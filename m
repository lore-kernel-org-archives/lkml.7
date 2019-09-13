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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0074DC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE34520830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV3TsPsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404308AbfIMXWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:22:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44831 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404283AbfIMXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id k1so13900133pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xm5+dOflKaTZIVZnokmYc6eT45ykFCPyC442ihyZjok=;
        b=OV3TsPsXkrHSEhUn2jjxMDQqUqQ8ahr+4gHRRqtIK6PgX1MJcq2IeZfW43y3razXAO
         4o6/R0cxB8i/WUO+ji1dT/K/hzsSbKD+JcmEFGNfTKx9fbUb9bIRZHa1ngeb+N3rBm01
         Gu1oGP2+imEg+ldkBFE7VwF4dcll3KbIJa59CA9Wl1T1iFr0z2kXDi49km8Q0e+DIBm5
         tSZKe8QQ/4qGQ4HK+AC1ix47tbE2rSpNJYgHE+qjQ+K+TlZYoXlfeAEzF1rrSh0B7Qom
         RSiZVHtDmTnyxj184BI2fxGX0PzOjWVJiZDgRKMOuYUqf+kDmA8xCF8x1Gs+e/Xg2FKt
         UuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xm5+dOflKaTZIVZnokmYc6eT45ykFCPyC442ihyZjok=;
        b=OBERzEyRDz5SBAC/1paxzfH61A/ns2Eoui6EZ0h+ibPS3XGKFZpdZLrdrWeRKFJ74+
         lMLRi6b6oZN5Hu60SrUObbp1Dvui+gvH9YKPDWatfVJrIRJzFVsk5n1mDUP6CJ+8T1vm
         QLWwNR7mw4UTNXM39ZBXiqpFkvBKS4QCP97urtlv5k4RiMOs7TrOnR4IcDQf2Qoahkz2
         5NQKwCIdKLkIBnqHfAMfOt9qCeaOfZFLV4Fc5UCmfym7T3NtdTX5NYlernaeKuhCfGN5
         GZm1bhZCLmzxqmo/2X0k8kHPjROJkLtTyK74E5zjwTb8AosaznkLbnAyfBtgVnf3/b8p
         8VVQ==
X-Gm-Message-State: APjAAAWZfTZumdszW3RPA89hSJkvl+zSTPsOiGpEnKvQvLCwz0c7POyR
        aCPNEUxNKiBtfIZIP2FgVa+E6/kHvUI=
X-Google-Smtp-Source: APXvYqwLmLOsabtf2cD0Vzz4ypj4IJzBjQ1RyqKJitFnVO3IQJ99uXnC6n31eX0PihaDbCwJxwityA==
X-Received: by 2002:a17:902:9f82:: with SMTP id g2mr52284368plq.63.1568416969778;
        Fri, 13 Sep 2019 16:22:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:49 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 5/7] irqchip/irq-bcm2836: Add support for the 7211 interrupt controller
Date:   Fri, 13 Sep 2019 16:22:34 -0700
Message-Id: <20190913232236.10200-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root interrupt controller on 7211 is about identical to the one
existing on BCM2836, except that the SMP cross call are done through the
standard ARM GIC-400 interrupt controller. This interrupt controller is
used for side band wake-up signals though.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm2836.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 2038693f074c..77fa395c8f6b 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -112,6 +112,8 @@ static int bcm2836_map(struct irq_domain *d, unsigned int irq,
 		return -EINVAL;
 	}
 
+	chip->flags |= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
+
 	irq_set_percpu_devid(irq);
 	irq_domain_set_info(d, irq, hw, chip, d->host_data,
 			    handle_percpu_devid_irq, NULL, NULL);
@@ -216,8 +218,9 @@ static void bcm2835_init_local_timer_frequency(void)
 	writel(0x80000000, intc.base + LOCAL_PRESCALER);
 }
 
-static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
-						      struct device_node *parent)
+static int __init arm_irqchip_l1_intc_of_init_smp(struct device_node *node,
+						  struct device_node *parent,
+						  bool smp_init)
 {
 	intc.base = of_iomap(node, 0);
 	if (!intc.base) {
@@ -232,11 +235,27 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
-	bcm2836_arm_irqchip_smp_init();
+	if (smp_init)
+		bcm2836_arm_irqchip_smp_init();
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
+
 	return 0;
 }
 
+static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
+						      struct device_node *parent)
+{
+	return arm_irqchip_l1_intc_of_init_smp(node, parent, true);
+}
+
+static int __init bcm7211_arm_irqchip_l1_intc_of_init(struct device_node *node,
+						      struct device_node *parent)
+{
+	return arm_irqchip_l1_intc_of_init_smp(node, parent, false);
+}
+
 IRQCHIP_DECLARE(bcm2836_arm_irqchip_l1_intc, "brcm,bcm2836-l1-intc",
 		bcm2836_arm_irqchip_l1_intc_of_init);
+IRQCHIP_DECLARE(bcm7211_arm_irqchip_l1_intc, "brcm,bcm7211-l1-intc",
+		bcm7211_arm_irqchip_l1_intc_of_init);
-- 
2.17.1

