Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E25CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F46208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbfJ1UIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:08:35 -0400
Received: from foss.arm.com ([217.140.110.172]:44636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfJ1UIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:08:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8293531F;
        Mon, 28 Oct 2019 13:08:34 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4C9F3F71F;
        Mon, 28 Oct 2019 13:08:33 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com
Cc:     steven.price@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panfrost: Don't dereference bogus MMU pointers
Date:   Mon, 28 Oct 2019 20:08:25 +0000
Message-Id: <9a0b09e6b5851f0d4428b72dd6b8b4c0d0ef4206.1572293305.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that killing an application while faults are occurring
(particularly with a GPU in FPGA at a whopping 40MHz) can lead to
handling a lingering page fault after all the address space contexts
have already been freed. In this situation, the LRU list is empty so
addr_to_drm_mm_node() ends up dereferencing the list head as if it were
a struct panfrost_mmu entry; this leaves "mmu->as" actually pointing at
the pfdev->alloc_mask bitmap, which is also empty, and given that the
fault has a high likelihood of being in AS0, hilarity ensues.

Sadly, the cleanest solution seems to involve another goto. Oh well, at
least it's robust...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index e61984e26e0a..508765f80cfe 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -413,11 +413,11 @@ addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
 	spin_lock(&pfdev->as_lock);
 	list_for_each_entry(mmu, &pfdev->as_lru_list, list) {
 		if (as == mmu->as)
-			break;
+			goto found_mmu;
 	}
-	if (as != mmu->as)
-		goto out;
+	goto out;
 
+found_mmu:
 	priv = container_of(mmu, struct panfrost_file_priv, mmu);
 
 	spin_lock(&priv->mm_lock);
-- 
2.21.0.dirty

