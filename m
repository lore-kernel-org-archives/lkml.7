Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543FEC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FB82146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qH9PeTCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392120AbfIZFRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:17:00 -0400
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:38073
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388115AbfIZFRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCst13BgDhoPoDQAZn4c8wWRk46ErnzeZh8xy9X7rsXD83PmD6zbMn5B+UzjCzpA1W5d30/ZLolJy+NHUMv/s673OZc4IxhOl3BeIdg3SN1nuUr5fjEWtbtn43Sh39OR9aQX4bSnjsErX/fxk03XPLCUk05xX/Z3QWQAm98bMFzgK2tgS9ePJGSD6dQyVo6GrSWQXw9fSC3zxuVd6Lu3UkGKsRjVByvO8TDPR6yajSINcIp9c+chqn2hZmYSBG/qLHKIY4rpizHybg3LVfqf980UnenxERqGse/tB91gK5tRltlfG6sgPyj4r6PW2SL2Q7yZQGOdF8ABEq+K3XtYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4GT1gzRasSp0wFjbCiHfukIZQPrLyPgJWm0PxnNHrA=;
 b=lb5MQsLX/IZ/7G5vILSHMJAGPKF/JG4cuRIDjJqcYl+7Ys5eWC8oPp9jZmWS34fLt0x1pkcYNTsnOW8KqrhjrAiFUGC+g9uttt1EUiXbkxFebhLQqaiWGIyppqqQ5zkbyFsEth5gq+gvUkFdYFJSfEhK16z7vTNVxKgi9xXN29CuJu6OeuFiZLtkKsCPbbU7PsW/zpuIACcne7lrSExPVbx3g+Un/i/WaWg/j2qhcPF2WX9/PSNP2fCcqviVcjtHgeH+YcfjXNiguZZzHCFoW9ouS80/cZva0rvi3k0j0nlVDVxPWJAy7RYRsPesog9DDKfkdDAv7DeVNPCkqX3QhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4GT1gzRasSp0wFjbCiHfukIZQPrLyPgJWm0PxnNHrA=;
 b=qH9PeTCJT+WzPeTZzayoU+p1EqQ4xd8mxxQkpNr7EqeTKIhfOrGSdV103utX/ej8AS1Zuk/g3qG49s1QgW4PlD4bBpUvbZcy3LmSgB0d90XyFiHjXEUS7nQbvT+f8gTPb1TQnkrZVOFcASb25+jYZ5cvC5Zxj2AomA6J7vFBR8Y=
