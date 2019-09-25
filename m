Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F723C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABBF222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfIYSuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:50:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40462 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfIYSuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:50:16 -0400
Received: from muedsl-82-207-238-254.citykom.de ([82.207.238.254] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iDCMb-0005K2-Ex; Wed, 25 Sep 2019 20:50:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     srinivas.kandagatla@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] nvmem: add Rockchip OTP driver
Date:   Wed, 25 Sep 2019 20:49:57 +0200
Message-Id: <20190925184957.14338-2-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925184957.14338-1-heiko@sntech.de>
References: <20190925184957.14338-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Newer Rockchip socs like the px30 use a different one-time-programmable
memory controller for things like cpu-id and leakage information,
so add the necessary driver for it.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[ported from vendor 4.4, converted to clock-bulk API and cleanups]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/nvmem/Kconfig        |  11 ++
 drivers/nvmem/Makefile       |   2 +
 drivers/nvmem/rockchip-otp.c | 268 +++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/nvmem/rockchip-otp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index c2ec750cae6e..80b7e5d9c448 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -119,6 +119,17 @@ config ROCKCHIP_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_rockchip_efuse.
 
+config ROCKCHIP_OTP
+	tristate "Rockchip OTP controller support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple drive to dump specified values of Rockchip SoC
+	  from otp, such as cpu-leakage.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_rockchip_otp.
+
 config NVMEM_BCM_OCOTP
 	tristate "Broadcom On-Chip OTP Controller support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e5c153d99a67..bbdbb929470f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -30,6 +30,8 @@ obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
 nvmem_qfprom-y			:= qfprom.o
 obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
 nvmem_rockchip_efuse-y		:= rockchip-efuse.o
+obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
+nvmem-rockchip-otp-y		:= rockchip-otp.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_stm32_romem-y 		:= stm32-romem.o
 obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
