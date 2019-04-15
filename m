Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A8E2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GVv5DV4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfDOHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:18:34 -0400
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:2291
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfDOHSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC9BgscH4gGqshx37wTfQWz43ztR2ITJd9cBbXiDiGU=;
 b=GVv5DV4LV8dHDm/g7gqpdM2gFhrCzdM64xeq83o0TryNs5Roak+fWggfy/CuTuWJn1K809s4Nf1Y/sAk8c8C6A0hE3UyJVRpi+9QvjlnMoJS1aOLH5PgACBa8sys8B8lrV+kNFPUxjBEl6zdWkJKyU4J0YAKOjJN7lAuZPDRtjQ=
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by MW2PR02MB3834.namprd02.prod.outlook.com (2603:10b6:907:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Mon, 15 Apr
 2019 07:18:30 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.15 via Frontend
 Transport; Mon, 15 Apr 2019 07:18:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 07:18:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41324 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsr-0004E8-0C; Mon, 15 Apr 2019 00:18:29 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsl-0006qj-Sw; Mon, 15 Apr 2019 00:18:23 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3F7IHpq029722;
        Mon, 15 Apr 2019 00:18:17 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvse-0006nQ-Ux; Mon, 15 Apr 2019 00:18:17 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 1/3] firmware: xilinx: Add fpga API's
Date:   Mon, 15 Apr 2019 12:47:46 +0530
Message-ID: <20190415071748.32275-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415071748.32275-1-nava.manne@xilinx.com>
References: <20190415071748.32275-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(189003)(199004)(2201001)(50226002)(50466002)(36386004)(81166006)(77096007)(81156014)(6666004)(356004)(486006)(8676002)(316002)(16586007)(336012)(476003)(478600001)(426003)(48376002)(8936002)(14444005)(126002)(9786002)(305945005)(110136005)(63266004)(106002)(47776003)(2616005)(36756003)(106466001)(51416003)(7696005)(186003)(26005)(2906002)(5660300002)(446003)(76176011)(11346002)(1076003)(921003)(1121003)(83996005)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3834;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb1fac1-9a3f-44f3-69b1-08d6c1728f8f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MW2PR02MB3834;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3834:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB38344ABBC084D4BC76AA268CC22B0@MW2PR02MB3834.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: rv3/bv0PJJdGfsWdK8WILZ0btJG/gCnTRQFf+jjYAV+Q9IDhDCVA4uhIqKwA30UynflrKnqZFmoi1jML27hUep7oJMksza2IjIQ8mFLyhpIVitVSrhL1ZSU8bGo63UZ5vExgRy0zCYWPHN0x3J0OStsDXH6xIRzDZADw0lojcrK6HGFGRoziPqGQ0c/SsyfYpXEYFJwx14N8XK9oKDL5rfmrgyqyXt5Mizfn/YeGylkeooCg3RbD+02ciZjvOiYN9K2ft5nnMUa+7VcO9g90qyRRd5l0r3qfJICGY1xBmkxyh+VKExT7iQMe5C7djdrb5xwFAhWAV1iLxP/vmTkl2e+80q25ySlkCJGDUzCu2vylxf/1M0gglwKmf6FnHpL9uVdPEZrOwLTnuHQwseiS7N9DUK54o/NJP1Yt8aib/dE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 07:18:29.6125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb1fac1-9a3f-44f3-69b1-08d6c1728f8f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---
Changes for v5:
		-Modified API's doc as suggested by Moritz.

 drivers/firmware/xilinx/zynqmp.c     | 45 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 98f936125643..f355ad42917c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -537,6 +537,49 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 	return ret;
 }
 
+/*
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:	Bitstream type
+ *	-XILINX_ZYNQMP_PM_FPGA_FULL:  FPGA full reconfiguration
+ *	-XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ *
+ * This function provides access to pmufw. To transfer
+ * the required bitstream into PL.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value: Value to read
+ *
+ * This function provides access to the pmufw to get the PCAP
+ * status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
 /**
  * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
  *			       master has initialized its own power management
@@ -640,6 +683,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
 	.set_requirement = zynqmp_pm_set_requirement,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 642dab10f65d..1b1de5539036 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -48,6 +48,14 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
 
+/*
+ * Firmware FPGA Manager flags
+ * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
+ * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ */
+#define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
+#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REQUEST_NODE = 13,
@@ -56,6 +64,8 @@ enum pm_api_id {
 	PM_RESET_ASSERT = 17,
 	PM_RESET_GET_STATUS,
 	PM_PM_INIT_FINALIZE = 21,
+	PM_FPGA_LOAD,
+	PM_FPGA_GET_STATUS,
 	PM_GET_CHIPID = 24,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
@@ -258,6 +268,8 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*get_chipid)(u32 *idcode, u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.18.0