Received: from BN6PR02CA0099.namprd02.prod.outlook.com (2603:10b6:405:60::40)
 by BN7PR02MB5249.namprd02.prod.outlook.com (2603:10b6:408:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 05:16:54 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR02CA0099.outlook.office365.com
 (2603:10b6:405:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 26 Sep 2019 05:16:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 26 Sep 2019 05:16:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37317 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM91-0007XN-Io; Wed, 25 Sep 2019 22:16:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8w-0007lO-Ex; Wed, 25 Sep 2019 22:16:42 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8Q5GXW4020945;
        Wed, 25 Sep 2019 22:16:33 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8m-0007hs-R6; Wed, 25 Sep 2019 22:16:33 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCHv2 2/3] misc: xilinx_flex: Add support for the flex noc Performance Monitor
Date:   Thu, 26 Sep 2019 10:46:25 +0530
Message-Id: <a0a95c8b9dfc78a2eb97737b90322cc29332c1b0.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(70586007)(478600001)(316002)(70206006)(118296001)(9786002)(486006)(305945005)(2906002)(44832011)(446003)(36756003)(426003)(36386004)(47776003)(356004)(6666004)(2616005)(336012)(126002)(11346002)(106002)(476003)(2351001)(30864003)(14444005)(6916009)(51416003)(186003)(2361001)(7696005)(26005)(76176011)(8746002)(8936002)(107886003)(50466002)(48376002)(5024004)(4326008)(50226002)(5660300002)(81166006)(81156014)(8676002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5249;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c53989a-ba9e-4c9a-ebda-08d74240be77
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN7PR02MB5249;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5249:
X-Microsoft-Antispam-PRVS: <BN7PR02MB52492DF99E26FB4E6D74AB50AA860@BN7PR02MB5249.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QuaJcE2EBLeZgYWgg1XuukJC0vSIzuPm2KYbSOhJyqXF8kWTY/2YH7afguwK33E0Da4zG62OSkqvfM7mq3zAl9fRbEa5SAJcYowodJP406jdqBwyu3INESiHtbhssIFmFz0Rhnz0xwZKz+poDs73UCrPMcXtaMub6gDfSgiFvrWf+pXiiZ6PjR+GL4vO4xvxMotBgYVoMP8ghIopXi0ASX+CgDpOOAUT3cYrbAuo0ye0pTjXOpgEoyAd1w0p1SghT78/g0YZORX7A7y+ku0END0xams72GNu7pYROdrSBvUowDfYlsHWAT8iHRoFnvvDa+HHjKeXvZbkCb9ecGAuf5JbCpCcdj3xW11iTYm1vsnI7WNCK5AREAnS0ZGCa4WlSYYP2Mp2BiDfD96aLLrGQmOUz0PBcqAxZUl7U3zp4wk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 05:16:53.3401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c53989a-ba9e-4c9a-ebda-08d74240be77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the FlexNoc Performance Monitor.
Adds support for various port setting and monitoring
the packets transactions. It supports LPD and FPD monitoring
counters for read and write transaction requests and responses.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Add a mutex to prevent race

---
 drivers/misc/Kconfig          |   9 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/xilinx_flex_pm.c | 653 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 663 insertions(+)
 create mode 100644 drivers/misc/xilinx_flex_pm.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c55b637..1e9a6fa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -454,6 +454,15 @@ config XILINX_SDFEC

          If unsure, say N.

+config XILINX_FLEX_PM
+       tristate "Xilinx Flexnoc Performance Monitor"
+       help
+         This option enables support for the Xilinx Flex Noc Performance M=
onitor driver.
+         It monitors the read and write transactions. It has counters for =
the LPD and
+         FPD domains.
+
+         If unsure, say N
+
 config MISC_RTSX
        tristate
        default MISC_RTSX_PCI || MISC_RTSX_USB
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c1860d3..1f1c34d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-y                         +=3D cardreader/
 obj-$(CONFIG_PVPANIC)          +=3D pvpanic.o
 obj-$(CONFIG_HABANA_AI)                +=3D habanalabs/
 obj-$(CONFIG_XILINX_SDFEC)     +=3D xilinx_sdfec.o
+obj-$(CONFIG_XILINX_FLEX_PM)   +=3D xilinx_flex_pm.o
diff --git a/drivers/misc/xilinx_flex_pm.c b/drivers/misc/xilinx_flex_pm.c
new file mode 100644
index 0000000..e7684d1
--- /dev/null
+++ b/drivers/misc/xilinx_flex_pm.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Flex Noc Performance Monitor driver.
+ * Copyright (c) 2019 Xilinx Inc.
+ */
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define to_xflex_dev_info(n)   ((struct xflex_dev_info *)dev_get_drvdata(n=
))
+
+#define FPM_LAR_OFFSET                 0xFB0
+#define FPM_UNLOCK                     0xC5ACCE55
+
+#define FPM_RD_REQ_OFFSET              0x1000
+#define FPM_RD_RES_OFFSET              0x2000
+#define FPM_WR_REQ_OFFSET              0x3000
+#define FPM_WR_RES_OFFSET              0x4000
+
+#define FPM_PORT_SEL_OFFSET            0x134
+#define FPM_MAIN_CTRL_OFFSET           0x008
+#define FPM_SRC_SEL_OFFSET             0x138
+#define FPM_STATPERIOD                 0x24
+#define FPM_CFGCTRL                    0x0C
+#define FPM_LPD                                0x4210002
+#define FPM_FPD                                0x420c003
+
+#define FPM_VAL                                0x300
+#define FPM_SRC                                0x200
+#define FPM_WRRSP_L                    0x70000
+#define FPM_WRREQ_L                    0x60000
+#define FPM_RDRSP_L                    0x50000
+#define FPM_RDREQ_L                    0x40000
+#define FPM_PROBE_SHIFT                        16
+#define FPM_COUNTER_OFFSET             0x14
+#define FPM_GLOBALEN                   BIT(0)
+#define FPM_STATEN                     BIT(3)
+#define FPM_STATCOND_DUMP              BIT(5)
+#define FPM_NUM_COUNTERS               4
+#define FPM_MAINCTL_DIS                        0
+
+#define FPM_SRC_OFF                    0x0
+#define FPM_SRC_CYCLE                  0x1
+#define FPM_SRC_IDLE                   0x2
+#define FPM_SRC_XFER                   0x3
+#define FPM_SRC_BUSY                   0x4
+#define FPM_SRC_WAIT                   0x5
+#define FPM_SRC_PACKET                 0x6
+
+/* Port values */
+#define FPM_PORT_LPD_AFIFS_AXI         0x0
+#define FPM_PORT_LPD_OCM               0x1
+#define FPM_PORT_LPD_OCMEXT            0x2
+#define FPM_PORT_PMC_RPU_AXI0          0x3
+
+#define FPM_PORT_FPDAXI                        0x1
+#define FPM_PORT_PROTXPPU              0x2
+
+/**
+ * struct xflex_dev_info - Global Driver structure
+ * @dev: Device structure
+ * @baselpd: Iomapped LPD base address
+ * @basefpd: Iomapped FPD base address
+ * @funnel: Iomapped funnel register base address
+ * @counterid_lpd: LPD counter id
+ * @counterid_fpd: FPD counter id
+ */
+struct xflex_dev_info {
+       struct device *dev;
+       void __iomem *baselpd;
+       void __iomem *basefpd;
+       void __iomem *funnel;
+       u32 counterid_fpd;
+       u32 counterid_lpd;
+       struct mutex mutex; /* avoid parallel access to device */
+};
+
+/**
+ * enum xflex_sysfs_cmd_codes - sysfs command codes
+ * @XFLEX_GET_COUNTER_FPD: get the FPD counter value
+ * @XFLEX_SET_COUNTER_FPD: set the FPD counter value
+ * @XFLEX_GET_COUNTER_FPD_RDREQ: get the FPD read request count
+ * @XFLEX_GET_COUNTER_FPD_RDRSP: get the FPD read response count
+ * @XFLEX_GET_COUNTER_FPD_WRREQ: get the FPD write request count
+ * @XFLEX_GET_COUNTER_FPD_WRRSP: get the FPD write response count
+ * @XFLEX_GET_COUNTER_LPD_RDREQ: get the LPD read request count
+ * @XFLEX_GET_COUNTER_LPD_RDRSP: get the LPD read response count
+ * @XFLEX_GET_COUNTER_LPD_WRREQ: get the LPD write request count
+ * @XFLEX_GET_COUNTER_LPD_WRRSP: get the LPD write response count
+ * @XFLEX_SET_COUNTER_LPD: set the LPD counter value
+ * @XFLEX_SET_SRC_COUNTER_LPD: set the LPD source
+ * @XFLEX_SET_SRC_COUNTER_FPD: set the FPD source
+ * @XFLEX_SET_PORT_COUNTER_LPD: set the LPD port
+ * @XFLEX_SET_PORT_COUNTER_FPD: set the FPD port
+ */
+enum xflex_sysfs_cmd_codes {
+       XFLEX_GET_COUNTER_FPD =3D 0,
+       XFLEX_SET_COUNTER_FPD,
+       XFLEX_GET_COUNTER_FPD_RDREQ,
+       XFLEX_GET_COUNTER_FPD_RDRSP,
+       XFLEX_GET_COUNTER_FPD_WRREQ,
+       XFLEX_GET_COUNTER_FPD_WRRSP,
+       XFLEX_GET_COUNTER_LPD_RDREQ,
+       XFLEX_GET_COUNTER_LPD_RDRSP,
+       XFLEX_GET_COUNTER_LPD_WRREQ,
+       XFLEX_GET_COUNTER_LPD_WRRSP,
+       XFLEX_SET_COUNTER_LPD,
+       XFLEX_SET_SRC_COUNTER_LPD,
+       XFLEX_SET_SRC_COUNTER_FPD,
+       XFLEX_SET_PORT_COUNTER_LPD,
+       XFLEX_SET_PORT_COUNTER_FPD,
+};
+
+static inline void fpm_reg(void __iomem *base, u32 val, u32 offset)
+{
+       writel(val, base + FPM_RD_REQ_OFFSET + offset);
+       writel(val, base + FPM_RD_RES_OFFSET + offset);
+       writel(val, base + FPM_WR_REQ_OFFSET + offset);
+       writel(val, base + FPM_WR_RES_OFFSET + offset);
+}
+
+static void reset_default(struct device *dev, u32 counter, u32 domain)
+{
+       struct xflex_dev_info *flexpm =3D to_xflex_dev_info(dev);
+       void __iomem *base =3D flexpm->basefpd;
+       u32 offset;
+
+       if (domain =3D=3D FPM_LPD)
+               base =3D flexpm->baselpd;
+
+       fpm_reg(base, FPM_MAINCTL_DIS, FPM_MAIN_CTRL_OFFSET);
+       fpm_reg(base, FPM_STATEN | FPM_STATCOND_DUMP, FPM_MAIN_CTRL_OFFSET)=
;
+       fpm_reg(base, FPM_STATEN | FPM_STATCOND_DUMP, FPM_MAIN_CTRL_OFFSET)=
;
+
+       offset =3D FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFSET;
+       fpm_reg(base, FPM_PORT_LPD_OCM, offset);
+       offset =3D FPM_SRC_SEL_OFFSET + counter * FPM_COUNTER_OFFSET;
+       fpm_reg(base, FPM_SRC_PACKET, offset);
+
+       fpm_reg(base, 0, FPM_STATPERIOD);
+       fpm_reg(base, FPM_GLOBALEN, FPM_CFGCTRL);
+}
+
+/**
+ * xflex_sysfs_cmd - Implements sysfs operations
+ * @dev: Device structure
+ * @buf: Value to write
+ * @cmd: sysfs cmd
+ *
+ * Return: value read from the sysfs cmd on success and negative error cod=
e
+ *             otherwise.
+ */
+static int xflex_sysfs_cmd(struct device *dev, const char *buf,
+                          enum xflex_sysfs_cmd_codes cmd)
+{
+       struct xflex_dev_info *flexpm =3D to_xflex_dev_info(dev);
+       u32 domain, src, offset, reg, val, counter;
+       int ret;
+       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops()=
;
+       u32 rdval =3D 0;
+       u32 pm_api_ret[4] =3D {0, 0, 0, 0};
+
+       if (IS_ERR_OR_NULL(eemi_ops))
+               return PTR_ERR(eemi_ops);
+
+       if (!eemi_ops->ioctl)
+               return -ENOTSUPP;
+
+       switch (cmd) {
+       case XFLEX_GET_COUNTER_LPD_WRRSP:
+               reg =3D flexpm->counterid_lpd | FPM_WRRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_LPD_WRREQ:
+               reg =3D flexpm->counterid_lpd | FPM_WRREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_LPD_RDRSP:
+               reg =3D flexpm->counterid_lpd | FPM_RDRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_LPD_RDREQ:
+               reg =3D flexpm->counterid_lpd | FPM_RDREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_SET_COUNTER_LPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       goto exit_unlock;
+
+               flexpm->counterid_lpd =3D val;
+               reset_default(dev, val, FPM_LPD);
+               break;
+
+       case XFLEX_SET_PORT_COUNTER_FPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       goto exit_unlock;
+
+               counter =3D flexpm->counterid_fpd * FPM_COUNTER_OFFSET;
+               offset =3D FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFS=
ET;
+               fpm_reg(flexpm->basefpd, val, offset);
+               break;
+
+       case XFLEX_SET_PORT_COUNTER_LPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       goto exit_unlock;
+
+               counter =3D flexpm->counterid_lpd * FPM_COUNTER_OFFSET;
+               offset =3D FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFS=
ET;
+               fpm_reg(flexpm->baselpd, val, offset);
+               break;
+
+       case XFLEX_SET_SRC_COUNTER_LPD:
+               reg =3D flexpm->counterid_lpd;
+               domain =3D FPM_LPD;
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       goto exit_unlock;
+
+               for (src =3D 0; src < FPM_NUM_COUNTERS; src++) {
+                       reg =3D reg | FPM_SRC | (src << FPM_PROBE_SHIFT);
+                       ret =3D eemi_ops->ioctl(domain, IOCTL_PROBE_COUNTER=
_WRITE,
+                                             reg, val, NULL);
+                       if (ret < 0) {
+                               dev_err(dev, "Counter write error %d\n", re=
t);
+                               goto exit_unlock;
+                       }
+               }
+               break;
+
+       case XFLEX_SET_SRC_COUNTER_FPD:
+               reg =3D flexpm->counterid_fpd;
+               domain =3D FPM_FPD;
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       goto exit_unlock;
+
+               for (src =3D 0; src < FPM_NUM_COUNTERS; src++) {
+                       reg =3D reg | FPM_SRC | (src << FPM_PROBE_SHIFT);
+                       ret =3D eemi_ops->ioctl(domain, IOCTL_PROBE_COUNTER=
_WRITE,
+                                             reg, val, NULL);
+                       if (ret < 0) {
+                               dev_err(dev, "Counter write error %d\n", re=
t);
+                               goto exit_unlock;
+                       }
+               }
+               break;
+
+       case XFLEX_SET_COUNTER_FPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       goto exit_unlock;
+
+               flexpm->counterid_fpd =3D val;
+               reset_default(dev, val, FPM_FPD);
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_WRRSP:
+               reg =3D flexpm->counterid_fpd | FPM_WRRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_WRREQ:
+               reg =3D flexpm->counterid_fpd | FPM_WRREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_RDRSP:
+               reg =3D flexpm->counterid_fpd | FPM_RDRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_RDREQ:
+               reg =3D flexpm->counterid_fpd | FPM_RDREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0, &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       goto exit_unlock;
+               }
+
+               rdval =3D pm_api_ret[1];
+               break;
+
+       default:
+               dev_err(dev, "Invalid option\n");
+               break;
+       }
+
+       return rdval;
+
+exit_unlock:
+       mutex_unlock(&flexpm->lock);
+       return ret;
+}
+
+/* Sysfs functions */
+
+static ssize_t counterfpd_wrreq_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_WRREQ=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_wrreq);
+
+static ssize_t counterfpd_wrrsp_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_WRRSP=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_wrrsp);
+
+static ssize_t counterfpd_rdreq_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_RDREQ=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_rdreq);
+
+static ssize_t counterfpd_rdrsp_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_RDRSP=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_rdrsp);
+
+static ssize_t counterlpd_wrreq_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_WRREQ=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_wrreq);
+
+static ssize_t counterlpd_wrrsp_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_WRRSP=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_wrrsp);
+
+static ssize_t counterlpd_rdreq_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_RDREQ=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_rdreq);
+
+static ssize_t counterlpd_rdrsp_show(struct device *dev,
+                                    struct device_attribute *attr, char *b=
uf)
+{
+       int rdval =3D xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_RDRSP=
);
+
+       if (rdval < 0)
+               return 0;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_rdrsp);
+
+static ssize_t counterlpdsrc_store(struct device *dev,
+                                  struct device_attribute *attr,
+                                  const char *buf, size_t size)
+{
+       xflex_sysfs_cmd(dev, buf, XFLEX_SET_SRC_COUNTER_LPD);
+
+       return size;
+}
+static DEVICE_ATTR_WO(counterlpdsrc);
+
+static ssize_t counterfpdsrc_store(struct device *dev,
+                                  struct device_attribute *attr,
+                                  const char *buf, size_t size)
+{
+       xflex_sysfs_cmd(dev, buf, XFLEX_SET_SRC_COUNTER_FPD);
+
+       return size;
+}
+static DEVICE_ATTR_WO(counterfpdsrc);
+
+static ssize_t counterlpdport_store(struct device *dev,
+                                   struct device_attribute *attr,
+                                   const char *buf, size_t size)
+{
+       xflex_sysfs_cmd(dev, buf, XFLEX_SET_PORT_COUNTER_LPD);
+
+       return size;
+}
+static DEVICE_ATTR_WO(counterlpdport);
+
+static ssize_t counterfpdport_store(struct device *dev,
+                                   struct device_attribute *attr,
+                                   const char *buf, size_t size)
+{
+       xflex_sysfs_cmd(dev, buf, XFLEX_SET_PORT_COUNTER_FPD);
+
+       return size;
+}
+static DEVICE_ATTR_WO(counterfpdport);
+
+static ssize_t counteridlpd_show(struct device *dev,
+                                struct device_attribute *attr, char *buf)
+{
+       struct xflex_dev_info *flexpm =3D to_xflex_dev_info(dev);
+
+       return snprintf(buf, PAGE_SIZE, "%08d\n", flexpm->counterid_lpd);
+}
+
+static ssize_t counteridlpd_store(struct device *dev,
+                                 struct device_attribute *attr,
+                                 const char *buf, size_t size)
+{
+       int ret;
+       struct xflex_dev_info *flexpm =3D to_xflex_dev_info(dev);
+
+       ret =3D kstrtou32(buf, 0, &flexpm->counterid_lpd);
+       if (ret < 0)
+               return ret;
+
+       reset_default(dev, flexpm->counterid_lpd, FPM_LPD);
+
+       return size;
+}
+static DEVICE_ATTR_RW(counteridlpd);
+
+static ssize_t counteridfpd_show(struct device *dev,
+                                struct device_attribute *attr, char *buf)
+{
+       struct xflex_dev_info *flexpm =3D to_xflex_dev_info(dev);
+
+       return snprintf(buf, PAGE_SIZE, "%08d\n", flexpm->counterid_fpd);
+}
+
+static ssize_t counteridfpd_store(struct device *dev,
+                                 struct device_attribute *attr,
+                                 const char *buf, size_t size)
+{
+       int ret;
+       struct xflex_dev_info *flexpm =3D to_xflex_dev_info(dev);
+
+       ret =3D kstrtou32(buf, 0, &flexpm->counterid_fpd);
+       if (ret < 0)
+               return ret;
+
+       return size;
+}
+static DEVICE_ATTR_RW(counteridfpd);
+
+static struct attribute *xflex_attrs[] =3D {
+       &dev_attr_counterlpdsrc.attr,
+       &dev_attr_counterlpdport.attr,
+       &dev_attr_counterfpdsrc.attr,
+       &dev_attr_counterfpdport.attr,
+
+       &dev_attr_counterlpd_rdreq.attr,
+       &dev_attr_counterlpd_wrreq.attr,
+       &dev_attr_counterlpd_rdrsp.attr,
+       &dev_attr_counterlpd_wrrsp.attr,
+
+       &dev_attr_counterfpd_rdreq.attr,
+       &dev_attr_counterfpd_wrreq.attr,
+       &dev_attr_counterfpd_rdrsp.attr,
+       &dev_attr_counterfpd_wrrsp.attr,
+
+       &dev_attr_counteridlpd.attr,
+       &dev_attr_counteridfpd.attr,
+       NULL,
+};
+
+ATTRIBUTE_GROUPS(xflex);
+
+/**
+ * xflex_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation and creates sysfs entries for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xflex_probe(struct platform_device *pdev)
+{
+       struct xflex_dev_info *flexpm;
+       struct resource *res;
+       int err;
+       struct device *dev =3D &pdev->dev;
+
+       flexpm =3D devm_kzalloc(dev, sizeof(*flexpm), GFP_KERNEL);
+       if (!flexpm)
+               return -ENOMEM;
+
+       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "baselpd=
");
+       flexpm->baselpd =3D devm_ioremap_resource(&pdev->dev, res);
+       if (IS_ERR(flexpm->baselpd))
+               return PTR_ERR(flexpm->baselpd);
+
+       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "basefpd=
");
+       flexpm->basefpd =3D devm_ioremap_resource(&pdev->dev, res);
+       if (IS_ERR(flexpm->basefpd))
+               return PTR_ERR(flexpm->basefpd);
+
+       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "funnel"=
);
+       flexpm->funnel =3D devm_ioremap_resource(&pdev->dev, res);
+       if (IS_ERR(flexpm->funnel))
+               return PTR_ERR(flexpm->funnel);
+
+       mutex_init(&flexpm->lock);
+       writel(FPM_UNLOCK, flexpm->funnel + FPM_LAR_OFFSET);
+       writel(FPM_UNLOCK, flexpm->baselpd + FPM_LAR_OFFSET);
+
+       /* Create sysfs file entries for the device */
+       err =3D sysfs_create_groups(&dev->kobj, xflex_groups);
+       if (err < 0) {
+               dev_err(dev, "unable to create sysfs entries\n");
+               return err;
+       }
+
+       dev_set_drvdata(dev, flexpm);
+
+       return 0;
+}
+
+/**
+ * xflex_remove - Driver remove function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This function frees all the resources allocated to the device.
+ *
+ * Return: 0 always
+ */
+static int xflex_remove(struct platform_device *pdev)
+{
+       sysfs_remove_groups(&pdev->dev.kobj, xflex_groups);
+       return 0;
+}
+
+static const struct of_device_id xflex_of_match[] =3D {
+       { .compatible =3D "xlnx,flexnoc-pm-2.7", },
+       { /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xflex_of_match);
+
+static struct platform_driver xflex_driver =3D {
+       .driver =3D {
+               .name =3D "xilinx-flex",
+               .of_match_table =3D xflex_of_match,
+       },
+       .probe =3D xflex_probe,
+       .remove =3D xflex_remove,
+};
+
+module_platform_driver(xflex_driver);
+
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Flexnoc performance monitor driver");
+MODULE_LICENSE("GPL v2");
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
