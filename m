Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D8C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B9920748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfKYQ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:29:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfKYQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:29:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZHFE-0001Sw-CY; Mon, 25 Nov 2019 17:29:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0381F1C1B00;
        Mon, 25 Nov 2019 17:29:48 +0100 (CET)
Date:   Mon, 25 Nov 2019 16:29:47 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Clean up the header portion of setup.c
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
MIME-Version: 1.0
Message-ID: <157469938792.21853.10716859022241922963.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d3d9911e0e1258819e7a245dd200f3637aa3ee47
Gitweb:        https://git.kernel.org/tip/d3d9911e0e1258819e7a245dd200f3637aa3ee47
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 15:49:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 17:49:15 +01:00

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
---
 arch/x86/kernel/setup.c | 122 +++++++--------------------------------
 1 file changed, 22 insertions(+), 100 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ea6496f..26a4a73 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -2,123 +2,45 @@
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
+#include <uapi/linux/mount.h>
+
+#include <xen/xen.h>
+
 #include <asm/apic.h>
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
+#include <asm/io_apic.h>
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
