Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8D4208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CcXDZhDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfHLL3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:17 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4806 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHLL3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d8c0000>; Mon, 12 Aug 2019 04:29:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:29:14 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:14 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:14 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d860001>; Mon, 12 Aug 2019 04:29:13 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 10/14] serial: tegra: add support to use 8 bytes trigger
Date:   Mon, 12 Aug 2019 16:58:19 +0530
Message-ID: <1565609303-27000-11-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609356; bh=R/RIL8j/aCxkKxLVcSAIXW0XzcCz1HZoTbaB+YwkLOc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CcXDZhDVh6RhPxEVrZvX98wPcNHfNn63SQe/E4bauBeTbq6WywKtWO3Qn4LoItVug
         tcPR1Ap+xx5nK1Qc87EbpIagi39ObIgA2B+Sr9/KpfMvbCi9p6GkX527dfgE5ebaix
         /nIHF/yS43b+e2bragWM9OWjFXzYBlttNtCGDVNB1jsC3hIoVxAKLUUPEXOuzHwyXO
         Iho202hLSOHppGscDBYrwMt2mKvpcew6mwY16BqpebJKV23dm+Rdg/J3JHEiwyVXhh
         Z6CgbegXwORTd58thAkBSzmrmiUWXW9fb4r2vp24EhIJ+CxTfi6QX2xLmWmK9437vV
         TZzviFp9ykJ9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

Add support to use 8 bytes trigger for Tegra186 SOC.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 329923c..03d1d20 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -88,6 +88,7 @@ struct tegra_uart_chip_data {
 	bool	support_clk_src_div;
 	bool	fifo_mode_enable_status;
 	int	uart_max_port;
+	int	dma_burst_bytes;
 };
 
 struct tegra_uart_port {
@@ -933,7 +934,12 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * programmed in the DMA registers.
 	 */
 	tup->fcr_shadow = UART_FCR_ENABLE_FIFO;
-	tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+
+	if (tup->cdata->dma_burst_bytes == 8)
+		tup->fcr_shadow |= UART_FCR_R_TRIG_10;
+	else
+		tup->fcr_shadow |= UART_FCR_R_TRIG_01;
+
 	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 
@@ -1046,7 +1052,7 @@ static int tegra_uart_dma_channel_allocate(struct tegra_uart_port *tup,
 		}
 		dma_sconfig.src_addr = tup->uport.mapbase;
 		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		dma_sconfig.src_maxburst = 4;
+		dma_sconfig.src_maxburst = tup->cdata->dma_burst_bytes;
 		tup->rx_dma_chan = dma_chan;
 		tup->rx_dma_buf_virt = dma_buf;
 		tup->rx_dma_buf_phys = dma_phys;
@@ -1325,6 +1331,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.support_clk_src_div		= false,
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
+	.dma_burst_bytes		= 4,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1333,6 +1340,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
+	.dma_burst_bytes		= 4,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1341,6 +1349,7 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= true,
 	.uart_max_port			= 5,
+	.dma_burst_bytes		= 8,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
-- 
2.7.4

