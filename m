Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F23C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D83218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eHvhaOyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfC2QwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:52:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57056 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2QwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:52:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TGq2hC019862;
        Fri, 29 Mar 2019 11:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553878322;
        bh=xvrU2Sslz3Ll7h4ui3tdSmGX5iYETj272CZM1M4goug=;
        h=From:To:CC:Subject:Date;
        b=eHvhaOyf3ZvgCGYwGUnLysGi/U+KJnl2AzBaYCFeTCC5oKV+Ybs2DZXeBv5cP5qRj
         uaWS0JT5sJt5Hy8cA5XiumZ4/sBkgNP0SpWipnsmfJcCu18+VC/Wn0gvbyrlze+92Q
         Qo3ADHHQkodeK17xc82MM24LzZOxlDY955rOE8+8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TGq2KS038035
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 11:52:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 11:52:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 11:52:02 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TGq2ab044058;
        Fri, 29 Mar 2019 11:52:02 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2TGq0U27156;
        Fri, 29 Mar 2019 11:52:01 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] dma-buf: Make mmap callback actually optional
Date:   Fri, 29 Mar 2019 11:52:01 -0500
Message-ID: <20190329165201.16233-1-afd@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs state the callback is optional but it is not, make it optional.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/dma-buf/dma-buf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 7c858020d14b..4d4ae9fe9ac8 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -90,6 +90,10 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 
 	dmabuf = file->private_data;
 
+	/* check if buffer supports mmap */
+	if (!dmabuf->ops->mmap)
+		return -EINVAL;
+
 	/* check for overflowing the buffer's size */
 	if (vma->vm_pgoff + vma_pages(vma) >
 	    dmabuf->size >> PAGE_SHIFT)
@@ -404,8 +408,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 			  || !exp_info->ops
 			  || !exp_info->ops->map_dma_buf
 			  || !exp_info->ops->unmap_dma_buf
-			  || !exp_info->ops->release
-			  || !exp_info->ops->mmap)) {
+			  || !exp_info->ops->release)) {
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -906,6 +909,10 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	if (WARN_ON(!dmabuf || !vma))
 		return -EINVAL;
 
+	/* check if buffer supports mmap */
+	if (!dmabuf->ops->mmap)
+		return -EINVAL;
+
 	/* check for offset overflow */
 	if (pgoff + vma_pages(vma) < pgoff)
 		return -EOVERFLOW;
-- 
2.21.0

