Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4497C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA0A20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ENayHrXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKVJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:46:06 -0500
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:32288
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbfKVJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:45:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QREfbtL1r4ZC19dYer52NhlmgszAeYKHFOv6s263rsUPZ61hbXCGOC/3v0SFCWp8Y1NTCswEUOpBefPr3l4ZVubxx3Dc3pPIwmeqKTB9iEWEhzFgWd0LlpmaKPwmEcxzzt3lMJBSdab+2wuQPRLj+pt9UeliFXokuoyNXl+eepZ31WX/RK6+ewBbRAMz6Sh00CivB3ekLB+h0/OeqGDHZnadPM765WF4CA+mRKL31DNwYLFkFzH9/0rrSjk2+eet2JcQxuSSzrGG5MkFEDHR3/7WeMLIsWN9d/mNRejRN3rSce9umukiOZjQyGJBNr5RUAxKG0QdMVfDza9cJ8ODtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My5GEXzjq+YdSFxcfZdDk/JzMNz28rCI+oq70GAKch8=;
 b=QWMe2iJFTxiZy+yAlRggIpsqJFgLgBlbulDp4yWwPdWfF1HLqqdrpAl+rcF++ihbc2Ct3RrMqdt+XP2hl2igIJAYEFWwZIlot3R1nZB3ZTW8KYKJgbalBPo3A2KiF1qGgLrxu1so3Wt0HPjqduXFSBDZR5i+TwVG4xQeqE3+Omh3gGVFXSxRvSHkPeUlo57nh5CnBzEQasruiAHjoxDQnTDaaoL4epK8PYeSj4DvN8h3fHWzvdTCpPyLVHuZ96btj0UxUMAolazZMadF4fyZ/Rc3qeFfs3TSWurGL/SxMYJ7d2krVE97lmWKhdKeKwCQpTh+HTZOVSwvvm+b8kybfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My5GEXzjq+YdSFxcfZdDk/JzMNz28rCI+oq70GAKch8=;
 b=ENayHrXVe+CUDC+FARwK+8OEc4iJ8+4H6B01ym+IFAbS8O6VQVdQby4mRpspu3rfqPT4tLrLG23F27rU14SCKLVgZ6bkJlA83KbGGi5HhuZx9bSS6WBPQ7HYQ+mMc+EqZyI1YQweUC3fX701i8QnjhMDUP5BRL81Srt+2ayKGus=
Received: from MN2PR02CA0031.namprd02.prod.outlook.com (2603:10b6:208:fc::44)
 by DM5PR0201MB3413.namprd02.prod.outlook.com (2603:10b6:4:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Fri, 22 Nov
 2019 09:45:35 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MN2PR02CA0031.outlook.office365.com
 (2603:10b6:208:fc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Fri, 22 Nov 2019 09:45:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 09:45:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VO-0008SL-Dq; Fri, 22 Nov 2019 01:45:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VJ-0002pC-Bt; Fri, 22 Nov 2019 01:45:29 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAM9jLiW003475;
        Fri, 22 Nov 2019 01:45:22 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VB-0002ob-PK; Fri, 22 Nov 2019 01:45:21 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, dan.carpenter@oracle.com,
        tejas.patel@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v2 6/6] clk: zynqmp: Add support for clock with CLK_DIVIDER_POWER_OF_TWO flag
Date:   Fri, 22 Nov 2019 01:43:34 -0800
Message-Id: <1574415814-19797-7-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
 <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(26005)(6666004)(356004)(478600001)(54906003)(36756003)(2906002)(44832011)(47776003)(11346002)(446003)(70206006)(48376002)(70586007)(2616005)(8676002)(8936002)(81166006)(50226002)(336012)(9786002)(81156014)(426003)(50466002)(4326008)(76176011)(7416002)(106002)(305945005)(36386004)(5660300002)(107886003)(16586007)(186003)(7696005)(316002)(51416003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3413;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7e8aea9-e3fc-4a8f-fc66-08d76f30b90b
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3413:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3413B5D9B9F88BD1CF3D0832B7490@DM5PR0201MB3413.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJiay6tkmJr1pNWMFXn85jWOt6mdL+ZLAnBydbVQk21YkTp0hmA7XU3zo+7MF0BV1ogZWHy1fDNpbbp6wPBcWCBcM/oDBgYLui4R9s5GZ2KGq0qMPK6JsvQC+SQiLoC6xyOZ6n8i+E44iixhSpr4AJYhvLHry4Daznw0aAe9B0Jjx8jGl+YkzsXU3SLQyLT3W01UN4pGCnfTWhzRAqlJk1eE5xp7tgalsOeZQrXrIBf/nn7VoMbm2y+wdTyHKC77z/ZugnCwJ0WoB5Iv3cQBbwpEL4/Z7XZMRDoRkYLRAlVG08eFmN5hnRD2ztAgCeP/UY9XrYUsxekaA7lfM3Cilb5i0BlVl7O48b21OSIo+Tb/WOYLm59XlfLV0O5v4j9d6sIyVdaaWESoRIH3E1mNJBGQvgQ6VKXtL/tsVL3t1CyhFjneRNSjL1q1B/IufI4o
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 09:45:34.8427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e8aea9-e3fc-4a8f-fc66-08d76f30b90b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3413
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
index e0d49cc..1d5a416 100644
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

