Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C5720836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688570;
	bh=mtOEnNwg7elOOz3a76j+tPDAtw8ExwE0Ioar0gNyk3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKpy2vZuZ0l+sQqPU9L/31nQoqeDL02PbZKUrr/tcVxdm2jJz7DGdD5BMOQqniiTE
	 opgswAeoL7ejhGCbgN0a11yIiki85LOQan9kQJpl/kCgqj6LfuVaA/6uoxNWjig32R
	 6yBJxKUtHvVTahBEyU9AOknERxeuLK/GohYWoTbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfCDIgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbfCDIgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B90208E4;
        Mon,  4 Mar 2019 08:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688565;
        bh=mtOEnNwg7elOOz3a76j+tPDAtw8ExwE0Ioar0gNyk3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT/I802RqSF9alCrxSnfXggSn5aXOGEJ4U2Y7e0FOPZnDyvbICUoZnJAsMv/8jgl7
         dCTawV8yq+bwcgXAT7ZO6UldaJDbxjN8vYMCcP3J8/F5mfyNpMlMig0MzM+b2IMrOM
         /sKgUDQYyLrz6XabIR5svEl66zqsB7UISRkvZbTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 83/88] scsi: csiostor: fix calls to dma_set_mask_and_coherent()
Date:   Mon,  4 Mar 2019 09:23:06 +0100
Message-Id: <20190304081633.979349948@linuxfoundation.org>
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

commit 732f3238dcf27acb92959a99b7923dc49395980e upstream.

The change to use dma_set_mask_and_coherent() incorrectly made a second
call with the 32 bit DMA mask value when the call with the 64 bit DMA mask
value succeeded.

Fixes: c22b332d811b ("scsi: csiostor: switch to generic DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/csiostor/csio_init.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -210,8 +210,11 @@ csio_pci_init(struct pci_dev *pdev, int
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
+	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rv)
+		rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (rv) {
+		rv = -ENODEV;
 		dev_err(&pdev->dev, "No suitable DMA available.\n");
 		goto err_release_regions;
 	}


