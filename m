Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC11C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F83214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aBuk0ZW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfKGJpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:45:08 -0500
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:51391
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727632AbfKGJpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:45:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEkpiYrGhlhold6F3vcVd7VjkY8X53eE/8Ve08fKY+lzEzm7ZAtAtaLzsHFMXzCybbdk30ZxeKDp5AR6XiRxzA7ugptTnPuCItAJuaZ4IxDrKIJgkb5lsgn4EvGSLE5+9xcR1ybuSq25FMY7K3Sv4BJmETGS1alwwaVcovHkBB7sDriRjq/vwP0W7RA6qCWzy003zfW8alluWfGK1xbf9PHEJGrajrSn0OISIp/mhCd3wiwWJ1Mneac9gYzLMdWYtMrTCgRg2O8fXWv7OYl3iiFyrXop8NHM//syNFLvjBMV6K6KAvt9ELglnyLPzlfVMAmT6cZsz9W+Xtr+CCJxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70XN+HW2tOs+lMgwysC8NdDOrLly9+dbxuxZUme1AR8=;
 b=QLPKoUwAyg0lq0ghGgixcsI5E29P5VpMGZrefFx/CHQCQxxxE5jteT5fMQg0Y7lsj4ugu2/YllYdX0IGfidci1BDJOS3u47bfluXy3cb6ky1wAqGEfnxrGqNg7dEWVx80BN8w3Teh00J/CHxAD1HtCUualvrs8f/ZiW2EOmUPDtUWeKrXNas2xP9onzgTLSfyao47IWfYTlyTG1x+1WoE7B7WoIqWxIYvZVJg16web6oqH5W7znAu23XlK9RXUoJyNuDblZrEnC0NBmpcZ3PBOkvLOLLWVpm0mMcjpOU8YK4cT9khPcYSCqdlIYV8vlXM9x5aVZl75SaBJtrT+t/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70XN+HW2tOs+lMgwysC8NdDOrLly9+dbxuxZUme1AR8=;
 b=aBuk0ZW1RCFniY8nt8a/u/+5Ls8TVMHra/Zgiuhm4Pax9ttL5haAzgYdMPcbyEsLNGJRmtm/9otHbDbqay7+i5lz30BxgvmFTvWgl6qS6HQupHuSWqjTiNJinDKDFLCsR8V2StWL0RWr18S1cEB+MOF5vXACYEu+VOwNaSlKPAg=
