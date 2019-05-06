Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD95C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A188A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HBBrzPCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEFKtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:49:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfEFKtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:49:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so6256748pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4HiK00SsH+pkXj3bib/Dm6kAutuvgEnhqs4fr0K5FLU=;
        b=HBBrzPCSragWeqLw9VL5g2rPc893dEPb5/25+bvYb0NfgsSnBhRPWLzy93bqb9v5Nu
         l4otNUX7cMdPP0jP0ra/us2VgV65r3hEJCv2fhjbzsOaQ3bDmlXU+o2BQtIwM/7/Uw97
         fpOmLJDea6SvvwUNetEPGxtEz+8RM4P7glSNTy5GQszNWRXBkAe6sqLt5u3bxHIuLsI+
         7i1jcjmjruWx0U//A83Iu3bGxR8PYoAZQlGHo9vS7EpOuuLHm+gKSBuDhIft9Vdf8dlZ
         VJeTQu+dAvjr6wBoTSQhkMxRH8pxFUHCHSDp6yOjhTqbA1pp+NMzXmCG3smb5zZt32Ys
         qLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4HiK00SsH+pkXj3bib/Dm6kAutuvgEnhqs4fr0K5FLU=;
        b=OSNKpExO7NVVZnF5ECpG92k3YsWwiu6ITz1javV8q996zVLVYqmVhjP8p91k6QKpd8
         lxesmAzynqSn6VR9oEuJ8zFz4++YCZw1v0tEa/I36Na/zon5JdXpwb1D0hRrvDChRJAo
         KJBLxILNpW9K1HQbV8+KSs0oOOroGD0xuTPrYq3Gu3VuRpzc2IT3uH6qRe+tI1sVPEfL
         wVLt7EQzQemL8GQmo0xeqphRa/opjWhblsk7wUoSlRldDpiJYam/j8xygVxLDO3WyZh9
         Y1zlzwg+qorcR0UCkc6wtyP8ug9ELH/I39lf+IETiGT7O8DIs9ulL0/3jQOwz/pnUNYU
         XSxg==
X-Gm-Message-State: APjAAAW0eE+VA2goLm8LRsZBuOxrOia5SkLE5M+nx70/Rh3NxL+10U44
        03pZOZCKaFI+vd9l5l1GnOtmFEWK51A=
X-Google-Smtp-Source: APXvYqxNsts953IiloKTJ1hJwytN2Sl6bspyUJk+Nr/Kky6yX9IBsXli/CNSxZWw3gSLYfzgdStgZQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr32702376pfm.41.1557139757825;
        Mon, 06 May 2019 03:49:17 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p67sm21662257pfi.123.2019.05.06.03.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 03:49:17 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, afd@ti.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 2/2] RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs
Date:   Mon,  6 May 2019 16:18:40 +0530
Message-Id: <1557139720-12384-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
References: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
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
 arch/riscv/include/asm/sifive_l2_cache.h |  16 +++
 arch/riscv/mm/Makefile                   |   1 +
 arch/riscv/mm/sifive_l2_cache.c          | 175 +++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 arch/riscv/include/asm/sifive_l2_cache.h
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c

diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/arch/riscv/include/asm/sifive_l2_cache.h
new file mode 100644
index 0000000..04f6748
--- /dev/null
+++ b/arch/riscv/include/asm/sifive_l2_cache.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiFive L2 Cache Controller header file
+ *
+ */
+
+#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
+#define _ASM_RISCV_SIFIVE_L2_CACHE_H
+
+extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
+extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
+
+#define SIFIVE_L2_ERR_TYPE_CE 0
+#define SIFIVE_L2_ERR_TYPE_UE 1
+
+#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
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
index 0000000..4eb6461
--- /dev/null
+++ b/arch/riscv/mm/sifive_l2_cache.c
@@ -0,0 +1,175 @@
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
+#include <asm/sifive_l2_cache.h>
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
+		add_h = readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
+		add_l = readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
+		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
+		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
+					   "DirECCFix");
+	}
+	if (irq == g_irq[DATA_CORR]) {
+		add_h = readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
+		add_l = readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
+		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
+		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
+					   "DatECCFix");
+	}
+	if (irq == g_irq[DATA_UNCORR]) {
+		add_h = readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
+		add_l = readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
+		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
+		regval = readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
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

