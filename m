Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4119C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997F92086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEi36b5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfCQWzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:55:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44182 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfCQWzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:55:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id h34so10009107pgh.11;
        Sun, 17 Mar 2019 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSikdKeOgVMUbPdUvSpI1vxVe2RfmJf1h+7n9WQeyU8=;
        b=PEi36b5zpTEJmpsUOoisFLOi8d0Q0wXGJL03axzsB31v6fjwhnROUduUsTzUDN2VpB
         gdU0L3pNl8GVgRy6yvobK7eIMSxSRgXn4jx9PQw2Yo+zbjqohE2vQKoy7Jm6uYV1jo9S
         wdotEepLqUf4MPxOJPrb5dcs/Mm4Mc1tMd9zyIiZRk13wBSSBTYnfNDG50igZstmMsaX
         5YWRmFDIHrLNoIxSIdRiaWvuoFaZ/zKuGhx55wWjIgVZgo5I+OahEOdF1QZHnVywEXsn
         /7E07VUQBssgr0tIrT4GjqKOqQghkBNFwQbDGV/VoljyQ1px4irDTtjb2eXobN9W1Xzq
         TvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSikdKeOgVMUbPdUvSpI1vxVe2RfmJf1h+7n9WQeyU8=;
        b=c45MoFFEuOvMVIRJ0+we/DJ/eUNINCzzD/gfBWG8oM4Zr4r0TmOXZGUGtMI2F7iQvq
         4l39xL6WPXgmWRiD3iFfjOTnnnG+piR8k+Pked6axRCllCZDiRGmniJOZN8LyjjD4P/M
         AJq/x8et3dWE7IH0I9wzkYxIaIqIUy0u62I+fbr3BOtID7RVBZVOm+OfaifLBTCHhm3V
         x0CaCRG+3HhDDnjxLWjjH6tGJ8Xr8uXdOxO5MIJlSMmsPbTA+/BRSi5jvACdLC9oG2Ft
         AzpT4eXdOXzmLVHcEAlULD8T/AbuLvORkZuldOre01Tji9GXJ/qRq+3gIXGgO8kQi5fv
         9eOg==
X-Gm-Message-State: APjAAAVbU907xMZuDwadSbmF18oAe4/6SPDrvkg5j3H1MUv25wMDDxOO
        guN603w7db/kKVC5cXkPE8w=
X-Google-Smtp-Source: APXvYqyHAAmmuTYlCvbEWrpAnISBYqSZKxjOQsd5C8tcZzyRaWynTw9dZDqIz6Oll/Xt9t5tQfTRFw==
X-Received: by 2002:a65:6559:: with SMTP id a25mr13688586pgw.99.1552863336090;
        Sun, 17 Mar 2019 15:55:36 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id v2sm13738838pfg.118.2019.03.17.15.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:55:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/7] ARM: trusted_foundations: Support L2 cache maintenance
Date:   Mon, 18 Mar 2019 01:52:04 +0300
Message-Id: <20190317225211.23091-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
References: <20190317225211.23091-1-digetx@gmail.com>
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
 arch/arm/include/asm/trusted_foundations.h | 10 ++++++
 2 files changed, 51 insertions(+)

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
index 00748350cf72..9e6a41e9215e 100644
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
@@ -43,6 +46,9 @@ void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
+static inline void tf_dummy_write_sec(unsigned long val, unsigned int reg)
+{
+}
 
 static inline void register_trusted_foundations(
 				   struct trusted_foundations_platform_data *pd)
@@ -53,6 +59,10 @@ static inline void register_trusted_foundations(
 	 */
 	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
 	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
+#if IS_ENABLED(CONFIG_CACHE_L2X0)
+	pr_err("L2X0 cache will be kept disabled.\n");
+	outer_cache.write_sec = tf_dummy_write_sec;
+#endif
 #if IS_ENABLED(CONFIG_SMP)
 	setup_max_cpus = 0;
 #endif
-- 
2.20.1

