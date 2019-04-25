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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A5A206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv50gmiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfDYPcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:32:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42576 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbfDYPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:32:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so82981pfi.9;
        Thu, 25 Apr 2019 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3zkoA2tV6BtinIJTJHud/7LDHzo3e/6dxbxlcXLLfQ=;
        b=gv50gmiBmxvOy3I41zkkP/R0kr22co2hjfKdC9LDlpxcmKJjEilpcroUxZbH/5XN1z
         qw+PUlxBFYIqdbabpHgXSEWWTSf1cq1Xb5zubZ/oB/XTf1oa9kvY4IJQQzc24pGR/Vm0
         vf4do3TfYhD5HVhlkj/2viSONtQe3FVI5CMz+ggDvA0RWvwDWXdcUVQ+6tC/zagXffxs
         wDViBuBKswSJjfEoM6wQYSm2CyzLVagYsCMylBDFsPym5QzPqYI64oFXtAz5wFt0bUH2
         wB99v92ynJHw/Z4eXSwDrdfDM8nQc3nAZ1YUedJaMzABxb/CMMBAm1TWUYpBdJU9dpyf
         podw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3zkoA2tV6BtinIJTJHud/7LDHzo3e/6dxbxlcXLLfQ=;
        b=oYGSQRke8rBYkLChjtTRnSvPohuIZNea5Ii76w54CWWUxl1IB44+RAFeTyuiqNoqY2
         a1meh+gyl7odylkO2F1ZuPFosddyvc/UQY44vthzWvEzCW3Pm/wb95Ya7TgpJoErxP7A
         kmR+de3ABVyjwnBR2JSfxgl0ktn4uiS7DqZkiQqQy0mjlJHiKJ3FbG4NWA9InUVqNAtL
         HOOWD1A6Sm6t4TA96+MeCYWxlGxe2zSlPj+oDlbY+fMByCTB2E9O0fD4j1vdXaw5WYlJ
         cL1XEx1sCvm1W7A/PqIAKsefjUO9xbu1BuXa89e5++4zq0neG1yZcxRBORJvyiG3h4H7
         StMQ==
X-Gm-Message-State: APjAAAXh7b8G7V8NK/VvutG0gN/YJsZgkNcAfqg9a8PGgOUhlc3gEs2C
        yfOS57UP4dCKZOlwUifzuwM=
X-Google-Smtp-Source: APXvYqzPSXJCCtOCFiChebMAkxAH/bGbNSWXqEY4idZ0r4THNvF2CK1c2G62HRi2Yfhq6sljSp1hpg==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr1753759pfm.102.1556206347562;
        Thu, 25 Apr 2019 08:32:27 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:32:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 09/24] Documentation: ACPI: move method-customizing.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:02 +0800
Message-Id: <20190425153117.16057-10-changbin.du@gmail.com>
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
 Documentation/acpi/method-customizing.txt     | 73 ---------------
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 .../acpi/method-customizing.rst               | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/acpi/method-customizing.txt
 create mode 100644 Documentation/firmware-guide/acpi/method-customizing.rst

diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
deleted file mode 100644
index 7235da975f23..000000000000
--- a/Documentation/acpi/method-customizing.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-Linux ACPI Custom Control Method How To
-=======================================
-
-Written by Zhang Rui <rui.zhang@intel.com>
-
-
-Linux supports customizing ACPI control methods at runtime.
-
-Users can use this to
-1. override an existing method which may not work correctly,
-   or just for debugging purposes.
-2. insert a completely new method in order to create a missing
-   method such as _OFF, _ON, _STA, _INI, etc.
-For these cases, it is far simpler to dynamically install a single
-control method rather than override the entire DSDT, because kernel
-rebuild/reboot is not needed and test result can be got in minutes.
-
-Note: Only ACPI METHOD can be overridden, any other object types like
-      "Device", "OperationRegion", are not recognized. Methods
-      declared inside scope operators are also not supported.
-Note: The same ACPI control method can be overridden for many times,
-      and it's always the latest one that used by Linux/kernel.
-Note: To get the ACPI debug object output (Store (AAAA, Debug)),
-      please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
-
-1. override an existing method
-   a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
-      just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
-   b) disassemble the table by running "iasl -d dsdt.dat".
-   c) rewrite the ASL code of the method and save it in a new file,
-   d) package the new file (psr.asl) to an ACPI table format.
-      Here is an example of a customized \_SB._AC._PSR method,
-
-      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
-      {
-	Method (\_SB_.AC._PSR, 0, NotSerialized)
-	{
-		Store ("In AC _PSR", Debug)
-		Return (ACON)
-	}
-      }
-      Note that the full pathname of the method in ACPI namespace
-      should be used.
-   e) assemble the file to generate the AML code of the method.
-      e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
-      If parameter "-vw 6084" is not supported by your iASL compiler,
-      please try a newer version.
-   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
-   g) override the old method via the debugfs by running
-      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
-
-2. insert a new method
-   This is easier than overriding an existing method.
-   We just need to create the ASL code of the method we want to
-   insert and then follow the step c) ~ g) in section 1.
-
-3. undo your changes
-   The "undo" operation is not supported for a new inserted method
-   right now, i.e. we can not remove a method currently.
-   For an overridden method, in order to undo your changes, please
-   save a copy of the method original ASL code in step c) section 1,
-   and redo step c) ~ g) to override the method with the original one.
-
-
-Note: We can use a kernel with multiple custom ACPI method running,
-      But each individual write to debugfs can implement a SINGLE
-      method override. i.e. if we want to insert/override multiple
-      ACPI methods, we need to redo step c) ~ g) for multiple times.
-
-Note: Be aware that root can mis-use this driver to modify arbitrary
-      memory and gain additional rights, if root's privileges got
-      restricted (for example if root is not allowed to load additional
-      modules after boot).
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 61d67763851b..d1d069b26bbc 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -10,5 +10,6 @@ ACPI Support
    namespace
    enumeration
    osi
