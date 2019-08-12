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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB33C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EEF214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bNshV6La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfHLL33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:29 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18491 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHLL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514da00002>; Mon, 12 Aug 2019 04:29:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:29:25 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:25 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d910002>; Mon, 12 Aug 2019 04:29:24 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH 13/14] serial: tegra: report clk rate errors
Date:   Mon, 12 Aug 2019 16:58:22 +0530
Message-ID: <1565609303-27000-14-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609376; bh=Of29im17IbC1N0xgf3ZFFqV6vfzuxCNL79lv/2Ae2B8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bNshV6LaRVcmqsDPl3SXDVLXmVDpeVKngZPtmdBSwVfdSB4GJu1vKZD4Ppcvp9jL6
         kONH9SH4jgCEmw4MuSdSMUfD7CCzGnxL1nX4s7za0X6kd7icMMj5PA3GfQwgEvMN4t
         TVO7HKM8Xj3HnkisHZjfmI5stYW0NiZ6PISrKma2zDyNo6n2uhxXLLgymQJ9+YpwYA
         c0edU1xSj8sidnSHwP8ydTqSBgQoaqGLn9YO3A4armjT1yA7VXWgd2JyBWLfKX5LUn
         Lj/cbNhqT2i+0pHQJonMmSC34/WEgb+LLpfYePhBOYliIT2r42Y+Loxo2uGLMRiGyK
         rEQ6r1203Oohg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard UART controllers support +/-4% baud rate error tolerance.
Tegra186 only supports 0% to +4% error tolerance whereas other Tegra
chips support standard +/-4% rate. Add chip data for knowing error
tolerance level for each soc. Creating new compatible for Tegra194 chip
as it supports baud rate error tolerance of -2 to +2 %, different from
older chips.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 58 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 3c9e5c5..3e02f27 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -89,6 +89,8 @@ struct tegra_uart_chip_data {
 	bool	fifo_mode_enable_status;
 	int	uart_max_port;
 	int	dma_burst_bytes;
+	int	error_tolerance_low_range;
+	int	error_tolerance_high_range;
 };
 
 struct tegra_baud_tolerance {
@@ -135,6 +137,8 @@ struct tegra_uart_port {
 	unsigned int				rx_bytes_requested;
 	struct tegra_baud_tolerance		*baud_tolerance;
 	int					n_adjustable_baud_rates;
+	int					required_rate;
+	int					configured_rate;
 };
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
@@ -352,6 +356,22 @@ static long tegra_get_tolerance_rate(struct tegra_uart_port *tup,
 	return rate;
 }
 
+static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
+{
+	long diff;
+
+	diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
+		/ tup->required_rate;
+	if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
+	    diff > (tup->cdata->error_tolerance_high_range * 100)) {
+		dev_err(tup->uport.dev,
+			"configured baud rate is out of range by %d", diff);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 {
 	unsigned long rate;
@@ -365,6 +385,8 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	if (tup->cdata->support_clk_src_div) {
 		rate = baud * 16;
+		tup->required_rate = rate;
+
 		if (tup->n_adjustable_baud_rates)
 			rate = tegra_get_tolerance_rate(tup, baud, rate);
 
@@ -374,7 +396,11 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 				"clk_set_rate() failed for rate %lu\n", rate);
 			return ret;
 		}
+		tup->configured_rate = clk_get_rate(tup->uart_clk);
 		divisor = 1;
+		ret = tegra_check_rate_in_range(tup);
+		if (ret < 0)
+			return ret;
 	} else {
 		rate = clk_get_rate(tup->uart_clk);
 		divisor = DIV_ROUND_CLOSEST(rate, baud * 16);
@@ -992,7 +1018,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * enqueued
 	 */
 	tup->lcr_shadow = TEGRA_UART_DEFAULT_LSR;
-	tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
+	ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
+	if (ret < 0) {
+		dev_err(tup->uport.dev, "Failed to set baud rate\n");
+		return ret;
+	}
 	tup->fcr_shadow |= UART_FCR_DMA_SELECT;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 
@@ -1191,6 +1221,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	struct clk *parent_clk = clk_get_parent(tup->uart_clk);
 	unsigned long parent_clk_rate = clk_get_rate(parent_clk);
 	int max_divider = (tup->cdata->support_clk_src_div) ? 0x7FFF : 0xFFFF;
+	int ret;
 
 	max_divider *= 16;
 	spin_lock_irqsave(&u->lock, flags);
@@ -1263,7 +1294,11 @@ static void tegra_uart_set_termios(struct uart_port *u,
 			parent_clk_rate/max_divider,
 			parent_clk_rate/16);
 	spin_unlock_irqrestore(&u->lock, flags);
-	tegra_set_baudrate(tup, baud);
+	ret = tegra_set_baudrate(tup, baud);
+	if (ret < 0) {
+		dev_err(tup->uport.dev, "Failed to set baud rate\n");
+		return;
+	}
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
 	spin_lock_irqsave(&u->lock, flags);
@@ -1400,6 +1435,8 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.dma_burst_bytes		= 4,
+	.error_tolerance_low_range	= 0,
+	.error_tolerance_high_range	= 4,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1409,6 +1446,8 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.dma_burst_bytes		= 4,
+	.error_tolerance_low_range	= 0,
+	.error_tolerance_high_range	= 4,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1418,6 +1457,18 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.fifo_mode_enable_status	= true,
 	.uart_max_port			= 5,
 	.dma_burst_bytes		= 8,
+	.error_tolerance_low_range	= 0,
+	.error_tolerance_high_range	= 4,
+};
+
+static struct tegra_uart_chip_data tegra194_uart_chip_data = {
+	.tx_fifo_full_status		= true,
+	.allow_txfifo_reset_fifo_mode	= false,
+	.support_clk_src_div		= true,
+	.fifo_mode_enable_status	= true,
+	.dma_burst_bytes		= 8,
+	.error_tolerance_low_range	= -2,
+	.error_tolerance_high_range	= 2,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
@@ -1431,6 +1482,9 @@ static const struct of_device_id tegra_uart_of_match[] = {
 		.compatible     = "nvidia,tegra186-hsuart",
 		.data		= &tegra186_uart_chip_data,
 	}, {
+		.compatible     = "nvidia,tegra194-hsuart",
+		.data		= &tegra194_uart_chip_data,
+	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
-- 
2.7.4

