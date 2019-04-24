Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496CBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0798C20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VixoaMN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbfDXRzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:55:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46090 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390486AbfDXRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:55:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id o7so7417891pll.13;
        Wed, 24 Apr 2019 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nt9Hzadmk3IfOZGZ4NISzwcFzm/IxLMb6ukyabMZ2m8=;
        b=VixoaMN7iS4CLmoPtjSm3dWFrXYImAKMW48zVIO3q7IPmZjyHVhYjRD9Stqv75m7gG
         CMwkETZl56gkjgogld3WIhFa/2POR+ad3Y0rwDVHqtRLgwgjmNJMusyEhrwaO/mj5pBk
         cvRLXMOT5ugRL/1rzE9b2M1bW+9pLfDETcxtNWBfgISNl0W/qXqzigcpunLCrRPSTnor
         DpydRV4DKydyh8dTuX6qV7R6hvB7422/d5o3ninzjmiTmPkUMczAKC/zsMdxpGK7jA8G
         2Jgc6vg1nPbER0vNg07g3VMIeEp9hSlkvpLhFAXxJpf9d8HmUqzbL7a75WKnPQhLIuiV
         0fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nt9Hzadmk3IfOZGZ4NISzwcFzm/IxLMb6ukyabMZ2m8=;
        b=VRemdj7wH8/IuKKo+WVHBTnSLbQbHGrDVROLytmRc9/4LuApgzS1F/oy5NJR9QX0hS
         6OgzpsYJqLHCSOMFe0GnothJrABY2AHCGSDrdRhlpYUtNNPWtwDLhckpslDNqEShaSy5
         rRiPZ56ei/AUxpkaSmPa1V9wGObLG3N1Od/5+XCHTiyZfbzplTVqtd1Mz1rRaqI3gfjP
         f+opfwpz/TYEamB+4XCYhBx98oKNVNhWZP5uu5q52cgRxandKu55qblXoH8Fw1RrIviA
         HTbB8CRoX21gh5Low9BYqtxgF8tngq5vxtTOI2PJr8OMjJyWqYhH33r5tBMqlsuZAt/X
         4nMg==
X-Gm-Message-State: APjAAAXlPA1i6PpsgJGObQFQAreeVnvuf4SRqkrXQs5KVczT0x/DMDyr
        b8ALTNUW4JOROj9vnOaN+A0=
X-Google-Smtp-Source: APXvYqy93lNoyPwASUX10uUPq56fhgtZU2w5KgeE7Jsnc14n8UpmKnuUg7Rho5VfB7LI5taHU36ZDw==
X-Received: by 2002:a17:902:2907:: with SMTP id g7mr33991261plb.238.1556128514958;
        Wed, 24 Apr 2019 10:55:14 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:55:14 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 09/23] Documentation: ACPI: move initrd_table_override.txt to admin-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:52 +0800
Message-Id: <20190424175306.25880-10-changbin.du@gmail.com>
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
 Documentation/acpi/initrd_table_override.txt  | 111 -----------------
 Documentation/admin-guide/acpi/index.rst      |   1 +
 .../acpi/initrd_table_override.rst            | 115 ++++++++++++++++++
 3 files changed, 116 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/acpi/initrd_table_override.txt
 create mode 100644 Documentation/admin-guide/acpi/initrd_table_override.rst

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
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 3e041206089d..09e4e81e4fb7 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -8,3 +8,4 @@ the Linux ACPI support.
 .. toctree::
    :maxdepth: 1
 
+   initrd_table_override
diff --git a/Documentation/admin-guide/acpi/initrd_table_override.rst b/Documentation/admin-guide/acpi/initrd_table_override.rst
new file mode 100644
index 000000000000..cbd768207631
--- /dev/null
+++ b/Documentation/admin-guide/acpi/initrd_table_override.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Upgrading ACPI tables via initrd
+================================
+
+What is this about
+==================
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
+What is this for
+================
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
+How does it work
+================
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
+Where to retrieve userspace tools
+=================================
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
-- 
2.20.1

