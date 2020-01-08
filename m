Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95480C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5858D206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L1HspH3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgAHXy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:54:58 -0500
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:58945
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727205AbgAHXyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:54:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g252871i/o5bxfvhGavJ7qatR5ro38BFLVRwc3Vg9LQnflBJRCZiF20NWVzJ24RU6oyNQhRjFmt6b65VA3TA2wMp+7/MuQ7XJk2jFddoL7PYLnlq46+8Dq3I3klU8PBb6DPNO73rCDguJJ2MTFHLhShBvPqivn9t6P29D9WxsqMZlJTyhgOspKJ2+RmnwkSfhS4MR5tU1IV31AFuk2MiJIkwiQqots4VCw+yVc550Sa6K4GK+gM+/r/QofbMQmZwGZIOcBtSULtSFLAG3WcHs3dHKBqIcTR2CZ4Q52drRlhL0gfCiM4eIyuRasnL/QEnn1XwlEGpJFmukEgfkhdJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TkZ4ipekWNHt0xnvjTqoRCL6UyPvqHoSGbedP4QqeQ=;
 b=YrakKjtMPf3SHiDQC6F6kcn5KcWO3J4hVc+ScyHN2Yu8Pn47RaPGUueshkhhlcgI6Ehsgr7Uz2tT+NKRSnTzbrkJekAQVXa/qgubxOT0RAZMc2Y9pl2t1j06EcsxZB+FP594LJemp8XcsksaJJdRaq5cREA2ZqbVR8Z8CVw0qXYGboea/wmd5RzexseZSOzAgNHi5lpgpXCq3Uoj57yhphV75IYE6gAlQkkbcEwYWQtUJjMQRbZYwbGmdk0nbkbFBcFKzk8DYb814IX7INu+75stzKDmCOqki5NA4Z+1VYOfDyLIAicP1afhC4jNQU6EYblg1kqZ5rI+4OOUq47P6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TkZ4ipekWNHt0xnvjTqoRCL6UyPvqHoSGbedP4QqeQ=;
 b=L1HspH3frkKgX8TAfBz2k4o+5kFtll+wvz2qDWCdfe+Go1YPNuBvvKEMjHYniR2bLfLci/gu5/Gjf90WNRPNkS++gt4FtHoi1yOeF6SaSuj51K/c0u+IF9GFOBNSJkoCxm1LSNH2ZRt84nomlyQcZpKK1FFuICjXLrPRyLbARaA=
