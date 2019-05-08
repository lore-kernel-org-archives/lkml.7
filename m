Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDBDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C1720644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOeSVHXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfEHPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:24:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34010 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfEHPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:24:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so2121701pfa.1;
        Wed, 08 May 2019 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykczYcAuczt96cphriyTm0it0An+cr/BFVb6zPYJcfA=;
        b=kOeSVHXoag8JFooHCfwA65IwLnlZ02Mmmotkn8gf+8gOQhNQCnaxb2dg6BBDR5l3bT
         v75h16CZJArLfz0qcRSpsoi2fkHcY6ev0PWYGj8+ig4B7SKD4xLE4JdgGFuI/w8aXaID
         ERxXDxXsaczhaH3peDweEH7jXkqvzS/ZiCijdcWBoWXMNWU/NIq4fe2DGKyYVuWUPove
         ZF+avnTodICsret/N/ruhWYVNGWqedcMbqrbYplBUCg3fDqNCChlppLP2sUfyiajfh7o
         6Gs1Y6rv9qgmj/b65PhdqNJL4damMxh7QCRRFTdqYHkbmq04Np9eIp016UpNIaJDuN9r
         i79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykczYcAuczt96cphriyTm0it0An+cr/BFVb6zPYJcfA=;
        b=KKNyHudPdcIrG6bqNTw0VxW3Rj6l5fKaEpQAM1XyNM5Jj9PgJaewNnkl7UHYduvfnT
         sQ59I9rNaQ4gO+swqTWHO0/8wyO7nphby0RV5fBKHADyyHJZgge643P2FrzR/DDHcSbz
         yM0xSHR1wTj2mnjkekRtx8zmsvCGazUfj7SGRpYVjFu5KAPMooJhK3bGdS1fFA0ucOEC
         0qeBWZoccCXGMSZPIrQTTY3pnzodw/UB0rbj0RbAT3ZiyIbAsjtYILEppf4tkfRq/dJo
         sG5IUTslr+0ij6yaAWzpf/CbmalyED2hZ07MIrCUd0NNnbhDXUOSL987Qnkpmay16Cbr
         HUDA==
X-Gm-Message-State: APjAAAW9ol8V79zdpxLRbp0a3c0b5cNq0rhVAD2TUCnEoqxOLvP7Wksh
        rDE//htv7SBYhz071S6Bdec=
X-Google-Smtp-Source: APXvYqwB1AatvvUUY7UhAxxOO7fGiokeuIYbB7eGkIZ/jULu6EuIKZPojqYCRwihC9W5MMchmp8HKw==
X-Received: by 2002:a62:a513:: with SMTP id v19mr48901163pfm.212.1557329054352;
        Wed, 08 May 2019 08:24:14 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.24.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:24:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 21/27] Documentation: x86: convert x86_64/boot-options.txt to reST
Date:   Wed,  8 May 2019 23:21:35 +0800
Message-Id: <20190508152141.8740-22-changbin.du@gmail.com>
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
 Documentation/x86/index.rst               |   1 +
 Documentation/x86/x86_64/boot-options.rst | 335 ++++++++++++++++++++++
 Documentation/x86/x86_64/boot-options.txt | 278 ------------------
 Documentation/x86/x86_64/index.rst        |  10 +
 4 files changed, 346 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/x86/x86_64/boot-options.rst
 delete mode 100644 Documentation/x86/x86_64/boot-options.txt
 create mode 100644 Documentation/x86/x86_64/index.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4e15bcc6456c..73a487957fd4 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -27,3 +27,4 @@ x86-specific Documentation
    resctrl_ui
    usb-legacy-support
    i386/index
