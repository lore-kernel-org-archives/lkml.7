Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B0A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paydmlBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfC2ANg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46169 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfC2ANa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so133700pfj.13;
        Thu, 28 Mar 2019 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyfhsLmaq1V/aRur5dBa23CgZwjMWfYxpowPFGnTGR0=;
        b=paydmlBwJ2XI2N8hY9lfibXtsaIQkRd8r8lKYjePd2UF1RqKq2ltayJxPTquya0kQI
         svdLdMz9wNfEGmtT8tWvB393ckVPprHXZnEGgqDJr7+Yi04nw9ACgtJspz8Io9iBeuwT
         TTQVPZCjVxD8a26ambGFDJUy3CY6HwaESb1RFKXrJNM6fkxsGBPvr+Q0GiGzHG64lgiT
         FJRWFis81l6YxbLGWGU1kdls0zDci1y6O7IUbOvKFgTSjfK/IgUUj5LU01a7nAIXYaD1
         GoezeolaGn0tL7U3uwnqstrYYOoEq0Q0Y6wfkE0FqvIDYnobJxpsjYZt2w2S49Ll/tGj
         KRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyfhsLmaq1V/aRur5dBa23CgZwjMWfYxpowPFGnTGR0=;
        b=BSu1OHOYEFdgglJAsNJHT7/uxScF1eRV0zqVarg6FMmFxaFJoYTza3z0JBC3yoLFt9
         4mMLoLs/qv8GGNqpAuojFtL09rFG7X3yGhOuF+W5uagSruXN9T3ug21v1k5BOULuhsNz
         U1HQKCSUTL5EXV71izdytlY4XZMkzOqv65FNZ3bjTnVe+YN1R2q5bMfUkLGU4r4nPUf3
         GKYlm//mYgtKw8OKR6aRlIkZFGnFR5LZYMPAmkHp9ld89tuNFEhqf1iS17lQZGSeWk+/
         D0FSI1vs8LbVtwoeHLQCQ94OR7Tvbubn1DCm5oyXyvKZNH5KRDUpYcoFBmT09kncdS2A
         K5Xg==
X-Gm-Message-State: APjAAAUpRTdnyRHd5aEaV+9+Gxgld13kuliLIOuP+RpFiqZOIlFtE6UF
        Jss5S4HZwmQuZyAqQccIupU=
X-Google-Smtp-Source: APXvYqwlXI65t9ff0em03xfocdCE174QBjvYlPXAZRuZ65cU0hCrh9LvegrLg8/bweU9AKQypQn7tg==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr28370588pgv.322.1553818409723;
        Thu, 28 Mar 2019 17:13:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 17/24] acpi doc: convert acpi/method-tracing.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:28 +0800
Message-Id: <20190329001135.15847-18-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst          |   1 +
 Documentation/acpi/method-tracing.rst | 225 ++++++++++++++++++++++++++
 Documentation/acpi/method-tracing.txt | 192 ----------------------
 3 files changed, 226 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/acpi/method-tracing.rst
 delete mode 100644 Documentation/acpi/method-tracing.txt

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index ee0000a396e4..a3c5ddb15a0e 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -22,3 +22,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    initrd_table_override
    dsdt-override
    debug
