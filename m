Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D884C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5DF21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UCrFmtSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404542AbfIYLXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:23:31 -0400
Received: from mail-eopbgr790083.outbound.protection.outlook.com ([40.107.79.83]:6222
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732430AbfIYLX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:23:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j65YBm3senjLCMXZoHXYsnLg7KolUJ7pTjXJgcXwsajY+OLTtClam/juiRmpkfwl2rE+68wIx3QsCTpSiZgWj936eE+kEiHyyyiBw0ez7+etcoT88wEg68GqRCr9aECQCAZn+AXrckWsH82chB90McpDMpwsJb60UfUytftp4SfEFu3+4GBwCL5vYpYqJRVXEcjv2AcnQaVuK8jHh/rM9tih8qT6zYsC90pJ74t8QTDNgiykKTS7oysjytvEXhBio1EaD5/e3Zx5M8DZRK+c91j8lU/QT2xhC7tVsZ+YvddTShkE+0VO2WkhCtb0qY4cW5PdDTkxGl5w0lPHa9ItOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5eLOlDDAkRpmr7hnA05uVyNoabuoFnj2jcKgDlU1fM=;
 b=CGPMlqI9w2pcKBqqkDZBhUvKrEWRU5M9OO6afVNhI3wGF8NnqQc2l/5YACSf+a0EsJmibU165ZLIR83Q05PlGe12Sf/t69BhzLAGSNOC17NJsPjsEOiNmD8uGAS4lThvETKAwA1v38tCnzD3CSSZ7Wd5xaDIE2LytzZEJaYBYC4PfTD69pGHX9Ff/EVTzuydlKghRar93dGoKZFH7fbnF18cWcPfaLVTzk3rxlNVynuFw0reFeS+Um/Z7GEmheJTmx6UozBKOs77HAiyc9mkO7lQnjSZeBSTeWsdYBd/q4WdOfpCdgUidrx683xW2p0FLEbOkUTuiHSJr1BZ1FWY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5eLOlDDAkRpmr7hnA05uVyNoabuoFnj2jcKgDlU1fM=;
 b=UCrFmtSQmC451a3iBpu0HZEhYcc8vFIbj9A0brfqSacDPipUhBJouvB7bkaadl2d6RTv1TyQq1TqeybWq6jb2AprvYPmotwcn96Rc9lncKqy8Y2HS4RrD8lxqZZ7s0MN9LkNydlBWKefk0/RB7G5SUvM+Jxm2Sq/hEunXPa43js=
Received: from DM6PR02CA0083.namprd02.prod.outlook.com (2603:10b6:5:1f4::24)
 by DM6PR02MB5258.namprd02.prod.outlook.com (2603:10b6:5:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Wed, 25 Sep
 2019 11:23:23 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR02CA0083.outlook.office365.com
 (2603:10b6:5:1f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18 via Frontend
 Transport; Wed, 25 Sep 2019 11:23:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Wed, 25 Sep 2019 11:23:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iD5OE-0004xq-Gk; Wed, 25 Sep 2019 04:23:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iD5O9-0004nc-Db; Wed, 25 Sep 2019 04:23:17 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iD5O5-0004n8-PM; Wed, 25 Sep 2019 04:23:14 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCH 2/2] misc: xilinx_flex: Add support for the flex noc Performance Monitor
Date:   Wed, 25 Sep 2019 16:53:07 +0530
Message-Id: <5694e92158ce93f774fc804c069b465b3dc1f62a.1569410216.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569410216.git.shubhrajyoti.datta@xilinx.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569410216.git.shubhrajyoti.datta@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(4326008)(11346002)(9786002)(7696005)(126002)(51416003)(446003)(2616005)(8676002)(30864003)(107886003)(81166006)(36386004)(476003)(186003)(36756003)(336012)(6916009)(76176011)(426003)(2906002)(48376002)(26005)(50226002)(305945005)(8746002)(486006)(81156014)(5660300002)(356004)(478600001)(8936002)(106002)(6666004)(118296001)(70206006)(50466002)(5024004)(14444005)(47776003)(2361001)(2351001)(316002)(70586007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5258;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776bafd4-5f11-4706-5700-08d741aac6d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB5258;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5258:
X-Microsoft-Antispam-PRVS: <DM6PR02MB52586314AD374BC992A85D4CAA870@DM6PR02MB5258.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 01713B2841
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YQQIofLv3RdP4Mp030pQLQUDLPOJQ8UE9ZxWCObLXxqK+0Wym4JCtDCXH6fIcJ3OVnFb5c2m0O1PZIgIx/WczGkIFqGfUOmOZ0PIkSWyyfxqVqZueK2Ngy0WWXBACtq2QaC7ybO3lw8Ez5rAfnstOBnpbnVLre/zNqTnAfrOAOd+9itve9f3fypZXiFUNUbsz3BvfRwxo7aovCILm3YneGbTHiGZ+SHYDQ70Q8/1pUlGT2G+XFIoa4QmnF1uGRqsTmIa67G0gLx+GVUbcS9Eo7ViROncx6VM7l4Er/4w4R57UbcaeFTYD8EW/0Q7MGsihY4nWWehHvaYissxhnu8bxvFd4hAPwJ5b9DWX9V6J4zI2yuVFNLgcsA8LBEGcaqVXla2jwR0A9myXtob7yRiVvU3/mv2V/XWSTRWz/A0OIc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 11:23:22.9180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776bafd4-5f11-4706-5700-08d741aac6d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5258
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
 drivers/misc/Kconfig          |   9 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/xilinx_flex_pm.c | 644 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 654 insertions(+)
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
index 0000000..891ab3a
--- /dev/null
+++ b/drivers/misc/xilinx_flex_pm.c
@@ -0,0 +1,644 @@
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
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* Macro */
+#define to_xflex_dev_info(n)   ((struct xflex_dev_info *)dev_get_drvdata(n=
))
+
+#define FPM_LAR_OFFSET                         0xFB0
+#define FPM_UNLOCK                             0xC5ACCE55
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
+/*Port values */
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
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_LPD_WRREQ:
+               reg =3D flexpm->counterid_lpd | FPM_WRREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_LPD_RDRSP:
+               reg =3D flexpm->counterid_lpd | FPM_RDRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_LPD_RDREQ:
+               reg =3D flexpm->counterid_lpd | FPM_RDREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_SET_COUNTER_LPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       return ret;
+
+               flexpm->counterid_lpd =3D val;
+
+               reset_default(dev, val, FPM_LPD);
+
+               break;
+
+       case XFLEX_SET_PORT_COUNTER_FPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       return ret;
+               counter =3D flexpm->counterid_fpd * FPM_COUNTER_OFFSET;
+               offset =3D FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFS=
ET;
+               fpm_reg(flexpm->basefpd, val, offset);
+               break;
+
+       case XFLEX_SET_PORT_COUNTER_LPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       return ret;
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
+                       return ret;
+               for (src =3D 0; src < FPM_NUM_COUNTERS; src++) {
+                       reg =3D reg | FPM_SRC | (src << FPM_PROBE_SHIFT);
+                       ret =3D eemi_ops->ioctl(domain, IOCTL_PROBE_COUNTER=
_WRITE,
+                                     reg, val, NULL);
+                       if (ret < 0) {
+                               dev_err(dev, "Counter write error %d\n", re=
t);
+                               return ret;
+                       }
+               }
+               break;
+
+       case XFLEX_SET_SRC_COUNTER_FPD:
+               reg =3D flexpm->counterid_fpd;
+               domain =3D FPM_FPD;
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       return ret;
+               for (src =3D 0; src < FPM_NUM_COUNTERS; src++) {
+                       reg =3D reg | FPM_SRC | (src << FPM_PROBE_SHIFT);
+                       ret =3D eemi_ops->ioctl(domain, IOCTL_PROBE_COUNTER=
_WRITE,
+                                     reg, val, NULL);
+                       if (ret < 0) {
+                               dev_err(dev, "Counter write error %d\n", re=
t);
+                               return ret;
+                       }
+               }
+               break;
+
+       case XFLEX_SET_COUNTER_FPD:
+               ret =3D kstrtou32(buf, 0, &val);
+               if (ret < 0)
+                       return ret;
+
+               flexpm->counterid_fpd =3D val;
+               reset_default(dev, val, FPM_FPD);
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_WRRSP:
+               reg =3D flexpm->counterid_fpd | FPM_WRRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_WRREQ:
+               reg =3D flexpm->counterid_fpd | FPM_WRREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_RDRSP:
+               reg =3D flexpm->counterid_fpd | FPM_RDRSP_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       case XFLEX_GET_COUNTER_FPD_RDREQ:
+               reg =3D flexpm->counterid_fpd | FPM_RDREQ_L | FPM_VAL;
+               ret =3D eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+                                     reg, 0,
+                                     &pm_api_ret[0]);
+               if (ret < 0) {
+                       dev_err(dev, "Counter read error %d\n", ret);
+                       return ret;
+               }
+               rdval =3D pm_api_ret[1];
+               break;
+
+       default:
+               dev_err(dev, "Invalid option\n");
+               break;
+       }
+
+       return rdval;
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
+       writel(FPM_UNLOCK, flexpm->funnel + FPM_LAR_OFFSET);
+       writel(FPM_UNLOCK, flexpm->baselpd + FPM_LAR_OFFSET);
+       /*
+        * Create sysfs file entries for the device
+        */
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
