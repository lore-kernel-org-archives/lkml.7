Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51895208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dBs3EBH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfKAGGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:06:43 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:1248
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727995AbfKAGGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuIm2PJ5eOBtK/48pzdxu+IkETmQ2VVd9NJbkJJ+VNzZoHsp2ZYd3Kz0GjPbGTtRnDeOMZ2PMIG0GhHYdASnOqtsuZrevxYQ8KLYDatyLFamVJDVNlXZBzejmBeRxiVz3gHzHepF8A0wDfTDOJX5+LQk2rHxg/CkusszOhz5jubKzakSCiHEBhOo4s5YTTnfrXZ8HRVTTJvuOK2J4g06ySkDqHM/k2sJR21cR1rckCAhrwzPPg/A+uG7Z0tkmp8ewndwYpEdLuIDilJmmgSxPcts7fF7QD6eOotYX3Wj7BD/iiYcQui4Swt9MaMWc3kuoHh/+eZRzfHN0zQ7SjkSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxkGV6M9kRxWtnGv4KOURERUHVjiwzQj1EsmmBg3bRk=;
 b=dThYEN5uWfZrP7YuXl/0G37iCo85ypKoM4aPj36dRqnGsrL6hmUjpVTnTvBGMQZWm7f9rRZU7+DJw1app/8Xb7crjclK+d+02/dUWnZz5WqIIfpNz0v58VCEqVTlnZzJCGHN3FR1vvAO7Mlp7GDucZfU089/CJJCkhH6Hrb2fENi8IKzRLZH9tt+h8k0+D95QeypUboT7QVLVNUG2uTVKench90++oABlN8uC9OsZ2RdcKyYVg+HZWkchc/CXX36HQ/KDTYIrDLOaIQDgCDyTzKq2vUoiONjypZc0kp7mqbyrRmxj0HPDNq995HLXEFTccCTW6HOTH1SLIZQ/0L2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxkGV6M9kRxWtnGv4KOURERUHVjiwzQj1EsmmBg3bRk=;
 b=dBs3EBH+BSCuejz8SJWsWvBQ/VSFsWRI1Zv/91fT2t7gZijzKidXg7qrANyc1Gpbie5Cxrmwyfy/k1FAyK7KE3nmF0kgJXwSP3rvfj/onkL2Yx7jvOpDmT48Ib1ikBz56lv2/VaxrvA5n0+MT7x+f72md9sFBAfax14JvNZZqA8=
Received: from BN7PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:20::14)
 by BY5PR02MB6019.namprd02.prod.outlook.com (2603:10b6:a03:1b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.18; Fri, 1 Nov
 2019 06:06:11 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN7PR02CA0001.outlook.office365.com
 (2603:10b6:408:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 06:06:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Fri, 1 Nov 2019 06:06:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4X-0005mN-2C; Thu, 31 Oct 2019 23:06:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4R-0007dN-UR; Thu, 31 Oct 2019 23:06:03 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA165xts010455;
        Thu, 31 Oct 2019 23:05:59 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iQQ4M-0007aN-Pn; Thu, 31 Oct 2019 23:05:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0DC00121388; Fri,  1 Nov 2019 11:35:57 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v5 7/8] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date:   Fri,  1 Nov 2019 11:35:52 +0530
Message-Id: <1572588353-110682-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(2906002)(51416003)(70586007)(36756003)(36386004)(70206006)(76176011)(26005)(186003)(356004)(44832011)(2616005)(106002)(305945005)(336012)(426003)(50226002)(8936002)(446003)(11346002)(5660300002)(6666004)(47776003)(478600001)(6266002)(103686004)(486006)(81166006)(4326008)(16586007)(476003)(48376002)(81156014)(107886003)(126002)(8676002)(42186006)(50466002)(316002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6019;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd5df4d9-2901-44bc-ddcb-08d75e91974c
X-MS-TrafficTypeDiagnostic: BY5PR02MB6019:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6019B4095451A781E86767BCC1620@BY5PR02MB6019.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xn+9IiKDvliIxDF/t7s/fO2AhvCnePY3nEmitoN1IGxF5WrWjgDC2McIbzq/es5MWVgyCYum1BQS5u6LtTCyLhFRPRay9tm/WzBLrrHyTHQJIRRmXo2KQtwqANC+8BEXGTqggCcYVFBTQqXG2jUlm/5ebrtHOMfGo+A09HGuNpCdiwlD6Wt8PdKppc5xH7bNIOEK999qvyfGnw1FKl070wkbsnXM486J2ng/n8789KmrBBsnEwCHCQIjzMnJWC1cnScZYGAdDYQxHug5f/1SNLSWtTwe6XLPBJYatYZUim30iLmnSgviCN2+7BIAhEoaW5ITrjS1Qz37p644nJgZeoZBxjE2BJVGlHDZHo34IMx7xF4BvtNQdODYFNNkMIFIxRjI46PCbUm94GwlclEnK4H3UbCkyr4muR/ncUW340Vrtce+vYaWRZklEySqG5/+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:06:09.6489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5df4d9-2901-44bc-ddcb-08d75e91974c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6019
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
index b51e40b2e0c5..6f28e9d612d9 100644
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
+		arasan-clk-phase-sd-hs = <63>, <72>;
+	};
+
 	emmc: sdhci@ec700000 {
 		compatible = "intel,lgm-sdhci-5.1-emmc", "arasan,sdhci-5.1";
 		reg = <0xec700000 0x300>;
-- 
2.17.1

