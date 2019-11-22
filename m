Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42392C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11520715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pmzvuXlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKVJpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:45:41 -0500
Received: from mail-eopbgr800082.outbound.protection.outlook.com ([40.107.80.82]:43088
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbfKVJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:45:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FILBKrJTFd1//TnIq65HYfj25Zr5oAxvzru38rJX5ES/p6TQQEQ3ptGmp+qW0u9ll5hMpOQnc86RSbnOGbyGy+3Zrda4q58R3+lMHE7MxettLDSIL8U395qrusIsgQ+Vf+7bi2Ze8pnaqXMTBR/XQoqWRVhUxmC/OdvMepS2/cWMh6FE4UGRdxpOdX7/UBep9LSLjGOVfkIcs8Me5IkbqlFIMDHzkqKNq4eKImWks2jya08ktqrXZy/bIGVTwNhpVD9uE8+BgVONYEyPmb5I3P9kihCkvVUBKoVdoLnnWaq5PeGLXeoAI6K+VXypR6jbaHQK+lpcySaci6tVHf8AvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CHQI/shtHh7y7xVKO9wv5ZGzwFahyHkg96iYSppKM=;
 b=JCxYmAaE/WCK2+8Az71SOXEY1jHS+GsD0Zb+hwk68Fq7pgXuVzDpqfVDpPC5UOwkFchkB2k/8EFICJvNbYSqx1vcgssmuml8oRXkDcN0ZYk3X2B1DsEDODnBgmihMPMPQhNtIG4K7ZilePGyxtZ0+IgQ9fNSI/UPoCryFveVjithaLnLz6JuSM5aq7YqbNrLiYkM1gkIa4hBhSVQboVPm7jO4DKoZPSlGp7xWdab8+6GManny/pMa1j+5CTX/sunX1OCXaQ26Wo5DgbgeNW1/A6oWabM19piQKLJQ8bCPLtByYFDRXG8i05flbCVeFzPzgg+QaBiy/8QRn3g6LRT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CHQI/shtHh7y7xVKO9wv5ZGzwFahyHkg96iYSppKM=;
 b=pmzvuXlMY1hE0qbminQtlBylIFmoaxlFNVEnDHWD+s0ZWsivsieAsjgnNJpJ9c/shqAgvs+/jNHb+Exa5hNkogWSvhAJm7cHN7n7DGW9yHqC6SCsUHVlvZRSkxmcYnrtZ3c5ZFqJSo2VNB2vsWnuNGwaap9Yr2BQcevTPHoukGE=
Received: from BYAPR02CA0072.namprd02.prod.outlook.com (2603:10b6:a03:54::49)
 by DM6PR02MB6874.namprd02.prod.outlook.com (2603:10b6:5:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Fri, 22 Nov
 2019 09:45:35 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BYAPR02CA0072.outlook.office365.com
 (2603:10b6:a03:54::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19 via Frontend
 Transport; Fri, 22 Nov 2019 09:45:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 09:45:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VO-0008SK-CX; Fri, 22 Nov 2019 01:45:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VJ-0002pC-AJ; Fri, 22 Nov 2019 01:45:29 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAM9jLTD003469;
        Fri, 22 Nov 2019 01:45:21 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VB-0002ob-Hu; Fri, 22 Nov 2019 01:45:21 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, dan.carpenter@oracle.com,
        tejas.patel@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v2 2/6] clk: zynqmp: Extend driver for versal
Date:   Fri, 22 Nov 2019 01:43:30 -0800
Message-Id: <1574415814-19797-3-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
 <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(186003)(44832011)(446003)(426003)(11346002)(4744005)(2616005)(336012)(36756003)(14444005)(5660300002)(36386004)(478600001)(76176011)(26005)(305945005)(70206006)(51416003)(70586007)(7416002)(9786002)(4326008)(50226002)(8936002)(106002)(7696005)(16586007)(316002)(8676002)(107886003)(50466002)(6666004)(2906002)(81156014)(356004)(47776003)(48376002)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6874;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845a9695-add7-4ad0-ae95-08d76f30b902
X-MS-TrafficTypeDiagnostic: DM6PR02MB6874:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6874B326CCE772BB6B777D27B7490@DM6PR02MB6874.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaG86OR89GYz2SMynOQPjd+Cj4yGmPps18eDtAO9doZpYQsdi0mMZbEjZYzLEDJNe7UwC+fjouZ6FpRYU9AmIi1OtutzBDb50EEGbmz+FHhjx5LpIyDyIzdUwKg5S+fcOv7X3k6DAAJl3U5IMpZiYDpn1QoO60LhbEhtdknKI8u2RgIeQYPRMBTf2CKJdhEzbLXPv5y+4BBNoJBePLlmumbxYfuVtDdmTWtXYF1LeHmuWCes4Qst/16//ecc03h0f2EPAMgxwLxgsn37JS/aTfNbPwtG92tBg2KUi6/lKgz5gIfBclMmGXVZcmh2y/utSRf1tH6pbMnm1dUhQDk1PVupbqmz0w9ZNA+QdWwOUyyZHhAMwwbxk3ri1PkodZLVE+k14puRY3CXfOweGU0Acz4ZZuxt9KzS9edfcXz/ngKPT9PNHk1IkAJ8p3GS95jU
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 09:45:34.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845a9695-add7-4ad0-ae95-08d76f30b902
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Versal compatible string to support Versal
binding.

Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
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

