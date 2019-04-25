Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75206C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C42088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN2o7l39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfDYPd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:33:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41200 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDYPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:33:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so5352908pls.8;
        Thu, 25 Apr 2019 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pH04kRYyWalcfdxNFd/RcJuwybMGiJUgaT2sLCy0+qg=;
        b=iN2o7l39vbfm3GPxdoByMVBRsNlBD00wuyCl6eGB8qlBWm0aQOqWxuTVaMBj7MOff2
         1ysN3+coPGduTwY4VqISIt3BCyHmQ1PHAof2DQrt/yZte2Rq1KBS23L5YATJbajaIadF
         iHXUpT6bdkmTZ+nk9T5UGWXC0vXn5czdAg9qfVoOXn/fsHAZP6zPBaTOBeiUHa7pOYj8
         eIsXKYsAjXiG7xLXbbqQD/76GNZeUCLcdp3OQyj/CRLGiI9Qee/+6EQp6ZNxocWk3wh9
         /2YDE+fhuaN2Zbq95YonJ3cQBKGiFeLWr68eUpMVtmDir+FCqXoeRh9wXTlGZ7SwLL1u
         aZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pH04kRYyWalcfdxNFd/RcJuwybMGiJUgaT2sLCy0+qg=;
        b=JSypXSBvpYeHjUWb6+Fb17TyhRxJFWgSryvH6UnCAMTLNEIiccyqPRTWT4WxkVEi1y
         FWyo3rgHMGGtEzFRt3WoQYtoUHXmThkoSvPAAtM+qtIU0lcHdQ8d2YOvMFQdjrTvXUdJ
         0TZetc1GJPVNLq0xEZ805r/EEJn7ouLngA9l7oxDm50WvPhvPQBTSTulXBBso84km69u
         G1Iqu4l3xoeGkZjoo8z+9zIKoIf1u9vhNYtC/S83sgvpr9vjBcOU7DYyQrpmLbKTfmgO
         TF6VMhXrluoVkaVscr3GIq6SvoA9kUdInACloB4/jX0TFrGsBVRqLa04/jKSkS4aZEtX
         3D+g==
X-Gm-Message-State: APjAAAXZBYBVb4ddbN6ozio/IYYzT/s5lGhiZE3lLltek34zYJtnEEz1
        RI9blHCJzRogEWytNRwRxqY=
X-Google-Smtp-Source: APXvYqzWkzGezzauzDXq+xcpyaqTeA6tKz0TdwasgTWJxjmapU525EUVsWXF6ZFMoSFWbH8xQsIOkQ==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr5818167plp.105.1556206436680;
        Thu, 25 Apr 2019 08:33:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:33:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 24/24] Documentation: ACPI: move video_extension.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:17 +0800
Message-Id: <20190425153117.16057-25-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 .../acpi/video_extension.rst}                 | 85 +++++++++++--------
 2 files changed, 52 insertions(+), 34 deletions(-)
 rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (68%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 0e60f4b7129a..ae609eec4679 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -23,3 +23,4 @@ ACPI Support
    i2c-muxes
    acpi-lid
    lpit
+   video_extension
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/firmware-guide/acpi/video_extension.rst
similarity index 68%
rename from Documentation/acpi/video_extension.txt
rename to Documentation/firmware-guide/acpi/video_extension.rst
index 79bf6a4921be..932fb47342a7 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/firmware-guide/acpi/video_extension.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
 ACPI video extensions
-~~~~~~~~~~~~~~~~~~~~~
+=====================
 
 This driver implement the ACPI Extensions For Display Adapters for
 integrated graphics devices on motherboard, as specified in ACPI 2.0
@@ -8,9 +11,12 @@ defining the video POST device, retrieving EDID information or to
 setup a video output, etc.  Note that this is an ref. implementation
 only.  It may or may not work for your integrated video device.
 
-The ACPI video driver does 3 things regarding backlight control:
+The ACPI video driver exports the backlight control via a sysfs interface,
+notifies userspace with events and changes the backlight level via ACPI
+firmware, as detailed at the following chapters:
 
-1 Export a sysfs interface for user space to control backlight level
+Export a sysfs interface for user space to control backlight level
+==================================================================
 
 If the ACPI table has a video device, and acpi_backlight=vendor kernel
 command line is not present, the driver will register a backlight device
@@ -22,36 +28,41 @@ The backlight sysfs interface has a standard definition here:
 Documentation/ABI/stable/sysfs-class-backlight.
 
 And what ACPI video driver does is:
-actual_brightness: on read, control method _BQC will be evaluated to
-get the brightness level the firmware thinks it is at;
-bl_power: not implemented, will set the current brightness instead;
-brightness: on write, control method _BCM will run to set the requested
-brightness level;
-max_brightness: Derived from the _BCL package(see below);
-type: firmware
+
+actual_brightness:
+  on read, control method _BQC will be evaluated to
+  get the brightness level the firmware thinks it is at;
+bl_power:
+  not implemented, will set the current brightness instead;
+brightness:
+  on write, control method _BCM will run to set the requested brightness level;
+max_brightness:
+  Derived from the _BCL package(see below);
+type:
+  firmware
 
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
@@ -62,13 +73,15 @@ as a "brightness level" indicator. Thus from the user space perspective
 the range of available brightness levels is from 0 to 9 (max_brightness)
 inclusive.
 
-2 Notify user space about hotkey event
+Notify user space about hotkey event
+====================================
 
 There are generally two cases for hotkey event reporting:
+
 i) For some laptops, when user presses the hotkey, a scancode will be
    generated and sent to user space through the input device created by
    the keyboard driver as a key type input event, with proper remap, the
-   following key code will appear to user space:
+   following key code will appear to user space::
 
 	EV_KEY, KEY_BRIGHTNESSUP
 	EV_KEY, KEY_BRIGHTNESSDOWN
@@ -84,23 +97,27 @@ ii) For some laptops, the press of the hotkey will not generate the
     notify value it received and send the event to user space through the
     input device it created:
 
+	=====		==================
 	event		keycode
+	=====		==================
 	0x86		KEY_BRIGHTNESSUP
 	0x87		KEY_BRIGHTNESSDOWN
 	etc.
+	=====		==================
 
 so this would lead to the same effect as case i) now.
 
 Once user space tool receives this event, it can modify the backlight
 level through the sysfs interface.
 
-3 Change backlight level in the kernel
+Change backlight level in the kernel
+====================================
 
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

