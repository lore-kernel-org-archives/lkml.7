Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BAC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A8208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FCOSJaFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfGAKsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:48:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38169 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfGAKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so15357014wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gb9XGzqLE+vLkGx+5lxuMEkb6+fi6KbX8z9nRVd90Qs=;
        b=FCOSJaFGS/PSPpM76IRF348a1175FaD6DXtgM7VYPyNd+LwhQafERGEkHo0191x1Qz
         77CHLda6ahMbX+pymTJigIoZzknRy1rDEG4EMrOUqYTJpZ+cUbdNbCsm/KAUYaBPIAkS
         na50hsFStu4/tzoUq0Xfs6f8z0ciov3Qu+N/tHQs+GdBEIPPKp1PUjNVJHd1wTEwqX59
         5KkYuSonl+bEUN9oRr5w0ONBejGBC98B1l4vTvcWqTGaT9B7F+YN7XHwo7Hk8CUC2wcj
         8Ftzd/2+mymgJnxYT5R3e7zh4bQWpAhkDw2vcffHa7c30TH9dv95s3q3IAfn5YfKP7y5
         AWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gb9XGzqLE+vLkGx+5lxuMEkb6+fi6KbX8z9nRVd90Qs=;
        b=szHqQ3xPsGYHeQGQxkNIrXObUGGFk6CZqks8koBUdKG+1BXlZqAYq28j+39AusG5nk
         +m0jUTBCc8ybaaD0bPqI+VwnchOJ1fQjm9+Li3LqCRbPL1rMe1EGveFGkrcyNjAgA0D0
         gL80r5PDSgVrE0NIIyAdU8+8Qx354q/jq5OUnSoELLI4MGt51MmR6wI6C5bNaolVWemF
         QFW/cd2u1GDYlitZLUNMCdeYOUFCClvxCQooM9I3jTzlchOyz9exqBDbAZZp7sjCaBfa
         xPSLjS3XbXtL55LQAcEec/xnmG0+AQvc4LqsqrKdQAnNJB+dXlIE4jQMwNlOC9Su4f05
         P6VA==
X-Gm-Message-State: APjAAAU57svA68GtaKel6xJRTDWx3S4toey1+kqxgdYYuUSQy8owpXpR
        rUQaXvBfYhDoEUV9wVYPGoUcWg==
X-Google-Smtp-Source: APXvYqxA+apBe3W5Wb0iLkD6SH/jYBE0dzWsbSKFqfaorUeQ4pethRQZyDE6JXJtxVptB/LGjMsKvQ==
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr15877315wme.173.1561978048382;
        Mon, 01 Jul 2019 03:47:28 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d24sm11658802wra.43.2019.07.01.03.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:47:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC 04/11] soc: amlogic: Add support for SM1 power controller
Date:   Mon,  1 Jul 2019 12:46:58 +0200
Message-Id: <20190701104705.18271-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the General Purpose Amlogic SM1 Power controller,
dedicated to the PCIe, USB, NNA and GE2D Power Domains.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/Kconfig          |  11 ++
 drivers/soc/amlogic/Makefile         |   1 +
 drivers/soc/amlogic/meson-sm1-pwrc.c | 245 +++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-sm1-pwrc.c

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 5501ad5650b2..596f1afef1a7 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -36,6 +36,17 @@ config MESON_GX_PM_DOMAINS
 	  Say yes to expose Amlogic Meson GX Power Domains as
 	  Generic Power Domains.
 
+config MESON_SM1_PM_DOMAINS
+	bool "Amlogic Meson SM1 Power Domains driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on PM && OF
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Say yes to expose Amlogic Meson SM1 Power Domains as
+	  Generic Power Domains.
+
 config MESON_MX_SOCINFO
 	bool "Amlogic Meson MX SoC Information driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index bf2d109f61e9..f99935499ee6 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
 obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
