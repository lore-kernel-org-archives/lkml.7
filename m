Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E04721D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HyB3iE2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKLNR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:17:29 -0500
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:47984
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfKLNRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mttOl/KoCymW0LCfzGC9s6QEmLWh04/cRbpiRGTc0+9iq06s7FdTXNPOOpDV7fjYOIlX6qu7ybIbATDZidIM0gLGeV3dP8UgCdxToaMaxQCxjBg3lcY/GHq7grXLKxm0KTg97TmsOLdWcME1DHb8J3jsrZmAIXRdMKtNfgjaKFnfRF1ligoF0q5gwDai7shUieh1iCXrWWFLRsNImZyaBaKeQedzdg7nyyVyEvehbj1jWKIWu8o4Pe/HtGr2777yjL1Me5ZShVevNWeG7QaCJ8Hgn4FdtMklFDPXR5QG0rY/Iv8xONcCeBYrgPCPlKV3eFSG4sg/1++gBYPaYzCcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cFkGCKk7MuEitcTUnSnqvZ/QbDnmb5KjStx3kSvack=;
 b=M+84ozEL+WfaGuLfhnnTnDH/omtchBXMDnhHYFVrPY9Xb5q5CjO1pInyc/AIiH5oHDE4ho+cL4llO7MET3GFXRxn+dp0Q89kxXMbki3cmbRl6A8pZP3dCil8geMtxjGXQDJu+nlxDyh2J+4hY3rRoAGoOgEy0x8d+AZVvbnkOyD0fYsHT7P+dfh9974foAvMFbXU8VxFR0G5RGs/a9z68BH8xvQ2aBtaQko7Ga4ZvsCWoyWwBXrjXP+jIy3M8Q2Vn2NfVUIog2CRqNZ4l4Jkoqd3lzX3YsYdBTcWC1lo9YbnBvnY+yXvhXTOHOMVRYmwVyo/9EDXIU+FrL1arqL+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cFkGCKk7MuEitcTUnSnqvZ/QbDnmb5KjStx3kSvack=;
 b=HyB3iE2OD6p83hK493koqVtM95XgS214QIO7M27DclA+GGyC0Bpj1ml9a/TiIzFnc35e7vSOpmDJK2cFdpTH5pOgel3ejCj9ImqUK2qvgZrqmqcyUjgY6LPlRRnvFJZKeBJ/BUucqRHPjCExteDndFJM3BUGRCvw+0YzAQh+/CI=
