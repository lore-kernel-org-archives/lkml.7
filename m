Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03DF20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfCDVhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:37:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbfCDVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:37:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24LWK3x039357
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 16:37:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r1a9x47r7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:37:12 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 4 Mar 2019 21:37:12 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 21:37:08 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24Lb78H29491344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 21:37:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81DA8136051;
        Mon,  4 Mar 2019 21:37:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0FA113604F;
        Mon,  4 Mar 2019 21:37:06 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 21:37:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        jk@ozlabs.org, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/6] drivers/misc: Add Aspeed XDMA engine driver
Date:   Mon,  4 Mar 2019 15:36:56 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19030421-8235-0000-0000-00000E683BB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010705; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01169658; UDB=6.00611233; IPR=6.00950286;
 MB=3.00025831; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-04 21:37:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030421-8236-0000-0000-000044AD3154
Message-Id: <1551735420-16202-3-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

This commit adds a driver to control the XDMA engine and adds functions
to initialize the hardware and memory and start DMA operations.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 MAINTAINERS                      |   9 +
 drivers/misc/Kconfig             |   8 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/aspeed-xdma.c       | 461 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h |  26 +++
 5 files changed, 505 insertions(+)
 create mode 100644 drivers/misc/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e64279..8428f84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2521,6 +2521,15 @@ S:	Maintained
 F:	drivers/media/platform/aspeed-video.c
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 
+ASPEED XDMA ENGINE DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/aspeed,xdma.txt
+F:	drivers/misc/aspeed-xdma.c
+F:	include/uapi/linux/aspeed-xdma.h
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user@lists.sourceforge.net
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec..8316f80 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -512,6 +512,14 @@ config ASPEED_LPC_SNOOP
 	  allows the BMC to listen on and save the data written by
 	  the host to an arbitrary LPC I/O port.
 
