Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41C5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8249C20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392726AbfIFMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:42:55 -0400
Received: from foss.arm.com ([217.140.110.172]:55732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392067AbfIFMmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:42:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 629511570;
        Fri,  6 Sep 2019 05:42:54 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77D963F718;
        Fri,  6 Sep 2019 05:42:53 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
To:     Rob Herring <robh@kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20190905121141.42820-1-steven.price@arm.com>
 <CAL_JsqKyKUBOK7+fSpr+ShjUz72oXC91ySOKCST9WyWjd0nqww@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d0fb9ba9-d8af-1523-192c-23376e467f12@arm.com>
Date:   Fri, 6 Sep 2019 13:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKyKUBOK7+fSpr+ShjUz72oXC91ySOKCST9WyWjd0nqww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 12:10, Rob Herring wrote:
> On Thu, Sep 5, 2019 at 1:11 PM Steven Price <steven.price@arm.com> wrote:
>>
>> When handling a GPU page fault addr_to_drm_mm_node() is used to
>> translate the GPU address to a buffer object. However it is possible for
>> the buffer object to be freed after the function has returned resulting
>> in a use-after-free of the BO.
>>
>> Change addr_to_drm_mm_node to return the panfrost_gem_object with an
>> extra reference on it, preventing the BO from being freed until after
>> the page fault has been handled.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>
>> I've managed to trigger this, generating the following stack trace.
> 
> Humm, the assumption was that a fault could only happen during a job
> and so a reference would already be held. Otherwise, couldn't the GPU
> also be accessing the BO after it is freed?

Ah, I guess I missed that in the commit message. This is assuming that
user space doesn't include the BO in the job even though the GPU then
does try to access it. AIUI mesa wouldn't do this, but this is still
easily possible if user space wants to crash the kernel.

> Also, looking at this again, I think we need to hold the mm_lock
> around the drm_mm_for_each_node().

Ah, good point. Squashing in the following should do the trick:

----8<----
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c
b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index ccc536d2e489..41f297aa259c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -396,26 +396,33 @@ static struct panfrost_gem_object *
 addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
 {
 	struct panfrost_gem_object *bo = NULL;
+	struct panfrost_file_priv *priv;
 	struct drm_mm_node *node;
 	u64 offset = addr >> PAGE_SHIFT;
 	struct panfrost_mmu *mmu;

 	spin_lock(&pfdev->as_lock);
 	list_for_each_entry(mmu, &pfdev->as_lru_list, list) {
-		struct panfrost_file_priv *priv;
-		if (as != mmu->as)
-			continue;
+		if (as == mmu->as)
+			break;
+	}
+	if (as != mmu->as)
+		goto out;

-		priv = container_of(mmu, struct panfrost_file_priv, mmu);
-		drm_mm_for_each_node(node, &priv->mm) {
-			if (offset >= node->start &&
-			    offset < (node->start + node->size)) {
-				bo = drm_mm_node_to_panfrost_bo(node);
-				drm_gem_object_get(&bo->base.base);
-				goto out;
-			}
+	priv = container_of(mmu, struct panfrost_file_priv, mmu);
+
+	spin_lock(&priv->mm_lock);
+
+	drm_mm_for_each_node(node, &priv->mm) {
+		if (offset >= node->start &&
+				offset < (node->start + node->size)) {
+			bo = drm_mm_node_to_panfrost_bo(node);
+			drm_gem_object_get(&bo->base.base);
+			break;
 		}
 	}
+
+	spin_unlock(&priv->mm_lock);
 out:
 	spin_unlock(&pfdev->as_lock);
 	return bo;
