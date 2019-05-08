Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BDCC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EECD216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8s8Py93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfEHPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46290 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfEHPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so178246pfm.13;
        Wed, 08 May 2019 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auSrnHuAF31y4BaeRC5x0jkMuUVcEeYH6Csq4j1xC8U=;
        b=i8s8Py93BMqyZZJqhZiyl63ogF3U5EV3QLlaXIsCZKVdFMUdw2wr+LAksQ2tepaM5j
         X3TugxIrq5VsD0S6yQjzxt9BVFi42TPi7FC5fprIdpRoqIYbKszLuhIeCxnCHJ2oZSQC
         5L9fsYW8/fa+rH34BTITqiyEfxiQWiI3krl4qXcScUiq5BdWH0r8qZgJnvKzk64P/kqZ
         uSm7scuppFD3sHVsipA7ewBypFxgCqVjfPsQnF5j2XJcPrWBEUapqjv/Q/XBoDsHnYo2
         N6jPDseEjZNRgwQf37WdbU+c9DeDiuJckIIpwsCG64ykPcsawnlioxzIUboZq86nxzH8
         4nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auSrnHuAF31y4BaeRC5x0jkMuUVcEeYH6Csq4j1xC8U=;
        b=VIz/9lgPeCZ4zpB+NPxWY+OSahC3xye4j9KgMXHveaPIOzxh76w0jp1s2498tQau2k
         p2HOcvVJATnvlf+qePRM5uW5YzJQVcT0XrbFc6BfFtvHlgQB+FV8bphJwGnpJa9cslqw
         vj9PBTj0CUzW6lSik3KuOLq5PJgjZ6uxOHQp2cUBxKcI7ObtbRR5MvYIHzyLgrZYJaUm
         UC76b5ek63OfoVSAtYzRAi9C/dA/5sj2+868qofw3utLJiBbfEyWX3wxZE5R9tTn3wsd
         iET2TDET/s8AnlBt87fz2WysIYgqYjP8M7mLuCtTQgpCPsJPlA89el4VxWzYbPz2g9rq
         bWNQ==
X-Gm-Message-State: APjAAAUjxRZgE6zU+jOk02GMNQNHO3KEh1TxtZXxD2urKzDGdxFp1vw0
        2vNRjCUcszKbJsnHo0LUzZ8=
X-Google-Smtp-Source: APXvYqyh4Rcu8AKgqWB/bHOS8P/RcWdBaNrxTfj+rnQY/N2YMUnY7kbALFzc7TkaJ7h1QJ2cWLL1+w==
X-Received: by 2002:a62:6b44:: with SMTP id g65mr49587206pfc.27.1557328964044;
        Wed, 08 May 2019 08:22:44 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.22.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:22:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 07/27] Documentation: x86: convert earlyprintk.txt to reST
Date:   Wed,  8 May 2019 23:21:21 +0800
Message-Id: <20190508152141.8740-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
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
 .../x86/{earlyprintk.txt => earlyprintk.rst}  | 122 ++++++++++--------
 Documentation/x86/index.rst                   |   1 +
 2 files changed, 67 insertions(+), 56 deletions(-)
 rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (51%)

diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.rst
similarity index 51%
rename from Documentation/x86/earlyprintk.txt
rename to Documentation/x86/earlyprintk.rst
index 46933e06c972..11307378acf0 100644
--- a/Documentation/x86/earlyprintk.txt
+++ b/Documentation/x86/earlyprintk.rst
@@ -1,52 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Early Printk
+============
 
 Mini-HOWTO for using the earlyprintk=dbgp boot option with a
 USB2 Debug port key and a debug cable, on x86 systems.
 
 You need two computers, the 'USB debug key' special gadget and
-and two USB cables, connected like this:
+and two USB cables, connected like this::
 
   [host/target] <-------> [USB debug key] <-------> [client/console]
 
-1. There are a number of specific hardware requirements:
-
- a.) Host/target system needs to have USB debug port capability.
-
- You can check this capability by looking at a 'Debug port' bit in
- the lspci -vvv output:
-
- # lspci -vvv
- ...
- 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
-         Subsystem: Lenovo ThinkPad T61
-         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
-         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-         Latency: 0
-         Interrupt: pin D routed to IRQ 19
-         Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
-         Capabilities: [50] Power Management version 2
-                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
-                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
-         Capabilities: [58] Debug port: BAR=1 offset=00a0
+Hardware requirements
+=====================
+
+  a) Host/target system needs to have USB debug port capability.
+
+     You can check this capability by looking at a 'Debug port' bit in
+     the lspci -vvv output::
+
+       # lspci -vvv
+       ...
+       00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
+               Subsystem: Lenovo ThinkPad T61
+               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
+               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
+               Latency: 0
+               Interrupt: pin D routed to IRQ 19
+               Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
+               Capabilities: [50] Power Management version 2
+                       Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
+                       Status: D0 PME-Enable- DSel=0 DScale=0 PME+
+               Capabilities: [58] Debug port: BAR=1 offset=00a0
                             ^^^^^^^^^^^ <==================== [ HERE ]
-	 Kernel driver in use: ehci_hcd
-         Kernel modules: ehci-hcd
- ...
+               Kernel driver in use: ehci_hcd
+               Kernel modules: ehci-hcd
+       ...
 
