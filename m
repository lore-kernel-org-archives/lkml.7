Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0569C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF8B2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBgIV6IP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLZVUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:20:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46341 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:20:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id n9so5879720pff.13;
        Thu, 26 Dec 2019 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wX+3hEenfXmN/mMKz5HHbE+R5xnrJ17FFJfmiklS2VA=;
        b=mBgIV6IPjR5UfU361VDPPLf2e1YQTyNYoni3gMBJexiykdildPARy++kDn7KJhwl2y
         h73pv4AjtEp67+l+TeyoTCXgAdCB1uDkAvLntoUHjz3+Bbdib2pXHLHf6XTE2F64a6s8
         XBUPavunIyEWYVdmrXGRAscYuGeMECj1EyG/Vr0U4Omsp6te3NNxJ5xnZt23MgExYfz0
         9ukiuunWA+mdnjkk8SuJUeaNS/76QUEdIalKAA2c2AUWmoUIo87jaYVQPKQ/abnr3XKE
         L1EeoriA1wHHCQICP2o26h6Z2L2tsw5wiOh8FgS5cUlcSxseANQ9FnbEAY/QQbyQ1vJt
         PqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wX+3hEenfXmN/mMKz5HHbE+R5xnrJ17FFJfmiklS2VA=;
        b=OrFR+vJnNVs7kTZWDK/HPgv5QXE1pR3wfI61pc9SF6CtJEb596RL/i9bMDms7qDIiA
         hPfGOjt0CRiW0/7jDKUZnrztT3YM3E4a93KqfoNfpA5IvrRybFsz2TzI+bYJM9jaRdUd
         2OPds3Y2izZtyMkiMyIZbATQbqZhIZSbA/x39vke4w6z7M6/pjl/jcr59qrQ9qrtoQUb
         NXlp3VmXfCnscNhI67W9B8LklHp5djHEErUtpM5TcJrE7h2QpXx0N6LfhmkaPqcYXwws
         pXO/BreeoQ6tnK7mN0Mp2L19OnwHdA+25VKzREiehbTgncXv4lUQdpsy19OUHtrdCeiI
         ZZqg==
X-Gm-Message-State: APjAAAXhbeBn7Y4OmefIDpLGQMuZzFx+DY9eZ0YFbzbj86awBzPodWpJ
        dsmq3ZpcpTVlbWpc/81Q54E=
X-Google-Smtp-Source: APXvYqwiU53JYGSwA0PfrtY5tnUtphiPZ9CcUiAzJt9D2DrV8QVtdV9uBqJ6fVYTbyz/sRC4cvOXtQ==
X-Received: by 2002:a63:215f:: with SMTP id s31mr49208815pgm.27.1577395206554;
        Thu, 26 Dec 2019 13:20:06 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id b22sm35114380pft.110.2019.12.26.13.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:20:06 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/5] Documentation: nfsroot.txt: convert to ReST
