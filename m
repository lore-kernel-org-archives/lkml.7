Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA0C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62A822525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MGcXV4fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfLEGhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:37:55 -0500
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:19001
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbfLEGhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:37:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/+LlNFoEFdwiWC+KGKrpe/HxkOiz6GhP3hXAFIyTczrEJgixsHyS1OY1ebtCK7EUp7YQgzrRawwVD0iaUBbUehFPtZCLAQXM41kn/59bhk+T9m0yu7UN53psLFyibWlKbbqLIp/dFHLvdFpo6E0Mi63kPgl6ssWs3Pb/Zujq87TAkamYv9gFsLzZvWi1EDi8NtoFjRbseVLf8n697aXA6bQkrs/igXv8sn/M/kV55OWX971CQ+Gex0psvHyzbo6taRcdhXBiA/oi8sKJVnNam471eChy+M44ibojJIUWI5eRo6KAQoIWzm0UbszrjMqiwPz8xaXYJjzqkJ4cj1OHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ey4Ej2hTzmEmKvVsIfcXFMBEAjs6vkI2lJYYHWL0KY=;
 b=nVO2eIDnEAaitrsQJwFNhHiSsruCwXEtYwDk94RAtSY8tzUJkoviULzixHkspmk8Rpgfv5eeM+P72yCxCKRsixqPsQTuIoVtSbUdvO7pOElUH5JnF7ZZhEQDRJsWj2PFEnOUKEAZAH1pOElpHxOYI9d5GljrrfeD/DoHZJT7EQY+ZI7WscV+1Se/76WsjTi0R2TJvLclIfbP0BTJL6uK6XvORs+mvnLLDNBzFk9dTq1U0CU/d8Uuo6kWmXey8paK1Fqt+aUOKfeIYxJGN+NpzpLZe2rT+btMTf1rfUfzkLt8DDDFr8WMQpZ46KvjsRt4pP71SS+ytF0Z/IlRV+ZasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ey4Ej2hTzmEmKvVsIfcXFMBEAjs6vkI2lJYYHWL0KY=;
 b=MGcXV4fF/Ly9ncJUJ3WmlGQHrAPFcOHGEL60Rh43foOdx87qw2ZMi+HnQeYU20Y7GZblAYP0b4YqxN2YZjEug/Iy2bXZ6CQEzbizOHTBpKqncDZFD0pouB/2KfYTJNig9q0vhIVOpTLoEBl7hV9MzbIBLgccwUOEFWXAvD+sHeQ=
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by CH2PR02MB6231.namprd02.prod.outlook.com (2603:10b6:610:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Thu, 5 Dec
 2019 06:37:36 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Thu, 5 Dec 2019 06:37:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 5 Dec 2019 06:37:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklb-0000xO-3Y; Wed, 04 Dec 2019 22:37:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklW-0000XV-04; Wed, 04 Dec 2019 22:37:30 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB56bKxV003543;
        Wed, 4 Dec 2019 22:37:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklM-0000WL-0w; Wed, 04 Dec 2019 22:37:20 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 5/6] clk: zynqmp: Fix divider calculation
Date:   Wed,  4 Dec 2019 22:35:58 -0800
Message-Id: <1575527759-26452-6-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(7696005)(356004)(76176011)(7416002)(51416003)(2906002)(6666004)(9786002)(36386004)(70206006)(50466002)(50226002)(8936002)(8676002)(48376002)(305945005)(81166006)(36756003)(81156014)(11346002)(70586007)(5660300002)(426003)(478600001)(107886003)(2616005)(336012)(44832011)(26005)(16586007)(186003)(316002)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6231;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340fb16f-cc92-4252-320c-08d7794d9d77
X-MS-TrafficTypeDiagnostic: CH2PR02MB6231:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6231EA23D6A1B12733A04295B75C0@CH2PR02MB6231.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75gzBgnQE4YwcCAdj5T+jIkZPJZzH3K5fiB3VVRUmzSpS1BbSRF6iGJoE5TrYhi9UQw8/7RCJsfJ1hIHzv0gQqtAgpJEXb4EXCR63B3QoygZfHffzQr2vtVG7nW+gPJ64U06BLHFu4frpNBgUFqqgzBg8iddLOfLcXdU8y5RAmUV4YPCu6GzPyQkYB9Z1OvuYm576hC8l5rdco8QCTLScnu6P+TvtpULS8FnpLgRM+hRJIvlnZgQEut+cjsdYVldmRHuRLtDC1wBTelPWR1k6o/k7ZMeYUDgNqJEwOkVtJGilDMYguxH8+f8ZRHTXlyYXIqf0QopjgWG7e27wYc74/c+FREsu5QkO4RKCFSLGEvl7VYNFwR7g+TcqIZTfYHMbQlXojAukb7W5+40wT+xbHJz8Kg/0N1kQGsTXxF4NGFr8A/GafyZkzb56C0Za5I5MfGgZJgn/FGpyScVfskVgq/WHoI+UEEB0G1D7toqa5ROBvrSUh8TPFAUFpvEYkql
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 06:37:35.5770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340fb16f-cc92-4252-320c-08d7794d9d77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6231
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
index aea52cd..e0d49cc 100644
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

