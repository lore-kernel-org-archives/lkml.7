Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB8BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E921721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FIhFfeBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfJ2KbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:31:17 -0400
Received: from mail-eopbgr790077.outbound.protection.outlook.com ([40.107.79.77]:25760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730588AbfJ2KbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:31:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcPJwlb51njYt6sDkzgZS/nEQ9ZMYCEqx61n+3rDH20Li5oLyovDZL+ve1eObA4MTiLRZ591pEuOR0K2q7d8VJnWFbC4gBZM3axtiwnc5UEZzJzKjW2vRSbUio8EczSP8HDGPaL7YYx2OS4YGTy3qJfxLC/p4SPak9dntgjs/kWTucNE/vv6uQZ4BpYKqm5CQZTxtB/0WHo+auiw+pQRooVk06zsgp/B+RYpwChBuHn/KOeigBUqUs6LjdyjIXrCw+ZYYCKbxIonKaMngCu4gw3IIVRwgMfteEH66/eBwGtSE9wRwHyCwKIjaBYgWK9JjwYQBb8HH3xHigKnUguBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxw1psbVVwyN2TF4HQNaK35e4i6JA+/gvN/jbmvC1Nc=;
 b=ERMBTIRh+0gPy3sfbf9D4hrIRHOVFo5HhcHQ5eK50Oh6d2suEWWq3vkjZTngfaGxyCOu6YyQYhfFB+8R3CrSRBqoy13ji40nIq8EprzIEyzLwA79Jc8P22T4ySWhaYVpsaARgcLqIK+03SSsh3HjkOBK65JzLOd6GYUuvJ9igR/EneuI+7YYc6KD1sLjxwtO2Zugt6lJ+VGHRjd4EVSz+axY9/QzP1y1Oxs6+eeKK6xaNo/HBKKObIHvkoxg6Dlrk4WdPISLPf4J6az/+xVBbaUTuLjvc5WNoNdi0v3C6NLwLWw17Sq9yh3Ksc/CJSoSZWiQZtNitx4iHPCGpQ6Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxw1psbVVwyN2TF4HQNaK35e4i6JA+/gvN/jbmvC1Nc=;
 b=FIhFfeBYVsiZRz3pVRYDInPsc5fyQelw8ZV1zporMpt2rFGifOm2oVpVpQIXBJJvKkMXFGPZdqNzUogYcWXJd6qqd9B6wwjm5g9etHNzbKppNAYQj5sr96eXFM1n/ul900gtN6wsxeIQBTeTT3HJx0UT6UNs7tB26NjYtXKLnCg=
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by BYAPR02MB4693.namprd02.prod.outlook.com (2603:10b6:a03:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Tue, 29 Oct
 2019 10:31:02 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Tue, 29 Oct 2019 10:31:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 29 Oct 2019 10:31:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOmD-0002tz-JU; Tue, 29 Oct 2019 03:31:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOm8-0005qH-E0; Tue, 29 Oct 2019 03:30:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iPOly-0005lC-6v; Tue, 29 Oct 2019 03:30:46 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 805A31217FE; Tue, 29 Oct 2019 16:00:44 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v4 7/8] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date:   Tue, 29 Oct 2019 16:00:41 +0530
Message-Id: <1572345042-101207-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(5660300002)(478600001)(76176011)(426003)(336012)(26005)(36386004)(186003)(36756003)(6666004)(356004)(47776003)(48376002)(305945005)(50466002)(2906002)(476003)(8936002)(51416003)(44832011)(2616005)(70586007)(70206006)(486006)(11346002)(50226002)(126002)(81166006)(446003)(81156014)(8676002)(4326008)(107886003)(16586007)(316002)(42186006)(6266002)(106002)(103686004)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4693;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e1c9031-35e8-4b3c-92be-08d75c5b18b6
X-MS-TrafficTypeDiagnostic: BYAPR02MB4693:
X-Microsoft-Antispam-PRVS: <BYAPR02MB46937B56635E6ED065D43FC1C1610@BYAPR02MB4693.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yQ/kCbOZOAZ/QUHKZw7JzYoV/x8/grMQvIQicmEzoECA5AoNjAWpFhWXo7ZlrfOnLvIGA2AOJ6w6OzBDsbq0ZEc35f1MMJ3WTMKT4YQ40Ctfb/39giY4LtgIMQqNf9Raa6SLMXeH+inuB11EgKtS1EN67HChF+P+wjbZssHOAeP1M3apU6HFfRsV087UeyhzUOeoDIe4f78HSv309fjmv5FlUI8kBSaKxhlVJ1ruELGtYYWKQn/0Z9b92tCYaQTsrSCT32ZAbZ+0yoYKgSmemKK4FLyYKYlZhOS4j8rXflFa+4QvTC+GgtgSY9OEm3WGcqxuKjgYI6HNQJqn+3RHlKOIJr2bOnF7sPxee3yX+Mu8CxzNzaupfhN4uo7/zZ7x7RBwIbPqlDKJJTGPPHf2ILWOZt2bH/HvIK9FZPTugV9EmX0azSGRngJZmdWXQVq
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 10:31:02.1461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1c9031-35e8-4b3c-92be-08d75c5b18b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4693
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
index c0f505b6cab5..22fba39b94c4 100644
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
@@ -63,6 +66,10 @@ Optional Properties:
   0 to 359 degrees. If not specified, driver will configure the default value
   defined for particular mode in it.
 
+  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
+    which the command and data lines are configured. If not specified, driver
+    will assume this as 0.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -99,6 +106,18 @@ Example:
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
+		arasan-clk-phase-sd-hs = <63>, <72>;
+	};
+
 	emmc: sdhci@ec700000 {
 		compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
 		reg = <0xec700000 0x300>;
-- 
2.17.1

