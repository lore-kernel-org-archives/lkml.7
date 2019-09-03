Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDA323697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528478;
	bh=f21eev754077QISDuWAvVBzwWnDaFeAJ0E93al3vANs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eCCH/l5Nf3kDmccyyHl1zd6dmjNL5NUTVyOucvFoNww0zky/MwmNhhB0ksSET6ejU
	 mjtZGUhQ+nQnH7iFQPxeTaeRHEOlJnMDF6fS+VNkk9ZEm0+2vgwDWvOBxEpaAGlgtm
	 SYhDkGNzRu5I+bNtMwftNYvJZCblg2cc73s91ERs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfICQ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730190AbfICQ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:27:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3807E215EA;
        Tue,  3 Sep 2019 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528075;
        bh=f21eev754077QISDuWAvVBzwWnDaFeAJ0E93al3vANs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zojX9ZH0xnYZ5SDBNLLQzHJNR2IsYgaEEQkKgrKXQvZsmyeXbArkcbmkJPBoEu43e
         dNL3fNnKOj64ooBJjp9WrbwUaLlQ3yUJMsWzwZtJbfzTN5v1yY7tgOK3KpU+wB1PyH
         XJfI85WlRWRV6Ou9Js2vBs2XSAd4MpWrbsDgfUU8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Antonio Argenziano <antonio.argenziano@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 088/167] drm/i915: Sanity check mmap length against object size
Date:   Tue,  3 Sep 2019 12:24:00 -0400
Message-Id: <20190903162519.7136-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

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

