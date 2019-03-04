Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD32C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1032520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688631;
	bh=2iPyNSJib/bhpsiqSjs354eU6/m6+0VEVNOB13F3DcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8SEN/6dgQZv0b+ShrwV5plb+K1wQiyDZSltCLBzszb2vb6o1Q4z4CH3LZWPVIGD8
	 FOvqkuPBm51GOPm1+3AazoHMRLkwsIjfmdA0PrMmFtc6lrSBVwwAjzXPZ5+YJ/wEOv
	 j0Nv5Z4kKVDmLLpP0ixDRPcCWFXdhmOGoqCx9CjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfCDIgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfCDIgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40AB420823;
        Mon,  4 Mar 2019 08:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688568;
        bh=2iPyNSJib/bhpsiqSjs354eU6/m6+0VEVNOB13F3DcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=welHtIfRHtxTL4WtZj3Aqh3d4U+7dgWjQCwXQkByRk249UNHiTxPoRwWG4jH6IjF5
         HoCLI0Zz/qlVD/sRC1VQt++wlNtVsYSyq8ecMqGjXCoQJoAkXx7mPiHW5dumyljBvK
         Gi28rknwwA/cvzo2XxyYwhqQjL1mndN5sKF2ekMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 84/88] scsi: 3w-9xxx: fix calls to dma_set_mask_and_coherent()
Date:   Mon,  4 Mar 2019 09:23:07 +0100
Message-Id: <20190304081634.022789663@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>

commit 33d6667416c73eb0b37f0f10f56d825b15389dab upstream.

The change to use dma_set_mask_and_coherent() incorrectly made a second
call with the 32 bit DMA mask value when the call with the 64 bit DMA mask
value succeeded.

Fixes: b000bced5739 ("scsi: 3w-9xxx: fully convert to the generic DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/3w-9xxx.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2010,7 +2010,7 @@ static int twa_probe(struct pci_dev *pde
 	struct Scsi_Host *host = NULL;
 	TW_Device_Extension *tw_dev;
 	unsigned long mem_addr, mem_len;
-	int retval = -ENODEV;
+	int retval;
 
 	retval = pci_enable_device(pdev);
 	if (retval) {
@@ -2021,8 +2021,10 @@ static int twa_probe(struct pci_dev *pde
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (retval)
+		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x23, "Failed to set dma mask");
 		retval = -ENODEV;
 		goto out_disable_device;
@@ -2241,8 +2243,10 @@ static int twa_resume(struct pci_dev *pd
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (retval)
+		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x40, "Failed to set dma mask during resume");
 		retval = -ENODEV;
 		goto out_disable_device;


