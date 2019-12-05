Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BECC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ABE2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es1CC/pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfLEPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:13:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41790 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:13:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so1746625pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xH7/cdrcedOn36xP43WZQskLGrfjIagWIu9yEgzZPnM=;
        b=Es1CC/pkIO97E5F6W7mvIfX2ofPGR6nkRoVTYkt4heeVUzUTYDqhmLSSwdg1DXzczf
         Dh0EwWIm3CNAwh29qxsR8ZTPWaNk7aG0O941L5SmDX7/MatN81xXbZE33SN4GnqGAsrl
         zTSHy1DnVLZjj0HzPsiYwstkm2gFeNwUSeESoI9NP7KhKjhxujM8vO35r3KnfauLRY/U
         v87wCuuK7PK9I98gLXMvjf0mUl7Jgx5BEt6F3g3NdRrdiIKMlkO98N5Fapork43UTE51
         NG7mUEtOKH0NlPfr8UdC9GExGZaoNDwxxWUbnJAPqVLhvr0jq2m+3yKhDmZzXaNUy6Ng
         A7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xH7/cdrcedOn36xP43WZQskLGrfjIagWIu9yEgzZPnM=;
        b=T9G2aV/gKfrJS16YYNLbVUZClLVB/rU4vpaLpnnp5pLjL7R50eSxzXmc6sVVLuB4Cr
         GM/v14GjxVCUCviXbn6JxhkP1xikuTAcTTJjZTmm29uHt8EspnIoEyFBfgwJQrXp0xHl
         /vGrQUBNG9ki4274Xwa6FuI2Q/nxaRp6X5W6sk3IKZogitMdttmsOH+WfRgduogd9Sct
         saMsz9f2BPSVXxWgFgZSuxrtSkL93FItisDe6BwOashgigXxPInKLQsLkc6Wri/3QMoF
         WbOeMzc8JT4cbjgmJvusx6x5vNlCHTTTxh2c4ygYKDMkVeYd5PR4hDpuHnX+G2yQsepe
         diOA==
X-Gm-Message-State: APjAAAVWkNLo5NczTZhPF2RAMEAZrrq81R9jmbH7xZQw66nNs8TV3oVp
        2jahS1N2kPej69YygP2JYICX+/6d
X-Google-Smtp-Source: APXvYqzHFjSwjKJLbyvry1R2HsvtKHWdlB4AWnl37QrVQQZxT7KNZSiyj/zglqbgypwtyBh8Po3n/A==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr9576256pfx.255.1575558810674;
        Thu, 05 Dec 2019 07:13:30 -0800 (PST)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id x2sm11923203pgc.67.2019.12.05.07.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:13:30 -0800 (PST)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
To:     tglx@linutronix.de
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: define EXYNOS_IRQ_COMBINER
Date:   Fri,  6 Dec 2019 00:13:19 +0900
Message-Id: <20191205151319.22981-1-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

Not all exynos device have IRQ_COMBINER.
Thus add the config for EXYNOS_IRQ_COMBINER.

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 drivers/irqchip/Kconfig  | 7 +++++++
 drivers/irqchip/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ba152954324b..1fff899a6421 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -393,6 +393,13 @@ config STM32_EXTI
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
 
+config EXYNOS_IRQ_COMBINER
+	bool "Samsung Exynos IRQ combiner support"
+	depends on ARCH_EXYNOS
+	help
+	  Say yes here to add support for the IRQ combiner devices embedded
+	  in Samsung Exynos chips.
+
 config QCOM_IRQ_COMBINER
 	bool "QCOM IRQ combiner support"
 	depends on ARCH_QCOM && ACPI
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

