Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA50C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E452186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574099020;
	bh=Gs4XpVZ7QJjWFFs2nclvmjkR4l3yvqgE7MsMtSWOhps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dZR2qEZnkCU/SH6CTlZEdr9W1EROiwJezRj/Hi3IDHkPuV1p9rIoD/xWXoJwYKHNU
	 wI/RWZhW9IcgftLkwiu38td/zHPyYicQjd0fY1/DINetZ+U+eCrDegLZlTXbtsRihG
	 4NZBaWO6SbuUrqIu/KcObGnoLTBo1XSuutWIMYPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfKRRni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:43:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37907 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfKRRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:43:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so20568227wro.5;
        Mon, 18 Nov 2019 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4ZGu9GaSykUrUtDjgjE86yoyZv/5jyvwD0NxGBLc3Y=;
        b=c88D4KcjubRwUtppyUJBZfj+vGm3eupAsbwNxtWVrmnPu8st2LnMLKtqDT3QUG77IU
         PZeUJAyZI+mEuScpIrASct9n8K2nDlXRR/1KrtqcCMxLhB1V8r4/LyL/lwkRj+zLsdO/
         yElLK/Eam60UvLEKwoYBXZct/yGF4UmKk7CzsWkgzONOWWtNpmxSIjkf/m6ntRvZfFL8
         8e7uZHi6AL6Wod0R8TvmskJpz3V4QtZbIV+vmnRwlej8amttGP/ASU9fH/1ax4aN5IXD
         rWZt3VuqWbfO5b1dn0RvZQ4hsW9pxmozSt20Fdpo+9VMAzdOJRq1taXXjW7GosF6DH36
         1aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4ZGu9GaSykUrUtDjgjE86yoyZv/5jyvwD0NxGBLc3Y=;
        b=ZYWsxLwYjK7/kvTUSl+enaUJe0B8NImui6QnE7DEu4/9ACOOl0k32NSaHNS8afxKiZ
         /R6BPzpj955Gmik4MyXVi2C1LvJM4GBl2EE2zW/e2HSOiMEzsXTcOv4EV3iNN5vN4MGo
         zBmol1nezq4gZYYvvKeezZuHQPho6owtgps3G93InVKk0Q+ybNnTqv9APhcbJBvGK56N
         SAg2oXg071K5+74IS5ebeEKEBBZXMeWXEojonBZrTp3OO65reMbeawPcCXbVcb2RMsKc
         vntBQLPD9zLbztABgAW70VurTDeYOPWy6dQFx1vrfhvtlhvz4lZp8DC8IlCloqy3Q5GD
         V5kQ==
X-Gm-Message-State: APjAAAWhSCUklsMnufyLrNeElOwxW/pV5EVzFT6swpHC2GGFeIjKKk9B
        BhlHt8Br3RsvlRXYJylz8aI=
X-Google-Smtp-Source: APXvYqw17JHWJU13OtpqGqKNwBzV/pfnyyHE3epirb5MIRXrZciDJrCpcBdBCysBxzAfIqP1kRig7Q==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr30993848wrv.360.1574099014934;
        Mon, 18 Nov 2019 09:43:34 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w132sm127816wma.6.2019.11.18.09.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:43:34 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:43:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Robert Richter <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        x86-ml <x86@kernel.org>
Subject: [PATCH] Re: [tip: x86/cleanups] x86: Fix typos in comments
Message-ID: <20191118174332.GA41920@gmail.com>
References: <20191118070012.27850-1-caoj.fnst@cn.fujitsu.com>
 <157406828172.12247.4218858363680758865.tip-bot2@tip-bot2>
 <20191118121027.GA74767@gmail.com>
 <20191118124633.GA6363@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118124633.GA6363@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> >  /*
> >   * Keep the crash kernel below this limit.
> >   *
> > - * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
> > + * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
> >   * due to mapping restrictions.
> >   *
> > - * On 64bit, kdump kernel need be restricted to be under 64TB, which is
> > + * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
> >   * the upper limit of system RAM in 4-level paging mode. Since the kdump
> > - * jumping could be from 5-level to 4-level, the jumping will fail if
> > - * kernel is put above 64TB, and there's no way to detect the paging mode
> > - * of the kernel which will be loaded for dumping during the 1st kernel
> > - * bootup.
> > + * jump could be from 5-level paging to 4-level paging, the jump will fail if
> > + * the kernel is put above 64 TB, and during the 1st kernel bootup there's
> > + * no good way to detect the paging mode of the target kernel which will be
> > + * loaded for dumping.
> >   */
> >  #ifdef CONFIG_X86_32
> >  # define CRASH_ADDR_LOW_MAX	SZ_512M
> 
> Yap, sure.
> 
> Except that tglx committed another patch ontop of x86/cleanups in the 
> meantime. I leave it up to you to decide what to do. I'd backmerge and 
> rebase but this is just me.