new file mode 100644
index 000000000000..9f53bcce2f87
--- /dev/null
+++ b/drivers/nvmem/rockchip-otp.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Rockchip OTP Driver
+ *
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ * Author: Finley Xiao <finley.xiao@rock-chips.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+/* OTP Register Offsets */
+#define OTPC_SBPI_CTRL			0x0020
+#define OTPC_SBPI_CMD_VALID_PRE		0x0024
+#define OTPC_SBPI_CS_VALID_PRE		0x0028
+#define OTPC_SBPI_STATUS		0x002C
+#define OTPC_USER_CTRL			0x0100
+#define OTPC_USER_ADDR			0x0104
+#define OTPC_USER_ENABLE		0x0108
+#define OTPC_USER_Q			0x0124
+#define OTPC_INT_STATUS			0x0304
+#define OTPC_SBPI_CMD0_OFFSET		0x1000
+#define OTPC_SBPI_CMD1_OFFSET		0x1004
+
+/* OTP Register bits and masks */
+#define OTPC_USER_ADDR_MASK		GENMASK(31, 16)
+#define OTPC_USE_USER			BIT(0)
+#define OTPC_USE_USER_MASK		GENMASK(16, 16)
+#define OTPC_USER_FSM_ENABLE		BIT(0)
+#define OTPC_USER_FSM_ENABLE_MASK	GENMASK(16, 16)
+#define OTPC_SBPI_DONE			BIT(1)
+#define OTPC_USER_DONE			BIT(2)
+
+#define SBPI_DAP_ADDR			0x02
+#define SBPI_DAP_ADDR_SHIFT		8
+#define SBPI_DAP_ADDR_MASK		GENMASK(31, 24)
+#define SBPI_CMD_VALID_MASK		GENMASK(31, 16)
+#define SBPI_DAP_CMD_WRF		0xC0
+#define SBPI_DAP_REG_ECC		0x3A
+#define SBPI_ECC_ENABLE			0x00
+#define SBPI_ECC_DISABLE		0x09
+#define SBPI_ENABLE			BIT(0)
+#define SBPI_ENABLE_MASK		GENMASK(16, 16)
+
+#define OTPC_TIMEOUT			10000
+
+struct rockchip_otp {
+	struct device *dev;
+	void __iomem *base;
+	struct clk_bulk_data	*clks;
+	int num_clks;
+	struct reset_control *rst;
+};
+
+/* list of required clocks */
+static const char * const rockchip_otp_clocks[] = {
+	"otp", "apb_pclk", "phy",
+};
+
+struct rockchip_data {
+	int size;
+};
+
+static int rockchip_otp_reset(struct rockchip_otp *otp)
+{
+	int ret;
+
+	ret = reset_control_assert(otp->rst);
+	if (ret) {
+		dev_err(otp->dev, "failed to assert otp phy %d\n", ret);
+		return ret;
+	}
+
+	udelay(2);
+
+	ret = reset_control_deassert(otp->rst);
+	if (ret) {
+		dev_err(otp->dev, "failed to deassert otp phy %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rockchip_otp_wait_status(struct rockchip_otp *otp, u32 flag)
+{
+	u32 status = 0;
+	int ret;
+
+	ret = readl_poll_timeout_atomic(otp->base + OTPC_INT_STATUS, status,
+					(status & flag), 1, OTPC_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* clean int status */
+	writel(flag, otp->base + OTPC_INT_STATUS);
+
+	return 0;
+}
+
+static int rockchip_otp_ecc_enable(struct rockchip_otp *otp, bool enable)
+{
+	int ret = 0;
+
+	writel(SBPI_DAP_ADDR_MASK | (SBPI_DAP_ADDR << SBPI_DAP_ADDR_SHIFT),
+	       otp->base + OTPC_SBPI_CTRL);
+
+	writel(SBPI_CMD_VALID_MASK | 0x1, otp->base + OTPC_SBPI_CMD_VALID_PRE);
+	writel(SBPI_DAP_CMD_WRF | SBPI_DAP_REG_ECC,
+	       otp->base + OTPC_SBPI_CMD0_OFFSET);
+	if (enable)
+		writel(SBPI_ECC_ENABLE, otp->base + OTPC_SBPI_CMD1_OFFSET);
+	else
+		writel(SBPI_ECC_DISABLE, otp->base + OTPC_SBPI_CMD1_OFFSET);
+
+	writel(SBPI_ENABLE_MASK | SBPI_ENABLE, otp->base + OTPC_SBPI_CTRL);
+
+	ret = rockchip_otp_wait_status(otp, OTPC_SBPI_DONE);
+	if (ret < 0)
+		dev_err(otp->dev, "timeout during ecc_enable\n");
+
+	return ret;
+}
+
+static int rockchip_otp_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct rockchip_otp *otp = context;
+	u8 *buf = val;
+	int ret = 0;
+
+	ret = clk_bulk_prepare_enable(otp->num_clks, otp->clks);
+	if (ret < 0) {
+		dev_err(otp->dev, "failed to prepare/enable clks\n");
+		return ret;
+	}
+
+	ret = rockchip_otp_reset(otp);
+	if (ret) {
+		dev_err(otp->dev, "failed to reset otp phy\n");
+		goto disable_clks;
+	}
+
+	ret = rockchip_otp_ecc_enable(otp, false);
+	if (ret < 0) {
+		dev_err(otp->dev, "rockchip_otp_ecc_enable err\n");
+		goto disable_clks;
+	}
+
+	writel(OTPC_USE_USER | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
+	udelay(5);
+	while (bytes--) {
+		writel(offset++ | OTPC_USER_ADDR_MASK,
+		       otp->base + OTPC_USER_ADDR);
+		writel(OTPC_USER_FSM_ENABLE | OTPC_USER_FSM_ENABLE_MASK,
+		       otp->base + OTPC_USER_ENABLE);
+		ret = rockchip_otp_wait_status(otp, OTPC_USER_DONE);
+		if (ret < 0) {
+			dev_err(otp->dev, "timeout during read setup\n");
+			goto read_end;
+		}
+		*buf++ = readb(otp->base + OTPC_USER_Q);
+	}
+
+read_end:
+	writel(0x0 | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
+disable_clks:
+	clk_bulk_disable_unprepare(otp->num_clks, otp->clks);
+
+	return ret;
+}
+
+static struct nvmem_config otp_config = {
+	.name = "rockchip-otp",
+	.owner = THIS_MODULE,
+	.read_only = true,
+	.stride = 1,
+	.word_size = 1,
+	.reg_read = rockchip_otp_read,
+};
+
+static const struct rockchip_data px30_data = {
+	.size = 0x40,
+};
+
+static const struct of_device_id rockchip_otp_match[] = {
+	{
+		.compatible = "rockchip,px30-otp",
+		.data = (void *)&px30_data,
+	},
+	{
+		.compatible = "rockchip,rk3308-otp",
+		.data = (void *)&px30_data,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rockchip_otp_match);
+
+static int rockchip_otp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_otp *otp;
+	const struct rockchip_data *data;
+	struct nvmem_device *nvmem;
+	int ret, i;
+
+	data = of_device_get_match_data(dev);
+	if (!data) {
+		dev_err(dev, "failed to get match data\n");
+		return -EINVAL;
+	}
+
+	otp = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_otp),
+			   GFP_KERNEL);
+	if (!otp)
+		return -ENOMEM;
+
+	otp->dev = dev;
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(otp->base))
+		return PTR_ERR(otp->base);
+
+	otp->num_clks = ARRAY_SIZE(rockchip_otp_clocks);
+	otp->clks = devm_kcalloc(dev, otp->num_clks,
+				     sizeof(*otp->clks), GFP_KERNEL);
+	if (!otp->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < otp->num_clks; ++i)
+		otp->clks[i].id = rockchip_otp_clocks[i];
+
+	ret = devm_clk_bulk_get(dev, otp->num_clks, otp->clks);
+	if (ret)
+		return ret;
+
+	otp->rst = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(otp->rst))
+		return PTR_ERR(otp->rst);
+
+	otp_config.size = data->size;
+	otp_config.priv = otp;
+	otp_config.dev = dev;
+	nvmem = devm_nvmem_register(dev, &otp_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static struct platform_driver rockchip_otp_driver = {
+	.probe = rockchip_otp_probe,
+	.driver = {
+		.name = "rockchip-otp",
+		.of_match_table = rockchip_otp_match,
+	},
+};
+
+module_platform_driver(rockchip_otp_driver);
+MODULE_DESCRIPTION("Rockchip OTP driver");
+MODULE_LICENSE("GPL v2");
-- 
2.23.0

