Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44EDC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70170214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A5xhXGRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfHLL3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18479 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHLL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d9c0002>; Mon, 12 Aug 2019 04:29:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:29:22 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:21 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d8e0000>; Mon, 12 Aug 2019 04:29:21 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Shardar Shariff Md <smohammed@nvidia.com>
Subject: [PATCH 12/14] serial: tegra: add support to adjust baud rate
Date:   Mon, 12 Aug 2019 16:58:21 +0530
Message-ID: <1565609303-27000-13-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609373; bh=4VuVn4if/4s3BnQNcEwaN+bWUnt5ZYouFMrUfkNcwAY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=A5xhXGRAw2qNEvMFHKuMGOGcKVOZmqsMLyGTNu0Jdkv7g/hMZRzg+aCa9XCk0tYbb
         0f6z0/AoiQ+fQgryXXQx+cr2en8jS89ueIiCZvy4PB+pJPRXXS8DGtlQ/JNTHoz3Sy
         qWZZ88qfmRm9FSbviW1OeitlvTC2+darheXBf4GJ1KW4s7J//i3YamS6jaFiunQqmz
         bj8guz1FfflcKQsrA+RGT0lPFWhNT68JLbg0SS6HqVYwIs9znkXmhn8+sZyO+Yw1US
         moXPPvIgK5ik0YVLxc7weuE60MKDCtj3NoSVsZnyReLhlCv1cUInO1S2felxc1A+Wy
         NvDxk1sHW6QPA==
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
index 03d1d20..3c9e5c5 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -91,6 +91,12 @@ struct tegra_uart_chip_data {
 	int	dma_burst_bytes;
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
@@ -329,6 +337,21 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
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
@@ -342,6 +365,9 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	if (tup->cdata->support_clk_src_div) {
 		rate = baud * 16;
+		if (tup->n_adjustable_baud_rates)
+			rate = tegra_get_tolerance_rate(tup, baud, rate);
+
 		ret = clk_set_rate(tup->uart_clk, rate);
 		if (ret < 0) {
 			dev_err(tup->uport.dev,
@@ -1312,6 +1338,12 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
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
@@ -1322,6 +1354,42 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 
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

