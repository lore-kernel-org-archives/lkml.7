Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9AFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38872171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm4rQPwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfB1PAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33831 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbfB1O75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:59:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id u21so15507186lfu.1;
        Thu, 28 Feb 2019 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUbFGCkTlGqhFrgKpP67ocSrAhCVcyTzIpRgjYYzmlY=;
        b=Nm4rQPwID/9qjpwD9gXHmcQqNg5O9haWteRwKy6cSPs5T/O3gfp8Y+Cp36miuvYYGs
         Sno4ncvsRmzE1Rlm2os0nld/JQukOslvE+6kp3eeuZj0eTGPkaf4H3M7+56GKkRjOhQq
         g1gkrNh99hx9t3leTWgG1NIoTM4JnXiIO9R23Huwu89sBf7SAwkfqIgh4yrpOgUPj93e
         xrbNXynXjQo6puIZFzdx/j99AgAUF6A7QGH2T+29plLdv1KfRtOS3I8gGJiHz7dMThFV
         8/iInqoGX44r928jXwvXYzVSO/Abr5Fmh+2FNZSp1tX2/dnK9gtD7695iQRsLYekQPwT
         LnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUbFGCkTlGqhFrgKpP67ocSrAhCVcyTzIpRgjYYzmlY=;
        b=EwhM7rpbPTcIzCl29QeWIKPVcXRNVTIOlevv7M0t7OZdfXaVKxUgjd74Rwo76h0PK9
         JeS9KzRmHgsNQdldtuLeUnBL+xJo/g8oNovn/3YmC+N+xNcJiAXVlQ/jaJP0KtAnIkCk
         lciHB/ImbTYV3fG8rRazOPRKLto7SmNuW0ETd9oYPKZY5EZhY5/fdeNVGqWRFHfgrUmk
         daekC56xMhjulyg/GykTZzAa9b4o970HN2I5FkCzsU0sXC5l6XAE4nRiA70GwGPmok7t
         lG26LGPB+1uXu5wgqdQemK472n0L2TyYSkXQCJvTkgFwUVvTLFJk98c+gpZI/rC2tOVs
         0E6A==
X-Gm-Message-State: AHQUAuYSRaIbRfe5dEc7JCVBVwTUK6TYsfqAlwRsf8zhODOv9qLgwvKg
        0GKhYR/Yg+OuARxnT6xEf2ES5zTP
X-Google-Smtp-Source: AHgI3IZ3xD1oLK6FWxPWrtoHeM5XRP9iIJFoEzkCDvFv/SgcqG28srWBZjSjQyc5x2iOuPRVayHI1g==
X-Received: by 2002:a19:760d:: with SMTP id c13mr3821793lff.102.1551365994766;
        Thu, 28 Feb 2019 06:59:54 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.06.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:59:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/7] ARM: trusted_foundations: Support L2 cache maintenance
Date:   Thu, 28 Feb 2019 17:59:31 +0300
Message-Id: <20190228145937.27725-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228145937.27725-1-digetx@gmail.com>
References: <20190228145937.27725-1-digetx@gmail.com>
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
index 00748350cf72..07183ca43b25 100644
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
+		pr_err("Trusted Foundations unavailable, ignoring L2C enable-request\n");
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

