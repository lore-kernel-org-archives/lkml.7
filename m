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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A073D20693
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzzqoWRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfC1Q3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33063 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1Q3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so5189740plb.0;
        Thu, 28 Mar 2019 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YsRok5upwEgLJC1lxOj44ppzWx3p5ZJETm96ypmwaI8=;
        b=KzzqoWRLjkOHpH8Sy4rheKN8pF+HzFS15NwlaD13nnQgoI4O6eixty97qIhcRjcnoD
         OdmpUK4DnnGDPmWbIhT6ubarsN3q59UzZGubfIpKKyFjuHZhRvDf0ApJDLZ9HIdwYyT9
         GOpZOnGxGMEonQQslnpmZupd0VZ/kO5rT3ebbumiGS2skYK43iAY5pLJecUptTpF5J95
         IJD//CRFIOgLIlXeGh/Z/Xa0MdDq4aAVXRHlo0d09Pw//FKMsO+fHdsyMIihLfR6Bvyk
         08AQbHqvNcOBIKJbGpq6oQEN6sybrnH2Yz08MSNSq3WesxQCT6kZpZDIkX1j1ml63h4K
         bf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsRok5upwEgLJC1lxOj44ppzWx3p5ZJETm96ypmwaI8=;
        b=p16N/CBqIylzvIgo78gwjFk79ngQOYwZiwD4WoqGYJng29Nv/rhZHiDNvBq3FcRuy9
         n/fAR8WpTgJh1UONeFZQ/BKFehphZNUBdKcecz8j6W4QoBGFpvPNw2YAMQsIwzhbpJqP
         CvgR6dzwOEUPWtRLKNwurHz8pQ+tvA66W84V8SnhN5rPbVct1E6xbJAZIc7rRScuVlhF
         fTO39c01mh4w7BE18rqryE/c9cmwiMw/9r8l6eL7IwNc9gxF40+zlrIDnIWlEPRPQVNe
         DI4Akb50FsC1YFWmkqKD2U4W0RCgY5inKXLiQxA5vRgx5J1jzZ9vPQgjkZO72l8cUZP1
         USBQ==
X-Gm-Message-State: APjAAAXHOh6SNeFCGIKHugAHjsrZsR5eBQHjXFJcicfgJ0Ex53TM85p1
        ohadE+Y0KiOYgzR8tGe2sIo=
X-Google-Smtp-Source: APXvYqy1jX/NuK/jtu1rKP5UJQMkb601rJtzGnnkmmnUDwEFTLjC1JeS0ggUZdsr0TqgdwJ7yJvlBg==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr43507966plb.236.1553790561941;
        Thu, 28 Mar 2019 09:29:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:21 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 10/23] acpi doc: convert acpi/initrd_table_override.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:08 +0800
Message-Id: <20190328162721.26138-11-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst                 |   1 +
 Documentation/acpi/initrd_table_override.rst | 118 +++++++++++++++++++
 Documentation/acpi/initrd_table_override.txt | 111 -----------------
 3 files changed, 119 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/acpi/initrd_table_override.rst
 delete mode 100644 Documentation/acpi/initrd_table_override.txt

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 84d55c5d6746..5ab8bad833f6 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -13,3 +13,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    gpio-properties
    scan_handlers
    method-customizing
+   initrd_table_override
diff --git a/Documentation/acpi/initrd_table_override.rst b/Documentation/acpi/initrd_table_override.rst
new file mode 100644
index 000000000000..ece496e9d692
--- /dev/null
+++ b/Documentation/acpi/initrd_table_override.rst
@@ -0,0 +1,118 @@
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