+config ASPEED_XDMA
+	tristate "Aspeed XDMA Engine Driver"
+	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON && HAS_DMA
+	help
+	  Enable support for the Aspeed XDMA Engine found on the Aspeed AST2500
+	  SOC. The XDMA engine can perform automatic PCI DMA operations between
+	  the AST2500 (acting as a BMC) and a host processor.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d5b7d34..969a680 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
+obj-$(CONFIG_ASPEED_XDMA)	+= aspeed-xdma.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
diff --git a/drivers/misc/aspeed-xdma.c b/drivers/misc/aspeed-xdma.c
new file mode 100644
index 0000000..970ea92
--- /dev/null
+++ b/drivers/misc/aspeed-xdma.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
+
+#include <linux/aspeed-xdma.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/mfd/syscon.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+#define DEVICE_NAME			"aspeed-xdma"
+
+#define SCU_STRAP			0x070
+#define  SCU_STRAP_VGA_MEM		GENMASK(3, 2)
+
+#define SCU_PCIE_CONF			0x180
+#define  SCU_PCIE_CONF_VGA_EN		BIT(0)
+#define  SCU_PCIE_CONF_VGA_EN_MMIO	BIT(1)
+#define  SCU_PCIE_CONF_VGA_EN_LPC	BIT(2)
+#define  SCU_PCIE_CONF_VGA_EN_MSI	BIT(3)
+#define  SCU_PCIE_CONF_VGA_EN_MCTP	BIT(4)
+#define  SCU_PCIE_CONF_VGA_EN_IRQ	BIT(5)
+#define  SCU_PCIE_CONF_VGA_EN_DMA	BIT(6)
+#define  SCU_PCIE_CONF_BMC_EN		BIT(8)
+#define  SCU_PCIE_CONF_BMC_EN_MMIO	BIT(9)
+#define  SCU_PCIE_CONF_BMC_EN_MSI	BIT(11)
+#define  SCU_PCIE_CONF_BMC_EN_MCTP	BIT(12)
+#define  SCU_PCIE_CONF_BMC_EN_IRQ	BIT(13)
+#define  SCU_PCIE_CONF_BMC_EN_DMA	BIT(14)
+#define  SCU_PCIE_CONF_RSVD		GENMASK(19, 18)
+
+#define SDMC_CONF			0x004
+#define  SDMC_CONF_MEM			GENMASK(1, 0)
+#define SDMC_REMAP			0x008
+#define  SDMC_REMAP_MAGIC		GENMASK(17, 16)
+
+#define XDMA_CMD_SIZE			4
+#define XDMA_CMDQ_SIZE			PAGE_SIZE
+#define XDMA_BYTE_ALIGN			16
+#define XDMA_MAX_LINE_SIZE		BIT(10)
+#define XDMA_NUM_CMDS			\
+	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
+#define XDMA_NUM_DEBUGFS_REGS		6
+
+#define XDMA_CMD_BMC_CHECK		BIT(0)
+#define XDMA_CMD_BMC_ADDR		GENMASK(29, 4)
+#define XDMA_CMD_BMC_DIR_US		BIT(31)
+
+#define XDMA_CMD_COMM1_HI_HOST_PITCH	GENMASK(14, 3)
+#define XDMA_CMD_COMM1_HI_BMC_PITCH	GENMASK(30, 19)
+
+#define XDMA_CMD_CONF_CHECK		BIT(1)
+#define XDMA_CMD_CONF_LINE_SIZE		GENMASK(14, 4)
+#define XDMA_CMD_CONF_IRQ_BMC		BIT(15)
+#define XDMA_CMD_CONF_NUM_LINES		GENMASK(27, 16)
+#define XDMA_CMD_CONF_IRQ		BIT(31)
+
+#define XDMA_DS_PCIE_REQ_SIZE_128	0
+#define XDMA_DS_PCIE_REQ_SIZE_256	1
+#define XDMA_DS_PCIE_REQ_SIZE_512	2
+#define XDMA_DS_PCIE_REQ_SIZE_1K	3
+#define XDMA_DS_PCIE_REQ_SIZE_2K	4
+#define XDMA_DS_PCIE_REQ_SIZE_4K	5
+
+#define XDMA_BMC_CMD_QUEUE_ADDR		0x10
+#define XDMA_BMC_CMD_QUEUE_ENDP		0x14
+#define XDMA_BMC_CMD_QUEUE_WRITEP	0x18
+#define XDMA_BMC_CMD_QUEUE_READP	0x1c
+#define  XDMA_BMC_CMD_QUEUE_READP_MAGIC	0xee882266
+#define XDMA_CTRL			0x20
+#define  XDMA_CTRL_US_COMP		BIT(4)
+#define  XDMA_CTRL_DS_COMP		BIT(5)
+#define  XDMA_CTRL_DS_DIRTY		BIT(6)
+#define  XDMA_CTRL_DS_PCIE_REQ_SIZE	GENMASK(19, 17)
+#define  XDMA_CTRL_DS_DATA_TIMEOUT	BIT(28)
+#define  XDMA_CTRL_DS_CHECK_ID		BIT(29)
+#define XDMA_STATUS			0x24
+#define  XDMA_STATUS_US_COMP		BIT(4)
+#define  XDMA_STATUS_DS_COMP		BIT(5)
+
+enum {
+	XDMA_IN_PRG,
+	XDMA_UPSTREAM,
+};
+
+struct aspeed_xdma_cmd {
+	u32 host_addr_lo;
+	u32 host_addr_hi;
+	u32 bmc_addr;
+	u32 comm1_hi;
+	u32 conf;
+	u32 id;
+	u32 resv0;
+	u32 resv1;
+};
+
+struct aspeed_xdma_client;
+
+struct aspeed_xdma {
+	struct device *dev;
+	void __iomem *base;
+	struct regmap *scu;
+	struct reset_control *reset;
+
+	unsigned long flags;
+	unsigned int cmd_idx;
+	wait_queue_head_t wait;
+	struct aspeed_xdma_client *current_client;
+
+	u32 vga_phys;
+	u32 vga_size;
+	dma_addr_t vga_dma;
+	void *cmdq;
+	void *vga_virt;
+};
+
+struct aspeed_xdma_client {
+	struct aspeed_xdma *ctx;
+
+	unsigned long flags;
+	u32 phys;
+	u32 size;
+};
+
+static u32 aspeed_xdma_reg_read(struct aspeed_xdma *ctx, u32 reg)
+{
+	u32 v = readl(ctx->base + reg);
+
+	dev_dbg(ctx->dev, "read %02x[%08x]\n", reg, v);
+	return v;
+}
+
+static void aspeed_xdma_reg_write(struct aspeed_xdma *ctx, u32 reg, u32 val)
+{
+	writel(val, ctx->base + reg);
+	dev_dbg(ctx->dev, "write %02x[%08x]\n", reg, readl(ctx->base + reg));
+}
+
+static void aspeed_xdma_init_eng(struct aspeed_xdma *ctx)
+{
+	const u32 ctrl = XDMA_CTRL_US_COMP | XDMA_CTRL_DS_COMP |
+		XDMA_CTRL_DS_DIRTY | FIELD_PREP(XDMA_CTRL_DS_PCIE_REQ_SIZE,
+						XDMA_DS_PCIE_REQ_SIZE_256) |
+		XDMA_CTRL_DS_DATA_TIMEOUT | XDMA_CTRL_DS_CHECK_ID;
+
+	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_ENDP,
+			      XDMA_CMD_SIZE * XDMA_NUM_CMDS);
+	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_READP,
+			      XDMA_BMC_CMD_QUEUE_READP_MAGIC);
+	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_WRITEP, 0);
+	aspeed_xdma_reg_write(ctx, XDMA_CTRL, ctrl);
+
+	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_ADDR, ctx->vga_phys);
+
+	ctx->cmd_idx = 0;
+	ctx->flags = 0;
+}
+
+static void aspeed_xdma_reset(struct aspeed_xdma *ctx)
+{
+	reset_control_assert(ctx->reset);
+
+	msleep(10);
+
+	reset_control_deassert(ctx->reset);
+
+	msleep(10);
+
+	aspeed_xdma_init_eng(ctx);
+}
+
+static void aspeed_xdma_start(struct aspeed_xdma *ctx,
+			      struct aspeed_xdma_op *op, u32 bmc_addr)
+{
+	u32 conf = XDMA_CMD_CONF_CHECK | XDMA_CMD_CONF_IRQ_BMC |
+		XDMA_CMD_CONF_IRQ;
+	unsigned int line_size = op->len / XDMA_BYTE_ALIGN;
+	unsigned int num_lines = 1;
+	unsigned int nidx = (ctx->cmd_idx + 1) % XDMA_NUM_CMDS;
+	struct aspeed_xdma_cmd *cmd =
+		&(((struct aspeed_xdma_cmd *)ctx->cmdq)[ctx->cmd_idx]);
+
+	if (line_size > XDMA_MAX_LINE_SIZE) {
+		unsigned int rem;
+		unsigned int total;
+
+		num_lines = line_size / XDMA_MAX_LINE_SIZE;
+		total = XDMA_MAX_LINE_SIZE * num_lines;
+		rem = line_size - total;
+		line_size = XDMA_MAX_LINE_SIZE;
+
+		if (rem) {
+			unsigned int offs = total * XDMA_BYTE_ALIGN;
+			u32 r_bmc_addr = bmc_addr + offs;
+			u64 r_host_addr = op->host_addr + (u64)offs;
+			struct aspeed_xdma_cmd *r_cmd =
+				&(((struct aspeed_xdma_cmd *)ctx->cmdq)[nidx]);
+
+			r_cmd->host_addr_lo =
+				(u32)(r_host_addr & 0xFFFFFFFFULL);
+			r_cmd->host_addr_hi = (u32)(r_host_addr >> 32ULL);
+			r_cmd->bmc_addr = (r_bmc_addr & XDMA_CMD_BMC_ADDR) |
+				XDMA_CMD_BMC_CHECK |
+				(op->upstream ? XDMA_CMD_BMC_DIR_US : 0);
+			r_cmd->conf = conf |
+				FIELD_PREP(XDMA_CMD_CONF_LINE_SIZE, rem) |
+				FIELD_PREP(XDMA_CMD_CONF_NUM_LINES, 1);
+			r_cmd->comm1_hi =
+				FIELD_PREP(XDMA_CMD_COMM1_HI_HOST_PITCH, 1) |
+				FIELD_PREP(XDMA_CMD_COMM1_HI_BMC_PITCH, 1);
+
+			/* do not trigger IRQ for first command */
+			conf = XDMA_CMD_CONF_CHECK;
+
+			nidx = (nidx + 1) % XDMA_NUM_CMDS;
+		}
+
+		/* undocumented formula to get required number of lines */
+		num_lines = (num_lines * 2) - 1;
+	}
+
+	/* ctrl == 0 indicates engine hasn't started properly; restart it */
+	if (!aspeed_xdma_reg_read(ctx, XDMA_CTRL))
+		aspeed_xdma_reset(ctx);
+
+	cmd->host_addr_lo = (u32)(op->host_addr & 0xFFFFFFFFULL);
+	cmd->host_addr_hi = (u32)(op->host_addr >> 32ULL);
+	cmd->bmc_addr = (bmc_addr & XDMA_CMD_BMC_ADDR) | XDMA_CMD_BMC_CHECK |
+		(op->upstream ? XDMA_CMD_BMC_DIR_US : 0);
+	cmd->conf = conf |
+		FIELD_PREP(XDMA_CMD_CONF_LINE_SIZE, line_size) |
+		FIELD_PREP(XDMA_CMD_CONF_NUM_LINES, num_lines);
+	cmd->comm1_hi = FIELD_PREP(XDMA_CMD_COMM1_HI_HOST_PITCH, line_size) |
+			FIELD_PREP(XDMA_CMD_COMM1_HI_BMC_PITCH, line_size);
+
+	memcpy(ctx->vga_virt, ctx->cmdq, XDMA_CMDQ_SIZE);
+
+	if (op->upstream)
+		set_bit(XDMA_UPSTREAM, &ctx->flags);
+	else
+		clear_bit(XDMA_UPSTREAM, &ctx->flags);
+
+	set_bit(XDMA_IN_PRG, &ctx->flags);
+
+	aspeed_xdma_reg_write(ctx, XDMA_BMC_CMD_QUEUE_WRITEP,
+			      nidx * XDMA_CMD_SIZE);
+	ctx->cmd_idx = nidx;
+}
+
+static void aspeed_xdma_done(struct aspeed_xdma *ctx)
+{
+	if (ctx->current_client) {
+		clear_bit(XDMA_IN_PRG, &ctx->current_client->flags);
+
+		ctx->current_client = NULL;
+	}
+
+	clear_bit(XDMA_IN_PRG, &ctx->flags);
+	wake_up_interruptible_all(&ctx->wait);
+}
+
+static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
+{
+	struct aspeed_xdma *ctx = arg;
+	u32 status = aspeed_xdma_reg_read(ctx, XDMA_STATUS);
+
+	if (status & XDMA_STATUS_US_COMP) {
+		if (test_bit(XDMA_UPSTREAM, &ctx->flags))
+			aspeed_xdma_done(ctx);
+	}
+
+	if (status & XDMA_STATUS_DS_COMP) {
+		if (!test_bit(XDMA_UPSTREAM, &ctx->flags))
+			aspeed_xdma_done(ctx);
+	}
+
+	aspeed_xdma_reg_write(ctx, XDMA_STATUS, status);
+
+	return IRQ_HANDLED;
+}
+
+static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
+{
+	int rc;
+	u32 scu_conf = 0;
+	u32 mem_size = 0x20000000;
+	const u32 pcie_conf = SCU_PCIE_CONF_VGA_EN | SCU_PCIE_CONF_VGA_EN_MSI |
+		SCU_PCIE_CONF_VGA_EN_MCTP | SCU_PCIE_CONF_VGA_EN_IRQ |
+		SCU_PCIE_CONF_VGA_EN_DMA | SCU_PCIE_CONF_BMC_EN_MSI |
+		SCU_PCIE_CONF_BMC_EN_MCTP | SCU_PCIE_CONF_BMC_EN_IRQ |
+		SCU_PCIE_CONF_BMC_EN_DMA | SCU_PCIE_CONF_RSVD;
+	const u32 mem_sizes[4] = { 0x8000000, 0x10000000, 0x20000000,
+				   0x40000000 };
+	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
+	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
+
+	regmap_write(ctx->scu, SCU_PCIE_CONF, pcie_conf);
+
+	regmap_read(ctx->scu, SCU_STRAP, &scu_conf);
+	ctx->vga_size = vga_sizes[FIELD_GET(SCU_STRAP_VGA_MEM, scu_conf)];
+
+	if (sdmc_base) {
+		u32 sdmc = readl(sdmc_base + SDMC_CONF);
+		u32 remap = readl(sdmc_base + SDMC_REMAP);
+
+		remap |= SDMC_REMAP_MAGIC;
+		writel(remap, sdmc_base + SDMC_REMAP);
+		remap = readl(sdmc_base + SDMC_REMAP);
+
+		mem_size = mem_sizes[sdmc & SDMC_CONF_MEM];
+		iounmap(sdmc_base);
+	}
+
+	ctx->vga_phys = (mem_size - ctx->vga_size) + 0x80000000;
+
+	ctx->cmdq = devm_kzalloc(ctx->dev, XDMA_CMDQ_SIZE, GFP_KERNEL);
+	if (!ctx->cmdq) {
+		dev_err(ctx->dev, "Failed to allocate command queue.\n");
+		return -ENOMEM;
+	}
+
+	rc = dma_set_mask_and_coherent(ctx->dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(ctx->dev, "Failed to set DMA mask: %d.\n", rc);
+		return rc;
+	}
+
+	rc = dma_declare_coherent_memory(ctx->dev, ctx->vga_phys,
+					 ctx->vga_phys, ctx->vga_size);
+	if (rc) {
+		dev_err(ctx->dev, "Failed to declare coherent memory: %d.\n",
+			rc);
+		return rc;
+	}
+
+	ctx->vga_virt = dma_alloc_coherent(ctx->dev, ctx->vga_size,
+					   &ctx->vga_dma, GFP_KERNEL);
+	if (!ctx->vga_virt) {
+		dev_err(ctx->dev, "Failed to allocate DMA.\n");
+		dma_release_declared_memory(ctx->dev);
+		return -ENOMEM;
+	}
+
+	dev_dbg(ctx->dev, "VGA mapped at phys[%08x], size[%08x].\n",
+		ctx->vga_phys, ctx->vga_size);
+
+	return 0;
+}
+
+static int aspeed_xdma_probe(struct platform_device *pdev)
+{
+	int irq;
+	int rc;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dev = dev;
+	platform_set_drvdata(pdev, ctx);
+	init_waitqueue_head(&ctx->wait);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctx->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ctx->base)) {
+		dev_err(dev, "Unable to ioremap registers\n");
+		return PTR_ERR(ctx->base);
+	}
+
+	irq = irq_of_parse_and_map(dev->of_node, 0);
+	if (!irq) {
+		dev_err(dev, "Unable to find IRQ\n");
+		return -ENODEV;
+	}
+
+	rc = devm_request_irq(dev, irq, aspeed_xdma_irq, IRQF_SHARED,
+			      DEVICE_NAME, ctx);
+	if (rc < 0) {
+		dev_err(dev, "Unable to request IRQ %d\n", irq);
+		return rc;
+	}
+
+	ctx->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");
+	if (IS_ERR(ctx->scu)) {
+		dev_err(ctx->dev, "Unable to grab SCU regs\n");
+		return PTR_ERR(ctx->scu);
+	}
+
+	ctx->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(ctx->reset)) {
+		dev_err(dev, "Unable to request reset control\n");
+		return PTR_ERR(ctx->reset);
+	}
+
+	reset_control_deassert(ctx->reset);
+
+	msleep(10);
+
+	rc = aspeed_xdma_init_mem(ctx);
+	if (rc) {
+		reset_control_assert(ctx->reset);
+		return rc;
+	}
+
+	aspeed_xdma_init_eng(ctx);
+
+	return 0;
+}
+
+static int aspeed_xdma_remove(struct platform_device *pdev)
+{
+	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
+
+	dma_free_coherent(ctx->dev, ctx->vga_size, ctx->vga_virt,
+			  ctx->vga_dma);
+	dma_release_declared_memory(ctx->dev);
+	reset_control_assert(ctx->reset);
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_xdma_match[] = {
+	{ .compatible = "aspeed,ast2500-xdma" },
+	{ },
+};
+
+static struct platform_driver aspeed_xdma_driver = {
+	.probe = aspeed_xdma_probe,
+	.remove = aspeed_xdma_remove,
+	.driver = {
+		.name = DEVICE_NAME,
+		.of_match_table = aspeed_xdma_match,
+	},
+};
+
+module_platform_driver(aspeed_xdma_driver);
+
+MODULE_AUTHOR("Eddie James");
+MODULE_DESCRIPTION("Aspeed XDMA Engine Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
new file mode 100644
index 0000000..9c1659d
--- /dev/null
+++ b/include/uapi/linux/aspeed-xdma.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright IBM Corp 2019 */
+
+#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
+#define _UAPI_LINUX_ASPEED_XDMA_H_
+
+#include <linux/types.h>
+
+/*
+ * aspeed_xdma_op
+ *
+ * upstream: boolean indicating the direction of the DMA operation; upstream
+ *           means a transfer from the BMC to the host
+ *
+ * host_addr: the DMA address on the host side, typically configured by PCI
+ *            subsystem
+ *
+ * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
+ */
+struct aspeed_xdma_op {
+	__u8 upstream;
+	__u64 host_addr;
+	__u32 len;
+} __packed;
+
+#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */
-- 
1.8.3.1

