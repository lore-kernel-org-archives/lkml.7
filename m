Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBB8ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C2221D80
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be6D+3c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfJAWs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:48:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43589 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJAWs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:48:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id v27so10714918pgk.10;
        Tue, 01 Oct 2019 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ALVvzcJj6X8VNDYYs+4cy0jFFvB8QV8WJEiVVo2kQGE=;
        b=Be6D+3c9ngOyzkSxFr7ojqi52yfdOwgEJdriPspA445qZMJiG98tDcsXJ2FcjO3pNE
         QqEAfCieC7lT8RjG4ucuTsHaayjP8GGjVwKQ0BlYEX2zDx6ujad0NsvvroYxnkPr5aGR
         ELiN8QgLY73XXCEcXqI/ZSQbXHk9qrxiCtd9LBn/6oc0rSl9sReRqii6+h7kFIf8kcEj
         WWM6yXfye/v3I2hmTD5Z5zJ7xdhEBy5Dp8iaznVMnC4t0m8FduyCLYyECaAbC/9CAelv
         OojhsNSODLxSAKyJpm89xw3uo1cFrEY0JqvBX3h2qEfU+Gr/o/BvbP6KnmRXo8Ks70AY
         g3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ALVvzcJj6X8VNDYYs+4cy0jFFvB8QV8WJEiVVo2kQGE=;
        b=aIBQB87z1teEJ9V+jRklMTR0nJjBk5BIMwKT33HPVBqiUR1AkNPwQkaSfRT9PCn+o/
         u4FX2UzL8aFZ6PdA7rFxbtXmifj3PsdcNAtH7F2r3zFREz8URMobC8cuBRIiyXsmrOzn
         dDMVrjDAd3iXWTFHxYys7lGITq8JMmPnDsbpsrkGIjZ52gb4YsCp5mLc1e6tnRQqYI23
         hU596CaGakbiMGCBbalaL5qOQaHYTfmJpBzJ0tiFXU6bd9+UiZWXkXWRfl4e93zOpKcj
         P81hZOYanUfy2CTY+PXhGifiQkHfuRXOR+sWf4aEGp2O2miB8lzT0GaEAyojtTLlzCRQ
         1EgQ==
X-Gm-Message-State: APjAAAUJoT1oCN9N8vHza+har9Xs59aDJD/BQhh5wKk0anj1ZGqBVhvY
        haqyZe++r0Hkm4+bfQuW+Q3JaQON
X-Google-Smtp-Source: APXvYqzJ0GLUmIOTnwatqSEh6qohHVG2F/73wfU8+xRyEwS3DswKWK4sHNJrNfPODg3CYN48PtCR5w==
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr643655pje.93.1569970136511;
        Tue, 01 Oct 2019 15:48:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:48:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH 1/7] irqchip: Introduce Kconfig symbol to build irq-bcm283x.c
Date:   Tue,  1 Oct 2019 15:48:36 -0700
Message-Id: <20191001224842.9382-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
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

