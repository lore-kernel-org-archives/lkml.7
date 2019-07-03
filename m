Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791FE218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562186058;
	bh=VRh1kxQj5KQPwJ1qZ1iWROc+JBUAmD5qcOf7OGsKO3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1xPnH9qF+MXpVe3rdG/evDy0EB+L9gpqbtzeOoUhTz7F2E5mOaE/cTRGFuMHfErn
	 wJY8Eo9uKYnH2LjjxrNskKQUkVSLJdYuB6BWqwcZNIfGjhLtxkaJnQIpGOPzxHc/4a
	 q0sRZUrQuZmmLISftQAgVdHrDMgCTLla4qTyCsWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGCUeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCUeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:34:11 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0511A218B0;
        Wed,  3 Jul 2019 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562186050;
        bh=VRh1kxQj5KQPwJ1qZ1iWROc+JBUAmD5qcOf7OGsKO3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJZBnUicmzJj9wm+BC+hDMSmBTCCTuyB467Hee+19KsKsMVPZzigjqB/ey6VGNnb4
         E82RaEcMOZR+TejQTeo8A8u2SI/Gy0Fdd7XXGoAYyYyag3OM+yTn4GCglaniZUIZf9
         DE4MdzuZ9Vqyu88VlzwIu/z6D4wq2NOWBCi4a4qE=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/4] x86/syscalls: Split the x32 syscalls into their own table
Date:   Wed,  3 Jul 2019 13:34:04 -0700
Message-Id: <208024256b764312598f014ebfb0a42472c19354.1562185330.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185330.git.luto@kernel.org>
References: <cover.1562185330.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unfortunate historical reasons, the x32 syscalls and the x86_64
syscalls are not all numbered the same.  As an example, ioctl() is
nr 16 on x86_64 but 514 on x32.

This has potentially nasty consequences, since it means that there are
two valid RAX values to do ioctl(2) and two invalid RAX values.  The
valid values are 16 (i.e. ioctl(2) using the x86_64 ABI) and (514 |
0x40000000) (i.e. ioctl(2) using the x32 ABI).  The invalid values are
514 and (16 | 0x40000000).  514 will enter the
"COMPAT_SYSCALL_DEFINE3(ioctl, ...)" entry point with
in_compat_syscall() and in_x32_syscall() returning false, whereas
(16 | 0x40000000) will enter the native entry point with
in_compat_syscall() and in_x32_syscall() returning true.  Both are
bogus, and both will exercise code paths in the kernel and in any
running seccomp filters that really ought to be unreachable.

By splitting out the x32 syscalls into their own tables, we can make
both bogus invocations return -ENOSYS.  I've checked glibc, musl,
and Bionic, and all of them appear to call syscalls with their
correct numbers, so this patch should have no effect on them.

This patch has an added benefit going forward: new syscalls that
need special handling on x32 can share the same number on x32 and
x86_64.  This means that the special syscall range 512-547 can be
treated as a legacy wart instead of something that may need to be
extended in the future.

