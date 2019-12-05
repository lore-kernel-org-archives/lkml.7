Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8687C2D0C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33472464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="skXEWJ+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfLEGhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:37:45 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:6200
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfLEGhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:37:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiZfO6QfPOY4K6g9I4wWWvW8FewkB1/NvpJ0d/AQfNdryzYtFjY9OrUTYBNDnrv77H/DJeyEQ41XFXXr6cQJitM74NZ/D8BjwNTVb1BLZSLUNBz5QQwINfQbW3sAS4gU4PRz0pf8jQhhi4dvnMxsjO/xt/vL32SVXo8Sac+nbB4n3AJqgEKopZSPqebVZzJJENBeyiEQppiEaAdcct8e+QlcSsPTEeZfwps1Qba+xJmya7i88ldEZz0g4BAbKbe6/RtUjfs0w2u7SZHu1CTxEQ6zrOdo4SKpG7zXqNqNYlID6VvPwuT416Cm/kLCdWw3lZJVDSjXEIP8VilHCH3gSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2ZBg83lGfUj0DfhyWSb64nyUYJNXtQgQndPSIHkG7k=;
 b=Bnyp7BbaKMdV6X+M/9/Un3kSPju37LjBR3dqtuwdzFXQirO6H8rBeKdb+Aa9Y80j5VCP+PVZBJ197fJI2LIaPcCxmeGS9y0L4ctVTY7slI0xpJ6RdZaw3EiyeIwR26pJX+I6QEhM3YYsDskbISK0BplYxmrvfd8HPTdVzhhkyV4nPtIAB7pp/3ejZue3GXghchQTULSQBvb6RRF4S5fTyRMipG8aakRRJUvfH+iGWAb0T0VqUjEoHdWDtSkS7W6ub9+KwmeFOwsMU8CX8ClO+79jWGVVpuBHim7g7TIg2awH3VgfnsL2JHLDdeEdaZ/VdUJEVU14hTWjzAa69USuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2ZBg83lGfUj0DfhyWSb64nyUYJNXtQgQndPSIHkG7k=;
 b=skXEWJ+HIoFZjAtDLv/0C8mMf/kSZ8OT1X73a0l9Ayy9aNsylHKgi6BfQSRCjrD+YmomPxS+w8nMdMk1l7LM3ZQMwKfH5qKx4zQ+ui2camKG/GzErJD/Dn0S8SZL42FpMu0ixnrQidn/XqYiYA5qmET9FfJ3XSlnq0QaiSof2CI=
Received: from CY4PR02CA0040.namprd02.prod.outlook.com (2603:10b6:903:117::26)
 by BN7PR02MB4211.namprd02.prod.outlook.com (2603:10b6:406:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18; Thu, 5 Dec
 2019 06:37:36 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CY4PR02CA0040.outlook.office365.com
 (2603:10b6:903:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 06:37:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 5 Dec 2019 06:37:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ickla-0000xJ-HF; Wed, 04 Dec 2019 22:37:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklV-0000XV-E0; Wed, 04 Dec 2019 22:37:29 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB56bJb4003541;
        Wed, 4 Dec 2019 22:37:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklL-0000WL-Sx; Wed, 04 Dec 2019 22:37:19 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 3/6] clk: zynqmp: Warn user if clock user are more than allowed
Date:   Wed,  4 Dec 2019 22:35:56 -0800
Message-Id: <1575527759-26452-4-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(356004)(9786002)(50226002)(5660300002)(6666004)(51416003)(36756003)(16586007)(7696005)(2906002)(8936002)(81166006)(81156014)(8676002)(44832011)(426003)(2616005)(478600001)(11346002)(336012)(48376002)(26005)(70586007)(107886003)(14444005)(7416002)(316002)(70206006)(36386004)(76176011)(4326008)(305945005)(50466002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4211;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c1ad22b-481b-4231-00ef-08d7794d9db7
X-MS-TrafficTypeDiagnostic: BN7PR02MB4211:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4211CDC677292EF18F50D2A0B75C0@BN7PR02MB4211.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UH5uRED0BhVVNnFuM4DfjtIabJw3Urtd5yXbeWddBYGe820Rix6L176tLVroh28f1YToHMPp32QTewaKISzrgRwbG4lAVjnxrQT7BBtWKq6rpaqXo4HHEbeorSQoj+pAZttQzNPbOsd3wWB8x8TjpRw4Y4zIi+ebvKKZggDDM783GP4cWXIHkOaghK0kKNQ2WknFrAXyA97Pb5QAjRoLCuWsFdUG7wcsEFMEiZp/33na9HfvsfmgEeeJStragz6AhqONn/8v/p+rsbOQyqiFLDnNIsiyiYAwqlFiqncIjty4ItTAq93yIXE/WOUK7vgY6suJO3jhtzInZjFZ4tDfGhCWa9/UIthoUVZ+WZRgfmTJXwAyzBEoc6UPKFkXpmy2Nwe5UliwsqD6W71XJdpri+zbrRZlJfZuv8vhJxJogysgoCFl5h5inyIj4wl7XU0ysebGTXx+vihxjXAajdQpX9QOst0J0nSGkLOPobh95tm03xbKgBRVOZYHfDqdzVLo
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 06:37:36.0372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1ad22b-481b-4231-00ef-08d7794d9db7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn user if clock is used by more than allowed devices.
This check is done by firmware and returns respective
error code. Upon receiving error code for excessive user,
warn user for the same.

This change is done to restrict VPLL use count. It is
assumed that VPLL is used by one user only.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
Changes in v2:
 - Leave the existing warning as it is and print new warning in case of
   -EUSERS instead of printing error and warning both.
---
 drivers/clk/zynqmp/pll.c             | 6 ++++--
 drivers/firmware/xilinx/zynqmp.c     | 2 ++
 include/linux/firmware/xlnx-zynqmp.h | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index a541397..89b5995 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -188,10 +188,12 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		frac = (parent_rate * f) / FRAC_DIV;
 
 		ret = eemi_ops->clock_setdivider(clk_id, m);
-		if (ret)
+		if (ret == -EUSERS)
+			WARN(1, "More than allowed devices are using the %s, which is forbidden\n",
+			     clk_name);
+		else if (ret)
 			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
 				     __func__, clk_name, ret);
-
 		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, f, NULL);
 
 		return rate + frac;
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 75bdfaa..74d9f13 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -48,6 +48,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 		return -EACCES;
 	case XST_PM_ABORT_SUSPEND:
 		return -ECANCELED;
+	case XST_PM_MULT_USER:
+		return -EUSERS;
 	case XST_PM_INTERNAL:
 	case XST_PM_CONFLICT:
 	case XST_PM_INVALID_NODE:
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index adb14bc..a3b0a39 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -89,6 +89,7 @@ enum pm_ret_status {
 	XST_PM_INVALID_NODE,
 	XST_PM_DOUBLE_REQ,
 	XST_PM_ABORT_SUSPEND,
+	XST_PM_MULT_USER = 2008,
 };
 
 enum pm_ioctl_id {
-- 
2.7.4

