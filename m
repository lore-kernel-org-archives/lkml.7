Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B10C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9845F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ8HSQcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfC2AM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37107 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2AM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so152978pfr.4;
        Thu, 28 Mar 2019 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmFCOp1zzXDTR/WkGfGYEVJ0LQS5ChGN6DXlYhfq/Q0=;
        b=ZJ8HSQcMk+pOaaN9E2C21ZqZ+RGDfnXmeB8xHP/SWCMB+dwzQZ8QU9DdlmthA9fUWO
         PJwEh9xNgbCek69XiPVHJR6LtsY81UH0qJoWvLL+xgWvr4AAl1NrM6yaRaa4Y7uwZgUL
         UTrmBGcsJ7oOJ3QBw9gcwiGUW8gvmzbsP+aLCa7nujfq0Hsik4ev4zUV6+lxH6m9nyjC
         KpkMMtu2Ycnjyn+T29C0YiEJmKcSJQq+cnYSd/oRjqROzxkTa2S5d2aMJVV57Wf8FYCr
         hqTa4Afl7aq+PVbiaJInkr5iuyVnEE90Ixa1BJd/NBtoM6HahLwZDomWv5Dy6Pfpl3DB
         Vv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmFCOp1zzXDTR/WkGfGYEVJ0LQS5ChGN6DXlYhfq/Q0=;
        b=rYoADd2sjqzFmDlhEe2cuxLGlKUfoideXaWZHhcFR+c2tvheb9jjx2fSFhPu+J+X+/
         jHDzEFHVuPNN3UV3KN4bRm7jQP5ecJgUTgzXKKo3BGT+rh0ZXG6BOyC1bExGv1LCVfvG
         AmOo8mS9wXDR2KsO59GI/qzM+5/mXQ4i2LxSEXZ8JE0CbzYid0Hrp00L7A/4K7t+U3QA
         /2AdCH7+EaUEU+Z20Dfa7dx0O+/OXfUMchkLLUjYtQjmScMvOhsOkxex1T54e1K+3RD6
         2gq/TBFIIue5iqnwGknwLK+4uwTdy9n8UJmEajMC8HkoBwoADLCZIBrwak0WTuN5T8dz
         gAog==
X-Gm-Message-State: APjAAAVr8C9K+EuesW671MgD/6/li8VhJVQLWVHymn1oARwSBjs9N9RD
        9eVN0ktuXpeWTmZEaX8MbkA=
X-Google-Smtp-Source: APXvYqy/6azm44zZ71XXhOxXggTPTBzxiMhI0jvmqy8wpEj1h420lISyztLqfXIg0xuSkfYCECVhnA==
X-Received: by 2002:a65:4549:: with SMTP id x9mr43900442pgr.3.1553818375399;
        Thu, 28 Mar 2019 17:12:55 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 10/24] acpi doc: convert acpi/initrd_table_override.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:21 +0800
Message-Id: <20190329001135.15847-11-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst                 |   1 +
 Documentation/acpi/initrd_table_override.rst | 120 +++++++++++++++++++
 Documentation/acpi/initrd_table_override.txt | 111 -----------------
 3 files changed, 121 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/acpi/initrd_table_override.rst
 delete mode 100644 Documentation/acpi/initrd_table_override.txt

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 409e98f19748..213c4601a42c 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -15,3 +15,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    gpio-properties
    scan_handlers
    method-customizing
