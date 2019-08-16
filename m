Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75733C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354632064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yj5yi77L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfHPLor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:44:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39115 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfHPLoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:44:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so2367056pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J3crdqEwB33aj7HWecSWYeN/dCr6hNrApJcl74wGcdg=;
        b=Yj5yi77LRElTJKXbIKhtLM4quE/lRimNj1WmSdzv6UKma8n4YyroGxk9+MNTODfNmU
         Y9z+lDx//8VltjXej8V0qr4Dp1XFr7zjyovkr1mtV3eVPIeHT9S5vuJZCQbm63qYNsMX
         w0/PNYgRYdkyw4ciRi4riOM/WHevsNYcLo9q+iU7ppnmj/B9sU8qN/jdS7NeH71+4ens
         cP7eUgkVi0ojK6OETPG5kFuf6rbvLBs8CmzE9UxDqUG0zpthPFcDDUjuKICzRVSJ6N0/
         XTgrCVJDeoYGc/CPShCyB4QauWbY7UxsfEFKAHXq+qcqBzyPiwSsjontBJdA6/CGMLFu
         eEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J3crdqEwB33aj7HWecSWYeN/dCr6hNrApJcl74wGcdg=;
        b=c5lG+DN8ZkkTeS61xwDQY43KXR2kkHNiHw1N/C6b65tkbPCe48XS+cRDq8ziYfXyXY
         /y+4bzlv2dWrs5SxqSsH8I2NEoAN+VCIkKoX3EC1E4LlszWWvDjgSjV7OzLE+JALKUYY
         IBGXtX7OdV71yDteQjdGhE9K2LFm0jvKnOdUnY/Nb30Ub7XgtjdmWHsT7ZHQdzApycxS
         zyXIfPIN3yZObmgD0rUavwXZdKxbuI5LTrf2kaveOMsj35b+7TkDPLVKq0dWlntqANnv
         y1qXG1SsXLaxnyZgn5IVjzUEXHqT6undsnEM19KeJ3H9v8BaNKrUrqq+okV7bHlPAj/R
         P/Jw==
X-Gm-Message-State: APjAAAWoeqZ6LxfYbFlUoiv1uQfMFP6k4yTDd7+XRGGuV9NDX7z/y0u5
        p5Sx4BpruFbAs9AMGY3DkLrxIQ==
X-Google-Smtp-Source: APXvYqyJbeqtEcp34QzBJPbQzUnHhF7gAysL//hcBT2l7b6zdfifBYvqLTc9qUHoRKCQSeUlVmevVA==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr8989474plp.245.1565955885105;
        Fri, 16 Aug 2019 04:44:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v22sm4693952pgk.69.2019.08.16.04.44.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 04:44:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        freeman.liu@unisoc.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: sprd: Add Spreadtrum SoCs eFuse support
Date:   Fri, 16 Aug 2019 19:44:17 +0800
Message-Id: <8f83a5f0fa66d9e0a601458f9ba01ce582215a46.1565955745.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
References: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
In-Reply-To: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
References: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

The Spreadtrum eFuse controller is widely used to dump chip ID,
configuration setting, function select and so on, as well as
supporting one-time programming.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/nvmem/Kconfig      |   11 ++
 drivers/nvmem/Makefile     |    2 +
 drivers/nvmem/sprd-efuse.c |  424 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 437 insertions(+)
 create mode 100644 drivers/nvmem/sprd-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index c2ec750..8fd425d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -230,4 +230,15 @@ config NVMEM_ZYNQMP
 
 	  If sure, say yes. If unsure, say no.
 
+config SPRD_EFUSE
+	tristate "Spreadtrum SoC eFuse Support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This is a simple driver to dump specified values of Spreadtrum
+	  SoCs from eFuse.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-sprd-efuse.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e5c153d..7c19870 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -50,3 +50,5 @@ obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
 nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
 obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
+obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
+nvmem_sprd_efuse-y		:= sprd-efuse.o
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
new file mode 100644
index 0000000..2f1e0fb
--- /dev/null
+++ b/drivers/nvmem/sprd-efuse.c
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define SPRD_EFUSE_ENABLE		0x20
+#define SPRD_EFUSE_ERR_FLAG		0x24
+#define SPRD_EFUSE_ERR_CLR		0x28
+#define SPRD_EFUSE_MAGIC_NUM		0x2c
+#define SPRD_EFUSE_FW_CFG		0x50
+#define SPRD_EFUSE_PW_SWT		0x54
+#define SPRD_EFUSE_MEM(val)		(0x1000 + ((val) << 2))
+
+#define SPRD_EFUSE_VDD_EN		BIT(0)
+#define SPRD_EFUSE_AUTO_CHECK_EN	BIT(1)
+#define SPRD_EFUSE_DOUBLE_EN		BIT(2)
+#define SPRD_EFUSE_MARGIN_RD_EN		BIT(3)
+#define SPRD_EFUSE_LOCK_WR_EN		BIT(4)
+
+#define SPRD_EFUSE_ERR_CLR_MASK		GENMASK(13, 0)
+
+#define SPRD_EFUSE_ENK1_ON		BIT(0)
+#define SPRD_EFUSE_ENK2_ON		BIT(1)
+#define SPRD_EFUSE_PROG_EN		BIT(2)
+
+#define SPRD_EFUSE_MAGIC_NUMBER		0x8810
+
+/* Block width (bytes) definitions */
+#define SPRD_EFUSE_BLOCK_WIDTH		4
+
+/*
+ * The Spreadtrum AP efuse contains 2 parts: normal efuse and secure efuse,
+ * and we can only access the normal efuse in kernel. So define the normal
+ * block offset index and normal block numbers.
+ */
+#define SPRD_EFUSE_NORMAL_BLOCK_NUMS	24
+#define SPRD_EFUSE_NORMAL_BLOCK_OFFSET	72
+
+/* Timeout (ms) for the trylock of hardware spinlocks */
+#define SPRD_EFUSE_HWLOCK_TIMEOUT	5000
+
+/*
+ * Since different Spreadtrum SoC chip can have different normal block numbers
+ * and offset. And some SoC can support block double feature, which means
+ * when reading or writing data to efuse memory, the controller can save double
+ * data in case one data become incorrect after a long period.
+ *
+ * Thus we should save them in the device data structure.
+ */
+struct sprd_efuse_variant_data {
+	u32 blk_nums;
+	u32 blk_offset;
+	bool blk_double;
+};
+
+struct sprd_efuse {
+	struct device *dev;
+	struct clk *clk;
+	struct hwspinlock *hwlock;
+	struct mutex mutex;
+	void __iomem *base;
+	const struct sprd_efuse_variant_data *data;
+};
+
+static const struct sprd_efuse_variant_data ums312_data = {
+	.blk_nums = SPRD_EFUSE_NORMAL_BLOCK_NUMS,
+	.blk_offset = SPRD_EFUSE_NORMAL_BLOCK_OFFSET,
+	.blk_double = false,
+};
+
+/*
+ * On Spreadtrum platform, we have multi-subsystems will access the unique
+ * efuse controller, so we need one hardware spinlock to synchronize between
+ * the multiple subsystems.
+ */
+static int sprd_efuse_lock(struct sprd_efuse *efuse)
+{
+	int ret;
+
+	mutex_lock(&efuse->mutex);
+
+	ret = hwspin_lock_timeout_raw(efuse->hwlock,
+				      SPRD_EFUSE_HWLOCK_TIMEOUT);
+	if (ret) {
+		dev_err(efuse->dev, "timeout get the hwspinlock\n");
+		mutex_unlock(&efuse->mutex);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sprd_efuse_unlock(struct sprd_efuse *efuse)
+{
+	hwspin_unlock_raw(efuse->hwlock);
+	mutex_unlock(&efuse->mutex);
+}
+
+static void sprd_efuse_set_prog_power(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_PW_SWT);
+
+	if (en)
+		val &= ~SPRD_EFUSE_ENK2_ON;
+	else
+		val &= ~SPRD_EFUSE_ENK1_ON;
+
+	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
+
+	/* Open or close efuse power need wait 1000us to make power stable. */
+	usleep_range(1000, 1200);
+
+	if (en)
+		val |= SPRD_EFUSE_ENK1_ON;
+	else
+		val |= SPRD_EFUSE_ENK2_ON;
+
+	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
+
+	/* Open or close efuse power need wait 1000us to make power stable. */
+	usleep_range(1000, 1200);
+}
+
+static void sprd_efuse_set_read_power(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_VDD_EN;
+	else
+		val &= ~SPRD_EFUSE_VDD_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+
+	/* Open or close efuse power need wait 1000us to make power stable. */
+	usleep_range(1000, 1200);
+}
+
+static void sprd_efuse_set_prog_lock(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_LOCK_WR_EN;
+	else
+		val &= ~SPRD_EFUSE_LOCK_WR_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+}
+
+static void sprd_efuse_set_auto_check(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_AUTO_CHECK_EN;
+	else
+		val &= ~SPRD_EFUSE_AUTO_CHECK_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+}
+
+static void sprd_efuse_set_data_double(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_ENABLE);
+
+	if (en)
+		val |= SPRD_EFUSE_DOUBLE_EN;
+	else
+		val &= ~SPRD_EFUSE_DOUBLE_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_ENABLE);
+}
+
+static void sprd_efuse_set_prog_en(struct sprd_efuse *efuse, bool en)
+{
+	u32 val = readl(efuse->base + SPRD_EFUSE_PW_SWT);
+
+	if (en)
+		val |= SPRD_EFUSE_PROG_EN;
+	else
+		val &= ~SPRD_EFUSE_PROG_EN;
+
+	writel(val, efuse->base + SPRD_EFUSE_PW_SWT);
+}
+
+static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
+			       bool lock, u32 *data)
+{
+	u32 status;
+	int ret = 0;
+
+	/*
+	 * We need set the correct magic number before writing the efuse to
+	 * allow programming, and block other programming until we clear the
+	 * magic number.
+	 */
+	writel(SPRD_EFUSE_MAGIC_NUMBER,
+	       efuse->base + SPRD_EFUSE_MAGIC_NUM);
+
+	/*
+	 * Power on the efuse, enable programme and enable double data
+	 * if asked.
+	 */
+	sprd_efuse_set_prog_power(efuse, true);
+	sprd_efuse_set_prog_en(efuse, true);
+	sprd_efuse_set_data_double(efuse, doub);
+
+	/*
+	 * Enable the auto-check function to validate if the programming is
+	 * successful.
+	 */
+	sprd_efuse_set_auto_check(efuse, true);
+
+	writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
+
+	/* Disable auto-check and data double after programming */
+	sprd_efuse_set_auto_check(efuse, false);
+	sprd_efuse_set_data_double(efuse, false);
+
+	/*
+	 * Check the efuse error status, if the programming is successful,
+	 * we should lock this efuse block to avoid programming again.
+	 */
+	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
+	if (status) {
+		dev_err(efuse->dev,
+			"write error status %d of block %d\n", ret, blk);
+
+		writel(SPRD_EFUSE_ERR_CLR_MASK,
+		       efuse->base + SPRD_EFUSE_ERR_CLR);
+		ret = -EBUSY;
+	} else {
+		sprd_efuse_set_prog_lock(efuse, lock);
+		writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
+		sprd_efuse_set_prog_lock(efuse, false);
+	}
+
+	sprd_efuse_set_prog_power(efuse, false);
+	writel(0, efuse->base + SPRD_EFUSE_MAGIC_NUM);
+
+	return ret;
+}
+
+static int sprd_efuse_raw_read(struct sprd_efuse *efuse, int blk, u32 *val,
+			       bool doub)
+{
+	u32 status;
+
+	/*
+	 * Need power on the efuse before reading data from efuse, and will
+	 * power off the efuse after reading process.
+	 */
+	sprd_efuse_set_read_power(efuse, true);
+
+	/* Enable double data if asked */
+	sprd_efuse_set_data_double(efuse, doub);
+
+	/* Start to read data from efuse block */
+	*val = readl(efuse->base + SPRD_EFUSE_MEM(blk));
+
+	/* Disable double data */
+	sprd_efuse_set_data_double(efuse, false);
+
+	/* Power off the efuse */
+	sprd_efuse_set_read_power(efuse, false);
+
+	/*
+	 * Check the efuse error status and clear them if there are some
+	 * errors occurred.
+	 */
+	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
+	if (status) {
+		dev_err(efuse->dev,
+			"read error status %d of block %d\n", status, blk);
+
+		writel(SPRD_EFUSE_ERR_CLR_MASK,
+		       efuse->base + SPRD_EFUSE_ERR_CLR);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
+{
+	struct sprd_efuse *efuse = context;
+	bool blk_double = efuse->data->blk_double;
+	u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
+	u32 blk_offset = (offset % SPRD_EFUSE_BLOCK_WIDTH) * BITS_PER_BYTE;
+	u32 data;
+	int ret;
+
+	ret = sprd_efuse_lock(efuse);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret)
+		goto unlock;
+
+	ret = sprd_efuse_raw_read(efuse, index, &data, blk_double);
+	if (!ret) {
+		data >>= blk_offset;
+		memcpy(val, &data, bytes);
+	}
+
+	clk_disable_unprepare(efuse->clk);
+
+unlock:
+	sprd_efuse_unlock(efuse);
+	return ret;
+}
+
+static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
+{
+	struct sprd_efuse *efuse = context;
+	int ret;
+
+	ret = sprd_efuse_lock(efuse);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(efuse->clk);
+	if (ret)
+		goto unlock;
+
+	ret = sprd_efuse_raw_prog(efuse, offset, false, false, val);
+
+	clk_disable_unprepare(efuse->clk);
+
+unlock:
+	sprd_efuse_unlock(efuse);
+	return ret;
+}
+
+static int sprd_efuse_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct nvmem_device *nvmem;
+	struct nvmem_config econfig = { };
+	struct sprd_efuse *efuse;
+	const struct sprd_efuse_variant_data *pdata;
+	int ret;
+
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
+
+	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
+	if (!efuse)
+		return -ENOMEM;
+
+	efuse->base = devm_platform_ioremap_resource(pdev, 0);
+	if (!efuse->base)
+		return -ENOMEM;
+
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get hwlock id\n");
+		return ret;
+	}
+
+	efuse->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
+	if (!efuse->hwlock) {
+		dev_err(&pdev->dev, "failed to request hwlock\n");
+		return -ENXIO;
+	}
+
+	efuse->clk = devm_clk_get(&pdev->dev, "enable");
+	if (IS_ERR(efuse->clk)) {
+		dev_err(&pdev->dev, "failed to get enable clock\n");
+		return PTR_ERR(efuse->clk);
+	}
+
+	mutex_init(&efuse->mutex);
+	efuse->dev = &pdev->dev;
+	efuse->data = pdata;
+
+	econfig.stride = 1;
+	econfig.word_size = 1;
+	econfig.read_only = false;
+	econfig.name = "sprd-efuse";
+	econfig.size = efuse->data->blk_nums * SPRD_EFUSE_BLOCK_WIDTH;
+	econfig.reg_read = sprd_efuse_read;
+	econfig.reg_write = sprd_efuse_write;
+	econfig.priv = efuse;
+	econfig.dev = &pdev->dev;
+	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
+	if (IS_ERR(nvmem)) {
+		dev_err(&pdev->dev, "failed to register nvmem\n");
+		return PTR_ERR(nvmem);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sprd_efuse_of_match[] = {
+	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
+	{ }
+};
+
+static struct platform_driver sprd_efuse_driver = {
+	.probe = sprd_efuse_probe,
+	.driver = {
+		.name = "sprd-efuse",
+		.of_match_table = sprd_efuse_of_match,
+	},
+};
+
+module_platform_driver(sprd_efuse_driver);
+
+MODULE_AUTHOR("Freeman Liu <freeman.liu@spreadtrum.com>");
+MODULE_DESCRIPTION("Spreadtrum AP efuse driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

