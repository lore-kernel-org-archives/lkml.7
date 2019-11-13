Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1787222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFTJqj1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfKMDL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:11:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41438 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfKMDLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:11:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so426410plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 19:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJiK++JIPldTLL1wRXseicOTaXcBO5MXmJRFC+IoCVk=;
        b=NFTJqj1tlASRiXMu7xA4iajDi0F6YRuNSKAa3RVV888rdWUGkk2E0H2W6umwHVSqZa
         Iv65aeEm7Q+iNaYkusXo3eJhoNIOP++dtVSk71pT1Rfp40rcTIcEJWevTubDs4kQOFEy
         N449B2gX86KmOQKBbGCAQDiv21PykNSTKcd6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJiK++JIPldTLL1wRXseicOTaXcBO5MXmJRFC+IoCVk=;
        b=AcCjMz5dR1Hh1/scmP+rHgo0oVs9DVHhkyZO6KGBzC3EtnMj+5kJ3+GM9Qo8IQw5Ob
         huDXkPaT8G+pBsHHlwSD/NQH8uu+0sTkPAicbKmUX7IkaAKDjS7CtSf28g+TjnWuJJ9t
         gvga0TreLKyFFUAPajELLD4+Yik3FyrUcMUIFl/+uyFkbOz0rMt4qzgxiBF0W8jvU14E
         uSuqzgrlR9SfUZofOU+n3/sXywOwUVXAIIdJYu4cb0zIzJvTtEYWmw1XEhB2nOtsic/A
         z5Hi4TuraKR37tJmS7KNEN6LoaR36L1QsX03vh5NRmrHobYsiiuUDPcNEamWJAKVRFyy
         PqVA==
X-Gm-Message-State: APjAAAWQxozuv3m9kCGWG5piAnMq1EYp43A+yBZW8eoZiBfolFStvmnI
        NZPDeRH04VolrvN/QsxWCHosKnGKdcw=
X-Google-Smtp-Source: APXvYqz47kRH6qlKsHFl+BtN8uvKToCaT0ncLeVdaF9yT1A5suX9g5s3Etylww3Ror5K8IZ8k6VimA==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr1245743pls.255.1573614684422;
        Tue, 12 Nov 2019 19:11:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:1b1f:9c69:179b:de9a])
        by smtp.gmail.com with ESMTPSA id z23sm439227pgu.16.2019.11.12.19.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 19:11:24 -0800 (PST)
From:   Jon Flatley <jflat@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org, sre@kernel.org,
        jflat@chromium.org
Subject: [PATCH 2/3] power: supply: cros-ec-usbpd-charger: Fix host events
Date:   Tue, 12 Nov 2019 19:10:43 -0800
Message-Id: <20191113031044.136232-3-jflat@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191113031044.136232-1-jflat@chromium.org>
References: <20191113031044.136232-1-jflat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug on ACPI platforms where host events from the ECPD ACPI
device never make their way to the cros-ec-usbpd-charger driver. This
makes it so the only time the charger driver updates its state is when
user space accesses its sysfs attributes.

Now that these events have been unified into a single notifier chain on
both ACPI and non-ACPI platforms the charger driver can just be updated
to use this new notifer.

Signed-off-by: Jon Flatley <jflat@chromium.org>
---
 drivers/power/supply/Kconfig              |  2 +-
 drivers/power/supply/cros_usbpd-charger.c | 45 ++++++++---------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c84a7b1caeb6..7664849d7680 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -659,7 +659,7 @@ config CHARGER_RT9455
 
 config CHARGER_CROS_USBPD
 	tristate "ChromeOS EC based USBPD charger"
-	depends on CROS_EC
+	depends on CROS_EC_USBPD_NOTIFY
 	default n
 	help
 	  Say Y here to enable ChromeOS EC based USBPD charger
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 6cc7c3910e09..58cf51b51179 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -8,6 +8,7 @@
 #include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_usbpd_notify.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -524,32 +525,22 @@ static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
 }
 
 static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
-				       unsigned long queued_during_suspend,
+				       unsigned long host_event,
 				       void *_notify)
 {
-	struct cros_ec_device *ec_device;
 	struct charger_data *charger;
-	u32 host_event;
 
 	charger = container_of(nb, struct charger_data, notifier);
-	ec_device = charger->ec_device;
 
-	host_event = cros_ec_get_host_event(ec_device);
-	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
-		return NOTIFY_OK;
-	} else {
-		return NOTIFY_DONE;
-	}
+	cros_usbpd_charger_power_changed(charger->ports[0]->psy);
+	return NOTIFY_OK;
 }
 
 static void cros_usbpd_charger_unregister_notifier(void *data)
 {
 	struct charger_data *charger = data;
-	struct cros_ec_device *ec_device = charger->ec_device;
 
-	blocking_notifier_chain_unregister(&ec_device->event_notifier,
-					   &charger->notifier);
+	cros_ec_usbpd_unregister_notify(&charger->notifier);
 }
 
 static int cros_usbpd_charger_probe(struct platform_device *pd)
@@ -683,21 +674,17 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 		goto fail;
 	}
 
-	if (ec_device->mkbp_event_supported) {
-		/* Get PD events from the EC */
-		charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
-		ret = blocking_notifier_chain_register(
-						&ec_device->event_notifier,
-						&charger->notifier);
-		if (ret < 0) {
-			dev_warn(dev, "failed to register notifier\n");
-		} else {
-			ret = devm_add_action_or_reset(dev,
-					cros_usbpd_charger_unregister_notifier,
-					charger);
-			if (ret < 0)
-				goto fail;
-		}
+	/* Get PD events from the EC */
+	charger->notifier.notifier_call = cros_usbpd_charger_ec_event;
+	ret = cros_ec_usbpd_register_notify(&charger->notifier);
+	if (ret < 0) {
+		dev_warn(dev, "failed to register notifier\n");
+	} else {
+		ret = devm_add_action_or_reset(dev,
+				cros_usbpd_charger_unregister_notifier,
+				charger);
+		if (ret < 0)
+			goto fail;
 	}
 
 	return 0;
-- 
2.24.0.432.g9d3f5f5b63-goog

