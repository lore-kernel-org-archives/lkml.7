Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A983FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CLwFQ/3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406189AbfFKRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:30:04 -0400
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:46848
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406114AbfFKR35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf4fGS5YwaVbK+ZyRGE02u+VGUWPOY7u/wQIVleAlKo=;
 b=CLwFQ/3TKGWVIUsLMsPD8Ypd+RlXlAAsiEsE7Txcfy+YvO165bl63BMj3UWHOI15jKu9BhujqXtZi1AzhjMC6yO6wSIW/4pvG2sCDINXx/kL7ZvM90vqYGMt/O5m/dyb/j92aJugTBYu8xhcGZ13hE0/nXyF8yL5c6U5yOdFK1s=
Received: from BN6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:405:60::37)
 by DM6PR02MB6236.namprd02.prod.outlook.com (2603:10b6:5:1d1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Tue, 11 Jun
 2019 17:29:54 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR02CA0096.outlook.office365.com
 (2603:10b6:405:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.13 via Frontend
 Transport; Tue, 11 Jun 2019 17:29:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Tue, 11 Jun 2019 17:29:53 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Jun 2019 18:29:48 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Jun 2019 18:29:48 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 mark.rutland@arm.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=50346 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hakai-0002MF-QE; Tue, 11 Jun 2019 18:29:48 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V7 07/11] misc: xilinx_sdfec: Add ability to get/set config
Date:   Tue, 11 Jun 2019 18:29:41 +0100
Message-ID: <1560274185-264438-8-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(189003)(199004)(478600001)(14444005)(356004)(6666004)(26826003)(956004)(476003)(336012)(2616005)(44832011)(48376002)(126002)(486006)(446003)(11346002)(426003)(50466002)(50226002)(2906002)(8676002)(28376004)(246002)(70206006)(76130400001)(71366001)(316002)(16586007)(54906003)(4326008)(110136005)(60926002)(7636002)(305945005)(5660300002)(70586007)(47776003)(36756003)(106002)(2201001)(36906005)(9786002)(51416003)(76176011)(8936002)(107886003)(7696005)(186003)(26005)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6236;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74854048-7067-4e53-82fb-08d6ee926a5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB6236;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6236:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB623607EF11A6F39B8A4F9375CBED0@DM6PR02MB6236.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kBYBRmxQKrABzOoelkzYL84jfK4JfgZLTzwdRs07rwLl3r6EGUGpOuV/KnwOgSmvpCQ68SmXDABEOlOIuvi93GmOWvnNzXpErgRNfV3XNUAhZraAHQLBn+FelIaZs7ubeU9YaSHCTquDW2LctwrQTj3RkTj8TCWpPxf6tVsHS6Ro8pCWXwGwN2jn53MMgg8mcKlfbhjciJN1spuFdl2eTq2tnvTCgDDwOXitZGSlWWrMCRk4s23gp2HnbH2fyGzKgtgoa5fzN1dBw6fnU+dRmOTop8+dpARAfve7Cq1i0Nqp5yrP5CcbGpmYS6sluoUV5p3l082txqqei86PCCmMDz/wEHKhroDFWipk890rHk1aKTa/gS7ArRGw9totWZx7Fqu0DEpcxIeF9j//dyfiUrSiwWAwoZDf22Nya5pzmK4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 17:29:53.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74854048-7067-4e53-82fb-08d6ee926a5f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add capability to get SD-FEC config data using ioctl
XSDFEC_GET_CONFIG.

- Add capability to set SD-FEC data order using ioctl
SDFEC_SET_ORDER.

- Add capability to set SD-FEC bypass option using ioctl
XSDFEC_SET_BYPASS.

- Add capability to set SD-FEC active state using ioctl
XSDFEC_IS_ACTIVE.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 88 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h | 57 ++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index b2b16771..83de77e 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -273,6 +273,17 @@ static void update_config_from_hw(struct xsdfec_dev *xsdfec)
 		xsdfec->state = XSDFEC_STOPPED;
 }
 
+static int xsdfec_get_config(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	int err;
+
+	err = copy_to_user(arg, &xsdfec->config, sizeof(xsdfec->config));
+	if (err)
+		err = -EFAULT;
+
+	return err;
+}
+
 static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
 {
 	struct xsdfec_turbo turbo;
@@ -591,6 +602,71 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
 	return ret;
 }
 
