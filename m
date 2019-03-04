Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF35C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF0520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688650;
	bh=VdsFLmcJdkaqDAs6fki7j0qN0zxzxekm/gkxJWg4IJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sm1NuazONgZG12k3P1etWdycik0cL65PvY4fb20LEZXV5WcGIS6Jh5rMzz9KK3UcS
	 U7VIHpPfTpLBvZakvLBjNUpvieOwkFrzh17Ht6zkvZGkUmNE8P4xqWHlM9631ITPbL
	 x1H4M3uB5qX0hFSRVoh5DIZp3wl9hIiGHGtAtNPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfCDIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfCDIgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2A721019;
        Mon,  4 Mar 2019 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688571;
        bh=VdsFLmcJdkaqDAs6fki7j0qN0zxzxekm/gkxJWg4IJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNXtx2PQFDKb0sSrIc3Tv2/vvwA5/a1XSmZX/Dk1A2CZVaP+fe+xfqf3W/WlhbqQk
         dHb7X679Q5Op2dedVxYHGG3GbE/4omCJe+WhrjXIVssqin/OUSDCFV1hEgiPFDuLfN
         IW9bsAZTCMEoLpU1Q11afix58V4QUU/qqKTE/u90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 85/88] scsi: aic94xx: fix calls to dma_set_mask_and_coherent()
Date:   Mon,  4 Mar 2019 09:23:08 +0100
Message-Id: <20190304081634.063440631@linuxfoundation.org>
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

commit c326de562f1fc149da4855a1b9d0433300c2a85d upstream.

The change to use dma_set_mask_and_coherent() incorrectly made a second
call with the 32 bit DMA mask value when the call with the 64 bit DMA mask
value succeeded.

[mkp: fixed subject]

Fixes: 3a21986f1a59 ("scsi: aic94xx: fully convert to the generic DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aic94xx/aic94xx_init.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -770,9 +770,11 @@ static int asd_pci_probe(struct pci_dev
 	if (err)
 		goto Err_remove;
 
-	err = -ENODEV;
-	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) ||
-	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32))) {
+	err = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		err = -ENODEV;
 		asd_printk("no suitable DMA mask for %s\n", pci_name(dev));
 		goto Err_remove;
 	}


