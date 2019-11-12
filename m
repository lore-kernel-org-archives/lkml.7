Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907E8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB9621A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GZNdnDzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKLIht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:37:49 -0500
Received: from mail-eopbgr750084.outbound.protection.outlook.com ([40.107.75.84]:3814
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfKLIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:37:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW9/LNvmcX+C1TRJ1jeJ54VdSpl0s/9efgqviw8oJvNI78Ld/zVjL8qoEWzv+YhlKE5ghUiI6JA9yIKN4UdLWw6JRsT+MRgI0ahDbjgD1Vb1KHG4E3QW2Rnv78LzTYeL5KXdjBtTPkY5MHEQV1JH/UucTllEfRCOKWHUYGUUQgQ8QokXWSWbaGYISu0XUbKzh6yodyRP4MqBWF9izmsJWk+BZyRNygc4qoCbgWoc6n6Jw+GcTDACHbrU77zW3bhOx/U0AKR93NxLlnHKl6RDQVXE6zicRCfEx8+fIGac2ciuccA4GNOOC4UsR0x6chGQmp5r9Nd19AapYuSHZ9TfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnonpDgdGcrSnWv3TiSOaA/ryLf5VJjthY7se3QdMDA=;
 b=TJ50xxEU0Spxyrcdc1D/NAcLPPpEzpdFhsHrEm1SSBe8VcW4e7PDygti6yWidxvaArP7LbEd8b/PMgnNbMaE67qGgbn1SdKPCeqGzb1K9Dc6iO7jys8dIpx526qx80CB/W2XvQba/Zdh3YKr/cuzGqyvcuJKKFKrLOEunA4xRfkyTHwMdaSaPuiuADGHKvJK9yOt0BUmmd2+UNvHzMo6YNCY2647tr/K8QngP0Opv5fRvVkXpTRNehVV821PpPNOgoWm6dQTAj/C4AZRyhDncWG2Pwk7K+piuxr6AAyNzmaskA9O91cOJ0EGLv+LOxqlzpyS6eJtdFajgyaOK9tUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnonpDgdGcrSnWv3TiSOaA/ryLf5VJjthY7se3QdMDA=;
 b=GZNdnDzMCLqMPlhY9YIYZXdkZwkyDtJ3f717hXYWjvv1hhNj2vAaDYGmydP98C5EJMhCurkQvKGA8z5PWu5j6cemnDozD41UkUHZZt+209sax+DANbYz8le7ZZRp6bhyebR7AlMUCjswpI5gEwAxN2SqoGm+JdMxJ8xUFJ5vp2Y=
Received: from BN6PR02CA0027.namprd02.prod.outlook.com (2603:10b6:404:5f::13)
 by BYAPR02MB5095.namprd02.prod.outlook.com (2603:10b6:a03:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Tue, 12 Nov
 2019 08:37:42 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR02CA0027.outlook.office365.com
 (2603:10b6:404:5f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Tue, 12 Nov 2019 08:37:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 08:37:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iURgD-00012N-MS; Tue, 12 Nov 2019 00:37:41 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iURg8-00052T-Ky; Tue, 12 Nov 2019 00:37:36 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAC8bUbh011974;
        Tue, 12 Nov 2019 00:37:30 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iURg2-000528-BJ; Tue, 12 Nov 2019 00:37:30 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     michal.simek@xilinx.com, jolly.shah@xilinx.com,
        nava.manne@xilinx.com, ravi.patel@xilinx.com,
        tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] drivers: firmware: xilinx: Add support for feature check
Date:   Tue, 12 Nov 2019 00:35:55 -0800
Message-Id: <1573547755-4779-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(189003)(199004)(6636002)(47776003)(2906002)(478600001)(50466002)(356004)(6666004)(476003)(126002)(4326008)(2616005)(486006)(426003)(44832011)(107886003)(26005)(7696005)(14444005)(51416003)(48376002)(186003)(336012)(36756003)(81166006)(70206006)(70586007)(81156014)(305945005)(8936002)(106002)(36386004)(8676002)(316002)(50226002)(5660300002)(16586007)(9786002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5095;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be06afd6-3616-480d-f7a4-08d7674b9584
X-MS-TrafficTypeDiagnostic: BYAPR02MB5095:
X-Microsoft-Antispam-PRVS: <BYAPR02MB509564C3129AEFA9B23CA3BAB7770@BYAPR02MB5095.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q1KRvmj2mvIOvrx0IvAaiVxiyCDzxmDBDkuXaWcwVCjPM5TuDHYwhTY1zWgS7yVwhTSPD5Jfe3eEMADsXYxZWYpIJaB6w0EheXYu+f43XPgtLXB2U0afYGitUuXeDCrn9O7zbEXzjzq0+wMb0WvYEnbXHsXZHi8UEMEWOI0YErs5l+1EkoD+PX6I1chUYVcWyJvgVYHO6bRZOezpvBjxrqBUz50CmTPktQHi/vkoAvO932Fzrr55bKGVjZoSXQgtPA2cFDJjBJmTf3mKxXBKH2sw086i/tlDvLyJwQ60qynu6MgDt1G4XkejczUf+s/rxUN9llCztozVe15yDrJ94J/p2Jf1Q1gz9KiMsMHcx27t9JoXpgFlP53WBIFsW8gYvHatPaj6fl6VnzWAg5utXl+fmV5gSmA1JJcSnf0UyW6epD/klQURtOqh3hPaiXw
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 08:37:42.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be06afd6-3616-480d-f7a4-08d7674b9584
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Patel <ravi.patel@xilinx.com>

Query for corresponding feature before calling EEMI API
from the driver.

Signed-off-by: Ravi Patel <ravi.patel@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  7 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 74d9f13..ecc339d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -26,6 +26,9 @@
 
 static const struct zynqmp_eemi_ops *eemi_ops_tbl;
 
+static bool feature_check_enabled;
+static u32 zynqmp_pm_features[PM_API_MAX];
+
 static const struct mfd_cell firmware_devs[] = {
 	{
 		.name = "zynqmp_power_controller",
@@ -44,6 +47,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	case XST_PM_SUCCESS:
 	case XST_PM_DOUBLE_REQ:
 		return 0;
+	case XST_PM_NO_FEATURE:
+		return -ENOTSUPP;
 	case XST_PM_NO_ACCESS:
 		return -EACCES;
 	case XST_PM_ABORT_SUSPEND:
@@ -129,6 +134,39 @@ static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
 }
 
 /**
+ * zynqmp_pm_feature() - Check weather given feature is supported or not
+ * @api_id:		API ID to check
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_feature(u32 api_id)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u64 smc_arg[2];
+
+	if (!feature_check_enabled)
+		return 0;
+
+	/* Return value if feature is already checked */
+	if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
+		return zynqmp_pm_features[api_id];
+
+	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
+	smc_arg[1] = api_id;
+
+	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
+	if (ret) {
+		zynqmp_pm_features[api_id] = PM_FEATURE_INVALID;
+		return PM_FEATURE_INVALID;
+	}
+
+	zynqmp_pm_features[api_id] = ret_payload[1];
+
+	return zynqmp_pm_features[api_id];
+}
+
+/**
  * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
  *			   caller function depending on the configuration
  * @pm_api_id:		Requested PM-API call
@@ -162,6 +200,9 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 	 */
 	u64 smc_arg[4];
 
+	if (zynqmp_pm_feature(pm_api_id) == PM_FEATURE_INVALID)
+		return -ENOTSUPP;
+
 	smc_arg[0] = PM_SIP_SVC | pm_api_id;
 	smc_arg[1] = ((u64)arg1 << 32) | arg0;
 	smc_arg[2] = ((u64)arg3 << 32) | arg2;
@@ -717,6 +758,8 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 		np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
 		if (!np)
 			return 0;
+
+		feature_check_enabled = true;
 	}
 	of_node_put(np);
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 74d710d..f0d4558 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -48,6 +48,10 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
 
+/* Feature check status */
+#define PM_FEATURE_INVALID		-1
+#define PM_FEATURE_UNCHECKED		0
+
 /*
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
@@ -78,11 +82,14 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE,
 	PM_CLOCK_SETPARENT,
 	PM_CLOCK_GETPARENT,
+	PM_FEATURE_CHECK = 63,
+	PM_API_MAX,
 };
 
 /* PMU-FW return status codes */
 enum pm_ret_status {
 	XST_PM_SUCCESS = 0,
+	XST_PM_NO_FEATURE = 19,
 	XST_PM_INTERNAL = 2000,
 	XST_PM_CONFLICT,
 	XST_PM_NO_ACCESS,
-- 
2.7.4

