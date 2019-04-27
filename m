Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E7D20881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qQElBcKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfD0WHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 18:07:00 -0400
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:6206
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfD0WG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 18:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pODisuJL+mYJVlmjU43X/a2/nBww/lbXSKf4hNbtc9E=;
 b=qQElBcKrf8SAyFubwD2Nl7yYKS5xL2Oj5Y413HwayEpY8R18vIOWCwQIfonTZTnBXNCmyEbpgj00BjlgTimZ3tYWWCyZREIXiMbPXnj5WWbk2g8bEuFwUtjGwgC6M+Acmg8MCzqjWUr6UWmYCha1EnFHLOBZYytwpUJG3sv8Clc=
Received: from BL0PR02CA0075.namprd02.prod.outlook.com (2603:10b6:208:51::16)
 by BL2PR02MB2003.namprd02.prod.outlook.com (2a01:111:e400:c74a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.13; Sat, 27 Apr
 2019 22:05:16 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BL0PR02CA0075.outlook.office365.com
 (2603:10b6:208:51::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.12 via Frontend
 Transport; Sat, 27 Apr 2019 22:05:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1835.13 via Frontend Transport; Sat, 27 Apr 2019 22:05:15 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 27 Apr 2019 23:05:12 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 27 Apr 2019 23:05:12 +0100
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
Received: from [149.199.110.15] (port=52636 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hKVRY-0002Gu-5v; Sat, 27 Apr 2019 23:05:12 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V3 08/12] misc: xilinx_sdfec: Add ability to get/set config
Date:   Sat, 27 Apr 2019 23:05:02 +0100
Message-ID: <1556402706-176271-9-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(14444005)(336012)(76176011)(2906002)(48376002)(26826003)(186003)(70586007)(2201001)(316002)(126002)(478600001)(956004)(2616005)(426003)(446003)(11346002)(47776003)(54906003)(486006)(36906005)(476003)(6666004)(356004)(110136005)(76130400001)(16586007)(71366001)(44832011)(8936002)(7696005)(5660300002)(106002)(50226002)(51416003)(107886003)(93146003)(28376004)(7636002)(305945005)(246002)(70206006)(50466002)(26005)(8676002)(36756003)(60926002)(4326008)(9786002)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2003;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c2c8011-1caf-484b-0278-08d6cb5c6dde
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR02MB2003;
X-MS-TrafficTypeDiagnostic: BL2PR02MB2003:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB2003363587504D0760C5778BCB3F0@BL2PR02MB2003.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0020414413
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: thggX2OMhUSG4+b98aJ/6cozSafoRy2cauNAoltmpiXKOAfu7CcyVKrFjiGGr1zGjiNBiG2rq+w9MVtABXAqqvpHU5Vt9LMqdQfDI3lPMlAOWKiqj3OUYA5BIFb74diQuFcmvcNN9Y1xR1znzXTcxltVtbBX/26NJYzxkTXEi6l3sY1kK/RyNM0xuE4X5d2qlm78Vj+sDSwJW5qZYMmNaEAYn1hC68UyqnhQ3yzetOhHtYX6fDV36Mey8ci6BqwCxJH3htpSGB3KjCn/wEniQ51E/iRAOHM+yRM8+yEdXDoca1yrYJiVT0y6ysI+iCV4KlAnGk3I21B+36lY6Xsg1873XU7/FOIooCbpQ7nCsqr6aVESTIlfKoJ7Yk+lI7mILq9XIdZWkzrwPtrt26WirXpA8+FbMdMs68W8nUZot0E=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2019 22:05:15.8568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2c8011-1caf-484b-0278-08d6cb5c6dde
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2003
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
 drivers/misc/xilinx_sdfec.c      | 99 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h | 57 +++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 18e7ae2..560a2ed 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -306,6 +306,17 @@ static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
 	return 0;
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
@@ -648,6 +659,82 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
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
+	if (order_invalid) {
+		dev_err(xsdfec->dev, "%s invalid order value %d for SDFEC%d",
+			__func__, order, xsdfec->config.fec_id);
+		return -EINVAL;
+	}
+
+	/* Verify Device has not started */
+	if (xsdfec->state == XSDFEC_STARTED) {
+		dev_err(xsdfec->dev,
+			"%s attempting to set Order while started for SDFEC%d",
+			__func__, xsdfec->config.fec_id);
+		return -EIO;
+	}
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
+	if (xsdfec->state == XSDFEC_STARTED) {
+		dev_err(xsdfec->dev,
+			"%s attempting to set bypass while started for SDFEC%d",
+			__func__, xsdfec->config.fec_id);
+		return -EIO;
+	}
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
@@ -741,6 +828,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	}
 
 	switch (cmd) {
+	case XSDFEC_GET_CONFIG:
+		rval = xsdfec_get_config(xsdfec, arg);
+		break;
 	case XSDFEC_SET_TURBO:
 		rval = xsdfec_set_turbo(xsdfec, arg);
 		break;
@@ -750,6 +840,15 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
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
 		dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index b6987c5..5532572 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -315,6 +315,19 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
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
@@ -327,4 +340,48 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
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

