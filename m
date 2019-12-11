Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C51C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBA0208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077419;
	bh=GW2YGA+QzrGLjY9ALDQ0hmhF/i4mTywfXyP/HhjOtOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MjSlHnpNQ+joonBgZmn/I0aGeZHLQRLJHmGsccHlX3oUiv2FuKs3g5YZ3k3qHrsqc
	 QCWL6BYdmUeDu6cfuYXhjwXsOBjMnhDFl6xg+QY/U9QP7O2Xdt629vzoZMkwzbV5dh
	 VMiLTMaN9Tl/J45S7n7BFl5skFWUjYvDxb6S7rIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfLKPQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfLKPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:16:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE46208C3;
        Wed, 11 Dec 2019 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077415;
        bh=GW2YGA+QzrGLjY9ALDQ0hmhF/i4mTywfXyP/HhjOtOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyIBfhiMP1c7WNaRHYHAEEhZvAqtw7dawzsSRxZmMSpjjL/RL3SbwGYoMHwXkJq/F
         zVXI+cSuzSq4EfNUCzwikwsRUo5+cAimg31yzDSS9IbSlbkzZt+pRAf9AiF4+Ufuix
         6q3EI9IjdNOp3hTyxl2lVrffBbdEFTa4v9+hNo4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4.19 006/243] tty: serial: fsl_lpuart: use the sg count from dma_map_sg
Date:   Wed, 11 Dec 2019 16:02:48 +0100
Message-Id: <20191211150339.568579032@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
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
@@ -376,8 +376,8 @@ static void lpuart_dma_tx(struct lpuart_
 	}
 
 	sport->dma_tx_desc = dmaengine_prep_slave_sg(sport->dma_tx_chan, sgl,
-					sport->dma_tx_nents,
-					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
+					ret, DMA_MEM_TO_DEV,
+					DMA_PREP_INTERRUPT);
 	if (!sport->dma_tx_desc) {
 		dma_unmap_sg(dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
 		dev_err(dev, "Cannot prepare TX slave DMA!\n");


