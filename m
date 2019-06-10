Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1289C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AE32085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hLvP7x0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390589AbfFJNqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:46:11 -0400
Received: from mail-eopbgr730084.outbound.protection.outlook.com ([40.107.73.84]:15232
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390490AbfFJNpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxwi6c/RufAgHDd/B+jUdNiuYv/Qd/tnF77JZ7SB5bQ=;
 b=hLvP7x0cOPRBCrgvMuDFhGp4/6O2SEr7X/ZswijI4pS9rVnXCn+jvvv0ZI/AMMTLtlAVxt2kKfws/C57TYlHG/RJ7XiHdLhu95Jo3KqopkkB0eYvQ+hdnqJ7aFanwkQxyfXBYetkZY9KjA5kGX/Z2Ap5H88/7qsu9wAg/H/6riw=
Received: from MWHPR0201CA0021.namprd02.prod.outlook.com
 (2603:10b6:301:74::34) by SN6PR02MB4943.namprd02.prod.outlook.com
 (2603:10b6:805:99::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15; Mon, 10 Jun
 2019 13:45:38 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR0201CA0021.outlook.office365.com
 (2603:10b6:301:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Mon, 10 Jun 2019 13:45:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Mon, 10 Jun 2019 13:45:37 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 10 Jun 2019 14:45:31 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 10 Jun 2019 14:45:31 +0100
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
Received: from [149.199.110.15] (port=49286 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1haKc7-00074r-HF; Mon, 10 Jun 2019 14:45:31 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V6 09/11] misc: xilinx_sdfec: Add stats & status ioctls
Date:   Mon, 10 Jun 2019 14:45:12 +0100
Message-ID: <1560174314-124649-10-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(486006)(47776003)(60926002)(50466002)(8936002)(26826003)(11346002)(5660300002)(26005)(48376002)(2201001)(2616005)(446003)(956004)(186003)(110136005)(54906003)(106002)(246002)(44832011)(28376004)(76176011)(6666004)(356004)(476003)(50226002)(426003)(71366001)(76130400001)(14444005)(7636002)(316002)(305945005)(16586007)(36756003)(126002)(70206006)(51416003)(7696005)(2906002)(478600001)(8676002)(36906005)(336012)(70586007)(107886003)(4326008)(9786002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4943;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d5d266-3b6f-4df6-0541-08d6eda9ebb9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB4943;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4943:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4943CFEA1223B904DA1DF41CCB130@SN6PR02MB4943.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9naKTMg6vgiev+4/HFkfhuUpbL0LMYntHSDVjseNwdBh0FUfhrBhlrh1HHoQ9iBoxscccTS4FfWU0uu4uJ7JHmkJ3W8AZWQcQ90R9y1aj4OnBRh49LBFefznzIiEuzPgjpEE71su5GkcY0Z4nV78Tpi9hT10nU1mCLldL+Ky2X6jq1ugyybAUXSoJRpPD7MpgO5Vbl8R225pMDLJbO4nUV6AJLQD91BLQTCT+btJ9VH57xTNPPOzmJHyvf5fDiBgObPewrGBrtmZFHJPuXm7QMksSXCMMv69/gvEvTwRgvnmMMHb7pMJvg2B1UjCayVwKXXX5/+y+phuWrniCHApZ5SoSpxXptHztpivuD7r4uDvZbxeD5e4Q2/bF3V0yidjo5JInnOUPwPiT9E4mCk2D8rd7cv0SP5WC6EtK1ubjjE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 13:45:37.7919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d5d266-3b6f-4df6-0541-08d6eda9ebb9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD-FEC statistic data are:
- count of data interface errors (isr_err_count)
- count of Correctable ECC errors (cecc_count)
- count of Uncorrectable ECC errors (uecc_count)

Add support:
1. clear stats ioctl callback which clears collected
statistic data,
2. get stats ioctl callback which reads a collected
statistic data,
3. set default configuration ioctl callback,
4. start ioctl callback enables SD-FEC HW,
5. stop ioctl callback disables SD-FEC HW.

In a failed state driver enables the following ioctls:
- get status
- get statistics
- clear stats
- set default SD-FEC device configuration

Tested-by: Santhosh Dyavanapally <SDYAVANA@xilinx.com>
Tested by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Tested-by: Derek Kiernan <derek.kiernan@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 125 +++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h |  75 +++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 040dc59..881f464 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -193,6 +193,7 @@ struct xsdfec_clks {
  * @dev: pointer to device struct
  * @state: State of the SDFEC device
  * @config: Configuration of the SDFEC device
+ * @intr_enabled: indicates IRQ enabled
  * @state_updated: indicates State updated by interrupt handler
  * @stats_updated: indicates Stats updated by interrupt handler
  * @isr_err_count: Count of ISR errors
@@ -213,6 +214,7 @@ struct xsdfec_dev {
 	struct device *dev;
 	enum xsdfec_state state;
 	struct xsdfec_config config;
+	bool intr_enabled;
 	bool state_updated;
 	bool stats_updated;
 	u32 isr_err_count;
@@ -288,6 +290,25 @@ static void update_config_from_hw(struct xsdfec_dev *xsdfec)
 		xsdfec->state = XSDFEC_STOPPED;
 }
 
+static int xsdfec_get_status(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	struct xsdfec_status status;
+	int err;
+
+	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
+	status.state = xsdfec->state;
+	xsdfec->state_updated = false;
+	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
+	status.activity = (xsdfec_regread(xsdfec, XSDFEC_ACTIVE_ADDR) &
+			   XSDFEC_IS_ACTIVITY_SET);
+
+	err = copy_to_user(arg, &status, sizeof(status));
+	if (err)
+		err = -EFAULT;
+
+	return err;
+}
+
 static int xsdfec_get_config(struct xsdfec_dev *xsdfec, void __user *arg)
 {
 	int err;
@@ -839,6 +860,82 @@ static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
 	return 0;
 }
 
+static int xsdfec_start(struct xsdfec_dev *xsdfec)
+{
+	u32 regread;
+
+	regread = xsdfec_regread(xsdfec, XSDFEC_FEC_CODE_ADDR);
+	regread &= 0x1;
+	if (regread != xsdfec->config.code) {
+		dev_dbg(xsdfec->dev,
+			"%s SDFEC HW code does not match driver code, reg %d, code %d",
+			__func__, regread, xsdfec->config.code);
+		return -EINVAL;
+	}
+
+	/* Set AXIS enable */
+	xsdfec_regwrite(xsdfec, XSDFEC_AXIS_ENABLE_ADDR,
+			XSDFEC_AXIS_ENABLE_MASK);
+	/* Done */
+	xsdfec->state = XSDFEC_STARTED;
+	return 0;
+}
+
+static int xsdfec_stop(struct xsdfec_dev *xsdfec)
+{
+	u32 regread;
+
+	if (xsdfec->state != XSDFEC_STARTED)
+		dev_dbg(xsdfec->dev, "Device not started correctly");
+	/* Disable AXIS_ENABLE Input interfaces only */
+	regread = xsdfec_regread(xsdfec, XSDFEC_AXIS_ENABLE_ADDR);
+	regread &= (~XSDFEC_AXIS_IN_ENABLE_MASK);
+	xsdfec_regwrite(xsdfec, XSDFEC_AXIS_ENABLE_ADDR, regread);
+	/* Stop */
+	xsdfec->state = XSDFEC_STOPPED;
+	return 0;
+}
+
+static int xsdfec_clear_stats(struct xsdfec_dev *xsdfec)
+{
+	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
+	xsdfec->isr_err_count = 0;
+	xsdfec->uecc_count = 0;
+	xsdfec->cecc_count = 0;
+	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
+
+	return 0;
+}
+
+static int xsdfec_get_stats(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	int err;
+	struct xsdfec_stats user_stats;
+
+	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
+	user_stats.isr_err_count = xsdfec->isr_err_count;
+	user_stats.cecc_count = xsdfec->cecc_count;
+	user_stats.uecc_count = xsdfec->uecc_count;
+	xsdfec->stats_updated = false;
+	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
+
+	err = copy_to_user(arg, &user_stats, sizeof(user_stats));
+	if (err)
+		err = -EFAULT;
+
+	return err;
+}
+
+static int xsdfec_set_default_config(struct xsdfec_dev *xsdfec)
+{
+	/* Ensure registers are aligned with core configuration */
+	xsdfec_regwrite(xsdfec, XSDFEC_FEC_CODE_ADDR, xsdfec->config.code);
+	xsdfec_cfg_axi_streams(xsdfec);
+	update_config_from_hw(xsdfec);
+
+	return 0;
+}
+
 static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 			     unsigned long data)
 {
@@ -848,6 +945,16 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 
 	xsdfec = container_of(fptr->private_data, struct xsdfec_dev, miscdev);
 
+	/* In failed state allow only reset and get status IOCTLs */
+	if (xsdfec->state == XSDFEC_NEEDS_RESET &&
+	    (cmd != XSDFEC_SET_DEFAULT_CONFIG && cmd != XSDFEC_GET_STATUS &&
+	     cmd != XSDFEC_GET_STATS && cmd != XSDFEC_CLEAR_STATS)) {
+		return -EPERM;
+	}
+
+	if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
+		return -ENOTTY;
+
 	/* check if ioctl argument is present and valid */
 	if (_IOC_DIR(cmd) != _IOC_NONE) {
 		arg = (void __user *)data;
@@ -856,9 +963,27 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	}
 
 	switch (cmd) {
+	case XSDFEC_START_DEV:
+		rval = xsdfec_start(xsdfec);
+		break;
+	case XSDFEC_STOP_DEV:
+		rval = xsdfec_stop(xsdfec);
+		break;
+	case XSDFEC_CLEAR_STATS:
+		rval = xsdfec_clear_stats(xsdfec);
+		break;
+	case XSDFEC_GET_STATS:
+		rval = xsdfec_get_stats(xsdfec, arg);
+		break;
+	case XSDFEC_GET_STATUS:
+		rval = xsdfec_get_status(xsdfec, arg);
+		break;
 	case XSDFEC_GET_CONFIG:
 		rval = xsdfec_get_config(xsdfec, arg);
 		break;
+	case XSDFEC_SET_DEFAULT_CONFIG:
+		rval = xsdfec_set_default_config(xsdfec);
+		break;
 	case XSDFEC_SET_IRQ:
 		rval = xsdfec_set_irq(xsdfec, arg);
 		break;
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index 59ee10c..31a9110 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -234,6 +234,21 @@ struct xsdfec_config {
 };
 
 /**
+ * struct xsdfec_stats - Stats retrived by ioctl XSDFEC_GET_STATS. Used
+ *			 to buffer atomic_t variables from struct
+ *			 xsdfec_dev. Counts are accumulated until
+ *			 the user clears them.
+ * @isr_err_count: Count of ISR errors
+ * @cecc_count: Count of Correctable ECC errors (SBE)
+ * @uecc_count: Count of Uncorrectable ECC errors (MBE)
+ */
+struct xsdfec_stats {
+	__u32 isr_err_count;
+	__u32 cecc_count;
+	__u32 uecc_count;
+};
+
+/**
  * struct xsdfec_ldpc_param_table_sizes - Used to store sizes of SD-FEC table
  *					  entries for an individual LPDC code
  *					  parameter.
@@ -252,6 +267,32 @@ struct xsdfec_ldpc_param_table_sizes {
  */
 #define XSDFEC_MAGIC 'f'
 /**
+ * DOC: XSDFEC_START_DEV
+ *
+ * @Description
+ *
+ * ioctl to start SD-FEC core
+ *
+ * This fails if the XSDFEC_SET_ORDER ioctl has not been previously called
+ */
+#define XSDFEC_START_DEV _IO(XSDFEC_MAGIC, 0)
+/**
+ * DOC: XSDFEC_STOP_DEV
+ *
+ * @Description
+ *
+ * ioctl to stop the SD-FEC core
+ */
+#define XSDFEC_STOP_DEV _IO(XSDFEC_MAGIC, 1)
+/**
+ * DOC: XSDFEC_GET_STATUS
+ *
+ * @Description
+ *
+ * ioctl that returns status of SD-FEC core
+ */
+#define XSDFEC_GET_STATUS _IOR(XSDFEC_MAGIC, 2, struct xsdfec_status)
+/**
  * DOC: XSDFEC_SET_IRQ
  * @Parameters
  *
@@ -370,4 +411,38 @@ struct xsdfec_ldpc_param_table_sizes {
  * ioctl that determines if SD-FEC is processing data
  */
 #define XSDFEC_IS_ACTIVE _IOR(XSDFEC_MAGIC, 10, bool)
+/**
+ * DOC: XSDFEC_CLEAR_STATS
+ *
+ * @Description
+ *
+ * ioctl that clears error stats collected during interrupts
+ */
+#define XSDFEC_CLEAR_STATS _IO(XSDFEC_MAGIC, 11)
+/**
+ * DOC: XSDFEC_GET_STATS
+ * @Parameters
+ *
+ * @struct xsdfec_stats *
+ *	Pointer to the &struct xsdfec_stats that will contain the updated stats
+ *	values
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC core stats
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_GET_STATS _IOR(XSDFEC_MAGIC, 12, struct xsdfec_stats)
+/**
+ * DOC: XSDFEC_SET_DEFAULT_CONFIG
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC core to default config, use after a reset
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_DEFAULT_CONFIG _IO(XSDFEC_MAGIC, 13)
+
 #endif /* __XILINX_SDFEC_H__ */
-- 
2.7.4

