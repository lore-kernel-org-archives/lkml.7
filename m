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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179EAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15F920830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkX+85gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbfIMXWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:22:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40405 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404295AbfIMXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so16052490pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lByhQoUDqedSEy5jA6OCeRd6BYLoC/Hj4IwADVyV/Nw=;
        b=kkX+85gkrW2Buu+Xzskcqir8gvZG5lMldcBBLygf4PXf9udy9Yn4gHOn6AlRGXvi9J
         7PhdCriwozvDlBmwEq/3pUA3H+MYuyi6/D83wtoqw1uI9OCUT7/XG/l59akvIF19rRCM
         GTpoDeXbpgEX5p4wluTb9nPyChr1JS/8zKT5879mepD8rbdOdT1QBxemWJy8dhdbuKU2
         nR/Y7Eqg0f9MWpPQdnqAsaPZ9j7YCS8OoO1c9W9s1IbNyphBeoEI9HMzTfm0QJGBC8nI
         9vvxlIu8HfOOPv0E3PZvoIYIKoUdfWFdU1mQafBDq17wOP2hUmvm0bRudJZk+F6/Hpkt
         MNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lByhQoUDqedSEy5jA6OCeRd6BYLoC/Hj4IwADVyV/Nw=;
        b=WKnMQleISm28CY2l0Vv9rIiBi8jOxaTiAz+hgmAhMXTSL1/xOXdLjHxgXWeIdDp+wA
         qcBOP1GtFlF2Rh/r/kKg5k3Bd2graP3QWbeVNzaTCJg0l4fsOG82lNUTiAWFdC1f24F6
         id1f6agFISZGMJYU7pEYnxihZL0BS0lPOQM9Id5Ww58iIOJiQ0nUYUy2NOMNJuXw9M95
         w+y5p9gqOi5k2/HNDEUjZKUNDS52BQs/iyUnHlBH6n74iyv19zMA2swLHhmRc+75m9WK
         OVuK0hIHeNzcJKFHJ9bI12mzL1eDgw4Zt5/lpq/rv11ULIguxlZtwHinJWGapW9m2KLR
         6z2w==
X-Gm-Message-State: APjAAAUyB0XvGufZ0JODGxwZih9ftYCmx40683+NKIATNYp6vZFkaTp7
        WkXNTBlifEfJCXbnykXsdWmcFWI5trA=
X-Google-Smtp-Source: APXvYqw5V4giGaYQM7saATgByD8AiGr53K7hgwnjrsM/mFIonSJcE58JGwgAh8LLDakgrbrvvMVMEA==
X-Received: by 2002:aa7:9abb:: with SMTP id x27mr24756825pfi.206.1568416971878;
        Fri, 13 Sep 2019 16:22:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 7/7] irqchip/irq-bcm283x: Add registration prints
Date:   Fri, 13 Sep 2019 16:22:36 -0700
Message-Id: <20190913232236.10200-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
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

