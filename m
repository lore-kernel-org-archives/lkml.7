Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D31C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11F52146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Yuwz9zhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCSVyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:54:54 -0400
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:30503
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbfCSVyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikwhRobiAPAIyj7bqWFpDBd/PXuKxOgoI/Euv31ZV1Y=;
 b=Yuwz9zhpZ6gS6KlEBt2jHrq4wTt6nDnz3//a8N/S2OWS+Ywqiao41MDXRPM93keHSERtMXAXBQx2bU53fR+oqubRCj2SoRROLogB+hGQG8iXAl5P67GAxc0s0etRqplD8SFqaL4PCTFMzaOsUj8XNzalycq0vqEDldruZILEN3Y=
Received: from BN6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:405:60::17)
 by DM6PR02MB5915.namprd02.prod.outlook.com (2603:10b6:5:152::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 21:54:15 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN6PR02CA0076.outlook.office365.com
 (2603:10b6:405:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 21:54:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 21:54:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52713 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgY-0002CI-6V; Tue, 19 Mar 2019 14:54:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgT-0001Ps-2x; Tue, 19 Mar 2019 14:54:09 -0700
Received: from [172.19.73.196] (helo=xsjsonals5570.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <sonals@xilinx.com>)
        id 1h6MgL-0001KP-QV; Tue, 19 Mar 2019 14:54:01 -0700
Received: by xsjsonals5570.xilinx.com (Postfix, from userid 1000)
        id 8998A76001F; Tue, 19 Mar 2019 14:54:01 -0700 (PDT)
From:   <sonal.santan@xilinx.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <airlied@redhat.com>, <cyrilc@xilinx.com>, <michals@xilinx.com>,
        <lizhih@xilinx.com>, <hyunk@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>
Subject: [RFC PATCH Xilinx Alveo 3/6] Add platform drivers for various IPs and frameworks
Date:   Tue, 19 Mar 2019 14:53:58 -0700
Message-ID: <20190319215401.6562-4-sonal.santan@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190319215401.6562-1-sonal.santan@xilinx.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(51234002)(336012)(42186006)(6666004)(106466001)(53946003)(63266004)(81166006)(8676002)(81156014)(30864003)(478600001)(11346002)(51416003)(446003)(5024004)(8936002)(52956003)(6916009)(966005)(486006)(476003)(126002)(90966002)(426003)(106002)(14444005)(1076003)(2616005)(186003)(76176011)(6306002)(50226002)(26005)(356004)(2876002)(305945005)(50466002)(36386004)(107886003)(6266002)(54906003)(36756003)(103686004)(86152003)(47776003)(48376002)(2351001)(16586007)(316002)(2906002)(5660300002)(4326008)(2004002)(5001870100001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5915;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ddb868-f89f-4bd5-5d8d-08d6acb56de8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB5915;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5915:
X-MS-Exchange-PUrlCount: 2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB591529539A540362D72449D7BB400@DM6PR02MB5915.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ogUgcHm797GG4rasnTSTaq/fknYNPjGJngO0GwqcUe3l67uSybzzqAzH1qHjIOYIsvKcASZu0woKZJQfF+e1GhN5MJU67WCzqLqtTT7NPLGIms1EEp2F3cE+WBeieODlDDE6hTN7BZmxo671BSAs7EHk+PYNV956E84BRp4HVLv949hrIMMB0P8nPhwtmp/L9jgt2/9vmb5h/tPEnPTfkF78JZvv5ijavrdGoEb3cLMXMZI/Gv50ni4cFCh/PwHJxFF3jgBI4Ptv76Ro+Xk6MSfuj6eV6u3DvN2eOMNEl/Mxl6e+bORNzAfSvF+J1jnfyleC96PrjM7LNCplxJnmLs8NIek3Kwn/RoHNacgRDs3V9Q5uc2+KTHBw0OkdqKCe4rPfyHOqBzFvOu9ZNWHFi9N9jEvHL1IJA7bHaynFzNI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 21:54:14.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ddb868-f89f-4bd5-5d8d-08d6acb56de8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/gpu/drm/xocl/subdev/dna.c          |  356 +++
 drivers/gpu/drm/xocl/subdev/feature_rom.c  |  412 +++
 drivers/gpu/drm/xocl/subdev/firewall.c     |  389 +++
 drivers/gpu/drm/xocl/subdev/fmgr.c         |  198 ++
 drivers/gpu/drm/xocl/subdev/icap.c         | 2859 ++++++++++++++++++
 drivers/gpu/drm/xocl/subdev/mailbox.c      | 1868 ++++++++++++
 drivers/gpu/drm/xocl/subdev/mb_scheduler.c | 3059 ++++++++++++++++++++
 drivers/gpu/drm/xocl/subdev/microblaze.c   |  722 +++++
 drivers/gpu/drm/xocl/subdev/mig.c          |  256 ++
 drivers/gpu/drm/xocl/subdev/sysmon.c       |  385 +++
 drivers/gpu/drm/xocl/subdev/xdma.c         |  510 ++++
 drivers/gpu/drm/xocl/subdev/xmc.c          | 1480 ++++++++++
 drivers/gpu/drm/xocl/subdev/xvc.c          |  461 +++
 13 files changed, 12955 insertions(+)
 create mode 100644 drivers/gpu/drm/xocl/subdev/dna.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/feature_rom.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/firewall.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/fmgr.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/icap.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/mailbox.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/mb_scheduler.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/microblaze.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/mig.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/sysmon.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/xdma.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/xmc.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/xvc.c

diff --git a/drivers/gpu/drm/xocl/subdev/dna.c b/drivers/gpu/drm/xocl/subdev/dna.c
new file mode 100644
index 000000000000..991d98e5b9aa
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/dna.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Chien-Wei Lan <chienwei@xilinx.com>
+ *
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/vmalloc.h>
+#include "../xocl_drv.h"
+#include <drm/xmgmt_drm.h>
+
+/* Registers are defined in pg150-ultrascale-memory-ip.pdf:
+ * AXI4-Lite Slave Control/Status Register Map
+ */
+#define XLNX_DNA_MEMORY_MAP_MAGIC_IS_DEFINED                        (0x3E4D7732)
+#define XLNX_DNA_MAJOR_MINOR_VERSION_REGISTER_OFFSET                0x00          //  RO
+#define XLNX_DNA_REVISION_REGISTER_OFFSET                           0x04          //  RO
+#define XLNX_DNA_CAPABILITY_REGISTER_OFFSET                         0x08          //  RO
+//#define XLNX_DNA_SCRATCHPAD_REGISTER_OFFSET                         (0x0C)          //  RO (31-1) + RW (0)
+#define XLNX_DNA_STATUS_REGISTER_OFFSET                             0x10            //  RO
+#define XLNX_DNA_FSM_DNA_WORD_WRITE_COUNT_REGISTER_OFFSET           (0x14)          //  RO
+#define XLNX_DNA_FSM_CERTIFICATE_WORD_WRITE_COUNT_REGISTER_OFFSET   (0x18)          //  RO
+#define XLNX_DNA_MESSAGE_START_AXI_ONLY_REGISTER_OFFSET             (0x20)          //  RO (31-1) + RW (0)
+#define XLNX_DNA_READBACK_REGISTER_2_OFFSET                         0x40            //  RO XLNX_DNA_BOARD_DNA_95_64
+#define XLNX_DNA_READBACK_REGISTER_1_OFFSET                         0x44            //  RO XLNX_DNA_BOARD_DNA_63_32
+#define XLNX_DNA_READBACK_REGISTER_0_OFFSET                         0x48            //  RO XLNX_DNA_BOARD_DNA_31_0
+#define XLNX_DNA_DATA_AXI_ONLY_REGISTER_OFFSET                      (0x80)          //  WO
+#define XLNX_DNA_CERTIFICATE_DATA_AXI_ONLY_REGISTER_OFFSET          (0xC0)          //  WO - 512 bit aligned.
+#define XLNX_DNA_MAX_ADDRESS_WORDS                                  (0xC4)
+
+struct xocl_xlnx_dna {
+	void __iomem		*base;
+	struct device		*xlnx_dna_dev;
+	struct mutex		xlnx_dna_lock;
+};
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xlnx_dna *xlnx_dna = dev_get_drvdata(dev);
+	u32 status;
+
+	status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+
+	return sprintf(buf, "0x%x\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t dna_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xlnx_dna *xlnx_dna = dev_get_drvdata(dev);
+	uint32_t dna96_64, dna63_32, dna31_0;
+
+	dna96_64 = ioread32(xlnx_dna->base+XLNX_DNA_READBACK_REGISTER_2_OFFSET);
+	dna63_32 = ioread32(xlnx_dna->base+XLNX_DNA_READBACK_REGISTER_1_OFFSET);
+	dna31_0  = ioread32(xlnx_dna->base+XLNX_DNA_READBACK_REGISTER_0_OFFSET);
+
+	return sprintf(buf, "%08x%08x%08x\n", dna96_64, dna63_32, dna31_0);
+}
+static DEVICE_ATTR_RO(dna);
+
+static ssize_t capability_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xlnx_dna *xlnx_dna = dev_get_drvdata(dev);
+	u32 capability;
+
+	capability = ioread32(xlnx_dna->base+XLNX_DNA_CAPABILITY_REGISTER_OFFSET);
+
+	return sprintf(buf, "0x%x\n", capability);
+}
+static DEVICE_ATTR_RO(capability);
+
+
+static ssize_t dna_version_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xlnx_dna *xlnx_dna = dev_get_drvdata(dev);
+	u32 version;
+
+	version = ioread32(xlnx_dna->base+XLNX_DNA_MAJOR_MINOR_VERSION_REGISTER_OFFSET);
+
+	return sprintf(buf, "%d.%d\n", version>>16, version & 0xffff);
+}
+static DEVICE_ATTR_RO(dna_version);
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xlnx_dna *xlnx_dna = dev_get_drvdata(dev);
+	u32 revision;
+
+	revision = ioread32(xlnx_dna->base+XLNX_DNA_REVISION_REGISTER_OFFSET);
+
+	return sprintf(buf, "%d\n", revision);
+}
+static DEVICE_ATTR_RO(revision);
+
+static struct attribute *xlnx_dna_attributes[] = {
+	&dev_attr_status.attr,
+	&dev_attr_dna.attr,
+	&dev_attr_capability.attr,
+	&dev_attr_dna_version.attr,
+	&dev_attr_revision.attr,
+	NULL
+};
+
+static const struct attribute_group xlnx_dna_attrgroup = {
+	.attrs = xlnx_dna_attributes,
+};
+
+static uint32_t dna_status(struct platform_device *pdev)
+{
+	struct xocl_xlnx_dna *xlnx_dna = platform_get_drvdata(pdev);
+	uint32_t status = 0;
+	uint8_t retries = 10;
+	bool rsa4096done = false;
+
+	if (!xlnx_dna)
+		return status;
+
+	while (!rsa4096done && retries) {
+		status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+		if (status>>8 & 0x1) {
+			rsa4096done = true;
+			break;
+		}
+		msleep(1);
+		retries--;
+	}
+
+	if (retries == 0)
+		return -EBUSY;
+
+	status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+
+	return status;
+}
+
+static uint32_t dna_capability(struct platform_device *pdev)
+{
+	struct xocl_xlnx_dna *xlnx_dna = platform_get_drvdata(pdev);
+	u32 capability = 0;
+
+	if (!xlnx_dna)
+		return capability;
+
+	capability = ioread32(xlnx_dna->base+XLNX_DNA_CAPABILITY_REGISTER_OFFSET);
+
+	return capability;
+}
+
+static void dna_write_cert(struct platform_device *pdev, const uint32_t *cert, uint32_t len)
+{
+	struct xocl_xlnx_dna *xlnx_dna = platform_get_drvdata(pdev);
+	int i, j, k;
+	u32 status = 0, words;
+	uint8_t retries = 100;
+	bool sha256done = false;
+	uint32_t convert;
+	uint32_t sign_start, message_words = (len-512)>>2;
+
+	sign_start = message_words;
+
+	if (!xlnx_dna)
+		return;
+
+	iowrite32(0x1, xlnx_dna->base+XLNX_DNA_MESSAGE_START_AXI_ONLY_REGISTER_OFFSET);
+	status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+	xocl_info(&pdev->dev, "Start: status %08x", status);
+
+	for (i = 0; i < message_words; i += 16) {
+
+		retries = 100;
+		sha256done = false;
+
+		while (!sha256done && retries) {
+			status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+			if (!(status >> 4 & 0x1)) {
+				sha256done = true;
+				break;
+			}
+			msleep(10);
+			retries--;
+		}
+		for (j = 0; j < 16; ++j) {
+			convert = (*(cert+i+j) >> 24 & 0xff) | (*(cert+i+j) >> 8 & 0xff00) |
+				(*(cert+i+j) << 8 & 0xff0000) | ((*(cert+i+j) & 0xff) << 24);
+			iowrite32(convert, xlnx_dna->base+XLNX_DNA_DATA_AXI_ONLY_REGISTER_OFFSET+j*4);
+		}
+	}
+	retries = 100;
+	sha256done = false;
+	while (!sha256done && retries) {
+		status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+		if (!(status >> 4 & 0x1)) {
+			sha256done = true;
+			break;
+		}
+		msleep(10);
+		retries--;
+	}
+
+	status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+	words  = ioread32(xlnx_dna->base+XLNX_DNA_FSM_DNA_WORD_WRITE_COUNT_REGISTER_OFFSET);
+	xocl_info(&pdev->dev, "Message: status %08x dna words %d", status, words);
+
+	for (k = 0; k < 128; k += 16) {
+		for (i = 0; i < 16; i++) {
+			j = k+i+sign_start;
+			convert = (*(cert + j) >> 24 & 0xff) | (*(cert + j) >> 8 & 0xff00) |
+				(*(cert + j) << 8 & 0xff0000) | ((*(cert + j) & 0xff) << 24);
+			iowrite32(convert, xlnx_dna->base+XLNX_DNA_CERTIFICATE_DATA_AXI_ONLY_REGISTER_OFFSET + i * 4);
+		}
+	}
+
+	status = ioread32(xlnx_dna->base+XLNX_DNA_STATUS_REGISTER_OFFSET);
+	words  = ioread32(xlnx_dna->base+XLNX_DNA_FSM_CERTIFICATE_WORD_WRITE_COUNT_REGISTER_OFFSET);
+	xocl_info(&pdev->dev, "Signature: status %08x certificate words %d", status, words);
+}
+
+static struct xocl_dna_funcs dna_ops = {
+	.status = dna_status,
+	.capability = dna_capability,
+	.write_cert = dna_write_cert,
+};
+
+
+static void mgmt_sysfs_destroy_xlnx_dna(struct platform_device *pdev)
+{
+	struct xocl_xlnx_dna *xlnx_dna;
+
+	xlnx_dna = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &xlnx_dna_attrgroup);
+
+}
+
+static int mgmt_sysfs_create_xlnx_dna(struct platform_device *pdev)
+{
+	struct xocl_xlnx_dna *xlnx_dna;
+	struct xocl_dev_core *core;
+	int err;
+
+	xlnx_dna = platform_get_drvdata(pdev);
+	core = XDEV(xocl_get_xdev(pdev));
+
+	err = sysfs_create_group(&pdev->dev.kobj, &xlnx_dna_attrgroup);
+	if (err) {
+		xocl_err(&pdev->dev, "create pw group failed: 0x%x", err);
+		goto create_grp_failed;
+	}
+
+	return 0;
+
+create_grp_failed:
+	return err;
+}
+
+static int xlnx_dna_probe(struct platform_device *pdev)
+{
+	struct xocl_xlnx_dna *xlnx_dna;
+	struct resource *res;
+	int err;
+
+	xlnx_dna = devm_kzalloc(&pdev->dev, sizeof(*xlnx_dna), GFP_KERNEL);
+	if (!xlnx_dna)
+		return -ENOMEM;
+
+	xlnx_dna->base = devm_kzalloc(&pdev->dev, sizeof(void __iomem *), GFP_KERNEL);
+	if (!xlnx_dna->base)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xocl_err(&pdev->dev, "resource is NULL");
+		return -EINVAL;
+	}
+	xocl_info(&pdev->dev, "IO start: 0x%llx, end: 0x%llx",
+		res->start, res->end);
+
+	xlnx_dna->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!xlnx_dna->base) {
+		err = -EIO;
+		xocl_err(&pdev->dev, "Map iomem failed");
+		goto failed;
+	}
+
+	platform_set_drvdata(pdev, xlnx_dna);
+
+	err = mgmt_sysfs_create_xlnx_dna(pdev);
+	if (err)
+		goto create_xlnx_dna_failed;
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_DNA, &dna_ops);
+
+	return 0;
+
+create_xlnx_dna_failed:
+	platform_set_drvdata(pdev, NULL);
+failed:
+	return err;
+}
+
+
+static int xlnx_dna_remove(struct platform_device *pdev)
+{
+	struct xocl_xlnx_dna	*xlnx_dna;
+
+	xlnx_dna = platform_get_drvdata(pdev);
+	if (!xlnx_dna) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	mgmt_sysfs_destroy_xlnx_dna(pdev);
+
+	if (xlnx_dna->base)
+		iounmap(xlnx_dna->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, xlnx_dna);
+
+	return 0;
+}
+
+struct platform_device_id xlnx_dna_id_table[] = {
+	{ XOCL_DNA, 0 },
+	{ },
+};
+
+static struct platform_driver	xlnx_dna_driver = {
+	.probe		= xlnx_dna_probe,
+	.remove		= xlnx_dna_remove,
+	.driver		= {
+		.name = "xocl_dna",
+	},
+	.id_table = xlnx_dna_id_table,
+};
+
+int __init xocl_init_dna(void)
+{
+	return platform_driver_register(&xlnx_dna_driver);
+}
+
+void xocl_fini_dna(void)
+{
+	platform_driver_unregister(&xlnx_dna_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/feature_rom.c b/drivers/gpu/drm/xocl/subdev/feature_rom.c
new file mode 100644
index 000000000000..f898af6844aa
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/feature_rom.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include "../xclfeatures.h"
+#include "../xocl_drv.h"
+
+#define	MAGIC_NUM	0x786e6c78
+struct feature_rom {
+	void __iomem		*base;
+
+	struct FeatureRomHeader	header;
+	unsigned int            dsa_version;
+	bool			unified;
+	bool			mb_mgmt_enabled;
+	bool			mb_sche_enabled;
+	bool			are_dev;
+	bool			aws_dev;
+};
+
+static ssize_t VBNV_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct feature_rom *rom = platform_get_drvdata(to_platform_device(dev));
+
+	return sprintf(buf, "%s\n", rom->header.VBNVName);
+}
+static DEVICE_ATTR_RO(VBNV);
+
+static ssize_t dr_base_addr_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct feature_rom *rom = platform_get_drvdata(to_platform_device(dev));
+
+	//TODO: Fix: DRBaseAddress no longer required in feature rom
+	if (rom->header.MajorVersion >= 10)
+		return sprintf(buf, "%llu\n", rom->header.DRBaseAddress);
+	else
+		return sprintf(buf, "%u\n", 0);
+}
+static DEVICE_ATTR_RO(dr_base_addr);
+
+static ssize_t ddr_bank_count_max_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct feature_rom *rom = platform_get_drvdata(to_platform_device(dev));
+
+	return sprintf(buf, "%d\n", rom->header.DDRChannelCount);
+}
+static DEVICE_ATTR_RO(ddr_bank_count_max);
+
+static ssize_t ddr_bank_size_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct feature_rom *rom = platform_get_drvdata(to_platform_device(dev));
+
+	return sprintf(buf, "%d\n", rom->header.DDRChannelSize);
+}
+static DEVICE_ATTR_RO(ddr_bank_size);
+
+static ssize_t timestamp_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct feature_rom *rom = platform_get_drvdata(to_platform_device(dev));
+
+	return sprintf(buf, "%llu\n", rom->header.TimeSinceEpoch);
+}
+static DEVICE_ATTR_RO(timestamp);
+
+static ssize_t FPGA_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct feature_rom *rom = platform_get_drvdata(to_platform_device(dev));
+
+	return sprintf(buf, "%s\n", rom->header.FPGAPartName);
+}
+static DEVICE_ATTR_RO(FPGA);
+
+static struct attribute *rom_attrs[] = {
+	&dev_attr_VBNV.attr,
+	&dev_attr_dr_base_addr.attr,
+	&dev_attr_ddr_bank_count_max.attr,
+	&dev_attr_ddr_bank_size.attr,
+	&dev_attr_timestamp.attr,
+	&dev_attr_FPGA.attr,
+	NULL,
+};
+
+static struct attribute_group rom_attr_group = {
+	.attrs = rom_attrs,
+};
+
+static unsigned int dsa_version(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->dsa_version;
+}
+
+static bool is_unified(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->unified;
+}
+
+static bool mb_mgmt_on(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->mb_mgmt_enabled;
+}
+
+static bool mb_sched_on(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->mb_sche_enabled && !XOCL_DSA_MB_SCHE_OFF(xocl_get_xdev(pdev));
+}
+
+static uint32_t *get_cdma_base_addresses(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return (rom->header.FeatureBitMap & CDMA) ? rom->header.CDMABaseAddress : 0;
+}
+
+static u16 get_ddr_channel_count(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->header.DDRChannelCount;
+}
+
+static u64 get_ddr_channel_size(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->header.DDRChannelSize;
+}
+
+static u64 get_timestamp(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->header.TimeSinceEpoch;
+}
+
+static bool is_are(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->are_dev;
+}
+
+static bool is_aws(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	return rom->aws_dev;
+}
+
+static bool verify_timestamp(struct platform_device *pdev, u64 timestamp)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	xocl_info(&pdev->dev, "DSA timestamp: 0x%llx",
+		rom->header.TimeSinceEpoch);
+	xocl_info(&pdev->dev, "Verify timestamp: 0x%llx", timestamp);
+	return (rom->header.TimeSinceEpoch == timestamp);
+}
+
+static void get_raw_header(struct platform_device *pdev, void *header)
+{
+	struct feature_rom *rom;
+
+	rom = platform_get_drvdata(pdev);
+	BUG_ON(!rom);
+
+	memcpy(header, &rom->header, sizeof(rom->header));
+}
+
+static struct xocl_rom_funcs rom_ops = {
+	.dsa_version = dsa_version,
+	.is_unified = is_unified,
+	.mb_mgmt_on = mb_mgmt_on,
+	.mb_sched_on = mb_sched_on,
+	.cdma_addr = get_cdma_base_addresses,
+	.get_ddr_channel_count = get_ddr_channel_count,
+	.get_ddr_channel_size = get_ddr_channel_size,
+	.is_are = is_are,
+	.is_aws = is_aws,
+	.verify_timestamp = verify_timestamp,
+	.get_timestamp = get_timestamp,
+	.get_raw_header = get_raw_header,
+};
+
+static int feature_rom_probe(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+	struct resource *res;
+	u32	val;
+	u16	vendor, did;
+	char	*tmp;
+	int	ret;
+
+	rom = devm_kzalloc(&pdev->dev, sizeof(*rom), GFP_KERNEL);
+	if (!rom)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rom->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!rom->base) {
+		ret = -EIO;
+		xocl_err(&pdev->dev, "Map iomem failed");
+		goto failed;
+	}
+
+	val = ioread32(rom->base);
+	if (val != MAGIC_NUM) {
+		vendor = XOCL_PL_TO_PCI_DEV(pdev)->vendor;
+		did = XOCL_PL_TO_PCI_DEV(pdev)->device;
+		if (vendor == 0x1d0f && (did == 0x1042 || did == 0xf010)) { // MAGIC, we should define elsewhere
+			xocl_info(&pdev->dev,
+				"Found AWS VU9P Device without featureROM");
+			/*
+			 * This is AWS device. Fill the FeatureROM struct.
+			 * Right now it doesn't have FeatureROM
+			 */
+			memset(rom->header.EntryPointString, 0,
+				sizeof(rom->header.EntryPointString));
+			strncpy(rom->header.EntryPointString, "xlnx", 4);
+			memset(rom->header.FPGAPartName, 0,
+				sizeof(rom->header.FPGAPartName));
+			strncpy(rom->header.FPGAPartName, "AWS VU9P", 8);
+			memset(rom->header.VBNVName, 0,
+				sizeof(rom->header.VBNVName));
+			strncpy(rom->header.VBNVName,
+				"xilinx_aws-vu9p-f1_dynamic_5_0", 35);
+			rom->header.MajorVersion = 4;
+			rom->header.MinorVersion = 0;
+			rom->header.VivadoBuildID = 0xabcd;
+			rom->header.IPBuildID = 0xabcd;
+			rom->header.TimeSinceEpoch = 0xabcd;
+			rom->header.DDRChannelCount = 4;
+			rom->header.DDRChannelSize = 16;
+			rom->header.FeatureBitMap = 0x0;
+			rom->header.FeatureBitMap = UNIFIED_PLATFORM;
+			rom->unified = true;
+			rom->aws_dev = true;
+
+			xocl_info(&pdev->dev, "Enabling AWS dynamic 5.0 DSA");
+		} else {
+			xocl_err(&pdev->dev, "Magic number does not match, actual 0x%x, expected 0x%x",
+					val, MAGIC_NUM);
+			ret = -ENODEV;
+			goto failed;
+		}
+	}
+
+	xocl_memcpy_fromio(&rom->header, rom->base, sizeof(rom->header));
+
+	if (strstr(rom->header.VBNVName, "-xare")) {
+		/*
+		 * ARE device, ARE is mapped like another DDR inside FPGA;
+		 * map_connects as M04_AXI
+		 */
+		rom->header.DDRChannelCount = rom->header.DDRChannelCount - 1;
+		rom->are_dev = true;
+	}
+
+	rom->dsa_version = 0;
+	if (strstr(rom->header.VBNVName, "5_0"))
+		rom->dsa_version = 50;
+	else if (strstr(rom->header.VBNVName, "5_1")
+		 || strstr(rom->header.VBNVName, "u200_xdma_201820_1"))
+		rom->dsa_version = 51;
+	else if (strstr(rom->header.VBNVName, "5_2")
+		 || strstr(rom->header.VBNVName, "u200_xdma_201820_2")
+		 || strstr(rom->header.VBNVName, "u250_xdma_201820_1")
+		 || strstr(rom->header.VBNVName, "201830"))
+		rom->dsa_version = 52;
+	else if (strstr(rom->header.VBNVName, "5_3"))
+		rom->dsa_version = 53;
+
+	if (rom->header.FeatureBitMap & UNIFIED_PLATFORM)
+		rom->unified = true;
+
+	if (rom->header.FeatureBitMap & BOARD_MGMT_ENBLD)
+		rom->mb_mgmt_enabled = true;
+
+	if (rom->header.FeatureBitMap & MB_SCHEDULER)
+		rom->mb_sche_enabled = true;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &rom_attr_group);
+	if (ret) {
+		xocl_err(&pdev->dev, "create sysfs failed");
+		goto failed;
+	}
+
+	tmp = rom->header.EntryPointString;
+	xocl_info(&pdev->dev, "ROM magic : %c%c%c%c",
+		tmp[0], tmp[1], tmp[2], tmp[3]);
+	xocl_info(&pdev->dev, "VBNV: %s", rom->header.VBNVName);
+	xocl_info(&pdev->dev, "DDR channel count : %d",
+		rom->header.DDRChannelCount);
+	xocl_info(&pdev->dev, "DDR channel size: %d GB",
+		rom->header.DDRChannelSize);
+	xocl_info(&pdev->dev, "Major Version: %d", rom->header.MajorVersion);
+	xocl_info(&pdev->dev, "Minor Version: %d", rom->header.MinorVersion);
+	xocl_info(&pdev->dev, "IPBuildID: %u", rom->header.IPBuildID);
+	xocl_info(&pdev->dev, "TimeSinceEpoch: %llx",
+		rom->header.TimeSinceEpoch);
+	xocl_info(&pdev->dev, "FeatureBitMap: %llx", rom->header.FeatureBitMap);
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_FEATURE_ROM, &rom_ops);
+	platform_set_drvdata(pdev, rom);
+
+	return 0;
+
+failed:
+	if (rom->base)
+		iounmap(rom->base);
+	devm_kfree(&pdev->dev, rom);
+	return ret;
+}
+
+static int feature_rom_remove(struct platform_device *pdev)
+{
+	struct feature_rom *rom;
+
+	xocl_info(&pdev->dev, "Remove feature rom");
+	rom = platform_get_drvdata(pdev);
+	if (!rom) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+	if (rom->base)
+		iounmap(rom->base);
+
+	sysfs_remove_group(&pdev->dev.kobj, &rom_attr_group);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, rom);
+	return 0;
+}
+
+struct platform_device_id rom_id_table[] =  {
+	{ XOCL_FEATURE_ROM, 0 },
+	{ },
+};
+
+static struct platform_driver	feature_rom_driver = {
+	.probe		= feature_rom_probe,
+	.remove		= feature_rom_remove,
+	.driver		= {
+		.name = XOCL_FEATURE_ROM,
+	},
+	.id_table = rom_id_table,
+};
+
+int __init xocl_init_feature_rom(void)
+{
+	return platform_driver_register(&feature_rom_driver);
+}
+
+void xocl_fini_feature_rom(void)
+{
+	return platform_driver_unregister(&feature_rom_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/firewall.c b/drivers/gpu/drm/xocl/subdev/firewall.c
new file mode 100644
index 000000000000..a32766507ae0
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/firewall.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  Copyright (C) 2017-2019 Xilinx, Inc. All rights reserved.
+ *
+ *  Utility Functions for AXI firewall IP.
+ *  Author: Lizhi.Hou@Xilinx.com
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/ktime.h>
+#include <linux/rtc.h>
+#include "../xocl_drv.h"
+
+/* Firewall registers */
+#define	FAULT_STATUS				0x0
+#define	SOFT_CTRL				0x4
+#define	UNBLOCK_CTRL				0x8
+// Firewall error bits
+#define READ_RESPONSE_BUSY                        BIT(0)
+#define RECS_ARREADY_MAX_WAIT                     BIT(1)
+#define RECS_CONTINUOUS_RTRANSFERS_MAX_WAIT       BIT(2)
+#define ERRS_RDATA_NUM                            BIT(3)
+#define ERRS_RID                                  BIT(4)
+#define WRITE_RESPONSE_BUSY                       BIT(16)
+#define RECS_AWREADY_MAX_WAIT                     BIT(17)
+#define RECS_WREADY_MAX_WAIT                      BIT(18)
+#define RECS_WRITE_TO_BVALID_MAX_WAIT             BIT(19)
+#define ERRS_BRESP                                BIT(20)
+
+#define	FIREWALL_STATUS_BUSY	(READ_RESPONSE_BUSY | WRITE_RESPONSE_BUSY)
+#define	CLEAR_RESET_GPIO		0
+
+#define	READ_STATUS(fw, id)			\
+	XOCL_READ_REG32(fw->base_addrs[id] + FAULT_STATUS)
+#define	WRITE_UNBLOCK_CTRL(fw, id, val)			\
+	XOCL_WRITE_REG32(val, fw->base_addrs[id] + UNBLOCK_CTRL)
+
+#define	IS_FIRED(fw, id) (READ_STATUS(fw, id) & ~FIREWALL_STATUS_BUSY)
+
+#define	BUSY_RETRY_COUNT		20
+#define	BUSY_RETRY_INTERVAL		100		/* ms */
+#define	CLEAR_RETRY_COUNT		4
+#define	CLEAR_RETRY_INTERVAL		2		/* ms */
+
+#define	MAX_LEVEL		16
+
+struct firewall {
+	void __iomem		*base_addrs[MAX_LEVEL];
+	u32			max_level;
+	void __iomem		*gpio_addr;
+
+	u32			curr_status;
+	int			curr_level;
+
+	u32			err_detected_status;
+	u32			err_detected_level;
+	u64			err_detected_time;
+
+	bool			inject_firewall;
+};
+
+static int clear_firewall(struct platform_device *pdev);
+static u32 check_firewall(struct platform_device *pdev, int *level);
+
+static int get_prop(struct platform_device *pdev, u32 prop, void *val)
+{
+	struct firewall *fw;
+
+	fw = platform_get_drvdata(pdev);
+	BUG_ON(!fw);
+
+	check_firewall(pdev, NULL);
+	switch (prop) {
+	case XOCL_AF_PROP_TOTAL_LEVEL:
+		*(u32 *)val = fw->max_level;
+		break;
+	case XOCL_AF_PROP_STATUS:
+		*(u32 *)val = fw->curr_status;
+		break;
+	case XOCL_AF_PROP_LEVEL:
+		*(int *)val = fw->curr_level;
+		break;
+	case XOCL_AF_PROP_DETECTED_STATUS:
+		*(u32 *)val = fw->err_detected_status;
+		break;
+	case XOCL_AF_PROP_DETECTED_LEVEL:
+		*(u32 *)val = fw->err_detected_level;
+		break;
+	case XOCL_AF_PROP_DETECTED_TIME:
+		*(u64 *)val = fw->err_detected_time;
+		break;
+	default:
+		xocl_err(&pdev->dev, "Invalid prop %d", prop);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* sysfs support */
+static ssize_t show_firewall(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct firewall *fw;
+	u64 t;
+	u32 val;
+	int ret;
+
+	fw = platform_get_drvdata(pdev);
+	BUG_ON(!fw);
+
+	if (attr->index == XOCL_AF_PROP_DETECTED_TIME) {
+		get_prop(pdev,  attr->index, &t);
+		return sprintf(buf, "%llu\n", t);
+	}
+
+	ret = get_prop(pdev, attr->index, &val);
+	if (ret)
+		return 0;
+
+	return sprintf(buf, "%u\n", val);
+}
+
+static SENSOR_DEVICE_ATTR(status, 0444, show_firewall, NULL,
+	XOCL_AF_PROP_STATUS);
+static SENSOR_DEVICE_ATTR(level, 0444, show_firewall, NULL,
+	XOCL_AF_PROP_LEVEL);
+static SENSOR_DEVICE_ATTR(detected_status, 0444, show_firewall, NULL,
+	XOCL_AF_PROP_DETECTED_STATUS);
+static SENSOR_DEVICE_ATTR(detected_level, 0444, show_firewall, NULL,
+	XOCL_AF_PROP_DETECTED_LEVEL);
+static SENSOR_DEVICE_ATTR(detected_time, 0444, show_firewall, NULL,
+	XOCL_AF_PROP_DETECTED_TIME);
+
+static ssize_t clear_store(struct device *dev, struct device_attribute *da,
+	const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	u32 val = 0;
+
+	if (kstrtou32(buf, 10, &val) == -EINVAL || val != 1)
+		return -EINVAL;
+
+	clear_firewall(pdev);
+
+	return count;
+}
+static DEVICE_ATTR_WO(clear);
+
+static ssize_t inject_store(struct device *dev, struct device_attribute *da,
+	const char *buf, size_t count)
+{
+	struct firewall *fw = platform_get_drvdata(to_platform_device(dev));
+
+	fw->inject_firewall = true;
+	return count;
+}
+static DEVICE_ATTR_WO(inject);
+
+static struct attribute *firewall_attributes[] = {
+	&sensor_dev_attr_status.dev_attr.attr,
+	&sensor_dev_attr_level.dev_attr.attr,
+	&sensor_dev_attr_detected_status.dev_attr.attr,
+	&sensor_dev_attr_detected_level.dev_attr.attr,
+	&sensor_dev_attr_detected_time.dev_attr.attr,
+	&dev_attr_clear.attr,
+	&dev_attr_inject.attr,
+	NULL
+};
+
+static const struct attribute_group firewall_attrgroup = {
+	.attrs = firewall_attributes,
+};
+
+static u32 check_firewall(struct platform_device *pdev, int *level)
+{
+	struct firewall	*fw;
+//	struct timeval	time;
+	struct timespec64 now;
+	int	i;
+	u32	val = 0;
+
+	fw = platform_get_drvdata(pdev);
+	BUG_ON(!fw);
+
+	for (i = 0; i < fw->max_level; i++) {
+		val = IS_FIRED(fw, i);
+		if (val) {
+			xocl_info(&pdev->dev, "AXI Firewall %d tripped, "
+				  "status: 0x%x", i, val);
+			if (!fw->curr_status) {
+				fw->err_detected_status = val;
+				fw->err_detected_level = i;
+				ktime_get_ts64(&now);
+				fw->err_detected_time = (u64)(now.tv_sec -
+					(sys_tz.tz_minuteswest * 60));
+			}
+			fw->curr_level = i;
+
+			if (level)
+				*level = i;
+			break;
+		}
+	}
+
+	fw->curr_status = val;
+	fw->curr_level = i >= fw->max_level ? -1 : i;
+
+	/* Inject firewall for testing. */
+	if (fw->curr_level == -1 && fw->inject_firewall) {
+		fw->inject_firewall = false;
+		fw->curr_level = 0;
+		fw->curr_status = 0x1;
+	}
+
+	return fw->curr_status;
+}
+
+static int clear_firewall(struct platform_device *pdev)
+{
+	struct firewall	*fw;
+	int	i, retry = 0, clear_retry = 0;
+	u32	val;
+	int	ret = 0;
+
+	fw = platform_get_drvdata(pdev);
+	BUG_ON(!fw);
+
+	if (!check_firewall(pdev, NULL)) {
+		/* firewall is not tripped */
+		return 0;
+	}
+
+retry_level1:
+	for (i = 0; i < fw->max_level; i++) {
+		for (val = READ_STATUS(fw, i);
+			(val & FIREWALL_STATUS_BUSY) &&
+			retry++ < BUSY_RETRY_COUNT;
+			val = READ_STATUS(fw, i)) {
+			msleep(BUSY_RETRY_INTERVAL);
+		}
+		if (val & FIREWALL_STATUS_BUSY) {
+			xocl_err(&pdev->dev, "firewall %d busy", i);
+			ret = -EBUSY;
+			goto failed;
+		}
+		WRITE_UNBLOCK_CTRL(fw, i, 1);
+	}
+
+	if (check_firewall(pdev, NULL) && clear_retry++ < CLEAR_RETRY_COUNT) {
+		msleep(CLEAR_RETRY_INTERVAL);
+		goto retry_level1;
+	}
+
+	if (!check_firewall(pdev, NULL)) {
+		xocl_info(&pdev->dev, "firewall cleared level 1");
+		return 0;
+	}
+
+	clear_retry = 0;
+
+retry_level2:
+	XOCL_WRITE_REG32(CLEAR_RESET_GPIO, fw->gpio_addr);
+
+	if (check_firewall(pdev, NULL) && clear_retry++ < CLEAR_RETRY_COUNT) {
+		msleep(CLEAR_RETRY_INTERVAL);
+		goto retry_level2;
+	}
+
+	if (!check_firewall(pdev, NULL)) {
+		xocl_info(&pdev->dev, "firewall cleared level 2");
+		return 0;
+	}
+
+	xocl_info(&pdev->dev, "failed clear firewall, level %d, status 0x%x",
+		fw->curr_level, fw->curr_status);
+
+	ret = -EIO;
+
+failed:
+	return ret;
+}
+
+static struct xocl_firewall_funcs fw_ops = {
+	.clear_firewall	= clear_firewall,
+	.check_firewall = check_firewall,
+	.get_prop = get_prop,
+};
+
+static int firewall_remove(struct platform_device *pdev)
+{
+	struct firewall *fw;
+	int     i;
+
+	fw = platform_get_drvdata(pdev);
+	if (!fw) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	sysfs_remove_group(&pdev->dev.kobj, &firewall_attrgroup);
+
+	for (i = 0; i <= fw->max_level; i++) {
+		if (fw->base_addrs[i])
+			iounmap(fw->base_addrs[i]);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, fw);
+
+	return 0;
+}
+
+static int firewall_probe(struct platform_device *pdev)
+{
+	struct firewall	*fw;
+	struct resource	*res;
+	int	i, ret = 0;
+
+	xocl_info(&pdev->dev, "probe");
+
+	fw = devm_kzalloc(&pdev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, fw);
+
+	fw->curr_level = -1;
+
+	for (i = 0; i < MAX_LEVEL; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res) {
+			fw->max_level = i - 1;
+			fw->gpio_addr = fw->base_addrs[i - 1];
+			break;
+		}
+		fw->base_addrs[i] =
+			ioremap_nocache(res->start, res->end - res->start + 1);
+		if (!fw->base_addrs[i]) {
+			ret = -EIO;
+			xocl_err(&pdev->dev, "Map iomem failed");
+			goto failed;
+		}
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &firewall_attrgroup);
+	if (ret) {
+		xocl_err(&pdev->dev, "create attr group failed: %d", ret);
+		goto failed;
+	}
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_AF, &fw_ops);
+
+	return 0;
+
+failed:
+	firewall_remove(pdev);
+	return ret;
+}
+
+struct platform_device_id firewall_id_table[] = {
+	{ XOCL_FIREWALL, 0 },
+	{ },
+};
+
+static struct platform_driver	firewall_driver = {
+	.probe		= firewall_probe,
+	.remove		= firewall_remove,
+	.driver		= {
+		.name = "xocl_firewall",
+	},
+	.id_table = firewall_id_table,
+};
+
+int __init xocl_init_firewall(void)
+{
+	return platform_driver_register(&firewall_driver);
+}
+
+void xocl_fini_firewall(void)
+{
+	return platform_driver_unregister(&firewall_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/fmgr.c b/drivers/gpu/drm/xocl/subdev/fmgr.c
new file mode 100644
index 000000000000..99efd86ccd1b
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/fmgr.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * FPGA Manager bindings for XRT driver
+ *
+ * Copyright (C) 2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Sonal Santan
+ *
+ */
+
+#include <linux/fpga/fpga-mgr.h>
+
+#include "../xocl_drv.h"
+#include "../xclbin.h"
+
+/*
+ * Container to capture and cache full xclbin as it is passed in blocks by FPGA
+ * Manager. xocl needs access to full xclbin to walk through xclbin sections. FPGA
+ * Manager's .write() backend sends incremental blocks without any knowledge of
+ * xclbin format forcing us to collect the blocks and stitch them together here.
+ * TODO:
+ * 1. Add a variant of API, icap_download_bitstream_axlf() which works off kernel buffer
+ * 2. Call this new API from FPGA Manager's write complete hook, xocl_pr_write_complete()
+ */
+
+struct xfpga_klass {
+	struct xocl_dev *xdev;
+	struct axlf *blob;
+	char name[64];
+	size_t count;
+	enum fpga_mgr_states state;
+};
+
+static int xocl_pr_write_init(struct fpga_manager *mgr,
+			      struct fpga_image_info *info, const char *buf, size_t count)
+{
+	struct xfpga_klass *obj = mgr->priv;
+	const struct axlf *bin = (const struct axlf *)buf;
+
+	if (count < sizeof(struct axlf)) {
+		obj->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -EINVAL;
+	}
+
+	if (count > bin->m_header.m_length) {
+		obj->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -EINVAL;
+	}
+
+	/* Free up the previous blob */
+	vfree(obj->blob);
+	obj->blob = vmalloc(bin->m_header.m_length);
+	if (!obj->blob) {
+		obj->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -ENOMEM;
+	}
+
+	memcpy(obj->blob, buf, count);
+	xocl_info(&mgr->dev, "Begin download of xclbin %pUb of length %lld B", &obj->blob->m_header.uuid,
+		  obj->blob->m_header.m_length);
+	obj->count = count;
+	obj->state = FPGA_MGR_STATE_WRITE_INIT;
+	return 0;
+}
+
+static int xocl_pr_write(struct fpga_manager *mgr,
+			 const char *buf, size_t count)
+{
+	struct xfpga_klass *obj = mgr->priv;
+	char *curr = (char *)obj->blob;
+
+	if ((obj->state != FPGA_MGR_STATE_WRITE_INIT) && (obj->state != FPGA_MGR_STATE_WRITE)) {
+		obj->state = FPGA_MGR_STATE_WRITE_ERR;
+		return -EINVAL;
+	}
+
+	curr += obj->count;
+	obj->count += count;
+	/* Check if the xclbin buffer is not longer than advertised in the header */
+	if (obj->blob->m_header.m_length < obj->count) {
+		obj->state = FPGA_MGR_STATE_WRITE_ERR;
+		return -EINVAL;
+	}
+	memcpy(curr, buf, count);
+	xocl_info(&mgr->dev, "Next block of %zu B of xclbin %pUb", count, &obj->blob->m_header.uuid);
+	obj->state = FPGA_MGR_STATE_WRITE;
+	return 0;
+}
+
+
+static int xocl_pr_write_complete(struct fpga_manager *mgr,
+				  struct fpga_image_info *info)
+{
+	int result;
+	struct xfpga_klass *obj = mgr->priv;
+
+	if (obj->state != FPGA_MGR_STATE_WRITE) {
+		obj->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return -EINVAL;
+	}
+
+	/* Check if we got the complete xclbin */
+	if (obj->blob->m_header.m_length != obj->count) {
+		obj->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return -EINVAL;
+	}
+	/* Send the xclbin blob to actual download framework in icap */
+	result = xocl_icap_download_axlf(obj->xdev, obj->blob);
+	obj->state = result ? FPGA_MGR_STATE_WRITE_COMPLETE_ERR : FPGA_MGR_STATE_WRITE_COMPLETE;
+	xocl_info(&mgr->dev, "Finish download of xclbin %pUb of size %zu B", &obj->blob->m_header.uuid, obj->count);
+	vfree(obj->blob);
+	obj->blob = NULL;
+	obj->count = 0;
+	return result;
+}
+
+static enum fpga_mgr_states xocl_pr_state(struct fpga_manager *mgr)
+{
+	struct xfpga_klass *obj = mgr->priv;
+
+	return obj->state;
+}
+
+static const struct fpga_manager_ops xocl_pr_ops = {
+	.initial_header_size = sizeof(struct axlf),
+	.write_init = xocl_pr_write_init,
+	.write = xocl_pr_write,
+	.write_complete = xocl_pr_write_complete,
+	.state = xocl_pr_state,
+};
+
+
+struct platform_device_id fmgr_id_table[] = {
+	{ XOCL_FMGR, 0 },
+	{ },
+};
+
+static int fmgr_probe(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr;
+	int ret = 0;
+	struct xfpga_klass *obj = kzalloc(sizeof(struct xfpga_klass), GFP_KERNEL);
+
+	if (!obj)
+		return -ENOMEM;
+
+	obj->xdev = xocl_get_xdev(pdev);
+	snprintf(obj->name, sizeof(obj->name), "Xilinx PCIe FPGA Manager");
+
+	obj->state = FPGA_MGR_STATE_UNKNOWN;
+	mgr = fpga_mgr_create(&pdev->dev, obj->name, &xocl_pr_ops, obj);
+	if (!mgr) {
+		ret = -ENODEV;
+		goto out;
+	}
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		goto out;
+
+	return ret;
+out:
+	kfree(obj);
+	return ret;
+}
+
+static int fmgr_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+	struct xfpga_klass *obj = mgr->priv;
+
+	obj->state = FPGA_MGR_STATE_UNKNOWN;
+	fpga_mgr_unregister(mgr);
+
+	platform_set_drvdata(pdev, NULL);
+	vfree(obj->blob);
+	kfree(obj);
+	return 0;
+}
+
+static struct platform_driver	fmgr_driver = {
+	.probe		= fmgr_probe,
+	.remove		= fmgr_remove,
+	.driver		= {
+		.name = "xocl_fmgr",
+	},
+	.id_table = fmgr_id_table,
+};
+
+int __init xocl_init_fmgr(void)
+{
+	return platform_driver_register(&fmgr_driver);
+}
+
+void xocl_fini_fmgr(void)
+{
+	platform_driver_unregister(&fmgr_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/icap.c b/drivers/gpu/drm/xocl/subdev/icap.c
new file mode 100644
index 000000000000..93eb6265a9c4
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/icap.c
@@ -0,0 +1,2859 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  Copyright (C) 2017 Xilinx, Inc. All rights reserved.
+ *  Author: Sonal Santan
+ *  Code copied verbatim from SDAccel xcldma kernel mode driver
+ *
+ */
+
+/*
+ * TODO: Currently, locking / unlocking bitstream is implemented w/ pid as
+ * identification of bitstream users. We assume that, on bare metal, an app
+ * has only one process and will open both user and mgmt pfs. In this model,
+ * xclmgmt has enough information to handle locking/unlocking alone, but we
+ * still involve user pf and mailbox here so that it'll be easier to support
+ * cloud env later. We'll replace pid with a token that is more appropriate
+ * to identify a user later as well.
+ */
+
+#include <linux/firmware.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/version.h>
+#include <linux/uuid.h>
+#include <linux/pid.h>
+#include "../xclbin.h"
+#include "../xocl_drv.h"
+#include <drm/xmgmt_drm.h>
+
+#if defined(XOCL_UUID)
+static uuid_t uuid_null = NULL_UUID_LE;
+#endif
+
+#define	ICAP_ERR(icap, fmt, arg...)	\
+	xocl_err(&(icap)->icap_pdev->dev, fmt "\n", ##arg)
+#define	ICAP_INFO(icap, fmt, arg...)	\
+	xocl_info(&(icap)->icap_pdev->dev, fmt "\n", ##arg)
+#define	ICAP_DBG(icap, fmt, arg...)	\
+	xocl_dbg(&(icap)->icap_pdev->dev, fmt "\n", ##arg)
+
+#define	ICAP_PRIVILEGED(icap)	((icap)->icap_regs != NULL)
+#define DMA_HWICAP_BITFILE_BUFFER_SIZE 1024
+#define	ICAP_MAX_REG_GROUPS		ARRAY_SIZE(XOCL_RES_ICAP_MGMT)
+
+#define	ICAP_MAX_NUM_CLOCKS		2
+#define OCL_CLKWIZ_STATUS_OFFSET	0x4
+#define OCL_CLKWIZ_CONFIG_OFFSET(n)	(0x200 + 4 * (n))
+#define OCL_CLK_FREQ_COUNTER_OFFSET	0x8
+
+/*
+ * Bitstream header information.
+ */
+struct XHwIcap_Bit_Header {
+	unsigned int HeaderLength;     /* Length of header in 32 bit words */
+	unsigned int BitstreamLength;  /* Length of bitstream to read in bytes*/
+	unsigned char *DesignName;     /* Design name read from bitstream header */
+	unsigned char *PartName;       /* Part name read from bitstream header */
+	unsigned char *Date;           /* Date read from bitstream header */
+	unsigned char *Time;           /* Bitstream creation time read from header */
+	unsigned int MagicLength;      /* Length of the magic numbers in header */
+};
+
+#define XHI_BIT_HEADER_FAILURE	-1
+/* Used for parsing bitstream header */
+#define XHI_EVEN_MAGIC_BYTE	0x0f
+#define XHI_ODD_MAGIC_BYTE	0xf0
+/* Extra mode for IDLE */
+#define XHI_OP_IDLE		-1
+/* The imaginary module length register */
+#define XHI_MLR			15
+
+#define	GATE_FREEZE_USER	0x0c
+#define GATE_FREEZE_SHELL	0x00
+
+static u32 gate_free_user[] = {0xe, 0xc, 0xe, 0xf};
+static u32 gate_free_shell[] = {0x8, 0xc, 0xe, 0xf};
+
+/*
+ * AXI-HWICAP IP register layout
+ */
+struct icap_reg {
+	u32			ir_rsvd1[7];
+	u32			ir_gier;
+	u32			ir_isr;
+	u32			ir_rsvd2;
+	u32			ir_ier;
+	u32			ir_rsvd3[53];
+	u32			ir_wf;
+	u32			ir_rf;
+	u32			ir_sz;
+	u32			ir_cr;
+	u32			ir_sr;
+	u32			ir_wfv;
+	u32			ir_rfo;
+	u32			ir_asr;
+} __attribute__((packed));
+
+struct icap_generic_state {
+	u32			igs_state;
+} __attribute__((packed));
+
+struct icap_axi_gate {
+	u32			iag_wr;
+	u32			iag_rvsd;
+	u32			iag_rd;
+} __attribute__((packed));
+
+struct icap_bitstream_user {
+	struct list_head	ibu_list;
+	pid_t			ibu_pid;
+};
+
+struct icap {
+	struct platform_device	*icap_pdev;
+	struct mutex		icap_lock;
+	struct icap_reg		*icap_regs;
+	struct icap_generic_state *icap_state;
+	unsigned int            idcode;
+	bool			icap_axi_gate_frozen;
+	bool			icap_axi_gate_shell_frozen;
+	struct icap_axi_gate	*icap_axi_gate;
+
+	u64			icap_bitstream_id;
+	uuid_t			icap_bitstream_uuid;
+	int			icap_bitstream_ref;
+	struct list_head	icap_bitstream_users;
+
+	char			*icap_clear_bitstream;
+	unsigned long		icap_clear_bitstream_length;
+
+	char			*icap_clock_bases[ICAP_MAX_NUM_CLOCKS];
+	unsigned short		icap_ocl_frequency[ICAP_MAX_NUM_CLOCKS];
+
+	char                    *icap_clock_freq_topology;
+	unsigned long		icap_clock_freq_topology_length;
+	char                    *icap_clock_freq_counter;
+	struct mem_topology      *mem_topo;
+	struct ip_layout         *ip_layout;
+	struct debug_ip_layout   *debug_layout;
+	struct connectivity      *connectivity;
+
+	char			*bit_buffer;
+	unsigned long		bit_length;
+};
+
+static inline u32 reg_rd(void __iomem *reg)
+{
+	return XOCL_READ_REG32(reg);
+}
+
+static inline void reg_wr(void __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+
+/*
+ * Precomputed table with config0 and config2 register values together with
+ * target frequency. The steps are approximately 5 MHz apart. Table is
+ * generated by wiz.pl.
+ */
+const static struct xclmgmt_ocl_clockwiz {
+	/* target frequency */
+	unsigned short ocl;
+	/* config0 register */
+	unsigned long config0;
+	/* config2 register */
+	unsigned short config2;
+} frequency_table[] = {
+	{/* 600*/   60, 0x0601, 0x000a},
+	{/* 600*/   66, 0x0601, 0x0009},
+	{/* 600*/   75, 0x0601, 0x0008},
+	{/* 800*/   80, 0x0801, 0x000a},
+	{/* 600*/   85, 0x0601, 0x0007},
+	{/* 900*/   90, 0x0901, 0x000a},
+	{/*1000*/  100, 0x0a01, 0x000a},
+	{/*1100*/  110, 0x0b01, 0x000a},
+	{/* 700*/  116, 0x0701, 0x0006},
+	{/*1100*/  122, 0x0b01, 0x0009},
+	{/* 900*/  128, 0x0901, 0x0007},
+	{/*1200*/  133, 0x0c01, 0x0009},
+	{/*1400*/  140, 0x0e01, 0x000a},
+	{/*1200*/  150, 0x0c01, 0x0008},
+	{/*1400*/  155, 0x0e01, 0x0009},
+	{/* 800*/  160, 0x0801, 0x0005},
+	{/*1000*/  166, 0x0a01, 0x0006},
+	{/*1200*/  171, 0x0c01, 0x0007},
+	{/* 900*/  180, 0x0901, 0x0005},
+	{/*1300*/  185, 0x0d01, 0x0007},
+	{/*1400*/  200, 0x0e01, 0x0007},
+	{/*1300*/  216, 0x0d01, 0x0006},
+	{/* 900*/  225, 0x0901, 0x0004},
+	{/*1400*/  233, 0x0e01, 0x0006},
+	{/*1200*/  240, 0x0c01, 0x0005},
+	{/*1000*/  250, 0x0a01, 0x0004},
+	{/*1300*/  260, 0x0d01, 0x0005},
+	{/* 800*/  266, 0x0801, 0x0003},
+	{/*1100*/  275, 0x0b01, 0x0004},
+	{/*1400*/  280, 0x0e01, 0x0005},
+	{/*1200*/  300, 0x0c01, 0x0004},
+	{/*1300*/  325, 0x0d01, 0x0004},
+	{/*1000*/  333, 0x0a01, 0x0003},
+	{/*1400*/  350, 0x0e01, 0x0004},
+	{/*1100*/  366, 0x0b01, 0x0003},
+	{/*1200*/  400, 0x0c01, 0x0003},
+	{/*1300*/  433, 0x0d01, 0x0003},
+	{/* 900*/  450, 0x0901, 0x0002},
+	{/*1400*/  466, 0x0e01, 0x0003},
+	{/*1000*/  500, 0x0a01, 0x0002}
+};
+
+static int icap_verify_bitstream_axlf(struct platform_device *pdev,
+	struct axlf *xclbin);
+static int icap_parse_bitstream_axlf_section(struct platform_device *pdev,
+	const struct axlf *xclbin, enum axlf_section_kind kind);
+
+static struct icap_bitstream_user *alloc_user(pid_t pid)
+{
+	struct icap_bitstream_user *u =
+		kzalloc(sizeof(struct icap_bitstream_user), GFP_KERNEL);
+
+	if (u) {
+		INIT_LIST_HEAD(&u->ibu_list);
+		u->ibu_pid = pid;
+	}
+	return u;
+}
+
+static void free_user(struct icap_bitstream_user *u)
+{
+	kfree(u);
+}
+
+static struct icap_bitstream_user *obtain_user(struct icap *icap, pid_t pid)
+{
+	struct list_head *pos, *n;
+
+	list_for_each_safe(pos, n, &icap->icap_bitstream_users) {
+		struct icap_bitstream_user *u = list_entry(pos, struct icap_bitstream_user, ibu_list);
+
+		if (u->ibu_pid == pid)
+			return u;
+	}
+
+	return NULL;
+}
+
+static void icap_read_from_peer(struct platform_device *pdev, enum data_kind kind, void *resp, size_t resplen)
+{
+	struct mailbox_subdev_peer subdev_peer = {0};
+	size_t data_len = sizeof(struct mailbox_subdev_peer);
+	struct mailbox_req *mb_req = NULL;
+	size_t reqlen = sizeof(struct mailbox_req) + data_len;
+
+	mb_req = vmalloc(reqlen);
+	if (!mb_req)
+		return;
+
+	mb_req->req = MAILBOX_REQ_PEER_DATA;
+
+	subdev_peer.kind = kind;
+	memcpy(mb_req->data, &subdev_peer, data_len);
+
+	(void) xocl_peer_request(XOCL_PL_DEV_TO_XDEV(pdev),
+		mb_req, reqlen, resp, &resplen, NULL, NULL);
+
+	vfree(mb_req);
+}
+
+
+static int add_user(struct icap *icap, pid_t pid)
+{
+	struct icap_bitstream_user *u;
+
+	u = obtain_user(icap, pid);
+	if (u)
+		return 0;
+
+	u = alloc_user(pid);
+	if (!u)
+		return -ENOMEM;
+
+	list_add_tail(&u->ibu_list, &icap->icap_bitstream_users);
+	icap->icap_bitstream_ref++;
+	return 0;
+}
+
+static int del_user(struct icap *icap, pid_t pid)
+{
+	struct icap_bitstream_user *u = NULL;
+
+	u = obtain_user(icap, pid);
+	if (!u)
+		return -EINVAL;
+
+	list_del(&u->ibu_list);
+	free_user(u);
+	icap->icap_bitstream_ref--;
+	return 0;
+}
+
+static void del_all_users(struct icap *icap)
+{
+	struct icap_bitstream_user *u = NULL;
+	struct list_head *pos, *n;
+
+	if (icap->icap_bitstream_ref == 0)
+		return;
+
+	list_for_each_safe(pos, n, &icap->icap_bitstream_users) {
+		u = list_entry(pos, struct icap_bitstream_user, ibu_list);
+		list_del(&u->ibu_list);
+		free_user(u);
+	}
+
+	ICAP_INFO(icap, "removed %d users", icap->icap_bitstream_ref);
+	icap->icap_bitstream_ref = 0;
+}
+
+static unsigned int find_matching_freq_config(unsigned int freq)
+{
+	unsigned int start = 0;
+	unsigned int end = ARRAY_SIZE(frequency_table) - 1;
+	unsigned int idx = ARRAY_SIZE(frequency_table) - 1;
+
+	if (freq < frequency_table[0].ocl)
+		return 0;
+
+	if (freq > frequency_table[ARRAY_SIZE(frequency_table) - 1].ocl)
+		return ARRAY_SIZE(frequency_table) - 1;
+
+	while (start < end) {
+		if (freq == frequency_table[idx].ocl)
+			break;
+		if (freq < frequency_table[idx].ocl)
+			end = idx;
+		else
+			start = idx + 1;
+		idx = start + (end - start) / 2;
+	}
+	if (freq < frequency_table[idx].ocl)
+		idx--;
+
+	return idx;
+}
+
+static unsigned short icap_get_ocl_frequency(const struct icap *icap, int idx)
+{
+#define XCL_INPUT_FREQ 100
+	const u64 input = XCL_INPUT_FREQ;
+	u32 val;
+	u32 mul0, div0;
+	u32 mul_frac0 = 0;
+	u32 div1;
+	u32 div_frac1 = 0;
+	u64 freq;
+	char *base = NULL;
+
+	if (ICAP_PRIVILEGED(icap)) {
+		base = icap->icap_clock_bases[idx];
+	  val = reg_rd(base + OCL_CLKWIZ_STATUS_OFFSET);
+		if ((val & 1) == 0)
+			return 0;
+
+		val = reg_rd(base + OCL_CLKWIZ_CONFIG_OFFSET(0));
+
+		div0 = val & 0xff;
+		mul0 = (val & 0xff00) >> 8;
+		if (val & BIT(26)) {
+			mul_frac0 = val >> 16;
+			mul_frac0 &= 0x3ff;
+		}
+
+		/*
+		 * Multiply both numerator (mul0) and the denominator (div0) with 1000
+		 * to account for fractional portion of multiplier
+		 */
+		mul0 *= 1000;
+		mul0 += mul_frac0;
+		div0 *= 1000;
+
+		val = reg_rd(base + OCL_CLKWIZ_CONFIG_OFFSET(2));
+
+		div1 = val & 0xff;
+		if (val & BIT(18)) {
+			div_frac1 = val >> 8;
+			div_frac1 &= 0x3ff;
+		}
+
+		/*
+		 * Multiply both numerator (mul0) and the denominator (div1) with 1000 to
+		 * account for fractional portion of divider
+		 */
+
+		div1 *= 1000;
+		div1 += div_frac1;
+		div0 *= div1;
+		mul0 *= 1000;
+		if (div0 == 0) {
+			ICAP_ERR(icap, "clockwiz 0 divider");
+			return 0;
+		}
+		freq = (input * mul0) / div0;
+	} else {
+		icap_read_from_peer(icap->icap_pdev, CLOCK_FREQ_0, (u32 *)&freq, sizeof(u32));
+	}
+	return freq;
+}
+
+static unsigned int icap_get_clock_frequency_counter_khz(const struct icap *icap, int idx)
+{
+	u32 freq, status;
+	char *base = icap->icap_clock_freq_counter;
+	int times;
+
+	times = 10;
+	freq = 0;
+	/*
+	 * reset and wait until done
+	 */
+	if (ICAP_PRIVILEGED(icap)) {
+		if (uuid_is_null(&icap->icap_bitstream_uuid)) {
+			ICAP_ERR(icap, "ERROR: There isn't a xclbin loaded in the dynamic "
+				 "region, frequencies counter cannot be determined");
+			return freq;
+		}
+		reg_wr(base, 0x1);
+
+		while (times != 0) {
+			status = reg_rd(base);
+			if (status == 0x2)
+				break;
+			mdelay(1);
+			times--;
+		};
+
+	  freq = reg_rd(base + OCL_CLK_FREQ_COUNTER_OFFSET + idx * sizeof(u32));
+	} else {
+		icap_read_from_peer(icap->icap_pdev, FREQ_COUNTER_0, (u32 *)&freq, sizeof(u32));
+	}
+	return freq;
+}
+/*
+ * Based on Clocking Wizard v5.1, section Dynamic Reconfiguration
+ * through AXI4-Lite
+ */
+static int icap_ocl_freqscaling(struct icap *icap, bool force)
+{
+	unsigned int curr_freq;
+	u32 config;
+	int i;
+	int j = 0;
+	u32 val = 0;
+	unsigned int idx = 0;
+	long err = 0;
+
+	for (i = 0; i < ICAP_MAX_NUM_CLOCKS; ++i) {
+		// A value of zero means skip scaling for this clock index
+		if (!icap->icap_ocl_frequency[i])
+			continue;
+
+		idx = find_matching_freq_config(icap->icap_ocl_frequency[i]);
+		curr_freq = icap_get_ocl_frequency(icap, i);
+		ICAP_INFO(icap, "Clock %d, Current %d Mhz, New %d Mhz ",
+				i, curr_freq, icap->icap_ocl_frequency[i]);
+
+		/*
+		 * If current frequency is in the same step as the
+		 * requested frequency then nothing to do.
+		 */
+		if (!force && (find_matching_freq_config(curr_freq) == idx))
+			continue;
+
+		val = reg_rd(icap->icap_clock_bases[i] +
+			OCL_CLKWIZ_STATUS_OFFSET);
+		if (val != 1) {
+			ICAP_ERR(icap, "clockwiz %d is busy", i);
+			err = -EBUSY;
+			break;
+		}
+
+		config = frequency_table[idx].config0;
+		reg_wr(icap->icap_clock_bases[i] + OCL_CLKWIZ_CONFIG_OFFSET(0),
+			config);
+		config = frequency_table[idx].config2;
+		reg_wr(icap->icap_clock_bases[i] + OCL_CLKWIZ_CONFIG_OFFSET(2),
+			config);
+		msleep(10);
+		reg_wr(icap->icap_clock_bases[i] + OCL_CLKWIZ_CONFIG_OFFSET(23),
+			0x00000007);
+		msleep(1);
+		reg_wr(icap->icap_clock_bases[i] + OCL_CLKWIZ_CONFIG_OFFSET(23),
+			0x00000002);
+
+		ICAP_INFO(icap, "clockwiz waiting for locked signal");
+		msleep(100);
+		for (j = 0; j < 100; j++) {
+			val = reg_rd(icap->icap_clock_bases[i] +
+				OCL_CLKWIZ_STATUS_OFFSET);
+			if (val != 1) {
+				msleep(100);
+				continue;
+			}
+		}
+		if (val != 1) {
+			ICAP_ERR(icap, "clockwiz MMCM/PLL did not lock after %d ms, "
+				"restoring the original configuration", 100 * 100);
+			/* restore the original clock configuration */
+			reg_wr(icap->icap_clock_bases[i] +
+				OCL_CLKWIZ_CONFIG_OFFSET(23), 0x00000004);
+			msleep(10);
+			reg_wr(icap->icap_clock_bases[i] +
+				OCL_CLKWIZ_CONFIG_OFFSET(23), 0x00000000);
+			err = -ETIMEDOUT;
+			break;
+		}
+		val = reg_rd(icap->icap_clock_bases[i] +
+			OCL_CLKWIZ_CONFIG_OFFSET(0));
+		ICAP_INFO(icap, "clockwiz CONFIG(0) 0x%x", val);
+		val = reg_rd(icap->icap_clock_bases[i] +
+			OCL_CLKWIZ_CONFIG_OFFSET(2));
+		ICAP_INFO(icap, "clockwiz CONFIG(2) 0x%x", val);
+	}
+
+	return err;
+}
+
+static bool icap_bitstream_in_use(struct icap *icap, pid_t pid)
+{
+	BUG_ON(icap->icap_bitstream_ref < 0);
+
+	/* Any user counts if pid isn't specified. */
+	if (pid == 0)
+		return icap->icap_bitstream_ref != 0;
+
+	if (icap->icap_bitstream_ref == 0)
+		return false;
+	if ((icap->icap_bitstream_ref == 1) && obtain_user(icap, pid))
+		return false;
+	return true;
+}
+
+static int icap_freeze_axi_gate_shell(struct icap *icap)
+{
+	xdev_handle_t xdev = xocl_get_xdev(icap->icap_pdev);
+
+	ICAP_INFO(icap, "freezing Shell AXI gate");
+	BUG_ON(icap->icap_axi_gate_shell_frozen);
+
+	(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+	reg_wr(&icap->icap_axi_gate->iag_wr, GATE_FREEZE_SHELL);
+	(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+
+	if (!xocl_is_unified(xdev)) {
+		reg_wr(&icap->icap_regs->ir_cr, 0xc);
+		ndelay(20);
+	} else {
+		/* New ICAP reset sequence applicable only to unified dsa. */
+		reg_wr(&icap->icap_regs->ir_cr, 0x8);
+		ndelay(2000);
+		reg_wr(&icap->icap_regs->ir_cr, 0x0);
+		ndelay(2000);
+		reg_wr(&icap->icap_regs->ir_cr, 0x4);
+		ndelay(2000);
+		reg_wr(&icap->icap_regs->ir_cr, 0x0);
+		ndelay(2000);
+	}
+
+	icap->icap_axi_gate_shell_frozen = true;
+
+	return 0;
+}
+
+static int icap_free_axi_gate_shell(struct icap *icap)
+{
+	int i;
+
+	ICAP_INFO(icap, "freeing Shell AXI gate");
+	/*
+	 * First pulse the OCL RESET. This is important for PR with multiple
+	 * clocks as it resets the edge triggered clock converter FIFO
+	 */
+
+	if (!icap->icap_axi_gate_shell_frozen)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(gate_free_shell); i++) {
+		(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+		reg_wr(&icap->icap_axi_gate->iag_wr, gate_free_shell[i]);
+		mdelay(50);
+	}
+
+	(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+
+	icap->icap_axi_gate_shell_frozen = false;
+
+	return 0;
+}
+
+static int icap_freeze_axi_gate(struct icap *icap)
+{
+	xdev_handle_t xdev = xocl_get_xdev(icap->icap_pdev);
+
+	ICAP_INFO(icap, "freezing CL AXI gate");
+	BUG_ON(icap->icap_axi_gate_frozen);
+
+	(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+	reg_wr(&icap->icap_axi_gate->iag_wr, GATE_FREEZE_USER);
+	(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+
+	if (!xocl_is_unified(xdev)) {
+		reg_wr(&icap->icap_regs->ir_cr, 0xc);
+		ndelay(20);
+	} else {
+		/* New ICAP reset sequence applicable only to unified dsa. */
+		reg_wr(&icap->icap_regs->ir_cr, 0x8);
+		ndelay(2000);
+		reg_wr(&icap->icap_regs->ir_cr, 0x0);
+		ndelay(2000);
+		reg_wr(&icap->icap_regs->ir_cr, 0x4);
+		ndelay(2000);
+		reg_wr(&icap->icap_regs->ir_cr, 0x0);
+		ndelay(2000);
+	}
+
+	icap->icap_axi_gate_frozen = true;
+
+	return 0;
+}
+
+static int icap_free_axi_gate(struct icap *icap)
+{
+	int i;
+
+	ICAP_INFO(icap, "freeing CL AXI gate");
+	/*
+	 * First pulse the OCL RESET. This is important for PR with multiple
+	 * clocks as it resets the edge triggered clock converter FIFO
+	 */
+
+	if (!icap->icap_axi_gate_frozen)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(gate_free_user); i++) {
+		(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+		reg_wr(&icap->icap_axi_gate->iag_wr, gate_free_user[i]);
+		ndelay(500);
+	}
+
+	(void) reg_rd(&icap->icap_axi_gate->iag_rd);
+
+	icap->icap_axi_gate_frozen = false;
+
+	return 0;
+}
+
+static void platform_reset_axi_gate(struct platform_device *pdev)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+
+	/* Can only be done from mgmt pf. */
+	if (!ICAP_PRIVILEGED(icap))
+		return;
+
+	mutex_lock(&icap->icap_lock);
+	if (!icap_bitstream_in_use(icap, 0)) {
+		(void) icap_freeze_axi_gate(platform_get_drvdata(pdev));
+		msleep(500);
+		(void) icap_free_axi_gate(platform_get_drvdata(pdev));
+		msleep(500);
+	}
+	mutex_unlock(&icap->icap_lock);
+}
+
+static int set_freqs(struct icap *icap, unsigned short *freqs, int num_freqs)
+{
+	int i;
+	int err;
+	u32 val;
+
+	for (i = 0; i < min(ICAP_MAX_NUM_CLOCKS, num_freqs); ++i) {
+		if (freqs[i] == 0)
+			continue;
+
+		val = reg_rd(icap->icap_clock_bases[i] +
+			OCL_CLKWIZ_STATUS_OFFSET);
+		if ((val & 0x1) == 0) {
+			ICAP_ERR(icap, "clockwiz %d is busy", i);
+			err = -EBUSY;
+			goto done;
+		}
+	}
+
+	memcpy(icap->icap_ocl_frequency, freqs,
+		sizeof(*freqs) * min(ICAP_MAX_NUM_CLOCKS, num_freqs));
+
+	icap_freeze_axi_gate(icap);
+	err = icap_ocl_freqscaling(icap, false);
+	icap_free_axi_gate(icap);
+
+done:
+	return err;
+
+}
+
+static int set_and_verify_freqs(struct icap *icap, unsigned short *freqs, int num_freqs)
+{
+	int i;
+	int err;
+	u32 clock_freq_counter, request_in_khz, tolerance;
+
+	err = set_freqs(icap, freqs, num_freqs);
+	if (err)
+		return err;
+
+	for (i = 0; i < min(ICAP_MAX_NUM_CLOCKS, num_freqs); ++i) {
+		if (!freqs[i])
+			continue;
+		clock_freq_counter = icap_get_clock_frequency_counter_khz(icap, i);
+		if (clock_freq_counter == 0) {
+			err = -EDOM;
+			break;
+		}
+		request_in_khz = freqs[i]*1000;
+		tolerance = freqs[i]*50;
+		if (tolerance < abs(clock_freq_counter-request_in_khz)) {
+			ICAP_ERR(icap, "Frequency is higher than tolerance value, request %u khz, "
+				 "actual %u khz", request_in_khz, clock_freq_counter);
+			err = -EDOM;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int icap_ocl_set_freqscaling(struct platform_device *pdev,
+	unsigned int region, unsigned short *freqs, int num_freqs)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	int err = 0;
+
+	/* Can only be done from mgmt pf. */
+	if (!ICAP_PRIVILEGED(icap))
+		return -EPERM;
+
+	/* For now, only PR region 0 is supported. */
+	if (region != 0)
+		return -EINVAL;
+
+	mutex_lock(&icap->icap_lock);
+
+	err = set_freqs(icap, freqs, num_freqs);
+
+	mutex_unlock(&icap->icap_lock);
+
+	return err;
+}
+
+static int icap_ocl_update_clock_freq_topology(struct platform_device *pdev, struct xclmgmt_ioc_freqscaling *freq_obj)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	struct clock_freq_topology *topology = 0;
+	int num_clocks = 0;
+	int i = 0;
+	int err = 0;
+
+	mutex_lock(&icap->icap_lock);
+	if (icap->icap_clock_freq_topology) {
+		topology = (struct clock_freq_topology *)icap->icap_clock_freq_topology;
+		num_clocks = topology->m_count;
+		ICAP_INFO(icap, "Num clocks is %d", num_clocks);
+		for (i = 0; i < ARRAY_SIZE(freq_obj->ocl_target_freq); i++) {
+			ICAP_INFO(icap, "requested frequency is : "
+				"%d xclbin freq is: %d",
+				freq_obj->ocl_target_freq[i],
+				topology->m_clock_freq[i].m_freq_Mhz);
+			if (freq_obj->ocl_target_freq[i] >
+				topology->m_clock_freq[i].m_freq_Mhz) {
+				ICAP_ERR(icap, "Unable to set frequency as "
+					"requested frequency %d is greater "
+					"than set by xclbin %d",
+					freq_obj->ocl_target_freq[i],
+					topology->m_clock_freq[i].m_freq_Mhz);
+				err = -EDOM;
+				goto done;
+			}
+		}
+	} else {
+		ICAP_ERR(icap, "ERROR: There isn't a hardware accelerator loaded in the dynamic region."
+			" Validation of accelerator frequencies cannot be determine");
+		err = -EDOM;
+		goto done;
+	}
+
+	err = set_and_verify_freqs(icap, freq_obj->ocl_target_freq, ARRAY_SIZE(freq_obj->ocl_target_freq));
+
+done:
+	mutex_unlock(&icap->icap_lock);
+	return err;
+}
+
+static int icap_ocl_get_freqscaling(struct platform_device *pdev,
+	unsigned int region, unsigned short *freqs, int num_freqs)
+{
+	int i;
+	struct icap *icap = platform_get_drvdata(pdev);
+
+	/* For now, only PR region 0 is supported. */
+	if (region != 0)
+		return -EINVAL;
+
+	mutex_lock(&icap->icap_lock);
+	for (i = 0; i < min(ICAP_MAX_NUM_CLOCKS, num_freqs); i++)
+		freqs[i] = icap_get_ocl_frequency(icap, i);
+	mutex_unlock(&icap->icap_lock);
+
+	return 0;
+}
+
+static inline bool mig_calibration_done(struct icap *icap)
+{
+	return (reg_rd(&icap->icap_state->igs_state) & BIT(0)) != 0;
+}
+
+/* Check for MIG calibration. */
+static int calibrate_mig(struct icap *icap)
+{
+	int i;
+
+	for (i = 0; i < 10 && !mig_calibration_done(icap); ++i)
+		msleep(500);
+
+	if (!mig_calibration_done(icap)) {
+		ICAP_ERR(icap,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static inline void free_clock_freq_topology(struct icap *icap)
+{
+	vfree(icap->icap_clock_freq_topology);
+	icap->icap_clock_freq_topology = NULL;
+	icap->icap_clock_freq_topology_length = 0;
+}
+
+static int icap_setup_clock_freq_topology(struct icap *icap,
+	const char *buffer, unsigned long length)
+{
+	if (length == 0)
+		return 0;
+
+	free_clock_freq_topology(icap);
+
+	icap->icap_clock_freq_topology = vmalloc(length);
+	if (!icap->icap_clock_freq_topology)
+		return -ENOMEM;
+
+	memcpy(icap->icap_clock_freq_topology, buffer, length);
+	icap->icap_clock_freq_topology_length = length;
+
+	return 0;
+}
+
+static inline void free_clear_bitstream(struct icap *icap)
+{
+	vfree(icap->icap_clear_bitstream);
+	icap->icap_clear_bitstream = NULL;
+	icap->icap_clear_bitstream_length = 0;
+}
+
+static int icap_setup_clear_bitstream(struct icap *icap,
+	const char *buffer, unsigned long length)
+{
+	if (length == 0)
+		return 0;
+
+	free_clear_bitstream(icap);
+
+	icap->icap_clear_bitstream = vmalloc(length);
+	if (!icap->icap_clear_bitstream)
+		return -ENOMEM;
+
+	memcpy(icap->icap_clear_bitstream, buffer, length);
+	icap->icap_clear_bitstream_length = length;
+
+	return 0;
+}
+
+static int wait_for_done(struct icap *icap)
+{
+	u32 w;
+	int i = 0;
+
+	for (i = 0; i < 10; i++) {
+		udelay(5);
+		w = reg_rd(&icap->icap_regs->ir_sr);
+		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
+		if (w & 0x5)
+			return 0;
+	}
+
+	ICAP_ERR(icap, "bitstream download timeout");
+	return -ETIMEDOUT;
+}
+
+static int icap_write(struct icap *icap, const u32 *word_buf, int size)
+{
+	int i;
+	u32 value = 0;
+
+	for (i = 0; i < size; i++) {
+		value = be32_to_cpu(word_buf[i]);
+		reg_wr(&icap->icap_regs->ir_wf, value);
+	}
+
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+
+	for (i = 0; i < 20; i++) {
+		value = reg_rd(&icap->icap_regs->ir_cr);
+		if ((value & 0x1) == 0)
+			return 0;
+		ndelay(50);
+	}
+
+	ICAP_ERR(icap, "writing %d dwords timeout", size);
+	return -EIO;
+}
+
+static uint64_t icap_get_section_size(struct icap *icap, enum axlf_section_kind kind)
+{
+	uint64_t size = 0;
+
+	switch (kind) {
+	case IP_LAYOUT:
+		size = sizeof_sect(icap->ip_layout, m_ip_data);
+		break;
+	case MEM_TOPOLOGY:
+		size = sizeof_sect(icap->mem_topo, m_mem_data);
+		break;
+	case DEBUG_IP_LAYOUT:
+		size = sizeof_sect(icap->debug_layout, m_debug_ip_data);
+		break;
+	case CONNECTIVITY:
+		size = sizeof_sect(icap->connectivity, m_connection);
+		break;
+	default:
+		break;
+	}
+
+	return size;
+}
+
+static int bitstream_parse_header(struct icap *icap, const unsigned char *Data,
+	unsigned int Size, struct XHwIcap_Bit_Header *Header)
+{
+	unsigned int I;
+	unsigned int Len;
+	unsigned int Tmp;
+	unsigned int Index;
+
+	/* Start Index at start of bitstream */
+	Index = 0;
+
+	/* Initialize HeaderLength.  If header returned early inidicates
+	 * failure.
+	 */
+	Header->HeaderLength = XHI_BIT_HEADER_FAILURE;
+
+	/* Get "Magic" length */
+	Header->MagicLength = Data[Index++];
+	Header->MagicLength = (Header->MagicLength << 8) | Data[Index++];
+
+	/* Read in "magic" */
+	for (I = 0; I < Header->MagicLength - 1; I++) {
+		Tmp = Data[Index++];
+		if (I%2 == 0 && Tmp != XHI_EVEN_MAGIC_BYTE)
+			return -1;   /* INVALID_FILE_HEADER_ERROR */
+
+		if (I%2 == 1 && Tmp != XHI_ODD_MAGIC_BYTE)
+			return -1;   /* INVALID_FILE_HEADER_ERROR */
+
+	}
+
+	/* Read null end of magic data. */
+	Tmp = Data[Index++];
+
+	/* Read 0x01 (short) */
+	Tmp = Data[Index++];
+	Tmp = (Tmp << 8) | Data[Index++];
+
+	/* Check the "0x01" half word */
+	if (Tmp != 0x01)
+		return -1;	 /* INVALID_FILE_HEADER_ERROR */
+
+	/* Read 'a' */
+	Tmp = Data[Index++];
+	if (Tmp != 'a')
+		return -1;	  /* INVALID_FILE_HEADER_ERROR	*/
+
+	/* Get Design Name length */
+	Len = Data[Index++];
+	Len = (Len << 8) | Data[Index++];
+
+	/* allocate space for design name and final null character. */
+	Header->DesignName = kmalloc(Len, GFP_KERNEL);
+
+	/* Read in Design Name */
+	for (I = 0; I < Len; I++)
+		Header->DesignName[I] = Data[Index++];
+
+
+	if (Header->DesignName[Len-1] != '\0')
+		return -1;
+
+	/* Read 'b' */
+	Tmp = Data[Index++];
+	if (Tmp != 'b')
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Get Part Name length */
+	Len = Data[Index++];
+	Len = (Len << 8) | Data[Index++];
+
+	/* allocate space for part name and final null character. */
+	Header->PartName = kmalloc(Len, GFP_KERNEL);
+
+	/* Read in part name */
+	for (I = 0; I < Len; I++)
+		Header->PartName[I] = Data[Index++];
+
+	if (Header->PartName[Len-1] != '\0')
+		return -1;
+
+	/* Read 'c' */
+	Tmp = Data[Index++];
+	if (Tmp != 'c')
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Get date length */
+	Len = Data[Index++];
+	Len = (Len << 8) | Data[Index++];
+
+	/* allocate space for date and final null character. */
+	Header->Date = kmalloc(Len, GFP_KERNEL);
+
+	/* Read in date name */
+	for (I = 0; I < Len; I++)
+		Header->Date[I] = Data[Index++];
+
+	if (Header->Date[Len - 1] != '\0')
+		return -1;
+
+	/* Read 'd' */
+	Tmp = Data[Index++];
+	if (Tmp != 'd')
+		return -1;	/* INVALID_FILE_HEADER_ERROR  */
+
+	/* Get time length */
+	Len = Data[Index++];
+	Len = (Len << 8) | Data[Index++];
+
+	/* allocate space for time and final null character. */
+	Header->Time = kmalloc(Len, GFP_KERNEL);
+
+	/* Read in time name */
+	for (I = 0; I < Len; I++)
+		Header->Time[I] = Data[Index++];
+
+	if (Header->Time[Len - 1] != '\0')
+		return -1;
+
+	/* Read 'e' */
+	Tmp = Data[Index++];
+	if (Tmp != 'e')
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Get byte length of bitstream */
+	Header->BitstreamLength = Data[Index++];
+	Header->BitstreamLength = (Header->BitstreamLength << 8) | Data[Index++];
+	Header->BitstreamLength = (Header->BitstreamLength << 8) | Data[Index++];
+	Header->BitstreamLength = (Header->BitstreamLength << 8) | Data[Index++];
+	Header->HeaderLength = Index;
+
+	ICAP_INFO(icap, "Design \"%s\"", Header->DesignName);
+	ICAP_INFO(icap, "Part \"%s\"", Header->PartName);
+	ICAP_INFO(icap, "Timestamp \"%s %s\"", Header->Time, Header->Date);
+	ICAP_INFO(icap, "Raw data size 0x%x", Header->BitstreamLength);
+	return 0;
+}
+
+static int bitstream_helper(struct icap *icap, const u32 *word_buffer,
+			    unsigned int word_count)
+{
+	unsigned int remain_word;
+	unsigned int word_written = 0;
+	int wr_fifo_vacancy = 0;
+	int err = 0;
+
+	for (remain_word = word_count; remain_word > 0;
+		remain_word -= word_written, word_buffer += word_written) {
+		wr_fifo_vacancy = reg_rd(&icap->icap_regs->ir_wfv);
+		if (wr_fifo_vacancy <= 0) {
+			ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
+			err = -EIO;
+			break;
+		}
+		word_written = (wr_fifo_vacancy < remain_word) ?
+			wr_fifo_vacancy : remain_word;
+		if (icap_write(icap, word_buffer, word_written) != 0) {
+			err = -EIO;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static long icap_download(struct icap *icap, const char *buffer,
+	unsigned long length)
+{
+	long err = 0;
+	struct XHwIcap_Bit_Header bit_header = { 0 };
+	unsigned int numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+	unsigned int byte_read;
+
+	BUG_ON(!buffer);
+	BUG_ON(!length);
+
+	if (bitstream_parse_header(icap, buffer,
+		DMA_HWICAP_BITFILE_BUFFER_SIZE, &bit_header)) {
+		err = -EINVAL;
+		goto free_buffers;
+	}
+
+	if ((bit_header.HeaderLength + bit_header.BitstreamLength) > length) {
+		err = -EINVAL;
+		goto free_buffers;
+	}
+
+	buffer += bit_header.HeaderLength;
+
+	for (byte_read = 0; byte_read < bit_header.BitstreamLength;
+		byte_read += numCharsRead) {
+		numCharsRead = bit_header.BitstreamLength - byte_read;
+		if (numCharsRead > DMA_HWICAP_BITFILE_BUFFER_SIZE)
+			numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+
+		err = bitstream_helper(icap, (u32 *)buffer,
+				       numCharsRead / sizeof(u32));
+		if (err)
+			goto free_buffers;
+		buffer += numCharsRead;
+	}
+
+	err = wait_for_done(icap);
+
+free_buffers:
+	kfree(bit_header.DesignName);
+	kfree(bit_header.PartName);
+	kfree(bit_header.Date);
+	kfree(bit_header.Time);
+	return err;
+}
+
+static const struct axlf_section_header *get_axlf_section_hdr(
+	struct icap *icap, const struct axlf *top, enum axlf_section_kind kind)
+{
+	int i;
+	const struct axlf_section_header *hdr = NULL;
+
+	ICAP_INFO(icap,
+		"trying to find section header for axlf section %d", kind);
+
+	for (i = 0; i < top->m_header.m_numSections; i++) {
+		ICAP_INFO(icap, "saw section header: %d",
+			top->m_sections[i].m_sectionKind);
+		if (top->m_sections[i].m_sectionKind == kind) {
+			hdr = &top->m_sections[i];
+			break;
+		}
+	}
+
+	if (hdr) {
+		if ((hdr->m_sectionOffset + hdr->m_sectionSize) >
+			top->m_header.m_length) {
+			ICAP_INFO(icap, "found section is invalid");
+			hdr = NULL;
+		} else {
+			ICAP_INFO(icap, "header offset: %llu, size: %llu",
+				hdr->m_sectionOffset, hdr->m_sectionSize);
+		}
+	} else {
+		ICAP_INFO(icap, "could not find section header %d", kind);
+	}
+
+	return hdr;
+}
+
+static int alloc_and_get_axlf_section(struct icap *icap,
+	const struct axlf *top, enum axlf_section_kind kind,
+	void **addr, uint64_t *size)
+{
+	void *section = NULL;
+	const struct axlf_section_header *hdr =
+		get_axlf_section_hdr(icap, top, kind);
+
+	if (hdr == NULL)
+		return -EINVAL;
+
+	section = vmalloc(hdr->m_sectionSize);
+	if (section == NULL)
+		return -ENOMEM;
+
+	memcpy(section, ((const char *)top) + hdr->m_sectionOffset,
+		hdr->m_sectionSize);
+
+	*addr = section;
+	*size = hdr->m_sectionSize;
+	return 0;
+}
+
+static int icap_download_boot_firmware(struct platform_device *pdev)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	struct pci_dev *pcidev = XOCL_PL_TO_PCI_DEV(pdev);
+	struct pci_dev *pcidev_user = NULL;
+	xdev_handle_t xdev = xocl_get_xdev(pdev);
+	int funcid = PCI_FUNC(pcidev->devfn);
+	int slotid = PCI_SLOT(pcidev->devfn);
+	unsigned short deviceid = pcidev->device;
+	struct axlf *bin_obj_axlf;
+	const struct firmware *fw;
+	char fw_name[128];
+	struct XHwIcap_Bit_Header bit_header = { 0 };
+	long err = 0;
+	uint64_t length = 0;
+	uint64_t primaryFirmwareOffset = 0;
+	uint64_t primaryFirmwareLength = 0;
+	uint64_t secondaryFirmwareOffset = 0;
+	uint64_t secondaryFirmwareLength = 0;
+	uint64_t mbBinaryOffset = 0;
+	uint64_t mbBinaryLength = 0;
+	const struct axlf_section_header *primaryHeader = 0;
+	const struct axlf_section_header *secondaryHeader = 0;
+	const struct axlf_section_header *mbHeader = 0;
+	bool load_mbs = false;
+
+	/* Can only be done from mgmt pf. */
+	if (!ICAP_PRIVILEGED(icap))
+		return -EPERM;
+
+	/* Read dsabin from file system. */
+
+	if (funcid != 0) {
+		pcidev_user = pci_get_slot(pcidev->bus,
+			PCI_DEVFN(slotid, funcid - 1));
+		if (!pcidev_user) {
+			pcidev_user = pci_get_device(pcidev->vendor,
+				pcidev->device + 1, NULL);
+		}
+		if (pcidev_user)
+			deviceid = pcidev_user->device;
+	}
+
+	snprintf(fw_name, sizeof(fw_name),
+		"xilinx/%04x-%04x-%04x-%016llx.dsabin",
+		le16_to_cpu(pcidev->vendor),
+		le16_to_cpu(deviceid),
+		le16_to_cpu(pcidev->subsystem_device),
+		le64_to_cpu(xocl_get_timestamp(xdev)));
+	ICAP_INFO(icap, "try load dsabin %s", fw_name);
+	err = request_firmware(&fw, fw_name, &pcidev->dev);
+	if (err) {
+		snprintf(fw_name, sizeof(fw_name),
+			"xilinx/%04x-%04x-%04x-%016llx.dsabin",
+			le16_to_cpu(pcidev->vendor),
+			le16_to_cpu(deviceid + 1),
+			le16_to_cpu(pcidev->subsystem_device),
+			le64_to_cpu(xocl_get_timestamp(xdev)));
+		ICAP_INFO(icap, "try load dsabin %s", fw_name);
+		err = request_firmware(&fw, fw_name, &pcidev->dev);
+	}
+	/* Retry with the legacy dsabin. */
+	if (err) {
+		snprintf(fw_name, sizeof(fw_name),
+			"xilinx/%04x-%04x-%04x-%016llx.dsabin",
+			le16_to_cpu(pcidev->vendor),
+			le16_to_cpu(pcidev->device + 1),
+			le16_to_cpu(pcidev->subsystem_device),
+			le64_to_cpu(0x0000000000000000));
+		ICAP_INFO(icap, "try load dsabin %s", fw_name);
+		err = request_firmware(&fw, fw_name, &pcidev->dev);
+	}
+	if (err) {
+		/* Give up on finding .dsabin. */
+		ICAP_ERR(icap, "unable to find firmware, giving up");
+		return err;
+	}
+
+	/* Grab lock and touch hardware. */
+	mutex_lock(&icap->icap_lock);
+
+	if (xocl_mb_sched_on(xdev)) {
+		/* Try locating the microblaze binary. */
+		bin_obj_axlf = (struct axlf *)fw->data;
+		mbHeader = get_axlf_section_hdr(icap, bin_obj_axlf, SCHED_FIRMWARE);
+		if (mbHeader) {
+			mbBinaryOffset = mbHeader->m_sectionOffset;
+			mbBinaryLength = mbHeader->m_sectionSize;
+			length = bin_obj_axlf->m_header.m_length;
+			xocl_mb_load_sche_image(xdev, fw->data + mbBinaryOffset,
+				mbBinaryLength);
+			ICAP_INFO(icap, "stashed mb sche binary");
+			load_mbs = true;
+		}
+	}
+
+	if (xocl_mb_mgmt_on(xdev)) {
+		/* Try locating the board mgmt binary. */
+		bin_obj_axlf = (struct axlf *)fw->data;
+		mbHeader = get_axlf_section_hdr(icap, bin_obj_axlf, FIRMWARE);
+		if (mbHeader) {
+			mbBinaryOffset = mbHeader->m_sectionOffset;
+			mbBinaryLength = mbHeader->m_sectionSize;
+			length = bin_obj_axlf->m_header.m_length;
+			xocl_mb_load_mgmt_image(xdev, fw->data + mbBinaryOffset,
+				mbBinaryLength);
+			ICAP_INFO(icap, "stashed mb mgmt binary");
+			load_mbs = true;
+		}
+	}
+
+	if (load_mbs)
+		xocl_mb_reset(xdev);
+
+
+	if (memcmp(fw->data, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)) != 0) {
+		ICAP_ERR(icap, "invalid firmware %s", fw_name);
+		err = -EINVAL;
+		goto done;
+	}
+
+	ICAP_INFO(icap, "boot_firmware in axlf format");
+	bin_obj_axlf = (struct axlf *)fw->data;
+	length = bin_obj_axlf->m_header.m_length;
+	/* Match the xclbin with the hardware. */
+	if (!xocl_verify_timestamp(xdev,
+		bin_obj_axlf->m_header.m_featureRomTimeStamp)) {
+		ICAP_ERR(icap, "timestamp of ROM did not match xclbin");
+		err = -EINVAL;
+		goto done;
+	}
+	ICAP_INFO(icap, "VBNV and timestamps matched");
+
+	if (xocl_xrt_version_check(xdev, bin_obj_axlf, true)) {
+		ICAP_ERR(icap, "Major version does not match xrt");
+		err = -EINVAL;
+		goto done;
+	}
+	ICAP_INFO(icap, "runtime version matched");
+
+	primaryHeader = get_axlf_section_hdr(icap, bin_obj_axlf, BITSTREAM);
+	secondaryHeader = get_axlf_section_hdr(icap, bin_obj_axlf,
+		CLEARING_BITSTREAM);
+	if (primaryHeader) {
+		primaryFirmwareOffset = primaryHeader->m_sectionOffset;
+		primaryFirmwareLength = primaryHeader->m_sectionSize;
+	}
+	if (secondaryHeader) {
+		secondaryFirmwareOffset = secondaryHeader->m_sectionOffset;
+		secondaryFirmwareLength = secondaryHeader->m_sectionSize;
+	}
+
+	if (length > fw->size) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if ((primaryFirmwareOffset + primaryFirmwareLength) > length) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if ((secondaryFirmwareOffset + secondaryFirmwareLength) > length) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (primaryFirmwareLength) {
+		ICAP_INFO(icap,
+			"found second stage bitstream of size 0x%llx in %s",
+			primaryFirmwareLength, fw_name);
+		err = icap_download(icap, fw->data + primaryFirmwareOffset,
+			primaryFirmwareLength);
+		/*
+		 * If we loaded a new second stage, we do not need the
+		 * previously stashed clearing bitstream if any.
+		 */
+		free_clear_bitstream(icap);
+		if (err) {
+			ICAP_ERR(icap,
+				"failed to download second stage bitstream");
+			goto done;
+		}
+		ICAP_INFO(icap, "downloaded second stage bitstream");
+	}
+
+	/*
+	 * If both primary and secondary bitstreams have been provided then
+	 * ignore the previously stashed bitstream if any. If only secondary
+	 * bitstream was provided, but we found a previously stashed bitstream
+	 * we should use the latter since it is more appropriate for the
+	 * current state of the device
+	 */
+	if (secondaryFirmwareLength && (primaryFirmwareLength ||
+		!icap->icap_clear_bitstream)) {
+		free_clear_bitstream(icap);
+		icap->icap_clear_bitstream = vmalloc(secondaryFirmwareLength);
+		if (!icap->icap_clear_bitstream) {
+			err = -ENOMEM;
+			goto done;
+		}
+		icap->icap_clear_bitstream_length = secondaryFirmwareLength;
+		memcpy(icap->icap_clear_bitstream,
+			fw->data + secondaryFirmwareOffset,
+			icap->icap_clear_bitstream_length);
+		ICAP_INFO(icap, "found clearing bitstream of size 0x%lx in %s",
+			icap->icap_clear_bitstream_length, fw_name);
+	} else if (icap->icap_clear_bitstream) {
+		ICAP_INFO(icap,
+			"using existing clearing bitstream of size 0x%lx",
+		       icap->icap_clear_bitstream_length);
+	}
+
+	if (icap->icap_clear_bitstream &&
+		bitstream_parse_header(icap, icap->icap_clear_bitstream,
+		DMA_HWICAP_BITFILE_BUFFER_SIZE, &bit_header)) {
+		err = -EINVAL;
+		free_clear_bitstream(icap);
+	}
+
+done:
+	mutex_unlock(&icap->icap_lock);
+	release_firmware(fw);
+	kfree(bit_header.DesignName);
+	kfree(bit_header.PartName);
+	kfree(bit_header.Date);
+	kfree(bit_header.Time);
+	ICAP_INFO(icap, "%s err: %ld", __func__, err);
+	return err;
+}
+
+
+static long icap_download_clear_bitstream(struct icap *icap)
+{
+	long err = 0;
+	const char *buffer = icap->icap_clear_bitstream;
+	unsigned long length = icap->icap_clear_bitstream_length;
+
+	ICAP_INFO(icap, "downloading clear bitstream of length 0x%lx", length);
+
+	if (!buffer)
+		return 0;
+
+	err = icap_download(icap, buffer, length);
+
+	free_clear_bitstream(icap);
+	return err;
+}
+
+/*
+ * This function should be called with icap_mutex lock held
+ */
+static long axlf_set_freqscaling(struct icap *icap, struct platform_device *pdev,
+	const char *clk_buf, unsigned long length)
+{
+	struct clock_freq_topology *freqs = NULL;
+	int clock_type_count = 0;
+	int i = 0;
+	struct clock_freq *freq = NULL;
+	int data_clk_count = 0;
+	int kernel_clk_count = 0;
+	int system_clk_count = 0;
+	unsigned short target_freqs[4] = {0};
+
+	freqs = (struct clock_freq_topology *)clk_buf;
+	if (freqs->m_count > 4) {
+		ICAP_ERR(icap, "More than 4 clocks found in clock topology");
+		return -EDOM;
+	}
+
+	//Error checks - we support 1 data clk (reqd), one kernel clock(reqd) and
+	//at most 2 system clocks (optional/reqd for aws).
+	//Data clk needs to be the first entry, followed by kernel clock
+	//and then system clocks
+	//
+
+	for (i = 0; i < freqs->m_count; i++) {
+		freq = &(freqs->m_clock_freq[i]);
+		if (freq->m_type == CT_DATA)
+			data_clk_count++;
+
+		if (freq->m_type == CT_KERNEL)
+			kernel_clk_count++;
+
+		if (freq->m_type == CT_SYSTEM)
+			system_clk_count++;
+
+	}
+
+	if (data_clk_count != 1) {
+		ICAP_ERR(icap, "Data clock not found in clock topology");
+		return -EDOM;
+	}
+	if (kernel_clk_count != 1) {
+		ICAP_ERR(icap, "Kernel clock not found in clock topology");
+		return -EDOM;
+	}
+	if (system_clk_count > 2) {
+		ICAP_ERR(icap,
+			"More than 2 system clocks found in clock topology");
+		return -EDOM;
+	}
+
+	for (i = 0; i < freqs->m_count; i++) {
+		freq = &(freqs->m_clock_freq[i]);
+		if (freq->m_type == CT_DATA)
+			target_freqs[0] = freq->m_freq_Mhz;
+	}
+
+	for (i = 0; i < freqs->m_count; i++) {
+		freq = &(freqs->m_clock_freq[i]);
+		if (freq->m_type == CT_KERNEL)
+			target_freqs[1] = freq->m_freq_Mhz;
+	}
+
+	clock_type_count = 2;
+	for (i = 0; i < freqs->m_count; i++) {
+		freq = &(freqs->m_clock_freq[i]);
+		if (freq->m_type == CT_SYSTEM)
+			target_freqs[clock_type_count++] = freq->m_freq_Mhz;
+	}
+
+
+	ICAP_INFO(icap, "setting clock freq, "
+		"num: %lu, data_freq: %d , clk_freq: %d, "
+		"sys_freq[0]: %d, sys_freq[1]: %d",
+		ARRAY_SIZE(target_freqs), target_freqs[0], target_freqs[1],
+		target_freqs[2], target_freqs[3]);
+	return set_freqs(icap, target_freqs, 4);
+}
+
+
+static int icap_download_user(struct icap *icap, const char *bit_buf,
+	unsigned long length)
+{
+	long err = 0;
+	struct XHwIcap_Bit_Header bit_header = { 0 };
+	unsigned int numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+	unsigned int byte_read;
+
+	ICAP_INFO(icap, "downloading bitstream, length: %lu", length);
+
+	icap_freeze_axi_gate(icap);
+
+	err = icap_download_clear_bitstream(icap);
+	if (err)
+		goto free_buffers;
+
+	if (bitstream_parse_header(icap, bit_buf,
+		DMA_HWICAP_BITFILE_BUFFER_SIZE, &bit_header)) {
+		err = -EINVAL;
+		goto free_buffers;
+	}
+	if ((bit_header.HeaderLength + bit_header.BitstreamLength) > length) {
+		err = -EINVAL;
+		goto free_buffers;
+	}
+
+	bit_buf += bit_header.HeaderLength;
+	for (byte_read = 0; byte_read < bit_header.BitstreamLength;
+		byte_read += numCharsRead) {
+		numCharsRead = bit_header.BitstreamLength - byte_read;
+		if (numCharsRead > DMA_HWICAP_BITFILE_BUFFER_SIZE)
+			numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+
+		err = bitstream_helper(icap, (u32 *)bit_buf,
+				       numCharsRead / sizeof(u32));
+		if (err)
+			goto free_buffers;
+
+		bit_buf += numCharsRead;
+	}
+
+	err = wait_for_done(icap);
+	if (err)
+		goto free_buffers;
+
+	/*
+	 * Perform frequency scaling since PR download can silenty overwrite
+	 * MMCM settings in static region changing the clock frequencies
+	 * although ClockWiz CONFIG registers will misleading report the older
+	 * configuration from before bitstream download as if nothing has
+	 * changed.
+	 */
+	if (!err)
+		err = icap_ocl_freqscaling(icap, true);
+
+free_buffers:
+	icap_free_axi_gate(icap);
+	kfree(bit_header.DesignName);
+	kfree(bit_header.PartName);
+	kfree(bit_header.Date);
+	kfree(bit_header.Time);
+	return err;
+}
+
+
+static int __icap_lock_peer(struct platform_device *pdev, const uuid_t *id)
+{
+	int err = 0;
+	struct icap *icap = platform_get_drvdata(pdev);
+	int resp = 0;
+	size_t resplen = sizeof(resp);
+	struct mailbox_req_bitstream_lock bitstream_lock = {0};
+	size_t data_len = sizeof(struct mailbox_req_bitstream_lock);
+	struct mailbox_req *mb_req = NULL;
+	size_t reqlen = sizeof(struct mailbox_req) + data_len;
+	/* if there is no user there
+	 * ask mgmt to lock the bitstream
+	 */
+	if (icap->icap_bitstream_ref == 0) {
+		mb_req = vmalloc(reqlen);
+		if (!mb_req) {
+			err = -ENOMEM;
+			goto done;
+		}
+
+		mb_req->req = MAILBOX_REQ_LOCK_BITSTREAM;
+		uuid_copy(&bitstream_lock.uuid, id);
+
+		memcpy(mb_req->data, &bitstream_lock, data_len);
+
+		err = xocl_peer_request(XOCL_PL_DEV_TO_XDEV(pdev),
+			mb_req, reqlen, &resp, &resplen, NULL, NULL);
+
+		if (err) {
+			err = -ENODEV;
+			goto done;
+		}
+
+		if (resp < 0) {
+			err = resp;
+			goto done;
+		}
+	}
+
+done:
+	vfree(mb_req);
+	return err;
+}
+
+static int __icap_unlock_peer(struct platform_device *pdev, const uuid_t *id)
+{
+	int err = 0;
+	struct icap *icap = platform_get_drvdata(pdev);
+	struct mailbox_req_bitstream_lock bitstream_lock = {0};
+	size_t data_len = sizeof(struct mailbox_req_bitstream_lock);
+	struct mailbox_req *mb_req = NULL;
+	size_t reqlen = sizeof(struct mailbox_req) + data_len;
+	/* if there is no user there
+	 * ask mgmt to unlock the bitstream
+	 */
+	if (icap->icap_bitstream_ref == 0) {
+		mb_req = vmalloc(reqlen);
+		if (!mb_req) {
+			err = -ENOMEM;
+			goto done;
+		}
+
+		mb_req->req = MAILBOX_REQ_UNLOCK_BITSTREAM;
+		memcpy(mb_req->data, &bitstream_lock, data_len);
+
+		err = xocl_peer_notify(XOCL_PL_DEV_TO_XDEV(pdev), mb_req, reqlen);
+		if (err) {
+			err = -ENODEV;
+			goto done;
+		}
+	}
+done:
+	vfree(mb_req);
+	return err;
+}
+
+
+static int icap_download_bitstream_axlf(struct platform_device *pdev,
+	const void *u_xclbin)
+{
+	/*
+	 * decouple as 1. download xclbin, 2. parse xclbin 3. verify xclbin
+	 */
+	struct icap *icap = platform_get_drvdata(pdev);
+	long err = 0;
+	uint64_t primaryFirmwareOffset = 0;
+	uint64_t primaryFirmwareLength = 0;
+	uint64_t secondaryFirmwareOffset = 0;
+	uint64_t secondaryFirmwareLength = 0;
+	const struct axlf_section_header *primaryHeader = NULL;
+	const struct axlf_section_header *clockHeader = NULL;
+	const struct axlf_section_header *secondaryHeader = NULL;
+	struct axlf *xclbin = (struct axlf *)u_xclbin;
+	char *buffer;
+	xdev_handle_t xdev = xocl_get_xdev(pdev);
+	bool need_download;
+	int msg = -ETIMEDOUT;
+	size_t resplen = sizeof(msg);
+	int pid = pid_nr(task_tgid(current));
+	uint32_t data_len = 0;
+	int peer_connected;
+	struct mailbox_req *mb_req = NULL;
+	struct mailbox_bitstream_kaddr mb_addr = {0};
+	uuid_t peer_uuid;
+
+	if (memcmp(xclbin->m_magic, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)))
+		return -EINVAL;
+
+	if (ICAP_PRIVILEGED(icap)) {
+		if (xocl_xrt_version_check(xdev, xclbin, true)) {
+			ICAP_ERR(icap, "XRT version does not match");
+			return -EINVAL;
+		}
+
+		/* Match the xclbin with the hardware. */
+		if (!xocl_verify_timestamp(xdev,
+			xclbin->m_header.m_featureRomTimeStamp)) {
+			ICAP_ERR(icap, "timestamp of ROM not match Xclbin");
+			xocl_sysfs_error(xdev, "timestamp of ROM not match Xclbin");
+			return -EINVAL;
+		}
+
+		mutex_lock(&icap->icap_lock);
+
+		ICAP_INFO(icap,
+			"incoming xclbin: %016llx, on device xclbin: %016llx",
+			xclbin->m_uniqueId, icap->icap_bitstream_id);
+
+		need_download = (icap->icap_bitstream_id != xclbin->m_uniqueId);
+
+		if (!need_download) {
+			/*
+			 * No need to download, if xclbin exists already.
+			 * But, still need to reset CUs.
+			 */
+			if (!icap_bitstream_in_use(icap, 0)) {
+				icap_freeze_axi_gate(icap);
+				msleep(50);
+				icap_free_axi_gate(icap);
+				msleep(50);
+			}
+			ICAP_INFO(icap, "bitstream already exists, skip downloading");
+		}
+
+		mutex_unlock(&icap->icap_lock);
+
+		if (!need_download)
+			return 0;
+
+		/*
+		 * Find sections in xclbin.
+		 */
+		ICAP_INFO(icap, "finding CLOCK_FREQ_TOPOLOGY section");
+		/* Read the CLOCK section but defer changing clocks to later */
+		clockHeader = get_axlf_section_hdr(icap, xclbin,
+			CLOCK_FREQ_TOPOLOGY);
+
+		ICAP_INFO(icap, "finding bitstream sections");
+		primaryHeader = get_axlf_section_hdr(icap, xclbin, BITSTREAM);
+		if (primaryHeader == NULL) {
+			err = -EINVAL;
+			goto done;
+		}
+		primaryFirmwareOffset = primaryHeader->m_sectionOffset;
+		primaryFirmwareLength = primaryHeader->m_sectionSize;
+
+		secondaryHeader = get_axlf_section_hdr(icap, xclbin,
+			CLEARING_BITSTREAM);
+		if (secondaryHeader) {
+			if (XOCL_PL_TO_PCI_DEV(pdev)->device == 0x7138) {
+				err = -EINVAL;
+				goto done;
+			} else {
+				secondaryFirmwareOffset =
+					secondaryHeader->m_sectionOffset;
+				secondaryFirmwareLength =
+					secondaryHeader->m_sectionSize;
+			}
+		}
+
+		mutex_lock(&icap->icap_lock);
+
+		if (icap_bitstream_in_use(icap, 0)) {
+			ICAP_ERR(icap, "bitstream is locked, can't download new one");
+			err = -EBUSY;
+			goto done;
+		}
+
+		/* All clear, go ahead and start fiddling with hardware */
+
+		if (clockHeader != NULL) {
+			uint64_t clockFirmwareOffset = clockHeader->m_sectionOffset;
+			uint64_t clockFirmwareLength = clockHeader->m_sectionSize;
+
+			buffer = (char *)xclbin;
+			buffer += clockFirmwareOffset;
+			err = axlf_set_freqscaling(icap, pdev, buffer, clockFirmwareLength);
+			if (err)
+				goto done;
+			err = icap_setup_clock_freq_topology(icap, buffer, clockFirmwareLength);
+			if (err)
+				goto done;
+		}
+
+		icap->icap_bitstream_id = 0;
+		uuid_copy(&icap->icap_bitstream_uuid, &uuid_null);
+
+		buffer = (char *)xclbin;
+		buffer += primaryFirmwareOffset;
+		err = icap_download_user(icap, buffer, primaryFirmwareLength);
+		if (err)
+			goto done;
+
+		buffer = (char *)u_xclbin;
+		buffer += secondaryFirmwareOffset;
+		err = icap_setup_clear_bitstream(icap, buffer, secondaryFirmwareLength);
+		if (err)
+			goto done;
+
+		if ((xocl_is_unified(xdev) || XOCL_DSA_XPR_ON(xdev)))
+			err = calibrate_mig(icap);
+		if (err)
+			goto done;
+
+		/* Remember "this" bitstream, so avoid redownload the next time. */
+		icap->icap_bitstream_id = xclbin->m_uniqueId;
+		if (!uuid_is_null(&xclbin->m_header.uuid)) {
+			uuid_copy(&icap->icap_bitstream_uuid, &xclbin->m_header.uuid);
+		} else {
+			// Legacy xclbin, convert legacy id to new id
+			memcpy(&icap->icap_bitstream_uuid,
+				&xclbin->m_header.m_timeStamp, 8);
+		}
+	} else {
+
+		mutex_lock(&icap->icap_lock);
+
+		if (icap_bitstream_in_use(icap, pid)) {
+			if (!uuid_equal(&xclbin->m_header.uuid, &icap->icap_bitstream_uuid)) {
+				err = -EBUSY;
+				goto done;
+			}
+		}
+
+		icap_read_from_peer(pdev, XCLBIN_UUID, &peer_uuid, sizeof(uuid_t));
+
+		if (!uuid_equal(&peer_uuid, &xclbin->m_header.uuid)) {
+			/*
+			 *  should replace with userpf download flow
+			 */
+			peer_connected = xocl_mailbox_get_data(xdev, PEER_CONN);
+			ICAP_INFO(icap, "%s peer_connected 0x%x", __func__,
+				peer_connected);
+			if (peer_connected < 0) {
+				err = -ENODEV;
+				goto done;
+			}
+
+			if (!(peer_connected & MB_PEER_CONNECTED)) {
+				ICAP_ERR(icap, "%s fail to find peer, abort!",
+					__func__);
+				err = -EFAULT;
+				goto done;
+			}
+
+			if ((peer_connected & 0xF) == MB_PEER_SAMEDOM_CONNECTED) {
+				data_len = sizeof(struct mailbox_req) + sizeof(struct mailbox_bitstream_kaddr);
+				mb_req = vmalloc(data_len);
+				if (!mb_req) {
+					ICAP_ERR(icap, "Unable to create mb_req\n");
+					err = -ENOMEM;
+					goto done;
+				}
+				mb_req->req = MAILBOX_REQ_LOAD_XCLBIN_KADDR;
+				mb_addr.addr = (uint64_t)xclbin;
+				memcpy(mb_req->data, &mb_addr, sizeof(struct mailbox_bitstream_kaddr));
+
+			} else if ((peer_connected & 0xF) == MB_PEER_CONNECTED) {
+				data_len = sizeof(struct mailbox_req) +
+					xclbin->m_header.m_length;
+				mb_req = vmalloc(data_len);
+				if (!mb_req) {
+					ICAP_ERR(icap, "Unable to create mb_req\n");
+					err = -ENOMEM;
+					goto done;
+				}
+				memcpy(mb_req->data, u_xclbin, xclbin->m_header.m_length);
+				mb_req->req = MAILBOX_REQ_LOAD_XCLBIN;
+			}
+
+			mb_req->data_total_len = data_len;
+			(void) xocl_peer_request(xdev,
+				mb_req, data_len, &msg, &resplen, NULL, NULL);
+
+			if (msg != 0) {
+				ICAP_ERR(icap,
+					"%s peer failed to download xclbin",
+					__func__);
+				err = -EFAULT;
+				goto done;
+			}
+		} else
+			ICAP_INFO(icap, "Already downloaded xclbin ID: %016llx",
+				xclbin->m_uniqueId);
+
+		icap->icap_bitstream_id = xclbin->m_uniqueId;
+		if (!uuid_is_null(&xclbin->m_header.uuid)) {
+			uuid_copy(&icap->icap_bitstream_uuid, &xclbin->m_header.uuid);
+		} else {
+			// Legacy xclbin, convert legacy id to new id
+			memcpy(&icap->icap_bitstream_uuid,
+				&xclbin->m_header.m_timeStamp, 8);
+		}
+
+	}
+
+	if (ICAP_PRIVILEGED(icap)) {
+		icap_parse_bitstream_axlf_section(pdev, xclbin, MEM_TOPOLOGY);
+		icap_parse_bitstream_axlf_section(pdev, xclbin, IP_LAYOUT);
+	} else {
+		icap_parse_bitstream_axlf_section(pdev, xclbin, IP_LAYOUT);
+		icap_parse_bitstream_axlf_section(pdev, xclbin, MEM_TOPOLOGY);
+		icap_parse_bitstream_axlf_section(pdev, xclbin, CONNECTIVITY);
+		icap_parse_bitstream_axlf_section(pdev, xclbin, DEBUG_IP_LAYOUT);
+	}
+
+	if (ICAP_PRIVILEGED(icap))
+		err = icap_verify_bitstream_axlf(pdev, xclbin);
+
+done:
+	mutex_unlock(&icap->icap_lock);
+	vfree(mb_req);
+	ICAP_INFO(icap, "%s err: %ld", __func__, err);
+	return err;
+}
+
+static int icap_verify_bitstream_axlf(struct platform_device *pdev,
+	struct axlf *xclbin)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	int err = 0, i;
+	xdev_handle_t xdev = xocl_get_xdev(pdev);
+	bool dna_check = false;
+	uint64_t section_size = 0;
+
+	/* Destroy all dynamically add sub-devices*/
+	xocl_subdev_destroy_by_id(xdev, XOCL_SUBDEV_DNA);
+	xocl_subdev_destroy_by_id(xdev, XOCL_SUBDEV_MIG);
+
+	/*
+	 * Add sub device dynamically.
+	 * restrict any dynamically added sub-device and 1 base address,
+	 * Has pre-defined length
+	 *  Ex:    "ip_data": {
+	 *         "m_type": "IP_DNASC",
+	 *         "properties": "0x0",
+	 *         "m_base_address": "0x1100000", <--  base address
+	 *         "m_name": "slr0\/dna_self_check_0"
+	 */
+
+	if (!icap->ip_layout) {
+		err = -EFAULT;
+		goto done;
+	}
+	for (i = 0; i < icap->ip_layout->m_count; ++i) {
+		struct xocl_subdev_info subdev_info = { 0 };
+		struct resource res = { 0 };
+		struct ip_data *ip = &icap->ip_layout->m_ip_data[i];
+
+		if (ip->m_type == IP_KERNEL)
+			continue;
+
+		if (ip->m_type == IP_DDR4_CONTROLLER) {
+			uint32_t memidx = ip->properties;
+
+			if (!icap->mem_topo || ip->properties >= icap->mem_topo->m_count ||
+				icap->mem_topo->m_mem_data[memidx].m_type !=
+				MEM_DDR4) {
+				ICAP_ERR(icap, "bad ECC controller index: %u",
+					ip->properties);
+				continue;
+			}
+			if (!icap->mem_topo->m_mem_data[memidx].m_used) {
+				ICAP_INFO(icap,
+					"ignore ECC controller for: %s",
+					icap->mem_topo->m_mem_data[memidx].m_tag);
+				continue;
+			}
+			err = xocl_subdev_get_devinfo(XOCL_SUBDEV_MIG,
+				&subdev_info, &res);
+			if (err) {
+				ICAP_ERR(icap, "can't get MIG subdev info");
+				goto done;
+			}
+			res.start += ip->m_base_address;
+			res.end += ip->m_base_address;
+			subdev_info.priv_data =
+				icap->mem_topo->m_mem_data[memidx].m_tag;
+			subdev_info.data_len =
+				sizeof(icap->mem_topo->m_mem_data[memidx].m_tag);
+			err = xocl_subdev_create_multi_inst(xdev, &subdev_info);
+			if (err) {
+				ICAP_ERR(icap, "can't create MIG subdev");
+				goto done;
+			}
+		}
+		if (ip->m_type == IP_DNASC) {
+			dna_check = true;
+			err = xocl_subdev_get_devinfo(XOCL_SUBDEV_DNA,
+				&subdev_info, &res);
+			if (err) {
+				ICAP_ERR(icap, "can't get DNA subdev info");
+				goto done;
+			}
+			res.start += ip->m_base_address;
+			res.end += ip->m_base_address;
+			err = xocl_subdev_create_one(xdev, &subdev_info);
+			if (err) {
+				ICAP_ERR(icap, "can't create DNA subdev");
+				goto done;
+			}
+		}
+	}
+
+	if (dna_check) {
+		bool is_axi = ((xocl_dna_capability(xdev) & 0x1) != 0);
+
+		/*
+		 * Any error occurs here should return -EACCES for app to
+		 * know that DNA has failed.
+		 */
+		err = -EACCES;
+
+		ICAP_INFO(icap, "DNA version: %s", is_axi ? "AXI" : "BRAM");
+
+		if (is_axi) {
+			uint32_t *cert = NULL;
+
+			if (alloc_and_get_axlf_section(icap, xclbin,
+				DNA_CERTIFICATE,
+				(void **)&cert, &section_size) != 0) {
+
+				// We keep dna sub device if IP_DNASC presents
+				ICAP_ERR(icap, "Can't get certificate section");
+				goto dna_cert_fail;
+			}
+
+			ICAP_INFO(icap, "DNA Certificate Size 0x%llx", section_size);
+			if (section_size % 64 || section_size < 576)
+				ICAP_ERR(icap, "Invalid certificate size");
+			else
+				xocl_dna_write_cert(xdev, cert, section_size);
+			vfree(cert);
+		}
+
+		/* Check DNA validation result. */
+		if (0x1 & xocl_dna_status(xdev)) {
+			err = 0; /* xclbin is valid */
+		} else {
+			ICAP_ERR(icap, "DNA inside xclbin is invalid");
+			goto dna_cert_fail;
+		}
+	}
+
+done:
+	if (err) {
+		vfree(icap->connectivity);
+		icap->connectivity = NULL;
+		vfree(icap->ip_layout);
+		icap->ip_layout = NULL;
+		vfree(icap->mem_topo);
+		icap->mem_topo = NULL;
+		xocl_subdev_destroy_by_id(xdev, XOCL_SUBDEV_DNA);
+		xocl_subdev_destroy_by_id(xdev, XOCL_SUBDEV_MIG);
+	}
+dna_cert_fail:
+	return err;
+}
+
+/*
+ * On x86_64, reset hwicap by loading special bitstream sequence which
+ * forces the FPGA to reload from PROM.
+ */
+static int icap_reset_bitstream(struct platform_device *pdev)
+{
+/*
+ * Booting FPGA from PROM
+ * http://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
+ * Table 7.1
+ */
+#define DUMMY_WORD         0xFFFFFFFF
+#define SYNC_WORD          0xAA995566
+#define TYPE1_NOOP         0x20000000
+#define TYPE1_WRITE_WBSTAR 0x30020001
+#define WBSTAR_ADD10       0x00000000
+#define WBSTAR_ADD11       0x01000000
+#define TYPE1_WRITE_CMD    0x30008001
+#define IPROG_CMD          0x0000000F
+#define SWAP_ENDIAN_32(x)						\
+	(unsigned int)((((x) & 0xFF000000) >> 24) | (((x) & 0x00FF0000) >> 8) | \
+		       (((x) & 0x0000FF00) << 8)  | (((x) & 0x000000FF) << 24))
+	/*
+	 * The bitstream is expected in big endian format
+	 */
+	const unsigned int fpga_boot_seq[] = {SWAP_ENDIAN_32(DUMMY_WORD),
+			SWAP_ENDIAN_32(SYNC_WORD),
+			SWAP_ENDIAN_32(TYPE1_NOOP),
+			SWAP_ENDIAN_32(TYPE1_WRITE_CMD),
+			SWAP_ENDIAN_32(IPROG_CMD),
+			SWAP_ENDIAN_32(TYPE1_NOOP),
+			SWAP_ENDIAN_32(TYPE1_NOOP)};
+
+	struct icap *icap = platform_get_drvdata(pdev);
+	int i;
+
+	/* Can only be done from mgmt pf. */
+	if (!ICAP_PRIVILEGED(icap))
+		return -EPERM;
+
+	mutex_lock(&icap->icap_lock);
+
+	if (icap_bitstream_in_use(icap, 0)) {
+		mutex_unlock(&icap->icap_lock);
+		ICAP_ERR(icap, "bitstream is locked, can't reset");
+		return -EBUSY;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(fpga_boot_seq); i++) {
+		unsigned int value = be32_to_cpu(fpga_boot_seq[i]);
+
+		reg_wr(&icap->icap_regs->ir_wfv, value);
+	}
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+
+	msleep(4000);
+
+	mutex_unlock(&icap->icap_lock);
+
+	ICAP_INFO(icap, "reset bitstream is done");
+	return 0;
+}
+
+static int icap_lock_bitstream(struct platform_device *pdev, const uuid_t *id,
+	pid_t pid)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	int err = 0;
+
+	if (uuid_is_null(id)) {
+		ICAP_ERR(icap, "proc %d invalid UUID", pid);
+		return -EINVAL;
+	}
+
+	mutex_lock(&icap->icap_lock);
+
+	if (!ICAP_PRIVILEGED(icap)) {
+		err = __icap_lock_peer(pdev, id);
+		if (err < 0)
+			goto done;
+	}
+
+	if (uuid_equal(id, &icap->icap_bitstream_uuid))
+		err = add_user(icap, pid);
+	else
+		err = -EBUSY;
+
+	if (err >= 0)
+		err = icap->icap_bitstream_ref;
+
+	ICAP_INFO(icap, "proc %d try to lock bitstream %pUb, ref=%d, err=%d",
+		  pid, id, icap->icap_bitstream_ref, err);
+done:
+	mutex_unlock(&icap->icap_lock);
+
+	if (!ICAP_PRIVILEGED(icap) && err == 1) /* reset on first reference */
+		xocl_exec_reset(xocl_get_xdev(pdev));
+
+	if (err >= 0)
+		err = 0;
+
+	return err;
+}
+
+static int icap_unlock_bitstream(struct platform_device *pdev, const uuid_t *id,
+	pid_t pid)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	int err = 0;
+
+	if (id == NULL)
+		id = &uuid_null;
+
+	mutex_lock(&icap->icap_lock);
+
+	/* Force unlock. */
+	if (uuid_is_null(id))
+		del_all_users(icap);
+	else if (uuid_equal(id, &icap->icap_bitstream_uuid))
+		err = del_user(icap, pid);
+	else
+		err = -EINVAL;
+
+	if (!ICAP_PRIVILEGED(icap))
+		__icap_unlock_peer(pdev, id);
+
+	if (err >= 0)
+		err = icap->icap_bitstream_ref;
+
+	if (!ICAP_PRIVILEGED(icap)) {
+		if (err == 0)
+			xocl_exec_stop(xocl_get_xdev(pdev));
+	}
+
+	ICAP_INFO(icap, "proc %d try to unlock bitstream %pUb, ref=%d, err=%d",
+		  pid, id, icap->icap_bitstream_ref, err);
+
+	mutex_unlock(&icap->icap_lock);
+	if (err >= 0)
+		err = 0;
+	return err;
+}
+
+static int icap_parse_bitstream_axlf_section(struct platform_device *pdev,
+	const struct axlf *xclbin, enum axlf_section_kind kind)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	long err = 0;
+	uint64_t section_size = 0, sect_sz = 0;
+	void **target = NULL;
+
+	if (memcmp(xclbin->m_magic, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)))
+		return -EINVAL;
+
+	switch (kind) {
+	case IP_LAYOUT:
+		target = (void **)&icap->ip_layout;
+		break;
+	case MEM_TOPOLOGY:
+		target = (void **)&icap->mem_topo;
+		break;
+	case DEBUG_IP_LAYOUT:
+		target = (void **)&icap->debug_layout;
+		break;
+	case CONNECTIVITY:
+		target = (void **)&icap->connectivity;
+		break;
+	default:
+		break;
+	}
+	if (target) {
+		vfree(*target);
+		*target = NULL;
+	}
+	err = alloc_and_get_axlf_section(icap, xclbin, kind,
+		target, &section_size);
+	if (err != 0)
+		goto done;
+	sect_sz = icap_get_section_size(icap, kind);
+	if (sect_sz > section_size) {
+		err = -EINVAL;
+		goto done;
+	}
+done:
+	if (err) {
+		vfree(*target);
+		*target = NULL;
+	}
+	ICAP_INFO(icap, "%s kind %d, err: %ld", __func__, kind, err);
+	return err;
+}
+
+static uint64_t icap_get_data(struct platform_device *pdev,
+	enum data_kind kind)
+{
+
+	struct icap *icap = platform_get_drvdata(pdev);
+	uint64_t target = 0;
+
+	mutex_lock(&icap->icap_lock);
+	switch (kind) {
+	case IPLAYOUT_AXLF:
+		target = (uint64_t)icap->ip_layout;
+		break;
+	case MEMTOPO_AXLF:
+		target = (uint64_t)icap->mem_topo;
+		break;
+	case DEBUG_IPLAYOUT_AXLF:
+		target = (uint64_t)icap->debug_layout;
+		break;
+	case CONNECTIVITY_AXLF:
+		target = (uint64_t)icap->connectivity;
+		break;
+	case IDCODE:
+		target = icap->idcode;
+		break;
+	case XCLBIN_UUID:
+		target = (uint64_t)&icap->icap_bitstream_uuid;
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&icap->icap_lock);
+	return target;
+}
+
+/* Kernel APIs exported from this sub-device driver. */
+static struct xocl_icap_funcs icap_ops = {
+	.reset_axi_gate = platform_reset_axi_gate,
+	.reset_bitstream = icap_reset_bitstream,
+	.download_boot_firmware = icap_download_boot_firmware,
+	.download_bitstream_axlf = icap_download_bitstream_axlf,
+	.ocl_set_freq = icap_ocl_set_freqscaling,
+	.ocl_get_freq = icap_ocl_get_freqscaling,
+	.ocl_update_clock_freq_topology = icap_ocl_update_clock_freq_topology,
+	.ocl_lock_bitstream = icap_lock_bitstream,
+	.ocl_unlock_bitstream = icap_unlock_bitstream,
+	.get_data = icap_get_data,
+};
+
+static ssize_t clock_freq_topology_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct icap *icap = platform_get_drvdata(to_platform_device(dev));
+	ssize_t cnt = 0;
+
+	mutex_lock(&icap->icap_lock);
+	if (ICAP_PRIVILEGED(icap)) {
+		memcpy(buf, icap->icap_clock_freq_topology, icap->icap_clock_freq_topology_length);
+		cnt = icap->icap_clock_freq_topology_length;
+	}
+	mutex_unlock(&icap->icap_lock);
+
+	return cnt;
+
+}
+
+static DEVICE_ATTR_RO(clock_freq_topology);
+
+static ssize_t clock_freqs_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct icap *icap = platform_get_drvdata(to_platform_device(dev));
+	ssize_t cnt = 0;
+	int i;
+	u32 freq_counter, freq, request_in_khz, tolerance;
+
+	mutex_lock(&icap->icap_lock);
+
+	for (i = 0; i < ICAP_MAX_NUM_CLOCKS; i++) {
+		freq = icap_get_ocl_frequency(icap, i);
+		if (!uuid_is_null(&icap->icap_bitstream_uuid)) {
+			freq_counter = icap_get_clock_frequency_counter_khz(icap, i);
+
+			request_in_khz = freq * 1000;
+			tolerance = freq * 50;
+
+			if (abs(freq_counter-request_in_khz) > tolerance)
+				ICAP_INFO(icap, "Frequency mismatch, Should be %u khz, Now is %ukhz",
+					  request_in_khz, freq_counter);
+			cnt += sprintf(buf + cnt, "%d\n", DIV_ROUND_CLOSEST(freq_counter, 1000));
+		} else {
+			cnt += sprintf(buf + cnt, "%d\n", freq);
+		}
+	}
+
+	mutex_unlock(&icap->icap_lock);
+
+	return cnt;
+}
+static DEVICE_ATTR_RO(clock_freqs);
+
+static ssize_t icap_rl_program(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t off, size_t count)
+{
+	struct XHwIcap_Bit_Header bit_header = { 0 };
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct icap *icap = platform_get_drvdata(to_platform_device(dev));
+	ssize_t ret = count;
+
+	if (off == 0) {
+		if (count < DMA_HWICAP_BITFILE_BUFFER_SIZE) {
+			ICAP_ERR(icap, "count is too small %ld", count);
+			return -EINVAL;
+		}
+
+		if (bitstream_parse_header(icap, buffer,
+			DMA_HWICAP_BITFILE_BUFFER_SIZE, &bit_header)) {
+			ICAP_ERR(icap, "parse header failed");
+			return -EINVAL;
+		}
+
+		icap->bit_length = bit_header.HeaderLength +
+			bit_header.BitstreamLength;
+		icap->bit_buffer = vmalloc(icap->bit_length);
+	}
+
+	if (off + count >= icap->bit_length) {
+		/*
+		 * assumes all subdevices are removed at this time
+		 */
+		memcpy(icap->bit_buffer + off, buffer, icap->bit_length - off);
+		icap_freeze_axi_gate_shell(icap);
+		ret = icap_download(icap, icap->bit_buffer, icap->bit_length);
+		if (ret) {
+			ICAP_ERR(icap, "bitstream download failed");
+			ret = -EIO;
+		} else {
+			ret = count;
+		}
+		icap_free_axi_gate_shell(icap);
+		/* has to reset pci, otherwise firewall trips */
+		xocl_reset(xocl_get_xdev(icap->icap_pdev));
+		icap->icap_bitstream_id = 0;
+		memset(&icap->icap_bitstream_uuid, 0, sizeof(uuid_t));
+		vfree(icap->bit_buffer);
+		icap->bit_buffer = NULL;
+	} else {
+		memcpy(icap->bit_buffer + off, buffer, count);
+	}
+
+	return ret;
+}
+
+static struct bin_attribute shell_program_attr = {
+	.attr = {
+		.name = "shell_program",
+		.mode = 0200
+	},
+	.read = NULL,
+	.write = icap_rl_program,
+	.size = 0
+};
+
+static struct bin_attribute *icap_mgmt_bin_attrs[] = {
+	&shell_program_attr,
+	NULL,
+};
+
+static struct attribute_group icap_mgmt_bin_attr_group = {
+	.bin_attrs = icap_mgmt_bin_attrs,
+};
+
+static ssize_t idcode_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct icap *icap = platform_get_drvdata(to_platform_device(dev));
+	ssize_t cnt = 0;
+	uint32_t val;
+
+	mutex_lock(&icap->icap_lock);
+	if (ICAP_PRIVILEGED(icap)) {
+		cnt = sprintf(buf, "0x%x\n", icap->idcode);
+	} else {
+		icap_read_from_peer(to_platform_device(dev), IDCODE, &val, sizeof(unsigned int));
+		cnt = sprintf(buf, "0x%x\n", val);
+	}
+	mutex_unlock(&icap->icap_lock);
+
+	return cnt;
+}
+
+static DEVICE_ATTR_RO(idcode);
+
+static struct attribute *icap_attrs[] = {
+	&dev_attr_clock_freq_topology.attr,
+	&dev_attr_clock_freqs.attr,
+	&dev_attr_idcode.attr,
+	NULL,
+};
+
+//- Debug IP_layout--
+static ssize_t icap_read_debug_ip_layout(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t offset, size_t count)
+{
+	struct icap *icap;
+	u32 nread = 0;
+	size_t size = 0;
+
+	icap = (struct icap *)dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	if (!icap || !icap->debug_layout)
+		return 0;
+
+	mutex_lock(&icap->icap_lock);
+
+	size = sizeof_sect(icap->debug_layout, m_debug_ip_data);
+	if (offset >= size)
+		goto unlock;
+
+	if (count < size - offset)
+		nread = count;
+	else
+		nread = size - offset;
+
+	memcpy(buffer, ((char *)icap->debug_layout) + offset, nread);
+
+unlock:
+	mutex_unlock(&icap->icap_lock);
+	return nread;
+}
+static struct bin_attribute debug_ip_layout_attr = {
+	.attr = {
+		.name = "debug_ip_layout",
+		.mode = 0444
+	},
+	.read = icap_read_debug_ip_layout,
+	.write = NULL,
+	.size = 0
+};
+
+//IP layout
+static ssize_t icap_read_ip_layout(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t offset, size_t count)
+{
+	struct icap *icap;
+	u32 nread = 0;
+	size_t size = 0;
+
+	icap = (struct icap *)dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	if (!icap || !icap->ip_layout)
+		return 0;
+
+	mutex_lock(&icap->icap_lock);
+
+	size = sizeof_sect(icap->ip_layout, m_ip_data);
+	if (offset >= size)
+		goto unlock;
+
+	if (count < size - offset)
+		nread = count;
+	else
+		nread = size - offset;
+
+	memcpy(buffer, ((char *)icap->ip_layout) + offset, nread);
+
+unlock:
+	mutex_unlock(&icap->icap_lock);
+	return nread;
+}
+
+static struct bin_attribute ip_layout_attr = {
+	.attr = {
+		.name = "ip_layout",
+		.mode = 0444
+	},
+	.read = icap_read_ip_layout,
+	.write = NULL,
+	.size = 0
+};
+
+//-Connectivity--
+static ssize_t icap_read_connectivity(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t offset, size_t count)
+{
+	struct icap *icap;
+	u32 nread = 0;
+	size_t size = 0;
+
+	icap = (struct icap *)dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	if (!icap || !icap->connectivity)
+		return 0;
+
+	mutex_lock(&icap->icap_lock);
+
+	size = sizeof_sect(icap->connectivity, m_connection);
+	if (offset >= size)
+		goto unlock;
+
+	if (count < size - offset)
+		nread = count;
+	else
+		nread = size - offset;
+
+	memcpy(buffer, ((char *)icap->connectivity) + offset, nread);
+
+unlock:
+	mutex_unlock(&icap->icap_lock);
+	return nread;
+}
+
+static struct bin_attribute connectivity_attr = {
+	.attr = {
+		.name = "connectivity",
+		.mode = 0444
+	},
+	.read = icap_read_connectivity,
+	.write = NULL,
+	.size = 0
+};
+
+
+//-Mem_topology--
+static ssize_t icap_read_mem_topology(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t offset, size_t count)
+{
+	struct icap *icap;
+	u32 nread = 0;
+	size_t size = 0;
+
+	icap = (struct icap *)dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	if (!icap || !icap->mem_topo)
+		return 0;
+
+	mutex_lock(&icap->icap_lock);
+
+	size = sizeof_sect(icap->mem_topo, m_mem_data);
+	if (offset >= size)
+		goto unlock;
+
+	if (count < size - offset)
+		nread = count;
+	else
+		nread = size - offset;
+
+	memcpy(buffer, ((char *)icap->mem_topo) + offset, nread);
+unlock:
+	mutex_unlock(&icap->icap_lock);
+	return nread;
+}
+
+
+static struct bin_attribute mem_topology_attr = {
+	.attr = {
+		.name = "mem_topology",
+		.mode = 0444
+	},
+	.read = icap_read_mem_topology,
+	.write = NULL,
+	.size = 0
+};
+
+static struct bin_attribute *icap_bin_attrs[] = {
+	&debug_ip_layout_attr,
+	&ip_layout_attr,
+	&connectivity_attr,
+	&mem_topology_attr,
+	NULL,
+};
+
+static struct attribute_group icap_attr_group = {
+	.attrs = icap_attrs,
+	.bin_attrs = icap_bin_attrs,
+};
+
+static int icap_remove(struct platform_device *pdev)
+{
+	struct icap *icap = platform_get_drvdata(pdev);
+	int i;
+
+	BUG_ON(icap == NULL);
+
+	del_all_users(icap);
+	xocl_subdev_register(pdev, XOCL_SUBDEV_ICAP, NULL);
+
+	if (ICAP_PRIVILEGED(icap))
+		sysfs_remove_group(&pdev->dev.kobj, &icap_mgmt_bin_attr_group);
+
+	if (icap->bit_buffer)
+		vfree(icap->bit_buffer);
+
+	iounmap(icap->icap_regs);
+	iounmap(icap->icap_state);
+	iounmap(icap->icap_axi_gate);
+	for (i = 0; i < ICAP_MAX_NUM_CLOCKS; i++)
+		iounmap(icap->icap_clock_bases[i]);
+	free_clear_bitstream(icap);
+	free_clock_freq_topology(icap);
+
+	sysfs_remove_group(&pdev->dev.kobj, &icap_attr_group);
+
+	ICAP_INFO(icap, "cleaned up successfully");
+	platform_set_drvdata(pdev, NULL);
+	vfree(icap->mem_topo);
+	vfree(icap->ip_layout);
+	vfree(icap->debug_layout);
+	vfree(icap->connectivity);
+	kfree(icap);
+	return 0;
+}
+
+/*
+ * Run the following sequence of canned commands to obtain IDCODE of the FPGA
+ */
+static void icap_probe_chip(struct icap *icap)
+{
+	u32 w;
+
+	if (!ICAP_PRIVILEGED(icap))
+		return;
+
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	reg_wr(&icap->icap_regs->ir_gier, 0x0);
+	w = reg_rd(&icap->icap_regs->ir_wfv);
+	reg_wr(&icap->icap_regs->ir_wf, 0xffffffff);
+	reg_wr(&icap->icap_regs->ir_wf, 0xaa995566);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x28018001);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	reg_wr(&icap->icap_regs->ir_sz, 0x1);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	reg_wr(&icap->icap_regs->ir_cr, 0x2);
+	w = reg_rd(&icap->icap_regs->ir_rfo);
+	icap->idcode = reg_rd(&icap->icap_regs->ir_rf);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+}
+
+static int icap_probe(struct platform_device *pdev)
+{
+	struct icap *icap = NULL;
+	struct resource *res;
+	int ret;
+	int reg_grp;
+	void **regs;
+
+	icap = kzalloc(sizeof(struct icap), GFP_KERNEL);
+	if (!icap)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, icap);
+	icap->icap_pdev = pdev;
+	mutex_init(&icap->icap_lock);
+	INIT_LIST_HEAD(&icap->icap_bitstream_users);
+
+	for (reg_grp = 0; reg_grp < ICAP_MAX_REG_GROUPS; reg_grp++) {
+		switch (reg_grp) {
+		case 0:
+			regs = (void **)&icap->icap_regs;
+			break;
+		case 1:
+			regs = (void **)&icap->icap_state;
+			break;
+		case 2:
+			regs = (void **)&icap->icap_axi_gate;
+			break;
+		case 3:
+			regs = (void **)&icap->icap_clock_bases[0];
+			break;
+		case 4:
+			regs = (void **)&icap->icap_clock_bases[1];
+			break;
+		case 5:
+			regs = (void **)&icap->icap_clock_freq_counter;
+			break;
+		default:
+			BUG();
+			break;
+		}
+		res = platform_get_resource(pdev, IORESOURCE_MEM, reg_grp);
+		if (res != NULL) {
+			*regs = ioremap_nocache(res->start,
+				res->end - res->start + 1);
+			if (*regs == NULL) {
+				ICAP_ERR(icap,
+					"failed to map in register group: %d",
+					reg_grp);
+				ret = -EIO;
+				goto failed;
+			} else {
+				ICAP_INFO(icap,
+					"mapped in register group %d @ 0x%p",
+					reg_grp, *regs);
+			}
+		} else {
+			if (reg_grp != 0) {
+				ICAP_ERR(icap,
+					"failed to find register group: %d",
+					reg_grp);
+				ret = -EIO;
+				goto failed;
+			}
+			break;
+		}
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &icap_attr_group);
+	if (ret) {
+		ICAP_ERR(icap, "create icap attrs failed: %d", ret);
+		goto failed;
+	}
+
+	if (ICAP_PRIVILEGED(icap)) {
+		ret = sysfs_create_group(&pdev->dev.kobj,
+			&icap_mgmt_bin_attr_group);
+		if (ret) {
+			ICAP_ERR(icap, "create icap attrs failed: %d", ret);
+			goto failed;
+		}
+	}
+
+	icap_probe_chip(icap);
+	if (!ICAP_PRIVILEGED(icap))
+		icap_unlock_bitstream(pdev, NULL, 0);
+	ICAP_INFO(icap, "successfully initialized FPGA IDCODE 0x%x",
+			icap->idcode);
+	xocl_subdev_register(pdev, XOCL_SUBDEV_ICAP, &icap_ops);
+	return 0;
+
+failed:
+	(void) icap_remove(pdev);
+	return ret;
+}
+
+
+struct platform_device_id icap_id_table[] = {
+	{ XOCL_ICAP, 0 },
+	{ },
+};
+
+static struct platform_driver icap_driver = {
+	.probe		= icap_probe,
+	.remove		= icap_remove,
+	.driver		= {
+		.name	= XOCL_ICAP,
+	},
+	.id_table = icap_id_table,
+};
+
+int __init xocl_init_icap(void)
+{
+	return platform_driver_register(&icap_driver);
+}
+
+void xocl_fini_icap(void)
+{
+	platform_driver_unregister(&icap_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/mailbox.c b/drivers/gpu/drm/xocl/subdev/mailbox.c
new file mode 100644
index 000000000000..dc4736c9100a
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/mailbox.c
@@ -0,0 +1,1868 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Max Zhen <maxz@xilinx.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Statement of Theory
+ *
+ * This is the mailbox sub-device driver added into existing xclmgmt / xocl
+ * driver so that user pf and mgmt pf can send and receive messages of
+ * arbitrary length to / from peer. The driver is written based on the spec of
+ * pg114 document (https://www.xilinx.com/support/documentation/
+ * ip_documentation/mailbox/v2_1/pg114-mailbox.pdf). The HW provides one TX
+ * channel and one RX channel, which operate completely independent of each
+ * other. Data can be pushed into or read from a channel in DWORD unit as a
+ * FIFO.
+ *
+ *
+ * Packet layer
+ *
+ * The driver implemented two transport layers - packet and message layer (see
+ * below). A packet is a fixed size chunk of data that can be send through TX
+ * channel or retrieved from RX channel. The TX and RX interrupt happens at
+ * packet boundary, instead of DWORD boundary. The driver will not attempt to
+ * send next packet until the previous one is read by peer. Similarly, the
+ * driver will not attempt to read the data from HW until a full packet has been
+ * written to HW by peer. No polling is implemented. Data transfer is entirely
+ * interrupt driven. So, the interrupt functionality needs to work and enabled
+ * on both mgmt and user pf for mailbox driver to function properly.
+ *
+ * A TX packet is considered as time'd out after sitting in the TX channel of
+ * mailbox HW for two packet ticks (1 packet tick = 1 second, for now) without
+ * being read by peer. Currently, the driver will not try to re-transmit the
+ * packet after timeout. It just simply propagate the error to the upper layer.
+ * A retry at packet layer can be implement later, if considered as appropriate.
+ *
+ *
+ * Message layer
+ *
+ * A message is a data buffer of arbitrary length. The driver will break a
+ * message into multiple packets and transmit them to the peer, which, in turn,
+ * will assemble them into a full message before it's delivered to upper layer
+ * for further processing. One message requires at least one packet to be
+ * transferred to the peer.
+ *
+ * Each message has a unique temporary u64 ID (see communication model below
+ * for more detail). The ID shows up in each packet's header. So, at packet
+ * layer, there is no assumption that adjacent packets belong to the same
+ * message. However, for the sake of simplicity, at message layer, the driver
+ * will not attempt to send the next message until the sending of current one
+ * is finished. I.E., we implement a FIFO for message TX channel. All messages
+ * are sent by driver in the order of received from upper layer. We can
+ * implement messages of different priority later, if needed. There is no
+ * certain order for receiving messages. It's up to the peer side to decide
+ * which message gets enqueued into its own TX queue first, which will be
+ * received first on the other side.
+ *
+ * A message is considered as time'd out when it's transmit (send or receive)
+ * is not finished within 10 packet ticks. This applies to all messages queued
+ * up on both RX and TX channels. Again, no retry for a time'd out message is
+ * implemented. The error will be simply passed to upper layer. Also, a TX
+ * message may time out earlier if it's being transmitted and one of it's
+ * packets time'd out. During normal operation, timeout should never happen.
+ *
+ * The upper layer can choose to queue a message for TX or RX asynchronously
+ * when it provides a callback or wait synchronously when no callback is
+ * provided.
+ *
+ *
+ * Communication model
+ *
+ * At the highest layer, the driver implements a request-response communication
+ * model. A request may or may not require a response, but a response must match
+ * a request, or it'll be silently dropped. The driver provides a few kernel
+ * APIs for mgmt and user pf to talk to each other in this model (see kernel
+ * APIs section below for details). Each request or response is a message by
+ * itself. A request message will automatically be assigned a message ID when
+ * it's enqueued into TX channel for sending. If this request requires a
+ * response, the buffer provided by caller for receiving response will be
+ * enqueued into RX channel as well. The enqueued response message will have
+ * the same message ID as the corresponding request message. The response
+ * message, if provided, will always be enqueued before the request message is
+ * enqueued to avoid race condition.
+ *
+ * The driver will automatically enqueue a special message into the RX channel
+ * for receiving new request after initialized. This request RX message has a
+ * special message ID (id=0) and never time'd out. When a new request comes
+ * from peer, it'll be copied into request RX message then passed to the
+ * callback provided by upper layer through xocl_peer_listen() API for further
+ * processing. Currently, the driver implements only one kernel thread for RX
+ * channel and one for TX channel. So, all message callback happens in the
+ * context of that channel thread. So, the user of mailbox driver needs to be
+ * careful when it calls xocl_peer_request() synchronously in this context.
+ * You may see deadlock when both ends are trying to call xocl_peer_request()
+ * synchronously at the same time.
+ *
+ *
+ * +------------------+            +------------------+
+ * | Request/Response | <--------> | Request/Response |
+ * +------------------+            +------------------+
+ * | Message          | <--------> | Message          |
+ * +------------------+            +------------------+
+ * | Packet           | <--------> | Packet           |
+ * +------------------+            +------------------+
+ * | RX/TX Channel    | <<======>> | RX/TX Channel    |
+ * +------------------+            +------------------+
+ *   mgmt pf                         user pf
+ */
+
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/crc32c.h>
+#include <linux/random.h>
+#include "../xocl_drv.h"
+
+int mailbox_no_intr;
+module_param(mailbox_no_intr, int, (S_IRUGO|S_IWUSR));
+MODULE_PARM_DESC(mailbox_no_intr,
+	"Disable mailbox interrupt and do timer-driven msg passing");
+
+#define	PACKET_SIZE	16 /* Number of DWORD. */
+
+#define	FLAG_STI	(1 << 0)
+#define	FLAG_RTI	(1 << 1)
+
+#define	STATUS_EMPTY	(1 << 0)
+#define	STATUS_FULL	(1 << 1)
+#define	STATUS_STA	(1 << 2)
+#define	STATUS_RTA	(1 << 3)
+
+#define	MBX_ERR(mbx, fmt, arg...)	\
+	xocl_err(&mbx->mbx_pdev->dev, fmt "\n", ##arg)
+#define	MBX_INFO(mbx, fmt, arg...)	\
+	xocl_info(&mbx->mbx_pdev->dev, fmt "\n", ##arg)
+#define	MBX_DBG(mbx, fmt, arg...)	\
+	xocl_dbg(&mbx->mbx_pdev->dev, fmt "\n", ##arg)
+
+#define	MAILBOX_TIMER	HZ	/* in jiffies */
+#define	MSG_TTL		10	/* in MAILBOX_TIMER */
+#define	TEST_MSG_LEN	128
+
+#define	INVALID_MSG_ID	((u64)-1)
+#define	MSG_FLAG_RESPONSE	(1 << 0)
+#define	MSG_FLAG_REQUEST (1 << 1)
+
+#define MAX_MSG_QUEUE_SZ  (PAGE_SIZE << 16)
+#define MAX_MSG_QUEUE_LEN 5
+
+#define MB_CONN_INIT	(0x1<<0)
+#define MB_CONN_SYN	(0x1<<1)
+#define MB_CONN_ACK	(0x1<<2)
+#define MB_CONN_FIN	(0x1<<3)
+
+/*
+ * Mailbox IP register layout
+ */
+struct mailbox_reg {
+	u32			mbr_wrdata;
+	u32			mbr_resv1;
+	u32			mbr_rddata;
+	u32			mbr_resv2;
+	u32			mbr_status;
+	u32			mbr_error;
+	u32			mbr_sit;
+	u32			mbr_rit;
+	u32			mbr_is;
+	u32			mbr_ie;
+	u32			mbr_ip;
+	u32			mbr_ctrl;
+} __attribute__((packed));
+
+/*
+ * A message transport by mailbox.
+ */
+struct mailbox_msg {
+	struct list_head	mbm_list;
+	struct mailbox_channel	*mbm_ch;
+	u64			mbm_req_id;
+	char			*mbm_data;
+	size_t			mbm_len;
+	int			mbm_error;
+	struct completion	mbm_complete;
+	mailbox_msg_cb_t	mbm_cb;
+	void			*mbm_cb_arg;
+	u32			mbm_flags;
+	int			mbm_ttl;
+	bool			mbm_timer_on;
+};
+
+/*
+ * A packet transport by mailbox.
+ * When extending, only add new data structure to body. Choose to add new flag
+ * if new feature can be safely ignored by peer, other wise, add new type.
+ */
+enum packet_type {
+	PKT_INVALID = 0,
+	PKT_TEST,
+	PKT_MSG_START,
+	PKT_MSG_BODY
+};
+
+
+enum conn_state {
+	CONN_START = 0,
+	CONN_SYN_SENT,
+	CONN_SYN_RECV,
+	CONN_ESTABLISH,
+};
+
+/* Lower 8 bits for type, the rest for flags. */
+#define	PKT_TYPE_MASK		0xff
+#define	PKT_TYPE_MSG_END	(1 << 31)
+struct mailbox_pkt {
+	struct {
+		u32		type;
+		u32		payload_size;
+	} hdr;
+	union {
+		u32		data[PACKET_SIZE - 2];
+		struct {
+			u64	msg_req_id;
+			u32	msg_flags;
+			u32	msg_size;
+			u32	payload[0];
+		} msg_start;
+		struct {
+			u32	payload[0];
+		} msg_body;
+	} body;
+} __attribute__((packed));
+
+/*
+ * Mailbox communication channel.
+ */
+#define MBXCS_BIT_READY		0
+#define MBXCS_BIT_STOP		1
+#define MBXCS_BIT_TICK		2
+#define MBXCS_BIT_CHK_STALL	3
+#define MBXCS_BIT_POLL_MODE	4
+
+struct mailbox_channel;
+typedef	void (*chan_func_t)(struct mailbox_channel *ch);
+struct mailbox_channel {
+	struct mailbox		*mbc_parent;
+	char			*mbc_name;
+
+	struct workqueue_struct	*mbc_wq;
+	struct work_struct	mbc_work;
+	struct completion	mbc_worker;
+	chan_func_t		mbc_tran;
+	unsigned long		mbc_state;
+
+	struct mutex		mbc_mutex;
+	struct list_head	mbc_msgs;
+
+	struct mailbox_msg	*mbc_cur_msg;
+	int			mbc_bytes_done;
+	struct mailbox_pkt	mbc_packet;
+
+	struct timer_list	mbc_timer;
+	bool			mbc_timer_on;
+};
+
+/*
+ * The mailbox softstate.
+ */
+struct mailbox {
+	struct platform_device	*mbx_pdev;
+	struct mailbox_reg	*mbx_regs;
+	u32			mbx_irq;
+
+	struct mailbox_channel	mbx_rx;
+	struct mailbox_channel	mbx_tx;
+
+	/* For listening to peer's request. */
+	mailbox_msg_cb_t	mbx_listen_cb;
+	void			*mbx_listen_cb_arg;
+	struct workqueue_struct	*mbx_listen_wq;
+	struct work_struct	mbx_listen_worker;
+
+	int			mbx_paired;
+	/*
+	 * For testing basic intr and mailbox comm functionality via sysfs.
+	 * No locking protection, use with care.
+	 */
+	struct mailbox_pkt	mbx_tst_pkt;
+	char			mbx_tst_tx_msg[TEST_MSG_LEN];
+	char			mbx_tst_rx_msg[TEST_MSG_LEN];
+	size_t			mbx_tst_tx_msg_len;
+
+	/* Req list for all incoming request message */
+	struct completion mbx_comp;
+	struct mutex mbx_lock;
+	struct list_head mbx_req_list;
+	uint8_t mbx_req_cnt;
+	size_t mbx_req_sz;
+
+	struct mutex mbx_conn_lock;
+	uint64_t mbx_conn_id;
+	enum conn_state mbx_state;
+	bool mbx_established;
+	uint32_t mbx_prot_ver;
+
+	void *mbx_kaddr;
+};
+
+static inline const char *reg2name(struct mailbox *mbx, u32 *reg)
+{
+	static const char *reg_names[] = {
+		"wrdata",
+		"reserved1",
+		"rddata",
+		"reserved2",
+		"status",
+		"error",
+		"sit",
+		"rit",
+		"is",
+		"ie",
+		"ip",
+		"ctrl"
+	};
+
+	return reg_names[((uintptr_t)reg -
+		(uintptr_t)mbx->mbx_regs) / sizeof(u32)];
+}
+
+struct mailbox_conn {
+	uint64_t flag;
+	void *kaddr;
+	phys_addr_t paddr;
+	uint32_t crc32;
+	uint32_t ver;
+	uint64_t sec_id;
+};
+
+int mailbox_request(struct platform_device *pdev, void *req, size_t reqlen,
+		    void *resp, size_t *resplen, mailbox_msg_cb_t cb, void *cbarg);
+int mailbox_post(struct platform_device *pdev, u64 reqid, void *buf, size_t len);
+static int mailbox_connect_status(struct platform_device *pdev);
+static void connect_state_handler(struct mailbox *mbx, struct mailbox_conn *conn);
+
+static void connect_state_touch(struct mailbox *mbx, uint64_t flag)
+{
+	struct mailbox_conn conn = {0};
+	if (!mbx)
+		return;
+	conn.flag = flag;
+	connect_state_handler(mbx, &conn);
+}
+
+
+static inline u32 mailbox_reg_rd(struct mailbox *mbx, u32 *reg)
+{
+	u32 val = ioread32(reg);
+
+#ifdef	MAILBOX_REG_DEBUG
+	MBX_DBG(mbx, "REG_RD(%s)=0x%x", reg2name(mbx, reg), val);
+#endif
+	return val;
+}
+
+static inline void mailbox_reg_wr(struct mailbox *mbx, u32 *reg, u32 val)
+{
+#ifdef	MAILBOX_REG_DEBUG
+	MBX_DBG(mbx, "REG_WR(%s, 0x%x)", reg2name(mbx, reg), val);
+#endif
+	iowrite32(val, reg);
+}
+
+static inline void reset_pkt(struct mailbox_pkt *pkt)
+{
+	pkt->hdr.type = PKT_INVALID;
+}
+
+static inline bool valid_pkt(struct mailbox_pkt *pkt)
+{
+	return (pkt->hdr.type != PKT_INVALID);
+}
+
+irqreturn_t mailbox_isr(int irq, void *arg)
+{
+	struct mailbox *mbx = (struct mailbox *)arg;
+	u32 is = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_is);
+
+	while (is) {
+		MBX_DBG(mbx, "intr status: 0x%x", is);
+
+		if ((is & FLAG_STI) != 0) {
+			/* A packet has been sent successfully. */
+			complete(&mbx->mbx_tx.mbc_worker);
+		}
+		if ((is & FLAG_RTI) != 0) {
+			/* A packet is waiting to be received from mailbox. */
+			complete(&mbx->mbx_rx.mbc_worker);
+		}
+		/* Anything else is not expected. */
+		if ((is & (FLAG_STI | FLAG_RTI)) == 0) {
+			MBX_ERR(mbx, "spurious mailbox irq %d, is=0x%x",
+				irq, is);
+		}
+
+		/* Clear intr state for receiving next one. */
+		mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_is, is);
+
+		is = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_is);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void chan_timer(struct timer_list *t)
+{
+	struct mailbox_channel *ch = from_timer(ch, t, mbc_timer);
+
+	MBX_DBG(ch->mbc_parent, "%s tick", ch->mbc_name);
+
+	set_bit(MBXCS_BIT_TICK, &ch->mbc_state);
+	complete(&ch->mbc_worker);
+
+	/* We're a periodic timer. */
+	mod_timer(&ch->mbc_timer, jiffies + MAILBOX_TIMER);
+}
+
+static void chan_config_timer(struct mailbox_channel *ch)
+{
+	struct list_head *pos, *n;
+	struct mailbox_msg *msg = NULL;
+	bool on = false;
+
+	mutex_lock(&ch->mbc_mutex);
+
+	if (test_bit(MBXCS_BIT_POLL_MODE, &ch->mbc_state)) {
+		on = true;
+	} else {
+		list_for_each_safe(pos, n, &ch->mbc_msgs) {
+			msg = list_entry(pos, struct mailbox_msg, mbm_list);
+			if (msg->mbm_req_id == 0)
+			       continue;
+			on = true;
+			break;
+		}
+	}
+
+	if (on != ch->mbc_timer_on) {
+		ch->mbc_timer_on = on;
+		if (on)
+			mod_timer(&ch->mbc_timer, jiffies + MAILBOX_TIMER);
+		else
+			del_timer_sync(&ch->mbc_timer);
+	}
+
+	mutex_unlock(&ch->mbc_mutex);
+}
+
+static void free_msg(struct mailbox_msg *msg)
+{
+	vfree(msg);
+}
+
+static void msg_done(struct mailbox_msg *msg, int err)
+{
+	struct mailbox_channel *ch = msg->mbm_ch;
+	struct mailbox *mbx = ch->mbc_parent;
+
+	MBX_DBG(ch->mbc_parent, "%s finishing msg id=0x%llx err=%d",
+		ch->mbc_name, msg->mbm_req_id, err);
+
+	msg->mbm_error = err;
+	if (msg->mbm_cb) {
+		msg->mbm_cb(msg->mbm_cb_arg, msg->mbm_data, msg->mbm_len,
+			msg->mbm_req_id, msg->mbm_error);
+		free_msg(msg);
+	} else {
+		if (msg->mbm_flags & MSG_FLAG_REQUEST) {
+			if ((mbx->mbx_req_sz+msg->mbm_len) >= MAX_MSG_QUEUE_SZ ||
+				  mbx->mbx_req_cnt >= MAX_MSG_QUEUE_LEN) {
+				goto done;
+			}
+			mutex_lock(&ch->mbc_parent->mbx_lock);
+			list_add_tail(&msg->mbm_list, &ch->mbc_parent->mbx_req_list);
+			mbx->mbx_req_cnt++;
+			mbx->mbx_req_sz += msg->mbm_len;
+			mutex_unlock(&ch->mbc_parent->mbx_lock);
+
+			complete(&ch->mbc_parent->mbx_comp);
+		} else {
+			complete(&msg->mbm_complete);
+		}
+	}
+done:
+	chan_config_timer(ch);
+}
+
+static void chan_msg_done(struct mailbox_channel *ch, int err)
+{
+	if (!ch->mbc_cur_msg)
+		return;
+
+	msg_done(ch->mbc_cur_msg, err);
+	ch->mbc_cur_msg = NULL;
+	ch->mbc_bytes_done = 0;
+}
+
+void timeout_msg(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_msg *msg = NULL;
+	struct list_head *pos, *n;
+	struct list_head l = LIST_HEAD_INIT(l);
+	bool reschedule = false;
+
+	/* Check active msg first. */
+	msg = ch->mbc_cur_msg;
+	if (msg) {
+
+		if (msg->mbm_ttl == 0) {
+			MBX_ERR(mbx, "found active msg time'd out");
+			chan_msg_done(ch, -ETIME);
+		} else {
+			if (msg->mbm_timer_on) {
+				msg->mbm_ttl--;
+				/* Need to come back again for this one. */
+				reschedule = true;
+			}
+		}
+	}
+
+	mutex_lock(&ch->mbc_mutex);
+
+	list_for_each_safe(pos, n, &ch->mbc_msgs) {
+		msg = list_entry(pos, struct mailbox_msg, mbm_list);
+		if (!msg->mbm_timer_on)
+			continue;
+		if (msg->mbm_req_id == 0)
+		       continue;
+		if (msg->mbm_ttl == 0) {
+			list_del(&msg->mbm_list);
+			list_add_tail(&msg->mbm_list, &l);
+		} else {
+			msg->mbm_ttl--;
+			/* Need to come back again for this one. */
+			reschedule = true;
+		}
+	}
+
+	mutex_unlock(&ch->mbc_mutex);
+
+	if (!list_empty(&l))
+		MBX_ERR(mbx, "found waiting msg time'd out");
+
+	list_for_each_safe(pos, n, &l) {
+		msg = list_entry(pos, struct mailbox_msg, mbm_list);
+		list_del(&msg->mbm_list);
+		msg_done(msg, -ETIME);
+	}
+}
+
+static void chann_worker(struct work_struct *work)
+{
+	struct mailbox_channel *ch =
+		container_of(work, struct mailbox_channel, mbc_work);
+	struct mailbox *mbx = ch->mbc_parent;
+
+	while (!test_bit(MBXCS_BIT_STOP, &ch->mbc_state)) {
+		MBX_DBG(mbx, "%s worker start", ch->mbc_name);
+		ch->mbc_tran(ch);
+		wait_for_completion_interruptible(&ch->mbc_worker);
+	}
+}
+
+static inline u32 mailbox_chk_err(struct mailbox *mbx)
+{
+	u32 val = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_error);
+
+	/* Ignore bad register value after firewall is tripped. */
+	if (val == 0xffffffff)
+		val = 0;
+
+	/* Error should not be seen, shout when found. */
+	if (val)
+		MBX_ERR(mbx, "mailbox error detected, error=0x%x\n", val);
+	return val;
+}
+
+static int chan_msg_enqueue(struct mailbox_channel *ch, struct mailbox_msg *msg)
+{
+	int rv = 0;
+
+	MBX_DBG(ch->mbc_parent, "%s enqueuing msg, id=0x%llx\n",
+		ch->mbc_name, msg->mbm_req_id);
+
+	BUG_ON(msg->mbm_req_id == INVALID_MSG_ID);
+
+	mutex_lock(&ch->mbc_mutex);
+	if (test_bit(MBXCS_BIT_STOP, &ch->mbc_state)) {
+		rv = -ESHUTDOWN;
+	} else {
+		list_add_tail(&msg->mbm_list, &ch->mbc_msgs);
+		msg->mbm_ch = ch;
+//		msg->mbm_ttl = MSG_TTL;
+	}
+	mutex_unlock(&ch->mbc_mutex);
+
+	chan_config_timer(ch);
+
+	return rv;
+}
+
+static struct mailbox_msg *chan_msg_dequeue(struct mailbox_channel *ch,
+	u64 req_id)
+{
+	struct mailbox_msg *msg = NULL;
+	struct list_head *pos;
+
+	mutex_lock(&ch->mbc_mutex);
+
+	/* Take the first msg. */
+	if (req_id == INVALID_MSG_ID) {
+		msg = list_first_entry_or_null(&ch->mbc_msgs,
+			struct mailbox_msg, mbm_list);
+	/* Take the msg w/ specified ID. */
+	} else {
+		list_for_each(pos, &ch->mbc_msgs) {
+			msg = list_entry(pos, struct mailbox_msg, mbm_list);
+			if (msg->mbm_req_id == req_id)
+				break;
+		}
+	}
+
+	if (msg) {
+		MBX_DBG(ch->mbc_parent, "%s dequeued msg, id=0x%llx\n",
+			ch->mbc_name, msg->mbm_req_id);
+		list_del(&msg->mbm_list);
+	}
+
+	mutex_unlock(&ch->mbc_mutex);
+
+	return msg;
+}
+
+static struct mailbox_msg *alloc_msg(void *buf, size_t len)
+{
+	char *newbuf = NULL;
+	struct mailbox_msg *msg = NULL;
+	/* Give MB*2 secs as time to live */
+	int calculated_ttl = (len >> 19) < MSG_TTL ? MSG_TTL : (len >> 19);
+
+	if (!buf) {
+		msg = vzalloc(sizeof(struct mailbox_msg) + len);
+		if (!msg)
+			return NULL;
+		newbuf = ((char *)msg) + sizeof(struct mailbox_msg);
+	} else {
+		msg = vzalloc(sizeof(struct mailbox_msg));
+		if (!msg)
+			return NULL;
+		newbuf = buf;
+	}
+
+	INIT_LIST_HEAD(&msg->mbm_list);
+	msg->mbm_data = newbuf;
+	msg->mbm_len = len;
+	msg->mbm_ttl = calculated_ttl;
+	msg->mbm_timer_on = false;
+	init_completion(&msg->mbm_complete);
+
+	return msg;
+}
+
+static int chan_init(struct mailbox *mbx, char *nm,
+	struct mailbox_channel *ch, chan_func_t fn)
+{
+	ch->mbc_parent = mbx;
+	ch->mbc_name = nm;
+	ch->mbc_tran = fn;
+	INIT_LIST_HEAD(&ch->mbc_msgs);
+	init_completion(&ch->mbc_worker);
+	mutex_init(&ch->mbc_mutex);
+
+	ch->mbc_cur_msg = NULL;
+	ch->mbc_bytes_done = 0;
+
+	reset_pkt(&ch->mbc_packet);
+	set_bit(MBXCS_BIT_READY, &ch->mbc_state);
+
+	/* One thread for one channel. */
+	ch->mbc_wq =
+		create_singlethread_workqueue(dev_name(&mbx->mbx_pdev->dev));
+	if (!ch->mbc_wq) {
+		ch->mbc_parent = NULL;
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&ch->mbc_work, chann_worker);
+	queue_work(ch->mbc_wq, &ch->mbc_work);
+
+	/* One timer for one channel. */
+	timer_setup(&ch->mbc_timer, chan_timer, 0);
+
+	return 0;
+}
+
+static void chan_fini(struct mailbox_channel *ch)
+{
+	struct mailbox_msg *msg;
+
+	if (!ch->mbc_parent)
+		return;
+
+	/*
+	 * Holding mutex to ensure no new msg is enqueued after
+	 * flag is set.
+	 */
+	mutex_lock(&ch->mbc_mutex);
+	set_bit(MBXCS_BIT_STOP, &ch->mbc_state);
+	mutex_unlock(&ch->mbc_mutex);
+
+	complete(&ch->mbc_worker);
+	cancel_work_sync(&ch->mbc_work);
+	destroy_workqueue(ch->mbc_wq);
+
+	msg = ch->mbc_cur_msg;
+	if (msg)
+		chan_msg_done(ch, -ESHUTDOWN);
+
+	while ((msg = chan_msg_dequeue(ch, INVALID_MSG_ID)) != NULL)
+		msg_done(msg, -ESHUTDOWN);
+
+	del_timer_sync(&ch->mbc_timer);
+}
+
+static void listen_wq_fini(struct mailbox *mbx)
+{
+	BUG_ON(mbx == NULL);
+
+	if (mbx->mbx_listen_wq != NULL) {
+		complete(&mbx->mbx_comp);
+		cancel_work_sync(&mbx->mbx_listen_worker);
+		destroy_workqueue(mbx->mbx_listen_wq);
+	}
+
+}
+
+static void chan_recv_pkt(struct mailbox_channel *ch)
+{
+	int i, retry = 10;
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+
+	BUG_ON(valid_pkt(pkt));
+
+	/* Picking up a packet from HW. */
+	for (i = 0; i < PACKET_SIZE; i++) {
+		while ((mailbox_reg_rd(mbx,
+			&mbx->mbx_regs->mbr_status) & STATUS_EMPTY) &&
+			(retry-- > 0))
+			msleep(100);
+
+		*(((u32 *)pkt) + i) =
+			mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_rddata);
+	}
+
+	if ((mailbox_chk_err(mbx) & STATUS_EMPTY) != 0)
+		reset_pkt(pkt);
+	else
+		MBX_DBG(mbx, "received pkt: type=0x%x", pkt->hdr.type);
+}
+
+static void chan_send_pkt(struct mailbox_channel *ch)
+{
+	int i;
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+
+	BUG_ON(!valid_pkt(pkt));
+
+	MBX_DBG(mbx, "sending pkt: type=0x%x", pkt->hdr.type);
+
+	/* Pushing a packet into HW. */
+	for (i = 0; i < PACKET_SIZE; i++) {
+		mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_wrdata,
+			*(((u32 *)pkt) + i));
+	}
+
+	reset_pkt(pkt);
+	if (ch->mbc_cur_msg)
+		ch->mbc_bytes_done += ch->mbc_packet.hdr.payload_size;
+
+	BUG_ON((mailbox_chk_err(mbx) & STATUS_FULL) != 0);
+}
+
+static int chan_pkt2msg(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	void *msg_data, *pkt_data;
+	struct mailbox_msg *msg = ch->mbc_cur_msg;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+	size_t cnt = pkt->hdr.payload_size;
+	u32 type = (pkt->hdr.type & PKT_TYPE_MASK);
+
+	BUG_ON(((type != PKT_MSG_START) && (type != PKT_MSG_BODY)) || !msg);
+
+	if (type == PKT_MSG_START) {
+		msg->mbm_req_id = pkt->body.msg_start.msg_req_id;
+		BUG_ON(msg->mbm_len < pkt->body.msg_start.msg_size);
+		msg->mbm_len = pkt->body.msg_start.msg_size;
+		pkt_data = pkt->body.msg_start.payload;
+	} else {
+		pkt_data = pkt->body.msg_body.payload;
+	}
+
+	if (cnt > msg->mbm_len - ch->mbc_bytes_done) {
+		MBX_ERR(mbx, "invalid mailbox packet size\n");
+		return -EBADMSG;
+	}
+
+	msg_data = msg->mbm_data + ch->mbc_bytes_done;
+	(void) memcpy(msg_data, pkt_data, cnt);
+	ch->mbc_bytes_done += cnt;
+
+	reset_pkt(pkt);
+	return 0;
+}
+
+/*
+ * Worker for RX channel.
+ */
+static void chan_do_rx(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+	struct mailbox_msg *msg = NULL;
+	bool needs_read = false;
+	u64 id = 0;
+	bool eom;
+	int err;
+	u32 type;
+	u32 st = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_status);
+
+	/* Check if a packet is ready for reading. */
+	if (st == 0xffffffff) {
+		/* Device is still being reset. */
+		needs_read = false;
+	} else if (test_bit(MBXCS_BIT_POLL_MODE, &ch->mbc_state)) {
+		needs_read = ((st & STATUS_EMPTY) == 0);
+	} else {
+		needs_read = ((st & STATUS_RTA) != 0);
+	}
+
+	if (needs_read) {
+		chan_recv_pkt(ch);
+		type = pkt->hdr.type & PKT_TYPE_MASK;
+		eom = ((pkt->hdr.type & PKT_TYPE_MSG_END) != 0);
+
+		switch (type) {
+		case PKT_TEST:
+			(void) memcpy(&mbx->mbx_tst_pkt, &ch->mbc_packet,
+				sizeof(struct mailbox_pkt));
+			reset_pkt(pkt);
+			return;
+		case PKT_MSG_START:
+			if (ch->mbc_cur_msg) {
+				MBX_ERR(mbx, "received partial msg\n");
+				chan_msg_done(ch, -EBADMSG);
+			}
+
+			/* Get a new active msg. */
+			id = 0;
+			if (pkt->body.msg_start.msg_flags & MSG_FLAG_RESPONSE)
+				id = pkt->body.msg_start.msg_req_id;
+			ch->mbc_cur_msg = chan_msg_dequeue(ch, id);
+
+			if (!ch->mbc_cur_msg) {
+				//no msg, alloc dynamically
+				msg = alloc_msg(NULL, pkt->body.msg_start.msg_size);
+
+				msg->mbm_ch = ch;
+				msg->mbm_flags |= MSG_FLAG_REQUEST;
+				ch->mbc_cur_msg = msg;
+
+			}	else if (pkt->body.msg_start.msg_size >
+				ch->mbc_cur_msg->mbm_len) {
+				chan_msg_done(ch, -EMSGSIZE);
+				MBX_ERR(mbx, "received msg is too big");
+				reset_pkt(pkt);
+			}
+			break;
+		case PKT_MSG_BODY:
+			if (!ch->mbc_cur_msg) {
+				MBX_ERR(mbx, "got unexpected msg body pkt\n");
+				reset_pkt(pkt);
+			}
+			break;
+		default:
+			MBX_ERR(mbx, "invalid mailbox pkt type\n");
+			reset_pkt(pkt);
+			return;
+		}
+
+		if (valid_pkt(pkt)) {
+			err = chan_pkt2msg(ch);
+			if (err || eom)
+				chan_msg_done(ch, err);
+		}
+	}
+
+	/* Handle timer event. */
+	if (test_bit(MBXCS_BIT_TICK, &ch->mbc_state)) {
+		timeout_msg(ch);
+		clear_bit(MBXCS_BIT_TICK, &ch->mbc_state);
+	}
+}
+
+static void chan_msg2pkt(struct mailbox_channel *ch)
+{
+	size_t cnt = 0;
+	size_t payload_off = 0;
+	void *msg_data, *pkt_data;
+	struct mailbox_msg *msg = ch->mbc_cur_msg;
+	struct mailbox_pkt *pkt = &ch->mbc_packet;
+	bool is_start = (ch->mbc_bytes_done == 0);
+	bool is_eom = false;
+
+	if (is_start) {
+		payload_off = offsetof(struct mailbox_pkt,
+			body.msg_start.payload);
+	} else {
+		payload_off = offsetof(struct mailbox_pkt,
+			body.msg_body.payload);
+	}
+	cnt = PACKET_SIZE * sizeof(u32) - payload_off;
+	if (cnt >= msg->mbm_len - ch->mbc_bytes_done) {
+		cnt = msg->mbm_len - ch->mbc_bytes_done;
+		is_eom = true;
+	}
+
+	pkt->hdr.type = is_start ? PKT_MSG_START : PKT_MSG_BODY;
+	pkt->hdr.type |= is_eom ? PKT_TYPE_MSG_END : 0;
+	pkt->hdr.payload_size = cnt;
+
+	if (is_start) {
+		pkt->body.msg_start.msg_req_id = msg->mbm_req_id;
+		pkt->body.msg_start.msg_size = msg->mbm_len;
+		pkt->body.msg_start.msg_flags = msg->mbm_flags;
+		pkt_data = pkt->body.msg_start.payload;
+	} else {
+		pkt_data = pkt->body.msg_body.payload;
+	}
+	msg_data = msg->mbm_data + ch->mbc_bytes_done;
+	(void) memcpy(pkt_data, msg_data, cnt);
+}
+
+static void check_tx_stall(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	struct mailbox_msg *msg = ch->mbc_cur_msg;
+
+	/*
+	 * No stall checking in polling mode. Don't know how often peer will
+	 * check the channel.
+	 */
+	if ((msg == NULL) || test_bit(MBXCS_BIT_POLL_MODE, &ch->mbc_state))
+		return;
+
+	/*
+	 * No tx intr has come since last check.
+	 * The TX channel is stalled, reset it.
+	 */
+	if (test_bit(MBXCS_BIT_CHK_STALL, &ch->mbc_state)) {
+		MBX_ERR(mbx, "TX channel stall detected, reset...\n");
+		mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_ctrl, 0x1);
+		chan_msg_done(ch, -ETIME);
+		connect_state_touch(mbx, MB_CONN_FIN);
+	/* Mark it for next check. */
+	} else {
+		set_bit(MBXCS_BIT_CHK_STALL, &ch->mbc_state);
+	}
+}
+
+
+
+static void rx_enqueued_msg_timer_on(struct mailbox *mbx, uint64_t req_id)
+{
+	struct list_head *pos, *n;
+	struct mailbox_msg *msg = NULL;
+	struct mailbox_channel *ch = NULL;
+	ch = &mbx->mbx_rx;
+	MBX_DBG(mbx, "try to set ch rx, req_id %llu\n", req_id);
+	mutex_lock(&ch->mbc_mutex);
+
+	list_for_each_safe(pos, n, &ch->mbc_msgs) {
+		msg = list_entry(pos, struct mailbox_msg, mbm_list);
+		if (msg->mbm_req_id == req_id) {
+			msg->mbm_timer_on = true;
+			MBX_DBG(mbx, "set ch rx, req_id %llu\n", req_id);
+			break;
+		}
+	}
+
+	mutex_unlock(&ch->mbc_mutex);
+
+}
+
+/*
+ * Worker for TX channel.
+ */
+static void chan_do_tx(struct mailbox_channel *ch)
+{
+	struct mailbox *mbx = ch->mbc_parent;
+	u32 st = mailbox_reg_rd(mbx, &mbx->mbx_regs->mbr_status);
+
+	/* Check if a packet has been read by peer. */
+	if ((st != 0xffffffff) && ((st & STATUS_STA) != 0)) {
+		clear_bit(MBXCS_BIT_CHK_STALL, &ch->mbc_state);
+
+		/*
+		 * The mailbox is free for sending new pkt now. See if we
+		 * have something to send.
+		 */
+
+		/* Finished sending a whole msg, call it done. */
+		if (ch->mbc_cur_msg &&
+			(ch->mbc_cur_msg->mbm_len == ch->mbc_bytes_done)) {
+			rx_enqueued_msg_timer_on(mbx, ch->mbc_cur_msg->mbm_req_id);
+			chan_msg_done(ch, 0);
+		}
+
+		if (!ch->mbc_cur_msg) {
+			ch->mbc_cur_msg = chan_msg_dequeue(ch, INVALID_MSG_ID);
+			if (ch->mbc_cur_msg)
+				ch->mbc_cur_msg->mbm_timer_on = true;
+		}
+
+		if (ch->mbc_cur_msg) {
+			chan_msg2pkt(ch);
+		} else if (valid_pkt(&mbx->mbx_tst_pkt)) {
+			(void) memcpy(&ch->mbc_packet, &mbx->mbx_tst_pkt,
+				sizeof(struct mailbox_pkt));
+			reset_pkt(&mbx->mbx_tst_pkt);
+		} else {
+			return; /* Nothing to send. */
+		}
+
+		chan_send_pkt(ch);
+	}
+
+	/* Handle timer event. */
+	if (test_bit(MBXCS_BIT_TICK, &ch->mbc_state)) {
+		timeout_msg(ch);
+		check_tx_stall(ch);
+		clear_bit(MBXCS_BIT_TICK, &ch->mbc_state);
+	}
+}
+
+static int mailbox_connect_status(struct platform_device *pdev)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	int ret = 0;
+	mutex_lock(&mbx->mbx_lock);
+	ret = mbx->mbx_paired;
+	mutex_unlock(&mbx->mbx_lock);
+	return ret;
+}
+
+static ssize_t mailbox_ctl_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	u32 *reg = (u32 *)mbx->mbx_regs;
+	int r, n;
+	int nreg = sizeof (struct mailbox_reg) / sizeof (u32);
+
+	for (r = 0, n = 0; r < nreg; r++, reg++) {
+		/* Non-status registers. */
+		if ((reg == &mbx->mbx_regs->mbr_resv1)		||
+			(reg == &mbx->mbx_regs->mbr_wrdata)	||
+			(reg == &mbx->mbx_regs->mbr_rddata)	||
+			(reg == &mbx->mbx_regs->mbr_resv2))
+			continue;
+		/* Write-only status register. */
+		if (reg == &mbx->mbx_regs->mbr_ctrl) {
+			n += sprintf(buf + n, "%02ld %10s = --\n",
+				r * sizeof (u32), reg2name(mbx, reg));
+		/* Read-able status register. */
+		} else {
+			n += sprintf(buf + n, "%02ld %10s = 0x%08x\n",
+				r * sizeof (u32), reg2name(mbx, reg),
+				mailbox_reg_rd(mbx, reg));
+		}
+	}
+
+	return n;
+}
+
+static ssize_t mailbox_ctl_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	u32 off, val;
+	int nreg = sizeof (struct mailbox_reg) / sizeof (u32);
+	u32 *reg = (u32 *)mbx->mbx_regs;
+
+	if (sscanf(buf, "%d:%d", &off, &val) != 2 || (off % sizeof (u32)) ||
+		!(off >= 0 && off < nreg * sizeof (u32))) {
+		MBX_ERR(mbx, "input should be <reg_offset:reg_val>");
+		return -EINVAL;
+	}
+	reg += off / sizeof (u32);
+
+	mailbox_reg_wr(mbx, reg, val);
+	return count;
+}
+/* HW register level debugging i/f. */
+static DEVICE_ATTR_RW(mailbox_ctl);
+
+static ssize_t mailbox_pkt_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (valid_pkt(&mbx->mbx_tst_pkt)) {
+		(void) memcpy(buf, mbx->mbx_tst_pkt.body.data,
+			mbx->mbx_tst_pkt.hdr.payload_size);
+		ret = mbx->mbx_tst_pkt.hdr.payload_size;
+	}
+
+	return ret;
+}
+
+static ssize_t mailbox_pkt_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	size_t maxlen = sizeof (mbx->mbx_tst_pkt.body.data);
+
+	if (count > maxlen) {
+		MBX_ERR(mbx, "max input length is %ld", maxlen);
+		return 0;
+	}
+
+	(void) memcpy(mbx->mbx_tst_pkt.body.data, buf, count);
+	mbx->mbx_tst_pkt.hdr.payload_size = count;
+	mbx->mbx_tst_pkt.hdr.type = PKT_TEST;
+	complete(&mbx->mbx_tx.mbc_worker);
+	return count;
+}
+
+/* Packet test i/f. */
+static DEVICE_ATTR_RW(mailbox_pkt);
+
+static ssize_t mailbox_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_req req;
+	size_t respsz = sizeof (mbx->mbx_tst_rx_msg);
+	int ret = 0;
+
+	req.req = MAILBOX_REQ_TEST_READ;
+	ret = mailbox_request(to_platform_device(dev), &req, sizeof (req),
+		mbx->mbx_tst_rx_msg, &respsz, NULL, NULL);
+	if (ret) {
+		MBX_ERR(mbx, "failed to read test msg from peer: %d", ret);
+	} else if (respsz > 0) {
+		(void) memcpy(buf, mbx->mbx_tst_rx_msg, respsz);
+		ret = respsz;
+	}
+
+	return ret;
+}
+
+static ssize_t mailbox_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	size_t maxlen = sizeof (mbx->mbx_tst_tx_msg);
+	struct mailbox_req req = { 0 };
+
+	if (count > maxlen) {
+		MBX_ERR(mbx, "max input length is %ld", maxlen);
+		return 0;
+	}
+
+	(void) memcpy(mbx->mbx_tst_tx_msg, buf, count);
+	mbx->mbx_tst_tx_msg_len = count;
+	req.req = MAILBOX_REQ_TEST_READY;
+	(void) mailbox_post(mbx->mbx_pdev, 0, &req, sizeof (req));
+
+	return count;
+}
+
+/* Msg test i/f. */
+static DEVICE_ATTR_RW(mailbox);
+
+static ssize_t connection_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
+	ret = mailbox_connect_status(pdev);
+	return sprintf(buf, "0x%x\n", ret);
+}
+static DEVICE_ATTR_RO(connection);
+
+
+static struct attribute *mailbox_attrs[] = {
+	&dev_attr_mailbox.attr,
+	&dev_attr_mailbox_ctl.attr,
+	&dev_attr_mailbox_pkt.attr,
+	&dev_attr_connection.attr,
+	NULL,
+};
+
+static const struct attribute_group mailbox_attrgroup = {
+	.attrs = mailbox_attrs,
+};
+
+static void dft_req_msg_cb(void *arg, void *data, size_t len, u64 id, int err)
+{
+	struct mailbox_msg *respmsg;
+	struct mailbox_msg *reqmsg = (struct mailbox_msg *)arg;
+	struct mailbox *mbx = reqmsg->mbm_ch->mbc_parent;
+
+	/*
+	 * Can't send out request msg.
+	 * Removing corresponding response msg from queue and return error.
+	 */
+	if (err) {
+		respmsg = chan_msg_dequeue(&mbx->mbx_rx, reqmsg->mbm_req_id);
+		if (respmsg)
+			msg_done(respmsg, err);
+	}
+}
+
+static void dft_post_msg_cb(void *arg, void *buf, size_t len, u64 id, int err)
+{
+	struct mailbox_msg *msg = (struct mailbox_msg *)arg;
+
+	if (err) {
+		MBX_ERR(msg->mbm_ch->mbc_parent,
+			"failed to post msg, err=%d", err);
+	}
+}
+
+/*
+ * Msg will be sent to peer and reply will be received.
+ */
+int mailbox_request(struct platform_device *pdev, void *req, size_t reqlen,
+	void *resp, size_t *resplen, mailbox_msg_cb_t cb, void *cbarg)
+{
+	int rv = -ENOMEM;
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_msg *reqmsg = NULL, *respmsg = NULL;
+
+	MBX_INFO(mbx, "sending request: %d", ((struct mailbox_req *)req)->req);
+
+	if (cb) {
+		reqmsg = alloc_msg(NULL, reqlen);
+		if (reqmsg)
+			(void) memcpy(reqmsg->mbm_data, req, reqlen);
+	} else {
+		reqmsg = alloc_msg(req, reqlen);
+	}
+	if (!reqmsg)
+		goto fail;
+	reqmsg->mbm_cb = dft_req_msg_cb;
+	reqmsg->mbm_cb_arg = reqmsg;
+	reqmsg->mbm_req_id = (uintptr_t)reqmsg->mbm_data;
+
+	respmsg = alloc_msg(resp, *resplen);
+	if (!respmsg)
+		goto fail;
+	respmsg->mbm_cb = cb;
+	respmsg->mbm_cb_arg = cbarg;
+	/* Only interested in response w/ same ID. */
+	respmsg->mbm_req_id = reqmsg->mbm_req_id;
+
+	/* Always enqueue RX msg before TX one to avoid race. */
+	rv = chan_msg_enqueue(&mbx->mbx_rx, respmsg);
+	if (rv)
+		goto fail;
+	rv = chan_msg_enqueue(&mbx->mbx_tx, reqmsg);
+	if (rv) {
+		respmsg = chan_msg_dequeue(&mbx->mbx_rx, reqmsg->mbm_req_id);
+		goto fail;
+	}
+
+	/* Kick TX channel to try to send out msg. */
+	complete(&mbx->mbx_tx.mbc_worker);
+
+	if (cb)
+		return 0;
+
+	wait_for_completion(&respmsg->mbm_complete);
+	rv = respmsg->mbm_error;
+	if (rv == 0)
+		*resplen = respmsg->mbm_len;
+
+	free_msg(respmsg);
+	return rv;
+
+fail:
+	if (reqmsg)
+		free_msg(reqmsg);
+	if (respmsg)
+		free_msg(respmsg);
+	return rv;
+}
+
+/*
+ * Msg will be posted, no wait for reply.
+ */
+int mailbox_post(struct platform_device *pdev, u64 reqid, void *buf, size_t len)
+{
+	int rv = 0;
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_msg *msg = alloc_msg(NULL, len);
+
+	if (reqid == 0) {
+		MBX_DBG(mbx, "posting request: %d",
+			((struct mailbox_req *)buf)->req);
+	} else {
+		MBX_DBG(mbx, "posting response...");
+	}
+
+	if (!msg)
+		return -ENOMEM;
+
+	(void) memcpy(msg->mbm_data, buf, len);
+	msg->mbm_cb = dft_post_msg_cb;
+	msg->mbm_cb_arg = msg;
+	if (reqid) {
+		msg->mbm_req_id = reqid;
+		msg->mbm_flags |= MSG_FLAG_RESPONSE;
+	} else {
+		msg->mbm_req_id = (uintptr_t)msg->mbm_data;
+	}
+
+	rv = chan_msg_enqueue(&mbx->mbx_tx, msg);
+	if (rv)
+		free_msg(msg);
+
+	/* Kick TX channel to try to send out msg. */
+	complete(&mbx->mbx_tx.mbc_worker);
+
+	return rv;
+}
+/*
+ *   should not be called by other than connect_state_handler
+ */
+static int mailbox_connection_notify(struct platform_device *pdev, uint64_t sec_id, uint64_t flag)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	struct mailbox_req *mb_req = NULL;
+	struct mailbox_conn mb_conn = { 0 };
+	int  ret = 0;
+	size_t data_len = 0, reqlen = 0;
+	data_len = sizeof(struct mailbox_conn);
+	reqlen = sizeof(struct mailbox_req) + data_len;
+
+	mb_req = (struct mailbox_req *)vmalloc(reqlen);
+	if (!mb_req) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	mb_req->req = MAILBOX_REQ_CONN_EXPL;
+	if (!mbx->mbx_kaddr) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	mb_conn.kaddr = mbx->mbx_kaddr;
+	mb_conn.paddr = virt_to_phys(mbx->mbx_kaddr);
+	mb_conn.crc32 = crc32c_le(~0, mbx->mbx_kaddr, PAGE_SIZE);
+	mb_conn.flag = flag;
+	mb_conn.ver = mbx->mbx_prot_ver;
+
+	if (sec_id != 0) {
+		mb_conn.sec_id = sec_id;
+	} else {
+		mb_conn.sec_id = (uint64_t)mbx->mbx_kaddr;
+		mbx->mbx_conn_id = (uint64_t)mbx->mbx_kaddr;
+	}
+
+	memcpy(mb_req->data, &mb_conn, data_len);
+
+	ret = mailbox_post(pdev, 0, mb_req, reqlen);
+
+done:
+	vfree(mb_req);
+	return ret;
+}
+
+static int mailbox_connection_explore(struct platform_device *pdev, struct mailbox_conn *mb_conn)
+{
+	int ret = 0;
+	uint32_t crc_chk;
+	phys_addr_t paddr;
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	if (!mb_conn) {
+		ret = -EFAULT;
+		goto done;
+	}
+
+	paddr = virt_to_phys(mb_conn->kaddr);
+	if (paddr != mb_conn->paddr) {
+		MBX_INFO(mbx, "mb_conn->paddr %llx paddr: %llx\n", mb_conn->paddr, paddr);
+		MBX_INFO(mbx, "Failed to get the same physical addr, running in VMs?\n");
+		ret = -EFAULT;
+		goto done;
+	}
+	crc_chk = crc32c_le(~0, mb_conn->kaddr, PAGE_SIZE);
+
+	if (crc_chk != mb_conn->crc32) {
+		MBX_INFO(mbx, "crc32  : %x, %x\n",  mb_conn->crc32, crc_chk);
+		MBX_INFO(mbx, "failed to get the same CRC\n");
+		ret = -EFAULT;
+		goto done;
+	}
+done:
+	return ret;
+}
+
+static int mailbox_get_data(struct platform_device *pdev, enum data_kind kind)
+{
+	int ret = 0;
+	switch (kind) {
+	case PEER_CONN:
+		ret = mailbox_connect_status(pdev);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+
+static void connect_state_handler(struct mailbox *mbx, struct mailbox_conn *conn)
+{
+		int ret = 0;
+
+		if (!mbx || !conn)
+			return;
+
+		mutex_lock(&mbx->mbx_lock);
+
+		switch (conn->flag) {
+		case MB_CONN_INIT:
+			/* clean up all cached data, */
+			mbx->mbx_paired = 0;
+			mbx->mbx_established = false;
+			kfree(mbx->mbx_kaddr);
+
+			mbx->mbx_kaddr = kzalloc(PAGE_SIZE, GFP_KERNEL);
+			get_random_bytes(mbx->mbx_kaddr, PAGE_SIZE);
+			ret = mailbox_connection_notify(mbx->mbx_pdev, 0, MB_CONN_SYN);
+			if (ret)
+				goto done;
+			mbx->mbx_state = CONN_SYN_SENT;
+			break;
+		case MB_CONN_SYN:
+			if (mbx->mbx_state == CONN_SYN_SENT) {
+				if (!mailbox_connection_explore(mbx->mbx_pdev, conn)) {
+					mbx->mbx_paired |= 0x2;
+					MBX_INFO(mbx, "mailbox mbx_prot_ver %x", mbx->mbx_prot_ver);
+				}
+				ret = mailbox_connection_notify(mbx->mbx_pdev, conn->sec_id, MB_CONN_ACK);
+				if (ret)
+					goto done;
+				mbx->mbx_state = CONN_SYN_RECV;
+			} else
+				mbx->mbx_state = CONN_START;
+			break;
+		case MB_CONN_ACK:
+			if (mbx->mbx_state & (CONN_SYN_SENT | CONN_SYN_RECV)) {
+				if (mbx->mbx_conn_id == (uint64_t)conn->sec_id) {
+					mbx->mbx_paired |= 0x1;
+					mbx->mbx_established = true;
+					mbx->mbx_state = CONN_ESTABLISH;
+					kfree(mbx->mbx_kaddr);
+					mbx->mbx_kaddr = NULL;
+				} else
+					mbx->mbx_state = CONN_START;
+			}
+			break;
+		case MB_CONN_FIN:
+			mbx->mbx_paired = 0;
+			mbx->mbx_established = false;
+			kfree(mbx->mbx_kaddr);
+			mbx->mbx_kaddr = NULL;
+			mbx->mbx_state = CONN_START;
+			break;
+		default:
+			break;
+		}
+done:
+	if (ret) {
+		kfree(mbx->mbx_kaddr);
+		mbx->mbx_kaddr = NULL;
+		mbx->mbx_paired = 0;
+		mbx->mbx_state = CONN_START;
+	}
+	mutex_unlock(&mbx->mbx_lock);
+	MBX_INFO(mbx, "mailbox connection state %d", mbx->mbx_paired);
+}
+
+static void process_request(struct mailbox *mbx, struct mailbox_msg *msg)
+{
+	struct mailbox_req *req = (struct mailbox_req *)msg->mbm_data;
+	struct mailbox_conn *conn = (struct mailbox_conn *)req->data;
+	int rc;
+	const char *recvstr = "received request from peer";
+	const char *sendstr = "sending test msg to peer";
+
+	if (req->req == MAILBOX_REQ_TEST_READ) {
+		MBX_INFO(mbx, "%s: %d", recvstr, req->req);
+		if (mbx->mbx_tst_tx_msg_len) {
+			MBX_INFO(mbx, "%s", sendstr);
+			rc = mailbox_post(mbx->mbx_pdev, msg->mbm_req_id,
+				mbx->mbx_tst_tx_msg, mbx->mbx_tst_tx_msg_len);
+			if (rc)
+				MBX_ERR(mbx, "%s failed: %d", sendstr, rc);
+			else
+				mbx->mbx_tst_tx_msg_len = 0;
+
+		}
+	} else if (req->req == MAILBOX_REQ_TEST_READY) {
+		MBX_INFO(mbx, "%s: %d", recvstr, req->req);
+	} else if (req->req == MAILBOX_REQ_CONN_EXPL) {
+		MBX_INFO(mbx, "%s: %d", recvstr, req->req);
+		if (mbx->mbx_state != CONN_SYN_SENT) {
+			/* if your peer droped without notice,
+			 * initial the connection Simultaneously
+			 * again.
+			 */
+			if (conn->flag == MB_CONN_SYN) {
+				connect_state_touch(mbx, MB_CONN_INIT);
+			}
+		}
+		connect_state_handler(mbx, conn);
+	} else if (mbx->mbx_listen_cb) {
+		/* Call client's registered callback to process request. */
+		MBX_DBG(mbx, "%s: %d, passed on", recvstr, req->req);
+		mbx->mbx_listen_cb(mbx->mbx_listen_cb_arg, msg->mbm_data,
+			msg->mbm_len, msg->mbm_req_id, msg->mbm_error);
+	} else {
+		MBX_INFO(mbx, "%s: %d, dropped", recvstr, req->req);
+	}
+}
+
+/*
+ * Wait for request from peer.
+ */
+static void mailbox_recv_request(struct work_struct *work)
+{
+	int rv = 0;
+	struct mailbox_msg *msg = NULL;
+	struct mailbox *mbx =
+		container_of(work, struct mailbox, mbx_listen_worker);
+
+	for (;;) {
+		/* Only interested in request msg. */
+
+		rv = wait_for_completion_interruptible(&mbx->mbx_comp);
+		if (rv)
+			break;
+		mutex_lock(&mbx->mbx_lock);
+		msg = list_first_entry_or_null(&mbx->mbx_req_list,
+			struct mailbox_msg, mbm_list);
+
+		if (msg) {
+			list_del(&msg->mbm_list);
+			mbx->mbx_req_cnt--;
+			mbx->mbx_req_sz -= msg->mbm_len;
+			mutex_unlock(&mbx->mbx_lock);
+		} else {
+			mutex_unlock(&mbx->mbx_lock);
+			break;
+		}
+
+		process_request(mbx, msg);
+		free_msg(msg);
+	}
+
+	if (rv == -ESHUTDOWN)
+		MBX_INFO(mbx, "channel is closed, no listen to peer");
+	else if (rv != 0)
+		MBX_ERR(mbx, "failed to receive request from peer, err=%d", rv);
+
+	if (msg)
+		free_msg(msg);
+}
+
+int mailbox_listen(struct platform_device *pdev,
+	mailbox_msg_cb_t cb, void *cbarg)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+
+	mbx->mbx_listen_cb_arg = cbarg;
+	/* mbx->mbx_listen_cb is used in another thread as a condition to
+	 * call the function. Ensuring that the argument is captured before
+	 * the function pointer
+	 */
+	wmb();
+	mbx->mbx_listen_cb = cb;
+
+	return 0;
+}
+
+static int mailbox_enable_intr_mode(struct mailbox *mbx)
+{
+	struct resource *res;
+	int ret;
+	struct platform_device *pdev = mbx->mbx_pdev;
+	struct xocl_dev *xdev = xocl_get_xdev(pdev);
+
+	if (mbx->mbx_irq != -1)
+		return 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res == NULL) {
+		MBX_ERR(mbx, "failed to acquire intr resource");
+		return -EINVAL;
+	}
+
+	ret = xocl_user_interrupt_reg(xdev, res->start, mailbox_isr, mbx);
+	if (ret) {
+		MBX_ERR(mbx, "failed to add intr handler");
+		return ret;
+	}
+	ret = xocl_user_interrupt_config(xdev, res->start, true);
+	BUG_ON(ret != 0);
+
+	/* Only see intr when we have full packet sent or received. */
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_rit, PACKET_SIZE - 1);
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_sit, 0);
+
+	/* Finally, enable TX / RX intr. */
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_ie, 0x3);
+
+	clear_bit(MBXCS_BIT_POLL_MODE, &mbx->mbx_rx.mbc_state);
+	chan_config_timer(&mbx->mbx_rx);
+
+	clear_bit(MBXCS_BIT_POLL_MODE, &mbx->mbx_tx.mbc_state);
+	chan_config_timer(&mbx->mbx_tx);
+
+	mbx->mbx_irq = res->start;
+	return 0;
+}
+
+static void mailbox_disable_intr_mode(struct mailbox *mbx)
+{
+	struct platform_device *pdev = mbx->mbx_pdev;
+	struct xocl_dev *xdev = xocl_get_xdev(pdev);
+
+	/*
+	 * No need to turn on polling mode for TX, which has
+	 * a channel stall checking timer always on when there is
+	 * outstanding TX packet.
+	 */
+	set_bit(MBXCS_BIT_POLL_MODE, &mbx->mbx_rx.mbc_state);
+	chan_config_timer(&mbx->mbx_rx);
+
+	/* Disable both TX / RX intrs. */
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_ie, 0x0);
+
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_rit, 0x0);
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_sit, 0x0);
+
+	if (mbx->mbx_irq == -1)
+		return;
+
+	(void) xocl_user_interrupt_config(xdev, mbx->mbx_irq, false);
+	(void) xocl_user_interrupt_reg(xdev, mbx->mbx_irq, NULL, mbx);
+
+	mbx->mbx_irq = -1;
+}
+
+int mailbox_reset(struct platform_device *pdev, bool end_of_reset)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (mailbox_no_intr)
+		return 0;
+
+	if (end_of_reset) {
+		MBX_INFO(mbx, "enable intr mode");
+		if (mailbox_enable_intr_mode(mbx) != 0)
+			MBX_ERR(mbx, "failed to enable intr after reset");
+	} else {
+		MBX_INFO(mbx, "enable polling mode");
+		mailbox_disable_intr_mode(mbx);
+	}
+	return ret;
+}
+
+/* Kernel APIs exported from this sub-device driver. */
+static struct xocl_mailbox_funcs mailbox_ops = {
+	.request = mailbox_request,
+	.post = mailbox_post,
+	.listen = mailbox_listen,
+	.reset = mailbox_reset,
+	.get_data = mailbox_get_data,
+};
+
+static int mailbox_remove(struct platform_device *pdev)
+{
+	struct mailbox *mbx = platform_get_drvdata(pdev);
+
+	BUG_ON(mbx == NULL);
+
+	connect_state_touch(mbx, MB_CONN_FIN);
+
+	mailbox_disable_intr_mode(mbx);
+
+	sysfs_remove_group(&pdev->dev.kobj, &mailbox_attrgroup);
+
+	chan_fini(&mbx->mbx_rx);
+	chan_fini(&mbx->mbx_tx);
+	listen_wq_fini(mbx);
+
+	BUG_ON(!(list_empty(&mbx->mbx_req_list)));
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_MAILBOX, NULL);
+
+	if (mbx->mbx_regs)
+		iounmap(mbx->mbx_regs);
+
+	MBX_INFO(mbx, "mailbox cleaned up successfully");
+	platform_set_drvdata(pdev, NULL);
+	kfree(mbx);
+	return 0;
+}
+
+static int mailbox_probe(struct platform_device *pdev)
+{
+	struct mailbox *mbx = NULL;
+	struct resource *res;
+	int ret;
+
+	mbx = kzalloc(sizeof(struct mailbox), GFP_KERNEL);
+	if (!mbx)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, mbx);
+	mbx->mbx_pdev = pdev;
+	mbx->mbx_irq = (u32)-1;
+
+
+	init_completion(&mbx->mbx_comp);
+	mutex_init(&mbx->mbx_lock);
+	INIT_LIST_HEAD(&mbx->mbx_req_list);
+	mbx->mbx_req_cnt = 0;
+	mbx->mbx_req_sz = 0;
+
+	mutex_init(&mbx->mbx_conn_lock);
+	mbx->mbx_established = false;
+	mbx->mbx_conn_id = 0;
+	mbx->mbx_kaddr = NULL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mbx->mbx_regs = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!mbx->mbx_regs) {
+		MBX_ERR(mbx, "failed to map in registers");
+		ret = -EIO;
+		goto failed;
+	}
+	/* Reset TX channel, RX channel is managed by peer as his TX. */
+	mailbox_reg_wr(mbx, &mbx->mbx_regs->mbr_ctrl, 0x1);
+
+	/* Set up software communication channels. */
+	ret = chan_init(mbx, "RX", &mbx->mbx_rx, chan_do_rx);
+	if (ret != 0) {
+		MBX_ERR(mbx, "failed to init rx channel");
+		goto failed;
+	}
+	ret = chan_init(mbx, "TX", &mbx->mbx_tx, chan_do_tx);
+	if (ret != 0) {
+		MBX_ERR(mbx, "failed to init tx channel");
+		goto failed;
+	}
+	/* Dedicated thread for listening to peer request. */
+	mbx->mbx_listen_wq =
+		create_singlethread_workqueue(dev_name(&mbx->mbx_pdev->dev));
+	if (!mbx->mbx_listen_wq) {
+		MBX_ERR(mbx, "failed to create request-listen work queue");
+		goto failed;
+	}
+	INIT_WORK(&mbx->mbx_listen_worker, mailbox_recv_request);
+	queue_work(mbx->mbx_listen_wq, &mbx->mbx_listen_worker);
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &mailbox_attrgroup);
+	if (ret != 0) {
+		MBX_ERR(mbx, "failed to init sysfs");
+		goto failed;
+	}
+
+	if (mailbox_no_intr) {
+		MBX_INFO(mbx, "Enabled timer-driven mode");
+		mailbox_disable_intr_mode(mbx);
+	} else {
+		ret = mailbox_enable_intr_mode(mbx);
+		if (ret != 0)
+			goto failed;
+	}
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_MAILBOX, &mailbox_ops);
+
+	connect_state_touch(mbx, MB_CONN_INIT);
+	mbx->mbx_prot_ver = MB_PROTOCOL_VER;
+
+	MBX_INFO(mbx, "successfully initialized");
+	return 0;
+
+failed:
+	mailbox_remove(pdev);
+	return ret;
+}
+
+struct platform_device_id mailbox_id_table[] = {
+	{ XOCL_MAILBOX, 0 },
+	{ },
+};
+
+static struct platform_driver mailbox_driver = {
+	.probe		= mailbox_probe,
+	.remove		= mailbox_remove,
+	.driver		= {
+		.name	= XOCL_MAILBOX,
+	},
+	.id_table = mailbox_id_table,
+};
+
+int __init xocl_init_mailbox(void)
+{
+	BUILD_BUG_ON(sizeof(struct mailbox_pkt) != sizeof(u32) * PACKET_SIZE);
+	return platform_driver_register(&mailbox_driver);
+}
+
+void xocl_fini_mailbox(void)
+{
+	platform_driver_unregister(&mailbox_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/mb_scheduler.c b/drivers/gpu/drm/xocl/subdev/mb_scheduler.c
new file mode 100644
index 000000000000..b3ed3ae0b41a
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/mb_scheduler.c
@@ -0,0 +1,3059 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *    Soren Soe <soren.soe@xilinx.com>
+ */
+
+/*
+ * Kernel Driver Scheduler (KDS) for XRT
+ *
+ * struct xocl_cmd
+ *  - wraps exec BOs create from user space
+ *  - transitions through a number of states
+ *  - initially added to pending command queue
+ *  - consumed by scheduler which manages its execution (state transition)
+ * struct xcol_cu
+ *  - compute unit for executing commands
+ *  - used only without embedded scheduler (ert)
+ *  - talks to HW compute units
+ * struct xocl_ert
+ *  - embedded scheduler for executing commands on ert
+ *  - talks to HW ERT
+ * struct exec_core
+ *  - execution core managing execution on one device
+ * struct xocl_scheduler
+ *  - manages execution of cmds on one or more exec cores
+ *  - executed in a separate kernel thread
+ *  - loops repeatedly when there is work to do
+ *  - moves pending commands into a scheduler command queue
+ *
+ * [new -> pending]. The xocl API adds exec BOs to KDS.	 The exec BOs are
+ * wrapped in a xocl_cmd object and added to a pending command queue.
+ *
+ * [pending -> queued]. Scheduler loops repeatedly and copies pending commands
+ * to its own command queue, then managaes command execution on one or more
+ * execution cores.
+ *
+ * [queued -> submitted]. Commands are submitted for execution on execution
+ * core when the core has room for new commands.
+ *
+ * [submitted -> running]. Once submitted, a command is transition by
+ * scheduler into running state when there is an available compute unit (no
+ * ert) or if ERT is used, then when ERT has room.
+ *
+ * [running -> complete]. Commands running on ERT complete by sending an
+ * interrupt to scheduler.  When ERT is not used, commands are running on a
+ * compute unit and are polled for completion.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/list.h>
+#include <linux/eventfd.h>
+#include <linux/kthread.h>
+#include "../ert.h"
+#include "../xocl_drv.h"
+#include "../userpf/common.h"
+
+//#define SCHED_VERBOSE
+
+#if defined(__GNUC__)
+#define SCHED_UNUSED __attribute__((unused))
+#endif
+
+#define sched_debug_packet(packet, size)				\
+({									\
+	int i;								\
+	u32 *data = (u32 *)packet;					\
+	for (i = 0; i < size; ++i)					    \
+		DRM_INFO("packet(0x%p) data[%d] = 0x%x\n", data, i, data[i]); \
+})
+
+#ifdef SCHED_VERBOSE
+# define SCHED_DEBUG(msg) DRM_INFO(msg)
+# define SCHED_DEBUGF(format, ...) DRM_INFO(format, ##__VA_ARGS__)
+# define SCHED_PRINTF(format, ...) DRM_INFO(format, ##__VA_ARGS__)
+# define SCHED_DEBUG_PACKET(packet, size) sched_debug_packet(packet, size)
+#else
+# define SCHED_DEBUG(msg)
+# define SCHED_DEBUGF(format, ...)
+# define SCHED_PRINTF(format, ...) DRM_INFO(format, ##__VA_ARGS__)
+# define SCHED_DEBUG_PACKET(packet, size)
+#endif
+
+/* constants */
+static const unsigned int no_index = -1;
+
+/* FFA	handling */
+static const u32 AP_START    = 0x1;
+static const u32 AP_DONE     = 0x2;
+static const u32 AP_IDLE     = 0x4;
+static const u32 AP_READY    = 0x8;
+static const u32 AP_CONTINUE = 0x10;
+
+/* Forward declaration */
+struct exec_core;
+struct exec_ops;
+struct xocl_scheduler;
+
+static int validate(struct platform_device *pdev, struct client_ctx *client,
+		    const struct drm_xocl_bo *bo);
+static bool exec_is_flush(struct exec_core *exec);
+static void scheduler_wake_up(struct xocl_scheduler *xs);
+static void scheduler_intr(struct xocl_scheduler *xs);
+static void scheduler_decr_poll(struct xocl_scheduler *xs);
+
+/*
+ */
+static void
+xocl_bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits)
+{
+	unsigned int i, halfwords;
+
+	halfwords = DIV_ROUND_UP(nbits, 32);
+	for (i = 0; i < halfwords; i++) {
+		buf[i] = (u32) (bitmap[i/2] & UINT_MAX);
+		if (++i < halfwords)
+			buf[i] = (u32) (bitmap[i/2] >> 32);
+	}
+
+	/* Clear tail bits in last element of array beyond nbits. */
+	if (nbits % BITS_PER_LONG)
+		buf[halfwords - 1] &= (u32) (UINT_MAX >> ((-nbits) & 31));
+}
+
+static void
+xocl_bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned int nbits)
+{
+	unsigned int i, halfwords;
+
+	halfwords = DIV_ROUND_UP(nbits, 32);
+	for (i = 0; i < halfwords; i++) {
+		bitmap[i/2] = (unsigned long) buf[i];
+		if (++i < halfwords)
+			bitmap[i/2] |= ((unsigned long) buf[i]) << 32;
+	}
+
+	/* Clear tail bits in last word beyond nbits. */
+	if (nbits % BITS_PER_LONG)
+		bitmap[(halfwords - 1) / 2] &= BITMAP_LAST_WORD_MASK(nbits);
+}
+
+
+/**
+ * slot_mask_idx() - Slot mask idx index for a given slot_idx
+ *
+ * @slot_idx: Global [0..127] index of a CQ slot
+ * Return: Index of the slot mask containing the slot_idx
+ */
+static inline unsigned int
+slot_mask_idx(unsigned int slot_idx)
+{
+	return slot_idx >> 5;
+}
+
+/**
+ * slot_idx_in_mask() - Index of command queue slot within the mask that contains it
+ *
+ * @slot_idx: Global [0..127] index of a CQ slot
+ * Return: Index of slot within the mask that contains it
+ */
+static inline unsigned int
+slot_idx_in_mask(unsigned int slot_idx)
+{
+	return slot_idx - (slot_mask_idx(slot_idx) << 5);
+}
+
+/**
+ * Command data used by scheduler
+ *
+ * @list: command object moves from pending to commmand queue list
+ * @cu_list: command object is added to CU list when running (penguin only)
+ *
+ * @bo: underlying drm buffer object
+ * @exec: execution device associated with this command
+ * @client: client (user process) context that created this command
+ * @xs: command scheduler responsible for schedulint this command
+ * @state: state of command object per scheduling
+ * @id: unique id for an active command object
+ * @cu_idx: index of CU executing this cmd object; used in penguin mode only
+ * @slot_idx: command queue index of this command object
+ * @wait_count: number of commands that must trigger this command before it can start
+ * @chain_count: number of commands that this command must trigger when it completes
+ * @chain: list of commands to trigger upon completion; maximum chain depth is 8
+ * @deps: list of commands this object depends on, converted to chain when command is queued
+ * @packet: mapped ert packet object from user space
+ */
+struct xocl_cmd {
+	struct list_head cq_list; // scheduler command queue
+	struct list_head rq_list; // exec core running queue
+
+	/* command packet */
+	struct drm_xocl_bo *bo;
+	union {
+		struct ert_packet	    *ecmd;
+		struct ert_start_kernel_cmd *kcmd;
+	};
+
+	DECLARE_BITMAP(cu_bitmap, MAX_CUS);
+
+	struct xocl_dev	  *xdev;
+	struct exec_core  *exec;
+	struct client_ctx *client;
+	struct xocl_scheduler *xs;
+	enum ert_cmd_state state;
+
+	/* dependency handling */
+	unsigned int chain_count;
+	unsigned int wait_count;
+	union {
+		struct xocl_cmd *chain[8];
+		struct drm_xocl_bo *deps[8];
+	};
+
+	unsigned long uid;     // unique id for this command
+	unsigned int cu_idx;   // index of CU running this cmd (penguin mode)
+	unsigned int slot_idx; // index in exec core submit queue
+};
+
+/*
+ * List of free xocl_cmd objects.
+ *
+ * @free_cmds: populated with recycled xocl_cmd objects
+ * @cmd_mutex: mutex lock for cmd_list
+ *
+ * Command objects are recycled for later use and only freed when kernel
+ * module is unloaded.
+ */
+static LIST_HEAD(free_cmds);
+static DEFINE_MUTEX(free_cmds_mutex);
+
+/**
+ * delete_cmd_list() - reclaim memory for all allocated command objects
+ */
+static void
+cmd_list_delete(void)
+{
+	struct xocl_cmd *xcmd;
+	struct list_head *pos, *next;
+
+	mutex_lock(&free_cmds_mutex);
+	list_for_each_safe(pos, next, &free_cmds) {
+		xcmd = list_entry(pos, struct xocl_cmd, cq_list);
+		list_del(pos);
+		kfree(xcmd);
+	}
+	mutex_unlock(&free_cmds_mutex);
+}
+
+/*
+ * opcode() - Command opcode
+ *
+ * @cmd: Command object
+ * Return: Opcode per command packet
+ */
+static inline u32
+cmd_opcode(struct xocl_cmd *xcmd)
+{
+	return xcmd->ecmd->opcode;
+}
+
+/*
+ * type() - Command type
+ *
+ * @cmd: Command object
+ * Return: Type of command
+ */
+static inline u32
+cmd_type(struct xocl_cmd *xcmd)
+{
+	return xcmd->ecmd->type;
+}
+
+/*
+ * exec() - Get execution core
+ */
+static inline struct exec_core *
+cmd_exec(struct xocl_cmd *xcmd)
+{
+	return xcmd->exec;
+}
+
+/*
+ * uid() - Get unique id of command
+ */
+static inline unsigned long
+cmd_uid(struct xocl_cmd *xcmd)
+{
+	return xcmd->uid;
+}
+
+/*
+ */
+static inline unsigned int
+cmd_wait_count(struct xocl_cmd *xcmd)
+{
+	return xcmd->wait_count;
+}
+
+/**
+ * payload_size() - Command payload size
+ *
+ * @xcmd: Command object
+ * Return: Size in number of words of command packet payload
+ */
+static inline unsigned int
+cmd_payload_size(struct xocl_cmd *xcmd)
+{
+	return xcmd->ecmd->count;
+}
+
+/**
+ * cmd_packet_size() - Command packet size
+ *
+ * @xcmd: Command object
+ * Return: Size in number of words of command packet
+ */
+static inline unsigned int
+cmd_packet_size(struct xocl_cmd *xcmd)
+{
+	return cmd_payload_size(xcmd) + 1;
+}
+
+/**
+ * cu_masks() - Number of command packet cu_masks
+ *
+ * @xcmd: Command object
+ * Return: Total number of CU masks in command packet
+ */
+static inline unsigned int
+cmd_cumasks(struct xocl_cmd *xcmd)
+{
+	return 1 + xcmd->kcmd->extra_cu_masks;
+}
+
+/**
+ * regmap_size() - Size of regmap is payload size (n) minus the number of cu_masks
+ *
+ * @xcmd: Command object
+ * Return: Size of register map in number of words
+ */
+static inline unsigned int
+cmd_regmap_size(struct xocl_cmd *xcmd)
+{
+	return cmd_payload_size(xcmd) - cmd_cumasks(xcmd);
+}
+
+/*
+ */
+static inline struct ert_packet*
+cmd_packet(struct xocl_cmd *xcmd)
+{
+	return xcmd->ecmd;
+}
+
+/*
+ */
+static inline u32*
+cmd_regmap(struct xocl_cmd *xcmd)
+{
+	return xcmd->kcmd->data + xcmd->kcmd->extra_cu_masks;
+}
+
+/**
+ * cmd_set_int_state() - Set internal command state used by scheduler only
+ *
+ * @xcmd: command to change internal state on
+ * @state: new command state per ert.h
+ */
+static inline void
+cmd_set_int_state(struct xocl_cmd *xcmd, enum ert_cmd_state state)
+{
+	SCHED_DEBUGF("-> %s(%lu,%d)\n", __func__, xcmd->uid, state);
+	xcmd->state = state;
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/**
+ * cmd_set_state() - Set both internal and external state of a command
+ *
+ * The state is reflected externally through the command packet
+ * as well as being captured in internal state variable
+ *
+ * @xcmd: command object
+ * @state: new state
+ */
+static inline void
+cmd_set_state(struct xocl_cmd *xcmd, enum ert_cmd_state state)
+{
+	SCHED_DEBUGF("->%s(%lu,%d)\n", __func__, xcmd->uid, state);
+	xcmd->state = state;
+	xcmd->ecmd->state = state;
+	SCHED_DEBUGF("<-%s\n", __func__);
+}
+
+/*
+ * update_state() - Update command state if client has aborted
+ */
+static enum ert_cmd_state
+cmd_update_state(struct xocl_cmd *xcmd)
+{
+	if (xcmd->state != ERT_CMD_STATE_RUNNING && xcmd->client->abort) {
+		userpf_info(xcmd->xdev, "aborting stale client cmd(%lu)", xcmd->uid);
+		cmd_set_state(xcmd, ERT_CMD_STATE_ABORT);
+	}
+	if (exec_is_flush(xcmd->exec)) {
+		userpf_info(xcmd->xdev, "aborting stale exec cmd(%lu)", xcmd->uid);
+		cmd_set_state(xcmd, ERT_CMD_STATE_ABORT);
+	}
+	return xcmd->state;
+}
+
+/*
+ * release_gem_object_reference() -
+ */
+static inline void
+cmd_release_gem_object_reference(struct xocl_cmd *xcmd)
+{
+	if (xcmd->bo)
+		drm_gem_object_put_unlocked(&xcmd->bo->base);
+//PORT4_20
+//		drm_gem_object_unreference_unlocked(&xcmd->bo->base);
+}
+
+/*
+ */
+static inline void
+cmd_mark_active(struct xocl_cmd *xcmd)
+{
+	if (xcmd->bo)
+		xcmd->bo->metadata.active = xcmd;
+}
+
+/*
+ */
+static inline void
+cmd_mark_deactive(struct xocl_cmd *xcmd)
+{
+	if (xcmd->bo)
+		xcmd->bo->metadata.active = NULL;
+}
+
+/**
+ * chain_dependencies() - Chain this command to its dependencies
+ *
+ * @xcmd: Command to chain to its dependencies
+ *
+ * This function looks at all incoming explicit BO dependencies, checks if a
+ * corresponding xocl_cmd object exists (is active) in which case that command
+ * object must chain argument xcmd so that it (xcmd) can be triggered when
+ * dependency completes.  The chained command has a wait count corresponding to
+ * the number of dependencies that are active.
+ */
+static int
+cmd_chain_dependencies(struct xocl_cmd *xcmd)
+{
+	int didx;
+	int dcount = xcmd->wait_count;
+
+	SCHED_DEBUGF("-> chain_dependencies of xcmd(%lu)\n", xcmd->uid);
+	for (didx = 0; didx < dcount; ++didx) {
+		struct drm_xocl_bo *dbo = xcmd->deps[didx];
+		struct xocl_cmd *chain_to = dbo->metadata.active;
+		// release reference created in ioctl call when dependency was looked up
+		// see comments in xocl_ioctl.c:xocl_execbuf_ioctl()
+//PORT4_20
+//		drm_gem_object_unreference_unlocked(&dbo->base);
+		drm_gem_object_put_unlocked(&dbo->base);
+		xcmd->deps[didx] = NULL;
+		if (!chain_to) { /* command may have completed already */
+			--xcmd->wait_count;
+			continue;
+		}
+		if (chain_to->chain_count >= MAX_DEPS) {
+			DRM_INFO("chain count exceeded");
+			return 1;
+		}
+		SCHED_DEBUGF("+ xcmd(%lu)->chain[%d]=xcmd(%lu)", chain_to->uid, chain_to->chain_count, xcmd->uid);
+		chain_to->chain[chain_to->chain_count++] = xcmd;
+	}
+	SCHED_DEBUG("<- chain_dependencies\n");
+	return 0;
+}
+
+/**
+ * trigger_chain() - Trigger the execution of any commands chained to argument command
+ *
+ * @xcmd: Completed command that must trigger its chained (waiting) commands
+ *
+ * The argument command has completed and must trigger the execution of all
+ * chained commands whos wait_count is 0.
+ */
+static void
+cmd_trigger_chain(struct xocl_cmd *xcmd)
+{
+	SCHED_DEBUGF("-> trigger_chain xcmd(%lu)\n", xcmd->uid);
+	while (xcmd->chain_count) {
+		struct xocl_cmd *trigger = xcmd->chain[--xcmd->chain_count];
+
+		SCHED_DEBUGF("+ cmd(%lu) triggers cmd(%lu) with wait_count(%d)\n",
+			     xcmd->uid, trigger->uid, trigger->wait_count);
+		// decrement trigger wait count
+		// scheduler will submit when wait count reaches zero
+		--trigger->wait_count;
+	}
+	SCHED_DEBUG("<- trigger_chain\n");
+}
+
+
+/**
+ * cmd_get() - Get a free command object
+ *
+ * Get from free/recycled list or allocate a new command if necessary.
+ *
+ * Return: Free command object
+ */
+static struct xocl_cmd*
+cmd_get(struct xocl_scheduler *xs, struct exec_core *exec, struct client_ctx *client)
+{
+	struct xocl_cmd *xcmd;
+	static unsigned long count;
+
+	mutex_lock(&free_cmds_mutex);
+	xcmd = list_first_entry_or_null(&free_cmds, struct xocl_cmd, cq_list);
+	if (xcmd)
+		list_del(&xcmd->cq_list);
+	mutex_unlock(&free_cmds_mutex);
+	if (!xcmd)
+		xcmd = kmalloc(sizeof(struct xocl_cmd), GFP_KERNEL);
+	if (!xcmd)
+		return ERR_PTR(-ENOMEM);
+	xcmd->uid = count++;
+	xcmd->exec = exec;
+	xcmd->cu_idx = no_index;
+	xcmd->slot_idx = no_index;
+	xcmd->xs = xs;
+	xcmd->xdev = client->xdev;
+	xcmd->client = client;
+	xcmd->bo = NULL;
+	xcmd->ecmd = NULL;
+	atomic_inc(&client->outstanding_execs);
+	SCHED_DEBUGF("xcmd(%lu) xcmd(%p) [-> new ]\n", xcmd->uid, xcmd);
+	return xcmd;
+}
+
+/**
+ * cmd_free() - free a command object
+ *
+ * @xcmd: command object to free (move to freelist)
+ *
+ * The command *is* in some current list (scheduler command queue)
+ */
+static void
+cmd_free(struct xocl_cmd *xcmd)
+{
+	cmd_release_gem_object_reference(xcmd);
+
+	mutex_lock(&free_cmds_mutex);
+	list_move_tail(&xcmd->cq_list, &free_cmds);
+	mutex_unlock(&free_cmds_mutex);
+
+	atomic_dec(&xcmd->xdev->outstanding_execs);
+	atomic_dec(&xcmd->client->outstanding_execs);
+	SCHED_DEBUGF("xcmd(%lu) [-> free]\n", xcmd->uid);
+}
+
+/**
+ * abort_cmd() - abort command object before it becomes pending
+ *
+ * @xcmd: command object to abort (move to freelist)
+ *
+ * Command object is *not* in any current list
+ *
+ * Return: 0
+ */
+static void
+cmd_abort(struct xocl_cmd *xcmd)
+{
+	mutex_lock(&free_cmds_mutex);
+	list_add_tail(&xcmd->cq_list, &free_cmds);
+	mutex_unlock(&free_cmds_mutex);
+	SCHED_DEBUGF("xcmd(%lu) [-> abort]\n", xcmd->uid);
+}
+
+/*
+ * cmd_bo_init() - Initialize a command object with an exec BO
+ *
+ * In penguin mode, the command object caches the CUs available
+ * to execute the command.  When ERT is enabled, the CU info
+ * is not used.
+ */
+static void
+cmd_bo_init(struct xocl_cmd *xcmd, struct drm_xocl_bo *bo,
+	    int numdeps, struct drm_xocl_bo **deps, int penguin)
+{
+	SCHED_DEBUGF("%s(%lu,bo,%d,deps,%d)\n", __func__, xcmd->uid, numdeps, penguin);
+	xcmd->bo = bo;
+	xcmd->ecmd = (struct ert_packet *)bo->vmapping;
+
+	if (penguin && cmd_opcode(xcmd) == ERT_START_KERNEL) {
+		unsigned int i = 0;
+		u32 cumasks[4] = {0};
+
+		cumasks[0] = xcmd->kcmd->cu_mask;
+		SCHED_DEBUGF("+ xcmd(%lu) cumask[0]=0x%x\n", xcmd->uid, cumasks[0]);
+		for (i = 0; i < xcmd->kcmd->extra_cu_masks; ++i) {
+			cumasks[i+1] = xcmd->kcmd->data[i];
+			SCHED_DEBUGF("+ xcmd(%lu) cumask[%d]=0x%x\n", xcmd->uid, i+1, cumasks[i+1]);
+		}
+		xocl_bitmap_from_arr32(xcmd->cu_bitmap, cumasks, MAX_CUS);
+		SCHED_DEBUGF("cu_bitmap[0] = %lu\n", xcmd->cu_bitmap[0]);
+	}
+
+	// dependencies are copied here, the anticipated wait_count is number
+	// of specified dependencies.  The wait_count is adjusted when the
+	// command is queued in the scheduler based on whether or not a
+	// dependency is active (managed by scheduler)
+	memcpy(xcmd->deps, deps, numdeps*sizeof(struct drm_xocl_bo *));
+	xcmd->wait_count = numdeps;
+	xcmd->chain_count = 0;
+}
+
+/*
+ */
+static void
+cmd_packet_init(struct xocl_cmd *xcmd, struct ert_packet *packet)
+{
+	SCHED_DEBUGF("%s(%lu,packet)\n", __func__, xcmd->uid);
+	xcmd->ecmd = packet;
+}
+
+/*
+ * cmd_has_cu() - Check if this command object can execute on CU
+ *
+ * @cuidx: the index of the CU.	 Note that CU indicies start from 0.
+ */
+static int
+cmd_has_cu(struct xocl_cmd *xcmd, unsigned int cuidx)
+{
+	SCHED_DEBUGF("%s(%lu,%d) = %d\n", __func__, xcmd->uid, cuidx, test_bit(cuidx, xcmd->cu_bitmap));
+	return test_bit(cuidx, xcmd->cu_bitmap);
+}
+
+/*
+ * struct xocl_cu: Represents a compute unit in penguin mode
+ *
+ * @running_queue: a fifo representing commands running on this CU
+ * @xdev: the xrt device with this CU
+ * @idx: index of this CU
+ * @base: exec base address of this CU
+ * @addr: base address of this CU
+ * @ctrlreg: state of the CU (value of AXI-lite control register)
+ * @done_cnt: number of command that have completed (<=running_queue.size())
+ *
+ */
+struct xocl_cu {
+	struct list_head   running_queue;
+	unsigned int idx;
+	void __iomem *base;
+	u32 addr;
+
+	u32 ctrlreg;
+	unsigned int done_cnt;
+	unsigned int run_cnt;
+	unsigned int uid;
+};
+
+/*
+ */
+void
+cu_reset(struct xocl_cu *xcu, unsigned int idx, void __iomem *base, u32 addr)
+{
+	xcu->idx = idx;
+	xcu->base = base;
+	xcu->addr = addr;
+	xcu->ctrlreg = 0;
+	xcu->done_cnt = 0;
+	xcu->run_cnt = 0;
+	SCHED_DEBUGF("%s(uid:%d,idx:%d) @ 0x%x\n", __func__, xcu->uid, xcu->idx, xcu->addr);
+}
+
+/*
+ */
+struct xocl_cu *
+cu_create(void)
+{
+	struct xocl_cu *xcu = kmalloc(sizeof(struct xocl_cu), GFP_KERNEL);
+	static unsigned int uid;
+
+	INIT_LIST_HEAD(&xcu->running_queue);
+	xcu->uid = uid++;
+	SCHED_DEBUGF("%s(uid:%d)\n", __func__, xcu->uid);
+	return xcu;
+}
+
+static inline u32
+cu_base_addr(struct xocl_cu *xcu)
+{
+	return xcu->addr;
+}
+
+/*
+ */
+void
+cu_destroy(struct xocl_cu *xcu)
+{
+	SCHED_DEBUGF("%s(uid:%d)\n", __func__, xcu->uid);
+	kfree(xcu);
+}
+
+/*
+ */
+void
+cu_poll(struct xocl_cu *xcu)
+{
+	// assert !list_empty(&running_queue)
+	xcu->ctrlreg = ioread32(xcu->base + xcu->addr);
+	SCHED_DEBUGF("%s(%d) 0x%x done(%d) run(%d)\n", __func__, xcu->idx, xcu->ctrlreg, xcu->done_cnt, xcu->run_cnt);
+	if (xcu->ctrlreg & AP_DONE) {
+		++xcu->done_cnt; // assert done_cnt <= |running_queue|
+		--xcu->run_cnt;
+		// acknowledge done
+		iowrite32(AP_CONTINUE, xcu->base + xcu->addr);
+	}
+}
+
+/*
+ * cu_ready() - Check if CU is ready to start another command
+ *
+ * The CU is ready when AP_START is low
+ */
+static int
+cu_ready(struct xocl_cu *xcu)
+{
+	if (xcu->ctrlreg & AP_START)
+		cu_poll(xcu);
+
+	SCHED_DEBUGF("%s(%d) returns %d\n", __func__, xcu->idx, !(xcu->ctrlreg & AP_START));
+	return !(xcu->ctrlreg & AP_START);
+}
+
+/*
+ * cu_first_done() - Get the first completed command from the running queue
+ *
+ * Return: The first command that has completed or nullptr if none
+ */
+static struct xocl_cmd*
+cu_first_done(struct xocl_cu *xcu)
+{
+	if (!xcu->done_cnt)
+		cu_poll(xcu);
+
+	SCHED_DEBUGF("%s(%d) has done_cnt %d\n", __func__, xcu->idx, xcu->done_cnt);
+
+	return xcu->done_cnt
+		? list_first_entry(&xcu->running_queue, struct xocl_cmd, rq_list)
+		: NULL;
+}
+
+/*
+ * cu_pop_done() - Remove first element from running queue
+ */
+static void
+cu_pop_done(struct xocl_cu *xcu)
+{
+	struct xocl_cmd *xcmd;
+
+	if (!xcu->done_cnt)
+		return;
+	xcmd = list_first_entry(&xcu->running_queue, struct xocl_cmd, rq_list);
+	list_del(&xcmd->rq_list);
+	--xcu->done_cnt;
+	SCHED_DEBUGF("%s(%d) xcmd(%lu) done(%d) run(%d)\n", __func__, xcu->idx, xcmd->uid, xcu->done_cnt, xcu->run_cnt);
+}
+
+/*
+ * cu_start() - Start the CU with a new command.
+ *
+ * The command is pushed onto the running queue
+ */
+static int
+cu_start(struct xocl_cu *xcu, struct xocl_cmd *xcmd)
+{
+	// assert(!(ctrlreg & AP_START), "cu not ready");
+
+	// data past header and cu_masks
+	unsigned int size = cmd_regmap_size(xcmd);
+	u32 *regmap = cmd_regmap(xcmd);
+	unsigned int i;
+
+	// past header, past cumasks
+	SCHED_DEBUG_PACKET(regmap, size);
+
+	// write register map, starting at base + 0xC
+	// 0x4, 0x8 used for interrupt, which is initialized in setu
+	for (i = 1; i < size; ++i)
+		iowrite32(*(regmap + i), xcu->base + xcu->addr + (i << 2));
+
+	// start cu.  update local state as we may not be polling prior
+	// to next ready check.
+	xcu->ctrlreg |= AP_START;
+	iowrite32(AP_START, xcu->base + xcu->addr);
+
+	// add cmd to end of running queue
+	list_add_tail(&xcmd->rq_list, &xcu->running_queue);
+	++xcu->run_cnt;
+
+	SCHED_DEBUGF("%s(%d) started xcmd(%lu) done(%d) run(%d)\n",
+		     __func__, xcu->idx, xcmd->uid, xcu->done_cnt, xcu->run_cnt);
+
+	return true;
+}
+
+
+/*
+ * sruct xocl_ert: Represents embedded scheduler in ert mode
+ */
+struct xocl_ert {
+	void __iomem *base;
+	u32	     cq_addr;
+	unsigned int uid;
+
+	unsigned int slot_size;
+	unsigned int cq_intr;
+};
+
+/*
+ */
+struct xocl_ert *
+ert_create(void __iomem *base, u32 cq_addr)
+{
+	struct xocl_ert *xert = kmalloc(sizeof(struct xocl_ert), GFP_KERNEL);
+	static unsigned int uid;
+
+	xert->base = base;
+	xert->cq_addr = cq_addr;
+	xert->uid = uid++;
+	xert->slot_size = 0;
+	xert->cq_intr = false;
+	SCHED_DEBUGF("%s(%d,0x%x)\n", __func__, xert->uid, xert->cq_addr);
+	return xert;
+}
+
+/*
+ */
+static void
+ert_destroy(struct xocl_ert *xert)
+{
+	SCHED_DEBUGF("%s(%d)\n", __func__, xert->uid);
+	kfree(xert);
+}
+
+/*
+ */
+static void
+ert_cfg(struct xocl_ert *xert, unsigned int slot_size, unsigned int cq_intr)
+{
+	SCHED_DEBUGF("%s(%d) slot_size(%d) cq_intr(%d)\n", __func__, xert->uid, slot_size, cq_intr);
+	xert->slot_size = slot_size;
+	xert->cq_intr = cq_intr;
+}
+
+/*
+ */
+static bool
+ert_start_cmd(struct xocl_ert *xert, struct xocl_cmd *xcmd)
+{
+	u32 slot_addr = xert->cq_addr + xcmd->slot_idx * xert->slot_size;
+	struct ert_packet *ecmd = cmd_packet(xcmd);
+
+	SCHED_DEBUG_PACKET(ecmd, cmd_packet_size(xcmd));
+
+	SCHED_DEBUGF("-> %s(%d,%lu)\n", __func__, xert->uid, xcmd->uid);
+
+	// write packet minus header
+	SCHED_DEBUGF("++ slot_idx=%d, slot_addr=0x%x\n", xcmd->slot_idx, slot_addr);
+	memcpy_toio(xert->base + slot_addr + 4, ecmd->data, (cmd_packet_size(xcmd) - 1) * sizeof(u32));
+
+	// write header
+	iowrite32(ecmd->header, xert->base + slot_addr);
+
+	// trigger interrupt to embedded scheduler if feature is enabled
+	if (xert->cq_intr) {
+		u32 cq_int_addr = ERT_CQ_STATUS_REGISTER_ADDR + (slot_mask_idx(xcmd->slot_idx) << 2);
+		u32 mask = 1 << slot_idx_in_mask(xcmd->slot_idx);
+
+		SCHED_DEBUGF("++ mb_submit writes slot mask 0x%x to CQ_INT register at addr 0x%x\n",
+			     mask, cq_int_addr);
+		iowrite32(mask, xert->base + cq_int_addr);
+	}
+	SCHED_DEBUGF("<- %s returns true\n", __func__);
+	return true;
+}
+
+/*
+ */
+static void
+ert_read_custat(struct xocl_ert *xert, unsigned int num_cus, u32 *cu_usage, struct xocl_cmd *xcmd)
+{
+	u32 slot_addr = xert->cq_addr + xcmd->slot_idx*xert->slot_size;
+
+	memcpy_fromio(cu_usage, xert->base + slot_addr + 4, num_cus * sizeof(u32));
+}
+
+/**
+ * struct exec_ops: scheduler specific operations
+ *
+ * Scheduler can operate in MicroBlaze mode (mb/ert) or in penguin mode. This
+ * struct differentiates specific operations.  The struct is per device node,
+ * meaning that one device can operate in ert mode while another can operate
+ * in penguin mode.
+ */
+struct exec_ops {
+	bool (*start)(struct exec_core *exec, struct xocl_cmd *xcmd);
+	void (*query)(struct exec_core *exec, struct xocl_cmd *xcmd);
+};
+
+static struct exec_ops ert_ops;
+static struct exec_ops penguin_ops;
+
+/**
+ * struct exec_core: Core data structure for command execution on a device
+ *
+ * @ctx_list: Context list populated with device context
+ * @exec_lock: Lock for synchronizing external access
+ * @poll_wait_queue: Wait queue for device polling
+ * @scheduler: Command queue scheduler
+ * @submitted_cmds: Tracking of command submitted for execution on this device
+ * @num_slots: Number of command queue slots
+ * @num_cus: Number of CUs in loaded program
+ * @num_cdma: Number of CDMAs in hardware
+ * @polling_mode: If set then poll for command completion
+ * @cq_interrupt: If set then trigger interrupt to MB on new commands
+ * @configured: Flag to indicate that the core data structure has been initialized
+ * @stopped: Flag to indicate that the core data structure cannot be used
+ * @flush: Flag to indicate that commands for this device should be flushed
+ * @cu_usage: Usage count since last reset
+ * @slot_status: Bitmap to track status (busy(1)/free(0)) slots in command queue
+ * @ctrl_busy: Flag to indicate that slot 0 (ctrl commands) is busy
+ * @cu_status: Bitmap to track status (busy(1)/free(0)) of CUs. Unused in ERT mode.
+ * @sr0: If set, then status register [0..31] is pending with completed commands (ERT only).
+ * @sr1: If set, then status register [32..63] is pending with completed commands (ERT only).
+ * @sr2: If set, then status register [64..95] is pending with completed commands (ERT only).
+ * @sr3: If set, then status register [96..127] is pending with completed commands (ERT only).
+ * @ops: Scheduler operations vtable
+ */
+struct exec_core {
+	struct platform_device	   *pdev;
+
+	struct mutex		   exec_lock;
+
+	void __iomem		   *base;
+	u32			   intr_base;
+	u32			   intr_num;
+
+	wait_queue_head_t	   poll_wait_queue;
+
+	struct xocl_scheduler	   *scheduler;
+
+	uuid_t			   xclbin_id;
+
+	unsigned int		   num_slots;
+	unsigned int		   num_cus;
+	unsigned int		   num_cdma;
+	unsigned int		   polling_mode;
+	unsigned int		   cq_interrupt;
+	unsigned int		   configured;
+	unsigned int		   stopped;
+	unsigned int		   flush;
+
+	struct xocl_cu		   *cus[MAX_CUS];
+	struct xocl_ert		   *ert;
+
+	u32			   cu_usage[MAX_CUS];
+
+	// Bitmap tracks busy(1)/free(0) slots in cmd_slots
+	struct xocl_cmd		   *submitted_cmds[MAX_SLOTS];
+	DECLARE_BITMAP(slot_status, MAX_SLOTS);
+	unsigned int		   ctrl_busy;
+
+	// Status register pending complete.  Written by ISR,
+	// cleared by scheduler
+	atomic_t		   sr0;
+	atomic_t		   sr1;
+	atomic_t		   sr2;
+	atomic_t		   sr3;
+
+	// Operations for dynamic indirection dependt on MB
+	// or kernel scheduler
+	struct exec_ops		   *ops;
+
+	unsigned int		   uid;
+	unsigned int		   ip_reference[MAX_CUS];
+};
+
+/**
+ * exec_get_pdev() -
+ */
+static inline struct platform_device *
+exec_get_pdev(struct exec_core *exec)
+{
+	return exec->pdev;
+}
+
+/**
+ * exec_get_xdev() -
+ */
+static inline struct xocl_dev *
+exec_get_xdev(struct exec_core *exec)
+{
+	return xocl_get_xdev(exec->pdev);
+}
+
+/*
+ */
+static inline bool
+exec_is_ert(struct exec_core *exec)
+{
+	return exec->ops == &ert_ops;
+}
+
+/*
+ */
+static inline bool
+exec_is_polling(struct exec_core *exec)
+{
+	return exec->polling_mode;
+}
+
+/*
+ */
+static inline bool
+exec_is_flush(struct exec_core *exec)
+{
+	return exec->flush;
+}
+
+/*
+ */
+static inline u32
+exec_cu_base_addr(struct exec_core *exec, unsigned int cuidx)
+{
+	return cu_base_addr(exec->cus[cuidx]);
+}
+
+/*
+ */
+static inline u32
+exec_cu_usage(struct exec_core *exec, unsigned int cuidx)
+{
+	return exec->cu_usage[cuidx];
+}
+
+/*
+ */
+static void
+exec_cfg(struct exec_core *exec)
+{
+}
+
+/*
+ * to be automated
+ */
+static int
+exec_cfg_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	struct xocl_dev *xdev = exec_get_xdev(exec);
+	struct client_ctx *client = xcmd->client;
+	bool ert = xocl_mb_sched_on(xdev);
+	uint32_t *cdma = xocl_cdma_addr(xdev);
+	unsigned int dsa = xocl_dsa_version(xdev);
+	struct ert_configure_cmd *cfg;
+	int cuidx = 0;
+
+	/* Only allow configuration with one live ctx */
+	if (exec->configured) {
+		DRM_INFO("command scheduler is already configured for this device\n");
+		return 1;
+	}
+
+	DRM_INFO("ert per feature rom = %d\n", ert);
+	DRM_INFO("dsa per feature rom = %d\n", dsa);
+
+	cfg = (struct ert_configure_cmd *)(xcmd->ecmd);
+
+	/* Mark command as control command to force slot 0 execution */
+	cfg->type = ERT_CTRL;
+
+	if (cfg->count != 5 + cfg->num_cus) {
+		DRM_INFO("invalid configure command, count=%d expected 5+num_cus(%d)\n", cfg->count, cfg->num_cus);
+		return 1;
+	}
+
+	SCHED_DEBUG("configuring scheduler\n");
+	exec->num_slots = ERT_CQ_SIZE / cfg->slot_size;
+	exec->num_cus = cfg->num_cus;
+	exec->num_cdma = 0;
+
+	// skip this in polling mode
+	for (cuidx = 0; cuidx < exec->num_cus; ++cuidx) {
+		struct xocl_cu *xcu = exec->cus[cuidx];
+
+		if (!xcu)
+			xcu = exec->cus[cuidx] = cu_create();
+		cu_reset(xcu, cuidx, exec->base, cfg->data[cuidx]);
+		userpf_info(xdev, "%s cu(%d) at 0x%x\n", __func__, xcu->idx, xcu->addr);
+	}
+
+	if (cdma) {
+		uint32_t *addr = 0;
+
+		mutex_lock(&client->lock); /* for modification to client cu_bitmap */
+		for (addr = cdma; addr < cdma+4; ++addr) { /* 4 is from xclfeatures.h */
+			if (*addr) {
+				struct xocl_cu *xcu = exec->cus[cuidx];
+
+				if (!xcu)
+					xcu = exec->cus[cuidx] = cu_create();
+				cu_reset(xcu, cuidx, exec->base, *addr);
+				++exec->num_cus;
+				++exec->num_cdma;
+				++cfg->num_cus;
+				++cfg->count;
+				cfg->data[cuidx] = *addr;
+				set_bit(cuidx, client->cu_bitmap); /* cdma is shared */
+				userpf_info(xdev, "configure cdma as cu(%d) at 0x%x\n", cuidx, *addr);
+				++cuidx;
+			}
+		}
+		mutex_unlock(&client->lock);
+	}
+
+	if (ert && cfg->ert) {
+		SCHED_DEBUG("++ configuring embedded scheduler mode\n");
+		if (!exec->ert)
+			exec->ert = ert_create(exec->base, ERT_CQ_BASE_ADDR);
+		ert_cfg(exec->ert, cfg->slot_size, cfg->cq_int);
+		exec->ops = &ert_ops;
+		exec->polling_mode = cfg->polling;
+		exec->cq_interrupt = cfg->cq_int;
+		cfg->dsa52 = (dsa >= 52) ? 1 : 0;
+		cfg->cdma = cdma ? 1 : 0;
+	} else {
+		SCHED_DEBUG("++ configuring penguin scheduler mode\n");
+		exec->ops = &penguin_ops;
+		exec->polling_mode = 1;
+	}
+
+	// reserve slot 0 for control commands
+	set_bit(0, exec->slot_status);
+
+	DRM_INFO("scheduler config ert(%d) slots(%d), cudma(%d), cuisr(%d), cdma(%d), cus(%d)\n"
+		 , exec_is_ert(exec)
+		 , exec->num_slots
+		 , cfg->cu_dma ? 1 : 0
+		 , cfg->cu_isr ? 1 : 0
+		 , exec->num_cdma
+		 , exec->num_cus);
+
+	exec->configured = true;
+	return 0;
+}
+
+/**
+ * exec_reset() - Reset the scheduler
+ *
+ * @exec: Execution core (device) to reset
+ *
+ * TODO: Perform scheduler configuration based on current xclbin
+ *	 rather than relying of cfg command
+ */
+static void
+exec_reset(struct exec_core *exec)
+{
+	struct xocl_dev *xdev = exec_get_xdev(exec);
+	uuid_t *xclbin_id;
+
+	mutex_lock(&exec->exec_lock);
+
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+
+	userpf_info(xdev, "%s(%d) cfg(%d)\n", __func__, exec->uid, exec->configured);
+
+	// only reconfigure the scheduler on new xclbin
+	if (!xclbin_id || (uuid_equal(&exec->xclbin_id, xclbin_id) && exec->configured)) {
+		exec->stopped = false;
+		exec->configured = false;  // TODO: remove, but hangs ERT because of in between AXI resets
+		goto out;
+	}
+
+	userpf_info(xdev, "exec->xclbin(%pUb),xclbin(%pUb)\n", &exec->xclbin_id, xclbin_id);
+	userpf_info(xdev, "%s resets for new xclbin", __func__);
+	memset(exec->cu_usage, 0, MAX_CUS * sizeof(u32));
+	uuid_copy(&exec->xclbin_id, xclbin_id);
+	exec->num_cus = 0;
+	exec->num_cdma = 0;
+
+	exec->num_slots = 16;
+	exec->polling_mode = 1;
+	exec->cq_interrupt = 0;
+	exec->configured = false;
+	exec->stopped = false;
+	exec->flush = false;
+	exec->ops = &penguin_ops;
+
+	bitmap_zero(exec->slot_status, MAX_SLOTS);
+	set_bit(0, exec->slot_status); // reserve for control command
+	exec->ctrl_busy = false;
+
+	atomic_set(&exec->sr0, 0);
+	atomic_set(&exec->sr1, 0);
+	atomic_set(&exec->sr2, 0);
+	atomic_set(&exec->sr3, 0);
+
+	exec_cfg(exec);
+
+out:
+	mutex_unlock(&exec->exec_lock);
+}
+
+/**
+ * exec_stop() - Stop the scheduler from scheduling commands on this core
+ *
+ * @exec:  Execution core (device) to stop
+ *
+ * Block access to current exec_core (device).	This API must be called prior
+ * to performing an AXI reset and downloading of a new xclbin.	Calling this
+ * API flushes the commands running on current device and prevents new
+ * commands from being scheduled on the device.	 This effectively prevents any
+ * further commands from running on the device
+ */
+static void
+exec_stop(struct exec_core *exec)
+{
+	int idx;
+	struct xocl_dev *xdev = exec_get_xdev(exec);
+	unsigned int outstanding = 0;
+	unsigned int wait_ms = 100;
+	unsigned int retry = 20;  // 2 sec
+
+	mutex_lock(&exec->exec_lock);
+	userpf_info(xdev, "%s(%p)\n", __func__, exec);
+	exec->stopped = true;
+	mutex_unlock(&exec->exec_lock);
+
+	// Wait for commands to drain if any
+	outstanding = atomic_read(&xdev->outstanding_execs);
+	while (--retry && outstanding) {
+		userpf_info(xdev, "Waiting for %d outstanding commands to finish", outstanding);
+		msleep(wait_ms);
+		outstanding = atomic_read(&xdev->outstanding_execs);
+	}
+
+	// Last gasp, flush any remaining commands for this device exec core
+	// This is an abnormal case.  All exec clients have been destroyed
+	// prior to exec_stop being called (per contract), this implies that
+	// all regular client commands have been flushed.
+	if (outstanding) {
+		// Wake up the scheduler to force one iteration flushing stale
+		// commands for this device
+		exec->flush = 1;
+		scheduler_intr(exec->scheduler);
+
+		// Wait a second
+		msleep(1000);
+	}
+
+	outstanding = atomic_read(&xdev->outstanding_execs);
+	if (outstanding)
+		userpf_err(xdev, "unexpected outstanding commands %d after flush", outstanding);
+
+	// Stale commands were flushed, reset submitted command state
+	for (idx = 0; idx < MAX_SLOTS; ++idx)
+		exec->submitted_cmds[idx] = NULL;
+
+	bitmap_zero(exec->slot_status, MAX_SLOTS);
+	set_bit(0, exec->slot_status); // reserve for control command
+	exec->ctrl_busy = false;
+}
+
+/*
+ */
+static irqreturn_t
+exec_isr(int irq, void *arg)
+{
+	struct exec_core *exec = (struct exec_core *)arg;
+
+	SCHED_DEBUGF("-> xocl_user_event %d\n", irq);
+	if (exec_is_ert(exec) && !exec->polling_mode) {
+
+		if (irq == 0)
+			atomic_set(&exec->sr0, 1);
+		else if (irq == 1)
+			atomic_set(&exec->sr1, 1);
+		else if (irq == 2)
+			atomic_set(&exec->sr2, 1);
+		else if (irq == 3)
+			atomic_set(&exec->sr3, 1);
+
+		/* wake up all scheduler ... currently one only */
+		scheduler_intr(exec->scheduler);
+	} else {
+		userpf_err(exec_get_xdev(exec), "Unhandled isr irq %d, is_ert %d, polling %d",
+			   irq, exec_is_ert(exec), exec->polling_mode);
+	}
+	SCHED_DEBUGF("<- xocl_user_event\n");
+	return IRQ_HANDLED;
+}
+
+/*
+ */
+struct exec_core *
+exec_create(struct platform_device *pdev, struct xocl_scheduler *xs)
+{
+	struct exec_core *exec = devm_kzalloc(&pdev->dev, sizeof(struct exec_core), GFP_KERNEL);
+	struct xocl_dev *xdev = xocl_get_xdev(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	static unsigned int count;
+	unsigned int i;
+
+	if (!exec)
+		return NULL;
+
+	mutex_init(&exec->exec_lock);
+	exec->base = xdev->core.bar_addr;
+
+	exec->intr_base = res->start;
+	exec->intr_num = res->end - res->start + 1;
+	exec->pdev = pdev;
+
+	init_waitqueue_head(&exec->poll_wait_queue);
+	exec->scheduler = xs;
+	exec->uid = count++;
+
+	for (i = 0; i < exec->intr_num; i++) {
+		xocl_user_interrupt_reg(xdev, i+exec->intr_base, exec_isr, exec);
+		xocl_user_interrupt_config(xdev, i + exec->intr_base, true);
+	}
+
+	exec_reset(exec);
+	platform_set_drvdata(pdev, exec);
+
+	SCHED_DEBUGF("%s(%d)\n", __func__, exec->uid);
+
+	return exec;
+}
+
+/*
+ */
+static void
+exec_destroy(struct exec_core *exec)
+{
+	int idx;
+
+	SCHED_DEBUGF("%s(%d)\n", __func__, exec->uid);
+	for (idx = 0; idx < exec->num_cus; ++idx)
+		cu_destroy(exec->cus[idx]);
+	if (exec->ert)
+		ert_destroy(exec->ert);
+	devm_kfree(&exec->pdev->dev, exec);
+}
+
+/*
+ */
+static inline struct xocl_scheduler *
+exec_scheduler(struct exec_core *exec)
+{
+	return exec->scheduler;
+}
+
+/*
+ * acquire_slot_idx() - First available slot index
+ */
+static unsigned int
+exec_acquire_slot_idx(struct exec_core *exec)
+{
+	unsigned int idx = find_first_zero_bit(exec->slot_status, MAX_SLOTS);
+
+	SCHED_DEBUGF("%s(%d) returns %d\n", __func__, exec->uid, idx < exec->num_slots ? idx : no_index);
+	if (idx < exec->num_slots) {
+		set_bit(idx, exec->slot_status);
+		return idx;
+	}
+	return no_index;
+}
+
+
+/**
+ * acquire_slot() - Acquire a slot index for a command
+ *
+ * This function makes a special case for control commands which
+ * must always dispatch to slot 0, otherwise normal acquisition
+ */
+static int
+exec_acquire_slot(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	// slot 0 is reserved for ctrl commands
+	if (cmd_type(xcmd) == ERT_CTRL) {
+		SCHED_DEBUGF("%s(%d,%lu) ctrl cmd\n", __func__, exec->uid, xcmd->uid);
+		if (exec->ctrl_busy)
+			return -1;
+		exec->ctrl_busy = true;
+		return (xcmd->slot_idx = 0);
+	}
+
+	return (xcmd->slot_idx = exec_acquire_slot_idx(exec));
+}
+
+/*
+ * release_slot_idx() - Release specified slot idx
+ */
+static void
+exec_release_slot_idx(struct exec_core *exec, unsigned int slot_idx)
+{
+	clear_bit(slot_idx, exec->slot_status);
+}
+
+/**
+ * release_slot() - Release a slot index for a command
+ *
+ * Special case for control commands that execute in slot 0.  This
+ * slot cannot be marked free ever.
+ */
+static void
+exec_release_slot(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	if (xcmd->slot_idx == no_index)
+		return; // already released
+
+	SCHED_DEBUGF("%s(%d) xcmd(%lu) slotidx(%d)\n",
+		     __func__, exec->uid, xcmd->uid, xcmd->slot_idx);
+	if (cmd_type(xcmd) == ERT_CTRL) {
+		SCHED_DEBUG("+ ctrl cmd\n");
+		exec->ctrl_busy = false;
+	} else {
+		exec_release_slot_idx(exec, xcmd->slot_idx);
+	}
+	xcmd->slot_idx = no_index;
+}
+
+/*
+ * submit_cmd() - Submit command for execution on this core
+ *
+ * Return: true on success, false if command could not be submitted
+ */
+static bool
+exec_submit_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	unsigned int slotidx = exec_acquire_slot(exec, xcmd);
+
+	if (slotidx == no_index)
+		return false;
+	SCHED_DEBUGF("%s(%d,%lu) slotidx(%d)\n", __func__, exec->uid, xcmd->uid, slotidx);
+	exec->submitted_cmds[slotidx] = xcmd;
+	cmd_set_int_state(xcmd, ERT_CMD_STATE_SUBMITTED);
+	return true;
+}
+
+/*
+ * finish_cmd() - Special post processing of commands after execution
+ */
+static int
+exec_finish_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	if (cmd_opcode(xcmd) == ERT_CU_STAT && exec_is_ert(exec))
+		ert_read_custat(exec->ert, exec->num_cus, exec->cu_usage, xcmd);
+	return 0;
+}
+
+/*
+ * execute_write_cmd() - Execute ERT_WRITE commands
+ */
+static int
+exec_execute_write_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	struct ert_packet *ecmd = xcmd->ecmd;
+	unsigned int idx = 0;
+
+	SCHED_DEBUGF("-> %s(%d,%lu)\n", __func__, exec->uid, xcmd->uid);
+	for (idx = 0; idx < ecmd->count - 1; idx += 2) {
+		u32 addr = ecmd->data[idx];
+		u32 val = ecmd->data[idx+1];
+
+		SCHED_DEBUGF("+ exec_write_cmd base[0x%x] = 0x%x\n", addr, val);
+		iowrite32(val, exec->base + addr);
+	}
+	SCHED_DEBUG("<- exec_write\n");
+	return 0;
+}
+
+/*
+ * notify_host() - Notify user space that a command is complete.
+ */
+static void
+exec_notify_host(struct exec_core *exec)
+{
+	struct list_head *ptr;
+	struct client_ctx *entry;
+	struct xocl_dev *xdev = exec_get_xdev(exec);
+
+	SCHED_DEBUGF("-> %s(%d)\n", __func__, exec->uid);
+
+	/* now for each client update the trigger counter in the context */
+	mutex_lock(&xdev->ctx_list_lock);
+	list_for_each(ptr, &xdev->ctx_list) {
+		entry = list_entry(ptr, struct client_ctx, link);
+		atomic_inc(&entry->trigger);
+	}
+	mutex_unlock(&xdev->ctx_list_lock);
+	/* wake up all the clients */
+	wake_up_interruptible(&exec->poll_wait_queue);
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/*
+ * exec_cmd_mark_complete() - Move a command to complete state
+ *
+ * Commands are marked complete in two ways
+ *  1. Through polling of CUs or polling of MB status register
+ *  2. Through interrupts from MB
+ *
+ * @xcmd: Command to mark complete
+ *
+ * The external command state is changed to complete and the host
+ * is notified that some command has completed.
+ */
+static void
+exec_mark_cmd_complete(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	SCHED_DEBUGF("-> %s(%d,%lu)\n", __func__, exec->uid, xcmd->uid);
+	if (cmd_type(xcmd) == ERT_CTRL)
+		exec_finish_cmd(exec, xcmd);
+
+	cmd_set_state(xcmd, ERT_CMD_STATE_COMPLETED);
+
+	if (exec->polling_mode)
+		scheduler_decr_poll(exec->scheduler);
+
+	exec_release_slot(exec, xcmd);
+	exec_notify_host(exec);
+
+	// Deactivate command and trigger chain of waiting commands
+	cmd_mark_deactive(xcmd);
+	cmd_trigger_chain(xcmd);
+
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/**
+ * mark_mask_complete() - Move all commands in mask to complete state
+ *
+ * @mask: Bitmask with queried statuses of commands
+ * @mask_idx: Index of the command mask. Used to offset the actual cmd slot index
+ *
+ * Used in ERT mode only.  Currently ERT submitted commands remain in exec
+ * submitted queue as ERT doesn't support data flow
+ */
+static void
+exec_mark_mask_complete(struct exec_core *exec, u32 mask, unsigned int mask_idx)
+{
+	int bit_idx = 0, cmd_idx = 0;
+
+	SCHED_DEBUGF("-> %s(0x%x,%d)\n", __func__, mask, mask_idx);
+	if (!mask)
+		return;
+
+	for (bit_idx = 0, cmd_idx = mask_idx<<5; bit_idx < 32; mask >>= 1, ++bit_idx, ++cmd_idx) {
+		// mask could be -1 when firewall trips, double check
+		// exec->submitted_cmds[cmd_idx] to make sure it's not NULL
+		if ((mask & 0x1) && exec->submitted_cmds[cmd_idx])
+			exec_mark_cmd_complete(exec, exec->submitted_cmds[cmd_idx]);
+	}
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/*
+ * penguin_start_cmd() - Start a command in penguin mode
+ */
+static bool
+exec_penguin_start_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	unsigned int cuidx;
+	u32 opcode = cmd_opcode(xcmd);
+
+	SCHED_DEBUGF("-> %s (%d,%lu) opcode(%d)\n", __func__, exec->uid, xcmd->uid, opcode);
+
+	if (opcode == ERT_WRITE && exec_execute_write_cmd(exec, xcmd)) {
+		cmd_set_state(xcmd, ERT_CMD_STATE_ERROR);
+		return false;
+	}
+
+	if (opcode != ERT_START_CU) {
+		SCHED_DEBUGF("<- %s -> true\n", __func__);
+		return true;
+	}
+
+	// Find a ready CU
+	for (cuidx = 0; cuidx < exec->num_cus; ++cuidx) {
+		struct xocl_cu *xcu = exec->cus[cuidx];
+
+		if (cmd_has_cu(xcmd, cuidx) && cu_ready(xcu) && cu_start(xcu, xcmd)) {
+			exec->submitted_cmds[xcmd->slot_idx] = NULL;
+			++exec->cu_usage[cuidx];
+			exec_release_slot(exec, xcmd);
+			xcmd->cu_idx = cuidx;
+			SCHED_DEBUGF("<- %s -> true\n", __func__);
+			return true;
+		}
+	}
+	SCHED_DEBUGF("<- %s -> false\n", __func__);
+	return false;
+}
+
+/**
+ * penguin_query() - Check command status of argument command
+ *
+ * @xcmd: Command to check
+ *
+ * Function is called in penguin mode (no embedded scheduler).
+ */
+static void
+exec_penguin_query_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	u32 cmdopcode = cmd_opcode(xcmd);
+	u32 cmdtype = cmd_type(xcmd);
+
+	SCHED_DEBUGF("-> %s(%lu) opcode(%d) type(%d) slot_idx=%d\n",
+		     __func__, xcmd->uid, cmdopcode, cmdtype, xcmd->slot_idx);
+
+	if (cmdtype == ERT_KDS_LOCAL || cmdtype == ERT_CTRL)
+		exec_mark_cmd_complete(exec, xcmd);
+	else if (cmdopcode == ERT_START_CU) {
+		struct xocl_cu *xcu = exec->cus[xcmd->cu_idx];
+
+		if (cu_first_done(xcu) == xcmd) {
+			cu_pop_done(xcu);
+			exec_mark_cmd_complete(exec, xcmd);
+		}
+	}
+
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+
+/*
+ * ert_start_cmd() - Start a command on ERT
+ */
+static bool
+exec_ert_start_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	// if (cmd_type(xcmd) == ERT_DATAFLOW)
+	//   exec_penguin_start_cmd(exec,xcmd);
+	return ert_start_cmd(exec->ert, xcmd);
+}
+
+/*
+ * ert_query_cmd() - Check command completion in ERT
+ *
+ * @xcmd: Command to check
+ *
+ * This function is for ERT mode.  In polling mode, check the command status
+ * register containing the slot assigned to the command.  In interrupt mode
+ * check the interrupting status register.  The function checks all commands
+ * in the same command status register as argument command so more than one
+ * command may be marked complete by this function.
+ */
+static void
+exec_ert_query_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	unsigned int cmd_mask_idx = slot_mask_idx(xcmd->slot_idx);
+
+	SCHED_DEBUGF("-> %s(%lu) slot_idx(%d), cmd_mask_idx(%d)\n", __func__, xcmd->uid, xcmd->slot_idx, cmd_mask_idx);
+
+	if (cmd_type(xcmd) == ERT_KDS_LOCAL) {
+		exec_mark_cmd_complete(exec, xcmd);
+		SCHED_DEBUGF("<- %s local command\n", __func__);
+		return;
+	}
+
+	if (exec->polling_mode
+	    || (cmd_mask_idx == 0 && atomic_xchg(&exec->sr0, 0))
+	    || (cmd_mask_idx == 1 && atomic_xchg(&exec->sr1, 0))
+	    || (cmd_mask_idx == 2 && atomic_xchg(&exec->sr2, 0))
+	    || (cmd_mask_idx == 3 && atomic_xchg(&exec->sr3, 0))) {
+		u32 csr_addr = ERT_STATUS_REGISTER_ADDR + (cmd_mask_idx<<2);
+		u32 mask = ioread32(xcmd->exec->base + csr_addr);
+
+		SCHED_DEBUGF("++ %s csr_addr=0x%x mask=0x%x\n", __func__, csr_addr, mask);
+		if (mask)
+			exec_mark_mask_complete(xcmd->exec, mask, cmd_mask_idx);
+	}
+
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/*
+ * start_cmd() - Start execution of a command
+ *
+ * Return: true if successfully started, false otherwise
+ *
+ * Function dispatches based on penguin vs ert mode
+ */
+static bool
+exec_start_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	// assert cmd had been submitted
+	SCHED_DEBUGF("%s(%d,%lu) opcode(%d)\n", __func__, exec->uid, xcmd->uid, cmd_opcode(xcmd));
+
+	if (exec->ops->start(exec, xcmd)) {
+		cmd_set_int_state(xcmd, ERT_CMD_STATE_RUNNING);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * query_cmd() - Check status of command
+ *
+ * Function dispatches based on penguin vs ert mode.  In ERT mode
+ * multiple commands can be marked complete by this function.
+ */
+static void
+exec_query_cmd(struct exec_core *exec, struct xocl_cmd *xcmd)
+{
+	SCHED_DEBUGF("%s(%d,%lu)\n", __func__, exec->uid, xcmd->uid);
+	exec->ops->query(exec, xcmd);
+}
+
+
+
+/**
+ * ert_ops: operations for ERT scheduling
+ */
+static struct exec_ops ert_ops = {
+	.start = exec_ert_start_cmd,
+	.query = exec_ert_query_cmd,
+};
+
+/**
+ * penguin_ops: operations for kernel mode scheduling
+ */
+static struct exec_ops penguin_ops = {
+	.start = exec_penguin_start_cmd,
+	.query = exec_penguin_query_cmd,
+};
+
+/*
+ */
+static inline struct exec_core *
+pdev_get_exec(struct platform_device *pdev)
+{
+	return platform_get_drvdata(pdev);
+}
+
+/*
+ */
+static inline struct exec_core *
+dev_get_exec(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return pdev ? pdev_get_exec(pdev) : NULL;
+}
+
+/*
+ */
+static inline struct xocl_dev *
+dev_get_xdev(struct device *dev)
+{
+	struct exec_core *exec = dev_get_exec(dev);
+
+	return exec ? exec_get_xdev(exec) : NULL;
+}
+
+/**
+ * List of new pending xocl_cmd objects
+ *
+ * @pending_cmds: populated from user space with new commands for buffer objects
+ * @num_pending: number of pending commands
+ *
+ * Scheduler copies pending commands to its private queue when necessary
+ */
+static LIST_HEAD(pending_cmds);
+static DEFINE_MUTEX(pending_cmds_mutex);
+static atomic_t num_pending = ATOMIC_INIT(0);
+
+static void
+pending_cmds_reset(void)
+{
+	/* clear stale command objects if any */
+	while (!list_empty(&pending_cmds)) {
+		struct xocl_cmd *xcmd = list_first_entry(&pending_cmds, struct xocl_cmd, cq_list);
+
+		DRM_INFO("deleting stale pending cmd\n");
+		cmd_free(xcmd);
+	}
+	atomic_set(&num_pending, 0);
+}
+
+/**
+ * struct xocl_sched: scheduler for xocl_cmd objects
+ *
+ * @scheduler_thread: thread associated with this scheduler
+ * @use_count: use count for this scheduler
+ * @wait_queue: conditional wait queue for scheduler thread
+ * @error: set to 1 to indicate scheduler error
+ * @stop: set to 1 to indicate scheduler should stop
+ * @reset: set to 1 to reset the scheduler
+ * @command_queue: list of command objects managed by scheduler
+ * @intc: boolean flag set when there is a pending interrupt for command completion
+ * @poll: number of running commands in polling mode
+ */
+struct xocl_scheduler {
+	struct task_struct	  *scheduler_thread;
+	unsigned int		   use_count;
+
+	wait_queue_head_t	   wait_queue;
+	unsigned int		   error;
+	unsigned int		   stop;
+	unsigned int		   reset;
+
+	struct list_head	   command_queue;
+
+	unsigned int		   intc; /* pending intr shared with isr, word aligned atomic */
+	unsigned int		   poll; /* number of cmds to poll */
+};
+
+static struct xocl_scheduler scheduler0;
+
+static void
+scheduler_reset(struct xocl_scheduler *xs)
+{
+	xs->error = 0;
+	xs->stop = 0;
+	xs->poll = 0;
+	xs->reset = false;
+	xs->intc = 0;
+}
+
+static void
+scheduler_cq_reset(struct xocl_scheduler *xs)
+{
+	while (!list_empty(&xs->command_queue)) {
+		struct xocl_cmd *xcmd = list_first_entry(&xs->command_queue, struct xocl_cmd, cq_list);
+
+		DRM_INFO("deleting stale scheduler cmd\n");
+		cmd_free(xcmd);
+	}
+}
+
+static void
+scheduler_wake_up(struct xocl_scheduler *xs)
+{
+	wake_up_interruptible(&xs->wait_queue);
+}
+
+static void
+scheduler_intr(struct xocl_scheduler *xs)
+{
+	xs->intc = 1;
+	scheduler_wake_up(xs);
+}
+
+static inline void
+scheduler_decr_poll(struct xocl_scheduler *xs)
+{
+	--xs->poll;
+}
+
+
+/**
+ * scheduler_queue_cmds() - Queue any pending commands
+ *
+ * The scheduler copies pending commands to its internal command queue where
+ * is is now in queued state.
+ */
+static void
+scheduler_queue_cmds(struct xocl_scheduler *xs)
+{
+	struct xocl_cmd *xcmd;
+	struct list_head *pos, *next;
+
+	SCHED_DEBUGF("-> %s\n", __func__);
+	mutex_lock(&pending_cmds_mutex);
+	list_for_each_safe(pos, next, &pending_cmds) {
+		xcmd = list_entry(pos, struct xocl_cmd, cq_list);
+		if (xcmd->xs != xs)
+			continue;
+		SCHED_DEBUGF("+ queueing cmd(%lu)\n", xcmd->uid);
+		list_del(&xcmd->cq_list);
+		list_add_tail(&xcmd->cq_list, &xs->command_queue);
+
+		/* chain active dependencies if any to this command object */
+		if (cmd_wait_count(xcmd) && cmd_chain_dependencies(xcmd))
+			cmd_set_state(xcmd, ERT_CMD_STATE_ERROR);
+		else
+			cmd_set_int_state(xcmd, ERT_CMD_STATE_QUEUED);
+
+		/* this command is now active and can chain other commands */
+		cmd_mark_active(xcmd);
+		atomic_dec(&num_pending);
+	}
+	mutex_unlock(&pending_cmds_mutex);
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/**
+ * queued_to_running() - Move a command from queued to running state if possible
+ *
+ * @xcmd: Command to start
+ *
+ * Upon success, the command is not necessarily running. In ert mode the
+ * command will have been submitted to the embedded scheduler, whereas in
+ * penguin mode the command has been started on a CU.
+ *
+ * Return: %true if command was submitted to device, %false otherwise
+ */
+static bool
+scheduler_queued_to_submitted(struct xocl_scheduler *xs, struct xocl_cmd *xcmd)
+{
+	struct exec_core *exec = cmd_exec(xcmd);
+	bool retval = false;
+
+	if (cmd_wait_count(xcmd))
+		return false;
+
+	SCHED_DEBUGF("-> %s(%lu) opcode(%d)\n", __func__, xcmd->uid, cmd_opcode(xcmd));
+
+	// configure prior to using the core
+	if (cmd_opcode(xcmd) == ERT_CONFIGURE && exec_cfg_cmd(exec, xcmd)) {
+		cmd_set_state(xcmd, ERT_CMD_STATE_ERROR);
+		return false;
+	}
+
+	// submit the command
+	if (exec_submit_cmd(exec, xcmd)) {
+		if (exec->polling_mode)
+			++xs->poll;
+		retval = true;
+	}
+
+	SCHED_DEBUGF("<- queued_to_submitted returns %d\n", retval);
+
+	return retval;
+}
+
+static bool
+scheduler_submitted_to_running(struct xocl_scheduler *xs, struct xocl_cmd *xcmd)
+{
+	return exec_start_cmd(cmd_exec(xcmd), xcmd);
+}
+
+/**
+ * running_to_complete() - Check status of running commands
+ *
+ * @xcmd: Command is in running state
+ *
+ * When ERT is enabled this function may mark more than just argument
+ * command as complete based on content of command completion register.
+ * Without ERT, only argument command is checked for completion.
+ */
+static void
+scheduler_running_to_complete(struct xocl_scheduler *xs, struct xocl_cmd *xcmd)
+{
+	exec_query_cmd(cmd_exec(xcmd), xcmd);
+}
+
+/**
+ * complete_to_free() - Recycle a complete command objects
+ *
+ * @xcmd: Command is in complete state
+ */
+static void
+scheduler_complete_to_free(struct xocl_scheduler *xs, struct xocl_cmd *xcmd)
+{
+	SCHED_DEBUGF("-> %s(%lu)\n", __func__, xcmd->uid);
+	cmd_free(xcmd);
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+static void
+scheduler_error_to_free(struct xocl_scheduler *xs, struct xocl_cmd *xcmd)
+{
+	SCHED_DEBUGF("-> %s(%lu)\n", __func__, xcmd->uid);
+	exec_notify_host(cmd_exec(xcmd));
+	scheduler_complete_to_free(xs, xcmd);
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+static void
+scheduler_abort_to_free(struct xocl_scheduler *xs, struct xocl_cmd *xcmd)
+{
+	SCHED_DEBUGF("-> %s(%lu)\n", __func__, xcmd->uid);
+	scheduler_error_to_free(xs, xcmd);
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/**
+ * scheduler_iterator_cmds() - Iterate all commands in scheduler command queue
+ */
+static void
+scheduler_iterate_cmds(struct xocl_scheduler *xs)
+{
+	struct list_head *pos, *next;
+
+	SCHED_DEBUGF("-> %s\n", __func__);
+	list_for_each_safe(pos, next, &xs->command_queue) {
+		struct xocl_cmd *xcmd = list_entry(pos, struct xocl_cmd, cq_list);
+
+		cmd_update_state(xcmd);
+		SCHED_DEBUGF("+ processing cmd(%lu)\n", xcmd->uid);
+
+		/* check running first since queued maybe we waiting for cmd slot */
+		if (xcmd->state == ERT_CMD_STATE_QUEUED)
+			scheduler_queued_to_submitted(xs, xcmd);
+		if (xcmd->state == ERT_CMD_STATE_SUBMITTED)
+			scheduler_submitted_to_running(xs, xcmd);
+		if (xcmd->state == ERT_CMD_STATE_RUNNING)
+			scheduler_running_to_complete(xs, xcmd);
+		if (xcmd->state == ERT_CMD_STATE_COMPLETED)
+			scheduler_complete_to_free(xs, xcmd);
+		if (xcmd->state == ERT_CMD_STATE_ERROR)
+			scheduler_error_to_free(xs, xcmd);
+		if (xcmd->state == ERT_CMD_STATE_ABORT)
+			scheduler_abort_to_free(xs, xcmd);
+	}
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
+
+/**
+ * scheduler_wait_condition() - Check status of scheduler wait condition
+ *
+ * Scheduler must wait (sleep) if
+ *   1. there are no pending commands
+ *   2. no pending interrupt from embedded scheduler
+ *   3. no pending complete commands in polling mode
+ *
+ * Return: 1 if scheduler must wait, 0 othewise
+ */
+static int
+scheduler_wait_condition(struct xocl_scheduler *xs)
+{
+	if (kthread_should_stop()) {
+		xs->stop = 1;
+		SCHED_DEBUG("scheduler wakes kthread_should_stop\n");
+		return 0;
+	}
+
+	if (atomic_read(&num_pending)) {
+		SCHED_DEBUG("scheduler wakes to copy new pending commands\n");
+		return 0;
+	}
+
+	if (xs->intc) {
+		SCHED_DEBUG("scheduler wakes on interrupt\n");
+		xs->intc = 0;
+		return 0;
+	}
+
+	if (xs->poll) {
+		SCHED_DEBUG("scheduler wakes to poll\n");
+		return 0;
+	}
+
+	SCHED_DEBUG("scheduler waits ...\n");
+	return 1;
+}
+
+/**
+ * scheduler_wait() - check if scheduler should wait
+ *
+ * See scheduler_wait_condition().
+ */
+static void
+scheduler_wait(struct xocl_scheduler *xs)
+{
+	wait_event_interruptible(xs->wait_queue, scheduler_wait_condition(xs) == 0);
+}
+
+/**
+ * scheduler_loop() - Run one loop of the scheduler
+ */
+static void
+scheduler_loop(struct xocl_scheduler *xs)
+{
+	static unsigned int loop_cnt;
+
+	SCHED_DEBUGF("%s\n", __func__);
+	scheduler_wait(xs);
+
+	if (xs->error)
+		DRM_INFO("scheduler encountered unexpected error\n");
+
+	if (xs->stop)
+		return;
+
+	if (xs->reset) {
+		SCHED_DEBUG("scheduler is resetting after timeout\n");
+		scheduler_reset(xs);
+	}
+
+	/* queue new pending commands */
+	scheduler_queue_cmds(xs);
+
+	/* iterate all commands */
+	scheduler_iterate_cmds(xs);
+
+	// loop 8 times before explicitly yielding
+	if (++loop_cnt == 8) {
+		loop_cnt = 0;
+		schedule();
+	}
+}
+
+/**
+ * scheduler() - Command scheduler thread routine
+ */
+static int
+scheduler(void *data)
+{
+	struct xocl_scheduler *xs = (struct xocl_scheduler *)data;
+
+	while (!xs->stop)
+		scheduler_loop(xs);
+	DRM_INFO("%s:%d %s thread exits with value %d\n", __FILE__, __LINE__, __func__, xs->error);
+	return xs->error;
+}
+
+
+
+/**
+ * add_xcmd() - Add initialized xcmd object to pending command list
+ *
+ * @xcmd: Command to add
+ *
+ * Scheduler copies pending commands to its internal command queue.
+ *
+ * Return: 0 on success
+ */
+static int
+add_xcmd(struct xocl_cmd *xcmd)
+{
+	struct exec_core *exec = xcmd->exec;
+	struct xocl_dev *xdev = xocl_get_xdev(exec->pdev);
+
+	// Prevent stop and reset
+	mutex_lock(&exec->exec_lock);
+
+	SCHED_DEBUGF("-> %s(%lu) pid(%d)\n", __func__, xcmd->uid, pid_nr(task_tgid(current)));
+	SCHED_DEBUGF("+ exec stopped(%d) configured(%d)\n", exec->stopped, exec->configured);
+
+	if (exec->stopped || (!exec->configured && cmd_opcode(xcmd) != ERT_CONFIGURE))
+		goto err;
+
+	cmd_set_state(xcmd, ERT_CMD_STATE_NEW);
+	mutex_lock(&pending_cmds_mutex);
+	list_add_tail(&xcmd->cq_list, &pending_cmds);
+	atomic_inc(&num_pending);
+	mutex_unlock(&pending_cmds_mutex);
+
+	/* wake scheduler */
+	atomic_inc(&xdev->outstanding_execs);
+	atomic64_inc(&xdev->total_execs);
+	scheduler_wake_up(xcmd->xs);
+
+	SCHED_DEBUGF("<- %s ret(0) opcode(%d) type(%d) num_pending(%d)\n",
+		     __func__, cmd_opcode(xcmd), cmd_type(xcmd), atomic_read(&num_pending));
+	mutex_unlock(&exec->exec_lock);
+	return 0;
+
+err:
+	SCHED_DEBUGF("<- %s ret(1) opcode(%d) type(%d) num_pending(%d)\n",
+		     __func__, cmd_opcode(xcmd), cmd_type(xcmd), atomic_read(&num_pending));
+	mutex_unlock(&exec->exec_lock);
+	return 1;
+}
+
+
+/**
+ * add_bo_cmd() - Add a new buffer object command to pending list
+ *
+ * @exec: Targeted device
+ * @client: Client context
+ * @bo: Buffer objects from user space from which new command is created
+ * @numdeps: Number of dependencies for this command
+ * @deps: List of @numdeps dependencies
+ *
+ * Scheduler copies pending commands to its internal command queue.
+ *
+ * Return: 0 on success, 1 on failure
+ */
+static int
+add_bo_cmd(struct exec_core *exec, struct client_ctx *client, struct drm_xocl_bo *bo,
+	   int numdeps, struct drm_xocl_bo **deps)
+{
+	struct xocl_cmd *xcmd = cmd_get(exec_scheduler(exec), exec, client);
+
+	if (!xcmd)
+		return 1;
+
+	SCHED_DEBUGF("-> %s(%lu)\n", __func__, xcmd->uid);
+
+	cmd_bo_init(xcmd, bo, numdeps, deps, !exec_is_ert(exec));
+
+	if (add_xcmd(xcmd))
+		goto err;
+
+	SCHED_DEBUGF("<- %s ret(0) opcode(%d) type(%d)\n", __func__, cmd_opcode(xcmd), cmd_type(xcmd));
+	return 0;
+err:
+	cmd_abort(xcmd);
+	SCHED_DEBUGF("<- %s ret(1) opcode(%d) type(%d)\n", __func__, cmd_opcode(xcmd), cmd_type(xcmd));
+	return 1;
+}
+
+static int
+add_ctrl_cmd(struct exec_core *exec, struct client_ctx *client, struct ert_packet *packet)
+{
+	struct xocl_cmd *xcmd = cmd_get(exec_scheduler(exec), exec, client);
+
+	if (!xcmd)
+		return 1;
+
+	SCHED_DEBUGF("-> %s(%lu)\n", __func__, xcmd->uid);
+
+	cmd_packet_init(xcmd, packet);
+
+	if (add_xcmd(xcmd))
+		goto err;
+
+	SCHED_DEBUGF("<- %s ret(0) opcode(%d) type(%d)\n", __func__, cmd_opcode(xcmd), cmd_type(xcmd));
+	return 0;
+err:
+	cmd_abort(xcmd);
+	SCHED_DEBUGF("<- %s ret(1) opcode(%d) type(%d)\n", __func__, cmd_opcode(xcmd), cmd_type(xcmd));
+	return 1;
+}
+
+
+/**
+ * init_scheduler_thread() - Initialize scheduler thread if necessary
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+static int
+init_scheduler_thread(struct xocl_scheduler *xs)
+{
+	SCHED_DEBUGF("%s use_count=%d\n", __func__, xs->use_count);
+	if (xs->use_count++)
+		return 0;
+
+	init_waitqueue_head(&xs->wait_queue);
+	INIT_LIST_HEAD(&xs->command_queue);
+	scheduler_reset(xs);
+
+	xs->scheduler_thread = kthread_run(scheduler, (void *)xs, "xocl-scheduler-thread0");
+	if (IS_ERR(xs->scheduler_thread)) {
+		int ret = PTR_ERR(xs->scheduler_thread);
+
+		DRM_ERROR(__func__);
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * fini_scheduler_thread() - Finalize scheduler thread if unused
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+static int
+fini_scheduler_thread(struct xocl_scheduler *xs)
+{
+	int retval = 0;
+
+	SCHED_DEBUGF("%s use_count=%d\n", __func__, xs->use_count);
+	if (--xs->use_count)
+		return 0;
+
+	retval = kthread_stop(xs->scheduler_thread);
+
+	/* clear stale command objects if any */
+	pending_cmds_reset();
+	scheduler_cq_reset(xs);
+
+	/* reclaim memory for allocate command objects */
+	cmd_list_delete();
+
+	return retval;
+}
+
+/**
+ * Entry point for exec buffer.
+ *
+ * Function adds exec buffer to the pending list of commands
+ */
+int
+add_exec_buffer(struct platform_device *pdev, struct client_ctx *client, void *buf,
+		int numdeps, struct drm_xocl_bo **deps)
+{
+	struct exec_core *exec = platform_get_drvdata(pdev);
+	// Add the command to pending list
+	return add_bo_cmd(exec, client, buf, numdeps, deps);
+}
+
+static int
+xocl_client_lock_bitstream_nolock(struct xocl_dev *xdev, struct client_ctx *client)
+{
+	int pid = pid_nr(task_tgid(current));
+	uuid_t *xclbin_id;
+
+	if (client->xclbin_locked)
+		return 0;
+
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+	if (!xclbin_id || !uuid_equal(xclbin_id, &client->xclbin_id)) {
+		userpf_err(xdev,
+			   "device xclbin does not match context xclbin, cannot obtain lock for process %d",
+			   pid);
+		return 1;
+	}
+
+	if (xocl_icap_lock_bitstream(xdev, &client->xclbin_id, pid) < 0) {
+		userpf_err(xdev, "could not lock bitstream for process %d", pid);
+		return 1;
+	}
+
+	client->xclbin_locked = true;
+	userpf_info(xdev, "process %d successfully locked xcblin", pid);
+	return 0;
+}
+
+static int
+xocl_client_lock_bitstream(struct xocl_dev *xdev, struct client_ctx *client)
+{
+	int ret = 0;
+
+	mutex_lock(&client->lock);	   // protect current client
+	mutex_lock(&xdev->ctx_list_lock);  // protect xdev->xclbin_id
+	ret = xocl_client_lock_bitstream_nolock(xdev, client);
+	mutex_unlock(&xdev->ctx_list_lock);
+	mutex_unlock(&client->lock);
+	return ret;
+}
+
+
+static int
+create_client(struct platform_device *pdev, void **priv)
+{
+	struct client_ctx	*client;
+	struct xocl_dev		*xdev = xocl_get_xdev(pdev);
+	int			ret = 0;
+
+	client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	mutex_lock(&xdev->ctx_list_lock);
+
+	if (!xdev->offline) {
+		client->pid = task_tgid(current);
+		mutex_init(&client->lock);
+		client->xclbin_locked = false;
+		client->abort = false;
+		atomic_set(&client->trigger, 0);
+		atomic_set(&client->outstanding_execs, 0);
+		client->num_cus = 0;
+		client->xdev = xocl_get_xdev(pdev);
+		list_add_tail(&client->link, &xdev->ctx_list);
+		*priv =	 client;
+	} else {
+		/* Do not allow new client to come in while being offline. */
+		devm_kfree(&pdev->dev, client);
+		ret = -EBUSY;
+	}
+
+	mutex_unlock(&xdev->ctx_list_lock);
+
+	DRM_INFO("creating scheduler client for pid(%d), ret: %d\n",
+		 pid_nr(task_tgid(current)), ret);
+
+	return ret;
+}
+
+static void destroy_client(struct platform_device *pdev, void **priv)
+{
+	struct client_ctx *client = (struct client_ctx *)(*priv);
+	struct exec_core *exec = platform_get_drvdata(pdev);
+	struct xocl_scheduler *xs = exec_scheduler(exec);
+	struct xocl_dev	*xdev = xocl_get_xdev(pdev);
+	unsigned int	outstanding = atomic_read(&client->outstanding_execs);
+	unsigned int	timeout_loops = 20;
+	unsigned int	loops = 0;
+	int pid = pid_nr(task_tgid(current));
+	unsigned int bit;
+	struct ip_layout *layout = XOCL_IP_LAYOUT(xdev);
+
+	bit = layout
+	  ? find_first_bit(client->cu_bitmap, layout->m_count)
+	  : MAX_CUS;
+
+	/*
+	 * This happens when application exists without formally releasing the
+	 * contexts on CUs. Give up our contexts on CUs and our lock on xclbin.
+	 * Note, that implicit CUs (such as CDMA) do not add to ip_reference.
+	 */
+	while (layout && (bit < layout->m_count)) {
+		if (exec->ip_reference[bit]) {
+			userpf_info(xdev, "CTX reclaim (%pUb, %d, %u)",
+				&client->xclbin_id, pid, bit);
+			exec->ip_reference[bit]--;
+		}
+		bit = find_next_bit(client->cu_bitmap, layout->m_count, bit + 1);
+	}
+	bitmap_zero(client->cu_bitmap, MAX_CUS);
+
+	// force scheduler to abort execs for this client
+	client->abort = true;
+
+	// wait for outstanding execs to finish
+	while (outstanding) {
+		unsigned int new;
+
+		userpf_info(xdev, "waiting for %d outstanding execs to finish", outstanding);
+		msleep(500);
+		new = atomic_read(&client->outstanding_execs);
+		loops = (new == outstanding ? (loops + 1) : 0);
+		if (loops == timeout_loops) {
+			userpf_err(xdev,
+				   "Giving up with %d outstanding execs, please reset device with 'xbutil reset'\n",
+				   outstanding);
+			xdev->needs_reset = true;
+			// reset the scheduler loop
+			xs->reset = true;
+			break;
+		}
+		outstanding = new;
+	}
+
+	DRM_INFO("client exits pid(%d)\n", pid);
+
+	mutex_lock(&xdev->ctx_list_lock);
+	list_del(&client->link);
+	mutex_unlock(&xdev->ctx_list_lock);
+
+	if (client->xclbin_locked)
+		xocl_icap_unlock_bitstream(xdev, &client->xclbin_id, pid);
+	mutex_destroy(&client->lock);
+	devm_kfree(&pdev->dev, client);
+	*priv = NULL;
+}
+
+static uint poll_client(struct platform_device *pdev, struct file *filp,
+	poll_table *wait, void *priv)
+{
+	struct client_ctx	*client = (struct client_ctx *)priv;
+	struct exec_core	*exec;
+	int			counter;
+	uint			ret = 0;
+
+	exec = platform_get_drvdata(pdev);
+
+	poll_wait(filp, &exec->poll_wait_queue, wait);
+
+	/*
+	 * Mutex lock protects from two threads from the same application
+	 * calling poll concurrently using the same file handle
+	 */
+	mutex_lock(&client->lock);
+	counter = atomic_read(&client->trigger);
+	if (counter > 0) {
+		/*
+		 * Use atomic here since the trigger may be incremented by
+		 * interrupt handler running concurrently.
+		 */
+		atomic_dec(&client->trigger);
+		ret = POLLIN;
+	}
+	mutex_unlock(&client->lock);
+
+	return ret;
+}
+
+static int client_ioctl_ctx(struct platform_device *pdev,
+			    struct client_ctx *client, void *data)
+{
+	bool acquire_lock = false;
+	struct drm_xocl_ctx *args = data;
+	int ret = 0;
+	int pid = pid_nr(task_tgid(current));
+	struct xocl_dev	*xdev = xocl_get_xdev(pdev);
+	struct exec_core *exec = platform_get_drvdata(pdev);
+	uuid_t *xclbin_id;
+
+	mutex_lock(&client->lock);
+	mutex_lock(&xdev->ctx_list_lock);
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+	if (!xclbin_id || !uuid_equal(xclbin_id, &args->xclbin_id)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (args->cu_index >= XOCL_IP_LAYOUT(xdev)->m_count) {
+		userpf_err(xdev, "cuidx(%d) >= numcus(%d)\n",
+			   args->cu_index, XOCL_IP_LAYOUT(xdev)->m_count);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (args->op == XOCL_CTX_OP_FREE_CTX) {
+		ret = test_and_clear_bit(args->cu_index, client->cu_bitmap) ? 0 : -EINVAL;
+		if (ret) // No context was previously allocated for this CU
+			goto out;
+
+		// CU unlocked explicitly
+		--exec->ip_reference[args->cu_index];
+		if (!--client->num_cus) {
+			// We just gave up the last context, unlock the xclbin
+			ret = xocl_icap_unlock_bitstream(xdev, xclbin_id, pid);
+			client->xclbin_locked = false;
+		}
+		userpf_info(xdev, "CTX del(%pUb, %d, %u)",
+			    xclbin_id, pid, args->cu_index);
+		goto out;
+	}
+
+	if (args->op != XOCL_CTX_OP_ALLOC_CTX) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (args->flags != XOCL_CTX_SHARED) {
+		userpf_err(xdev, "Only shared contexts are supported in this release");
+		ret = -EPERM;
+		goto out;
+	}
+
+	if (!client->num_cus && !client->xclbin_locked)
+		// Process has no other context on any CU yet, hence we need to
+		// lock the xclbin A process uses just one lock for all its ctxs
+		acquire_lock = true;
+
+	if (test_and_set_bit(args->cu_index, client->cu_bitmap)) {
+		userpf_info(xdev, "CTX already allocated by this process");
+		// Context was previously allocated for the same CU,
+		// cannot allocate again
+		ret = 0;
+		goto out;
+	}
+
+	if (acquire_lock) {
+		// This is the first context on any CU for this process,
+		// lock the xclbin
+		ret = xocl_client_lock_bitstream_nolock(xdev, client);
+		if (ret) {
+			// Locking of xclbin failed, give up our context
+			clear_bit(args->cu_index, client->cu_bitmap);
+			goto out;
+		} else {
+			uuid_copy(&client->xclbin_id, xclbin_id);
+		}
+	}
+
+	// Everything is good so far, hence increment the CU reference count
+	++client->num_cus; // explicitly acquired
+	++exec->ip_reference[args->cu_index];
+	xocl_info(&pdev->dev, "CTX add(%pUb, %d, %u, %d)",
+		  xclbin_id, pid, args->cu_index, acquire_lock);
+out:
+	mutex_unlock(&xdev->ctx_list_lock);
+	mutex_unlock(&client->lock);
+	return ret;
+}
+
+static int
+get_bo_paddr(struct xocl_dev *xdev, struct drm_file *filp,
+	     uint32_t bo_hdl, size_t off, size_t size, uint64_t *paddrp)
+{
+	struct drm_device *ddev = filp->minor->dev;
+	struct drm_gem_object *obj;
+	struct drm_xocl_bo *xobj;
+
+	obj = xocl_gem_object_lookup(ddev, filp, bo_hdl);
+	if (!obj) {
+		userpf_err(xdev, "Failed to look up GEM BO 0x%x\n", bo_hdl);
+		return -ENOENT;
+	}
+	xobj = to_xocl_bo(obj);
+
+	if (obj->size <= off || obj->size < off + size || !xobj->mm_node) {
+		userpf_err(xdev, "Failed to get paddr for BO 0x%x\n", bo_hdl);
+//PORT4_20
+//		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
+		return -EINVAL;
+	}
+
+	*paddrp = xobj->mm_node->start + off;
+//	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
+	return 0;
+}
+
+static int
+convert_execbuf(struct xocl_dev *xdev, struct drm_file *filp,
+		struct exec_core *exec, struct drm_xocl_bo *xobj)
+{
+	int i;
+	int ret;
+	size_t src_off;
+	size_t dst_off;
+	size_t sz;
+	uint64_t src_addr;
+	uint64_t dst_addr;
+	struct ert_start_copybo_cmd *scmd = (struct ert_start_copybo_cmd *)xobj->vmapping;
+
+	/* Only convert COPYBO cmd for now. */
+	if (scmd->opcode != ERT_START_COPYBO)
+		return 0;
+
+	sz = scmd->size * COPYBO_UNIT;
+
+	src_off = scmd->src_addr_hi;
+	src_off <<= 32;
+	src_off |= scmd->src_addr_lo;
+	ret = get_bo_paddr(xdev, filp, scmd->src_bo_hdl, src_off, sz, &src_addr);
+	if (ret != 0)
+		return ret;
+
+	dst_off = scmd->dst_addr_hi;
+	dst_off <<= 32;
+	dst_off |= scmd->dst_addr_lo;
+	ret = get_bo_paddr(xdev, filp, scmd->dst_bo_hdl, dst_off, sz, &dst_addr);
+	if (ret != 0)
+		return ret;
+
+	ert_fill_copybo_cmd(scmd, 0, 0, src_addr, dst_addr, sz);
+
+	for (i = exec->num_cus - exec->num_cdma; i < exec->num_cus; i++)
+		scmd->cu_mask[i / 32] |= 1 << (i % 32);
+
+	scmd->opcode = ERT_START_CU;
+
+	return 0;
+}
+
+static int
+client_ioctl_execbuf(struct platform_device *pdev,
+		     struct client_ctx *client, void *data, struct drm_file *filp)
+{
+	struct drm_xocl_execbuf *args = data;
+	struct drm_xocl_bo *xobj;
+	struct drm_gem_object *obj;
+	struct drm_xocl_bo *deps[8] = {0};
+	int numdeps = -1;
+	int ret = 0;
+	struct xocl_dev	*xdev = xocl_get_xdev(pdev);
+	struct drm_device *ddev = filp->minor->dev;
+
+	if (xdev->needs_reset) {
+		userpf_err(xdev, "device needs reset, use 'xbutil reset -h'");
+		return -EBUSY;
+	}
+
+	/* Look up the gem object corresponding to the BO handle.
+	 * This adds a reference to the gem object.  The refernece is
+	 * passed to kds or released here if errors occur.
+	 */
+	obj = xocl_gem_object_lookup(ddev, filp, args->exec_bo_handle);
+	if (!obj) {
+		userpf_err(xdev, "Failed to look up GEM BO %d\n",
+		args->exec_bo_handle);
+		return -ENOENT;
+	}
+
+	/* Convert gem object to xocl_bo extension */
+	xobj = to_xocl_bo(obj);
+	if (!xocl_bo_execbuf(xobj) || convert_execbuf(xdev, filp,
+		platform_get_drvdata(pdev), xobj) != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = validate(pdev, client, xobj);
+	if (ret) {
+		userpf_err(xdev, "Exec buffer validation failed\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Copy dependencies from user.	 It is an error if a BO handle specified
+	 * as a dependency does not exists. Lookup gem object corresponding to bo
+	 * handle.  Convert gem object to xocl_bo extension.  Note that the
+	 * gem lookup acquires a reference to the drm object, this reference
+	 * is passed on to the the scheduler via xocl_exec_add_buffer.
+	 */
+	for (numdeps = 0; numdeps < 8 && args->deps[numdeps]; ++numdeps) {
+		struct drm_gem_object *gobj =
+		  xocl_gem_object_lookup(ddev, filp, args->deps[numdeps]);
+		struct drm_xocl_bo *xbo = gobj ? to_xocl_bo(gobj) : NULL;
+
+		if (!gobj)
+			userpf_err(xdev, "Failed to look up GEM BO %d\n",
+				   args->deps[numdeps]);
+		if (!xbo) {
+			ret = -EINVAL;
+			goto out;
+		}
+		deps[numdeps] = xbo;
+	}
+
+	/* acquire lock on xclbin if necessary */
+	ret = xocl_client_lock_bitstream(xdev, client);
+	if (ret) {
+		userpf_err(xdev, "Failed to lock xclbin\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Add exec buffer to scheduler (kds).	The scheduler manages the
+	 * drm object references acquired by xobj and deps.  It is vital
+	 * that the references are released properly.
+	 */
+	ret = add_exec_buffer(pdev, client, xobj, numdeps, deps);
+	if (ret) {
+		userpf_err(xdev, "Failed to add exec buffer to scheduler\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Return here, noting that the gem objects passed to kds have
+	 * references that must be released by kds itself.  User manages
+	 * a regular reference to all BOs returned as file handles.  These
+	 * references are released with the BOs are freed.
+	 */
+	return ret;
+
+out:
+	for (--numdeps; numdeps >= 0; numdeps--)
+		drm_gem_object_put_unlocked(&deps[numdeps]->base);
+//PORT4_20
+//		drm_gem_object_unreference_unlocked(&deps[numdeps]->base);
+	drm_gem_object_put_unlocked(&xobj->base);
+//	drm_gem_object_unreference_unlocked(&xobj->base);
+	return ret;
+}
+
+int
+client_ioctl(struct platform_device *pdev, int op, void *data, void *drm_filp)
+{
+	struct drm_file *filp = drm_filp;
+	struct client_ctx *client = filp->driver_priv;
+	int ret;
+
+	switch (op) {
+	case DRM_XOCL_CTX:
+		ret = client_ioctl_ctx(pdev, client, data);
+		break;
+	case DRM_XOCL_EXECBUF:
+		ret = client_ioctl_execbuf(pdev, client, data, drm_filp);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+/**
+ * reset() - Reset device exec data structure
+ *
+ * @pdev: platform device to reset
+ *
+ * [Current 2018.3 situation:]
+ * This function is currently called from mgmt icap on every AXI is
+ * freeze/unfreeze.  It ensures that the device exec_core state is reset to
+ * same state as was when scheduler was originally probed for the device.
+ * The callback from icap, ensures that scheduler resets the exec core when
+ * multiple processes are already attached to the device but AXI is reset.
+ *
+ * Even though the very first client created for this device also resets the
+ * exec core, it is possible that further resets are necessary.	 For example
+ * in multi-process case, there can be 'n' processes that attach to the
+ * device.  On first client attach the exec core is reset correctly, but now
+ * assume that 'm' of these processes finishes completely before any remaining
+ * (n-m) processes start using the scheduler.  In this case, the n-m clients have
+ * already been created, but icap resets AXI because the xclbin has no
+ * references (arguably this AXI reset is wrong)
+ *
+ * [Work-in-progress:]
+ * Proper contract:
+ *  Pre-condition: xocl_exec_stop has been called before xocl_exec_reset.
+ *  Pre-condition: new bitstream has been downloaded and AXI has been reset
+ */
+static int
+reset(struct platform_device *pdev)
+{
+	struct exec_core *exec = platform_get_drvdata(pdev);
+
+	exec_stop(exec);   // remove when upstream explicitly calls stop()
+	exec_reset(exec);
+	return 0;
+}
+
+/**
+ * stop() - Reset device exec data structure
+ *
+ * This API must be called prior to performing an AXI reset and downloading of
+ * a new xclbin.  Calling this API flushes the commands running on current
+ * device and prevents new commands from being scheduled on the device.	 This
+ * effectively prevents 'xbutil top' from issuing CU_STAT commands while
+ * programming is performed.
+ *
+ * Pre-condition: xocl_client_release has been called, e.g there are no
+ *		  current clients using the bitstream
+ */
+static int
+stop(struct platform_device *pdev)
+{
+	struct exec_core *exec = platform_get_drvdata(pdev);
+
+	exec_stop(exec);
+	return 0;
+}
+
+/**
+ * validate() - Check if requested cmd is valid in the current context
+ */
+static int
+validate(struct platform_device *pdev, struct client_ctx *client, const struct drm_xocl_bo *bo)
+{
+	struct ert_packet *ecmd = (struct ert_packet *)bo->vmapping;
+	struct ert_start_kernel_cmd *scmd = (struct ert_start_kernel_cmd *)bo->vmapping;
+	unsigned int i = 0;
+	u32 ctx_cus[4] = {0};
+	u32 cumasks = 0;
+	int err = 0;
+
+	SCHED_DEBUGF("-> %s(%d)\n", __func__, ecmd->opcode);
+
+	/* cus for start kernel commands only */
+	if (ecmd->opcode != ERT_START_CU)
+		return 0; /* ok */
+
+	/* client context cu bitmap may not change while validating */
+	mutex_lock(&client->lock);
+
+	/* no specific CUs selected, maybe ctx is not used by client */
+	if (bitmap_empty(client->cu_bitmap, MAX_CUS)) {
+		userpf_err(xocl_get_xdev(pdev), "%s found no CUs in ctx\n", __func__);
+		goto out; /* ok */
+	}
+
+	/* Check CUs in cmd BO against CUs in context */
+	cumasks = 1 + scmd->extra_cu_masks;
+	xocl_bitmap_to_arr32(ctx_cus, client->cu_bitmap, cumasks * 32);
+
+	for (i = 0; i < cumasks; ++i) {
+		uint32_t cmd_cus = ecmd->data[i];
+		/* cmd_cus must be subset of ctx_cus */
+		if (cmd_cus & ~ctx_cus[i]) {
+			SCHED_DEBUGF("<- %s(1), CU mismatch in mask(%d) cmd(0x%x) ctx(0x%x)\n",
+				     __func__, i, cmd_cus, ctx_cus[i]);
+			err = 1;
+			goto out; /* error */
+		}
+	}
+
+
+out:
+	mutex_unlock(&client->lock);
+	SCHED_DEBUGF("<- %s(%d) cmd and ctx CUs match\n", __func__, err);
+	return err;
+
+}
+
+struct xocl_mb_scheduler_funcs sche_ops = {
+	.create_client = create_client,
+	.destroy_client = destroy_client,
+	.poll_client = poll_client,
+	.client_ioctl = client_ioctl,
+	.stop = stop,
+	.reset = reset,
+};
+
+/* sysfs */
+static ssize_t
+kds_numcus_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct exec_core *exec = dev_get_exec(dev);
+	unsigned int cus = exec ? exec->num_cus - exec->num_cdma : 0;
+
+	return sprintf(buf, "%d\n", cus);
+}
+static DEVICE_ATTR_RO(kds_numcus);
+
+static ssize_t
+kds_numcdmas_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_xdev(dev);
+	uint32_t *cdma = xocl_cdma_addr(xdev);
+	unsigned int cdmas = cdma ? 1 : 0; //TBD
+
+	return sprintf(buf, "%d\n", cdmas);
+}
+static DEVICE_ATTR_RO(kds_numcdmas);
+
+static ssize_t
+kds_custat_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct exec_core *exec = dev_get_exec(dev);
+	struct xocl_dev *xdev = exec_get_xdev(exec);
+	struct client_ctx client;
+	struct ert_packet packet;
+	unsigned int count = 0;
+	ssize_t sz = 0;
+
+	// minimum required initialization of client
+	client.abort = false;
+	client.xdev = xdev;
+	atomic_set(&client.trigger, 0);
+	atomic_set(&client.outstanding_execs, 0);
+
+	packet.opcode = ERT_CU_STAT;
+	packet.type = ERT_CTRL;
+	packet.count = 1;  // data[1]
+
+	if (add_ctrl_cmd(exec, &client, &packet) == 0) {
+		int retry = 5;
+
+		SCHED_DEBUGF("-> custat waiting for command to finish\n");
+		// wait for command completion
+		while (--retry && atomic_read(&client.outstanding_execs))
+			msleep(100);
+		if (retry == 0 && atomic_read(&client.outstanding_execs))
+			userpf_info(xdev, "custat unexpected timeout\n");
+		SCHED_DEBUGF("<- custat retry(%d)\n", retry);
+	}
+
+	for (count = 0; count < exec->num_cus; ++count)
+		sz += sprintf(buf+sz, "CU[@0x%x] : %d\n",
+			      exec_cu_base_addr(exec, count),
+			      exec_cu_usage(exec, count));
+	if (sz)
+		buf[sz++] = 0;
+
+	return sz;
+}
+static DEVICE_ATTR_RO(kds_custat);
+
+static struct attribute *kds_sysfs_attrs[] = {
+	&dev_attr_kds_numcus.attr,
+	&dev_attr_kds_numcdmas.attr,
+	&dev_attr_kds_custat.attr,
+	NULL
+};
+
+static const struct attribute_group kds_sysfs_attr_group = {
+	.attrs = kds_sysfs_attrs,
+};
+
+static void
+user_sysfs_destroy_kds(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &kds_sysfs_attr_group);
+}
+
+static int
+user_sysfs_create_kds(struct platform_device *pdev)
+{
+	int err = sysfs_create_group(&pdev->dev.kobj, &kds_sysfs_attr_group);
+
+	if (err)
+		userpf_err(xocl_get_xdev(pdev), "create kds attr failed: 0x%x", err);
+	return err;
+}
+
+/**
+ * Init scheduler
+ */
+static int mb_scheduler_probe(struct platform_device *pdev)
+{
+	struct exec_core *exec = exec_create(pdev, &scheduler0);
+
+	if (!exec)
+		return -ENOMEM;
+
+	if (user_sysfs_create_kds(pdev))
+		goto err;
+
+	init_scheduler_thread(&scheduler0);
+	xocl_subdev_register(pdev, XOCL_SUBDEV_MB_SCHEDULER, &sche_ops);
+	platform_set_drvdata(pdev, exec);
+
+	DRM_INFO("command scheduler started\n");
+
+	return 0;
+
+err:
+	devm_kfree(&pdev->dev, exec);
+	return 1;
+}
+
+/**
+ * Fini scheduler
+ */
+static int mb_scheduler_remove(struct platform_device *pdev)
+{
+	struct xocl_dev *xdev;
+	int i;
+	struct exec_core *exec = platform_get_drvdata(pdev);
+
+	SCHED_DEBUGF("-> %s\n", __func__);
+	fini_scheduler_thread(exec_scheduler(exec));
+
+	xdev = xocl_get_xdev(pdev);
+	for (i = 0; i < exec->intr_num; i++) {
+		xocl_user_interrupt_config(xdev, i + exec->intr_base, false);
+		xocl_user_interrupt_reg(xdev, i + exec->intr_base,
+			NULL, NULL);
+	}
+	mutex_destroy(&exec->exec_lock);
+
+	user_sysfs_destroy_kds(pdev);
+	exec_destroy(exec);
+	platform_set_drvdata(pdev, NULL);
+
+	SCHED_DEBUGF("<- %s\n", __func__);
+	DRM_INFO("command scheduler removed\n");
+	return 0;
+}
+
+static struct platform_device_id mb_sche_id_table[] = {
+	{ XOCL_MB_SCHEDULER, 0 },
+	{ },
+};
+
+static struct platform_driver	mb_scheduler_driver = {
+	.probe		= mb_scheduler_probe,
+	.remove		= mb_scheduler_remove,
+	.driver		= {
+		.name = "xocl_mb_sche",
+	},
+	.id_table	= mb_sche_id_table,
+};
+
+int __init xocl_init_mb_scheduler(void)
+{
+	return platform_driver_register(&mb_scheduler_driver);
+}
+
+void xocl_fini_mb_scheduler(void)
+{
+	SCHED_DEBUGF("-> %s\n", __func__);
+	platform_driver_unregister(&mb_scheduler_driver);
+	SCHED_DEBUGF("<- %s\n", __func__);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/microblaze.c b/drivers/gpu/drm/xocl/subdev/microblaze.c
new file mode 100644
index 000000000000..38cfbdbb39ef
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/microblaze.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Lizhi.HOu@xilinx.com
+ *
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/vmalloc.h>
+#include "../xocl_drv.h"
+#include <drm/xmgmt_drm.h>
+
+#define MAX_RETRY	50
+#define RETRY_INTERVAL	100	  //ms
+
+#define	MAX_IMAGE_LEN	0x20000
+
+#define	REG_VERSION		0
+#define	REG_ID			0x4
+#define	REG_STATUS		0x8
+#define	REG_ERR			0xC
+#define	REG_CAP			0x10
+#define	REG_CTL			0x18
+#define	REG_STOP_CONFIRM	0x1C
+#define	REG_CURR_BASE		0x20
+#define	REG_POWER_CHECKSUM	0x1A4
+
+#define	VALID_ID		0x74736574
+
+#define	GPIO_RESET		0x0
+#define	GPIO_ENABLED		0x1
+
+#define	SELF_JUMP(ins)		(((ins) & 0xfc00ffff) == 0xb8000000)
+
+enum ctl_mask {
+	CTL_MASK_CLEAR_POW	= 0x1,
+	CTL_MASK_CLEAR_ERR	= 0x2,
+	CTL_MASK_PAUSE		= 0x4,
+	CTL_MASK_STOP		= 0x8,
+};
+
+enum status_mask {
+	STATUS_MASK_INIT_DONE		= 0x1,
+	STATUS_MASK_STOPPED		= 0x2,
+	STATUS_MASK_PAUSE		= 0x4,
+};
+
+enum cap_mask {
+	CAP_MASK_PM			= 0x1,
+};
+
+enum {
+	MB_STATE_INIT = 0,
+	MB_STATE_RUN,
+	MB_STATE_RESET,
+};
+
+enum {
+	IO_REG,
+	IO_GPIO,
+	IO_IMAGE_MGMT,
+	IO_IMAGE_SCHE,
+	NUM_IOADDR
+};
+
+#define	READ_REG32(mb, off)		\
+	XOCL_READ_REG32(mb->base_addrs[IO_REG] + off)
+#define	WRITE_REG32(mb, val, off)	\
+	XOCL_WRITE_REG32(val, mb->base_addrs[IO_REG] + off)
+
+#define	READ_GPIO(mb, off)		\
+	XOCL_READ_REG32(mb->base_addrs[IO_GPIO] + off)
+#define	WRITE_GPIO(mb, val, off)	\
+	XOCL_WRITE_REG32(val, mb->base_addrs[IO_GPIO] + off)
+
+#define	READ_IMAGE_MGMT(mb, off)		\
+	XOCL_READ_REG32(mb->base_addrs[IO_IMAGE_MGMT] + off)
+
+#define	COPY_MGMT(mb, buf, len)		\
+	xocl_memcpy_toio(mb->base_addrs[IO_IMAGE_MGMT], buf, len)
+#define	COPY_SCHE(mb, buf, len)		\
+	xocl_memcpy_toio(mb->base_addrs[IO_IMAGE_SCHE], buf, len)
+
+struct xocl_mb {
+	struct platform_device	*pdev;
+	void __iomem		*base_addrs[NUM_IOADDR];
+
+	struct device		*hwmon_dev;
+	bool			enabled;
+	u32			state;
+	u32			cap;
+	struct mutex		mb_lock;
+
+	char			*sche_binary;
+	u32			sche_binary_length;
+	char			*mgmt_binary;
+	u32			mgmt_binary_length;
+};
+
+static int mb_stop(struct xocl_mb *mb);
+static int mb_start(struct xocl_mb *mb);
+
+/* sysfs support */
+static void safe_read32(struct xocl_mb *mb, u32 reg, u32 *val)
+{
+	mutex_lock(&mb->mb_lock);
+	if (mb->enabled && mb->state == MB_STATE_RUN)
+		*val = READ_REG32(mb, reg);
+	else
+		*val = 0;
+	mutex_unlock(&mb->mb_lock);
+}
+
+static void safe_write32(struct xocl_mb *mb, u32 reg, u32 val)
+{
+	mutex_lock(&mb->mb_lock);
+	if (mb->enabled && mb->state == MB_STATE_RUN)
+		WRITE_REG32(mb, val, reg);
+	mutex_unlock(&mb->mb_lock);
+}
+
+static ssize_t version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_VERSION, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t id_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_ID, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(id);
+
+static ssize_t status_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_STATUS, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t error_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_ERR, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(error);
+
+static ssize_t capability_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_CAP, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t power_checksum_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_POWER_CHECKSUM, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(power_checksum);
+
+static ssize_t pause_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(mb, REG_CTL, &val);
+
+	return sprintf(buf, "%d\n", !!(val & CTL_MASK_PAUSE));
+}
+
+static ssize_t pause_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val) == -EINVAL || val > 1)
+		return -EINVAL;
+
+	val = val ? CTL_MASK_PAUSE : 0;
+	safe_write32(mb, REG_CTL, val);
+
+	return count;
+}
+static DEVICE_ATTR_RW(pause);
+
+static ssize_t reset_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xocl_mb *mb = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val) == -EINVAL || val > 1)
+		return -EINVAL;
+
+	if (val) {
+		mb_stop(mb);
+		mb_start(mb);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *mb_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_id.attr,
+	&dev_attr_status.attr,
+	&dev_attr_error.attr,
+	&dev_attr_capability.attr,
+	&dev_attr_power_checksum.attr,
+	&dev_attr_pause.attr,
+	&dev_attr_reset.attr,
+	NULL,
+};
+static struct attribute_group mb_attr_group = {
+	.attrs = mb_attrs,
+};
+
+static ssize_t show_mb_pw(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct xocl_mb *mb = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(mb, REG_CURR_BASE + attr->index * sizeof(u32), &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static SENSOR_DEVICE_ATTR(curr1_highest, 0444, show_mb_pw, NULL, 0);
+static SENSOR_DEVICE_ATTR(curr1_average, 0444, show_mb_pw, NULL, 1);
+static SENSOR_DEVICE_ATTR(curr1_input, 0444, show_mb_pw, NULL, 2);
+static SENSOR_DEVICE_ATTR(curr2_highest, 0444, show_mb_pw, NULL, 3);
+static SENSOR_DEVICE_ATTR(curr2_average, 0444, show_mb_pw, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr2_input, 0444, show_mb_pw, NULL, 5);
+static SENSOR_DEVICE_ATTR(curr3_highest, 0444, show_mb_pw, NULL, 6);
+static SENSOR_DEVICE_ATTR(curr3_average, 0444, show_mb_pw, NULL, 7);
+static SENSOR_DEVICE_ATTR(curr3_input, 0444, show_mb_pw, NULL, 8);
+static SENSOR_DEVICE_ATTR(curr4_highest, 0444, show_mb_pw, NULL, 9);
+static SENSOR_DEVICE_ATTR(curr4_average, 0444, show_mb_pw, NULL, 10);
+static SENSOR_DEVICE_ATTR(curr4_input, 0444, show_mb_pw, NULL, 11);
+static SENSOR_DEVICE_ATTR(curr5_highest, 0444, show_mb_pw, NULL, 12);
+static SENSOR_DEVICE_ATTR(curr5_average, 0444, show_mb_pw, NULL, 13);
+static SENSOR_DEVICE_ATTR(curr5_input, 0444, show_mb_pw, NULL, 14);
+static SENSOR_DEVICE_ATTR(curr6_highest, 0444, show_mb_pw, NULL, 15);
+static SENSOR_DEVICE_ATTR(curr6_average, 0444, show_mb_pw, NULL, 16);
+static SENSOR_DEVICE_ATTR(curr6_input, 0444, show_mb_pw, NULL, 17);
+
+static struct attribute *hwmon_mb_attributes[] = {
+	&sensor_dev_attr_curr1_highest.dev_attr.attr,
+	&sensor_dev_attr_curr1_average.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_highest.dev_attr.attr,
+	&sensor_dev_attr_curr2_average.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_curr3_highest.dev_attr.attr,
+	&sensor_dev_attr_curr3_average.dev_attr.attr,
+	&sensor_dev_attr_curr3_input.dev_attr.attr,
+	&sensor_dev_attr_curr4_highest.dev_attr.attr,
+	&sensor_dev_attr_curr4_average.dev_attr.attr,
+	&sensor_dev_attr_curr4_input.dev_attr.attr,
+	&sensor_dev_attr_curr5_highest.dev_attr.attr,
+	&sensor_dev_attr_curr5_average.dev_attr.attr,
+	&sensor_dev_attr_curr5_input.dev_attr.attr,
+	&sensor_dev_attr_curr6_highest.dev_attr.attr,
+	&sensor_dev_attr_curr6_average.dev_attr.attr,
+	&sensor_dev_attr_curr6_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group hwmon_mb_attrgroup = {
+	.attrs = hwmon_mb_attributes,
+};
+
+static ssize_t show_name(struct device *dev, struct device_attribute *da,
+			 char *buf)
+{
+	return sprintf(buf, "%s\n", XCLMGMT_MB_HWMON_NAME);
+}
+
+static struct sensor_device_attribute name_attr =
+	SENSOR_ATTR(name, 0444, show_name, NULL, 0);
+
+static void mgmt_sysfs_destroy_mb(struct platform_device *pdev)
+{
+	struct xocl_mb *mb;
+
+	mb = platform_get_drvdata(pdev);
+
+	if (!mb->enabled)
+		return;
+
+	if (mb->hwmon_dev) {
+		device_remove_file(mb->hwmon_dev, &name_attr.dev_attr);
+		sysfs_remove_group(&mb->hwmon_dev->kobj,
+			&hwmon_mb_attrgroup);
+		hwmon_device_unregister(mb->hwmon_dev);
+		mb->hwmon_dev = NULL;
+	}
+
+	sysfs_remove_group(&pdev->dev.kobj, &mb_attr_group);
+}
+
+static int mgmt_sysfs_create_mb(struct platform_device *pdev)
+{
+	struct xocl_mb *mb;
+	struct xocl_dev_core *core;
+	int err;
+
+	mb = platform_get_drvdata(pdev);
+	core = XDEV(xocl_get_xdev(pdev));
+
+	if (!mb->enabled)
+		return 0;
+	err = sysfs_create_group(&pdev->dev.kobj, &mb_attr_group);
+	if (err) {
+		xocl_err(&pdev->dev, "create mb attrs failed: 0x%x", err);
+		goto create_attr_failed;
+	}
+	mb->hwmon_dev = hwmon_device_register(&core->pdev->dev);
+	if (IS_ERR(mb->hwmon_dev)) {
+		err = PTR_ERR(mb->hwmon_dev);
+		xocl_err(&pdev->dev, "register mb hwmon failed: 0x%x", err);
+		goto hwmon_reg_failed;
+	}
+
+	dev_set_drvdata(mb->hwmon_dev, mb);
+
+	err = device_create_file(mb->hwmon_dev, &name_attr.dev_attr);
+	if (err) {
+		xocl_err(&pdev->dev, "create attr name failed: 0x%x", err);
+		goto create_name_failed;
+	}
+
+	err = sysfs_create_group(&mb->hwmon_dev->kobj,
+		&hwmon_mb_attrgroup);
+	if (err) {
+		xocl_err(&pdev->dev, "create pw group failed: 0x%x", err);
+		goto create_pw_failed;
+	}
+
+	return 0;
+
+create_pw_failed:
+	device_remove_file(mb->hwmon_dev, &name_attr.dev_attr);
+create_name_failed:
+	hwmon_device_unregister(mb->hwmon_dev);
+	mb->hwmon_dev = NULL;
+hwmon_reg_failed:
+	sysfs_remove_group(&pdev->dev.kobj, &mb_attr_group);
+create_attr_failed:
+	return err;
+}
+
+static int mb_stop(struct xocl_mb *mb)
+{
+	int retry = 0;
+	int ret = 0;
+	u32 reg_val = 0;
+
+	if (!mb->enabled)
+		return 0;
+
+	mutex_lock(&mb->mb_lock);
+	reg_val = READ_GPIO(mb, 0);
+	xocl_info(&mb->pdev->dev, "Reset GPIO 0x%x", reg_val);
+	if (reg_val == GPIO_RESET) {
+		/* MB in reset status */
+		mb->state = MB_STATE_RESET;
+		goto out;
+	}
+
+	xocl_info(&mb->pdev->dev,
+		"MGMT Image magic word, 0x%x, status 0x%x, id 0x%x",
+		READ_IMAGE_MGMT(mb, 0),
+		READ_REG32(mb, REG_STATUS),
+		READ_REG32(mb, REG_ID));
+
+	if (!SELF_JUMP(READ_IMAGE_MGMT(mb, 0))) {
+		/* non cold boot */
+		reg_val = READ_REG32(mb, REG_STATUS);
+		if (!(reg_val & STATUS_MASK_STOPPED)) {
+			// need to stop microblaze
+			xocl_info(&mb->pdev->dev, "stopping microblaze...");
+			WRITE_REG32(mb, CTL_MASK_STOP, REG_CTL);
+			WRITE_REG32(mb, 1, REG_STOP_CONFIRM);
+			while (retry++ < MAX_RETRY &&
+				!(READ_REG32(mb, REG_STATUS) &
+				STATUS_MASK_STOPPED)) {
+				msleep(RETRY_INTERVAL);
+			}
+			if (retry >= MAX_RETRY) {
+				xocl_err(&mb->pdev->dev,
+					"Failed to stop microblaze");
+				xocl_err(&mb->pdev->dev,
+					"Error Reg 0x%x",
+					READ_REG32(mb, REG_ERR));
+				ret = -EIO;
+				goto out;
+			}
+		}
+		xocl_info(&mb->pdev->dev, "Microblaze Stopped, retry %d",
+			retry);
+	}
+
+	/* hold reset */
+	WRITE_GPIO(mb, GPIO_RESET, 0);
+	mb->state = MB_STATE_RESET;
+out:
+	mutex_unlock(&mb->mb_lock);
+
+	return ret;
+}
+
+static int mb_start(struct xocl_mb *mb)
+{
+	int retry = 0;
+	u32 reg_val = 0;
+	int ret = 0;
+	void *xdev_hdl;
+
+	if (!mb->enabled)
+		return 0;
+
+	xdev_hdl = xocl_get_xdev(mb->pdev);
+
+	mutex_lock(&mb->mb_lock);
+	reg_val = READ_GPIO(mb, 0);
+	xocl_info(&mb->pdev->dev, "Reset GPIO 0x%x", reg_val);
+	if (reg_val == GPIO_ENABLED)
+		goto out;
+
+	xocl_info(&mb->pdev->dev, "Start Microblaze...");
+	xocl_info(&mb->pdev->dev, "MGMT Image magic word, 0x%x",
+		READ_IMAGE_MGMT(mb, 0));
+
+	if (xocl_mb_mgmt_on(xdev_hdl)) {
+		xocl_info(&mb->pdev->dev, "Copying mgmt image len %d",
+			mb->mgmt_binary_length);
+		COPY_MGMT(mb, mb->mgmt_binary, mb->mgmt_binary_length);
+	}
+
+	if (xocl_mb_sched_on(xdev_hdl)) {
+		xocl_info(&mb->pdev->dev, "Copying scheduler image len %d",
+			mb->sche_binary_length);
+		COPY_SCHE(mb, mb->sche_binary, mb->sche_binary_length);
+	}
+
+	WRITE_GPIO(mb, GPIO_ENABLED, 0);
+	xocl_info(&mb->pdev->dev,
+		"MGMT Image magic word, 0x%x, status 0x%x, id 0x%x",
+		READ_IMAGE_MGMT(mb, 0),
+		READ_REG32(mb, REG_STATUS),
+		READ_REG32(mb, REG_ID));
+	do {
+		msleep(RETRY_INTERVAL);
+	} while (retry++ < MAX_RETRY && (READ_REG32(mb, REG_STATUS) &
+		STATUS_MASK_STOPPED));
+
+	/* Extra pulse needed as workaround for axi interconnect issue in DSA */
+	if (retry >= MAX_RETRY) {
+		retry = 0;
+		WRITE_GPIO(mb, GPIO_RESET, 0);
+		WRITE_GPIO(mb, GPIO_ENABLED, 0);
+		do {
+			msleep(RETRY_INTERVAL);
+		} while (retry++ < MAX_RETRY && (READ_REG32(mb, REG_STATUS) &
+			STATUS_MASK_STOPPED));
+	}
+
+	if (retry >= MAX_RETRY) {
+		xocl_err(&mb->pdev->dev, "Failed to start microblaze");
+		xocl_err(&mb->pdev->dev, "Error Reg 0x%x",
+				READ_REG32(mb, REG_ERR));
+			ret = -EIO;
+	}
+
+	mb->cap = READ_REG32(mb, REG_CAP);
+	mb->state = MB_STATE_RUN;
+out:
+	mutex_unlock(&mb->mb_lock);
+
+	return ret;
+}
+
+static void mb_reset(struct platform_device *pdev)
+{
+	struct xocl_mb *mb;
+
+	xocl_info(&pdev->dev, "Reset Microblaze...");
+	mb = platform_get_drvdata(pdev);
+	if (!mb)
+		return;
+
+	mb_stop(mb);
+	mb_start(mb);
+}
+
+static int load_mgmt_image(struct platform_device *pdev, const char *image,
+	u32 len)
+{
+	struct xocl_mb *mb;
+	char *binary;
+
+	if (len > MAX_IMAGE_LEN)
+		return -EINVAL;
+
+	mb = platform_get_drvdata(pdev);
+	if (!mb)
+		return -EINVAL;
+
+	binary = mb->mgmt_binary;
+	mb->mgmt_binary = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!mb->mgmt_binary)
+		return -ENOMEM;
+
+	if (binary)
+		devm_kfree(&pdev->dev, binary);
+	memcpy(mb->mgmt_binary, image, len);
+	mb->mgmt_binary_length = len;
+
+	return 0;
+}
+
+static int load_sche_image(struct platform_device *pdev, const char *image,
+	u32 len)
+{
+	struct xocl_mb *mb;
+	char *binary = NULL;
+
+	if (len > MAX_IMAGE_LEN)
+		return -EINVAL;
+
+	mb = platform_get_drvdata(pdev);
+	if (!mb)
+		return -EINVAL;
+
+	binary = mb->sche_binary;
+	mb->sche_binary = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!mb->sche_binary)
+		return -ENOMEM;
+
+	if (binary)
+		devm_kfree(&pdev->dev, binary);
+	memcpy(mb->sche_binary, image, len);
+	mb->sche_binary_length = len;
+
+	return 0;
+}
+
+//Have a function stub but don't actually do anything when this is called
+static int mb_ignore(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct xocl_mb_funcs mb_ops = {
+	.load_mgmt_image	= load_mgmt_image,
+	.load_sche_image	= load_sche_image,
+	.reset			= mb_reset,
+	.stop			= mb_ignore,
+};
+
+
+
+static int mb_remove(struct platform_device *pdev)
+{
+	struct xocl_mb *mb;
+	int	i;
+
+	mb = platform_get_drvdata(pdev);
+	if (!mb)
+		return 0;
+
+	if (mb->mgmt_binary)
+		devm_kfree(&pdev->dev, mb->mgmt_binary);
+	if (mb->sche_binary)
+		devm_kfree(&pdev->dev, mb->sche_binary);
+
+	/*
+	 * It is more secure that MB keeps running even driver is unloaded.
+	 * Even user unload our driver and use their own stuff, MB will still
+	 * be able to monitor the board unless user stops it explicitly
+	 */
+	mb_stop(mb);
+
+	mgmt_sysfs_destroy_mb(pdev);
+
+	for (i = 0; i < NUM_IOADDR; i++) {
+		if (mb->base_addrs[i])
+			iounmap(mb->base_addrs[i]);
+	}
+
+	mutex_destroy(&mb->mb_lock);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, mb);
+
+	return 0;
+}
+
+static int mb_probe(struct platform_device *pdev)
+{
+	struct xocl_mb *mb;
+	struct resource *res;
+	void	*xdev_hdl;
+	int i, err;
+
+	mb = devm_kzalloc(&pdev->dev, sizeof(*mb), GFP_KERNEL);
+	if (!mb) {
+		xocl_err(&pdev->dev, "out of memory");
+		return -ENOMEM;
+	}
+
+	mb->pdev = pdev;
+	platform_set_drvdata(pdev, mb);
+
+	xdev_hdl = xocl_get_xdev(pdev);
+	if (xocl_mb_mgmt_on(xdev_hdl) || xocl_mb_sched_on(xdev_hdl)) {
+		xocl_info(&pdev->dev, "Microblaze is supported.");
+		mb->enabled = true;
+	} else {
+		xocl_info(&pdev->dev, "Microblaze is not supported.");
+		devm_kfree(&pdev->dev, mb);
+		platform_set_drvdata(pdev, NULL);
+		return 0;
+	}
+
+	for (i = 0; i < NUM_IOADDR; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		xocl_info(&pdev->dev, "IO start: 0x%llx, end: 0x%llx",
+			res->start, res->end);
+		mb->base_addrs[i] =
+			ioremap_nocache(res->start, res->end - res->start + 1);
+		if (!mb->base_addrs[i]) {
+			err = -EIO;
+			xocl_err(&pdev->dev, "Map iomem failed");
+			goto failed;
+		}
+	}
+
+	err = mgmt_sysfs_create_mb(pdev);
+	if (err) {
+		xocl_err(&pdev->dev, "Create sysfs failed, err %d", err);
+		goto failed;
+	}
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_MB, &mb_ops);
+
+	mutex_init(&mb->mb_lock);
+
+	return 0;
+
+failed:
+	mb_remove(pdev);
+	return err;
+}
+
+struct platform_device_id mb_id_table[] = {
+	{ XOCL_MB, 0 },
+	{ },
+};
+
+static struct platform_driver	mb_driver = {
+	.probe		= mb_probe,
+	.remove		= mb_remove,
+	.driver		= {
+		.name = "xocl_mb",
+	},
+	.id_table = mb_id_table,
+};
+
+int __init xocl_init_mb(void)
+{
+	return platform_driver_register(&mb_driver);
+}
+
+void xocl_fini_mb(void)
+{
+	platform_driver_unregister(&mb_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/mig.c b/drivers/gpu/drm/xocl/subdev/mig.c
new file mode 100644
index 000000000000..5a574f7af796
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/mig.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2018-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Chien-Wei Lan <chienwei@xilinx.com>
+ *
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include "../xocl_drv.h"
+#include <drm/xmgmt_drm.h>
+
+/* Registers are defined in pg150-ultrascale-memory-ip.pdf:
+ * AXI4-Lite Slave Control/Status Register Map
+ */
+
+#define MIG_DEBUG
+#define	MIG_DEV2MIG(dev)	\
+	((struct xocl_mig *)platform_get_drvdata(to_platform_device(dev)))
+#define	MIG_DEV2BASE(dev)	(MIG_DEV2MIG(dev)->base)
+
+#define ECC_STATUS	0x0
+#define ECC_ON_OFF	0x8
+#define CE_CNT		0xC
+#define CE_ADDR_LO	0x1C0
+#define CE_ADDR_HI	0x1C4
+#define UE_ADDR_LO	0x2C0
+#define UE_ADDR_HI	0x2C4
+#define INJ_FAULT_REG	0x300
+
+struct xocl_mig {
+	void __iomem	*base;
+	struct device	*mig_dev;
+};
+
+static ssize_t ecc_ue_ffa_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	uint64_t val = ioread32(MIG_DEV2BASE(dev) + UE_ADDR_HI);
+
+	val <<= 32;
+	val |= ioread32(MIG_DEV2BASE(dev) + UE_ADDR_LO);
+	return sprintf(buf, "0x%llx\n", val);
+}
+static DEVICE_ATTR_RO(ecc_ue_ffa);
+
+
+static ssize_t ecc_ce_ffa_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	uint64_t val = ioread32(MIG_DEV2BASE(dev) + CE_ADDR_HI);
+
+	val <<= 32;
+	val |= ioread32(MIG_DEV2BASE(dev) + CE_ADDR_LO);
+	return sprintf(buf, "0x%llx\n", val);
+}
+static DEVICE_ATTR_RO(ecc_ce_ffa);
+
+
+static ssize_t ecc_ce_cnt_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	return sprintf(buf, "%u\n", ioread32(MIG_DEV2BASE(dev) + CE_CNT));
+}
+static DEVICE_ATTR_RO(ecc_ce_cnt);
+
+
+static ssize_t ecc_status_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	return sprintf(buf, "%u\n", ioread32(MIG_DEV2BASE(dev) + ECC_STATUS));
+}
+static DEVICE_ATTR_RO(ecc_status);
+
+
+static ssize_t ecc_reset_store(struct device *dev, struct device_attribute *da,
+	const char *buf, size_t count)
+{
+	iowrite32(0x3, MIG_DEV2BASE(dev) + ECC_STATUS);
+	iowrite32(0, MIG_DEV2BASE(dev) + CE_CNT);
+	return count;
+}
+static DEVICE_ATTR_WO(ecc_reset);
+
+
+static ssize_t ecc_enabled_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	return sprintf(buf, "%u\n", ioread32(MIG_DEV2BASE(dev) + ECC_ON_OFF));
+}
+static ssize_t ecc_enabled_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	uint32_t val;
+
+	if (sscanf(buf, "%d", &val) != 1 || val > 1) {
+		xocl_err(&to_platform_device(dev)->dev,
+			"usage: echo [0|1] > ecc_enabled");
+		return -EINVAL;
+	}
+
+	iowrite32(val, MIG_DEV2BASE(dev) + ECC_ON_OFF);
+	return count;
+}
+static DEVICE_ATTR_RW(ecc_enabled);
+
+
+#ifdef MIG_DEBUG
+static ssize_t ecc_inject_store(struct device *dev, struct device_attribute *da,
+	const char *buf, size_t count)
+{
+	iowrite32(1, MIG_DEV2BASE(dev) + INJ_FAULT_REG);
+	return count;
+}
+static DEVICE_ATTR_WO(ecc_inject);
+#endif
+
+
+/* Standard sysfs entry for all dynamic subdevices. */
+static ssize_t name_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	return sprintf(buf, "%s\n", XOCL_GET_SUBDEV_PRIV(dev));
+}
+static DEVICE_ATTR_RO(name);
+
+
+static struct attribute *mig_attributes[] = {
+	&dev_attr_name.attr,
+	&dev_attr_ecc_enabled.attr,
+	&dev_attr_ecc_status.attr,
+	&dev_attr_ecc_ce_cnt.attr,
+	&dev_attr_ecc_ce_ffa.attr,
+	&dev_attr_ecc_ue_ffa.attr,
+	&dev_attr_ecc_reset.attr,
+#ifdef MIG_DEBUG
+	&dev_attr_ecc_inject.attr,
+#endif
+	NULL
+};
+
+static const struct attribute_group mig_attrgroup = {
+	.attrs = mig_attributes,
+};
+
+static void mgmt_sysfs_destroy_mig(struct platform_device *pdev)
+{
+	struct xocl_mig *mig;
+
+	mig = platform_get_drvdata(pdev);
+	sysfs_remove_group(&pdev->dev.kobj, &mig_attrgroup);
+}
+
+static int mgmt_sysfs_create_mig(struct platform_device *pdev)
+{
+	struct xocl_mig *mig;
+	int err;
+
+	mig = platform_get_drvdata(pdev);
+	err = sysfs_create_group(&pdev->dev.kobj, &mig_attrgroup);
+	if (err) {
+		xocl_err(&pdev->dev, "create pw group failed: 0x%x", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int mig_probe(struct platform_device *pdev)
+{
+	struct xocl_mig *mig;
+	struct resource *res;
+	int err;
+
+	mig = devm_kzalloc(&pdev->dev, sizeof(*mig), GFP_KERNEL);
+	if (!mig)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xocl_err(&pdev->dev, "resource is NULL");
+		return -EINVAL;
+	}
+
+	xocl_info(&pdev->dev, "MIG name: %s, IO start: 0x%llx, end: 0x%llx",
+		XOCL_GET_SUBDEV_PRIV(&pdev->dev), res->start, res->end);
+
+	mig->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!mig->base) {
+		xocl_err(&pdev->dev, "Map iomem failed");
+		return -EIO;
+	}
+
+	platform_set_drvdata(pdev, mig);
+
+	err = mgmt_sysfs_create_mig(pdev);
+	if (err) {
+		platform_set_drvdata(pdev, NULL);
+		iounmap(mig->base);
+		return err;
+	}
+
+	return 0;
+}
+
+
+static int mig_remove(struct platform_device *pdev)
+{
+	struct xocl_mig	*mig;
+
+	mig = platform_get_drvdata(pdev);
+	if (!mig) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	xocl_info(&pdev->dev, "MIG name: %s", XOCL_GET_SUBDEV_PRIV(&pdev->dev));
+
+	mgmt_sysfs_destroy_mig(pdev);
+
+	if (mig->base)
+		iounmap(mig->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, mig);
+
+	return 0;
+}
+
+struct platform_device_id mig_id_table[] = {
+	{ XOCL_MIG, 0 },
+	{ },
+};
+
+static struct platform_driver	mig_driver = {
+	.probe		= mig_probe,
+	.remove		= mig_remove,
+	.driver		= {
+		.name = "xocl_mig",
+	},
+	.id_table = mig_id_table,
+};
+
+int __init xocl_init_mig(void)
+{
+	return platform_driver_register(&mig_driver);
+}
+
+void xocl_fini_mig(void)
+{
+	platform_driver_unregister(&mig_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/sysmon.c b/drivers/gpu/drm/xocl/subdev/sysmon.c
new file mode 100644
index 000000000000..bb5c84485344
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/sysmon.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include "../xocl_drv.h"
+#include <drm/xmgmt_drm.h>
+
+#define TEMP		0x400		// TEMPOERATURE REGISTER ADDRESS
+#define VCCINT		0x404		// VCCINT REGISTER OFFSET
+#define VCCAUX		0x408		// VCCAUX REGISTER OFFSET
+#define VCCBRAM		0x418		// VCCBRAM REGISTER OFFSET
+#define	TEMP_MAX	0x480
+#define	VCCINT_MAX	0x484
+#define	VCCAUX_MAX	0x488
+#define	VCCBRAM_MAX	0x48c
+#define	TEMP_MIN	0x490
+#define	VCCINT_MIN	0x494
+#define	VCCAUX_MIN	0x498
+#define	VCCBRAM_MIN	0x49c
+
+#define	SYSMON_TO_MILLDEGREE(val)		\
+	(((int64_t)(val) * 501374 >> 16) - 273678)
+#define	SYSMON_TO_MILLVOLT(val)			\
+	((val) * 1000 * 3 >> 16)
+
+#define	READ_REG32(sysmon, off)		\
+	XOCL_READ_REG32(sysmon->base + off)
+#define	WRITE_REG32(sysmon, val, off)	\
+	XOCL_WRITE_REG32(val, sysmon->base + off)
+
+struct xocl_sysmon {
+	void __iomem		*base;
+	struct device		*hwmon_dev;
+};
+
+static int get_prop(struct platform_device *pdev, u32 prop, void *val)
+{
+	struct xocl_sysmon	*sysmon;
+	u32			tmp;
+
+	sysmon = platform_get_drvdata(pdev);
+	BUG_ON(!sysmon);
+
+	switch (prop) {
+	case XOCL_SYSMON_PROP_TEMP:
+		tmp = READ_REG32(sysmon, TEMP);
+		*(u32 *)val = SYSMON_TO_MILLDEGREE(tmp)/1000;
+		break;
+	case XOCL_SYSMON_PROP_TEMP_MAX:
+		tmp = READ_REG32(sysmon, TEMP_MAX);
+		*(u32 *)val = SYSMON_TO_MILLDEGREE(tmp);
+		break;
+	case XOCL_SYSMON_PROP_TEMP_MIN:
+		tmp = READ_REG32(sysmon, TEMP_MIN);
+		*(u32 *)val = SYSMON_TO_MILLDEGREE(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_INT:
+		tmp = READ_REG32(sysmon, VCCINT);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_INT_MAX:
+		tmp = READ_REG32(sysmon, VCCINT_MAX);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_INT_MIN:
+		tmp = READ_REG32(sysmon, VCCINT_MIN);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_AUX:
+		tmp = READ_REG32(sysmon, VCCAUX);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_AUX_MAX:
+		tmp = READ_REG32(sysmon, VCCAUX_MAX);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_AUX_MIN:
+		tmp = READ_REG32(sysmon, VCCAUX_MIN);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_BRAM:
+		tmp = READ_REG32(sysmon, VCCBRAM);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_BRAM_MAX:
+		tmp = READ_REG32(sysmon, VCCBRAM_MAX);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	case XOCL_SYSMON_PROP_VCC_BRAM_MIN:
+		tmp = READ_REG32(sysmon, VCCBRAM_MIN);
+		*(u32 *)val = SYSMON_TO_MILLVOLT(tmp);
+		break;
+	default:
+		xocl_err(&pdev->dev, "Invalid prop");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct xocl_sysmon_funcs sysmon_ops = {
+	.get_prop	= get_prop,
+};
+
+static ssize_t show_sysmon(struct platform_device *pdev, u32 prop, char *buf)
+{
+	u32 val;
+
+	(void) get_prop(pdev, prop, &val);
+	return sprintf(buf, "%u\n", val);
+}
+
+/* sysfs support */
+static ssize_t show_hwmon(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct platform_device *pdev = dev_get_drvdata(dev);
+
+	return show_sysmon(pdev, attr->index, buf);
+}
+
+static ssize_t show_name(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	return sprintf(buf, "%s\n", XCLMGMT_SYSMON_HWMON_NAME);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_TEMP);
+static SENSOR_DEVICE_ATTR(temp1_highest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_TEMP_MAX);
+static SENSOR_DEVICE_ATTR(temp1_lowest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_TEMP_MIN);
+
+static SENSOR_DEVICE_ATTR(in0_input, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_INT);
+static SENSOR_DEVICE_ATTR(in0_highest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_INT_MAX);
+static SENSOR_DEVICE_ATTR(in0_lowest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_INT_MIN);
+
+static SENSOR_DEVICE_ATTR(in1_input, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_AUX);
+static SENSOR_DEVICE_ATTR(in1_highest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_AUX_MAX);
+static SENSOR_DEVICE_ATTR(in1_lowest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_AUX_MIN);
+
+static SENSOR_DEVICE_ATTR(in2_input, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_BRAM);
+static SENSOR_DEVICE_ATTR(in2_highest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_BRAM_MAX);
+static SENSOR_DEVICE_ATTR(in2_lowest, 0444, show_hwmon, NULL,
+	XOCL_SYSMON_PROP_VCC_BRAM_MIN);
+
+static struct attribute *hwmon_sysmon_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_highest.dev_attr.attr,
+	&sensor_dev_attr_temp1_lowest.dev_attr.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_highest.dev_attr.attr,
+	&sensor_dev_attr_in0_lowest.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_highest.dev_attr.attr,
+	&sensor_dev_attr_in1_lowest.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_highest.dev_attr.attr,
+	&sensor_dev_attr_in2_lowest.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group hwmon_sysmon_attrgroup = {
+	.attrs = hwmon_sysmon_attributes,
+};
+
+static struct sensor_device_attribute sysmon_name_attr =
+	SENSOR_ATTR(name, 0444, show_name, NULL, 0);
+
+static ssize_t temp_show(struct device *dev, struct device_attribute *da,
+			 char *buf)
+{
+	return show_sysmon(to_platform_device(dev), XOCL_SYSMON_PROP_TEMP, buf);
+}
+static DEVICE_ATTR_RO(temp);
+
+static ssize_t vcc_int_show(struct device *dev, struct device_attribute *da,
+			    char *buf)
+{
+	return show_sysmon(to_platform_device(dev), XOCL_SYSMON_PROP_VCC_INT, buf);
+}
+static DEVICE_ATTR_RO(vcc_int);
+
+static ssize_t vcc_aux_show(struct device *dev, struct device_attribute *da,
+			    char *buf)
+{
+	return show_sysmon(to_platform_device(dev), XOCL_SYSMON_PROP_VCC_AUX, buf);
+}
+static DEVICE_ATTR_RO(vcc_aux);
+
+static ssize_t vcc_bram_show(struct device *dev, struct device_attribute *da,
+			     char *buf)
+{
+	return show_sysmon(to_platform_device(dev), XOCL_SYSMON_PROP_VCC_BRAM, buf);
+}
+static DEVICE_ATTR_RO(vcc_bram);
+
+static struct attribute *sysmon_attributes[] = {
+	&dev_attr_temp.attr,
+	&dev_attr_vcc_int.attr,
+	&dev_attr_vcc_aux.attr,
+	&dev_attr_vcc_bram.attr,
+	NULL,
+};
+
+static const struct attribute_group sysmon_attrgroup = {
+	.attrs = sysmon_attributes,
+};
+
+static void mgmt_sysfs_destroy_sysmon(struct platform_device *pdev)
+{
+	struct xocl_sysmon *sysmon;
+
+	sysmon = platform_get_drvdata(pdev);
+
+	device_remove_file(sysmon->hwmon_dev, &sysmon_name_attr.dev_attr);
+	sysfs_remove_group(&sysmon->hwmon_dev->kobj, &hwmon_sysmon_attrgroup);
+	hwmon_device_unregister(sysmon->hwmon_dev);
+	sysmon->hwmon_dev = NULL;
+
+	sysfs_remove_group(&pdev->dev.kobj, &sysmon_attrgroup);
+}
+
+static int mgmt_sysfs_create_sysmon(struct platform_device *pdev)
+{
+	struct xocl_sysmon *sysmon;
+	struct xocl_dev_core *core;
+	int err;
+
+	sysmon = platform_get_drvdata(pdev);
+	core = XDEV(xocl_get_xdev(pdev));
+
+	sysmon->hwmon_dev = hwmon_device_register(&core->pdev->dev);
+	if (IS_ERR(sysmon->hwmon_dev)) {
+		err = PTR_ERR(sysmon->hwmon_dev);
+		xocl_err(&pdev->dev, "register sysmon hwmon failed: 0x%x", err);
+		goto hwmon_reg_failed;
+	}
+
+	dev_set_drvdata(sysmon->hwmon_dev, pdev);
+	err = device_create_file(sysmon->hwmon_dev,
+		&sysmon_name_attr.dev_attr);
+	if (err) {
+		xocl_err(&pdev->dev, "create attr name failed: 0x%x", err);
+		goto create_name_failed;
+	}
+
+	err = sysfs_create_group(&sysmon->hwmon_dev->kobj,
+		&hwmon_sysmon_attrgroup);
+	if (err) {
+		xocl_err(&pdev->dev, "create hwmon group failed: 0x%x", err);
+		goto create_hwmon_failed;
+	}
+
+	err = sysfs_create_group(&pdev->dev.kobj, &sysmon_attrgroup);
+	if (err) {
+		xocl_err(&pdev->dev, "create sysmon group failed: 0x%x", err);
+		goto create_sysmon_failed;
+	}
+
+	return 0;
+
+create_sysmon_failed:
+	sysfs_remove_group(&sysmon->hwmon_dev->kobj, &hwmon_sysmon_attrgroup);
+create_hwmon_failed:
+	device_remove_file(sysmon->hwmon_dev, &sysmon_name_attr.dev_attr);
+create_name_failed:
+	hwmon_device_unregister(sysmon->hwmon_dev);
+	sysmon->hwmon_dev = NULL;
+hwmon_reg_failed:
+	return err;
+}
+
+static int sysmon_probe(struct platform_device *pdev)
+{
+	struct xocl_sysmon *sysmon;
+	struct resource *res;
+	int err;
+
+	sysmon = devm_kzalloc(&pdev->dev, sizeof(*sysmon), GFP_KERNEL);
+	if (!sysmon)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xocl_err(&pdev->dev, "resource is NULL");
+		return -EINVAL;
+	}
+	xocl_info(&pdev->dev, "IO start: 0x%llx, end: 0x%llx",
+		res->start, res->end);
+	sysmon->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!sysmon->base) {
+		err = -EIO;
+		xocl_err(&pdev->dev, "Map iomem failed");
+		goto failed;
+	}
+
+	platform_set_drvdata(pdev, sysmon);
+
+	err = mgmt_sysfs_create_sysmon(pdev);
+	if (err)
+		goto create_sysmon_failed;
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_SYSMON, &sysmon_ops);
+
+	return 0;
+
+create_sysmon_failed:
+	platform_set_drvdata(pdev, NULL);
+failed:
+	return err;
+}
+
+
+static int sysmon_remove(struct platform_device *pdev)
+{
+	struct xocl_sysmon	*sysmon;
+
+	sysmon = platform_get_drvdata(pdev);
+	if (!sysmon) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	mgmt_sysfs_destroy_sysmon(pdev);
+
+	if (sysmon->base)
+		iounmap(sysmon->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, sysmon);
+
+	return 0;
+}
+
+struct platform_device_id sysmon_id_table[] = {
+	{ XOCL_SYSMON, 0 },
+	{ },
+};
+
+static struct platform_driver	sysmon_driver = {
+	.probe		= sysmon_probe,
+	.remove		= sysmon_remove,
+	.driver		= {
+		.name = "xocl_sysmon",
+	},
+	.id_table = sysmon_id_table,
+};
+
+int __init xocl_init_sysmon(void)
+{
+	return platform_driver_register(&sysmon_driver);
+}
+
+void xocl_fini_sysmon(void)
+{
+	platform_driver_unregister(&sysmon_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/xdma.c b/drivers/gpu/drm/xocl/subdev/xdma.c
new file mode 100644
index 000000000000..647a69f29a84
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/xdma.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ */
+
+/* XDMA version Memory Mapped DMA */
+
+#include <linux/version.h>
+#include <linux/eventfd.h>
+#include <drm/drmP.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_mm.h>
+#include "../xocl_drv.h"
+#include "../xocl_drm.h"
+#include "../lib/libxdma_api.h"
+
+#define XOCL_FILE_PAGE_OFFSET   0x100000
+#ifndef VM_RESERVED
+#define VM_RESERVED (VM_DONTEXPAND | VM_DONTDUMP)
+#endif
+
+struct xdma_irq {
+	struct eventfd_ctx	*event_ctx;
+	bool			in_use;
+	bool			enabled;
+	irq_handler_t		handler;
+	void			*arg;
+};
+
+struct xocl_xdma {
+	void			*dma_handle;
+	u32			max_user_intr;
+	u32			start_user_intr;
+	struct xdma_irq		*user_msix_table;
+	struct mutex		user_msix_table_lock;
+
+	struct xocl_drm		*drm;
+	/* Number of bidirectional channels */
+	u32			channel;
+	/* Semaphore, one for each direction */
+	struct semaphore	channel_sem[2];
+	/*
+	 * Channel usage bitmasks, one for each direction
+	 * bit 1 indicates channel is free, bit 0 indicates channel is free
+	 */
+	unsigned long		channel_bitmap[2];
+	unsigned long long	*channel_usage[2];
+
+	struct mutex		stat_lock;
+};
+
+static ssize_t xdma_migrate_bo(struct platform_device *pdev,
+	struct sg_table *sgt, u32 dir, u64 paddr, u32 channel, u64 len)
+{
+	struct xocl_xdma *xdma;
+	struct page *pg;
+	struct scatterlist *sg = sgt->sgl;
+	int nents = sgt->orig_nents;
+	pid_t pid = current->pid;
+	int i = 0;
+	ssize_t ret;
+	unsigned long long pgaddr;
+
+	xdma = platform_get_drvdata(pdev);
+	xocl_dbg(&pdev->dev, "TID %d, Channel:%d, Offset: 0x%llx, Dir: %d",
+		pid, channel, paddr, dir);
+	ret = xdma_xfer_submit(xdma->dma_handle, channel, dir,
+		paddr, sgt, false, 10000);
+	if (ret >= 0) {
+		xdma->channel_usage[dir][channel] += ret;
+		return ret;
+	}
+
+	xocl_err(&pdev->dev, "DMA failed, Dumping SG Page Table");
+	for (i = 0; i < nents; i++, sg = sg_next(sg)) {
+		if (!sg)
+			break;
+		pg = sg_page(sg);
+		if (!pg)
+			continue;
+		pgaddr = page_to_phys(pg);
+		xocl_err(&pdev->dev, "%i, 0x%llx\n", i, pgaddr);
+	}
+	return ret;
+}
+
+static int acquire_channel(struct platform_device *pdev, u32 dir)
+{
+	struct xocl_xdma *xdma;
+	int channel = 0;
+	int result = 0;
+
+	xdma = platform_get_drvdata(pdev);
+	if (down_interruptible(&xdma->channel_sem[dir])) {
+		channel = -ERESTARTSYS;
+		goto out;
+	}
+
+	for (channel = 0; channel < xdma->channel; channel++) {
+		result = test_and_clear_bit(channel,
+			&xdma->channel_bitmap[dir]);
+		if (result)
+			break;
+	}
+	if (!result) {
+		// How is this possible?
+		up(&xdma->channel_sem[dir]);
+		channel = -EIO;
+	}
+
+out:
+	return channel;
+}
+
+static void release_channel(struct platform_device *pdev, u32 dir, u32 channel)
+{
+	struct xocl_xdma *xdma;
+
+
+	xdma = platform_get_drvdata(pdev);
+	set_bit(channel, &xdma->channel_bitmap[dir]);
+	up(&xdma->channel_sem[dir]);
+}
+
+static u32 get_channel_count(struct platform_device *pdev)
+{
+	struct xocl_xdma *xdma;
+
+	xdma = platform_get_drvdata(pdev);
+	BUG_ON(!xdma);
+
+	return xdma->channel;
+}
+
+static void *get_drm_handle(struct platform_device *pdev)
+{
+	struct xocl_xdma *xdma;
+
+	xdma = platform_get_drvdata(pdev);
+
+	return xdma->drm;
+}
+
+static u64 get_channel_stat(struct platform_device *pdev, u32 channel,
+	u32 write)
+{
+	struct xocl_xdma *xdma;
+
+	xdma = platform_get_drvdata(pdev);
+	BUG_ON(!xdma);
+
+	return xdma->channel_usage[write][channel];
+}
+
+static int user_intr_config(struct platform_device *pdev, u32 intr, bool en)
+{
+	struct xocl_xdma *xdma;
+	const unsigned int mask = 1 << intr;
+	int ret;
+
+	xdma = platform_get_drvdata(pdev);
+
+	if (intr >= xdma->max_user_intr) {
+		xocl_err(&pdev->dev, "Invalid intr %d, user start %d, max %d",
+			intr, xdma->start_user_intr, xdma->max_user_intr);
+		return -EINVAL;
+	}
+
+	mutex_lock(&xdma->user_msix_table_lock);
+	if (xdma->user_msix_table[intr].enabled == en) {
+		ret = 0;
+		goto end;
+	}
+
+	ret = en ? xdma_user_isr_enable(xdma->dma_handle, mask) :
+		xdma_user_isr_disable(xdma->dma_handle, mask);
+	if (!ret)
+		xdma->user_msix_table[intr].enabled = en;
+end:
+	mutex_unlock(&xdma->user_msix_table_lock);
+
+	return ret;
+}
+
+static irqreturn_t xdma_isr(int irq, void *arg)
+{
+	struct xdma_irq *irq_entry = arg;
+	int ret = IRQ_HANDLED;
+
+	if (irq_entry->handler)
+		ret = irq_entry->handler(irq, irq_entry->arg);
+
+	if (!IS_ERR_OR_NULL(irq_entry->event_ctx))
+		eventfd_signal(irq_entry->event_ctx, 1);
+
+	return ret;
+}
+
+static int user_intr_unreg(struct platform_device *pdev, u32 intr)
+{
+	struct xocl_xdma *xdma;
+	const unsigned int mask = 1 << intr;
+	int ret;
+
+	xdma = platform_get_drvdata(pdev);
+
+	if (intr >= xdma->max_user_intr)
+		return -EINVAL;
+
+	mutex_lock(&xdma->user_msix_table_lock);
+	if (!xdma->user_msix_table[intr].in_use) {
+		ret = -EINVAL;
+		goto failed;
+	}
+	xdma->user_msix_table[intr].handler = NULL;
+	xdma->user_msix_table[intr].arg = NULL;
+
+	ret = xdma_user_isr_register(xdma->dma_handle, mask, NULL, NULL);
+	if (ret) {
+		xocl_err(&pdev->dev, "xdma unregister isr failed");
+		goto failed;
+	}
+
+	xdma->user_msix_table[intr].in_use = false;
+
+failed:
+	mutex_unlock(&xdma->user_msix_table_lock);
+	return ret;
+}
+
+static int user_intr_register(struct platform_device *pdev, u32 intr,
+	irq_handler_t handler, void *arg, int event_fd)
+{
+	struct xocl_xdma *xdma;
+	struct eventfd_ctx *trigger = ERR_PTR(-EINVAL);
+	const unsigned int mask = 1 << intr;
+	int ret;
+
+	xdma = platform_get_drvdata(pdev);
+
+	if (intr >= xdma->max_user_intr ||
+			(event_fd >= 0 && intr < xdma->start_user_intr)) {
+		xocl_err(&pdev->dev, "Invalid intr %d, user start %d, max %d",
+			intr, xdma->start_user_intr, xdma->max_user_intr);
+		return -EINVAL;
+	}
+
+	if (event_fd >= 0) {
+		trigger = eventfd_ctx_fdget(event_fd);
+		if (IS_ERR(trigger)) {
+			xocl_err(&pdev->dev, "get event ctx failed");
+			return -EFAULT;
+		}
+	}
+
+	mutex_lock(&xdma->user_msix_table_lock);
+	if (xdma->user_msix_table[intr].in_use) {
+		xocl_err(&pdev->dev, "IRQ %d is in use", intr);
+		ret = -EPERM;
+		goto failed;
+	}
+	xdma->user_msix_table[intr].event_ctx = trigger;
+	xdma->user_msix_table[intr].handler = handler;
+	xdma->user_msix_table[intr].arg = arg;
+
+	ret = xdma_user_isr_register(xdma->dma_handle, mask, xdma_isr,
+			&xdma->user_msix_table[intr]);
+	if (ret) {
+		xocl_err(&pdev->dev, "IRQ register failed");
+		xdma->user_msix_table[intr].handler = NULL;
+		xdma->user_msix_table[intr].arg = NULL;
+		xdma->user_msix_table[intr].event_ctx = NULL;
+		goto failed;
+	}
+
+	xdma->user_msix_table[intr].in_use = true;
+
+	mutex_unlock(&xdma->user_msix_table_lock);
+
+
+	return 0;
+
+failed:
+	mutex_unlock(&xdma->user_msix_table_lock);
+	if (!IS_ERR(trigger))
+		eventfd_ctx_put(trigger);
+
+	return ret;
+}
+
+static struct xocl_dma_funcs xdma_ops = {
+	.migrate_bo = xdma_migrate_bo,
+	.ac_chan = acquire_channel,
+	.rel_chan = release_channel,
+	.get_chan_count = get_channel_count,
+	.get_chan_stat = get_channel_stat,
+	.user_intr_register = user_intr_register,
+	.user_intr_config = user_intr_config,
+	.user_intr_unreg = user_intr_unreg,
+	.get_drm_handle = get_drm_handle,
+};
+
+static ssize_t channel_stat_raw_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	u32 i;
+	ssize_t nbytes = 0;
+	struct platform_device *pdev = to_platform_device(dev);
+	u32 chs = get_channel_count(pdev);
+
+	for (i = 0; i < chs; i++) {
+		nbytes += sprintf(buf + nbytes, "%llu %llu\n",
+			get_channel_stat(pdev, i, 0),
+			get_channel_stat(pdev, i, 1));
+	}
+	return nbytes;
+}
+static DEVICE_ATTR_RO(channel_stat_raw);
+
+static struct attribute *xdma_attrs[] = {
+	&dev_attr_channel_stat_raw.attr,
+	NULL,
+};
+
+static struct attribute_group xdma_attr_group = {
+	.attrs = xdma_attrs,
+};
+
+static int set_max_chan(struct platform_device *pdev,
+		struct xocl_xdma *xdma)
+{
+	xdma->channel_usage[0] = devm_kzalloc(&pdev->dev, sizeof(u64) *
+		xdma->channel, GFP_KERNEL);
+	xdma->channel_usage[1] = devm_kzalloc(&pdev->dev, sizeof(u64) *
+		xdma->channel, GFP_KERNEL);
+	if (!xdma->channel_usage[0] || !xdma->channel_usage[1]) {
+		xocl_err(&pdev->dev, "failed to alloc channel usage");
+		return -ENOMEM;
+	}
+
+	sema_init(&xdma->channel_sem[0], xdma->channel);
+	sema_init(&xdma->channel_sem[1], xdma->channel);
+
+	/* Initialize bit mask to represent individual channels */
+	xdma->channel_bitmap[0] = BIT(xdma->channel);
+	xdma->channel_bitmap[0]--;
+	xdma->channel_bitmap[1] = xdma->channel_bitmap[0];
+
+	return 0;
+}
+
+static int xdma_probe(struct platform_device *pdev)
+{
+	struct xocl_xdma	*xdma = NULL;
+	int	ret = 0;
+	xdev_handle_t		xdev;
+
+	xdev = xocl_get_xdev(pdev);
+	BUG_ON(!xdev);
+
+	xdma = devm_kzalloc(&pdev->dev, sizeof(*xdma), GFP_KERNEL);
+	if (!xdma) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	xdma->dma_handle = xdma_device_open(XOCL_MODULE_NAME, XDEV(xdev)->pdev,
+			&xdma->max_user_intr,
+			&xdma->channel, &xdma->channel);
+	if (xdma->dma_handle == NULL) {
+		xocl_err(&pdev->dev, "XDMA Device Open failed");
+		ret = -EIO;
+		goto failed;
+	}
+
+	xdma->user_msix_table = devm_kzalloc(&pdev->dev,
+			xdma->max_user_intr *
+			sizeof(struct xdma_irq), GFP_KERNEL);
+	if (!xdma->user_msix_table) {
+		xocl_err(&pdev->dev, "alloc user_msix_table failed");
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	ret = set_max_chan(pdev, xdma);
+	if (ret) {
+		xocl_err(&pdev->dev, "Set max channel failed");
+		goto failed;
+	}
+
+	xdma->drm = xocl_drm_init(xdev);
+	if (!xdma->drm) {
+		ret = -EFAULT;
+		xocl_err(&pdev->dev, "failed to init drm mm");
+		goto failed;
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &xdma_attr_group);
+	if (ret) {
+		xocl_err(&pdev->dev, "create attrs failed: %d", ret);
+		goto failed;
+	}
+
+	mutex_init(&xdma->stat_lock);
+	mutex_init(&xdma->user_msix_table_lock);
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_DMA, &xdma_ops);
+	platform_set_drvdata(pdev, xdma);
+
+	return 0;
+
+failed:
+	if (xdma) {
+		if (xdma->drm)
+			xocl_drm_fini(xdma->drm);
+		if (xdma->dma_handle)
+			xdma_device_close(XDEV(xdev)->pdev, xdma->dma_handle);
+		if (xdma->channel_usage[0])
+			devm_kfree(&pdev->dev, xdma->channel_usage[0]);
+		if (xdma->channel_usage[1])
+			devm_kfree(&pdev->dev, xdma->channel_usage[1]);
+		if (xdma->user_msix_table)
+			devm_kfree(&pdev->dev, xdma->user_msix_table);
+
+		devm_kfree(&pdev->dev, xdma);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+
+	return ret;
+}
+
+static int xdma_remove(struct platform_device *pdev)
+{
+	struct xocl_xdma *xdma = platform_get_drvdata(pdev);
+	xdev_handle_t xdev;
+	struct xdma_irq *irq_entry;
+	int i;
+
+	if (!xdma) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	xdev = xocl_get_xdev(pdev);
+	BUG_ON(!xdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &xdma_attr_group);
+
+	if (xdma->drm)
+		xocl_drm_fini(xdma->drm);
+	if (xdma->dma_handle)
+		xdma_device_close(XDEV(xdev)->pdev, xdma->dma_handle);
+
+	for (i = 0; i < xdma->max_user_intr; i++) {
+		irq_entry = &xdma->user_msix_table[i];
+		if (irq_entry->in_use) {
+			if (irq_entry->enabled) {
+				xocl_err(&pdev->dev,
+					"ERROR: Interrupt %d is still on", i);
+			}
+			if (!IS_ERR_OR_NULL(irq_entry->event_ctx))
+				eventfd_ctx_put(irq_entry->event_ctx);
+		}
+	}
+
+	if (xdma->channel_usage[0])
+		devm_kfree(&pdev->dev, xdma->channel_usage[0]);
+	if (xdma->channel_usage[1])
+		devm_kfree(&pdev->dev, xdma->channel_usage[1]);
+
+	mutex_destroy(&xdma->stat_lock);
+	mutex_destroy(&xdma->user_msix_table_lock);
+
+	devm_kfree(&pdev->dev, xdma->user_msix_table);
+	platform_set_drvdata(pdev, NULL);
+
+	devm_kfree(&pdev->dev, xdma);
+
+	return 0;
+}
+
+static struct platform_device_id xdma_id_table[] = {
+	{ XOCL_XDMA, 0 },
+	{ },
+};
+
+static struct platform_driver	xdma_driver = {
+	.probe		= xdma_probe,
+	.remove		= xdma_remove,
+	.driver		= {
+		.name = "xocl_xdma",
+	},
+	.id_table	= xdma_id_table,
+};
+
+int __init xocl_init_xdma(void)
+{
+	return platform_driver_register(&xdma_driver);
+}
+
+void xocl_fini_xdma(void)
+{
+	return platform_driver_unregister(&xdma_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/xmc.c b/drivers/gpu/drm/xocl/subdev/xmc.c
new file mode 100644
index 000000000000..d9d620ac09b9
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/xmc.c
@@ -0,0 +1,1480 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: chienwei@xilinx.com
+ *
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include "../ert.h"
+#include "../xocl_drv.h"
+#include <drm/xmgmt_drm.h>
+
+#define MAX_XMC_RETRY       150	//Retry is set to 15s for XMC
+#define MAX_ERT_RETRY       10	//Retry is set to 1s for ERT
+#define RETRY_INTERVAL  100       //100ms
+
+#define	MAX_IMAGE_LEN	0x20000
+
+#define XMC_MAGIC_REG               0x0
+#define XMC_VERSION_REG             0x4
+#define XMC_STATUS_REG              0x8
+#define XMC_ERROR_REG               0xC
+#define XMC_FEATURE_REG             0x10
+#define XMC_SENSOR_REG              0x14
+#define XMC_CONTROL_REG             0x18
+#define XMC_STOP_CONFIRM_REG        0x1C
+#define XMC_12V_PEX_REG             0x20
+#define XMC_3V3_PEX_REG             0x2C
+#define XMC_3V3_AUX_REG             0x38
+#define XMC_12V_AUX_REG             0x44
+#define XMC_DDR4_VPP_BTM_REG        0x50
+#define XMC_SYS_5V5_REG             0x5C
+#define XMC_VCC1V2_TOP_REG          0x68
+#define XMC_VCC1V8_REG              0x74
+#define XMC_VCC0V85_REG             0x80
+#define XMC_DDR4_VPP_TOP_REG        0x8C
+#define XMC_MGT0V9AVCC_REG          0x98
+#define XMC_12V_SW_REG              0xA4
+#define XMC_MGTAVTT_REG             0xB0
+#define XMC_VCC1V2_BTM_REG          0xBC
+#define XMC_12V_PEX_I_IN_REG        0xC8
+#define XMC_12V_AUX_I_IN_REG        0xD4
+#define XMC_VCCINT_V_REG            0xE0
+#define XMC_VCCINT_I_REG            0xEC
+#define XMC_FPGA_TEMP               0xF8
+#define XMC_FAN_TEMP_REG            0x104
+#define XMC_DIMM_TEMP0_REG          0x110
+#define XMC_DIMM_TEMP1_REG          0x11C
+#define XMC_DIMM_TEMP2_REG          0x128
+#define XMC_DIMM_TEMP3_REG          0x134
+#define XMC_FAN_SPEED_REG           0x164
+#define XMC_SE98_TEMP0_REG          0x140
+#define XMC_SE98_TEMP1_REG          0x14C
+#define XMC_SE98_TEMP2_REG          0x158
+#define XMC_CAGE_TEMP0_REG          0x170
+#define XMC_CAGE_TEMP1_REG          0x17C
+#define XMC_CAGE_TEMP2_REG          0x188
+#define XMC_CAGE_TEMP3_REG          0x194
+#define XMC_SNSR_CHKSUM_REG         0x1A4
+#define XMC_SNSR_FLAGS_REG          0x1A8
+#define XMC_HOST_MSG_OFFSET_REG     0x300
+#define XMC_HOST_MSG_ERROR_REG      0x304
+#define XMC_HOST_MSG_HEADER_REG     0x308
+
+
+#define	VALID_ID		0x74736574
+
+#define	GPIO_RESET		0x0
+#define	GPIO_ENABLED		0x1
+
+#define	SELF_JUMP(ins)		(((ins) & 0xfc00ffff) == 0xb8000000)
+#define	XMC_PRIVILEGED(xmc)	((xmc)->base_addrs[0] != NULL)
+
+enum ctl_mask {
+	CTL_MASK_CLEAR_POW	= 0x1,
+	CTL_MASK_CLEAR_ERR	= 0x2,
+	CTL_MASK_PAUSE		= 0x4,
+	CTL_MASK_STOP		= 0x8,
+};
+
+enum status_mask {
+	STATUS_MASK_INIT_DONE		= 0x1,
+	STATUS_MASK_STOPPED		= 0x2,
+	STATUS_MASK_PAUSE		= 0x4,
+};
+
+enum cap_mask {
+	CAP_MASK_PM			= 0x1,
+};
+
+enum {
+	XMC_STATE_UNKNOWN,
+	XMC_STATE_ENABLED,
+	XMC_STATE_RESET,
+	XMC_STATE_STOPPED,
+	XMC_STATE_ERROR
+};
+
+enum {
+	IO_REG,
+	IO_GPIO,
+	IO_IMAGE_MGMT,
+	IO_IMAGE_SCHED,
+	IO_CQ,
+	NUM_IOADDR
+};
+
+enum {
+	VOLTAGE_MAX,
+	VOLTAGE_AVG,
+	VOLTAGE_INS,
+};
+
+#define	READ_REG32(xmc, off)		\
+	XOCL_READ_REG32(xmc->base_addrs[IO_REG] + off)
+#define	WRITE_REG32(xmc, val, off)	\
+	XOCL_WRITE_REG32(val, xmc->base_addrs[IO_REG] + off)
+
+#define	READ_GPIO(xmc, off)		\
+	XOCL_READ_REG32(xmc->base_addrs[IO_GPIO] + off)
+#define	WRITE_GPIO(xmc, val, off)	\
+	XOCL_WRITE_REG32(val, xmc->base_addrs[IO_GPIO] + off)
+
+#define	READ_IMAGE_MGMT(xmc, off)		\
+	XOCL_READ_REG32(xmc->base_addrs[IO_IMAGE_MGMT] + off)
+
+#define	READ_IMAGE_SCHED(xmc, off)		\
+	XOCL_READ_REG32(xmc->base_addrs[IO_IMAGE_SCHED] + off)
+
+#define	COPY_MGMT(xmc, buf, len)		\
+	xocl_memcpy_toio(xmc->base_addrs[IO_IMAGE_MGMT], buf, len)
+#define	COPY_SCHE(xmc, buf, len)		\
+	xocl_memcpy_toio(xmc->base_addrs[IO_IMAGE_SCHED], buf, len)
+
+struct xocl_xmc {
+	struct platform_device	*pdev;
+	void __iomem		*base_addrs[NUM_IOADDR];
+
+	struct device		*hwmon_dev;
+	bool			enabled;
+	u32			state;
+	u32			cap;
+	struct mutex		xmc_lock;
+
+	char			*sche_binary;
+	u32			sche_binary_length;
+	char			*mgmt_binary;
+	u32			mgmt_binary_length;
+};
+
+
+static int load_xmc(struct xocl_xmc *xmc);
+static int stop_xmc(struct platform_device *pdev);
+
+static void xmc_read_from_peer(struct platform_device *pdev, enum data_kind kind, void *resp, size_t resplen)
+{
+	struct mailbox_subdev_peer subdev_peer = {0};
+	size_t data_len = sizeof(struct mailbox_subdev_peer);
+	struct mailbox_req *mb_req = NULL;
+	size_t reqlen = sizeof(struct mailbox_req) + data_len;
+
+	mb_req = vmalloc(reqlen);
+	if (!mb_req)
+		return;
+
+	mb_req->req = MAILBOX_REQ_PEER_DATA;
+
+	subdev_peer.kind = kind;
+	memcpy(mb_req->data, &subdev_peer, data_len);
+
+	(void) xocl_peer_request(XOCL_PL_DEV_TO_XDEV(pdev),
+		mb_req, reqlen, resp, &resplen, NULL, NULL);
+	vfree(mb_req);
+}
+
+/* sysfs support */
+static void safe_read32(struct xocl_xmc *xmc, u32 reg, u32 *val)
+{
+	mutex_lock(&xmc->xmc_lock);
+	if (xmc->enabled && xmc->state == XMC_STATE_ENABLED)
+		*val = READ_REG32(xmc, reg);
+	else
+		*val = 0;
+
+	mutex_unlock(&xmc->xmc_lock);
+}
+
+static void safe_write32(struct xocl_xmc *xmc, u32 reg, u32 val)
+{
+	mutex_lock(&xmc->xmc_lock);
+	if (xmc->enabled && xmc->state == XMC_STATE_ENABLED)
+		WRITE_REG32(xmc, val, reg);
+
+	mutex_unlock(&xmc->xmc_lock);
+}
+
+static void safe_read_from_peer(struct xocl_xmc *xmc, struct platform_device *pdev, enum data_kind kind, u32 *val)
+{
+	mutex_lock(&xmc->xmc_lock);
+	if (xmc->enabled)
+		xmc_read_from_peer(pdev, kind, val, sizeof(u32));
+	else
+		*val = 0;
+
+	mutex_unlock(&xmc->xmc_lock);
+}
+
+static int xmc_get_data(struct platform_device *pdev, enum data_kind kind)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(pdev);
+	int val;
+
+	if (XMC_PRIVILEGED(xmc)) {
+		switch (kind) {
+		case VOL_12V_PEX:
+			safe_read32(xmc, XMC_12V_PEX_REG + sizeof(u32)*VOLTAGE_INS, &val);
+			break;
+		default:
+			break;
+		}
+	}
+	return val;
+}
+
+static ssize_t xmc_12v_pex_vol_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 pes_val;
+
+	if (XMC_PRIVILEGED(xmc))
+		safe_read32(xmc, XMC_12V_PEX_REG+sizeof(u32)*VOLTAGE_INS, &pes_val);
+	else
+		safe_read_from_peer(xmc, to_platform_device(dev), VOL_12V_PEX, &pes_val);
+
+	return sprintf(buf, "%d\n", pes_val);
+}
+static DEVICE_ATTR_RO(xmc_12v_pex_vol);
+
+static ssize_t xmc_12v_aux_vol_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_12V_AUX_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_12v_aux_vol);
+
+static ssize_t xmc_12v_pex_curr_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 pes_val;
+
+	safe_read32(xmc, XMC_12V_PEX_I_IN_REG+sizeof(u32)*VOLTAGE_INS, &pes_val);
+
+	return sprintf(buf, "%d\n", pes_val);
+}
+static DEVICE_ATTR_RO(xmc_12v_pex_curr);
+
+static ssize_t xmc_12v_aux_curr_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_12V_AUX_I_IN_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_12v_aux_curr);
+
+static ssize_t xmc_3v3_pex_vol_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_3V3_PEX_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_3v3_pex_vol);
+
+static ssize_t xmc_3v3_aux_vol_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_3V3_AUX_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_3v3_aux_vol);
+
+static ssize_t xmc_ddr_vpp_btm_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_DDR4_VPP_BTM_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_ddr_vpp_btm);
+
+static ssize_t xmc_sys_5v5_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_SYS_5V5_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_sys_5v5);
+
+static ssize_t xmc_1v2_top_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_VCC1V2_TOP_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_1v2_top);
+
+static ssize_t xmc_1v8_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_VCC1V8_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_1v8);
+
+static ssize_t xmc_0v85_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_VCC0V85_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_0v85);
+
+static ssize_t xmc_ddr_vpp_top_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_DDR4_VPP_TOP_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_ddr_vpp_top);
+
+
+static ssize_t xmc_mgt0v9avcc_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_MGT0V9AVCC_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_mgt0v9avcc);
+
+static ssize_t xmc_12v_sw_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_12V_SW_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_12v_sw);
+
+
+static ssize_t xmc_mgtavtt_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_MGTAVTT_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_mgtavtt);
+
+static ssize_t xmc_vcc1v2_btm_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_VCC1V2_BTM_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_vcc1v2_btm);
+
+static ssize_t xmc_vccint_vol_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_VCCINT_V_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_vccint_vol);
+
+static ssize_t xmc_vccint_curr_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_VCCINT_I_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_vccint_curr);
+
+static ssize_t xmc_se98_temp0_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_SE98_TEMP0_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_se98_temp0);
+
+static ssize_t xmc_se98_temp1_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_SE98_TEMP1_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_se98_temp1);
+
+static ssize_t xmc_se98_temp2_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_SE98_TEMP2_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_se98_temp2);
+
+static ssize_t xmc_fpga_temp_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_FPGA_TEMP, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_fpga_temp);
+
+static ssize_t xmc_fan_temp_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_FAN_TEMP_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_fan_temp);
+
+static ssize_t xmc_fan_rpm_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_FAN_SPEED_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_fan_rpm);
+
+
+static ssize_t xmc_dimm_temp0_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_DIMM_TEMP0_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_dimm_temp0);
+
+static ssize_t xmc_dimm_temp1_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_DIMM_TEMP1_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_dimm_temp1);
+
+static ssize_t xmc_dimm_temp2_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_DIMM_TEMP2_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_dimm_temp2);
+
+static ssize_t xmc_dimm_temp3_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_DIMM_TEMP3_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_dimm_temp3);
+
+
+static ssize_t xmc_cage_temp0_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_CAGE_TEMP0_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_cage_temp0);
+
+static ssize_t xmc_cage_temp1_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_CAGE_TEMP1_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_cage_temp1);
+
+static ssize_t xmc_cage_temp2_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_CAGE_TEMP2_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_cage_temp2);
+
+static ssize_t xmc_cage_temp3_show(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_CAGE_TEMP3_REG+sizeof(u32)*VOLTAGE_INS, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(xmc_cage_temp3);
+
+
+static ssize_t version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_VERSION_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t sensor_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_SENSOR_REG, &val);
+
+	return sprintf(buf, "0x%04x\n", val);
+}
+static DEVICE_ATTR_RO(sensor);
+
+
+static ssize_t id_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_MAGIC_REG, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(id);
+
+static ssize_t status_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_STATUS_REG, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t error_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_ERROR_REG, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(error);
+
+static ssize_t capability_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_FEATURE_REG, &val);
+
+	return sprintf(buf, "%x\n", val);
+}
+static DEVICE_ATTR_RO(capability);
+
+static ssize_t power_checksum_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_SNSR_CHKSUM_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(power_checksum);
+
+static ssize_t pause_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	safe_read32(xmc, XMC_CONTROL_REG, &val);
+
+	return sprintf(buf, "%d\n", !!(val & CTL_MASK_PAUSE));
+}
+
+static ssize_t pause_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val) == -EINVAL || val > 1)
+		return -EINVAL;
+
+	val = val ? CTL_MASK_PAUSE : 0;
+	safe_write32(xmc, XMC_CONTROL_REG, val);
+
+	return count;
+}
+static DEVICE_ATTR_RW(pause);
+
+static ssize_t reset_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xocl_xmc *xmc = platform_get_drvdata(to_platform_device(dev));
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val) == -EINVAL || val > 1)
+		return -EINVAL;
+
+	if (val)
+		load_xmc(xmc);
+
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static ssize_t power_flag_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_SNSR_FLAGS_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(power_flag);
+
+static ssize_t host_msg_offset_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_HOST_MSG_OFFSET_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(host_msg_offset);
+
+static ssize_t host_msg_error_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_HOST_MSG_ERROR_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(host_msg_error);
+
+static ssize_t host_msg_header_show(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_HOST_MSG_HEADER_REG, &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+static DEVICE_ATTR_RO(host_msg_header);
+
+
+
+static int get_temp_by_m_tag(struct xocl_xmc *xmc, char *m_tag)
+{
+
+	/**
+	 *   m_tag get from xclbin must follow this format
+	 *   DDR[0] or bank1
+	 *   we check the index in m_tag to decide which temperature
+	 *   to get from XMC IP base address
+	 */
+	char *start = NULL, *left_parentness = NULL, *right_parentness = NULL;
+	long idx;
+	int ret = 0, digit_len = 0;
+	char temp[4];
+
+	if (!xmc)
+		return -ENODEV;
+
+
+	if (!strncmp(m_tag, "bank", 4)) {
+		start = m_tag;
+		// bank0, no left parentness
+		left_parentness = m_tag+3;
+		right_parentness = m_tag+strlen(m_tag)+1;
+		digit_len = right_parentness-(2+left_parentness);
+	} else if (!strncmp(m_tag, "DDR", 3)) {
+
+		start = m_tag;
+		left_parentness = strstr(m_tag, "[");
+		right_parentness = strstr(m_tag, "]");
+		digit_len = right_parentness-(1+left_parentness);
+	}
+
+	if (!left_parentness || !right_parentness)
+		return ret;
+
+	if (!strncmp(m_tag, "DDR", left_parentness-start) || !strncmp(m_tag, "bank", left_parentness-start)) {
+
+		strncpy(temp, left_parentness+1, digit_len);
+		//assumption, temperature won't higher than 3 digits, or the temp[digit_len] should be a null character
+		temp[digit_len] = '\0';
+		//convert to signed long, decimal base
+		if (kstrtol(temp, 10, &idx) == 0 && idx < 4 && idx >= 0)
+			safe_read32(xmc, XMC_DIMM_TEMP0_REG + (3*sizeof(int32_t)) * idx +
+				    sizeof(u32)*VOLTAGE_INS, &ret);
+		else
+			ret = 0;
+	}
+
+	return ret;
+
+}
+
+static struct attribute *xmc_attrs[] = {
+	&dev_attr_version.attr,
+	&dev_attr_id.attr,
+	&dev_attr_status.attr,
+	&dev_attr_sensor.attr,
+	&dev_attr_error.attr,
+	&dev_attr_capability.attr,
+	&dev_attr_power_checksum.attr,
+	&dev_attr_xmc_12v_pex_vol.attr,
+	&dev_attr_xmc_12v_aux_vol.attr,
+	&dev_attr_xmc_12v_pex_curr.attr,
+	&dev_attr_xmc_12v_aux_curr.attr,
+	&dev_attr_xmc_3v3_pex_vol.attr,
+	&dev_attr_xmc_3v3_aux_vol.attr,
+	&dev_attr_xmc_ddr_vpp_btm.attr,
+	&dev_attr_xmc_sys_5v5.attr,
+	&dev_attr_xmc_1v2_top.attr,
+	&dev_attr_xmc_1v8.attr,
+	&dev_attr_xmc_0v85.attr,
+	&dev_attr_xmc_ddr_vpp_top.attr,
+	&dev_attr_xmc_mgt0v9avcc.attr,
+	&dev_attr_xmc_12v_sw.attr,
+	&dev_attr_xmc_mgtavtt.attr,
+	&dev_attr_xmc_vcc1v2_btm.attr,
+	&dev_attr_xmc_fpga_temp.attr,
+	&dev_attr_xmc_fan_temp.attr,
+	&dev_attr_xmc_fan_rpm.attr,
+	&dev_attr_xmc_dimm_temp0.attr,
+	&dev_attr_xmc_dimm_temp1.attr,
+	&dev_attr_xmc_dimm_temp2.attr,
+	&dev_attr_xmc_dimm_temp3.attr,
+	&dev_attr_xmc_vccint_vol.attr,
+	&dev_attr_xmc_vccint_curr.attr,
+	&dev_attr_xmc_se98_temp0.attr,
+	&dev_attr_xmc_se98_temp1.attr,
+	&dev_attr_xmc_se98_temp2.attr,
+	&dev_attr_xmc_cage_temp0.attr,
+	&dev_attr_xmc_cage_temp1.attr,
+	&dev_attr_xmc_cage_temp2.attr,
+	&dev_attr_xmc_cage_temp3.attr,
+	&dev_attr_pause.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_power_flag.attr,
+	&dev_attr_host_msg_offset.attr,
+	&dev_attr_host_msg_error.attr,
+	&dev_attr_host_msg_header.attr,
+	NULL,
+};
+
+
+static ssize_t read_temp_by_mem_topology(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t offset, size_t count)
+{
+	u32 nread = 0;
+	size_t size = 0;
+	u32 i;
+	struct mem_topology *memtopo = NULL;
+	struct xocl_xmc *xmc;
+	uint32_t temp[MAX_M_COUNT] = {0};
+	struct xclmgmt_dev *lro;
+
+	//xocl_icap_lock_bitstream
+	lro = (struct xclmgmt_dev *)dev_get_drvdata(container_of(kobj, struct device, kobj)->parent);
+	xmc = (struct xocl_xmc *)dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	memtopo = (struct mem_topology *)xocl_icap_get_data(lro, MEMTOPO_AXLF);
+
+	if (!memtopo)
+		return 0;
+
+	size = sizeof(u32)*(memtopo->m_count);
+
+	if (offset >= size)
+		return 0;
+
+	for (i = 0; i < memtopo->m_count; ++i)
+		*(temp+i) = get_temp_by_m_tag(xmc, memtopo->m_mem_data[i].m_tag);
+
+	if (count < size - offset)
+		nread = count;
+	else
+		nread = size - offset;
+
+	memcpy(buffer, temp, nread);
+	//xocl_icap_unlock_bitstream
+	return nread;
+}
+
+static struct bin_attribute bin_dimm_temp_by_mem_topology_attr = {
+	.attr = {
+		.name = "temp_by_mem_topology",
+		.mode = 0444
+	},
+	.read = read_temp_by_mem_topology,
+	.write = NULL,
+	.size = 0
+};
+
+static struct bin_attribute *xmc_bin_attrs[] = {
+	&bin_dimm_temp_by_mem_topology_attr,
+	NULL,
+};
+
+static struct attribute_group xmc_attr_group = {
+	.attrs = xmc_attrs,
+	.bin_attrs = xmc_bin_attrs,
+};
+static ssize_t show_mb_pw(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct xocl_xmc *xmc = dev_get_drvdata(dev);
+	u32 val;
+
+	safe_read32(xmc, XMC_12V_PEX_REG + attr->index * sizeof(u32), &val);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static SENSOR_DEVICE_ATTR(curr1_highest, 0444, show_mb_pw, NULL, 0);
+static SENSOR_DEVICE_ATTR(curr1_average, 0444, show_mb_pw, NULL, 1);
+static SENSOR_DEVICE_ATTR(curr1_input, 0444, show_mb_pw, NULL, 2);
+static SENSOR_DEVICE_ATTR(curr2_highest, 0444, show_mb_pw, NULL, 3);
+static SENSOR_DEVICE_ATTR(curr2_average, 0444, show_mb_pw, NULL, 4);
+static SENSOR_DEVICE_ATTR(curr2_input, 0444, show_mb_pw, NULL, 5);
+static SENSOR_DEVICE_ATTR(curr3_highest, 0444, show_mb_pw, NULL, 6);
+static SENSOR_DEVICE_ATTR(curr3_average, 0444, show_mb_pw, NULL, 7);
+static SENSOR_DEVICE_ATTR(curr3_input, 0444, show_mb_pw, NULL, 8);
+static SENSOR_DEVICE_ATTR(curr4_highest, 0444, show_mb_pw, NULL, 9);
+static SENSOR_DEVICE_ATTR(curr4_average, 0444, show_mb_pw, NULL, 10);
+static SENSOR_DEVICE_ATTR(curr4_input, 0444, show_mb_pw, NULL, 11);
+static SENSOR_DEVICE_ATTR(curr5_highest, 0444, show_mb_pw, NULL, 12);
+static SENSOR_DEVICE_ATTR(curr5_average, 0444, show_mb_pw, NULL, 13);
+static SENSOR_DEVICE_ATTR(curr5_input, 0444, show_mb_pw, NULL, 14);
+static SENSOR_DEVICE_ATTR(curr6_highest, 0444, show_mb_pw, NULL, 15);
+static SENSOR_DEVICE_ATTR(curr6_average, 0444, show_mb_pw, NULL, 16);
+static SENSOR_DEVICE_ATTR(curr6_input, 0444, show_mb_pw, NULL, 17);
+
+static struct attribute *hwmon_xmc_attributes[] = {
+	&sensor_dev_attr_curr1_highest.dev_attr.attr,
+	&sensor_dev_attr_curr1_average.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_highest.dev_attr.attr,
+	&sensor_dev_attr_curr2_average.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_curr3_highest.dev_attr.attr,
+	&sensor_dev_attr_curr3_average.dev_attr.attr,
+	&sensor_dev_attr_curr3_input.dev_attr.attr,
+	&sensor_dev_attr_curr4_highest.dev_attr.attr,
+	&sensor_dev_attr_curr4_average.dev_attr.attr,
+	&sensor_dev_attr_curr4_input.dev_attr.attr,
+	&sensor_dev_attr_curr5_highest.dev_attr.attr,
+	&sensor_dev_attr_curr5_average.dev_attr.attr,
+	&sensor_dev_attr_curr5_input.dev_attr.attr,
+	&sensor_dev_attr_curr6_highest.dev_attr.attr,
+	&sensor_dev_attr_curr6_average.dev_attr.attr,
+	&sensor_dev_attr_curr6_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group hwmon_xmc_attrgroup = {
+	.attrs = hwmon_xmc_attributes,
+};
+
+static ssize_t show_name(struct device *dev, struct device_attribute *da,
+	char *buf)
+{
+	return sprintf(buf, "%s\n", XCLMGMT_MB_HWMON_NAME);
+}
+
+static struct sensor_device_attribute name_attr =
+	SENSOR_ATTR(name, 0444, show_name, NULL, 0);
+
+static void mgmt_sysfs_destroy_xmc(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+
+	xmc = platform_get_drvdata(pdev);
+
+	if (!xmc->enabled)
+		return;
+
+	if (xmc->hwmon_dev) {
+		device_remove_file(xmc->hwmon_dev, &name_attr.dev_attr);
+		sysfs_remove_group(&xmc->hwmon_dev->kobj,
+			&hwmon_xmc_attrgroup);
+		hwmon_device_unregister(xmc->hwmon_dev);
+		xmc->hwmon_dev = NULL;
+	}
+
+	sysfs_remove_group(&pdev->dev.kobj, &xmc_attr_group);
+}
+
+static int mgmt_sysfs_create_xmc(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+	struct xocl_dev_core *core;
+	int err;
+
+	xmc = platform_get_drvdata(pdev);
+	core = XDEV(xocl_get_xdev(pdev));
+
+	if (!xmc->enabled)
+		return 0;
+
+	err = sysfs_create_group(&pdev->dev.kobj, &xmc_attr_group);
+	if (err) {
+		xocl_err(&pdev->dev, "create xmc attrs failed: 0x%x", err);
+		goto create_attr_failed;
+	}
+	xmc->hwmon_dev = hwmon_device_register(&core->pdev->dev);
+	if (IS_ERR(xmc->hwmon_dev)) {
+		err = PTR_ERR(xmc->hwmon_dev);
+		xocl_err(&pdev->dev, "register xmc hwmon failed: 0x%x", err);
+		goto hwmon_reg_failed;
+	}
+
+	dev_set_drvdata(xmc->hwmon_dev, xmc);
+
+	err = device_create_file(xmc->hwmon_dev, &name_attr.dev_attr);
+	if (err) {
+		xocl_err(&pdev->dev, "create attr name failed: 0x%x", err);
+		goto create_name_failed;
+	}
+
+	err = sysfs_create_group(&xmc->hwmon_dev->kobj,
+		&hwmon_xmc_attrgroup);
+	if (err) {
+		xocl_err(&pdev->dev, "create pw group failed: 0x%x", err);
+		goto create_pw_failed;
+	}
+
+	return 0;
+
+create_pw_failed:
+	device_remove_file(xmc->hwmon_dev, &name_attr.dev_attr);
+create_name_failed:
+	hwmon_device_unregister(xmc->hwmon_dev);
+	xmc->hwmon_dev = NULL;
+hwmon_reg_failed:
+	sysfs_remove_group(&pdev->dev.kobj, &xmc_attr_group);
+create_attr_failed:
+	return err;
+}
+
+static int stop_xmc_nolock(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+	int retry = 0;
+	u32 reg_val = 0;
+	void *xdev_hdl;
+
+	xmc = platform_get_drvdata(pdev);
+	if (!xmc)
+		return -ENODEV;
+	else if (!xmc->enabled)
+		return -ENODEV;
+
+	xdev_hdl = xocl_get_xdev(xmc->pdev);
+
+	reg_val = READ_GPIO(xmc, 0);
+	xocl_info(&xmc->pdev->dev, "MB Reset GPIO 0x%x", reg_val);
+
+	//Stop XMC and ERT if its currently running
+	if (reg_val == GPIO_ENABLED) {
+		xocl_info(&xmc->pdev->dev,
+			"XMC info, version 0x%x, status 0x%x, id 0x%x",
+			READ_REG32(xmc, XMC_VERSION_REG),
+			READ_REG32(xmc, XMC_STATUS_REG),
+			READ_REG32(xmc, XMC_MAGIC_REG));
+
+		reg_val = READ_REG32(xmc, XMC_STATUS_REG);
+		if (!(reg_val & STATUS_MASK_STOPPED)) {
+			xocl_info(&xmc->pdev->dev, "Stopping XMC...");
+			WRITE_REG32(xmc, CTL_MASK_STOP, XMC_CONTROL_REG);
+			WRITE_REG32(xmc, 1, XMC_STOP_CONFIRM_REG);
+		}
+		//Need to check if ERT is loaded before we attempt to stop it
+		if (!SELF_JUMP(READ_IMAGE_SCHED(xmc, 0))) {
+			reg_val = XOCL_READ_REG32(xmc->base_addrs[IO_CQ]);
+			if (!(reg_val & ERT_STOP_ACK)) {
+				xocl_info(&xmc->pdev->dev, "Stopping scheduler...");
+				XOCL_WRITE_REG32(ERT_STOP_CMD, xmc->base_addrs[IO_CQ]);
+			}
+		}
+
+		retry = 0;
+		while (retry++ < MAX_XMC_RETRY &&
+			!(READ_REG32(xmc, XMC_STATUS_REG) & STATUS_MASK_STOPPED))
+			msleep(RETRY_INTERVAL);
+
+		//Wait for XMC to stop and then check that ERT has also finished
+		if (retry >= MAX_XMC_RETRY) {
+			xocl_err(&xmc->pdev->dev,
+				"Failed to stop XMC");
+			xocl_err(&xmc->pdev->dev,
+				"XMC Error Reg 0x%x",
+				READ_REG32(xmc, XMC_ERROR_REG));
+			xmc->state = XMC_STATE_ERROR;
+			return -ETIMEDOUT;
+		} else if (!SELF_JUMP(READ_IMAGE_SCHED(xmc, 0)) &&
+			 !(XOCL_READ_REG32(xmc->base_addrs[IO_CQ]) & ERT_STOP_ACK)) {
+			while (retry++ < MAX_ERT_RETRY &&
+				!(XOCL_READ_REG32(xmc->base_addrs[IO_CQ]) & ERT_STOP_ACK))
+				msleep(RETRY_INTERVAL);
+			if (retry >= MAX_ERT_RETRY) {
+				xocl_err(&xmc->pdev->dev,
+					"Failed to stop sched");
+				xocl_err(&xmc->pdev->dev,
+					"Scheduler CQ status 0x%x",
+					XOCL_READ_REG32(xmc->base_addrs[IO_CQ]));
+				//We don't exit if ERT doesn't stop since it can hang due to bad kernel
+				//xmc->state = XMC_STATE_ERROR;
+				//return -ETIMEDOUT;
+			}
+		}
+
+		xocl_info(&xmc->pdev->dev, "XMC/sched Stopped, retry %d",
+			retry);
+	}
+
+	// Hold XMC in reset now that its safely stopped
+	xocl_info(&xmc->pdev->dev,
+		"XMC info, version 0x%x, status 0x%x, id 0x%x",
+		READ_REG32(xmc, XMC_VERSION_REG),
+		READ_REG32(xmc, XMC_STATUS_REG),
+		READ_REG32(xmc, XMC_MAGIC_REG));
+	WRITE_GPIO(xmc, GPIO_RESET, 0);
+	xmc->state = XMC_STATE_RESET;
+	reg_val = READ_GPIO(xmc, 0);
+	xocl_info(&xmc->pdev->dev, "MB Reset GPIO 0x%x", reg_val);
+	if (reg_val != GPIO_RESET) {
+		//Shouldnt make it here but if we do then exit
+		xmc->state = XMC_STATE_ERROR;
+		return -EIO;
+	}
+
+	return 0;
+}
+static int stop_xmc(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+	int ret = 0;
+	void *xdev_hdl;
+
+	xocl_info(&pdev->dev, "Stop Microblaze...");
+	xmc = platform_get_drvdata(pdev);
+	if (!xmc)
+		return -ENODEV;
+	else if (!xmc->enabled)
+		return -ENODEV;
+
+	xdev_hdl = xocl_get_xdev(xmc->pdev);
+
+	mutex_lock(&xmc->xmc_lock);
+	ret = stop_xmc_nolock(pdev);
+	mutex_unlock(&xmc->xmc_lock);
+
+	return ret;
+}
+
+static int load_xmc(struct xocl_xmc *xmc)
+{
+	int retry = 0;
+	u32 reg_val = 0;
+	int ret = 0;
+	void *xdev_hdl;
+
+	if (!xmc->enabled)
+		return -ENODEV;
+
+	mutex_lock(&xmc->xmc_lock);
+
+	/* Stop XMC first */
+	ret = stop_xmc_nolock(xmc->pdev);
+	if (ret != 0)
+		goto out;
+
+	xdev_hdl = xocl_get_xdev(xmc->pdev);
+
+	/* Load XMC and ERT Image */
+	if (xocl_mb_mgmt_on(xdev_hdl)) {
+		xocl_info(&xmc->pdev->dev, "Copying XMC image len %d",
+			xmc->mgmt_binary_length);
+		COPY_MGMT(xmc, xmc->mgmt_binary, xmc->mgmt_binary_length);
+	}
+
+	if (xocl_mb_sched_on(xdev_hdl)) {
+		xocl_info(&xmc->pdev->dev, "Copying scheduler image len %d",
+			xmc->sche_binary_length);
+		COPY_SCHE(xmc, xmc->sche_binary, xmc->sche_binary_length);
+	}
+
+	/* Take XMC and ERT out of reset */
+	WRITE_GPIO(xmc, GPIO_ENABLED, 0);
+	reg_val = READ_GPIO(xmc, 0);
+	xocl_info(&xmc->pdev->dev, "MB Reset GPIO 0x%x", reg_val);
+	if (reg_val != GPIO_ENABLED) {
+		//Shouldnt make it here but if we do then exit
+		xmc->state = XMC_STATE_ERROR;
+		goto out;
+	}
+
+	/* Wait for XMC to start
+	 * Note that ERT will start long before XMC so we don't check anything
+	 */
+	reg_val = READ_REG32(xmc, XMC_STATUS_REG);
+	if (!(reg_val & STATUS_MASK_INIT_DONE)) {
+		xocl_info(&xmc->pdev->dev, "Waiting for XMC to finish init...");
+		retry = 0;
+		while (retry++ < MAX_XMC_RETRY &&
+			!(READ_REG32(xmc, XMC_STATUS_REG) & STATUS_MASK_INIT_DONE))
+			msleep(RETRY_INTERVAL);
+		if (retry >= MAX_XMC_RETRY) {
+			xocl_err(&xmc->pdev->dev,
+				"XMC did not finish init sequence!");
+			xocl_err(&xmc->pdev->dev,
+				"Error Reg 0x%x",
+				READ_REG32(xmc, XMC_ERROR_REG));
+			xocl_err(&xmc->pdev->dev,
+				"Status Reg 0x%x",
+				READ_REG32(xmc, XMC_STATUS_REG));
+			ret = -ETIMEDOUT;
+			xmc->state = XMC_STATE_ERROR;
+			goto out;
+		}
+	}
+	xocl_info(&xmc->pdev->dev, "XMC and scheduler Enabled, retry %d",
+			retry);
+	xocl_info(&xmc->pdev->dev,
+		"XMC info, version 0x%x, status 0x%x, id 0x%x",
+		READ_REG32(xmc, XMC_VERSION_REG),
+		READ_REG32(xmc, XMC_STATUS_REG),
+		READ_REG32(xmc, XMC_MAGIC_REG));
+	xmc->state = XMC_STATE_ENABLED;
+
+	xmc->cap = READ_REG32(xmc, XMC_FEATURE_REG);
+out:
+	mutex_unlock(&xmc->xmc_lock);
+
+	return ret;
+}
+
+static void xmc_reset(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+
+	xocl_info(&pdev->dev, "Reset Microblaze...");
+	xmc = platform_get_drvdata(pdev);
+	if (!xmc)
+		return;
+
+	load_xmc(xmc);
+}
+
+static int load_mgmt_image(struct platform_device *pdev, const char *image,
+	u32 len)
+{
+	struct xocl_xmc *xmc;
+	char *binary;
+
+	if (len > MAX_IMAGE_LEN)
+		return -EINVAL;
+
+	xmc = platform_get_drvdata(pdev);
+	if (!xmc)
+		return -EINVAL;
+
+	binary = xmc->mgmt_binary;
+	xmc->mgmt_binary = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!xmc->mgmt_binary)
+		return -ENOMEM;
+
+	if (binary)
+		devm_kfree(&pdev->dev, binary);
+	memcpy(xmc->mgmt_binary, image, len);
+	xmc->mgmt_binary_length = len;
+
+	return 0;
+}
+
+static int load_sche_image(struct platform_device *pdev, const char *image,
+	u32 len)
+{
+	struct xocl_xmc *xmc;
+	char *binary = NULL;
+
+	if (len > MAX_IMAGE_LEN)
+		return -EINVAL;
+
+	xmc = platform_get_drvdata(pdev);
+	if (!xmc)
+		return -EINVAL;
+
+	binary = xmc->sche_binary;
+	xmc->sche_binary = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!xmc->sche_binary)
+		return -ENOMEM;
+
+	if (binary)
+		devm_kfree(&pdev->dev, binary);
+	memcpy(xmc->sche_binary, image, len);
+	xmc->sche_binary_length = len;
+
+	return 0;
+}
+
+static struct xocl_mb_funcs xmc_ops = {
+	.load_mgmt_image	= load_mgmt_image,
+	.load_sche_image	= load_sche_image,
+	.reset			= xmc_reset,
+	.stop			= stop_xmc,
+	.get_data     = xmc_get_data,
+};
+
+static int xmc_remove(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+	int	i;
+
+	xmc = platform_get_drvdata(pdev);
+	if (!xmc)
+		return 0;
+
+	if (xmc->mgmt_binary)
+		devm_kfree(&pdev->dev, xmc->mgmt_binary);
+	if (xmc->sche_binary)
+		devm_kfree(&pdev->dev, xmc->sche_binary);
+
+	mgmt_sysfs_destroy_xmc(pdev);
+
+	for (i = 0; i < NUM_IOADDR; i++) {
+		if (xmc->base_addrs[i])
+			iounmap(xmc->base_addrs[i]);
+	}
+
+	mutex_destroy(&xmc->xmc_lock);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, xmc);
+
+	return 0;
+}
+
+static int xmc_probe(struct platform_device *pdev)
+{
+	struct xocl_xmc *xmc;
+	struct resource *res;
+	void	*xdev_hdl;
+	int i, err;
+
+	xmc = devm_kzalloc(&pdev->dev, sizeof(*xmc), GFP_KERNEL);
+	if (!xmc) {
+		xocl_err(&pdev->dev, "out of memory");
+		return -ENOMEM;
+	}
+
+	xmc->pdev = pdev;
+	platform_set_drvdata(pdev, xmc);
+
+	xdev_hdl = xocl_get_xdev(pdev);
+	if (xocl_mb_mgmt_on(xdev_hdl) || xocl_mb_sched_on(xdev_hdl)) {
+		xocl_info(&pdev->dev, "Microblaze is supported.");
+		xmc->enabled = true;
+	} else {
+		xocl_err(&pdev->dev, "Microblaze is not supported.");
+		devm_kfree(&pdev->dev, xmc);
+		platform_set_drvdata(pdev, NULL);
+		return 0;
+	}
+
+	for (i = 0; i < NUM_IOADDR; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (res) {
+			xocl_info(&pdev->dev, "IO start: 0x%llx, end: 0x%llx",
+				res->start, res->end);
+			xmc->base_addrs[i] =
+				ioremap_nocache(res->start, res->end - res->start + 1);
+			if (!xmc->base_addrs[i]) {
+				err = -EIO;
+				xocl_err(&pdev->dev, "Map iomem failed");
+				goto failed;
+			}
+		} else
+			break;
+	}
+
+	err = mgmt_sysfs_create_xmc(pdev);
+	if (err) {
+		xocl_err(&pdev->dev, "Create sysfs failed, err %d", err);
+		goto failed;
+	}
+
+	xocl_subdev_register(pdev, XOCL_SUBDEV_XMC, &xmc_ops);
+
+	mutex_init(&xmc->xmc_lock);
+
+	return 0;
+
+failed:
+	xmc_remove(pdev);
+	return err;
+}
+
+struct platform_device_id xmc_id_table[] = {
+	{ XOCL_XMC, 0 },
+	{ },
+};
+
+static struct platform_driver	xmc_driver = {
+	.probe		= xmc_probe,
+	.remove		= xmc_remove,
+	.driver		= {
+		.name = XOCL_XMC,
+	},
+	.id_table = xmc_id_table,
+};
+
+int __init xocl_init_xmc(void)
+{
+	return platform_driver_register(&xmc_driver);
+}
+
+void xocl_fini_xmc(void)
+{
+	platform_driver_unregister(&xmc_driver);
+}
diff --git a/drivers/gpu/drm/xocl/subdev/xvc.c b/drivers/gpu/drm/xocl/subdev/xvc.c
new file mode 100644
index 000000000000..355dbad30b00
--- /dev/null
+++ b/drivers/gpu/drm/xocl/subdev/xvc.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ":%s: " fmt, __func__
+
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/ioctl.h>
+
+#include "../xocl_drv.h"
+
+/* IOCTL interfaces */
+#define XIL_XVC_MAGIC 0x58564344  // "XVCD"
+#define	MINOR_PUB_HIGH_BIT	0x00000
+#define	MINOR_PRI_HIGH_BIT	0x10000
+#define MINOR_NAME_MASK		0xffffffff
+
+enum xvc_algo_type {
+	XVC_ALGO_NULL,
+	XVC_ALGO_CFG,
+	XVC_ALGO_BAR
+};
+
+struct xil_xvc_ioc {
+	unsigned int opcode;
+	unsigned int length;
+	unsigned char *tms_buf;
+	unsigned char *tdi_buf;
+	unsigned char *tdo_buf;
+};
+
+struct xil_xvc_properties {
+	unsigned int xvc_algo_type;
+	unsigned int config_vsec_id;
+	unsigned int config_vsec_rev;
+	unsigned int bar_index;
+	unsigned int bar_offset;
+};
+
+#define XDMA_IOCXVC	     _IOWR(XIL_XVC_MAGIC, 1, struct xil_xvc_ioc)
+#define XDMA_RDXVC_PROPS _IOR(XIL_XVC_MAGIC, 2, struct xil_xvc_properties)
+
+#define COMPLETION_LOOP_MAX	100
+
+#define XVC_BAR_LENGTH_REG	0x0
+#define XVC_BAR_TMS_REG		0x4
+#define XVC_BAR_TDI_REG		0x8
+#define XVC_BAR_TDO_REG		0xC
+#define XVC_BAR_CTRL_REG	0x10
+
+#define XVC_DEV_NAME "xvc" SUBDEV_SUFFIX
+
+struct xocl_xvc {
+	void *__iomem base;
+	unsigned int instance;
+	struct cdev *sys_cdev;
+	struct device *sys_device;
+};
+
+static dev_t xvc_dev;
+
+static struct xil_xvc_properties xvc_pci_props;
+
+#ifdef __REG_DEBUG__
+/* SECTION: Function definitions */
+static inline void __write_register(const char *fn, u32 value, void *base,
+				unsigned int off)
+{
+	pr_info("%s: 0x%p, W reg 0x%lx, 0x%x.\n", fn, base, off, value);
+	iowrite32(value, base + off);
+}
+
+static inline u32 __read_register(const char *fn, void *base, unsigned int off)
+{
+	u32 v = ioread32(base + off);
+
+	pr_info("%s: 0x%p, R reg 0x%lx, 0x%x.\n", fn, base, off, v);
+	return v;
+}
+#define write_register(v, base, off) __write_register(__func__, v, base, off)
+#define read_register(base, off) __read_register(__func__, base, off)
+
+#else
+#define write_register(v, base, off) iowrite32(v, (base) + (off))
+#define read_register(base, off) ioread32((base) + (off))
+#endif /* #ifdef __REG_DEBUG__ */
+
+
+static int xvc_shift_bits(void *base, u32 tms_bits, u32 tdi_bits,
+			  u32 *tdo_bits)
+{
+	u32 control;
+	u32 write_reg_data;
+	int count;
+
+	/* set tms bit */
+	write_register(tms_bits, base, XVC_BAR_TMS_REG);
+	/* set tdi bits and shift data out */
+	write_register(tdi_bits, base, XVC_BAR_TDI_REG);
+
+	control = read_register(base, XVC_BAR_CTRL_REG);
+	/* enable shift operation */
+	write_reg_data = control | 0x01;
+	write_register(write_reg_data, base, XVC_BAR_CTRL_REG);
+
+	/* poll for completion */
+	count = COMPLETION_LOOP_MAX;
+	while (count) {
+		/* read control reg to check shift operation completion */
+		control = read_register(base, XVC_BAR_CTRL_REG);
+		if ((control & 0x01) == 0)
+			break;
+
+		count--;
+	}
+
+	if (!count)	{
+		pr_warn("XVC bar transaction timed out (0x%0X)\n", control);
+		return -ETIMEDOUT;
+	}
+
+	/* read tdo bits back out */
+	*tdo_bits = read_register(base, XVC_BAR_TDO_REG);
+
+	return 0;
+}
+
+static long xvc_ioctl_helper(struct xocl_xvc *xvc, const void __user *arg)
+{
+	struct xil_xvc_ioc xvc_obj;
+	unsigned int opcode;
+	unsigned int total_bits;
+	unsigned int total_bytes;
+	unsigned int bits, bits_left;
+	unsigned char *buffer = NULL;
+	unsigned char *tms_buf = NULL;
+	unsigned char *tdi_buf = NULL;
+	unsigned char *tdo_buf = NULL;
+	void __iomem *iobase = xvc->base;
+	u32 control_reg_data;
+	u32 write_reg_data;
+	int rv;
+
+	rv = copy_from_user((void *)&xvc_obj, arg,
+				sizeof(struct xil_xvc_ioc));
+	/* anything not copied ? */
+	if (rv) {
+		pr_info("copy_from_user xvc_obj failed: %d.\n", rv);
+		goto cleanup;
+	}
+
+	opcode = xvc_obj.opcode;
+
+	/* Invalid operation type, no operation performed */
+	if (opcode != 0x01 && opcode != 0x02) {
+		pr_info("UNKNOWN opcode 0x%x.\n", opcode);
+		return -EINVAL;
+	}
+
+	total_bits = xvc_obj.length;
+	total_bytes = (total_bits + 7) >> 3;
+
+	buffer = kmalloc(total_bytes * 3, GFP_KERNEL);
+	if (!buffer) {
+		pr_info("OOM %u, op 0x%x, len %u bits, %u bytes.\n",
+			3 * total_bytes, opcode, total_bits, total_bytes);
+		rv = -ENOMEM;
+		goto cleanup;
+	}
+	tms_buf = buffer;
+	tdi_buf = tms_buf + total_bytes;
+	tdo_buf = tdi_buf + total_bytes;
+
+	rv = copy_from_user((void *)tms_buf, xvc_obj.tms_buf, total_bytes);
+	if (rv) {
+		pr_info("copy tmfs_buf failed: %d/%u.\n", rv, total_bytes);
+		goto cleanup;
+	}
+	rv = copy_from_user((void *)tdi_buf, xvc_obj.tdi_buf, total_bytes);
+	if (rv) {
+		pr_info("copy tdi_buf failed: %d/%u.\n", rv, total_bytes);
+		goto cleanup;
+	}
+
+	// If performing loopback test, set loopback bit (0x02) in control reg
+	if (opcode == 0x02) {
+		control_reg_data = read_register(iobase, XVC_BAR_CTRL_REG);
+		write_reg_data = control_reg_data | 0x02;
+		write_register(write_reg_data, iobase, XVC_BAR_CTRL_REG);
+	}
+
+	/* set length register to 32 initially if more than one
+	 * word-transaction is to be done
+	 */
+	if (total_bits >= 32)
+		write_register(0x20, iobase, XVC_BAR_LENGTH_REG);
+
+	for (bits = 0, bits_left = total_bits; bits < total_bits; bits += 32,
+		bits_left -= 32) {
+		unsigned int bytes = bits >> 3;
+		unsigned int shift_bytes = 4;
+		u32 tms_store = 0;
+		u32 tdi_store = 0;
+		u32 tdo_store = 0;
+
+		if (bits_left < 32) {
+			/* set number of bits to shift out */
+			write_register(bits_left, iobase, XVC_BAR_LENGTH_REG);
+			shift_bytes = (bits_left + 7) >> 3;
+		}
+
+		memcpy(&tms_store, tms_buf + bytes, shift_bytes);
+		memcpy(&tdi_store, tdi_buf + bytes, shift_bytes);
+
+		/* Shift data out and copy to output buffer */
+		rv = xvc_shift_bits(iobase, tms_store, tdi_store, &tdo_store);
+		if (rv < 0)
+			goto cleanup;
+
+		memcpy(tdo_buf + bytes, &tdo_store, shift_bytes);
+	}
+
+	// If performing loopback test, reset loopback bit in control reg
+	if (opcode == 0x02) {
+		control_reg_data = read_register(iobase, XVC_BAR_CTRL_REG);
+		write_reg_data = control_reg_data & ~(0x02);
+		write_register(write_reg_data, iobase, XVC_BAR_CTRL_REG);
+	}
+
+	rv = copy_to_user((void *)xvc_obj.tdo_buf, tdo_buf, total_bytes);
+	if (rv) {
+		pr_info("copy back tdo_buf failed: %d/%u.\n", rv, total_bytes);
+		rv = -EFAULT;
+		goto cleanup;
+	}
+
+cleanup:
+	kfree(buffer);
+
+	mmiowb();
+
+	return rv;
+}
+
+static long xvc_read_properties(struct xocl_xvc *xvc, const void __user *arg)
+{
+	int status = 0;
+	struct xil_xvc_properties xvc_props_obj;
+
+	xvc_props_obj.xvc_algo_type   = (unsigned int) xvc_pci_props.xvc_algo_type;
+	xvc_props_obj.config_vsec_id  = xvc_pci_props.config_vsec_id;
+	xvc_props_obj.config_vsec_rev = xvc_pci_props.config_vsec_rev;
+	xvc_props_obj.bar_index		  = xvc_pci_props.bar_index;
+	xvc_props_obj.bar_offset	  = xvc_pci_props.bar_offset;
+
+	if (copy_to_user((void *)arg, &xvc_props_obj, sizeof(xvc_props_obj)))
+		status = -ENOMEM;
+
+	mmiowb();
+	return status;
+}
+
+static long xvc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct xocl_xvc *xvc = filp->private_data;
+	long status = 0;
+
+	switch (cmd) {
+	case XDMA_IOCXVC:
+		status = xvc_ioctl_helper(xvc, (void __user *)arg);
+		break;
+	case XDMA_RDXVC_PROPS:
+		status = xvc_read_properties(xvc, (void __user *)arg);
+		break;
+	default:
+		status = -ENOIOCTLCMD;
+		break;
+	}
+
+	return status;
+}
+
+static int char_open(struct inode *inode, struct file *file)
+{
+	struct xocl_xvc *xvc = NULL;
+
+	xvc = xocl_drvinst_open(inode->i_cdev);
+	if (!xvc)
+		return -ENXIO;
+
+	/* create a reference to our char device in the opened file */
+	file->private_data = xvc;
+	return 0;
+}
+
+/*
+ * Called when the device goes from used to unused.
+ */
+static int char_close(struct inode *inode, struct file *file)
+{
+	struct xocl_xvc *xvc = file->private_data;
+
+	xocl_drvinst_close(xvc);
+	return 0;
+}
+
+
+/*
+ * character device file operations for the XVC
+ */
+static const struct file_operations xvc_fops = {
+	.owner = THIS_MODULE,
+	.open = char_open,
+	.release = char_close,
+	.unlocked_ioctl = xvc_ioctl,
+};
+
+static int xvc_probe(struct platform_device *pdev)
+{
+	struct xocl_xvc *xvc;
+	struct resource *res;
+	struct xocl_dev_core *core;
+	int err;
+
+	xvc = xocl_drvinst_alloc(&pdev->dev, sizeof(*xvc));
+	if (!xvc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xvc->base = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!xvc->base) {
+		err = -EIO;
+		xocl_err(&pdev->dev, "Map iomem failed");
+		goto failed;
+	}
+
+	core = xocl_get_xdev(pdev);
+
+	xvc->sys_cdev = cdev_alloc();
+	xvc->sys_cdev->ops = &xvc_fops;
+	xvc->sys_cdev->owner = THIS_MODULE;
+	xvc->instance = XOCL_DEV_ID(core->pdev) |
+		platform_get_device_id(pdev)->driver_data;
+	xvc->sys_cdev->dev = MKDEV(MAJOR(xvc_dev), core->dev_minor);
+	err = cdev_add(xvc->sys_cdev, xvc->sys_cdev->dev, 1);
+	if (err) {
+		xocl_err(&pdev->dev, "cdev_add failed, %d", err);
+		goto failed;
+	}
+
+	xvc->sys_device = device_create(xrt_class, &pdev->dev,
+					xvc->sys_cdev->dev,
+					NULL, "%s%d",
+					platform_get_device_id(pdev)->name,
+					xvc->instance & MINOR_NAME_MASK);
+	if (IS_ERR(xvc->sys_device)) {
+		err = PTR_ERR(xvc->sys_device);
+		goto failed;
+	}
+
+	xocl_drvinst_set_filedev(xvc, xvc->sys_cdev);
+
+	platform_set_drvdata(pdev, xvc);
+	xocl_info(&pdev->dev, "XVC device instance %d initialized\n",
+		xvc->instance);
+
+	// Update PCIe BAR properties in a global structure
+	xvc_pci_props.xvc_algo_type   = XVC_ALGO_BAR;
+	xvc_pci_props.config_vsec_id  = 0;
+	xvc_pci_props.config_vsec_rev = 0;
+	xvc_pci_props.bar_index	      = core->bar_idx;
+	xvc_pci_props.bar_offset      = (unsigned int) res->start - (unsigned int)
+									pci_resource_start(core->pdev, core->bar_idx);
+
+	return 0;
+failed:
+	if (!IS_ERR(xvc->sys_device))
+		device_destroy(xrt_class, xvc->sys_cdev->dev);
+	if (xvc->sys_cdev)
+		cdev_del(xvc->sys_cdev);
+	if (xvc->base)
+		iounmap(xvc->base);
+	xocl_drvinst_free(xvc);
+
+	return err;
+}
+
+
+static int xvc_remove(struct platform_device *pdev)
+{
+	struct xocl_xvc	*xvc;
+
+	xvc = platform_get_drvdata(pdev);
+	if (!xvc) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return -EINVAL;
+	}
+	device_destroy(xrt_class, xvc->sys_cdev->dev);
+	cdev_del(xvc->sys_cdev);
+	if (xvc->base)
+		iounmap(xvc->base);
+
+	platform_set_drvdata(pdev, NULL);
+	xocl_drvinst_free(xvc);
+
+	return 0;
+}
+
+struct platform_device_id xvc_id_table[] = {
+	{ XOCL_XVC_PUB, MINOR_PUB_HIGH_BIT },
+	{ XOCL_XVC_PRI, MINOR_PRI_HIGH_BIT },
+	{ },
+};
+
+static struct platform_driver	xvc_driver = {
+	.probe		= xvc_probe,
+	.remove		= xvc_remove,
+	.driver		= {
+		.name = XVC_DEV_NAME,
+	},
+	.id_table = xvc_id_table,
+};
+
+int __init xocl_init_xvc(void)
+{
+	int err = 0;
+
+	err = alloc_chrdev_region(&xvc_dev, 0, XOCL_MAX_DEVICES, XVC_DEV_NAME);
+	if (err < 0)
+		goto err_register_chrdev;
+
+	err = platform_driver_register(&xvc_driver);
+	if (err)
+		goto err_driver_reg;
+	return 0;
+
+err_driver_reg:
+	unregister_chrdev_region(xvc_dev, XOCL_MAX_DEVICES);
+err_register_chrdev:
+	return err;
+}
+
+void xocl_fini_xvc(void)
+{
+	unregister_chrdev_region(xvc_dev, XOCL_MAX_DEVICES);
+	platform_driver_unregister(&xvc_driver);
+}
-- 
2.17.0

