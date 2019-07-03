Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB7C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E7321880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McaWmSoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGCGO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:14:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40181 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGCGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:14:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so621941pla.7;
        Tue, 02 Jul 2019 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YegYfSqnvpGkvLeFqRLYsWX8iHdVd9QeovybaIitjeo=;
        b=McaWmSoqlYlxeE5J36kXhWceTSBqvcPCGUWpP2CYZqYjx2vcb0ExINXF6pPsMVwlcg
         ANT8HlbPyFiCubrS+uqnSkFc7L64ZJaOgEXq/U4CjPMgMnZOUKO4+oklfwojZ2OiyclX
         YfCYWLk2MaUK7OHG4iFau0XxJ4XdnkPK9086rml6EdCVDDPEuUKJB2sHCWh7h5LfH387
         aIHEZmPh9jZp8l0n3y9RKpltmIMu1VLN2qQ74W9iRxj/N+vp2nTvfDHSEJkbKNgObz++
         65dLTKnszGkvzdncNQRaovTG77sTDCXejSZ+vFdaDsuk1+9cKh+NWueoqEZEG04JSI7q
         Yq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YegYfSqnvpGkvLeFqRLYsWX8iHdVd9QeovybaIitjeo=;
        b=fyE5hQxfHJwyc2VTIEiY0nRaPideuGI2HPGCCuLzK9dLMcD4cF3bZ3PdUJIIqvhtfP
         foVJEMoUNybnsttalZimRanKTVtMBTHdPdGoJ5wVijpxMnkCdSPHGwUQi44k1eT0ol7D
         TQioC7fQxoRp/Ik1rt9Sa6ez3s6xFD4IB3EeEnihU9002zZEkVJOkS1l8jMWRoh0IRm4
         Oh4NSlG6mq02UHoVopdtyN171AVen9FRA2ps278cK/rDuq9hKEzJ/wqla0SwE3NuXWMT
         QWrzdvow40LmUF5x/FbGFXCs1SaWBGR7tFD5rpnSS/aBl5yqacetddn3f8iMX7771kHt
         RzmQ==
X-Gm-Message-State: APjAAAWBVyzwyuQySHCY9ZBMBjHbnhg1X1Rl5SiR+lZ4IEE2lwIeefWj
        e8zPlJCVyT+0TGhuG76PK20=
X-Google-Smtp-Source: APXvYqxbcW6uXdKZAS1kftQFCsPfEjulUZjPYHqSGhlvutJsJoxKKUpKPfJylNGPa35JkIZ1/G61ZA==
X-Received: by 2002:a17:902:7b84:: with SMTP id w4mr39114368pll.22.1562134497614;
        Tue, 02 Jul 2019 23:14:57 -0700 (PDT)
Received: from localhost.localdomain ([157.45.25.158])
        by smtp.gmail.com with ESMTPSA id b24sm977865pfd.98.2019.07.02.23.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 23:14:56 -0700 (PDT)
From:   Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] docs: aha152x.txt convert it to ReST
Date:   Wed,  3 Jul 2019 11:44:46 +0530
Message-Id: <20190703061446.12582-1-sushmaunnibhavi425@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts aha152x.rst
to ReST format, No content change.
Added aha152x.rst to sh/index.rst
Added SPDX tag in index.rst

Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
---
 Documentation/driver-api/index.rst  |   1 +
 Documentation/scsi/aha152x.rst      | 203 ++++++++++++++++++++++++++++
 Documentation/scsi/aha152x.txt      | 183 -------------------------
 Documentation/scsi/source/conf.py   |  52 +++++++
 Documentation/scsi/source/index.rst |  22 +++
 5 files changed, 278 insertions(+), 183 deletions(-)
 create mode 100644 Documentation/scsi/aha152x.rst
 delete mode 100644 Documentation/scsi/aha152x.txt
 create mode 100644 Documentation/scsi/source/conf.py
 create mode 100644 Documentation/scsi/source/index.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d26308af6036..e26809c95c79 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -32,6 +32,7 @@ available subsections can be seen below.
    usb/index
    firewire
    pci/index
+   scsi/index
    spi
    i2c
    i3c/index