+   initrd_table_override
diff --git a/Documentation/acpi/initrd_table_override.rst b/Documentation/acpi/initrd_table_override.rst
new file mode 100644
index 000000000000..0787b2b91ded
--- /dev/null
+++ b/Documentation/acpi/initrd_table_override.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Upgrading ACPI tables via initrd
+================================
+
+1) Introduction (What is this about)
+2) What is this for
+3) How does it work
+4) References (Where to retrieve userspace tools)
+
+1) What is this about
+=====================
+
+If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
+upgrade the ACPI execution environment that is defined by the ACPI tables
+via upgrading the ACPI tables provided by the BIOS with an instrumented,
+modified, more recent version one, or installing brand new ACPI tables.
+
+When building initrd with kernel in a single image, option
+ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
+feature to work.
+
+For a full list of ACPI tables that can be upgraded/installed, take a look
+at the char `*table_sigs[MAX_ACPI_SIGNATURE];` definition in
+drivers/acpi/tables.c.
+
+All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
+be overridable, except:
+
+  - ACPI_SIG_RSDP (has a signature of 6 bytes)
+  - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
+
+Both could get implemented as well.
+
+
+2) What is this for
+===================
+
+Complain to your platform/BIOS vendor if you find a bug which is so severe
+that a workaround is not accepted in the Linux kernel. And this facility
+allows you to upgrade the buggy tables before your platform/BIOS vendor
+releases an upgraded BIOS binary.
+
+This facility can be used by platform/BIOS vendors to provide a Linux
+compatible environment without modifying the underlying platform firmware.
+
+This facility also provides a powerful feature to easily debug and test
+ACPI BIOS table compatibility with the Linux kernel by modifying old
+platform provided ACPI tables or inserting new ACPI tables.
+
+It can and should be enabled in any kernel because there is no functional
+change with not instrumented initrds.
+
+
+3) How does it work
+===================
+::
+
+  # Extract the machine's ACPI tables:
+  cd /tmp
+  acpidump >acpidump
+  acpixtract -a acpidump
+  # Disassemble, modify and recompile them:
+  iasl -d *.dat
+  # For example add this statement into a _PRT (PCI Routing Table) function
+  # of the DSDT:
+  Store("HELLO WORLD", debug)
+  # And increase the OEM Revision. For example, before modification:
+  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
+  # After modification:
+  DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
+  iasl -sa dsdt.dsl
+  # Add the raw ACPI tables to an uncompressed cpio archive.
+  # They must be put into a /kernel/firmware/acpi directory inside the cpio
+  # archive. Note that if the table put here matches a platform table
+  # (similar Table Signature, and similar OEMID, and similar OEM Table ID)
+  # with a more recent OEM Revision, the platform table will be upgraded by
+  # this table. If the table put here doesn't match a platform table
+  # (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
+  # ID), this table will be appended.
+  mkdir -p kernel/firmware/acpi
+  cp dsdt.aml kernel/firmware/acpi
+  # A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
+  # (see osl.c):
+  iasl -sa facp.dsl
+  iasl -sa ssdt1.dsl
+  cp facp.aml kernel/firmware/acpi
+  cp ssdt1.aml kernel/firmware/acpi
+  # The uncompressed cpio archive must be the first. Other, typically
+  # compressed cpio archives, must be concatenated on top of the uncompressed
+  # one. Following command creates the uncompressed cpio archive and
+  # concatenates the original initrd on top:
+  find kernel | cpio -H newc --create > /boot/instrumented_initrd
+  cat /boot/initrd >>/boot/instrumented_initrd
+  # reboot with increased acpi debug level, e.g. boot params:
+  acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
+  # and check your syslog:
+  [    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
+  [    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
+
+iasl is able to disassemble and recompile quite a lot different,
+also static ACPI tables.
+
+
+4) Where to retrieve userspace tools
+====================================
+
+iasl and acpixtract are part of Intel's ACPICA project:
+http://acpica.org/
+
+and should be packaged by distributions (for example in the acpica package
+on SUSE).
+
+acpidump can be found in Len Browns pmtools:
+ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
+
+This tool is also part of the acpica package on SUSE.
+Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
+/sys/firmware/acpi/tables
diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
deleted file mode 100644
index 30437a6db373..000000000000
--- a/Documentation/acpi/initrd_table_override.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-Upgrading ACPI tables via initrd
-================================
-
-1) Introduction (What is this about)
-2) What is this for
-3) How does it work
-4) References (Where to retrieve userspace tools)
-
-1) What is this about
----------------------
-
-If the ACPI_TABLE_UPGRADE compile option is true, it is possible to
-upgrade the ACPI execution environment that is defined by the ACPI tables
-via upgrading the ACPI tables provided by the BIOS with an instrumented,
-modified, more recent version one, or installing brand new ACPI tables.
-
-When building initrd with kernel in a single image, option
-ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
-feature to work.
-
-For a full list of ACPI tables that can be upgraded/installed, take a look
-at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
-drivers/acpi/tables.c.
-All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
-be overridable, except:
-   - ACPI_SIG_RSDP (has a signature of 6 bytes)
-   - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
-Both could get implemented as well.
-
-
-2) What is this for
--------------------
-
-Complain to your platform/BIOS vendor if you find a bug which is so severe
-that a workaround is not accepted in the Linux kernel. And this facility
-allows you to upgrade the buggy tables before your platform/BIOS vendor
-releases an upgraded BIOS binary.
-
-This facility can be used by platform/BIOS vendors to provide a Linux
-compatible environment without modifying the underlying platform firmware.
-
-This facility also provides a powerful feature to easily debug and test
-ACPI BIOS table compatibility with the Linux kernel by modifying old
-platform provided ACPI tables or inserting new ACPI tables.
-
-It can and should be enabled in any kernel because there is no functional
-change with not instrumented initrds.
-
-
-3) How does it work
--------------------
-
-# Extract the machine's ACPI tables:
-cd /tmp
-acpidump >acpidump
-acpixtract -a acpidump
-# Disassemble, modify and recompile them:
-iasl -d *.dat
-# For example add this statement into a _PRT (PCI Routing Table) function
-# of the DSDT:
-Store("HELLO WORLD", debug)
-# And increase the OEM Revision. For example, before modification:
-DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
-# After modification:
-DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
-iasl -sa dsdt.dsl
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the cpio
-# archive. Note that if the table put here matches a platform table
-# (similar Table Signature, and similar OEMID, and similar OEM Table ID)
-# with a more recent OEM Revision, the platform table will be upgraded by
-# this table. If the table put here doesn't match a platform table
-# (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
-# ID), this table will be appended.
-mkdir -p kernel/firmware/acpi
-cp dsdt.aml kernel/firmware/acpi
-# A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
-# (see osl.c):
-iasl -sa facp.dsl
-iasl -sa ssdt1.dsl
-cp facp.aml kernel/firmware/acpi
-cp ssdt1.aml kernel/firmware/acpi
-# The uncompressed cpio archive must be the first. Other, typically
-# compressed cpio archives, must be concatenated on top of the uncompressed
-# one. Following command creates the uncompressed cpio archive and
-# concatenates the original initrd on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
-# reboot with increased acpi debug level, e.g. boot params:
-acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
-# and check your syslog:
-[    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-[    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
-
-iasl is able to disassemble and recompile quite a lot different,
-also static ACPI tables.
-
-
-4) Where to retrieve userspace tools
-------------------------------------
-
-iasl and acpixtract are part of Intel's ACPICA project:
-http://acpica.org/
-and should be packaged by distributions (for example in the acpica package
-on SUSE).
-
-acpidump can be found in Len Browns pmtools:
-ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
-This tool is also part of the acpica package on SUSE.
-Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
-/sys/firmware/acpi/tables
-- 
2.20.1