+static int xsdfec_set_order(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	bool order_invalid;
+	enum xsdfec_order order;
+	int err;
+
+	err = get_user(order, (enum xsdfec_order *)arg);
+	if (err)
+		return -EFAULT;
+
+	order_invalid = (order != XSDFEC_MAINTAIN_ORDER) &&
+			(order != XSDFEC_OUT_OF_ORDER);
+	if (order_invalid)
+		return -EINVAL;
+
+	/* Verify Device has not started */
+	if (xsdfec->state == XSDFEC_STARTED)
+		return -EIO;
+
+	xsdfec_regwrite(xsdfec, XSDFEC_ORDER_ADDR, order);
+
+	xsdfec->config.order = order;
+
+	return 0;
+}
+
+static int xsdfec_set_bypass(struct xsdfec_dev *xsdfec, bool __user *arg)
+{
+	bool bypass;
+	int err;
+
+	err = get_user(bypass, arg);
+	if (err)
+		return -EFAULT;
+
+	/* Verify Device has not started */
+	if (xsdfec->state == XSDFEC_STARTED)
+		return -EIO;
+
+	if (bypass)
+		xsdfec_regwrite(xsdfec, XSDFEC_BYPASS_ADDR, 1);
+	else
+		xsdfec_regwrite(xsdfec, XSDFEC_BYPASS_ADDR, 0);
+
+	xsdfec->config.bypass = bypass;
+
+	return 0;
+}
+
+static int xsdfec_is_active(struct xsdfec_dev *xsdfec, bool __user *arg)
+{
+	u32 reg_value;
+	bool is_active;
+	int err;
+
+	reg_value = xsdfec_regread(xsdfec, XSDFEC_ACTIVE_ADDR);
+	/* using a double ! operator instead of casting */
+	is_active = !!(reg_value & XSDFEC_IS_ACTIVITY_SET);
+	err = put_user(is_active, arg);
+	if (err)
+		return -EFAULT;
+
+	return err;
+}
+
 static u32
 xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
 {
@@ -681,6 +757,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	}
 
 	switch (cmd) {
+	case XSDFEC_GET_CONFIG:
+		rval = xsdfec_get_config(xsdfec, arg);
+		break;
 	case XSDFEC_SET_TURBO:
 		rval = xsdfec_set_turbo(xsdfec, arg);
 		break;
@@ -690,6 +769,15 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	case XSDFEC_ADD_LDPC_CODE_PARAMS:
 		rval = xsdfec_add_ldpc(xsdfec, arg);
 		break;
+	case XSDFEC_SET_ORDER:
+		rval = xsdfec_set_order(xsdfec, arg);
+		break;
+	case XSDFEC_SET_BYPASS:
+		rval = xsdfec_set_bypass(xsdfec, arg);
+		break;
+	case XSDFEC_IS_ACTIVE:
+		rval = xsdfec_is_active(xsdfec, (bool __user *)arg);
+		break;
 	default:
 		/* Should not get here */
 		break;
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index 7443ed8..163dff6 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -288,6 +288,19 @@ struct xsdfec_ldpc_param_table_sizes {
 #define XSDFEC_ADD_LDPC_CODE_PARAMS                                            \
 	_IOW(XSDFEC_MAGIC, 5, struct xsdfec_ldpc_params)
 /**
+ * DOC: XSDFEC_GET_CONFIG
+ * @Parameters
+ *
+ * @struct xsdfec_config *
+ *	Pointer to the &struct xsdfec_config that contains the current
+ *	configuration settings of the SD-FEC Block
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC core configuration
+ */
+#define XSDFEC_GET_CONFIG _IOR(XSDFEC_MAGIC, 6, struct xsdfec_config)
+/**
  * DOC: XSDFEC_GET_TURBO
  * @Parameters
  *
@@ -300,4 +313,48 @@ struct xsdfec_ldpc_param_table_sizes {
  * ioctl that returns SD-FEC turbo param values
  */
 #define XSDFEC_GET_TURBO _IOR(XSDFEC_MAGIC, 7, struct xsdfec_turbo)
+/**
+ * DOC: XSDFEC_SET_ORDER
+ * @Parameters
+ *
+ * @struct unsigned long *
+ *	Pointer to the unsigned long that contains a value from the
+ *	@enum xsdfec_order
+ *
+ * @Description
+ *
+ * ioctl that sets order, if order of blocks can change from input to output
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_ORDER _IOW(XSDFEC_MAGIC, 8, unsigned long)
+/**
+ * DOC: XSDFEC_SET_BYPASS
+ * @Parameters
+ *
+ * @struct bool *
+ *	Pointer to bool that sets the bypass value, where false results in
+ *	normal operation and false results in the SD-FEC performing the
+ *	configured operations (same number of cycles) but output data matches
+ *	the input data
+ *
+ * @Description
+ *
+ * ioctl that sets bypass.
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_BYPASS _IOW(XSDFEC_MAGIC, 9, bool)
+/**
+ * DOC: XSDFEC_IS_ACTIVE
+ * @Parameters
+ *
+ * @struct bool *
+ *	Pointer to bool that returns true if the SD-FEC is processing data
+ *
+ * @Description
+ *
+ * ioctl that determines if SD-FEC is processing data
+ */
+#define XSDFEC_IS_ACTIVE _IOR(XSDFEC_MAGIC, 10, bool)
 #endif /* __XILINX_SDFEC_H__ */
-- 
2.7.4

