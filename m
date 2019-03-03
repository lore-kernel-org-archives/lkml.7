Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D353FC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E7D20818
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX66dTWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfCCRNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:13:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35357 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:13:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id e17so1355925pgd.2;
        Sun, 03 Mar 2019 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRPWdDzEgjoLvgNLlDqRYxDvr6EyPAugVognUJGP4To=;
        b=GX66dTWenzmhQlN/6AF7yMeSO+8lEdUWk3OCpxejXPDUIViLmNao/iQN2OXXJ8dJvw
         QhGQpNA6WahNSHIAaoUF3HxcP/NfK7/KFTzohiWFAtrRjh8MtOapZ5QdhMnsn22ilHBf
         8Q/lJ773NqYxwM/dejIWQ8ImZOC1u1bpUd9Ks0Pl3hv0y4NGWLlNDJcxI2+il/ltKNGQ
         ZJbgeTWaEajaGFEnLzzxa/g42lEcg00QLt5xwEGgSj5RG3LkPzD3Fi97knSgclYyntf7
         mPE84fmCNDl3idzCTpo/zbYH2WQX2oP0ldi1RAzHcDTTo1EU1HEoeQZ9IcNBiBcJACUC
         vlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRPWdDzEgjoLvgNLlDqRYxDvr6EyPAugVognUJGP4To=;
        b=qs2TogYRtT4ZTMnQfXxbkQQzOTuN4t+uUJRZaLkAbDOuSTxasA0PY1Ae+i8K8N0GhJ
         l6Z9pDO6rLhZeuqzFoXlf+bbnhmT7XP5J5T4EiWZZG3zplJzFXicjjI1M1BPeUrZMgvA
         5f73nR4Jeama+ssEyOYgQOilLEbxCicAFg8nWDfwHEhbiJI3+66Dit3IPnI1TmX1fJvA
         r9IwrZJ4oiBcDobp8lsMvT4wzl/4klTPR+bYHOTFMq8MLXMXL1QV5iI4suXdewFpy+pw
         ym3lrkDaLlvahfSr/ARM7gEr81XgSpjZyJPkLebawPW7MCtJHlbS1lDgeVpTGixhmXOS
         RiOQ==
X-Gm-Message-State: APjAAAXjocUWMcLyZ5HTfuEM4rB363rywNvtfZXGd4AhHS5ciQ/pYkmi
        qDDCmaxFrFRCrvpNnsFDKJlC/T7t
X-Google-Smtp-Source: APXvYqxo0avGDODD2Ng7ahsZcZsdIAE0WSZBf83j2wK0402ss5WHfCLwakvdJMgd9pnTnpTuLTx9jg==
X-Received: by 2002:a65:4384:: with SMTP id m4mr14493823pgp.375.1551633211778;
        Sun, 03 Mar 2019 09:13:31 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e22sm5349412pfi.126.2019.03.03.09.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:13:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/7] ARM: trusted_foundations: Support L2 cache maintenance
Date:   Sun,  3 Mar 2019 20:12:08 +0300
Message-Id: <20190303171214.24821-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303171214.24821-1-digetx@gmail.com>
References: <20190303171214.24821-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement L2 cache initialization firmware callback that should be
invoked early during boot in order to set up the required outer cache
driver's callbacks and add the callback required for L2X0 maintenance.

Partially based on work done by Michał Mirosław [1].

[1] https://www.spinics.net/lists/arm-kernel/msg594765.html

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 41 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h | 12 +++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 689e6565abfc..d7ac05103a52 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_ENABLE		1
+#define TF_CACHE_DISABLE	2
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -67,9 +74,43 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	u32 l2x0_way_mask = 0xff;
+
+	switch (reg) {
+	case L2X0_CTRL:
+		if (l2x0_saved_regs.aux_ctrl & L310_AUX_CTRL_ASSOCIATIVITY_16)
+			l2x0_way_mask = 0xffff;
+
+		if (val == L2X0_CTRL_EN)
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_ENABLE,
+				       l2x0_saved_regs.aux_ctrl);
+		else
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_DISABLE,
+				       l2x0_way_mask);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
+
+	return 0;
+}
+#endif /* CONFIG_CACHE_L2X0 */
+
 static const struct firmware_ops trusted_foundations_ops = {
 	.set_cpu_boot_addr = tf_set_cpu_boot_addr,
 	.prepare_idle = tf_prepare_idle,
+#ifdef CONFIG_CACHE_L2X0
+	.l2x0_init = tf_init_cache,
+#endif
 };
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..d5d1b7efa02e 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -32,6 +32,9 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
+
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
 	unsigned int version_minor;
@@ -43,6 +46,11 @@ void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
+static inline void tf_dummy_write_sec(unsigned long val, unsigned int reg)
+{
+	if (reg == L2X0_CTRL && val == L2X0_CTRL_EN)
+		pr_err("Trusted Foundations unavailable, ignoring request to enable L2C\n");
+}
 
 static inline void register_trusted_foundations(
 				   struct trusted_foundations_platform_data *pd)
@@ -53,6 +61,10 @@ static inline void register_trusted_foundations(
 	 */
 	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
 	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
+#if IS_ENABLED(CONFIG_CACHE_L2X0)
+	pr_err("L2X0 cache will be disabled.\n");
+	outer_cache.write_sec = tf_dummy_write_sec;
+#endif
 #if IS_ENABLED(CONFIG_SMP)
 	setup_max_cpus = 0;
 #endif
-- 
2.20.1

