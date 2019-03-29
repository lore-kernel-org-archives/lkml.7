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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3777C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A352075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1savWFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfC2AMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:12:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38309 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfC2AMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:12:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so300067pgl.5;
        Thu, 28 Mar 2019 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVixZIfNA2Yg4fbFwcPDdSwEWm+2D9vEvvVhq5Wb5fk=;
        b=e1savWFrk97BDBwEqNYfJRSnWkzanQMhLFTYlLhncH7cgluUe84gFyTOUoJl0Arczk
         STnKPOiPiRT/55E0pvXvXWnaPqALag+Ui40MI+OMHp8KdP9LOMcRktb7mZRfE/Un1AUP
         MVv/3IMLSS48hZJj7+MyKNCodlKS2peOtyFdmUYy1zjalib8DlqlbTyqLLB6hb0h7/7W
         Vuqj8SLmxqig3hGtBhikUBvATqvhhdlfQhHJGuFxquS6RFMYyZJO7xdVVweCksdUJZBd
         qhiOSJJ6UkKRaU+hh9YZflKbFjVVi77t9Tb3sInQzRYlNOTSnFz+rXqHwWoyhRQ30ugV
         bACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVixZIfNA2Yg4fbFwcPDdSwEWm+2D9vEvvVhq5Wb5fk=;
        b=OrFkXnQ+UQJlOdMz+CQy2Z86wVkafjBU6jNwvhi+QKwTTVeY3kYidZNVS13qgqqvUI
         AuZs91neMhd3hTH1MmCR6BHu3gs4PyZDufdl14Lr5bCQXi6QtRO+X9Q9z8AQEMTMKdx2
         sGXyD9huYmB0zzaDfbSa5mWM7rdH3DJcpSEG20iZTEnYe8c8hfnoFjEcOkGkgHdLuLlZ
         4EedKfa5NXwH2sNCRbR68sQItrDH0V9r7LnTTWIsOZzIC6mHRBjBS9VhNqr3ip0oyc7i
         ackzKPpmez90wDlrN8sqHb2M8Eowi85oFKFFCYVKTq//949v6kK52tA9fwhY8XRIMQ4N
         8EBQ==
X-Gm-Message-State: APjAAAUsHSV4dYSkuU08dgZIMaPtsBjcvMvQZ+ddcSiQRSUo+Wvq50vC
        R03CmH/WQ6Yk0GXMktJzqNE=
X-Google-Smtp-Source: APXvYqw0Ho/cKCkrPddBFeNp8mht35LmfOmJJ59H62/f8R0yqMR+aAmRQVm41Tpt/hxUdMqCakQHww==
X-Received: by 2002:a63:d84b:: with SMTP id k11mr42554928pgj.281.1553818335227;
        Thu, 28 Mar 2019 17:12:15 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:12:14 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 02/24] acpi doc: convert acpi/namespace.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:13 +0800
