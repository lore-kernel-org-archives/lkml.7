Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D5C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C677206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc5zN+a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbfDYPcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33655 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbfDYPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so107222pfo.0;
        Thu, 25 Apr 2019 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2q5HZCs0wb1AiehSMCcBp9Dd3YROqUjTWd5HoUyXnI=;
        b=qc5zN+a4lc9+gZzooB28qJSGFrGCGjklmAWMhmwsoAEXTeDtlxzsOPGdwSiNjX0E7v
         ofFH29d5mv3hm+TU+6xlkhnq2URzTpt7CO+vZD/dGHUG82oF6mmLLTXqTWfABSjTWO9Y
         VywMMpKESJg6x/2GmFw5Mb/wTqGEqlOMPsqZWOKbBIm/nrHRnZJvr0tG2DzAPBkpARrd
         gFmoWvdlCayrkkomzo0MXL/ckOur5GdNBBrZ/rwipfIJcLRxlWfTiSBy9JKgnbwX6rjz
         khqC1VdbRaw63WJQtVzfbn/yTEaQNtFnedtvWspVcebltzSs7hf3Jt4QygrZj0SP4Lm2
         rpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2q5HZCs0wb1AiehSMCcBp9Dd3YROqUjTWd5HoUyXnI=;
        b=JQ8PkxtN+6iH1ssH4nXyRbJTrE/gH7DKx+a4P/QkvwtWeH4lXze5fvgpw+GeAPqPuh
         BbKDeAc7fgFRNLK+BBrp2m3+TUhEzi8xTD/1jdY134S7IXnIszJPAobwmqa7MFXgCcou
         QupuUU1OAvv3WtinpwLiS9t8V4lNZjvrPu6r6y2dnWpAekHms8B0zkj9okjRClas4BVw
         OjktApKECdo9BTgD6bSrlyAr6FqQD8viRBuGYMckCa3SISkevu9fdpPnUpJFANs2fqju
         3Iy6pkvApvxhEh0UInlpUtbxCen03eeX9DOLzodKikZC962dFMP9uC54DsBRzOf2hjJy
         jOTw==
X-Gm-Message-State: APjAAAX8lyFPmPeWIr5CAuh5TSIQg3qldShAo6W5syA4kFKDNwvKoHWi
        Zq6EqTSog4FZokCK96Cn/xw=
X-Google-Smtp-Source: APXvYqxDdhXKmMynQwtHV1SeokOJvTgGhvFPwrIKvfuxG94xp+2CM42C/EBIIrtgjdquoN/YWyEjXA==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr37475938pgq.175.1556206340605;
        Thu, 25 Apr 2019 08:32:20 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:19 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 08/24] Documentation: ACPI: move gpio-properties.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:01 +0800
Message-Id: <20190425153117.16057-9-changbin.du@gmail.com>
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
 .../acpi/gpio-properties.rst}                 | 78 +++++++++++--------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 MAINTAINERS                                   |  2 +-
 3 files changed, 46 insertions(+), 35 deletions(-)
 rename Documentation/{acpi/gpio-properties.txt => firmware-guide/acpi/gpio-properties.rst} (81%)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/firmware-guide/acpi/gpio-properties.rst
similarity index 81%
rename from Documentation/acpi/gpio-properties.txt
rename to Documentation/firmware-guide/acpi/gpio-properties.rst
index 88c65cb5bf0a..bb6d74f23ee0 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
 _DSD Device Properties Related to GPIO
---------------------------------------
+======================================
 
 With the release of ACPI 5.1, the _DSD configuration object finally
 allows names to be given to GPIOs (and other things as well) returned
@@ -8,7 +11,7 @@ the corresponding GPIO, which is pretty error prone (it depends on
 the _CRS output ordering, for example).
 
 With _DSD we can now query GPIOs using a name instead of an integer
-index, like the ASL example below shows:
+index, like the ASL example below shows::
 
   // Bluetooth device with reset and shutdown GPIOs
   Device (BTH)
@@ -34,15 +37,19 @@ index, like the ASL example below shows:
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
@@ -55,7 +62,7 @@ It is possible to leave holes in the array of GPIOs. This is useful in
 cases like with SPI host controllers where some chip selects may be
 implemented as GPIOs and some as native signals. For example a SPI host
 controller can have chip selects 0 and 2 implemented as GPIOs and 1 as
-native:
+native::
 
   Package () {
       "cs-gpios",
@@ -67,7 +74,7 @@ native:
   }
 
 Other supported properties
---------------------------
+==========================
 
 Following Device Tree compatible device properties are also supported by
 _DSD device properties for GPIO controllers:
@@ -78,7 +85,7 @@ _DSD device properties for GPIO controllers:
 - input
 - line-name
 
-Example:
+Example::
 
   Name (_DSD, Package () {
       // _DSD Hierarchical Properties Extension UUID
@@ -100,7 +107,7 @@ Example:
 
 - gpio-line-names
 
-Example:
+Example::
 
   Package () {
       "gpio-line-names",
@@ -114,7 +121,7 @@ See Documentation/devicetree/bindings/gpio/gpio.txt for more information
 about these properties.
 
 ACPI GPIO Mappings Provided by Drivers
---------------------------------------
+======================================
 
 There are systems in which the ACPI tables do not contain _DSD but provide _CRS
 with GpioIo()/GpioInt() resources and device drivers still need to work with
@@ -139,16 +146,16 @@ line in that resource starting from zero, and the active-low flag for that line,
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
@@ -158,12 +165,12 @@ calling acpi_dev_remove_driver_gpios() on the ACPI device object where that
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
@@ -177,7 +184,7 @@ have a device like below:
       })
   }
 
-The driver might expect to get the right GPIO when it does:
+The driver might expect to get the right GPIO when it does::
 
   desc = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 
@@ -193,22 +200,25 @@ the ACPI GPIO mapping tables are hardly linked to ACPI ID and certain
 objects, as listed in the above chapter, of the device in question.
 
 Getting GPIO descriptor
------------------------
+=======================
+
+There are two main approaches to get GPIO resource from ACPI::
 
-There are two main approaches to get GPIO resource from ACPI:
-	desc = gpiod_get(dev, connection_id, flags);
-	desc = gpiod_get_index(dev, connection_id, index, flags);
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
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 0e05b843521c..61d67763851b 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -11,3 +11,4 @@ ACPI Support
    enumeration
    osi
    DSD-properties-rules
+   gpio-properties
diff --git a/MAINTAINERS b/MAINTAINERS
index 09f43f1bdd15..87f930bf32ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6593,7 +6593,7 @@ M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
-F:	Documentation/acpi/gpio-properties.txt
+F:	Documentation/firmware-guide/acpi/gpio-properties.rst
 F:	drivers/gpio/gpiolib-acpi.c
 
 GPIO IR Transmitter
-- 
2.20.1

