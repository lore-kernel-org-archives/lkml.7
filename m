Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B0C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3320449
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625135;
	bh=ks4xiQnpwqFncGQQW/YdHI2ZiMXGEsEjj/h+pGcqWSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVFnZx9u/NTigsbbLTRq/sIiBn/mO7k2dhgth7kjcoXiknF93LXKTJQtpV/+GSjXl
	 esDDNwnvfl/5XsezUGtyoevuaot5Ay4SpM8xfQtAcyVtPUsLd1gS2NwTMiY42zYcEM
	 uJlIfeN/x14RyrN6e2xU/MhLHdArsvxmH8xccNO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfD3LwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbfD3Lvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C412054F;
        Tue, 30 Apr 2019 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625108;
        bh=ks4xiQnpwqFncGQQW/YdHI2ZiMXGEsEjj/h+pGcqWSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLTTnoiK35x6ltGXBTKRqKWEBUVXlAuR2STkIPLK9X5JJ6IyG87Obx14BGnQGpKIH
         waMJVMq4XsaqGpPIz1mmLMWCzJgOWT08gcPYFt36yUOQiDZC08HRX6LzDLx9V6w5o7
         eLnPxJvzA9UARE2OooqLWrfNuVabqEOEZ5Z9Tm2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Mikityanskiy <maximmi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 87/89] net/mlx5e: Fix use-after-free after xdp_return_frame
Date:   Tue, 30 Apr 2019 13:39:18 +0200
Message-Id: <20190430113613.882729293@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Mikityanskiy <maximmi@mellanox.com>

[ Upstream commit 12fc512f5741443a03adde2ead20724da8ad550a ]

xdp_return_frame releases the frame. It leads to releasing the page, so
it's not allowed to access xdpi.xdpf->len after that, because xdpi.xdpf
is at xdp->data_hard_start after convert_to_xdp_frame. This patch moves
the memory access to precede the return of the frame.

Fixes: 58b99ee3e3ebe ("net/mlx5e: Add support for XDP_REDIRECT in device-out side")
Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -324,9 +324,9 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq
 					mlx5e_xdpi_fifo_pop(xdpi_fifo);
 
 				if (is_redirect) {
-					xdp_return_frame(xdpi.xdpf);
 					dma_unmap_single(sq->pdev, xdpi.dma_addr,
 							 xdpi.xdpf->len, DMA_TO_DEVICE);
+					xdp_return_frame(xdpi.xdpf);
 				} else {
 					/* Recycle RX page */
 					mlx5e_page_release(rq, &xdpi.di, true);
@@ -365,9 +365,9 @@ void mlx5e_free_xdpsq_descs(struct mlx5e
 				mlx5e_xdpi_fifo_pop(xdpi_fifo);
 
 			if (is_redirect) {
-				xdp_return_frame(xdpi.xdpf);
 				dma_unmap_single(sq->pdev, xdpi.dma_addr,
 						 xdpi.xdpf->len, DMA_TO_DEVICE);
+				xdp_return_frame(xdpi.xdpf);
 			} else {
 				/* Recycle RX page */
 				mlx5e_page_release(rq, &xdpi.di, false);


