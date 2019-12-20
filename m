Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB0206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4IdLhQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTTp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:45:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38520 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTTp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:45:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so5772220pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFXuqjqzuhn3j1yuWZII1AUzQtpErQYsp8G46vS6mF4=;
        b=a4IdLhQannJ0qodNcoBz7md9hndFw94LDA+Kg7EBZwStErRSTLpg3OOLjC4tRHqQbZ
         K3ckmn1Cp0U0eBVD0qlUclHoDWHGgP5kXfzaL8A99Z0JTIZHG+XUSkjtxWTTFEnc2qRn
         7lJOQXlin31D9yOAyPxDsEgbNGvvrm98t6mow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OFXuqjqzuhn3j1yuWZII1AUzQtpErQYsp8G46vS6mF4=;
        b=C/Vz0Y7EI6/TVRKBKIGFZY4EhPDkS+a8wz2GcAIc/+hh/O/E6UwgmT97Myk+WQu+AK
         Vrebqi7P6y5CDTFRaOm05Ge8Oc3p4eCABn4KmkxgCP5lRDRGAHwxsNUm45QX5m9412bh
         1+OUFlXr+bHKLKGhNRqfTlx717k3Ip/CN5AixQb3VJjWj8E4w4URQCMGukbpaol/vsDv
         +RbvxtiKro2eH5vEYfSmV9EELWfTmkJXiPEv2vCsvJ+oRDo+YqplKC2bJ18laLMbB/5P
         6QC2puJYAeiomPaVF+fKA6YqTh/0Uw+Two3XqYm1Q7UCPNwmst+UMQ2Ac5AgRuohk4nT
         Sezg==
X-Gm-Message-State: APjAAAVr0j+Nr+QxV6eeTJFT+YZp3qIhxTx1GZIy/8r5KQ+YC4KQxxfi
        JDuLX/eHVkbbWLzXCiQ13Rxhtw==
X-Google-Smtp-Source: APXvYqz4tfLA5dGoFl3czZFqWKsyQLX7lWtx9vJX3GzhFQiR/3+PQHzV0STbyufYZ1IZv9vvRnyJfA==
X-Received: by 2002:a62:7c58:: with SMTP id x85mr18030206pfc.76.1576871128522;
        Fri, 20 Dec 2019 11:45:28 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id e2sm14109577pfh.84.2019.12.20.11.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 11:45:28 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v4 2/2] mfd: cros_ec: Add cros-usbpd-notify subdevice
Date:   Fri, 20 Dec 2019 11:38:47 -0800
Message-Id: <20191220193843.47182-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220193843.47182-1-pmalani@chromium.org>
References: <20191220193843.47182-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cros-usbpd-notify driver as a subdevice on non-ACPI platforms
that support the EC_FEATURE_USB_PD EC feature flag.

This driver allows other cros-ec devices to receive PD event
notifications from the Chrome OS Embedded Controller (EC) via a
notification chain.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v4:
- Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
  mfd_cell and used an IS_ENABLED() check.
- Changed commit title and description slightly to reflect change in
  code.

 drivers/mfd/cros_ec_dev.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index c4b977a5dd966..da198abe2b0a6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014 Google, Inc.
  */
 
+#include <linux/kconfig.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
@@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
 	{ .name = "cros-usbpd-logger", },
 };
 
+static const struct mfd_cell cros_usbpd_notify_cells[] = {
+	{ .name = "cros-usbpd-notify", },
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -202,6 +207,22 @@ static int ec_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * The PD notifier driver cell is separate since it only needs to be
+	 * explicitly added on non-ACPI platforms.
+	 */
+	if (!IS_ENABLED(CONFIG_ACPI)) {
+		if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
+			retval = mfd_add_hotplug_devices(ec->dev,
+					cros_usbpd_notify_cells,
+					ARRAY_SIZE(cros_usbpd_notify_cells));
+			if (retval)
+				dev_err(ec->dev,
+					"failed to add PD notify devices: %d\n",
+					retval);
+		}
+	}
+
 	/*
 	 * The following subdevices cannot be detected by sending the
 	 * EC_FEATURE_GET_CMD to the Embedded Controller device.
-- 
2.24.1.735.g03f4e72817-goog

