Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BBC4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FF120830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXNlHMcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404270AbfIMXWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:22:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43631 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404236AbfIMXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so16026498pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ALVvzcJj6X8VNDYYs+4cy0jFFvB8QV8WJEiVVo2kQGE=;
        b=EXNlHMcPEc8E/geab7quLt9QQaVtHZnYIRb+2Lixs+atqwTdqJZHCECPN9z+bLle/y
         pzaEmY0hgn/D3JTeetka1SPT4HwiT69WxRjot/efFrRz8U27XlXT51LuR5gw5c796YIU
         9BayNJ23WX0dDZJ2xnIz9umef8YirKx/tneAL8ukb63kwEeBuoEH/+JwGU5zwYz9UgJ5
         qSZNaX3qGZrxur7nNp5Epciq1P5/Qs4SUJwzAbrHhZRo4b0dUGlTYjp2ExgRB1Nc93xA
         ytHG+Kdylr+vf1coukI5TwXuVDupNvpCw0EdhYQ6aE/AIXkKSn96I9atI+kZ+3sE9Wh4
         JWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ALVvzcJj6X8VNDYYs+4cy0jFFvB8QV8WJEiVVo2kQGE=;
        b=QyT+UbxIqoWNRQV+yn2gZ74ZE33A22pq+oLZ0Mqxa/So7PLdx09cJty+BucA6w87ps
         drn1FJMQvWef+N1v7gW3CAAJ7pemh8C+pq7hfSIlzndG4jPHtS9eMV3Oz3zoG13tVN2A
         OL3YlKalhtecakqUTB7EpQOWwgfnyRXI81gbZlpGsojw513NZXmXwUQM4+HbmOCXT6p3
         pOf0t0eHmpWLDL9MZBXX9KtRaIDG+1W/D9mNXOSwp+paKN6FTJeYpikrVu1SXXmvicum
         BHHNLlj7U0PXDvy9FwJLgb2n44qN98n9GgU4VHQ3Vytal6SCjdvuEpQ77bUZ0sK7haar
         xfIg==
X-Gm-Message-State: APjAAAXsv1Rxk7hBSH+TeYylaL3YJxxatofnY5wP2soOdJIrC1FZE7re
        26I3k4+7SFbQh3Y53LaNbZ/3by46baA=
X-Google-Smtp-Source: APXvYqy6LtT1j9J8i0k7QTsAYmQd1f1wM94WiTQlFjniQFdIXbdZ5HJjg02FiT45AUxpQBYRoBfEtw==
X-Received: by 2002:aa7:8a8a:: with SMTP id a10mr44137775pfc.131.1568416965633;
        Fri, 13 Sep 2019 16:22:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/7] irqchip: Introduce Kconfig symbol to build irq-bcm283x.c
Date:   Fri, 13 Sep 2019 16:22:30 -0700
Message-Id: <20190913232236.10200-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both irq-bcm2835.c and irq-bcm2836.c are currently used with
ARCH_BCM2835 but are soon going to be used with ARCH_BRCMSTB, introduce
a Kconfig symbol to make that those drivers selected/built by other
platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig  | 5 +++++
 drivers/irqchip/Makefile | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 80e10f4e213a..d1bb20d23d27 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -113,6 +113,11 @@ config I8259
 	bool
 	select IRQ_DOMAIN
 
+config BCM283X_IRQ
+	bool
+	select IRQ_DOMAIN
+	default ARCH_BCM2835
+
 config BCM6345_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 8d0fcec6ab23..9cf14c7945f6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_AL_FIC)			+= irq-al-fic.o
 obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
-obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
-obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_BCM283X_IRQ)		+= irq-bcm2835.o
+obj-$(CONFIG_BCM283X_IRQ)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
-- 
2.17.1

