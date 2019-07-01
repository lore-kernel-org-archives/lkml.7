Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16983C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CEF21479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wb/gacZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfGAFax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:30:53 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:14919
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727533AbfGAFaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzct6bKh5mu5ko5l0RipudqTl9PS5JVBajCtMm5Phyo=;
 b=wb/gacZMP83r/ei1gXLlwJCimiDRYlF/p5dGMv5uptBHyHsmR6in7nT4m2YdRA6GJ8X09Es4aPSd+LT+Kr5h61nqOotQQIbAhTaKbLuhJuTSkBzz2+eSa/x+BeeUG/ApX2YeoPXSHB2QIscKylmIsnM28yzJBM580rqoBgKqdBM=
Received: from BN6PR02CA0087.namprd02.prod.outlook.com (10.161.158.28) by
 DM6PR02MB5242.namprd02.prod.outlook.com (20.176.116.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 05:30:08 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR02CA0087.outlook.office365.com
 (2603:10b6:405:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.17 via Frontend
 Transport; Mon, 1 Jul 2019 05:30:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:30:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhotC-0002rw-OJ; Sun, 30 Jun 2019 22:30:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhot7-0003EO-J3; Sun, 30 Jun 2019 22:30:01 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615TtA8008169;
        Sun, 30 Jun 2019 22:29:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhot0-0003CN-Vf; Sun, 30 Jun 2019 22:29:55 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2A452121063; Mon,  1 Jul 2019 10:59:54 +0530 (IST)
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
Subject: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation for SD Card Clock
Date:   Mon,  1 Jul 2019 10:59:41 +0530
Message-Id: <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(199004)(189003)(63266004)(50466002)(478600001)(76176011)(6266002)(26005)(42186006)(36386004)(5660300002)(2616005)(36756003)(446003)(476003)(103686004)(7416002)(186003)(336012)(44832011)(16586007)(11346002)(126002)(356004)(70586007)(4326008)(70206006)(316002)(305945005)(15650500001)(106002)(50226002)(48376002)(51416003)(8936002)(81156014)(72206003)(81166006)(486006)(8676002)(47776003)(426003)(2906002)(6666004)(52956003)(921003)(42866002)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5242;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f52d5f-620e-4deb-d46c-08d6fde52de8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR02MB5242;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5242:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5242573C780C82A28EC5B0A7C1F90@DM6PR02MB5242.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: I3AOl3OhYMrMAwHzDn3Y5VCgXJA8vmtAYMzXLApLsvv8LRWJ/A0glzrLIslJlB4nsw8BAluv50nK6iwGogwEt+AuOZTUEJqXSnG6HvqiYePF25Zfk31DegP8/ima8zZDzBQI2/ByTTA3f8JzQ61EazJmL5bBKSDi+DVHHitfs6UixmUyAWYvuMwkTHP/0bE9GKwLookpZtkEgJLuqM2D4UiDcFUrMXzAVjujQUYs6YjP3iZzRV1HrK3t5ZkgmKv1J54r6olvd0kIppxP4gnmUpIHP3i0bPfyLJpvk/Z3iMHB12KOCzRf4WynnarvNsCjmVR2aubcEWclib8GDVO01XvNtdTR5TBKfxCyalVpQ1H5gWQRhEvSG2xU8fRiyOTIpPbkD98JnzvvMWhYgh1SBXaXTdSQhb+uFmFZKVP8Zpg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:30:07.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f52d5f-620e-4deb-d46c-08d6fde52de8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock handling is to be updated in the Arasan SDHCI. As the
'devm_clk_register' is deprecated in the clock framework, this needs to
specify one more clock named 'clk_sdcard' to get the clock in the driver
via 'devm_clk_get()'. This clock represents the clock from controller to
the card.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 1edbb04..15c6397 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -23,6 +23,10 @@ Required Properties:
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
+		 Apart from these two there is one more optional clock which
+		 is "clk_sdcard". This clock represents output clock from
+		 controller and card. This must be specified when #clock-cells
+		 is specified.
   - interrupts: Interrupt specifier
 
 Required Properties for "arasan,sdhci-5.1":
@@ -36,9 +40,10 @@ Optional Properties:
   - clock-output-names: If specified, this will be the name of the card clock
     which will be exposed by this device.  Required if #clock-cells is
     specified.
-  - #clock-cells: If specified this should be the value <0>.  With this property
-    in place we will export a clock representing the Card Clock.  This clock
-    is expected to be consumed by our PHY.  You must also specify
+  - #clock-cells: If specified this should be the value <0>. With this
+    property in place we will export one clock representing the Card
+    Clock. This clock is expected to be consumed by our PHY. You must also
+    specify
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
@@ -70,8 +75,8 @@ Example:
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>, <&sdhci 0>;
+		clock-names = "clk_xin", "clk_ahb", "clk_sdcard";
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
-- 
2.1.1