Well, I did the two patches on top: once shrinks the number of #include 
lines from 90 to 30, the other improves most of the comments, with a 
bunch of other typo/grammar fixes, but more importantly I tried to 
clarify/extend/fix the comments where they were misleading or 
meaningless:

  9dcc69c4ea5c: x86/setup: Enhance the comments
  c1877650f3c9: x86/setup: Clean up the header portion of setup.c

Attached below as well.

Thanks,

	Ingo


===============>
commit 9dcc69c4ea5c0cd4031a4dde645c71b66bea04f8
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Nov 18 16:03:39 2019 +0100

    x86/setup: Enhance the comments
    
    Update various comments, fix outright mistakes and meaningless descriptions.
    
    Also harmonize the style across the file, both in form and in language.
    
    Cc: linux-kernel@vger.kernel.org
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5f483eb14d44..c7774af9f8a1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -41,11 +41,11 @@
 #include <asm/vsyscall.h>
 
 /*
- * max_low_pfn_mapped: highest direct mapped pfn under 4GB
- * max_pfn_mapped:     highest direct mapped pfn over 4GB
+ * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
+ * max_pfn_mapped:     highest directly mapped pfn > 4 GB
  *
  * The direct mapping only covers E820_TYPE_RAM regions, so the ranges and gaps are
- * represented by pfn_mapped
+ * represented by pfn_mapped[].
  */
 unsigned long max_low_pfn_mapped;
 unsigned long max_pfn_mapped;
@@ -55,14 +55,23 @@ RESERVE_BRK(dmi_alloc, 65536);
 #endif
 
 
-static __initdata unsigned long _brk_start = (unsigned long)__brk_base;
-unsigned long _brk_end = (unsigned long)__brk_base;
+/*
+ * Range of the BSS area. The size of the BSS area is determined
+ * at link time, with RESERVE_BRK*() facility reserving additional
+ * chunks.
+ */
+static __initdata
+unsigned long _brk_start = (unsigned long)__brk_base;
+unsigned long _brk_end   = (unsigned long)__brk_base;
 
 struct boot_params boot_params;
 
 /*
- * Machine setup..
+ * These are the four main kernel memory regions, we put them into
+ * the resource tree so that kdump tools and other debugging tools
+ * recover it:
  */