Message-Id: <20190329001135.15847-3-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst                  |   4 +-
 .../acpi/{namespace.txt => namespace.rst}     | 310 +++++++++---------
 2 files changed, 163 insertions(+), 151 deletions(-)
 rename Documentation/acpi/{namespace.txt => namespace.rst} (54%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 7241ceb1673c..2f48ffc6061a 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -1,8 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =======================================================
-Linux ACPI (Advanced Configuration and Power Interface) 
+Linux ACPI (Advanced Configuration and Power Interface)
 =======================================================
 
 .. toctree::
    :maxdepth: 2
+
+   namespace
diff --git a/Documentation/acpi/namespace.txt b/Documentation/acpi/namespace.rst
similarity index 54%
rename from Documentation/acpi/namespace.txt
rename to Documentation/acpi/namespace.rst
index 1860cb3865c6..443f0e5d0617 100644
--- a/Documentation/acpi/namespace.txt
+++ b/Documentation/acpi/namespace.rst
@@ -1,85 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===================================================
 ACPI Device Tree - Representation of ACPI Namespace
+===================================================
+
+:Copyright: |copy| 2013, Intel Corporation
+
+:Author: Lv Zheng <lv.zheng@intel.com>
+
+:Abstract: The Linux ACPI subsystem converts ACPI namespace objects into a Linux
+           device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
+           receiving ACPI hotplug notification events.  For each device object
+           in this hierarchy there is a corresponding symbolic link in the
+           /sys/bus/acpi/devices.
+           This document illustrates the structure of the ACPI device tree.
+
+:Credit:   Thanks for the help from Zhang Rui <rui.zhang@intel.com> and
+           Rafael J.Wysocki <rafael.j.wysocki@intel.com>.
+
+
+ACPI Definition Blocks
+======================
+
+The ACPI firmware sets up RSDP (Root System Description Pointer) in the
+system memory address space pointing to the XSDT (Extended System
+Description Table).  The XSDT always points to the FADT (Fixed ACPI
+Description Table) using its first entry, the data within the FADT
+includes various fixed-length entries that describe fixed ACPI features
+of the hardware.  The FADT contains a pointer to the DSDT
+(Differentiated System Descripition Table).  The XSDT also contains
+entries pointing to possibly multiple SSDTs (Secondary System
+Description Table).
+
+The DSDT and SSDT data is organized in data structures called definition
+blocks that contain definitions of various objects, including ACPI
+control methods, encoded in AML (ACPI Machine Language).  The data block
+of the DSDT along with the contents of SSDTs represents a hierarchical
+data structure called the ACPI namespace whose topology reflects the
+structure of the underlying hardware platform.
+
+The relationships between ACPI System Definition Tables described above
+are illustrated in the following diagram::
+
+   +---------+    +-------+    +--------+    +------------------------+
+   |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
+   +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
+   | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
+   +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
+   | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
+   +---------+    +-------+    +--------+    |  +-------------------+ |
+                  | Entry |------------------|->|       SSDT        | |
+                  +- - - -+                  |  +-------------------| |
+                  | Entry | - - - - - - - -+ |  | Definition Blocks | |
+                  +- - - -+                | |  +-------------------+ |
+                                          | |  +- - - - - - - - - -+ |
+                                          +-|->|       SSDT        | |
+                                             |  +-------------------+ |
+                                             |  | Definition Blocks | |
+                                             |  +- - - - - - - - - -+ |
+                                             +------------------------+
+                                                         |
+                                             OSPM Loading |
+                                                         \|/
+                                                   +----------------+
+                                                   | ACPI Namespace |
+                                                   +----------------+
+
+                  Figure 1. ACPI Definition Blocks
+
+.. note:: RSDP can also contain a pointer to the RSDT (Root System
+   Description Table).  Platforms provide RSDT to enable
+   compatibility with ACPI 1.0 operating systems.  The OS is expected
+   to use XSDT, if present.
+
+
+Example ACPI Namespace
+======================
+
+All definition blocks are loaded into a single namespace.  The namespace
+is a hierarchy of objects identified by names and paths.
+The following naming conventions apply to object names in the ACPI
+namespace:
 
-Copyright (C) 2013, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
-
-
-Abstract:
-
-The Linux ACPI subsystem converts ACPI namespace objects into a Linux
-device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
-receiving ACPI hotplug notification events.  For each device object in this
-hierarchy there is a corresponding symbolic link in the
-/sys/bus/acpi/devices.
-This document illustrates the structure of the ACPI device tree.
-
-
-Credit:
-
-Thanks for the help from Zhang Rui <rui.zhang@intel.com> and Rafael J.
-Wysocki <rafael.j.wysocki@intel.com>.
-
-
-1. ACPI Definition Blocks
-
-   The ACPI firmware sets up RSDP (Root System Description Pointer) in the
-   system memory address space pointing to the XSDT (Extended System
-   Description Table).  The XSDT always points to the FADT (Fixed ACPI
-   Description Table) using its first entry, the data within the FADT
-   includes various fixed-length entries that describe fixed ACPI features
-   of the hardware.  The FADT contains a pointer to the DSDT
-   (Differentiated System Descripition Table).  The XSDT also contains
-   entries pointing to possibly multiple SSDTs (Secondary System
-   Description Table).
-
-   The DSDT and SSDT data is organized in data structures called definition
-   blocks that contain definitions of various objects, including ACPI
-   control methods, encoded in AML (ACPI Machine Language).  The data block
-   of the DSDT along with the contents of SSDTs represents a hierarchical
-   data structure called the ACPI namespace whose topology reflects the
-   structure of the underlying hardware platform.
-
-   The relationships between ACPI System Definition Tables described above
-   are illustrated in the following diagram.
-
-     +---------+    +-------+    +--------+    +------------------------+
-     |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
-     +---------+ |  +-------+ |  +--------+  +-|->|       DSDT        | |
-     | Pointer | |  | Entry |-+  | ...... |  | |  +-------------------+ |
-     +---------+ |  +-------+    | X_DSDT |--+ |  | Definition Blocks | |
-     | Pointer |-+  | ..... |    | ...... |    |  +-------------------+ |
-     +---------+    +-------+    +--------+    |  +-------------------+ |
-                    | Entry |------------------|->|       SSDT        | |
-                    +- - - -+                  |  +-------------------| |
-                    | Entry | - - - - - - - -+ |  | Definition Blocks | |
-                    +- - - -+                | |  +-------------------+ |
-                                             | |  +- - - - - - - - - -+ |
-                                             +-|->|       SSDT        | |
-                                               |  +-------------------+ |
-                                               |  | Definition Blocks | |
-                                               |  +- - - - - - - - - -+ |
-                                               +------------------------+
-                                                           |
-                                              OSPM Loading |
-                                                          \|/
-                                                    +----------------+
-                                                    | ACPI Namespace |
-                                                    +----------------+
-
-                     Figure 1. ACPI Definition Blocks
-
-   NOTE: RSDP can also contain a pointer to the RSDT (Root System
-         Description Table).  Platforms provide RSDT to enable
-         compatibility with ACPI 1.0 operating systems.  The OS is expected
-         to use XSDT, if present.
-
-
-2. Example ACPI Namespace
-
-   All definition blocks are loaded into a single namespace.  The namespace
-   is a hierarchy of objects identified by names and paths.
-   The following naming conventions apply to object names in the ACPI
-   namespace:
    1. All names are 32 bits long.
    2. The first byte of a name must be one of 'A' - 'Z', '_'.
    3. Each of the remaining bytes of a name must be one of 'A' - 'Z', '0'
@@ -91,7 +94,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
       (i.e. names prepended with '^' are relative to the parent of the
       current namespace node).
 
-   The figure below shows an example ACPI namespace.
+The figure below shows an example ACPI namespace::
 
    +------+
    | \    |                     Root
@@ -184,19 +187,20 @@ Wysocki <rafael.j.wysocki@intel.com>.
                      Figure 2. Example ACPI Namespace
 
 
-3. Linux ACPI Device Objects
+Linux ACPI Device Objects
+=========================
 
-   The Linux kernel's core ACPI subsystem creates struct acpi_device
-   objects for ACPI namespace objects representing devices, power resources
-   processors, thermal zones.  Those objects are exported to user space via
-   sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
-   format of their names is <bus_id:instance>, where 'bus_id' refers to the
-   ACPI namespace representation of the given object and 'instance' is used
-   for distinguishing different object of the same 'bus_id' (it is
-   two-digit decimal representation of an unsigned integer).
+The Linux kernel's core ACPI subsystem creates struct acpi_device
+objects for ACPI namespace objects representing devices, power resources
+processors, thermal zones.  Those objects are exported to user space via
+sysfs as directories in the subtree under /sys/devices/LNXSYSTM:00.  The
+format of their names is <bus_id:instance>, where 'bus_id' refers to the
+ACPI namespace representation of the given object and 'instance' is used
+for distinguishing different object of the same 'bus_id' (it is
+two-digit decimal representation of an unsigned integer).
 
-   The value of 'bus_id' depends on the type of the object whose name it is
-   part of as listed in the table below.
+The value of 'bus_id' depends on the type of the object whose name it is
+part of as listed in the table below::
 
                 +---+-----------------+-------+----------+
                 |   | Object/Feature  | Table | bus_id   |
@@ -226,10 +230,11 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
                  Table 1. ACPI Namespace Objects Mapping
 
-   The following rules apply when creating struct acpi_device objects on
-   the basis of the contents of ACPI System Description Tables (as
-   indicated by the letter in the first column and the notation in the
-   second column of the table above):
+The following rules apply when creating struct acpi_device objects on
+the basis of the contents of ACPI System Description Tables (as
+indicated by the letter in the first column and the notation in the
+second column of the table above):
+
    N:
       The object's source is an ACPI namespace node (as indicated by the
       named object's type in the second column).  In that case the object's
@@ -249,13 +254,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
       struct acpi_device object with LNXVIDEO 'bus_id' will be created for
       it.
 
-   The third column of the above table indicates which ACPI System
-   Description Tables contain information used for the creation of the
-   struct acpi_device objects represented by the given row (xSDT means DSDT
-   or SSDT).
+The third column of the above table indicates which ACPI System
+Description Tables contain information used for the creation of the
+struct acpi_device objects represented by the given row (xSDT means DSDT
+or SSDT).
+
+The forth column of the above table indicates the 'bus_id' generation
+rule of the struct acpi_device object:
 
-   The forth column of the above table indicates the 'bus_id' generation
-   rule of the struct acpi_device object:
    _HID:
       _HID in the last column of the table means that the object's bus_id
       is derived from the _HID/_CID identification objects present under
@@ -275,45 +281,47 @@ Wysocki <rafael.j.wysocki@intel.com>.
       object's bus_id.
 
 
-4. Linux ACPI Physical Device Glue
-
-   ACPI device (i.e. struct acpi_device) objects may be linked to other
-   objects in the Linux' device hierarchy that represent "physical" devices
-   (for example, devices on the PCI bus).  If that happens, it means that
-   the ACPI device object is a "companion" of a device otherwise
-   represented in a different way and is used (1) to provide configuration
-   information on that device which cannot be obtained by other means and
-   (2) to do specific things to the device with the help of its ACPI
-   control methods.  One ACPI device object may be linked this way to
-   multiple "physical" devices.
-
-   If an ACPI device object is linked to a "physical" device, its sysfs
-   directory contains the "physical_node" symbolic link to the sysfs
-   directory of the target device object.  In turn, the target device's
-   sysfs directory will then contain the "firmware_node" symbolic link to
-   the sysfs directory of the companion ACPI device object.
-   The linking mechanism relies on device identification provided by the
-   ACPI namespace.  For example, if there's an ACPI namespace object
-   representing a PCI device (i.e. a device object under an ACPI namespace
-   object representing a PCI bridge) whose _ADR returns 0x00020000 and the
-   bus number of the parent PCI bridge is 0, the sysfs directory
-   representing the struct acpi_device object created for that ACPI
-   namespace object will contain the 'physical_node' symbolic link to the
-   /sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
-   corresponding PCI device.
-
-   The linking mechanism is generally bus-specific.  The core of its
-   implementation is located in the drivers/acpi/glue.c file, but there are
-   complementary parts depending on the bus types in question located
-   elsewhere.  For example, the PCI-specific part of it is located in
-   drivers/pci/pci-acpi.c.
-
-
-5. Example Linux ACPI Device Tree
-
-   The sysfs hierarchy of struct acpi_device objects corresponding to the
-   example ACPI namespace illustrated in Figure 2 with the addition of
-   fixed PWR_BUTTON/SLP_BUTTON devices is shown below.
+Linux ACPI Physical Device Glue
+===============================
+
+ACPI device (i.e. struct acpi_device) objects may be linked to other
+objects in the Linux' device hierarchy that represent "physical" devices
+(for example, devices on the PCI bus).  If that happens, it means that
+the ACPI device object is a "companion" of a device otherwise
+represented in a different way and is used (1) to provide configuration
+information on that device which cannot be obtained by other means and
+(2) to do specific things to the device with the help of its ACPI
+control methods.  One ACPI device object may be linked this way to
+multiple "physical" devices.
+
+If an ACPI device object is linked to a "physical" device, its sysfs
+directory contains the "physical_node" symbolic link to the sysfs
+directory of the target device object.  In turn, the target device's
+sysfs directory will then contain the "firmware_node" symbolic link to
+the sysfs directory of the companion ACPI device object.
+The linking mechanism relies on device identification provided by the
+ACPI namespace.  For example, if there's an ACPI namespace object
+representing a PCI device (i.e. a device object under an ACPI namespace
+object representing a PCI bridge) whose _ADR returns 0x00020000 and the
+bus number of the parent PCI bridge is 0, the sysfs directory
+representing the struct acpi_device object created for that ACPI
+namespace object will contain the 'physical_node' symbolic link to the
+/sys/devices/pci0000:00/0000:00:02:0/ sysfs directory of the
+corresponding PCI device.
+
+The linking mechanism is generally bus-specific.  The core of its
+implementation is located in the drivers/acpi/glue.c file, but there are
+complementary parts depending on the bus types in question located
+elsewhere.  For example, the PCI-specific part of it is located in
+drivers/pci/pci-acpi.c.
+
+
+Example Linux ACPI Device Tree
+=================================
+
+The sysfs hierarchy of struct acpi_device objects corresponding to the
+example ACPI namespace illustrated in Figure 2 with the addition of
+fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
 
    +--------------+---+-----------------+
    | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
@@ -377,12 +385,14 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
                   Figure 3. Example Linux ACPI Device Tree
 
-   NOTE: Each node is represented as "object/path/modalias", where:
-         1. 'object' is the name of the object's directory in sysfs.
-         2. 'path' is the ACPI namespace path of the corresponding
-            ACPI namespace object, as returned by the object's 'path'
-            sysfs attribute.
-         3. 'modalias' is the value of the object's 'modalias' sysfs
-            attribute (as described earlier in this document).
-   NOTE: N/A indicates the device object does not have the 'path' or the
-         'modalias' attribute.
+.. note:: Each node is represented as "object/path/modalias", where:
+
+   1. 'object' is the name of the object's directory in sysfs.
+   2. 'path' is the ACPI namespace path of the corresponding
+      ACPI namespace object, as returned by the object's 'path'
+      sysfs attribute.
+   3. 'modalias' is the value of the object's 'modalias' sysfs
+      attribute (as described earlier in this document).
+
+.. note:: N/A indicates the device object does not have the 'path' or the
+   'modalias' attribute.
-- 
2.20.1