+   method-customizing
    DSD-properties-rules
-   gpio-properties
+   gpio-properties
\ No newline at end of file
diff --git a/Documentation/firmware-guide/acpi/method-customizing.rst b/Documentation/firmware-guide/acpi/method-customizing.rst
new file mode 100644
index 000000000000..de3ebcaed4cf
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/method-customizing.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Linux ACPI Custom Control Method How To
+=======================================
+
+:Author: Zhang Rui <rui.zhang@intel.com>
+
+
+Linux supports customizing ACPI control methods at runtime.
+
+Users can use this to:
+
+1. override an existing method which may not work correctly,
+   or just for debugging purposes.
+2. insert a completely new method in order to create a missing
+   method such as _OFF, _ON, _STA, _INI, etc.
+
+For these cases, it is far simpler to dynamically install a single
+control method rather than override the entire DSDT, because kernel
+rebuild/reboot is not needed and test result can be got in minutes.
+
+.. note::
+
+  - Only ACPI METHOD can be overridden, any other object types like
+    "Device", "OperationRegion", are not recognized. Methods
+    declared inside scope operators are also not supported.
+
+  - The same ACPI control method can be overridden for many times,
+    and it's always the latest one that used by Linux/kernel.
+
+  - To get the ACPI debug object output (Store (AAAA, Debug)),
+    please run::
+
+      echo 1 > /sys/module/acpi/parameters/aml_debug_output
+
+
+1. override an existing method
+==============================
+a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
+   just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
+b) disassemble the table by running "iasl -d dsdt.dat".
+c) rewrite the ASL code of the method and save it in a new file,
+d) package the new file (psr.asl) to an ACPI table format.
+   Here is an example of a customized \_SB._AC._PSR method::
+
+      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
+      {
+         Method (\_SB_.AC._PSR, 0, NotSerialized)
+         {
+            Store ("In AC _PSR", Debug)
+            Return (ACON)
+         }
+      }
+
+   Note that the full pathname of the method in ACPI namespace
+   should be used.
+e) assemble the file to generate the AML code of the method.
+   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
+   If parameter "-vw 6084" is not supported by your iASL compiler,
+   please try a newer version.
+f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
+g) override the old method via the debugfs by running
+   "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
+
+2. insert a new method
+======================
+This is easier than overriding an existing method.
+We just need to create the ASL code of the method we want to
+insert and then follow the step c) ~ g) in section 1.
+
+3. undo your changes
+====================
+The "undo" operation is not supported for a new inserted method
+right now, i.e. we can not remove a method currently.
+For an overridden method, in order to undo your changes, please
+save a copy of the method original ASL code in step c) section 1,
+and redo step c) ~ g) to override the method with the original one.
+
+
+.. note:: We can use a kernel with multiple custom ACPI method running,
+   But each individual write to debugfs can implement a SINGLE
+   method override. i.e. if we want to insert/override multiple
+   ACPI methods, we need to redo step c) ~ g) for multiple times.
+
+.. note:: Be aware that root can mis-use this driver to modify arbitrary
+   memory and gain additional rights, if root's privileges got
+   restricted (for example if root is not allowed to load additional
+   modules after boot).
-- 
2.20.1