+
 static struct resource rodata_resource = {
 	.name	= "Kernel rodata",
 	.start	= 0,
@@ -93,16 +102,16 @@ static struct resource bss_resource = {
 
 
 #ifdef CONFIG_X86_32
-/* cpu data as detected by the assembly code in head_32.S */
+/* CPU data as detected by the assembly code in head_32.S */
 struct cpuinfo_x86 new_cpu_data;
 
-/* common cpu data for all cpus */
+/* Common CPU data for all CPUs */
 struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned int def_to_bigsmp;
 
-/* for MCA, but anyone else can use it if they want */
+/* For MCA, but anyone else can use it if they want */
 unsigned int machine_id;
 unsigned int machine_submodel_id;
 unsigned int BIOS_revision;
@@ -382,15 +391,15 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 /*
  * Keep the crash kernel below this limit.
  *
- * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
  * due to mapping restrictions.
  *
- * On 64bit, kdump kernel need be restricted to be under 64TB, which is
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
  * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jumping could be from 5-level to 4-level, the jumping will fail if
- * kernel is put above 64TB, and there's no way to detect the paging mode
- * of the kernel which will be loaded for dumping during the 1st kernel
- * bootup.
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	SZ_512M
@@ -801,7 +810,7 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * Note: Quark X1000 CPUs advertise PGE incorrectly and require
 	 * a cr3 based tlb flush, so the following __flush_tlb_all()
-	 * will not flush anything because the cpu quirk which clears
+	 * will not flush anything because the CPU quirk which clears
 	 * X86_FEATURE_PGE has not been invoked yet. Though due to the
 	 * load_cr3() above the TLB has been flushed already. The
 	 * quirk is invoked before subsequent calls to __flush_tlb_all()

commit c1877650f3c9fb8568f8dce3fc804ab45125cf78
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Nov 18 15:49:22 2019 +0100

    x86/setup: Clean up the header portion of setup.c
    
    In 20 years we accumulated 89 #include lines in setup.c,
    but we only need 30 of them (!) ...
    
    Get rid of the excessive ones, and while at it, sort the
    remaining ones alphabetically.
    
    Also get rid of the incomplete changelogs at the header of the file,
    and explain better what this file does.
    
    Cc: linux-kernel@vger.kernel.org
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ea6496f2debb..5f483eb14d44 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -2,123 +2,43 @@
 /*
  *  Copyright (C) 1995  Linus Torvalds
  *
- *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
- *
- *  Memory region support
- *	David Parsons <orc@pell.chi.il.us>, July-August 1999
- *
- *  Added E820 sanitization routine (removes overlapping memory regions);
- *  Brian Moyle <bmoyle@mvista.com>, February 2001
- *
- * Moved CPU detection code to cpu/${cpu}.c
- *    Patrick Mochel <mochel@osdl.org>, March 2002
- *
- *  Provisions for empty E820 memory regions (reported by certain BIOSes).
- *  Alex Achenbach <xela@slit.de>, December 2002.
- *
+ * This file contains the setup_arch() code, which handles the architecture-dependent
+ * parts of early kernel initialization.
  */
-
-/*
- * This file handles the architecture-dependent parts of initialization
- */
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/mmzone.h>
-#include <linux/screen_info.h>
-#include <linux/ioport.h>
-#include <linux/acpi.h>
-#include <linux/sfi.h>
-#include <linux/apm_bios.h>
-#include <linux/initrd.h>
-#include <linux/memblock.h>
-#include <linux/seq_file.h>
 #include <linux/console.h>
-#include <linux/root_dev.h>
-#include <linux/highmem.h>
-#include <linux/export.h>
+#include <linux/crash_dump.h>
+#include <linux/dmi.h>
 #include <linux/efi.h>
-#include <linux/init.h>
-#include <linux/edd.h>
+#include <linux/init_ohci1394_dma.h>
+#include <linux/initrd.h>
 #include <linux/iscsi_ibft.h>
-#include <linux/nodemask.h>
-#include <linux/kexec.h>
-#include <linux/dmi.h>
-#include <linux/pfn.h>
+#include <linux/memblock.h>
 #include <linux/pci.h>
-#include <asm/pci-direct.h>
-#include <linux/init_ohci1394_dma.h>
-#include <linux/kvm_para.h>
-#include <linux/dma-contiguous.h>
-#include <xen/xen.h>
-#include <uapi/linux/mount.h>
-
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
-#include <linux/user.h>
-#include <linux/delay.h>
-
-#include <linux/kallsyms.h>
-#include <linux/cpufreq.h>
-#include <linux/dma-mapping.h>
-#include <linux/ctype.h>
-#include <linux/uaccess.h>
-
-#include <linux/percpu.h>
-#include <linux/crash_dump.h>
+#include <linux/root_dev.h>
+#include <linux/sfi.h>
 #include <linux/tboot.h>
-#include <linux/jiffies.h>
-#include <linux/mem_encrypt.h>
-#include <linux/sizes.h>
-
 #include <linux/usb/xhci-dbgp.h>
-#include <video/edid.h>
 
-#include <asm/mtrr.h>
-#include <asm/apic.h>
-#include <asm/realmode.h>
-#include <asm/e820/api.h>
-#include <asm/mpspec.h>
-#include <asm/setup.h>
-#include <asm/efi.h>
-#include <asm/timer.h>
-#include <asm/i8259.h>
-#include <asm/sections.h>
-#include <asm/io_apic.h>
-#include <asm/ist.h>
-#include <asm/setup_arch.h>
+#include <uapi/linux/mount.h>
+
+#include <xen/xen.h>
+
 #include <asm/bios_ebda.h>
-#include <asm/cacheflush.h>
-#include <asm/processor.h>
 #include <asm/bugs.h>
-#include <asm/kasan.h>
-
-#include <asm/vsyscall.h>
 #include <asm/cpu.h>
-#include <asm/desc.h>
-#include <asm/dma.h>
-#include <asm/iommu.h>
+#include <asm/efi.h>
 #include <asm/gart.h>
-#include <asm/mmu_context.h>
-#include <asm/proto.h>
-
-#include <asm/paravirt.h>
 #include <asm/hypervisor.h>
-#include <asm/olpc_ofw.h>
-
-#include <asm/percpu.h>
-#include <asm/topology.h>
-#include <asm/apicdef.h>
-#include <asm/amd_nb.h>
+#include <asm/kasan.h>
+#include <asm/kaslr.h>
 #include <asm/mce.h>
-#include <asm/alternative.h>
+#include <asm/mtrr.h>
+#include <asm/olpc_ofw.h>
+#include <asm/pci-direct.h>
 #include <asm/prom.h>
-#include <asm/microcode.h>
-#include <asm/kaslr.h>
+#include <asm/proto.h>
 #include <asm/unwind.h>
+#include <asm/vsyscall.h>
 
 /*
  * max_low_pfn_mapped: highest direct mapped pfn under 4GB
