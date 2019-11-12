Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18095C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93A92196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hvyuBA/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKLNRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:17:18 -0500
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:26944
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbfKLNRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir+1rE/fi48CWFPExj9BIGfW/rmoAvyLHbSpmTNfFMTXLuL+nfM6QDEBFZgduogPqd8eNQ50Yk8f/yYqCSsx9z2mzUvqJoacPG81PxKj3et/Bxs50YQP2g3oDzRNT+kpkgvax/mN9KhINDTmBEyH2yHhGNMCm62gf4VAREzUug0gsqrdn4wnPDRhDMAT7Kb4k4zb203KcSV/NCZoVCwGw5FCUq2xf1o/TqYNVf1OgYuXsMbtLkmiYRgL7f7ZlWkG+vJ4uXUd6bKt1BdHEwXgaZW9f7VSZZPCYdbMPvDbiXa/KkA5M/q0dOB92Rv6gd0Ilqd+mHprc32Dhm4j+c9Fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CHQI/shtHh7y7xVKO9wv5ZGzwFahyHkg96iYSppKM=;
 b=DuEA/PW3L0HOEJYqVJbmMJa2sKxv70tuPv2VuxhCMF/OUXMVePVnBEr3DXU2mpnD1+trtlGiLaVcw+D1Ea3HgLsMPRWvwUsbUEIF7gTdkwoEQXGWrhw0tT5AxlvMYFP2drJ/DMslxxfXSGbqjhHAUNAVu0+ZnUBLT0ihLwmbxy3wNYjzDHJ/g8vtjQINvikbtgVHfgZjvMBX8vY+RUmyAGKdXmpZ4ryvl8fYZyPlQDQyf0ndCiOXH6bd8KxvJeRQipQhHUkCum7KEZLxHgzXIkopozqueiftnlPfx1NbBlQWczqC+WtIGylQtxr45NS3jdaYDEvw9IAJCYrCv14VcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CHQI/shtHh7y7xVKO9wv5ZGzwFahyHkg96iYSppKM=;
 b=hvyuBA/Rw2UvQoh60XpGkgiU/9pYrsMtnuMJ9ERQiIfJx2woOrQK17g6uu8FP/tE9dgUAj++PxgU0BB4QH1iO/us+mRqOkRzMrd22E8V2sY5jhrOlggOetuamNW+Vf8GiyM0gj76NMh0r0HrgU7YeRcR0eZ2psnq6kDINZ9pcvY=
Received: from MWHPR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:301:74::49) by BYAPR02MB4885.namprd02.prod.outlook.com
 (2603:10b6:a03:49::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 13:17:10 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR0201CA0036.outlook.office365.com
 (2603:10b6:301:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 13:17:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:17:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2f-0003sj-DQ; Tue, 12 Nov 2019 05:17:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2a-0004GJ-9c; Tue, 12 Nov 2019 05:17:04 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDH1wB011286;
        Tue, 12 Nov 2019 05:17:01 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2X-0004Ds-Dt; Tue, 12 Nov 2019 05:17:01 -0800
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
Subject: [PATCH 2/7] clk: zynqmp: Extend driver for versal
Date:   Tue, 12 Nov 2019 05:16:15 -0800
Message-Id: <1573564580-9006-3-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(186003)(81166006)(4326008)(26005)(76176011)(70586007)(50466002)(50226002)(7416002)(107886003)(44832011)(36756003)(8676002)(8936002)(48376002)(5660300002)(478600001)(4744005)(51416003)(70206006)(336012)(7696005)(81156014)(476003)(426003)(2616005)(446003)(2906002)(126002)(356004)(11346002)(6666004)(305945005)(16586007)(14444005)(316002)(486006)(36386004)(9786002)(47776003)(106002)(6636002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4885;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2c6b8aa-40ec-49cd-e6ae-08d767729fb1
X-MS-TrafficTypeDiagnostic: BYAPR02MB4885:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4885C0475158C8DEB8459D86B7770@BYAPR02MB4885.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1Txsz6n+PlIPBKScsX8ayhCjm55WyRhefh3bNt4J28AeXky1i5SGllsVolaU8pdViW9dtNou22y992pwrbFwbN6ltzVWCcFxOoGHMpjN08ADM2bNPlkcEA5IAm45ujqy1TUjQfaTBJaU750dZeDF8DNFrXzeN6dwNOccJ/GOd+apyHiXbo3t9MXloX2Nv+nX/ftp6rnrQodGFdZcOx61yBT3QsuCpsk6D3X67ACDnNMBPkW6GrfU8AGJpvZI7h5Ei2+7OfW4UfvKZSNhTvOSDwLhwD65RzpSjPp8HRbuCTxlPXObInKSeE180peJ1hPzuD67HHkRNJUk/9RNrJ2QR8MsDI+90uC9VbispelxKZX5P21G9UDIdjC+r/zU8TGsde8AsMuXdOqxvhJ0Jyyo1RYSvBxuhVx+E2v3UitCnaewKr/F2xeisHIxwzOykUb
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:17:09.8250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c6b8aa-40ec-49cd-e6ae-08d767729fb1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4885
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

