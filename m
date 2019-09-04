Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D9922DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="loKEDSOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfIDEn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:43:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6777 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfIDEn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:43:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f410d0000>; Tue, 03 Sep 2019 21:43:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Sep 2019 21:43:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Sep 2019 21:43:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:54 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 04:43:53 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 04:43:53 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f41060000>; Tue, 03 Sep 2019 21:43:53 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH V2 10/12] serial: tegra: add support to adjust baud rate
Date:   Wed, 4 Sep 2019 10:13:05 +0530
Message-ID: <1567572187-29820-11-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567572237; bh=IZae99G+BuwW5yhrHlYLtUOFBH5on+g3tDFO/hptQ/Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=loKEDSOTQdABr6YAnAhTMhGuxm5JRzrY2WR2ztU4sesE2n6Rpfs+xzNIMIQQoM8Ro
         4Xdfm7rMIOgYJW+pA9S3Z/S06mD/pElY8tIliCyGHzydJP/vO/n6Ugh21dOJ5jPlsU
         4K2OfPMDpa49dw/HQf4IBDRy8zaDcxvsxDA5donGBsFp+V10a6jI1TOKwP2TI+vJUQ
         wDkWlZONFaOE+KP/sjoyCG0vqwVqFSLSs0zg/ZSn4sZ+KTy5//U53Zoadyz+MrNBBV
         TZexE/A0p/KpaOmMvhbLHN2u3HVPQFwr8Owh+T3KE+ekp4I2Om6/8tkFbveTzhwC0q
         YArwHoc6XeKnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to adjust baud rates to fall under supported tolerance
range through DT.

Tegra186 chip has a hardware issue resulting in frame errors when
tolerance level for baud rate is negative. Provided entries to adjust
baud rate to be within acceptable range and work with devices that
can send negative baud rate. Also report error when baud rate set is
out of tolerance range of controller updated in device tree.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 02f8535..f970ed7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -91,6 +91,12 @@ struct tegra_uart_chip_data {
 	int	max_dma_burst_bytes;
 };
 
+struct tegra_baud_tolerance {
+	u32 lower_range_baud;
+	u32 upper_range_baud;
+	s32 tolerance;
+};
+
 struct tegra_uart_port {
 	struct uart_port			uport;
 	const struct tegra_uart_chip_data	*cdata;
@@ -127,6 +133,8 @@ struct tegra_uart_port {
 	dma_cookie_t				rx_cookie;
 	unsigned int				tx_bytes_requested;
 	unsigned int				rx_bytes_requested;
+	struct tegra_baud_tolerance		*baud_tolerance;
+	int					n_adjustable_baud_rates;
 };
 
 static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);
@@ -327,6 +335,21 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 		set_rts(tup, true);
 }
 
+static long tegra_get_tolerance_rate(struct tegra_uart_port *tup,
+				     unsigned int baud, long rate)
+{
+	int i;
+
+	for (i = 0; i < tup->n_adjustable_baud_rates; ++i) {
+		if (baud >= tup->baud_tolerance[i].lower_range_baud &&
+		    baud <= tup->baud_tolerance[i].upper_range_baud)
+			return (rate + (rate *
+				tup->baud_tolerance[i].tolerance) / 10000);
+	}
+
+	return rate;
+}
+
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 {
 	unsigned long rate;
@@ -340,6 +363,9 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	if (tup->cdata->support_clk_src_div) {
 		rate = baud * 16;
+		if (tup->n_adjustable_baud_rates)
+			rate = tegra_get_tolerance_rate(tup, baud, rate);
+
 		ret = clk_set_rate(tup->uart_clk, rate);
 		if (ret < 0) {
 			dev_err(tup->uport.dev,
@@ -1311,6 +1337,12 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	int port;
+	int ret;
+	int index;
+	u32 pval;
+	int count;
+	int n_entries;
+
 
 	port = of_alias_get_id(np, "serial");
 	if (port < 0) {
@@ -1321,6 +1353,42 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 
 	tup->enable_modem_interrupt = of_property_read_bool(np,
 					"nvidia,enable-modem-interrupt");
+	n_entries = of_property_count_u32_elems(np, "nvidia,adjust-baud-rates");
+	if (n_entries > 0) {
+		tup->n_adjustable_baud_rates = n_entries / 3;
+		tup->baud_tolerance =
+		devm_kzalloc(&pdev->dev, (tup->n_adjustable_baud_rates) *
+			     sizeof(*tup->baud_tolerance), GFP_KERNEL);
+		if (!tup->baud_tolerance)
+			return -ENOMEM;
+		for (count = 0, index = 0; count < n_entries; count += 3,
+		     index++) {
+			ret =
+			of_property_read_u32_index(np,
+						   "nvidia,adjust-baud-rates",
+						   count, &pval);
+			if (!ret)
+				tup->baud_tolerance[index].lower_range_baud =
+				pval;
+			ret =
+			of_property_read_u32_index(np,
+						   "nvidia,adjust-baud-rates",
+						   count + 1, &pval);
+			if (!ret)
+				tup->baud_tolerance[index].upper_range_baud =
+				pval;
+			ret =
+			of_property_read_u32_index(np,
+						   "nvidia,adjust-baud-rates",
+						   count + 2, &pval);
+			if (!ret)
+				tup->baud_tolerance[index].tolerance =
+				(s32)pval;
+		}
+	} else {
+		tup->n_adjustable_baud_rates = 0;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

