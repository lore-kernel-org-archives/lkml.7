Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE0820873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1OAdgBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEBFuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:50:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43233 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfEBFuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:50:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so548794pgi.10;
        Wed, 01 May 2019 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ofX7LDqq87j2O5scvzF2g6WKDxCyl+YOsNtVsetrRdc=;
        b=n1OAdgBMZKfbVXjMGE1mNwpFPEazRQ8NFSHgSbzDuZbtwmFJ3kQ92Q76EXva1h4KvZ
         zWvK5Gws4ouZKx4NQ97cyeLXcFtDmcgSqfdyrROIz/uWGe2OHbjgRbnqlUEGQpRoY2Nv
         XAGYsq5T9U/t9jiIb3ZNSteb8X9I2diy2yVTyCzcAxe+Osj5Y50+ZPo/z4lwRrsK7PJD
         EBK1uSvWEkWKQjzR/ooOn/n63JeiBze0gDVK6Z3+nSdNhZn2zH8niwmWe6v1li22ViR8
         fVeySakYhGWkX6v7+7RFBXYkdXHgr8kua+OVNyMhSaQYSa5kqMzA1p0lO+HehCIreHpV
         r0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ofX7LDqq87j2O5scvzF2g6WKDxCyl+YOsNtVsetrRdc=;
        b=dySZe7y9F8TrEF1fsC4OzmyGcAvltNjyBgjFS3Xd2amwWo4AUzTHEFKubmtbJ2uDNE
         eHxuy8mWxlNwX6sTxNSk6WeeDyuqnxQRJMdM444Gm/u8R+MVMVAwtay/YASuc2zQNG0N
         KsYki/4XuAhkErKcUhS9BM+95BHmV6P34OehkGN5gjnUoz33yNcFH1F/x27YQ0CMRfWY
         cubgw6i9u5Zjixehi3tXDp2gYKDso859agC0dBverGCCzQlaHAg8x6AKURMSIQ7GgBxP
         TJcac7eUAj5fRa2SsNm/zyw3ZPnTTa9lVFMbHofyU9qTZSJKoi+VWQfOVm4LLPyP8NvA
         /tEw==
X-Gm-Message-State: APjAAAU7+GHXbtemvU7MKYa+8kOKSlhtvh+q6IWKBwhQHnAvc5LKHFRr
        QUmvd+6bLJigRJvwSy0f3scWPRIn
X-Google-Smtp-Source: APXvYqwSDgskISS//uCHU+8IeNPVwM6s+xODtid6od6nQLuKezyzH+ZvIzSHM0SApHwhkzWwL5QvcQ==
X-Received: by 2002:a63:f712:: with SMTP id x18mr2081277pgh.293.1556776210827;
        Wed, 01 May 2019 22:50:10 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id e6sm44450673pfe.158.2019.05.01.22.50.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 01 May 2019 22:50:10 -0700 (PDT)
Date:   Thu, 2 May 2019 13:49:56 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/27] Documentation: x86: convert
 x86_64/boot-options.txt to reST
Message-ID: <20190502054953.yjmc3qyqdsfotfx4@mail.google.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
 <20190426153150.21228-22-changbin.du@gmail.com>
 <20190427153031.08489e65@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427153031.08489e65@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 03:30:31PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Apr 2019 23:31:44 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/x86/index.rst               |   1 +
