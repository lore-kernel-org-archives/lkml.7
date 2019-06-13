Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA38C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B9E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrUI5Tu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392904AbfFMQxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:22 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34400 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbfFMDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:05:00 -0400
Received: by mail-yw1-f68.google.com with SMTP id a11so1589189ywc.1;
        Wed, 12 Jun 2019 20:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4S5lqn5I3zXmixd7LhbTzQ90QBdVDOadcoSgSK1gCOU=;
        b=KrUI5Tu6zNMBrq05zotXrdh9heUiqi7xbScH8EwQOyONcKXTp+CvKgkRTWE9zi6lMT
         HMLoFTwcZ7c+TNNMB5soGWw7BFAfNpkhSALhb3mm342GBFL/CxEDkSM7Fsu5fAUcIXSy
         l1cj2//rqY43Alm0AGi8cRXB32HsXsnp3zTgSTPoXkHlpmRju0Rdxxt501uDvGPOZk4V
         f2gY0tdJxiOwEPeWShAVOFyxDBwoyGOC9xProejMYqscuTJYMxjg36z708/lHQA6z/Ho
         z2y3tw/7KjJZCGOY54vPJOz5U667wbE1OgG2iktoXPxHQ+OQB/EDzyzBhhRjUHGaLylO
         D92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4S5lqn5I3zXmixd7LhbTzQ90QBdVDOadcoSgSK1gCOU=;
        b=W1P/eHwxYnDnoIfcdN2zh+zjH/AQm4qFvN18dOlTaWXsy8DhC13T/NVDMRXUlgBFEj
         t5mS86T38VUOzMeM7iLH/rvFtB7u4JQdKnN0so1b2+wbnVrDY5vC9ctA5kFK156iXr0D
         Vpm+mprbjXAJAImXyXf5AtIcFTVriuq38y2dTvPEMrKvmHkHU5zVRc2vylGdRo6o14p7
         OBTXAxNEeKMG/OkDwShR3E5yyIzOGOdRWKY4ej4lcvAiEI4gbJQN+AULNhPNoIel21oQ
         zJaxTZRGlZNjEzePovPfiKwdB4FIQc8OwAhv2+rm1/ZSaa8F5/rKjwsg8WL69E+93zZE
         20yQ==
X-Gm-Message-State: APjAAAX/bsQG5CB8BoBUJvyCly8X1u0KWcXAVId597CWbeAUVH1rn5iU
        TLJRCMDQkqyC3XR06hJ8Bm0YcEiIDw==
X-Google-Smtp-Source: APXvYqylhQw4ltDpktiVjx6zWXMhigkwD7C2gG3zsJn/8dmWhxog4MIBDsp1oOp0vLh0T00iuPwzGQ==
X-Received: by 2002:a81:3358:: with SMTP id z85mr46704537ywz.251.1560395099163;
        Wed, 12 Jun 2019 20:04:59 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.04.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:04:58 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 4/8] platform/x86: huawei-wmi: control micmute LED through WMI interface
Date:   Wed, 12 Jun 2019 23:04:11 -0400
Message-Id: <20190613030416.25807-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using HWMI interface, micmute LED can be controlled on supported models.
`MateBook X` from 2017, doesn't provide controlling the micmute
LED through this interface instead it uses another "legacy" interface
that is not "fully" implemented yet.
Currently, this "legacy" interface is used for hotkeys on this specific
model. A quirk is set to use ACPI method to control micmute LED on
MateBook X (2017).

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 74 ++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 647c5a6c8ab3..358d9d168300 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -239,42 +239,52 @@ static int huawei_wmi_cmd(struct device *dev, u64 arg, u8 *buf, size_t buflen)
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
-	char *acpi_method;
-	acpi_handle handle;
-	acpi_status status;
-	union acpi_object args[3];
-	struct acpi_object_list arg_list = {
-		.pointer = args,
-		.count = ARRAY_SIZE(args),
-	};
-
-	handle = ec_get_handle();
-	if (!handle) {
-		dev_err(led_cdev->dev->parent, "Failed to get EC handle\n");
-		return -ENODEV;
-	}
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
 
-	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
-	args[1].integer.value = 0x04;
-
-	if (acpi_has_method(handle, "SPIN")) {
-		acpi_method = "SPIN";
-		args[0].integer.value = 0;
-		args[2].integer.value = brightness ? 1 : 0;
-	} else if (acpi_has_method(handle, "WPIN")) {
-		acpi_method = "WPIN";
-		args[0].integer.value = 1;
-		args[2].integer.value = brightness ? 0 : 1;
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
+		if (ACPI_FAILURE(status)) {
+			return -ENODEV;
+		}
+
+		return 0;
 	} else {
-		return -ENODEV;
-	}
+		u8 arg[8];
 
-	status = acpi_evaluate_object(handle, acpi_method, &arg_list, NULL);
-	if (ACPI_FAILURE(status)) {
-		return -ENODEV;
-	}
+		*(u64 *)arg = MICMUTE_LED_SET;
+		arg[2] = brightness;
 
-	return 0;
+		return huawei_wmi_cmd(led_cdev->dev->parent, *(u64 *)arg, NULL, NULL);
+	}
 }
 
 static int huawei_wmi_leds_setup(struct device *dev)
-- 
2.20.1

