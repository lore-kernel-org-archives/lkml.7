Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E47C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417B2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ql/6Rrup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDIKHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:46 -0400
Received: from mail-eopbgr820071.outbound.protection.outlook.com ([40.107.82.71]:42451
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfDIKHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12YiFtkZsJC4GzgUt1sNMf9elPT76KAOk1R67yYYVeY=;
 b=Ql/6RrupxxXFkDYrIju7Tkzhi1B0QM2QrQzpY6PfEG5AsYNcgWEK2xrdQ1V1oeGONJzDDy+uEaYMdni+I1MeLLfdnCjpARCccMBneJqWBYFXcr3jZ96pRInFaBtEBNAoJYkbhCGgVvmkLYiYBTucG8bMgxd7uaS+moeZVzgw5og=
Received: from BYAPR02CA0034.namprd02.prod.outlook.com (2603:10b6:a02:ee::47)
 by MW2PR02MB3835.namprd02.prod.outlook.com (2603:10b6:907:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.16; Tue, 9 Apr
 2019 10:07:17 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BYAPR02CA0034.outlook.office365.com
 (2603:10b6:a02:ee::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:16 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 9 Apr 2019 11:07:04 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 9 Apr 2019 11:07:04 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=57788 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hDnei-0007SJ-Nh; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 10/12] misc: xilinx_sdfec: Add stats & status ioctls
Date:   Tue, 9 Apr 2019 11:06:52 +0100
Message-ID: <1554804414-206099-11-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(199004)(189003)(47776003)(2616005)(486006)(50466002)(48376002)(11346002)(246002)(478600001)(2906002)(476003)(446003)(8936002)(9786002)(956004)(36906005)(186003)(336012)(316002)(106002)(110136005)(76176011)(305945005)(54906003)(4326008)(426003)(7636002)(16586007)(51416003)(7696005)(50226002)(14444005)(28376004)(93146003)(126002)(26826003)(36756003)(106466001)(71366001)(107886003)(8676002)(26005)(76130400001)(60926002)(5660300002)(356004)(44832011)(6666004)(2201001)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3835;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df639873-3c19-4323-8106-08d6bcd3254f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:MW2PR02MB3835;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3835:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB3835B835DB17EF9206945A5ACB2D0@MW2PR02MB3835.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kVKdrP09UuXG70wKFFB3fpk8/iPZKiKSOOagBJTpLMA1mn+6cR7dmx2nvV536orSoaeW6vIaIe0FfnB3mmZhrbdonhvPCt747TwtjD1fmW9BR0fjatbMHYK7yRcuiFQbO5p2zJreU5JTQcsjUSH7AKS0jktQihQsRh59fd2dzUtwPnLT3jTkWn9FDTqM6tlPLLDQaCVsGco9VgZgX/6KzXgVzkM49wE5NSRavRaO1QK4VIqldskN+b+Ug2rNR2+wRl/akD2qH5xaw0Kt2b1sJT3poEsY/Fuj7Q9v4GFr/5TP3LgKoJaLK1ABohmIqOVbJc8qxY6tuN4cjWz9OquCzFx6IwaXr+3wUp25ITM3rIIauzjKIhpZoOWjwJ88OlQ7bAJzrMTGhrtYVCoKakr1qTenZ+vuDvY4hsL9siRWzB0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:16.7981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df639873-3c19-4323-8106-08d6bcd3254f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3835
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
 drivers/misc/xilinx_sdfec.c      | 123 +++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h |  75 ++++++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 32b2e2d..317c5c4 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -203,6 +203,7 @@ struct xsdfec_clks {
  * @dev: pointer to device struct
  * @state: State of the SDFEC device
  * @config: Configuration of the SDFEC device
+ * @intr_enabled: indicates IRQ enabled
  * @state_updated: indicates State updated by interrupt handler
  * @stats_updated: indicates Stats updated by interrupt handler
  * @isr_err_count: Count of ISR errors
@@ -222,6 +223,7 @@ struct xsdfec_dev {
 	struct device *dev;
 	enum xsdfec_state state;
 	struct xsdfec_config config;
+	bool intr_enabled;
 	bool state_updated;
 	bool stats_updated;
 	atomic_t isr_err_count;
@@ -320,6 +322,26 @@ static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
 	return 0;
 }
 
+static int xsdfec_get_status(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	struct xsdfec_status status;
+	int err;
+
+	status.fec_id = xsdfec->config.fec_id;
+	spin_lock_irq(&xsdfec->irq_lock);
+	status.state = xsdfec->state;
+	xsdfec->state_updated = false;
+	spin_unlock_irq(&xsdfec->irq_lock);
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
@@ -896,6 +918,80 @@ static int xsdfec_cfg_axi_streams(struct xsdfec_dev *xsdfec)
 	return 0;
 }
 
+static int xsdfec_start(struct xsdfec_dev *xsdfec)
+{
+	u32 regread;
+
+	regread = xsdfec_regread(xsdfec, XSDFEC_FEC_CODE_ADDR);
+	regread &= 0x1;
+	if (regread != xsdfec->config.code) {
+		dev_err(xsdfec->dev,
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
+		dev_err(xsdfec->dev, "Device not started correctly");
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
+	atomic_set(&xsdfec->isr_err_count, 0);
+	atomic_set(&xsdfec->uecc_count, 0);
+	atomic_set(&xsdfec->cecc_count, 0);
+
+	return 0;
+}
+
+static int xsdfec_get_stats(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	int err;
+	struct xsdfec_stats user_stats;
+
+	spin_lock_irq(&xsdfec->irq_lock);
+	user_stats.isr_err_count = atomic_read(&xsdfec->isr_err_count);
+	user_stats.cecc_count = atomic_read(&xsdfec->cecc_count);
+	user_stats.uecc_count = atomic_read(&xsdfec->uecc_count);
+	xsdfec->stats_updated = false;
+	spin_unlock_irq(&xsdfec->irq_lock);
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
@@ -907,6 +1003,15 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	if (!xsdfec)
 		return rval;
 
+	/* In failed state allow only reset and get status IOCTLs */
+	if (xsdfec->state == XSDFEC_NEEDS_RESET &&
+	    (cmd != XSDFEC_SET_DEFAULT_CONFIG && cmd != XSDFEC_GET_STATUS &&
+	     cmd != XSDFEC_GET_STATS && cmd != XSDFEC_CLEAR_STATS)) {
+		dev_err(xsdfec->dev, "SDFEC%d in failed state. Reset Required",
+			xsdfec->config.fec_id);
+		return -EPERM;
+	}
+
 	if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
 		return -ENOTTY;
 
@@ -926,9 +1031,27 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
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
index 7dd9495..7f7e229 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -240,6 +240,21 @@ struct xsdfec_config {
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
+	u32 isr_err_count;
+	u32 cecc_count;
+	u32 uecc_count;
+};
+
+/**
  * struct xsdfec_ldpc_param_table_sizes - Used to store sizes of SD-FEC table
  *					  entries for an individual LPDC code
  *					  parameter.
@@ -279,6 +294,32 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
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
@@ -397,4 +438,38 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
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

