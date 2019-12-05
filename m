Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD583C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B9724249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XtbWNw7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfLEGh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:37:56 -0500
Received: from mail-eopbgr680074.outbound.protection.outlook.com ([40.107.68.74]:2267
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbfLEGhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:37:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVk1kCycfYPkLbfNWkT4UdIhWBW3pdBKyaMnWgcFqtvxJBBRXmZPB6esP8fBjEVB+k3fYTAf0zGK0VRu+zCuuILM0pqodpvBasrnKdQDbeKshv/fhLoIdtYPBeWGfCnoThD4AE4hH7WYr0emguVYDSRPyuKj75iQg22fkAg6tGoL6E0BKW+/O1Fgf3GrPVMxDi78QagWs1dPYU7zU/E6TYMQxc0TtJ5wD/cQACV60sstGCYtTlRNOWPkA9vRLHVyhcoUlE/gmEvStUyFUDB4x8xK1PLIr6oQl6lX3egW4XejjhN8M3lXMTEB0vQkNJKy3zERGm0JyRjj9UCtIKnksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33LS+ZyloUssHMLNiVKIi6pfKqJm0s1OswnsyX5QmCY=;
 b=kwxhVZfxMESCN1b2sRR0PKUNNkomisw9kJgmbvdBuX3xsP8uEpoKK5+S/ss8TAV3NnczgCqdOJgZU9ky1ib2xKddprdkghqQscaYcLZMqR72ZsT9plOGRQErqX22Omcm8oZd+zqe6cGbPoefthn8XUKZGkfxx9DtFi5HBrnyRl2zSV8wDVPmekdA0S9RTTErM51rjqesnm8CWe1newjAQnvIwvG4PpcsIMrCO/P+PTgwU/OVanMZZG87QkOAMxG1tCW0UzYPN7jemCKMrSa7EgVCkzUT2mtRGt5vjhcdbXhXJevGlq2cEW/gqqtydbAP3rynv1GpMb5qDRb60g8h3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33LS+ZyloUssHMLNiVKIi6pfKqJm0s1OswnsyX5QmCY=;
 b=XtbWNw7PeC8HngHNHgxnqby5z51/+Pw3X/tfyDDhA6R0RCaVdtbvWzHybwtsAK7tD/O7KudJHqTxV0ewYJx64Lh14wTGXc3cG2eIPc0EX4DoD9YgLARPQ/KiuIEPAg/2K2APtMpgtRPVgdQHlBczfe3s/PmIpVESLosjdpna7jc=
Received: from BL0PR02CA0130.namprd02.prod.outlook.com (2603:10b6:208:35::35)
 by BN7PR02MB4978.namprd02.prod.outlook.com (2603:10b6:408:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Thu, 5 Dec
 2019 06:37:36 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BL0PR02CA0130.outlook.office365.com
 (2603:10b6:208:35::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Thu, 5 Dec 2019 06:37:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 5 Dec 2019 06:37:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklb-0000xN-1u; Wed, 04 Dec 2019 22:37:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklV-0000XV-Un; Wed, 04 Dec 2019 22:37:29 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB56bJdw010325;
        Wed, 4 Dec 2019 22:37:19 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklL-0000WL-Mg; Wed, 04 Dec 2019 22:37:19 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 0/6] clk: zynqmp: Extend and fix zynqmp clock driver
Date:   Wed,  4 Dec 2019 22:35:53 -0800
Message-Id: <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(4326008)(5660300002)(16586007)(50466002)(7696005)(81166006)(316002)(336012)(8676002)(48376002)(9786002)(107886003)(76176011)(356004)(51416003)(6666004)(81156014)(11346002)(305945005)(478600001)(14444005)(50226002)(8936002)(26005)(36756003)(7416002)(426003)(186003)(2616005)(2906002)(70206006)(44832011)(70586007)(36386004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4978;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 008fa6ff-3627-4751-bf7b-08d7794d9e10
X-MS-TrafficTypeDiagnostic: BN7PR02MB4978:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4978A89B46C8FDFAF7DF1354B75C0@BN7PR02MB4978.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GixZawCC27bTcGF15s5shn5D7og2KQf6FBLpMwvLopd7E2MG1Bkm6XHqwa323sQe1kdWialSpvRtL5OeMXjtBEp3UKHSmqahn+ToANwUG9KR0zPyzxBta+IQEeWA82FQ99ZY3Pd4thmlSZyMN8iQGlOhe0D/1CVg3alGrDRN5rGcK6axvw1efNK2CThYkGWBOZW7eVlilo2PZDYyZgtJ+uf8nt8fXq0P3nV7vFJpzQTwtrWXsPqIAGyDcq+SqWKl69Ucezk5VZOXtnOvMHzEldRW/WhNYUhw4VghvJ4/xwxUE7p0LEOwqGZEAV5FcPDXp78dHPHvQIK9bVR/pifG68w3FFE6wb5edzR5pdg3KUnJ2Y2e9a8jdGBDZ5qTWh7PJr51K+3afDsKSNkiFwrWZM9Wd5yd836VG+CYSWBMcD+saytjXHTq3E9jBCBLz6W2y+H2jqv6oauq74Wb4OBFAwdjqU4MmoXlI5DBNOKTjM+XtsVTMpQzIOWDAG7Mc2s2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 06:37:36.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008fa6ff-3627-4751-bf7b-08d7794d9e10
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4978
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP clock driver can be used for Versal platform also. Add support
for Versal platform in ZynqMP clock driver.

Also this patch series fixes divider calculation and adds support for get
maximum divider, clock with CLK_DIVIDER_POWER_OF_TWO flag and warn user if
clock users are more than allowed.

Rajan Vaja (5):
  dt-bindings: clock: Add bindings for versal clock driver
  clk: zynqmp: Extend driver for versal
  clk: zynqmp: Warn user if clock user are more than allowed
  clk: zynqmp: Add support for get max divider
  clk: zynqmp: Fix divider calculation

Tejas Patel (1):
  clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag

 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |  64 +++++++++++
 drivers/clk/zynqmp/clkc.c                          |   3 +-
 drivers/clk/zynqmp/divider.c                       | 118 +++++++++++++++++++-
 drivers/clk/zynqmp/pll.c                           |   6 +-
 drivers/firmware/xilinx/zynqmp.c                   |   2 +
 include/dt-bindings/clock/xlnx-versal-clk.h        | 123 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |   2 +
 7 files changed, 310 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
 create mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h

-- 
Changes in v3:
 - [PATCH 1/7]: Update SPDX-License-Identifier.
Changes in v2:
 - [PATCH 7/7]: Removed patch #7 to fix clock frac to handle backward
		compatibility. Will send this patch separately with
		proper backward compatibility handling.
 - Rest of the changes are mentioned in individual patches.
-- 
2.7.4

