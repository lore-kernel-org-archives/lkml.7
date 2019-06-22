Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B84C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9249620675
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTS853nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfFVPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:20:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44525 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:20:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so5058064pfe.11;
        Sat, 22 Jun 2019 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yd9cK3KlTlKE8WDxZQXCNK6DagSfSc1V7/+W70Ps+4g=;
        b=YTS853nARLIw+qA7mq2MQCVCRISctm/68X2uUVoMnFLFcxTsHK3dCIakUVcaayGZWL
         VrR5MvPTwk3rT/l7HNixPoHSIfdJUbOxmqaAdZTZNs/VFrdaf5QpDFkuAs9XF+TkdD3O
         OsEtVKVLXuCg4tx58fdgWb3QA5dl2gfyYTKL4twYSfYt92cWv7Yy8ayz8m/JTd5b45w3
         c0wBgDQ7bcfsk/4AGOgw0mBxMY6H7gxJU2Ae4GGkAcwELEnh2BD+QiRn/JfyQiTVbkJI
         DC+iPnSbxOiUwrGZ6Df4x3DRIwYE9wbQXWYd7i7vIbKKtPauENyg3tnIHevdIanWdA+X
         eDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yd9cK3KlTlKE8WDxZQXCNK6DagSfSc1V7/+W70Ps+4g=;
        b=PHNQgDscmh0fsThsRXHlCYGqLIzcSR+3HlwvM1nlLD5uVcTlH3W5YZ6b0WkT/ot/IR
         nsTGnok6AYzY9QL+ULLjMIYy3RjroGYYFXG0KSqVsRQ1+RHApH3EQXneXhznck2d4Gpi
         tVjUkHP4km4iy+b8pMCcgkTOiqvfn0u+KzCBVbPcVNi+w1+qJtFaX8j0A4LuLVa0vAL+
         L/82zPFPLscBqFIs5+i4B+H6FYu0qScDKRZTxlr0foZ8cV74E35AGQi7OgO+eSxaxs8e
         iwezm2Hm+vgocqGuUEuS/4fa0nwcTnY/O82IM8S5xiHT8WMEkVKTN94ghVrJ1wnAYZ6C
         wqQw==
X-Gm-Message-State: APjAAAUVs17b/rD+HC/Yktox1gqMmrkmBQaiDGqgMbLPScbJdwgwlGzK
        GPB8vN/1XJdxI8eX3SbpkbQ=
X-Google-Smtp-Source: APXvYqw57sKAhkgB8gPrVERzwSnYleejPYzIVFUwlLk5LVgKDzjNl/0OXF/V9ON38culSflBQ3GYLA==
X-Received: by 2002:a65:538d:: with SMTP id x13mr13854671pgq.190.1561216801760;
        Sat, 22 Jun 2019 08:20:01 -0700 (PDT)
Received: from debian.net.fpt ([2405:4800:58c7:2e37:f043:c009:144d:8e5e])
        by smtp.gmail.com with ESMTPSA id j64sm8779698pfb.126.2019.06.22.08.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 08:20:00 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     corbet@lwn.net, skhan@linuxfoundation.org,
        martin.petersen@oracle.com, axboe@kernel.dk, avri.altman@wdc.com,
        beanhuo@micron.com, evgreen@chromium.org, henrik@austad.us,
        jpittman@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] scsi: convert to rst for documenation
Date:   Sat, 22 Jun 2019 22:19:47 +0700
Message-Id: <20190622151947.29115-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Update to the link in documenation
- Remove trailing white space
- Adaptation the sphinx doc syntax

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 Documentation/index.rst                            |    1 +
 Documentation/scsi/index.rst                       |   29 +
 .../scsi/link_power_management_policy.rst          |   22 +
 .../scsi/link_power_management_policy.txt          |   19 -
 .../scsi/{scsi-changer.txt => scsi-changer.rst}    |  108 +-
 .../scsi/{scsi-generic.txt => scsi-generic.rst}    |   74 +-
 .../{scsi-parameters.txt => scsi-parameters.rst}   |   30 +-
 Documentation/scsi/{scsi.txt => scsi.rst}          |    4 +-
 Documentation/scsi/scsi_eh.rst                     |  533 ++++++++
 Documentation/scsi/scsi_eh.txt                     |  475 -------
 ...scsi_fc_transport.txt => scsi_fc_transport.rst} |   94 +-
 Documentation/scsi/scsi_mid_low_api.rst            | 1357 ++++++++++++++++++++
 Documentation/scsi/scsi_mid_low_api.txt            | 1279 ------------------
 13 files changed, 2120 insertions(+), 1905 deletions(-)
 create mode 100644 Documentation/scsi/index.rst
 create mode 100644 Documentation/scsi/link_power_management_policy.rst
 delete mode 100644 Documentation/scsi/link_power_management_policy.txt
 rename Documentation/scsi/{scsi-changer.txt => scsi-changer.rst} (71%)
 rename Documentation/scsi/{scsi-generic.txt => scsi-generic.rst} (70%)
 rename Documentation/scsi/{scsi-parameters.txt => scsi-parameters.rst} (82%)
 rename Documentation/scsi/{scsi.txt => scsi.rst} (93%)
 create mode 100644 Documentation/scsi/scsi_eh.rst
 delete mode 100644 Documentation/scsi/scsi_eh.txt
 rename Documentation/scsi/{scsi_fc_transport.txt => scsi_fc_transport.rst} (93%)
 create mode 100644 Documentation/scsi/scsi_mid_low_api.rst
 delete mode 100644 Documentation/scsi/scsi_mid_low_api.txt

diff --git a/Documentation/index.rst b/Documentation/index.rst
index a7566ef62411..ad638a5bf711 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -95,6 +95,7 @@ needed).
    input/index
    hwmon/index
    gpu/index
+   scsi/index
    security/index
    sound/index
    crypto/index
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
new file mode 100644
index 000000000000..1cb8e61ab368
--- /dev/null
+++ b/Documentation/scsi/index.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Linux Kernel SCSI Subsystem Documentation
+=========================================
+
+.. only:: html
+
+   .. class:: toc-title
+
+        Table of Contents
+
+.. toctree::
+   :maxdepth: 3
+
+   scsi
+   scsi-generic
+   scsi-parameters
+   scsi_mid_low_api
+   scsi_eh
+   scsi-changer
+   scsi_fc_transport
+   link_power_management_policy
+
+.. only:: html and subproject
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/scsi/link_power_management_policy.rst b/Documentation/scsi/link_power_management_policy.rst
new file mode 100644
index 000000000000..170f58c94cac
--- /dev/null
+++ b/Documentation/scsi/link_power_management_policy.rst
@@ -0,0 +1,22 @@
+SCSI Power Management Policy
+============================
+
+This parameter allows the user to set the link (interface) power management.
+There are 3 possible options:
+
++-------------------+------------------------------------------------------+
+| Value             | Effect                                               |
++===================+======================================================+
+| min_power         | Tell the controller to try to make the link use the  |
+|                   | least possible power when possible. This may         |
+|                   | sacrifice some performance due to increased latency  |
+|                   | when coming out of lower power states.               |
++-------------------+------------------------------------------------------+
+| max_performance   | Generally, this means no power management. Tell      |
+|                   | the controller to have performance be a priority     |
+|                   | over power management.                               |
++-------------------+------------------------------------------------------+
+| medium_power      | Tell the controller to enter a lower power state     |
+|                   | when possible, but do not enter the lowest power     |
+|                   | state, thus improving latency over min_power setting.|
++-------------------+------------------------------------------------------+
diff --git a/Documentation/scsi/link_power_management_policy.txt b/Documentation/scsi/link_power_management_policy.txt
deleted file mode 100644
index d18993d01884..000000000000
--- a/Documentation/scsi/link_power_management_policy.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-This parameter allows the user to set the link (interface) power management.
-There are 3 possible options:
-
-Value			Effect
-----------------------------------------------------------------------------
-min_power		Tell the controller to try to make the link use the
-			least possible power when possible.  This may
-			sacrifice some performance due to increased latency
-			when coming out of lower power states.
-
-max_performance		Generally, this means no power management.  Tell
-			the controller to have performance be a priority
-			over power management.
-
-medium_power		Tell the controller to enter a lower power state
-			when possible, but do not enter the lowest power
-			state, thus improving latency over min_power setting.
-
-
diff --git a/Documentation/scsi/scsi-changer.txt b/Documentation/scsi/scsi-changer.rst
similarity index 71%
rename from Documentation/scsi/scsi-changer.txt
rename to Documentation/scsi/scsi-changer.rst
index ade046ea7c17..a4923873c77b 100644
--- a/Documentation/scsi/scsi-changer.txt
+++ b/Documentation/scsi/scsi-changer.rst
@@ -1,4 +1,3 @@
-
 README for the SCSI media changer driver
 ========================================
 
@@ -10,7 +9,7 @@ common small CD-ROM changers, neither one-lun-per-slot SCSI changers
 nor IDE drives.
 
 Userland tools available from here:
-	http://linux.bytesex.org/misc/changer.html
+    http://linux.bytesex.org/misc/changer.html
 
 
 General Information
@@ -28,15 +27,17 @@ The SCSI changer model is complex, compared to - for example - IDE-CD
 changers. But it allows to handle nearly all possible cases. It knows
 4 different types of changer elements:
 
+::
+
   media transport - this one shuffles around the media, i.e. the
                     transport arm.  Also known as "picker".
   storage         - a slot which can hold a media.
   import/export   - the same as above, but is accessible from outside,
                     i.e. there the operator (you !) can use this to
                     fill in and remove media from the changer.
-		    Sometimes named "mailslot".
+            Sometimes named "mailslot".
   data transfer   - this is the device which reads/writes, i.e. the
-		    CD-ROM / Tape / whatever drive.
+            CD-ROM / Tape / whatever drive.
 
 None of these is limited to one: A huge Jukebox could have slots for
 123 CD-ROM's, 5 CD-ROM readers (and therefore 6 SCSI ID's: the changer
@@ -113,47 +114,48 @@ driver, please include these messages.
 
 Insmod options
 --------------
-
-debug=0/1
-	Enable debug messages (see above, default: 0).
-
-verbose=0/1
-	Be verbose (default: 1).
-
-init=0/1
-	Send INITIALIZE ELEMENT STATUS command to the changer
-	at insmod time (default: 1).
-
-timeout_init=<seconds>
-	timeout for the INITIALIZE ELEMENT STATUS command
-	(default: 3600).
-
-timeout_move=<seconds>
-	timeout for all other commands (default: 120).
-
-dt_id=<id1>,<id2>,...
-dt_lun=<lun1>,<lun2>,...
-	These two allow to specify the SCSI ID and LUN for the data
-	transfer elements.  You likely don't need this as the jukebox
-	should provide this information.  But some devices don't ...
-
-vendor_firsts=
-vendor_counts=
-vendor_labels=
-	These insmod options can be used to tell the driver that there
-	are some vendor-specific element types.  Grundig for example
-	does this.  Some jukeboxes have a printer to label fresh burned
-	CDs, which is addressed as element 0xc000 (type 5).  To tell the
-	driver about this vendor-specific element, use this:
-		$ insmod ch			\
-			vendor_firsts=0xc000	\
-			vendor_counts=1		\
-			vendor_labels=printer
-	All three insmod options accept up to four comma-separated
-	values, this way you can configure the element types 5-8.
-	You likely need the SCSI specs for the device in question to
-	find the correct values as they are not covered by the SCSI-2
-	standard.
+::
+
+    debug=0/1
+        Enable debug messages (see above, default: 0).
+
+    verbose=0/1
+        Be verbose (default: 1).
+
+    init=0/1
+        Send INITIALIZE ELEMENT STATUS command to the changer
+        at insmod time (default: 1).
+
+    timeout_init=<seconds>
+        timeout for the INITIALIZE ELEMENT STATUS command
+        (default: 3600).
+
+    timeout_move=<seconds>
+        timeout for all other commands (default: 120).
+
+    dt_id=<id1>,<id2>,...
+    dt_lun=<lun1>,<lun2>,...
+        These two allow to specify the SCSI ID and LUN for the data
+        transfer elements.  You likely don't need this as the jukebox
+        should provide this information.  But some devices don't ...
+
+    vendor_firsts=
+    vendor_counts=
+    vendor_labels=
+        These insmod options can be used to tell the driver that there
+        are some vendor-specific element types.  Grundig for example
+        does this.  Some jukeboxes have a printer to label fresh burned
+        CDs, which is addressed as element 0xc000 (type 5).  To tell the
+        driver about this vendor-specific element, use this:
+            $ insmod ch            \
+                vendor_firsts=0xc000    \
+                vendor_counts=1        \
+                vendor_labels=printer
+        All three insmod options accept up to four comma-separated
+        values, this way you can configure the element types 5-8.
+        You likely need the SCSI specs for the device in question to
+        find the correct values as they are not covered by the SCSI-2
+        standard.
 
 
 Credits
@@ -162,13 +164,17 @@ Credits
 I wrote this driver using the famous mailing-patches-around-the-world
 method.  With (more or less) help from:
 
-	Daniel Moehwald <moehwald@hdg.de>
-	Dane Jasper <dane@sonic.net>
-	R. Scott Bailey <sbailey@dsddi.eds.com>
-	Jonathan Corbet <corbet@lwn.net>
+    Daniel Moehwald <moehwald@hdg.de>
+
+    Dane Jasper <dane@sonic.net>
+
+    R. Scott Bailey <sbailey@dsddi.eds.com>
+
+    Jonathan Corbet <corbet@lwn.net>
 
 Special thanks go to
-	Martin Kuehne <martin.kuehne@bnbt.de>
+    Martin Kuehne <martin.kuehne@bnbt.de>
+
 for a old, second-hand (but full functional) cdrom jukebox which I use
 to develop/test driver and tools now.
 
@@ -176,5 +182,5 @@ Have fun,
 
    Gerd
 
--- 
+--
 Gerd Knorr <kraxel@bytesex.org>
diff --git a/Documentation/scsi/scsi-generic.txt b/Documentation/scsi/scsi-generic.rst
similarity index 70%
rename from Documentation/scsi/scsi-generic.txt
rename to Documentation/scsi/scsi-generic.rst
index 51be20a6a14d..8356810160f0 100644
--- a/Documentation/scsi/scsi-generic.txt
+++ b/Documentation/scsi/scsi-generic.rst
@@ -1,8 +1,10 @@
-            Notes on Linux SCSI Generic (sg) driver
-            ---------------------------------------
-                                                        20020126
+=======================================
+Notes on Linux SCSI Generic (sg) driver
+=======================================
+20020126
+
 Introduction
-============
+------------
 The SCSI Generic driver (sg) is one of the four "high level" SCSI device
 drivers along with sd, st and sr (disk, tape and CDROM respectively). Sg
 is more generalized (but lower level) than its siblings and tends to be
@@ -16,20 +18,20 @@ and examples.
 
 
 Major versions of the sg driver
-===============================
+-------------------------------
 There are three major versions of sg found in the linux kernel (lk):
-      - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) . 
-	It is based in the sg_header interface structure.
+      - sg version 1 (original) from 1992 to early 1999 (lk 2.2.5) .
+        It is based in the sg_header interface structure.
       - sg version 2 from lk 2.2.6 in the 2.2 series. It is based on
-	an extended version of the sg_header interface structure.
+        an extended version of the sg_header interface structure.
       - sg version 3 found in the lk 2.4 series (and the lk 2.5 series).
-	It adds the sg_io_hdr interface structure.
+        It adds the sg_io_hdr interface structure.
 
 
 Sg driver documentation
-=======================
+-----------------------
 The most recent documentation of the sg driver is kept at the Linux
-Documentation Project's (LDP) site: 
+Documentation Project's (LDP) site:
 http://www.tldp.org/HOWTO/SCSI-Generic-HOWTO
 This describes the sg version 3 driver found in the lk 2.4 series.
 The LDP renders documents in single and multiple page HTML, postscript
@@ -41,27 +43,28 @@ be found at http://sg.danny.cz/sg/. A larger version
 is at: http://sg.danny.cz/sg/p/scsi-generic_long.txt.
 
 The original documentation for the sg driver (prior to lk 2.2.6) can be
-found at http://www.torque.net/sg/p/original/SCSI-Programming-HOWTO.txt
+found at https://www.tldp.org/HOWTO/archived/SCSI-Programming-HOWTO/index.html
 and in the LDP archives.
 
 A changelog with brief notes can be found in the
-/usr/src/linux/include/scsi/sg.h file. Note that the glibc maintainers copy 
-and edit this file (removing its changelog for example) before placing it 
-in /usr/include/scsi/sg.h . Driver debugging information and other notes 
+/usr/src/linux/include/scsi/sg.h file. Note that the glibc maintainers copy
+and edit this file (removing its changelog for example) before placing it
+in /usr/include/scsi/sg.h . Driver debugging information and other notes
 can be found at the top of the /usr/src/linux/drivers/scsi/sg.c file.
 
-A more general description of the Linux SCSI subsystem of which sg is a 
+A more general description of the Linux SCSI subsystem of which sg is a
 part can be found at http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO .
 
 
 Example code and utilities
-==========================
+--------------------------
 There are two packages of sg utilities:
   - sg3_utils   for the sg version 3 driver found in lk 2.4
   - sg_utils    for the sg version 2 (and original) driver found in lk 2.2
                 and earlier
+
 Both packages will work in the lk 2.4 series however sg3_utils offers more
-capabilities. They can be found at: http://sg.danny.cz/sg/sg3_utils.html and 
+capabilities. They can be found at: http://sg.danny.cz/sg/sg3_utils.html and
 freecode.com
 
 Another approach is to look at the applications that use the sg driver.
@@ -69,27 +72,34 @@ These include cdrecord, cdparanoia, SANE and cdrdao.
 
 
 Mapping of Linux kernel versions to sg driver versions
-======================================================
+------------------------------------------------------
 Here is a list of linux kernels in the 2.4 series that had new version
 of the sg driver:
-      lk 2.4.0 : sg version 3.1.17
-      lk 2.4.7 : sg version 3.1.19 
-      lk 2.4.10 : sg version 3.1.20  **
-      lk 2.4.17 : sg version 3.1.22 
+
+=========  =======================
+lk 2.4.0   sg version 3.1.17
+lk 2.4.7   sg version 3.1.19
+lk 2.4.10  sg version 3.1.20  **
+lk 2.4.17  sg version 3.1.22
+=========  =======================
+
 
 ** There were 3 changes to sg version 3.1.20 by third parties in the
    next six linux kernel versions.
 
-For reference here is a list of linux kernels in the 2.2 series that had 
+For reference here is a list of linux kernels in the 2.2 series that had
 new version of the sg driver:
-      lk 2.2.0 : original sg version [with no version number]
-      lk 2.2.6 : sg version 2.1.31
-      lk 2.2.8 : sg version 2.1.32
-      lk 2.2.10 : sg version 2.1.34 [SG_GET_VERSION_NUM ioctl first appeared]
-      lk 2.2.14 : sg version 2.1.36
-      lk 2.2.16 : sg version 2.1.38
-      lk 2.2.17 : sg version 2.1.39
-      lk 2.2.20 : sg version 2.1.40
+
+========= =============================================================
+lk 2.2.0  original sg version [with no version number]
+lk 2.2.6  sg version 2.1.31
+lk 2.2.8  sg version 2.1.32
+lk 2.2.10  sg version 2.1.34 [SG_GET_VERSION_NUM ioctl first appeared]
+lk 2.2.14  sg version 2.1.36
+lk 2.2.16  sg version 2.1.38
+lk 2.2.17  sg version 2.1.39
+lk 2.2.20  sg version 2.1.40
+========= =============================================================
 
 The lk 2.5 development series has recently commenced and it currently
 contains sg version 3.5.23 which is functionally equivalent to sg
diff --git a/Documentation/scsi/scsi-parameters.txt b/Documentation/scsi/scsi-parameters.rst
similarity index 82%
rename from Documentation/scsi/scsi-parameters.txt
rename to Documentation/scsi/scsi-parameters.rst
index 25a4b4cf04a6..0b54e9a6ef50 100644
--- a/Documentation/scsi/scsi-parameters.txt
+++ b/Documentation/scsi/scsi-parameters.rst
@@ -1,16 +1,30 @@
-                          SCSI Kernel Parameters
-                          ~~~~~~~~~~~~~~~~~~~~~~
+SCSI Kernel Parameters
+======================
 
-See Documentation/admin-guide/kernel-parameters.rst for general information on
-specifying module parameters.
+See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
+for general information on specifying module parameters.
 
 This document may not be entirely up to date and comprehensive. The command
-"modinfo -p ${modulename}" shows a current list of all parameters of a loadable
+
+.. code-block:: bash
+
+ modinfo -p ${modulename}
+
+shows a current list of all parameters of a loadable
 module. Loadable modules, after being loaded into the running kernel, also
-reveal their parameters in /sys/module/${modulename}/parameters/. Some of these
-parameters may be changed at runtime by the command
-"echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
+reveal their parameters in
+
+.. code-block:: bash
+
+ /sys/module/${modulename}/parameters/
+
+Some of these parameters may be changed at runtime by the command
+
+.. code-block:: bash
+
+ echo -n ${value} > /sys/module/${modulename}/parameters/${parm}
 
+.. code-block:: text
 
 	advansys=	[HW,SCSI]
 			See header of drivers/scsi/advansys.c.
