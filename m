Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58806C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDC32085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LWGFPhb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEBKf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:35:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33985 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfEBKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:35:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so872157pgt.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gla8W0VcIaKCNYDoMpCJ/dAJtzrxBYSm4bxzw12y5b0=;
        b=LWGFPhb3eIYp32ggoe32vmRuIcrsJaaQV6P48HNlsOEpHzEOKbvqe14GdnfxIggF20
         1n0SlrH02nrcZK8thEs1NjNjTBnDRuN5MY8eS6WhwvK31FG7tHaGROfPeWTcTrUvHRUT
         7rwN9D00eB5EU5keAJKHsxaY07zaOf74Z57jfdTTfvOPuAhGx6I8aTUSIJRYMDwNaI8G
         c7PggqvB7kkSXrD4Nm8vKDl2n5mGGTNvn4jvApjrjmzASi/wUzJiUSfWorOd2tcN8KkR
         ma/8mHu4Ky/BKPjVBBLq85qNR+w1GHkEru3yNg+rzyc3SyMlzOQbWtxJVUb3il02NvgZ
         gcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gla8W0VcIaKCNYDoMpCJ/dAJtzrxBYSm4bxzw12y5b0=;
        b=HUrVcPFPlAlmq1Mo9clTZPhwFWkguzf50pviL1DxVt3j/uPoi/R6sUCnyOpuKGRuhH
         LAyaKCIZDUZF8A8Ehn1lPuRSE5ppVxW4WT4L2qct2skU02E2VYs2zu4sSV/zka/wLOcy
         cCRHHGUvwi46SrpK1jlayED3GT9Aat+1PS2yqrOjDWFIFn3GupZ5kMsBPZYtdMjQJvUT
         RrgyrHt7ejwV1nL6E+Vlk5pzxORBVVhraESCzRcW9ySC2YM0aTdfzNCk0LJc8RlZiCzR
         2x2nORfOBIRiP2CLVqMMbbITXQA08nk4uVCzeaGH5sGvSv9cODTMfW0/aPYslOiVc3uk
         2QOQ==
X-Gm-Message-State: APjAAAVfs41ZtjAdVjPzYMBU4yBBFDlNvCwWD/MW9L5Xe6XunK2kuzfs
        iJ2ouXX7r4vM7z4TUDD47XD8+Q==
X-Google-Smtp-Source: APXvYqzqNYTmQyuQDYqxh0FSZvVztNfPbJzy0gr2jgxi1o61S2zACE5TdFO4V9cHB3kAjge2uTaeOg==
X-Received: by 2002:aa7:8a8d:: with SMTP id a13mr3459163pfc.2.1556793323456;
        Thu, 02 May 2019 03:35:23 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id h187sm69141133pfc.52.2019.05.02.03.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 03:35:22 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 2/2] RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs
Date:   Thu,  2 May 2019 16:04:53 +0530
Message-Id: <1556793293-21019-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556793293-21019-1-git-send-email-yash.shah@sifive.com>
References: <1556793293-21019-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently supports only SiFive FU540-C000 platform.

The initial version of L2 cache controller driver includes:
- Initial configuration reporting at boot up.
- Support for ECC related functionality.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/mm/Makefile          |   1 +
 arch/riscv/mm/sifive_l2_cache.c | 221 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index eb22ab4..1523ee5 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -3,3 +3,4 @@ obj-y += fault.o
 obj-y += extable.o
 obj-y += ioremap.o
 obj-y += cacheflush.o
