Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04525C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F62183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUrndTPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfC2AOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:14:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46171 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2AOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:14:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so281122pgv.13;
        Thu, 28 Mar 2019 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skjv7l2h5MA9DwI8lXOTQ36apFX7gjZkTbCMjm2yaTs=;
        b=IUrndTPKwI9JCRlVUonbhQvbaAW8iP2VWbZJcAdbURee/YMO+vPw8FNNKUTQGq28/P
         WtPvwj3+zUCdcxlMMvmdq0IUGJAF/qXK07imBQqIrj4yPZmrlsvFslrVu+GcZpp5dqZy
         kMawbFdmv7USDkqUmrDNta+kya6EPZFYq8N+XgwYzvCPLhnmxeGtSF+gm1uZgxO77F65
         n0pZvr0CoW8qZszse69ugKxQIbz3awUacq/lnNzZ6F9IwGUVcSceD8OD1BGNTOp+jAr+
         mrarrJgPWQ26ncrVeH0ttVb8iZ751LriczdZmH4XL4ZE7s/Y1ttn8Ce7o0vTRQuZwzUB
         6KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skjv7l2h5MA9DwI8lXOTQ36apFX7gjZkTbCMjm2yaTs=;
        b=Zw6ZUAeyETHKgFbkNNObZSftR69lcCiAVGreFgRrq6PA42mQkH2//wa3nJ/NTOlvxy
         oUiIN4qTEWAhFq673r495nH2L0ICYrM9XcmD0nWwrJmaY3UElTb5x67jYJmNj4Yfjejr
         UZtZS4KLXQb7ED/h+I8K0kJ9M09n79ERAxyvXzsYsytUgshIkJta9Fl0fBG6+3KgQP+k
         PKwtrwk60UGnqRGNOEd+9aSCrsjini9lgv5+pSfQrGlorGIIChb7YFVyz+kEj5kpltF9
         LpHC+Z4RPxF40F4SgnqAzdN5bIOYbBnkmnTbYWGzulB4rhLlCyYEtE18XiagWR2EPjx8
         IlKg==
X-Gm-Message-State: APjAAAXMiTM3UUB5smsK/Y4uKTcK+UQlHby1n8LPamfHJ4IBxToRU/je
        PKDxwOrdcBEzKajbhC7B84Y=
X-Google-Smtp-Source: APXvYqz3M618n0vrvXdyQNq4Jm2XY9Oa0ej+wpEpUymHpb52YFBtx8YXtCqI8XLC36Ci/xSxYJm1/g==
X-Received: by 2002:a62:1249:: with SMTP id a70mr44253271pfj.160.1553818439608;
        Thu, 28 Mar 2019 17:13:59 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 23/24] acpi doc: convert acpi/ssdt-overlays.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:34 +0800
Message-Id: <20190329001135.15847-24-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst         |   1 +
 Documentation/acpi/ssdt-overlays.rst | 180 +++++++++++++++++++++++++++
 Documentation/acpi/ssdt-overlays.txt | 172 -------------------------
 3 files changed, 181 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/acpi/ssdt-overlays.rst
 delete mode 100644 Documentation/acpi/ssdt-overlays.txt

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 664807949272..d856ba53da4d 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -28,3 +28,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    apei/einj
    cppc_sysfs
    lpit
