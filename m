Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162652196F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255098;
	bh=xYFi3/bBWwRjcEhh5G16jq25FQ2lpe98kxIJ5cIuKnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0o+EB5dm9CAMU6R2/DJQczWWrDLQA0lysDcDtioThq2N0kDVnURdwrmrxinAnoFUo
	 GY0LhO2TTFZP0/ZyM2GTehL8Fp/MHC1czBG76tQ/qh3loUQOAVrmDHuOB82rMaKtX6
	 8IaHCAnYA1W59eOhY+4F9vXVX3QH63PpKxfLmrMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfCVLo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbfCVLox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:44:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DE22082C;
        Fri, 22 Mar 2019 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255092;
        bh=xYFi3/bBWwRjcEhh5G16jq25FQ2lpe98kxIJ5cIuKnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL/sLmrtviywxxhzOD4c4iSAMOCTtC+b87YmSmTMvVfzJbVh6f03lgM90tsP0M2lS
         cVF05TCuQVWR1hiTsfgJOtea9I4G9PYFPvO9JnkAoKDJfDx87i/egFuxCXYybYSuVr
         N/d9fm8iy21xKGa8J30900U15gn2Cv6zDNNqR+tA=
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
Subject: [PATCH 4.9 085/118] drm/i915: Relax mmap VMA check
Date:   Fri, 22 Mar 2019 12:15:57 +0100
Message-Id: <20190322111222.612208265@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpu/drm/i915/i915_gem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1600,7 +1600,8 @@ __vma_matches(struct vm_area_struct *vma
 	if (vma->vm_file != filp)
 		return false;
 
-	return vma->vm_start == addr && (vma->vm_end - vma->vm_start) == size;
+	return vma->vm_start == addr &&
+	       (vma->vm_end - vma->vm_start) == PAGE_ALIGN(size);
 }
 
 /**


