Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9165C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912B1218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eBQVpTL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfCUUKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:10:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57506 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfCUUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:10:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LK9wxg115200;
        Thu, 21 Mar 2019 15:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553198998;
        bh=lZ9YUXczeYXra49/riDoG0QBNS5c2/EbEIAbt8EChQs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eBQVpTL2fXqbTM+NluGlN5q6blBC1bY3JGPLE0TKIYXaJCPClPrW2rLYBDGnPi7z5
         WSvMP1vYeb/7GT3vm7c6gpQkz9U8hypfc78dvyxSR2EfAa9ZikoChUcACXQuBlB/Yi
         MHij6fv2MZrCXAkPPlHsOPiWjTbMrGwf7fkJWhuw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LK9w9g034132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 15:09:58 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 15:09:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 15:09:58 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LK9wH2017575;
        Thu, 21 Mar 2019 15:09:58 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2LK9vU17906;
        Thu, 21 Mar 2019 15:09:57 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/2] dma-buf: Update [un]map documentation to match the other functions
Date:   Thu, 21 Mar 2019 15:09:57 -0500
Message-ID: <20190321200957.16938-2-afd@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321200957.16938-1-afd@ti.com>
References: <20190321200957.16938-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other function have inline documentation, a couple still have
theirs at the top of the structure, update the docs and move
them inline.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 include/linux/dma-buf.h | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index e4a8dab2bc54..a0bd071466fc 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -39,8 +39,6 @@ struct dma_buf_attachment;
 
 /**
  * struct dma_buf_ops - operations possible on struct dma_buf
- * @map: [optional] maps a page from the buffer into kernel address space.
- * @unmap: [optional] unmaps a page from the buffer.
  * @vmap: [optional] creates a virtual mapping for the buffer into kernel
  *	  address space. Same restrictions as for vmap and friends apply.
  * @vunmap: [optional] unmaps a vmap from the buffer
@@ -200,8 +198,6 @@ struct dma_buf_ops {
 	 * to be restarted.
 	 */
 	int (*end_cpu_access)(struct dma_buf *, enum dma_data_direction);
-	void *(*map)(struct dma_buf *, unsigned long);
-	void (*unmap)(struct dma_buf *, unsigned long, void *);
 
 	/**
 	 * @mmap:
@@ -240,6 +236,31 @@ struct dma_buf_ops {
 	 */
 	int (*mmap)(struct dma_buf *, struct vm_area_struct *vma);
 
+	/**
+	 * @map:
+	 *
+	 * Maps a page from the buffer into kernel address space. The page is
+	 * specified by offset into the buffer in PAGE_SIZE units.
+	 *
+	 * This callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * Virtual address pointer where requested page can be accessed. NULL
+	 * on error or when this function is unimplemented by the exporter.
+	 */
+	void *(*map)(struct dma_buf *, unsigned long);
+
+	/**
+	 * @unmap:
+	 *
+	 * Unmaps a page from the buffer. Page offset and address pointer should
+	 * be the same as the one passed to and returned by matching call to map.
+	 *
+	 * This callback is optional.
+	 */
+	void (*unmap)(struct dma_buf *, unsigned long, void *);
+
 	void *(*vmap)(struct dma_buf *);
 	void (*vunmap)(struct dma_buf *, void *vaddr);
 };
-- 
2.21.0

