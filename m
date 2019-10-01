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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200A121906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJKIPqAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfJAWtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:49:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45057 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfJAWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:49:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so9153716pfb.12;
        Tue, 01 Oct 2019 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lByhQoUDqedSEy5jA6OCeRd6BYLoC/Hj4IwADVyV/Nw=;
        b=WJKIPqAEY/H0PHzfcKZu5++4lceWw/qRVIiktl/qkBV5K8aji5rGiLHvtt1Cr8aWCg
         vHOm9JrCRK7xr1153NTkjsc0wU0cAcshM094iSds+eyFSWlYTQoVu7Bh2AbjxGTculz5
         xg5kp0Knv81SN4PRMiBE51WSrSvd9E+V4W2ixzJQL7ZKUqF3vew/gHPNEAz4UVvg7Z5p
         dv9iaFQcPGH/qptes9jzQ2m115mWkiNI0kHmh9t3S5UuzdD1UvLqocJBnnErTS4Q8lMY
         ciyNzzVDOivzD0AkRSstw9gaoFBbOErtTFSEIY999ST6fcqZQeQAPCiu+eD+xkEacaJC
         QBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lByhQoUDqedSEy5jA6OCeRd6BYLoC/Hj4IwADVyV/Nw=;
        b=jC+LkSPcBs1748ArgRXc2uIx3B43MiROwU/mjVk+Rem7E3L6Olbcq4B+8XZ7xA1Qnq
         NKOsKL17IJ4NSjlNa8ad/exoWGwFqV9wNttwtuWGLH6hlTWgIetY/36NZhknuzz5GWHS
         eT5c1TDXTItgc47hcZrV7ua1H8fyJyyLSc7JgdvWARkLG/QIswWmPtgCsP7yvjIYJtVk
         e33tX6wEpwKgdAsGZTWGFEcwhq3sc/otUkIew5Pkjb5ahvY8ysI4FdQpbut9BF8qXbbU
         /Rb+jVOaANkr0DigbpnisUB/VmQgiWeNYTNYoU1n/SDjIQHF3D0IAHms2NXDhL9Mnb5T
         laxA==
X-Gm-Message-State: APjAAAUNLFum+enFCIoF5tXwD9MLP0EVj9ato74Lpzfv90Q1crFARllg
        araTKhLWbMauMgoJXq0s6tMlsvh+
X-Google-Smtp-Source: APXvYqw2VJmCyzOsAOxBdOzNbTd0KkoYIRi/7Y88yuuzid05BfYRTc439EhGBxpTHYxv5uBbtXSdPw==
X-Received: by 2002:a63:4616:: with SMTP id t22mr256877pga.123.1569970144635;
        Tue, 01 Oct 2019 15:49:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:49:04 -0700 (PDT)
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
Subject: [PATCH 7/7] irqchip/irq-bcm283x: Add registration prints
Date:   Tue,  1 Oct 2019 15:48:42 -0700
Message-Id: <20191001224842.9382-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With many different kind of interrupt controllers available and used on
7211, add prints to help determine which ones are registered.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm2835.c | 9 +++++++++
 drivers/irqchip/irq-bcm2836.c | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 55afc3487723..ae23e9ec86d0 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -76,6 +76,12 @@ enum armctrl_type {
 	ARMCTRL_BCM7211
 };
 
+static const char *armctrl_type_str[] = {
+	[ARMCTRL_BCM2835] = "BCM2835",
+	[ARMCTRL_BCM2836] = "BCM2836",
+	[ARMCTRL_BCM7211] = "BCM7211",
+};
+
 static const int reg_pending[] __initconst = { 0x00, 0x04, 0x08 };
 static const int reg_enable[] __initconst = { 0x18, 0x10, 0x14 };
 static const int reg_disable[] __initconst = { 0x24, 0x1c, 0x20 };
@@ -205,6 +211,9 @@ static int __init armctrl_of_init(struct device_node *node,
 		set_handle_irq(bcm2835_handle_irq);
 	}
 
+	pr_info("registered %s intc (%pOF)\n", armctrl_type_str[type],
+		node);
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 77fa395c8f6b..b159dc91919d 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -240,6 +240,8 @@ static int __init arm_irqchip_l1_intc_of_init_smp(struct device_node *node,
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
 
+	pr_info("Registered BCM2836 intc (%s)\n", node->full_name);
+
 	return 0;
 }
 
-- 
2.17.1

