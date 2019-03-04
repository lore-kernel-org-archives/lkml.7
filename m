Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEE220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688658;
	bh=cRMUPaLIi0BDREOESeMJ4vw6h/Mx21sdn8ALz6z4lgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=id8U7EdDHGTBjakLKhYNJfYJX/AqxOHdZ3q845d2GT8z0lk22ZufKLLLFbuszjAT8
	 NGUyhAG9ADPeihfJZ6YGD5J/+zRDshk/h2c+Ld3124SUwwUMHU9oVUSmsGOvd2Tb+2
	 LeKgCJwFbrXTT8swxIi6NgX1yKvOvCIe+ipWTbOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCDIhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfCDIgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84A220836;
        Mon,  4 Mar 2019 08:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688562;
        bh=cRMUPaLIi0BDREOESeMJ4vw6h/Mx21sdn8ALz6z4lgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DyTIiA8d9gpRW5riRbJkefBMAiLGMq/f91K9XHSkLV+Or8i5B/nAMzP8v4dlsDKnh
         CHA74a43NkolBPU4vsiTCHMOpZmjW6qmbb5+HDNnBO5rMRytFAMb3yICv80dyNsP43
         yffBmKzMgqRV5w4c+jhhZrbDM5tGgCvvbnLhqMAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 82/88] scsi: 3w-sas: fix calls to dma_set_mask_and_coherent()
Date:   Mon,  4 Mar 2019 09:23:05 +0100
Message-Id: <20190304081633.938850713@linuxfoundation.org>
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

commit 1feb3b02294994ee3a067c9b6cda6c244fd0ee18 upstream.

The change to use dma_set_mask_and_coherent() incorrectly made a second
call with the 32 bit DMA mask value when the call with the 64 bit DMA mask
value succeeded.

Fixes: b1fa122930c4 ("scsi: 3w-sas: fully convert to the generic DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/3w-sas.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1573,8 +1573,10 @@ static int twl_probe(struct pci_dev *pde
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (retval)
+		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x18, "Failed to set dma mask");
 		retval = -ENODEV;
 		goto out_disable_device;
@@ -1805,8 +1807,10 @@ static int twl_resume(struct pci_dev *pd
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (retval)
+		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x25, "Failed to set dma mask during resume");
 		retval = -ENODEV;
 		goto out_disable_device;


