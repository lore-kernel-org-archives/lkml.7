Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A1EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3FF217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1NlZH3lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCSVyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:54:23 -0400
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:42148
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbfCSVyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P1wj2GIaMVFakoJ6FHkk9MTldF4wx4WTvvqJ/oVe00=;
 b=1NlZH3lhivO6U/Ci0/KoQB3bSnOd8vTE50bHaQdtQz5rSCKv25cPuXauNkicb6xA5OMDT/MalZTEHYsb901FbeZQYrqaroRtuLt9rt/fNTDLNRQyAgEBLqpPOiKk62PSaCTSEA+bnZjxzTRKLIWr9Gzhl5gaAvft8XSnywNDVa4=
Received: from MWHPR0201CA0010.namprd02.prod.outlook.com (10.167.160.151) by
 BN8PR02MB5906.namprd02.prod.outlook.com (20.179.96.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 21:54:13 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0010.outlook.office365.com
 (2603:10b6:301:74::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 21:54:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 21:54:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgW-0001Qa-Cs; Tue, 19 Mar 2019 14:54:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgR-0001Oa-9y; Tue, 19 Mar 2019 14:54:07 -0700
Received: from [172.19.73.196] (helo=xsjsonals5570.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <sonals@xilinx.com>)
        id 1h6MgL-0001KJ-PB; Tue, 19 Mar 2019 14:54:01 -0700
Received: by xsjsonals5570.xilinx.com (Postfix, from userid 1000)
        id 7D23A76001C; Tue, 19 Mar 2019 14:54:01 -0700 (PDT)
From:   <sonal.santan@xilinx.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <airlied@redhat.com>, <cyrilc@xilinx.com>, <michals@xilinx.com>,
        <lizhih@xilinx.com>, <hyunk@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>
Subject: [RFC PATCH Xilinx Alveo 1/6] Add skeleton code: ioctl definitions and build hooks
Date:   Tue, 19 Mar 2019 14:53:56 -0700
Message-ID: <20190319215401.6562-2-sonal.santan@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190319215401.6562-1-sonal.santan@xilinx.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(189003)(199004)(6346003)(90966002)(76176011)(8676002)(4326008)(107886003)(6916009)(81166006)(8936002)(106002)(316002)(11346002)(16586007)(426003)(42186006)(50226002)(305945005)(336012)(81156014)(446003)(486006)(6266002)(51416003)(478600001)(48376002)(186003)(50466002)(47776003)(14444005)(2616005)(86152003)(36386004)(6666004)(54906003)(356004)(63266004)(2876002)(30864003)(2906002)(476003)(2351001)(5660300002)(103686004)(26005)(52956003)(1076003)(106466001)(36756003)(126002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5906;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f09e4c-ac85-4b5e-b644-08d6acb56ca3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN8PR02MB5906;
X-MS-TrafficTypeDiagnostic: BN8PR02MB5906:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN8PR02MB5906F62CAE5C5DEFA9B2C76DBB400@BN8PR02MB5906.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: k1MT5igoGdyv4qyL8SuTfvFCG9v/6cxkWnRRDA4pXie+Wv4gdfLU7OlgQUvYnS8CaN8BMvwStuwJ8ql8VSjx43PPmujEgnUKy8KSkFiMiudxf2Ijq+RQr5wFTl9NFSRLGhKw8+cglIv4rx7/qzgtqwdn3bdHTTzk2pSEZk04in0Eh2HbsBp524YOKqOczWRueEbaXFZrhn5WBMGiHwXicO5yPAOtlZavltDp+QePJkzOxP/P2nTWnNoDBoQrKdd5Oc4sUPibfxVI7pzbt2VlcsOqXK5VcE55Nd/j54OPw0ZcMf/VvUnDYghSLa38X2tzhru7PVWr5NcX3P/OwI+A5OqQHIcdgh9ql467NMomdD0QKGendk9xYezknSoZGZ8/HmE03ffq4whW0Rfz1WyEk7omQQFYw1I/qB/oJ7fHzTw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 21:54:12.8017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f09e4c-ac85-4b5e-b644-08d6acb56ca3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/gpu/drm/Kconfig              |   2 +
 drivers/gpu/drm/Makefile             |   1 +
 drivers/gpu/drm/xocl/Kconfig         |  22 ++
 drivers/gpu/drm/xocl/Makefile        |   3 +
 drivers/gpu/drm/xocl/mgmtpf/Makefile |  29 ++
 drivers/gpu/drm/xocl/userpf/Makefile |  27 ++
 include/uapi/drm/xmgmt_drm.h         | 204 +++++++++++
 include/uapi/drm/xocl_drm.h          | 483 +++++++++++++++++++++++++++
 8 files changed, 771 insertions(+)
 create mode 100644 drivers/gpu/drm/xocl/Kconfig
 create mode 100644 drivers/gpu/drm/xocl/Makefile
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/Makefile
 create mode 100644 drivers/gpu/drm/xocl/userpf/Makefile
 create mode 100644 include/uapi/drm/xmgmt_drm.h
 create mode 100644 include/uapi/drm/xocl_drm.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index bd943a71756c..cc3785b1ae3d 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -329,6 +329,8 @@ source "drivers/gpu/drm/tve200/Kconfig"
 
 source "drivers/gpu/drm/xen/Kconfig"
 
+source "drivers/gpu/drm/xocl/Kconfig"
+
 # Keep legacy drivers last
 
 menuconfig DRM_LEGACY
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 1ac55c65eac0..ebebaba2bf3d 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -109,3 +109,4 @@ obj-$(CONFIG_DRM_TINYDRM) += tinydrm/
 obj-$(CONFIG_DRM_PL111) += pl111/
 obj-$(CONFIG_DRM_TVE200) += tve200/
 obj-$(CONFIG_DRM_XEN) += xen/
+obj-$(CONFIG_DRM_XOCL) += xocl/
diff --git a/drivers/gpu/drm/xocl/Kconfig b/drivers/gpu/drm/xocl/Kconfig
new file mode 100644
index 000000000000..197d36250b7c
--- /dev/null
+++ b/drivers/gpu/drm/xocl/Kconfig
@@ -0,0 +1,22 @@
+#
+# Xilinx Alveo and FaaS platform drivers
+#
+
+config DRM_XOCL
+	tristate "DRM Support for Xilinx PCIe Accelerator Alveo and FaaS platforms (EXPERIMENTAL)"
+	depends on DRM
+	depends on PCI
+	default n
+	help
+	  Choose this option if you have a Xilinx PCIe Accelerator
+	  card like Alveo or FaaS environments like AWS F1
+
+
+config DRM_XMGMT
+	tristate "DRM Support for Xilinx PCIe Accelerator Alveo and FaaS platforms (EXPERIMENTAL)"
+	depends on PCI
+	depends on FPGA
+	default n
+	help
+	  Choose this option if you have a Xilinx PCIe Accelerator
+	  card like Alveo
diff --git a/drivers/gpu/drm/xocl/Makefile b/drivers/gpu/drm/xocl/Makefile
new file mode 100644
index 000000000000..605459ab7de6
--- /dev/null
+++ b/drivers/gpu/drm/xocl/Makefile
@@ -0,0 +1,3 @@
+
+obj-$(CONFIG_DRM_XOCL) += userpf/
+obj-$(CONFIG_DRM_XMGMT) += mgmtpf/
diff --git a/drivers/gpu/drm/xocl/mgmtpf/Makefile b/drivers/gpu/drm/xocl/mgmtpf/Makefile
new file mode 100644
index 000000000000..569b7dc01866
--- /dev/null
+++ b/drivers/gpu/drm/xocl/mgmtpf/Makefile
@@ -0,0 +1,29 @@
+obj-m	+= xmgmt.o
+
+xmgmt-y := \
+	../xocl_subdev.o \
+	../xocl_ctx.o \
+	../xocl_thread.o \
+	../subdev/sysmon.o \
+	../subdev/feature_rom.o \
+	../subdev/microblaze.o \
+	../subdev/firewall.o \
+	../subdev/xvc.o \
+	../subdev/mailbox.o \
+	../subdev/icap.o \
+	../subdev/mig.o \
+	../subdev/xmc.o \
+	../subdev/dna.o \
+	../subdev/fmgr.o \
+	mgmt-core.o \
+	mgmt-cw.o \
+	mgmt-utils.o \
+	mgmt-ioctl.o \
+	mgmt-sysfs.o
+
+
+
+ccflags-y += -DSUBDEV_SUFFIX=MGMT_SUFFIX
+ifeq ($(DEBUG),1)
+ccflags-y += -DDEBUG
+endif
diff --git a/drivers/gpu/drm/xocl/userpf/Makefile b/drivers/gpu/drm/xocl/userpf/Makefile
new file mode 100644
index 000000000000..ff895d2b2e68
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/Makefile
@@ -0,0 +1,27 @@
+obj-$(CONFIG_DRM_XOCL)	+= xocl.o
+
+include $(src)/../lib/Makefile.in
+
+xocl-y := \
+	../xocl_subdev.o \
+	../xocl_ctx.o \
+	../xocl_thread.o \
+	../subdev/xdma.o \
+	../subdev/feature_rom.o \
+	../subdev/mb_scheduler.o \
+	../subdev/mailbox.o \
+	../subdev/xvc.o \
+	../subdev/icap.o \
+	../subdev/xmc.o \
+	$(xocl_lib-y)	\
+	xocl_drv.o	\
+	xocl_bo.o	\
+	xocl_drm.o	\
+	xocl_ioctl.o	\
+	xocl_sysfs.o
+
+
+ccflags-y += -DSUBDEV_SUFFIX=USER_SUFFIX
+ifeq ($(DEBUG),1)
+ccflags-y += -DDEBUG
+endif
diff --git a/include/uapi/drm/xmgmt_drm.h b/include/uapi/drm/xmgmt_drm.h
new file mode 100644
index 000000000000..a0c23cf2ae82
--- /dev/null
+++ b/include/uapi/drm/xmgmt_drm.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+/**
+ * DOC: PCIe Kernel Driver for Managament Physical Function
+ * Interfaces exposed by *xclmgmt* driver are defined in file, *mgmt-ioctl.h*.
+ * Core functionality provided by *xclmgmt* driver is described in the following table:
+ *
+ * ==== ====================================== ============================== ==================================
+ * #    Functionality                          ioctl request code             data format
+ * ==== ====================================== ============================== ==================================
+ * 1    FPGA image download                    XCLMGMT_IOCICAPDOWNLOAD_AXLF   xclmgmt_ioc_bitstream_axlf
+ * 2    CL frequency scaling                   XCLMGMT_IOCFREQSCALE           xclmgmt_ioc_freqscaling
+ * 3    PCIe hot reset                         XCLMGMT_IOCHOTRESET            NA
+ * 4    CL reset                               XCLMGMT_IOCOCLRESET            NA
+ * 5    Live boot FPGA from PROM               XCLMGMT_IOCREBOOT              NA
+ * 6    Device sensors (current, voltage and   NA                             *hwmon* (xclmgmt_microblaze and
+ *      temperature)                                                          xclmgmt_sysmon) interface on sysfs
+ * 7    Querying device errors                 XCLMGMT_IOCERRINFO             xclErrorStatus
+ * ==== ====================================== ============================== ==================================
+ *
+ */
+
+#ifndef _XCLMGMT_IOCALLS_POSIX_H_
+#define _XCLMGMT_IOCALLS_POSIX_H_
+
+#include <linux/ioctl.h>
+
+/**
+ * enum xclFirewallID - AXI Firewall IDs used to identify individual AXI Firewalls
+ *
+ * @XCL_FW_MGMT_CONTROL:  MGMT BAR AXI-Lite BAR access protection
+ * @XCL_FW_USER_CONTROL:  USER BAR AXI-Lite BAR access protection
+ * @XCL_FW_DATAPATH:	  DMA data path protection
+ */
+enum xclFirewallID {
+	XCL_FW_MGMT_CONTROL = 0,
+	XCL_FW_USER_CONTROL,
+	XCL_FW_DATAPATH,
+	XCL_FW_MAX_LEVEL // always the last one
+};
+
+/**
+ * struct xclAXIErrorStatus - Record used to capture specific error
+ *
+ * @mErrFirewallTime:	 Timestamp of when Firewall tripped
+ * @mErrFirewallStatus:	 Error code obtained from the Firewall
+ * @mErrFirewallID:	 Firewall ID
+ */
+struct xclAXIErrorStatus {
+	unsigned int long   mErrFirewallTime;
+	unsigned int	    mErrFirewallStatus;
+	enum xclFirewallID  mErrFirewallID;
+};
+
+struct xclPCIErrorStatus {
+	unsigned int mDeviceStatus;
+	unsigned int mUncorrErrStatus;
+	unsigned int mCorrErrStatus;
+	unsigned int rsvd1;
+	unsigned int rsvd2;
+};
+
+/**
+ * struct xclErrorStatus - Container for all error records
+ *
+ * @mNumFirewalls:    Count of Firewalls in the record (max is 8)
+ * @mAXIErrorStatus:  Records holding Firewall information
+ * @mPCIErrorStatus:  Unused
+ */
+struct xclErrorStatus {
+	unsigned int mNumFirewalls;
+	struct xclAXIErrorStatus mAXIErrorStatus[8];
+	struct xclPCIErrorStatus mPCIErrorStatus;
+	unsigned int mFirewallLevel;
+};
+
+#define XCLMGMT_IOC_MAGIC	'X'
+#define XCLMGMT_NUM_SUPPORTED_CLOCKS 4
+#define XCLMGMT_NUM_ACTUAL_CLOCKS 2
+#define XCLMGMT_NUM_FIREWALL_IPS 3
+#define AWS_SHELL14		69605400
+
+#define AXI_FIREWALL
+
+enum XCLMGMT_IOC_TYPES {
+	XCLMGMT_IOC_INFO,
+	XCLMGMT_IOC_ICAP_DOWNLOAD,
+	XCLMGMT_IOC_FREQ_SCALE,
+	XCLMGMT_IOC_OCL_RESET,
+	XCLMGMT_IOC_HOT_RESET,
+	XCLMGMT_IOC_REBOOT,
+	XCLMGMT_IOC_ICAP_DOWNLOAD_AXLF,
+	XCLMGMT_IOC_ERR_INFO,
+	XCLMGMT_IOC_MAX
+};
+
+/**
+ * struct xclmgmt_ioc_info - Obtain information from the device
+ * used with XCLMGMT_IOCINFO ioctl
+ *
+ * Note that this structure will be obsoleted in future and the same functionality will be exposed via sysfs nodes
+ */
+struct xclmgmt_ioc_info {
+	unsigned short vendor;
+	unsigned short device;
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	unsigned int driver_version;
+	unsigned int device_version;
+	unsigned long long feature_id;
+	unsigned long long time_stamp;
+	unsigned short ddr_channel_num;
+	unsigned short ddr_channel_size;
+	unsigned short pcie_link_width;
+	unsigned short pcie_link_speed;
+	char vbnv[64];
+	char fpga[64];
+	unsigned short onchip_temp;
+	unsigned short fan_temp;
+	unsigned short fan_speed;
+	unsigned short vcc_int;
+	unsigned short vcc_aux;
+	unsigned short vcc_bram;
+	unsigned short ocl_frequency[XCLMGMT_NUM_SUPPORTED_CLOCKS];
+	bool mig_calibration[4];
+	unsigned short num_clocks;
+	bool isXPR;
+	unsigned int pci_slot;
+	unsigned long long xmc_version;
+	unsigned short twelve_vol_pex;
+	unsigned short twelve_vol_aux;
+	unsigned long long pex_curr;
+	unsigned long long aux_curr;
+	unsigned short three_vol_three_pex;
+	unsigned short three_vol_three_aux;
+	unsigned short ddr_vpp_btm;
+	unsigned short sys_5v5;
+	unsigned short one_vol_two_top;
+	unsigned short one_vol_eight_top;
+	unsigned short zero_vol_eight;
+	unsigned short ddr_vpp_top;
+	unsigned short mgt0v9avcc;
+	unsigned short twelve_vol_sw;
+	unsigned short mgtavtt;
+	unsigned short vcc1v2_btm;
+	short se98_temp[4];
+	short dimm_temp[4];
+};
+
+struct xclmgmt_ioc_bitstream {
+	struct xclBin *xclbin;
+};
+
+
+/*
+ * struct xclmgmt_err_info - Obtain Error information from the device
+ * used with XCLMGMT_IOCERRINFO ioctl
+ *
+ * Note that this structure will be obsoleted in future and the same functionality will be exposed via sysfs nodes
+ */
+struct xclmgmt_err_info {
+	unsigned int mNumFirewalls;
+	struct xclAXIErrorStatus mAXIErrorStatus[8];
+	struct xclPCIErrorStatus mPCIErrorStatus;
+};
+
+/**
+ * struct xclmgmt_ioc_bitstream_axlf - load xclbin (AXLF) device image
+ * used with XCLMGMT_IOCICAPDOWNLOAD_AXLF ioctl
+ *
+ * @xclbin:	Pointer to user's xclbin structure in memory
+ */
+struct xclmgmt_ioc_bitstream_axlf {
+	struct axlf *xclbin;
+};
+
+/**
+ * struct xclmgmt_ioc_freqscaling - scale frequencies on the board using Xilinx clock wizard
+ * used with XCLMGMT_IOCFREQSCALE ioctl
+ *
+ * @ocl_region:		PR region (currently only 0 is supported)
+ * @ocl_target_freq:	Array of requested frequencies, a value o zero in the array indicates leave untouched
+ */
+struct xclmgmt_ioc_freqscaling {
+	unsigned int ocl_region;
+	unsigned short ocl_target_freq[XCLMGMT_NUM_SUPPORTED_CLOCKS];
+};
+
+#define XCLMGMT_IOCINFO			 _IOR(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_INFO, \
+					      struct xclmgmt_ioc_info)
+#define XCLMGMT_IOCICAPDOWNLOAD		 _IOW(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_ICAP_DOWNLOAD, \
+					      struct xclmgmt_ioc_bitstream)
+#define XCLMGMT_IOCICAPDOWNLOAD_AXLF	 _IOW(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_ICAP_DOWNLOAD_AXLF, \
+					      struct xclmgmt_ioc_bitstream_axlf)
+#define XCLMGMT_IOCFREQSCALE		 _IOW(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_FREQ_SCALE, \
+					      struct xclmgmt_ioc_freqscaling)
+#define XCLMGMT_IOCHOTRESET		 _IO(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_HOT_RESET)
+#define XCLMGMT_IOCOCLRESET		 _IO(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_OCL_RESET)
+#define XCLMGMT_IOCREBOOT		 _IO(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_REBOOT)
+#define XCLMGMT_IOCERRINFO		 _IOR(XCLMGMT_IOC_MAGIC, XCLMGMT_IOC_ERR_INFO, struct xclErrorStatus)
+
+#define	XCLMGMT_MB_HWMON_NAME	    "xclmgmt_microblaze"
+#define XCLMGMT_SYSMON_HWMON_NAME   "xclmgmt_sysmon"
+#endif
diff --git a/include/uapi/drm/xocl_drm.h b/include/uapi/drm/xocl_drm.h
new file mode 100644
index 000000000000..259e30b159ca
--- /dev/null
+++ b/include/uapi/drm/xocl_drm.h
@@ -0,0 +1,483 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+/**
+ * DOC: A GEM style driver for Xilinx PCIe based accelerators
+ * This file defines ioctl command codes and associated structures for interacting with
+ * *xocl* PCI driver for Xilinx FPGA platforms.
+ *
+ * Device memory allocation is modeled as buffer objects (bo). For each bo driver tracks the host pointer
+ * backed by scatter gather list -- which provides backing storage on host -- and the corresponding device
+ * side allocation of contiguous buffer in one of the memory mapped DDRs/BRAMs, etc.
+ *
+ * Exection model is asynchronous where execute commands are submitted using command buffers and POSIX poll
+ * is used to wait for finished commands. Commands for a compute unit can only be submitted after an explicit
+ * context has been opened by the client.
+ *
+ * *xocl* driver functionality is described in the following table. All the APIs are multi-threading and
+ * multi-process safe.
+ *
+ * ==== ====================================== ============================== ==================================
+ * #    Functionality                          ioctl request code             data format
+ * ==== ====================================== ============================== ==================================
+ * 1    Allocate buffer on device              DRM_IOCTL_XOCL_CREATE_BO       drm_xocl_create_bo
+ * 2    Allocate buffer on device with         DRM_IOCTL_XOCL_USERPTR_BO      drm_xocl_userptr_bo
+ *      userptr
+ * 3    Prepare bo for mapping into user's     DRM_IOCTL_XOCL_MAP_BO          drm_xocl_map_bo
+ *      address space
+ * 4    Synchronize (DMA) buffer contents in   DRM_IOCTL_XOCL_SYNC_BO         drm_xocl_sync_bo
+ *      requested direction
+ * 5    Obtain information about buffer        DRM_IOCTL_XOCL_INFO_BO         drm_xocl_info_bo
+ *      object
+ * 6    Update bo backing storage with user's  DRM_IOCTL_XOCL_PWRITE_BO       drm_xocl_pwrite_bo
+ *      data
+ * 7    Read back data in bo backing storage   DRM_IOCTL_XOCL_PREAD_BO        drm_xocl_pread_bo
+ * 8    Open/close a context on a compute unit DRM_XOCL_CTX                   drm_xocl_ctx
+ *      on the device
+ * 9    Unprotected write to device memory     DRM_IOCTL_XOCL_PWRITE_UNMGD    drm_xocl_pwrite_unmgd
+ * 10   Unprotected read from device memory    DRM_IOCTL_XOCL_PREAD_UNMGD     drm_xocl_pread_unmgd
+ * 11   Send an execute job to a compute unit  DRM_IOCTL_XOCL_EXECBUF         drm_xocl_execbuf
+ * 12   Register eventfd handle for MSIX       DRM_IOCTL_XOCL_USER_INTR       drm_xocl_user_intr
+ *      interrupt
+ * 13   Update device view with a specific     DRM_XOCL_READ_AXLF             drm_xocl_axlf
+ *      xclbin image
+ * 14   Write buffer from device to peer FPGA  DRM_IOCTL_XOCL_COPY_BO         drm_xocl_copy_bo
+ *      buffer
+ * ==== ====================================== ============================== ==================================
+ */
+
+#ifndef _XCL_XOCL_IOCTL_H_
+#define _XCL_XOCL_IOCTL_H_
+
+#if defined(__KERNEL__)
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/version.h>
+#elif defined(__cplusplus)
+#include <cstdlib>
+#include <cstdint>
+#include <uuid/uuid.h>
+#else
+#include <stdlib.h>
+#include <stdint.h>
+#include <uuid/uuid.h>
+#endif
+
+/*
+ * enum drm_xocl_ops - ioctl command code enumerations
+ */
+enum drm_xocl_ops {
+	/* Buffer creation */
+	DRM_XOCL_CREATE_BO = 0,
+	/* Buffer creation from user provided pointer */
+	DRM_XOCL_USERPTR_BO,
+	/* Map buffer into application user space (no DMA is performed) */
+	DRM_XOCL_MAP_BO,
+	/* Sync buffer (like fsync) in the desired direction by using DMA */
+	DRM_XOCL_SYNC_BO,
+	/* Get information about the buffer such as physical address in the device, etc */
+	DRM_XOCL_INFO_BO,
+	/* Update host cached copy of buffer wih user's data */
+	DRM_XOCL_PWRITE_BO,
+	/* Update user's data with host cached copy of buffer */
+	DRM_XOCL_PREAD_BO,
+	/* Other ioctls */
+	DRM_XOCL_OCL_RESET,
+	/* Open/close a context */
+	DRM_XOCL_CTX,
+	/* Get information from device */
+	DRM_XOCL_INFO,
+	/* Unmanaged DMA from/to device */
+	DRM_XOCL_PREAD_UNMGD,
+	DRM_XOCL_PWRITE_UNMGD,
+	/* Various usage metrics */
+	DRM_XOCL_USAGE_STAT,
+	/* Hardware debug command */
+	DRM_XOCL_DEBUG,
+	/* Command to run on one or more CUs */
+	DRM_XOCL_EXECBUF,
+	/* Register eventfd for user interrupts */
+	DRM_XOCL_USER_INTR,
+	/* Read xclbin/axlf */
+	DRM_XOCL_READ_AXLF,
+	/* Copy buffer to Destination buffer by using DMA */
+	DRM_XOCL_COPY_BO,
+	/* Hot reset request */
+	DRM_XOCL_HOT_RESET,
+	/* Reclock through userpf*/
+	DRM_XOCL_RECLOCK,
+
+	DRM_XOCL_NUM_IOCTLS
+};
+
+enum drm_xocl_sync_bo_dir {
+	DRM_XOCL_SYNC_BO_TO_DEVICE = 0,
+	DRM_XOCL_SYNC_BO_FROM_DEVICE
+};
+
+/*
+ * Higher 4 bits are for DDR, one for each DDR
+ * LSB bit for execbuf
+ */
+#define DRM_XOCL_BO_BANK0   (0x1)
+#define DRM_XOCL_BO_BANK1   (0x1 << 1)
+#define DRM_XOCL_BO_BANK2   (0x1 << 2)
+#define DRM_XOCL_BO_BANK3   (0x1 << 3)
+
+#define DRM_XOCL_BO_CMA     (0x1 << 29)
+#define DRM_XOCL_BO_P2P     (0x1 << 30)
+#define DRM_XOCL_BO_EXECBUF (0x1 << 31)
+
+#define DRM_XOCL_CTX_FLAG_EXCLUSIVE (0x1)
+
+
+#define DRM_XOCL_NUM_SUPPORTED_CLOCKS 4
+/**
+ * struct drm_xocl_create_bo - Create buffer object
+ * used with DRM_IOCTL_XOCL_CREATE_BO ioctl
+ *
+ * @size:       Requested size of the buffer object
+ * @handle:     bo handle returned by the driver
+ * @flags:      DRM_XOCL_BO_XXX flags
+ * @type:       The type of bo
+ */
+struct drm_xocl_create_bo {
+	uint64_t size;
+	uint32_t handle;
+	uint32_t flags;
+	uint32_t type;
+};
+
+/**
+ * struct drm_xocl_userptr_bo - Create buffer object with user's pointer
+ * used with DRM_IOCTL_XOCL_USERPTR_BO ioctl
+ *
+ * @addr:       Address of buffer allocated by user
+ * @size:       Requested size of the buffer object
+ * @handle:     bo handle returned by the driver
+ * @flags:      DRM_XOCL_BO_XXX flags
+ * @type:       The type of bo
+ */
+struct drm_xocl_userptr_bo {
+	uint64_t addr;
+	uint64_t size;
+	uint32_t handle;
+	uint32_t flags;
+	uint32_t type;
+};
+
+/**
+ * struct drm_xocl_map_bo - Prepare a buffer object for mmap
+ * used with DRM_IOCTL_XOCL_MAP_BO ioctl
+ *
+ * @handle:     bo handle
+ * @pad:        Unused
+ * @offset:     'Fake' offset returned by the driver which can be used with POSIX mmap
+ */
+struct drm_xocl_map_bo {
+	uint32_t handle;
+	uint32_t pad;
+	uint64_t offset;
+};
+
+/**
+ * struct drm_xocl_sync_bo - Synchronize the buffer in the requested direction
+ * between device and host
+ * used with DRM_IOCTL_XOCL_SYNC_BO ioctl
+ *
+ * @handle:	bo handle
+ * @flags:	Unused
+ * @size:	Number of bytes to synchronize
+ * @offset:	Offset into the object to synchronize
+ * @dir:	DRM_XOCL_SYNC_DIR_XXX
+ */
+struct drm_xocl_sync_bo {
+	uint32_t handle;
+	uint32_t flags;
+	uint64_t size;
+	uint64_t offset;
+	enum drm_xocl_sync_bo_dir dir;
+};
+
+/**
+ * struct drm_xocl_info_bo - Obtain information about an allocated buffer obbject
+ * used with DRM_IOCTL_XOCL_INFO_BO IOCTL
+ *
+ * @handle:	bo handle
+ * @flags:      Unused
+ * @size:	Size of buffer object (out)
+ * @paddr:	Physical address (out)
+ */
+struct drm_xocl_info_bo {
+	uint32_t handle;
+	uint32_t flags;
+	uint64_t size;
+	uint64_t paddr;
+};
+
+/**
+ * struct drm_xocl_copy_bo - copy source buffer to destination buffer
+ * between device and device
+ * used with DRM_IOCTL_XOCL_COPY_BO ioctl
+ *
+ * @dst_handle: destination bo handle
+ * @src_handle: source bo handle
+ * @flags:  Unused
+ * @size: Number of bytes to synchronize
+ * @dst_offset: Offset into the object to destination buffer to synchronize
+ * @src_offset: Offset into the object to source buffer to synchronize
+ */
+struct drm_xocl_copy_bo {
+	uint32_t dst_handle;
+	uint32_t src_handle;
+	uint32_t flags;
+	uint64_t size;
+	uint64_t dst_offset;
+	uint64_t src_offset;
+};
+/**
+ * struct drm_xocl_axlf - load xclbin (AXLF) device image
+ * used with DRM_IOCTL_XOCL_READ_AXLF ioctl
+ * NOTE: This ioctl will be removed in next release
+ *
+ * @xclbin:	Pointer to user's xclbin structure in memory
+ */
+struct drm_xocl_axlf {
+	struct axlf *xclbin;
+};
+
+/**
+ * struct drm_xocl_pwrite_bo - Update bo with user's data
+ * used with DRM_IOCTL_XOCL_PWRITE_BO ioctl
+ *
+ * @handle:	bo handle
+ * @pad:	Unused
+ * @offset:	Offset into the buffer object to write to
+ * @size:	Length of data to write
+ * @data_ptr:	User's pointer to read the data from
+ */
+struct drm_xocl_pwrite_bo {
+	uint32_t handle;
+	uint32_t pad;
+	uint64_t offset;
+	uint64_t size;
+	uint64_t data_ptr;
+};
+
+/**
+ * struct drm_xocl_pread_bo - Read data from bo
+ * used with DRM_IOCTL_XOCL_PREAD_BO ioctl
+ *
+ * @handle:	bo handle
+ * @pad:	Unused
+ * @offset:	Offset into the buffer object to read from
+ * @size:	Length of data to read
+ * @data_ptr:	User's pointer to write the data into
+ */
+struct drm_xocl_pread_bo {
+	uint32_t handle;
+	uint32_t pad;
+	uint64_t offset;
+	uint64_t size;
+	uint64_t data_ptr;
+};
+
+enum drm_xocl_ctx_code {
+	XOCL_CTX_OP_ALLOC_CTX = 0,
+	XOCL_CTX_OP_FREE_CTX
+};
+
+#define XOCL_CTX_SHARED    0x0
+#define XOCL_CTX_EXCLUSIVE 0x1
+
+/**
+ * struct drm_xocl_ctx - Open or close a context on a compute unit on device
+ * used with DRM_XOCL_CTX ioctl
+ *
+ * @op:            Alloc or free a context (XOCL_CTX_OP_ALLOC_CTX/XOCL_CTX_OP_FREE_CTX)
+ * @xclbin_id:	   UUID of the device image (xclbin)
+ * @cu_index:	   Index of the compute unit in the device inage for which
+ *                 the request is being made
+ * @flags:	   Shared or exclusive context (XOCL_CTX_SHARED/XOCL_CTX_EXCLUSIVE)
+ * @handle:	   Unused
+ */
+struct drm_xocl_ctx {
+	enum drm_xocl_ctx_code op;
+	uuid_t	 xclbin_id;
+	uint32_t cu_index;
+	uint32_t flags;
+	// unused, in future it would return context id
+	uint32_t handle;
+};
+
+struct drm_xocl_info {
+	unsigned short vendor;
+	unsigned short device;
+	unsigned short subsystem_vendor;
+	unsigned short subsystem_device;
+	unsigned int dma_engine_version;
+	unsigned int driver_version;
+	unsigned int pci_slot;
+	char reserved[64];
+};
+
+
+/**
+ * struct drm_xocl_pwrite_unmgd - unprotected write to device memory
+ * used with DRM_IOCTL_XOCL_PWRITE_UNMGD ioctl
+ *
+ * @address_space: Address space in the DSA; currently only 0 is suported
+ * @pad:	   Unused
+ * @paddr:	   Physical address in the specified address space
+ * @size:	   Length of data to write
+ * @data_ptr:	   User's pointer to read the data from
+ */
+struct drm_xocl_pwrite_unmgd {
+	uint32_t address_space;
+	uint32_t pad;
+	uint64_t paddr;
+	uint64_t size;
+	uint64_t data_ptr;
+};
+
+/**
+ * struct drm_xocl_pread_unmgd - unprotected read from device memory
+ * used with DRM_IOCTL_XOCL_PREAD_UNMGD ioctl
+ *
+ * @address_space: Address space in the DSA; currently only 0 is valid
+ * @pad:	   Unused
+ * @paddr:	   Physical address in the specified address space
+ * @size:	   Length of data to write
+ * @data_ptr:	   User's pointer to write the data to
+ */
+struct drm_xocl_pread_unmgd {
+	uint32_t address_space;
+	uint32_t pad;
+	uint64_t paddr;
+	uint64_t size;
+	uint64_t data_ptr;
+};
+
+
+struct drm_xocl_mm_stat {
+	size_t memory_usage;
+	unsigned int bo_count;
+};
+
+/**
+ * struct drm_xocl_stats - obtain device memory usage and DMA statistics
+ * used with DRM_IOCTL_XOCL_USAGE_STAT ioctl
+ *
+ * @dma_channel_count: How many DMA channels are present
+ * @mm_channel_count:  How many storage banks (DDR) are present
+ * @h2c:	       Total data transferred from host to device by a DMA channel
+ * @c2h:	       Total data transferred from device to host by a DMA channel
+ * @mm:	               BO statistics for a storage bank (DDR)
+ */
+struct drm_xocl_usage_stat {
+	unsigned int dma_channel_count;
+	unsigned int mm_channel_count;
+	uint64_t h2c[8];
+	uint64_t c2h[8];
+	struct drm_xocl_mm_stat mm[8];
+};
+
+enum drm_xocl_debug_code {
+	DRM_XOCL_DEBUG_ACQUIRE_CU = 0,
+	DRM_XOCL_DEBUG_RELEASE_CU,
+	DRM_XOCL_DEBUG_NIFD_RD,
+	DRM_XOCL_DEBUG_NIFD_WR,
+};
+
+struct drm_xocl_debug {
+	uint32_t ctx_id;
+	enum drm_xocl_debug_code code;
+	unsigned int code_size;
+	uint64_t code_ptr;
+};
+
+enum drm_xocl_execbuf_state {
+	DRM_XOCL_EXECBUF_STATE_COMPLETE = 0,
+	DRM_XOCL_EXECBUF_STATE_RUNNING,
+	DRM_XOCL_EXECBUF_STATE_SUBMITTED,
+	DRM_XOCL_EXECBUF_STATE_QUEUED,
+	DRM_XOCL_EXECBUF_STATE_ERROR,
+	DRM_XOCL_EXECBUF_STATE_ABORT,
+};
+
+
+/**
+ * struct drm_xocl_execbuf - Submit a command buffer for execution on a compute unit
+ * used with DRM_IOCTL_XOCL_EXECBUF ioctl
+ *
+ * @ctx_id:         Pass 0
+ * @exec_bo_handle: BO handle of command buffer formatted as ERT command
+ * @deps:	    Upto 8 dependency command BO handles this command is dependent on
+ *                  for automatic event dependency handling by ERT
+ */
+struct drm_xocl_execbuf {
+	uint32_t ctx_id;
+	uint32_t exec_bo_handle;
+	uint32_t deps[8];
+};
+
+/**
+ * struct drm_xocl_user_intr - Register user's eventfd for MSIX interrupt
+ * used with DRM_IOCTL_XOCL_USER_INTR ioctl
+ *
+ * @ctx_id:        Pass 0
+ * @fd:	           File descriptor created with eventfd system call
+ * @msix:	   User interrupt number (0 to 15)
+ */
+struct drm_xocl_user_intr {
+	uint32_t ctx_id;
+	int fd;
+	int msix;
+};
+
+struct drm_xocl_reclock_info {
+	unsigned int region;
+	unsigned short ocl_target_freq[DRM_XOCL_NUM_SUPPORTED_CLOCKS];
+};
+
+/*
+ * Core ioctls numbers
+ */
+
+#define DRM_IOCTL_XOCL_CREATE_BO      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_CREATE_BO, struct drm_xocl_create_bo)
+#define DRM_IOCTL_XOCL_USERPTR_BO     DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_USERPTR_BO, struct drm_xocl_userptr_bo)
+#define DRM_IOCTL_XOCL_MAP_BO	      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_MAP_BO, struct drm_xocl_map_bo)
+#define DRM_IOCTL_XOCL_SYNC_BO	      DRM_IOW(DRM_COMMAND_BASE +       \
+					       DRM_XOCL_SYNC_BO, struct drm_xocl_sync_bo)
+#define DRM_IOCTL_XOCL_COPY_BO	      DRM_IOW(DRM_COMMAND_BASE +       \
+					       DRM_XOCL_COPY_BO, struct drm_xocl_copy_bo)
+#define DRM_IOCTL_XOCL_INFO_BO	      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_INFO_BO, struct drm_xocl_info_bo)
+#define DRM_IOCTL_XOCL_PWRITE_BO      DRM_IOW(DRM_COMMAND_BASE +       \
+					      DRM_XOCL_PWRITE_BO, struct drm_xocl_pwrite_bo)
+#define DRM_IOCTL_XOCL_PREAD_BO	      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_PREAD_BO, struct drm_xocl_pread_bo)
+#define DRM_IOCTL_XOCL_CTX	      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_CTX, struct drm_xocl_ctx)
+#define DRM_IOCTL_XOCL_INFO	      DRM_IOR(DRM_COMMAND_BASE +	\
+					      DRM_XOCL_INFO, struct drm_xocl_info)
+#define DRM_IOCTL_XOCL_READ_AXLF      DRM_IOW(DRM_COMMAND_BASE +	\
+					      DRM_XOCL_READ_AXLF, struct drm_xocl_axlf)
+#define DRM_IOCTL_XOCL_PWRITE_UNMGD   DRM_IOW(DRM_COMMAND_BASE +	\
+					      DRM_XOCL_PWRITE_UNMGD, struct drm_xocl_pwrite_unmgd)
+#define DRM_IOCTL_XOCL_PREAD_UNMGD    DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_PREAD_UNMGD, struct drm_xocl_pread_unmgd)
+#define DRM_IOCTL_XOCL_USAGE_STAT     DRM_IOR(DRM_COMMAND_BASE +	\
+					      DRM_XOCL_USAGE_STAT, struct drm_xocl_usage_stat)
+#define DRM_IOCTL_XOCL_DEBUG	      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_DEBUG, struct drm_xocl_debug)
+#define DRM_IOCTL_XOCL_EXECBUF	      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_EXECBUF, struct drm_xocl_execbuf)
+#define DRM_IOCTL_XOCL_USER_INTR      DRM_IOWR(DRM_COMMAND_BASE +	\
+					       DRM_XOCL_USER_INTR, struct drm_xocl_user_intr)
+#define DRM_IOCTL_XOCL_HOT_RESET      DRM_IO(DRM_COMMAND_BASE +	DRM_XOCL_HOT_RESET)
+#define DRM_IOCTL_XOCL_RECLOCK	      DRM_IOWR(DRM_COMMAND_BASE + \
+					    DRM_XOCL_RECLOCK, struct drm_xocl_reclock_info)
+#endif
-- 
2.17.0

