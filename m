Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51AEFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82071214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jD8MDQx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438048AbfJQGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:22:41 -0400
Received: from mail-eopbgr820075.outbound.protection.outlook.com ([40.107.82.75]:26432
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437764AbfJQGWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgeDJIzP5D+fqFojj7PKzdk+CJz6mR0DgxH17sm65EE/mUQKOWq5iNnj9iu8MNTqGnY+ciyaS/BC9yMAtbOzk5G1b+3R63KtLBe8d4JSBkaJlCLuk80x4v36FnGeIPzfYMAKUYcTehk5H5HZ2B91tJi+dYLUGo8Hvb2oKVt985slz2BBrhSYAv5ogOx2r/ZVMASIqV0mH2n6w9hUQPAw1+EbAj+aPBPfCkkkvUz3YCbPOoI6fRAd/7zK0il+6HhwQHqY9zqlBLW1D3E8dg0/mUQG8qpbykXvzRwJaa199Yl34xnkNF0BqV7P5JJWJciKCsIF2pXW21O9yM22cos0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CQasHPXaJ2sCQPAjdsHoAZR98dlhjH7T48MmF7bglA=;
 b=bWqC1RNNTAAmhv2IzaqSk1/4Dt0I/5nSCQsIwWoQMm+IA3qz/nzFQxKlm0Am686bEnSuE8dw6IZbLd5jGvnC49MYbSpAKs9djjvY28Nlk73Phh9PYXKyJWdTK52tKNz6/MATlONDQ9YyyNRUobolRoxG2WumFvG1/QgbWBmsqUl2VhZci3PijdFPGia3x6xDzLHOXJSK0kCvYc9CdaiSg+TnhDaCUIiAgaRqdYerZaQdwa4JsFLa87TwlVzToPFuKLR8/6awIzKSVw9xPnuXX6zqUYCXKdOFFrN2/z6iZD/JhBxpAMDI87kRoS1bNqIPpW76NnAOl7nbPYQh8rUFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CQasHPXaJ2sCQPAjdsHoAZR98dlhjH7T48MmF7bglA=;
 b=jD8MDQx6sKpha2Iz/CGSp1hk5SDD1LvleSykdaysudFYOSE483ZGsVtxZaZYzCnHEE29+ZuqlrF8RLUR5f5lnUPfHEAK5shkhB+/wD91qMliTjpFxW8QnmPOZwIKsNjufyqOqZpsmVRKmiqgfFqTzCBeoYy1AhVOc1yIMoSTDu4=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by MWHPR02MB3151.namprd02.prod.outlook.com (2603:10b6:301:6a::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Thu, 17 Oct
 2019 06:22:15 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Thu, 17 Oct 2019 06:22:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Thu, 17 Oct 2019 06:22:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAr-0004bQ-Ua; Wed, 16 Oct 2019 23:22:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAm-0003mX-RS; Wed, 16 Oct 2019 23:22:08 -0700
Received: from [172.23.64.104] (helo=xhdvnc123.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iKzAe-0003fI-Mv; Wed, 16 Oct 2019 23:22:00 -0700
Received: by xhdvnc123.xilinx.com (Postfix, from userid 16987)
        id 5B88143A9B; Thu, 17 Oct 2019 11:52:00 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v3 7/8] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date:   Thu, 17 Oct 2019 11:51:49 +0530
Message-Id: <1571293310-92563-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(336012)(426003)(26005)(305945005)(2906002)(36386004)(186003)(47776003)(103686004)(81156014)(81166006)(8676002)(16586007)(50226002)(316002)(106002)(8936002)(42186006)(486006)(44832011)(2616005)(476003)(11346002)(446003)(126002)(50466002)(478600001)(36756003)(70586007)(70206006)(51416003)(107886003)(356004)(6666004)(48376002)(6266002)(76176011)(5660300002)(4326008)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3151;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c746296-2466-4db8-7745-08d752ca5a36
X-MS-TrafficTypeDiagnostic: MWHPR02MB3151:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3151EC1C7502D1810E473202C16D0@MWHPR02MB3151.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95aKU+mcAcJ9zXh0GZOUlVPOdFF3H1QOdHBxTy+aSgqBlO23JAzz4oXVk2j92cT9C2jfOWJ1MU9Jo83I2Lc+NHfMmwxRHsRsmZY4WLaMcsige8lYpAy8gWUgSJeK2BdQQffim7ByX4/vNzEd6FyozWzdqGQyxYqhJVZDIQGjAqZwJILiG4EOwfoVrEI4Mc7Wtwx04HEFHpvzFp5Qrmp/sMKqCtUoJcTR3SwCFwnot493Q685SwicfMMF2cXvpA9iYwLash3sFhGgHvKYza6oVCnJv+yl6/UEHviVL/elUiy5M5V2054qVFv/5bDya/ENYQMyxIKNn6awlVQVL20QnCC1lv463Vq+Cu7FyJnckSyHtm5xR9S33jMPLv/7qD3yuLmpHeEiqUUy6mzbnBJnm/d9bK8HHWvIhKYvvxXoTfE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 06:22:14.4853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c746296-2466-4db8-7745-08d752ca5a36
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dd documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and optional
properties followed by example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index e0369dd7fb18..c3ee86b819f3 100644
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
     - "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1": Intel LGM eMMC PHY
@@ -62,6 +65,10 @@ Optional Properties:
   controller while switching to particular speed mode. If not specified, driver
   will configure the default value defined for particular mode in it.
 
+  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
+    which the command and data lines are configured. If not specified, driver
+    will assume this as 0.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -98,6 +105,18 @@ Example:
 		#clock-cells = <0>;
 	};
 
+	sdhci: mmc@ff160000 {
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		interrupt-parent = <&gic>;
+		interrupts = <0 48 4>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		clocks = <&clk200>, <&clk200>;
+		clock-names = "clk_xin", "clk_ahb";
+		clock-output-names = "clk_out_sd0", "clk_in_sd0";
+		#clock-cells = <1>;
+		clk-phase-sd-hs = <63>, <72>;
+	};
+
 	emmc: sdhci@ec700000 {
 		compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
 		reg = <0xec700000 0x300>;
-- 
2.17.1

