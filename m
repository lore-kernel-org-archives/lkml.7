Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEFBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2682075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJCua6bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfC2AOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:14:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46126 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2AOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:14:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so112950pll.13;
        Thu, 28 Mar 2019 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10Wi886LBw1v6Ju0WB7ZPM93RxeXGAk2oNhDtGllK0Y=;
        b=EJCua6bgQYFRswIQgJJ0+6JvQ9dQRgdUjZQRKY0hbh919F9OSr3m/NSo/LJgpLORuD
         tFIQWYyCCSdevz186hK4YpeL4kQAQGRLS/MU8F7tF9IyZVKM+MLRTyH3LcBA+pCP4wBf
         /AKBVrqEC0amMhcaEvcs6p7HHb8N7YV8DaCxu+sDdnfbCN/PNYc6swipJS6ETE0rz3F0
         ufvf4HglX5ow09pvWMufvV/QLdgcHcaILHlr1oNdNxMRDx+xlZjRo028hZz0lI6kmgEF
         yk+DDDQHLbHZQKPfLh4B2qulaSe/YGK66QiveioNzo5O8n2podk2jcJ+F6lm+pLQPizt
         N8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10Wi886LBw1v6Ju0WB7ZPM93RxeXGAk2oNhDtGllK0Y=;
        b=DtXC/uQfVV9U+VVdmiPczas/vxS4lYG8mMS7aevAtljWNxqhkXxVjjVHBxOZAieGay
         p/lj2kM3diV7bvtE7wqKgFLYgdvEK8TZnch1egUnMT7OQxO6oQpzcquxmIqAeZYE/IX/
         c/DHo0kGU/30YyzslcNAzPLN9uyJrndjkxCA6Ss/GmVJQTXPaQvChpyPdx2BsYKZnqZx
         gIc5GW2rZDPJTDJERK2ghMjbwAUYdIHpQMYINDSeKCJbfq/eUjVcCuR1gokb/vxS9vnh
         asjuwpRq8LaBDeoSX8dNLcKIGlPH7Elc+eSKnbywtpwDN4E56VSEsYfhpohkhHFwgPKo
         vcrw==
X-Gm-Message-State: APjAAAXqLF7T90LAw3J3jSf3aHh0NWD+yz2losivOUYj67LCMjNMMoLA
        Al5y3uyaRIwJVZp58WYEQFc=
X-Google-Smtp-Source: APXvYqzj/Y6Aq8jrolnEUINBlHM6FBwTqFIpCy6Yq6C0b7zUcFFMD6xb9RKWMnpB2eP+aAkG0fsjjw==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr45464928plb.56.1553818444061;
        Thu, 28 Mar 2019 17:14:04 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:14:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 24/24] acpi doc: convert acpi/video_extension.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:35 +0800
Message-Id: <20190329001135.15847-25-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst                  |  1 +
 ...ideo_extension.txt => video_extension.rst} | 63 ++++++++++---------
 2 files changed, 36 insertions(+), 28 deletions(-)
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (79%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index d856ba53da4d..f16d527d1958 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -29,3 +29,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    cppc_sysfs
    lpit
    ssdt-overlays
+   video_extension
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/acpi/video_extension.rst
similarity index 79%
rename from Documentation/acpi/video_extension.txt
rename to Documentation/acpi/video_extension.rst
index 79bf6a4921be..06f7e3230b6e 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/acpi/video_extension.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
 ACPI video extensions
-~~~~~~~~~~~~~~~~~~~~~
+=====================
 
 This driver implement the ACPI Extensions For Display Adapters for
 integrated graphics devices on motherboard, as specified in ACPI 2.0
@@ -8,9 +11,10 @@ defining the video POST device, retrieving EDID information or to
 setup a video output, etc.  Note that this is an ref. implementation
 only.  It may or may not work for your integrated video device.
 
-The ACPI video driver does 3 things regarding backlight control:
+The ACPI video driver does 3 things regarding backlight control.
 
-1 Export a sysfs interface for user space to control backlight level
+1. Export a sysfs interface for user space to control backlight level
+=====================================================================
 
 If the ACPI table has a video device, and acpi_backlight=vendor kernel
 command line is not present, the driver will register a backlight device
@@ -32,26 +36,26 @@ type: firmware
 
 Note that ACPI video backlight driver will always use index for
 brightness, actual_brightness and max_brightness. So if we have
-the following _BCL package:
+the following _BCL package::
 
-Method (_BCL, 0, NotSerialized)
-{
-	Return (Package (0x0C)
+	Method (_BCL, 0, NotSerialized)
 	{
-		0x64,
-		0x32,
-		0x0A,
-		0x14,
-		0x1E,
-		0x28,
-		0x32,
-		0x3C,
-		0x46,
-		0x50,
-		0x5A,
-		0x64
-	})
-}
+		Return (Package (0x0C)
+		{
+			0x64,
+			0x32,
+			0x0A,
+			0x14,
+			0x1E,
+			0x28,
+			0x32,
+			0x3C,
+			0x46,
+			0x50,
+			0x5A,
+			0x64
+		})
+	}
 
 The first two levels are for when laptop are on AC or on battery and are
 not used by Linux currently. The remaining 10 levels are supported levels
@@ -62,13 +66,15 @@ as a "brightness level" indicator. Thus from the user space perspective
 the range of available brightness levels is from 0 to 9 (max_brightness)
 inclusive.
 
-2 Notify user space about hotkey event
+2. Notify user space about hotkey event
+=======================================
 
 There are generally two cases for hotkey event reporting:
+
 i) For some laptops, when user presses the hotkey, a scancode will be
    generated and sent to user space through the input device created by
    the keyboard driver as a key type input event, with proper remap, the
-   following key code will appear to user space:
+   following key code will appear to user space::
 
 	EV_KEY, KEY_BRIGHTNESSUP
 	EV_KEY, KEY_BRIGHTNESSDOWN
@@ -82,7 +88,7 @@ ii) For some laptops, the press of the hotkey will not generate the
     about the event. The event value is defined in the ACPI spec. ACPI
     video driver will generate an key type input event according to the
     notify value it received and send the event to user space through the
-    input device it created:
+    input device it created::
 
 	event		keycode
 	0x86		KEY_BRIGHTNESSUP
@@ -94,13 +100,14 @@ so this would lead to the same effect as case i) now.
 Once user space tool receives this event, it can modify the backlight
 level through the sysfs interface.
 
-3 Change backlight level in the kernel
+3. Change backlight level in the kernel
+=======================================
 
 This works for machines covered by case ii) in Section 2. Once the driver
 received a notification, it will set the backlight level accordingly. This does
 not affect the sending of event to user space, they are always sent to user
 space regardless of whether or not the video module controls the backlight level
 directly. This behaviour can be controlled through the brightness_switch_enabled
-module parameter as documented in admin-guide/kernel-parameters.rst. It is recommended to
-disable this behaviour once a GUI environment starts up and wants to have full
-control of the backlight level.
+module parameter as documented in admin-guide/kernel-parameters.rst. It is
+recommended to disable this behaviour once a GUI environment starts up and
+wants to have full control of the backlight level.
-- 
2.20.1

