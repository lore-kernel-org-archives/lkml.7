Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB65021939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256470;
	bh=I5DfUpWc4FkhWApzv8awRJ97Wee7r7iwYLBrP50ov9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RiI8wwCNIKI3WtRF+q0vD1SjSQ+Z+QzxfZaPFwHTZD1qxng8TdFbCXtbmQ5KxOC3/
	 KX3n4dq+vpFqJ2E7qF6XmCOUR+4AOe5fP9KyZsCYnj/HI8QfnY9dVXfFRS3GqbNY/v
	 YWgbmG1/XdiT9aWBv/RNPoeBxMGJJdku5MMPz1HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbfCVMHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389063AbfCVMHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD7E206C0;
        Fri, 22 Mar 2019 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256462;
        bh=I5DfUpWc4FkhWApzv8awRJ97Wee7r7iwYLBrP50ov9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDwmuMhyHEAgiZMBWy6JZq0yrnlc4SVb3Bkm2C73Zad9qIXr/Ar7fDIo+cEZ0hPOm
         KDXlea2FeRU89X7Pkd8LyGBjgFpVSgbhhjgbinDvoVA15PzrKqy4bK6BKDGmqMg7j+
         3hJlbzjRczct75AamxYxTrexxPf5wrp6XoZxCJEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Zabrocki <adamza@microsoft.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Akash Goel <akash.goel@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 211/280] drm/i915: Relax mmap VMA check
Date:   Fri, 22 Mar 2019 12:16:04 +0100
Message-Id: <20190322111332.825969209@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ca22f32a6296cbfa29de56328c8505560a18cfa8 ]

Legacy behaviour was to allow non-page-aligned mmap requests, as does the
linux mmap(2) implementation by virtue of automatically rounding up for
the caller.

To avoid breaking legacy userspace relax the newly introduced fix.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: 5c4604e757ba ("drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Adam Zabrocki <adamza@microsoft.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.0+
Cc: Akash Goel <akash.goel@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20190305110409.28633-1-tvrtko.ursulin@linux.intel.com
(cherry picked from commit a90e1948efb648f567444f87f3c19b2a0787affd)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 280c851714e6..03cda197fb6b 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1828,7 +1828,8 @@ __vma_matches(struct vm_area_struct *vma, struct file *filp,
 	if (vma->vm_file != filp)
 		return false;
 
-	return vma->vm_start == addr && (vma->vm_end - vma->vm_start) == size;
+	return vma->vm_start == addr &&
+	       (vma->vm_end - vma->vm_start) == PAGE_ALIGN(size);
 }
 
 /**
-- 
2.19.1