> >  Documentation/x86/x86_64/boot-options.rst | 326 ++++++++++++++++++++++
> >  Documentation/x86/x86_64/boot-options.txt | 278 ------------------
> >  Documentation/x86/x86_64/index.rst        |  10 +
> >  4 files changed, 337 insertions(+), 278 deletions(-)
> >  create mode 100644 Documentation/x86/x86_64/boot-options.rst
> >  delete mode 100644 Documentation/x86/x86_64/boot-options.txt
> >  create mode 100644 Documentation/x86/x86_64/index.rst
> > 
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index 19323c5b89ce..e7becb146c30 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -27,3 +27,4 @@ Linux x86 Support
> >     resctrl_ui
> >     usb-legacy-support
> >     i386/index
> > +   x86_64/index
> > diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
> > new file mode 100644
> > index 000000000000..2378f30c694a
> > --- /dev/null
> > +++ b/Documentation/x86/x86_64/boot-options.rst
> > @@ -0,0 +1,326 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===========================
> > +AMD64 Specific Boot Options
> > +===========================
> > +
> > +There are many others (usually documented in driver documentation), but
> > +only the AMD64 specific ones are listed here.
> > +
> > +Machine check
> > +=============
> > +Please see Documentation/x86/x86_64/machinecheck for sysfs runtime tunables.
> > +
> > +   mce=off
> > +		Disable machine check
> > +   mce=no_cmci
> > +		Disable CMCI(Corrected Machine Check Interrupt) that
> > +		Intel processor supports.  Usually this disablement is
> > +		not recommended, but it might be handy if your hardware
> > +		is misbehaving.
> > +		Note that you'll get more problems without CMCI than with
> > +		due to the shared banks, i.e. you might get duplicated
> > +		error logs.
> > +   mce=dont_log_ce
> > +		Don't make logs for corrected errors.  All events reported
> > +		as corrected are silently cleared by OS.
> > +		This option will be useful if you have no interest in any
> > +		of corrected errors.
> > +   mce=ignore_ce
> > +		Disable features for corrected errors, e.g. polling timer
> > +		and CMCI.  All events reported as corrected are not cleared
> > +		by OS and remained in its error banks.
> > +		Usually this disablement is not recommended, however if
> > +		there is an agent checking/clearing corrected errors
> > +		(e.g. BIOS or hardware monitoring applications), conflicting
> > +		with OS's error handling, and you cannot deactivate the agent,
> > +		then this option will be a help.
> > +   mce=no_lmce
> > +		Do not opt-in to Local MCE delivery. Use legacy method
> > +		to broadcast MCEs.
> > +   mce=bootlog
> > +		Enable logging of machine checks left over from booting.
> > +		Disabled by default on AMD Fam10h and older because some BIOS
> > +		leave bogus ones.
> > +		If your BIOS doesn't do that it's a good idea to enable though
> > +		to make sure you log even machine check events that result
> > +		in a reboot. On Intel systems it is enabled by default.
> > +   mce=nobootlog
> > +		Disable boot machine check logging.
> > +   mce=tolerancelevel[,monarchtimeout] (number,number)
> > +		tolerance levels:
> > +		0: always panic on uncorrected errors, log corrected errors
> > +		1: panic or SIGBUS on uncorrected errors, log corrected errors
> > +		2: SIGBUS or log uncorrected errors, log corrected errors
> > +		3: never panic or SIGBUS, log all errors (for testing only)
> > +		Default is 1
> > +		Can be also set using sysfs which is preferable.
> > +		monarchtimeout:
> > +		Sets the time in us to wait for other CPUs on machine checks. 0
> > +		to disable.
> > +   mce=bios_cmci_threshold
> > +		Don't overwrite the bios-set CMCI threshold. This boot option
> > +		prevents Linux from overwriting the CMCI threshold set by the
> > +		bios. Without this option, Linux always sets the CMCI
> > +		threshold to 1. Enabling this may make memory predictive failure
> > +		analysis less effective if the bios sets thresholds for memory
> > +		errors since we will not see details for all errors.
> > +   mce=recovery
> > +		Force-enable recoverable machine check code paths
> > +
> > +   nomce (for compatibility with i386)
> > +		same as mce=off
> > +
> > +   Everything else is in sysfs now.
> > +
> > +APICs
> > +=====
> > +
> > +   apic
> > +	Use IO-APIC. Default
> > +
> > +   noapic
> > +	Don't use the IO-APIC.
> > +
> > +   disableapic
> > +	Don't use the local APIC
> > +
> > +   nolapic
> > +     Don't use the local APIC (alias for i386 compatibility)
> > +
> > +   pirq=...
> > +	See Documentation/x86/i386/IO-APIC.txt
> > +
> > +   noapictimer
> > +	Don't set up the APIC timer
> > +
> > +   no_timer_check
> > +	Don't check the IO-APIC timer. This can work around
> > +	problems with incorrect timer initialization on some boards.
> > +
> > +   apicpmtimer
> > +	Do APIC timer calibration using the pmtimer. Implies
> > +	apicmaintimer. Useful when your PIT timer is totally broken.
> > +
> > +Timing
> > +======
> > +
> > +  notsc
> > +    Deprecated, use tsc=unstable instead.
> > +
> > +  nohpet
> > +    Don't use the HPET timer.
> > +
> > +Idle loop
> > +=========
> > +
> > +  idle=poll
> > +    Don't do power saving in the idle loop using HLT, but poll for rescheduling
> > +    event. This will make the CPUs eat a lot more power, but may be useful
> > +    to get slightly better performance in multiprocessor benchmarks. It also
> > +    makes some profiling using performance counters more accurate.
> > +    Please note that on systems with MONITOR/MWAIT support (like Intel EM64T
> > +    CPUs) this option has no performance advantage over the normal idle loop.
> > +    It may also interact badly with hyperthreading.
> > +
> > +Rebooting
> > +=========
> > +
> > +   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
> > +    * bios - Use the CPU reboot vector for warm reset
> 
> Please use the same convention as the one you used before, e. g.: 
> 
> 	* bios
> 		Use the CPU reboot vector for warm reset
> 
> and so on.
>
Sure.