+obj-$(CONFIG_MESON_SM1_PM_DOMAINS) += meson-sm1-pwrc.o
diff --git a/drivers/soc/amlogic/meson-sm1-pwrc.c b/drivers/soc/amlogic/meson-sm1-pwrc.c
new file mode 100644
index 000000000000..9ece1d06f417
--- /dev/null
+++ b/drivers/soc/amlogic/meson-sm1-pwrc.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <dt-bindings/power/meson-sm1-power.h>
+
+/* AO Offsets */
+
+#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
+#define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
+
+/* HHI Offsets */
+
+#define HHI_MEM_PD_REG0			(0x40 << 2)
+#define HHI_NANOQ_MEM_PD_REG0		(0x46 << 2)
+#define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
+
+struct meson_sm1_pwrc;
+
+struct meson_sm1_pwrc_mem_domain {
+	unsigned int reg;
+	unsigned int mask;
+};
+
+struct meson_sm1_pwrc_domain_desc {
+	char *name;
+	unsigned int sleep_reg;
+	unsigned int sleep_bit;
+	unsigned int iso_reg;
+	unsigned int iso_bit;
+	unsigned int mem_pd_count;
+	struct meson_sm1_pwrc_mem_domain *mem_pd;
+};
+
+struct meson_sm1_pwrc_domain_data {
+	unsigned int count;
+	struct meson_sm1_pwrc_domain_desc *domains;
+};
+
+static struct meson_sm1_pwrc_mem_domain sm1_pwrc_mem_nna[] = {
+	{ HHI_NANOQ_MEM_PD_REG0, 0xff },
+	{ HHI_NANOQ_MEM_PD_REG1, 0xff },
+};
+
+static struct meson_sm1_pwrc_mem_domain sm1_pwrc_mem_usb[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(31, 30) },
+};
+
+static struct meson_sm1_pwrc_mem_domain sm1_pwrc_mem_pcie[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(29, 26) },
+};
+
+static struct meson_sm1_pwrc_mem_domain sm1_pwrc_mem_ge2d[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(25, 18) },
+};
+
+#define SM1_PD(__name, __bit, __mem) \
+	{ \
+		.name = __name, \
+		.sleep_reg = AO_RTI_GEN_PWR_SLEEP0, \
+		.sleep_bit = __bit, \
+		.iso_reg = AO_RTI_GEN_PWR_ISO0, \
+		.iso_bit = __bit, \
+		.mem_pd_count = ARRAY_SIZE(__mem), \
+		.mem_pd = __mem, \
+	}
+
+static struct meson_sm1_pwrc_domain_desc sm1_pwrc_domains[] = {
+	[PWRC_SM1_NNA_ID]  = SM1_PD("NNA", 16, sm1_pwrc_mem_nna),
+	[PWRC_SM1_USB_ID]  = SM1_PD("USB", 17, sm1_pwrc_mem_usb),
+	[PWRC_SM1_PCIE_ID] = SM1_PD("PCI", 18, sm1_pwrc_mem_pcie),
+	[PWRC_SM1_GE2D_ID] = SM1_PD("GE2D", 19, sm1_pwrc_mem_ge2d),
+};
+
+struct meson_sm1_pwrc_domain {
+	struct generic_pm_domain base;
+	bool enabled;
+	struct meson_sm1_pwrc *pwrc;
+	struct meson_sm1_pwrc_domain_desc desc;
+};
+
+struct meson_sm1_pwrc {
+	struct regmap *regmap_ao;
+	struct regmap *regmap_hhi;
+	struct meson_sm1_pwrc_domain *domains;
+	struct genpd_onecell_data xlate;
+};
+
+static int meson_sm1_pwrc_off(struct generic_pm_domain *domain)
+{
+	struct meson_sm1_pwrc_domain *pwrc_domain =
+		container_of(domain, struct meson_sm1_pwrc_domain, base);
+	int i;
+
+	regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
+			   pwrc_domain->desc.sleep_reg,
+			   pwrc_domain->desc.sleep_bit,
+			   pwrc_domain->desc.sleep_bit);
+	udelay(20);
+
+	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
+		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
+				   pwrc_domain->desc.mem_pd[i].reg,
+				   pwrc_domain->desc.mem_pd[i].mask,
+				   pwrc_domain->desc.mem_pd[i].mask);
+
+	udelay(20);
+
+	regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
+			   pwrc_domain->desc.iso_reg,
+			   pwrc_domain->desc.iso_bit,
+			   pwrc_domain->desc.iso_bit);
+
+	return 0;
+}
+
+static int meson_sm1_pwrc_on(struct generic_pm_domain *domain)
+{
+	struct meson_sm1_pwrc_domain *pwrc_domain =
+		container_of(domain, struct meson_sm1_pwrc_domain, base);
+	int i;
+
+	regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
+			   pwrc_domain->desc.sleep_reg,
+			   pwrc_domain->desc.sleep_bit, 0);
+	udelay(20);
+
+	for (i = 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
+		regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
+				   pwrc_domain->desc.mem_pd[i].reg,
+				   pwrc_domain->desc.mem_pd[i].mask, 0);
+
+	udelay(20);
+
+	regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
+			   pwrc_domain->desc.iso_reg,
+			   pwrc_domain->desc.iso_bit, 0);
+
+	return 0;
+}
+
+static int meson_sm1_pwrc_probe(struct platform_device *pdev)
+{
+	const struct meson_sm1_pwrc_domain_data *match;
+	struct regmap *regmap_ao, *regmap_hhi;
+	struct meson_sm1_pwrc *sm1_pwrc;
+	int i;
+
+	match = of_device_get_match_data(&pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+
+	sm1_pwrc = devm_kzalloc(&pdev->dev, sizeof(*sm1_pwrc), GFP_KERNEL);
+	if (!sm1_pwrc)
+		return -ENOMEM;
+
+	sm1_pwrc->xlate.domains =
+		devm_kcalloc(&pdev->dev,
+			     match->count,
+			     sizeof(*sm1_pwrc->xlate.domains),
+			     GFP_KERNEL);
+	if (!sm1_pwrc->xlate.domains)
+		return -ENOMEM;
+
+	sm1_pwrc->domains =
+		devm_kcalloc(&pdev->dev,
+			     match->count,
+			     sizeof(*sm1_pwrc->domains),
+			     GFP_KERNEL);
+	if (!sm1_pwrc->domains)
+		return -ENOMEM;
+
+	sm1_pwrc->xlate.num_domains = match->count;
+
+	regmap_ao = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
+	if (IS_ERR(regmap_ao)) {
+		dev_err(&pdev->dev, "failed to get regmap\n");
+		return PTR_ERR(regmap_ao);
+	}
+
+	regmap_hhi = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+						     "amlogic,hhi-sysctrl");
+	if (IS_ERR(regmap_hhi)) {
+		dev_err(&pdev->dev, "failed to get HHI regmap\n");
+		return PTR_ERR(regmap_hhi);
+	}
+
+	sm1_pwrc->regmap_ao = regmap_ao;
+	sm1_pwrc->regmap_hhi = regmap_hhi;
+
+	platform_set_drvdata(pdev, sm1_pwrc);
+
+	for (i = 0 ; i < match->count ; ++i) {
+		struct meson_sm1_pwrc_domain *dom = &sm1_pwrc->domains[i];
+
+		dom->pwrc = sm1_pwrc;
+
+		memcpy(&dom->desc, &match->domains[i], sizeof(dom->desc));
+
+		dom->base.name = dom->desc.name;
+		dom->base.power_on = meson_sm1_pwrc_on;
+		dom->base.power_off = meson_sm1_pwrc_off;
+
+		pm_genpd_init(&dom->base, NULL, true);
+
+		sm1_pwrc->xlate.domains[i] = &dom->base;
+	}
+
+	of_genpd_add_provider_onecell(pdev->dev.of_node, &sm1_pwrc->xlate);
+
+	return 0;
+}
+
+static struct meson_sm1_pwrc_domain_data meson_sm1_pwrc_data = {
+	.count = ARRAY_SIZE(sm1_pwrc_domains),
+	.domains = sm1_pwrc_domains,
+};
+
+static const struct of_device_id meson_sm1_pwrc_match_table[] = {
+	{
+		.compatible = "amlogic,meson-sm1-pwrc",
+		.data = &meson_sm1_pwrc_data,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver meson_sm1_pwrc_driver = {
+	.probe	= meson_sm1_pwrc_probe,
+	.driver = {
+		.name		= "meson_sm1_pwrc",
+		.of_match_table	= meson_sm1_pwrc_match_table,
+	},
+};
+builtin_platform_driver(meson_sm1_pwrc_driver);
-- 
2.21.0

