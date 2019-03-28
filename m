Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33588C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9962183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeAxcd74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfC1Qab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:30:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfC1Qa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:30:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so11854808pgq.4;
        Thu, 28 Mar 2019 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02dp9uDmolhd9EB0XQ83sM4tTRkAtvyNrL2ap8FgGY0=;
        b=DeAxcd74G4zHnc4i03E9s5fhTtgPz+zfrQ1ilYWZk/bVDaggtf8JVI7LqpaAsrS6nC
         uWpo9Wpu5u9QsowsYc6q316JBRNKM7QU4S/KaNv/1zLqiU2psJUzDFYVKsuywTFbT2qn
         bPSJHFHNW3V7/gFmKGSzBExA7WcIHGAjyNIg3N3Chj+6CgEXSRr8MXlPfIy0tL8FVes5
         eaWiAnFnSSjTEkWzmDYj1fFvYPyBPSURXhOYFKNjcSeIFxBe4HQHohsnGflbqmWWriBQ
         a0wKWLFBwN2aqgTm64QLBf5se/+nQJ7tgwQV8lVpQCRrZ+ZCayDrTIIdCxmQpx0rh6o1
         2jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02dp9uDmolhd9EB0XQ83sM4tTRkAtvyNrL2ap8FgGY0=;
        b=MrIujA+/pb0vYPQICPv6wB3KXgRHDlKnu7T88nOfKk7TqnrCBP/TVROnKLCLFBWyf8
         vOQtY52CmdXLgnLlAbrg95jeYEM3kOIUy9ie7I15HWDEApNwswVgl8A7mhRo9obBGt9w
         ELXxIOcsVmg8rTWJEq3moaI+LZD+Xc/num8mYW5FaLqsGN3ICl1o7MXVHkasHa5rFwKc
         /Sg1N2gOxKbPyS4LxpfJWzZn/SQCuau1OlOgKuk41oNG7crkGyiAk3Me2cVozrB8yHDJ
         3Y7S7pE3UoOeYVtzWJ7iYZSUS9AXbdBADEGzreTdDqkE90On9xpopeftKqbEgfynuxXi
         tnuQ==
X-Gm-Message-State: APjAAAUv6nn+1ZinzJHivZdSCJINIjRGFTWiCgFELDFC2FRzonus0HD5
        VUisVnW4PZ1MEU3rQ9d67h4KCQF/QFM=
X-Google-Smtp-Source: APXvYqwr6Gl7DKHLpREQkkZBG3uDOnOtC8OAe5HEV/UMgMLj0GglQ6j1rPCauHqqF/Ms1I/i1bAZ7g==
X-Received: by 2002:a62:4e86:: with SMTP id c128mr18976029pfb.39.1553790628279;
        Thu, 28 Mar 2019 09:30:28 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:30:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 23/23] acpi doc: convert acpi/video_extension.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:21 +0800
Message-Id: <20190328162721.26138-24-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 ...ideo_extension.txt => video_extension.rst} | 61 ++++++++++---------
 2 files changed, 34 insertions(+), 28 deletions(-)
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (80%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 7909199e16ff..1b96562d5c5b 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -27,3 +27,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    cppc_sysfs
    lpit
    ssdt-overlays
+   video_extension
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/acpi/video_extension.rst
similarity index 80%
rename from Documentation/acpi/video_extension.txt
rename to Documentation/acpi/video_extension.rst
index 79bf6a4921be..842c72aad2ae 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/acpi/video_extension.rst
@@ -1,5 +1,6 @@
+=====================
 ACPI video extensions
-~~~~~~~~~~~~~~~~~~~~~
+=====================
 
 This driver implement the ACPI Extensions For Display Adapters for
 integrated graphics devices on motherboard, as specified in ACPI 2.0
@@ -8,9 +9,10 @@ defining the video POST device, retrieving EDID information or to
 setup a video output, etc.  Note that this is an ref. implementation
 only.  It may or may not work for your integrated video device.
 
-The ACPI video driver does 3 things regarding backlight control:
+The ACPI video driver does 3 things regarding backlight control.
 
-1 Export a sysfs interface for user space to control backlight level
+1. Export a sysfs interface for user space to control backlight level
+=====================================================================
 
 If the ACPI table has a video device, and acpi_backlight=vendor kernel
 command line is not present, the driver will register a backlight device
@@ -32,26 +34,26 @@ type: firmware
 
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
@@ -62,13 +64,15 @@ as a "brightness level" indicator. Thus from the user space perspective
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
@@ -82,7 +86,7 @@ ii) For some laptops, the press of the hotkey will not generate the
     about the event. The event value is defined in the ACPI spec. ACPI
     video driver will generate an key type input event according to the
     notify value it received and send the event to user space through the
-    input device it created:
+    input device it created::
 
 	event		keycode
 	0x86		KEY_BRIGHTNESSUP
@@ -94,13 +98,14 @@ so this would lead to the same effect as case i) now.
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

