Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17699C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8FC2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="Ay7mqLpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLCQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:03:41 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:62195 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbfLCQDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:03:40 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 23DE31A0E5A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 16:03:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a9.g.dreamhost.com (100-96-4-107.trex.outbound.svc.cluster.local [100.96.4.107])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 35CEE1A0AE0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 16:03:38 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a9.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Tue, 03 Dec 2019 16:03:39 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Fearful: 4590fa411b991331_1575389018625_620993541
X-MC-Loop-Signature: 1575389018625:4043353571
X-MC-Ingress-Time: 1575389018624
Received: from pdx1-sub0-mail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a9.g.dreamhost.com (Postfix) with ESMTP id E4240AF64D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 08:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=qrpff.net;
         bh=77WoW3CkLyIvTb55IWHyUNylFDU=; b=Ay7mqLpcOlXW88JLFTrS1ruLZ3AE
        OPpyM6VV14yG6S6DEX9cCoEg738k5JLyfOTmWx0Ji6jy5UqQ9pruq6d0Ho+oJyUR
        /uxTYIetDoOYgqE9PacognOInxkCJRevrC3YhdzSRBA/WcGJlI/bkF6yFvcRhyAP
        iuVUL6kw9V8vtxE=
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a9.g.dreamhost.com (Postfix) with ESMTPSA id A279AAF63D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 08:03:31 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id z17so4388719ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:03:31 -0800 (PST)
X-Gm-Message-State: APjAAAWKZ0NgEIetnU1i3M/O5C6IGRrSOx5BTeR0mzfeGjnz/6UUpbXo
        9avgq+btXscLZnT+VO9ypbcn78fiKXvVVgzX/8g=
X-Google-Smtp-Source: APXvYqxnYtyAULgy0CLVafmglqQYuBJM2g0N7H4XjCt/asq8qw6Msu0aT9JUoTab9GNHYZlPouOW5eCykIphcX9s5eY=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr3062360lja.117.1575389009625;
 Tue, 03 Dec 2019 08:03:29 -0800 (PST)
MIME-Version: 1.0
X-DH-BACKEND: pdx1-sub0-mail-a9
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Tue, 3 Dec 2019 11:03:18 -0500
X-Gmail-Original-Message-ID: <CAD_xR9dGuVLsZf1P3C-x7L8_WVkHHMfQCKdvR_ZRkeBXCOxW_w@mail.gmail.com>
Message-ID: <CAD_xR9dGuVLsZf1P3C-x7L8_WVkHHMfQCKdvR_ZRkeBXCOxW_w@mail.gmail.com>
Subject: [RFC] chromeos_laptop: Make touchscreen work on C720
To:     Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 627be71ee77f4fc20cdb55c6e0a06826fb43ca9d Mon Sep 17 00:00:00 2001
From: Stephen Oberholtzer <stevie@qrpff.net>
Date: Tue, 3 Dec 2019 02:20:28 -0500
Subject: [RFC] chromeos_laptop: Make touchscreen work on C720

I have an old Acer C720 Chromebook reflashed with MrChromebox, running
Debian.  When I did an upgrade, the touchscreen stopped working; I traced
it to the kernel.

After six hours of bisecting -- if anyone can tell me how to make a kernel
build take less than 2 hours of CPU time while bisecting, I'd greatly
appreciate it -- I tracked the problem to commit 7cf432bf0586
("Input: atmel_mxt_ts - require device properties present when probing").

Looking at https://lkml.org/lkml/2018/5/3/955, it appears that the idea
was to reassign the responsibility for setting up ACPI data for
atmel_mxt_ts into chromeos_laptop, which makes a lot of sense, as that
would tidy up some potential maintenance issues.

However, that doesn't actually work.  The chromeos_laptop code appears to
categorize every Chromebook as exactly one of the following:

(A) Having I2C devices (declared using DECLARE_CROS_LAPTOP)
(B) Requiring ACPI munging (declared using DECLARE_ACPI_CROS_LAPTOP)

There's some stuff about a board_info.properties that looks like it's meant
to do the job for I2C devices, but it doesn't seem to do anything;
it *definitely* doesn't do what the atmel_mxt_ts driver is expecting.

