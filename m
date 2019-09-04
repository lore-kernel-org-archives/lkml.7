Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C31C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C48F22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gVo3746v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfIDEoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:44:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6784 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfIDEn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f41100000>; Tue, 03 Sep 2019 21:44:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Sep 2019 21:43:58 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:58 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:57 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:57 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f410a0000>; Tue, 03 Sep 2019 21:43:57 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH V2 11/12] serial: tegra: report clk rate errors
Date:   Wed, 4 Sep 2019 10:13:06 +0530
Message-ID: <1567572187-29820-12-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572241; bh=6GuzwNjfqjC6sa7qLkGdDN4IQWnYvkgZRsI14Sszg94=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gVo3746vHsyr0qmIhywTzvVYx7A9lQPcxDwOqHVu9U/qgGyCgAdLujUMz2pK8akVN
         S5LDfN9eHmCx0tnFzzmZmEKO5pok6JBC5oqcTG0AOfokZZMn/KvnvjYUOCdr1p7nlF
         z7GJpkzW2BVzhuIX8NN/YxDcU9FSns3kjdDlgpGWwbsnjRsjledYbiesTv4/NCe4nk
         W8SM2XYpdUB4xyliPOFd6fZK1gkhTAmhibHM0IeVc+lIhBqUL9eqWjsYCFpmq7zLyy
         PQ3czL/gDuml7QuH6kggxdOo8l286A4SnMy8WVB9wxWMF5ZV4fYRL8oDzvysdzidB6
         tpXhURWc2qn3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard UART controllers support +/-4% baud rate error tolerance.
Tegra186 only supports 0% to +4% error tolerance whereas other Tegra
chips support standard +/-4% rate. Add chip data for knowing error
tolerance level for each soc. Creating new compatible for Tegra194
chip as it supports baud rate error tolerance of -2 to +2%, different
from older chips.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 59 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index f970ed7..d0fd417 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -89,6 +89,8 @@ struct tegra_uart_chip_data {
 	bool	fifo_mode_enable_status;
 	int	uart_max_port;
 	int	max_dma_burst_bytes;
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
@@ -350,6 +354,22 @@ static long tegra_get_tolerance_rate(struct tegra_uart_port *tup,
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
+			"configured baud rate is out of range by %ld", diff);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 {
 	unsigned long rate;
@@ -363,6 +383,8 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	if (tup->cdata->support_clk_src_div) {
 		rate = baud * 16;
+		tup->required_rate = rate;
+
 		if (tup->n_adjustable_baud_rates)
 			rate = tegra_get_tolerance_rate(tup, baud, rate);
 
@@ -372,7 +394,11 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
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
@@ -991,7 +1017,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
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
 
@@ -1190,6 +1220,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	struct clk *parent_clk = clk_get_parent(tup->uart_clk);
 	unsigned long parent_clk_rate = clk_get_rate(parent_clk);
 	int max_divider = (tup->cdata->support_clk_src_div) ? 0x7FFF : 0xFFFF;
+	int ret;
 
 	max_divider *= 16;
 	spin_lock_irqsave(&u->lock, flags);
@@ -1262,7 +1293,11 @@ static void tegra_uart_set_termios(struct uart_port *u,
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
@@ -1399,6 +1434,8 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
+	.error_tolerance_low_range	= 0,
+	.error_tolerance_high_range	= 4,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1408,6 +1445,8 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
+	.error_tolerance_low_range	= 0,
+	.error_tolerance_high_range	= 4,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1417,6 +1456,19 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.fifo_mode_enable_status	= true,
 	.uart_max_port			= 8,
 	.max_dma_burst_bytes		= 8,
+	.error_tolerance_low_range	= 0,
+	.error_tolerance_high_range	= 4,
+};
+
+static struct tegra_uart_chip_data tegra194_uart_chip_data = {
+	.tx_fifo_full_status		= true,
+	.allow_txfifo_reset_fifo_mode	= false,
+	.support_clk_src_div		= true,
+	.fifo_mode_enable_status	= true,
+	.uart_max_port			= 8,
+	.max_dma_burst_bytes		= 8,
+	.error_tolerance_low_range	= -2,
+	.error_tolerance_high_range	= 2,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
@@ -1430,6 +1482,9 @@ static const struct of_device_id tegra_uart_of_match[] = {
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

