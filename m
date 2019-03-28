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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4489520693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te6SIWjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfC1QaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:30:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33667 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1Q36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so11887277pgk.0;
        Thu, 28 Mar 2019 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LslbaMQBc3sJd5zVyQUZb0watNq+cg5vHqlwEZBt+rQ=;
        b=Te6SIWjokfV1QNZgVeqhdJTdkySId8pHYxtCfsc5TJMyHLuK9lNE8cfnlZqsH614oA
         6+BawDgcISa9ve18+cz2CiB0yfv8UsHvlbXv1pDojdwSBcgnfJnDcGMaU3fm+zAzi7ca
         pWzmvfZslvkfw8F0T8OEUDAfd1LakeN0ERBmn6TCp/Yvx4XP61cpObbBgn4NdJQ6nPfp
         UWTsP7tdjvL/BG5OthOcfD9nEntwhLHfpVXvfHp8vrdkpnDptx0oPgELccSMFJtvgmOp
         41GSlnsUD8wiFBs72xj4RGAYpqrpXI5TwDKNCDZPInj+3SzxSn1jQlM37pCa/WG3K39R
         2M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LslbaMQBc3sJd5zVyQUZb0watNq+cg5vHqlwEZBt+rQ=;
        b=HrarxVZ1mZXp0MY1ajKgLFR5MNH6FyGus2KdvHUzbMrwlGVyI8RtmNJRVs7pwkJyp3
         YYzB5JPYLlMNI62YWMQFllEBHLCg02B73nJ0p/uBq5dorN2ErIsLx0f99hPFE3Xf3drA
         IL+FJYileVukzTbBNx9OhHb2/hBOhfC5t8XO4Amyi63BfiOgZ6oSX/jSrB2bIkoOo8OD
         Wyru/za3L3IWuByqA3cvZWwvZok85oxod9TVsJZdiERRnXZzkIiFxm2D3ou5MXymCcKA
         B0AjvLgcW9QnIwMitXSx5zmO47SOdmpmh3hzsqyvdxXiaRbnuFregsuli/ZNlpGEFJQ+
         SvhA==
X-Gm-Message-State: APjAAAV7Yx5YenS9YOHS3kLMnMJWU9nJm18vVNetwtn0//soZSI1yYQ9
        7mAUVI64cdUZRjN8T/gtCotHiPndtAY=
X-Google-Smtp-Source: APXvYqxWfHXFjyMwJh5aEhETbMjaNqGZKWdai5rxovak5GVCN0kOzIWgQC1f/Ap9TzVaI0JZlodc2A==
X-Received: by 2002:a62:574d:: with SMTP id l74mr43259447pfb.9.1553790597249;
        Thu, 28 Mar 2019 09:29:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 17/23] acpi doc: convert acpi/aml-debugger.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:15 +0800
Message-Id: <20190328162721.26138-18-changbin.du@gmail.com>
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
 Documentation/acpi/aml-debugger.rst | 74 +++++++++++++++++++++++++++++
 Documentation/acpi/aml-debugger.txt | 66 -------------------------
 Documentation/acpi/index.rst        |  1 +
 3 files changed, 75 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/acpi/aml-debugger.rst
 delete mode 100644 Documentation/acpi/aml-debugger.txt

diff --git a/Documentation/acpi/aml-debugger.rst b/Documentation/acpi/aml-debugger.rst
new file mode 100644
index 000000000000..dc9b75530dc3
--- /dev/null
+++ b/Documentation/acpi/aml-debugger.rst
@@ -0,0 +1,74 @@
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
index 48964586ef75..241723643468 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -21,3 +21,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    dsdt-override
    debug
    method-tracing
+   aml-debugger
-- 
2.20.1

