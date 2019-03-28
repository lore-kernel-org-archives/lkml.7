Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74442183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyiIaJdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfC1Q34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42120 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Q3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so5213901plb.9;
        Thu, 28 Mar 2019 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgiHW6sZjESZHY3/1FQNS9NWd9qLpnbJAfZL5jUguto=;
        b=jyiIaJdc5mOcnVusiCoIhIGwemqV1sqDkivYUuZbjkCvHKZNCCDMGQOSiEd+llDGL2
         I4jCsIWHqFefzSK+OziXRc0VleV7ruorQoUizZj4WvqsN5lIpClcJPdSE1Lyis0Gokic
         kS+xXrKppvji/IToWZJOy6GR8neIAuPsYWbq8v7EUI8sgkeXKi5ACxyjg9k7R80WdhSK
         3LYP+vv/awbySJTg2VJg7L24Tj4EEVQpMgzeqA9kiJml7/W+kZh/ay9YK503xZ7owFP/
         yaUNmezlkMs65CyJ08moUI9NKRDsYdoux2SbYzfbcMRPTiCouOipUFBHAJBTZ5VB73TD
         AV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgiHW6sZjESZHY3/1FQNS9NWd9qLpnbJAfZL5jUguto=;
        b=gYyhfIYqgpp4Kc5nwM2e/ACv/2ripA0qQe2LgO6K/edUOp83SJEcbtZJS0x9skgF4q
         0q62W4FtRWYeYMdj5STT7Xg86TJt8R43zkAKL9L1xY2ePdx6Q3rOKGBeW+YqJ9e0jfbW
         r5XTUp7XGrk+4PyTLyPynggruBprR/mqLfuQP8AfvusVoy7LYj1BYdl5V56yJwb/1tbe
         AYlXb5wDyYulWDZboswJyGZp7W2c3Sej6L6L8gtUUSehlQypVpryjN74lEc9ggNVrHCY
         bNH1t3DA33yBgGMZS2XTORlsOueKiw5AolO5zhKOOudJH7o1Nk/2vgFx4XbMyLjS7nCS
         u+zw==
X-Gm-Message-State: APjAAAW/XqnQlYPxykFY6jiaKsjMlZIp2YNJpJov92m3580q0VUPeqLn
        FROs3dI7iFut02iTM0zjfgE=
X-Google-Smtp-Source: APXvYqwGZOyBfNlV6/gu97e4PRTRKRmp2gGQusSlDgBVfuBZrsEwxCHZ7Obwgs+AP8iq89Y5TJnH/w==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr43568776ply.243.1553790592926;
        Thu, 28 Mar 2019 09:29:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 16/23] acpi doc: convert acpi/method-tracing.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:14 +0800
Message-Id: <20190328162721.26138-17-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst          |   1 +
 Documentation/acpi/method-tracing.rst | 224 ++++++++++++++++++++++++++
 Documentation/acpi/method-tracing.txt | 192 ----------------------
 3 files changed, 225 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/acpi/method-tracing.rst
 delete mode 100644 Documentation/acpi/method-tracing.txt

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 3bd1d9996ffc..48964586ef75 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -20,3 +20,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    initrd_table_override
    dsdt-override
    debug
+   method-tracing
diff --git a/Documentation/acpi/method-tracing.rst b/Documentation/acpi/method-tracing.rst
new file mode 100644
index 000000000000..5edb22391c87
--- /dev/null
+++ b/Documentation/acpi/method-tracing.rst
@@ -0,0 +1,224 @@
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