-( If your system does not list a debug port capability then you probably
-  won't be able to use the USB debug key. )
+     .. note::
+       If your system does not list a debug port capability then you probably
+       won't be able to use the USB debug key.
 
- b.) You also need a NetChip USB debug cable/key:
+  b) You also need a NetChip USB debug cable/key:
 
         http://www.plxtech.com/products/NET2000/NET20DC/default.asp
 
      This is a small blue plastic connector with two USB connections;
      it draws power from its USB connections.
 
- c.) You need a second client/console system with a high speed USB 2.0
-     port.
+  c) You need a second client/console system with a high speed USB 2.0 port.
 
- d.) The NetChip device must be plugged directly into the physical
-     debug port on the "host/target" system.  You cannot use a USB hub in
+  d) The NetChip device must be plugged directly into the physical
+     debug port on the "host/target" system. You cannot use a USB hub in
      between the physical debug port and the "host/target" system.
 
      The EHCI debug controller is bound to a specific physical USB
@@ -65,29 +71,31 @@ and two USB cables, connected like this:
      to the hardware vendor, because there is no reason not to wire
      this port into one of the physically accessible ports.
 
- e.) It is also important to note, that many versions of the NetChip
+  e) It is also important to note, that many versions of the NetChip
      device require the "client/console" system to be plugged into the
      right hand side of the device (with the product logo facing up and
      readable left to right).  The reason being is that the 5 volt
      power supply is taken from only one side of the device and it
      must be the side that does not get rebooted.
 
-2. Software requirements:
+Software requirements
+=====================
 
- a.) On the host/target system:
+  a) On the host/target system:
 
-    You need to enable the following kernel config option:
+    You need to enable the following kernel config option::
 
       CONFIG_EARLY_PRINTK_DBGP=y
 
     And you need to add the boot command line: "earlyprintk=dbgp".
 
-    (If you are using Grub, append it to the 'kernel' line in
-     /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
-     append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
-     using Grub2 on an EFI firmware system, append it to the 'linux'
-     or 'linuxefi' line in /boot/grub2/grub.cfg or
-     /boot/efi/EFI/<distro>/grub.cfg.)
+    .. note::
+      If you are using Grub, append it to the 'kernel' line in
+      /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
+      append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
+      using Grub2 on an EFI firmware system, append it to the 'linux'
+      or 'linuxefi' line in /boot/grub2/grub.cfg or
+      /boot/efi/EFI/<distro>/grub.cfg.
 
     On systems with more than one EHCI debug controller you must
     specify the correct EHCI debug controller number.  The ordering
@@ -96,14 +104,15 @@ and two USB cables, connected like this:
     controller.  To use the second EHCI debug controller, you would
     use the command line: "earlyprintk=dbgp1"
 
-    NOTE: normally earlyprintk console gets turned off once the
-    regular console is alive - use "earlyprintk=dbgp,keep" to keep
-    this channel open beyond early bootup. This can be useful for
-    debugging crashes under Xorg, etc.
+    .. note::
+      normally earlyprintk console gets turned off once the
+      regular console is alive - use "earlyprintk=dbgp,keep" to keep
+      this channel open beyond early bootup. This can be useful for
+      debugging crashes under Xorg, etc.
 
- b.) On the client/console system:
+  b) On the client/console system:
 
-    You should enable the following kernel config option:
+    You should enable the following kernel config option::
 
       CONFIG_USB_SERIAL_DEBUG=y
 
@@ -115,27 +124,28 @@ and two USB cables, connected like this:
     it up to use /dev/ttyUSB0 - or use a raw 'cat /dev/ttyUSBx' to
     see the raw output.
 
- c.) On Nvidia Southbridge based systems: the kernel will try to probe
+  c) On Nvidia Southbridge based systems: the kernel will try to probe
      and find out which port has a debug device connected.
 
-3. Testing that it works fine:
+Testing
+=======
 
-   You can test the output by using earlyprintk=dbgp,keep and provoking
-   kernel messages on the host/target system. You can provoke a harmless
-   kernel message by for example doing:
+You can test the output by using earlyprintk=dbgp,keep and provoking
+kernel messages on the host/target system. You can provoke a harmless
+kernel message by for example doing::
 
      echo h > /proc/sysrq-trigger
 
-   On the host/target system you should see this help line in "dmesg" output:
+On the host/target system you should see this help line in "dmesg" output::
 
      SysRq : HELP : loglevel(0-9) reBoot Crashdump terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) saK show-backtrace-all-active-cpus(L) show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z)
 
-   On the client/console system do:
+On the client/console system do::
 
        cat /dev/ttyUSB0
 
-   And you should see the help line above displayed shortly after you've
-   provoked it on the host system.
+And you should see the help line above displayed shortly after you've
+provoked it on the host system.
 
 If it does not work then please ask about it on the linux-kernel@vger.kernel.org
 mailing list or contact the x86 maintainers.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 0e3e73458738..d9ccc0f39279 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -13,3 +13,4 @@ x86-specific Documentation
    exception-tables
    kernel-stacks
    entry_64
+   earlyprintk
-- 
2.20.1

