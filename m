Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49257C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC94206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380577;
	bh=Jca2Y4YgeNJeQz0dr97Q6CH5BvgAV0DjfudxgcwUv78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fmB0oUXqfaAei4r/fAVWTGAqIW+gKrHc7MzLyj92AvWBnAbCNKaVGue3eA9rOyTMI
	 R8GhT4WUA/mddkmrXMaZNNnnjjPJmEknSQx5nN45O/RwLDtcQJuPPmBjMDU5NUzl2j
	 AeJKVzbGyp+7gFzuQKXYNtBY0eVlTLANVpBCGS2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389824AbfIMNQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389787AbfIMNQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:16:13 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6A0206A5;
        Fri, 13 Sep 2019 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380572;
        bh=Jca2Y4YgeNJeQz0dr97Q6CH5BvgAV0DjfudxgcwUv78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYc87Fpb1I88410q9ibLyf4oOqr5JPk/05MSnikAJ6cMYGLmA7jTgbXT7N0yf9jBi
         wbc6tgSc3pDyITw0QOh9/d2BOXG3LDPbFapUDd8BK4R4DfhqU+0mRHF5vwVpY246/8
         05jxzFUe1yXcNDJTvA+CPG4Jywt+6bXbAX1c5ofE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Zabrocki <adamza@microsoft.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 4.19 108/190] drm/i915: Handle vm_mmap error during I915_GEM_MMAP ioctl with WC set
Date:   Fri, 13 Sep 2019 14:06:03 +0100
Message-Id: <20190913130608.340127771@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ebfb6977801da521d8d5d752d373a187e2a2b9b3 ]

Add err goto label and use it when VMA can't be established or changes
underneath.

v2:
- Dropping Fixes: as it's indeed impossible to race an object to the
  error address. (Chris)
v3:
- Use IS_ERR_VALUE (Chris)

Reported-by: Adam Zabrocki <adamza@microsoft.com>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Adam Zabrocki <adamza@microsoft.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com> #v2
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20190207085454.10598-2-joonas.lahtinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index e81abd468a15d..9634d3adb8d01 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1881,6 +1881,9 @@ i915_gem_mmap_ioctl(struct drm_device *dev, void *data,
 	addr = vm_mmap(obj->base.filp, 0, args->size,
 		       PROT_READ | PROT_WRITE, MAP_SHARED,
 		       args->offset);
+	if (IS_ERR_VALUE(addr))
+		goto err;
+
 	if (args->flags & I915_MMAP_WC) {
 		struct mm_struct *mm = current->mm;
 		struct vm_area_struct *vma;
@@ -1896,17 +1899,22 @@ i915_gem_mmap_ioctl(struct drm_device *dev, void *data,
 		else
 			addr = -ENOMEM;
 		up_write(&mm->mmap_sem);
+		if (IS_ERR_VALUE(addr))
+			goto err;
 
 		/* This may race, but that's ok, it only gets set */
 		WRITE_ONCE(obj->frontbuffer_ggtt_origin, ORIGIN_CPU);
 	}
 	i915_gem_object_put(obj);
-	if (IS_ERR((void *)addr))
-		return addr;
 
 	args->addr_ptr = (uint64_t) addr;
 
 	return 0;
+
+err:
+	i915_gem_object_put(obj);
+
+	return addr;
 }
 
 static unsigned int tile_row_pages(struct drm_i915_gem_object *obj)
-- 
2.20.1