> After such change:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> 
> > +    * warm - Don't set the cold reboot flag
> > +    * cold - Set the cold reboot flag
> > +    * triple - Force a triple fault (init)
> > +    * kbd  - Use the keyboard controller. cold reset (default)
> > +    * acpi - Use the ACPI RESET_REG in the FADT. If ACPI is not configured or
> > +      the ACPI reset does not work, the reboot path attempts the reset
> > +      using the keyboard controller.
> > +    * efi - Use efi reset_system runtime service. If EFI is not configured or
> > +      the EFI reset does not work, the reboot path attempts the reset using
> > +      the keyboard controller.
> > +
> > +   Using warm reset will be much faster especially on big memory
> > +   systems because the BIOS will not go through the memory check.
> > +   Disadvantage is that not all hardware will be completely reinitialized
> > +   on reboot so there may be boot problems on some systems.
> > +
> > +   reboot=force
> > +     Don't stop other CPUs on reboot. This can make reboot more reliable
> > +     in some cases.
> > +
> > +Non Executable Mappings
> > +=======================
> > +
> > +  noexec=on|off
> > +    * on  - Enable(default)
> > +    * off - Disable
> > +
> > +NUMA
> > +====
> > +
> > +  numa=off
> > +    Only set up a single NUMA node spanning all memory.
> > +
> > +  numa=noacpi
> > +    Don't parse the SRAT table for NUMA setup
> > +
> > +  numa=fake=<size>[MG]
> > +    If given as a memory unit, fills all system RAM with nodes of
> > +    size interleaved over physical nodes.
> > +
> > +  numa=fake=<N>
> > +    If given as an integer, fills all system RAM with N fake nodes
> > +    interleaved over physical nodes.
> > +
> > +  numa=fake=<N>U
> > +    If given as an integer followed by 'U', it will divide each
> > +    physical node into N emulated nodes.
> > +
> > +ACPI
> > +====
> > +
> > +  acpi=off
> > +    Don't enable ACPI
> > +  acpi=ht
> > +    Use ACPI boot table parsing, but don't enable ACPI interpreter
> > +  acpi=force
> > +    Force ACPI on (currently not needed)
> > +  acpi=strict
> > +    Disable out of spec ACPI workarounds.
> > +  acpi_sci={edge,level,high,low}
> > +    Set up ACPI SCI interrupt.
> > +  acpi=noirq
> > +    Don't route interrupts
> > +  acpi=nocmcff
> > +    Disable firmware first mode for corrected errors. This
> > +    disables parsing the HEST CMC error source to check if
> > +    firmware has set the FF flag. This may result in
> > +    duplicate corrected error reports.
> > +
> > +PCI
> > +===
> > +
> > +  pci=off
> > +    Don't use PCI
> > +  pci=conf1
> > +    Use conf1 access.
> > +  pci=conf2
> > +    Use conf2 access.
> > +  pci=rom
> > +    Assign ROMs.
> > +  pci=assign-busses
> > +    Assign busses
> > +  pci=irqmask=MASK
> > +    Set PCI interrupt mask to MASK
> > +  pci=lastbus=NUMBER
> > +    Scan up to NUMBER busses, no matter what the mptable says.
> > +  pci=noacpi
> > +    Don't use ACPI to set up PCI interrupt routing.
> > +
> > +IOMMU (input/output memory management unit)
> > +===========================================
> > +Multiple x86-64 PCI-DMA mapping implementations exist, for example:
> > +
> > +   1. <lib/dma-direct.c>: use no hardware/software IOMMU at all
> > +      (e.g. because you have < 3 GB memory).
> > +      Kernel boot message: "PCI-DMA: Disabling IOMMU"
> > +
> > +   2. <arch/x86/kernel/amd_gart_64.c>: AMD GART based hardware IOMMU.
> > +      Kernel boot message: "PCI-DMA: using GART IOMMU"
> > +
> > +   3. <arch/x86_64/kernel/pci-swiotlb.c> : Software IOMMU implementation. Used
> > +      e.g. if there is no hardware IOMMU in the system and it is need because
> > +      you have >3GB memory or told the kernel to us it (iommu=soft))
> > +      Kernel boot message: "PCI-DMA: Using software bounce buffering
> > +      for IO (SWIOTLB)"
> > +
> > +   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
> > +      pSeries and xSeries servers. This hardware IOMMU supports DMA address
> > +      mapping with memory protection, etc.
> > +      Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
> > +
> > +::
> > +
> > +  iommu=[<size>][,noagp][,off][,force][,noforce]
> > +  [,memaper[=<order>]][,merge][,fullflush][,nomerge]
> > +  [,noaperture][,calgary]
> > +
> > +General iommu options:
> > +
> > +    off
> > +      Don't initialize and use any kind of IOMMU.
> > +    noforce
> > +      Don't force hardware IOMMU usage when it is not needed. (default).
> > +    force
> > +      Force the use of the hardware IOMMU even when it is
> > +      not actually needed (e.g. because < 3 GB memory).
> > +    soft
> > +      Use software bounce buffering (SWIOTLB) (default for
> > +      Intel machines). This can be used to prevent the usage
> > +      of an available hardware IOMMU.
> > +
> > +iommu options only relevant to the AMD GART hardware IOMMU:
> > +
> > +    <size>
> > +      Set the size of the remapping area in bytes.
> > +    allowed
> > +      Overwrite iommu off workarounds for specific chipsets.
> > +    fullflush
> > +      Flush IOMMU on each allocation (default).
> > +    nofullflush
> > +      Don't use IOMMU fullflush.
> > +    memaper[=<order>]
> > +      Allocate an own aperture over RAM with size 32MB<<order.
> > +      (default: order=1, i.e. 64MB)
> > +    merge
> > +      Do scatter-gather (SG) merging. Implies "force" (experimental).
> > +    nomerge
> > +      Don't do scatter-gather (SG) merging.
> > +    noaperture
> > +      Ask the IOMMU not to touch the aperture for AGP.
> > +    noagp
> > +      Don't initialize the AGP driver and use full aperture.
> > +    panic
> > +      Always panic when IOMMU overflows.
> > +    calgary
> > +      Use the Calgary IOMMU if it is available
> > +
> > +iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
> > +implementation:
> > +
> > +    swiotlb=<pages>[,force]
> > +      <pages>
> > +        Prereserve that many 128K pages for the software IO bounce buffering.
> > +      force
> > +        Force all IO through the software TLB.
> > +
> > +Settings for the IBM Calgary hardware IOMMU currently found in IBM
> > +pSeries and xSeries machines
> > +
> > +    calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
> > +      Set the size of each PCI slot's translation table when using the
> > +      Calgary IOMMU. This is the size of the translation table itself
> > +      in main memory. The smallest table, 64k, covers an IO space of
> > +      32MB; the largest, 8MB table, can cover an IO space of 4GB.
> > +      Normally the kernel will make the right choice by itself.
> > +    calgary=[translate_empty_slots]
> > +      Enable translation even on slots that have no devices attached to
> > +      them, in case a device will be hotplugged in the future.
> > +    calgary=[disable=<PCI bus number>]
> > +      Disable translation on a given PHB. For
> > +      example, the built-in graphics adapter resides on the first bridge
> > +      (PCI bus number 0); if translation (isolation) is enabled on this
> > +      bridge, X servers that access the hardware directly from user
> > +      space might stop working. Use this option if you have devices that
> > +      are accessed from userspace directly on some PCI host bridge.
> > +    panic
> > +      Always panic when IOMMU overflows
> > +
> > +
> > +Miscellaneous
> > +=============
> > +
> > +  nogbpages
> > +    Do not use GB pages for kernel direct mappings.
> > +  gbpages
> > +    Use GB pages for kernel direct mappings.
> > diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
> > deleted file mode 100644
> > index abc53886655e..000000000000
> > --- a/Documentation/x86/x86_64/boot-options.txt
> > +++ /dev/null
> > @@ -1,278 +0,0 @@
> > -AMD64 specific boot options
> > -
> > -There are many others (usually documented in driver documentation), but
> > -only the AMD64 specific ones are listed here.
> > -
> > -Machine check
> > -
> > -   Please see Documentation/x86/x86_64/machinecheck for sysfs runtime tunables.
> > -
> > -   mce=off
> > -		Disable machine check
> > -   mce=no_cmci
> > -		Disable CMCI(Corrected Machine Check Interrupt) that
> > -		Intel processor supports.  Usually this disablement is
> > -		not recommended, but it might be handy if your hardware
> > -		is misbehaving.
> > -		Note that you'll get more problems without CMCI than with
> > -		due to the shared banks, i.e. you might get duplicated
> > -		error logs.
> > -   mce=dont_log_ce
> > -		Don't make logs for corrected errors.  All events reported
> > -		as corrected are silently cleared by OS.
> > -		This option will be useful if you have no interest in any
> > -		of corrected errors.
> > -   mce=ignore_ce
> > -		Disable features for corrected errors, e.g. polling timer
> > -		and CMCI.  All events reported as corrected are not cleared
> > -		by OS and remained in its error banks.
> > -		Usually this disablement is not recommended, however if
> > -		there is an agent checking/clearing corrected errors
> > -		(e.g. BIOS or hardware monitoring applications), conflicting
> > -		with OS's error handling, and you cannot deactivate the agent,
> > -		then this option will be a help.
> > -   mce=no_lmce
> > -		Do not opt-in to Local MCE delivery. Use legacy method
> > -		to broadcast MCEs.
> > -   mce=bootlog
> > -		Enable logging of machine checks left over from booting.
> > -		Disabled by default on AMD Fam10h and older because some BIOS
> > -		leave bogus ones.
> > -		If your BIOS doesn't do that it's a good idea to enable though
> > -		to make sure you log even machine check events that result
> > -		in a reboot. On Intel systems it is enabled by default.
> > -   mce=nobootlog
> > -		Disable boot machine check logging.
> > -   mce=tolerancelevel[,monarchtimeout] (number,number)
> > -		tolerance levels:
> > -		0: always panic on uncorrected errors, log corrected errors
> > -		1: panic or SIGBUS on uncorrected errors, log corrected errors
> > -		2: SIGBUS or log uncorrected errors, log corrected errors
> > -		3: never panic or SIGBUS, log all errors (for testing only)
> > -		Default is 1
> > -		Can be also set using sysfs which is preferable.
> > -		monarchtimeout:
> > -		Sets the time in us to wait for other CPUs on machine checks. 0
> > -		to disable.
> > -   mce=bios_cmci_threshold
> > -		Don't overwrite the bios-set CMCI threshold. This boot option
> > -		prevents Linux from overwriting the CMCI threshold set by the
> > -		bios. Without this option, Linux always sets the CMCI
> > -		threshold to 1. Enabling this may make memory predictive failure
> > -		analysis less effective if the bios sets thresholds for memory
> > -		errors since we will not see details for all errors.
> > -   mce=recovery
> > -		Force-enable recoverable machine check code paths
> > -
> > -   nomce (for compatibility with i386): same as mce=off
> > -
> > -   Everything else is in sysfs now.
> > -
> > -APICs
> > -
> > -   apic		 Use IO-APIC. Default
> > -
> > -   noapic	 Don't use the IO-APIC.
> > -
> > -   disableapic	 Don't use the local APIC
> > -
> > -   nolapic	 Don't use the local APIC (alias for i386 compatibility)
> > -
> > -   pirq=...	 See Documentation/x86/i386/IO-APIC.txt
> > -
> > -   noapictimer	 Don't set up the APIC timer
> > -
> > -   no_timer_check Don't check the IO-APIC timer. This can work around
> > -		 problems with incorrect timer initialization on some boards.
> > -   apicpmtimer
> > -		 Do APIC timer calibration using the pmtimer. Implies
> > -		 apicmaintimer. Useful when your PIT timer is totally
> > -		 broken.
> > -
> > -Timing
> > -
> > -  notsc
> > -  Deprecated, use tsc=unstable instead.
> > -
> > -  nohpet
> > -  Don't use the HPET timer.
> > -
> > -Idle loop
> > -
> > -  idle=poll
> > -  Don't do power saving in the idle loop using HLT, but poll for rescheduling
> > -  event. This will make the CPUs eat a lot more power, but may be useful
> > -  to get slightly better performance in multiprocessor benchmarks. It also
> > -  makes some profiling using performance counters more accurate.
> > -  Please note that on systems with MONITOR/MWAIT support (like Intel EM64T
> > -  CPUs) this option has no performance advantage over the normal idle loop.
> > -  It may also interact badly with hyperthreading.
> > -
> > -Rebooting
> > -
> > -   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
> > -   bios	  Use the CPU reboot vector for warm reset
> > -   warm   Don't set the cold reboot flag
> > -   cold   Set the cold reboot flag
> > -   triple Force a triple fault (init)
> > -   kbd    Use the keyboard controller. cold reset (default)
> > -   acpi   Use the ACPI RESET_REG in the FADT. If ACPI is not configured or the
> > -          ACPI reset does not work, the reboot path attempts the reset using
> > -          the keyboard controller.
> > -   efi    Use efi reset_system runtime service. If EFI is not configured or the
> > -          EFI reset does not work, the reboot path attempts the reset using
> > -          the keyboard controller.
> > -
> > -   Using warm reset will be much faster especially on big memory
> > -   systems because the BIOS will not go through the memory check.
> > -   Disadvantage is that not all hardware will be completely reinitialized
> > -   on reboot so there may be boot problems on some systems.
> > -
> > -   reboot=force
> > -
> > -   Don't stop other CPUs on reboot. This can make reboot more reliable
> > -   in some cases.
> > -
> > -Non Executable Mappings
> > -
> > -  noexec=on|off
> > -
> > -  on      Enable(default)
> > -  off     Disable
> > -
> > -NUMA
> > -
> > -  numa=off	Only set up a single NUMA node spanning all memory.
> > -
> > -  numa=noacpi   Don't parse the SRAT table for NUMA setup
> > -
> > -  numa=fake=<size>[MG]
> > -		If given as a memory unit, fills all system RAM with nodes of
> > -		size interleaved over physical nodes.
> > -
> > -  numa=fake=<N>
> > -		If given as an integer, fills all system RAM with N fake nodes
> > -		interleaved over physical nodes.
> > -
> > -  numa=fake=<N>U
> > -		If given as an integer followed by 'U', it will divide each
> > -		physical node into N emulated nodes.
> > -
> > -ACPI
> > -
> > -  acpi=off	Don't enable ACPI
> > -  acpi=ht	Use ACPI boot table parsing, but don't enable ACPI
> > -		interpreter
> > -  acpi=force	Force ACPI on (currently not needed)
> > -
> > -  acpi=strict   Disable out of spec ACPI workarounds.
> > -
> > -  acpi_sci={edge,level,high,low}  Set up ACPI SCI interrupt.
> > -
> > -  acpi=noirq	Don't route interrupts
> > -
> > -  acpi=nocmcff	Disable firmware first mode for corrected errors. This
> > -		disables parsing the HEST CMC error source to check if
> > -		firmware has set the FF flag. This may result in
> > -		duplicate corrected error reports.
> > -
> > -PCI
> > -
> > -  pci=off		Don't use PCI
> > -  pci=conf1		Use conf1 access.
> > -  pci=conf2		Use conf2 access.
> > -  pci=rom		Assign ROMs.
> > -  pci=assign-busses	Assign busses
> > -  pci=irqmask=MASK	Set PCI interrupt mask to MASK
> > -  pci=lastbus=NUMBER	Scan up to NUMBER busses, no matter what the mptable says.
> > -  pci=noacpi		Don't use ACPI to set up PCI interrupt routing.
> > -
> > -IOMMU (input/output memory management unit)
> > -
> > - Multiple x86-64 PCI-DMA mapping implementations exist, for example:
> > -
> > -   1. <lib/dma-direct.c>: use no hardware/software IOMMU at all
> > -      (e.g. because you have < 3 GB memory).
> > -      Kernel boot message: "PCI-DMA: Disabling IOMMU"
> > -
> > -   2. <arch/x86/kernel/amd_gart_64.c>: AMD GART based hardware IOMMU.
> > -      Kernel boot message: "PCI-DMA: using GART IOMMU"
> > -
> > -   3. <arch/x86_64/kernel/pci-swiotlb.c> : Software IOMMU implementation. Used
> > -      e.g. if there is no hardware IOMMU in the system and it is need because
> > -      you have >3GB memory or told the kernel to us it (iommu=soft))
> > -      Kernel boot message: "PCI-DMA: Using software bounce buffering
> > -      for IO (SWIOTLB)"
> > -
> > -   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
> > -      pSeries and xSeries servers. This hardware IOMMU supports DMA address
> > -      mapping with memory protection, etc.
> > -      Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
> > -
> > - iommu=[<size>][,noagp][,off][,force][,noforce]
> > -	[,memaper[=<order>]][,merge][,fullflush][,nomerge]
> > -	[,noaperture][,calgary]
> > -
> > -  General iommu options:
> > -    off                Don't initialize and use any kind of IOMMU.
> > -    noforce            Don't force hardware IOMMU usage when it is not needed.
> > -                       (default).
> > -    force              Force the use of the hardware IOMMU even when it is
> > -                       not actually needed (e.g. because < 3 GB memory).
> > -    soft               Use software bounce buffering (SWIOTLB) (default for
> > -                       Intel machines). This can be used to prevent the usage
> > -                       of an available hardware IOMMU.
> > -
> > -  iommu options only relevant to the AMD GART hardware IOMMU:
> > -    <size>             Set the size of the remapping area in bytes.
> > -    allowed            Overwrite iommu off workarounds for specific chipsets.
> > -    fullflush          Flush IOMMU on each allocation (default).
> > -    nofullflush        Don't use IOMMU fullflush.
> > -    memaper[=<order>]  Allocate an own aperture over RAM with size 32MB<<order.
> > -                       (default: order=1, i.e. 64MB)
> > -    merge              Do scatter-gather (SG) merging. Implies "force"
> > -                       (experimental).
> > -    nomerge            Don't do scatter-gather (SG) merging.
> > -    noaperture         Ask the IOMMU not to touch the aperture for AGP.
> > -    noagp              Don't initialize the AGP driver and use full aperture.
> > -    panic              Always panic when IOMMU overflows.
> > -    calgary            Use the Calgary IOMMU if it is available
> > -
> > -  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
> > -  implementation:
> > -    swiotlb=<pages>[,force]
> > -    <pages>            Prereserve that many 128K pages for the software IO
> > -                       bounce buffering.
> > -    force              Force all IO through the software TLB.
> > -
> > -  Settings for the IBM Calgary hardware IOMMU currently found in IBM
> > -  pSeries and xSeries machines:
> > -
> > -    calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
> > -    calgary=[translate_empty_slots]
> > -    calgary=[disable=<PCI bus number>]
> > -    panic              Always panic when IOMMU overflows
> > -
> > -    64k,...,8M - Set the size of each PCI slot's translation table
> > -    when using the Calgary IOMMU. This is the size of the translation
> > -    table itself in main memory. The smallest table, 64k, covers an IO
> > -    space of 32MB; the largest, 8MB table, can cover an IO space of
> > -    4GB. Normally the kernel will make the right choice by itself.
> > -
> > -    translate_empty_slots - Enable translation even on slots that have
> > -    no devices attached to them, in case a device will be hotplugged
> > -    in the future.
> > -
> > -    disable=<PCI bus number> - Disable translation on a given PHB. For
> > -    example, the built-in graphics adapter resides on the first bridge
> > -    (PCI bus number 0); if translation (isolation) is enabled on this
> > -    bridge, X servers that access the hardware directly from user
> > -    space might stop working. Use this option if you have devices that
> > -    are accessed from userspace directly on some PCI host bridge.
> > -
> > -Miscellaneous
> > -
> > -	nogbpages
> > -		Do not use GB pages for kernel direct mappings.
> > -	gbpages
> > -		Use GB pages for kernel direct mappings.
> > diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
> > new file mode 100644
> > index 000000000000..a8cf7713cac9
> > --- /dev/null
> > +++ b/Documentation/x86/x86_64/index.rst
> > @@ -0,0 +1,10 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==============
> > +x86_64 Support
> > +==============
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +
> > +   boot-options
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