Received: from BL0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:207:3d::35)
 by DM6PR02MB5180.namprd02.prod.outlook.com (2603:10b6:5:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Tue, 12 Nov
 2019 13:17:20 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0058.outlook.office365.com
 (2603:10b6:207:3d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25 via Frontend
 Transport; Tue, 12 Nov 2019 13:17:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:17:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2p-0003tB-Q6; Tue, 12 Nov 2019 05:17:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2k-0004J3-Mc; Tue, 12 Nov 2019 05:17:14 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDH6lG022526;
        Tue, 12 Nov 2019 05:17:07 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2c-0004Ds-P0; Tue, 12 Nov 2019 05:17:06 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, jolly.shah@xilinx.com,
        dan.carpenter@oracle.com, gustavo@embeddedor.com,
        tejas.patel@xilinx.com, nava.manne@xilinx.com,
        ravi.patel@xilinx.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH 6/7] clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag
Date:   Tue, 12 Nov 2019 05:16:19 -0800
Message-Id: <1573564580-9006-7-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(50226002)(81156014)(9786002)(50466002)(186003)(11346002)(446003)(2616005)(486006)(126002)(476003)(426003)(336012)(26005)(8936002)(81166006)(8676002)(48376002)(70586007)(36386004)(4326008)(70206006)(356004)(7696005)(6666004)(51416003)(36756003)(107886003)(106002)(76176011)(16586007)(316002)(6636002)(54906003)(478600001)(2906002)(7416002)(305945005)(44832011)(5660300002)(47776003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5180;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ca7f2a-38db-4dde-4c72-08d76772a612
X-MS-TrafficTypeDiagnostic: DM6PR02MB5180:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5180BA1917286F2EB9F6239AB7770@DM6PR02MB5180.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PG7LSlqBANqo0T68T1kDibIsVt5tyJTPGAjid3YRleze+uZj7MLcb+4dUgU3UF0XQwsjR3hIdCrYofHzPzpBR94OfMVZuDGUVr9pFwg7GaujHvuGN/XBZirALyTYhSzNIDcoNqGmc5RkEWxSyzIsl8/SmqGrAlBk5A3lYDASMAL51VCUW/Pyxq6kk5q9pti4/E3mA5P3wEkg1TOvkI4yxyeXNGIP4MmRUOTf+CRLsz12RxrHZ2M11xb3JjPGNgSPm/wIhzgQxNZm3uUbJ4UoQc9KcB+eIsW+r+1Rf8l20/5felEPZkKR24WjVomPpDwNzfROsk4oR/IS4OXxkA4148ve/d1VPw3jdS4HfqBEgETrH3BUCMhunAULh9Oa7hb/1xYOFMndEdvfY75aHMyx7ByzinHMFLVGzFN5veXbFmQwm7qdYnfyCjn2jOXWRh+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:17:20.3972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ca7f2a-38db-4dde-4c72-08d76772a612
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Existing clock divider functions is not checking for
base of divider. So, if any clock divider is power of 2
then clock rate calculation will be wrong.

Add support to calculate divider value for the clocks
with CLK_DIVIDER_POWER_OF_TWO flag.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index b564696..67aa88c 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -2,7 +2,7 @@
 /*
  * Zynq UltraScale+ MPSoC Divider support
  *
- *  Copyright (C) 2016-2018 Xilinx
+ *  Copyright (C) 2016-2019 Xilinx
  *
  * Adjustable divider clock implementation
  */
@@ -45,9 +45,26 @@ struct zynqmp_clk_divider {
 };
 
 static inline int zynqmp_divider_get_val(unsigned long parent_rate,
-					 unsigned long rate)
+					 unsigned long rate, u16 flags)
 {
-	return DIV_ROUND_CLOSEST(parent_rate, rate);
+	int up, down;
+	unsigned long up_rate, down_rate;
+
+	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
+		up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+		down = DIV_ROUND_DOWN_ULL((u64)parent_rate, rate);
+
+		up = __roundup_pow_of_two(up);
+		down = __rounddown_pow_of_two(down);
+
+		up_rate = DIV_ROUND_UP_ULL((u64)parent_rate, up);
+		down_rate = DIV_ROUND_UP_ULL((u64)parent_rate, down);
+
+		return (rate - up_rate) <= (down_rate - rate) ? up : down;
+
+	} else {
+		return DIV_ROUND_CLOSEST(parent_rate, rate);
+	}
 }
 
 /**
@@ -79,6 +96,9 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	else
 		value = div >> 16;
 
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		value = 1 << value;
+
 	if (!value) {
 		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
 		     "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
@@ -157,10 +177,13 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 		else
 			bestdiv  = bestdiv >> 16;
 
+		if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+			bestdiv = 1 << bestdiv;
+
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
-	bestdiv = zynqmp_divider_get_val(*prate, rate);
+	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
 
 	/*
 	 * In case of two divisors, compute best divider values and return
@@ -198,7 +221,7 @@ static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	int ret;
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	value = zynqmp_divider_get_val(parent_rate, rate);
+	value = zynqmp_divider_get_val(parent_rate, rate, divider->flags);
 	if (div_type == TYPE_DIV1) {
 		div = value & 0xFFFF;
 		div |= 0xffff << 16;
@@ -207,6 +230,9 @@ static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 		div |= value << 16;
 	}
 
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		div = __ffs(div);
+
 	ret = eemi_ops->clock_setdivider(clk_id, div);
 
 	if (ret)
-- 
2.7.4

