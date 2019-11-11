Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA70C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66F421783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKKOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:35:34 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48836 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbfKKOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:35:34 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Nov 2019 16:35:28 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id xABEZRxg019168;
        Mon, 11 Nov 2019 09:35:27 -0500
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id xABEZR9C019810;
        Mon, 11 Nov 2019 09:35:27 -0500
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     lsun@mellanox.com, Shravan Kumar Ramani <sramani@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Date:   Mon, 11 Nov 2019 09:34:39 -0500
Message-Id: <a28dc896a131bf9c8c21eb6b06371ca7aacaae52.1573460910.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1573460910.git.sramani@mellanox.com>
References: <cover.1573460910.git.sramani@mellanox.com>
In-Reply-To: <cover.1573460910.git.sramani@mellanox.com>
References: <cover.1573460910.git.sramani@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Support for Mellanox BlueField TRIO PCIe host controller.

Reviewed-by: Liming Sun <lsun@mellanox.com>
Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
---
 MAINTAINERS                            |   5 +
 drivers/platform/mellanox/Kconfig      |   8 +
 drivers/platform/mellanox/Makefile     |   1 +
 drivers/platform/mellanox/mlxbf-trio.c | 624 +++++++++++++++++++++++++++++++++
 4 files changed, 638 insertions(+)
 create mode 100644 drivers/platform/mellanox/mlxbf-trio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad..123ad78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10501,6 +10501,11 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/x86/mlx-platform.c
 
+MELLANOX BLUEFIELD TRIO DRIVER
+M:	Shravan Kumar Ramani <sramani@mellanox.com>
+S:	Supported
+F:	drivers/platform/mellanox/mlxbf-trio.c
+
 MEMBARRIER SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index 530fe7e..f962015 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -44,4 +44,12 @@ config MLXBF_TMFIFO
           platform driver support for the TmFifo which supports console
           and networking based on the virtio framework.
 
+config MLXBF_TRIO
+	tristate "Mellanox BlueField SoC TRIO driver"
+	depends on ARM64
+	depends on ACPI
+	help
+	  Say y here to enable TRIO driver. This driver provides platform
+	  driver support for the TRIO PCIe Host Controller.
+
 endif # MELLANOX_PLATFORM
diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
index a229bda1..37bbd56 100644
--- a/drivers/platform/mellanox/Makefile
+++ b/drivers/platform/mellanox/Makefile
@@ -4,5 +4,6 @@
 # Mellanox Platform-Specific Drivers
 #
 obj-$(CONFIG_MLXBF_TMFIFO)	+= mlxbf-tmfifo.o
+obj-$(CONFIG_MLXBF_TRIO)	+= mlxbf-trio.o
 obj-$(CONFIG_MLXREG_HOTPLUG)	+= mlxreg-hotplug.o
 obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
