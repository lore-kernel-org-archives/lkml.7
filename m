Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007E421530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfEHRDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:03:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:5321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfEHRDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697610"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:05 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for FSGSBASE
Date:   Wed,  8 May 2019 03:02:33 -0700
Message-Id: <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

v2: Minor updates to documentation requested in review.
v3: Update for new gcc and various improvements.
v4: Address the typos pointed by Randy Dunlap

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/x86/fsgs.txt | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/x86/fsgs.txt

diff --git a/Documentation/x86/fsgs.txt b/Documentation/x86/fsgs.txt
new file mode 100644
index 0000000..a6e2e38
--- /dev/null
+++ b/Documentation/x86/fsgs.txt
@@ -0,0 +1,103 @@
+
+Using FS and GS prefixes on 64-bit x86 linux
+
+The x86 architecture supports segment prefixes per instruction to add an
+offset to an address.  On 64-bit x86, these are mostly nops, except for FS
+and GS.
+
+This offers an efficient way to reference a global pointer.
+
+The compiler has to generate special code to use these base registers,
+or they can be accessed with inline assembler.
+
+	mov %gs:offset,%reg
+	mov %fs:offset,%reg
+
+On 64-bit code, FS is used to address the thread local segment (TLS), declared
+using thread. The compiler then automatically generates the correct prefixes
+and relocations to access these values.
+
+FS is normally managed by the runtime code or the threading library.
+Overwriting it can break a lot of things (including syscalls and gdb),
+but it can make sense to save/restore it for threading purposes.
+
+GS is freely available, but may need special (compiler or inline assembler)
+code to use.
+
+Traditionally 64-bit FS and GS could be set by the arch_prctl system call
+
+	arch_prctl(ARCH_SET_GS, value)
+	arch_prctl(ARCH_SET_FS, value)
+
+[There was also an older method using modify_ldt(), inherited from 32-bit,
+but this is not discussed here.]
+
+However, using a syscall is problematic for user space threading libraries
+that want to context switch in user space. The whole point of them
+is avoiding the overhead of a syscall. It's also cleaner for compilers
+wanting to use the extra register to use instructions to write
+it, or read it directly to compute addresses and offsets.
+
+Newer Intel CPUs (Ivy Bridge and later) added new instructions to directly
+access these registers quickly from user context:
+
+	RDFSBASE %reg	read the FS base	(or _readfsbase_u64)
+	RDGSBASE %reg	read the GS base	(or _readgsbase_u64)
+
+	WRFSBASE %reg	write the FS base	(or _writefsbase_u64)
+	WRGSBASE %reg	write the GS base	(or _writegsbase_u64)
+
+If you use the intrinsics, include <immintrin.h> and set the -mfsgsbase option.
+
+The instructions are supported by the CPU when the "fsgsbase" string is shown
+in /proc/cpuinfo (or directly retrieved through the CPUID instruction,
+7:0 (ebx), word 9, bit 0).
+
+The instructions are only available to 64-bit binaries.
+
+In addition the kernel needs to explicitly enable these instructions, as it
+may otherwise not correctly context switch the state. Newer Linux
+kernels enable this. When the kernel does not enable the instruction
+they will fault with a #UD exception.
+
+An FSGSBASE-enabled kernel can be detected by checking the AT_HWCAP2
+bitmask in the aux vector. When the HWCAP2_FSGSBASE bit is set the
+kernel supports FSGSBASE.
+
+	#include <sys/auxv.h>
+	#include <elf.h>
+
+	/* Will be eventually in asm/hwcap.h */
+	#define HWCAP2_FSGSBASE        (1 << 1)
+
+        unsigned val = getauxval(AT_HWCAP2);
+        if (val & HWCAP2_FSGSBASE) {
+                asm("wrgsbase %0" :: "r" (ptr));
+        }
+
+No extra CPUID check is needed as the kernel will not set this bit if the CPU
+does not support it.
+
+gcc 6 has special support to directly access data relative to fs/gs using the
+__seg_fs and __seg_gs address space pointer modifiers.
+
+#ifndef __SEG_GS
+#error "Need gcc 6 or later"
+#endif
+
+struct gsdata {
+	int a;
+	int b;
+} gsdata = { 1, 2 };
+
+int __seg_gs *valp = 0;		/* offset relative to GS */
+
+	/* Check if kernel supports FSGSBASE as above */
+
+	/* Set up new GS */
+	asm("wrgsbase %0" :: "r" (&gsdata));
+
+	/* Now the global pointer can be used normally */
+	printf("gsdata.a = %d\n", *valp);
+
+Andi Kleen
-- 
2.7.4