Date:   Thu, 26 Dec 2019 18:19:44 -0300
Message-Id: <92be5a49b967ce35a305fc5ccfb3efea3f61a19a.1577394517.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577394517.git.dwlsalmeida@gmail.com>
References: <cover.1577394517.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert nfsroot.txt to RST and move it to admin-guide. Content remains
mostly the same.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |   1 +
 .../nfs/nfsroot.rst}                          | 140 ++++++++++--------
 2 files changed, 76 insertions(+), 65 deletions(-)
 rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (83%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index f5c0180f4e5e..c2b87e9f0fed 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -6,4 +6,5 @@ NFS
     :maxdepth: 1
 
     nfs-client
+    nfsroot
 
diff --git a/Documentation/filesystems/nfs/nfsroot.txt b/Documentation/admin-guide/nfs/nfsroot.rst
similarity index 83%
rename from Documentation/filesystems/nfs/nfsroot.txt
rename to Documentation/admin-guide/nfs/nfsroot.rst
index ae4332464560..85d834ad3d03 100644
--- a/Documentation/filesystems/nfs/nfsroot.txt
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -1,18 +1,24 @@
+===============================================
 Mounting the root filesystem via NFS (nfsroot)
 ===============================================
 
-Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
-Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
-Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
-Updated 2006 by Horms <horms@verge.net.au>
-Updated 2018 by Chris Novakovic <chris@chrisn.me.uk>
+:Authors:
+	Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
+
+	Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+
+	Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
+
+	Updated 2006 by Horms <horms@verge.net.au>
+
+	Updated 2018 by Chris Novakovic <chris@chrisn.me.uk>
 
 
 
 In order to use a diskless system, such as an X-terminal or printer server
 for example, it is necessary for the root filesystem to be present on a
-non-disk device. This may be an initramfs (see Documentation/filesystems/
-ramfs-rootfs-initramfs.txt), a ramdisk (see Documentation/admin-guide/initrd.rst) or a
+non-disk device. This may be an initramfs (see Documentation/filesystems/ramfs-rootfs-initramfs.txt`),
+a ramdisk (see Documentation/admin-guide/initrd.rst) or a
 filesystem mounted via NFS. The following text describes on how to use NFS
 for the root filesystem. For the rest of this text 'client' means the
 diskless system, and 'server' means the NFS server.
@@ -20,8 +26,8 @@ diskless system, and 'server' means the NFS server.
 
 
 
-1.) Enabling nfsroot capabilities
-    -----------------------------
+Enabling nfsroot capabilities
+=============================
 
 In order to use nfsroot, NFS client support needs to be selected as
 built-in during configuration. Once this has been selected, the nfsroot
@@ -34,8 +40,8 @@ DHCP, BOOTP and RARP is safe.
 
 
 
-2.) Kernel command line
-    -------------------
+Kernel command line
+===================
 
 When the kernel has been loaded by a boot loader (see below) it needs to be
 told what root fs device to use. And in the case of nfsroot, where to find
@@ -44,19 +50,17 @@ This can be established using the following kernel command line parameters:
 
 
 root=/dev/nfs
-
   This is necessary to enable the pseudo-NFS-device. Note that it's not a
   real device but just a synonym to tell the kernel to use NFS instead of
   a real device.
 
 
 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
-
   If the `nfsroot' parameter is NOT given on the command line,
-  the default "/tftpboot/%s" will be used.
+  the default ``"/tftpboot/%s"`` will be used.
 
   <server-ip>	Specifies the IP address of the NFS server.
-		The default address is determined by the `ip' parameter
+		The default address is determined by the ip parameter
 		(see below). This parameter allows the use of different
 		servers for IP autoconfiguration and NFS.
 
@@ -67,6 +71,9 @@ nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
 
   <nfs-options>	Standard NFS options. All options are separated by commas.
 		The following defaults are used:
+
+		::
+
 			port		= as given by server portmap daemon
 			rsize		= 4096
 			wsize		= 4096
@@ -79,13 +86,11 @@ nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
 			flags		= hard, nointr, noposix, cto, ac
 
 
-ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
-   <dns0-ip>:<dns1-ip>:<ntp0-ip>
-
+ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:<dns0-ip>:<dns1-ip>:<ntp0-ip>
   This parameter tells the kernel how to configure IP addresses of devices
   and also how to set up the IP routing table. It was originally called
-  `nfsaddrs', but now the boot-time IP configuration works independently of
-  NFS, so it was renamed to `ip' and the old name remained as an alias for
+  nfsaddrs, but now the boot-time IP configuration works independently of
+  NFS, so it was renamed to ip and the old name remained as an alias for
   compatibility reasons.
 
   If this parameter is missing from the kernel command line, all fields are
@@ -93,17 +98,17 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
   this means that the kernel tries to configure everything using
   autoconfiguration.
 
-  The <autoconf> parameter can appear alone as the value to the `ip'
+  The <autoconf> parameter can appear alone as the value to the ip
   parameter (without all the ':' characters before).  If the value is
   "ip=off" or "ip=none", no autoconfiguration will take place, otherwise
   autoconfiguration will take place.  The most common way to use this
   is "ip=dhcp".
 
   <client-ip>	IP address of the client.
-
   		Default:  Determined using autoconfiguration.
 
-  <server-ip>	IP address of the NFS server. If RARP is used to determine
+  <server-ip>	IP address of the NFS server.
+		If RARP is used to determine
 		the client address and this parameter is NOT empty only
 		replies from the specified server are accepted.
 
@@ -115,19 +120,19 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
 		(see below).
 
 		Default: Determined using autoconfiguration.
-		         The address of the autoconfiguration server is used.
+		The address of the autoconfiguration server is used.
 
   <gw-ip>	IP address of a gateway if the server is on a different subnet.
-
 		Default: Determined using autoconfiguration.
 
-  <netmask>	Netmask for local network interface. If unspecified
-		the netmask is derived from the client IP address assuming
-		classful addressing.
+  <netmask>	Netmask for local network interface.
+  		If unspecified the netmask is derived from the client IP address
+		assuming classful addressing.
 
 		Default:  Determined using autoconfiguration.
 
-  <hostname>	Name of the client. If a '.' character is present, anything
+  <hostname>	Name of the client.
+  		If a '.' character is present, anything
 		before the first '.' is used as the client's hostname, and anything
 		after it is used as its NIS domain name. May be supplied by
 		autoconfiguration, but its absence will not trigger autoconfiguration.
@@ -138,21 +143,21 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
   		Default: Client IP address is used in ASCII notation.
 
   <device>	Name of network device to use.
-
 		Default: If the host only has one device, it is used.
-			 Otherwise the device is determined using
-			 autoconfiguration. This is done by sending
-			 autoconfiguration requests out of all devices,
-			 and using the device that received the first reply.
-
-  <autoconf>	Method to use for autoconfiguration. In the case of options
-                which specify multiple autoconfiguration protocols,
+		Otherwise the device is determined using
+		autoconfiguration. This is done by sending
+		autoconfiguration requests out of all devices,
+		and using the device that received the first reply.
+
+  <autoconf>	Method to use for autoconfiguration.
+  		In the case of options
+		which specify multiple autoconfiguration protocols,
 		requests are sent using all protocols, and the first one
 		to reply is used.
 
 		Only autoconfiguration protocols that have been compiled
 		into the kernel will be used, regardless of the value of
-		this option.
+		this option::
 
                   off or none: don't use autoconfiguration
 				(do static IP assignment instead)
@@ -221,7 +226,6 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:
 
 
 nfsrootdebug
-
   This parameter enables debugging messages to appear in the kernel
   log at boot time so that administrators can verify that the correct
   NFS mount options, server address, and root path are passed to the
@@ -229,36 +233,32 @@ nfsrootdebug
 
 
 rdinit=<executable file>
-
   To specify which file contains the program that starts system
   initialization, administrators can use this command line parameter.
   The default value of this parameter is "/init".  If the specified
   file exists and the kernel can execute it, root filesystem related
-  kernel command line parameters, including `nfsroot=', are ignored.
+  kernel command line parameters, including 'nfsroot=', are ignored.
 
   A description of the process of mounting the root file system can be
-  found in:
-
-    Documentation/driver-api/early-userspace/early_userspace_support.rst
-
+  found in Documentation/driver-api/early-userspace/early_userspace_support.rst
 
 
-
-3.) Boot Loader
-    ----------
+Boot Loader
+===========
 
 To get the kernel into memory different approaches can be used.
 They depend on various facilities being available:
 
 
-3.1)  Booting from a floppy using syslinux
+#. Booting from a floppy using syslinux
 
 	When building kernels, an easy way to create a boot floppy that uses
 	syslinux is to use the zdisk or bzdisk make targets which use zimage
       	and bzimage images respectively. Both targets accept the
      	FDARGS parameter which can be used to set the kernel command line.
 
-	e.g.
+	e.g::
+
 	   make bzdisk FDARGS="root=/dev/nfs"
 
    	Note that the user running this command will need to have
@@ -267,32 +267,36 @@ They depend on various facilities being available:
      	For more information on syslinux, including how to create bootdisks
      	for prebuilt kernels, see http://syslinux.zytor.com/
 
-	N.B: Previously it was possible to write a kernel directly to
-	     a floppy using dd, configure the boot device using rdev, and
-	     boot using the resulting floppy. Linux no longer supports this
-	     method of booting.
+	.. note::
+		Previously it was possible to write a kernel directly to
+		a floppy using dd, configure the boot device using rdev, and
+		boot using the resulting floppy. Linux no longer supports this
+		method of booting.
 
-3.2) Booting from a cdrom using isolinux
+#. Booting from a cdrom using isolinux
 
      	When building kernels, an easy way to create a bootable cdrom that
      	uses isolinux is to use the isoimage target which uses a bzimage
      	image. Like zdisk and bzdisk, this target accepts the FDARGS
      	parameter which can be used to set the kernel command line.
 
-	e.g.
+	e.g::
+
 	  make isoimage FDARGS="root=/dev/nfs"
 
      	The resulting iso image will be arch/<ARCH>/boot/image.iso
      	This can be written to a cdrom using a variety of tools including
      	cdrecord.
 
-	e.g.
+	e.g::
+
 	  cdrecord dev=ATAPI:1,0,0 arch/x86/boot/image.iso
 
      	For more information on isolinux, including how to create bootdisks
      	for prebuilt kernels, see http://syslinux.zytor.com/
 
-3.2) Using LILO
+#.  Using LILO
+
 	When using LILO all the necessary command line parameters may be
 	specified using the 'append=' directive in the LILO configuration
 	file.
@@ -300,15 +304,19 @@ They depend on various facilities being available:
 	However, to use the 'root=' directive you also need to create
 	a dummy root device, which may be removed after LILO is run.
 
-	mknod /dev/boot255 c 0 255
+	e.g::
+
+	  mknod /dev/boot255 c 0 255
 
 	For information on configuring LILO, please refer to its documentation.
 
-3.3) Using GRUB
+#. Using GRUB
+
 	When using GRUB, kernel parameter are simply appended after the kernel
 	specification: kernel <kernel> <parameters>
 
-3.4) Using loadlin
+#. Using loadlin
+
 	loadlin may be used to boot Linux from a DOS command prompt without
 	requiring a local hard disk to mount as root. This has not been
 	thoroughly tested by the authors of this document, but in general
@@ -317,7 +325,8 @@ They depend on various facilities being available:
 
 	Please refer to the loadlin documentation for further information.
 
-3.5) Using a boot ROM
+#. Using a boot ROM
+
 	This is probably the most elegant way of booting a diskless client.
 	With a boot ROM the kernel is loaded using the TFTP protocol. The
 	authors of this document are not aware of any no commercial boot
@@ -326,7 +335,8 @@ They depend on various facilities being available:
 	etherboot, both of which are available on sunsite.unc.edu, and both
 	of which contain everything you need to boot a diskless Linux client.
 
-3.6) Using pxelinux
+#. Using pxelinux
+
 	Pxelinux may be used to boot linux using the PXE boot loader
 	which is present on many modern network cards.
 
@@ -342,8 +352,8 @@ They depend on various facilities being available:
 
 
 
-4.) Credits
-    -------
+Credits
+=======
 
   The nfsroot code in the kernel and the RARP support have been written
   by Gero Kuhlmann <gero@gkminix.han.de>.
-- 
2.24.1

