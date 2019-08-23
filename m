Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF7DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EE620850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404529AbfHWRsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:48:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfHWRsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E7A13086218;
        Fri, 23 Aug 2019 17:48:23 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (unknown [10.36.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5C95D9CA;
        Fri, 23 Aug 2019 17:48:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: intel_int0002_vgpio: Use device_init_wakeup
Date:   Fri, 23 Aug 2019 19:48:15 +0200
Message-Id: <20190823174815.27861-2-hdegoede@redhat.com>
In-Reply-To: <20190823174815.27861-1-hdegoede@redhat.com>
References: <20190823174815.27861-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 23 Aug 2019 17:48:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_init_wakeup and pm_wakeup_hard_event instead of directly
calling pm_system_wakeup(). This is the preferred way to do this and
this will allow the user to disable wakeup through INT0002 events
through sysfs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_int0002_vgpio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index 9ea1a2a19f86..f9fee682a8a2 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -122,7 +122,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
 	generic_handle_irq(irq_find_mapping(chip->irq.domain,
 					    GPE0A_PME_B0_VIRT_GPIO_PIN));
 
-	pm_system_wakeup();
+	pm_wakeup_hard_event(chip->parent);
 
 	return IRQ_HANDLED;
 }
@@ -217,6 +217,13 @@ static int int0002_probe(struct platform_device *pdev)
 
 	gpiochip_set_chained_irqchip(chip, irq_chip, irq, NULL);
 
+	device_init_wakeup(dev, true);
+	return 0;
+}
+
+static int int0002_remove(struct platform_device *pdev)
+{
+	device_init_wakeup(&pdev->dev, false);
 	return 0;
 }
 
@@ -232,6 +239,7 @@ static struct platform_driver int0002_driver = {
 		.acpi_match_table	= int0002_acpi_ids,
 	},
 	.probe	= int0002_probe,
+	.remove	= int0002_remove,
 };
 
 module_platform_driver(int0002_driver);
-- 
2.22.0