Received: from BL0PR02CA0078.namprd02.prod.outlook.com (2603:10b6:208:51::19)
 by DM6PR02MB4604.namprd02.prod.outlook.com (2603:10b6:5:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Wed, 8 Jan
 2020 23:54:48 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BL0PR02CA0078.outlook.office365.com
 (2603:10b6:208:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 8 Jan 2020 23:54:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Wed, 8 Jan 2020 23:54:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9z-0003py-Du; Wed, 08 Jan 2020 15:54:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9u-0002BN-9e; Wed, 08 Jan 2020 15:54:42 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9l-0002A4-IW; Wed, 08 Jan 2020 15:54:33 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Date:   Wed,  8 Jan 2020 15:54:20 -0800
Message-Id: <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(336012)(9786002)(5660300002)(36756003)(30864003)(70206006)(70586007)(316002)(54906003)(8936002)(4326008)(356004)(107886003)(81166006)(6636002)(7696005)(426003)(186003)(2906002)(26005)(7416002)(2616005)(6666004)(8676002)(81156014)(478600001)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4604;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e3c87d6-a7b6-473e-5b8a-08d7949624db
X-MS-TrafficTypeDiagnostic: DM6PR02MB4604:
X-Microsoft-Antispam-PRVS: <DM6PR02MB460430BD51EFD3A577B18193B83E0@DM6PR02MB4604.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6NEKb2B5xaO3RmbU4lrsOXNrNX0pWfr4jIdz5dLVfirbcJGb0KuaeWXxSntDPlCZAgGETjHSSP4j791I/Nr2gnshKk9snTwkVFyvDDElnZJD59t//uODVk9hetZGbytw368G5Pj2QP6no9d714jQnqXHcFOW4olgEd2AZnUNqtXsUPv0jMlA9b5xw81VG47bSJTKyThs9Ec2CnmBo6FMCFYXDRWcp2iw0nOY4NBKd6Ni6tZo567k4wMH8bZAVafznC87tFrYS4hX8TdNLBQseiFgrXm+Li9KotD6UmgLqXyAXioH0H1sInRE9Q95fjN+3c3kVZ14Ow6qT1/jANtvYhkSyyiOy6USV1r05jhp+BOIVAnwXlixyqc/kvD0oRo7pSFABWxpdtWVtsX1SoNlV+xm/ywFVQ4LYr5aDiqJd2Nq41Y2ktATvisibXaIong
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 23:54:47.8173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3c87d6-a7b6-473e-5b8a-08d7949624db
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Firmware-ggs sysfs interface which provides read/write
interface to global storage registers.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
Changes in v2:
 - Updated Linux kernel version in documentation.
 - Used DEVICE_ATTR_* and ATTRIBUTE_GROUPS macros.
 - Free Kobject structure in case of error.
 - Resolved smatch errors.
 - Updated Signed-off-by sequence.
---
 Documentation/ABI/stable/sysfs-firmware-zynqmp |  50 +++++
 drivers/firmware/xilinx/Makefile               |   2 +-
 drivers/firmware/xilinx/zynqmp-ggs.c           | 284 +++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c               |  32 +++
 include/linux/firmware/xlnx-zynqmp.h           |  10 +
 5 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-firmware-zynqmp
 create mode 100644 drivers/firmware/xilinx/zynqmp-ggs.c

diff --git a/Documentation/ABI/stable/sysfs-firmware-zynqmp b/Documentation/ABI/stable/sysfs-firmware-zynqmp
new file mode 100644
index 0000000..cffa2fc
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-firmware-zynqmp
@@ -0,0 +1,50 @@
+What:		/sys/firmware/zynqmp/ggs*
+Date:		January 2018
+KernelVersion:	5.5
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU global general storage register value,
+		GLOBAL_GEN_STORAGE{0:3}.
+		Global general storage register that can be used
+		by system to pass information between masters.
+
+		The register is reset during system or power-on
+		resets. Three registers are used by the FSBL and
+		other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
+
+		Usage:
+		# cat /sys/firmware/zynqmp/ggs0
+		# echo <mask> <value> > /sys/firmware/zynqmp/ggs0
+
+		Example:
+		# cat /sys/firmware/zynqmp/ggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
+
+Users:		Xilinx
+
+What:		/sys/firmware/zynqmp/pggs*
+Date:		January 2018
+KernelVersion:	5.5
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU persistent global general storage register
+		value, PERS_GLOB_GEN_STORAGE{0:3}.
+		Persistent global general storage register that
+		can be used by system to pass information between
+		masters.
+
+		This register is only reset by the power-on reset
+		and maintains its value through a system reset.
+		Four registers are used by the FSBL and other Xilinx
+		software products: PERS_GLOB_GEN_STORAGE{4:7}.
+		Register is reset only by a POR reset.
+
+		Usage:
+		# cat /sys/firmware/zynqmp/pggs0
+		# echo <mask> <value> > /sys/firmware/zynqmp/pggs0
+
+		Example:
+		# cat /sys/firmware/zynqmp/pggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/pggs0
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 875a537..1e8643c 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Xilinx firmwares
 
-obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o zynqmp-ggs.o
 obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-ggs.c b/drivers/firmware/xilinx/zynqmp-ggs.c
new file mode 100644
index 0000000..e2a6700
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-ggs.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (IS_ERR(eemi_ops) || !eemi_ops->ioctl)
+		return -EFAULT;
+
+	ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret_payload[1]);
+}
+
+static ssize_t write_register(const char *buf, size_t count, u32 read_ioctl,
+			      u32 write_ioctl, u32 reg)
+{
+	char *kern_buff, *inbuf, *tok;
+	long mask, value;
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (IS_ERR(eemi_ops) || !eemi_ops->ioctl)
+		return -EFAULT;
+
+	kern_buff = kzalloc(count, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	ret = strlcpy(kern_buff, buf, count);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	inbuf = kern_buff;
+
+	/* Read the write mask */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtol(tok, 16, &mask);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the write value */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtol(tok, 16, &value);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+	ret_payload[1] &= ~mask;
+	value &= mask;
+	value |= ret_payload[1];
+
+	ret = eemi_ops->ioctl(0, write_ioctl, reg, value, NULL);
+	if (ret)
+		ret = -EFAULT;
+
+err:
+	kfree(kern_buff);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * ggs_show - Show global general storage (ggs) sysfs attribute
+ * @device: Device structure
+ * @attr: Device attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a ggs register value.
+ *
+ * User-space interface for viewing the content of the ggs0 register.
+ * cat /sys/firmware/zynqmp/ggs0
+ */
+static ssize_t ggs_show(struct device *device,
+			struct device_attribute *attr,
+			char *buf,
+			u32 reg)
+{
+	return read_register(buf, IOCTL_READ_GGS, reg);
+}
+
+/**
+ * ggs_store - Store global general storage (ggs) sysfs attribute
+ * @device: Device structure
+ * @attr: Device attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a ggs register value.
+ *
+ * For example, the user-space interface for storing a value to the
+ * ggs0 register:
+ * echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
+ */
+static ssize_t ggs_store(struct device *device,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count,
+			 u32 reg)
+{
+	if (!device || !attr || !buf || !count || reg >= GSS_NUM_REGS)
+		return -EINVAL;
+
+	return write_register(buf, count, IOCTL_READ_GGS, IOCTL_WRITE_GGS, reg);
+}
+
+/* GGS register show functions */
+#define GGS0_SHOW(N)						\
+	ssize_t ggs##N##_show(struct device *device,		\
+			      struct device_attribute *attr,	\
+			      char *buf)			\
+	{							\
+		return ggs_show(device, attr, buf, N);		\
+	}
+
+static GGS0_SHOW(0);
+static GGS0_SHOW(1);
+static GGS0_SHOW(2);
+static GGS0_SHOW(3);
+
+/* GGS register store function */
+#define GGS0_STORE(N)						\
+	ssize_t ggs##N##_store(struct device *device,		\
+			       struct device_attribute *attr,	\
+			       const char *buf,			\
+			       size_t count)			\
+	{							\
+		return ggs_store(device, attr, buf, count, N);	\
+	}
+
+static GGS0_STORE(0);
+static GGS0_STORE(1);
+static GGS0_STORE(2);
+static GGS0_STORE(3);
+
+/**
+ * pggs_show - Show persistent global general storage (pggs) sysfs attribute
+ * @device: Device structure
+ * @attr: Device attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a pggs register value.
+ */
+static ssize_t pggs_show(struct device *device,
+			 struct device_attribute *attr,
+			 char *buf,
+			 u32 reg)
+{
+	return read_register(buf, IOCTL_READ_PGGS, reg);
+}
+
+/**
+ * pggs_store - Store persistent global general storage (pggs) sysfs attribute
+ * @device: Device structure
+ * @attr: Device attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a pggs register value.
+ */
+static ssize_t pggs_store(struct device *device,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count,
+			  u32 reg)
+{
+	return write_register(buf, count, IOCTL_READ_PGGS,
+			      IOCTL_WRITE_PGGS, reg);
+}
+
+#define PGGS0_SHOW(N)						\
+	ssize_t pggs##N##_show(struct device *device,		\
+			       struct device_attribute *attr,	\
+			       char *buf)			\
+	{							\
+		return pggs_show(device, attr, buf, N);		\
+	}
+
+#define PGGS0_STORE(N)						\
+	ssize_t pggs##N##_store(struct device *device,		\
+				struct device_attribute *attr,	\
+				const char *buf,		\
+				size_t count)			\
+	{							\
+		return pggs_store(device, attr, buf, count, N);	\
+	}
+
+/* PGGS register show functions */
+static PGGS0_SHOW(0);
+static PGGS0_SHOW(1);
+static PGGS0_SHOW(2);
+static PGGS0_SHOW(3);
+
+/* PGGS register store functions */
+static PGGS0_STORE(0);
+static PGGS0_STORE(1);
+static PGGS0_STORE(2);
+static PGGS0_STORE(3);
+
+/* GGS register attributes */
+static DEVICE_ATTR_RW(ggs0);
+static DEVICE_ATTR_RW(ggs1);
+static DEVICE_ATTR_RW(ggs2);
+static DEVICE_ATTR_RW(ggs3);
+
+/* PGGS register attributes */
+static DEVICE_ATTR_RW(pggs0);
+static DEVICE_ATTR_RW(pggs1);
+static DEVICE_ATTR_RW(pggs2);
+static DEVICE_ATTR_RW(pggs3);
+
+static struct attribute *zynqmp_ggs_attrs[] = {
+	&dev_attr_ggs0.attr,
+	&dev_attr_ggs1.attr,
+	&dev_attr_ggs2.attr,
+	&dev_attr_ggs3.attr,
+	&dev_attr_pggs0.attr,
+	&dev_attr_pggs1.attr,
+	&dev_attr_pggs2.attr,
+	&dev_attr_pggs3.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(zynqmp_ggs);
+
+int zynqmp_pm_ggs_init(struct kobject *parent_kobj)
+{
+	return sysfs_create_group(parent_kobj, zynqmp_ggs_groups[0]);
+}
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 75bdfaa..4c1117d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -473,6 +473,10 @@ static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
 	case IOCTL_GET_PLL_FRAC_MODE:
 	case IOCTL_SET_PLL_FRAC_DATA:
 	case IOCTL_GET_PLL_FRAC_DATA:
+	case IOCTL_WRITE_GGS:
+	case IOCTL_READ_GGS:
+	case IOCTL_WRITE_PGGS:
+	case IOCTL_READ_PGGS:
 		return 1;
 	default:
 		return 0;
@@ -704,6 +708,28 @@ const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
 
+static int zynqmp_pm_sysfs_init(void)
+{
+	struct kobject *zynqmp_kobj;
+	int ret;
+
+	zynqmp_kobj = kobject_create_and_add("zynqmp", firmware_kobj);
+	if (!zynqmp_kobj) {
+		pr_err("zynqmp: Firmware kobj add failed.\n");
+		return -ENOMEM;
+	}
+
+	ret = zynqmp_pm_ggs_init(zynqmp_kobj);
+	if (ret) {
+		kobject_put(zynqmp_kobj);
+		pr_err("%s() GGS init fail with error %d\n",
+		       __func__, ret);
+		goto err;
+	}
+err:
+	return ret;
+}
+
 static int zynqmp_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -751,6 +777,12 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	/* Assign eemi_ops_table */
 	eemi_ops_tbl = &eemi_ops;
 
+	ret = zynqmp_pm_sysfs_init();
+	if (ret) {
+		pr_err("%s() sysfs init fail with error %d\n", __func__, ret);
+		return ret;
+	}
+
 	zynqmp_pm_api_debugfs_init();
 
 	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e41ad9e..534814e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -13,6 +13,8 @@
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
 
+#include <linux/device.h>
+
 #define ZYNQMP_PM_VERSION_MAJOR	1
 #define ZYNQMP_PM_VERSION_MINOR	0
 
@@ -42,6 +44,8 @@
 
 #define ZYNQMP_PM_MAX_QOS		100U
 
+#define GSS_NUM_REGS	(4)
+
 /* Node capabilities */
 #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
 #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
@@ -97,6 +101,10 @@ enum pm_ioctl_id {
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
+	IOCTL_WRITE_GGS,
+	IOCTL_READ_GGS,
+	IOCTL_WRITE_PGGS,
+	IOCTL_READ_PGGS,
 };
 
 enum pm_query_id {
@@ -311,6 +319,8 @@ struct zynqmp_eemi_ops {
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
+int zynqmp_pm_ggs_init(struct kobject *parent_kobj);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4

