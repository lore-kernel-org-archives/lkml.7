Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFA0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BAF21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL24z7bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfC2AN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40048 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfC2ANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so294695pgo.7;
        Thu, 28 Mar 2019 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mq8v8dZP1qNBWq/BZtYrY35GeFDcWgn8IoOZx1Wiy7g=;
        b=fL24z7bFZd7PkqvDwyLaJceYQVooNoiIgz05qrBmJjIAll/c0JE0SAE9kHUsFnrc8c
         r4gpvcCuf+KG4qnWXRPfOiE/lk/nlSYnounBYcUeXL0/2qBbzUg5rYL4Kw7H0a+YtcYc
         Pwn/m3hz98Dq1KHtYqRqIw6UTs8cTeTBUxGqy0gS/6xuGCIcrU/48IgHnMLBFGiEAEdF
         1QK33oM8r7RR9hm07kSHBSvuzI6VBUtqBihzcWm3Ri6QwK9zIHANgnLDcnrhJM/7o/4/
         R6ImonIxB5XeiuF5LfjqRta/BqR7bZIBR9mTazCN5iInzWImSx5QrrS/sGZNOhm2Ded6
         MFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mq8v8dZP1qNBWq/BZtYrY35GeFDcWgn8IoOZx1Wiy7g=;
        b=aJyGwVoqU2MM3fL8Q2B47PRpXoji88YE3uEZeeNF6sQTbDemDs+sm2JNpKP0Rl1Nec
         ArXPXFZd2vlyy2eK8R9TIQnoB+d58zFLmYA8LICfnCsArRRxjXYzTDUzULs0MBoOTRWy
         /77On2YdsE4GnWtmi2dPAB4N2YGx+6Rz6I1XurNOeNZ+p1a5mmAIH+lOS4tS15j/Domb
         aZlxdl1OU+OkY+l05JYhFIYsRvYb+BVou0UFLcvOMgqmeHcwYSI+1DVPe7KKJBVI3d9h
         3H5NnpNTHWjVcB2fTmfeRSa5fpf8ky1wu3gQ/e4UQPmX2qICAi8k9/0wmCcqR13VB5/O
         yUUg==
X-Gm-Message-State: APjAAAUID91qVZ8ggoQqiLk1/lsgZEi2LA1cufeCQArfIE28cLoxsx+x
        Y0eXOw6QlOE2P81AC70uT2I=
X-Google-Smtp-Source: APXvYqwBA2DnYGK75pWCG9tSoxEAK5mWHAn6XxrqB2NYES11rcilM+9ZS63660HNvpkjefo3AjqZbg==
X-Received: by 2002:a65:4806:: with SMTP id h6mr42804386pgs.408.1553818404168;
        Thu, 28 Mar 2019 17:13:24 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 16/24] acpi doc: convert acpi/debug.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:27 +0800
Message-Id: <20190329001135.15847-17-changbin.du@gmail.com>
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
 Documentation/acpi/{debug.txt => debug.rst} | 31 +++++++++++----------
 Documentation/acpi/index.rst                |  1 +
 2 files changed, 18 insertions(+), 14 deletions(-)
 rename Documentation/acpi/{debug.txt => debug.rst} (91%)

diff --git a/Documentation/acpi/debug.txt b/Documentation/acpi/debug.rst
similarity index 91%
rename from Documentation/acpi/debug.txt
rename to Documentation/acpi/debug.rst
index 65bf47c46b6d..1a152dd1d765 100644
--- a/Documentation/acpi/debug.txt
+++ b/Documentation/acpi/debug.rst
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
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index b680fb13f445..ee0000a396e4 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -21,3 +21,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    method-customizing
    initrd_table_override
    dsdt-override
+   debug
-- 
2.20.1

