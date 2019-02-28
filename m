Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB7CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF669218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="n+nMizrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbfB1HCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:02:13 -0500
Received: from mail-eopbgr700068.outbound.protection.outlook.com ([40.107.70.68]:11269
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725967AbfB1HCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3HKWjiyL7HY3l08z7yuz0J4xAq05627uqB7ge+BEm8=;
 b=n+nMizrYcD1tDr/l0b+hIUApIwgAvl6CXqqvMrYSzmoDrE2Edv+3Dr3DQTrBODFLndWsqqpKljQ3TX9Bs4yzbn5ZZHauusL0Dbxc8uawpH2darxn4BFU7nJn5Ez9Lh/LHvrKM0o6gY3PzGDGC0dpp5thA6WqQCwci/GXLIYtrAY=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by DM6PR02MB4524.namprd02.prod.outlook.com
 (2603:10b6:5:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16; Thu, 28 Feb
 2019 07:02:10 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Thu, 28 Feb 2019 07:02:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 28 Feb 2019 07:02:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gzFhp-0002Em-31; Wed, 27 Feb 2019 23:02:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gzFhj-0004ra-VF; Wed, 27 Feb 2019 23:02:04 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gzFhe-0004nm-NP; Wed, 27 Feb 2019 23:01:59 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <robh+dt@kernel.org>
CC:     <michal.simek@xilinx.com>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <horms+renesas@verge.net.au>, <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [RFC PATCH 1/2] dt-bindings: spi: Add device tree binding documentation for Zynq QSPI controller
Date:   Thu, 28 Feb 2019 12:31:53 +0530
Message-ID: <1551337313-9499-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(5660300002)(63266004)(4326008)(478600001)(107886003)(7696005)(9786002)(106002)(36756003)(476003)(486006)(126002)(2616005)(50466002)(305945005)(48376002)(2351001)(7416002)(106466001)(316002)(50226002)(426003)(47776003)(16586007)(186003)(2906002)(356004)(6666004)(54906003)(8676002)(26005)(77096007)(336012)(8936002)(36386004)(51416003)(81156014)(81166006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4524;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539d2c94-f0e0-40db-8908-08d69d4aa87a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB4524;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4524:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4524;20:idHq1jRj3I1UiHoaFk3izIYpBqSTL1dz1P+47RU4xRmPzctQnZBEopNxPr/Obdib9b5cPBvKoYPscIDDWaTZZKJMzLchJSORxjo0oSlpSCJbqV6btF/kbQxFEIbN5HE3uu43pIeioYj0FDEZ0Op6RK6GYf44NYbMmt6Fd4FKLHDjJrppRWgszfN7RbCJSYnOzqp6BJMbrrL2GrRpEsySVtiOlRovj9P+4Fw4IoER1/5kp/btv1NzvKN5SHVD0oXG0WM8HKayjEY5iMF/pGnDzCc8tqsX7Kv7nscBepVfNipVctUJMs7sJpor+mvhhLWLs5/U2TlWzLQcr5J49Wprh5TOfrcb3pfQ3Zhcsbuo5EiKKS4dxo+1MZwIjdmsI/SS1VfF5e5pOSKdISxiN5M5WbhNXVNia2riLffLp2uXJ36IF5dOUUYbWdT2hX8NpUFtYhi58agl6d+R8WIHBbXLJXyvBfZSHLiMi6Xufokvn3ljInMR5gFijZaH8ddaynKx
X-Microsoft-Antispam-PRVS: <DM6PR02MB4524FD1D7195532D097E63D6AF750@DM6PR02MB4524.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0962D394D2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4524;23:7WCPswMdvz7egv3CUSpHzK43HfBZt4HhQ1NjoTkTF?=
 =?us-ascii?Q?WBX3PrZx2gpzvoYfl47/aruDJZWzs9LQDItjGLRAgj1THIRB5AgazAV+39vD?=
 =?us-ascii?Q?nLeGQatD1OQhBDG9cYu89ga07j6OLpBgkAYU4Zdf6WmYeVmbeIvye9A/g2Hu?=
 =?us-ascii?Q?lQUQNmpI/+m/6nmm6kBX7loQQC6joWtlzZTHX6eFuqDcYQUxyDlNPdFSrdee?=
 =?us-ascii?Q?4qfcvdwIGNmkh0A9whjSWOfRBZvKABxJAx//RUfQLzOe2E14SZxDXylVO92Z?=
 =?us-ascii?Q?eSQpZu1H0qxTalSXH46BSseColNyrJDwMCWfreG57oWHDFpyjT76B9UlxSSY?=
 =?us-ascii?Q?7VDpWhg9eDHgZ+SJ6rW4iwK8+UKwupMtWd9Z4ELWArPpLsGzYFPEQwgDZAGc?=
 =?us-ascii?Q?s7SbiZsP9DhxvZennXIVif4aGiy7Fbcnpzje8z6fEAKMJzpuWxA2diIc4ZuT?=
 =?us-ascii?Q?TODx12pngs5OEPPDkGMqP2AakYRZ1P0juggPBc3V8/sQ+1OsQTrm41UT5sjv?=
 =?us-ascii?Q?NVU8h6rLgurv+WPY84UCL0NXh1yS5iTYtlXCdoGbC/S928coApLWCcWZw9c1?=
 =?us-ascii?Q?u23vrVM4Z3TYrzBL9Wo2XAv3lwE7MLeM8KlTy5m21e6x0b2Ib01411HtRbrf?=
 =?us-ascii?Q?8frOGPxcO+4I/ZkakuBYw5vHvcrj/WoZZ59Dl6NVtUKuNbSw0Pun6PGDS1wc?=
 =?us-ascii?Q?d8K1pPfi/+XV6KsoDabOSO8kEVhqEp+nboCCQt2j0lFOMpEExSBJRgJ+SYCv?=
 =?us-ascii?Q?sMqDEUHXIGRC0We+vF3+5zJ7TU4F+qsfFXSe/If94F7GI2Y0S7XsmlVKBU3j?=
 =?us-ascii?Q?tpIzfD4+i27pdS+4WJX8BEgSfH3sG2zwtltJY7DtRbvVRrrkCrhC9trn7XTw?=
 =?us-ascii?Q?a5VQJJf4xYCq770x0ZZDYQt6XZLFaCmn7R5+FCEdSNMMo4tia4WFT72MoHdQ?=
 =?us-ascii?Q?XUtFMh0VFsbVbVnzPKI0IV+u5N4NVwp/ofvEWqzYkwidBP3Wek+rNvRunPvh?=
 =?us-ascii?Q?lYJKoZ5zurC+DU8Dl9YJkGKWiqpxs2pT+uYdn0gdR7/l9QWu8tHkAch/zjFU?=
 =?us-ascii?Q?oJZiNU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ng0mCUQLqnzPz7npiuPCTim+n/e7Gg1EsCASKavzvUY+lB15mB4xaBlx2Q/7A0+ipSqqUB8tOj0sYLdqlIH0pe92oKd9B97cUNWrMeW7pV1YygI5j11AwmTwF33GGeDVDgk4xjH5mGyPQsZWi4MftXW2eQHHCKrjywvamOcvsyz2z7plSfUVzzqp7HircKdMhlkd0HMAlMPvn9RU9zvbPCXu8IVggmPr6ELDxZ4MGBUhKwMqnzPrqr/73hPG0YoFAi0uy3i93Cvl3NAVBqLEqFXOvfJQRu1TxIDuvisdGTuak9ppYRnOLiuD+MgCMny69xPEHC/ce0yQBroSLOiwDh47w7/xK7A7s9srvHnq6oEaiKw6ioVagltQfrihoUQSzrn9nsj0/0UuTJIdGhQvXvsjJLrg66KMDn59S3JJCg4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2019 07:02:09.5244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539d2c94-f0e0-40db-8908-08d69d4aa87a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4524
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dts binding document for Zynq SOC QSPI
controller.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
 .../devicetree/bindings/spi/spi-zynq-qspi.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
new file mode 100644
index 0000000..16b734a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
@@ -0,0 +1,25 @@
+Xilinx Zynq QSPI controller Device Tree Bindings
+-------------------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynq-qspi-1.0".
+- reg			: Physical base address and size of QSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi: spi@e000d000 {
+		compatible = "xlnx,zynq-qspi-1.0";
+		reg = <0xe000d000 0x1000>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 19 4>;
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clkc 10>, <&clkc 43>;
+		num-cs = <1>;
+	};
-- 
2.7.4

