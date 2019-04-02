Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B7CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA120883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2644IwVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfDBMca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:32:30 -0400
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:15968
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728733AbfDBMc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmlV6vWcU8OeUEHHI1J5y2arp5RoIlmZiWip4ONrBAM=;
 b=2644IwVr6DUYJzk6ZnkGVUQ7wLl2D6g6uzq6knZELQU40Ft6JxmF1g93YI1ZhyXFrTPf9W4OLPdC9ggQgQ1rod6FR8bZrSvVcfXyiZiJVBbakYnACDZy+ElewXyw0dmlichR7mnoVBb7tiJEdjDpTunEWfNPRQGBwxlMJ55p2FM=
Received: from SN4PR0201CA0068.namprd02.prod.outlook.com
 (2603:10b6:803:20::30) by SN4PR0201MB3406.namprd02.prod.outlook.com
 (2603:10b6:803:48::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.20; Tue, 2 Apr
 2019 12:31:47 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0068.outlook.office365.com
 (2603:10b6:803:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.16 via Frontend
 Transport; Tue, 2 Apr 2019 12:31:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Tue, 2 Apr 2019 12:31:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZu-0003li-E5; Tue, 02 Apr 2019 05:31:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZp-0007Wo-AM; Tue, 02 Apr 2019 05:31:41 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZh-0007U9-CW; Tue, 02 Apr 2019 05:31:33 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
Date:   Tue, 2 Apr 2019 18:01:21 +0530
Message-ID: <20190402123123.915-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190402123123.915-1-nava.manne@xilinx.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(189003)(199004)(81166006)(336012)(316002)(426003)(126002)(106466001)(8676002)(486006)(356004)(47776003)(5660300002)(6666004)(81156014)(305945005)(478600001)(14444005)(106002)(36386004)(2201001)(9786002)(51416003)(36756003)(7696005)(11346002)(110136005)(2906002)(50226002)(476003)(1076003)(8936002)(77096007)(63266004)(26005)(50466002)(48376002)(16586007)(186003)(76176011)(446003)(2616005)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3406;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4642d5d0-bee5-470a-04a7-08d6b7672c53
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN4PR0201MB3406;
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3406:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3406D6DF82F9ACF8CD56650CC2560@SN4PR0201MB3406.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: W0lv8gql5iusY6q68JaZ4CxjR4/TiKU2Ij0iwemdbqFdl+07ZESmUTJwdLKlwNcOGqrFzvHMW0HpKw6hr6jIzY/aVgb8ARLxGMJWDtFIOUfme1y+ZbSXNk82t5MhpegaKqFEcGZxpyu+iPtyALz190Gnu5qpXtXpRqhAeD2Isv1F3tggTg7kpRBxIWn5MLNWUWUBl9+I/zQC0xpE5ePhC+Tqcfr9nlXJEB4vb2fVI2MZaw6qejseiQdP+mOYm4/0aSr7TnY8yPYK9V7ErZwxksaffVjUVL+uAh4Q4HhEk4WoYeoPr/5hqLTjYstj8sixHuq2g1a2jYURTTQcF78D8Os5dQ/H9yjuDBnO7IDWVmQDDQaHb7ggrw70jDj3twftAQav071gw9OIxsqZw221m/X2Ezl240r71KPZLfdTBZs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 12:31:47.0284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4642d5d0-bee5-470a-04a7-08d6b7672c53
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v4:
		-None.

Chnages for v3:
		-Created patches on top of 5.0-rc5.
		 No functional changes.

Changes for v2:
		-Added Firmware FPGA Manager flags As suggested by
		 Moritz.

Changes for v1:
		-None.

Changes for RFC-V2:
		-New Patch

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 10 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 98f936125643..7159a90abc44 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -537,6 +537,50 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 	return ret;
 }
 
+/*
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bitstream.
+ *		 1 - Partial Bitstream.
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
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
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
@@ -640,6 +684,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
 	.set_requirement = zynqmp_pm_set_requirement,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 642dab10f65d..4df226b6ab0f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -48,6 +48,12 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
 
+/*
+ * Firmware FPGA Manager flags
+ * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ */
+#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REQUEST_NODE = 13,
@@ -56,6 +62,8 @@ enum pm_api_id {
 	PM_RESET_ASSERT = 17,
 	PM_RESET_GET_STATUS,
 	PM_PM_INIT_FINALIZE = 21,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_GET_CHIPID = 24,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
@@ -258,6 +266,8 @@ struct zynqmp_pm_query_data {
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