+obj-y += sifive_l2_cache.o
diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
new file mode 100644
index 0000000..923ab34
--- /dev/null
+++ b/arch/riscv/mm/sifive_l2_cache.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive L2 cache controller Driver
+ *
+ * Copyright (C) 2018-2019 SiFive, Inc.
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+#define SIFIVE_L2_DIRECCFIX_LOW 0x100
+#define SIFIVE_L2_DIRECCFIX_HIGH 0x104
+#define SIFIVE_L2_DIRECCFIX_COUNT 0x108
+
+#define SIFIVE_L2_DATECCFIX_LOW 0x140
+#define SIFIVE_L2_DATECCFIX_HIGH 0x144
+#define SIFIVE_L2_DATECCFIX_COUNT 0x148
+
+#define SIFIVE_L2_DATECCFAIL_LOW 0x160
+#define SIFIVE_L2_DATECCFAIL_HIGH 0x164
+#define SIFIVE_L2_DATECCFAIL_COUNT 0x168
+
+#define SIFIVE_L2_CONFIG 0x00
+#define SIFIVE_L2_WAYENABLE 0x08
+#define SIFIVE_L2_ECCINJECTERR 0x40
+
+#define SIFIVE_L2_ERR_TYPE_CE 0
+#define SIFIVE_L2_ERR_TYPE_UE 1
+#define SIFIVE_L2_MAX_ECCINTR 3
+
+static void __iomem *l2_base;
+static int g_irq[SIFIVE_L2_MAX_ECCINTR];
+
+enum {
+	DIR_CORR = 0,
+	DATA_CORR,
+	DATA_UNCORR,
+};
+
+static unsigned int l2_dirfix_addr_high(void)
+{
+	return readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
+}
+
+static unsigned int l2_dirfix_addr_low(void)
+{
+	return readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
+}
+
+static unsigned int l2_dirfix_count(void)
+{
+	return readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
+}
+
+static unsigned int l2_datfix_addr_high(void)
+{
+	return readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
+}
+
+static unsigned int l2_datfix_addr_low(void)
+{
+	return readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
+}
+
+static unsigned int l2_datfix_count(void)
+{
+	return readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
+}
+
+static unsigned int l2_datfail_addr_high(void)
+{
+	return readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
+}
+
+static unsigned int l2_datfail_addr_low(void)
+{
+	return readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
+}
+
+static unsigned int l2_datfail_count(void)
+{
+	return readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *sifive_test;
+
+static ssize_t l2_write(struct file *file, const char __user *data,
+			size_t count, loff_t *ppos)
+{
+	unsigned int val;
+
+	if (kstrtouint_from_user(data, count, 0, &val))
+		return -EINVAL;
+	if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
+		writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
+	else
+		return -EINVAL;
+	return count;
+}
+
+static const struct file_operations l2_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = l2_write
+};
+
+static void setup_sifive_debug(void)
+{
+	sifive_test = debugfs_create_dir("sifive_l2_cache", NULL);
+
+	debugfs_create_file("sifive_debug_inject_error", 0200,
+			    sifive_test, NULL, &l2_fops);
+}
+#endif
+
+static void l2_config_read(void)
+{
+	u32 regval, val;
+
+	regval = readl(l2_base + SIFIVE_L2_CONFIG);
+	val = regval & 0xFF;
+	pr_info("L2CACHE: No. of Banks in the cache: %d\n", val);
+	val = (regval & 0xFF00) >> 8;
+	pr_info("L2CACHE: No. of ways per bank: %d\n", val);
+	val = (regval & 0xFF0000) >> 16;
+	pr_info("L2CACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
+	val = (regval & 0xFF000000) >> 24;
+	pr_info("L2CACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
+
+	regval = readl(l2_base + SIFIVE_L2_WAYENABLE);
+	pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
+}
+
+static const struct of_device_id sifive_l2_ids[] = {
+	{ .compatible = "sifive,fu540-c000-ccache" },
+	{ /* end of table */ },
+};
+
+static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
+
+int register_sifive_l2_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(&l2_err_chain, nb);
+}
+EXPORT_SYMBOL_GPL(register_sifive_l2_error_notifier);
+
+int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(&l2_err_chain, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
+
+static irqreturn_t l2_int_handler(int irq, void *device)
+{
+	unsigned int regval, add_h, add_l;
+
+	if (irq == g_irq[DIR_CORR]) {
+		add_h = l2_dirfix_addr_high();
+		add_l = l2_dirfix_addr_low();
+		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		regval = l2_dirfix_count();
+		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
+					   "DirECCFix");
+	}
+	if (irq == g_irq[DATA_CORR]) {
+		add_h = l2_datfix_addr_high();
+		add_l = l2_datfix_addr_low();
+		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		regval = l2_datfix_count();
+		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
+					   "DatECCFix");
+	}
+	if (irq == g_irq[DATA_UNCORR]) {
+		add_h = l2_datfail_addr_high();
+		add_l = l2_datfail_addr_low();
+		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		regval = l2_datfail_count();
+		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
+					   "DatECCFail");
+	}
+
+	return IRQ_HANDLED;
+}
+
+int __init sifive_l2_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int i, rc;
+
+	np = of_find_matching_node(NULL, sifive_l2_ids);
+	if (!np)
+		return -ENODEV;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENODEV;
+
+	l2_base = ioremap(res.start, resource_size(&res));
+	if (!l2_base)
+		return -ENOMEM;
+
+	for (i = 0; i < SIFIVE_L2_MAX_ECCINTR; i++) {
+		g_irq[i] = irq_of_parse_and_map(np, i);
+		rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
+		if (rc) {
+			pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
+			return rc;
+		}
+	}
+
+	l2_config_read();
+
+#ifdef CONFIG_DEBUG_FS
+	setup_sifive_debug();
+#endif
+	return 0;
+}
+device_initcall(sifive_l2_init);
-- 
1.9.1

