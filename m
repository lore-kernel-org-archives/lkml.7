Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED09C468BC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E44216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qgV3CmS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfFIAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 20:04:59 -0400
Received: from mail-eopbgr740083.outbound.protection.outlook.com ([40.107.74.83]:6464
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbfFIAEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 20:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHIO23OrfM+Yg/HDizZUxwqJkSmO4ppAVzEuSuniLo8=;
 b=qgV3CmS5LwSI45so0b1ik8MiqBVw3VFVbkXvKBcJLKRtCz61gqyYld10/b9+1E1bU4ug726770IChp7+rBN34rNMMaznmKYhtTpPHajwZoTAQo62UtPKPTGKqzcEuS9DMDaZMzC4ab0pwYxb0f2jfoHN7q4LeLg6F30ga0RGvTA=
Received: from CY4PR02CA0048.namprd02.prod.outlook.com (2603:10b6:903:117::34)
 by MN2PR02MB6238.namprd02.prod.outlook.com (2603:10b6:208:1bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Sun, 9 Jun
 2019 00:04:30 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR02CA0048.outlook.office365.com
 (2603:10b6:903:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Sun, 9 Jun 2019 00:04:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Sun, 9 Jun 2019 00:04:29 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sun, 9 Jun 2019 01:04:24 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sun, 9 Jun 2019 01:04:24 +0100
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
Received: from [149.199.110.15] (port=48046 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hZlJw-0001PN-9M; Sun, 09 Jun 2019 01:04:24 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V5 05/11] misc: xilinx_sdfec: Add ability to configure turbo
Date:   Sun, 9 Jun 2019 01:04:10 +0100
Message-ID: <1560038656-380620-6-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39850400004)(396003)(2980300002)(199004)(189003)(2906002)(36906005)(16586007)(47776003)(6666004)(356004)(316002)(26005)(5660300002)(51416003)(186003)(26826003)(14444005)(28376004)(107886003)(7696005)(9786002)(76176011)(478600001)(70206006)(336012)(70586007)(36756003)(426003)(7636002)(305945005)(60926002)(50226002)(4326008)(71366001)(8936002)(2201001)(446003)(126002)(50466002)(76130400001)(44832011)(8676002)(956004)(246002)(476003)(2616005)(11346002)(486006)(110136005)(54906003)(106002)(48376002)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6238;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 618c8514-a11f-463b-5d45-08d6ec6e0b4d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR02MB6238;
X-MS-TrafficTypeDiagnostic: MN2PR02MB6238:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MN2PR02MB623879418C87F486F04A5B66CB120@MN2PR02MB6238.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 006339698F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 9MoFwDyhQSrPMKuBY+sKDjd6kwNzG0GWTkvE7oM6Tzgs/Y3CoWbSn61nm51tqNtd7lBX8MiK2zK7lNSeDHrpGYH8Ysf203qe4d2NG2RLHe5g10Ifk6KMZKdizDnjEvMxjwzevYeufBKBLDIjnMWeOJDiMCUWcu+HGx1UdvBuG+jnaq4HBZtnNmyQBGyKOAVzlZPvnivKSn2GWvevMwWmPrLjPslcBLic9T8B14HtxXXdi96tD5qDtbVscCVucnhlEGn3giIbo59ym6RVm0yrLen6noCJJS904h8ZbuZYE1MWgdva9Iqs/DAOOjJk4gopIQztdHLthbPC2G+06gFFovyTBSTioQ4v2zMlc5A17iVVW2xNl/MYJyzDy0lFoF4DQ55+XiLMs7c76xnpwCZLrBDn8wQ9f6AC3jkosOwEba8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2019 00:04:29.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618c8514-a11f-463b-5d45-08d6ec6e0b4d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to configure and retrieve turbo mode
via the ioctls XSDFEC_SET_TURBO and XSDFEC_GET_TURBO.
Add char device interface per DT node present and support
file operations:
- open(),
- close(),
- unlocked_ioctl(),
- compat_ioctl().

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 110 +++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h |  67 ++++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index ddfca54..3b59c12 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -19,6 +19,7 @@
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
+#include <linux/compat.h>
 
 #include <uapi/misc/xilinx_sdfec.h>
 
@@ -103,6 +104,12 @@ static int xsdfec_ndevs;
 /* BYPASS Register */
 #define XSDFEC_BYPASS_ADDR (0x3C)
 
+/* Turbo Code Register */
+#define XSDFEC_TURBO_ADDR (0x100)
+#define XSDFEC_TURBO_SCALE_MASK (0xFFF)
+#define XSDFEC_TURBO_SCALE_BIT_POS (8)
+#define XSDFEC_TURBO_SCALE_MAX (15)
+
 /**
  * struct xsdfec_clks - For managing SD-FEC clocks
  * @core_clk: Main processing clock for core
@@ -207,6 +214,55 @@ static void update_config_from_hw(struct xsdfec_dev *xsdfec)
 		xsdfec->state = XSDFEC_STOPPED;
 }
 
+static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	struct xsdfec_turbo turbo;
+	int err;
+	u32 turbo_write;
+
+	err = copy_from_user(&turbo, arg, sizeof(turbo));
+	if (err)
+		return -EFAULT;
+
+	if (turbo.alg >= XSDFEC_TURBO_ALG_MAX)
+		return -EINVAL;
+
+	if (turbo.scale > XSDFEC_TURBO_SCALE_MAX)
+		return -EINVAL;
+
+	/* Check to see what device tree says about the FEC codes */
+	if (xsdfec->config.code == XSDFEC_LDPC_CODE)
+		return -EIO;
+
+	turbo_write = ((turbo.scale & XSDFEC_TURBO_SCALE_MASK)
+		       << XSDFEC_TURBO_SCALE_BIT_POS) |
+		      turbo.alg;
+	xsdfec_regwrite(xsdfec, XSDFEC_TURBO_ADDR, turbo_write);
+	return err;
+}
+
+static int xsdfec_get_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	u32 reg_value;
+	struct xsdfec_turbo turbo_params;
+	int err;
+
+	if (xsdfec->config.code == XSDFEC_LDPC_CODE)
+		return -EIO;
+
+	reg_value = xsdfec_regread(xsdfec, XSDFEC_TURBO_ADDR);
+
+	turbo_params.scale = (reg_value & XSDFEC_TURBO_SCALE_MASK) >>
+			     XSDFEC_TURBO_SCALE_BIT_POS;
+	turbo_params.alg = reg_value & 0x1;
+
+	err = copy_to_user(arg, &turbo_params, sizeof(turbo_params));
+	if (err)
+		err = -EFAULT;
+
+	return err;
+}
+
 static u32
 xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
 {
@@ -270,8 +326,62 @@ static int xsdfec_cfg_axi_streams(struct xsdfec_dev *xsdfec)
 	return 0;
 }
 