diff --git a/drivers/platform/mellanox/mlxbf-trio.c b/drivers/platform/mellanox/mlxbf-trio.c
new file mode 100644
index 0000000..1dfcc28
--- /dev/null
+++ b/drivers/platform/mellanox/mlxbf-trio.c
@@ -0,0 +1,624 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+#include <uapi/linux/psci.h>
+
+#define DRIVER_NAME		"mlxbf-trio"
+#define DRIVER_DESCRIPTION	"Mellanox TRIO PCIe host controller driver"
+
+/* SMC return codes */
+#define SMCCC_ACCESS_VIOLATION (-4)
+
+/* SMC function identifiers */
+#define MLNX_WRITE_REG_64		(0x8200000B)
+#define MLNX_READ_REG_64		(0x8200000C)
+#define MLNX_SIP_SVC_UID		(0x8200ff01)
+#define MLNX_SIP_SVC_VERSION		(0x8200ff03)
+
+#define MLNX_TRIO_SVC_REQ_MAJOR 0
+#define MLNX_TRIO_SVC_MIN_MINOR 4
+
+#define TRIO_NUM_IRQS 17
+#define L3C_PROF_RD_MISS__LENGTH 0x0040
+#define L3C_PROF_RD_MISS__STRIDE 0x0004
+#define L3_PROFILE_NUM	(L3C_PROF_RD_MISS__LENGTH / L3C_PROF_RD_MISS__STRIDE)
+
+/* The PUSH_DMA_EVT_CTR wrapped. */
+#define TRIO_PUSH_DMA_EVT_CTR_INT_BIT 10
+
+/* The MAP_EVT_CTR wrapped. */
+#define TRIO_MAP_EVT_CTR_INT_BIT 11
+
+#define TRIO_DEV_CTL 0x0008
+#define TRIO_DEV_CTL__L3_PROFILE_OVD_SHIFT 4
+#define TRIO_DEV_CTL__L3_PROFILE_OVD_MASK  0x10
+#define TRIO_DEV_CTL__L3_PROFILE_VAL_SHIFT 5
+#define TRIO_DEV_CTL__L3_PROFILE_VAL_MASK  0x1e0
+
+#define TRIO_MMIO_ERROR_INFO 0x0608
+
+#define TRIO_MAP_ERR_STS 0x0810
+
+#define TRIO_TILE_PIO_CPL_ERR_STS 0x09f0
+
+enum trio_int_events {
+	TRIO_MAC_INT = 0,
+	TRIO_RSH_FULL_ERR_INT,
+	TRIO_MSG_Q_FULL_ERR_INT,
+	TRIO_MSG_Q_ARRIVED_INT,
+	TRIO_MMIO_ERR_INT,
+	TRIO_MAP_UNCLAIMED_INT,
+	TRIO_RSH_SIZE_ERR_INT,
+	TRIO_PIO_ECAM_ERR_INT,
+	TRIO_PIO_CPL_ERR_INT,
+	TRIO_MMIO_PROT_ERR_INT,
+	TRIO_PUSH_DMA_EVT_CTR_INT,
+	TRIO_MAP_EVT_CTR_INT,
+	TRIO_PIO_DISABLED_INT,
+	TRIO_REM_MMIO_ERR_INT,
+	TRIO_ERR_MSG_COR_INT,
+	TRIO_ERR_MSG_NONFATAL_INT,
+	TRIO_ERR_MSG_FATAL_INT,
+};
+
+struct trio_event_info {
+	const char *name;
+	int additional_info;
+};
+
+static const struct trio_event_info trio_events[TRIO_NUM_IRQS] = {
+	[TRIO_MAC_INT] = {
+		.name = "MAC Interrupt",
+		.additional_info = -1,
+	},
+	[TRIO_RSH_FULL_ERR_INT] = {
+		.name = "RShim Full Error",
+		.additional_info = -1,
+	},
+	[TRIO_MSG_Q_FULL_ERR_INT] = {
+		.name = "Msg Queue Full Error",
+		.additional_info = -1,
+	},
+	[TRIO_MSG_Q_ARRIVED_INT] = {
+		.name = "Msg Arrived Interrupt",
+		.additional_info = -1,
+	},
+	[TRIO_MMIO_ERR_INT] = {
+		.name = "MMIO Error",
+		.additional_info = TRIO_MMIO_ERROR_INFO,
+	},
+	[TRIO_MAP_UNCLAIMED_INT] = {
+		.name = "Packet Unclaimed Error",
+		.additional_info = TRIO_MAP_ERR_STS,
+	},
+	[TRIO_RSH_SIZE_ERR_INT] = {
+		.name = "RShim Size Error",
+		.additional_info = -1,
+	},
+	[TRIO_PIO_ECAM_ERR_INT] = {
+		.name = "PIO ECAM Error",
+		.additional_info = -1,
+	},
+	[TRIO_PIO_CPL_ERR_INT] = {
+		.name = "PIO Completion Error",
+		.additional_info = TRIO_TILE_PIO_CPL_ERR_STS,
+	},
+	[TRIO_MMIO_PROT_ERR_INT] = {
+		.name = "MMIO Protection level Violation",
+		.additional_info = -1,
+	},
+	[TRIO_PUSH_DMA_EVT_CTR_INT] = {
+		.name = "PUSH_DMA_CTR wrapped",
+		.additional_info = -1,
+	},
+	[TRIO_MAP_EVT_CTR_INT] = {
+		.name = "MAP_EVT_CTR wrapped",
+		.additional_info = -1,
+	},
+	[TRIO_PIO_DISABLED_INT] = {
+		.name = "Access to disabled PIO region",
+		.additional_info = -1,
+	},
+	[TRIO_REM_MMIO_ERR_INT] = {
+		.name = "Remote Buffer MMIO Error",
+		.additional_info = -1,
+	},
+	[TRIO_ERR_MSG_COR_INT] = {
+		.name = "Correctable error message received",
+		.additional_info = -1,
+	},
+	[TRIO_ERR_MSG_NONFATAL_INT] = {
+		.name = "Nonfatal error message received",
+		.additional_info = -1,
+	},
+	[TRIO_ERR_MSG_FATAL_INT] = {
+		.name = "Fatal error message received",
+		.additional_info = -1,
+	},
+};
+
+enum l3_profile_type {
+	LRU_PROFILE = 0,	/* 0 is the default behavior. */
+	NVME_PROFILE,
+	L3_PROFILE_TYPE_NUM,
+};
+
+static const char * const l3_profiles[L3_PROFILE_TYPE_NUM] = {
+	[LRU_PROFILE] = "Strict_LRU",
+	[NVME_PROFILE] = "NVMeOF_suitable"
+};
+
+/*
+ * The default profile each L3 profile would get.
+ * The current setting would make profile 1 the NVMe suitable profile
+ * and the rest of the profiles LRU profile.
+ * Note that profile 0 should be configured as LRU as this is the
+ * default profile.
+ */
+static const enum l3_profile_type default_profile[L3_PROFILE_NUM] = {
+	[1] = NVME_PROFILE,
+};
+
+struct event_context {
+	int event_num;
+	int irq;
+	struct trio_context *trio;
+};
+
+/**
+ * trio_context - Structure for TRIO block info
+ * @pdev: kenrel struct representing the device
+ * @events: argument to be passed to the IRQ handler
+ * @mmio_base: Reg base addr
+ * @trio_index: Index of TRIO
+ * @bus: Name of the bus this TRIO corresponds to
+ * @trio_pci: PCI device this TRIO corresponds to
+ * @num_irqs: Number of platform_irqs for this device
+ * @sreg_use_smcs: Access regs with SMCs if true, else memory mapped
+ * @sreg_trio_tbl: Verification table for TRIO
+ */
+struct trio_context {
+	struct platform_device	*pdev;
+	struct event_context *events;
+	void __iomem *mmio_base;
+	int trio_index;
+	const char *bus;
+	struct pci_dev *trio_pci;
+	u32 num_irqs;
+	bool sreg_use_smcs;
+	u32 sreg_trio_tbl;
+};
+
+static int secure_writeq(struct trio_context *trio, uint64_t value,
+			 void __iomem *addr)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLNX_WRITE_REG_64, trio->sreg_trio_tbl, value,
+		      (uintptr_t)addr, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	/*
+	 * Note: PSCI_RET_NOT_SUPPORTED is used here to maintain compatibility
+	 * with older kernels that do not have SMCCC_RET_NOT_SUPPORTED
+	 */
+	case PSCI_RET_NOT_SUPPORTED:
+		dev_err(&trio->pdev->dev, "Required SMC unsupported\n");
+		return -EFAULT;
+	case SMCCC_ACCESS_VIOLATION:
+		dev_err(&trio->pdev->dev, "SMC access violation\n");
+		return -EFAULT;
+	default:
+		return 0;
+	}
+}
+
+static int trio_writeq(struct trio_context *trio, uint64_t value,
+		       void __iomem *addr)
+{
+	int ret = 0;
+
+	if (trio->sreg_use_smcs)
+		ret = secure_writeq(trio, value, addr);
+	else
+		writeq(value, addr);
+
+	return ret;
+}
+
+static int secure_readq(struct trio_context *trio, void __iomem *addr,
+			uint64_t *result)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLNX_READ_REG_64, trio->sreg_trio_tbl, (uintptr_t)addr,
+		      0, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	/*
+	 * Note: PSCI_RET_NOT_SUPPORTED is used here to maintain compatibility
+	 * with older kernels that do not have SMCCC_RET_NOT_SUPPORTED
+	 */
+	case PSCI_RET_NOT_SUPPORTED:
+		dev_err(&trio->pdev->dev, "Required SMC unsupported\n");
+		return -EFAULT;
+	case SMCCC_ACCESS_VIOLATION:
+		dev_err(&trio->pdev->dev, "SMC access violation\n");
+		return -EFAULT;
+	default:
+		*result = (uint64_t)res.a1;
+		return 0;
+	}
+}
+
+static int trio_readq(struct trio_context *trio, void __iomem *addr,
+		      uint64_t *result)
+{
+	int ret = 0;
+
+	if (trio->sreg_use_smcs)
+		ret = secure_readq(trio, addr, result);
+	else
+		*result = readq(addr);
+
+	return ret;
+}
+
+static irqreturn_t trio_irq_handler(int irq, void *arg)
+{
+	struct event_context *ctx = (struct event_context *)arg;
+	struct trio_context *trio = ctx->trio;
+	u64 info;
+
+	dev_err(&trio->pdev->dev,
+		"mlx_trio: TRIO %d received IRQ %d event %d (%s)\n",
+		trio->trio_index, irq, ctx->event_num,
+		trio_events[ctx->event_num].name);
+
+	if (trio_events[ctx->event_num].additional_info != -1) {
+		trio_readq(trio, trio->mmio_base +
+				trio_events[ctx->event_num].additional_info,
+				&info);
+		dev_err(&trio->pdev->dev,
+			"mlx_trio: Addition IRQ info: %llx\n", info);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t current_profile_show(struct device *dev,
+				    struct device_attribute *attr,
+				     char *buf)
+{
+	struct platform_device *pdev;
+	struct trio_context *trio;
+	int profile_num;
+	u64 tdc;
+
+	pdev = to_platform_device(dev);
+	trio = platform_get_drvdata(pdev);
+
+	if (trio_readq(trio, trio->mmio_base + TRIO_DEV_CTL, &tdc))
+		return -EIO;
+
+	if (((tdc & TRIO_DEV_CTL__L3_PROFILE_OVD_MASK) >>
+		TRIO_DEV_CTL__L3_PROFILE_OVD_SHIFT) == 0)
+		profile_num = -1;
+	else
+		profile_num = (tdc & TRIO_DEV_CTL__L3_PROFILE_VAL_MASK) >>
+				TRIO_DEV_CTL__L3_PROFILE_VAL_SHIFT;
+
+	return sprintf(buf, "%d\n", profile_num);
+}
+
+static int set_l3cache_profile(struct trio_context *trio, long profile_num)
+{
+	u64 tdc;
+
+	if (trio_readq(trio, trio->mmio_base + TRIO_DEV_CTL, &tdc))
+		return -EIO;
+
+	if (profile_num == -1) {
+		dev_info(&trio->pdev->dev, "Unlink %s profile\n", trio->bus);
+
+		tdc |= (0 << TRIO_DEV_CTL__L3_PROFILE_OVD_SHIFT);
+	} else if (profile_num < L3_PROFILE_NUM && profile_num >= 0) {
+		dev_info(&trio->pdev->dev, "Change %s to profile %ld\n",
+			 trio->bus, profile_num);
+
+		tdc |= (1 << TRIO_DEV_CTL__L3_PROFILE_OVD_SHIFT);
+		tdc |= (profile_num << TRIO_DEV_CTL__L3_PROFILE_VAL_SHIFT);
+	} else {
+		dev_err(&trio->pdev->dev, "Profile number out of range.");
+		return -EINVAL;
+	}
+
+	if (trio_writeq(trio, tdc, trio->mmio_base + TRIO_DEV_CTL))
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t current_profile_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trio_context *trio;
+	long profile_num;
+	int err;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	trio = platform_get_drvdata(pdev);
+
+	err = kstrtol(buf, 10, &profile_num);
+	if (err)
+		return err;
+
+	err = set_l3cache_profile(trio, profile_num);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(current_profile);
+
+static ssize_t available_profiles_show(struct device *dev,
+				       struct device_attribute *attr,
+				     char *buf)
+{
+	ssize_t line_size;
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < L3_PROFILE_NUM; i++) {
+		line_size = sprintf(buf, "%d %s\n", i,
+				    l3_profiles[default_profile[i]]);
+		buf += line_size;
+		len += line_size;
+	}
+	return len;
+}
+
+static DEVICE_ATTR_RO(available_profiles);
+
+static int trio_probe(struct platform_device *pdev)
+{
+	int trio_bus, trio_device, trio_function;
+	struct device *dev = &pdev->dev;
+	struct arm_smccc_res smc_res;
+	int i, j, ret, irq, dri_ret;
+	struct trio_context *trio;
+	struct event_context *ctx;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_warn(dev, "%s: failed to find reg resource 0\n", __func__);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	trio = devm_kzalloc(dev, sizeof(struct trio_context), GFP_KERNEL);
+	if (!trio) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, trio);
+	trio->pdev = pdev;
+
+	/* Determine whether to use SMCs or not. */
+	if (device_property_read_u32(&pdev->dev, "sec_reg_block",
+				     &trio->sreg_trio_tbl)) {
+		trio->sreg_use_smcs = false;
+	} else {
+		/*
+		 * Ensure we have the UUID we expect for the Mellanox service.
+		 */
+		arm_smccc_smc(MLNX_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &smc_res);
+		if (smc_res.a0 != 0x89c036b4 || smc_res.a1 != 0x11e6e7d7 ||
+		    smc_res.a2 != 0x1a009787 || smc_res.a3 != 0xc4bf00ca) {
+			dev_err(&pdev->dev,
+				"Mellanox SMC service not available\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * Check service version to see if we actually do support the
+		 * needed SMCs. If we have the calls we need, mark support for
+		 * them in the trio struct.
+		 */
+		arm_smccc_smc(MLNX_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0,
+			      &smc_res);
+		if (smc_res.a0 == MLNX_TRIO_SVC_REQ_MAJOR &&
+		    smc_res.a1 >= MLNX_TRIO_SVC_MIN_MINOR) {
+			trio->sreg_use_smcs = true;
+		} else {
+			dev_err(&pdev->dev,
+				"Required SMCs are not supported.\n");
+
+			return -EINVAL;
+		}
+	}
+
+	if (device_property_read_string(dev, "bus_number", &trio->bus)) {
+		dev_warn(dev, "%s: failed to retrieve Trio bus name\n",
+			 __func__);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (device_property_read_u32(dev, "num_irqs", &trio->num_irqs))
+		trio->num_irqs = TRIO_NUM_IRQS;
+
+	trio->events = devm_kzalloc(dev, sizeof(struct event_context) *
+				    trio->num_irqs,
+				    GFP_KERNEL);
+	if (!trio->events) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* Map registers */
+	if (!trio->sreg_use_smcs) {
+		trio->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+
+		if (IS_ERR(trio->mmio_base)) {
+			dev_warn(dev, "%s: ioremap failed for mmio_base %llx err %p\n",
+				 __func__, res->start, trio->mmio_base);
+			ret = PTR_ERR(trio->mmio_base);
+			goto err;
+		}
+	} else {
+		trio->mmio_base = (void __iomem *)res->start;
+	}
+
+	for (i = 0; i < trio->num_irqs; ++i) {
+		ctx = &trio->events[i];
+
+		switch (i) {
+		case TRIO_PUSH_DMA_EVT_CTR_INT_BIT:
+		case TRIO_MAP_EVT_CTR_INT_BIT:
+			/*
+			 * These events are not errors, they just indicate
+			 * that a performance counter wrapped.  We may want
+			 * the performance counter driver to register for them.
+			 */
+			continue;
+		default:
+			break;
+		}
+
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			dev_warn(dev, "%s: failed to get plat irq %d ret %d\n",
+				 __func__, i, irq);
+			for (j = i - 1; j >= 0; j--) {
+				ctx = &trio->events[j];
+				devm_free_irq(&pdev->dev, ctx->irq, ctx);
+			}
+			ret = -ENXIO;
+			goto err;
+		}
+		ctx->event_num = i;
+		ctx->trio = trio;
+		ctx->irq = irq;
+		dri_ret = devm_request_irq(&pdev->dev, irq, trio_irq_handler, 0,
+					   dev_name(dev), ctx);
+
+		dev_dbg(dev, "%s: request_irq returns %d %d->%d\n", __func__,
+			dri_ret, i, irq);
+	}
+
+	/* Create the L3 cache profile on this device */
+	device_create_file(dev, &dev_attr_current_profile);
+	device_create_file(dev, &dev_attr_available_profiles);
+
+	/*
+	 * Get the corresponding PCI device this trio maps to.
+	 * If the bus number can't be read properly, no symlinks are created.
+	 */
+	if (sscanf(trio->bus, "%d:%d.%d", &trio_bus, &trio_device,
+		   &trio_function) != 3) {
+		dev_warn(dev, "Device [%s] not valid\n", trio->bus);
+		return 0;
+	}
+
+	/* trio_device is also the index of the TRIO */
+	trio->trio_index = trio_device;
+
+	/* The PCI domain/segment would always be 0 here. */
+	trio->trio_pci =
+		pci_get_domain_bus_and_slot(0, trio_bus,
+					    (trio_device << 3) + trio_function);
+
+	/* Add the symlink from the TRIO to the PCI device */
+	if (trio->trio_pci) {
+		if (sysfs_create_link(&dev->kobj, &trio->trio_pci->dev.kobj,
+				      "pcie_slot")) {
+			pci_dev_put(trio->trio_pci);
+			trio->trio_pci = NULL;
+			dev_warn(dev, "Failed to create symblink for %s\n",
+				 trio->bus);
+		}
+	} else {
+		dev_warn(dev, "Device %s not found\n", trio->bus);
+	}
+
+	dev_info(dev, " probed\n");
+	return 0;
+err:
+	dev_warn(dev, "Error probing trio\n");
+	platform_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static int trio_remove(struct platform_device *pdev)
+{
+	struct trio_context *trio = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int i;
+
+	for (i = 0; i < trio->num_irqs; ++i) {
+		struct event_context *ctx = &trio->events[i];
+
+		if (ctx->irq)
+			devm_free_irq(&pdev->dev, ctx->irq, ctx);
+	}
+	device_remove_file(dev, &dev_attr_current_profile);
+	device_remove_file(dev, &dev_attr_available_profiles);
+
+	/* Delete the symlink and decrement the reference count. */
+	if (trio->trio_pci) {
+		sysfs_remove_link(&dev->kobj, "pcie_slot");
+		pci_dev_put(trio->trio_pci);
+	}
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct acpi_device_id trio_acpi_ids[] = {
+	{"MLNXBF06", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, trio_acpi_ids);
+static struct platform_driver mlx_trio_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.acpi_match_table = ACPI_PTR(trio_acpi_ids),
+	},
+	.probe = trio_probe,
+	.remove = trio_remove,
+};
+
+module_platform_driver(mlx_trio_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL");
-- 
2.1.2

