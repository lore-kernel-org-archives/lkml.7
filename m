Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E16CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0883120656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PI7bTcTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfKAGGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:06:18 -0400
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:9536
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729404AbfKAGGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYAOYckO8sl+ooAl2u4bn0CHyiPR26GRdWCj0pvD37zgwuE5Gk78GYUExobPVx9Vjc6kzl6K1jq7TSNC6CrHZBI0ZKj9AI9jlk7j6Qb1R9p0f1c6KuSrv204/FxaTtzj4WINkKegp42I8LwsJv8JABVgnuaGxh/4OrmZPAG1NPuSxHBmu4ITCgjtOZv+LcyxGR6BW/Rj4WAWpJU9nNF0OG6dsWnb9LoA6RdDGzZvuUEheM7RktePXBiW+bCaFVCWxuZmTf65Uyp0QMnpC0RX8O9sjNlGk2SnHQt5Akq62BOBYcC1UF87BC/c85inosDDkM3PieMT6j9mvczvYSq+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3geTXuV4lpN8m8W1d6uvc+nibMhYsrXL7CoPVOywXc=;
 b=VRM+iZd8Im9byI56Fo3ktHm9xr9mniIT7g4eCaHt3Pn1fNOSpnm3naHx9iQLzYaHpkmQBN4WJySO96LJkC3nrO+t2hirEo9C4OmQEIjMQ3sVqAS+cyUoLvnAaeRsVAJ6NsAbbatZzp4t5I0MoSBrxRCYEmssNWPJAC2bAA5/uW3X8iJQgkzxcqFfS9vsZMNVaZDIIBzJL3XfLepn1TVWhIQ5nOSwGs7GqoZdgRHtLqtMllEPo+Mvtwesd2NdXIAOZgD7qOd22/tbYK6yMEqW2oU3J9e5QFoXqpiBe8ixhPYT+WJHzh5XT70DGp2cZeajRmcKyK/rZQIkp9NKvh5gsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3geTXuV4lpN8m8W1d6uvc+nibMhYsrXL7CoPVOywXc=;
 b=PI7bTcTWZ13tZOqgvpiO/SaxOxLb0Oh8XlKYM2PJadaZDR5Lkg7ykyShQVLnLqGOPVP8locM9JfrevWGiAVmLXpgtlkxwcOExj+5L+fBGdTKLgX4yiC8cDNo2fPvjU4Bd5QKQFHET/0G45RPnFFYzs67sj2c0uOYLwfK1wJPWyg=
Received: from MWHPR02CA0003.namprd02.prod.outlook.com (2603:10b6:300:4b::13)
 by SN1PR02MB3807.namprd02.prod.outlook.com (2603:10b6:802:31::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Fri, 1 Nov
 2019 06:06:11 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR02CA0003.outlook.office365.com
 (2603:10b6:300:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 06:06:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 06:06:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4Y-0005me-Cf; Thu, 31 Oct 2019 23:06:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4T-0007dN-80; Thu, 31 Oct 2019 23:06:05 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA165w0t010449;
        Thu, 31 Oct 2019 23:05:58 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iQQ4L-0007Zx-Nr; Thu, 31 Oct 2019 23:05:58 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id F1175121385; Fri,  1 Nov 2019 11:35:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties for mmc
Date:   Fri,  1 Nov 2019 11:35:49 +0530
Message-Id: <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(426003)(4326008)(107886003)(5660300002)(11346002)(186003)(126002)(44832011)(2616005)(486006)(476003)(356004)(305945005)(6266002)(336012)(6666004)(446003)(70206006)(70586007)(81156014)(51416003)(478600001)(26005)(81166006)(76176011)(103686004)(106002)(316002)(16586007)(48376002)(47776003)(36756003)(2906002)(50226002)(42186006)(50466002)(36386004)(8936002)(8676002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3807;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dff954f7-f8e9-49d0-cd79-08d75e91980c
X-MS-TrafficTypeDiagnostic: SN1PR02MB3807:
X-Microsoft-Antispam-PRVS: <SN1PR02MB38074315E248422F91325C4FC1620@SN1PR02MB3807.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xrv/KS/zB81+SQjgET0Epr1lkvKD8nX6b5nl+k+lx0JIw+vndDF3WLlfXczqWycNCeaabbK6es6lHER+nmbY85whTzdAkUkcQar8BvamL8yVnJXuhJpPs2nBUJeNIbMKCp8MlsqJqUv4yHflXh6mlO/E0ixgwpRUgYLN/gj9HG9nDFs/Ng17DVYqtDYFUlWtX3Z3DmPPUr7oTlOSyNdbJWg+yAmV23FgaT/JvrnLcjRt7VN0G8KoI+PAsnZppREqSg4OjrRkiPCkseW3VxoGHlj3tYPtExL8ru4S7Tp+xrBRLyvEGV744YP0h+WWz5oZNWbHx6Cg2V95TpoVgcHGU7Ua6klQDDRjPzUL4wcdZQLgLrGvysTlmZWO4yqIS5UO4Mkpg1k3zn4BzyUOl9KX/1cdXkXnwrGF7dyZX1uy5zgdmz73TrpiT5wQJQ3+rMO9
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:06:10.8597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff954f7-f8e9-49d0-cd79-08d75e91980c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional properties for mmc hosts which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 080754e0ef35..87a83d966851 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -212,6 +212,98 @@ properties:
     description:
       eMMC HS400 enhanced strobe mode is supported
 
+  # Below mentioned are the clock (phase) delays which are to be configured
+  # in the controller while switching to particular speed mode. The range
+  # of values are 0 to 359 degrees.
+
+  clk-phase-legacy:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for Legacy Mode.
+
+  clk-phase-mmc-hs:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair degrees for MMC HS.
+
+  clk-phase-sd-hs:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SD HS.
+
+  clk-phase-uhs-sdr12:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR12.
+
+  clk-phase-uhs-sdr25:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR25.
+
+  clk-phase-uhs-sdr50:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR50.
+
+  clk-phase-uhs-sdr104:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SDR104.
+
+  clk-phase-uhs-ddr50:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for SD DDR50.
+
+  clk-phase-mmc-ddr52:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for MMC DDR52.
+
+  clk-phase-mmc-hs200:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for MMC HS200.
+
+  clk-phase-mmc-hs400:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 359
+    description:
+      Input/Output Clock Delay pair in degrees for MMC HS400.
+
   dsr:
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.17.1

