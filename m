Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B8120811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O1D2CevQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfC2Re3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:34:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33714 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2Re3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:34:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2THYRZ6032730;
        Fri, 29 Mar 2019 12:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553880867;
        bh=QxQfcfn0O/wNidZNs+QiyQ7UbiBLTB0CeLj+vHNmjtQ=;
        h=From:To:CC:Subject:Date;
        b=O1D2CevQd2RlwEgJWNY31c3nYR7z7ZDE/RnsHVOw8Nlq4t2oeffFOvW6hfR+rbnx8
         7N1I3vkgL0eAdxZ7gA6QgRSjlI1h+cjv9ECqHq06NoHmag+gS8SgYYODZ+aOin1d4r
         Td9kgYtJgnOZnq+Zx+k3f4a+1iexcEfrs+WaJm6Y=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2THYRW6093662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 12:34:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 12:34:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 12:34:27 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2THYRr0097091;
        Fri, 29 Mar 2019 12:34:27 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2THYQU16108;
        Fri, 29 Mar 2019 12:34:26 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] [media] videobuf-dma-contig: Use size of buffer in mmap not vma size
Date:   Fri, 29 Mar 2019 12:34:27 -0500
Message-ID: <20190329173427.18238-1-afd@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the vma can be larger than the size of the backing buffer.
Use the buffer size over vma size to prevent exposing extra memory
to userspace.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/media/v4l2-core/videobuf-dma-contig.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/media/v4l2-core/videobuf-dma-contig.c
index e1bf50df4c70..65e2655d22b7 100644
--- a/drivers/media/v4l2-core/videobuf-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
@@ -280,7 +280,6 @@ static int __videobuf_mmap_mapper(struct videobuf_queue *q,
 	struct videobuf_dma_contig_memory *mem;
 	struct videobuf_mapping *map;
 	int retval;
-	unsigned long size;
 
 	dev_dbg(q->dev, "%s\n", __func__);
 
@@ -303,7 +302,6 @@ static int __videobuf_mmap_mapper(struct videobuf_queue *q,
 		goto error;
 
 	/* Try to remap memory */
-	size = vma->vm_end - vma->vm_start;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	/* the "vm_pgoff" is just used in v4l2 to find the
@@ -314,7 +312,7 @@ static int __videobuf_mmap_mapper(struct videobuf_queue *q,
 	 */
 	vma->vm_pgoff = 0;
 
-	retval = vm_iomap_memory(vma, mem->dma_handle, size);
+	retval = vm_iomap_memory(vma, mem->dma_handle, mem->size);
 	if (retval) {
 		dev_err(q->dev, "mmap: remap failed with error %d. ",
 			retval);
-- 
2.21.0

