Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E15EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12520708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NdP6VJ5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKVJpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:45:43 -0500
Received: from mail-eopbgr720076.outbound.protection.outlook.com ([40.107.72.76]:14816
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbfKVJpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:45:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFKuovtPZlP/f81ASrq/5OkjQb/rBeY00Cjl9UkZx5lP2AdZVEVCmZUa9JXcX4g/qz76gLBDH6HO620js5mUbFWqMawqZDQCSvxHREnY2xF18MycJx8HA6uexi1rcGgbNxSwOM5MKHxhyUrK6x5GgWevw2XRbPynLWXRcTgsTq05Uc+hphAR1M2sFKYL+kn0oXkiz5ztkmktvU98y3BbZg/CFdVRR67kWkpIiDudxRZwgXkmg2TFT6Opv20F8CM7k2MCW+6tlP7oNDtTqjKwJjo/SlNVA3Wjgn3szgTxpf1wNd9xVytFmJ+V5N0nOZT00ckIN6NKydSF40Oskn2EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ey4Ej2hTzmEmKvVsIfcXFMBEAjs6vkI2lJYYHWL0KY=;
 b=S0zIxpA/fhKyA4tYEPoKCfqVwGBhnEqJ8iKI72G8y3oLJ3yPL+AtudgEA+5NDefzh4Es5wHV8BeGSW9VaoBAzilBbQQ5v5MijFAu4/IeNuH56NL/Z2Mxh2Mz48i82T8yy982PYAUYco+yhUnkZ1N4rnz4sJwjMvR+fiRkeewa1WF8cRV1RytRHh3oCsuAHTZRE/BznWD2As1DlejZcyxWQhN2VkfgOYVP6QeI3MpKfliD5VfyS/k71Jq0r0o0mH+z55yKCm0hVD8R3k1S+2prkzN2tDXlZonvxx12rxnn+CFICi2i7UlcZBUvE1Y0UjWvlnyPj46hiWok4+RBZ8yFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ey4Ej2hTzmEmKvVsIfcXFMBEAjs6vkI2lJYYHWL0KY=;
 b=NdP6VJ5vEPVQ9G4c47wkJy5jpG51dyh0o3mS6uTynW0WyYG10+dY6ckELgtt7J4nLSv3/JJWqejNwE/UIyFK2XVrAVkayIgGUv4LCVnJeRqM6HdQeB1DoIGgl+daKtmXr2s8RCJ5GpIKQ9YtFvGGYL1RhHAzFJLAVuGzWf8by4Q=
Received: from MN2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:208:fc::43)
 by BYAPR02MB5335.namprd02.prod.outlook.com (2603:10b6:a03:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.30; Fri, 22 Nov
 2019 09:45:35 +0000
Received: from SN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MN2PR02CA0030.outlook.office365.com
 (2603:10b6:208:fc::43) with Microsoft SMTP Server (version=TLS1_2,
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
 SN1NAM02FT049.mail.protection.outlook.com (10.152.72.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 09:45:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VO-0008SM-FT; Fri, 22 Nov 2019 01:45:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VJ-0002pC-DS; Fri, 22 Nov 2019 01:45:29 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAM9jLfu003473;
        Fri, 22 Nov 2019 01:45:21 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY5VB-0002ob-OO; Fri, 22 Nov 2019 01:45:21 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, dan.carpenter@oracle.com,
        tejas.patel@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v2 5/6] clk: zynqmp: Fix divider calculation
Date:   Fri, 22 Nov 2019 01:43:33 -0800
Message-Id: <1574415814-19797-6-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
 <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(44832011)(70206006)(70586007)(446003)(356004)(6666004)(47776003)(106002)(316002)(51416003)(107886003)(16586007)(36756003)(81166006)(36386004)(9786002)(81156014)(7696005)(7416002)(4326008)(76176011)(48376002)(8676002)(50466002)(186003)(426003)(478600001)(8936002)(336012)(2906002)(50226002)(26005)(11346002)(2616005)(5660300002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5335;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc89da8-e211-4eb8-29cb-08d76f30b913
X-MS-TrafficTypeDiagnostic: BYAPR02MB5335:
X-Microsoft-Antispam-PRVS: <BYAPR02MB533572A79681AF5B087BDB85B7490@BYAPR02MB5335.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 495oJHQJ6HRrOGmsd9BWdHN8xeEIWXZiqYW3tiCvSeKD1BmYWgywTfuCtD2rrlTngN3m3GY8mY3TpIgO2QRi+RcHkXpgMeiVpnTAmrFmTXUM5clAFntWTEq+g9avtN24phogIB0PMv90KBC6shVrYTyxEOJV/T7schKnxpdYrumyjtlNIohkuwxrLbuP8xmoRBdIlBrhFKaKl+cqMspYddFSCOFdqiQuoMa/rqPZay26yGAcTBtfiKBb24ZDNkLNGn44IhajgwcLqOKEHfIElx14UY4shv5dlr7/8+8izKbkuJQGtJp1yKbCQWAaV0rNeUXFJj/va98phsHxCL+q0ASGPJFXEW2t6uWItOtVZBa+rdIsLqaPQB/vrhJxAlGDj2BshauL8qi4bnrzwKp0EMah7Tx80TmOMttDC/9osyDWyk6o6tMfikZTwJYfRdXE
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 09:45:34.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc89da8-e211-4eb8-29cb-08d76f30b913
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5335
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

