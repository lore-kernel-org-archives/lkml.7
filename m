Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D395C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BE1206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CNKHe9QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKUVLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:11:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46636 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKUVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:11:10 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so5136808iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqHZ4m2Kb1nVikc9JBJTUdDh4K08lzxOK7BztY3CPPg=;
        b=CNKHe9QKX5rkVfl48ln59vFYW4WKlV0PzynmhLTlV1ZCEPwbdh7m9/lGjsjJAB2vuh
         oU7wz+IQOZBwFjsNjvovRPlvTSgbZeK68/EF3DjXX3OV+5bTsCAK0jp4OusjdNMLl1+n
         xI80W8HrbVAy4k2AurpxTAT5/BYivH8KsE1DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqHZ4m2Kb1nVikc9JBJTUdDh4K08lzxOK7BztY3CPPg=;
        b=kCM0KfAMvQyPXYYaVw7CcAtQP9pdibu+FHedWOCfTjbto/XIAGIXer/3ovGs4M3LfH
         n8IjjbFVpvoyLyVUZAy9sjkWU2EJevqALSqsA6LHzryzqZM9ZcXObQ9zu2TXxGhOtdFx
         XMOZ5lWqmo2A2z/Q73EfsEEn7OEHfTreJgSKlnHZv0By+l5S39hMMyfaQhvLH31Po0Fz
         yrjGUnueKCewPj4zIu2pFvJQkfaN+/PwUTjOE/lqcFZqylGnjevZnwOhBcj1kv8UOl7C
         ibx+dvhztw67+9I2WFGX5JUJ1UB2GLP1/3XFl134lZac5n2tHh6M8fpg0zt0nVuoe8fv
         Lw0g==
X-Gm-Message-State: APjAAAUdPppigVPKv33/Ag75Uc18bJDySruAfuZYKtEqPhsdRY1+88kW
        xvY+MzRFpP2lzj/UKJmF5ExACQ==
X-Google-Smtp-Source: APXvYqxcU0GD0yzNKIBLmIuoo6t5CXAl1CPRi/D6cXgb4BiHgAKKYgT2Z1yGXO1tt6IufzPDXOby9A==
X-Received: by 2002:a02:52c9:: with SMTP id d192mr10650700jab.29.1574370669358;
        Thu, 21 Nov 2019 13:11:09 -0800 (PST)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id n12sm1348770iob.71.2019.11.21.13.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 13:11:09 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc:     Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: [PATCH 3/4] platform/chrome: cros_ec: Pass firmware node to MFD device
Date:   Thu, 21 Nov 2019 14:10:52 -0700
Message-Id: <20191121140830.3.I1fbda3ecf40f4631420cbb75ba830d2d3b3bac1e@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191121211053.48861-1-rrangel@chromium.org>
References: <20191121211053.48861-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_dev needs to have a firmware node associated with it so mfd
cells can be properly bound to the correct ACPI/DT nodes.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

Before this patch:
$ find /sys/bus/platform/devices/cros-ec-* -iname firmware_node -exec ls -l '{}' \;
<nothing>

After this patch:
$ find /sys/bus/platform/devices/cros-ec-dev.0.auto/ -iname firmware_node -exec ls -l '{}' \;
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-accel.1.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-chardev.7.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-debugfs.8.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-gyro.2.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-lid-angle.4.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-lightbar.9.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-pd-sysfs.10.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-ring.3.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-sysfs.11.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-usbpd-charger.5.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/cros-usbpd-logger.6.auto/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00
/sys/bus/platform/devices/cros-ec-dev.0.auto/firmware_node -> ../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00

 drivers/platform/chrome/cros_ec.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 51d76037f52a..3c08c9098d29 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -167,9 +167,16 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	}
 
 	/* Register a platform device for the main EC instance */
-	ec_dev->ec = platform_device_register_data(ec_dev->dev, "cros-ec-dev",
-					PLATFORM_DEVID_AUTO, &ec_p,
-					sizeof(struct cros_ec_platform));
+	ec_dev->ec =
+		platform_device_register_full(&(struct platform_device_info){
+			.parent = ec_dev->dev,
+			.name = "cros-ec-dev",
+			.id = PLATFORM_DEVID_AUTO,
+			.data = &ec_p,
+			.size_data = sizeof(struct cros_ec_platform),
+			.fwnode = ec_dev->dev->fwnode,
+			.of_node_reused = 1});
+
 	if (IS_ERR(ec_dev->ec)) {
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
-- 
2.24.0.432.g9d3f5f5b63-goog

