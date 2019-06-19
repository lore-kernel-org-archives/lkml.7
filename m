Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113BC214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfFSOuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:50:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:30727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFSOuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:50:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 07:50:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="162065638"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2019 07:50:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B59F162; Wed, 19 Jun 2019 17:50:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/x86: intel_int0002_vgpio: Get rid of custom ICPU() macro
Date:   Wed, 19 Jun 2019 17:50:50 +0300
Message-Id: <20190619145050.13876-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom grown macro with generic INTEL_CPU_FAM6() one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_int0002_vgpio.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index 1694a9aec77c..d9542c661ddc 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -51,17 +51,6 @@
 #define GPE0A_STS_PORT			0x420
 #define GPE0A_EN_PORT			0x428
 
-#define BAYTRAIL			0x01
-#define CHERRYTRAIL			0x02
-
-#define ICPU(model, data) { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, data }
-
-static const struct x86_cpu_id int0002_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT, BAYTRAIL), /* Valleyview, Bay Trail  */
-	ICPU(INTEL_FAM6_ATOM_AIRMONT, CHERRYTRAIL), /* Braswell, Cherry Trail */
-	{}
-};
-
 /*
  * As this is not a real GPIO at all, but just a hack to model an event in
  * ACPI the get / set functions are dummy functions.
@@ -157,6 +146,12 @@ static struct irq_chip int0002_cht_irqchip = {
 	 */
 };
 
+static const struct x86_cpu_id int0002_cpu_ids[] = {
+	INTEL_CPU_FAM6(ATOM_SILVERMONT, int0002_byt_irqchip),	/* Valleyview, Bay Trail  */
+	INTEL_CPU_FAM6(ATOM_AIRMONT, int0002_cht_irqchip),	/* Braswell, Cherry Trail */
+	{}
+};
+
 static int int0002_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -210,10 +205,7 @@ static int int0002_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (cpu_id->driver_data == BAYTRAIL)
-		irq_chip = &int0002_byt_irqchip;
-	else
-		irq_chip = &int0002_cht_irqchip;
+	irq_chip = (struct irq_chip *)cpu_id->driver_data;
 
 	ret = gpiochip_irqchip_add(chip, irq_chip, 0, handle_edge_irq,
 				   IRQ_TYPE_NONE);
-- 
2.20.1

