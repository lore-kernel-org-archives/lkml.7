Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98125217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XLUlNFfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCSVy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:54:28 -0400
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:4742
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfCSVy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5uT3RoGOjmrsMNpi9mlrv0/ktnL+JnwHRpQvPcHkIE=;
 b=XLUlNFfnkaubomSZ9PJuzhilBmsoGghL1qty/MuwwBoF3zsumXUXRFGPeJsPD+qD/zHjgpe05PGctFXdYUhN8GC28cNYkMdcYklHF+cgL6kUEqAjN8djEe4KF5Xvg5MUfHx7DVPQa0bYpBmAQj1I9tHyMnUzX2AHBa8x93RjEvU=
Received: from CY4PR02CA0046.namprd02.prod.outlook.com (2603:10b6:903:117::32)
 by DM6PR02MB5914.namprd02.prod.outlook.com (2603:10b6:5:152::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 21:54:13 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR02CA0046.outlook.office365.com
 (2603:10b6:903:117::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 21:54:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 21:54:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgW-0001QY-8L; Tue, 19 Mar 2019 14:54:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgR-0001Oa-50; Tue, 19 Mar 2019 14:54:07 -0700
Received: from [172.19.73.196] (helo=xsjsonals5570.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <sonals@xilinx.com>)
        id 1h6MgL-0001KJ-Rd; Tue, 19 Mar 2019 14:54:01 -0700
Received: by xsjsonals5570.xilinx.com (Postfix, from userid 1000)
        id 92EF5760024; Tue, 19 Mar 2019 14:54:01 -0700 (PDT)
From:   <sonal.santan@xilinx.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <airlied@redhat.com>, <cyrilc@xilinx.com>, <michals@xilinx.com>,
        <lizhih@xilinx.com>, <hyunk@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>
Subject: [RFC PATCH Xilinx Alveo 5/6] Add management driver
Date:   Tue, 19 Mar 2019 14:54:00 -0700
Message-ID: <20190319215401.6562-6-sonal.santan@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190319215401.6562-1-sonal.santan@xilinx.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(76176011)(126002)(63266004)(48376002)(52956003)(476003)(2906002)(305945005)(4326008)(47776003)(6916009)(2616005)(426003)(356004)(316002)(53946003)(1076003)(54906003)(336012)(50466002)(26005)(5660300002)(81156014)(2351001)(42186006)(16586007)(11346002)(90966002)(51416003)(103686004)(446003)(36386004)(8676002)(107886003)(14444005)(86152003)(30864003)(486006)(50226002)(106002)(478600001)(81166006)(966005)(186003)(106466001)(2876002)(36756003)(8936002)(6266002)(6306002)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5914;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5c3dbab-ae2b-4a3f-fdd2-08d6acb56c91
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB5914;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5914:
X-MS-Exchange-PUrlCount: 2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5914B714B4CB3B8C3835297CBB400@DM6PR02MB5914.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1tj0ryRUYZxPPvm/pKFBzokL5CN2SrnR0QH8iCtn99cEaxFWalWZszPnJSLpZjHbU4hcwtTZOWdHT8on5FsrsXLx/8jhmMij/qf+YtmsS6fSO2fQY560ZS2CPfY9Tl1T+abz+FS6PAxOSfde+VQBJeIHbDkUz+CVFxJcigYWv7nGW5mcz1jM3Nyqzu62hxE+EeGd7H8bxCrTYZGoTVuqRVKCNdhD3PNH/etgAiBDGVY/Zh0aIvpzVEYBw+Mkw0sxqSQT8osdOCcUxfQuGnryACXylwu9Blcrs1xB08VduDpB/sd4lRtEB82Phwn6kZXP4eNfr6f6VgOC7xtwEhKiCyCjPjW9MwRrWdtpItH9Wte0xIpY5Q9MrHHF27D/lCDgwjVUTKgPmF/jhx7k51IGyYkVo5lqV67dukL/3nEXTxk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 21:54:12.6826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c3dbab-ae2b-4a3f-fdd2-08d6acb56c91
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c  | 960 +++++++++++++++++++++++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h  | 147 ++++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c    |  30 +
 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c | 148 ++++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h   | 244 ++++++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c | 318 ++++++++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c | 399 ++++++++++
 7 files changed, 2246 insertions(+)
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c

diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c b/drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
new file mode 100644
index 000000000000..2eb0267fc2b2
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
@@ -0,0 +1,960 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Simple Driver for Management PF
+ *
+ * Copyright (C) 2017 Xilinx, Inc.
+ *
+ * Code borrowed from Xilinx SDAccel XDMA driver
+ *
+ * Author(s):
+ * Sonal Santan <sonal.santan@xilinx.com>
+ */
+#include "mgmt-core.h"
+#include <linux/ioctl.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/version.h>
+#include <linux/fs.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/crc32c.h>
+#include "../xocl_drv.h"
+#include "../version.h"
+
+//#define USE_FEATURE_ROM
+
+static const struct pci_device_id pci_ids[] = XOCL_MGMT_PCI_IDS;
+
+MODULE_DEVICE_TABLE(pci, pci_ids);
+
+int health_interval = 5;
+module_param(health_interval, int, (S_IRUGO|S_IWUSR));
+MODULE_PARM_DESC(health_interval,
+	"Interval (in sec) after which the health thread is run. (1 = Minimum, 5 = default)");
+
+int health_check = 1;
+module_param(health_check, int, (S_IRUGO|S_IWUSR));
+MODULE_PARM_DESC(health_check,
+	"Enable health thread that checks the status of AXI Firewall and SYSMON. (0 = disable, 1 = enable)");
+
+int minimum_initialization;
+module_param(minimum_initialization, int, (S_IRUGO|S_IWUSR));
+MODULE_PARM_DESC(minimum_initialization,
+	"Enable minimum_initialization to force driver to load without vailid firmware or DSA. Thus xbsak flash is able to upgrade firmware. (0 = normal initialization, 1 = minimum initialization)");
+
+#define	LOW_TEMP		0
+#define	HI_TEMP			85000
+#define	LOW_MILLVOLT		500
+#define	HI_MILLVOLT		2500
+
+
+static dev_t xclmgmt_devnode;
+struct class *xrt_class;
+
+/*
+ * Called when the device goes from unused to used.
+ */
+static int char_open(struct inode *inode, struct file *file)
+{
+	struct xclmgmt_dev *lro;
+
+	/* pointer to containing data structure of the character device inode */
+	lro = xocl_drvinst_open(inode->i_cdev);
+	if (!lro)
+		return -ENXIO;
+
+	/* create a reference to our char device in the opened file */
+	file->private_data = lro;
+	BUG_ON(!lro);
+
+	mgmt_info(lro, "opened file %p by pid: %d\n",
+		file, pid_nr(task_tgid(current)));
+
+	return 0;
+}
+
+/*
+ * Called when the device goes from used to unused.
+ */
+static int char_close(struct inode *inode, struct file *file)
+{
+	struct xclmgmt_dev *lro;
+
+	lro = (struct xclmgmt_dev *)file->private_data;
+	BUG_ON(!lro);
+
+	mgmt_info(lro, "Closing file %p by pid: %d\n",
+		file, pid_nr(task_tgid(current)));
+
+	xocl_drvinst_close(lro);
+
+	return 0;
+}
+
+/*
+ * Unmap the BAR regions that had been mapped earlier using map_bars()
+ */
+static void unmap_bars(struct xclmgmt_dev *lro)
+{
+	if (lro->core.bar_addr) {
+		/* unmap BAR */
+		pci_iounmap(lro->core.pdev, lro->core.bar_addr);
+		/* mark as unmapped */
+		lro->core.bar_addr = NULL;
+	}
+	if (lro->core.intr_bar_addr) {
+		/* unmap BAR */
+		pci_iounmap(lro->core.pdev, lro->core.intr_bar_addr);
+		/* mark as unmapped */
+		lro->core.intr_bar_addr = NULL;
+	}
+}
+
+static int identify_bar(struct xocl_dev_core *core, int bar)
+{
+	void *__iomem bar_addr;
+	resource_size_t bar_len;
+
+	bar_len = pci_resource_len(core->pdev, bar);
+	bar_addr = pci_iomap(core->pdev, bar, bar_len);
+	if (!bar_addr) {
+		xocl_err(&core->pdev->dev, "Could not map BAR #%d",
+				core->bar_idx);
+		return -EIO;
+	}
+
+	/*
+	 * did not find a better way to identify BARS. Currently,
+	 * we have DSAs which rely VBNV name to differenciate them.
+	 * And reading VBNV name needs to bring up Feature ROM.
+	 * So we are not able to specify BARs in devices.h
+	 */
+	if (bar_len < 1024 * 1024 && bar > 0) {
+		core->intr_bar_idx = bar;
+		core->intr_bar_addr = bar_addr;
+		core->intr_bar_size = bar_len;
+	} else if (bar_len < 256 * 1024 * 1024) {
+		core->bar_idx = bar;
+		core->bar_size = bar_len;
+		core->bar_addr = bar_addr;
+	}
+
+	return 0;
+}
+
+/* map_bars() -- map device regions into kernel virtual address space
+ *
+ * Map the device memory regions into kernel virtual address space after
+ * verifying their sizes respect the minimum sizes needed, given by the
+ * bar_map_sizes[] array.
+ */
+static int map_bars(struct xclmgmt_dev *lro)
+{
+	struct pci_dev *pdev = lro->core.pdev;
+	resource_size_t bar_len;
+	int	i, ret = 0;
+
+	for (i = PCI_STD_RESOURCES; i <= PCI_STD_RESOURCE_END; i++) {
+		bar_len = pci_resource_len(pdev, i);
+		if (bar_len > 0) {
+			ret = identify_bar(&lro->core, i);
+			if (ret)
+				goto failed;
+		}
+	}
+
+	/* succesfully mapped all required BAR regions */
+	return 0;
+
+failed:
+	unmap_bars(lro);
+	return ret;
+}
+
+void get_pcie_link_info(struct xclmgmt_dev *lro,
+	unsigned short *link_width, unsigned short *link_speed, bool is_cap)
+{
+	u16 stat;
+	long result;
+	int pos = is_cap ? PCI_EXP_LNKCAP : PCI_EXP_LNKSTA;
+
+	result = pcie_capability_read_word(lro->core.pdev, pos, &stat);
+	if (result) {
+		*link_width = *link_speed = 0;
+		mgmt_err(lro, "Read pcie capability failed");
+		return;
+	}
+	*link_width = (stat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
+	*link_speed = stat & PCI_EXP_LNKSTA_CLS;
+}
+
+void device_info(struct xclmgmt_dev *lro, struct xclmgmt_ioc_info *obj)
+{
+	u32 val, major, minor, patch;
+	struct FeatureRomHeader rom;
+
+	memset(obj, 0, sizeof(struct xclmgmt_ioc_info));
+	if (sscanf(XRT_DRIVER_VERSION, "%d.%d.%d", &major, &minor, &patch) != 3)
+		return;
+
+	obj->vendor = lro->core.pdev->vendor;
+	obj->device = lro->core.pdev->device;
+	obj->subsystem_vendor = lro->core.pdev->subsystem_vendor;
+	obj->subsystem_device = lro->core.pdev->subsystem_device;
+	obj->driver_version = XOCL_DRV_VER_NUM(major, minor, patch);
+	obj->pci_slot = PCI_SLOT(lro->core.pdev->devfn);
+
+	val = MGMT_READ_REG32(lro, GENERAL_STATUS_BASE);
+	mgmt_info(lro, "MIG Calibration: %d\n", val);
+
+	obj->mig_calibration[0] = (val & BIT(0)) ? true : false;
+	obj->mig_calibration[1] = obj->mig_calibration[0];
+	obj->mig_calibration[2] = obj->mig_calibration[0];
+	obj->mig_calibration[3] = obj->mig_calibration[0];
+
+	/*
+	 * Get feature rom info
+	 */
+	obj->ddr_channel_num = xocl_get_ddr_channel_count(lro);
+	obj->ddr_channel_size = xocl_get_ddr_channel_size(lro);
+	obj->time_stamp = xocl_get_timestamp(lro);
+	obj->isXPR = XOCL_DSA_XPR_ON(lro);
+	xocl_get_raw_header(lro, &rom);
+	memcpy(obj->vbnv, rom.VBNVName, 64);
+	memcpy(obj->fpga, rom.FPGAPartName, 64);
+
+	/* Get sysmon info */
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_TEMP, &val);
+	obj->onchip_temp = val / 1000;
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_VCC_INT, &val);
+	obj->vcc_int = val;
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_VCC_AUX, &val);
+	obj->vcc_aux = val;
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_VCC_BRAM, &val);
+	obj->vcc_bram = val;
+
+	fill_frequency_info(lro, obj);
+	get_pcie_link_info(lro, &obj->pcie_link_width, &obj->pcie_link_speed,
+		false);
+}
+
+/*
+ * Maps the PCIe BAR into user space for memory-like access using mmap().
+ * Callable even when lro->ready == false.
+ */
+static int bridge_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int rc;
+	struct xclmgmt_dev *lro;
+	unsigned long off;
+	unsigned long phys;
+	unsigned long vsize;
+	unsigned long psize;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	lro = (struct xclmgmt_dev *)file->private_data;
+	BUG_ON(!lro);
+
+	off = vma->vm_pgoff << PAGE_SHIFT;
+	/* BAR physical address */
+	phys = pci_resource_start(lro->core.pdev, lro->core.bar_idx) + off;
+	vsize = vma->vm_end - vma->vm_start;
+	/* complete resource */
+	psize = pci_resource_end(lro->core.pdev, lro->core.bar_idx) -
+		pci_resource_start(lro->core.pdev, lro->core.bar_idx) + 1 - off;
+
+	mgmt_info(lro, "mmap(): bar %d, phys:0x%lx, vsize:%ld, psize:%ld",
+		lro->core.bar_idx, phys, vsize, psize);
+
+	if (vsize > psize)
+		return -EINVAL;
+
+	/*
+	 * pages must not be cached as this would result in cache line sized
+	 * accesses to the end point
+	 */
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	/*
+	 * prevent touching the pages (byte access) for swap-in,
+	 * and prevent the pages from being swapped out
+	 */
+#ifndef VM_RESERVED
+	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
+#else
+	vma->vm_flags |= VM_IO | VM_RESERVED;
+#endif
+
+	/* make MMIO accessible to user space */
+	rc = io_remap_pfn_range(vma, vma->vm_start, phys >> PAGE_SHIFT,
+				vsize, vma->vm_page_prot);
+	if (rc)
+		return -EAGAIN;
+
+	return rc;
+}
+
+/*
+ * character device file operations for control bus (through control bridge)
+ */
+static const struct file_operations ctrl_fops = {
+	.owner = THIS_MODULE,
+	.open = char_open,
+	.release = char_close,
+	.mmap = bridge_mmap,
+	.unlocked_ioctl = mgmt_ioctl,
+};
+
+/*
+ * create_char() -- create a character device interface to data or control bus
+ *
+ * If at least one SG DMA engine is specified, the character device interface
+ * is coupled to the SG DMA file operations which operate on the data bus. If
+ * no engines are specified, the interface is coupled with the control bus.
+ */
+static int create_char(struct xclmgmt_dev *lro)
+{
+	struct xclmgmt_char *lro_char;
+	int rc;
+
+	lro_char = &lro->user_char_dev;
+
+	/* couple the control device file operations to the character device */
+	lro_char->cdev = cdev_alloc();
+	if (!lro_char->cdev)
+		return -ENOMEM;
+
+	lro_char->cdev->ops = &ctrl_fops;
+	lro_char->cdev->owner = THIS_MODULE;
+	lro_char->cdev->dev = MKDEV(MAJOR(xclmgmt_devnode), lro->core.dev_minor);
+	rc = cdev_add(lro_char->cdev, lro_char->cdev->dev, 1);
+	if (rc < 0) {
+		memset(lro_char, 0, sizeof(*lro_char));
+		mgmt_info(lro, "cdev_add() = %d\n", rc);
+		goto fail_add;
+	}
+
+	lro_char->sys_device = device_create(xrt_class,
+				&lro->core.pdev->dev,
+				lro_char->cdev->dev, NULL,
+				DRV_NAME "%d", lro->instance);
+
+	if (IS_ERR(lro_char->sys_device)) {
+		rc = PTR_ERR(lro_char->sys_device);
+		goto fail_device;
+	}
+
+	return 0;
+
+fail_device:
+	cdev_del(lro_char->cdev);
+fail_add:
+	return rc;
+}
+
+static int destroy_sg_char(struct xclmgmt_char *lro_char)
+{
+	BUG_ON(!lro_char);
+	BUG_ON(!xrt_class);
+
+	if (lro_char->sys_device)
+		device_destroy(xrt_class, lro_char->cdev->dev);
+	cdev_del(lro_char->cdev);
+
+	return 0;
+}
+
+struct pci_dev *find_user_node(const struct pci_dev *pdev)
+{
+	struct xclmgmt_dev *lro;
+	unsigned int slot = PCI_SLOT(pdev->devfn);
+	unsigned int func = PCI_FUNC(pdev->devfn);
+	struct pci_dev *user_dev;
+
+	lro = (struct xclmgmt_dev *)dev_get_drvdata(&pdev->dev);
+
+	/*
+	 * if we are function one then the zero
+	 * function has the user pf node
+	 */
+	if (func == 0) {
+		mgmt_err(lro, "failed get user pf, expect user pf is func 0");
+		return NULL;
+	}
+
+	user_dev = pci_get_slot(pdev->bus, PCI_DEVFN(slot, 0));
+	if (!user_dev) {
+		mgmt_err(lro, "did not find user dev");
+		return NULL;
+	}
+
+	return user_dev;
+}
+
+inline void check_temp_within_range(struct xclmgmt_dev *lro, u32 temp)
+{
+	if (temp < LOW_TEMP || temp > HI_TEMP) {
+		mgmt_err(lro, "Temperature outside normal range (%d-%d) %d.",
+			LOW_TEMP, HI_TEMP, temp);
+	}
+}
+
+inline void check_volt_within_range(struct xclmgmt_dev *lro, u16 volt)
+{
+	if (volt < LOW_MILLVOLT || volt > HI_MILLVOLT) {
+		mgmt_err(lro, "Voltage outside normal range (%d-%d)mV %d.",
+			LOW_MILLVOLT, HI_MILLVOLT, volt);
+	}
+}
+
+static void check_sysmon(struct xclmgmt_dev *lro)
+{
+	u32 val;
+
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_TEMP, &val);
+	check_temp_within_range(lro, val);
+
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_VCC_INT, &val);
+	check_volt_within_range(lro, val);
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_VCC_AUX, &val);
+	check_volt_within_range(lro, val);
+	xocl_sysmon_get_prop(lro, XOCL_SYSMON_PROP_VCC_BRAM, &val);
+	check_volt_within_range(lro, val);
+}
+
+static int health_check_cb(void *data)
+{
+	struct xclmgmt_dev *lro = (struct xclmgmt_dev *)data;
+	struct mailbox_req mbreq = { MAILBOX_REQ_FIREWALL, };
+	bool tripped;
+
+	if (!health_check)
+		return 0;
+
+	mutex_lock(&lro->busy_mutex);
+	tripped = xocl_af_check(lro, NULL);
+	mutex_unlock(&lro->busy_mutex);
+
+	if (!tripped) {
+		check_sysmon(lro);
+	} else {
+		mgmt_info(lro, "firewall tripped, notify peer");
+		(void) xocl_peer_notify(lro, &mbreq, sizeof(struct mailbox_req));
+	}
+
+	return 0;
+}
+
+static inline bool xclmgmt_support_intr(struct xclmgmt_dev *lro)
+{
+	return lro->core.intr_bar_addr != NULL;
+}
+
+static int xclmgmt_setup_msix(struct xclmgmt_dev *lro)
+{
+	int total, rv, i;
+
+	if (!xclmgmt_support_intr(lro))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Get start vector (index into msi-x table) of msi-x usr intr on this
+	 * device.
+	 *
+	 * The device has XCLMGMT_MAX_USER_INTR number of usr intrs, the last
+	 * half of them belongs to mgmt pf, and the first half to user pf. All
+	 * vectors are hard-wired.
+	 *
+	 * The device also has some number of DMA intrs whose vectors come
+	 * before usr ones.
+	 *
+	 * This means that mgmt pf needs to allocate msi-x table big enough to
+	 * cover its own usr vectors. So, only the last chunk of the table will
+	 * ever be used for mgmt pf.
+	 */
+	lro->msix_user_start_vector = XOCL_READ_REG32(lro->core.intr_bar_addr +
+		XCLMGMT_INTR_USER_VECTOR) & 0x0f;
+	total = lro->msix_user_start_vector + XCLMGMT_MAX_USER_INTR;
+
+	i = 0; // Suppress warning about unused variable
+	rv = pci_alloc_irq_vectors(lro->core.pdev, total, total, PCI_IRQ_MSIX);
+	if (rv == total)
+		rv = 0;
+	mgmt_info(lro, "setting up msix, total irqs: %d, rv=%d\n", total, rv);
+	return rv;
+}
+
+static void xclmgmt_teardown_msix(struct xclmgmt_dev *lro)
+{
+	if (xclmgmt_support_intr(lro))
+		pci_disable_msix(lro->core.pdev);
+}
+
+static int xclmgmt_intr_config(xdev_handle_t xdev_hdl, u32 intr, bool en)
+{
+	struct xclmgmt_dev *lro = (struct xclmgmt_dev *)xdev_hdl;
+
+	if (!xclmgmt_support_intr(lro))
+		return -EOPNOTSUPP;
+
+	XOCL_WRITE_REG32(1 << intr, lro->core.intr_bar_addr +
+		(en ? XCLMGMT_INTR_USER_ENABLE : XCLMGMT_INTR_USER_DISABLE));
+	return 0;
+}
+
+static int xclmgmt_intr_register(xdev_handle_t xdev_hdl, u32 intr,
+	irq_handler_t handler, void *arg)
+{
+	u32 vec;
+	struct xclmgmt_dev *lro = (struct xclmgmt_dev *)xdev_hdl;
+
+	if (!xclmgmt_support_intr(lro))
+		return -EOPNOTSUPP;
+
+	vec = pci_irq_vector(lro->core.pdev,
+		lro->msix_user_start_vector + intr);
+
+	if (handler)
+		return request_irq(vec, handler, 0, DRV_NAME, arg);
+
+	free_irq(vec, arg);
+	return 0;
+}
+
+static int xclmgmt_reset(xdev_handle_t xdev_hdl)
+{
+	struct xclmgmt_dev *lro = (struct xclmgmt_dev *)xdev_hdl;
+
+	return reset_hot_ioctl(lro);
+}
+
+struct xocl_pci_funcs xclmgmt_pci_ops = {
+	.intr_config = xclmgmt_intr_config,
+	.intr_register = xclmgmt_intr_register,
+	.reset = xclmgmt_reset,
+};
+
+static int xclmgmt_read_subdev_req(struct xclmgmt_dev *lro, char *data_ptr, void **resp, size_t *sz)
+{
+	uint64_t val = 0;
+	size_t resp_sz = 0;
+	void *ptr = NULL;
+	struct mailbox_subdev_peer *subdev_req = (struct mailbox_subdev_peer *)data_ptr;
+
+	switch (subdev_req->kind) {
+	case VOL_12V_PEX:
+		val = xocl_xmc_get_data(lro, subdev_req->kind);
+		resp_sz = sizeof(u32);
+		ptr = (void *)&val;
+		break;
+	case IDCODE:
+		val = xocl_icap_get_data(lro, subdev_req->kind);
+		resp_sz = sizeof(u32);
+		ptr = (void *)&val;
+		break;
+	case XCLBIN_UUID:
+		ptr = (void *)xocl_icap_get_data(lro, subdev_req->kind);
+		resp_sz = sizeof(uuid_t);
+		break;
+	default:
+		break;
+	}
+
+	if (!resp_sz)
+		return -EINVAL;
+
+	*resp = vmalloc(resp_sz);
+	if (*resp == NULL)
+		return -ENOMEM;
+
+	memcpy(*resp, ptr, resp_sz);
+	*sz = resp_sz;
+	return 0;
+}
+
+static void xclmgmt_mailbox_srv(void *arg, void *data, size_t len,
+	u64 msgid, int err)
+{
+	int ret = 0;
+	size_t sz = 0;
+	struct xclmgmt_dev *lro = (struct xclmgmt_dev *)arg;
+	struct mailbox_req *req = (struct mailbox_req *)data;
+	struct mailbox_req_bitstream_lock *bitstm_lock = NULL;
+	struct mailbox_bitstream_kaddr *mb_kaddr = NULL;
+	void *resp = NULL;
+
+	bitstm_lock =	(struct mailbox_req_bitstream_lock *)req->data;
+
+	if (err != 0)
+		return;
+
+	mgmt_info(lro, "%s received request (%d) from peer\n", __func__, req->req);
+
+	switch (req->req) {
+	case MAILBOX_REQ_LOCK_BITSTREAM:
+		ret = xocl_icap_lock_bitstream(lro, &bitstm_lock->uuid,
+			0);
+		(void) xocl_peer_response(lro, msgid, &ret, sizeof(ret));
+		break;
+	case MAILBOX_REQ_UNLOCK_BITSTREAM:
+		ret = xocl_icap_unlock_bitstream(lro, &bitstm_lock->uuid,
+			0);
+		break;
+	case MAILBOX_REQ_HOT_RESET:
+		ret = (int) reset_hot_ioctl(lro);
+		(void) xocl_peer_response(lro, msgid, &ret, sizeof(ret));
+		break;
+	case MAILBOX_REQ_LOAD_XCLBIN_KADDR:
+		mb_kaddr = (struct mailbox_bitstream_kaddr *)req->data;
+		ret = xocl_icap_download_axlf(lro, (void *)mb_kaddr->addr);
+		(void) xocl_peer_response(lro, msgid, &ret, sizeof(ret));
+		break;
+	case MAILBOX_REQ_LOAD_XCLBIN:
+		ret = xocl_icap_download_axlf(lro, req->data);
+		(void) xocl_peer_response(lro, msgid, &ret, sizeof(ret));
+		break;
+	case MAILBOX_REQ_RECLOCK:
+		ret = xocl_icap_ocl_update_clock_freq_topology(lro, (struct xclmgmt_ioc_freqscaling *)req->data);
+		(void) xocl_peer_response(lro, msgid, &ret, sizeof(ret));
+		break;
+	case MAILBOX_REQ_PEER_DATA:
+		ret = xclmgmt_read_subdev_req(lro, req->data, &resp, &sz);
+		if (ret) {
+			/* if can't get data, return 0 as response */
+			ret = 0;
+			(void) xocl_peer_response(lro, msgid, &ret, sizeof(ret));
+		} else
+			(void) xocl_peer_response(lro, msgid, resp, sz);
+		vfree(resp);
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * Called after minimum initialization is done. Should not return failure.
+ * If something goes wrong, it should clean up and return back to minimum
+ * initialization stage.
+ */
+static void xclmgmt_extended_probe(struct xclmgmt_dev *lro)
+{
+	int ret;
+	struct xocl_board_private *dev_info = &lro->core.priv;
+	struct pci_dev *pdev = lro->pci_dev;
+
+	/* We can only support MSI-X. */
+	ret = xclmgmt_setup_msix(lro);
+	if (ret && (ret != -EOPNOTSUPP)) {
+		xocl_err(&pdev->dev, "set up MSI-X failed\n");
+		goto fail;
+	}
+	lro->core.pci_ops = &xclmgmt_pci_ops;
+	lro->core.pdev = pdev;
+
+	/*
+	 * Workaround needed on some platforms. Will clear out any stale
+	 * data after the platform has been reset
+	 */
+	ret = xocl_subdev_create_one(lro,
+		&(struct xocl_subdev_info)XOCL_DEVINFO_AF);
+	if (ret) {
+		xocl_err(&pdev->dev, "failed to register firewall\n");
+		goto fail_firewall;
+	}
+	if (dev_info->flags & XOCL_DSAFLAG_AXILITE_FLUSH)
+		platform_axilite_flush(lro);
+
+	ret = xocl_subdev_create_all(lro, dev_info->subdev_info,
+		dev_info->subdev_num);
+	if (ret) {
+		xocl_err(&pdev->dev, "failed to register subdevs\n");
+		goto fail_all_subdev;
+	}
+	xocl_err(&pdev->dev, "created all sub devices");
+
+	ret = xocl_icap_download_boot_firmware(lro);
+	if (ret)
+		goto fail_all_subdev;
+
+	lro->core.thread_arg.health_cb = health_check_cb;
+	lro->core.thread_arg.arg = lro;
+	lro->core.thread_arg.interval = health_interval * 1000;
+
+	health_thread_start(lro);
+
+	/* Launch the mailbox server. */
+	(void) xocl_peer_listen(lro, xclmgmt_mailbox_srv, (void *)lro);
+
+	lro->ready = true;
+	xocl_err(&pdev->dev, "device fully initialized\n");
+	return;
+
+fail_all_subdev:
+	xocl_subdev_destroy_all(lro);
+fail_firewall:
+	xclmgmt_teardown_msix(lro);
+fail:
+	xocl_err(&pdev->dev, "failed to fully probe device, err: %d\n", ret);
+}
+
+/*
+ * Device initialization is done in two phases:
+ * 1. Minimum initialization - init to the point where open/close/mmap entry
+ * points are working, sysfs entries work without register access, ioctl entry
+ * point is completely disabled.
+ * 2. Full initialization - driver is ready for use.
+ * Once we pass minimum initialization point, probe function shall not fail.
+ */
+static int xclmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int rc = 0;
+	struct xclmgmt_dev *lro = NULL;
+	struct xocl_board_private *dev_info;
+
+	xocl_info(&pdev->dev, "Driver: %s", XRT_DRIVER_VERSION);
+	xocl_info(&pdev->dev, "probe(pdev = 0x%p, pci_id = 0x%p)\n", pdev, id);
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		xocl_err(&pdev->dev, "pci_enable_device() failed, rc = %d.\n",
+			rc);
+		return rc;
+	}
+
+	/* allocate zeroed device book keeping structure */
+	lro = xocl_drvinst_alloc(&pdev->dev, sizeof(struct xclmgmt_dev));
+	if (!lro) {
+		xocl_err(&pdev->dev, "Could not kzalloc(xclmgmt_dev).\n");
+		rc = -ENOMEM;
+		goto err_alloc;
+	}
+
+	/* create a device to driver reference */
+	dev_set_drvdata(&pdev->dev, lro);
+	/* create a driver to device reference */
+	lro->core.pdev = pdev;
+	lro->pci_dev = pdev;
+	lro->ready = false;
+
+	rc = pcie_get_readrq(pdev);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "failed to read mrrs %d\n", rc);
+		goto err_alloc;
+	}
+	if (rc > 512) {
+		rc = pcie_set_readrq(pdev, 512);
+		if (rc) {
+			dev_err(&pdev->dev, "failed to force mrrs %d\n", rc);
+			goto err_alloc;
+		}
+	}
+
+	rc = xocl_alloc_dev_minor(lro);
+	if (rc)
+		goto err_alloc_minor;
+
+	dev_info = (struct xocl_board_private *)id->driver_data;
+	xocl_fill_dsa_priv(lro, dev_info);
+
+	/* map BARs */
+	rc = map_bars(lro);
+	if (rc)
+		goto err_map;
+
+	lro->instance = XOCL_DEV_ID(pdev);
+	rc = create_char(lro);
+	if (rc) {
+		xocl_err(&pdev->dev, "create_char(user_char_dev) failed\n");
+		goto err_cdev;
+	}
+
+	xocl_drvinst_set_filedev(lro, lro->user_char_dev.cdev);
+
+	mutex_init(&lro->busy_mutex);
+
+	mgmt_init_sysfs(&pdev->dev);
+
+	/* Probe will not fail from now on. */
+	xocl_err(&pdev->dev, "minimum initialization done\n");
+
+	/* No further initialization for MFG board. */
+	if (minimum_initialization ||
+		(dev_info->flags & XOCL_DSAFLAG_MFG) != 0) {
+		return 0;
+	}
+
+	xclmgmt_extended_probe(lro);
+
+	return 0;
+
+err_cdev:
+	unmap_bars(lro);
+err_map:
+	xocl_free_dev_minor(lro);
+err_alloc_minor:
+	dev_set_drvdata(&pdev->dev, NULL);
+	xocl_drvinst_free(lro);
+err_alloc:
+	pci_disable_device(pdev);
+
+	return rc;
+}
+
+static void xclmgmt_remove(struct pci_dev *pdev)
+{
+	struct xclmgmt_dev *lro;
+
+	if ((pdev == 0) || (dev_get_drvdata(&pdev->dev) == 0))
+		return;
+
+	lro = (struct xclmgmt_dev *)dev_get_drvdata(&pdev->dev);
+	mgmt_info(lro, "remove(0x%p) where pdev->dev.driver_data = 0x%p",
+	       pdev, lro);
+	BUG_ON(lro->core.pdev != pdev);
+
+	health_thread_stop(lro);
+
+	mgmt_fini_sysfs(&pdev->dev);
+
+	xocl_subdev_destroy_all(lro);
+
+	xclmgmt_teardown_msix(lro);
+	/* remove user character device */
+	destroy_sg_char(&lro->user_char_dev);
+
+	/* unmap the BARs */
+	unmap_bars(lro);
+	pci_disable_device(pdev);
+
+	xocl_free_dev_minor(lro);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	xocl_drvinst_free(lro);
+}
+
+static pci_ers_result_t mgmt_pci_error_detected(struct pci_dev *pdev,
+	pci_channel_state_t state)
+{
+	switch (state) {
+	case pci_channel_io_normal:
+		xocl_info(&pdev->dev, "PCI normal state error\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		xocl_info(&pdev->dev, "PCI frozen state error\n");
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		xocl_info(&pdev->dev, "PCI failure state error\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	default:
+		xocl_info(&pdev->dev, "PCI unknown state %d error\n", state);
+		break;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static const struct pci_error_handlers xclmgmt_err_handler = {
+	.error_detected = mgmt_pci_error_detected,
+};
+
+static struct pci_driver xclmgmt_driver = {
+	.name = DRV_NAME,
+	.id_table = pci_ids,
+	.probe = xclmgmt_probe,
+	.remove = xclmgmt_remove,
+	/* resume, suspend are optional */
+	.err_handler = &xclmgmt_err_handler,
+};
+
+static int (*drv_reg_funcs[])(void) __initdata = {
+	xocl_init_feature_rom,
+	xocl_init_sysmon,
+	xocl_init_mb,
+	xocl_init_xvc,
+	xocl_init_mailbox,
+	xocl_init_firewall,
+	xocl_init_icap,
+	xocl_init_mig,
+	xocl_init_xmc,
+	xocl_init_dna,
+	xocl_init_fmgr,
+};
+
+static void (*drv_unreg_funcs[])(void) = {
+	xocl_fini_feature_rom,
+	xocl_fini_sysmon,
+	xocl_fini_mb,
+	xocl_fini_xvc,
+	xocl_fini_mailbox,
+	xocl_fini_firewall,
+	xocl_fini_icap,
+	xocl_fini_mig,
+	xocl_fini_xmc,
+	xocl_fini_dna,
+	xocl_fini_fmgr,
+};
+
+static int __init xclmgmt_init(void)
+{
+	int res, i;
+
+	pr_info(DRV_NAME " init()\n");
+	xrt_class = class_create(THIS_MODULE, "xrt_mgmt");
+	if (IS_ERR(xrt_class))
+		return PTR_ERR(xrt_class);
+
+	res = alloc_chrdev_region(&xclmgmt_devnode, 0,
+				  XOCL_MAX_DEVICES, DRV_NAME);
+	if (res)
+		goto alloc_err;
+
+	/* Need to init sub device driver before pci driver register */
+	for (i = 0; i < ARRAY_SIZE(drv_reg_funcs); ++i) {
+		res = drv_reg_funcs[i]();
+		if (res)
+			goto drv_init_err;
+	}
+
+	res = pci_register_driver(&xclmgmt_driver);
+	if (res)
+		goto reg_err;
+
+	return 0;
+
+drv_init_err:
+reg_err:
+	for (i--; i >= 0; i--)
+		drv_unreg_funcs[i]();
+
+	unregister_chrdev_region(xclmgmt_devnode, XOCL_MAX_DEVICES);
+alloc_err:
+	pr_info(DRV_NAME " init() err\n");
+	class_destroy(xrt_class);
+	return res;
+}
+
+static void xclmgmt_exit(void)
+{
+	int i;
+
+	pr_info(DRV_NAME" exit()\n");
+	pci_unregister_driver(&xclmgmt_driver);
+
+	for (i = ARRAY_SIZE(drv_unreg_funcs) - 1; i >= 0; i--)
+		drv_unreg_funcs[i]();
+
+	/* unregister this driver from the PCI bus driver */
+	unregister_chrdev_region(xclmgmt_devnode, XOCL_MAX_DEVICES);
+	class_destroy(xrt_class);
+}
+
+module_init(xclmgmt_init);
+module_exit(xclmgmt_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Lizhi Hou <lizhi.hou@xilinx.com>");
+MODULE_VERSION(XRT_DRIVER_VERSION);
+MODULE_DESCRIPTION("Xilinx SDx management function driver");
diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h b/drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
new file mode 100644
index 000000000000..14ef10e21e00
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/**
+ * Copyright (C) 2017-2019 Xilinx, Inc.
+ *
+ * Author(s):
+ * Sonal Santan <sonal.santan@xilinx.com>
+ */
+
+#ifndef _XCL_MGT_PF_H_
+#define _XCL_MGT_PF_H_
+
+#include <linux/cdev.h>
+#include <linux/list.h>
+#include <linux/signal.h>
+#include <linux/init_task.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <drm/xmgmt_drm.h>
+#include "mgmt-reg.h"
+#include "../xclfeatures.h"
+#include "../xocl_drv.h"
+
+#define DRV_NAME "xmgmt"
+
+#define	MGMT_READ_REG32(lro, off)	\
+	ioread32(lro->core.bar_addr + off)
+#define	MGMT_WRITE_REG32(lro, off, val)	\
+	iowrite32(val, lro->core.bar_addr + off)
+#define	MGMT_WRITE_REG8(lro, off, val)	\
+	iowrite8(val, lro->core.bar_addr + off)
+
+#define	mgmt_err(lro, fmt, args...)	\
+	dev_err(&lro->core.pdev->dev, "%s: "fmt, __func__, ##args)
+#define	mgmt_info(lro, fmt, args...)	\
+	dev_info(&lro->core.pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define	MGMT_PROC_TABLE_HASH_SZ		256
+
+struct xclmgmt_ioc_info;
+
+// List of processes that are using the mgmt driver
+// also saving the task
+struct proc_list {
+	struct list_head head;
+	struct pid      *pid;
+	bool		 signaled;
+};
+
+struct power_val {
+	s32 max;
+	s32 avg;
+	s32 curr;
+};
+
+struct mgmt_power {
+	struct power_val vccint;
+	struct power_val vcc1v8;
+	struct power_val vcc1v2;
+	struct power_val vccbram;
+	struct power_val mgtavcc;
+	struct power_val mgtavtt;
+};
+
+struct xclmgmt_proc_ctx {
+	struct xclmgmt_dev	*lro;
+	struct pid		*pid;
+	bool			signaled;
+};
+
+struct xclmgmt_char {
+	struct xclmgmt_dev *lro;
+	struct cdev *cdev;
+	struct device *sys_device;
+};
+
+struct xclmgmt_data_buf {
+	enum mb_cmd_type cmd_type;
+	uint64_t priv_data;
+	char *data_buf;
+};
+
+struct xclmgmt_dev {
+	struct xocl_dev_core	core;
+	/* MAGIC_DEVICE == 0xAAAAAAAA */
+	unsigned long magic;
+
+	/* the kernel pci device data structure provided by probe() */
+	struct pci_dev *pci_dev;
+	int instance;
+	struct xclmgmt_char user_char_dev;
+	int axi_gate_frozen;
+	unsigned short ocl_frequency[4];
+
+	struct mutex busy_mutex;
+	struct mgmt_power power;
+
+	int msix_user_start_vector;
+	bool ready;
+
+};
+
+extern int health_check;
+
+int ocl_freqscaling_ioctl(struct xclmgmt_dev *lro, const void __user *arg);
+void platform_axilite_flush(struct xclmgmt_dev *lro);
+u16 get_dsa_version(struct xclmgmt_dev *lro);
+void fill_frequency_info(struct xclmgmt_dev *lro, struct xclmgmt_ioc_info *obj);
+void device_info(struct xclmgmt_dev *lro, struct xclmgmt_ioc_info *obj);
+long mgmt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+void get_pcie_link_info(struct xclmgmt_dev *lro,
+			unsigned short *width, unsigned short *speed, bool is_cap);
+
+// utils.c
+unsigned int compute_unit_busy(struct xclmgmt_dev *lro);
+int pci_fundamental_reset(struct xclmgmt_dev *lro);
+
+long reset_hot_ioctl(struct xclmgmt_dev *lro);
+void xdma_reset(struct pci_dev *pdev, bool prepare);
+void xclmgmt_reset_pci(struct xclmgmt_dev *lro);
+
+// firewall.c
+void init_firewall(struct xclmgmt_dev *lro);
+void xclmgmt_killall_processes(struct xclmgmt_dev *lro);
+void xclmgmt_list_add(struct xclmgmt_dev *lro, struct pid *new_pid);
+void xclmgmt_list_remove(struct xclmgmt_dev *lro, struct pid *remove_pid);
+void xclmgmt_list_del(struct xclmgmt_dev *lro);
+bool xclmgmt_check_proc(struct xclmgmt_dev *lro, struct pid *pid);
+
+// mgmt-xvc.c
+long xvc_ioctl(struct xclmgmt_dev *lro, const void __user *arg);
+
+//mgmt-sysfs.c
+int mgmt_init_sysfs(struct device *dev);
+void mgmt_fini_sysfs(struct device *dev);
+
+//mgmt-mb.c
+int mgmt_init_mb(struct xclmgmt_dev *lro);
+void mgmt_fini_mb(struct xclmgmt_dev *lro);
+int mgmt_start_mb(struct xclmgmt_dev *lro);
+int mgmt_stop_mb(struct xclmgmt_dev *lro);
+
+#endif
diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c b/drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
new file mode 100644
index 000000000000..5e60db260b37
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/**
+ *  Copyright (C) 2017-2019 Xilinx, Inc. All rights reserved.
+ *
+ *  Code borrowed from Xilinx SDAccel XDMA driver
+ *  Author: Umang Parekh
+ *
+ */
+
+#include "mgmt-core.h"
+
+int ocl_freqscaling_ioctl(struct xclmgmt_dev *lro, const void __user *arg)
+{
+	struct xclmgmt_ioc_freqscaling freq_obj;
+
+	mgmt_info(lro, "%s  called", __func__);
+
+	if (copy_from_user((void *)&freq_obj, arg,
+		sizeof(struct xclmgmt_ioc_freqscaling)))
+		return -EFAULT;
+
+	return xocl_icap_ocl_update_clock_freq_topology(lro, &freq_obj);
+}
+
+void fill_frequency_info(struct xclmgmt_dev *lro, struct xclmgmt_ioc_info *obj)
+{
+	(void) xocl_icap_ocl_get_freq(lro, 0, obj->ocl_frequency,
+		ARRAY_SIZE(obj->ocl_frequency));
+}
diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c b/drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
new file mode 100644
index 000000000000..bd53b6997d2a
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/**
+ *  Copyright (C) 2017 Xilinx, Inc. All rights reserved.
+ *  Author: Sonal Santan
+ *  Code copied verbatim from SDAccel xcldma kernel mode driver
+ */
+
+#include "mgmt-core.h"
+
+static int err_info_ioctl(struct xclmgmt_dev *lro, void __user *arg)
+{
+	struct xclmgmt_err_info obj;
+	u32	val, level;
+	u64	t;
+	int	i;
+
+	mgmt_info(lro, "Enter error_info IOCTL");
+
+	xocl_af_get_prop(lro, XOCL_AF_PROP_TOTAL_LEVEL, &val);
+	if (val > ARRAY_SIZE(obj.mAXIErrorStatus)) {
+		mgmt_err(lro, "Too many levels %d", val);
+		return -EINVAL;
+	}
+
+	obj.mNumFirewalls = val;
+	memset(obj.mAXIErrorStatus, 0, sizeof(obj.mAXIErrorStatus));
+	for (i = 0; i < obj.mNumFirewalls; ++i)
+		obj.mAXIErrorStatus[i].mErrFirewallID = i;
+
+	xocl_af_get_prop(lro, XOCL_AF_PROP_DETECTED_LEVEL, &level);
+	if (level >= val) {
+		mgmt_err(lro, "Invalid detected level %d", level);
+		return -EINVAL;
+	}
+	obj.mAXIErrorStatus[level].mErrFirewallID = level;
+
+	xocl_af_get_prop(lro, XOCL_AF_PROP_DETECTED_STATUS, &val);
+	obj.mAXIErrorStatus[level].mErrFirewallStatus = val;
+
+	xocl_af_get_prop(lro, XOCL_AF_PROP_DETECTED_TIME, &t);
+	obj.mAXIErrorStatus[level].mErrFirewallTime = t;
+
+	if (copy_to_user(arg, &obj, sizeof(struct xclErrorStatus)))
+		return -EFAULT;
+	return 0;
+}
+
+static int version_ioctl(struct xclmgmt_dev *lro, void __user *arg)
+{
+	struct xclmgmt_ioc_info obj;
+
+	mgmt_info(lro, "%s: %s\n", DRV_NAME, __func__);
+	device_info(lro, &obj);
+	if (copy_to_user(arg, &obj, sizeof(struct xclmgmt_ioc_info)))
+		return -EFAULT;
+	return 0;
+}
+
+static long reset_ocl_ioctl(struct xclmgmt_dev *lro)
+{
+	xocl_icap_reset_axi_gate(lro);
+	return compute_unit_busy(lro) ? -EBUSY : 0;
+}
+
+static int bitstream_ioctl_axlf(struct xclmgmt_dev *lro, const void __user *arg)
+{
+	void *copy_buffer = NULL;
+	size_t copy_buffer_size = 0;
+	struct xclmgmt_ioc_bitstream_axlf ioc_obj = { 0 };
+	struct axlf xclbin_obj = { 0 };
+	int ret = 0;
+
+	if (copy_from_user((void *)&ioc_obj, arg, sizeof(ioc_obj)))
+		return -EFAULT;
+	if (copy_from_user((void *)&xclbin_obj, ioc_obj.xclbin,
+		sizeof(xclbin_obj)))
+		return -EFAULT;
+
+	copy_buffer_size = xclbin_obj.m_header.m_length;
+	copy_buffer = vmalloc(copy_buffer_size);
+	if (copy_buffer == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user((void *)copy_buffer, ioc_obj.xclbin,
+		copy_buffer_size))
+		ret = -EFAULT;
+	else
+		ret = xocl_icap_download_axlf(lro, copy_buffer);
+
+	vfree(copy_buffer);
+	return ret;
+}
+
+long mgmt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct xclmgmt_dev *lro = (struct xclmgmt_dev *)filp->private_data;
+	long result = 0;
+
+	BUG_ON(!lro);
+
+	if (!lro->ready || _IOC_TYPE(cmd) != XCLMGMT_IOC_MAGIC)
+		return -ENOTTY;
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		result = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		result =  !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+
+	if (result)
+		return -EFAULT;
+
+	mutex_lock(&lro->busy_mutex);
+
+	switch (cmd) {
+	case XCLMGMT_IOCINFO:
+		result = version_ioctl(lro, (void __user *)arg);
+		break;
+	case XCLMGMT_IOCICAPDOWNLOAD:
+		mgmt_err(lro, "Bitstream ioctl with legacy bitstream not supported");
+		result = -EINVAL;
+		break;
+	case XCLMGMT_IOCICAPDOWNLOAD_AXLF:
+		result = bitstream_ioctl_axlf(lro, (void __user *)arg);
+		break;
+	case XCLMGMT_IOCOCLRESET:
+		result = reset_ocl_ioctl(lro);
+		break;
+	case XCLMGMT_IOCHOTRESET:
+		result = reset_hot_ioctl(lro);
+		break;
+	case XCLMGMT_IOCFREQSCALE:
+		result = ocl_freqscaling_ioctl(lro, (void __user *)arg);
+		break;
+	case XCLMGMT_IOCREBOOT:
+		result = capable(CAP_SYS_ADMIN) ? pci_fundamental_reset(lro) : -EACCES;
+		break;
+	case XCLMGMT_IOCERRINFO:
+		result = err_info_ioctl(lro, (void __user *)arg);
+		break;
+	default:
+		mgmt_info(lro, "MGMT default IOCTL request %u\n", cmd & 0xff);
+		result = -ENOTTY;
+	}
+
+	mutex_unlock(&lro->busy_mutex);
+	return result;
+}
diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h b/drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
new file mode 100644
index 000000000000..cff012c98673
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
@@ -0,0 +1,244 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+/**
+ * Copyright (C) 2016-2019 Xilinx, Inc
+ */
+
+#ifndef _XCL_MGT_REG_H_
+#define _XCL_MGT_REG_H_
+
+
+#define KB(x)   ((unsigned int) (x) << 10)
+#define MB(x)   ((unsigned int) (x) << 20)
+
+enum PFO_BARS {
+	USER_BAR = 0,
+	DMA_BAR,
+	MAX_BAR
+};
+
+/**
+ * Peripherals on AXI-Lite mapped to PCIe BAR
+ */
+
+#define XILINX_VENDOR_ID	0x10EE
+#define OCL_CU_CTRL_RANGE	KB(4)
+
+#define DDR_BUFFER_ALIGNMENT	0x40
+#define MMAP_SIZE_USER		MB(32)
+
+//parameters for HWICAP, Flash and APM on PCIe BAR
+#define HWICAP_OFFSET		0x020000
+#define AXI_GATE_OFFSET		0x030000
+#define AXI_GATE_OFFSET_READ	0x030008
+#define BPI_FLASH_OFFSET	0x040000
+
+//Base addresses for LAPC
+#define LAPC0_BASE	      0x00120000  //ocl master00
+#define LAPC1_BASE	      0x00121000  //ocl master01
+#define LAPC2_BASE	      0x00122000  //ocl master02
+#define LAPC3_BASE	      0x00123000  //ocl master03
+
+//Following status registers are available at each base
+#define LAPC_OVERALL_STATUS_OFFSET	  0x0
+#define LAPC_CUMULATIVE_STATUS_0_OFFSET	  0x100
+#define LAPC_CUMULATIVE_STATUS_1_OFFSET	  0x104
+#define LAPC_CUMULATIVE_STATUS_2_OFFSET	  0x108
+#define LAPC_CUMULATIVE_STATUS_3_OFFSET	  0x10c
+
+#define LAPC_SNAPSHOT_STATUS_0_OFFSET	  0x200
+#define LAPC_SNAPSHOT_STATUS_1_OFFSET	  0x204
+#define LAPC_SNAPSHOT_STATUS_2_OFFSET	  0x208
+#define LAPC_SNAPSHOT_STATUS_3_OFFSET	  0x20c
+
+// NOTE: monitor address offset now defined by PERFMON0_BASE
+#define PERFMON0_OFFSET		0x0
+#define PERFMON1_OFFSET		0x020000
+#define PERFMON2_OFFSET		0x010000
+
+#define PERFMON_START_OFFSET	0x2000
+#define PERFMON_RANGE			0x1000
+
+#define FEATURE_ROM_BASE	   0x0B0000
+#define OCL_CTLR_BASE		   0x000000
+#define HWICAP_BASE		   0x020000
+#define AXI_GATE_BASE		   0x030000
+#define AXI_GATE_BASE_RD_BASE	   0x030008
+#define FEATURE_ID_BASE		   0x031000
+#define GENERAL_STATUS_BASE	   0x032000
+#define AXI_I2C_BASE		   0x041000
+#define PERFMON0_BASE		   0x100000
+#define PERFMON0_BASE2		   0x1800000
+#define OCL_CLKWIZ0_BASE	   0x050000
+#define OCL_CLKWIZ1_BASE	   0x051000
+/* Only needed for workaround for 5.0 platforms */
+#define GPIO_NULL_BASE		   0x1FFF000
+
+
+#define OCL_CLKWIZ_STATUS_OFFSET      0x4
+#define OCL_CLKWIZ_CONFIG_OFFSET(n)   (0x200 + 4 * (n))
+
+/**
+ * AXI Firewall Register definition
+ */
+#define FIREWALL_MGMT_CONTROL_BASE	0xD0000
+#define FIREWALL_USER_CONTROL_BASE	0xE0000
+#define FIREWALL_DATAPATH_BASE		0xF0000
+
+#define AF_MI_FAULT_STATUS_OFFSET	       0x0	//MI Fault Status Register
+#define AF_MI_SOFT_CTRL_OFFSET		       0x4	//MI Soft Fault Control Register
+#define AF_UNBLOCK_CTRL_OFFSET		       0x8	//MI Unblock Control Register
+
+// Currently un-used regs from the Firewall IP.
+#define AF_MAX_CONTINUOUS_RTRANSFERS_WAITS     0x30	//MAX_CONTINUOUS_RTRANSFERS_WAITS
+#define AF_MAX_WRITE_TO_BVALID_WAITS	       0x34	//MAX_WRITE_TO_BVALID_WAITS
+#define AF_MAX_ARREADY_WAITS		       0x38	//MAX_ARREADY_WAITS
+#define AF_MAX_AWREADY_WAITS		       0x3c	//MAX_AWREADY_WAITS
+#define AF_MAX_WREADY_WAITS		       0x40	//MAX_WREADY_WAITS
+
+/**
+ * DDR Zero IP Register definition
+ */
+//#define ENABLE_DDR_ZERO_IP
+#define DDR_ZERO_BASE			0x0B0000
+#define DDR_ZERO_CONFIG_REG_OFFSET	0x10
+#define DDR_ZERO_CTRL_REG_OFFSET	0x0
+
+
+/**
+ * SYSMON Register definition
+ */
+#define SYSMON_BASE		0x0A0000
+#define SYSMON_TEMP		0x400		// TEMPOERATURE REGISTER ADDRESS
+#define SYSMON_VCCINT		0x404		// VCCINT REGISTER OFFSET
+#define SYSMON_VCCAUX		0x408		// VCCAUX REGISTER OFFSET
+#define SYSMON_VCCBRAM		0x418		// VCCBRAM REGISTER OFFSET
+#define	SYSMON_TEMP_MAX		0x480
+#define	SYSMON_VCCINT_MAX	0x484
+#define	SYSMON_VCCAUX_MAX	0x488
+#define	SYSMON_VCCBRAM_MAX	0x48c
+#define	SYSMON_TEMP_MIN		0x490
+#define	SYSMON_VCCINT_MIN	0x494
+#define	SYSMON_VCCAUX_MIN	0x498
+#define	SYSMON_VCCBRAM_MIN	0x49c
+
+#define	SYSMON_TO_MILLDEGREE(val)		\
+	(((int64_t)(val) * 501374 >> 16) - 273678)
+#define	SYSMON_TO_MILLVOLT(val)			\
+	((val) * 1000 * 3 >> 16)
+
+
+/**
+ * ICAP Register definition
+ */
+
+#define XHWICAP_GIER		(HWICAP_BASE+0x1c)
+#define XHWICAP_ISR		(HWICAP_BASE+0x20)
+#define XHWICAP_IER		(HWICAP_BASE+0x28)
+#define XHWICAP_WF		(HWICAP_BASE+0x100)
+#define XHWICAP_RF		(HWICAP_BASE+0x104)
+#define XHWICAP_SZ		(HWICAP_BASE+0x108)
+#define XHWICAP_CR		(HWICAP_BASE+0x10c)
+#define XHWICAP_SR		(HWICAP_BASE+0x110)
+#define XHWICAP_WFV		(HWICAP_BASE+0x114)
+#define XHWICAP_RFO		(HWICAP_BASE+0x118)
+#define XHWICAP_ASR		(HWICAP_BASE+0x11c)
+
+/* Used for parsing bitstream header */
+#define XHI_EVEN_MAGIC_BYTE	0x0f
+#define XHI_ODD_MAGIC_BYTE	0xf0
+
+/* Extra mode for IDLE */
+#define XHI_OP_IDLE  -1
+
+#define XHI_BIT_HEADER_FAILURE -1
+
+/* The imaginary module length register */
+#define XHI_MLR			 15
+
+#define DMA_HWICAP_BITFILE_BUFFER_SIZE 1024
+
+/*
+ * Flash programming constants
+ * XAPP 518
+ * http://www.xilinx.com/support/documentation/application_notes/xapp518-isp-bpi-prom-virtex-6-pcie.pdf
+ * Table 1
+ */
+
+#define START_ADDR_HI_CMD   0x53420000
+#define START_ADDR_CMD	    0x53410000
+#define END_ADDR_CMD	    0x45000000
+#define END_ADDR_HI_CMD	    0x45420000
+#define UNLOCK_CMD	    0x556E6C6B
+#define ERASE_CMD	    0x45726173
+#define PROGRAM_CMD	    0x50726F67
+#define VERSION_CMD	    0x55726F73
+
+#define READY_STAT	    0x00008000
+#define ERASE_STAT	    0x00000000
+#define PROGRAM_STAT	    0x00000080
+
+/*
+ * Booting FPGA from PROM
+ * http://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
+ * Table 7.1
+ */
+
+#define DUMMY_WORD	   0xFFFFFFFF
+#define SYNC_WORD	   0xAA995566
+#define TYPE1_NOOP	   0x20000000
+#define TYPE1_WRITE_WBSTAR 0x30020001
+#define WBSTAR_ADD10	   0x00000000
+#define WBSTAR_ADD11	   0x01000000
+#define TYPE1_WRITE_CMD	   0x30008001
+#define IPROG_CMD	   0x0000000F
+
+/*
+ * MicroBlaze definition
+ */
+
+#define	MB_REG_BASE		0x120000
+#define	MB_GPIO			0x131000
+#define	MB_IMAGE_MGMT		0x140000
+#define	MB_IMAGE_SCHE		0x160000
+
+#define	MB_REG_VERSION		(MB_REG_BASE)
+#define	MB_REG_ID		(MB_REG_BASE + 0x4)
+#define	MB_REG_STATUS		(MB_REG_BASE + 0x8)
+#define	MB_REG_ERR		(MB_REG_BASE + 0xC)
+#define	MB_REG_CAP		(MB_REG_BASE + 0x10)
+#define	MB_REG_CTL		(MB_REG_BASE + 0x18)
+#define	MB_REG_STOP_CONFIRM	(MB_REG_BASE + 0x1C)
+#define	MB_REG_CURR_BASE	(MB_REG_BASE + 0x20)
+#define	MB_REG_POW_CHK		(MB_REG_BASE + 0x1A4)
+
+#define	MB_CTL_MASK_STOP		0x8
+#define	MB_CTL_MASK_PAUSE		0x4
+#define	MB_CTL_MASK_CLEAR_ERR		0x2
+#define MB_CTL_MASK_CLEAR_POW		0x1
+
+#define	MB_STATUS_MASK_INIT_DONE	0x1
+#define	MB_STATUS_MASK_STOPPED		0x2
+#define	MB_STATUS_MASK_PAUSED		0x4
+
+#define	MB_CAP_MASK_PM			0x1
+
+#define	MB_VALID_ID			0x74736574
+
+#define	MB_GPIO_RESET			0x0
+#define	MB_GPIO_ENABLED			0x1
+
+#define	MB_SELF_JUMP(ins)		(((ins) & 0xfc00ffff) == 0xb8000000)
+
+/*
+ * Interrupt controls
+ */
+#define XCLMGMT_MAX_INTR_NUM		32
+#define XCLMGMT_MAX_USER_INTR		16
+#define XCLMGMT_INTR_CTRL_BASE		(0x2000UL)
+#define XCLMGMT_INTR_USER_ENABLE	(XCLMGMT_INTR_CTRL_BASE + 0x08)
+#define XCLMGMT_INTR_USER_DISABLE	(XCLMGMT_INTR_CTRL_BASE + 0x0C)
+#define XCLMGMT_INTR_USER_VECTOR	(XCLMGMT_INTR_CTRL_BASE + 0x80)
+#define XCLMGMT_MAILBOX_INTR		11
+
+#endif
diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c b/drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
new file mode 100644
index 000000000000..40d7c855ab14
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * sysfs for the device attributes.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *    Lizhi Hou <lizhih@xilinx.com>
+ *    Umang Parekh <umang.parekh@xilinx.com>
+ *
+ */
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#include "mgmt-core.h"
+#include "../version.h"
+
+static ssize_t instance_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", lro->instance);
+}
+static DEVICE_ATTR_RO(instance);
+
+static ssize_t error_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+	ssize_t count = sprintf(buf, "%s\n", lro->core.ebuf);
+
+	lro->core.ebuf[0] = 0;
+	return count;
+}
+static DEVICE_ATTR_RO(error);
+
+static ssize_t userbar_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", lro->core.bar_idx);
+}
+static DEVICE_ATTR_RO(userbar);
+
+static ssize_t flash_type_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n",
+		lro->core.priv.flash_type ? lro->core.priv.flash_type : "");
+}
+static DEVICE_ATTR_RO(flash_type);
+
+static ssize_t board_name_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n",
+		lro->core.priv.board_name ? lro->core.priv.board_name : "");
+}
+static DEVICE_ATTR_RO(board_name);
+
+static ssize_t mfg_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", (lro->core.priv.flags & XOCL_DSAFLAG_MFG) != 0);
+}
+static DEVICE_ATTR_RO(mfg);
+
+static ssize_t feature_rom_offset_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%llu\n", lro->core.feature_rom_offset);
+}
+static DEVICE_ATTR_RO(feature_rom_offset);
+
+static ssize_t mgmt_pf_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	// The existence of entry indicates mgmt function.
+	return sprintf(buf, "%s", "");
+}
+static DEVICE_ATTR_RO(mgmt_pf);
+
+static ssize_t version_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	u32 major, minor, patch;
+
+	if (sscanf(XRT_DRIVER_VERSION, "%d.%d.%d", &major, &minor, &patch) != 3)
+		return 0;
+	return sprintf(buf, "%d\n", XOCL_DRV_VER_NUM(major, minor, patch));
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t slot_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", PCI_SLOT(lro->core.pdev->devfn));
+}
+static DEVICE_ATTR_RO(slot);
+
+static ssize_t link_speed_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	get_pcie_link_info(lro, &width, &speed, false);
+	return sprintf(buf, "%d\n", speed);
+}
+static DEVICE_ATTR_RO(link_speed);
+
+static ssize_t link_width_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	get_pcie_link_info(lro, &width, &speed, false);
+	return sprintf(buf, "%d\n", width);
+}
+static DEVICE_ATTR_RO(link_width);
+
+static ssize_t link_speed_max_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	get_pcie_link_info(lro, &width, &speed, true);
+	return sprintf(buf, "%d\n", speed);
+}
+static DEVICE_ATTR_RO(link_speed_max);
+
+static ssize_t link_width_max_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	get_pcie_link_info(lro, &width, &speed, true);
+	return sprintf(buf, "%d\n", width);
+}
+static DEVICE_ATTR_RO(link_width_max);
+
+static ssize_t mig_calibration_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n",
+		lro->ready ? MGMT_READ_REG32(lro, GENERAL_STATUS_BASE) : 0);
+}
+static DEVICE_ATTR_RO(mig_calibration);
+
+static ssize_t xpr_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", XOCL_DSA_XPR_ON(lro));
+}
+static DEVICE_ATTR_RO(xpr);
+
+static ssize_t ready_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", lro->ready);
+}
+static DEVICE_ATTR_RO(ready);
+
+static ssize_t dev_offline_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+	int val = lro->core.offline ? 1 : 0;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t dev_offline_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+	int ret;
+	u32 offline;
+
+	if (kstrtou32(buf, 10, &offline) == -EINVAL || offline > 1)
+		return -EINVAL;
+
+	device_lock(dev);
+	if (offline) {
+		ret = health_thread_stop(lro);
+		if (ret) {
+			xocl_err(dev, "stop health thread failed");
+			return -EIO;
+		}
+		xocl_subdev_destroy_all(lro);
+		lro->core.offline = true;
+	} else {
+		ret = xocl_subdev_create_all(lro, lro->core.priv.subdev_info,
+			lro->core.priv.subdev_num);
+		if (ret) {
+			xocl_err(dev, "Online subdevices failed");
+			return -EIO;
+		}
+		ret = health_thread_start(lro);
+		if (ret) {
+			xocl_err(dev, "start health thread failed");
+			return -EIO;
+		}
+		lro->core.offline = false;
+	}
+	device_unlock(dev);
+
+	return count;
+}
+
+static DEVICE_ATTR(dev_offline, 0644, dev_offline_show, dev_offline_store);
+
+static ssize_t subdev_online_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+	int ret;
+	char *name = (char *)buf;
+
+	device_lock(dev);
+	ret = xocl_subdev_create_by_name(lro, name);
+	if (ret)
+		xocl_err(dev, "create subdev by name failed");
+	else
+		ret = count;
+	device_unlock(dev);
+
+	return ret;
+}
+
+static DEVICE_ATTR(subdev_online, 0200, NULL, subdev_online_store);
+
+static ssize_t subdev_offline_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xclmgmt_dev *lro = dev_get_drvdata(dev);
+	int ret;
+	char *name = (char *)buf;
+
+	device_lock(dev);
+	ret = xocl_subdev_destroy_by_name(lro, name);
+	if (ret)
+		xocl_err(dev, "destroy subdev by name failed");
+	else
+		ret = count;
+	device_unlock(dev);
+
+	return ret;
+}
+
+static DEVICE_ATTR(subdev_offline, 0200, NULL, subdev_offline_store);
+
+static struct attribute *mgmt_attrs[] = {
+	&dev_attr_instance.attr,
+	&dev_attr_error.attr,
+	&dev_attr_userbar.attr,
+	&dev_attr_version.attr,
+	&dev_attr_slot.attr,
+	&dev_attr_link_speed.attr,
+	&dev_attr_link_width.attr,
+	&dev_attr_link_speed_max.attr,
+	&dev_attr_link_width_max.attr,
+	&dev_attr_mig_calibration.attr,
+	&dev_attr_xpr.attr,
+	&dev_attr_ready.attr,
+	&dev_attr_mfg.attr,
+	&dev_attr_mgmt_pf.attr,
+	&dev_attr_flash_type.attr,
+	&dev_attr_board_name.attr,
+	&dev_attr_feature_rom_offset.attr,
+	&dev_attr_dev_offline.attr,
+	&dev_attr_subdev_online.attr,
+	&dev_attr_subdev_offline.attr,
+	NULL,
+};
+
+static struct attribute_group mgmt_attr_group = {
+	.attrs = mgmt_attrs,
+};
+
+int mgmt_init_sysfs(struct device *dev)
+{
+	int err;
+
+	err = sysfs_create_group(&dev->kobj, &mgmt_attr_group);
+	if (err)
+		xocl_err(dev, "create mgmt attrs failed: %d", err);
+
+	return err;
+}
+
+void mgmt_fini_sysfs(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &mgmt_attr_group);
+}
diff --git a/drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c b/drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
new file mode 100644
index 000000000000..ed70ca83d748
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  Copyright (C) 2017-2019 Xilinx, Inc. All rights reserved.
+ *
+ *  Utility Functions for sysmon, axi firewall and other peripherals.
+ *  Author: Umang Parekh
+ *
+ */
+
+#include "mgmt-core.h"
+#include <linux/module.h>
+#include "../xocl_drv.h"
+
+#define XCLMGMT_RESET_MAX_RETRY		10
+
+/**
+ * @returns: NULL if AER apability is not found walking up to the root port
+ *         : pci_dev ptr to the port which is AER capable.
+ */
+static struct pci_dev *find_aer_cap(struct pci_dev *bridge)
+{
+	struct pci_dev *prev_bridge = bridge;
+	int cap;
+
+	if (bridge == NULL)
+		return NULL;
+	/*
+	 * Walk the hierarchy up to the root port
+	 **/
+	do {
+		cap = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ERR);
+		if (cap) {
+			printk(KERN_DEBUG "%s: AER capability found.\n", DRV_NAME);
+			return bridge;
+		}
+
+		prev_bridge = bridge;
+		bridge = bridge->bus->self;
+
+		if (!bridge || prev_bridge == bridge) {
+			printk(KERN_DEBUG "%s: AER capability not found. Ignoring boot command.\n", DRV_NAME);
+			return NULL;
+		}
+
+	} while (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT);
+
+	return NULL;
+}
+
+/*
+ * pcie_(un)mask_surprise_down inspired by myri10ge driver, myri10ge.c
+ */
+static int pcie_mask_surprise_down(struct pci_dev *pdev, u32 *orig_mask)
+{
+	struct pci_dev *bridge = pdev->bus->self;
+	int cap;
+	u32 mask;
+
+	printk(KERN_INFO "%s: pcie_mask_surprise_down\n", DRV_NAME);
+
+	bridge = find_aer_cap(bridge);
+	if (bridge) {
+		cap = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ERR);
+		if (cap) {
+			pci_read_config_dword(bridge, cap + PCI_ERR_UNCOR_MASK, orig_mask);
+			mask = *orig_mask;
+			mask |= 0x20;
+			pci_write_config_dword(bridge, cap + PCI_ERR_UNCOR_MASK, mask);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int pcie_unmask_surprise_down(struct pci_dev *pdev, u32 orig_mask)
+{
+	struct pci_dev *bridge = pdev->bus->self;
+	int cap;
+
+	printk(KERN_DEBUG "%s: pcie_unmask_surprise_down\n", DRV_NAME);
+
+	bridge = find_aer_cap(bridge);
+	if (bridge) {
+		cap = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ERR);
+		if (cap) {
+			pci_write_config_dword(bridge, cap + PCI_ERR_UNCOR_MASK, orig_mask);
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * Workaround for some DSAs that need axilite bus flushed after reset
+ */
+void platform_axilite_flush(struct xclmgmt_dev *lro)
+{
+	u32 val, i, gpio_val;
+
+	mgmt_info(lro, "Flushing axilite busses.");
+
+	/* The flush sequence works as follows:
+	 * Read axilite peripheral up to 4 times
+	 * Check if firewall trips and clear it.
+	 * Touch all axilite interconnects with clock crossing
+	 * in platform which requires reading multiple peripherals
+	 * (Feature ROM, MB Reset GPIO, Sysmon)
+	 */
+	for (i = 0; i < 4; i++) {
+		val = MGMT_READ_REG32(lro, FEATURE_ROM_BASE);
+		xocl_af_clear(lro);
+	}
+
+	for (i = 0; i < 4; i++) {
+		gpio_val = MGMT_READ_REG32(lro, MB_GPIO);
+		xocl_af_clear(lro);
+	}
+
+	for (i = 0; i < 4; i++) {
+		val = MGMT_READ_REG32(lro, SYSMON_BASE);
+		xocl_af_clear(lro);
+	}
+
+	//Can only read this safely if not in reset
+	if (gpio_val == 1) {
+		for (i = 0; i < 4; i++) {
+			val = MGMT_READ_REG32(lro, MB_IMAGE_SCHE);
+			xocl_af_clear(lro);
+		}
+	}
+
+	for (i = 0; i < 4; i++) {
+		val = MGMT_READ_REG32(lro, XHWICAP_CR);
+		xocl_af_clear(lro);
+	}
+
+	for (i = 0; i < 4; i++) {
+		val = MGMT_READ_REG32(lro, GPIO_NULL_BASE);
+		xocl_af_clear(lro);
+	}
+
+	for (i = 0; i < 4; i++) {
+		val = MGMT_READ_REG32(lro, AXI_GATE_BASE);
+		xocl_af_clear(lro);
+	}
+}
+
+/**
+ * Perform a PCIe secondary bus reset. Note: Use this method over pcie fundamental reset.
+ * This method is known to work better.
+ */
+
+long reset_hot_ioctl(struct xclmgmt_dev *lro)
+{
+	long err = 0;
+	const char *ep_name;
+	struct pci_dev *pdev = lro->pci_dev;
+	struct xocl_board_private *dev_info = &lro->core.priv;
+	int retry = 0;
+
+
+	if (!pdev->bus || !pdev->bus->self) {
+		mgmt_err(lro, "Unable to identify device root port for card %d",
+		       lro->instance);
+		err = -ENODEV;
+		goto done;
+	}
+
+	ep_name = pdev->bus->name;
+#if defined(__PPC64__)
+	mgmt_err(lro, "Ignore reset operation for card %d in slot %s:%02x:%1x",
+		lro->instance, ep_name,
+		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+#else
+	mgmt_err(lro, "Trying to reset card %d in slot %s:%02x:%1x",
+		lro->instance, ep_name,
+		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+
+	/* request XMC/ERT to stop */
+	xocl_mb_stop(lro);
+
+	xocl_icap_reset_axi_gate(lro);
+
+	/*
+	 * lock pci config space access from userspace,
+	 * save state and issue PCIe secondary bus reset
+	 */
+	if (!XOCL_DSA_PCI_RESET_OFF(lro)) {
+		(void) xocl_mailbox_reset(lro, false);
+		xclmgmt_reset_pci(lro);
+		(void) xocl_mailbox_reset(lro, true);
+	} else {
+		mgmt_err(lro, "PCI Hot reset is not supported on this board.");
+	}
+
+	/* Workaround for some DSAs. Flush axilite busses */
+	if (dev_info->flags & XOCL_DSAFLAG_AXILITE_FLUSH)
+		platform_axilite_flush(lro);
+
+	/*
+	 * Check firewall status. Status should be 0 (cleared)
+	 * Otherwise issue message that a warm reboot is required.
+	 */
+	do {
+		msleep(20);
+	} while (retry++ < XCLMGMT_RESET_MAX_RETRY &&
+		xocl_af_check(lro, NULL));
+
+	if (retry >= XCLMGMT_RESET_MAX_RETRY) {
+		mgmt_err(lro, "Board is not able to recover by PCI Hot reset, please warm reboot");
+		return -EIO;
+	}
+
+	//Also freeze and free AXI gate to reset the OCL region.
+	xocl_icap_reset_axi_gate(lro);
+
+	/* Workaround for some DSAs. Flush axilite busses */
+	if (dev_info->flags & XOCL_DSAFLAG_AXILITE_FLUSH)
+		platform_axilite_flush(lro);
+
+	/* restart XMC/ERT */
+	xocl_mb_reset(lro);
+
+#endif
+done:
+	return err;
+}
+
+static int xocl_match_slot_and_save(struct device *dev, void *data)
+{
+	struct pci_dev *pdev;
+	unsigned long slot;
+
+	pdev = to_pci_dev(dev);
+	slot = PCI_SLOT(pdev->devfn);
+
+	if (slot == (unsigned long)data) {
+		pci_cfg_access_lock(pdev);
+		pci_save_state(pdev);
+	}
+
+	return 0;
+}
+
+static void xocl_pci_save_config_all(struct pci_dev *pdev)
+{
+	unsigned long slot = PCI_SLOT(pdev->devfn);
+
+	bus_for_each_dev(&pci_bus_type, NULL, (void *)slot,
+		xocl_match_slot_and_save);
+}
+
+static int xocl_match_slot_and_restore(struct device *dev, void *data)
+{
+	struct pci_dev *pdev;
+	unsigned long slot;
+
+	pdev = to_pci_dev(dev);
+	slot = PCI_SLOT(pdev->devfn);
+
+	if (slot == (unsigned long)data) {
+		pci_restore_state(pdev);
+		pci_cfg_access_unlock(pdev);
+	}
+
+	return 0;
+}
+
+static void xocl_pci_restore_config_all(struct pci_dev *pdev)
+{
+	unsigned long slot = PCI_SLOT(pdev->devfn);
+
+	bus_for_each_dev(&pci_bus_type, NULL, (void *)slot,
+		xocl_match_slot_and_restore);
+}
+/*
+ * Inspired by GenWQE driver, card_base.c
+ */
+int pci_fundamental_reset(struct xclmgmt_dev *lro)
+{
+	int rc;
+	u32 orig_mask;
+	u8 hot;
+	struct pci_dev *pci_dev = lro->pci_dev;
+
+	//freeze and free AXI gate to reset the OCL region before and after the pcie reset.
+	xocl_icap_reset_axi_gate(lro);
+
+	/*
+	 * lock pci config space access from userspace,
+	 * save state and issue PCIe fundamental reset
+	 */
+	mgmt_info(lro, "%s\n", __func__);
+
+	// Save pci config space for botht the pf's
+	xocl_pci_save_config_all(pci_dev);
+
+	rc = pcie_mask_surprise_down(pci_dev, &orig_mask);
+	if (rc)
+		goto done;
+
+#if defined(__PPC64__)
+	/*
+	 * On PPC64LE use pcie_warm_reset which will cause the FPGA to
+	 * reload from PROM
+	 */
+	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset);
+	if (rc)
+		goto done;
+	/* keep PCIe reset asserted for 250ms */
+	msleep(250);
+	rc = pci_set_pcie_reset_state(pci_dev, pcie_deassert_reset);
+	if (rc)
+		goto done;
+	/* Wait for 2s to reload flash and train the link */
+	msleep(2000);
+#else
+	rc = xocl_icap_reset_bitstream(lro);
+	if (rc)
+		goto done;
+
+	/* Now perform secondary bus reset which should reset most of the device */
+	pci_read_config_byte(pci_dev->bus->self, PCI_MIN_GNT, &hot);
+	/* Toggle the PCIe hot reset bit in the root port */
+	pci_write_config_byte(pci_dev->bus->self, PCI_MIN_GNT, hot | 0x40);
+	msleep(500);
+	pci_write_config_byte(pci_dev->bus->self, PCI_MIN_GNT, hot);
+	msleep(500);
+#endif
+done:
+	// restore pci config space for botht the pf's
+	rc = pcie_unmask_surprise_down(pci_dev, orig_mask);
+	xocl_pci_restore_config_all(pci_dev);
+
+	//Also freeze and free AXI gate to reset the OCL region.
+	xocl_icap_reset_axi_gate(lro);
+
+	return rc;
+}
+
+unsigned int compute_unit_busy(struct xclmgmt_dev *lro)
+{
+	int i = 0;
+	unsigned int result = 0;
+	u32 r = MGMT_READ_REG32(lro, AXI_GATE_BASE_RD_BASE);
+
+	/*
+	 * r != 0x3 implies that OCL region is isolated and we cannot read
+	 * CUs' status
+	 */
+	if (r != 0x3)
+		return 0;
+
+	/* ?? Assumed only 16 CUs ? */
+	for (i = 0; i < 16; i++) {
+		r = MGMT_READ_REG32(lro, OCL_CTLR_BASE + i * OCL_CU_CTRL_RANGE);
+		if (r == 0x1)
+			result |= (r << i);
+	}
+	return result;
+}
+
+void xclmgmt_reset_pci(struct xclmgmt_dev *lro)
+{
+	struct pci_dev *pdev = lro->pci_dev;
+	struct pci_bus *bus;
+	int i;
+	u16 pci_cmd;
+	u8 pci_bctl;
+
+	mgmt_info(lro, "Reset PCI");
+
+	/* what if user PF in VM ? */
+	xocl_pci_save_config_all(pdev);
+
+	/* Reset secondary bus. */
+	bus = pdev->bus;
+	pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
+	pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+
+	msleep(100);
+	pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+
+	for (i = 0; i < 5000; i++) {
+		pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd != 0xffff)
+			break;
+		msleep(1);
+	}
+
+	mgmt_info(lro, "Resetting for %d ms", i);
+
+	xocl_pci_restore_config_all(pdev);
+}
-- 
2.17.0

