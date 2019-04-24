Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF42C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9511620685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwar+sNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392278AbfDXR4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:56:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37962 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbfDXRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:55:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so9693593pfo.5;
        Wed, 24 Apr 2019 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ANYEStqupVcUyOOdEhP27CWqrM1IUuJpSYFn0ATO6g=;
        b=Nwar+sNP7OepVGzD2QfVm1FY2qQ+FQwXsNp3MxBu+Zqvkg0k41WoJkybX3e7/1Kys4
         nMztQvg3SBNGEuYdez39sjBDopHypIGbBlEpH7g0P7AFWdft2KD1FL28K3IH6haW5Req
         CTzcODMDL1eOiroz2EF8lGbfTk2Yg6pbtlkPzPsBcQlGW0W0vBEczw/AnHuGiBlxmTFU
         LQnOKSzbGsUuLYvqcZErWI0Gmiq6KOsO+U6YUvG2dt4K9NePL6qxVVs9djk27vEleNIH
         tqUNsX6Aa11/cwew2hlxCh5//Cwa+oHHksa3nadW0TBEkAcHvRuT0l8VO0b39+kC7NOy
         i68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ANYEStqupVcUyOOdEhP27CWqrM1IUuJpSYFn0ATO6g=;
        b=eHiWCOufwezFWVBFlQTDNE7zEizS8zMSqp+CNEWojGBHPG/d+OrHdlu5r+eYjoUy/L
         u8I5Mn4GEXntypDDBR0fnZCpQ8r66pjnzGwKO4XCryA0OKfK4o1DCtaIbtLutoU27YtU
         5jCRBMYoeCBwcMJtcghihjDf4Od+9lzH+Bm93goP99k0WmMTJ9CnfcFrwSwHhT5eRpkd
         6f7w7p4ybOH7HfNyUabcd5cnRT1gyWTv/b19AC8gjxZH9t/ygsx5KHm4G7HnlAxjWikT
         J7QL4sVRZA7Gpe9oYy6lcYfOroteybQJqruKXyXKE1BIGWMpZL5DaF5lsgTOlqF3yTP7
         fOGA==
X-Gm-Message-State: APjAAAWpYidVrt9jZ/fG7eA0Z/k1nchOz2YYvLoEOwGrdOYElo/tIDSG
        vfAGE1ZYct4U3UfmUh89PU4=
X-Google-Smtp-Source: APXvYqzlGCSUA4M0DN1NLn1445DIGw8wYMQGyM1Z4M/QGJ/NELTE6/4gc/ac7uibaSVeBJSypf87Lw==
X-Received: by 2002:a62:f24e:: with SMTP id y14mr34875958pfl.209.1556128557561;
        Wed, 24 Apr 2019 10:55:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:55:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 15/23] Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:58 +0800
Message-Id: <20190424175306.25880-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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
 .../acpi/debug.rst}                           | 31 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 2 files changed, 19 insertions(+), 15 deletions(-)
 rename Documentation/{acpi/debug.txt => firmware-guide/acpi/debug.rst} (91%)

diff --git a/Documentation/acpi/debug.txt b/Documentation/firmware-guide/acpi/debug.rst
similarity index 91%
rename from Documentation/acpi/debug.txt
rename to Documentation/firmware-guide/acpi/debug.rst
index 65bf47c46b6d..1a152dd1d765 100644
--- a/Documentation/acpi/debug.txt
+++ b/Documentation/firmware-guide/acpi/debug.rst
@@ -1,18 +1,21 @@
-			ACPI Debug Output
+.. SPDX-License-Identifier: GPL-2.0
 
+=================
+ACPI Debug Output
+=================
 
 The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
 output.  This document describes how to use this facility.
 
 Compile-time configuration
---------------------------
+==========================
 
 ACPI debug output is globally enabled by CONFIG_ACPI_DEBUG.  If this config
 option is turned off, the debug messages are not even built into the
 kernel.
 
 Boot- and run-time configuration
---------------------------------
+================================
 
 When CONFIG_ACPI_DEBUG=y, you can select the component and level of messages
 you're interested in.  At boot-time, use the acpi.debug_layer and
@@ -21,7 +24,7 @@ debug_layer and debug_level files in /sys/module/acpi/parameters/ to control
 the debug messages.
 
 debug_layer (component)
------------------------
+=======================
 
 The "debug_layer" is a mask that selects components of interest, e.g., a
 specific driver or part of the ACPI interpreter.  To build the debug_layer
@@ -33,7 +36,7 @@ to /sys/module/acpi/parameters/debug_layer.
 
 The possible components are defined in include/acpi/acoutput.h and
 include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
-shows the supported mask values, currently these:
+shows the supported mask values, currently these::
 
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
@@ -65,7 +68,7 @@ shows the supported mask values, currently these:
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
 debug_level
------------
+===========
 
 The "debug_level" is a mask that selects different types of messages, e.g.,
 those related to initialization, method execution, informational messages, etc.
@@ -81,7 +84,7 @@ to /sys/module/acpi/parameters/debug_level.
 
 The possible levels are defined in include/acpi/acoutput.h.  Reading
 /sys/module/acpi/parameters/debug_level shows the supported mask values,
-currently these:
+currently these::
 
     ACPI_LV_INIT                    0x00000001
     ACPI_LV_DEBUG_OBJECT            0x00000002
@@ -113,9 +116,9 @@ currently these:
     ACPI_LV_EVENTS                  0x80000000
 
 Examples
---------
+========
 
-For example, drivers/acpi/bus.c contains this:
+For example, drivers/acpi/bus.c contains this::
 
     #define _COMPONENT              ACPI_BUS_COMPONENT
     ...
@@ -127,22 +130,22 @@ statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
 definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
-AML) during boot:
+AML) during boot::
 
     acpi.debug_layer=0xffffffff acpi.debug_level=0x2
 
-Enable PCI and PCI interrupt routing debug messages:
+Enable PCI and PCI interrupt routing debug messages::
 
     acpi.debug_layer=0x400000 acpi.debug_level=0x4
 
-Enable all ACPI hardware-related messages:
+Enable all ACPI hardware-related messages::
 
     acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
-Enable all ACPI_DB_INFO messages after boot:
+Enable all ACPI_DB_INFO messages after boot::
 
     # echo 0x4 > /sys/module/acpi/parameters/debug_level
 
-Show all valid component values:
+Show all valid component values::
 
     # cat /sys/module/acpi/parameters/debug_layer
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 6d4e0df4f063..a45fea11f998 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -14,6 +14,7 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
+   debug
    gpio-properties
    i2c-muxes
-   acpi-lid
\ No newline at end of file
+   acpi-lid
-- 
2.20.1

