Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA24BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9881E208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380582;
	bh=kQb2lO5SeC/552C3y6/UkLfJlBEviMXtrHmh+PN1ors=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMuSQkuOKsx9ue4XtYbzQDC7i859T+Olz/dk3qUUl8C6moi1ui6404fVYJ9uTzNxs
	 yRSxND6okm004wLZO9FdcSc2DqFpXFXRour8bwyYGGSzKTaMHMi9c2NtpAvcSMBBmA
	 KKieTkCoXyka4d8KwhqT8C+HXRxrH6ZJkuvOeg20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfIMNQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388932AbfIMNQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:16:19 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165F8206A5;
        Fri, 13 Sep 2019 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380578;
        bh=kQb2lO5SeC/552C3y6/UkLfJlBEviMXtrHmh+PN1ors=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Q9p+9piCSU+U0ian/02WO7q8Y7lNOxlKfKrDSPZa1j1n99SJXwzpFy65/cDsL1GD
         O3D/1fLy3Z8odN8KtjCqNm0iS7IPkwiuPNZLznNGxGf5hrOmPrILP5SMKRgN6B25bh
         oGw7PTPMX16gjTA+4RsoN7CZGv1fL2gWNxB2hTX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antonio Argenziano <antonio.argenziano@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/190] drm/i915: Sanity check mmap length against object size
Date:   Fri, 13 Sep 2019 14:06:04 +0100
Message-Id: <20190913130608.433465428@linuxfoundation.org>
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

[ Upstream commit 000c4f90e3f0194eef218ff2c6a8fd8ca1de4313 ]

We assumed that vm_mmap() would reject an attempt to mmap past the end of
the filp (our object), but we were wrong.

Applications that tried to use the mmap beyond the end of the object
would be greeted by a SIGBUS. After this patch, those applications will
be told about the error on creating the mmap, rather than at a random
moment on later access.

Reported-by: Antonio Argenziano <antonio.argenziano@intel.com>
Testcase: igt/gem_mmap/bad-size
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Antonio Argenziano <antonio.argenziano@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190314075829.16838-1-chris@chris-wilson.co.uk
(cherry picked from commit 794a11cb67201ad1bb61af510bb8460280feb3f3)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 9634d3adb8d01..9372877100420 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1874,8 +1874,13 @@ i915_gem_mmap_ioctl(struct drm_device *dev, void *data,
 	 * pages from.
 	 */
 	if (!obj->base.filp) {
-		i915_gem_object_put(obj);
-		return -ENXIO;
+		addr = -ENXIO;
+		goto err;
+	}
+
+	if (range_overflows(args->offset, args->size, (u64)obj->base.size)) {
+		addr = -EINVAL;
+		goto err;
 	}
 
 	addr = vm_mmap(obj->base.filp, 0, args->size,
@@ -1889,8 +1894,8 @@ i915_gem_mmap_ioctl(struct drm_device *dev, void *data,
 		struct vm_area_struct *vma;
 
 		if (down_write_killable(&mm->mmap_sem)) {
-			i915_gem_object_put(obj);
-			return -EINTR;
+			addr = -EINTR;
+			goto err;
 		}
 		vma = find_vma(mm, addr);
 		if (vma && __vma_matches(vma, obj->base.filp, addr, args->size))
@@ -1908,12 +1913,10 @@ i915_gem_mmap_ioctl(struct drm_device *dev, void *data,
 	i915_gem_object_put(obj);
 
 	args->addr_ptr = (uint64_t) addr;
-
 	return 0;
 
 err:
 	i915_gem_object_put(obj);
-
 	return addr;
 }
 
-- 
2.20.1



