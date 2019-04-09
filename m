Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC93CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D24121473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nJmYzeS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDIKHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:22 -0400
Received: from mail-eopbgr710075.outbound.protection.outlook.com ([40.107.71.75]:35760
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfDIKHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnyBbHDLHe4D5IThM8xtRvuZWyly4CLClC/Q/sy5cD0=;
 b=nJmYzeS+jbOrij8OI1DBQY6Mn75hRWi/zz01ingrPEbXZ19Qe6L/jVPcE1GyYs8QwyGOMnDnZCiolxizBx6iFB3RjGwO+u2Zhj4Bb9k2WjDwOq8HsNW2PD1dsTHyerpt+SlpQK0XrVqDIg+xmmzE8owM8C0cmdGvpAXGPv+Fsb4=
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by MW2PR02MB3834.namprd02.prod.outlook.com (2603:10b6:907:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.15; Tue, 9 Apr
 2019 10:07:15 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:14 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
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
        id 1hDnei-0007SJ-LB; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 06/12] misc: xilinx_sdfec: Add ability to configure turbo
Date:   Tue, 9 Apr 2019 11:06:48 +0100
Message-ID: <1554804414-206099-7-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(189003)(199004)(478600001)(186003)(6666004)(76176011)(426003)(356004)(50226002)(336012)(446003)(54906003)(110136005)(956004)(11346002)(48376002)(47776003)(26826003)(51416003)(7696005)(246002)(8936002)(9786002)(50466002)(36756003)(126002)(476003)(106002)(106466001)(8676002)(26005)(93146003)(486006)(107886003)(60926002)(14444005)(4326008)(2616005)(7636002)(44832011)(71366001)(36906005)(2201001)(5660300002)(2906002)(316002)(16586007)(28376004)(76130400001)(305945005)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3834;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991cd2aa-f350-4932-b75a-08d6bcd32429
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MW2PR02MB3834;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3834:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB3834A850512B006A9BE3EFEDCB2D0@MW2PR02MB3834.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KVmwrcIwKzDxiqfRtWHXBexMnV04sfPEjJAWqc9qZtQpkJy4LNDHEGq8q3FGvhdZgeUdedxCfMUoAT+zH/OzAnd/HULKnxz7Ccio5ovjlJZBrzCqZYOfbp2O55VvScPDaCADtBsk9BvmQrsu8E9u1nO/t70m0lDlHlW7K1Yx3TMFSV9IcL7SGCgCuRbWvoXZhExozDG+qyoT1po+kJNFNNYNYtmN/BNJYDCjD5BT8LmRMDTU4+FB44G53+X63xZL1EoFK+t9DscfqRSTS/N2Hoz/ZzWLqAzfwMUUNKVLSWt7BiIfII70YoQCkOTrn3zELXL05ZIW2nSuPzBTJ0m7qhyxTqTYbwTmBDV2tcBkKjyvDBxkyIZBJdJtKGMkBMtVc59IW+GuqWw7wrP1ffLUPk3TjkIs0opnDVKsv6YwxQs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:14.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991cd2aa-f350-4932-b75a-08d6bcd32429
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mode

Add the capability to configure and retrieve turbo mode
via the ioctls XSDFEC_SET_TURBO and XSDFEC_GET_TURBO.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 77 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h | 71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 77ee62d..19b5f96 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -116,6 +116,12 @@ static dev_t xsdfec_devt;
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
@@ -247,6 +253,71 @@ static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
 	return 0;
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
+	if (turbo.alg >= XSDFEC_TURBO_ALG_MAX) {
+		dev_err(xsdfec->dev,
+			"%s invalid turbo alg value %d for SDFEC%d", __func__,
+			turbo.alg, xsdfec->config.fec_id);
+		return -EINVAL;
+	}
+
+	if (turbo.scale > XSDFEC_TURBO_SCALE_MAX) {
+		dev_err(xsdfec->dev,
+			"%s invalid turbo scale value %d for SDFEC%d", __func__,
+			turbo.scale, xsdfec->config.fec_id);
+		return -EINVAL;
+	}
+
+	/* Check to see what device tree says about the FEC codes */
+	if (xsdfec->config.code == XSDFEC_LDPC_CODE) {
+		dev_err(xsdfec->dev,
+			"%s: Unable to write Turbo to SDFEC%d check DT",
+			__func__, xsdfec->config.fec_id);
+		return -EIO;
+	}
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
+	if (xsdfec->config.code == XSDFEC_LDPC_CODE) {
+		dev_err(xsdfec->dev,
+			"%s: SDFEC%d is configured for LDPC, check DT",
+			__func__, xsdfec->config.fec_id);
+		return -EIO;
+	}
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
@@ -340,6 +411,12 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	}
 
 	switch (cmd) {
+	case XSDFEC_SET_TURBO:
+		rval = xsdfec_set_turbo(xsdfec, arg);
+		break;
+	case XSDFEC_GET_TURBO:
+		rval = xsdfec_get_turbo(xsdfec, arg);
+		break;
 	default:
 		/* Should not get here */
 		dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index 0497b66..b46c90e 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -39,6 +39,22 @@ enum xsdfec_order {
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
@@ -96,6 +112,33 @@ enum xsdfec_axis_word_include {
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
+	u8 scale;
+};
+
+/**
+ * struct xsdfec_status - Status of SD-FEC core.
+ * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
+ *          SD-FEC's in the FPGA and is related to the driver instance
+ *          Minor number.
+ * @state: State of the SD-FEC core
+ * @activity: Describes if the SD-FEC instance is Active
+ */
+struct xsdfec_status {
+	s32 fec_id;
+	enum xsdfec_state state;
+	char activity;
+};
+
+/**
  * struct xsdfec_irq - Enabling or Disabling Interrupts.
  * @enable_isr: If true enables the ISR
  * @enable_ecc_isr: If true enables the ECC ISR
@@ -137,4 +180,32 @@ struct xsdfec_config {
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

