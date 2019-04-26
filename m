Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC452084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf0/0urt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDZPeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1807472pgc.4;
        Fri, 26 Apr 2019 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfBnlSnN/EooEyU9lpw5gI9oFt0Um6GP38LU0wS+lZs=;
        b=Kf0/0urt+JDNr9pwEYPqA45xh/zKoYDou0yv45NwosDx0ibXA/UT/m0tnmKDXY+gry
         Is+TfWOkQSaVD0LiESDkl7oOH8uakpvX6T3upyXh/EdZk+cOUMSIqNExl9df9AJgHIZC
         9njYl0Km4xdn6AjMV4pfup9baH5Q4/ZdcRpJ9u2nYZ0V6l+WJIzEn2lzh+WhObn3gfDW
         VyDq9A8PForf4ZY4QtkP+hv1KqvjAP2mPf6SLlwgXKpYcaGp7HMFC4GdOzROvobwb0fC
         yBls0wxwOm+aYxFoI0s7gKH+9SeMqtBRicEkltQPwoXkWGdy6WEslwZCHb2EJsyQ2EEh
         RFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfBnlSnN/EooEyU9lpw5gI9oFt0Um6GP38LU0wS+lZs=;
        b=JptciUXQt9ak7/KGuaZjkC/tZZfNJwpHHlbpNwCWU6d3tRvmSe/j2yozSpToaUbPBX
         5xQ6kF3JHt2pj3mXdXB/mC115fJBbYXjW2SkLl/1WgCfm/beTjmgyG+cZqs4/NxVy+rJ
         jeTZjvsbifmZ0kMc27TfmGe2Iz2GBkWnLaaO2JwYAGsVBMjpU6c2p95oIggO+3M9Uba+
         sAYBdDOGnZSJ8yAaUoS+D1z08iVovc/QDUrS16CKZpSGSqJcqHtJbOwA8g0lI11g2Mad
         /O2inBaOUbNE2fE8tgcak94w4P//pCgeaiDkAJn3sDdS0dWExneJbsZDhpyBjgq780a9
         Rbqw==
X-Gm-Message-State: APjAAAX1hU4bSxoSL4VLQrI2w7Tj0qpyWmuqfXMkN1bKtSzxEWbikwDs
        mVjg4x/e4BdgcpA+kkgn5ss=
X-Google-Smtp-Source: APXvYqwBIuYOew6rwo7Q+T0FHLo+e7wlL52uaHsi2e6QYYybDXh7IOyF7hQwyAcIXYkgqkxFiflHOg==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr49263587pfa.134.1556292859688;
        Fri, 26 Apr 2019 08:34:19 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 21/27] Documentation: x86: convert x86_64/boot-options.txt to reST
Date:   Fri, 26 Apr 2019 23:31:44 +0800
Message-Id: <20190426153150.21228-22-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
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
 Documentation/x86/index.rst               |   1 +
 Documentation/x86/x86_64/boot-options.rst | 326 ++++++++++++++++++++++
 Documentation/x86/x86_64/boot-options.txt | 278 ------------------
 Documentation/x86/x86_64/index.rst        |  10 +
 4 files changed, 337 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/x86/x86_64/boot-options.rst
 delete mode 100644 Documentation/x86/x86_64/boot-options.txt
 create mode 100644 Documentation/x86/x86_64/index.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 19323c5b89ce..e7becb146c30 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -27,3 +27,4 @@ Linux x86 Support
    resctrl_ui
    usb-legacy-support
    i386/index
+   x86_64/index
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
new file mode 100644
index 000000000000..2378f30c694a
--- /dev/null
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -0,0 +1,326 @@
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
+    * bios - Use the CPU reboot vector for warm reset
+    * warm - Don't set the cold reboot flag
+    * cold - Set the cold reboot flag
+    * triple - Force a triple fault (init)
+    * kbd  - Use the keyboard controller. cold reset (default)
+    * acpi - Use the ACPI RESET_REG in the FADT. If ACPI is not configured or
+      the ACPI reset does not work, the reboot path attempts the reset
+      using the keyboard controller.
+    * efi - Use efi reset_system runtime service. If EFI is not configured or
+      the EFI reset does not work, the reboot path attempts the reset using
+      the keyboard controller.
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
+    * on  - Enable(default)
+    * off - Disable
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

