Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440AFC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1AE2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Xs+Wn37x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbfKGJEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:04:24 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:38689
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387659AbfKGJEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:04:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYizInECLV3LqEMdD2T2lTMTJKRpF75O4IO7OjGM97J6a5c87A7Xome/C7Gdzzn4Q94akbt6sGUk7HmUdVxjIYXySdbS+3wcv92fJSM7Hyz7l2VyLfDTV19YcSrZAH9Es1LmecT5+FPxUOvHgqSXSfnd2fDTNEvcImp/lQlj4i72tL9uF+s/CkRyODTnNaJ3Mw+4sHPW8QkA76tpX9pKQIdgIBapzvYWL35HPu3HFB+nqbQh30IfqNv8T/H/39s6RQbDZN/rPZ2ffXMX5tWa+X2IIOhzdNT6aw2Gb+5EEGLtfpaub3WqP5UaNtrd9D/nu+2RTnJiLY4vwKnjTObOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw4237nyp6fQxJJpCC/ruHnRC4ZONUAsQqlmaf6f9Oc=;
 b=j3Pd5/XEIVozp0lgm24vzDt/QStPsYMyPdB9pCyFQgQvsTPzwFMr6clIJvuIlhCyjWSK5lX/tplLhzGL8R8H9kodjXS4bXnEebJVIaF5ZhzPPIxSAaKDDwttonDvd9V3DfXFx0qiQkwvMlbF/BmTEt6/WyUlXGTIJ1hNyxpUUcQ3bu0AFF4lcCJjBFuOptaD6D10p4xC9Rlcpb1Jmm898+muVDUj50T6PFVoEsEBXlLyY9ewgsqbqg5pKc57937SYyLbITMo22lHjVDMuRAtPypyV8bE+oLHKXJn7KoqhfpfAZbBZbdNOGtFXmfbjN0Fp5xg6+ur4tN0C1zrphZNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=baylibre.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw4237nyp6fQxJJpCC/ruHnRC4ZONUAsQqlmaf6f9Oc=;
 b=Xs+Wn37xyK5/I7U6DSaAkiHLXRg61CRpU15LjZGVtK4fd2ce9KUzx60eu8yIrw/kzBVcw3U/UiZVTjZap9Z0LFBWIgFjyt8xcttgO3INjHwiiSh2dJP0wPbQyc6PfmSihPN/vlydWRWMfhZX7vBSZ3+TfCdv6LzHzOI2DN/0szg=
Received: from DM6PR02CA0121.namprd02.prod.outlook.com (2603:10b6:5:1b4::23)
 by BL0PR02MB3745.namprd02.prod.outlook.com (2603:10b6:207:43::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 09:04:21 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR02CA0121.outlook.office365.com
 (2603:10b6:5:1b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Thu, 7 Nov 2019 09:04:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Thu, 7 Nov 2019 09:04:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSdiF-0001FU-VP; Thu, 07 Nov 2019 01:04:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSdiA-0001Tz-SD; Thu, 07 Nov 2019 01:04:14 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iSdi7-0001Tr-HJ; Thu, 07 Nov 2019 01:04:11 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, dan.carpenter@oracle.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] clk: zynqmp: Extend driver for versal
Date:   Thu,  7 Nov 2019 01:03:49 -0800
Message-Id: <1573117429-9175-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(106002)(305945005)(316002)(44832011)(36386004)(478600001)(107886003)(16586007)(126002)(50226002)(426003)(9786002)(2616005)(356004)(486006)(8676002)(8936002)(6666004)(476003)(81156014)(81166006)(336012)(36756003)(4744005)(48376002)(70586007)(26005)(50466002)(186003)(14444005)(4326008)(5660300002)(2906002)(51416003)(47776003)(7696005)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3745;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5662f35-9c7c-4628-6643-08d763617a04
X-MS-TrafficTypeDiagnostic: BL0PR02MB3745:
X-Microsoft-Antispam-PRVS: <BL0PR02MB3745B6D39307E79BD86649BBB7780@BL0PR02MB3745.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kG46knZY61nOjGnJNEcF4BZbSlN28D5pwu1IuvjcQo7zovaq5hjO7r2EWa+2hOb/GYX/iQCfyjkC6KMYRcNC8B1tYUG0wnnVXCrFFI2+BFFD49TmiTrrca5NX+QPI6n14uh+Vgwiy16WVa1qKGUjdbCFMSrM0N6+yGAi3GYa5tR/5jEP5xDHgGm+WeoIU7vlsV6tjxPryva6NoTYu48LoFLxSZwk6PdW/20p1Wzq+X5iLoHDGsz6gKL+zZeXcSEzn0p5l1EPAgYFA1Y3Xmrk7bdKddiVfgyfF0PWtKZ86i/aN2bpjdDjNJXRzUNChc1n0UWU15BFApKG1BLJ5Fw9BAd9XoMsahScvcJOTArtFQW7THXenmoM70ENIw9mzq0YMKPe2gB5iyjncRh8mo4wuZk/o8nsPDvAXzDyJnmM8d/H2cdnvaJ+EgWWnbGhNt1H
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 09:04:20.4879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5662f35-9c7c-4628-6643-08d763617a04
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Versal compatible string to support Versal
binding.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index a11f93e..10e89f2 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -2,7 +2,7 @@
 /*
  * Zynq UltraScale+ MPSoC clock controller
  *
- *  Copyright (C) 2016-2018 Xilinx
+ *  Copyright (C) 2016-2019 Xilinx
  *
  * Based on drivers/clk/zynq/clkc.c
  */
@@ -749,6 +749,7 @@ static int zynqmp_clock_probe(struct platform_device *pdev)
 
 static const struct of_device_id zynqmp_clock_of_match[] = {
 	{.compatible = "xlnx,zynqmp-clk"},
+	{.compatible = "xlnx,versal-clk"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, zynqmp_clock_of_match);
-- 
2.7.4