+static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
+{
+	return 0;
+}
+
+static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
+{
+	return 0;
+}
+
+static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
+			     unsigned long data)
+{
+	struct xsdfec_dev *xsdfec;
+	void __user *arg = NULL;
+	int rval = -EINVAL;
+
+	xsdfec = container_of(fptr->private_data, struct xsdfec_dev, miscdev);
+
+	/* check if ioctl argument is present and valid */
+	if (_IOC_DIR(cmd) != _IOC_NONE) {
+		arg = (void __user *)data;
+		if (!arg)
+			return rval;
+	}
+
+	switch (cmd) {
+	case XSDFEC_SET_TURBO:
+		rval = xsdfec_set_turbo(xsdfec, arg);
+		break;
+	case XSDFEC_GET_TURBO:
+		rval = xsdfec_get_turbo(xsdfec, arg);
+		break;
+	default:
+		/* Should not get here */
+		break;
+	}
+	return rval;
+}
+
+#ifdef CONFIG_COMPAT
+static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
+				    unsigned long data)
+{
+	return xsdfec_dev_ioctl(file, cmd, (unsigned long)compat_ptr(data));
+}
+#endif
+
 static const struct file_operations xsdfec_fops = {
 	.owner = THIS_MODULE,
+	.open = xsdfec_dev_open,
+	.release = xsdfec_dev_release,
+	.unlocked_ioctl = xsdfec_dev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = xsdfec_dev_compat_ioctl,
+#endif
 };
 
 static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index 7b47a4c..dc9d4a3 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -41,6 +41,22 @@ enum xsdfec_order {
 };
 
 /**
+ * enum xsdfec_turbo_alg - Turbo Algorithm Type.
+ * @XSDFEC_MAX_SCALE: Max Log-Map algorithm with extrinsic scaling. When
+ *		      scaling is set to this is equivalent to the Max Log-Map
+ *		      algorithm.
+ * @XSDFEC_MAX_STAR: Log-Map algorithm.
+ * @XSDFEC_TURBO_ALG_MAX: Used to indicate out of bound Turbo algorithms.
+ *
+ * This enum specifies which Turbo Decode algorithm is in use.
+ */
+enum xsdfec_turbo_alg {
+	XSDFEC_MAX_SCALE = 0,
+	XSDFEC_MAX_STAR,
+	XSDFEC_TURBO_ALG_MAX,
+};
+
+/**
  * enum xsdfec_state - State.
  * @XSDFEC_INIT: Driver is initialized.
  * @XSDFEC_STARTED: Driver is started.
@@ -98,6 +114,29 @@ enum xsdfec_axis_word_include {
 };
 
 /**
+ * struct xsdfec_turbo - User data for Turbo codes.
+ * @alg: Specifies which Turbo decode algorithm to use
+ * @scale: Specifies the extrinsic scaling to apply when the Max Scale algorithm
+ *	   has been selected
+ *
+ * Turbo code structure to communicate parameters to XSDFEC driver.
+ */
+struct xsdfec_turbo {
+	enum xsdfec_turbo_alg alg;
+	__u8 scale;
+};
+
+/**
+ * struct xsdfec_status - Status of SD-FEC core.
+ * @state: State of the SD-FEC core
+ * @activity: Describes if the SD-FEC instance is Active
+ */
+struct xsdfec_status {
+	enum xsdfec_state state;
+	__s8 activity;
+};
+
+/**
  * struct xsdfec_irq - Enabling or Disabling Interrupts.
  * @enable_isr: If true enables the ISR
  * @enable_ecc_isr: If true enables the ECC ISR
@@ -135,4 +174,32 @@ struct xsdfec_config {
  * XSDFEC IOCTL List
  */
 #define XSDFEC_MAGIC 'f'
+/**
+ * DOC: XSDFEC_SET_TURBO
+ * @Parameters
+ *
+ * @struct xsdfec_turbo *
+ *	Pointer to the &struct xsdfec_turbo that contains the Turbo decode
+ *	settings for the SD-FEC core
+ *
+ * @Description
+ *
+ * ioctl that sets the SD-FEC Turbo parameter values
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_TURBO _IOW(XSDFEC_MAGIC, 4, struct xsdfec_turbo)
+/**
+ * DOC: XSDFEC_GET_TURBO
+ * @Parameters
+ *
+ * @struct xsdfec_turbo *
+ *	Pointer to the &struct xsdfec_turbo that contains the current Turbo
+ *	decode settings of the SD-FEC Block
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC turbo param values
+ */
+#define XSDFEC_GET_TURBO _IOR(XSDFEC_MAGIC, 7, struct xsdfec_turbo)
 #endif /* __XILINX_SDFEC_H__ */
-- 
2.7.4

