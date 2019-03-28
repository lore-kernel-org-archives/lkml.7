Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15820693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BICOiWPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfC1Q3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38070 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1Q3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so9852278pgl.5;
        Thu, 28 Mar 2019 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8YB6Omcp6x6Q2UyREeDiT50iiiUMuUAilTYNuoA/jw=;
        b=BICOiWPEWdAiXWqzctIn/C4VWcBOX7BaRl6NRvqLmoQYldyKDIu9cM9lhPS4UFWNNv
         HCxi4soY33xofINwABygm6ZiHRWS9JJl4fSwFyvp0NyxgCZmPHgQydo25ENaMX8kuO7J
         EndG3Zxg+VVL9ck3WQU7lsq1P5fP1d2lBxvM+tD0wblLxD7NAyv6Cs9rfNcCCXp10jeS
         x22J5hdOsOHI5JYXmOP4vgus1Q2bYNgzIy4ZcPGYBg+8bAtA4zFoMkF63WEnxA8+lwc1
         TsBQYzo9PAzK91WrerN9h3tOPLvP132cT9CC2LPRGP1zK7M4rrRGzsQFi0MlrnhpUcqq
         Je+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8YB6Omcp6x6Q2UyREeDiT50iiiUMuUAilTYNuoA/jw=;
        b=kukM8DvgZwJndoNk3DToemxijIIzm95tVFP7uM3Cl1wyI5cZ5n0JZh02BKRr+uLTeG
         3FSSfCY1ZLmyPx5Qb8+/cvqgYGZlViuA1anjCti116yBJLLnhsU2C0dUpK0UhDCYnXXY
         4QQHv6IAXJ5AZom3gyou8tB9/YRiRxfTYIBSs70ZA+uBhcvPpEkokYqi3oItGMFAUEqC
         JQFY68h9isZL0cbJ4LgNMpl4ExZuLE8384vl9wYPoxSIIDsMdAxKoAOE1xM/jwavcn6v
         9LaiN6YbgsREac9x3BZ2DmzRN63GIcmdnphMjJHJUuMe+lzy4v6RPbnJFY0sJzxA0TJ6
         b3Rg==
X-Gm-Message-State: APjAAAXaIx0K65zoMBG52vUSKONlXRkStEX45C6nhpGe/jJPJbup4yiM
        wMIHoq4hMaO/7VHctZ8GxuWmkJXesrc=
X-Google-Smtp-Source: APXvYqyePJ+r/jt8zG2XTB8zk+Sgs9m79zFjKDLDC5xzOQOd9zcpO1PZDqiquH/AiFZSdjqsyF+cbA==
X-Received: by 2002:a65:4844:: with SMTP id i4mr39871144pgs.347.1553790552477;
        Thu, 28 Mar 2019 09:29:12 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 08/23] acpi doc: convert acpi/gpio-properties.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:06 +0800
Message-Id: <20190328162721.26138-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 ...pio-properties.txt => gpio-properties.rst} | 76 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 43 insertions(+), 34 deletions(-)
 rename Documentation/acpi/{gpio-properties.txt => gpio-properties.rst} (82%)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.rst
similarity index 82%
rename from Documentation/acpi/gpio-properties.txt
rename to Documentation/acpi/gpio-properties.rst
index 88c65cb5bf0a..8a5246b7fa4a 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.rst
@@ -1,5 +1,6 @@
+======================================
 _DSD Device Properties Related to GPIO
---------------------------------------
+======================================
 
 With the release of ACPI 5.1, the _DSD configuration object finally
 allows names to be given to GPIOs (and other things as well) returned
@@ -8,7 +9,7 @@ the corresponding GPIO, which is pretty error prone (it depends on
 the _CRS output ordering, for example).
 
 With _DSD we can now query GPIOs using a name instead of an integer
-index, like the ASL example below shows:
+index, like the ASL example below shows::
 
   // Bluetooth device with reset and shutdown GPIOs
   Device (BTH)
@@ -34,15 +35,19 @@ index, like the ASL example below shows:
       })
   }
 
-The format of the supported GPIO property is:
+The format of the supported GPIO property is::
 
   Package () { "name", Package () { ref, index, pin, active_low }}
 
-  ref - The device that has _CRS containing GpioIo()/GpioInt() resources,
-        typically this is the device itself (BTH in our case).
-  index - Index of the GpioIo()/GpioInt() resource in _CRS starting from zero.
-  pin - Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
-  active_low - If 1 the GPIO is marked as active_low.
+ref
+  The device that has _CRS containing GpioIo()/GpioInt() resources,
+  typically this is the device itself (BTH in our case).
+index
+  Index of the GpioIo()/GpioInt() resource in _CRS starting from zero.
+pin
+  Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
+active_low
+  If 1 the GPIO is marked as active_low.
 
 Since ACPI GpioIo() resource does not have a field saying whether it is
 active low or high, the "active_low" argument can be used here.  Setting
