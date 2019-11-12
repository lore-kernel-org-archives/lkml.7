Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CCC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2576F214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hcquXC9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKLNSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:18:04 -0500
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:56548
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbfKLNSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:18:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF9gLcrSc+SeNzM5JCfL4fAHqRqnTvVh6J/LgssL0XmuLRml9vAN7JteYqvyu7W2APuI0cesamQiYg8LDMHn2YFxz6PGIwwArqI3wb6i+bPZtnA9m1lJm4isZ9NBtQJgj1p3l0+ERLaA0+3ItsAh0tZ3QTPPnRie+N/vs7ixNLZwj0bDUWXzkfGdcOVi0c51Uzgd/S1s4wO6JPihb6tYJCncfr17ycZDQu1I1x14KqE2m+4ExASXaulchV92Pv2n/NaEgFUq/wFsEdYUkOzloFVn0YJ1hl1+h8sSZKyBkp1s2PCp0O7UB0tzvhnPntnBe68RzBnRdNvnKEAOiUrsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdP+U6dhtNw6+OGsPJTh0GU7JulyeSgqB1ovS8xjHZk=;
 b=oRKShkZLyIPVgI+tSv/Q+DgvQFk+w4P0fErtFyS170uObKAff0mtL/t4X1df+KtnZh+NGWHrOWlMzEInc7fxGtRN4wR9RxdA9mrUzcpiNJluj6pJ2fgkC2g8IdtF2mcnxbpLyv7zGFjf6JYtJ066KIyI6csYib1BL6EFHgr2z32BK4BNEmY0ZaguyN3cab84bV9GEifmxO97Q3qoNz9tyDdGoQs3rgoqGw/S0HuEAWfwJaPi1Na0YU8tnXxCmirV21l5hezzHjTEXtI8esTWmKurq6KilijuCytDmKrUs4Y4XUfZelPM1R/GKG1Vt6r18HZ4NSVHmQcF7VMnM1V13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdP+U6dhtNw6+OGsPJTh0GU7JulyeSgqB1ovS8xjHZk=;
 b=hcquXC9lfBu5KZIMZmCN4QhOmB91NP6T6cbrBdCjLN/3YuSY+387ri4dO5ir2oj6V785WDktv2PnBhoWfn1RbOr3U0G51xiQ9sVFWF0KvszGjvp0lXuNTyh5DmBpyhPKm3GYh9mPeRemiphBhITvJ/F4RBz2iTvDtCG96b0hjUQ=
Received: from MN2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:fc::14)
 by DM5PR02MB2507.namprd02.prod.outlook.com (2603:10b6:3:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 12 Nov
 2019 13:17:20 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by MN2PR02CA0001.outlook.office365.com
 (2603:10b6:208:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 13:17:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:17:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2p-0003tC-S2; Tue, 12 Nov 2019 05:17:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2k-0004J3-OC; Tue, 12 Nov 2019 05:17:14 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDH4JA011314;
        Tue, 12 Nov 2019 05:17:04 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2a-0004Ds-1V; Tue, 12 Nov 2019 05:17:04 -0800
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
Subject: [PATCH 4/7] clk: zynqmp: Add support for get max divider
Date:   Tue, 12 Nov 2019 05:16:17 -0800
Message-Id: <1573564580-9006-5-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(48376002)(50466002)(36386004)(305945005)(50226002)(486006)(81156014)(81166006)(476003)(8676002)(70206006)(126002)(8936002)(51416003)(7696005)(70586007)(7416002)(9786002)(44832011)(5660300002)(2616005)(2906002)(76176011)(6636002)(26005)(107886003)(426003)(336012)(4326008)(36756003)(14444005)(47776003)(356004)(6666004)(16586007)(316002)(478600001)(11346002)(186003)(106002)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2507;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9559286b-faa2-4879-de99-08d76772a5fa
X-MS-TrafficTypeDiagnostic: DM5PR02MB2507:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2507C3756C9CB62FF73F79E2B7770@DM5PR02MB2507.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6POVWDugc0sdqyR9De+ldbWRza7Yr5+w1Hs6NtS4UuAu12ftpoGiDCjtvaL526ITqWX2Kx/+vpbWk1GXpkXhWzam0mRtH8W1/rYc7PbBCO67G4LTKatyCxWPOOKYnVkYNK5I2Hz/h88uGIow5WnVRgIpj/CjeWPAjJWm9FrrZeVlt4jKHrdphMDvOYNktl3wOZzA2YN+kzJpyL0p0ZxM5m8GabFU/WiZB+t9MusBtKRWv5ms1vKhxb6Odn4LvMFKtU62U+XD+kXxhRA/gHudRsOKyrb4woEMa9fHht7C2HBspRHPOkGBC5GAVFkVFJkL4X7B66tmVLUb4a145BwqjUk9RiboeQmUW80wJOzwzqzzAxGrWfyQhULvWWDKu1xtvgPB+qYAmwVsixiSyj6+Gi8JOaTjwFbPtnY+lPsoS6h8tNS4NBTF2P1yd4TMkSey
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:17:20.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559286b-faa2-4879-de99-08d76772a5fa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To achieve best possible rate, maximum limit of divider is required
while computation. Get maximum supported divisor from firmware. To
maintain backward compatibility assign maximum possible value(0xFFFF)
if query for max divisor is not successful.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/divider.c         | 19 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index d8f5b70d..b79cd45 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -41,6 +41,7 @@ struct zynqmp_clk_divider {
 	bool is_frac;
 	u32 clk_id;
 	u32 div_type;
+	u16 max_div;
 };
 
 static inline int zynqmp_divider_get_val(unsigned long parent_rate,
@@ -195,6 +196,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	struct clk_hw *hw;
 	struct clk_init_data init;
 	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	/* allocate the divider */
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
@@ -215,6 +219,21 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
 	div->clk_id = clk_id;
 	div->div_type = nodes->type;
 
+	/*
+	 * To achieve best possible rate, maximum limit of divider is required
+	 * while computation. Get maximum supported divisor from firmware. To
+	 * maintain backward compatibility assign maximum possible value(0xFFFF)
+	 * if query for max divisor is not successful.
+	 */
+	qdata.qid = PM_QID_CLOCK_GET_MAX_DIVISOR;
+	qdata.arg1 = clk_id;
+	qdata.arg2 = nodes->type;
+	ret = eemi_ops->query_data(qdata, ret_payload);
+	if (ret)
+		div->max_div = U16_MAX;
+	else
+		div->max_div = ret_payload[1];
+
 	hw = &div->hw;
 	ret = clk_hw_register(NULL, hw);
 	if (ret) {
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f019d1c..f0d4558 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -114,6 +114,7 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_PARENTS,
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
+	PM_QID_CLOCK_GET_MAX_DIVISOR,
 };
 
 enum zynqmp_pm_reset_action {
-- 
2.7.4