Received: from MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20)
 by BL0PR02MB6467.namprd02.prod.outlook.com (2603:10b6:208:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 09:45:00 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MN2PR02CA0007.outlook.office365.com
 (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 09:45:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 09:44:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSeLb-0002kG-DO; Thu, 07 Nov 2019 01:44:59 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSeLW-00006a-AP; Thu, 07 Nov 2019 01:44:54 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA79iox9004141;
        Thu, 7 Nov 2019 01:44:51 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSeLS-00005Y-Oq; Thu, 07 Nov 2019 01:44:50 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        harini.katakam@xilinx.com, jan.kiszka@siemens.com,
        ulf.hansson@linaro.org, xuwei5@hisilicon.com, mripard@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH 2/3] arm64: dts: xilinx: Remove dtsi for fixed clock
Date:   Thu,  7 Nov 2019 01:44:15 -0800
Message-Id: <1573119856-13548-3-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(51416003)(7696005)(6666004)(305945005)(7416002)(76176011)(107886003)(14444005)(356004)(446003)(70586007)(70206006)(4326008)(5660300002)(36386004)(50466002)(16586007)(36756003)(81156014)(8676002)(2906002)(50226002)(81166006)(9786002)(106002)(486006)(126002)(336012)(2616005)(476003)(44832011)(11346002)(186003)(48376002)(478600001)(47776003)(26005)(316002)(426003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB6467;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6a85ec6-43c7-4a7e-94b1-08d7636727ff
X-MS-TrafficTypeDiagnostic: BL0PR02MB6467:
X-Microsoft-Antispam-PRVS: <BL0PR02MB646742EA69B52584D2C069C3B7780@BL0PR02MB6467.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDFT1bs6pKz1MSgHjnKn928v1hyrZUa+izHVctNPxs6ilJphH4x6yDw25q11Q8b3RUrMCDd06fZGjRMaYBw7CO5eET3SwNyEkfukvHkdD+61claarbsNWsNY7W99U3ZPlfPV0i4Q2Rw4qq+ILX/Ag6H/ub3QtaZwGMSHv/oHlAVD246v/KiGL8X11xwvRAgWZzYt2QMJE6kq7HsD2VqSOIXIHx9gxI4QQa5xtILtvjm5YbzEeoNTNUhwqw7BxRGdOxs4vvD25jIYrOIHR9vql0pENbbAAlwh8hXfEa4OZ7yk+JLLsPN88uASrcZI+QhovUJMhihXx/ubzrdeIa7eV6j1EIpZcHCoDq7IL4zIzgKWGSPa/+8SEKkjLFadEGGrsHj193fOrdkTG3g9XH8QXjPBbO7Trif1gmocclIjNgJEC7ikUb7Cnq4I+23YmL0u
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 09:44:59.8575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a85ec6-43c7-4a7e-94b1-08d7636727ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CCF clocks sre used in zynqmp dts. So there is no use of
dtsi for fixed clock. Remove dtsi for fixed clock.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi | 213 -----------------------------
 1 file changed, 213 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
deleted file mode 100644
index 306ad21..0000000
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
+++ /dev/null
@@ -1,213 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Clock specification for Xilinx ZynqMP
- *
- * (C) Copyright 2015 - 2018, Xilinx, Inc.
- *
- * Michal Simek <michal.simek@xilinx.com>
- */
-
-/ {
-	clk100: clk100 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	clk125: clk125 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-	};
-
-	clk200: clk200 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-	};
-
-	clk250: clk250 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <250000000>;
-	};
-
-	clk300: clk300 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <300000000>;
-	};
-
-	clk600: clk600 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <600000000>;
-	};
-
-	dp_aclk: clock0 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-		clock-accuracy = <100>;
-	};
-
-	dp_aud_clk: clock1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24576000>;
-		clock-accuracy = <100>;
-	};
-
-	dpdma_clk: dpdma-clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0x0>;
-		clock-frequency = <533000000>;
-	};
-
-	drm_clock: drm-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0x0>;
-		clock-frequency = <262750000>;
-		clock-accuracy = <0x64>;
-	};
-};
-
-&can0 {
-	clocks = <&clk100 &clk100>;
-};
-
-&can1 {
-	clocks = <&clk100 &clk100>;
-};
-
-&fpd_dma_chan1 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan2 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan3 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan4 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan5 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan6 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan7 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&fpd_dma_chan8 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan1 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan2 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan3 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan4 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan5 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan6 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan7 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&lpd_dma_chan8 {
-	clocks = <&clk600>, <&clk100>;
-};
-
-&gem0 {
-	clocks = <&clk125>, <&clk125>, <&clk125>;
-};
-
-&gem1 {
-	clocks = <&clk125>, <&clk125>, <&clk125>;
-};
-
-&gem2 {
-	clocks = <&clk125>, <&clk125>, <&clk125>;
-};
-
-&gem3 {
-	clocks = <&clk125>, <&clk125>, <&clk125>;
-};
-
-&gpio {
-	clocks = <&clk100>;
-};
-
-&i2c0 {
-	clocks = <&clk100>;
-};
-
-&i2c1 {
-	clocks = <&clk100>;
-};
-
-&sata {
-	clocks = <&clk250>;
-};
-
-&sdhci0 {
-	clocks = <&clk200 &clk200>;
-};
-
-&sdhci1 {
-	clocks = <&clk200 &clk200>;
-};
-
-&spi0 {
-	clocks = <&clk200 &clk200>;
-};
-
-&spi1 {
-	clocks = <&clk200 &clk200>;
-};
-
-&uart0 {
-	clocks = <&clk100 &clk100>;
-};
-
-&uart1 {
-	clocks = <&clk100 &clk100>;
-};
-
-&usb0 {
-	clocks = <&clk250>, <&clk250>;
-};
-
-&usb1 {
-	clocks = <&clk250>, <&clk250>;
-};
-
-&watchdog0 {
-	clocks = <&clk250>;
-};
-- 
2.7.4

