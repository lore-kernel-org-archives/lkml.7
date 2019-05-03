Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B18C04AA9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1588B20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843182;
	bh=KVN3SXa5GiVV1FFghxWEC7Dki/DXI+Aw+9RrOLy4jIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1b15sLt4GAZ+H9AQJS6PIFbqWtC+hQv5O38IhkE568Eo6I54L6v04YwZJjuYwPtJ
	 BnCIuJ1XbWGpuzJ5wM86vAP+ItzPByzXwN32fVKkaOjY4sJHgb2rtRELX6ycxfnhrj
	 oggytGKo85/3SbwjrH0SselZ1f0iom2tmooivAAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfECA0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfECA0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:26:14 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19ED12089E;
        Fri,  3 May 2019 00:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843172;
        bh=KVN3SXa5GiVV1FFghxWEC7Dki/DXI+Aw+9RrOLy4jIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPG9UQUtJ/JZnMUW6Wzc/h5Nm3jzD2IXSBk90uB5x2D325zfXwT0CVHOY6RgzpNUa
         c+dhVvWgNO7WJDE6OQ2+GMaR3Jr/s6dLfFhX7fh9gDSiHqwlyvYTlXUx+BBmlBAjgG
         Jh6sFAYZX+QTKpGiOYkYHP7L+XmtebFu//DdIuYk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 10/11] tools arch uapi: Copy missing unistd.h headers for arc, hexagon and riscv
Date:   Thu,  2 May 2019 20:25:32 -0400
Message-Id: <20190503002533.29359-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since those were introduced in:

  c8ce48f06503 ("asm-generic: Make time32 syscall numbers optional")

But when the asm-generic/unistd.h was sync'ed with tools/ in:

  1a787fc5ba18 ("tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources")

I forgot to copy the files for the architectures that define
__ARCH_WANT_TIME32_SYSCALLS, so the perf build was breaking there, as
reported by Vineet Gupta for the ARC architecture.

After updating my ARC container to use the glibc based toolchain + cross
building libnuma, zlib and elfutils, I finally managed to reproduce the
problem and verify that this now is fixed and will not regress as will
be tested before each pull req sent upstream.

Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
CC: linux-snps-arc@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190426193531.GC28586@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arc/include/uapi/asm/unistd.h     | 51 ++++++++++++++++++++
 tools/arch/hexagon/include/uapi/asm/unistd.h | 40 +++++++++++++++
 tools/arch/riscv/include/uapi/asm/unistd.h   | 42 ++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 tools/arch/arc/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/hexagon/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/riscv/include/uapi/asm/unistd.h

diff --git a/tools/arch/arc/include/uapi/asm/unistd.h b/tools/arch/arc/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..5eafa1115162
--- /dev/null
+++ b/tools/arch/arc/include/uapi/asm/unistd.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/******** no-legacy-syscalls-ABI *******/
+
+/*
+ * Non-typical guard macro to enable inclusion twice in ARCH sys.c
+ * That is how the Generic syscall wrapper generator works
+ */
+#if !defined(_UAPI_ASM_ARC_UNISTD_H) || defined(__SYSCALL)
+#define _UAPI_ASM_ARC_UNISTD_H
+
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_EXECVE
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
+
+#define sys_mmap2 sys_mmap_pgoff
+
+#include <asm-generic/unistd.h>
+
+#define NR_syscalls	__NR_syscalls
+
+/* Generic syscall (fs/filesystems.c - lost in asm-generic/unistd.h */
+#define __NR_sysfs		(__NR_arch_specific_syscall + 3)
+
+/* ARC specific syscall */
+#define __NR_cacheflush		(__NR_arch_specific_syscall + 0)
+#define __NR_arc_settls		(__NR_arch_specific_syscall + 1)
+#define __NR_arc_gettls		(__NR_arch_specific_syscall + 2)
+#define __NR_arc_usr_cmpxchg	(__NR_arch_specific_syscall + 4)
+
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
+__SYSCALL(__NR_arc_settls, sys_arc_settls)
+__SYSCALL(__NR_arc_gettls, sys_arc_gettls)
+__SYSCALL(__NR_arc_usr_cmpxchg, sys_arc_usr_cmpxchg)
+__SYSCALL(__NR_sysfs, sys_sysfs)
+
+#undef __SYSCALL
+
+#endif
diff --git a/tools/arch/hexagon/include/uapi/asm/unistd.h b/tools/arch/hexagon/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..432c4db1b623
--- /dev/null
+++ b/tools/arch/hexagon/include/uapi/asm/unistd.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Syscall support for Hexagon
+ *
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ *  The kernel pulls this unistd.h in three different ways:
+ *  1.  the "normal" way which gets all the __NR defines
+ *  2.  with __SYSCALL defined to produce function declarations
+ *  3.  with __SYSCALL defined to produce syscall table initialization
+ *  See also:  syscalltab.c
+ */
+
+#define sys_mmap2 sys_mmap_pgoff
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_EXECVE
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
+
+#include <asm-generic/unistd.h>
diff --git a/tools/arch/riscv/include/uapi/asm/unistd.h b/tools/arch/riscv/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..0e2eeeb1fd27
--- /dev/null
+++ b/tools/arch/riscv/include/uapi/asm/unistd.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2018 David Abdurachmanov <david.abdurachmanov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifdef __LP64__
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#endif /* __LP64__ */
+
+#include <asm-generic/unistd.h>
+
+/*
+ * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
+ * having a direct 'fence.i' instruction available to userspace (which we
+ * can't trap!), that's not actually viable when running on Linux because the
+ * kernel might schedule a process on another hart.  There is no way for
+ * userspace to handle this without invoking the kernel (as it doesn't know the
+ * thread->hart mappings), so we've defined a RISC-V specific system call to
+ * flush the instruction cache.
+ *
+ * __NR_riscv_flush_icache is defined to flush the instruction cache over an
+ * address range, with the flush applying to either all threads or just the
+ * caller.  We don't currently do anything with the address range, that's just
+ * in there for forwards compatibility.
+ */
+#ifndef __NR_riscv_flush_icache
+#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
+#endif
+__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-- 
2.20.1

