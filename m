Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FEC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6QxSZfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfGaRxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:31 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44679 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfGaRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id l79so25249070ywe.11;
        Wed, 31 Jul 2019 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZ9bQ4qlIvn0nmi3/fOq2/nuJUUiXRlbGalFjI3uA7I=;
        b=i6QxSZfkIyq5TKFGaTNeNkQ4cJFz60M1HM+Mz6TdHb57MaE4cAaMuRLApZoOusKCJ1
         bfoM1I970P3hEqUe/jhd7iXTZj7hAMJIPEq0EfLXE9CZF+FiRl9wBlSe5v1IObP53muG
         FU36aHFS9gxYFbiXE/EjZ1X/1lJ7GwGU6b2Z0bnWQZBc+2WUJb41WDqVQjFnww5clYGr
         7dVFN7vfidGiH6KdtP3gmdb+n6eR/cje+o1idClYP5Vhwna+oWXxXg7SUKUTWyv1CFS8
         MW9Mhpz4n9wmf3e6JWWpn1qtH+7QHkZxLvZLkYHgKGMuDza4zERal0srjHczo2iMAY9i
         o1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZ9bQ4qlIvn0nmi3/fOq2/nuJUUiXRlbGalFjI3uA7I=;
        b=jkUO0f8ZysP8sITDcmKR7LGf+nlBdcWeWBnbuj52ev2fuQycrgkIeVY757LWoalDZV
         RLC0eeuEXw4y/vvdCqWtrCH+JiDjD5L2srfJLBSEwsxmbV9nox/TBEuWU0avSDo51lJ+
         k3Cy45e3mbxwKfrhenOhtN62sJ5t655tKh9eXFDRND7uQTyA/6KKP96kXuW2gUr43mDY
         RIRY+Vt94n63+ie1ba01mSF1eXtAb0UyPmjbrskrc7xcuJnYjTftmQNvJA7ilSQ+iVN4
         VMbzXGN8ZBCU+Bmbi3fJVVrttn7ILMy5VbG0OIt+Sd5XG1gSULWqNSJOE2TKYN6nSxNn
         AHYQ==
X-Gm-Message-State: APjAAAXkLDFgeFRkkaUvyMgNN5qIeOZafvNBix1W7fMpvoud310PBTo3
        SQuNNN7lvhXG5t8TC2fFQg==
X-Google-Smtp-Source: APXvYqxZahjTwEiFR8+YnzaToBYJqEk10aFO7u84onDnGBYXIB4RuD4c52wOK3rEV324N7h+8+EmhQ==
X-Received: by 2002:a0d:df47:: with SMTP id i68mr78055398ywe.151.1564595607426;
        Wed, 31 Jul 2019 10:53:27 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:26 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 5/9] platform/x86: huawei-wmi: Control micmute led through wmi interface
Date:   Wed, 31 Jul 2019 13:52:51 -0400
Message-Id: <20190731175255.25676-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731175255.25676-1-ayman.bagabas@gmail.com>
References: <20190731175255.25676-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
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


