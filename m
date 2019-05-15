Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85984C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627982084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfEOPMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:12:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:36718 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfEOPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:11:52 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQvYw-0001X8-JJ; Wed, 15 May 2019 18:11:22 +0300
Subject: [PATCH RFC 1/5] mm: Add process_vm_mmap() syscall declaration
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 15 May 2019 18:11:22 +0300
Message-ID: <155793308232.13922.18307403112092259417.stgit@localhost.localdomain>
In-Reply-To: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to process_vm_readv() and process_vm_writev(),
add declarations of a new syscall, which will allow
to map memory from or to another process.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 ++
 include/linux/syscalls.h               |    5 +++++
 include/uapi/asm-generic/unistd.h      |    5 ++++-
 init/Kconfig                           |    9 +++++----
 kernel/sys_ni.c                        |    2 ++
 6 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4cd5f982b1e5..bf8cc5de918f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	process_vm_mmap		sys_process_vm_mmap		__ia32_compat_sys_process_vm_mmap
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 64ca0d06259a..5af619c2d512 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	process_vm_mmap		__x64_sys_process_vm_mmap
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -398,3 +399,4 @@
 545	x32	execveat		__x32_compat_sys_execveat/ptregs
 546	x32	preadv2			__x32_compat_sys_preadv64v2
 547	x32	pwritev2		__x32_compat_sys_pwritev64v2
+548	x32	process_vm_mmap		__x32_compat_sys_process_vm_mmap
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..7d8ae36589cf 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -997,6 +997,11 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_process_vm_mmap(pid_t pid,
+				    unsigned long src_addr,
+				    unsigned long len,
+				    unsigned long dst_addr,
+				    unsigned long flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..1273d86bf546 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,12 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
 __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_process_vm_mmap 428
+__SC_COMP(__NR_process_vm_mmap, sys_process_vm_mmap, \
+          compat_sys_process_vm_mmap)
 
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
diff --git a/init/Kconfig b/init/Kconfig
index 8b9ffe236e4f..604db5f14718 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -320,13 +320,14 @@ config POSIX_MQUEUE_SYSCTL
 	default y
 
 config CROSS_MEMORY_ATTACH
-	bool "Enable process_vm_readv/writev syscalls"
+	bool "Enable process_vm_readv/writev/mmap syscalls"
 	depends on MMU
 	default y
 	help
-	  Enabling this option adds the system calls process_vm_readv and
-	  process_vm_writev which allow a process with the correct privileges
-	  to directly read from or write to another process' address space.
+	  Enabling this option adds the system calls process_vm_readv,
+	  process_vm_writev and process_vm_mmap, which allow a process
+	  with the correct privileges to directly read from or write to
+	  or mmap another process' address space.
 	  See the man page for more details.
 
 config USELIB
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..6f51634f4f7e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -316,6 +316,8 @@ COND_SYSCALL(process_vm_readv);
 COND_SYSCALL_COMPAT(process_vm_readv);
 COND_SYSCALL(process_vm_writev);
 COND_SYSCALL_COMPAT(process_vm_writev);
+COND_SYSCALL(process_vm_mmap);
+COND_SYSCALL_COMPAT(process_vm_mmap);
 
 /* compare kernel pointers */
 COND_SYSCALL(kcmp);

