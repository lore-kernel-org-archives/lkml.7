Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A6C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DDB21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HdM5A325"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKLNR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:17:26 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:40958
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbfKLNRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:17:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlvOmkKSMlNphwdohKIJkvKYRajZMsBoszlT7hlYPbqwLRXFUJLl2bxog6vuPcr1eMvaviTFGw2OM+vyZNgvVNqCjEJ4fEMO6AoiCSmccleF4t1Y8PiPmh4ZQvPS8kZgGiVEtz/FzzpKa50lIUURTFnp5hxnrEct6FvANmhkwkIt9s1OB+DSiy8Tc/QNog+2tbszDD925yS7PHYV5MWHPnt/F4nlZXZGWjhIq/H4trgnHCD3tlMfX/uOdj3VMg4cJwwAhcYmixl9I0OQJCXbnjgkWWWE7M7SS/YdNtCQysGQFPLzNln7iWYFz6I316q7J4if7/l/zDaL5HIUb3sZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HgqwMPlNAtuzqxwwyJ6M5WSyCmZH8RVOxfFul1KBnU=;
 b=WHgPqQN0r086i0ebYIdtrRCVaGRuZtMlg13rjp+995jgWPzw9GFi/bcIgIp3DuAqUFpEIruq3BhxpnWIDXlHL7FvmmL0Eg0pLH1LBvAnYufyTGJUXra2GiKUL2a/XqE3VuauVoMWJlo+Zk7wOlUnu3z7IVgFm5/NTTEz6vu1dhE0uwzaA1wCu6URpkZ+DGobGwDpCS0CWLA5iSM5MtWiZaCRHXKAOoUt64PnBphELutcZWMNjS8Ze2tQz3P0j0QaNbfTESB6/Uatqbl/GEPM8ZtHoOkaNtnVGeNFWV0WvOdSqkJDKp7ZhvpcSgQ5JpN73hbUlCk5vjJqtmjC2YToaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HgqwMPlNAtuzqxwwyJ6M5WSyCmZH8RVOxfFul1KBnU=;
 b=HdM5A325Kn+/7ZJMqGmh9dhx+BDniSx5B1p5hhtvWogmQV1ePayy3LKGxsUVgt/wvJ5COYttnoZXvhTYeg106pWx0WbfVW39n4HouvIuprpbLKzQQDst0946Ljob8C8K9P8pX+XWN40EfokYNqS8pUpmamVhR82mUPiglqt9gik=
Received: from MWHPR0201CA0014.namprd02.prod.outlook.com
 (2603:10b6:301:74::27) by DM6PR02MB5371.namprd02.prod.outlook.com
 (2603:10b6:5:47::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Tue, 12 Nov
 2019 13:17:21 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0014.outlook.office365.com
 (2603:10b6:301:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Tue, 12 Nov 2019 13:17:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:17:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2p-0003tD-Uu; Tue, 12 Nov 2019 05:17:19 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2k-0004J3-RP; Tue, 12 Nov 2019 05:17:14 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDH2US011304;
        Tue, 12 Nov 2019 05:17:03 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW2Y-0004Ds-OF; Tue, 12 Nov 2019 05:17:02 -0800
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
Subject: [PATCH 3/7] clk: zynqmp: Warn user if clock user are more than allowed
Date:   Tue, 12 Nov 2019 05:16:16 -0800
Message-Id: <1573564580-9006-4-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(126002)(4326008)(36756003)(47776003)(8676002)(44832011)(81166006)(81156014)(5660300002)(486006)(478600001)(70586007)(2906002)(107886003)(476003)(70206006)(48376002)(50466002)(356004)(6666004)(305945005)(106002)(336012)(426003)(2616005)(8936002)(36386004)(11346002)(446003)(186003)(16586007)(26005)(316002)(7696005)(76176011)(51416003)(6636002)(9786002)(7416002)(14444005)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5371;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3dcb755-19d3-406b-db39-08d76772a607
X-MS-TrafficTypeDiagnostic: DM6PR02MB5371:
X-Microsoft-Antispam-PRVS: <DM6PR02MB537151C4C63F87BB137BA9D1B7770@DM6PR02MB5371.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXEtnz7RbqeCD9c8eyFwyo1523L9WorAiS/fK0kwjsC1QbQYLoMgCF0o0lhGqRgfDgUXXw0RoBHNDM6pfmevF9FQLyz09o+9HtrHK0L6ij8qyWrELtxEXbueL/2VyHr/6mqxqvJS+vJ9rgd8Wqfewoe9F0ZM5p6KRCL8xG2emB1hr1OJsevKhubAxVUvq0VA/dfDVt4NeSsR/Kwzj6h5zY0cUUSlabuwY+I0mxaGwEwTSxBS9FEYyPR2oKv6C8cT98I8BQNP6mc3snajAW3Qvfl8zUqjiFMR9LtHIKqdetBg0evXxTzTtSdHdgucnCK7yA2diUWaqFIze9OtfMi3VxS9gQoPBgToQw52FpKkYy9vRQfuEtQZ0/oUK7PZbMs8n2RSFCq2r+OTYnwb83TTpGB3vx4X1SLQWm1RjqVL9akVHrNO3iZ7HyOVV+WCeT9n
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:17:20.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dcb755-19d3-406b-db39-08d76772a607
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5371
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
 drivers/clk/zynqmp/pll.c             | 9 ++++++---
 drivers/firmware/xilinx/zynqmp.c     | 2 ++
 include/linux/firmware/xlnx-zynqmp.h | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index a541397..2f4ccaa 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -188,9 +188,12 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		frac = (parent_rate * f) / FRAC_DIV;
 
 		ret = eemi_ops->clock_setdivider(clk_id, m);
-		if (ret)
-			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
-				     __func__, clk_name, ret);
+		if (ret) {
+			if (ret == -EUSERS)
+				WARN(1, "More than allowed devices are using the %s, which is forbidden\n", clk_name);
+			pr_err("%s() set divider failed for %s, ret = %d\n",
+			       __func__, clk_name, ret);
+		}
 
 		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, f, NULL);
 
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 0137bf3..ecc339d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -53,6 +53,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 		return -EACCES;
 	case XST_PM_ABORT_SUSPEND:
 		return -ECANCELED;
+	case XST_PM_MULT_USER:
+		return -EUSERS;
 	case XST_PM_INTERNAL:
 	case XST_PM_CONFLICT:
 	case XST_PM_INVALID_NODE:
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 25bedd2..f019d1c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -96,6 +96,7 @@ enum pm_ret_status {
 	XST_PM_INVALID_NODE,
 	XST_PM_DOUBLE_REQ,
 	XST_PM_ABORT_SUSPEND,
+	XST_PM_MULT_USER = 2008,
 };
 
 enum pm_ioctl_id {
-- 
2.7.4

