Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B15F20855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKTTUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:20:31 -0500
Received: from thoth.sbs.de ([192.35.17.2]:52705 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfKTTUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:20:30 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id xAKJKFIU022295
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 20:20:15 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xAKJKFQe024611;
        Wed, 20 Nov 2019 20:20:15 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 1/2] gpio: sch: Add edge event support
Date:   Wed, 20 Nov 2019 20:20:13 +0100
Message-Id: <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1574277614.git.jan.kiszka@siemens.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1574277614.git.jan.kiszka@siemens.com>
References: <cover.1574277614.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the required infrastructure consisting of an irq_chip_generic with
its irq_chip_type callbacks to enable and report edge events of the pins
to the gpio core. The actual hook-up of the event interrupt will happen
separately.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-sch.c | 114 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index fb143f28c386..6a9c5500800c 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -18,12 +18,17 @@
 #define GEN	0x00
 #define GIO	0x04
 #define GLV	0x08
+#define GTPE	0x0c
+#define GTNE	0x10
+#define GGPE	0x14
+#define GTS	0x1c
 
 struct sch_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
 	unsigned short iobase;
 	unsigned short resume_base;
+	int irq_base;
 };
 
 static unsigned sch_gpio_offset(struct sch_gpio *sch, unsigned gpio,
@@ -79,10 +84,11 @@ static void sch_gpio_reg_set(struct sch_gpio *sch, unsigned gpio, unsigned reg,
 static int sch_gpio_direction_in(struct gpio_chip *gc, unsigned gpio_num)
 {
 	struct sch_gpio *sch = gpiochip_get_data(gc);
+	unsigned long flags;
 
-	spin_lock(&sch->lock);
+	spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GIO, 1);
-	spin_unlock(&sch->lock);
+	spin_unlock_irqrestore(&sch->lock, flags);
 	return 0;
 }
 
@@ -95,20 +101,22 @@ static int sch_gpio_get(struct gpio_chip *gc, unsigned gpio_num)
 static void sch_gpio_set(struct gpio_chip *gc, unsigned gpio_num, int val)
 {
 	struct sch_gpio *sch = gpiochip_get_data(gc);
+	unsigned long flags;
 
-	spin_lock(&sch->lock);
+	spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GLV, val);
-	spin_unlock(&sch->lock);
+	spin_unlock_irqrestore(&sch->lock, flags);
 }
 
 static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned gpio_num,
 				  int val)
 {
 	struct sch_gpio *sch = gpiochip_get_data(gc);
+	unsigned long flags;
 
-	spin_lock(&sch->lock);
+	spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GIO, 0);
-	spin_unlock(&sch->lock);
+	spin_unlock_irqrestore(&sch->lock, flags);
 
 	/*
 	 * according to the datasheet, writing to the level register has no
@@ -130,6 +138,12 @@ static int sch_gpio_get_direction(struct gpio_chip *gc, unsigned gpio_num)
 	return sch_gpio_reg_get(sch, gpio_num, GIO);
 }
 
+static int sch_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
+{
+	struct sch_gpio *sch = gpiochip_get_data(gpio);
+	return sch->irq_base + offset;
+}
+
 static const struct gpio_chip sch_gpio_chip = {
 	.label			= "sch_gpio",
 	.owner			= THIS_MODULE,
@@ -138,12 +152,70 @@ static const struct gpio_chip sch_gpio_chip = {
 	.direction_output	= sch_gpio_direction_out,
 	.set			= sch_gpio_set,
 	.get_direction		= sch_gpio_get_direction,
+	.to_irq			= sch_gpio_to_irq,
 };
 
+static int sch_irq_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct sch_gpio *sch = gc->private;
+	unsigned int gpio_num = d->irq - sch->irq_base;
+	unsigned long flags;
+	int rising = 0;
+	int falling = 0;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+		rising = 1;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		falling = 1;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		rising = 1;
+		falling = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&sch->lock, flags);
+	sch_gpio_reg_set(sch, gpio_num, GTPE, rising);
+	sch_gpio_reg_set(sch, gpio_num, GTNE, falling);
+	spin_unlock_irqrestore(&sch->lock, flags);
+
+	return 0;
+}
+
+static void sch_irq_set_enable(struct irq_data *d, int val)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct sch_gpio *sch = gc->private;
+	unsigned int gpio_num = d->irq - sch->irq_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sch->lock, flags);
+	sch_gpio_reg_set(sch, gpio_num, GGPE, val);
+	spin_unlock_irqrestore(&sch->lock, flags);
+}
+
+static void sch_irq_mask(struct irq_data *d)
+{
+	sch_irq_set_enable(d, 0);
+}
+
+static void sch_irq_unmask(struct irq_data *d)
+{
+	sch_irq_set_enable(d, 1);
+}
+
 static int sch_gpio_probe(struct platform_device *pdev)
 {
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
 	struct sch_gpio *sch;
 	struct resource *res;
+	int irq_base, ret;
 
 	sch = devm_kzalloc(&pdev->dev, sizeof(*sch), GFP_KERNEL);
 	if (!sch)
@@ -203,7 +275,35 @@ static int sch_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sch);
 
-	return devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
+	ret = devm_gpiochip_add_data(&pdev->dev, &sch->chip, sch);
+	if (ret)
+		return ret;
+
+	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
+					NUMA_NO_NODE);
+	if (irq_base < 0)
+		return irq_base;
+	sch->irq_base = irq_base;
+
+	gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
+					 NULL, handle_simple_irq);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->private = sch;
+	ct = gc->chip_types;
+
+	ct->chip.irq_mask = sch_irq_mask;
+	ct->chip.irq_unmask = sch_irq_unmask;
+	ct->chip.irq_set_type = sch_irq_type;
+
+	ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
+					  IRQ_MSK(sch->chip.ngpio),
+					  0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static struct platform_driver sch_gpio_driver = {
-- 
2.16.4