+   x86_64/index
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
new file mode 100644
index 000000000000..2f69836b8445
--- /dev/null
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -0,0 +1,335 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+AMD64 Specific Boot Options
+===========================
+
+There are many others (usually documented in driver documentation), but
+only the AMD64 specific ones are listed here.
+
+Machine check
+=============
+Please see Documentation/x86/x86_64/machinecheck for sysfs runtime tunables.
+
+   mce=off
+		Disable machine check
+   mce=no_cmci
+		Disable CMCI(Corrected Machine Check Interrupt) that
+		Intel processor supports.  Usually this disablement is
+		not recommended, but it might be handy if your hardware
+		is misbehaving.
+		Note that you'll get more problems without CMCI than with
+		due to the shared banks, i.e. you might get duplicated
+		error logs.
+   mce=dont_log_ce
+		Don't make logs for corrected errors.  All events reported
+		as corrected are silently cleared by OS.
+		This option will be useful if you have no interest in any
+		of corrected errors.
+   mce=ignore_ce
+		Disable features for corrected errors, e.g. polling timer
+		and CMCI.  All events reported as corrected are not cleared
+		by OS and remained in its error banks.
+		Usually this disablement is not recommended, however if
+		there is an agent checking/clearing corrected errors
+		(e.g. BIOS or hardware monitoring applications), conflicting
+		with OS's error handling, and you cannot deactivate the agent,
+		then this option will be a help.
+   mce=no_lmce
+		Do not opt-in to Local MCE delivery. Use legacy method
+		to broadcast MCEs.
+   mce=bootlog
+		Enable logging of machine checks left over from booting.
+		Disabled by default on AMD Fam10h and older because some BIOS
+		leave bogus ones.
+		If your BIOS doesn't do that it's a good idea to enable though
+		to make sure you log even machine check events that result
+		in a reboot. On Intel systems it is enabled by default.
+   mce=nobootlog
+		Disable boot machine check logging.
+   mce=tolerancelevel[,monarchtimeout] (number,number)
+		tolerance levels:
+		0: always panic on uncorrected errors, log corrected errors
+		1: panic or SIGBUS on uncorrected errors, log corrected errors
+		2: SIGBUS or log uncorrected errors, log corrected errors
+		3: never panic or SIGBUS, log all errors (for testing only)
+		Default is 1
+		Can be also set using sysfs which is preferable.
+		monarchtimeout:
+		Sets the time in us to wait for other CPUs on machine checks. 0
+		to disable.
+   mce=bios_cmci_threshold
+		Don't overwrite the bios-set CMCI threshold. This boot option
+		prevents Linux from overwriting the CMCI threshold set by the
+		bios. Without this option, Linux always sets the CMCI
+		threshold to 1. Enabling this may make memory predictive failure
+		analysis less effective if the bios sets thresholds for memory
+		errors since we will not see details for all errors.
+   mce=recovery
+		Force-enable recoverable machine check code paths
+
+   nomce (for compatibility with i386)
+		same as mce=off
+
+   Everything else is in sysfs now.
+
+APICs
+=====
+
+   apic
+	Use IO-APIC. Default
+
+   noapic
+	Don't use the IO-APIC.
+
+   disableapic
+	Don't use the local APIC
+
+   nolapic
+     Don't use the local APIC (alias for i386 compatibility)
+
+   pirq=...
+	See Documentation/x86/i386/IO-APIC.txt
+
+   noapictimer
+	Don't set up the APIC timer
+
+   no_timer_check
+	Don't check the IO-APIC timer. This can work around
+	problems with incorrect timer initialization on some boards.
+
+   apicpmtimer
+	Do APIC timer calibration using the pmtimer. Implies
+	apicmaintimer. Useful when your PIT timer is totally broken.
+
+Timing
+======
+
+  notsc
+    Deprecated, use tsc=unstable instead.
+
+  nohpet
+    Don't use the HPET timer.
+
+Idle loop
+=========
+
+  idle=poll
+    Don't do power saving in the idle loop using HLT, but poll for rescheduling
+    event. This will make the CPUs eat a lot more power, but may be useful
+    to get slightly better performance in multiprocessor benchmarks. It also
+    makes some profiling using performance counters more accurate.
+    Please note that on systems with MONITOR/MWAIT support (like Intel EM64T
+    CPUs) this option has no performance advantage over the normal idle loop.
+    It may also interact badly with hyperthreading.
+
+Rebooting
+=========
+
+   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
+      bios
+        Use the CPU reboot vector for warm reset
+      warm
+        Don't set the cold reboot flag
+      cold
+        Set the cold reboot flag
+      triple
+        Force a triple fault (init)
+      kbd
+        Use the keyboard controller. cold reset (default)
+      acpi
+        Use the ACPI RESET_REG in the FADT. If ACPI is not configured or
+        the ACPI reset does not work, the reboot path attempts the reset
+        using the keyboard controller.
+      efi
+        Use efi reset_system runtime service. If EFI is not configured or
+        the EFI reset does not work, the reboot path attempts the reset using
+        the keyboard controller.
+
+   Using warm reset will be much faster especially on big memory
+   systems because the BIOS will not go through the memory check.
+   Disadvantage is that not all hardware will be completely reinitialized
+   on reboot so there may be boot problems on some systems.
+
+   reboot=force
+     Don't stop other CPUs on reboot. This can make reboot more reliable
+     in some cases.
+
+Non Executable Mappings
+=======================
+
+  noexec=on|off
+    on
+      Enable(default)
+    off
+      Disable
+
+NUMA
+====
+
+  numa=off
+    Only set up a single NUMA node spanning all memory.
+
+  numa=noacpi
+    Don't parse the SRAT table for NUMA setup
+
+  numa=fake=<size>[MG]
+    If given as a memory unit, fills all system RAM with nodes of
+    size interleaved over physical nodes.
+
+  numa=fake=<N>
+    If given as an integer, fills all system RAM with N fake nodes
+    interleaved over physical nodes.
+
+  numa=fake=<N>U
+    If given as an integer followed by 'U', it will divide each
+    physical node into N emulated nodes.
+
+ACPI
+====
+
+  acpi=off
+    Don't enable ACPI
+  acpi=ht
+    Use ACPI boot table parsing, but don't enable ACPI interpreter
+  acpi=force
+    Force ACPI on (currently not needed)
+  acpi=strict
+    Disable out of spec ACPI workarounds.
+  acpi_sci={edge,level,high,low}
+    Set up ACPI SCI interrupt.
+  acpi=noirq
+    Don't route interrupts
+  acpi=nocmcff
+    Disable firmware first mode for corrected errors. This
+    disables parsing the HEST CMC error source to check if
+    firmware has set the FF flag. This may result in
+    duplicate corrected error reports.
+
+PCI
+===
+
+  pci=off
+    Don't use PCI
+  pci=conf1
+    Use conf1 access.
+  pci=conf2
+    Use conf2 access.
+  pci=rom
+    Assign ROMs.
+  pci=assign-busses
+    Assign busses
+  pci=irqmask=MASK
+    Set PCI interrupt mask to MASK
+  pci=lastbus=NUMBER
+    Scan up to NUMBER busses, no matter what the mptable says.
+  pci=noacpi
+    Don't use ACPI to set up PCI interrupt routing.
+
+IOMMU (input/output memory management unit)
+===========================================
+Multiple x86-64 PCI-DMA mapping implementations exist, for example:
+
+   1. <lib/dma-direct.c>: use no hardware/software IOMMU at all
+      (e.g. because you have < 3 GB memory).
+      Kernel boot message: "PCI-DMA: Disabling IOMMU"
+
+   2. <arch/x86/kernel/amd_gart_64.c>: AMD GART based hardware IOMMU.
+      Kernel boot message: "PCI-DMA: using GART IOMMU"
+
+   3. <arch/x86_64/kernel/pci-swiotlb.c> : Software IOMMU implementation. Used
+      e.g. if there is no hardware IOMMU in the system and it is need because
+      you have >3GB memory or told the kernel to us it (iommu=soft))
+      Kernel boot message: "PCI-DMA: Using software bounce buffering
+      for IO (SWIOTLB)"
+
+   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
+      pSeries and xSeries servers. This hardware IOMMU supports DMA address
+      mapping with memory protection, etc.
+      Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
+
+::
+
+  iommu=[<size>][,noagp][,off][,force][,noforce]
+  [,memaper[=<order>]][,merge][,fullflush][,nomerge]
+  [,noaperture][,calgary]
+
+General iommu options:
+
+    off
+      Don't initialize and use any kind of IOMMU.
+    noforce
+      Don't force hardware IOMMU usage when it is not needed. (default).
+    force
+      Force the use of the hardware IOMMU even when it is
+      not actually needed (e.g. because < 3 GB memory).
+    soft
+      Use software bounce buffering (SWIOTLB) (default for
+      Intel machines). This can be used to prevent the usage
+      of an available hardware IOMMU.
+
+iommu options only relevant to the AMD GART hardware IOMMU:
+
+    <size>
+      Set the size of the remapping area in bytes.
+    allowed
+      Overwrite iommu off workarounds for specific chipsets.
+    fullflush
+      Flush IOMMU on each allocation (default).
+    nofullflush
+      Don't use IOMMU fullflush.
+    memaper[=<order>]
+      Allocate an own aperture over RAM with size 32MB<<order.
+      (default: order=1, i.e. 64MB)
+    merge
+      Do scatter-gather (SG) merging. Implies "force" (experimental).
+    nomerge
+      Don't do scatter-gather (SG) merging.
+    noaperture
+      Ask the IOMMU not to touch the aperture for AGP.
+    noagp
+      Don't initialize the AGP driver and use full aperture.
+    panic
+      Always panic when IOMMU overflows.
+    calgary
+      Use the Calgary IOMMU if it is available
+
+iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
+implementation:
+
+    swiotlb=<pages>[,force]
+      <pages>
+        Prereserve that many 128K pages for the software IO bounce buffering.
+      force
+        Force all IO through the software TLB.
+
+Settings for the IBM Calgary hardware IOMMU currently found in IBM
+pSeries and xSeries machines
+
+    calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
+      Set the size of each PCI slot's translation table when using the
+      Calgary IOMMU. This is the size of the translation table itself
+      in main memory. The smallest table, 64k, covers an IO space of
+      32MB; the largest, 8MB table, can cover an IO space of 4GB.
+      Normally the kernel will make the right choice by itself.
+    calgary=[translate_empty_slots]
+      Enable translation even on slots that have no devices attached to
+      them, in case a device will be hotplugged in the future.
+    calgary=[disable=<PCI bus number>]
+      Disable translation on a given PHB. For
+      example, the built-in graphics adapter resides on the first bridge
+      (PCI bus number 0); if translation (isolation) is enabled on this
+      bridge, X servers that access the hardware directly from user
+      space might stop working. Use this option if you have devices that
+      are accessed from userspace directly on some PCI host bridge.
+    panic
+      Always panic when IOMMU overflows
+
+
+Miscellaneous
+=============
+
+  nogbpages
+    Do not use GB pages for kernel direct mappings.
+  gbpages
+    Use GB pages for kernel direct mappings.
diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
deleted file mode 100644
index abc53886655e..000000000000
--- a/Documentation/x86/x86_64/boot-options.txt
+++ /dev/null
@@ -1,278 +0,0 @@
-AMD64 specific boot options
-
-There are many others (usually documented in driver documentation), but
-only the AMD64 specific ones are listed here.
-
-Machine check
-
-   Please see Documentation/x86/x86_64/machinecheck for sysfs runtime tunables.
-
-   mce=off
-		Disable machine check
-   mce=no_cmci
-		Disable CMCI(Corrected Machine Check Interrupt) that
-		Intel processor supports.  Usually this disablement is
-		not recommended, but it might be handy if your hardware
-		is misbehaving.
-		Note that you'll get more problems without CMCI than with
-		due to the shared banks, i.e. you might get duplicated
-		error logs.
-   mce=dont_log_ce
-		Don't make logs for corrected errors.  All events reported
-		as corrected are silently cleared by OS.
-		This option will be useful if you have no interest in any
-		of corrected errors.
-   mce=ignore_ce
-		Disable features for corrected errors, e.g. polling timer
-		and CMCI.  All events reported as corrected are not cleared
-		by OS and remained in its error banks.
-		Usually this disablement is not recommended, however if
-		there is an agent checking/clearing corrected errors
-		(e.g. BIOS or hardware monitoring applications), conflicting
-		with OS's error handling, and you cannot deactivate the agent,
-		then this option will be a help.
-   mce=no_lmce
-		Do not opt-in to Local MCE delivery. Use legacy method
-		to broadcast MCEs.
-   mce=bootlog
-		Enable logging of machine checks left over from booting.
-		Disabled by default on AMD Fam10h and older because some BIOS
-		leave bogus ones.
-		If your BIOS doesn't do that it's a good idea to enable though
-		to make sure you log even machine check events that result
-		in a reboot. On Intel systems it is enabled by default.
-   mce=nobootlog
-		Disable boot machine check logging.
-   mce=tolerancelevel[,monarchtimeout] (number,number)
-		tolerance levels:
-		0: always panic on uncorrected errors, log corrected errors
-		1: panic or SIGBUS on uncorrected errors, log corrected errors
-		2: SIGBUS or log uncorrected errors, log corrected errors
-		3: never panic or SIGBUS, log all errors (for testing only)
-		Default is 1
-		Can be also set using sysfs which is preferable.
-		monarchtimeout:
-		Sets the time in us to wait for other CPUs on machine checks. 0
-		to disable.
-   mce=bios_cmci_threshold
-		Don't overwrite the bios-set CMCI threshold. This boot option
-		prevents Linux from overwriting the CMCI threshold set by the
-		bios. Without this option, Linux always sets the CMCI
-		threshold to 1. Enabling this may make memory predictive failure
-		analysis less effective if the bios sets thresholds for memory
-		errors since we will not see details for all errors.
-   mce=recovery
-		Force-enable recoverable machine check code paths
-
-   nomce (for compatibility with i386): same as mce=off
-
-   Everything else is in sysfs now.
-
-APICs
-
-   apic		 Use IO-APIC. Default
-
-   noapic	 Don't use the IO-APIC.
-
-   disableapic	 Don't use the local APIC
-
-   nolapic	 Don't use the local APIC (alias for i386 compatibility)
-
-   pirq=...	 See Documentation/x86/i386/IO-APIC.txt
-
-   noapictimer	 Don't set up the APIC timer
-
-   no_timer_check Don't check the IO-APIC timer. This can work around
-		 problems with incorrect timer initialization on some boards.
-   apicpmtimer
-		 Do APIC timer calibration using the pmtimer. Implies
-		 apicmaintimer. Useful when your PIT timer is totally
-		 broken.
-
-Timing
-
-  notsc
-  Deprecated, use tsc=unstable instead.
-
-  nohpet
-  Don't use the HPET timer.
-
-Idle loop
-
-  idle=poll
-  Don't do power saving in the idle loop using HLT, but poll for rescheduling
-  event. This will make the CPUs eat a lot more power, but may be useful
-  to get slightly better performance in multiprocessor benchmarks. It also
-  makes some profiling using performance counters more accurate.
-  Please note that on systems with MONITOR/MWAIT support (like Intel EM64T
-  CPUs) this option has no performance advantage over the normal idle loop.
-  It may also interact badly with hyperthreading.
-
-Rebooting
-
-   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
-   bios	  Use the CPU reboot vector for warm reset
-   warm   Don't set the cold reboot flag
-   cold   Set the cold reboot flag
-   triple Force a triple fault (init)
-   kbd    Use the keyboard controller. cold reset (default)
-   acpi   Use the ACPI RESET_REG in the FADT. If ACPI is not configured or the
-          ACPI reset does not work, the reboot path attempts the reset using
-          the keyboard controller.
-   efi    Use efi reset_system runtime service. If EFI is not configured or the
-          EFI reset does not work, the reboot path attempts the reset using
-          the keyboard controller.
-
-   Using warm reset will be much faster especially on big memory
-   systems because the BIOS will not go through the memory check.
-   Disadvantage is that not all hardware will be completely reinitialized
-   on reboot so there may be boot problems on some systems.
-
-   reboot=force
-
-   Don't stop other CPUs on reboot. This can make reboot more reliable
-   in some cases.
-
-Non Executable Mappings
-
-  noexec=on|off
-
-  on      Enable(default)
-  off     Disable
-
-NUMA
-
-  numa=off	Only set up a single NUMA node spanning all memory.
-
-  numa=noacpi   Don't parse the SRAT table for NUMA setup
-
-  numa=fake=<size>[MG]
-		If given as a memory unit, fills all system RAM with nodes of
-		size interleaved over physical nodes.
-
-  numa=fake=<N>
-		If given as an integer, fills all system RAM with N fake nodes
-		interleaved over physical nodes.
-
-  numa=fake=<N>U
-		If given as an integer followed by 'U', it will divide each
-		physical node into N emulated nodes.
-
-ACPI
-
-  acpi=off	Don't enable ACPI
-  acpi=ht	Use ACPI boot table parsing, but don't enable ACPI
-		interpreter
-  acpi=force	Force ACPI on (currently not needed)
-
-  acpi=strict   Disable out of spec ACPI workarounds.
-
-  acpi_sci={edge,level,high,low}  Set up ACPI SCI interrupt.
-
-  acpi=noirq	Don't route interrupts
-
-  acpi=nocmcff	Disable firmware first mode for corrected errors. This
-		disables parsing the HEST CMC error source to check if
-		firmware has set the FF flag. This may result in
-		duplicate corrected error reports.
-
-PCI
-
-  pci=off		Don't use PCI
-  pci=conf1		Use conf1 access.
-  pci=conf2		Use conf2 access.
-  pci=rom		Assign ROMs.
-  pci=assign-busses	Assign busses
-  pci=irqmask=MASK	Set PCI interrupt mask to MASK
-  pci=lastbus=NUMBER	Scan up to NUMBER busses, no matter what the mptable says.
-  pci=noacpi		Don't use ACPI to set up PCI interrupt routing.
-
-IOMMU (input/output memory management unit)
-
- Multiple x86-64 PCI-DMA mapping implementations exist, for example:
-
-   1. <lib/dma-direct.c>: use no hardware/software IOMMU at all
-      (e.g. because you have < 3 GB memory).
-      Kernel boot message: "PCI-DMA: Disabling IOMMU"
-
-   2. <arch/x86/kernel/amd_gart_64.c>: AMD GART based hardware IOMMU.
-      Kernel boot message: "PCI-DMA: using GART IOMMU"
-
-   3. <arch/x86_64/kernel/pci-swiotlb.c> : Software IOMMU implementation. Used
-      e.g. if there is no hardware IOMMU in the system and it is need because
-      you have >3GB memory or told the kernel to us it (iommu=soft))
-      Kernel boot message: "PCI-DMA: Using software bounce buffering
-      for IO (SWIOTLB)"
-
-   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
-      pSeries and xSeries servers. This hardware IOMMU supports DMA address
-      mapping with memory protection, etc.
-      Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
-
- iommu=[<size>][,noagp][,off][,force][,noforce]
-	[,memaper[=<order>]][,merge][,fullflush][,nomerge]
-	[,noaperture][,calgary]
-
-  General iommu options:
-    off                Don't initialize and use any kind of IOMMU.
-    noforce            Don't force hardware IOMMU usage when it is not needed.
-                       (default).
-    force              Force the use of the hardware IOMMU even when it is
-                       not actually needed (e.g. because < 3 GB memory).
-    soft               Use software bounce buffering (SWIOTLB) (default for
-                       Intel machines). This can be used to prevent the usage
-                       of an available hardware IOMMU.
-
-  iommu options only relevant to the AMD GART hardware IOMMU:
-    <size>             Set the size of the remapping area in bytes.
-    allowed            Overwrite iommu off workarounds for specific chipsets.
-    fullflush          Flush IOMMU on each allocation (default).
-    nofullflush        Don't use IOMMU fullflush.
-    memaper[=<order>]  Allocate an own aperture over RAM with size 32MB<<order.
-                       (default: order=1, i.e. 64MB)
-    merge              Do scatter-gather (SG) merging. Implies "force"
-                       (experimental).
-    nomerge            Don't do scatter-gather (SG) merging.
-    noaperture         Ask the IOMMU not to touch the aperture for AGP.
-    noagp              Don't initialize the AGP driver and use full aperture.
-    panic              Always panic when IOMMU overflows.
-    calgary            Use the Calgary IOMMU if it is available
-
-  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
-  implementation:
-    swiotlb=<pages>[,force]
-    <pages>            Prereserve that many 128K pages for the software IO
-                       bounce buffering.
-    force              Force all IO through the software TLB.
-
-  Settings for the IBM Calgary hardware IOMMU currently found in IBM
-  pSeries and xSeries machines:
-
-    calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
-    calgary=[translate_empty_slots]
-    calgary=[disable=<PCI bus number>]
-    panic              Always panic when IOMMU overflows
-
-    64k,...,8M - Set the size of each PCI slot's translation table
-    when using the Calgary IOMMU. This is the size of the translation
-    table itself in main memory. The smallest table, 64k, covers an IO
-    space of 32MB; the largest, 8MB table, can cover an IO space of
-    4GB. Normally the kernel will make the right choice by itself.
-
-    translate_empty_slots - Enable translation even on slots that have
-    no devices attached to them, in case a device will be hotplugged
-    in the future.
-
-    disable=<PCI bus number> - Disable translation on a given PHB. For
-    example, the built-in graphics adapter resides on the first bridge
-    (PCI bus number 0); if translation (isolation) is enabled on this
-    bridge, X servers that access the hardware directly from user
-    space might stop working. Use this option if you have devices that
-    are accessed from userspace directly on some PCI host bridge.
-
-Miscellaneous
-
-	nogbpages
-		Do not use GB pages for kernel direct mappings.
-	gbpages
-		Use GB pages for kernel direct mappings.
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
new file mode 100644
index 000000000000..a8cf7713cac9
--- /dev/null
+++ b/Documentation/x86/x86_64/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+x86_64 Support
+==============
+
+.. toctree::
+   :maxdepth: 2
+
+   boot-options
-- 
2.20.1