diff --git a/Documentation/scsi/scsi.txt b/Documentation/scsi/scsi.rst
similarity index 93%
rename from Documentation/scsi/scsi.txt
rename to Documentation/scsi/scsi.rst
index 3d99d38cb62a..47b86055b5ae 100644
--- a/Documentation/scsi/scsi.txt
+++ b/Documentation/scsi/scsi.rst
@@ -4,11 +4,9 @@ The Linux Documentation Project (LDP) maintains a document describing
 the SCSI subsystem in the Linux kernel (lk) 2.4 series. See:
 http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
 and multiple page HTML renderings as well as postscript and pdf.
-It can also be found at:
-http://web.archive.org/web/*/http://www.torque.net/scsi/SCSI-2.4-HOWTO
 
 Notes on using modules in the SCSI subsystem
-============================================
+--------------------------------------------
 The scsi support in the linux kernel can be modularized in a number of 
 different ways depending upon the needs of the end user.  To understand
 your options, we should first define a few terms.
diff --git a/Documentation/scsi/scsi_eh.rst b/Documentation/scsi/scsi_eh.rst
new file mode 100644
index 000000000000..6135a721caf4
--- /dev/null
+++ b/Documentation/scsi/scsi_eh.rst
@@ -0,0 +1,533 @@
+SCSI EH
+======================================
+
+This document describes SCSI midlayer error handling infrastructure.
+Please refer to Documentation/scsi/scsi_mid_low_api.txt for more
+information regarding SCSI midlayer.
+
+TABLE OF CONTENTS
+
+:ref:`[1] How SCSI commands travel through the midlayer and to EH <1SCSIEH>`
+
+    :ref:`[1-1] struct scsi_cmnd <11SCSIEH>`
+
+    :ref:`[1-2] How do scmd’s get completed? <12SCSIEH>`
+
+        :ref:`[1-2-1] Completing a scmd w/ scsi_done <121SCSIEH>`
+
+        :ref:`[1-2-2] Completing a scmd w/ timeout <122SCSIEH>`
+
+    :ref:`[1-3] Asynchronous command aborts <13SCSIEH>`
+
+    :ref:`[1-4] How EH takes over <14SCSIEH>`
+
+:ref:`[2] How SCSI EH works <2SCSIEH>`
+
+    :ref:`[2-1] EH through fine-grained callbacks <21SCSIEH>`
+
+        :ref:`[2-1-1] Overview <211SCSIEH>`
+
+        :ref:`[2-1-2] Flow of scmds through EH <212SCSIEH>`
+
+        :ref:`[2-1-3] Flow of control <213SCSIEH>`
+
+    :ref:`[2-2] EH through transportt->eh_strategy_handler() <22SCSIEH>`
+
+        :ref:`[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions <221SCSIEH>`
+
+        :ref:`[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions <222SCSIEH>`
+
+        :ref:`[2-2-3] Things to consider  <223SCSIEH>`
+
+.. _1SCSIEH:
+
+[1] How SCSI commands travel through the midlayer and to EH
+-----------------------------------------------------------
+
+.. _11SCSIEH:
+
+[1-1] struct scsi_cmnd
+~~~~~~~~~~~~~~~~~~~~~~
+
+Each SCSI command is represented with struct scsi_cmnd (== scmd).  A
+scmd has two list_head's to link itself into lists.  The two are
+scmd->list and scmd->eh_entry.  The former is used for free list or
+per-device allocated scmd list and not of much interest to this EH
+discussion.  The latter is used for completion and EH lists and unless
+otherwise stated scmds are always linked using scmd->eh_entry in this
+discussion.
+
+.. _12SCSIEH:
+
+[1-2] How do scmd's get completed?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Once LLDD gets hold of a scmd, either the LLDD will complete the
+command by calling scsi_done callback passed from midlayer when
+invoking hostt->queuecommand() or the block layer will time it out.
+
+.. _121SCSIEH:
+
+[1-2-1] Completing a scmd w/ scsi_done
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+For all non-EH commands, scsi_done() is the completion callback.  It
+just calls blk_complete_request() to delete the block layer timer and
+raise SCSI_SOFTIRQ
+
+SCSI_SOFTIRQ handler scsi_softirq calls scsi_decide_disposition() to
+determine what to do with the command.  scsi_decide_disposition()
+looks at the scmd->result value and sense data to determine what to do
+with the command.
+
+ - SUCCESS
+    scsi_finish_command() is invoked for the command.  The
+    function does some maintenance chores and then calls
+    scsi_io_completion() to finish the I/O.
+    scsi_io_completion() then notifies the block layer on
+    the completed request by calling blk_end_request and
+    friends or figures out what to do with the remainder
+    of the data in case of an error.
+
+ - NEEDS_RETRY
+
+ - ADD_TO_MLQUEUE
+    scmd is requeued to blk queue.
+
+ - otherwise
+    scsi_eh_scmd_add(scmd) is invoked for the command.  See
+    [1-3] for details of this function.
+
+.. _122SCSIEH:
+
+[1-2-2] Completing a scmd w/ timeout
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The timeout handler is scsi_times_out().  When a timeout occurs, this
+function
+
+ 1. invokes optional hostt->eh_timed_out() callback.  Return value can
+    be one of
+
+    - BLK_EH_RESET_TIMER
+
+    This indicates that more time is required to finish the
+    command.  Timer is restarted.  This action is counted as a
+    retry and only allowed scmd->allowed + 1(!) times.  Once the
+    limit is reached, action for BLK_EH_DONE is taken instead.
+
+    - BLK_EH_DONE
+
+    eh_timed_out() callback did not handle the command. Step #2 is taken.
+
+ 2. scsi_abort_command() is invoked to schedule an asynchrous abort.
+    Asynchronous abort are not invoked for commands which the
+    SCSI_EH_ABORT_SCHEDULED flag is set (this indicates that the command
+    already had been aborted once, and this is a retry which failed),
+    or when the EH deadline is expired. In these case Step #3 is taken.
+
+ 3. scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD) is invoked for the
+    command.  See [1-4] for more information.
+
+.. _13SCSIEH:
+
+[1-3] Asynchronous command aborts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ After a timeout occurs a command abort is scheduled from
+ scsi_abort_command(). If the abort is successful the command
+ will either be retried (if the number of retries is not exhausted)
+ or terminated with DID_TIME_OUT.
+ Otherwise scsi_eh_scmd_add() is invoked for the command.
+ See [1-4] for more information.
+
+.. _14SCSIEH:
+
+[1-4] How EH takes over
+~~~~~~~~~~~~~~~~~~~~~~~
+
+ scmds enter EH via scsi_eh_scmd_add(), which does the following.
+
+ 1. Links scmd->eh_entry to shost->eh_cmd_q
+
+ 2. Sets SHOST_RECOVERY bit in shost->shost_state
+
+ 3. Increments shost->host_failed
+
+ 4. Wakes up SCSI EH thread if shost->host_busy == shost->host_failed
+
+As can be seen above, once any scmd is added to shost->eh_cmd_q,
+SHOST_RECOVERY shost_state bit is turned on.  This prevents any new
+scmd to be issued from blk queue to the host; eventually, all scmds on
+the host either complete normally, fail and get added to eh_cmd_q, or
+time out and get added to shost->eh_cmd_q.
+
+If all scmds either complete or fail, the number of in-flight scmds
+becomes equal to the number of failed scmds - i.e. shost->host_busy ==
+shost->host_failed.  This wakes up SCSI EH thread.  So, once woken up,
+SCSI EH thread can expect that all in-flight commands have failed and
+are linked on shost->eh_cmd_q.
+
+Note that this does not mean lower layers are quiescent.  If a LLDD
+completed a scmd with error status, the LLDD and lower layers are
+assumed to forget about the scmd at that point.  However, if a scmd
+has timed out, unless hostt->eh_timed_out() made lower layers forget
+about the scmd, which currently no LLDD does, the command is still
+active as long as lower layers are concerned and completion could
+occur at any time.  Of course, all such completions are ignored as the
+timer has already expired.
+
+We'll talk about how SCSI EH takes actions to abort - make LLDD
+forget about - timed out scmds later.
+
+
+.. _2SCSIEH:
+
+[2] How SCSI EH works
+---------------------
+
+LLDD's can implement SCSI EH actions in one of the following two
+ways.
+
+ - Fine-grained EH callbacks
+    LLDD can implement fine-grained EH callbacks and let SCSI
+    midlayer drive error handling and call appropriate callbacks.
+    This will be discussed further in :ref:`[2-1] <21SCSIEH>`.
+
+ - eh_strategy_handler() callback
+    This is one big callback which should perform whole error
+    handling.  As such, it should do all chores the SCSI midlayer
+    performs during recovery.  This will be discussed in :ref:`[2-2] <22SCSIEH>`
+
+Once recovery is complete, SCSI EH resumes normal operation by
+calling scsi_restart_operations(), which
+
+ 1. Checks if door locking is needed and locks door.
+
+ 2. Clears SHOST_RECOVERY shost_state bit
+
+ 3. Wakes up waiters on shost->host_wait.  This occurs if someone
+    calls scsi_block_when_processing_errors() on the host.
+    (*QUESTION* why is it needed?  All operations will be blocked
+    anyway after it reaches blk queue.)
+
+ 4. Kicks queues in all devices on the host in the asses
+
+.. _21SCSIEH:
+
+[2-1] EH through fine-grained callbacks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. _211SCSIEH:
+
+[2-1-1] Overview
+^^^^^^^^^^^^^^^^
+
+If eh_strategy_handler() is not present, SCSI midlayer takes charge
+of driving error handling.  EH's goals are two - make LLDD, host and
+device forget about timed out scmds and make them ready for new
+commands.  A scmd is said to be recovered if the scmd is forgotten by
+lower layers and lower layers are ready to process or fail the scmd
+again.
+
+To achieve these goals, EH performs recovery actions with increasing
+severity.  Some actions are performed by issuing SCSI commands and
+others are performed by invoking one of the following fine-grained
+hostt EH callbacks.  Callbacks may be omitted and omitted ones are
+considered to fail always.
+
+.. code-block:: c
+
+   int (* eh_abort_handler)(struct scsi_cmnd *);
+   int (* eh_device_reset_handler)(struct scsi_cmnd *);
+   int (* eh_bus_reset_handler)(struct scsi_cmnd *);
+   int (* eh_host_reset_handler)(struct scsi_cmnd *);
+
+Higher-severity actions are taken only when lower-severity actions
+cannot recover some of failed scmds.  Also, note that failure of the
+highest-severity action means EH failure and results in offlining of
+all unrecovered devices.
+
+ During recovery, the following rules are followed
+
+ - Recovery actions are performed on failed scmds on the to do list,
+   eh_work_q.  If a recovery action succeeds for a scmd, recovered
+   scmds are removed from eh_work_q.
+
+   Note that single recovery action on a scmd can recover multiple
+   scmds.  e.g. resetting a device recovers all failed scmds on the
+   device.
+
+ - Higher severity actions are taken iff eh_work_q is not empty after
+   lower severity actions are complete.
+
+ - EH reuses failed scmds to issue commands for recovery.  For
+   timed-out scmds, SCSI EH ensures that LLDD forgets about a scmd
+   before reusing it for EH commands.
+
+When a scmd is recovered, the scmd is moved from eh_work_q to EH
+local eh_done_q using scsi_eh_finish_cmd().  After all scmds are
+recovered (eh_work_q is empty), scsi_eh_flush_done_q() is invoked to
+either retry or error-finish (notify upper layer of failure) recovered
+scmds.
+
+scmds are retried iff its sdev is still online (not offlined during
+EH), REQ_FAILFAST is not set and ++scmd->retries is less than
+scmd->allowed.
+
+.. _212SCSIEH:
+
+[2-1-2] Flow of scmds through EH
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+ 1. Error completion / time out
+    ACTION: scsi_eh_scmd_add() is invoked for scmd
+    - add scmd to shost->eh_cmd_q
+    - set SHOST_RECOVERY
+    - shost->host_failed++
+    LOCKING: shost->host_lock
+
+ 2. EH starts
+    ACTION: move all scmds to EH's local eh_work_q.  shost->eh_cmd_q
+    is cleared.
+    LOCKING: shost->host_lock (not strictly necessary, just for
+    consistency)
+
+ 3. scmd recovered
+    ACTION: scsi_eh_finish_cmd() is invoked to EH-finish scmd
+    - scsi_setup_cmd_retry()
+    - move from local eh_work_q to local eh_done_q
+    LOCKING: none
+    CONCURRENCY: at most one thread per separate eh_work_q to
+    keep queue manipulation lockless
+
+ 4. EH completes
+    ACTION: scsi_eh_flush_done_q() retries scmds or notifies upper
+    layer of failure. May be called concurrently but must have
+    a no more than one thread per separate eh_work_q to
+    manipulate the queue locklessly
+    - scmd is removed from eh_done_q and scmd->eh_entry is cleared
+    - if retry is necessary, scmd is requeued using scsi_queue_insert()
+    - otherwise, scsi_finish_command() is invoked for scmd
+    - zero shost->host_failed
+    LOCKING: queue or finish function performs appropriate locking
+
+.. _213SCSIEH:
+
+[2-1-3] Flow of control
+^^^^^^^^^^^^^^^^^^^^^^^
+
+ EH through fine-grained callbacks start from scsi_unjam_host().
+
+<<scsi_unjam_host>>
+
+    1. Lock shost->host_lock, splice_init shost->eh_cmd_q into local
+       eh_work_q and unlock host_lock.  Note that shost->eh_cmd_q is
+       cleared by this action.
+
+    2. Invoke scsi_eh_get_sense.
+
+    <<scsi_eh_get_sense>>
+
+    This action is taken for each error-completed
+    (!SCSI_EH_CANCEL_CMD) commands without valid sense data.  Most
+    SCSI transports/LLDDs automatically acquire sense data on
+    command failures (autosense).  Autosense is recommended for
+    performance reasons and as sense information could get out of
+    sync between occurrence of CHECK CONDITION and this action.
+
+    Note that if autosense is not supported, scmd->sense_buffer
+    contains invalid sense data when error-completing the scmd
+    with scsi_done().  scsi_decide_disposition() always returns
+    FAILED in such cases thus invoking SCSI EH.  When the scmd
+    reaches here, sense data is acquired and
+    scsi_decide_disposition() is called again.
+
+    1. Invoke scsi_request_sense() which issues REQUEST_SENSE
+           command.  If fails, no action.  Note that taking no action
+           causes higher-severity recovery to be taken for the scmd.
+
+    2. Invoke scsi_decide_disposition() on the scmd
+
+       - SUCCESS
+
+        scmd->retries is set to scmd->allowed preventing
+        scsi_eh_flush_done_q() from retrying the scmd and
+        scsi_eh_finish_cmd() is invoked.
+
+       - NEEDS_RETRY
+
+        scsi_eh_finish_cmd() invoked
+
+       - otherwise
+
+        No action.
+
+    3. If !list_empty(&eh_work_q), invoke scsi_eh_abort_cmds().
+
+    <<scsi_eh_abort_cmds>>
+
+    This action is taken for each timed out command when
+    no_async_abort is enabled in the host template.
+    hostt->eh_abort_handler() is invoked for each scmd.  The
+    handler returns SUCCESS if it has succeeded to make LLDD and
+    all related hardware forget about the scmd.
+
+    If a timedout scmd is successfully aborted and the sdev is
+    either offline or ready, scsi_eh_finish_cmd() is invoked for
+    the scmd.  Otherwise, the scmd is left in eh_work_q for
+    higher-severity actions.
+
+    Note that both offline and ready status mean that the sdev is
+    ready to process new scmds, where processing also implies
+    immediate failing; thus, if a sdev is in one of the two
+    states, no further recovery action is needed.
+
+    Device readiness is tested using scsi_eh_tur() which issues
+    TEST_UNIT_READY command.  Note that the scmd must have been
+    aborted successfully before reusing it for TEST_UNIT_READY.
+
+    4. If !list_empty(&eh_work_q), invoke scsi_eh_ready_devs()
+
+    <<scsi_eh_ready_devs>>
+
+    This function takes four increasingly more severe measures to
+    make failed sdevs ready for new commands.
+
+    1. Invoke scsi_eh_stu()
+
+    <<scsi_eh_stu>>
+
+        For each sdev which has failed scmds with valid sense data
+        of which scsi_check_sense()'s verdict is FAILED,
+        START_STOP_UNIT command is issued w/ start=1.  Note that
+        as we explicitly choose error-completed scmds, it is known
+        that lower layers have forgotten about the scmd and we can
+        reuse it for STU.
+
+        If STU succeeds and the sdev is either offline or ready,
+        all failed scmds on the sdev are EH-finished with
+        scsi_eh_finish_cmd().
+
+        *NOTE* If hostt->eh_abort_handler() isn't implemented or
+        failed, we may still have timed out scmds at this point
+        and STU doesn't make lower layers forget about those
+        scmds.  Yet, this function EH-finish all scmds on the sdev
+        if STU succeeds leaving lower layers in an inconsistent
+        state.  It seems that STU action should be taken only when
+        a sdev has no timed out scmd.
+
+    2. If !list_empty(&eh_work_q), invoke scsi_eh_bus_device_reset().
+
+    <<scsi_eh_bus_device_reset>>
+
+        This action is very similar to scsi_eh_stu() except that,
+        instead of issuing STU, hostt->eh_device_reset_handler()
+        is used.  Also, as we're not issuing SCSI commands and
+        resetting clears all scmds on the sdev, there is no need
+        to choose error-completed scmds.
+
+    3. If !list_empty(&eh_work_q), invoke scsi_eh_bus_reset()
+
+    <<scsi_eh_bus_reset>>
+
+        hostt->eh_bus_reset_handler() is invoked for each channel
+        with failed scmds.  If bus reset succeeds, all failed
+        scmds on all ready or offline sdevs on the channel are
+        EH-finished.
+
+    4. If !list_empty(&eh_work_q), invoke scsi_eh_host_reset()
+
+    <<scsi_eh_host_reset>>
+
+        This is the last resort.  hostt->eh_host_reset_handler()
+        is invoked.  If host reset succeeds, all failed scmds on
+        all ready or offline sdevs on the host are EH-finished.
+
+    5. If !list_empty(&eh_work_q), invoke scsi_eh_offline_sdevs()
+
+    <<scsi_eh_offline_sdevs>>
+
+        Take all sdevs which still have unrecovered scmds offline
+        and EH-finish the scmds.
+
+    5. Invoke scsi_eh_flush_done_q().
+
+    <<scsi_eh_flush_done_q>>
+
+        At this point all scmds are recovered (or given up) and
+        put on eh_done_q by scsi_eh_finish_cmd().  This function
+        flushes eh_done_q by either retrying or notifying upper
+        layer of failure of the scmds.
+
+.. _22SCSIEH:
+
+[2-2] EH through transportt->eh_strategy_handler()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+transportt->eh_strategy_handler() is invoked in the place of
+scsi_unjam_host() and it is responsible for whole recovery process.
+On completion, the handler should have made lower layers forget about
+all failed scmds and either ready for new commands or offline.  Also,
+it should perform SCSI EH maintenance chores to maintain integrity of
+SCSI midlayer.  IOW, of the steps described in [2-1-2], all steps
+except for #1 must be implemented by eh_strategy_handler().
+
+.. _221SCSIEH:
+
+[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+ The following conditions are true on entry to the handler.
+
+ - Each failed scmd's eh_flags field is set appropriately.
+
+ - Each failed scmd is linked on scmd->eh_cmd_q by scmd->eh_entry.
+
+ - SHOST_RECOVERY is set.
+
+ - shost->host_failed == shost->host_busy
+
+.. _222SCSIEH:
+
+[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+ The following conditions must be true on exit from the handler.
+
+ - shost->host_failed is zero.
+
+ - Each scmd is in such a state that scsi_setup_cmd_retry() on the
+   scmd doesn't make any difference.
+
+ - shost->eh_cmd_q is cleared.
+
+ - Each scmd->eh_entry is cleared.
+
+ - Either scsi_queue_insert() or scsi_finish_command() is called on
+   each scmd.  Note that the handler is free to use scmd->retries and
+   ->allowed to limit the number of retries.
+
+.. _223SCSIEH:
+
+[2-2-3] Things to consider
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+ - Know that timed out scmds are still active on lower layers.  Make
+   lower layers forget about them before doing anything else with
+   those scmds.
+
+ - For consistency, when accessing/modifying shost data structure,
+   grab shost->host_lock.
+
+ - On completion, each failed sdev must have forgotten about all
+   active scmds.
+
+ - On completion, each failed sdev must be ready for new commands or
+   offline.
+
+
+--
+Tejun Heo
+htejun@gmail.com
+11th September 2005
diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
deleted file mode 100644
index 1b7436932a2b..000000000000
--- a/Documentation/scsi/scsi_eh.txt
+++ /dev/null
@@ -1,475 +0,0 @@
-
-SCSI EH
-======================================
-
- This document describes SCSI midlayer error handling infrastructure.
-Please refer to Documentation/scsi/scsi_mid_low_api.txt for more
-information regarding SCSI midlayer.
-
-TABLE OF CONTENTS
-
-[1] How SCSI commands travel through the midlayer and to EH
-    [1-1] struct scsi_cmnd
-    [1-2] How do scmd's get completed?
-	[1-2-1] Completing a scmd w/ scsi_done
-	[1-2-2] Completing a scmd w/ timeout
-    [1-3] How EH takes over
-[2] How SCSI EH works
-    [2-1] EH through fine-grained callbacks
-	[2-1-1] Overview
-	[2-1-2] Flow of scmds through EH
-	[2-1-3] Flow of control
-    [2-2] EH through transportt->eh_strategy_handler()
-	[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
-	[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
-	[2-2-3] Things to consider
-
-
-[1] How SCSI commands travel through the midlayer and to EH
-
-[1-1] struct scsi_cmnd
-
- Each SCSI command is represented with struct scsi_cmnd (== scmd).  A
-scmd has two list_head's to link itself into lists.  The two are
-scmd->list and scmd->eh_entry.  The former is used for free list or
-per-device allocated scmd list and not of much interest to this EH
-discussion.  The latter is used for completion and EH lists and unless
-otherwise stated scmds are always linked using scmd->eh_entry in this
-discussion.
-
-
-[1-2] How do scmd's get completed?
-
- Once LLDD gets hold of a scmd, either the LLDD will complete the
-command by calling scsi_done callback passed from midlayer when
-invoking hostt->queuecommand() or the block layer will time it out.
-
-
-[1-2-1] Completing a scmd w/ scsi_done
-
- For all non-EH commands, scsi_done() is the completion callback.  It
-just calls blk_complete_request() to delete the block layer timer and
-raise SCSI_SOFTIRQ
-
- SCSI_SOFTIRQ handler scsi_softirq calls scsi_decide_disposition() to
-determine what to do with the command.  scsi_decide_disposition()
-looks at the scmd->result value and sense data to determine what to do
-with the command.
-
- - SUCCESS
-	scsi_finish_command() is invoked for the command.  The
-	function does some maintenance chores and then calls
-	scsi_io_completion() to finish the I/O.
-	scsi_io_completion() then notifies the block layer on
-	the completed request by calling blk_end_request and
-	friends or figures out what to do with the remainder
-	of the data in case of an error.
-
- - NEEDS_RETRY
- - ADD_TO_MLQUEUE
-	scmd is requeued to blk queue.
-
- - otherwise
-	scsi_eh_scmd_add(scmd) is invoked for the command.  See
-	[1-3] for details of this function.
-
-
-[1-2-2] Completing a scmd w/ timeout
-
- The timeout handler is scsi_times_out().  When a timeout occurs, this
-function
-
- 1. invokes optional hostt->eh_timed_out() callback.  Return value can
-    be one of
-
-    - BLK_EH_RESET_TIMER
-	This indicates that more time is required to finish the
-	command.  Timer is restarted.  This action is counted as a
-	retry and only allowed scmd->allowed + 1(!) times.  Once the
-	limit is reached, action for BLK_EH_DONE is taken instead.
-
-    - BLK_EH_DONE
-        eh_timed_out() callback did not handle the command.
-	Step #2 is taken.
-
- 2. scsi_abort_command() is invoked to schedule an asynchrous abort.
-    Asynchronous abort are not invoked for commands which the
-    SCSI_EH_ABORT_SCHEDULED flag is set (this indicates that the command
-    already had been aborted once, and this is a retry which failed),
-    or when the EH deadline is expired. In these case Step #3 is taken.
-
- 3. scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD) is invoked for the
-    command.  See [1-4] for more information.
-
-[1-3] Asynchronous command aborts
-
- After a timeout occurs a command abort is scheduled from
- scsi_abort_command(). If the abort is successful the command
- will either be retried (if the number of retries is not exhausted)
- or terminated with DID_TIME_OUT.
- Otherwise scsi_eh_scmd_add() is invoked for the command.
- See [1-4] for more information.
-
-[1-4] How EH takes over
-
- scmds enter EH via scsi_eh_scmd_add(), which does the following.
-
- 1. Links scmd->eh_entry to shost->eh_cmd_q
-
- 2. Sets SHOST_RECOVERY bit in shost->shost_state
-
- 3. Increments shost->host_failed
-
- 4. Wakes up SCSI EH thread if shost->host_busy == shost->host_failed
-
- As can be seen above, once any scmd is added to shost->eh_cmd_q,
-SHOST_RECOVERY shost_state bit is turned on.  This prevents any new
-scmd to be issued from blk queue to the host; eventually, all scmds on
-the host either complete normally, fail and get added to eh_cmd_q, or
-time out and get added to shost->eh_cmd_q.
-
- If all scmds either complete or fail, the number of in-flight scmds
-becomes equal to the number of failed scmds - i.e. shost->host_busy ==
-shost->host_failed.  This wakes up SCSI EH thread.  So, once woken up,
-SCSI EH thread can expect that all in-flight commands have failed and
-are linked on shost->eh_cmd_q.
-
- Note that this does not mean lower layers are quiescent.  If a LLDD
-completed a scmd with error status, the LLDD and lower layers are
-assumed to forget about the scmd at that point.  However, if a scmd
-has timed out, unless hostt->eh_timed_out() made lower layers forget
-about the scmd, which currently no LLDD does, the command is still
-active as long as lower layers are concerned and completion could
-occur at any time.  Of course, all such completions are ignored as the
-timer has already expired.
-
- We'll talk about how SCSI EH takes actions to abort - make LLDD
-forget about - timed out scmds later.
-
-
-[2] How SCSI EH works
-
- LLDD's can implement SCSI EH actions in one of the following two
-ways.
-
- - Fine-grained EH callbacks
-	LLDD can implement fine-grained EH callbacks and let SCSI
-	midlayer drive error handling and call appropriate callbacks.
-	This will be discussed further in [2-1].
-
- - eh_strategy_handler() callback
-	This is one big callback which should perform whole error
-	handling.  As such, it should do all chores the SCSI midlayer
-	performs during recovery.  This will be discussed in [2-2].
-
- Once recovery is complete, SCSI EH resumes normal operation by
-calling scsi_restart_operations(), which
-
- 1. Checks if door locking is needed and locks door.
-
- 2. Clears SHOST_RECOVERY shost_state bit
-
- 3. Wakes up waiters on shost->host_wait.  This occurs if someone
-    calls scsi_block_when_processing_errors() on the host.
-    (*QUESTION* why is it needed?  All operations will be blocked
-    anyway after it reaches blk queue.)
-
- 4. Kicks queues in all devices on the host in the asses
-
-
-[2-1] EH through fine-grained callbacks
-
-[2-1-1] Overview
-
- If eh_strategy_handler() is not present, SCSI midlayer takes charge
-of driving error handling.  EH's goals are two - make LLDD, host and
-device forget about timed out scmds and make them ready for new
-commands.  A scmd is said to be recovered if the scmd is forgotten by
-lower layers and lower layers are ready to process or fail the scmd
-again.
-
- To achieve these goals, EH performs recovery actions with increasing
-severity.  Some actions are performed by issuing SCSI commands and
-others are performed by invoking one of the following fine-grained
-hostt EH callbacks.  Callbacks may be omitted and omitted ones are
-considered to fail always.
-
-int (* eh_abort_handler)(struct scsi_cmnd *);
-int (* eh_device_reset_handler)(struct scsi_cmnd *);
-int (* eh_bus_reset_handler)(struct scsi_cmnd *);
-int (* eh_host_reset_handler)(struct scsi_cmnd *);
-
- Higher-severity actions are taken only when lower-severity actions
-cannot recover some of failed scmds.  Also, note that failure of the
-highest-severity action means EH failure and results in offlining of
-all unrecovered devices.
-
- During recovery, the following rules are followed
-
- - Recovery actions are performed on failed scmds on the to do list,
-   eh_work_q.  If a recovery action succeeds for a scmd, recovered
-   scmds are removed from eh_work_q.
-
-   Note that single recovery action on a scmd can recover multiple
-   scmds.  e.g. resetting a device recovers all failed scmds on the
-   device.
-
- - Higher severity actions are taken iff eh_work_q is not empty after
-   lower severity actions are complete.
-
- - EH reuses failed scmds to issue commands for recovery.  For
-   timed-out scmds, SCSI EH ensures that LLDD forgets about a scmd
-   before reusing it for EH commands.
-
- When a scmd is recovered, the scmd is moved from eh_work_q to EH
-local eh_done_q using scsi_eh_finish_cmd().  After all scmds are
-recovered (eh_work_q is empty), scsi_eh_flush_done_q() is invoked to
-either retry or error-finish (notify upper layer of failure) recovered
-scmds.
-
- scmds are retried iff its sdev is still online (not offlined during
-EH), REQ_FAILFAST is not set and ++scmd->retries is less than
-scmd->allowed.
-
-
-[2-1-2] Flow of scmds through EH
-
- 1. Error completion / time out
-    ACTION: scsi_eh_scmd_add() is invoked for scmd
-	- add scmd to shost->eh_cmd_q
-	- set SHOST_RECOVERY
-	- shost->host_failed++
-    LOCKING: shost->host_lock
-
- 2. EH starts
-    ACTION: move all scmds to EH's local eh_work_q.  shost->eh_cmd_q
-	    is cleared.
-    LOCKING: shost->host_lock (not strictly necessary, just for
-             consistency)
-
- 3. scmd recovered
-    ACTION: scsi_eh_finish_cmd() is invoked to EH-finish scmd
-	- scsi_setup_cmd_retry()
-	- move from local eh_work_q to local eh_done_q
-    LOCKING: none
-    CONCURRENCY: at most one thread per separate eh_work_q to
-		 keep queue manipulation lockless
-
- 4. EH completes
-    ACTION: scsi_eh_flush_done_q() retries scmds or notifies upper
-	    layer of failure. May be called concurrently but must have
-	    a no more than one thread per separate eh_work_q to
-	    manipulate the queue locklessly
-	- scmd is removed from eh_done_q and scmd->eh_entry is cleared
-	- if retry is necessary, scmd is requeued using
-          scsi_queue_insert()
-	- otherwise, scsi_finish_command() is invoked for scmd
-	- zero shost->host_failed
-    LOCKING: queue or finish function performs appropriate locking
-
-
-[2-1-3] Flow of control
-
- EH through fine-grained callbacks start from scsi_unjam_host().
-
-<<scsi_unjam_host>>
-
-    1. Lock shost->host_lock, splice_init shost->eh_cmd_q into local
-       eh_work_q and unlock host_lock.  Note that shost->eh_cmd_q is
-       cleared by this action.
-
-    2. Invoke scsi_eh_get_sense.
-
-    <<scsi_eh_get_sense>>
-
-	This action is taken for each error-completed
-	(!SCSI_EH_CANCEL_CMD) commands without valid sense data.  Most
-	SCSI transports/LLDDs automatically acquire sense data on
-	command failures (autosense).  Autosense is recommended for
-	performance reasons and as sense information could get out of
-	sync between occurrence of CHECK CONDITION and this action.
-
-	Note that if autosense is not supported, scmd->sense_buffer
-	contains invalid sense data when error-completing the scmd
-	with scsi_done().  scsi_decide_disposition() always returns
-	FAILED in such cases thus invoking SCSI EH.  When the scmd
-	reaches here, sense data is acquired and
-	scsi_decide_disposition() is called again.
-
-	1. Invoke scsi_request_sense() which issues REQUEST_SENSE
-           command.  If fails, no action.  Note that taking no action
-           causes higher-severity recovery to be taken for the scmd.
-
-	2. Invoke scsi_decide_disposition() on the scmd
-
-	   - SUCCESS
-		scmd->retries is set to scmd->allowed preventing
-		scsi_eh_flush_done_q() from retrying the scmd and
-		scsi_eh_finish_cmd() is invoked.
-
-	   - NEEDS_RETRY
-		scsi_eh_finish_cmd() invoked
-
-	   - otherwise
-		No action.
-
-    3. If !list_empty(&eh_work_q), invoke scsi_eh_abort_cmds().
-
-    <<scsi_eh_abort_cmds>>
-
-	This action is taken for each timed out command when
-	no_async_abort is enabled in the host template.
-	hostt->eh_abort_handler() is invoked for each scmd.  The
-	handler returns SUCCESS if it has succeeded to make LLDD and
-	all related hardware forget about the scmd.
-
-	If a timedout scmd is successfully aborted and the sdev is
-	either offline or ready, scsi_eh_finish_cmd() is invoked for
-	the scmd.  Otherwise, the scmd is left in eh_work_q for
-	higher-severity actions.
-
-	Note that both offline and ready status mean that the sdev is
-	ready to process new scmds, where processing also implies
-	immediate failing; thus, if a sdev is in one of the two
-	states, no further recovery action is needed.
-
-	Device readiness is tested using scsi_eh_tur() which issues
-	TEST_UNIT_READY command.  Note that the scmd must have been
-	aborted successfully before reusing it for TEST_UNIT_READY.
-
-    4. If !list_empty(&eh_work_q), invoke scsi_eh_ready_devs()
-
-    <<scsi_eh_ready_devs>>
-
-	This function takes four increasingly more severe measures to
-	make failed sdevs ready for new commands.
-
-	1. Invoke scsi_eh_stu()
-
-	<<scsi_eh_stu>>
-
-	    For each sdev which has failed scmds with valid sense data
-	    of which scsi_check_sense()'s verdict is FAILED,
-	    START_STOP_UNIT command is issued w/ start=1.  Note that
-	    as we explicitly choose error-completed scmds, it is known
-	    that lower layers have forgotten about the scmd and we can
-	    reuse it for STU.
-
-	    If STU succeeds and the sdev is either offline or ready,
-	    all failed scmds on the sdev are EH-finished with
-	    scsi_eh_finish_cmd().
-
-	    *NOTE* If hostt->eh_abort_handler() isn't implemented or
-	    failed, we may still have timed out scmds at this point
-	    and STU doesn't make lower layers forget about those
-	    scmds.  Yet, this function EH-finish all scmds on the sdev
-	    if STU succeeds leaving lower layers in an inconsistent
-	    state.  It seems that STU action should be taken only when
-	    a sdev has no timed out scmd.
-
-	2. If !list_empty(&eh_work_q), invoke scsi_eh_bus_device_reset().
-
-	<<scsi_eh_bus_device_reset>>
-
-	    This action is very similar to scsi_eh_stu() except that,
-	    instead of issuing STU, hostt->eh_device_reset_handler()
-	    is used.  Also, as we're not issuing SCSI commands and
-	    resetting clears all scmds on the sdev, there is no need
-	    to choose error-completed scmds.
-
-	3. If !list_empty(&eh_work_q), invoke scsi_eh_bus_reset()
-
-	<<scsi_eh_bus_reset>>
-
-	    hostt->eh_bus_reset_handler() is invoked for each channel
-	    with failed scmds.  If bus reset succeeds, all failed
-	    scmds on all ready or offline sdevs on the channel are
-	    EH-finished.
-
-	4. If !list_empty(&eh_work_q), invoke scsi_eh_host_reset()
-
-	<<scsi_eh_host_reset>>
-
-	    This is the last resort.  hostt->eh_host_reset_handler()
-	    is invoked.  If host reset succeeds, all failed scmds on
-	    all ready or offline sdevs on the host are EH-finished.
-
-	5. If !list_empty(&eh_work_q), invoke scsi_eh_offline_sdevs()
-
-	<<scsi_eh_offline_sdevs>>
-
-	    Take all sdevs which still have unrecovered scmds offline
-	    and EH-finish the scmds.
-
-    5. Invoke scsi_eh_flush_done_q().
-
-	<<scsi_eh_flush_done_q>>
-
-	    At this point all scmds are recovered (or given up) and
-	    put on eh_done_q by scsi_eh_finish_cmd().  This function
-	    flushes eh_done_q by either retrying or notifying upper
-	    layer of failure of the scmds.
-
-
-[2-2] EH through transportt->eh_strategy_handler()
-
- transportt->eh_strategy_handler() is invoked in the place of
-scsi_unjam_host() and it is responsible for whole recovery process.
-On completion, the handler should have made lower layers forget about
-all failed scmds and either ready for new commands or offline.  Also,
-it should perform SCSI EH maintenance chores to maintain integrity of
-SCSI midlayer.  IOW, of the steps described in [2-1-2], all steps
-except for #1 must be implemented by eh_strategy_handler().
-
-
-[2-2-1] Pre transportt->eh_strategy_handler() SCSI midlayer conditions
-
- The following conditions are true on entry to the handler.
-
- - Each failed scmd's eh_flags field is set appropriately.
-
- - Each failed scmd is linked on scmd->eh_cmd_q by scmd->eh_entry.
-
- - SHOST_RECOVERY is set.
-
- - shost->host_failed == shost->host_busy
-
-
-[2-2-2] Post transportt->eh_strategy_handler() SCSI midlayer conditions
-
- The following conditions must be true on exit from the handler.
-
- - shost->host_failed is zero.
-
- - Each scmd is in such a state that scsi_setup_cmd_retry() on the
-   scmd doesn't make any difference.
-
- - shost->eh_cmd_q is cleared.
-
- - Each scmd->eh_entry is cleared.
-
- - Either scsi_queue_insert() or scsi_finish_command() is called on
-   each scmd.  Note that the handler is free to use scmd->retries and
-   ->allowed to limit the number of retries.
-
-
-[2-2-3] Things to consider
-
- - Know that timed out scmds are still active on lower layers.  Make
-   lower layers forget about them before doing anything else with
-   those scmds.
-
- - For consistency, when accessing/modifying shost data structure,
-   grab shost->host_lock.
-
- - On completion, each failed sdev must have forgotten about all
-   active scmds.
-
- - On completion, each failed sdev must be ready for new commands or
-   offline.
-
-
---
-Tejun Heo
-htejun@gmail.com
-11th September 2005
diff --git a/Documentation/scsi/scsi_fc_transport.txt b/Documentation/scsi/scsi_fc_transport.rst
similarity index 93%
rename from Documentation/scsi/scsi_fc_transport.txt
rename to Documentation/scsi/scsi_fc_transport.rst
index f79282fc48d7..a3c928bee01b 100644
--- a/Documentation/scsi/scsi_fc_transport.txt
+++ b/Documentation/scsi/scsi_fc_transport.rst
@@ -1,18 +1,21 @@
-                             SCSI FC Tansport
-                 =============================================
+SCSI FC Tansport
+=============================================
 
 Date:  11/18/2008
 Kernel Revisions for features:
+
   rports : <<TBS>>
   vports : 2.6.22
   bsg support : 2.6.30 (?TBD?)
 
 
 Introduction
-============
+------------
 This file documents the features and components of the SCSI FC Transport.
 It also provides documents the API between the transport and FC LLDDs.
 The FC transport can be found at:
+::
+
   drivers/scsi/scsi_transport_fc.c
   include/scsi/scsi_transport_fc.h
   include/scsi/scsi_netlink_fc.h
@@ -22,15 +25,15 @@ This file is found at Documentation/scsi/scsi_fc_transport.txt
 
 
 FC Remote Ports (rports)
-========================================================================
+------------------------
 << To Be Supplied >>
 
 
 FC Virtual Ports (vports)
-========================================================================
+-------------------------
 
 Overview:
--------------------------------
+~~~~~~~~~
 
   New FC standards have defined mechanisms which allows for a single physical
   port to appear on as multiple communication ports. Using the N_Port Id
@@ -75,7 +78,7 @@ Overview:
 
 
 Device Trees and Vport Objects:
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   Today, the device tree typically contains the scsi_host object,
   with rports and scsi target objects underneath it. Currently the FC
@@ -117,7 +120,7 @@ Device Trees and Vport Objects:
 
 
 Vport Attributes:
--------------------------------
+~~~~~~~~~~~~~~~~~
 
   The new fc_vport class object has the following attributes
 
@@ -185,7 +188,7 @@ Vport Attributes:
 
 
 Vport States:
--------------------------------
+~~~~~~~~~~~~~
 
   Vport instantiation consists of two parts:
     - Creation with the kernel and LLDD. This means all transport and
@@ -194,6 +197,7 @@ Vport States:
       independent of the adapter's link state.
     - Instantiation of the vport on the FC link via ELS traffic, etc.
       This is equivalent to a "link up" and successful link initialization.
+
   Further information can be found in the interfaces section below for
   Vport Creation.
 
@@ -227,6 +231,7 @@ Vport States:
     FC_VPORT_NO_FABRIC_SUPP     - No Fabric Support
       The vport is not operational. One of the following conditions were
       encountered:
+
        - The FC topology is not Point-to-Point
        - The FC port is not connected to an F_Port
        - The F_Port has indicated that NPIV is not supported.
@@ -251,7 +256,9 @@ Vport States:
 
   The following state table indicates the different state transitions:
 
-    State              Event                            New State
+::
+
+   State              Event                            New State
     --------------------------------------------------------------------
      n/a                Initialization                  Unknown
     Unknown:            Link Down                       Linkdown
@@ -286,7 +293,7 @@ Vport States:
 
 
 Transport <-> LLDD Interfaces :
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Vport support by LLDD:
 
@@ -302,6 +309,8 @@ Vport Creation:
 
   The LLDD vport_create() syntax is:
 
+::
+
       int vport_create(struct fc_vport *vport, bool disable)
 
     where:
@@ -375,8 +384,11 @@ Vport Disable/Enable:
 
   The LLDD vport_disable() syntax is:
 
+::
+
       int vport_disable(struct fc_vport *vport, bool disable)
 
+
     where:
       vport:    Is vport to be enabled or disabled
       disable:  If "true", the vport is to be disabled.
@@ -403,6 +415,8 @@ Vport Deletion:
 
   The LLDD vport_delete() syntax is:
 
+::
+
       int vport_delete(struct fc_vport *vport)
 
     where:
@@ -439,7 +453,7 @@ Other:
 
 
 Transport supplied functions
-----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The following functions are supplied by the FC-transport for use by LLDs.
 
@@ -448,34 +462,38 @@ The following functions are supplied by the FC-transport for use by LLDs.
 
 Details:
 
-/**
- * fc_vport_create - Admin App or LLDD requests creation of a vport
- * @shost:     scsi host the virtual port is connected to.
- * @ids:       The world wide names, FC4 port roles, etc for
- *              the virtual port.
- *
- * Notes:
- *     This routine assumes no locks are held on entry.
- */
-struct fc_vport *
-fc_vport_create(struct Scsi_Host *shost, struct fc_vport_identifiers *ids)
-
-/**
- * fc_vport_terminate - Admin App or LLDD requests termination of a vport
- * @vport:      fc_vport to be terminated
- *
- * Calls the LLDD vport_delete() function, then deallocates and removes
- * the vport from the shost and object tree.
- *
- * Notes:
- *      This routine assumes no locks are held on entry.
- */
-int
-fc_vport_terminate(struct fc_vport *vport)
+.. code-block:: c
+
+  /**
+   * fc_vport_create - Admin App or LLDD requests creation of a vport
+   * @shost:     scsi host the virtual port is connected to.
+   * @ids:       The world wide names, FC4 port roles, etc for
+   *              the virtual port.
+   *
+   * Notes:
+   *     This routine assumes no locks are held on entry.
+   */
+  struct fc_vport *
+  fc_vport_create(struct Scsi_Host *shost, struct fc_vport_identifiers *ids)
+
+.. code-block:: c
+
+  /**
+   * fc_vport_terminate - Admin App or LLDD requests termination of a vport
+   * @vport:      fc_vport to be terminated
+   *
+   * Calls the LLDD vport_delete() function, then deallocates and removes
+   * the vport from the shost and object tree.
+   *
+   * Notes:
+   *      This routine assumes no locks are held on entry.
+   */
+  int
+  fc_vport_terminate(struct fc_vport *vport)
 
 
 FC BSG support (CT & ELS passthru, and more)
-========================================================================
+--------------------------------------------
 << To Be Supplied >>
 
 
@@ -483,7 +501,7 @@ FC BSG support (CT & ELS passthru, and more)
 
 
 Credits
-=======
+-------
 The following people have contributed to this document:
 
 
diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
new file mode 100644
index 000000000000..00933e31cbaf
--- /dev/null
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -0,0 +1,1357 @@
+Linux Kernel 2.6 series SCSI mid_level - lower_level driver interface
+=====================================================================
+
+Introduction
+------------
+This document outlines the interface between the Linux SCSI mid level and
+SCSI lower level drivers. Lower level drivers (LLDs) are variously called
+host bus adapter (HBA) drivers and host drivers (HD). A "host" in this
+context is a bridge between a computer IO bus (e.g. PCI or ISA) and a
+single SCSI initiator port on a SCSI transport. An "initiator" port
+(SCSI terminology, see SAM-3 at http://www.t10.org) sends SCSI commands
+to "target" SCSI ports (e.g. disks). There can be many LLDs in a running
+system, but only one per hardware type. Most LLDs can control one or more
+SCSI HBAs. Some HBAs contain multiple hosts.
+
+In some cases the SCSI transport is an external bus that already has
+its own subsystem in Linux (e.g. USB and ieee1394). In such cases the
+SCSI subsystem LLD is a software bridge to the other driver subsystem.
+Examples are the usb-storage driver (found in the drivers/usb/storage
+directory) and the ieee1394/sbp2 driver (found in the drivers/ieee1394
+directory).
+
+For example, the aic7xxx LLD controls Adaptec SCSI parallel interface
+(SPI) controllers based on that company's 7xxx chip series. The aic7xxx
+LLD can be built into the kernel or loaded as a module. There can only be
+one aic7xxx LLD running in a Linux system but it may be controlling many
+HBAs. These HBAs might be either on PCI daughter-boards or built into
+the motherboard (or both). Some aic7xxx based HBAs are dual controllers
+and thus represent two hosts. Like most modern HBAs, each aic7xxx host
+has its own PCI device address. [The one-to-one correspondence between
+a SCSI host and a PCI device is common but not required (e.g. with
+ISA adapters).]
+
+The SCSI mid level isolates an LLD from other layers such as the SCSI
+upper layer drivers and the block layer.
+
+This version of the document roughly matches linux kernel version 2.6.8 .
+
+Documentation
+-------------
+There is a SCSI documentation directory within the kernel source tree,
+typically Documentation/scsi . Most documents are in plain
+(i.e. ASCII) text. This file is named scsi_mid_low_api.txt and can be
+found in that directory. A more recent copy of this document may be found
+at http://web.archive.org/web/20070107183357rn_1/sg.torque.net/scsi/.
+Many LLDs are documented there (e.g. aic7xxx.txt). The SCSI mid-level is
+briefly described in scsi.txt which contains a url to a document
+describing the SCSI subsystem in the lk 2.4 series. Two upper level
+drivers have documents in that directory: st.txt (SCSI tape driver) and
+scsi-generic.txt (for the sg driver).
+
+Some documentation (or urls) for LLDs may be found in the C source code
+or in the same directory as the C source code. For example to find a url
+about the USB mass storage driver see the
+/usr/src/linux/drivers/usb/storage directory.
+
+Driver structure
+----------------
+Traditionally an LLD for the SCSI subsystem has been at least two files in
+the drivers/scsi directory. For example, a driver called "xyz" has a header
+file "xyz.h" and a source file "xyz.c". [Actually there is no good reason
+why this couldn't all be in one file; the header file is superfluous.] Some
+drivers that have been ported to several operating systems have more than
+two files. For example the aic7xxx driver has separate files for generic
+and OS-specific code (e.g. FreeBSD and Linux). Such drivers tend to have
+their own directory under the drivers/scsi directory.
+
+When a new LLD is being added to Linux, the following files (found in the
+drivers/scsi directory) will need some attention: Makefile and Kconfig .
+It is probably best to study how existing LLDs are organized.
+
+As the 2.5 series development kernels evolve into the 2.6 series
+production series, changes are being introduced into this interface. An
+example of this is driver initialization code where there are now 2 models
+available. The older one, similar to what was found in the lk 2.4 series,
+is based on hosts that are detected at HBA driver load time. This will be
+referred to the "passive" initialization model. The newer model allows HBAs
+to be hot plugged (and unplugged) during the lifetime of the LLD and will
+be referred to as the "hotplug" initialization model. The newer model is
+preferred as it can handle both traditional SCSI equipment that is
+permanently connected as well as modern "SCSI" devices (e.g. USB or
+IEEE 1394 connected digital cameras) that are hotplugged. Both
+initialization models are discussed in the following sections.
+
+An LLD interfaces to the SCSI subsystem several ways:
+  a) directly invoking functions supplied by the mid level
+  b) passing a set of function pointers to a registration function
+     supplied by the mid level. The mid level will then invoke these
+     functions at some point in the future. The LLD will supply
+     implementations of these functions.
+  c) direct access to instances of well known data structures maintained
+     by the mid level
+
+Those functions in group a) are listed in a section entitled "Mid level
+supplied functions" below.
+
+Those functions in group b) are listed in a section entitled "Interface
+functions" below. Their function pointers are placed in the members of
+"struct scsi_host_template", an instance of which is passed to
+scsi_host_alloc() ** .  Those interface functions that the LLD does not
+wish to supply should have NULL placed in the corresponding member of
+struct scsi_host_template.  Defining an instance of struct
+scsi_host_template at file scope will cause NULL to be  placed in function
+pointer members not explicitly initialized.
+
+Those usages in group c) should be handled with care, especially in a
+"hotplug" environment. LLDs should be aware of the lifetime of instances
+that are shared with the mid level and other layers.
+
+All functions defined within an LLD and all data defined at file scope
+should be static. For example the slave_alloc() function in an LLD
+called "xxx" could be defined as
+
+.. code-block:: c
+
+   "static int xxx_slave_alloc(struct scsi_device * sdev) { /* code */ }"
+
+** the scsi_host_alloc() function is a replacement for the rather vaguely
+named scsi_register() function in most situations.
+
+
+Hotplug initialization model
+----------------------------
+In this model an LLD controls when SCSI hosts are introduced and removed
+from the SCSI subsystem. Hosts can be introduced as early as driver
+initialization and removed as late as driver shutdown. Typically a driver
+will respond to a sysfs probe() callback that indicates an HBA has been
+detected. After confirming that the new device is one that the LLD wants
+to control, the LLD will initialize the HBA and then register a new host
+with the SCSI mid level.
+
+During LLD initialization the driver should register itself with the
+appropriate IO bus on which it expects to find HBA(s) (e.g. the PCI bus).
+This can probably be done via sysfs. Any driver parameters (especially
+those that are writable after the driver is loaded) could also be
+registered with sysfs at this point. The SCSI mid level first becomes
+aware of an LLD when that LLD registers its first HBA.
+
+At some later time, the LLD becomes aware of an HBA and what follows
+is a typical sequence of calls between the LLD and the mid level.
+This example shows the mid level scanning the newly introduced HBA for 3
+scsi devices of which only the first 2 respond:
+
+::
+
+        HBA PROBE: assume 2 SCSI devices found in scan
+   LLD                   mid level                    LLD
+   ===-------------------=========--------------------===------
+   scsi_host_alloc()  -->
+   scsi_add_host()  ---->
+   scsi_scan_host()  -------+
+                            |
+                       slave_alloc()
+                       slave_configure() -->  scsi_change_queue_depth()
+                            |
+                       slave_alloc()
+                       slave_configure()
+                            |
+                       slave_alloc()   ***
+                       slave_destroy() ***
+   ------------------------------------------------------------
+
+If the LLD wants to adjust the default queue settings, it can invoke
+scsi_change_queue_depth() in its slave_configure() routine.
+
+.. code-block:: text
+
+   *** For scsi devices that the mid level tries to scan but do not
+       respond, a slave_alloc(), slave_destroy() pair is called.
+
+When an HBA is being removed it could be as part of an orderly shutdown
+associated with the LLD module being unloaded (e.g. with the "rmmod"
+command) or in response to a "hot unplug" indicated by sysfs()'s
+remove() callback being invoked. In either case, the sequence is the
+same:
+
+::
+
+           HBA REMOVE: assume 2 SCSI devices attached
+   LLD                      mid level                 LLD
+   ===----------------------=========-----------------===------
+   scsi_remove_host() ---------+
+                               |
+                        slave_destroy()
+                        slave_destroy()
+   scsi_host_put()
+   ------------------------------------------------------------
+
+It may be useful for a LLD to keep track of struct Scsi_Host instances
+(a pointer is returned by scsi_host_alloc()). Such instances are "owned"
+by the mid-level.  struct Scsi_Host instances are freed from
+scsi_host_put() when the reference count hits zero.
+
+Hot unplugging an HBA that controls a disk which is processing SCSI
+commands on a mounted file system is an interesting situation. Reference
+counting logic is being introduced into the mid level to cope with many
+of the issues involved. See the section on reference counting below.
+
+
+The hotplug concept may be extended to SCSI devices. Currently, when an
+HBA is added, the scsi_scan_host() function causes a scan for SCSI devices
+attached to the HBA's SCSI transport. On newer SCSI transports the HBA
+may become aware of a new SCSI device _after_ the scan has completed.
+An LLD can use this sequence to make the mid level aware of a SCSI device:
+
+::
+
+                    SCSI DEVICE hotplug
+   LLD                   mid level                    LLD
+   ===-------------------=========--------------------===------
+   scsi_add_device()  ------+
+                            |
+                       slave_alloc()
+                       slave_configure()   [--> scsi_change_queue_depth()]
+   ------------------------------------------------------------
+
+In a similar fashion, an LLD may become aware that a SCSI device has been
+removed (unplugged) or the connection to it has been interrupted. Some
+existing SCSI transports (e.g. SPI) may not become aware that a SCSI
+device has been removed until a subsequent SCSI command fails which will
+probably cause that device to be set offline by the mid level. An LLD that
+detects the removal of a SCSI device can instigate its removal from
+upper layers with this sequence:
+
+::
+
+                     SCSI DEVICE hot unplug
+   LLD                      mid level                 LLD
+   ===----------------------=========-----------------===------
+   scsi_remove_device() -------+
+                               |
+                        slave_destroy()
+   ------------------------------------------------------------
+
+It may be useful for an LLD to keep track of struct scsi_device instances
+(a pointer is passed as the parameter to slave_alloc() and
+slave_configure() callbacks). Such instances are "owned" by the mid-level.
+struct scsi_device instances are freed after slave_destroy().
+
+
+Reference Counting
+------------------
+The Scsi_Host structure has had reference counting infrastructure added.
+This effectively spreads the ownership of struct Scsi_Host instances
+across the various SCSI layers which use them. Previously such instances
+were exclusively owned by the mid level. LLDs would not usually need to
+directly manipulate these reference counts but there may be some cases
+where they do.
+
+There are 3 reference counting functions of interest associated with
+struct Scsi_Host:
+
+  - scsi_host_alloc(): returns a pointer to new instance of struct
+    Scsi_Host which has its reference count ^^ set to 1
+  - scsi_host_get(): adds 1 to the reference count of the given instance
+  - scsi_host_put(): decrements 1 from the reference count of the given
+    instance. If the reference count reaches 0 then the given instance
+    is freed
+
+The scsi_device structure has had reference counting infrastructure added.
+This effectively spreads the ownership of struct scsi_device instances
+across the various SCSI layers which use them. Previously such instances
+were exclusively owned by the mid level. See the access functions declared
+towards the end of include/scsi/scsi_device.h . If an LLD wants to keep
+a copy of a pointer to a scsi_device instance it should use scsi_device_get()
+to bump its reference count. When it is finished with the pointer it can
+use scsi_device_put() to decrement its reference count (and potentially
+delete it).
+
+^^ struct Scsi_Host actually has 2 reference counts which are manipulated
+in parallel by these functions.
+
+Conventions
+-----------
+First, Linus Torvalds's thoughts on C coding style can be found in the
+Documentation/process/coding-style.rst file.
+
+Next, there is a movement to "outlaw" typedefs introducing synonyms for
+struct tags. Both can be still found in the SCSI subsystem, but
+the typedefs have been moved to a single file, scsi_typedefs.h to
+make their future removal easier, for example:
+"typedef struct scsi_cmnd Scsi_Cmnd;"
+
+Also, most C99 enhancements are encouraged to the extent they are supported
+by the relevant gcc compilers. So C99 style structure and array
+initializers are encouraged where appropriate. Don't go too far,
+VLAs are not properly supported yet.  An exception to this is the use of
+"//" style comments; /*...*/ comments are still preferred in Linux.
+
+Well written, tested and documented code, need not be re-formatted to
+comply with the above conventions. For example, the aic7xxx driver
+comes to Linux from FreeBSD and Adaptec's own labs. No doubt FreeBSD
+and Adaptec have their own coding conventions.
+
+
+Mid level supplied functions
+----------------------------
+
+These functions are supplied by the SCSI mid level for use by LLDs.
+The names (i.e. entry points) of these functions are exported
+so an LLD that is a module can access them. The kernel will
+arrange for the SCSI mid level to be loaded and initialized before any LLD
+is initialized. The functions below are listed alphabetically and their
+names all start with "scsi\_".
+
+::
+
+   Summary:
+      scsi_add_device - creates new scsi device (lu) instance
+      scsi_add_host - perform sysfs registration and set up transport class
+      scsi_change_queue_depth - change the queue depth on a SCSI device
+      scsi_bios_ptable - return copy of block device's partition table
+      scsi_block_requests - prevent further commands being queued to given host
+      scsi_host_alloc - return a new scsi_host instance whose refcount==1
+      scsi_host_get - increments Scsi_Host instance's refcount
+      scsi_host_put - decrements Scsi_Host instance's refcount (free if 0)
+      scsi_partsize - parse partition table into cylinders, heads + sectors
+      scsi_register - create and register a scsi host adapter instance.
+      scsi_remove_device - detach and remove a SCSI device
+      scsi_remove_host - detach and remove all SCSI devices owned by host
+      scsi_report_bus_reset - report scsi _bus_ reset observed
+      scsi_scan_host - scan SCSI bus
+      scsi_track_queue_full - track successive QUEUE_FULL events
+      scsi_unblock_requests - allow further commands to be queued to given host
+      scsi_unregister - [calls scsi_host_put()]
+
+
+Details:
+
+.. code-block:: c
+
+   /**
+    * scsi_add_device - creates new scsi device (lu) instance
+    * @shost:   pointer to scsi host instance
+    * @channel: channel number (rarely other than 0)
+    * @id:      target id number
+    * @lun:     logical unit number
+    *
+    *      Returns pointer to new struct scsi_device instance or
+    *      ERR_PTR(-ENODEV) (or some other bent pointer) if something is
+    *      wrong (e.g. no lu responds at given address)
+    *
+    *      Might block: yes
+    *
+    *      Notes: This call is usually performed internally during a scsi
+    *      bus scan when an HBA is added (i.e. scsi_scan_host()). So it
+    *      should only be called if the HBA becomes aware of a new scsi
+    *      device (lu) after scsi_scan_host() has completed. If successful
+    *      this call can lead to slave_alloc() and slave_configure() callbacks
+    *      into the LLD.
+    *
+    *      Defined in: drivers/scsi/scsi_scan.c
+    **/
+   struct scsi_device * scsi_add_device(struct Scsi_Host *shost,
+                                        unsigned int channel,
+                                        unsigned int id, unsigned int lun)
+
+.. code-block:: c
+
+   /**
+    * scsi_add_host - perform sysfs registration and set up transport class
+    * @shost:   pointer to scsi host instance
+    * @dev:     pointer to struct device of type scsi class
+    *
+    *      Returns 0 on success, negative errno of failure (e.g. -ENOMEM)
+    *
+    *      Might block: no
+    *
+    *      Notes: Only required in "hotplug initialization model" after a
+    *      successful call to scsi_host_alloc().  This function does not
+    *	scan the bus; this can be done by calling scsi_scan_host() or
+    *	in some other transport-specific way.  The LLD must set up
+    *	the transport template before calling this function and may only
+    *	access the transport class data after this function has been called.
+    *
+    *      Defined in: drivers/scsi/hosts.c
+    **/
+   int scsi_add_host(struct Scsi_Host *shost, struct device * dev)
+
+.. code-block:: c
+
+   /**
+    * scsi_change_queue_depth - allow LLD to change queue depth on a SCSI device
+    * @sdev:       pointer to SCSI device to change queue depth on
+    * @tags        Number of tags allowed if tagged queuing enabled,
+    *              or number of commands the LLD can queue up
+    *              in non-tagged mode (as per cmd_per_lun).
+    *
+    *      Returns nothing
+    *
+    *      Might block: no
+    *
+    *      Notes: Can be invoked any time on a SCSI device controlled by this
+    *      LLD. [Specifically during and after slave_configure() and prior to
+    *      slave_destroy().] Can safely be invoked from interrupt code.
+    *
+    *      Defined in: drivers/scsi/scsi.c [see source code for more notes]
+    *
+    **/
+   int scsi_change_queue_depth(struct scsi_device *sdev, int tags)
+
+.. code-block:: c
+
+   /**
+    * scsi_bios_ptable - return copy of block device's partition table
+    * @dev:        pointer to block device
+    *
+    *      Returns pointer to partition table, or NULL for failure
+    *
+    *      Might block: yes
+    *
+    *      Notes: Caller owns memory returned (free with kfree() )
+    *
+    *      Defined in: drivers/scsi/scsicam.c
+    **/
+   unsigned char *scsi_bios_ptable(struct block_device *dev)
+
+.. code-block:: c
+
+   /**
+    * scsi_block_requests - prevent further commands being queued to given host
+    *
+    * @shost: pointer to host to block commands on
+    *
+    *      Returns nothing
+    *
+    *      Might block: no
+    *
+    *      Notes: There is no timer nor any other means by which the requests
+    *      get unblocked other than the LLD calling scsi_unblock_requests().
+    *
+    *      Defined in: drivers/scsi/scsi_lib.c
+   **/
+   void scsi_block_requests(struct Scsi_Host * shost)
+
+.. code-block:: c
+
+   /**
+    * scsi_host_alloc - create a scsi host adapter instance and perform basic
+    *                   initialization.
+    * @sht:        pointer to scsi host template
+    * @privsize:   extra bytes to allocate in hostdata array (which is the
+    *              last member of the returned Scsi_Host instance)
+    *
+    *      Returns pointer to new Scsi_Host instance or NULL on failure
+    *
+    *      Might block: yes
+    *
+    *      Notes: When this call returns to the LLD, the SCSI bus scan on
+    *      this host has _not_ yet been done.
+    *      The hostdata array (by default zero length) is a per host scratch
+    *      area for the LLD's exclusive use.
+    *      Both associated refcounting objects have their refcount set to 1.
+    *      Full registration (in sysfs) and a bus scan are performed later when
+    *      scsi_add_host() and scsi_scan_host() are called.
+    *
+    *      Defined in: drivers/scsi/hosts.c .
+    **/
+   struct Scsi_Host * scsi_host_alloc(struct scsi_host_template * sht,
+                                      int privsize)
+
+.. code-block:: c
+
+   /**
+    * scsi_host_get - increment Scsi_Host instance refcount
+    * @shost:   pointer to struct Scsi_Host instance
+    *
+    *      Returns nothing
+    *
+    *      Might block: currently may block but may be changed to not block
+    *
+    *      Notes: Actually increments the counts in two sub-objects
+    *
+    *      Defined in: drivers/scsi/hosts.c
+    **/
+   void scsi_host_get(struct Scsi_Host *shost)
+
+.. code-block:: c
+
+   /**
+    * scsi_host_put - decrement Scsi_Host instance refcount, free if 0
+    * @shost:   pointer to struct Scsi_Host instance
+    *
+    *      Returns nothing
+    *
+    *      Might block: currently may block but may be changed to not block
+    *
+    *      Notes: Actually decrements the counts in two sub-objects. If the
+    *      latter refcount reaches 0, the Scsi_Host instance is freed.
+    *      The LLD need not worry exactly when the Scsi_Host instance is
+    *      freed, it just shouldn't access the instance after it has balanced
+    *      out its refcount usage.
+    *
+    *      Defined in: drivers/scsi/hosts.c
+    **/
+   void scsi_host_put(struct Scsi_Host *shost)
+
+.. code-block:: c
+
+   /**
+    * scsi_partsize - parse partition table into cylinders, heads + sectors
+    * @buf: pointer to partition table
+    * @capacity: size of (total) disk in 512 byte sectors
+    * @cyls: outputs number of cylinders calculated via this pointer
+    * @hds: outputs number of heads calculated via this pointer
+    * @secs: outputs number of sectors calculated via this pointer
+    *
+    *      Returns 0 on success, -1 on failure
+    *
+    *      Might block: no
+    *
+    *      Notes: Caller owns memory returned (free with kfree() )
+    *
+    *      Defined in: drivers/scsi/scsicam.c
+    **/
+   int scsi_partsize(unsigned char *buf, unsigned long capacity,
+                     unsigned int *cyls, unsigned int *hds, unsigned int *secs)
+
+.. code-block:: c
+
+   /**
+    * scsi_register - create and register a scsi host adapter instance.
+    * @sht:        pointer to scsi host template
+    * @privsize:   extra bytes to allocate in hostdata array (which is the
+    *              last member of the returned Scsi_Host instance)
+    *
+    *      Returns pointer to new Scsi_Host instance or NULL on failure
+    *
+    *      Might block: yes
+    *
+    *      Notes: When this call returns to the LLD, the SCSI bus scan on
+    *      this host has _not_ yet been done.
+    *      The hostdata array (by default zero length) is a per host scratch
+    *      area for the LLD.
+    *
+    *      Defined in: drivers/scsi/hosts.c .
+    **/
+   struct Scsi_Host * scsi_register(struct scsi_host_template * sht,
+                                    int privsize)
+
+.. code-block:: c
+
+   /**
+    * scsi_remove_device - detach and remove a SCSI device
+    * @sdev:      a pointer to a scsi device instance
+    *
+    *      Returns value: 0 on success, -EINVAL if device not attached
+    *
+    *      Might block: yes
+    *
+    *      Notes: If an LLD becomes aware that a scsi device (lu) has
+    *      been removed but its host is still present then it can request
+    *      the removal of that scsi device. If successful this call will
+    *      lead to the slave_destroy() callback being invoked. sdev is an
+    *      invalid pointer after this call.
+    *
+    *      Defined in: drivers/scsi/scsi_sysfs.c .
+    **/
+   int scsi_remove_device(struct scsi_device *sdev)
+
+.. code-block:: c
+
+   /**
+    * scsi_remove_host - detach and remove all SCSI devices owned by host
+    * @shost:      a pointer to a scsi host instance
+    *
+    *      Returns value: 0 on success, 1 on failure (e.g. LLD busy ??)
+    *
+    *      Might block: yes
+    *
+    *      Notes: Should only be invoked if the "hotplug initialization
+    *      model" is being used. It should be called _prior_ to
+    *      scsi_unregister().
+    *
+    *      Defined in: drivers/scsi/hosts.c .
+    **/
+   int scsi_remove_host(struct Scsi_Host *shost)
+
+.. code-block:: c
+
+   /**
+    * scsi_report_bus_reset - report scsi _bus_ reset observed
+    * @shost: a pointer to a scsi host involved
+    * @channel: channel (within) host on which scsi bus reset occurred
+    *
+    *      Returns nothing
+    *
+    *      Might block: no
+    *
+    *      Notes: This only needs to be called if the reset is one which
+    *      originates from an unknown location.  Resets originated by the
+    *      mid level itself don't need to call this, but there should be
+    *      no harm.  The main purpose of this is to make sure that a
+    *      CHECK_CONDITION is properly treated.
+    *
+    *      Defined in: drivers/scsi/scsi_error.c .
+    **/
+   void scsi_report_bus_reset(struct Scsi_Host * shost, int channel)
+
+.. code-block:: c
+
+   /**
+    * scsi_scan_host - scan SCSI bus
+    * @shost: a pointer to a scsi host instance
+    *
+    *	Might block: yes
+    *
+    *	Notes: Should be called after scsi_add_host()
+    *
+    *	Defined in: drivers/scsi/scsi_scan.c
+    **/
+   void scsi_scan_host(struct Scsi_Host *shost)
+
+.. code-block:: c
+
+   /**
+    * scsi_track_queue_full - track successive QUEUE_FULL events on given
+    *                      device to determine if and when there is a need
+    *                      to adjust the queue depth on the device.
+    * @sdev:  pointer to SCSI device instance
+    * @depth: Current number of outstanding SCSI commands on this device,
+    *         not counting the one returned as QUEUE_FULL.
+    *
+    *      Returns 0  - no change needed
+    *              >0 - adjust queue depth to this new depth
+    *              -1 - drop back to untagged operation using host->cmd_per_lun
+    *                   as the untagged command depth
+    *
+    *      Might block: no
+    *
+    *      Notes: LLDs may call this at any time and we will do "The Right
+    *              Thing"; interrupt context safe.
+    *
+    *      Defined in: drivers/scsi/scsi.c .
+    **/
+   int scsi_track_queue_full(struct scsi_device *sdev, int depth)
+
+.. code-block:: c
+
+   /**
+    * scsi_unblock_requests - allow further commands to be queued to given host
+    *
+    * @shost: pointer to host to unblock commands on
+    *
+    *      Returns nothing
+    *
+    *      Might block: no
+    *
+    *      Defined in: drivers/scsi/scsi_lib.c .
+   **/
+   void scsi_unblock_requests(struct Scsi_Host * shost)
+
+.. code-block:: c
+
+   /**
+    * scsi_unregister - unregister and free memory used by host instance
+    * @shp:        pointer to scsi host instance to unregister.
+    *
+    *      Returns nothing
+    *
+    *      Might block: no
+    *
+    *      Notes: Should not be invoked if the "hotplug initialization
+    *      model" is being used. Called internally by exit_this_scsi_driver()
+    *      in the "passive initialization model". Hence a LLD has no need to
+    *      call this function directly.
+    *
+    *      Defined in: drivers/scsi/hosts.c .
+    **/
+   void scsi_unregister(struct Scsi_Host * shp)
+
+Interface Functions
+-------------------
+Interface functions are supplied (defined) by LLDs and their function
+pointers are placed in an instance of struct scsi_host_template which
+is passed to scsi_host_alloc() [or scsi_register() / init_this_scsi_driver()].
+Some are mandatory. Interface functions should be declared static. The
+accepted convention is that driver "xyz" will declare its slave_configure()
+function as:
+
+.. code-block:: c
+
+    static int xyz_slave_configure(struct scsi_device * sdev);
+
+and so forth for all interface functions listed below.
+
+A pointer to this function should be placed in the 'slave_configure' member
+of a "struct scsi_host_template" instance. A pointer to such an instance
+should be passed to the mid level's scsi_host_alloc() [or scsi_register() /
+init_this_scsi_driver()].
+
+The interface functions are also described in the include/scsi/scsi_host.h
+file immediately above their definition point in "struct scsi_host_template".
+In some cases more detail is given in scsi_host.h than below.
+
+The interface functions are listed below in alphabetical order.
+
+::
+
+   Summary:
+      bios_param - fetch head, sector, cylinder info for a disk
+      eh_timed_out - notify the host that a command timer expired
+      eh_abort_handler - abort given command
+      eh_bus_reset_handler - issue SCSI bus reset
+      eh_device_reset_handler - issue SCSI device reset
+      eh_host_reset_handler - reset host (host bus adapter)
+      info - supply information about given host
+      ioctl - driver can respond to ioctls
+      proc_info - supports /proc/scsi/{driver_name}/{host_no}
+      queuecommand - queue scsi command, invoke 'done' on completion
+      slave_alloc - prior to any commands being sent to a new device
+      slave_configure - driver fine tuning for given device after attach
+      slave_destroy - given device is about to be shut down
+
+
+Details:
+
+.. code-block:: c
+
+   /**
+    *      bios_param - fetch head, sector, cylinder info for a disk
+    *      @sdev: pointer to scsi device context (defined in
+    *             include/scsi/scsi_device.h)
+    *      @bdev: pointer to block device context (defined in fs.h)
+    *      @capacity:  device size (in 512 byte sectors)
+    *      @params: three element array to place output:
+    *              params[0] number of heads (max 255)
+    *              params[1] number of sectors (max 63)
+    *              params[2] number of cylinders
+    *
+    *      Return value is ignored
+    *
+    *      Locks: none
+    *
+    *      Calling context: process (sd)
+    *
+    *      Notes: an arbitrary geometry (based on READ CAPACITY) is used
+    *      if this function is not provided. The params array is
+    *      pre-initialized with made up values just in case this function
+    *      doesn't output anything.
+    *
+    *      Optionally defined in: LLD
+    **/
+       int bios_param(struct scsi_device * sdev, struct block_device *bdev,
+                      sector_t capacity, int params[3])
+
+.. code-block:: c
+
+   /**
+    *      eh_timed_out - The timer for the command has just fired
+    *      @scp: identifies command timing out
+    *
+    *      Returns:
+    *
+    *      EH_HANDLED:             I fixed the error, please complete the command
+    *      EH_RESET_TIMER:         I need more time, reset the timer and
+    *                              begin counting again
+    *      EH_NOT_HANDLED          Begin normal error recovery
+    *
+    *
+    *      Locks: None held
+    *
+    *      Calling context: interrupt
+    *
+    *      Notes: This is to give the LLD an opportunity to do local recovery.
+    *      This recovery is limited to determining if the outstanding command
+    *      will ever complete.  You may not abort and restart the command from
+    *      this callback.
+    *
+    *      Optionally defined in: LLD
+    **/
+        int eh_timed_out(struct scsi_cmnd * scp)
+
+.. code-block:: c
+
+   /**
+    *      eh_abort_handler - abort command associated with scp
+    *      @scp: identifies command to be aborted
+    *
+    *      Returns SUCCESS if command aborted else FAILED
+    *
+    *      Locks: None held
+    *
+    *      Calling context: kernel thread
+    *
+    *      Notes: If 'no_async_abort' is defined this callback
+    *  	will be invoked from scsi_eh thread. No other commands
+    *	will then be queued on current host during eh.
+    *	Otherwise it will be called whenever scsi_times_out()
+    *      is called due to a command timeout.
+    *
+    *      Optionally defined in: LLD
+    **/
+        int eh_abort_handler(struct scsi_cmnd * scp)
+
+.. code-block:: c
+
+   /**
+    *      eh_bus_reset_handler - issue SCSI bus reset
+    *      @scp: SCSI bus that contains this device should be reset
+    *
+    *      Returns SUCCESS if command aborted else FAILED
+    *
+    *      Locks: None held
+    *
+    *      Calling context: kernel thread
+    *
+    *      Notes: Invoked from scsi_eh thread. No other commands will be
+    *      queued on current host during eh.
+    *
+    *      Optionally defined in: LLD
+    **/
+        int eh_bus_reset_handler(struct scsi_cmnd * scp)
+
+.. code-block:: c
+
+   /**
+    *      eh_device_reset_handler - issue SCSI device reset
+    *      @scp: identifies SCSI device to be reset
+    *
+    *      Returns SUCCESS if command aborted else FAILED
+    *
+    *      Locks: None held
+    *
+    *      Calling context: kernel thread
+    *
+    *      Notes: Invoked from scsi_eh thread. No other commands will be
+    *      queued on current host during eh.
+    *
+    *      Optionally defined in: LLD
+    **/
+        int eh_device_reset_handler(struct scsi_cmnd * scp)
+
+.. code-block:: c
+
+   /**
+    *      eh_host_reset_handler - reset host (host bus adapter)
+    *      @scp: SCSI host that contains this device should be reset
+    *
+    *      Returns SUCCESS if command aborted else FAILED
+    *
+    *      Locks: None held
+    *
+    *      Calling context: kernel thread
+    *
+    *      Notes: Invoked from scsi_eh thread. No other commands will be
+    *      queued on current host during eh.
+    *      With the default eh_strategy in place, if none of the _abort_,
+    *      _device_reset_, _bus_reset_ or this eh handler function are
+    *      defined (or they all return FAILED) then the device in question
+    *      will be set offline whenever eh is invoked.
+    *
+    *      Optionally defined in: LLD
+    **/
+        int eh_host_reset_handler(struct scsi_cmnd * scp)
+
+.. code-block:: c
+
+   /**
+    *      info - supply information about given host: driver name plus data
+    *             to distinguish given host
+    *      @shp: host to supply information about
+    *
+    *      Return ASCII null terminated string. [This driver is assumed to
+    *      manage the memory pointed to and maintain it, typically for the
+    *      lifetime of this host.]
+    *
+    *      Locks: none
+    *
+    *      Calling context: process
+    *
+    *      Notes: Often supplies PCI or ISA information such as IO addresses
+    *      and interrupt numbers. If not supplied struct Scsi_Host::name used
+    *      instead. It is assumed the returned information fits on one line
+    *      (i.e. does not included embedded newlines).
+    *      The SCSI_IOCTL_PROBE_HOST ioctl yields the string returned by this
+    *      function (or struct Scsi_Host::name if this function is not
+    *      available).
+    *      In a similar manner, init_this_scsi_driver() outputs to the console
+    *      each host's "info" (or name) for the driver it is registering.
+    *      Also if proc_info() is not supplied, the output of this function
+    *      is used instead.
+    *
+    *      Optionally defined in: LLD
+    **/
+       const char * info(struct Scsi_Host * shp)
+
+.. code-block:: c
+
+   /**
+    *      ioctl - driver can respond to ioctls
+    *      @sdp: device that ioctl was issued for
+    *      @cmd: ioctl number
+    *      @arg: pointer to read or write data from. Since it points to
+    *            user space, should use appropriate kernel functions
+    *            (e.g. copy_from_user() ). In the Unix style this argument
+    *            can also be viewed as an unsigned long.
+    *
+    *      Returns negative "errno" value when there is a problem. 0 or a
+    *      positive value indicates success and is returned to the user space.
+    *
+    *      Locks: none
+    *
+    *      Calling context: process
+    *
+    *      Notes: The SCSI subsystem uses a "trickle down" ioctl model.
+    *      The user issues an ioctl() against an upper level driver
+    *      (e.g. /dev/sdc) and if the upper level driver doesn't recognize
+    *      the 'cmd' then it is passed to the SCSI mid level. If the SCSI
+    *      mid level does not recognize it, then the LLD that controls
+    *      the device receives the ioctl. According to recent Unix standards
+    *      unsupported ioctl() 'cmd' numbers should return -ENOTTY.
+    *
+    *      Optionally defined in: LLD
+    **/
+       int ioctl(struct scsi_device *sdp, int cmd, void *arg)
+
+.. code-block:: c
+
+   /**
+    *      proc_info - supports /proc/scsi/{driver_name}/{host_no}
+    *      @buffer: anchor point to output to (0==writeto1_read0) or fetch from
+    *               (1==writeto1_read0).
+    *      @start: where "interesting" data is written to. Ignored when
+    *              1==writeto1_read0.
+    *      @offset: offset within buffer 0==writeto1_read0 is actually
+    *               interested in. Ignored when 1==writeto1_read0 .
+    *      @length: maximum (or actual) extent of buffer
+    *      @host_no: host number of interest (struct Scsi_Host::host_no)
+    *      @writeto1_read0: 1 -> data coming from user space towards driver
+    *                            (e.g. "echo some_string > /proc/scsi/xyz/2")
+    *                       0 -> user what data from this driver
+    *                            (e.g. "cat /proc/scsi/xyz/2")
+    *
+    *      Returns length when 1==writeto1_read0. Otherwise number of chars
+    *      output to buffer past offset.
+    *
+    *      Locks: none held
+    *
+    *      Calling context: process
+    *
+    *      Notes: Driven from scsi_proc.c which interfaces to proc_fs. proc_fs
+    *      support can now be configured out of the scsi subsystem.
+    *
+    *      Optionally defined in: LLD
+    **/
+       int proc_info(char * buffer, char ** start, off_t offset,
+                     int length, int host_no, int writeto1_read0)
+
+.. code-block:: c
+
+   /**
+    *      queuecommand - queue scsi command, invoke scp->scsi_done on completion
+    *      @shost: pointer to the scsi host object
+    *      @scp: pointer to scsi command object
+    *
+    *      Returns 0 on success.
+    *
+    *      If there's a failure, return either:
+    *
+    *      SCSI_MLQUEUE_DEVICE_BUSY if the device queue is full, or
+    *      SCSI_MLQUEUE_HOST_BUSY if the entire host queue is full
+    *
+    *      On both of these returns, the mid-layer will requeue the I/O
+    *
+    *      - if the return is SCSI_MLQUEUE_DEVICE_BUSY, only that particular
+    *      device will be paused, and it will be unpaused when a command to
+    *      the device returns (or after a brief delay if there are no more
+    *      outstanding commands to it).  Commands to other devices continue
+    *      to be processed normally.
+    *
+    *      - if the return is SCSI_MLQUEUE_HOST_BUSY, all I/O to the host
+    *      is paused and will be unpaused when any command returns from
+    *      the host (or after a brief delay if there are no outstanding
+    *      commands to the host).
+    *
+    *      For compatibility with earlier versions of queuecommand, any
+    *      other return value is treated the same as
+    *      SCSI_MLQUEUE_HOST_BUSY.
+    *
+    *      Other types of errors that are detected immediately may be
+    *      flagged by setting scp->result to an appropriate value,
+    *      invoking the scp->scsi_done callback, and then returning 0
+    *      from this function. If the command is not performed
+    *      immediately (and the LLD is starting (or will start) the given
+    *      command) then this function should place 0 in scp->result and
+    *      return 0.
+    *
+    *      Command ownership.  If the driver returns zero, it owns the
+    *      command and must take responsibility for ensuring the
+    *      scp->scsi_done callback is executed.  Note: the driver may
+    *      call scp->scsi_done before returning zero, but after it has
+    *      called scp->scsi_done, it may not return any value other than
+    *      zero.  If the driver makes a non-zero return, it must not
+    *      execute the command's scsi_done callback at any time.
+    *
+    *      Locks: up to and including 2.6.36, struct Scsi_Host::host_lock
+    *             held on entry (with "irqsave") and is expected to be
+    *             held on return. From 2.6.37 onwards, queuecommand is
+    *             called without any locks held.
+    *
+    *      Calling context: in interrupt (soft irq) or process context
+    *
+    *      Notes: This function should be relatively fast. Normally it
+    *      will not wait for IO to complete. Hence the scp->scsi_done
+    *      callback is invoked (often directly from an interrupt service
+    *      routine) some time after this function has returned. In some
+    *      cases (e.g. pseudo adapter drivers that manufacture the
+    *      response to a SCSI INQUIRY) the scp->scsi_done callback may be
+    *      invoked before this function returns.  If the scp->scsi_done
+    *      callback is not invoked within a certain period the SCSI mid
+    *      level will commence error processing.  If a status of CHECK
+    *      CONDITION is placed in "result" when the scp->scsi_done
+    *      callback is invoked, then the LLD driver should perform
+    *      autosense and fill in the struct scsi_cmnd::sense_buffer
+    *      array. The scsi_cmnd::sense_buffer array is zeroed prior to
+    *      the mid level queuing a command to an LLD.
+    *
+    *      Defined in: LLD
+    **/
+       int queuecommand(struct Scsi_Host *shost, struct scsi_cmnd * scp)
+
+.. code-block:: c
+
+   /**
+    *      slave_alloc -   prior to any commands being sent to a new device
+    *                      (i.e. just prior to scan) this call is made
+    *      @sdp: pointer to new device (about to be scanned)
+    *
+    *      Returns 0 if ok. Any other return is assumed to be an error and
+    *      the device is ignored.
+    *
+    *      Locks: none
+    *
+    *      Calling context: process
+    *
+    *      Notes: Allows the driver to allocate any resources for a device
+    *      prior to its initial scan. The corresponding scsi device may not
+    *      exist but the mid level is just about to scan for it (i.e. send
+    *      and INQUIRY command plus ...). If a device is found then
+    *      slave_configure() will be called while if a device is not found
+    *      slave_destroy() is called.
+    *      For more details see the include/scsi/scsi_host.h file.
+    *
+    *      Optionally defined in: LLD
+    **/
+       int slave_alloc(struct scsi_device *sdp)
+
+.. code-block:: c
+
+   /**
+    *      slave_configure - driver fine tuning for given device just after it
+    *                     has been first scanned (i.e. it responded to an
+    *                     INQUIRY)
+    *      @sdp: device that has just been attached
+    *
+    *      Returns 0 if ok. Any other return is assumed to be an error and
+    *      the device is taken offline. [offline devices will _not_ have
+    *      slave_destroy() called on them so clean up resources.]
+    *
+    *      Locks: none
+    *
+    *      Calling context: process
+    *
+    *      Notes: Allows the driver to inspect the response to the initial
+    *      INQUIRY done by the scanning code and take appropriate action.
+    *      For more details see the include/scsi/scsi_host.h file.
+    *
+    *      Optionally defined in: LLD
+    **/
+       int slave_configure(struct scsi_device *sdp)
+
+.. code-block:: c
+
+   /**
+    *      slave_destroy - given device is about to be shut down. All
+    *                      activity has ceased on this device.
+    *      @sdp: device that is about to be shut down
+    *
+    *      Returns nothing
+    *
+    *      Locks: none
+    *
+    *      Calling context: process
+    *
+    *      Notes: Mid level structures for given device are still in place
+    *      but are about to be torn down. Any per device resources allocated
+    *      by this driver for given device should be freed now. No further
+    *      commands will be sent for this sdp instance. [However the device
+    *      could be re-attached in the future in which case a new instance
+    *      of struct scsi_device would be supplied by future slave_alloc()
+    *      and slave_configure() calls.]
+    *
+    *      Optionally defined in: LLD
+    **/
+       void slave_destroy(struct scsi_device *sdp)
+
+Data Structures
+---------------
+struct scsi_host_template
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There is one 
+
+.. code-block:: c
+
+   "struct scsi_host_template" instance per LLD ***.
+
+It is typically initialized as a file scope static in a driver's header file.
+That way members that are not explicitly initialized will be set to 0 or NULL.
+Member of interest:
+
+::
+
+    name         - name of driver (may contain spaces, please limit to
+                   less than 80 characters)
+    proc_name    - name used in "/proc/scsi/<proc_name>/<host_no>" and
+                   by sysfs in one of its "drivers" directories. Hence
+                   "proc_name" should only contain characters acceptable
+                   to a Unix file name.
+   (*queuecommand)() - primary callback that the mid level uses to inject
+                   SCSI commands into an LLD.
+
+The structure is defined and commented in include/scsi/scsi_host.h
+
+::
+
+   *** In extreme situations a single driver may have several instances
+       if it controls several different classes of hardware (e.g. an LLD
+       that handles both ISA and PCI cards and has a separate instance of
+       struct scsi_host_template for each class).
+
+struct Scsi_Host
+~~~~~~~~~~~~~~~~
+
+There is one struct Scsi_Host instance per host (HBA) that an LLD
+controls. The struct Scsi_Host structure has many members in common
+with "struct scsi_host_template". When a new struct Scsi_Host instance
+is created (in scsi_host_alloc() in hosts.c) those common members are
+initialized from the driver's struct scsi_host_template instance. Members
+of interest:
+
+::
+
+    host_no      - system wide unique number that is used for identifying
+                   this host. Issued in ascending order from 0.
+    can_queue    - must be greater than 0; do not send more than can_queue
+                   commands to the adapter.
+    this_id      - scsi id of host (scsi initiator) or -1 if not known
+    sg_tablesize - maximum scatter gather elements allowed by host.
+                   0 implies scatter gather not supported by host
+    max_sectors  - maximum number of sectors (usually 512 bytes) allowed
+                   in a single SCSI command. The default value of 0 leads
+                   to a setting of SCSI_DEFAULT_MAX_SECTORS (defined in
+                   scsi_host.h) which is currently set to 1024. So for a
+                   disk the maximum transfer size is 512 KB when max_sectors
+                   is not defined. Note that this size may not be sufficient
+                   for disk firmware uploads.
+    cmd_per_lun  - maximum number of commands that can be queued on devices
+                   controlled by the host. Overridden by LLD calls to
+                   scsi_change_queue_depth().
+    unchecked_isa_dma - 1=>only use bottom 16 MB of ram (ISA DMA addressing
+                   restriction), 0=>can use full 32 bit (or better) DMA
+                   address space
+    no_async_abort - 1=>Asynchronous aborts are not supported
+                     0=>Timed-out commands will be aborted asynchronously
+    hostt        - pointer to driver's struct scsi_host_template from which
+                   this struct Scsi_Host instance was spawned
+    hostt->proc_name  - name of LLD. This is the driver name that sysfs uses
+    transportt   - pointer to driver's struct scsi_transport_template instance
+                   (if any). FC and SPI transports currently supported.
+    sh_list      - a double linked list of pointers to all struct Scsi_Host
+                   instances (currently ordered by ascending host_no)
+    my_devices   - a double linked list of pointers to struct scsi_device
+                   instances that belong to this host.
+    hostdata[0]  - area reserved for LLD at end of struct Scsi_Host. Size
+                   is set by the second argument (named 'xtr_bytes') to
+                   scsi_host_alloc() or scsi_register().
+    vendor_id    - a unique value that identifies the vendor supplying
+                   the LLD for the Scsi_Host.  Used most often in validating
+                   vendor-specific message requests.  Value consists of an
+                   identifier type and a vendor-specific value.
+                   See scsi_netlink.h for a description of valid formats.
+
+The scsi_host structure is defined in include/scsi/scsi_host.h
+
+struct scsi_device
+~~~~~~~~~~~~~~~~~~
+Generally, there is one instance of this structure for each SCSI logical unit
+on a host. Scsi devices connected to a host are uniquely identified by a
+channel number, target id and logical unit number (lun).
+The structure is defined in include/scsi/scsi_device.h
+
+struct scsi_cmnd
+~~~~~~~~~~~~~~~~
+Instances of this structure convey SCSI commands to the LLD and responses
+back to the mid level. The SCSI mid level will ensure that no more SCSI
+commands become queued against the LLD than are indicated by
+scsi_change_queue_depth() (or struct Scsi_Host::cmd_per_lun). There will
+be at least one instance of struct scsi_cmnd available for each SCSI device.
+Members of interest:
+
+::
+
+    cmnd         - array containing SCSI command
+    cmnd_len     - length (in bytes) of SCSI command
+    sc_data_direction - direction of data transfer in data phase. See
+                "enum dma_data_direction" in include/linux/dma-mapping.h
+    request_bufflen - number of data bytes to transfer (0 if no data phase)
+    use_sg       - ==0 -> no scatter gather list, hence transfer data
+                          to/from request_buffer
+                 - >0 ->  scatter gather list (actually an array) in
+                          request_buffer with use_sg elements
+    request_buffer - either contains data buffer or scatter gather list
+                     depending on the setting of use_sg. Scatter gather
+                     elements are defined by 'struct scatterlist' found
+                     in include/linux/scatterlist.h .
+    done         - function pointer that should be invoked by LLD when the
+                   SCSI command is completed (successfully or otherwise).
+                   Should only be called by an LLD if the LLD has accepted
+                   the command (i.e. queuecommand() returned or will return
+                   0). The LLD may invoke 'done'  prior to queuecommand()
+                   finishing.
+    result       - should be set by LLD prior to calling 'done'. A value
+                   of 0 implies a successfully completed command (and all
+                   data (if any) has been transferred to or from the SCSI
+                   target device). 'result' is a 32 bit unsigned integer that
+                   can be viewed as 4 related bytes. The SCSI status value is
+                   in the LSB. See include/scsi/scsi.h status_byte(),
+                   msg_byte(), host_byte() and driver_byte() macros and
+                   related constants.
+    sense_buffer - an array (maximum size: SCSI_SENSE_BUFFERSIZE bytes) that
+                   should be written when the SCSI status (LSB of 'result')
+                   is set to CHECK_CONDITION (2). When CHECK_CONDITION is
+                   set, if the top nibble of sense_buffer[0] has the value 7
+                   then the mid level will assume the sense_buffer array
+                   contains a valid SCSI sense buffer; otherwise the mid
+                   level will issue a REQUEST_SENSE SCSI command to
+                   retrieve the sense buffer. The latter strategy is error
+                   prone in the presence of command queuing so the LLD should
+                   always "auto-sense".
+    device       - pointer to scsi_device object that this command is
+                   associated with.
+    resid        - an LLD should set this signed integer to the requested
+                   transfer length (i.e. 'request_bufflen') less the number
+                   of bytes that are actually transferred. 'resid' is
+                   preset to 0 so an LLD can ignore it if it cannot detect
+                   underruns (overruns should be rare). If possible an LLD
+                   should set 'resid' prior to invoking 'done'. The most
+                   interesting case is data transfers from a SCSI target
+                   device (e.g. READs) that underrun.
+    underflow    - LLD should place (DID_ERROR << 16) in 'result' if
+                   actual number of bytes transferred is less than this
+                   figure. Not many LLDs implement this check and some that
+                   do just output an error message to the log rather than
+                   report a DID_ERROR. Better for an LLD to implement
+                   'resid'.
+
+It is recommended that a LLD set 'resid' on data transfers from a SCSI
+target device (e.g. READs). It is especially important that 'resid' is set
+when such data transfers have sense keys of MEDIUM ERROR and HARDWARE ERROR
+(and possibly RECOVERED ERROR). In these cases if a LLD is in doubt how much
+data has been received then the safest approach is to indicate no bytes have
+been received. For example: to indicate that no valid data has been received
+a LLD might use these helpers:
+
+.. code-block:: c
+
+    scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
+
+where 'SCpnt' is a pointer to a scsi_cmnd object. To indicate only three 512
+bytes blocks has been received 'resid' could be set like this:
+
+.. code-block:: c
+
+    scsi_set_resid(SCpnt, scsi_bufflen(SCpnt) - (3 * 512));
+
+The scsi_cmnd structure is defined in include/scsi/scsi_cmnd.h
+
+
+Locks
+-----
+Each struct Scsi_Host instance has a spin_lock called struct
+Scsi_Host::default_lock which is initialized in scsi_host_alloc() [found in
+hosts.c]. Within the same function the struct Scsi_Host::host_lock pointer
+is initialized to point at default_lock.  Thereafter lock and unlock
+operations performed by the mid level use the struct Scsi_Host::host_lock
+pointer.  Previously drivers could override the host_lock pointer but
+this is not allowed anymore.
+
+
+Autosense
+---------
+Autosense (or auto-sense) is defined in the SAM-2 document as "the
+automatic return of sense data to the application client coincident
+with the completion of a SCSI command" when a status of CHECK CONDITION
+occurs. LLDs should perform autosense. This should be done when the LLD
+detects a CHECK CONDITION status by either:
+
+    a) instructing the SCSI protocol (e.g. SCSI Parallel Interface (SPI))
+       to perform an extra data in phase on such responses
+    b) or, the LLD issuing a REQUEST SENSE command itself
+
+Either way, when a status of CHECK CONDITION is detected, the mid level
+decides whether the LLD has performed autosense by checking struct
+scsi_cmnd::sense_buffer[0] . If this byte has an upper nibble of 7 (or 0xf)
+then autosense is assumed to have taken place. If it has another value (and
+this byte is initialized to 0 before each command) then the mid level will
+issue a REQUEST SENSE command.
+
+In the presence of queued commands the "nexus" that maintains sense
+buffer data from the command that failed until a following REQUEST SENSE
+may get out of synchronization. This is why it is best for the LLD
+to perform autosense.
+
+
+Changes since lk 2.4 series
+---------------------------
+io_request_lock has been replaced by several finer grained locks. The lock
+relevant to LLDs is struct Scsi_Host::host_lock and there is
+one per SCSI host.
+
+The older error handling mechanism has been removed. This means the
+LLD interface functions abort() and reset() have been removed.
+The struct scsi_host_template::use_new_eh_code flag has been removed.
+
+In the 2.4 series the SCSI subsystem configuration descriptions were
+aggregated with the configuration descriptions from all other Linux
+subsystems in the Documentation/Configure.help file. In the 2.6 series,
+the SCSI subsystem now has its own (much smaller) drivers/scsi/Kconfig
+file that contains both configuration and help information.
+
+struct SHT has been renamed to struct scsi_host_template.
+
+Addition of the "hotplug initialization model" and many extra functions
+to support it.
+
+
+Credits
+-------
+The following people have contributed to this document:
+
+.. code-block:: html
+
+        Mike Anderson <andmike at us dot ibm dot com>
+        James Bottomley <James dot Bottomley at hansenpartnership dot com>
+        Patrick Mansfield <patmans at us dot ibm dot com>
+        Christoph Hellwig <hch at infradead dot org>
+        Doug Ledford <dledford at redhat dot com>
+        Andries Brouwer <Andries dot Brouwer at cwi dot nl>
+        Randy Dunlap <rdunlap at xenotime dot net>
+        Alan Stern <stern at rowland dot harvard dot edu>
+
+
+Douglas Gilbert
+dgilbert at interlog dot com
+21st September 2004
diff --git a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
deleted file mode 100644
index c1dd4939f4ae..000000000000
--- a/Documentation/scsi/scsi_mid_low_api.txt
+++ /dev/null
@@ -1,1279 +0,0 @@
-                          Linux Kernel 2.6 series
-                 SCSI mid_level - lower_level driver interface
-                 =============================================
-
-Introduction
-============
-This document outlines the interface between the Linux SCSI mid level and
-SCSI lower level drivers. Lower level drivers (LLDs) are variously called 
-host bus adapter (HBA) drivers and host drivers (HD). A "host" in this
-context is a bridge between a computer IO bus (e.g. PCI or ISA) and a
-single SCSI initiator port on a SCSI transport. An "initiator" port
-(SCSI terminology, see SAM-3 at http://www.t10.org) sends SCSI commands
-to "target" SCSI ports (e.g. disks). There can be many LLDs in a running
-system, but only one per hardware type. Most LLDs can control one or more
-SCSI HBAs. Some HBAs contain multiple hosts.
-
-In some cases the SCSI transport is an external bus that already has
-its own subsystem in Linux (e.g. USB and ieee1394). In such cases the
-SCSI subsystem LLD is a software bridge to the other driver subsystem.
-Examples are the usb-storage driver (found in the drivers/usb/storage
-directory) and the ieee1394/sbp2 driver (found in the drivers/ieee1394
-directory).
-
-For example, the aic7xxx LLD controls Adaptec SCSI parallel interface
-(SPI) controllers based on that company's 7xxx chip series. The aic7xxx
-LLD can be built into the kernel or loaded as a module. There can only be
-one aic7xxx LLD running in a Linux system but it may be controlling many 
-HBAs. These HBAs might be either on PCI daughter-boards or built into 
-the motherboard (or both). Some aic7xxx based HBAs are dual controllers
-and thus represent two hosts. Like most modern HBAs, each aic7xxx host
-has its own PCI device address. [The one-to-one correspondence between
-a SCSI host and a PCI device is common but not required (e.g. with
-ISA adapters).]
-
-The SCSI mid level isolates an LLD from other layers such as the SCSI
-upper layer drivers and the block layer.
-
-This version of the document roughly matches linux kernel version 2.6.8 .
-
-Documentation
-=============
-There is a SCSI documentation directory within the kernel source tree, 
-typically Documentation/scsi . Most documents are in plain
-(i.e. ASCII) text. This file is named scsi_mid_low_api.txt and can be 
-found in that directory. A more recent copy of this document may be found
-at http://web.archive.org/web/20070107183357rn_1/sg.torque.net/scsi/. 
-Many LLDs are documented there (e.g. aic7xxx.txt). The SCSI mid-level is
-briefly described in scsi.txt which contains a url to a document 
-describing the SCSI subsystem in the lk 2.4 series. Two upper level 
-drivers have documents in that directory: st.txt (SCSI tape driver) and 
-scsi-generic.txt (for the sg driver).
-
-Some documentation (or urls) for LLDs may be found in the C source code
-or in the same directory as the C source code. For example to find a url
-about the USB mass storage driver see the 
-/usr/src/linux/drivers/usb/storage directory.
-
-Driver structure
-================
-Traditionally an LLD for the SCSI subsystem has been at least two files in
-the drivers/scsi directory. For example, a driver called "xyz" has a header
-file "xyz.h" and a source file "xyz.c". [Actually there is no good reason
-why this couldn't all be in one file; the header file is superfluous.] Some
-drivers that have been ported to several operating systems have more than
-two files. For example the aic7xxx driver has separate files for generic 
-and OS-specific code (e.g. FreeBSD and Linux). Such drivers tend to have
-their own directory under the drivers/scsi directory.
-
-When a new LLD is being added to Linux, the following files (found in the
-drivers/scsi directory) will need some attention: Makefile and Kconfig .
-It is probably best to study how existing LLDs are organized.
-
-As the 2.5 series development kernels evolve into the 2.6 series
-production series, changes are being introduced into this interface. An
-example of this is driver initialization code where there are now 2 models
-available. The older one, similar to what was found in the lk 2.4 series,
-is based on hosts that are detected at HBA driver load time. This will be
-referred to the "passive" initialization model. The newer model allows HBAs
-to be hot plugged (and unplugged) during the lifetime of the LLD and will
-be referred to as the "hotplug" initialization model. The newer model is
-preferred as it can handle both traditional SCSI equipment that is
-permanently connected as well as modern "SCSI" devices (e.g. USB or
-IEEE 1394 connected digital cameras) that are hotplugged. Both 
-initialization models are discussed in the following sections.
-
-An LLD interfaces to the SCSI subsystem several ways:
-  a) directly invoking functions supplied by the mid level
-  b) passing a set of function pointers to a registration function
-     supplied by the mid level. The mid level will then invoke these
-     functions at some point in the future. The LLD will supply
-     implementations of these functions.
-  c) direct access to instances of well known data structures maintained
-     by the mid level
-
-Those functions in group a) are listed in a section entitled "Mid level
-supplied functions" below.
-
-Those functions in group b) are listed in a section entitled "Interface
-functions" below. Their function pointers are placed in the members of
-"struct scsi_host_template", an instance of which is passed to
-scsi_host_alloc() ** .  Those interface functions that the LLD does not 
-wish to supply should have NULL placed in the corresponding member of 
-struct scsi_host_template.  Defining an instance of struct 
-scsi_host_template at file scope will cause NULL to be  placed in function
- pointer members not explicitly initialized.
-
-Those usages in group c) should be handled with care, especially in a
-"hotplug" environment. LLDs should be aware of the lifetime of instances
-that are shared with the mid level and other layers.
-
-All functions defined within an LLD and all data defined at file scope
-should be static. For example the slave_alloc() function in an LLD
-called "xxx" could be defined as 
-"static int xxx_slave_alloc(struct scsi_device * sdev) { /* code */ }"
-
-** the scsi_host_alloc() function is a replacement for the rather vaguely
-named scsi_register() function in most situations.
-
-
-Hotplug initialization model
-============================
-In this model an LLD controls when SCSI hosts are introduced and removed
-from the SCSI subsystem. Hosts can be introduced as early as driver
-initialization and removed as late as driver shutdown. Typically a driver
-will respond to a sysfs probe() callback that indicates an HBA has been
-detected. After confirming that the new device is one that the LLD wants
-to control, the LLD will initialize the HBA and then register a new host
-with the SCSI mid level.
-
-During LLD initialization the driver should register itself with the
-appropriate IO bus on which it expects to find HBA(s) (e.g. the PCI bus).
-This can probably be done via sysfs. Any driver parameters (especially
-those that are writable after the driver is loaded) could also be
-registered with sysfs at this point. The SCSI mid level first becomes
-aware of an LLD when that LLD registers its first HBA.
-
-At some later time, the LLD becomes aware of an HBA and what follows
-is a typical sequence of calls between the LLD and the mid level.
-This example shows the mid level scanning the newly introduced HBA for 3 
-scsi devices of which only the first 2 respond:
-
-     HBA PROBE: assume 2 SCSI devices found in scan
-LLD                   mid level                    LLD
-===-------------------=========--------------------===------
-scsi_host_alloc()  -->
-scsi_add_host()  ---->
-scsi_scan_host()  -------+
-                         |
-                    slave_alloc()
-                    slave_configure() -->  scsi_change_queue_depth()
-                         |
-                    slave_alloc()
-                    slave_configure()
-                         |
-                    slave_alloc()   ***
-                    slave_destroy() ***
-------------------------------------------------------------
-
-If the LLD wants to adjust the default queue settings, it can invoke
-scsi_change_queue_depth() in its slave_configure() routine.
-
-*** For scsi devices that the mid level tries to scan but do not
-    respond, a slave_alloc(), slave_destroy() pair is called.
-
-When an HBA is being removed it could be as part of an orderly shutdown
-associated with the LLD module being unloaded (e.g. with the "rmmod"
-command) or in response to a "hot unplug" indicated by sysfs()'s
-remove() callback being invoked. In either case, the sequence is the
-same:
-
-        HBA REMOVE: assume 2 SCSI devices attached
-LLD                      mid level                 LLD
-===----------------------=========-----------------===------
-scsi_remove_host() ---------+
-                            |
-                     slave_destroy()
-                     slave_destroy()
-scsi_host_put()
-------------------------------------------------------------
-                     
-It may be useful for a LLD to keep track of struct Scsi_Host instances
-(a pointer is returned by scsi_host_alloc()). Such instances are "owned"
-by the mid-level.  struct Scsi_Host instances are freed from
-scsi_host_put() when the reference count hits zero.
-
-Hot unplugging an HBA that controls a disk which is processing SCSI
-commands on a mounted file system is an interesting situation. Reference
-counting logic is being introduced into the mid level to cope with many
-of the issues involved. See the section on reference counting below.
-
-
-The hotplug concept may be extended to SCSI devices. Currently, when an
-HBA is added, the scsi_scan_host() function causes a scan for SCSI devices
-attached to the HBA's SCSI transport. On newer SCSI transports the HBA
-may become aware of a new SCSI device _after_ the scan has completed.
-An LLD can use this sequence to make the mid level aware of a SCSI device:
-
-                 SCSI DEVICE hotplug
-LLD                   mid level                    LLD
-===-------------------=========--------------------===------
-scsi_add_device()  ------+
-                         |
-                    slave_alloc()
-                    slave_configure()   [--> scsi_change_queue_depth()]
-------------------------------------------------------------
-
-In a similar fashion, an LLD may become aware that a SCSI device has been
-removed (unplugged) or the connection to it has been interrupted. Some
-existing SCSI transports (e.g. SPI) may not become aware that a SCSI
-device has been removed until a subsequent SCSI command fails which will
-probably cause that device to be set offline by the mid level. An LLD that
-detects the removal of a SCSI device can instigate its removal from
-upper layers with this sequence:
-
-                  SCSI DEVICE hot unplug
-LLD                      mid level                 LLD
-===----------------------=========-----------------===------
-scsi_remove_device() -------+
-                            |
-                     slave_destroy()
-------------------------------------------------------------
-
-It may be useful for an LLD to keep track of struct scsi_device instances
-(a pointer is passed as the parameter to slave_alloc() and
-slave_configure() callbacks). Such instances are "owned" by the mid-level.
-struct scsi_device instances are freed after slave_destroy().
-
-
-Reference Counting
-==================
-The Scsi_Host structure has had reference counting infrastructure added.
-This effectively spreads the ownership of struct Scsi_Host instances
-across the various SCSI layers which use them. Previously such instances
-were exclusively owned by the mid level. LLDs would not usually need to
-directly manipulate these reference counts but there may be some cases
-where they do.
-
-There are 3 reference counting functions of interest associated with
-struct Scsi_Host:
-  - scsi_host_alloc(): returns a pointer to new instance of struct 
-        Scsi_Host which has its reference count ^^ set to 1
-  - scsi_host_get(): adds 1 to the reference count of the given instance
-  - scsi_host_put(): decrements 1 from the reference count of the given
-        instance. If the reference count reaches 0 then the given instance
-        is freed
-
-The scsi_device structure has had reference counting infrastructure added.
-This effectively spreads the ownership of struct scsi_device instances
-across the various SCSI layers which use them. Previously such instances
-were exclusively owned by the mid level. See the access functions declared
-towards the end of include/scsi/scsi_device.h . If an LLD wants to keep
-a copy of a pointer to a scsi_device instance it should use scsi_device_get()
-to bump its reference count. When it is finished with the pointer it can
-use scsi_device_put() to decrement its reference count (and potentially
-delete it).
-
-^^ struct Scsi_Host actually has 2 reference counts which are manipulated
-in parallel by these functions.
-
-
-Conventions
-===========
-First, Linus Torvalds's thoughts on C coding style can be found in the
-Documentation/process/coding-style.rst file.
-
-Next, there is a movement to "outlaw" typedefs introducing synonyms for 
-struct tags. Both can be still found in the SCSI subsystem, but
-the typedefs have been moved to a single file, scsi_typedefs.h to
-make their future removal easier, for example: 
-"typedef struct scsi_cmnd Scsi_Cmnd;"
-
-Also, most C99 enhancements are encouraged to the extent they are supported
-by the relevant gcc compilers. So C99 style structure and array
-initializers are encouraged where appropriate. Don't go too far,
-VLAs are not properly supported yet.  An exception to this is the use of
-"//" style comments; /*...*/ comments are still preferred in Linux.
-
-Well written, tested and documented code, need not be re-formatted to
-comply with the above conventions. For example, the aic7xxx driver
-comes to Linux from FreeBSD and Adaptec's own labs. No doubt FreeBSD
-and Adaptec have their own coding conventions.
-
-
-Mid level supplied functions
-============================
-These functions are supplied by the SCSI mid level for use by LLDs.
-The names (i.e. entry points) of these functions are exported 
-so an LLD that is a module can access them. The kernel will
-arrange for the SCSI mid level to be loaded and initialized before any LLD
-is initialized. The functions below are listed alphabetically and their
-names all start with "scsi_".
-
-Summary:
-   scsi_add_device - creates new scsi device (lu) instance
-   scsi_add_host - perform sysfs registration and set up transport class
-   scsi_change_queue_depth - change the queue depth on a SCSI device
-   scsi_bios_ptable - return copy of block device's partition table
-   scsi_block_requests - prevent further commands being queued to given host
-   scsi_host_alloc - return a new scsi_host instance whose refcount==1
-   scsi_host_get - increments Scsi_Host instance's refcount
-   scsi_host_put - decrements Scsi_Host instance's refcount (free if 0)
-   scsi_partsize - parse partition table into cylinders, heads + sectors
-   scsi_register - create and register a scsi host adapter instance.
-   scsi_remove_device - detach and remove a SCSI device
-   scsi_remove_host - detach and remove all SCSI devices owned by host
-   scsi_report_bus_reset - report scsi _bus_ reset observed
-   scsi_scan_host - scan SCSI bus
-   scsi_track_queue_full - track successive QUEUE_FULL events 
-   scsi_unblock_requests - allow further commands to be queued to given host
-   scsi_unregister - [calls scsi_host_put()]
-
-
-Details:
-
-/**
- * scsi_add_device - creates new scsi device (lu) instance
- * @shost:   pointer to scsi host instance
- * @channel: channel number (rarely other than 0)
- * @id:      target id number
- * @lun:     logical unit number
- *
- *      Returns pointer to new struct scsi_device instance or 
- *      ERR_PTR(-ENODEV) (or some other bent pointer) if something is
- *      wrong (e.g. no lu responds at given address)
- *
- *      Might block: yes
- *
- *      Notes: This call is usually performed internally during a scsi
- *      bus scan when an HBA is added (i.e. scsi_scan_host()). So it
- *      should only be called if the HBA becomes aware of a new scsi
- *      device (lu) after scsi_scan_host() has completed. If successful
- *      this call can lead to slave_alloc() and slave_configure() callbacks
- *      into the LLD.
- *
- *      Defined in: drivers/scsi/scsi_scan.c
- **/
-struct scsi_device * scsi_add_device(struct Scsi_Host *shost, 
-                                     unsigned int channel,
-                                     unsigned int id, unsigned int lun)
-
-
-/**
- * scsi_add_host - perform sysfs registration and set up transport class
- * @shost:   pointer to scsi host instance
- * @dev:     pointer to struct device of type scsi class
- *
- *      Returns 0 on success, negative errno of failure (e.g. -ENOMEM)
- *
- *      Might block: no
- *
- *      Notes: Only required in "hotplug initialization model" after a
- *      successful call to scsi_host_alloc().  This function does not
- *	scan the bus; this can be done by calling scsi_scan_host() or
- *	in some other transport-specific way.  The LLD must set up
- *	the transport template before calling this function and may only
- *	access the transport class data after this function has been called.
- *
- *      Defined in: drivers/scsi/hosts.c
- **/
-int scsi_add_host(struct Scsi_Host *shost, struct device * dev)
-
-
-/**
- * scsi_change_queue_depth - allow LLD to change queue depth on a SCSI device
- * @sdev:       pointer to SCSI device to change queue depth on
- * @tags        Number of tags allowed if tagged queuing enabled,
- *              or number of commands the LLD can queue up
- *              in non-tagged mode (as per cmd_per_lun).
- *
- *      Returns nothing
- *
- *      Might block: no
- *
- *      Notes: Can be invoked any time on a SCSI device controlled by this
- *      LLD. [Specifically during and after slave_configure() and prior to
- *      slave_destroy().] Can safely be invoked from interrupt code.
- *
- *      Defined in: drivers/scsi/scsi.c [see source code for more notes]
- *
- **/
-int scsi_change_queue_depth(struct scsi_device *sdev, int tags)
-
-
-/**
- * scsi_bios_ptable - return copy of block device's partition table
- * @dev:        pointer to block device
- *
- *      Returns pointer to partition table, or NULL for failure
- *
- *      Might block: yes
- *
- *      Notes: Caller owns memory returned (free with kfree() )
- *
- *      Defined in: drivers/scsi/scsicam.c
- **/
-unsigned char *scsi_bios_ptable(struct block_device *dev)
-
-
-/**
- * scsi_block_requests - prevent further commands being queued to given host
- *
- * @shost: pointer to host to block commands on
- *
- *      Returns nothing
- *
- *      Might block: no
- *
- *      Notes: There is no timer nor any other means by which the requests
- *      get unblocked other than the LLD calling scsi_unblock_requests().
- *
- *      Defined in: drivers/scsi/scsi_lib.c
-**/
-void scsi_block_requests(struct Scsi_Host * shost)
-
-
-/**
- * scsi_host_alloc - create a scsi host adapter instance and perform basic
- *                   initialization.
- * @sht:        pointer to scsi host template
- * @privsize:   extra bytes to allocate in hostdata array (which is the
- *              last member of the returned Scsi_Host instance)
- *
- *      Returns pointer to new Scsi_Host instance or NULL on failure
- *
- *      Might block: yes
- *
- *      Notes: When this call returns to the LLD, the SCSI bus scan on
- *      this host has _not_ yet been done.
- *      The hostdata array (by default zero length) is a per host scratch 
- *      area for the LLD's exclusive use.
- *      Both associated refcounting objects have their refcount set to 1.
- *      Full registration (in sysfs) and a bus scan are performed later when
- *      scsi_add_host() and scsi_scan_host() are called.
- *
- *      Defined in: drivers/scsi/hosts.c .
- **/
-struct Scsi_Host * scsi_host_alloc(struct scsi_host_template * sht,
-                                   int privsize)
-
-
-/**
- * scsi_host_get - increment Scsi_Host instance refcount
- * @shost:   pointer to struct Scsi_Host instance
- *
- *      Returns nothing
- *
- *      Might block: currently may block but may be changed to not block
- *
- *      Notes: Actually increments the counts in two sub-objects
- *
- *      Defined in: drivers/scsi/hosts.c
- **/
-void scsi_host_get(struct Scsi_Host *shost)
-
-
-/**
- * scsi_host_put - decrement Scsi_Host instance refcount, free if 0
- * @shost:   pointer to struct Scsi_Host instance
- *
- *      Returns nothing
- *
- *      Might block: currently may block but may be changed to not block
- *
- *      Notes: Actually decrements the counts in two sub-objects. If the
- *      latter refcount reaches 0, the Scsi_Host instance is freed.
- *      The LLD need not worry exactly when the Scsi_Host instance is
- *      freed, it just shouldn't access the instance after it has balanced
- *      out its refcount usage.
- *
- *      Defined in: drivers/scsi/hosts.c
- **/
-void scsi_host_put(struct Scsi_Host *shost)
-
-
-/**
- * scsi_partsize - parse partition table into cylinders, heads + sectors
- * @buf: pointer to partition table
- * @capacity: size of (total) disk in 512 byte sectors
- * @cyls: outputs number of cylinders calculated via this pointer
- * @hds: outputs number of heads calculated via this pointer
- * @secs: outputs number of sectors calculated via this pointer
- *
- *      Returns 0 on success, -1 on failure
- *
- *      Might block: no
- *
- *      Notes: Caller owns memory returned (free with kfree() )
- *
- *      Defined in: drivers/scsi/scsicam.c
- **/
-int scsi_partsize(unsigned char *buf, unsigned long capacity,
-                  unsigned int *cyls, unsigned int *hds, unsigned int *secs)
-
-
-/**
- * scsi_register - create and register a scsi host adapter instance.
- * @sht:        pointer to scsi host template
- * @privsize:   extra bytes to allocate in hostdata array (which is the
- *              last member of the returned Scsi_Host instance)
- *
- *      Returns pointer to new Scsi_Host instance or NULL on failure
- *
- *      Might block: yes
- *
- *      Notes: When this call returns to the LLD, the SCSI bus scan on
- *      this host has _not_ yet been done.
- *      The hostdata array (by default zero length) is a per host scratch 
- *      area for the LLD.
- *
- *      Defined in: drivers/scsi/hosts.c .
- **/
-struct Scsi_Host * scsi_register(struct scsi_host_template * sht,
-                                 int privsize)
-
-
-/**
- * scsi_remove_device - detach and remove a SCSI device
- * @sdev:      a pointer to a scsi device instance
- *
- *      Returns value: 0 on success, -EINVAL if device not attached
- *
- *      Might block: yes
- *
- *      Notes: If an LLD becomes aware that a scsi device (lu) has
- *      been removed but its host is still present then it can request
- *      the removal of that scsi device. If successful this call will
- *      lead to the slave_destroy() callback being invoked. sdev is an 
- *      invalid pointer after this call.
- *
- *      Defined in: drivers/scsi/scsi_sysfs.c .
- **/
-int scsi_remove_device(struct scsi_device *sdev)
-
-
-/**
- * scsi_remove_host - detach and remove all SCSI devices owned by host
- * @shost:      a pointer to a scsi host instance
- *
- *      Returns value: 0 on success, 1 on failure (e.g. LLD busy ??)
- *
- *      Might block: yes
- *
- *      Notes: Should only be invoked if the "hotplug initialization
- *      model" is being used. It should be called _prior_ to  
- *      scsi_unregister().
- *
- *      Defined in: drivers/scsi/hosts.c .
- **/
-int scsi_remove_host(struct Scsi_Host *shost)
-
-
-/**
- * scsi_report_bus_reset - report scsi _bus_ reset observed
- * @shost: a pointer to a scsi host involved
- * @channel: channel (within) host on which scsi bus reset occurred
- *
- *      Returns nothing
- *
- *      Might block: no
- *
- *      Notes: This only needs to be called if the reset is one which
- *      originates from an unknown location.  Resets originated by the 
- *      mid level itself don't need to call this, but there should be 
- *      no harm.  The main purpose of this is to make sure that a
- *      CHECK_CONDITION is properly treated.
- *
- *      Defined in: drivers/scsi/scsi_error.c .
- **/
-void scsi_report_bus_reset(struct Scsi_Host * shost, int channel)
-
-
-/**
- * scsi_scan_host - scan SCSI bus
- * @shost: a pointer to a scsi host instance
- *
- *	Might block: yes
- *
- *	Notes: Should be called after scsi_add_host()
- *
- *	Defined in: drivers/scsi/scsi_scan.c
- **/
-void scsi_scan_host(struct Scsi_Host *shost)
-
-
-/**
- * scsi_track_queue_full - track successive QUEUE_FULL events on given
- *                      device to determine if and when there is a need
- *                      to adjust the queue depth on the device.
- * @sdev:  pointer to SCSI device instance
- * @depth: Current number of outstanding SCSI commands on this device,
- *         not counting the one returned as QUEUE_FULL.
- *
- *      Returns 0  - no change needed
- *              >0 - adjust queue depth to this new depth
- *              -1 - drop back to untagged operation using host->cmd_per_lun
- *                   as the untagged command depth
- *
- *      Might block: no
- *
- *      Notes: LLDs may call this at any time and we will do "The Right
- *              Thing"; interrupt context safe. 
- *
- *      Defined in: drivers/scsi/scsi.c .
- **/
-int scsi_track_queue_full(struct scsi_device *sdev, int depth)
-
-
-/**
- * scsi_unblock_requests - allow further commands to be queued to given host
- *
- * @shost: pointer to host to unblock commands on
- *
- *      Returns nothing
- *
- *      Might block: no
- *
- *      Defined in: drivers/scsi/scsi_lib.c .
-**/
-void scsi_unblock_requests(struct Scsi_Host * shost)
-
-
-/**
- * scsi_unregister - unregister and free memory used by host instance
- * @shp:        pointer to scsi host instance to unregister.
- *
- *      Returns nothing
- *
- *      Might block: no
- *
- *      Notes: Should not be invoked if the "hotplug initialization
- *      model" is being used. Called internally by exit_this_scsi_driver()
- *      in the "passive initialization model". Hence a LLD has no need to
- *      call this function directly.
- *
- *      Defined in: drivers/scsi/hosts.c .
- **/
-void scsi_unregister(struct Scsi_Host * shp)
-
-
-
-
-Interface Functions
-===================
-Interface functions are supplied (defined) by LLDs and their function
-pointers are placed in an instance of struct scsi_host_template which
-is passed to scsi_host_alloc() [or scsi_register() / init_this_scsi_driver()].
-Some are mandatory. Interface functions should be declared static. The
-accepted convention is that driver "xyz" will declare its slave_configure() 
-function as:
-    static int xyz_slave_configure(struct scsi_device * sdev);
-and so forth for all interface functions listed below.
-
-A pointer to this function should be placed in the 'slave_configure' member
-of a "struct scsi_host_template" instance. A pointer to such an instance
-should be passed to the mid level's scsi_host_alloc() [or scsi_register() /
-init_this_scsi_driver()].
-
-The interface functions are also described in the include/scsi/scsi_host.h
-file immediately above their definition point in "struct scsi_host_template".
-In some cases more detail is given in scsi_host.h than below.
-
-The interface functions are listed below in alphabetical order.
-
-Summary:
-   bios_param - fetch head, sector, cylinder info for a disk
-   eh_timed_out - notify the host that a command timer expired
-   eh_abort_handler - abort given command
-   eh_bus_reset_handler - issue SCSI bus reset
-   eh_device_reset_handler - issue SCSI device reset
-   eh_host_reset_handler - reset host (host bus adapter)
-   info - supply information about given host
-   ioctl - driver can respond to ioctls
-   proc_info - supports /proc/scsi/{driver_name}/{host_no}
-   queuecommand - queue scsi command, invoke 'done' on completion
-   slave_alloc - prior to any commands being sent to a new device 
-   slave_configure - driver fine tuning for given device after attach
-   slave_destroy - given device is about to be shut down
-
-
-Details:
-
-/**
- *      bios_param - fetch head, sector, cylinder info for a disk
- *      @sdev: pointer to scsi device context (defined in 
- *             include/scsi/scsi_device.h)
- *      @bdev: pointer to block device context (defined in fs.h)
- *      @capacity:  device size (in 512 byte sectors)
- *      @params: three element array to place output:
- *              params[0] number of heads (max 255)
- *              params[1] number of sectors (max 63)
- *              params[2] number of cylinders 
- *
- *      Return value is ignored
- *
- *      Locks: none
- *
- *      Calling context: process (sd)
- *
- *      Notes: an arbitrary geometry (based on READ CAPACITY) is used
- *      if this function is not provided. The params array is
- *      pre-initialized with made up values just in case this function 
- *      doesn't output anything.
- *
- *      Optionally defined in: LLD
- **/
-    int bios_param(struct scsi_device * sdev, struct block_device *bdev,
-                   sector_t capacity, int params[3])
-
-
-/**
- *      eh_timed_out - The timer for the command has just fired
- *      @scp: identifies command timing out
- *
- *      Returns:
- *
- *      EH_HANDLED:             I fixed the error, please complete the command
- *      EH_RESET_TIMER:         I need more time, reset the timer and
- *                              begin counting again
- *      EH_NOT_HANDLED          Begin normal error recovery
- *
- *
- *      Locks: None held
- *
- *      Calling context: interrupt
- *
- *      Notes: This is to give the LLD an opportunity to do local recovery.
- *      This recovery is limited to determining if the outstanding command
- *      will ever complete.  You may not abort and restart the command from
- *      this callback.
- *
- *      Optionally defined in: LLD
- **/
-     int eh_timed_out(struct scsi_cmnd * scp)
-
-
-/**
- *      eh_abort_handler - abort command associated with scp
- *      @scp: identifies command to be aborted
- *
- *      Returns SUCCESS if command aborted else FAILED
- *
- *      Locks: None held
- *
- *      Calling context: kernel thread
- *
- *      Notes: If 'no_async_abort' is defined this callback
- *  	will be invoked from scsi_eh thread. No other commands
- *	will then be queued on current host during eh.
- *	Otherwise it will be called whenever scsi_times_out()
- *      is called due to a command timeout.
- *
- *      Optionally defined in: LLD
- **/
-     int eh_abort_handler(struct scsi_cmnd * scp)
-
-
-/**
- *      eh_bus_reset_handler - issue SCSI bus reset
- *      @scp: SCSI bus that contains this device should be reset
- *
- *      Returns SUCCESS if command aborted else FAILED
- *
- *      Locks: None held
- *
- *      Calling context: kernel thread
- *
- *      Notes: Invoked from scsi_eh thread. No other commands will be
- *      queued on current host during eh.
- *
- *      Optionally defined in: LLD
- **/
-     int eh_bus_reset_handler(struct scsi_cmnd * scp)
-
-
-/**
- *      eh_device_reset_handler - issue SCSI device reset
- *      @scp: identifies SCSI device to be reset
- *
- *      Returns SUCCESS if command aborted else FAILED
- *
- *      Locks: None held
- *
- *      Calling context: kernel thread
- *
- *      Notes: Invoked from scsi_eh thread. No other commands will be
- *      queued on current host during eh.
- *
- *      Optionally defined in: LLD
- **/
-     int eh_device_reset_handler(struct scsi_cmnd * scp)
-
-
-/**
- *      eh_host_reset_handler - reset host (host bus adapter)
- *      @scp: SCSI host that contains this device should be reset
- *
- *      Returns SUCCESS if command aborted else FAILED
- *
- *      Locks: None held
- *
- *      Calling context: kernel thread
- *
- *      Notes: Invoked from scsi_eh thread. No other commands will be
- *      queued on current host during eh. 
- *      With the default eh_strategy in place, if none of the _abort_, 
- *      _device_reset_, _bus_reset_ or this eh handler function are 
- *      defined (or they all return FAILED) then the device in question 
- *      will be set offline whenever eh is invoked.
- *
- *      Optionally defined in: LLD
- **/
-     int eh_host_reset_handler(struct scsi_cmnd * scp)
-
-
-/**
- *      info - supply information about given host: driver name plus data
- *             to distinguish given host
- *      @shp: host to supply information about
- *
- *      Return ASCII null terminated string. [This driver is assumed to
- *      manage the memory pointed to and maintain it, typically for the
- *      lifetime of this host.]
- *
- *      Locks: none
- *
- *      Calling context: process
- *
- *      Notes: Often supplies PCI or ISA information such as IO addresses
- *      and interrupt numbers. If not supplied struct Scsi_Host::name used
- *      instead. It is assumed the returned information fits on one line 
- *      (i.e. does not included embedded newlines).
- *      The SCSI_IOCTL_PROBE_HOST ioctl yields the string returned by this
- *      function (or struct Scsi_Host::name if this function is not
- *      available).
- *      In a similar manner, init_this_scsi_driver() outputs to the console
- *      each host's "info" (or name) for the driver it is registering.
- *      Also if proc_info() is not supplied, the output of this function
- *      is used instead.
- *
- *      Optionally defined in: LLD
- **/
-    const char * info(struct Scsi_Host * shp)
-
-
-/**
- *      ioctl - driver can respond to ioctls
- *      @sdp: device that ioctl was issued for
- *      @cmd: ioctl number
- *      @arg: pointer to read or write data from. Since it points to
- *            user space, should use appropriate kernel functions
- *            (e.g. copy_from_user() ). In the Unix style this argument
- *            can also be viewed as an unsigned long.
- *
- *      Returns negative "errno" value when there is a problem. 0 or a
- *      positive value indicates success and is returned to the user space.
- *
- *      Locks: none
- *
- *      Calling context: process
- *
- *      Notes: The SCSI subsystem uses a "trickle down" ioctl model.
- *      The user issues an ioctl() against an upper level driver
- *      (e.g. /dev/sdc) and if the upper level driver doesn't recognize
- *      the 'cmd' then it is passed to the SCSI mid level. If the SCSI
- *      mid level does not recognize it, then the LLD that controls
- *      the device receives the ioctl. According to recent Unix standards
- *      unsupported ioctl() 'cmd' numbers should return -ENOTTY.
- *
- *      Optionally defined in: LLD
- **/
-    int ioctl(struct scsi_device *sdp, int cmd, void *arg)
-
-
-/**
- *      proc_info - supports /proc/scsi/{driver_name}/{host_no}
- *      @buffer: anchor point to output to (0==writeto1_read0) or fetch from
- *               (1==writeto1_read0).
- *      @start: where "interesting" data is written to. Ignored when
- *              1==writeto1_read0.
- *      @offset: offset within buffer 0==writeto1_read0 is actually
- *               interested in. Ignored when 1==writeto1_read0 .
- *      @length: maximum (or actual) extent of buffer
- *      @host_no: host number of interest (struct Scsi_Host::host_no)
- *      @writeto1_read0: 1 -> data coming from user space towards driver
- *                            (e.g. "echo some_string > /proc/scsi/xyz/2")
- *                       0 -> user what data from this driver
- *                            (e.g. "cat /proc/scsi/xyz/2")
- *
- *      Returns length when 1==writeto1_read0. Otherwise number of chars
- *      output to buffer past offset.
- *
- *      Locks: none held
- *
- *      Calling context: process
- *
- *      Notes: Driven from scsi_proc.c which interfaces to proc_fs. proc_fs
- *      support can now be configured out of the scsi subsystem.
- *
- *      Optionally defined in: LLD
- **/
-    int proc_info(char * buffer, char ** start, off_t offset, 
-                  int length, int host_no, int writeto1_read0)
-
-
-/**
- *      queuecommand - queue scsi command, invoke scp->scsi_done on completion
- *      @shost: pointer to the scsi host object
- *      @scp: pointer to scsi command object
- *
- *      Returns 0 on success.
- *
- *      If there's a failure, return either:
- *
- *      SCSI_MLQUEUE_DEVICE_BUSY if the device queue is full, or
- *      SCSI_MLQUEUE_HOST_BUSY if the entire host queue is full
- *
- *      On both of these returns, the mid-layer will requeue the I/O
- *
- *      - if the return is SCSI_MLQUEUE_DEVICE_BUSY, only that particular
- *      device will be paused, and it will be unpaused when a command to
- *      the device returns (or after a brief delay if there are no more
- *      outstanding commands to it).  Commands to other devices continue
- *      to be processed normally.
- *
- *      - if the return is SCSI_MLQUEUE_HOST_BUSY, all I/O to the host
- *      is paused and will be unpaused when any command returns from
- *      the host (or after a brief delay if there are no outstanding
- *      commands to the host).
- *
- *      For compatibility with earlier versions of queuecommand, any
- *      other return value is treated the same as
- *      SCSI_MLQUEUE_HOST_BUSY.
- *
- *      Other types of errors that are detected immediately may be
- *      flagged by setting scp->result to an appropriate value,
- *      invoking the scp->scsi_done callback, and then returning 0
- *      from this function. If the command is not performed
- *      immediately (and the LLD is starting (or will start) the given
- *      command) then this function should place 0 in scp->result and
- *      return 0.
- *
- *      Command ownership.  If the driver returns zero, it owns the
- *      command and must take responsibility for ensuring the
- *      scp->scsi_done callback is executed.  Note: the driver may
- *      call scp->scsi_done before returning zero, but after it has
- *      called scp->scsi_done, it may not return any value other than
- *      zero.  If the driver makes a non-zero return, it must not
- *      execute the command's scsi_done callback at any time.
- *
- *      Locks: up to and including 2.6.36, struct Scsi_Host::host_lock
- *             held on entry (with "irqsave") and is expected to be
- *             held on return. From 2.6.37 onwards, queuecommand is
- *             called without any locks held.
- *
- *      Calling context: in interrupt (soft irq) or process context
- *
- *      Notes: This function should be relatively fast. Normally it
- *      will not wait for IO to complete. Hence the scp->scsi_done
- *      callback is invoked (often directly from an interrupt service
- *      routine) some time after this function has returned. In some
- *      cases (e.g. pseudo adapter drivers that manufacture the
- *      response to a SCSI INQUIRY) the scp->scsi_done callback may be
- *      invoked before this function returns.  If the scp->scsi_done
- *      callback is not invoked within a certain period the SCSI mid
- *      level will commence error processing.  If a status of CHECK
- *      CONDITION is placed in "result" when the scp->scsi_done
- *      callback is invoked, then the LLD driver should perform
- *      autosense and fill in the struct scsi_cmnd::sense_buffer
- *      array. The scsi_cmnd::sense_buffer array is zeroed prior to
- *      the mid level queuing a command to an LLD.
- *
- *      Defined in: LLD
- **/
-    int queuecommand(struct Scsi_Host *shost, struct scsi_cmnd * scp)
-
-
-/**
- *      slave_alloc -   prior to any commands being sent to a new device 
- *                      (i.e. just prior to scan) this call is made
- *      @sdp: pointer to new device (about to be scanned)
- *
- *      Returns 0 if ok. Any other return is assumed to be an error and
- *      the device is ignored.
- *
- *      Locks: none
- *
- *      Calling context: process
- *
- *      Notes: Allows the driver to allocate any resources for a device
- *      prior to its initial scan. The corresponding scsi device may not
- *      exist but the mid level is just about to scan for it (i.e. send
- *      and INQUIRY command plus ...). If a device is found then
- *      slave_configure() will be called while if a device is not found
- *      slave_destroy() is called.
- *      For more details see the include/scsi/scsi_host.h file.
- *
- *      Optionally defined in: LLD
- **/
-    int slave_alloc(struct scsi_device *sdp)
-
-
-/**
- *      slave_configure - driver fine tuning for given device just after it
- *                     has been first scanned (i.e. it responded to an
- *                     INQUIRY)
- *      @sdp: device that has just been attached
- *
- *      Returns 0 if ok. Any other return is assumed to be an error and
- *      the device is taken offline. [offline devices will _not_ have
- *      slave_destroy() called on them so clean up resources.]
- *
- *      Locks: none
- *
- *      Calling context: process
- *
- *      Notes: Allows the driver to inspect the response to the initial
- *      INQUIRY done by the scanning code and take appropriate action.
- *      For more details see the include/scsi/scsi_host.h file.
- *
- *      Optionally defined in: LLD
- **/
-    int slave_configure(struct scsi_device *sdp)
-
-
-/**
- *      slave_destroy - given device is about to be shut down. All
- *                      activity has ceased on this device.
- *      @sdp: device that is about to be shut down
- *
- *      Returns nothing
- *
- *      Locks: none
- *
- *      Calling context: process
- *
- *      Notes: Mid level structures for given device are still in place
- *      but are about to be torn down. Any per device resources allocated
- *      by this driver for given device should be freed now. No further
- *      commands will be sent for this sdp instance. [However the device
- *      could be re-attached in the future in which case a new instance
- *      of struct scsi_device would be supplied by future slave_alloc()
- *      and slave_configure() calls.]
- *
- *      Optionally defined in: LLD
- **/
-    void slave_destroy(struct scsi_device *sdp)
-
-
-
-Data Structures
-===============
-struct scsi_host_template
--------------------------
-There is one "struct scsi_host_template" instance per LLD ***. It is
-typically initialized as a file scope static in a driver's header file. That
-way members that are not explicitly initialized will be set to 0 or NULL.
-Member of interest:
-    name         - name of driver (may contain spaces, please limit to
-                   less than 80 characters)
-    proc_name    - name used in "/proc/scsi/<proc_name>/<host_no>" and
-                   by sysfs in one of its "drivers" directories. Hence
-                   "proc_name" should only contain characters acceptable
-                   to a Unix file name.
-   (*queuecommand)() - primary callback that the mid level uses to inject
-                   SCSI commands into an LLD.
-The structure is defined and commented in include/scsi/scsi_host.h
-
-*** In extreme situations a single driver may have several instances
-    if it controls several different classes of hardware (e.g. an LLD
-    that handles both ISA and PCI cards and has a separate instance of
-    struct scsi_host_template for each class).
-
-struct Scsi_Host
-----------------
-There is one struct Scsi_Host instance per host (HBA) that an LLD
-controls. The struct Scsi_Host structure has many members in common
-with "struct scsi_host_template". When a new struct Scsi_Host instance
-is created (in scsi_host_alloc() in hosts.c) those common members are
-initialized from the driver's struct scsi_host_template instance. Members
-of interest:
-    host_no      - system wide unique number that is used for identifying
-                   this host. Issued in ascending order from 0.
-    can_queue    - must be greater than 0; do not send more than can_queue
-                   commands to the adapter.
-    this_id      - scsi id of host (scsi initiator) or -1 if not known
-    sg_tablesize - maximum scatter gather elements allowed by host.
-                   0 implies scatter gather not supported by host
-    max_sectors  - maximum number of sectors (usually 512 bytes) allowed
-                   in a single SCSI command. The default value of 0 leads
-                   to a setting of SCSI_DEFAULT_MAX_SECTORS (defined in
-                   scsi_host.h) which is currently set to 1024. So for a
-                   disk the maximum transfer size is 512 KB when max_sectors
-                   is not defined. Note that this size may not be sufficient
-                   for disk firmware uploads.
-    cmd_per_lun  - maximum number of commands that can be queued on devices
-                   controlled by the host. Overridden by LLD calls to
-                   scsi_change_queue_depth().
-    unchecked_isa_dma - 1=>only use bottom 16 MB of ram (ISA DMA addressing
-                   restriction), 0=>can use full 32 bit (or better) DMA
-                   address space
-    no_async_abort - 1=>Asynchronous aborts are not supported
-                     0=>Timed-out commands will be aborted asynchronously
-    hostt        - pointer to driver's struct scsi_host_template from which
-                   this struct Scsi_Host instance was spawned
-    hostt->proc_name  - name of LLD. This is the driver name that sysfs uses
-    transportt   - pointer to driver's struct scsi_transport_template instance
-                   (if any). FC and SPI transports currently supported.
-    sh_list      - a double linked list of pointers to all struct Scsi_Host
-                   instances (currently ordered by ascending host_no)
-    my_devices   - a double linked list of pointers to struct scsi_device 
-                   instances that belong to this host.
-    hostdata[0]  - area reserved for LLD at end of struct Scsi_Host. Size
-                   is set by the second argument (named 'xtr_bytes') to
-                   scsi_host_alloc() or scsi_register().
-    vendor_id    - a unique value that identifies the vendor supplying
-                   the LLD for the Scsi_Host.  Used most often in validating
-                   vendor-specific message requests.  Value consists of an
-                   identifier type and a vendor-specific value.
-                   See scsi_netlink.h for a description of valid formats.
-
-The scsi_host structure is defined in include/scsi/scsi_host.h
-
-struct scsi_device
-------------------
-Generally, there is one instance of this structure for each SCSI logical unit
-on a host. Scsi devices connected to a host are uniquely identified by a
-channel number, target id and logical unit number (lun).
-The structure is defined in include/scsi/scsi_device.h
-
-struct scsi_cmnd
-----------------
-Instances of this structure convey SCSI commands to the LLD and responses
-back to the mid level. The SCSI mid level will ensure that no more SCSI
-commands become queued against the LLD than are indicated by
-scsi_change_queue_depth() (or struct Scsi_Host::cmd_per_lun). There will
-be at least one instance of struct scsi_cmnd available for each SCSI device.
-Members of interest:
-    cmnd         - array containing SCSI command
-    cmnd_len     - length (in bytes) of SCSI command
-    sc_data_direction - direction of data transfer in data phase. See
-                "enum dma_data_direction" in include/linux/dma-mapping.h
-    request_bufflen - number of data bytes to transfer (0 if no data phase)
-    use_sg       - ==0 -> no scatter gather list, hence transfer data
-                          to/from request_buffer
-                 - >0 ->  scatter gather list (actually an array) in
-                          request_buffer with use_sg elements
-    request_buffer - either contains data buffer or scatter gather list
-                     depending on the setting of use_sg. Scatter gather
-                     elements are defined by 'struct scatterlist' found
-                     in include/linux/scatterlist.h .
-    done         - function pointer that should be invoked by LLD when the
-                   SCSI command is completed (successfully or otherwise).
-                   Should only be called by an LLD if the LLD has accepted
-                   the command (i.e. queuecommand() returned or will return
-                   0). The LLD may invoke 'done'  prior to queuecommand()
-                   finishing.
-    result       - should be set by LLD prior to calling 'done'. A value
-                   of 0 implies a successfully completed command (and all
-                   data (if any) has been transferred to or from the SCSI
-                   target device). 'result' is a 32 bit unsigned integer that
-                   can be viewed as 4 related bytes. The SCSI status value is
-                   in the LSB. See include/scsi/scsi.h status_byte(),
-                   msg_byte(), host_byte() and driver_byte() macros and
-                   related constants.
-    sense_buffer - an array (maximum size: SCSI_SENSE_BUFFERSIZE bytes) that
-                   should be written when the SCSI status (LSB of 'result')
-                   is set to CHECK_CONDITION (2). When CHECK_CONDITION is
-                   set, if the top nibble of sense_buffer[0] has the value 7
-                   then the mid level will assume the sense_buffer array
-                   contains a valid SCSI sense buffer; otherwise the mid
-                   level will issue a REQUEST_SENSE SCSI command to
-                   retrieve the sense buffer. The latter strategy is error
-                   prone in the presence of command queuing so the LLD should
-                   always "auto-sense".
-    device       - pointer to scsi_device object that this command is
-                   associated with.
-    resid        - an LLD should set this signed integer to the requested
-                   transfer length (i.e. 'request_bufflen') less the number
-                   of bytes that are actually transferred. 'resid' is
-                   preset to 0 so an LLD can ignore it if it cannot detect
-                   underruns (overruns should be rare). If possible an LLD
-                   should set 'resid' prior to invoking 'done'. The most
-                   interesting case is data transfers from a SCSI target
-                   device (e.g. READs) that underrun.
-    underflow    - LLD should place (DID_ERROR << 16) in 'result' if
-                   actual number of bytes transferred is less than this
-                   figure. Not many LLDs implement this check and some that
-                   do just output an error message to the log rather than
-                   report a DID_ERROR. Better for an LLD to implement
-                   'resid'.
-
-It is recommended that a LLD set 'resid' on data transfers from a SCSI
-target device (e.g. READs). It is especially important that 'resid' is set
-when such data transfers have sense keys of MEDIUM ERROR and HARDWARE ERROR
-(and possibly RECOVERED ERROR). In these cases if a LLD is in doubt how much
-data has been received then the safest approach is to indicate no bytes have
-been received. For example: to indicate that no valid data has been received
-a LLD might use these helpers:
-    scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
-where 'SCpnt' is a pointer to a scsi_cmnd object. To indicate only three 512
-bytes blocks has been received 'resid' could be set like this:
-    scsi_set_resid(SCpnt, scsi_bufflen(SCpnt) - (3 * 512));
-
-The scsi_cmnd structure is defined in include/scsi/scsi_cmnd.h
-
-
-Locks
-=====
-Each struct Scsi_Host instance has a spin_lock called struct 
-Scsi_Host::default_lock which is initialized in scsi_host_alloc() [found in 
-hosts.c]. Within the same function the struct Scsi_Host::host_lock pointer
-is initialized to point at default_lock.  Thereafter lock and unlock
-operations performed by the mid level use the struct Scsi_Host::host_lock
-pointer.  Previously drivers could override the host_lock pointer but
-this is not allowed anymore.
-
-
-Autosense
-=========
-Autosense (or auto-sense) is defined in the SAM-2 document as "the
-automatic return of sense data to the application client coincident
-with the completion of a SCSI command" when a status of CHECK CONDITION
-occurs. LLDs should perform autosense. This should be done when the LLD
-detects a CHECK CONDITION status by either: 
-    a) instructing the SCSI protocol (e.g. SCSI Parallel Interface (SPI))
-       to perform an extra data in phase on such responses
-    b) or, the LLD issuing a REQUEST SENSE command itself
-
-Either way, when a status of CHECK CONDITION is detected, the mid level
-decides whether the LLD has performed autosense by checking struct 
-scsi_cmnd::sense_buffer[0] . If this byte has an upper nibble of 7 (or 0xf)
-then autosense is assumed to have taken place. If it has another value (and
-this byte is initialized to 0 before each command) then the mid level will
-issue a REQUEST SENSE command.
-
-In the presence of queued commands the "nexus" that maintains sense
-buffer data from the command that failed until a following REQUEST SENSE
-may get out of synchronization. This is why it is best for the LLD
-to perform autosense.
-
-
-Changes since lk 2.4 series
-===========================
-io_request_lock has been replaced by several finer grained locks. The lock 
-relevant to LLDs is struct Scsi_Host::host_lock and there is
-one per SCSI host.
-
-The older error handling mechanism has been removed. This means the
-LLD interface functions abort() and reset() have been removed.
-The struct scsi_host_template::use_new_eh_code flag has been removed.
-
-In the 2.4 series the SCSI subsystem configuration descriptions were 
-aggregated with the configuration descriptions from all other Linux 
-subsystems in the Documentation/Configure.help file. In the 2.6 series, 
-the SCSI subsystem now has its own (much smaller) drivers/scsi/Kconfig
-file that contains both configuration and help information.
-
-struct SHT has been renamed to struct scsi_host_template.
-
-Addition of the "hotplug initialization model" and many extra functions
-to support it.
-
-
-Credits
-=======
-The following people have contributed to this document:
-        Mike Anderson <andmike at us dot ibm dot com>
-        James Bottomley <James dot Bottomley at hansenpartnership dot com>
-        Patrick Mansfield <patmans at us dot ibm dot com> 
-        Christoph Hellwig <hch at infradead dot org>
-        Doug Ledford <dledford at redhat dot com>
-        Andries Brouwer <Andries dot Brouwer at cwi dot nl>
-        Randy Dunlap <rdunlap at xenotime dot net>
-        Alan Stern <stern at rowland dot harvard dot edu>
-
-
-Douglas Gilbert
-dgilbert at interlog dot com
-21st September 2004
-- 
2.11.0

