Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB0CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF67F206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 21:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY6Z8gse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLXVL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 16:11:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34911 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 16:11:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so8846618plt.2;
        Tue, 24 Dec 2019 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZiIq+ODPkbmk3OovkgYvNLseu4fXK344aj0AC+jChpw=;
        b=RY6Z8gse4WXDdfZUdueg1YmV1qD/5ihmI7srcNXb/Yp7J/HxRn36oJWbCpXvJValW8
         fX0pql5BS3/8FxAI0eTafuTOqUE2F2Pj/AfS/fjTSfJJ/xA/Qc5JCCWjv2NZpqvfp1R1
         sh0HxjoxwLciBEgdmw9V8/K15LNahSLMjAzi28nSEbbPi3Mr0L8xbwtP/6MsK6q0Smsg
         SsYBgEDd8V+o91ROgm5nfGt8Gfltntiz3OoM4/F55FXXbDOKUTaXcZMFaYzG/Nu3vTIj
         H5XJA+lCN19m0kVswZuqNme/LBmDnjGQnT4FBEH9EZPxKPzMw104P3QGdDNKDqjlVp93
         kEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZiIq+ODPkbmk3OovkgYvNLseu4fXK344aj0AC+jChpw=;
        b=rSw/NyvfRfLu2A8dgkRyciQJQbQXXmqxYElqWTZl+WleSPZDrV83wJkgyJWMBfDB+W
         cxMSBPwvjreyvP09HUWfnucCmCxAXCs7J/FGQdkh79hEyq67+VJHVwysf/jfrQeRB4OJ
         nENI/f+pjy5sAbFeWtOuZGOGm5AiGfu9iU+vsu6hKzxInZymb20g7wEu2Fc2Gyih2REJ
         MxIsjPVGODlkZnX2GOWlJaa0WX3Ggz7t4U2AzZeKyPB5ob9vbn39EeDmLFs/p8Kky3cM
         QcwBaAae/p5EnTSpXkT4lGNqZDml3lZLqI/wnDKMzKaE/tyrcfXrYVzBVUh2aELwMM3U
         yj5A==
X-Gm-Message-State: APjAAAUGPF+lCp41GxIAkbmetomw9Et6rJKb5j7WzruoaFZRzlREM79I
        6UnO4kVEHpDFEG9dba7rDbYsoViw
X-Google-Smtp-Source: APXvYqz/C+9WgC+V/KEVMJDIBQxjgDS5AWjMUU0pMEE5lxF1QcLlKmnkbJUos6rMHuo0uN5S7XR9Zw==
X-Received: by 2002:a17:902:bb8c:: with SMTP id m12mr38370736pls.320.1577221885159;
        Tue, 24 Dec 2019 13:11:25 -0800 (PST)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id r28sm27021199pgk.39.2019.12.24.13.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 13:11:24 -0800 (PST)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: define EXYNOS_IRQ_COMBINER
Date:   Wed, 25 Dec 2019 06:11:07 +0900
Message-Id: <20191224211108.7128-1-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

This patch is written to clean up dependency of ARCH_EXYNOS
Not all exynos device have IRQ_COMBINER, especially aarch64 EXYNOS
but it is built for all exynos devices.
Thus add the config for EXYNOS_IRQ_COMBINER
remove direct dependency between ARCH_EXYNOS and exynos-combiner.c
and only selected on the aarch32 devices

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 drivers/irqchip/Kconfig      | 7 +++++++
 drivers/irqchip/Makefile     | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4ef56571145b..6e7f10c8098a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -12,6 +12,7 @@ menuconfig ARCH_EXYNOS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
+	select EXYNOS_IRQ_COMBINER
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_ASV
 	select EXYNOS_CHIPID
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ba152954324b..4c774d85375b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -499,4 +499,11 @@ config SIFIVE_PLIC
 
 	   If you don't know what to do here, say Y.
 
+config EXYNOS_IRQ_COMBINER
+	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
+	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
+	help
+	  Say yes here to add support for the IRQ combiner devices embedded
+	  in Samsung Exynos chips.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..60d7c7260fc3 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
-obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
-- 
2.17.1