+   ssdt-overlays
diff --git a/Documentation/acpi/ssdt-overlays.rst b/Documentation/acpi/ssdt-overlays.rst
new file mode 100644
index 000000000000..da37455f96c9
--- /dev/null
+++ b/Documentation/acpi/ssdt-overlays.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+SSDT Overlays
+=============
+
+In order to support ACPI open-ended hardware configurations (e.g. development
+boards) we need a way to augment the ACPI configuration provided by the firmware
+image. A common example is connecting sensors on I2C / SPI buses on development
+boards.
+
+Although this can be accomplished by creating a kernel platform driver or
+recompiling the firmware image with updated ACPI tables, neither is practical:
+the former proliferates board specific kernel code while the latter requires
+access to firmware tools which are often not publicly available.
+
+Because ACPI supports external references in AML code a more practical
+way to augment firmware ACPI configuration is by dynamically loading
+user defined SSDT tables that contain the board specific information.
+
+For example, to enumerate a Bosch BMA222E accelerometer on the I2C bus of the
+Minnowboard MAX development board exposed via the LSE connector [1], the
+following ASL code can be used::
+
+    DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
+    {
+        External (\_SB.I2C6, DeviceObj)
+
+        Scope (\_SB.I2C6)
+        {
+            Device (STAC)
+            {
+                Name (_ADR, Zero)
+                Name (_HID, "BMA222E")
+
+                Method (_CRS, 0, Serialized)
+                {
+                    Name (RBUF, ResourceTemplate ()
+                    {
+                        I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
+                                    AddressingMode7Bit, "\\_SB.I2C6", 0x00,
+                                    ResourceConsumer, ,)
+                        GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
+                                "\\_SB.GPO2", 0x00, ResourceConsumer, , )
+                        { // Pin list
+                            0
+                        }
+                    })
+                    Return (RBUF)
+                }
+            }
+        }
+    }
+
+which can then be compiled to AML binary format::
+
+    $ iasl minnowmax.asl
+
+    Intel ACPI Component Architecture
+    ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
+    Copyright (c) 2000 - 2014 Intel Corporation
+
+    ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
+    AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
+
+[1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
+
+The resulting AML code can then be loaded by the kernel using one of the methods
+below.
+
+Loading ACPI SSDTs from initrd
+==============================
+
+This option allows loading of user defined SSDTs from initrd and it is useful
+when the system does not support EFI or when there is not enough EFI storage.
+
+It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
+aml code must be placed in the first, uncompressed, initrd under the
+"kernel/firmware/acpi" path. Multiple files can be used and this will translate
+in loading multiple tables. Only SSDT and OEM tables are allowed. See
+initrd_table_override.txt for more details.
+
+Here is an example::
+
+    # Add the raw ACPI tables to an uncompressed cpio archive.
+    # They must be put into a /kernel/firmware/acpi directory inside the
+    # cpio archive.
+    # The uncompressed cpio archive must be the first.
+    # Other, typically compressed cpio archives, must be
+    # concatenated on top of the uncompressed one.
+    mkdir -p kernel/firmware/acpi
+    cp ssdt.aml kernel/firmware/acpi
+
+    # Create the uncompressed cpio archive and concatenate the original initrd
+    # on top:
+    find kernel | cpio -H newc --create > /boot/instrumented_initrd
+    cat /boot/initrd >>/boot/instrumented_initrd
+
+Loading ACPI SSDTs from EFI variables
+=====================================
+
+This is the preferred method, when EFI is supported on the platform, because it
+allows a persistent, OS independent way of storing the user defined SSDTs. There
+is also work underway to implement EFI support for loading user defined SSDTs
+and using this method will make it easier to convert to the EFI loading
+mechanism when that will arrive.
+
+In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
+parameter can be used. The argument for the option is the variable name to
+use. If there are multiple variables with the same name but with different
+vendor GUIDs, all of them will be loaded.
+
+In order to store the AML code in an EFI variable the efivarfs filesystem can be
+used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
+recent distribution.
+
+Creating a new file in /sys/firmware/efi/efivars will automatically create a new
+EFI variable. Updating a file in /sys/firmware/efi/efivars will update the EFI
+variable. Please note that the file name needs to be specially formatted as
+"Name-GUID" and that the first 4 bytes in the file (little-endian format)
+represent the attributes of the EFI variable (see EFI_VARIABLE_MASK in
+include/linux/efi.h). Writing to the file must also be done with one write
+operation.
+
+For example, you can use the following bash script to create/update an EFI
+variable with the content from a given file::
+
+    #!/bin/sh -e
+
+    while ! [ -z "$1" ]; do
+            case "$1" in
+            "-f") filename="$2"; shift;;
+            "-g") guid="$2"; shift;;
+            *) name="$1";;
+            esac
+            shift
+    done
+
+    usage()
+    {
+            echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
+            exit 1
+    }
+
+    [ -n "$name" -a -f "$filename" ] || usage
+
+    EFIVARFS="/sys/firmware/efi/efivars"
+
+    [ -d "$EFIVARFS" ] || exit 2
+
+    if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
+            mount -t efivarfs none $EFIVARFS
+    fi
+
+    # try to pick up an existing GUID
+    [ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
+
+    # use a randomly generated GUID
+    [ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
+
+    # efivarfs expects all of the data in one write
+    tmp=$(mktemp)
+    /bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
+    dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
+    rm $tmp
+
+Loading ACPI SSDTs from configfs
+================================
+
+This option allows loading of user defined SSDTs from userspace via the configfs
+interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
+mounted. In the following examples, we assume that configfs has been mounted in
+/config.
+
+New tables can be loading by creating new directories in /config/acpi/table/ and
+writing the SSDT aml code in the aml attribute::
+
+    cd /config/acpi/table
+    mkdir my_ssdt
+    cat ~/ssdt.aml > my_ssdt/aml
diff --git a/Documentation/acpi/ssdt-overlays.txt b/Documentation/acpi/ssdt-overlays.txt
deleted file mode 100644
index 5ae13f161ea2..000000000000
--- a/Documentation/acpi/ssdt-overlays.txt
+++ /dev/null
@@ -1,172 +0,0 @@
-
-In order to support ACPI open-ended hardware configurations (e.g. development
-boards) we need a way to augment the ACPI configuration provided by the firmware
-image. A common example is connecting sensors on I2C / SPI buses on development
-boards.
-
-Although this can be accomplished by creating a kernel platform driver or
-recompiling the firmware image with updated ACPI tables, neither is practical:
-the former proliferates board specific kernel code while the latter requires
-access to firmware tools which are often not publicly available.
-
-Because ACPI supports external references in AML code a more practical
-way to augment firmware ACPI configuration is by dynamically loading
-user defined SSDT tables that contain the board specific information.
-
-For example, to enumerate a Bosch BMA222E accelerometer on the I2C bus of the
-Minnowboard MAX development board exposed via the LSE connector [1], the
-following ASL code can be used:
-
-DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
-{
-    External (\_SB.I2C6, DeviceObj)
-
-    Scope (\_SB.I2C6)
-    {
-        Device (STAC)
-        {
-            Name (_ADR, Zero)
-            Name (_HID, "BMA222E")
-
-            Method (_CRS, 0, Serialized)
-            {
-                Name (RBUF, ResourceTemplate ()
-                {
-                    I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
-                                  AddressingMode7Bit, "\\_SB.I2C6", 0x00,
-                                  ResourceConsumer, ,)
-                    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
-                             "\\_SB.GPO2", 0x00, ResourceConsumer, , )
-                    { // Pin list
-                        0
-                    }
-                })
-                Return (RBUF)
-            }
-        }
-    }
-}
-
-which can then be compiled to AML binary format:
-
-$ iasl minnowmax.asl
-
-Intel ACPI Component Architecture
-ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
-Copyright (c) 2000 - 2014 Intel Corporation
-
-ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
-AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
-
-[1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
-
-The resulting AML code can then be loaded by the kernel using one of the methods
-below.
-
-== Loading ACPI SSDTs from initrd ==
-
-This option allows loading of user defined SSDTs from initrd and it is useful
-when the system does not support EFI or when there is not enough EFI storage.
-
-It works in a similar way with initrd based ACPI tables override/upgrade: SSDT
-aml code must be placed in the first, uncompressed, initrd under the
-"kernel/firmware/acpi" path. Multiple files can be used and this will translate
-in loading multiple tables. Only SSDT and OEM tables are allowed. See
-initrd_table_override.txt for more details.
-
-Here is an example:
-
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the
-# cpio archive.
-# The uncompressed cpio archive must be the first.
-# Other, typically compressed cpio archives, must be
-# concatenated on top of the uncompressed one.
-mkdir -p kernel/firmware/acpi
-cp ssdt.aml kernel/firmware/acpi
-
-# Create the uncompressed cpio archive and concatenate the original initrd
-# on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
-
-== Loading ACPI SSDTs from EFI variables ==
-
-This is the preferred method, when EFI is supported on the platform, because it
-allows a persistent, OS independent way of storing the user defined SSDTs. There
-is also work underway to implement EFI support for loading user defined SSDTs
-and using this method will make it easier to convert to the EFI loading
-mechanism when that will arrive.
-
-In order to load SSDTs from an EFI variable the efivar_ssdt kernel command line
-parameter can be used. The argument for the option is the variable name to
-use. If there are multiple variables with the same name but with different
-vendor GUIDs, all of them will be loaded.
-
-In order to store the AML code in an EFI variable the efivarfs filesystem can be
-used. It is enabled and mounted by default in /sys/firmware/efi/efivars in all
-recent distribution.
-
-Creating a new file in /sys/firmware/efi/efivars will automatically create a new
-EFI variable. Updating a file in /sys/firmware/efi/efivars will update the EFI
-variable. Please note that the file name needs to be specially formatted as
-"Name-GUID" and that the first 4 bytes in the file (little-endian format)
-represent the attributes of the EFI variable (see EFI_VARIABLE_MASK in
-include/linux/efi.h). Writing to the file must also be done with one write
-operation.
-
-For example, you can use the following bash script to create/update an EFI
-variable with the content from a given file:
-
-#!/bin/sh -e
-
-while ! [ -z "$1" ]; do
-        case "$1" in
-        "-f") filename="$2"; shift;;
-        "-g") guid="$2"; shift;;
-        *) name="$1";;
-        esac
-        shift
-done
-
-usage()
-{
-        echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
-        exit 1
-}
-
-[ -n "$name" -a -f "$filename" ] || usage
-
-EFIVARFS="/sys/firmware/efi/efivars"
-
-[ -d "$EFIVARFS" ] || exit 2
-
-if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
-        mount -t efivarfs none $EFIVARFS
-fi
-
-# try to pick up an existing GUID
-[ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
-
-# use a randomly generated GUID
-[ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
-
-# efivarfs expects all of the data in one write
-tmp=$(mktemp)
-/bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
-dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
-rm $tmp
-
-== Loading ACPI SSDTs from configfs ==
-
-This option allows loading of user defined SSDTs from userspace via the configfs
-interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
-mounted. In the following examples, we assume that configfs has been mounted in
-/config.
-
-New tables can be loading by creating new directories in /config/acpi/table/ and
-writing the SSDT aml code in the aml attribute:
-
-cd /config/acpi/table
-mkdir my_ssdt
-cat ~/ssdt.aml > my_ssdt/aml
-- 
2.20.1