diff --git a/Documentation/scsi/aha152x.rst b/Documentation/scsi/aha152x.rst
new file mode 100644
index 000000000000..3c4d558b9daf
--- /dev/null
+++ b/Documentation/scsi/aha152x.rst
@@ -0,0 +1,203 @@
+
+=====================================================
+Adaptec AHA-1520/1522 SCSI driver for Linux (aha152x)
+=====================================================
+
+Copyright 1993-1999 Jürgen Fischer <fischer@norbit.de>
+TC1550 patches by Luuk van Dijk (ldz@xs4all.nl)
+
+
+In Revision 2 the driver was modified a lot (especially the
+bottom-half handler complete()).
+
+The driver is much cleaner now, has support for the  new
+error handling code in 2.3, produced less cpu load (much
+less polling loops), has slightly higher throughput  (at
+least on my ancient test box; a i486/33Mhz/20MB).
+
+
+========================
+Configuration Arguments
+========================
++-----------+------------------------------------------+---------------------------+
+|IOPORT|    |   base io address                        |     (0x340/0x140)         |
++-----------+------------------------------------------+---------------------------+
+|IRQ        |      interrupt level                     |     (9-12; default 11)|   |
++-----------+------------------------------------------+---------------------------+
+|SCSI_ID    |   scsi id of controller                  |   (0-7; default 7)        |
++-----------+------------------------------------------+---------------------------+
+|RECONNECT  |  allow targets to disconnect from the bus|  (0/1; default 1 [on])    |
++-----------+------------------------------------------+---------------------------+
+|PARITY     |   enable parity checking                 |   (0/1; default 1 [on])   |
++-----------+------------------------------------------+---------------------------+
+|SYNCHRONOUS|   enable synchronous transfers           |   (0/1; default 1 [on])   |
++-----------+------------------------------------------+---------------------------+
+|DELAY:     |   bus reset delay                        |  (default 100)            |
++-----------+------------------------------------------+---------------------------+
+|EXT_TRANS: |  enable extended translation (see NOTES) |  (0/1: default 0 [off])   |
++-----------+------------------------------------------+---------------------------+
+
+========================================================================
+Compile Time Configuration (go into AHA152X in drivers/scsi/Makefile)
+========================================================================
+
+-DAUTOCONF
+ use configuration the controller reports (AHA-152x only)
+
+-DSKIP_BIOSTEST
+ Don't test for BIOS signature (AHA-1510 or disabled BIOS)
+
+-DSETUP0="{ IOPORT, IRQ, SCSI_ID, RECONNECT, PARITY, SYNCHRONOUS, DELAY, EXT_TRANS }"
+ override for the first controller 
+
+-DSETUP1="{ IOPORT, IRQ, SCSI_ID, RECONNECT, PARITY, SYNCHRONOUS, DELAY, EXT_TRANS }"
+ override for the second controller
+
+-DAHA152X_DEBUG
+ enable debugging output
+
+-DAHA152X_STAT
+ enable some statistics
+
+
+==========================
+Lilo Command Line Options
+==========================
+
+aha152x=<IOPORT>[,<IRQ>[,<SCSI-ID>[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY> [,<EXT_TRANS]]]]]]]
+
+The normal configuration can be overridden by specifying a command
+line.When you do this, the  BIOS  test  is skipped. Entered values
+have to be valid (known).  Don't use values that  aren't supported
+under normal operation.  If  you think that you need other values:
+contact me. For two controllers  use  the aha152x statement twice.
+
+
+=================================
+Symbols For Module Configuration
+=================================
+---------------------------
+Choose From 2 Alternatives
+---------------------------
+1. specify everything (old)
+
+   aha152x=IOPORT,IRQ,SCSI_ID,RECONNECT,PARITY,SYNCHRONOUS,DELAY,EXT_TRANS
+   configuration override for first controller
+
+
+   aha152x1=IOPORT,IRQ,SCSI_ID,RECONNECT,PARITY,SYNCHRONOUS,DELAY,EXT_TRANS
+   configuration override for second controller
+
+2. specify only what you need to (irq or io is required; new)
+
+   io=IOPORT0[,IOPORT1]
+   IOPORT for first and second controller
+
+   irq=IRQ0[,IRQ1]
+   IRQ for first and second controller
+
+   scsiid=SCSIID0[,SCSIID1]
+   SCSIID for first and second controller
+
+   reconnect=RECONNECT0[,RECONNECT1]
+   allow targets to disconnect for first and second controller
+
+   parity=PAR0[PAR1]
+   use parity for first and second controller
+
+   sync=SYNCHRONOUS0[,SYNCHRONOUS1]
+   enable synchronous transfers for first and second controller
+
+   delay=DELAY0[,DELAY1]
+   reset DELAY for first and second controller
+
+   exttrans=EXTTRANS0[,EXTTRANS1]
+   enable extended translation for first and second controller
+
+
+If you use both alternatives the first will be taken.
+
+
+====================
+NOTES ON EXT_TRANS:
+====================
+
+SCSI uses block numbers to address blocks/sectors on a device.
+The BIOS uses a cylinder/head/sector addressing scheme (C/H/S)
+scheme instead.  DOS expects a BIOS or driver that understands
+this C/H/S addressing.
+
+The number of cylinders/heads/sectors is called geometry and is
+required as base for requests in  C/H/S  addressing.  SCSI only
+knows about the total capacity  of  disks  in blocks (sectors).
+
+Therefore the SCSI BIOS/DOS driver has to calculate a logical/virtual
+geometry just  to  be  able  to  support  that addressing scheme. The
+geometry returned by the SCSI BIOS is  a  pure  calculation  and  has
+nothing to do with the  real/physical  geometry  of  the  disk (which
+is usually irrelevant anyway).
+
+Basically this has no impact at all on Linux, because it also  uses block
+instead of C/H/S addressing.  Unfortunately C/H/S addressing is also used
+in the partition table and therefore every operating  system  has to know
+the right geometry to be able to interpret it.
+
+Moreover there are certain limitations to the  C/H/S  addressing scheme,
+namely the address space is limited to up to 255 heads, up to 63 sectors
+and a maximum of 1023 cylinders.
+
+The AHA-1522 BIOS calculates the geometry by fixing the number of heads
+to 64, the number of sectors to  32  and  by  calculating the number of
+cylinders by dividing the capacity reported by the disk by 64*32 (1 MB).
+This is considered to be the default translation.
+
+With respect to the limit of 1023 cylinders using C/H/S you can only
+address the first GB of your disk in the partition table.  Therefore
+BIOSes of some  newer controllers based on the AIC-6260/6360 support
+extended  translation.  This means that the BIOS uses 255 for heads,
+63 for  sectors  and then divides the capacity of the disk by 255*63
+(about 8 MB), as soon it sees a disk greater than 1 GB. That results
+in a maximum of about 8 GB addressable  diskspace  in the  partition
+table (but there are already bigger disks out there today).
+
+To make it even more complicated the translation mode might/might
+not be configurable in certain BIOS setups.
+
+This driver does some more or less failsafe guessing to get the
+geometry right in most cases:
+
+- for disks<1GB:
+  -use default translation (C/32/64)
+
+- for disks>1GB:
+  - take current geometry from the partition table (using scsicam_bios_param
+    and accept only `valid` geometries, ie. either (C/32/64) or (C/63/255)).
+    This can be extended translation even if it's not enabled in the driver.
+
+  - if that fails, take extended translation if  enabled  by override,
+    kernel or module parameter, otherwise take default translation and
+    ask the user for verification.  This might on  not yet partitioned
+    disks.
+
+
+==================
+REFERENCES USED:
+==================
+ "AIC-6260 SCSI Chip Specification", Adaptec Corporation.
+
+ "SCSI COMPUTER SYSTEM INTERFACE - 2 (SCSI-2)", X3T9.2/86-109 rev. 10h
+
+ "Writing a SCSI device driver for Linux", Rik Faith (faith@cs.unc.edu)
+
+ "Kernel Hacker's Guide", Michael K. Johnson (johnsonm@sunsite.unc.edu)
+
+ "Adaptec 1520/1522 User's Guide", Adaptec Corporation.
+
+ Michael K. Johnson (johnsonm@sunsite.unc.edu)
+
+ Drew Eckhardt (drew@cs.colorado.edu)
+
+ Eric Youngdale (eric@andante.org)
+
+ special thanks to Eric Youngdale for the free(!) supplying the
+ documentation on the chip.
diff --git a/Documentation/scsi/aha152x.txt b/Documentation/scsi/aha152x.txt
deleted file mode 100644
index 94848734ac66..000000000000
--- a/Documentation/scsi/aha152x.txt
+++ /dev/null
@@ -1,183 +0,0 @@
-$Id: README.aha152x,v 1.2 1999/12/25 15:32:30 fischer Exp fischer $
-Adaptec AHA-1520/1522 SCSI driver for Linux (aha152x)
-
-Copyright 1993-1999 Jürgen Fischer <fischer@norbit.de>
-TC1550 patches by Luuk van Dijk (ldz@xs4all.nl)
-
-
-In Revision 2 the driver was modified a lot (especially the
-bottom-half handler complete()).
-
-The driver is much cleaner now, has support for the new
-error handling code in 2.3, produced less cpu load (much
-less polling loops), has slightly higher throughput (at
-least on my ancient test box; a i486/33Mhz/20MB).
-
-
-CONFIGURATION ARGUMENTS:
-
-IOPORT        base io address                           (0x340/0x140)
-IRQ           interrupt level                           (9-12; default 11)
-SCSI_ID       scsi id of controller                     (0-7; default 7)
-RECONNECT     allow targets to disconnect from the bus  (0/1; default 1 [on])
-PARITY        enable parity checking                    (0/1; default 1 [on])
-SYNCHRONOUS   enable synchronous transfers              (0/1; default 1 [on])
-DELAY:        bus reset delay                           (default 100)
-EXT_TRANS:    enable extended translation               (0/1: default 0 [off])
-              (see NOTES)
-
-COMPILE TIME CONFIGURATION (go into AHA152X in drivers/scsi/Makefile):
-
--DAUTOCONF
- use configuration the controller reports (AHA-152x only)
-
--DSKIP_BIOSTEST
- Don't test for BIOS signature (AHA-1510 or disabled BIOS)
-
--DSETUP0="{ IOPORT, IRQ, SCSI_ID, RECONNECT, PARITY, SYNCHRONOUS, DELAY, EXT_TRANS }"
- override for the first controller 
-
--DSETUP1="{ IOPORT, IRQ, SCSI_ID, RECONNECT, PARITY, SYNCHRONOUS, DELAY, EXT_TRANS }"
- override for the second controller
-
--DAHA152X_DEBUG
- enable debugging output
-
--DAHA152X_STAT
- enable some statistics
-
-
-LILO COMMAND LINE OPTIONS:
-
-aha152x=<IOPORT>[,<IRQ>[,<SCSI-ID>[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY> [,<EXT_TRANS]]]]]]]
-
- The normal configuration can be overridden by specifying a command line.
- When you do this, the BIOS test is skipped. Entered values have to be
- valid (known).  Don't use values that aren't supported under normal
- operation.  If you think that you need other values: contact me.
- For two controllers use the aha152x statement twice.
-
-
-SYMBOLS FOR MODULE CONFIGURATION:
-
-Choose from 2 alternatives:
-
-1. specify everything (old)
-
-aha152x=IOPORT,IRQ,SCSI_ID,RECONNECT,PARITY,SYNCHRONOUS,DELAY,EXT_TRANS
-  configuration override for first controller
-
-
-aha152x1=IOPORT,IRQ,SCSI_ID,RECONNECT,PARITY,SYNCHRONOUS,DELAY,EXT_TRANS
-  configuration override for second controller
-
-2. specify only what you need to (irq or io is required; new)
-
-io=IOPORT0[,IOPORT1]
-  IOPORT for first and second controller
-
-irq=IRQ0[,IRQ1]
-  IRQ for first and second controller
-
-scsiid=SCSIID0[,SCSIID1]
-  SCSIID for first and second controller
-
-reconnect=RECONNECT0[,RECONNECT1]
-  allow targets to disconnect for first and second controller
-
-parity=PAR0[PAR1]
-  use parity for first and second controller
-
-sync=SYNCHRONOUS0[,SYNCHRONOUS1]
-  enable synchronous transfers for first and second controller
-
-delay=DELAY0[,DELAY1]
-  reset DELAY for first and second controller
-
-exttrans=EXTTRANS0[,EXTTRANS1]
-  enable extended translation for first and second controller
-
-
-If you use both alternatives the first will be taken.
-
-
-NOTES ON EXT_TRANS: 
-
-SCSI uses block numbers to address blocks/sectors on a device.
-The BIOS uses a cylinder/head/sector addressing scheme (C/H/S)
-scheme instead.  DOS expects a BIOS or driver that understands this
-C/H/S addressing.
-
-The number of cylinders/heads/sectors is called geometry and is required
-as base for requests in C/H/S addressing.  SCSI only knows about the
-total capacity of disks in blocks (sectors).
-
-Therefore the SCSI BIOS/DOS driver has to calculate a logical/virtual
-geometry just to be able to support that addressing scheme.  The geometry
-returned by the SCSI BIOS is a pure calculation and has nothing to
-do with the real/physical geometry of the disk (which is usually
-irrelevant anyway).
-
-Basically this has no impact at all on Linux, because it also uses block
-instead of C/H/S addressing.  Unfortunately C/H/S addressing is also used
-in the partition table and therefore every operating system has to know
-the right geometry to be able to interpret it.
-
-Moreover there are certain limitations to the C/H/S addressing scheme,
-namely the address space is limited to up to 255 heads, up to 63 sectors
-and a maximum of 1023 cylinders.
-
-The AHA-1522 BIOS calculates the geometry by fixing the number of heads
-to 64, the number of sectors to 32 and by calculating the number of
-cylinders by dividing the capacity reported by the disk by 64*32 (1 MB).
-This is considered to be the default translation.
-
-With respect to the limit of 1023 cylinders using C/H/S you can only
-address the first GB of your disk in the partition table.  Therefore
-BIOSes of some newer controllers based on the AIC-6260/6360 support
-extended translation.  This means that the BIOS uses 255 for heads,
-63 for sectors and then divides the capacity of the disk by 255*63
-(about 8 MB), as soon it sees a disk greater than 1 GB.  That results
-in a maximum of about 8 GB addressable diskspace in the partition table
-(but there are already bigger disks out there today).
-
-To make it even more complicated the translation mode might/might
-not be configurable in certain BIOS setups.
-
-This driver does some more or less failsafe guessing to get the
-geometry right in most cases:
-
-- for disks<1GB: use default translation (C/32/64)
-
-- for disks>1GB:
-  - take current geometry from the partition table
-    (using scsicam_bios_param and accept only `valid' geometries,
-    ie. either (C/32/64) or (C/63/255)).  This can be extended translation
-    even if it's not enabled in the driver.
-
-  - if that fails, take extended translation if enabled by override,
-    kernel or module parameter, otherwise take default translation and
-    ask the user for verification.  This might on not yet partitioned
-    disks.
-
-
-REFERENCES USED:
-
- "AIC-6260 SCSI Chip Specification", Adaptec Corporation.
-
- "SCSI COMPUTER SYSTEM INTERFACE - 2 (SCSI-2)", X3T9.2/86-109 rev. 10h
-
- "Writing a SCSI device driver for Linux", Rik Faith (faith@cs.unc.edu)
-
- "Kernel Hacker's Guide", Michael K. Johnson (johnsonm@sunsite.unc.edu)
-
- "Adaptec 1520/1522 User's Guide", Adaptec Corporation.
-
- Michael K. Johnson (johnsonm@sunsite.unc.edu)
-
- Drew Eckhardt (drew@cs.colorado.edu)
-
- Eric Youngdale (eric@andante.org) 
-
- special thanks to Eric Youngdale for the free(!) supplying the
- documentation on the chip.
diff --git a/Documentation/scsi/source/conf.py b/Documentation/scsi/source/conf.py
new file mode 100644
index 000000000000..8f60483b49fb
--- /dev/null
+++ b/Documentation/scsi/source/conf.py
@@ -0,0 +1,52 @@
+# Configuration file for the Sphinx documentation builder.
+#
+# This file only contains a selection of the most common options. For a full
+# list see the documentation:
+# http://www.sphinx-doc.org/en/master/config
+
+# -- Path setup --------------------------------------------------------------
+
+# If extensions (or modules to document with autodoc) are in another directory,
+# add these directories to sys.path here. If the directory is relative to the
+# documentation root, use os.path.abspath to make it absolute, like shown here.
+#
+# import os
+# import sys
+# sys.path.insert(0, os.path.abspath('.'))
+
+
+# -- Project information -----------------------------------------------------
+
+project = 'doc'
+copyright = '2019, sushma'
+author = 'sushma'
+
+
+# -- General configuration ---------------------------------------------------
+
+# Add any Sphinx extension module names here, as strings. They can be
+# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
+# ones.
+extensions = [
+]
+
+# Add any paths that contain templates here, relative to this directory.
+templates_path = ['_templates']
+
+# List of patterns, relative to source directory, that match files and
+# directories to ignore when looking for source files.
+# This pattern also affects html_static_path and html_extra_path.
+exclude_patterns = []
+
+
+# -- Options for HTML output -------------------------------------------------
+
+# The theme to use for HTML and HTML Help pages.  See the documentation for
+# a list of builtin themes.
+#
+html_theme = 'alabaster'
+
+# Add any paths that contain custom static files (such as style sheets) here,
+# relative to this directory. They are copied after the builtin static files,
+# so a file named "default.css" will overwrite the builtin "default.css".
+html_static_path = ['_static']
diff --git a/Documentation/scsi/source/index.rst b/Documentation/scsi/source/index.rst
new file mode 100644
index 000000000000..003259e30a59
--- /dev/null
+++ b/Documentation/scsi/source/index.rst
@@ -0,0 +1,22 @@
+.. doc documentation master file, created by
+   sphinx-quickstart on Mon Jul  1 11:21:20 2019.
+   You can adapt this file completely to your liking, but it should at least
+   contain the root `toctree` directive.
+.SPDX-License-Identifier: GPL-2.0
+
+===============================
+SCSI Subsystem
+===============================
+
+.. toctree::
+   :maxdepth: 2
+   :caption: Contents:
+
+aha152x
+
+Indices and tables
+==================
+
+* :ref:`genindex`
+* :ref:`modindex`
+* :ref:`search`
-- 
2.17.1

