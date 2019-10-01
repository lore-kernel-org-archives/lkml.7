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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6933721906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvfH0JGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfJAWtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:49:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36048 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfJAWtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:49:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so2220499pgk.3;
        Tue, 01 Oct 2019 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xm5+dOflKaTZIVZnokmYc6eT45ykFCPyC442ihyZjok=;
        b=AvfH0JGGeod+exu/4O98hP0w0MWFeU5MDDpIqUf0TxoaWb1lRZPOWwJPHNdzFqp4tw
         MgAlSLOWBgHZ/hmrbWf3PkeKubOGzkKobVGw+AHTePEjd8si0p/WLEM+ULC+KScAR56l
         fM5P1gsFioiPQs63FnNdMbuWrrF8rgX+OuFOszZb7ns/1sPsrtdXwuz7WMAYXGrXr87i
         qqblRzyMKzRu7B3z3rMSboEPo2AKSVNMZNMn39FrjwAtDYdRkkR0YMzQfCk+RyGFYlyL
         uGt/XcWwCNyxv7UCEn5XQQgNgKp7cANUUu8zpMt1SebldmTK4GVIf6/rsiiEDJiQcv0w
         1nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xm5+dOflKaTZIVZnokmYc6eT45ykFCPyC442ihyZjok=;
        b=YhxsVQKB7xjk0XXBjz0hawPkKdMFj6tllc/lkFY7P8b42j8/wUHe0rxwXaDutIAZz8
         T2loYstigi6AZIIlzTkz9Zz7qPO0/L3Z3bu1LExkKnh6g8tjRmnTyvDnI/5lPPyyadk0
         E/veE5ZDnWF5H6/kZOj4wx8LU4dbM3MrdVfktu8xo7cGAl0+TF9qCyuvyFQWRMf6dQ0O
         yU+c4BKC8oUYn/o8kCKUy/L6F9o4SUw4VhVwvaN2KD8AjGryBFNytguV53OCcuFYdFFl
         getmQ4axhhkY8F9eekhjcojscTromCV2gpODuj71Mr80CtI7d0oyvEjZ0tHfLEgtm3HZ
         lt6Q==
X-Gm-Message-State: APjAAAVaYnnhKZlmj59SDhB2COrY53bULb8gFAIT1tmTzKp7OliBuDJe
        3IvASx6TGnjvLQLhN6MPRoTBsvBV
X-Google-Smtp-Source: APXvYqyELX0xr8bTqUc9jiZz9X1yUX+9gWsgaesoSqUgFW6SMdUD/tGFBJr4cN1mY9BwQJ17kpCwlw==
X-Received: by 2002:a62:2a04:: with SMTP id q4mr882217pfq.120.1569970141963;
        Tue, 01 Oct 2019 15:49:01 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:49:01 -0700 (PDT)
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
Subject: [PATCH 5/7] irqchip/irq-bcm2836: Add support for the 7211 interrupt controller
Date:   Tue,  1 Oct 2019 15:48:40 -0700
Message-Id: <20191001224842.9382-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
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

