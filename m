Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C542086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dH/+BLje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbfFKJ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:57:21 -0400
Received: from mail-eopbgr740083.outbound.protection.outlook.com ([40.107.74.83]:65152
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbfFKJ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3brkG15xLingG3mRXEA8jdLqGp0HAD2p+rpmjo1QiU=;
 b=dH/+BLjeAlwIke8S5tJUABjhJg6QqHfQ8LCd+MOIYomC0EJwtI5hZsfq29yU3tnJHCItYzmG9ThycqAhXy6+VNHbUNnts5DC4ffYEjASNNqgtbyQsyquh1qNvdFLrrIL6b5/Eso7nVA0Y0hp5o2DIn/wwBQMEiDxdrnEQPi97jA=
Received: from MWHPR0201CA0039.namprd02.prod.outlook.com
 (2603:10b6:301:73::16) by DM5PR02MB2682.namprd02.prod.outlook.com
 (2603:10b6:3:108::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Tue, 11 Jun
 2019 09:57:16 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0039.outlook.office365.com
 (2603:10b6:301:73::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Tue, 11 Jun 2019 09:57:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Tue, 11 Jun 2019 09:57:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46268 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hadWk-0006ss-5m; Tue, 11 Jun 2019 02:57:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hadWf-0002WX-1y; Tue, 11 Jun 2019 02:57:09 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5B9v0ao016627;
        Tue, 11 Jun 2019 02:57:01 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hadWW-0002Qq-AT; Tue, 11 Jun 2019 02:57:00 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 8005E12174A; Tue, 11 Jun 2019 15:26:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        nava.manne@xilinx.com, manish.narani@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] firmware: xilinx: Add SDIO Tap Delay API
Date:   Tue, 11 Jun 2019 15:26:49 +0530
Message-Id: <1560247011-26369-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(199004)(189003)(48376002)(8676002)(126002)(8936002)(63266004)(50466002)(476003)(6266002)(44832011)(2616005)(5660300002)(305945005)(51416003)(336012)(426003)(446003)(81156014)(76176011)(52956003)(81166006)(11346002)(2906002)(356004)(26005)(106002)(6666004)(70586007)(72206003)(16586007)(42186006)(316002)(36756003)(70206006)(103686004)(36386004)(47776003)(50226002)(478600001)(486006)(14444005)(186003)(4326008)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2682;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ca211fe-68bc-4e72-4936-08d6ee532ead
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR02MB2682;
X-MS-TrafficTypeDiagnostic: DM5PR02MB2682:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2682E6EB5D6330848DAD3590C1ED0@DM5PR02MB2682.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ykGTWxa4ZR5sg1KWPkM4nDVK3yKxZPN820+DTj5qAx5lYIJd3xnHrg7fXpFXphT9lYxclWwJdztB21woymt0pj57m2GzKBnbDq8ix46QGZYp0A8noSzS3obqDKUjr8E1jLvDDCZXQE/ASn4S8T0DzOhindfXQjrizQsnaNCMCGgElYLcVkufaGCa1UyIFLQqNluHn83wlSRIHPGqYocT7p5IvyaSy1mxit1fLFKkkXGWy3YBHG3x2V6iaEUa7V+1f9i0VQiUMUYDenp/EaV7T5IxPk8kDfCcbkgu3Vd4myRc0Cx17LKOgsBHS6dcP5kfd1zjnayt33gUMFGVf7ygBeoVvdFT9/pbHN/tTa5uPaFAWHHhvy46vGVnE8pENymhbazeIvMsJngZ4bGA6Yeyj3sLcnB3MYZzAuRUIA8GnXg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 09:57:14.6543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca211fe-68bc-4e72-4936-08d6ee532ead
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API for setting SDIO Tap Delays on ZynqMP platforms.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 32 ++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 17 ++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index fd3d837..c6f9e72 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -664,6 +664,37 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 				   qos, ack, NULL);
 }
 
+/**
+ * zynqmp_pm_sdio_setphase() - PM call to set clock delays for SD clock
+ * @device_id:		Device ID of the SD controller
+ * @degrees:		Tap Delay value in degrees for Input/Output clocks
+ *
+ * This API function is to be used for setting the clock delays for SD
+ * clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_sdio_setphase(u32 device_id, int degrees)
+{
+	u32 node_id = (!device_id) ? NODE_SD_0 : NODE_SD_1;
+	enum tap_delay_type tap_type;
+	int ret;
+
+	if (degrees < INPUT_TAP_BOUNDARY) {
+		tap_type = PM_TAPDELAY_INPUT;
+	} else {
+		tap_type = PM_TAPDELAY_OUTPUT;
+		degrees -= INPUT_TAP_BOUNDARY;
+	}
+
+	ret = zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, tap_type,
+			      degrees, NULL);
+	if (ret)
+		pr_err("Error setting Tap Delay\n");
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.get_chipid = zynqmp_pm_get_chipid,
@@ -687,6 +718,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
+	.sdio_setphase = zynqmp_pm_sdio_setphase,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1262ea6..0fc4bf7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -56,6 +56,9 @@
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
 
+/* Input Tap Delay Boundary Value */
+#define INPUT_TAP_BOUNDARY		0x100
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REQUEST_NODE = 13,
@@ -92,7 +95,8 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
-	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_SET_SD_TAPDELAY = 7,
+	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
@@ -251,6 +255,16 @@ enum zynqmp_pm_request_ack {
 	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
 };
 
+enum pm_node_id {
+	NODE_SD_0 = 39,
+	NODE_SD_1,
+};
+
+enum tap_delay_type {
+	PM_TAPDELAY_INPUT = 0,
+	PM_TAPDELAY_OUTPUT,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -295,6 +309,7 @@ struct zynqmp_eemi_ops {
 			       const u32 capabilities,
 			       const u32 qos,
 			       const enum zynqmp_pm_request_ack ack);
+	int (*sdio_setphase)(u32 device_id, int degrees);
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-- 
2.1.1