+   method-tracing
diff --git a/Documentation/acpi/method-tracing.rst b/Documentation/acpi/method-tracing.rst
new file mode 100644
index 000000000000..7a997ba168d7
--- /dev/null
+++ b/Documentation/acpi/method-tracing.rst
@@ -0,0 +1,225 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=====================
+ACPICA Trace Facility
+=====================
+
+:Copyright: |copy| 2015, Intel Corporation
+:Author: Lv Zheng <lv.zheng@intel.com>
+
+
+:Abstract: This document describes the functions and the interfaces of the
+  method tracing facility.
+
+1. Functionalities and usage examples
+=====================================
+
+ACPICA provides method tracing capability. And two functions are
+currently implemented using this capability.
+
+Log reducer
+--------------
+
+ACPICA subsystem provides debugging outputs when CONFIG_ACPI_DEBUG is
+enabled. The debugging messages which are deployed via
+ACPI_DEBUG_PRINT() macro can be reduced at 2 levels - per-component
+level (known as debug layer, configured via
+/sys/module/acpi/parameters/debug_layer) and per-type level (known as
+debug level, configured via /sys/module/acpi/parameters/debug_level).
+
+But when the particular layer/level is applied to the control method
+evaluations, the quantity of the debugging outputs may still be too
+large to be put into the kernel log buffer. The idea thus is worked out
+to only enable the particular debug layer/level (normally more detailed)
+logs when the control method evaluation is started, and disable the
+detailed logging when the control method evaluation is stopped.
+
+The following command examples illustrate the usage of the "log reducer"
+functionality:
+
+a. Filter out the debug layer/level matched logs when control methods
+   are being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0xXXXXXXXX" > trace_debug_layer
+      # echo "0xYYYYYYYY" > trace_debug_level
+      # echo "enable" > trace_state
+
+b. Filter out the debug layer/level matched logs when the specified
+   control method is being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0xXXXXXXXX" > trace_debug_layer
+      # echo "0xYYYYYYYY" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method" > /sys/module/acpi/parameters/trace_state
+
+c. Filter out the debug layer/level matched logs when the specified
+   control method is being evaluated for the first time::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0xXXXXXXXX" > trace_debug_layer
+      # echo "0xYYYYYYYY" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method-once" > /sys/module/acpi/parameters/trace_state
+
+Where:
+   0xXXXXXXXX/0xYYYYYYYY
+     Refer to Documentation/acpi/debug.txt for possible debug layer/level
+     masking values.
+   \PPPP.AAAA.TTTT.HHHH
+     Full path of a control method that can be found in the ACPI namespace.
+     It needn't be an entry of a control method evaluation.
+
+AML tracer
+-------------
+
+There are special log entries added by the method tracing facility at
+the "trace points" the AML interpreter starts/stops to execute a control
+method, or an AML opcode. Note that the format of the log entries are
+subject to change::
+
+   [    0.186427]   exdebug-0398 ex_trace_point        : Method Begin [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
+   [    0.186630]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905c88:If] execution.
+   [    0.186820]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:LEqual] execution.
+   [    0.187010]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905a20:-NamePath-] execution.
+   [    0.187214]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905a20:-NamePath-] execution.
+   [    0.187407]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
+   [    0.187594]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
+   [    0.187789]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:LEqual] execution.
+   [    0.187980]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:Return] execution.
+   [    0.188146]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
+   [    0.188334]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
+   [    0.188524]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:Return] execution.
+   [    0.188712]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905c88:If] execution.
+   [    0.188903]   exdebug-0398 ex_trace_point        : Method End [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
+
+Developers can utilize these special log entries to track the AML
+interpretion, thus can aid issue debugging and performance tuning. Note
+that, as the "AML tracer" logs are implemented via ACPI_DEBUG_PRINT()
+macro, CONFIG_ACPI_DEBUG is also required to be enabled for enabling
+"AML tracer" logs.
+
+The following command examples illustrate the usage of the "AML tracer"
+functionality:
+
+a. Filter out the method start/stop "AML tracer" logs when control
+   methods are being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "enable" > trace_state
+
+b. Filter out the method start/stop "AML tracer" when the specified
+   control method is being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method" > trace_state
+
+c. Filter out the method start/stop "AML tracer" logs when the specified
+   control method is being evaluated for the first time::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "method-once" > trace_state
+
+d. Filter out the method/opcode start/stop "AML tracer" when the
+   specified control method is being evaluated::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "opcode" > trace_state
+
+e. Filter out the method/opcode start/stop "AML tracer" when the
+   specified control method is being evaluated for the first time::
+
+      # cd /sys/module/acpi/parameters
+      # echo "0x80" > trace_debug_layer
+      # echo "0x10" > trace_debug_level
+      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+      # echo "opcode-opcode" > trace_state
+
+Note that all above method tracing facility related module parameters can
+be used as the boot parameters, for example::
+
+   acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 \
+   acpi.trace_method_name=\_SB.LID0._LID acpi.trace_state=opcode-once
+
+2. Interface descriptions
+=========================
+
+All method tracing functions can be configured via ACPI module
+parameters that are accessible at /sys/module/acpi/parameters/:
+
+trace_method_name
+The full path of the AML method that the user wants to trace.
+Note that the full path shouldn't contain the trailing "_"s in its
+name segments but may contain "\" to form an absolute path.
+
+trace_debug_layer
+The temporary debug_layer used when the tracing feature is enabled.
+Using ACPI_EXECUTER (0x80) by default, which is the debug_layer
+used to match all "AML tracer" logs.
+
+trace_debug_level
+The temporary debug_level used when the tracing feature is enabled.
+Using ACPI_LV_TRACE_POINT (0x10) by default, which is the
+debug_level used to match all "AML tracer" logs.
+
+trace_state
+The status of the tracing feature.
+Users can enable/disable this debug tracing feature by executing
+the following command::
+
+   # echo string > /sys/module/acpi/parameters/trace_state
+
+Where "string" should be one of the following:
+
+"disable"
+      Disable the method tracing feature.
+"enable"
+      Enable the method tracing feature.
+      ACPICA debugging messages matching
+      "trace_debug_layer/trace_debug_level" during any method
+      execution will be logged.
+"method"
+      Enable the method tracing feature.
+      ACPICA debugging messages matching
+      "trace_debug_layer/trace_debug_level" during method execution
+      of "trace_method_name" will be logged.
+"method-once"
+      Enable the method tracing feature.
+      ACPICA debugging messages matching
+      "trace_debug_layer/trace_debug_level" during method execution
+      of "trace_method_name" will be logged only once.
+"opcode"
+      Enable the method tracing feature.
+      ACPICA debugging messages matching
+      "trace_debug_layer/trace_debug_level" during method/opcode
+      execution of "trace_method_name" will be logged.
+"opcode-once"
+      Enable the method tracing feature.
+      ACPICA debugging messages matching
+      "trace_debug_layer/trace_debug_level" during method/opcode
+      execution of "trace_method_name" will be logged only once.
+
+Note that, the difference between the "enable" and other feature
+enabling options are:
+
+1. When "enable" is specified, since
+   "trace_debug_layer/trace_debug_level" shall apply to all control
+   method evaluations, after configuring "trace_state" to "enable",
+   "trace_method_name" will be reset to NULL.
+2. When "method/opcode" is specified, if
+   "trace_method_name" is NULL when "trace_state" is configured to
+   these options, the "trace_debug_layer/trace_debug_level" will
+   apply to all control method evaluations.
diff --git a/Documentation/acpi/method-tracing.txt b/Documentation/acpi/method-tracing.txt
deleted file mode 100644
index 0aba14c8f459..000000000000
--- a/Documentation/acpi/method-tracing.txt
+++ /dev/null
@@ -1,192 +0,0 @@
-ACPICA Trace Facility
-
-Copyright (C) 2015, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
-
-
-Abstract:
-
-This document describes the functions and the interfaces of the method
-tracing facility.
-
-1. Functionalities and usage examples:
-
-   ACPICA provides method tracing capability. And two functions are
-   currently implemented using this capability.
-
-   A. Log reducer
-   ACPICA subsystem provides debugging outputs when CONFIG_ACPI_DEBUG is
-   enabled. The debugging messages which are deployed via
-   ACPI_DEBUG_PRINT() macro can be reduced at 2 levels - per-component
-   level (known as debug layer, configured via
-   /sys/module/acpi/parameters/debug_layer) and per-type level (known as
-   debug level, configured via /sys/module/acpi/parameters/debug_level).
-
-   But when the particular layer/level is applied to the control method
-   evaluations, the quantity of the debugging outputs may still be too
-   large to be put into the kernel log buffer. The idea thus is worked out
-   to only enable the particular debug layer/level (normally more detailed)
-   logs when the control method evaluation is started, and disable the
-   detailed logging when the control method evaluation is stopped.
-
-   The following command examples illustrate the usage of the "log reducer"
-   functionality:
-   a. Filter out the debug layer/level matched logs when control methods
-      are being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "enable" > trace_state
-   b. Filter out the debug layer/level matched logs when the specified
-      control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method" > /sys/module/acpi/parameters/trace_state
-   c. Filter out the debug layer/level matched logs when the specified
-      control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method-once" > /sys/module/acpi/parameters/trace_state
-   Where:
-      0xXXXXXXXX/0xYYYYYYYY: Refer to Documentation/acpi/debug.txt for
-			     possible debug layer/level masking values.
-      \PPPP.AAAA.TTTT.HHHH: Full path of a control method that can be found
-			    in the ACPI namespace. It needn't be an entry
-			    of a control method evaluation.
-
-   B. AML tracer
-
-   There are special log entries added by the method tracing facility at
-   the "trace points" the AML interpreter starts/stops to execute a control
-   method, or an AML opcode. Note that the format of the log entries are
-   subject to change:
-     [    0.186427]   exdebug-0398 ex_trace_point        : Method Begin [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
-     [    0.186630]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905c88:If] execution.
-     [    0.186820]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:LEqual] execution.
-     [    0.187010]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905a20:-NamePath-] execution.
-     [    0.187214]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905a20:-NamePath-] execution.
-     [    0.187407]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
-     [    0.187594]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
-     [    0.187789]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:LEqual] execution.
-     [    0.187980]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:Return] execution.
-     [    0.188146]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905f60:One] execution.
-     [    0.188334]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905f60:One] execution.
-     [    0.188524]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905cc0:Return] execution.
-     [    0.188712]   exdebug-0398 ex_trace_point        : Opcode End [0xf5905c88:If] execution.
-     [    0.188903]   exdebug-0398 ex_trace_point        : Method End [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
-
-   Developers can utilize these special log entries to track the AML
-   interpretion, thus can aid issue debugging and performance tuning. Note
-   that, as the "AML tracer" logs are implemented via ACPI_DEBUG_PRINT()
-   macro, CONFIG_ACPI_DEBUG is also required to be enabled for enabling
-   "AML tracer" logs.
-
-   The following command examples illustrate the usage of the "AML tracer"
-   functionality:
-   a. Filter out the method start/stop "AML tracer" logs when control
-      methods are being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "enable" > trace_state
-   b. Filter out the method start/stop "AML tracer" when the specified
-      control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method" > trace_state
-   c. Filter out the method start/stop "AML tracer" logs when the specified
-      control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method-once" > trace_state
-   d. Filter out the method/opcode start/stop "AML tracer" when the
-      specified control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "opcode" > trace_state
-   e. Filter out the method/opcode start/stop "AML tracer" when the
-      specified control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "opcode-opcode" > trace_state
-
-  Note that all above method tracing facility related module parameters can
-  be used as the boot parameters, for example:
-      acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 \
-      acpi.trace_method_name=\_SB.LID0._LID acpi.trace_state=opcode-once
-
-2. Interface descriptions:
-
-   All method tracing functions can be configured via ACPI module
-   parameters that are accessible at /sys/module/acpi/parameters/:
-
-   trace_method_name
-	The full path of the AML method that the user wants to trace.
-	Note that the full path shouldn't contain the trailing "_"s in its
-	name segments but may contain "\" to form an absolute path.
-
-   trace_debug_layer
-	The temporary debug_layer used when the tracing feature is enabled.
-	Using ACPI_EXECUTER (0x80) by default, which is the debug_layer
-	used to match all "AML tracer" logs.
-
-   trace_debug_level
-	The temporary debug_level used when the tracing feature is enabled.
-	Using ACPI_LV_TRACE_POINT (0x10) by default, which is the
-	debug_level used to match all "AML tracer" logs.
-
-   trace_state
-	The status of the tracing feature.
-	Users can enable/disable this debug tracing feature by executing
-	the following command:
-	    # echo string > /sys/module/acpi/parameters/trace_state
-	Where "string" should be one of the following:
-	"disable"
-	    Disable the method tracing feature.
-	"enable"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during any method
-	    execution will be logged.
-	"method"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method execution
-	    of "trace_method_name" will be logged.
-	"method-once"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method execution
-	    of "trace_method_name" will be logged only once.
-	"opcode"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method/opcode
-	    execution of "trace_method_name" will be logged.
-	"opcode-once"
-	    Enable the method tracing feature.
-	    ACPICA debugging messages matching
-	    "trace_debug_layer/trace_debug_level" during method/opcode
-	    execution of "trace_method_name" will be logged only once.
-	Note that, the difference between the "enable" and other feature
-        enabling options are:
-	1. When "enable" is specified, since
-	   "trace_debug_layer/trace_debug_level" shall apply to all control
-	   method evaluations, after configuring "trace_state" to "enable",
-	   "trace_method_name" will be reset to NULL.
-	2. When "method/opcode" is specified, if
-	   "trace_method_name" is NULL when "trace_state" is configured to
-	   these options, the "trace_debug_layer/trace_debug_level" will
-	   apply to all control method evaluations.
-- 
2.20.1

