Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356DB208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hODwx1bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfHLL3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17367 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbfHLL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d850000>; Mon, 12 Aug 2019 04:29:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 04:29:06 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:06 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:06 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d7f0000>; Mon, 12 Aug 2019 04:29:06 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH 08/14] serial: tegra: check for FIFO mode enabled status
Date:   Mon, 12 Aug 2019 16:58:17 +0530
Message-ID: <1565609303-27000-9-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609349; bh=K5XclLIEm6+tT2h1xH2RmBo2OYFnrhtR4zz6OmWdxI8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hODwx1bwZ5ZYVEGgZYW1krmWQZ/xEjveq9hOX3r68AWNfXCjjLDGwLWEL15TYJO2Q
         7EvHpnaOahnHH4hVxOqq/wM/dqEwyXqcf95m4X7DUMXKowK6svHnm9UzlhFrRKBdLR
         jWdsBmvpwRrcTYkSgMApu3fsxTGdfty+O+GB0o5sC/BSwixvuZy7HqXF3XNPDTHNxp
         aE5TEk+272F4epiI8tMuyg85Z1wdwBhRa4leCbeh/Obp7GkU5fCBVEeVnDygzs7YRk
         h3dkrQTqm8VuZU+5NR9apslepQhVE3CLw61LOpy7Upvg6I7ZF3GFsW+zvvmyydh1y9
         TL3zPL6gpzrmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chips prior to Tegra186 needed delay of 3 UART clock cycles to avoid
data loss. This issue is fixed in Tegra186 and a new flag is added to
check if fifo mode is enabled. chip data updated to check if this flag
is available for a chip. Tegra186 has new compatible to enable this
flag.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 52 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 7ab81bb..e0379d9 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -72,6 +72,8 @@
 #define TEGRA_TX_PIO				1
 #define TEGRA_TX_DMA				2
 
+#define TEGRA_UART_FCR_IIR_FIFO_EN		0x40
+
 /**
  * tegra_uart_chip_data: SOC specific data.
  *
@@ -84,6 +86,7 @@ struct tegra_uart_chip_data {
 	bool	tx_fifo_full_status;
 	bool	allow_txfifo_reset_fifo_mode;
 	bool	support_clk_src_div;
+	bool	fifo_mode_enable_status;
 };
 
 struct tegra_uart_port {
@@ -263,6 +266,22 @@ static void tegra_uart_wait_sym_time(struct tegra_uart_port *tup,
 			tup->current_baud));
 }
 
+static int tegra_uart_is_fifo_mode_enabled(struct tegra_uart_port *tup)
+{
+	unsigned long iir;
+	unsigned int tmout = 100;
+
+	do {
+		iir = tegra_uart_read(tup, UART_IIR);
+		if (iir & TEGRA_UART_FCR_IIR_FIFO_EN)
+			return 0;
+		udelay(1);
+	} while (--tmout);
+	dev_err(tup->uport.dev, "FIFO mode not enabled\n");
+
+	return -EIO;
+}
+
 static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
@@ -282,6 +301,8 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 		tegra_uart_write(tup, fcr, UART_FCR);
 		fcr |= UART_FCR_ENABLE_FIFO;
 		tegra_uart_write(tup, fcr, UART_FCR);
+		if (tup->cdata->fifo_mode_enable_status)
+			tegra_uart_is_fifo_mode_enabled(tup);
 	}
 
 	/* Dummy read to ensure the write is posted */
@@ -918,12 +939,19 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	/* Dummy read to ensure the write is posted */
 	tegra_uart_read(tup, UART_SCR);
 
-	/*
-	 * For all tegra devices (up to t210), there is a hardware issue that
-	 * requires software to wait for 3 UART clock periods after enabling
-	 * the TX fifo, otherwise data could be lost.
-	 */
-	tegra_uart_wait_cycle_time(tup, 3);
+	if (tup->cdata->fifo_mode_enable_status) {
+		ret = tegra_uart_is_fifo_mode_enabled(tup);
+		if (ret < 0)
+			return ret;
+	} else {
+		/*
+		 * For all tegra devices (up to t210), there is a hardware
+		 * issue that requires software to wait for 3 UART clock
+		 * periods after enabling the TX fifo, otherwise data could
+		 * be lost.
+		 */
+		tegra_uart_wait_cycle_time(tup, 3);
+	}
 
 	/*
 	 * Initialize the UART with default configuration
@@ -1294,12 +1322,21 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.tx_fifo_full_status		= false,
 	.allow_txfifo_reset_fifo_mode	= true,
 	.support_clk_src_div		= false,
+	.fifo_mode_enable_status	= false,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.tx_fifo_full_status		= true,
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
+	.fifo_mode_enable_status	= false,
+};
+
+static struct tegra_uart_chip_data tegra186_uart_chip_data = {
+	.tx_fifo_full_status		= true,
+	.allow_txfifo_reset_fifo_mode	= false,
+	.support_clk_src_div		= true,
+	.fifo_mode_enable_status	= true,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
@@ -1310,6 +1347,9 @@ static const struct of_device_id tegra_uart_of_match[] = {
 		.compatible	= "nvidia,tegra20-hsuart",
 		.data		= &tegra20_uart_chip_data,
 	}, {
+		.compatible     = "nvidia,tegra186-hsuart",
+		.data		= &tegra186_uart_chip_data,
+	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
-- 
2.7.4

