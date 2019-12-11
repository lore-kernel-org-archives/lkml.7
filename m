Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4F120663
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076847;
	bh=CSoanEawr7j/BlobTii9kGEWTYL7h3Tmm7EJXD3PIU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PSsdVMbeJ6ne66qYB6/a959ZeqrBSqHvCQ94zsO9bVBkIqoRQJVRLU4OHLuHs02le
	 HCQNfO1d7BLFKQMuRgR3sm4TJnbPbZdtMQCIJWl7Z4uPqI+vZHZVrCMEOt0ySFFoHJ
	 z298blS1pKs+fykPDn8i/BqhpcOXzT2rDrmhFkgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfLKPHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbfLKPHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:07:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71075222C4;
        Wed, 11 Dec 2019 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076842;
        bh=CSoanEawr7j/BlobTii9kGEWTYL7h3Tmm7EJXD3PIU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgtTzlOBrraOV/E6JCPyqWHNiAZBy58zsiGyNoQ0RyYrQNBchP9TyR8XF48dNRbOk
         0eiThHhyGy/kodMumrheDejSWONV6AhCERC5+S4WNK+uI3oazEX67xiAQt5CV6AS/K
         NevSKMC2wVFKdjUeVWXURexRfKiIgn+i0d/p0ykM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5.4 12/92] tty: serial: fsl_lpuart: use the sg count from dma_map_sg
Date:   Wed, 11 Dec 2019 16:05:03 +0100
Message-Id: <20191211150224.428462819@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 487ee861de176090b055eba5b252b56a3b9973d6 upstream.

The dmaengine_prep_slave_sg needs to use sg count returned
by dma_map_sg, not use sport->dma_tx_nents, because the return
value of dma_map_sg is not always same with "nents".

When enabling iommu for lpuart + edma, iommu framework may concatenate
two sgs into one.

Fixes: 6250cc30c4c4e ("tty: serial: fsl_lpuart: Use scatter/gather DMA for Tx")
Cc: <stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1572932977-17866-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/fsl_lpuart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -437,8 +437,8 @@ static void lpuart_dma_tx(struct lpuart_
 	}
 
 	sport->dma_tx_desc = dmaengine_prep_slave_sg(sport->dma_tx_chan, sgl,
-					sport->dma_tx_nents,
-					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+					ret, DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT);
 	if (!sport->dma_tx_desc) {
 		dma_unmap_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
 		dev_err(dev, "Cannot prepare TX slave DMA!\n");


