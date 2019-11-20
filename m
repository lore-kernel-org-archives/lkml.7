Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FEB20855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKTTUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:20:31 -0500
Received: from goliath.siemens.de ([192.35.17.28]:42197 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKTTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:20:30 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id xAKJKF28030990
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 20:20:15 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xAKJKFQf024611;
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
Subject: [PATCH v3 2/2] gpio: sch: Hook into ACPI SCI handler to catch GPIO edge events
Date:   Wed, 20 Nov 2019 20:20:14 +0100
Message-Id: <bf556de14a3d093072e50b6a6cf3c64bd62b1730.1574277614.git.jan.kiszka@siemens.com>
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

The ACPI description on the Quark platform does not provide the required
information to do establish generic handling. Therefore, we need to hook
from the driver directly into SCI handler of the ACPI subsystem in order
to catch and report GPIO-related events.

Validated on the Quark-based IOT2000 platform.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-sch.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 6a9c5500800c..75c95da145d8 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -155,6 +155,31 @@ static const struct gpio_chip sch_gpio_chip = {
 	.to_irq			= sch_gpio_to_irq,
 };
 
+static u32 sch_sci_handler(void *context)
+{
+	struct sch_gpio *sch = context;
+	unsigned long core_status, resume_status;
+	unsigned int resume_gpios, offset;
+
+	core_status = inl(sch->iobase + GTS);
+	resume_status = inl(sch->iobase + GTS + 0x20);
+
+	if (core_status == 0 && resume_status == 0)
+		return ACPI_INTERRUPT_NOT_HANDLED;
+
+	for_each_set_bit(offset, &core_status, sch->resume_base)
+		generic_handle_irq(sch->irq_base + offset);
+
+	resume_gpios = sch->chip.ngpio - sch->resume_base;
+	for_each_set_bit(offset, &resume_status, resume_gpios)
+		generic_handle_irq(sch->irq_base + sch->resume_base + offset);
+
+	outl(core_status, sch->iobase + GTS);
+	outl(resume_status, sch->iobase + GTS + 0x20);
+
+	return ACPI_INTERRUPT_HANDLED;
+}
+
 static int sch_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -215,6 +240,7 @@ static int sch_gpio_probe(struct platform_device *pdev)
 	struct irq_chip_type *ct;
 	struct sch_gpio *sch;
 	struct resource *res;
+	acpi_status status;
 	int irq_base, ret;
 
 	sch = devm_kzalloc(&pdev->dev, sizeof(*sch), GFP_KERNEL);
@@ -303,6 +329,10 @@ static int sch_gpio_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	status = acpi_install_sci_handler(sch_sci_handler, sch);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.16.4

