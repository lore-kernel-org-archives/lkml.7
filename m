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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB2C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE422085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TSW60twc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfHLL3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17376 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHLL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d890000>; Mon, 12 Aug 2019 04:29:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 04:29:10 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:10 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:10 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:10 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d820000>; Mon, 12 Aug 2019 04:29:09 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Shardar Shariff Md" <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Date:   Mon, 12 Aug 2019 16:58:18 +0530
Message-ID: <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609353; bh=Kb8cbEz6rJFYJAtlVu/khIUYtTha+/jNCbvOutHh7ig=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TSW60twczLJtAL8JoqUQil8D047eS+DMQ8MRay4xI61hPXHEwsVEGssGqmvvil09p
         y+lDjrpeNGbERwUglTMM67pZMgWbrYd6I96OHt2rYHxSZpAJejiwZ0ih6zfHfG/4xB
         KAnJ1PsPe0fGYd7fIFTWJTB6HqjVatze6OItEniRxHc4dGH0ZWIKJy34vm/IcgA8SE
         tTUdNnJTfBR3kpioRfXKKk03uUDjgHm0ErDf/O/wYlxfVKRTf6Wt95S3Te9jPqj425
         RnM1qvOBgd+/qFkMjlIKFESEqWPTpA/dsQdVS4rJVG4bKAlaRm29Unh/ltsfG1aVqd
         cLilF/sVDdTNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

Set maximum number of UART ports to 8 as older chips have 7 ports and
Tergra194 and later chips will have 8 ports. Add this info to chip data
and register uart driver in platform driver probe.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index e0379d9..329923c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -62,7 +62,7 @@
 #define TEGRA_UART_TX_TRIG_4B			0x20
 #define TEGRA_UART_TX_TRIG_1B			0x30
 
-#define TEGRA_UART_MAXIMUM			5
+#define TEGRA_UART_MAXIMUM			8
 
 /* Default UART setting when started: 115200 no parity, stop, 8 data bits */
 #define TEGRA_UART_DEFAULT_BAUD			115200
@@ -87,6 +87,7 @@ struct tegra_uart_chip_data {
 	bool	allow_txfifo_reset_fifo_mode;
 	bool	support_clk_src_div;
 	bool	fifo_mode_enable_status;
+	int	uart_max_port;
 };
 
 struct tegra_uart_port {
@@ -1323,6 +1324,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.allow_txfifo_reset_fifo_mode	= true,
 	.support_clk_src_div		= false,
 	.fifo_mode_enable_status	= false,
+	.uart_max_port			= 5,
 };
 
 static struct tegra_uart_chip_data tegra30_uart_chip_data = {
@@ -1330,6 +1332,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= false,
+	.uart_max_port			= 5,
 };
 
 static struct tegra_uart_chip_data tegra186_uart_chip_data = {
@@ -1337,6 +1340,7 @@ static struct tegra_uart_chip_data tegra186_uart_chip_data = {
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
 	.fifo_mode_enable_status	= true,
+	.uart_max_port			= 5,
 };
 
 static const struct of_device_id tegra_uart_of_match[] = {
@@ -1386,6 +1390,7 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	u->type = PORT_TEGRA;
 	u->fifosize = 32;
 	tup->cdata = cdata;
+	tegra_uart_driver.nr = cdata->uart_max_port;
 
 	platform_set_drvdata(pdev, tup);
 	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1411,6 +1416,13 @@ static int tegra_uart_probe(struct platform_device *pdev)
 		return PTR_ERR(tup->rst);
 	}
 
+	ret = uart_register_driver(&tegra_uart_driver);
+	if (ret < 0) {
+		pr_err("Could not register %s driver\n",
+		       tegra_uart_driver.driver_name);
+		return ret;
+	}
+
 	u->iotype = UPIO_MEM32;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
@@ -1472,13 +1484,6 @@ static int __init tegra_uart_init(void)
 {
 	int ret;
 
-	ret = uart_register_driver(&tegra_uart_driver);
-	if (ret < 0) {
-		pr_err("Could not register %s driver\n",
-			tegra_uart_driver.driver_name);
-		return ret;
-	}
-
 	ret = platform_driver_register(&tegra_uart_platform_driver);
 	if (ret < 0) {
 		pr_err("Uart platform driver register failed, e = %d\n", ret);
-- 
2.7.4

