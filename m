Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AB5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B48A214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922642;
	bh=X5I1QTIKUgF5I/6Ulsx2MzAbe66S+3NmlIP8QNu9sdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mTybHvM2BnQmXPwUDz0DDwywGKNuASmwZzAUbiN3hEeCoSg90eGSqUWdzGYZ3WpRd
	 z+sJIB10ITctsOIVRAe39vSqljakn/PlueOlFAJHSpK7e+saMB9rgjGyGzKUbqGwvn
	 duxtnDvjXebJ3tkXMWMTzR60W59PIHbED+QfTtJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfFGPuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731773AbfFGPuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:50:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749942146E;
        Fri,  7 Jun 2019 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922634;
        bh=X5I1QTIKUgF5I/6Ulsx2MzAbe66S+3NmlIP8QNu9sdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19Mh28VYh0hfaM96yvUnNCSm6VHcZmSxDmS4orfE6Jpr+ama8ygH5EXSBaSQnGTVM
         iKiZ2QMr0006ux7a0j+8Ce/1qtPe2QhAr9wiEhh/HLZloA2vaTr3+HdmtUpi7uRqJO
         TxV9lVzTTH24kqxgr2KF8knZwt7X0ug7ZbWDOkwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Li, Tingqian" <tingqian.li@intel.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 5.1 83/85] drm/cma-helper: Fix drm_gem_cma_free_object()
Date:   Fri,  7 Jun 2019 17:40:08 +0200
Message-Id: <20190607153858.032131229@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noralf Trønnes <noralf@tronnes.org>

commit 23e35c0eb81a23d40c079a7eb187fc321fa1deb7 upstream.

The logic for freeing an imported buffer with a virtual address is
broken. It will free the buffer instead of unmapping the dma buf.
Fix by reversing the if ladder and first check if the buffer is imported.

Fixes: b9068cde51ee ("drm/cma-helper: Add DRM_GEM_CMA_VMAP_DRIVER_OPS")
Cc: stable@vger.kernel.org
Reported-by: "Li, Tingqian" <tingqian.li@intel.com>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190426124753.53722-1-noralf@tronnes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_gem_cma_helper.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -186,13 +186,13 @@ void drm_gem_cma_free_object(struct drm_
 
 	cma_obj = to_drm_gem_cma_obj(gem_obj);
 
-	if (cma_obj->vaddr) {
-		dma_free_wc(gem_obj->dev->dev, cma_obj->base.size,
-			    cma_obj->vaddr, cma_obj->paddr);
-	} else if (gem_obj->import_attach) {
+	if (gem_obj->import_attach) {
 		if (cma_obj->vaddr)
 			dma_buf_vunmap(gem_obj->import_attach->dmabuf, cma_obj->vaddr);
 		drm_prime_gem_destroy(gem_obj, cma_obj->sgt);
+	} else if (cma_obj->vaddr) {
+		dma_free_wc(gem_obj->dev->dev, cma_obj->base.size,
+			    cma_obj->vaddr, cma_obj->paddr);
 	}
 
 	drm_gem_object_release(gem_obj);


