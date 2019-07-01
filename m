Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD5C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D159A212F5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zNTLuAcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfGAFaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:30:30 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:19041
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727563AbfGAFaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+8MbKdv/urDiUXPMU5VRQGsspDB9YemXx5HGwKn5Zk=;
 b=zNTLuAcGvTTsDukAZRQxOpPJAO5GSued8ZHHtRFK965qK1pfhL3vPG1Yw+2OZT0Vz60kFKuJ0Idg7FA+cfMaUbHLtAVaUEM69FXea5W3ZQ+VoEwUk06w3PgVlUWNZaK/Wj6/tF0OgYL+CzRRryVPvAzzDAY06ZdoXBCiKPltRTo=
Received: from BL0PR02CA0137.namprd02.prod.outlook.com (20.177.207.106) by
 SN6PR02MB5247.namprd02.prod.outlook.com (52.135.103.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 05:30:09 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0137.outlook.office365.com
 (2603:10b6:208:35::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.18 via Frontend
 Transport; Mon, 1 Jul 2019 05:30:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:30:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhotE-0002rx-0o; Sun, 30 Jun 2019 22:30:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhot8-0003EO-LM; Sun, 30 Jun 2019 22:30:02 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615TuFB023630;
        Sun, 30 Jun 2019 22:29:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhot2-0003Ch-4m; Sun, 30 Jun 2019 22:29:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6046E121756; Mon,  1 Jul 2019 10:59:54 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        manish.narani@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 10/11] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date:   Mon,  1 Jul 2019 10:59:50 +0530
Message-Id: <1561958991-21935-11-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(16586007)(50226002)(76176011)(336012)(2616005)(316002)(42186006)(51416003)(7416002)(72206003)(2906002)(476003)(186003)(106002)(47776003)(305945005)(26005)(4326008)(36756003)(356004)(6666004)(36386004)(52956003)(81156014)(8676002)(50466002)(63266004)(126002)(486006)(70586007)(70206006)(81166006)(5660300002)(103686004)(44832011)(48376002)(11346002)(6266002)(478600001)(426003)(446003)(8936002)(142933001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5247;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ededdd-3bed-49ab-90d8-08d6fde52e72
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB5247;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5247:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52472352022881E709C690D2C1F90@SN6PR02MB5247.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ABitW+AB6Qt1J8swLUC04IWvycGShZVF7p5AszSz7rsPc47ISs4bZ7JvKvI1Fouv7qKBg6UVSNrC6gCPMZ/wzUFOUUMgnOxT8oP+5t1nQkHK6dOqkTlOPzYPzJmJvYVmZRgF9ghqzeOqE7z8g3vv3bGkEnKpQY7BdtHO2F6rogX7HlxkvLqvm6ggvhDXjeYzdtaZ9JVQcnjK27IP4EKnylj2z/U2KNzlE/6yOlQFQMt26C5vTJqiPa9hrHVVIIW+VD5VwJMWFCp5MTIOJvElgvX9XH1I+FkkQ6Y8XSM44KnrYH25fpls48uQymcJAKUF7169Dy+BSGKI+F5ZxbTcxPKKKHhF7lR9F8Gs00fBoP1mlhcNTsTPidDqn2gfZCNN3OXcki6+YT5dy2//OtFTU3nLe2P0fV1OliFgMy4Y3JA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:30:08.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ededdd-3bed-49ab-90d8-08d6fde52e72
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and optional
properties followed by example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7425d52..d2058ee 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -15,6 +15,9 @@ Required Properties:
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "xlnx,zynqmp-8.9a": ZynqMP SDHCI 8.9a PHY
+      For this device it is strongly suggested to include clock-output-names and
+      #clock-cells.
     - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
 	Note: This binding has been deprecated and moved to [5].
 
@@ -65,6 +68,10 @@ Optional Properties:
   controller while switching to particular speed mode. If not specified, driver
   will configure the default value defined for particular mode in it.
 
+  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
+    which the command and data lines are configured. If not specified, driver
+    will assume this as 0.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -100,3 +107,15 @@ Example:
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
 	};
+
+	sdhci: mmc@ff160000 {
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		interrupt-parent = <&gic>;
+		interrupts = <0 48 4>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		clocks = <&clk200>, <&clk200>, <&sdhci 0>, <&sdhci 1>;
+		clock-names = "clk_xin", "clk_ahb", "clk_sdcard", "clk_sample";
+		clock-output-names = "clk_out_sd0", "clk_in_sd0";
+		#clock-cells = <1>;
+		clk-phase-sd-hs = <63>, <72>;
+	};
-- 
2.1.1

