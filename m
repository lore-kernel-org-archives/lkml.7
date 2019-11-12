Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1AEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6C214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hDHVR/93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKLNR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:17:26 -0500
Received: from mail-eopbgr820054.outbound.protection.outlook.com ([40.107.82.54]:55168
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbfKLNRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4U9ZDEDVQcxJcvs93IDsX4/0qtE47lGzGBXfemniXq5s//v8ePmTXuOX3sV/1vcjdyrxb+Br7bl5ckt/D+6xnJwxsSxxOZoJRsDa94Wvcy2+or1WHfzGdmndO8nokzynjHR6OXyAp1Ik0SG8xQ08/5Rr/VTzPqDtFwfJERninLPhxFs7YNTtqL/lX4wXy26GMXX1OuHCjn5+cqXSflZbI6Pp/Zi0OLrOyf8OQqfDZqNXaB7hTBqKAu6k1RyB23HywqVSQXzbh/QwR2Bdz6aTxIWvSs2uV9gKA1MD9AXu5rZtzuKkTlZ7/ZE/kLty9lKPWSogkt/J5szQ18Qw8dD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+CH5nha3u7VAb6/vGD4aWhpVS4G2MMB+OKjgcV9eMk=;
 b=jwCKKoQ139DiZBipvpY9kYNrCikGL/IKzFwhtvdrw5N8PaEFdj0tWzgaVU8FTPuRWa6Lz8ZaNaVv7WN28Xm8cJNwulwb6TAsWyhk8s5O3VF5ofIJpmQ4G4g/4dO5qd2bOGNkE8nc0AAXAyqjr1Zh1f59xWvewGiQUOzMkQAVFp3Scxcez3KN3eilPRHFeVCZY6i1rmkRvYDmXSL2gv65FV4ZFO3hR5ag61I6nyLioU4GhZtfZVx1o39yZyMAaQdv7TUwWXwNpphbQsMc00BUrI+mfYGY6KL6G3OGH0G4iPSQrKW+NL0ZADj4vhl0HqaxdR9ZP5D1Cj7qf0R19zeJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+CH5nha3u7VAb6/vGD4aWhpVS4G2MMB+OKjgcV9eMk=;
 b=hDHVR/93gr4DB05ho7CgiNebuhWrOkL4bTWcnH7jePEH5eaLXMIRijwOTKB6lqDTxtB4CEPDvdeL/KB4UHz65nBby491TdJ8Jr70ilrgZdU/Lb8e80IV+hhWj0bW1AbvoLMKUr3AvA2jDmRYSdHSkvl73InAoq2S91NlALmhvVg=
Received: from MWHPR0201CA0033.namprd02.prod.outlook.com
 (2603:10b6:301:74::46) by DM6PR02MB4923.namprd02.prod.outlook.com
 (2603:10b6:5:fa::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 13:17:20 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR0201CA0033.outlook.office365.com
 (2603:10b6:301:74::46) with Microsoft SMTP Server (version=TLS1_2,
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
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 12 Nov 2019 13:17:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2q-0003tE-0E; Tue, 12 Nov 2019 05:17:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2k-0004J3-St; Tue, 12 Nov 2019 05:17:14 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDH5hO011322;
        Tue, 12 Nov 2019 05:17:05 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2b-0004Ds-H6; Tue, 12 Nov 2019 05:17:05 -0800
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
Subject: [PATCH 5/7] clk: zynqmp: Fix divider calculation
Date:   Tue, 12 Nov 2019 05:16:18 -0800
Message-Id: <1573564580-9006-6-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(186003)(50226002)(26005)(4326008)(7416002)(50466002)(70586007)(76176011)(107886003)(81166006)(44832011)(36756003)(8936002)(48376002)(5660300002)(478600001)(8676002)(70206006)(51416003)(336012)(7696005)(81156014)(11346002)(426003)(2906002)(446003)(126002)(6666004)(6636002)(356004)(2616005)(16586007)(316002)(486006)(305945005)(36386004)(476003)(9786002)(47776003)(106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4923;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b53be68-52f1-4652-8d7c-08d76772a60c
X-MS-TrafficTypeDiagnostic: DM6PR02MB4923:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4923F8CB792263924629DCF6B7770@DM6PR02MB4923.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJH/R/nLbRMigxKVB6MMqGMhlAlHWrkgiPP8IM1dlf4c9XUJg5r3hgj52A+uUgt/iTNrZwaywiM6EoPKoupkb4N4iDc9h3dGsBnN/9C50Hq+Zjr/6fNMS7FsFW33KFrWMYkknoYNzqQCg5ayxadhleFPydNjvLZ6uj7y1+qVu3SZ6t/U2PzfpP2zoZFPBN5sVWomilnYaMuVoR7fqsyrD82/bYDCrr5woqh97/JLWSjUTZ4LgWDe6hswpn9I9WHynnFP+R0q/gf2zK45DdSBm3rsVHvQF6CGxbkkUNGDbOQEKpj3S9xdPO97lrJuDutTvQhzUDtlk51lfp+Ucm6ZU0nacOIQlRLkuPbXiO497zP657+mjS4hJSdcGlhGuomL44eKTfxV9GZvK7tHqGzBztSdBQqpVZUlXny/0OCD6icNUiEc99yO3Wq4o7rRU/bA
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:17:20.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53be68-52f1-4652-8d7c-08d76772a60c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zynqmp_clk_divider_round_rate() returns actual divider value
after calculating from parent rate and desired rate, even though
that rate is not supported by single divider of hardware. It is
also possible that such divisor value can be achieved through 2
different dividers. As, Linux tries to set such divisor value(out
of range) in single divider set divider is getting failed.

Fix the same by computing best possible combination of two
divisors which provides more accurate clock rate.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index b79cd45..b564696 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -89,6 +89,42 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate, value);
 }
 
+static void zynqmp_get_divider2_val(struct clk_hw *hw,
+				    unsigned long rate,
+				    unsigned long parent_rate,
+				    struct zynqmp_clk_divider *divider,
+				    int *bestdiv)
+{
+	int div1;
+	int div2;
+	long error = LONG_MAX;
+	struct clk_hw *parent_hw = clk_hw_get_parent(hw);
+	struct zynqmp_clk_divider *pdivider = to_zynqmp_clk_divider(parent_hw);
+
+	if (!pdivider)
+		return;
+
+	*bestdiv = 1;
+	for (div1 = 1; div1 <= pdivider->max_div;) {
+		for (div2 = 1; div2 <= divider->max_div;) {
+			long new_error = ((parent_rate / div1) / div2) - rate;
+
+			if (abs(new_error) < abs(error)) {
+				*bestdiv = div2;
+				error = new_error;
+			}
+			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+				div2 = div2 << 1;
+			else
+				div2++;
+		}
+		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
+			div1 = div1 << 1;
+		else
+			div1++;
+	}
+}
+
 /**
  * zynqmp_clk_divider_round_rate() - Round rate of divider clock
  * @hw:			handle between common and hardware-specific interfaces
@@ -126,6 +162,16 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 
 	bestdiv = zynqmp_divider_get_val(*prate, rate);
 
+	/*
+	 * In case of two divisors, compute best divider values and return
+	 * divider2 value based on compute value. div1 will  be automatically
+	 * set to optimum based on required total divider value.
+	 */
+	if (div_type == TYPE_DIV2 &&
+	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		zynqmp_get_divider2_val(hw, rate, *prate, divider, &bestdiv);
+	}
+
 	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
 		bestdiv = rate % *prate ? 1 : bestdiv;
 	*prate = rate * bestdiv;
-- 
2.7.4

