Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE04DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6AB21850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwqumCfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfC2ANl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38710 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfC2ANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so131309plb.5;
        Thu, 28 Mar 2019 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7GmyxxsAbglevWR8mh3EqJ6PmOlr7B4jt5/Agj2J4Ac=;
        b=EwqumCfnku7GyGcp95e8rV3O7AbPyCjVbbd8UR8ydkGM9a5EtlXZVS8i2SubEoIYHP
         McJ5YfLCwaSZm9yll9vLA2LS18xlrPmJi6SshPgwqlmO7sGAXgzZg5DylYhsIx9Bk6fu
         OT+y2IGw7u0ypSCtQaEZnbUhDIVspinVx56brpFAqsMzk6/uf1yVzY8mDDiroB+JI0r7
         5w6+iVwmbnDiG6RDBaVDVXAmIL6kiV12XpLjcG60WSZD5aoeiN4sAahVuj7ix/6BAjZd
         P+eowZCUQfH/5YMWQaMT8FENsea0LatK05anHUofG7N87REfrEQNwwNEcn8J3n+OI0Vi
         xI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7GmyxxsAbglevWR8mh3EqJ6PmOlr7B4jt5/Agj2J4Ac=;
        b=GuSgzhiOqvtjBb6CIhDnO2N96tHdFQk/FU42UsPzxShO56QUNPliWT+a/9/81JITca
         wpbIANiEF8wMI99meoVY7VoiiQNdSuwNalCHI+dX8kF1ONdqRuxMDcyRn3X89sm6n+aq
         s94BE1/y38PZjxv5J/z5t0tuhI/Y2KMHgaJou6QSppdghrTvoMcxi6NE7cGLOx9+T8Ll
         TKoJ9VykOdLfCxAqkqxR4aS4+EbrhvxkDDX7ny/OBL8YV7Lcfiu5T3sYLMm0xCiBaa8F
         01Ox4DI5WbajuuSWSBwCbUL1QZvq2kEysM6W39pUStDsAVI7B9hn9FSX2IU/jHfADwSo
         CevQ==
X-Gm-Message-State: APjAAAVOAa3Uf31YMoXTHohc7M6iLxDQPwbL7Zp6NH+E+amJNQ+yRj56
        RvIJ/2c3uTg0rDVnkXWeI+I=
X-Google-Smtp-Source: APXvYqz+hUdriAR7nmFOZlgbLJXbMVCzEW/FK2d1EhywpIquwvWf+dAkhAnghQDjHb+MElE+FxXelA==
X-Received: by 2002:a17:902:d889:: with SMTP id b9mr43322285plz.294.1553818414863;
        Thu, 28 Mar 2019 17:13:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 18/24] acpi doc: convert acpi/aml-debugger.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:29 +0800
Message-Id: <20190329001135.15847-19-changbin.du@gmail.com>
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
 Documentation/acpi/aml-debugger.rst | 75 +++++++++++++++++++++++++++++
 Documentation/acpi/aml-debugger.txt | 66 -------------------------
 Documentation/acpi/index.rst        |  1 +
 3 files changed, 76 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt

diff --git a/Documentation/acpi/aml-debugger.rst b/Documentation/acpi/aml-debugger.rst
new file mode 100644
index 000000000000..a889d43bc6c5
--- /dev/null
+++ b/Documentation/acpi/aml-debugger.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+================
+The AML Debugger
+================
+
+:Copyright: |copy| 2016, Intel Corporation
+:Author: Lv Zheng <lv.zheng@intel.com>
+
+
+This document describes the usage of the AML debugger embedded in the Linux
+kernel.
+
+1. Build the debugger
+=====================
+
+The following kernel configuration items are required to enable the AML
+debugger interface from the Linux kernel::
+
+   CONFIG_ACPI_DEBUGGER=y
+   CONFIG_ACPI_DEBUGGER_USER=m
+
+The userspace utilities can be built from the kernel source tree using
+the following commands::
+
+   $ cd tools
+   $ make acpi
+
+The resultant userspace tool binary is then located at::
+
+   tools/power/acpi/acpidbg
+
+It can be installed to system directories by running "make install" (as a
+sufficiently privileged user).
+
+2. Start the userspace debugger interface
+=========================================
+
+After booting the kernel with the debugger built-in, the debugger can be
+started by using the following commands::
+
+   # mount -t debugfs none /sys/kernel/debug
+   # modprobe acpi_dbg
+   # tools/power/acpi/acpidbg
+
+That spawns the interactive AML debugger environment where you can execute
+debugger commands.
+
+The commands are documented in the "ACPICA Overview and Programmer Reference"
+that can be downloaded from
+
+https://acpica.org/documentation
+
+The detailed debugger commands reference is located in Chapter 12 "ACPICA
+Debugger Reference".  The "help" command can be used for a quick reference.
+
+3. Stop the userspace debugger interface
+========================================
+
+The interactive debugger interface can be closed by pressing Ctrl+C or using
+the "quit" or "exit" commands.  When finished, unload the module with::
+
+   # rmmod acpi_dbg
+
+The module unloading may fail if there is an acpidbg instance running.
+
+4. Run the debugger in a script
+===============================
+
+It may be useful to run the AML debugger in a test script. "acpidbg" supports
+this in a special "batch" mode.  For example, the following command outputs
+the entire ACPI namespace::
+
+   # acpidbg -b "namespace"
diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
deleted file mode 100644
index 75ebeb64ab29..000000000000
--- a/Documentation/acpi/aml-debugger.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-The AML Debugger
-
-Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
-
-
-This document describes the usage of the AML debugger embedded in the Linux
-kernel.
-
-1. Build the debugger
-
-   The following kernel configuration items are required to enable the AML
-   debugger interface from the Linux kernel:
-
-   CONFIG_ACPI_DEBUGGER=y
-   CONFIG_ACPI_DEBUGGER_USER=m
-
-   The userspace utilities can be built from the kernel source tree using
-   the following commands:
-
-   $ cd tools
-   $ make acpi
-
-   The resultant userspace tool binary is then located at:
-
-     tools/power/acpi/acpidbg
-
-   It can be installed to system directories by running "make install" (as a
-   sufficiently privileged user).
-
-2. Start the userspace debugger interface
-
-   After booting the kernel with the debugger built-in, the debugger can be
-   started by using the following commands:
-
-   # mount -t debugfs none /sys/kernel/debug
-   # modprobe acpi_dbg
-   # tools/power/acpi/acpidbg
-
-   That spawns the interactive AML debugger environment where you can execute
-   debugger commands.
-
-   The commands are documented in the "ACPICA Overview and Programmer Reference"
-   that can be downloaded from
-
-   https://acpica.org/documentation
-
-   The detailed debugger commands reference is located in Chapter 12 "ACPICA
-   Debugger Reference".  The "help" command can be used for a quick reference.
-
-3. Stop the userspace debugger interface
-
-   The interactive debugger interface can be closed by pressing Ctrl+C or using
-   the "quit" or "exit" commands.  When finished, unload the module with:
-
-   # rmmod acpi_dbg
-
-   The module unloading may fail if there is an acpidbg instance running.
-
-4. Run the debugger in a script
-
-   It may be useful to run the AML debugger in a test script. "acpidbg" supports
-   this in a special "batch" mode.  For example, the following command outputs
-   the entire ACPI namespace:
-
-   # acpidbg -b "namespace"
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index a3c5ddb15a0e..a1c7ad451099 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -23,3 +23,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    dsdt-override
    debug
    method-tracing
+   aml-debugger
-- 
2.20.1

