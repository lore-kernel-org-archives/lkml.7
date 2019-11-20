Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22901C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B6B2245D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Pnxi1hMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfKTGse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:48:34 -0500
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:64416
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbfKTGsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:48:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKzlk3ccR/peHoLz6gW2gfC7yqBErm/lp5jZh0BM27AWq72weAyiuOAp1yajbYLGct+hqzeDuAzZt+j5T0n6beUo+tbM05trYcb69r7fFWZI4DN3oVzaIt+NMFhmnubms3HoAeGXC7MEr80oOUfb3LPsxzsQatPoLPy3cC053Un1QX6PBjH8fmgV+PFXJNnjlPdc31R6HTjDVWy5yv2bFRJvAkxpLm0VaCYb5QgYrF5iI083g43ua238uTiD5MyY+7gNldKCDsccOHj/WACJMCyj1b6eFs/lTuB+kZ8J2aNEQwA1Z5xLXQbYnDDAhRx9XNJVZuSYSMseYH+vucQysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDLegMrhDggUgyFbZeHP6TBfYFHxtOMb3XgoN+5eRL0=;
 b=HTRGdQELXnJm+kbuhQcfOGsKRP+0kObuOy/jDzTLH4LcwbHkY3mlaQBQXlZ3x+VpIVhUWRg2VF/0Bk54IWVeVRpMfB/GkshX4nXR2o6hjcF4QMOzMdOxmv9/+S9l5To+rMhCHPN6pLE8myAmD48JViL5LB0v3WLKmATKSNL8RBpS7Ov1q5kcx4f6EI6+dgrHRLdzIZtho2XoVylCMHHGgGLzdEd+MNdTkb7n9jXAbIJp0jkydhw5SqGq3lLp8oxOM0Q7K48D0ous6sKiFGnEfY87DGTdOC2ZeZcYTl1iIaVdXHVgFqaRHZeNYaEcdNxvTFhuxDtaE2o95sKd7PWfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDLegMrhDggUgyFbZeHP6TBfYFHxtOMb3XgoN+5eRL0=;
 b=Pnxi1hMSvCajZoYlWzgS2Xa0lLkSOA3qy9b0Pi2xQDKvK/BdKr00HKCHrQFnPNCTvkMt8NjQao6mA5rk5cS/hH/sWJFK+/NoNwr/6huFmcObVrkzGf8z5IXa/SU/E1grHayUGRLR9GIJi2/3pP9hF6NOMX+Gj23N9K7ofxGG3N8=
Received: from BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15)
 by BN6PR02MB2802.namprd02.prod.outlook.com (2603:10b6:404:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.28; Wed, 20 Nov
 2019 06:47:48 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0074.outlook.office365.com
 (2603:10b6:208:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Wed, 20 Nov 2019 06:47:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 20 Nov 2019 06:47:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmF-000619-Lb; Tue, 19 Nov 2019 22:47:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmA-00049o-I9; Tue, 19 Nov 2019 22:47:42 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAK6lbBg001807;
        Tue, 19 Nov 2019 22:47:38 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iXJm5-00049G-Mr; Tue, 19 Nov 2019 22:47:37 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0170D12139A; Wed, 20 Nov 2019 12:17:35 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v6 7/8] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date:   Wed, 20 Nov 2019 12:17:28 +0530
Message-Id: <1574232449-13570-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(36386004)(48376002)(47776003)(476003)(50466002)(6266002)(107886003)(2616005)(6666004)(356004)(446003)(426003)(11346002)(336012)(106002)(70206006)(26005)(8676002)(50226002)(186003)(70586007)(51416003)(81156014)(81166006)(76176011)(8936002)(2906002)(478600001)(305945005)(5660300002)(126002)(316002)(4326008)(44832011)(486006)(16586007)(103686004)(36756003)(42186006)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2802;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9224fe54-a85d-4d7e-6444-08d76d858e5f
X-MS-TrafficTypeDiagnostic: BN6PR02MB2802:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2802FF75FD5C7CCC5221987CC14F0@BN6PR02MB2802.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSESfp3vp4nwXOBXS4w1zRkWtsJFVUGmEV67VioL8BnowVufoRP/8/KmuH2TG2bS6n10pCGJP2KopHVNLUXfIlQOzWz9RSvXL+g6PJVNV+WlgIgaBBh04RitdVworiLC0rHstwaT6yS88hU1ip4Y8czxVlsVPe4b870CZN3SdMkfOJREThuEscKZ640rJmn7oIw2kGZg0b+O7LLeVknD0DfpRqUABXYWR82B7KVifzDmPfOKLzscz8feaYqDOBfNuDjBX/bkcciQFJnjBrcdJoGl2BbbG7j2cwfI3l9YjP5g42TrkEvV3UweDVSleQfQdsFqfGE9l2Ipwwg1ThLo7eHDz6P68FFxQYdUi0zVZNPUCW6gvhx9nFBesXsEpq6So16hvEHUH3l7YQJf8UkguRFFsQjGl7vTuTNrkg2JHMoxPDb5haCDM4cO+Ep1hgcz
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:48.1617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9224fe54-a85d-4d7e-6444-08d76d858e5f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and optional
properties followed by example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index b51e40b2e0c5..5ad804a870e4 100644
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
@@ -47,6 +50,10 @@ Optional Properties:
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
 
+  - xlnx,mio-bank: When specified, this will indicate the MIO bank number in
+    which the command and data lines are configured. If not specified, driver
+    will assume this as 0.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
@@ -83,6 +90,18 @@ Example:
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

