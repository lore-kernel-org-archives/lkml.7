Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4CAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A115F2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLwildLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfDYPdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:33:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfDYPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:33:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so41233pgs.2;
        Thu, 25 Apr 2019 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ANYEStqupVcUyOOdEhP27CWqrM1IUuJpSYFn0ATO6g=;
        b=uLwildLUiX2Qpmo1OeBl52m1gj/udEIf3v8IeWQYzPyzPUkGtQLZ1wA5qkxnzVYxrP
         NOqokNVG4sWZyNwlePEt4atI8Cd7dkpK5RH1IigZDSap0rRotfWFLZrDGsNm6Jirp065
         IswmXzQ5GV4HXS2VJYg1SnEldFzy7KpihRmecvWqI0ZXLYcRM62Zi1tfshNj4j9DttzZ
         QNjApsZGe4Nqt+rIXUgk8Fu7ruV9LWJDkcH5kVJGqtIbNDXtPRp/D6Y44nZxxaXtU1uo
         XZt6FTn2qm9+QiOdU/lHAQt20CgFDuJgB3AabolVSn5DEiZUnphV4nKNdvX95ROQshyr
         Fe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ANYEStqupVcUyOOdEhP27CWqrM1IUuJpSYFn0ATO6g=;
        b=YThrWI5cpsZVdhWvs2Gv1Wskt9QOEQtcktYq0dhRXm3kXlx8O8vAR0k/3K1ODWeHSI
         Zf1I/hkDfWSA3kOIvAi0pGcOfUtDqeItuYuz7XSwiUju8WTIB/0JdPu/TbY0mS66tqGX
         thGqYz+z4EeORAcH4VBhjmnFY26sH8/UYXNGULsDQqqjyZkqzJfM1EMANLiadMU4lZWQ
         anSqLRVRhriacrbftV8B8DScpMPMRir2FJEYsbkiMru7Z+yloARu33vZNTpWgb3jk1Z2
         twfbkkqr1cmAcJ6S+riBEoMJTR1sCacYcDfwDd7AOD3ebqs+NVgXslUFvu5OZYCRATp7
         DT+A==
X-Gm-Message-State: APjAAAVMzru4tyA78YrgNnIBYW3ZQthKvzCGH7u4xlcyGL/cMGFLnRFT
        WMyRkRXu0TgTB1vQrFRx1sRM8oId
X-Google-Smtp-Source: APXvYqwxd1QTHDY2bcx7OWGQ+ic9X7jIyj3kAcVia5AyEq8KmdboilFetDUGCiVT7/TmxaoimxP4Sw==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr8826591pgi.180.1556206388245;
        Thu, 25 Apr 2019 08:33:08 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:33:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 16/24] Documentation: ACPI: move debug.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:09 +0800
Message-Id: <20190425153117.16057-17-changbin.du@gmail.com>
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