On the other hand, when I apply the following patch to a recent kernel
(5.2 is the one I tested), my touchscreen works again.

I'm still not sure if the appropriate solution is to ensure that the
ACPI properties are set, or if atmel_mxt_ts should be checking both
ACPI properties and the I2C board_info.properties, however.

>8------------------------------------------------------8<

Fixes: 7cf432bf058 ("Input: atmel_mxt_ts - require device properties
present when probing")

The ACPI data for the Atmel touchscreen found in many Chromebooks is
incomplete.  Originally, the atmel_mxt_ts driver had a whitelist of known
Chromebooks, but that changed in commit 7cf432bf0586 ("Input: atmel_mxt_ts
 - require device properties present when probing").
As of that commit, the atmel_mxt_ts driver expects the chromeos_laptop
driver to inject the required ACPI properties into the device node.

However, this doesn't actually work in all cases -- particularly, the Acer
C720.  This is because the C720's definition does not contain any rules to
set up the ACPI properties for the touchscreen.

Signed-off-by: Stephen Oberholtzer <stevie@qrpff.net>

---
 drivers/platform/chrome/chromeos_laptop.c | 47 +++++++++++++++--------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c
b/drivers/platform/chrome/chromeos_laptop.c
index 7abbb6167766..b6487a19f04a 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -228,16 +228,28 @@ static struct notifier_block
chromeos_laptop_i2c_notifier = {
     .notifier_call = chromeos_laptop_i2c_notifier_call,
 };

-#define DECLARE_CROS_LAPTOP(_name)                    \
-static const struct chromeos_laptop _name __initconst = {        \
+#define _DECLARE_I2C_CROS_LAPTOP(_name)                    \
     .i2c_peripherals    = _name##_peripherals,            \
-    .num_i2c_peripherals    = ARRAY_SIZE(_name##_peripherals),    \
+    .num_i2c_peripherals    = ARRAY_SIZE(_name##_peripherals),
+
+#define _DECLARE_ACPI_CROS_LAPTOP(_name)                \
+    .acpi_peripherals    = _name##_peripherals,            \
+    .num_acpi_peripherals    = ARRAY_SIZE(_name##_peripherals),
+
+#define DECLARE_I2C_CROS_LAPTOP(_name)                    \
+static const struct chromeos_laptop _name __initconst = {        \
+    _DECLARE_I2C_CROS_LAPTOP(_name)                    \
 }

 #define DECLARE_ACPI_CROS_LAPTOP(_name)                    \
 static const struct chromeos_laptop _name __initconst = {        \
-    .acpi_peripherals    = _name##_peripherals,            \
-    .num_acpi_peripherals    = ARRAY_SIZE(_name##_peripherals),    \
+    _DECLARE_ACPI_CROS_LAPTOP(_name)                \
+}
+
+#define DECLARE_I2C_ACPI_CROS_LAPTOP(_name, _acpiname)            \
+static const struct chromeos_laptop _name __initconst = {        \
+    _DECLARE_I2C_CROS_LAPTOP(_name)                    \
+    _DECLARE_ACPI_CROS_LAPTOP(_acpiname)                \
 }

 static struct i2c_peripheral samsung_series_5_550_peripherals[] __initdata = {
@@ -259,7 +271,7 @@ static struct i2c_peripheral
samsung_series_5_550_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_SMBUS,
     },
 };
-DECLARE_CROS_LAPTOP(samsung_series_5_550);
+DECLARE_I2C_CROS_LAPTOP(samsung_series_5_550);

 static struct i2c_peripheral samsung_series_5_peripherals[] __initdata = {
     /* Light Sensor. */
@@ -270,7 +282,7 @@ static struct i2c_peripheral
samsung_series_5_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_SMBUS,
     },
 };
-DECLARE_CROS_LAPTOP(samsung_series_5);
+DECLARE_I2C_CROS_LAPTOP(samsung_series_5);

 static const int chromebook_pixel_tp_keys[] __initconst = {
     KEY_RESERVED,
@@ -332,7 +344,7 @@ static struct i2c_peripheral
chromebook_pixel_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_PANEL,
     },
 };
-DECLARE_CROS_LAPTOP(chromebook_pixel);
+DECLARE_I2C_CROS_LAPTOP(chromebook_pixel);

 static struct i2c_peripheral hp_chromebook_14_peripherals[] __initdata = {
     /* Touchpad. */
@@ -345,7 +357,7 @@ static struct i2c_peripheral
hp_chromebook_14_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_DESIGNWARE,
     },
 };
-DECLARE_CROS_LAPTOP(hp_chromebook_14);
+DECLARE_I2C_CROS_LAPTOP(hp_chromebook_14);

 static struct i2c_peripheral dell_chromebook_11_peripherals[] __initdata = {
     /* Touchpad. */
@@ -367,7 +379,7 @@ static struct i2c_peripheral
dell_chromebook_11_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_DESIGNWARE,
     },
 };
-DECLARE_CROS_LAPTOP(dell_chromebook_11);
+DECLARE_I2C_CROS_LAPTOP(dell_chromebook_11);

 static struct i2c_peripheral toshiba_cb35_peripherals[] __initdata = {
     /* Touchpad. */
@@ -380,7 +392,7 @@ static struct i2c_peripheral
toshiba_cb35_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_DESIGNWARE,
     },
 };
-DECLARE_CROS_LAPTOP(toshiba_cb35);
+DECLARE_I2C_CROS_LAPTOP(toshiba_cb35);

 static struct i2c_peripheral acer_c7_chromebook_peripherals[] __initdata = {
     /* Touchpad. */
@@ -393,7 +405,7 @@ static struct i2c_peripheral
acer_c7_chromebook_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_SMBUS,
     },
 };