This patch also adds a selftest to verify the new behavior.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c                       | 13 +--
 arch/x86/entry/syscall_64.c                   | 25 ++++++
 arch/x86/entry/syscalls/syscalltbl.sh         | 31 ++++---
 arch/x86/include/asm/syscall.h                |  4 +
 arch/x86/include/asm/unistd.h                 |  6 --
 arch/x86/kernel/asm-offsets_64.c              | 20 +++++
 tools/testing/selftests/x86/Makefile          |  2 +-
 .../testing/selftests/x86/syscall_numbering.c | 89 +++++++++++++++++++
 8 files changed, 163 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/x86/syscall_numbering.c

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 2418804e66b4..73c216d73417 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -290,15 +290,16 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
-	/*
-	 * NB: Native and x32 syscalls are dispatched from the same
-	 * table.  The only functional difference is the x32 bit in
-	 * regs->orig_ax, which changes the behavior of some syscalls.
-	 */
-	nr &= __SYSCALL_MASK;
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](regs);
+#ifdef CONFIG_X86_X32_ABI
+	} else if (likely((nr & __X32_SYSCALL_BIT) &&
+			  (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
+		nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
+					X32_NR_syscalls);
+		regs->ax = x32_sys_call_table[nr](regs);
+#endif
 	}
 
 	syscall_return_slowpath(regs);
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index d5252bc1e380..b1bf31713374 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -10,10 +10,13 @@
 /* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
 extern asmlinkage long sys_ni_syscall(const struct pt_regs *);
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
+#undef __SYSCALL_X32
 
 #define __SYSCALL_64(nr, sym, qual) [nr] = sym,
+#define __SYSCALL_X32(nr, sym, qual)
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
@@ -23,3 +26,25 @@ asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	[0 ... __NR_syscall_max] = &sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
+
+#undef __SYSCALL_64
+#undef __SYSCALL_X32
+
+#ifdef CONFIG_X86_X32_ABI
+
+#define __SYSCALL_64(nr, sym, qual)
+#define __SYSCALL_X32(nr, sym, qual) [nr] = sym,
+
+asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
+	/*
+	 * Smells like a compiler bug -- it doesn't work
+	 * when the & below is removed.
+	 */
+	[0 ... __NR_syscall_x32_max] = &sys_ni_syscall,
+#include <asm/syscalls_64.h>
+};
+
+#undef __SYSCALL_64
+#undef __SYSCALL_X32
+
+#endif
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 53c8c1a9adf9..1af2be39e7d9 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -1,13 +1,13 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 in="$1"
 out="$2"
 
 syscall_macro() {
-    abi="$1"
-    nr="$2"
-    entry="$3"
+    local abi="$1"
+    local nr="$2"
+    local entry="$3"
 
     # Entry can be either just a function name or "function/qualifier"
     real_entry="${entry%%/*}"
@@ -21,11 +21,11 @@ syscall_macro() {
 }
 
 emit() {
-    abi="$1"
-    nr="$2"
-    entry="$3"
-    compat="$4"
-    umlentry=""
+    local abi="$1"
+    local nr="$2"
+    local entry="$3"
+    local compat="$4"
+    local umlentry=""
 
     if [ "$abi" != "I386" -a -n "$compat" ]; then
 	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
@@ -62,14 +62,17 @@ grep '^[0-9]' "$in" | sort -n | (
     while read nr abi name entry compat; do
 	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
 	if [ "$abi" = "COMMON" -o "$abi" = "64" ]; then
-	    # COMMON is the same as 64, except that we don't expect X32
-	    # programs to use it.  Our expectation has nothing to do with
-	    # any generated code, so treat them the same.
 	    emit 64 "$nr" "$entry" "$compat"
+	    if [ "$abi" = "COMMON" ]; then
+		# COMMON means that this syscall exists in the same form for
+		# 64-bit and X32.
+		echo "#ifdef CONFIG_X86_X32_ABI"
+		emit X32 "$nr" "$entry" "$compat"
+		echo "#endif"
+	    fi
 	elif [ "$abi" = "X32" ]; then
-	    # X32 is equivalent to 64 on an X32-compatible kernel.
 	    echo "#ifdef CONFIG_X86_X32_ABI"
-	    emit 64 "$nr" "$entry" "$compat"
+	    emit X32 "$nr" "$entry" "$compat"
 	    echo "#endif"
 	elif [ "$abi" = "I386" ]; then
 	    emit "$abi" "$nr" "$entry" "$compat"
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2dc4a021beea..8db3fdb6102e 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -36,6 +36,10 @@ extern const sys_call_ptr_t sys_call_table[];
 extern const sys_call_ptr_t ia32_sys_call_table[];
 #endif
 
+#ifdef CONFIG_X86_X32_ABI
+extern const sys_call_ptr_t x32_sys_call_table[];
+#endif
+
 /*
  * Only the low 32 bits of orig_ax are meaningful, so we return int.
  * This importantly ignores the high bits on 64-bit, so comparisons
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 146859efd83c..b923b8d333d4 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -5,12 +5,6 @@
 #include <uapi/asm/unistd.h>
 
 
-# ifdef CONFIG_X86_X32_ABI
-#  define __SYSCALL_MASK (~(__X32_SYSCALL_BIT))
-# else
-#  define __SYSCALL_MASK (~0)
-# endif
-
 # ifdef CONFIG_X86_32
 
 #  include <asm/unistd_32.h>
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index d3d075226c0a..70e97727a26a 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -6,13 +6,28 @@
 #include <asm/ia32.h>
 
 #define __SYSCALL_64(nr, sym, qual) [nr] = 1,
+#define __SYSCALL_X32(nr, sym, qual)
 static char syscalls_64[] = {
 #include <asm/syscalls_64.h>
 };
+#undef __SYSCALL_64
+#undef __SYSCALL_X32
+
+#ifdef CONFIG_X86_X32_ABI
+#define __SYSCALL_64(nr, sym, qual)
+#define __SYSCALL_X32(nr, sym, qual) [nr] = 1,
+static char syscalls_x32[] = {
+#include <asm/syscalls_64.h>
+};
+#undef __SYSCALL_64
+#undef __SYSCALL_X32
+#endif
+
 #define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
 static char syscalls_ia32[] = {
 #include <asm/syscalls_32.h>
 };
+#undef __SYSCALL_I386
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_PARAVIRT_SPINLOCKS)
 #include <asm/kvm_para.h>
@@ -80,6 +95,11 @@ int main(void)
 	DEFINE(__NR_syscall_max, sizeof(syscalls_64) - 1);
 	DEFINE(NR_syscalls, sizeof(syscalls_64));
 
+#ifdef CONFIG_X86_X32_ABI
+	DEFINE(__NR_syscall_x32_max, sizeof(syscalls_x32) - 1);
+	DEFINE(X32_NR_syscalls, sizeof(syscalls_x32));
+#endif
+
 	DEFINE(__NR_syscall_compat_max, sizeof(syscalls_ia32) - 1);
 	DEFINE(IA32_NR_syscalls, sizeof(syscalls_ia32));
 
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 186520198de7..2f9a691ed970 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -16,7 +16,7 @@ TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
-TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip
+TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
new file mode 100644
index 000000000000..d6b09cb1aa2c
--- /dev/null
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_arg_fault.c - tests faults 32-bit fast syscall stack args
+ * Copyright (c) 2018 Andrew Lutomirski
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <syscall.h>
+
+static int nerrs;
+
+#define X32_BIT 0x40000000UL
+
+static void check_enosys(unsigned long nr, bool *ok)
+{
+	/* If this fails, a segfault is reasonably likely. */
+	fflush(stdout);
+
+	long ret = syscall(nr, 0, 0, 0, 0, 0, 0);
+	if (ret == 0) {
+		printf("[FAIL]\tsyscall %lu succeeded, but it should have failed\n", nr);
+		*ok = false;
+	} else if (errno != ENOSYS) {
+		printf("[FAIL]\tsyscall %lu had error code %d, but it should have reported ENOSYS\n", nr, errno);
+		*ok = false;
+	}
+}
+
+static void test_x32_without_x32_bit(void)
+{
+	bool ok = true;
+
+	/*
+	 * Syscalls 512-547 are "x32" syscalls.  They are intended to be
+	 * called with the x32 (0x40000000) bit set.  Calling them without
+	 * the x32 bit set is nonsense and should not work.
+	 */
+	printf("[RUN]\tChecking syscalls 512-547\n");
+	for (int i = 512; i <= 547; i++)
+		check_enosys(i, &ok);
+
+	/*
+	 * Check that a handful of 64-bit-only syscalls are rejected if the x32
+	 * bit is set.
+	 */
+	printf("[RUN]\tChecking some 64-bit syscalls in x32 range\n");
+	check_enosys(16 | X32_BIT, &ok);	/* ioctl */
+	check_enosys(19 | X32_BIT, &ok);	/* readv */
+	check_enosys(20 | X32_BIT, &ok);	/* writev */
+
+	/*
+	 * Check some syscalls with high bits set.
+	 */
+	printf("[RUN]\tChecking numbers above 2^32-1\n");
+	check_enosys((1UL << 32), &ok);
+	check_enosys(X32_BIT | (1UL << 32), &ok);
+
+	if (!ok)
+		nerrs++;
+	else
+		printf("[OK]\tThey all returned -ENOSYS\n");
+}
+
+int main()
+{
+	/*
+	 * Anyone diagnosing a failure will want to know whether the kernel
+	 * supports x32.  Tell them.
+	 */
+	printf("\tChecking for x32...");
+	fflush(stdout);
+	if (syscall(39 | X32_BIT, 0, 0, 0, 0, 0, 0) >= 0) {
+		printf(" supported\n");
+	} else if (errno == ENOSYS) {
+		printf(" not supported\n");
+	} else {
+		printf(" confused\n");
+	}
+
+	test_x32_without_x32_bit();
+
+	return nerrs ? 1 : 0;
+}
-- 
2.21.0

