Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A28C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEEA24143
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfE2UVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:21:41 -0400
Received: from www17.your-server.de ([213.133.104.17]:55956 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2UVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:21:40 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54s-0005y9-E9; Wed, 29 May 2019 22:21:38 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54r-0006OR-5S; Wed, 29 May 2019 22:21:38 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Wed, 29 May 2019 22:21:36 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:21:36 +0200
Subject: [PATCH] scsi: lpfc: Use *_pool_zalloc rather than *_pool_alloc
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
References: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 1
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25464/Wed May 29 09:59:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4114,14 +4114,13 @@ lpfc_new_io_buf(struct lpfc_hba *phba, i
 		 * pci bus space for an I/O. The DMA buffer includes the
 		 * number of SGE's necessary to support the sg_tablesize.
 		 */
-		lpfc_ncmd->data = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool,
-				GFP_KERNEL,
-				&lpfc_ncmd->dma_handle);
+		lpfc_ncmd->data = dma_pool_zalloc(phba->lpfc_sg_dma_buf_pool,
+						  GFP_KERNEL,
+						  &lpfc_ncmd->dma_handle);
 		if (!lpfc_ncmd->data) {
 			kfree(lpfc_ncmd);
 			break;
 		}
-		memset(lpfc_ncmd->data, 0, phba->cfg_sg_dma_buf_size);
 
 		/*
 		 * 4K Page alignment is CRITICAL to BlockGuard, double check
