Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4026FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6232075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7z5aQhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfC2AMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38668 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2AMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so130622plb.5;
        Thu, 28 Mar 2019 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dA0pfVy9Llp9FksORyMVq9pfw5s+gke+P4BgXYNJeeo=;
        b=r7z5aQhsWEhbn7kCS76LPZ4ilzzXTDIrZ3jJCXuA2rWTsVR5ug9fwe7AMQgsrfuGQ/
         uzUBR0SLq0PNY7Hzdl3Py6KroyBUg4uOWnTrCh5CrydS7m3gvuljGk627y3lCnVoCbaO
         2v6GL+juDflEW/QPPsUb4vmYdKv+EY73Hzf/UiAkG258f+gEloId2sxgDdxYAqAEebs9
         AKsfFj5OrdfZfIK/9/6vp3PX7OvP8WrX1UGsQqw9VbT1fOEoI3MZl5DOwX6+/fZdYBhK
         Q2AJpb9A/Xi/F01pDz/jjl7eGv0M3hrprb3Rci/IvgNdLi8w88jidFtD+0ySb6D1heAD
         O9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dA0pfVy9Llp9FksORyMVq9pfw5s+gke+P4BgXYNJeeo=;
        b=noSNfxmymlqBbdKnXm35v8DgSkL713Oq1EqNyRI/18kKqeoz5fhv1lDnESXYD0FgOh
         A1lI4JuAEabOuuxlKZ9fde7pD/ZcFX1LuJzXK7JsV36364O8rDRDHCflEfw0LSQUBcMT
         dF5AB/EUPrzzJozGkz7axEeUkY82dgHRg+exM7EG/DTJZQ70RmJnKRcREr4NP88nCZ2p
         rvKPhB4cxrF6FcJngmFGT3zPyqJeej5BbqhZE04bTCBNEjUg7qhByccVRJdVKcWaM4LM
         oc7CtXCH3kv2ZiPdL41EBYlUcUI8fWjSXipp1SiWxDj0WKWqydXSX/k51SicjcDefENc
         fUsA==
X-Gm-Message-State: APjAAAXC8KlPF9MU5L9TJpljIv8uA75C6SUcWNUR04AgTVYpdB8Jbs28
        wzto0xSIhXVp9SdziMuVsDE=
X-Google-Smtp-Source: APXvYqy45uaxYLth+Oi1BXGfYGI+C9L/2A0z8jA0vfyOnVeftBbw3ron1+afhnoLBXBaDYfeaYfWAw==
X-Received: by 2002:a17:902:a511:: with SMTP id s17mr45195710plq.262.1553818370648;
        Thu, 28 Mar 2019 17:12:50 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:49 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 09/24] acpi doc: convert acpi/method-customizing.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:20 +0800
Message-Id: <20190329001135.15847-10-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst              |  1 +
 Documentation/acpi/method-customizing.rst | 82 +++++++++++++++++++++++
 Documentation/acpi/method-customizing.txt | 73 --------------------
 3 files changed, 83 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/acpi/method-customizing.rst
 delete mode 100644 Documentation/acpi/method-customizing.txt

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 0fae18cc1eea..409e98f19748 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -14,3 +14,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    DSD-properties-rules
    gpio-properties
    scan_handlers
+   method-customizing
diff --git a/Documentation/acpi/method-customizing.rst b/Documentation/acpi/method-customizing.rst
new file mode 100644
index 000000000000..32eb1cdc1549
--- /dev/null
+++ b/Documentation/acpi/method-customizing.rst
@@ -0,0 +1,82 @@
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
+.. note:: Only ACPI METHOD can be overridden, any other object types like
+   "Device", "OperationRegion", are not recognized. Methods
+   declared inside scope operators are also not supported.
+.. note:: The same ACPI control method can be overridden for many times,
+   and it's always the latest one that used by Linux/kernel.
+.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
+   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
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
-- 
2.20.1

