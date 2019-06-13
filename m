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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064FC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A74F20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTpvtPBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404409AbfFMQxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:32 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35296 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfFMDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:04:59 -0400
Received: by mail-yb1-f195.google.com with SMTP id v17so7209823ybm.2;
        Wed, 12 Jun 2019 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKWy+MYAC9Qnk4R94EFOwHl0lKGQuAZ2oqXPCo3dOhw=;
        b=JTpvtPBkRmGtQnud9fO2fYZJevc3HJLX591AVdzUF4SmiS18T8U/m2k9xky5KPUMYT
         3xkW9Ykht4kyduPLAN3/qjvuFHcjess1RPLgG8AgdLKLOls8tFlg93kBPwAWayogWELt
         zmsxO/ixd/zeHTcgxad4aRdvBT3ipPCggmAZShGhhIo5MRh3kTgmM+gBqjS31AGp0x1w
         f0sYCrm9yzJ5BHfHbSAJ/YUj72Oi8FZRsfsM6wgFVg60qepxJeqPzQMqKOSUX6dQnmTZ
         o73SaB7mY8WidO2ntPdA4EtXwkq8LsXpW1mjUiZ55YuTcXh6F8t4Ob6eFUrM0wd5YWIw
         Edng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKWy+MYAC9Qnk4R94EFOwHl0lKGQuAZ2oqXPCo3dOhw=;
        b=qBttOupWfLu0C2oVmF4HVi6khNlBQm7gl9c51y0y/IGLdt+cIu7mNz5SFBDN46RVmD
         N+2+T5JS7p11PSb1hobktFHpJwhmvOnau8qeeeLWSn2nEYrLWiaUnMy4zJHz/Dx8zt9J
         JAlSY1NWeyxdR/f4pTdj6KvIcHKR9074X+xH5pd4+yLQJcONmukjPxn9/JVtOgj8mw/1
         pRdIc4dETSP/9DBLDvn/cz1kYb0XaTyp3OJpIHQa9s3J8wOsmHo5UOG7EIPHjfd+Ff10
         pboHKHaUp7L1CQejUEOIz6cVGHM2fscp+HfncZcz1kFWB5T1mGzetQIWpkaiy5kkEly8
         apJQ==
X-Gm-Message-State: APjAAAVrM1Bo04MoeUbesnwJq3qPNnQF3IH73RC4J5QKgxU/eFPys8DH
        gl4UJr9agDfEy6O0T89PTQ==
X-Google-Smtp-Source: APXvYqz7Iw97WcJzg59QpO1fIdasPdVT8+xM6RNGzAz94X5hYmGBPkrdg3oga1rcJqorZbflskpnEg==
X-Received: by 2002:a5b:801:: with SMTP id x1mr38471062ybp.95.1560395097834;
        Wed, 12 Jun 2019 20:04:57 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.04.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:04:57 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 3/8] platform/x86: huawei-wmi: use quirks and module parameters
Date:   Wed, 12 Jun 2019 23:04:10 -0400
Message-Id: <20190613030416.25807-5-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces two parameters to force reporting brightness keys
and sleeping after setting battery thresholds value.
These parameters are implemented as quirks along with `ec_micmute` quirk
which controls the micmute LED through ACPI EC interface.

All newer models that "fully" implement the new interface report
brightness key events twice, once through WMI and once through
acpi-video. Older models, such as `MateBook X`, don't report brightness
events using WMI. This is implemented as a quirk and can be forced using
module parameters.

Some models don't allow setting thresholds to (0, 100), due to bad ASL
code, which indicates reset values, instead, it only turns off battery
charging protection. This would return the currently set values even
though battery protection is off which doesn't make sense. A sane value
like (0, 100) indicates no charging protection, but since it's not
possible to set such values, (0, 0) is set before turning protection
off with (0, 100). This requires a delay after setting (0, 0) and after
(0, 100) so that these values make their way to EC memory.

    Method (SBTT, 1, NotSerialized)
    {
        Name (BUFF, Buffer (0x0100){})
        Local0 = Arg0
        CreateByteField (Arg0, 0x02, STCP)
        CreateByteField (Arg0, 0x03, SOCP)
        CreateByteField (BUFF, Zero, STAT)
        If (((STCP == Zero) && (SOCP == 0x64)))
        {
            \_SB.PCI0.LPCB.EC0.ECXT (0xC7, Zero, Zero, Zero, Zero, Zero)
        }
        Else
        {
            \_SB.PCI0.LPCB.EC0.ECXT (0xC7, One, STCP, SOCP, Zero, Zero)
        }                                // ^    ^     ^
                                         // |    |     |
        STAT = Zero                      // on   low   high
        Return (BUFF) /* \SBTT.BUFF */   // bit  thresh  thresh
    }

ASL code taken from MateBook X Pro (MACH-WX9) showing how it turns off
protection without changing values.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 37b09d497f5e..647c5a6c8ab3 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
@@ -35,6 +36,14 @@ enum {
 	MICMUTE_LED_SET 		= 0x00000b04, /* \SMLS */
 };
 
+struct quirk_entry {
+	bool battery_sleep;
+	bool ec_micmute;
+	bool report_brightness;
+};
+
+static struct quirk_entry *quirks;
+
 struct huawei_wmi {
 	struct led_classdev cdev;
 	struct input_dev *idev[2];
@@ -61,6 +70,58 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+static bool battery_sleep;
+static bool report_brightness;
+
+module_param(battery_sleep, bool, 0444);
+MODULE_PARM_DESC(battery_sleep,
+		"Delay after setting battery charging thresholds.");
+module_param(report_brightness, bool, 0444);
+MODULE_PARM_DESC(report_brightness,
+		"Report brightness key events.");
+
+/* Quirks */
+
+static int __init dmi_matched(const struct dmi_system_id *dmi)
+{
+	quirks = dmi->driver_data;
+	return 1;
+}
+
+static struct quirk_entry quirk_unknown = {
+};
+
+static struct quirk_entry quirk_battery_sleep = {
+	.battery_sleep = true,
+};
+
+static struct quirk_entry quirk_matebook_x = {
+	.ec_micmute = true,
+	.report_brightness = true,
+};
+
+static const struct dmi_system_id huawei_quirks[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "Huawei MACH-WX9",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MACH-WX9"),
+		},
+		.driver_data = &quirk_battery_sleep
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Huawei MateBook X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HUAWEI MateBook X")
+		},
+		.driver_data = &quirk_matebook_x
+	},
+	{  }
+};
+
 /* Utils */
 
 static int huawei_wmi_call(struct device *dev, struct acpi_buffer *in,
@@ -266,6 +327,11 @@ static void huawei_wmi_process_key(struct input_dev *idev, int code)
 		return;
 	}
 
+	if (quirks && !quirks->report_brightness &&
+			(key->sw.code == KEY_BRIGHTNESSDOWN ||
+			key->sw.code == KEY_BRIGHTNESSUP))
+		return;
+
 	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
@@ -378,6 +444,11 @@ static __init int huawei_wmi_init(void)
 {
 	int err;
 
+	quirks = &quirk_unknown;
+	dmi_check_system(huawei_quirks);
+	quirks->battery_sleep |= battery_sleep;
+	quirks->report_brightness |= report_brightness;
+
 	err = platform_driver_register(&huawei_wmi_driver);
 	if (err) {
 		pr_err("Failed to register platform driver\n");
-- 
2.20.1