-DECLARE_CROS_LAPTOP(acer_c7_chromebook);
+DECLARE_I2C_CROS_LAPTOP(acer_c7_chromebook);

 static struct i2c_peripheral acer_ac700_peripherals[] __initdata = {
     /* Light Sensor. */
@@ -404,7 +416,7 @@ static struct i2c_peripheral
acer_ac700_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_SMBUS,
     },
 };
-DECLARE_CROS_LAPTOP(acer_ac700);
+DECLARE_I2C_CROS_LAPTOP(acer_ac700);

 static struct i2c_peripheral acer_c720_peripherals[] __initdata = {
     /* Touchscreen. */
@@ -452,7 +464,8 @@ static struct i2c_peripheral
acer_c720_peripherals[] __initdata = {
         .pci_devid    = PCI_DEVID(0, PCI_DEVFN(0x15, 0x2)),
     },
 };
-DECLARE_CROS_LAPTOP(acer_c720);
+
+/* C720 also needs generic_atmel ACPI stuff declared below. */

 static struct i2c_peripheral
 hp_pavilion_14_chromebook_peripherals[] __initdata = {
@@ -466,7 +479,7 @@ hp_pavilion_14_chromebook_peripherals[] __initdata = {
         .type        = I2C_ADAPTER_SMBUS,
     },
 };
-DECLARE_CROS_LAPTOP(hp_pavilion_14_chromebook);
+DECLARE_I2C_CROS_LAPTOP(hp_pavilion_14_chromebook);

 static struct i2c_peripheral cr48_peripherals[] __initdata = {
     /* Light Sensor. */
@@ -477,7 +490,7 @@ static struct i2c_peripheral cr48_peripherals[]
__initdata = {
         .type        = I2C_ADAPTER_SMBUS,
     },
 };
-DECLARE_CROS_LAPTOP(cr48);
+DECLARE_I2C_CROS_LAPTOP(cr48);

 static const u32 samus_touchpad_buttons[] __initconst = {
     KEY_RESERVED,
@@ -520,6 +533,8 @@ static struct acpi_peripheral
generic_atmel_peripherals[] __initdata = {
 };
 DECLARE_ACPI_CROS_LAPTOP(generic_atmel);

+DECLARE_I2C_ACPI_CROS_LAPTOP(acer_c720, generic_atmel);
+
 static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
     {
         .ident = "Samsung Series 5 550",
-- 
2.20.1
