Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BDD20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="S914k7OE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKLNRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:17:16 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:21050
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfKLNRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+8oO8iNbI462fwEIJ8+DV8J19yRbAJq4FFYxRf5Z/19xZRlzU0lTqGqjJLxl7ScXm3igjvmJcJjhYE3VSCBpEdDk4sg6+klPiC9ugHLVxIbpzMZ86qqRvrrH7t0Xgxe2yQIZUIo26Zyt4SAFz4yDK/E9uURmbjgPofn+3c32QN1sd0q9WzFqVylDRNdFmLRgQFvvZUqDbZRsOI6gCbV1jr0A6pcjVfLHIUaYX9824n92NuHyUUIqjVVOJppBR/sLbgvagXEupUGOEbzWPxnQgWH6XwF47htNYM7Kr5LnpVcpQub1qanWSygSrOU3Xk26E4zcfDDsk8P5WXyhv9z6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjJQF/rMyDwnWAHZ2OgcVJxIiRzJIybjry1lY+4QTFg=;
 b=oZGj6wMQVtqHqcbDWyQminzN4BFMXN913ofJj7KXm90kt6FGMWdcSyXDZE28REc1eM48t/6MLT4oW7fUEqwQMjpf1/Yi4DMv2kEdkAErw8QoCZnQOrkOCn2iiaXPT29WGrsOSYxU/Qd/lrSwaUjVox42zDw1Q6BTmTWTE60vUJ4ZvE7dNLNLBIrLIdvbwsBbFZxOQE4KUXAe685kRYoRKL0uQPOhECl8S8nnjPJrPE5jGwaM7ItcV/WsZLdvvlYG4blNDBevJeJ8au4ICM5AxzxG0eoVcNP1P0pLh/XJJr3ySpFGXxcHSSaGK81JMekGwBc2pHLZihs/PhK7c31cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjJQF/rMyDwnWAHZ2OgcVJxIiRzJIybjry1lY+4QTFg=;
 b=S914k7OEWIEWTmq7re1aJuuXlNr21nHvUxcyIDxoNMRpjweIj89qqeGcnlDFd/5bGAvBXRBq11WcSnHm5DUz4WyHCwDOfh+Cryxw1KsS7myBtP5Vdj1t+PeSnCm/jHY6gyu4fD6r0u0kJMpKdNOroSNhDLqSWEgcmhg+rxPtigE=
Received: from DM6PR02CA0136.namprd02.prod.outlook.com (2603:10b6:5:1b4::38)
 by BYAPR02MB5573.namprd02.prod.outlook.com (2603:10b6:a03:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Tue, 12 Nov
 2019 13:17:10 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (104.47.37.51) by DM6PR02CA0136.outlook.office365.com (20.179.165.166) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 12 Nov 2019 13:17:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:17:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2f-0003sh-8x; Tue, 12 Nov 2019 05:17:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2a-0004GJ-50; Tue, 12 Nov 2019 05:17:04 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDGwuU022459;
        Tue, 12 Nov 2019 05:16:58 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2U-0004Ds-9C; Tue, 12 Nov 2019 05:16:58 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, jolly.shah@xilinx.com,
        dan.carpenter@oracle.com, gustavo@embeddedor.com,
        tejas.patel@xilinx.com, nava.manne@xilinx.com,
        ravi.patel@xilinx.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH 0/7] clk: zynqmp: Extend and fix zynqmp clock driver
Date:   Tue, 12 Nov 2019 05:16:13 -0800
Message-Id: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(486006)(16586007)(9786002)(478600001)(44832011)(2906002)(36756003)(316002)(47776003)(36386004)(7416002)(4326008)(305945005)(6666004)(356004)(6636002)(107886003)(426003)(26005)(48376002)(50466002)(7696005)(51416003)(5660300002)(336012)(50226002)(70206006)(8676002)(186003)(81156014)(2616005)(476003)(126002)(8936002)(70586007)(106002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5573;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e9ad11-5642-427a-fbd7-08d767729faa
X-MS-TrafficTypeDiagnostic: BYAPR02MB5573:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5573B0C7E95FC4BEE982EAB3B7770@BYAPR02MB5573.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vs/ZzYRbnKavYMDBnB7ZntKM6Re4Xnpxm1Ar0w6ILmX6BYR8A4++lrCxKWVm7FYuKWoseSuDgbwEJ5aWxNhYMj3pWcVCFOPS/qr4sUbksADkt8NFiQmcy3O588kNqtyVtAeAEu+kWAw0UB41y4Eqe8fWTnEVtkPkVKuLzBdyskYHRVpW+MvYngnOIJnv0f9sNkDLLbFOL5nuuGDgprsXIo3fp8NZF0IB1SliktcRTS6afs1HQPTgx+j9uGFlZ7gVvMqObP2G1sBbBVEQ5yBelyxsK8nS71PPZ0YHcoJ/GY6kxEoxeV/KOFsZ2tZOZS9ihnEIcPbMoU25IHtWd6OAuBtaAe9T+a7IfHzPzl2j6AcIwBr3DFXWjXNZWg9I0NbpBw/U5gc7sP0sA886aLjrja6kJOpFmlre7mLJgYCdM39TT8124cMp4PpOpS4ceUu+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:17:09.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e9ad11-5642-427a-fbd7-08d767729faa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP clock driver can be used for Versal platform also. Add support
for Versal platform in ZynqMP clock driver.

Also this patch series fixes divider calculation, fractional clock
check and adds support for get maximum divider, clock with
CLK_DIVIDER_POWER_OF_TWO flag and warn user if clock users are more
than allowed.

Rajan Vaja (6):
  dt-bindings: clock: Add bindings for versal clock driver
  clk: zynqmp: Extend driver for versal
  clk: zynqmp: Warn user if clock user are more than allowed
  clk: zynqmp: Add support for get max divider
  clk: zynqmp: Fix divider calculation
  clk: zynqmp: Fix fractional clock check

Tejas Patel (1):
  clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag

 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |  67 +++++++++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |   1 +
 drivers/clk/zynqmp/clkc.c                          |   7 +-
 drivers/clk/zynqmp/divider.c                       | 108 ++++++++++++++++--
 drivers/clk/zynqmp/pll.c                           |   9 +-
 drivers/firmware/xilinx/zynqmp.c                   |   2 +
 include/dt-bindings/clock/xlnx-versal-clk.h        | 123 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |   2 +
 8 files changed, 306 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
 create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h

-- 
2.7.4

