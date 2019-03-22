Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86156C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539582075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+3bDjJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfCVLFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:05:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfCVLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:05:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id v64so1319985pfb.1;
        Fri, 22 Mar 2019 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H57lZTKcjfmfclS5dtqodrgu9eTd1Qq4Y0N5GE0IP4o=;
        b=e+3bDjJrjIyjman5rmk/6ZK/cfPqXjLJ7f8v8ifIOrv7nJLrSMBqp/l3nkui+TJzZq
         wE/4bsPiojCwy7wJGxDmDrzgsHRB/H1UuKKnuGePaPslTJ2eKAutu8omXKqK+soZ+N5v
         U/PBFeyUVBWjUGdoaNw1g8IZyO9aJ0mto0VGNpnZUwyDOuuVnhNOVM0WLhuuCnsG6fcr
         6dGjjW3qjLjTzOQF7JxpE5wG0i17eVd2IW6ASRTB1UY6BBy+kKbOYr88to7z+LA0r39z
         M6VvY3HD21dgw9xd82GMRbo6/zQXnrJIFpuWZzzjnUdnECdKVRH4EDBy+lTM2+WkXs8M
         dpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H57lZTKcjfmfclS5dtqodrgu9eTd1Qq4Y0N5GE0IP4o=;
        b=QUuamX945H6oXe6gfdxxJLed3ESoKTbiPEdHI5jI8iR8i/6pCEKhdoiP8jxtS3MsIn
         Lkf3fzCq6/S0yvGUvnbG20RyYH8UMJsIQs50rM5BY0gzqghSVvlIqbO19GoLAAPn44vY
         vUn7GTVP6MWjU0mCHR1mICPXGzmVpCycDw0aWJ/CFl6Cuc4Wcju1T/X4GgeUOUo2+XmB
         sJ1eU0PCXmf+jIvPprABUFzTSH1l2zJn+Ixg8tz1SWFo7xe+IiZPUqalsdwl+SOyu1z+
         riY5BxPjxjmLb6xGQTgcyJVTnz4zLpDGEFLeVE2kO4L30rsND0kzglerXvwKEnBD9j6U
         /vaw==
X-Gm-Message-State: APjAAAUZYUDAFzieBBMBx8Pl/l0ztvNBL16tJcJCju9TKWS3vZzGsXjz
        8gYtCX+yJclCNNJMO18JVTA=
X-Google-Smtp-Source: APXvYqwkmvtCcfGn3J/0aqRyLmRIF96uyXi1NVXocf9mKCXYXZ7NzQQp6pva2Ew9E9O3xXqry0lPJA==
X-Received: by 2002:a63:5622:: with SMTP id k34mr8319212pgb.123.1553252743058;
        Fri, 22 Mar 2019 04:05:43 -0700 (PDT)
Received: from localhost.localdomain ([58.173.144.54])
        by smtp.googlemail.com with ESMTPSA id i79sm17257065pfj.28.2019.03.22.04.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 04:05:41 -0700 (PDT)
From:   Ian W MORRISON <ianwmorrison@gmail.com>
To:     benjamin.tissoires@redhat.com, hdegoede@redhat.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] Skip deferred request irqs for devices known to fail
Date:   Fri, 22 Mar 2019 22:05:15 +1100
Message-Id: <20190322110515.21499-1-ianwmorrison@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch ca876c7483b6 "gpiolib-acpi: make sure we trigger edge events at
least once on boot" causes the MINIX family of mini PCs to fail to boot
resulting in a "black screen". 

This patch excludes MINIX devices from executing this trigger in order
to successfully boot.

Cc: stable@vger.kernel.org
Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 259cf6ab969b..8d855dc9b020 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -16,9 +16,21 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/dmi.h>
 
 #include "gpiolib.h"
 
+static const struct dmi_system_id skip_deferred_request_irqs_table[] = {
+	{
+		.ident = "MINIX Z83-4",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
+		},
+	},
+	{}
+};
+
 /**
  * struct acpi_gpio_event - ACPI GPIO event handler data
  *
@@ -1219,18 +1231,24 @@ bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
 }
 
 /* Run deferred acpi_gpiochip_request_irqs() */
+/* but exclude devices known to fail */
 static int acpi_gpio_handle_deferred_request_irqs(void)
 {
 	struct acpi_gpio_chip *acpi_gpio, *tmp;
+	const struct dmi_system_id *dmi_id;
 
-	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
-	list_for_each_entry_safe(acpi_gpio, tmp,
+	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
+
+	if (! dmi_id) {
+		mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+		list_for_each_entry_safe(acpi_gpio, tmp,
 				 &acpi_gpio_deferred_req_irqs_list,
 				 deferred_req_irqs_list_entry)
-		acpi_gpiochip_request_irqs(acpi_gpio);
+			acpi_gpiochip_request_irqs(acpi_gpio);
 
-	acpi_gpio_deferred_req_irqs_done = true;
-	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+		acpi_gpio_deferred_req_irqs_done = true;
+		mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+	}
 
 	return 0;
 }
-- 
2.17.1