@@ -55,7 +60,7 @@ It is possible to leave holes in the array of GPIOs. This is useful in
 cases like with SPI host controllers where some chip selects may be
 implemented as GPIOs and some as native signals. For example a SPI host
 controller can have chip selects 0 and 2 implemented as GPIOs and 1 as
-native:
+native::
 
   Package () {
       "cs-gpios",
@@ -67,7 +72,7 @@ native:
   }
 
 Other supported properties
---------------------------
+==========================
 
 Following Device Tree compatible device properties are also supported by
 _DSD device properties for GPIO controllers:
@@ -78,7 +83,7 @@ _DSD device properties for GPIO controllers:
 - input
 - line-name
 
-Example:
+Example::
 
   Name (_DSD, Package () {
       // _DSD Hierarchical Properties Extension UUID
@@ -100,7 +105,7 @@ Example:
 
 - gpio-line-names
 
-Example:
+Example::
 
   Package () {
       "gpio-line-names",
@@ -114,7 +119,7 @@ See Documentation/devicetree/bindings/gpio/gpio.txt for more information
 about these properties.
 
 ACPI GPIO Mappings Provided by Drivers
---------------------------------------
+======================================
 
 There are systems in which the ACPI tables do not contain _DSD but provide _CRS
 with GpioIo()/GpioInt() resources and device drivers still need to work with
@@ -139,16 +144,16 @@ line in that resource starting from zero, and the active-low flag for that line,
 respectively, in analogy with the _DSD GPIO property format specified above.
 
 For the example Bluetooth device discussed previously the data structures in
-question would look like this:
+question would look like this::
 
-static const struct acpi_gpio_params reset_gpio = { 1, 1, false };
-static const struct acpi_gpio_params shutdown_gpio = { 0, 0, false };
+  static const struct acpi_gpio_params reset_gpio = { 1, 1, false };
+  static const struct acpi_gpio_params shutdown_gpio = { 0, 0, false };
 
-static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
-  { "reset-gpios", &reset_gpio, 1 },
-  { "shutdown-gpios", &shutdown_gpio, 1 },
-  { },
-};
+  static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
+    { "reset-gpios", &reset_gpio, 1 },
+    { "shutdown-gpios", &shutdown_gpio, 1 },
+    { },
+  };
 
 Next, the mapping table needs to be passed as the second argument to
 acpi_dev_add_driver_gpios() that will register it with the ACPI device object
@@ -158,12 +163,12 @@ calling acpi_dev_remove_driver_gpios() on the ACPI device object where that
 table was previously registered.
 
 Using the _CRS fallback
------------------------
+=======================
 
 If a device does not have _DSD or the driver does not create ACPI GPIO
 mapping, the Linux GPIO framework refuses to return any GPIOs. This is
 because the driver does not know what it actually gets. For example if we
-have a device like below:
+have a device like below::
 
   Device (BTH)
   {
@@ -177,7 +182,7 @@ have a device like below:
       })
   }
 
-The driver might expect to get the right GPIO when it does:
+The driver might expect to get the right GPIO when it does:：
 
   desc = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 
@@ -193,22 +198,25 @@ the ACPI GPIO mapping tables are hardly linked to ACPI ID and certain
 objects, as listed in the above chapter, of the device in question.
 
 Getting GPIO descriptor
------------------------
+=======================
 
-There are two main approaches to get GPIO resource from ACPI:
-	desc = gpiod_get(dev, connection_id, flags);
-	desc = gpiod_get_index(dev, connection_id, index, flags);
+There are two main approaches to get GPIO resource from ACPI::
+
+  desc = gpiod_get(dev, connection_id, flags);
+  desc = gpiod_get_index(dev, connection_id, index, flags);
 
 We may consider two different cases here, i.e. when connection ID is
 provided and otherwise.
 
-Case 1:
-	desc = gpiod_get(dev, "non-null-connection-id", flags);
-	desc = gpiod_get_index(dev, "non-null-connection-id", index, flags);
+Case 1::
+
+  desc = gpiod_get(dev, "non-null-connection-id", flags);
+  desc = gpiod_get_index(dev, "non-null-connection-id", index, flags);
+
+Case 2::
 
-Case 2:
-	desc = gpiod_get(dev, NULL, flags);
-	desc = gpiod_get_index(dev, NULL, index, flags);
+  desc = gpiod_get(dev, NULL, flags);
+  desc = gpiod_get_index(dev, NULL, index, flags);
 
 Case 1 assumes that corresponding ACPI device description must have
 defined device properties and will prevent to getting any GPIO resources
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 376e12a65f3f..def0bf8d3283 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -10,4 +10,5 @@ Linux ACPI (Advanced Configuration and Power Interface)
    enumeration
    osi
    DSD-properties-rules
+   gpio-properties
    scan_handlers
-- 
2.20.1

