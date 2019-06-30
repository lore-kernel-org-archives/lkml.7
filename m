Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC26C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F75208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJFvM45d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF3Flq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46373 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfF3Fln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id l125so6723218vsl.13;
        Sat, 29 Jun 2019 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZ9bQ4qlIvn0nmi3/fOq2/nuJUUiXRlbGalFjI3uA7I=;
        b=MJFvM45dSjeXQnIwgGChPqc4FraiBlk+gI9fp7jI8CBRA73+ZssYzngmHfnLilOpnE
         shixoE/eoDN/4fRgXOqNDjLu1sbxLAFUM9hPLLxWa+veRZUPI1PvJJDqQ984NR8EztKY
         +HJ0fsrQlwyZ7X9tK1IqCY4PG6dussZwiRgxI21ab1CXYBfM9oGbGM8dJ3ajETQ4wsPk
         dMp2IZOdJ1fhP3rJXWvvscEnbqV2CIUQhfwA+VXQRNc1m2pbjQ3LER1cHZJMlOID0VMp
         RorLT60EuDiJPyuC1xiynE3DrcU6qeiA25PCGrH+0TSvWoGBfO20A9z7PghDXyI5Q07s
         jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZ9bQ4qlIvn0nmi3/fOq2/nuJUUiXRlbGalFjI3uA7I=;
        b=YLUH1qzQW8dphStthDHPueGmZmiz3ekn3y8pxoweppVbpajFVHEQuhKLCgrJujbxKP
         MHkx2SrXH/McgR/a6GjfZwIhKnsL3QI0ITFNF6G1HmWVtTIT0xbwF6qZA2X8a+5GBoOc
         Ox+7MY8rr9kyNuvl3aVZWURXTJ08+/XQdj0cx+Zhicc5R2P2shYKRHhcPlnGbKFmDd3z
         cZB+E+RlZ7ExWrvfmMPHHABrI0DjfjRruLGpamIDXD9AD8r00J9AAG2Y2d9eMKpQmsVT
         K6pvTiheitc+x1ECGussFWGslgf4Y5aVCfVhFjkMcTWogMt8qGRol/JwVbz3wsZKByj8
         41BA==
X-Gm-Message-State: APjAAAUCBLdqlBSkH0q0HnyR8GZVHYjCdutUDf5p+UJrzEsIa+tc0HXf
        sjSb1Uxd8gahNgkTSseJmA==
X-Google-Smtp-Source: APXvYqzcsnxe1ixaVvXGxui+zIBMylqPDrCwwR84fAUxX2R7ER30T4/9RM55EcjLobAyizJTve4yrQ==
X-Received: by 2002:a67:2586:: with SMTP id l128mr10987147vsl.52.1561873301726;
        Sat, 29 Jun 2019 22:41:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:41 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 5/9] platform/x86: huawei-wmi: Control micmute led through wmi interface
Date:   Sun, 30 Jun 2019 01:41:04 -0400
Message-Id: <20190630054108.19205-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that huawei WMI management interface is implemented, micmute LED can
be controlled easily through this interface. Exception is the Matebook X
(2017) which continue to uses ACPI EC method to control the LED. This
model can control the LED through the legacy WMI interface which is not
implemented ATM.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 86 ++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 8f918138053a..9013a05d2832 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -46,8 +46,6 @@ static struct quirk_entry *quirks;
 struct huawei_wmi_priv {
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
-	acpi_handle handle;
-	char *acpi_method;
 	struct mutex wmi_lock;
 	struct platform_device *pdev;
 };
@@ -238,49 +236,57 @@ static int huawei_wmi_cmd(struct device *dev, u64 arg, u8 *buf, size_t buflen)
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev->parent);
-	acpi_status status;
-	union acpi_object args[3];
-	struct acpi_object_list arg_list = {
-		.pointer = args,
-		.count = ARRAY_SIZE(args),
-	};
-
-	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
-	args[1].integer.value = 0x04;
-
-	if (strcmp(priv->acpi_method, "SPIN") == 0) {
-		args[0].integer.value = 0;
-		args[2].integer.value = brightness ? 1 : 0;
-	} else if (strcmp(priv->acpi_method, "WPIN") == 0) {
-		args[0].integer.value = 1;
-		args[2].integer.value = brightness ? 0 : 1;
+	/* This is a workaround until the "legacy" interface is implemented. */
+	if (quirks && quirks->ec_micmute) {
+		char *acpi_method;
+		acpi_handle handle;
+		acpi_status status;
+		union acpi_object args[3];
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
+
+		handle = ec_get_handle();
+		if (!handle) {
+			dev_err(led_cdev->dev->parent, "Failed to get EC handle\n");
+			return -ENODEV;
+		}
+
+		args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
+		args[1].integer.value = 0x04;
+
+		if (acpi_has_method(handle, "SPIN")) {
+			acpi_method = "SPIN";
+			args[0].integer.value = 0;
+			args[2].integer.value = brightness ? 1 : 0;
+		} else if (acpi_has_method(handle, "WPIN")) {
+			acpi_method = "WPIN";
+			args[0].integer.value = 1;
+			args[2].integer.value = brightness ? 0 : 1;
+		} else {
+			return -ENODEV;
+		}
+
+		status = acpi_evaluate_object(handle, acpi_method, &arg_list, NULL);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		return 0;
 	} else {
-		return -EINVAL;
-	}
+		u8 arg[8];
 
-	status = acpi_evaluate_object(priv->handle, priv->acpi_method, &arg_list, NULL);
-	if (ACPI_FAILURE(status))
-		return -ENXIO;
+		*(u64 *)arg = MICMUTE_LED_SET;
+		arg[2] = brightness;
 
-	return 0;
+		return huawei_wmi_cmd(led_cdev->dev->parent, *(u64 *)arg, NULL, NULL);
+	}
 }
 
 static int huawei_wmi_leds_setup(struct device *dev)
 {
 	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
 
-	priv->handle = ec_get_handle();
-	if (!priv->handle)
-		return 0;
-
-	if (acpi_has_method(priv->handle, "SPIN"))
-		priv->acpi_method = "SPIN";
-	else if (acpi_has_method(priv->handle, "WPIN"))
-		priv->acpi_method = "WPIN";
-	else
-		return 0;
-
 	priv->cdev.name = "platform::micmute";
 	priv->cdev.max_brightness = 1;
 	priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
@@ -412,9 +418,15 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&priv->wmi_lock);
+
+		err = huawei_wmi_leds_setup(&pdev->dev);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to setup leds\n");
+			return err;
+		}
 	}
 
-	return huawei_wmi_leds_setup(&pdev->dev);
+	return 0;
 }
 
 static int huawei_wmi_remove(struct platform_device *pdev)
-- 
2.20.1

