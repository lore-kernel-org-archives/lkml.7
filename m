Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4867C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A5E206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfCELuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:50:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfCELuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:50:18 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h18ZO-0004Um-5a; Tue, 05 Mar 2019 12:49:16 +0100
Subject: [GIT pull] Year 2038 updates for 5.1
Message-ID: <155178637783.3906.1920069893327897892.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
Date:   Tue, 05 Mar 2019 12:49:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-2038-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-2038-for-linus

Another round of changes to make the kernel ready for 2038. After lots of
preparatory work this is the first set of syscalls which are 2038 safe:

    403 clock_gettime64
    404 clock_settime64
    405 clock_adjtime64
    406 clock_getres_time64
    407 clock_nanosleep_time64
    408 timer_gettime64
    409 timer_settime64
    410 timerfd_gettime64
    411 timerfd_settime64
    412 utimensat_time64
    413 pselect6_time64
    414 ppoll_time64
    416 io_pgetevents_time64
    417 recvmmsg_time64
    418 mq_timedsend_time64
    419 mq_timedreceiv_time64
    420 semtimedop_time64
    421 rt_sigtimedwait_time64
    422 futex_time64
    423 sched_rr_get_interval_time64
    
The syscall numbers are identical all over the architectures.

Thanks,

	tglx

------------------>
Arnd Bergmann (35):
      s390: open-code s390_personality syscall
      ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
      s390: use generic UID16 implementation
      s390: autogenerate compat syscall wrappers
      s390: remove compat_wrapper.c
      ia64: add __NR_umount2 definition
      ia64: add statx and io_pgetevents syscalls
      ia64: assign syscall numbers for perf and seccomp
      alpha: wire up io_pgetevents system call
      alpha: update syscall macro definitions
      ARM: add migrate_pages() system call
      ARM: add kexec_file_load system call number
      m68k: assign syscall number for seccomp
      sh: remove duplicate unistd_32.h file
      sh: add statx system call
      sparc64: fix sparc_ipc type conversion
      ipc: rename old-style shmctl/semctl/msgctl syscalls
      arch: add split IPC system calls where needed
      arch: add pkey and rseq syscall numbers everywhere
      alpha: add standard statfs64/fstatfs64 syscalls
      alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
      time: make adjtime compat handling available for 32 bit
      time: fix sys_timer_settime prototype
      sparc64: add custom adjtimex/clock_adjtime functions
      x86/x32: use time64 versions of sigtimedwait and recvmmsg
      y2038: syscalls: rename y2038 compat syscalls
      syscalls: remove obsolete __IGNORE_ macros
      y2038: use time32 syscall names on 32-bit
      y2038: remove struct definition redirects
      y2038: rename old time and utime syscalls
      y2038: add 64-bit time_t syscalls to all 32-bit architectures
      asm-generic: Make time32 syscall numbers optional
      unicore32: Fix __ARCH_WANT_STAT64 definition
      checksyscalls: fix up mq_timedreceive and stat exceptions
      riscv: Use latest system call ABI

Deepa Dinamani (3):
      time: Add struct __kernel_timex
      timex: use __kernel_timex internally
      timex: change syscalls to use struct __kernel_timex

Yury Norov (3):
      compat ABI: use non-compat openat and open_by_handle_at variants
      32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
      asm-generic: Drop getrlimit and setrlimit syscalls from default list


 arch/Kconfig                                |  12 +-
 arch/alpha/include/asm/unistd.h             |  21 --
 arch/alpha/include/uapi/asm/unistd.h        |  10 +
 arch/alpha/kernel/osf_sys.c                 |   5 +-
 arch/alpha/kernel/syscalls/syscall.tbl      |  22 +-
 arch/arc/Kconfig                            |   1 +
 arch/arc/include/uapi/asm/unistd.h          |   2 +
 arch/arm/Kconfig                            |   1 +
 arch/arm/include/asm/unistd.h               |   5 +-
 arch/arm/kernel/sys_oabi-compat.c           |   8 +-
 arch/arm/tools/syscall.tbl                  |  85 +++---
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  99 +++++--
 arch/arm64/include/uapi/asm/unistd.h        |   2 +
 arch/c6x/Kconfig                            |   1 +
 arch/c6x/include/uapi/asm/unistd.h          |   2 +
 arch/csky/Kconfig                           |   1 +
 arch/csky/include/uapi/asm/unistd.h         |   2 +
 arch/h8300/Kconfig                          |   1 +
 arch/h8300/include/uapi/asm/unistd.h        |   2 +
 arch/hexagon/Kconfig                        |   1 +
 arch/hexagon/include/uapi/asm/unistd.h      |   2 +
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  11 +-
 arch/m68k/Kconfig                           |   1 +
 arch/m68k/include/asm/unistd.h              |   4 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  88 ++++--
 arch/microblaze/Kconfig                     |   1 +
 arch/microblaze/include/asm/unistd.h        |   4 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  83 +++---
 arch/mips/Kconfig                           |   1 +
 arch/mips/include/asm/unistd.h              |  17 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  77 ++++--
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   7 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  85 ++++--
 arch/nds32/Kconfig                          |   1 +
 arch/nds32/include/uapi/asm/unistd.h        |   2 +
 arch/nios2/Kconfig                          |   1 +
 arch/nios2/include/uapi/asm/unistd.h        |   2 +
 arch/openrisc/Kconfig                       |   1 +
 arch/openrisc/include/uapi/asm/unistd.h     |   2 +
 arch/parisc/Kconfig                         |   1 +
 arch/parisc/include/asm/unistd.h            |  13 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 109 ++++++--
 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/asm/unistd.h           |   8 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 134 +++++++--
 arch/riscv/include/uapi/asm/unistd.h        |   1 +
 arch/riscv/kernel/vdso/Makefile             |   2 +
 arch/s390/Kconfig                           |   2 +
 arch/s390/include/asm/syscall_wrapper.h     | 135 ++++++++++
 arch/s390/include/asm/unistd.h              |   7 +-
 arch/s390/include/uapi/asm/posix_types.h    |   6 +
 arch/s390/kernel/Makefile                   |   2 +-
 arch/s390/kernel/compat_linux.c             | 235 +---------------
 arch/s390/kernel/compat_wrapper.c           | 186 -------------
 arch/s390/kernel/entry.S                    |   4 +-
 arch/s390/kernel/sys_s390.c                 |  16 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 373 +++++++++++++------------
 arch/sh/Kconfig                             |   1 +
 arch/sh/include/asm/unistd.h                |   4 +-
 arch/sh/include/uapi/asm/unistd_32.h        | 403 ----------------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  88 ++++--
 arch/sparc/Kconfig                          |   1 +
 arch/sparc/include/asm/unistd.h             |  13 +-
 arch/sparc/kernel/sys_sparc_64.c            |  61 ++++-
 arch/sparc/kernel/syscalls/syscall.tbl      | 116 ++++++--
 arch/unicore32/Kconfig                      |   1 +
 arch/unicore32/include/uapi/asm/unistd.h    |   4 +-
 arch/x86/Kconfig                            |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  85 ++++--
 arch/x86/entry/syscalls/syscall_64.tbl      |   6 +-
 arch/x86/include/asm/unistd.h               |   8 +-
 arch/x86/um/Kconfig                         |   1 +
 arch/xtensa/Kconfig                         |   1 +
 arch/xtensa/include/asm/unistd.h            |  14 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  78 ++++--
 drivers/ptp/ptp_clock.c                     |   2 +-
 fs/aio.c                                    |  10 +-
 fs/select.c                                 |   4 +-
 fs/timerfd.c                                |   4 +-
 fs/utimes.c                                 |  10 +-
 include/linux/compat.h                      | 104 +------
 include/linux/fcntl.h                       |   2 +-
 include/linux/posix-clock.h                 |   2 +-
 include/linux/syscalls.h                    |  72 ++++-
 include/linux/time32.h                      |  32 ++-
 include/linux/time64.h                      |   8 -
 include/linux/timex.h                       |   4 +-
 include/uapi/asm-generic/unistd.h           | 149 +++++++---
 include/uapi/linux/time.h                   |   4 -
 include/uapi/linux/timex.h                  |  39 +++
 ipc/mqueue.c                                |  16 +-
 ipc/msg.c                                   |  39 ++-
 ipc/sem.c                                   |  41 ++-
 ipc/shm.c                                   |  40 ++-
 ipc/syscall.c                               |  32 ++-
 ipc/util.h                                  |  21 +-
 kernel/compat.c                             |  64 -----
 kernel/futex.c                              |   2 +-
 kernel/sched/core.c                         |   5 +-
 kernel/signal.c                             |   2 +-
 kernel/sys_ni.c                             |  22 +-
 kernel/time/hrtimer.c                       |   2 +-
 kernel/time/ntp.c                           |  18 +-
 kernel/time/ntp_internal.h                  |   2 +-
 kernel/time/posix-clock.c                   |   2 +-
 kernel/time/posix-stubs.c                   |  25 +-
 kernel/time/posix-timers.c                  |  72 +++--
 kernel/time/posix-timers.h                  |   2 +-
 kernel/time/time.c                          |  92 ++++++-
 kernel/time/timekeeping.c                   |   4 +-
 net/compat.c                                |   2 +-
 scripts/checksyscalls.sh                    |  53 +++-
 115 files changed, 1979 insertions(+), 1837 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..cd5f443865ec 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -276,6 +276,16 @@ config ARCH_THREAD_STACK_ALLOCATOR
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
 
+config ARCH_32BIT_OFF_T
+	bool
+	depends on !64BIT
+	help
+	  All new 32-bit architectures should have 64-bit off_t type on
+	  userspace side which corresponds to the loff_t kernel type. This
+	  is the requirement for modern ABIs. Some existing architectures
+	  still support 32-bit off_t. This option is enabled for all such
+	  architectures explicitly.
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
@@ -759,7 +769,7 @@ config 64BIT_TIME
 	  handling.
 
 config COMPAT_32BIT_TIME
-	def_bool (!64BIT && 64BIT_TIME) || COMPAT
+	def_bool !64BIT || COMPAT
 	help
 	  This enables 32 bit time_t support in addition to 64 bit time_t support.
 	  This is relevant on all 32-bit architectures, and 64-bit architectures
diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 21b706a5b772..986f5da9b7d8 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -19,25 +19,4 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
-/*
- * Ignore legacy syscalls that we don't use.
- */
-#define __IGNORE_alarm
-#define __IGNORE_creat
-#define __IGNORE_getegid
-#define __IGNORE_geteuid
-#define __IGNORE_getgid
-#define __IGNORE_getpid
-#define __IGNORE_getppid
-#define __IGNORE_getuid
-#define __IGNORE_pause
-#define __IGNORE_time
-#define __IGNORE_utime
-#define __IGNORE_umount2
-
-/* Alpha doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 9ba724f116f1..71fd5db06866 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -2,6 +2,16 @@
 #ifndef _UAPI_ALPHA_UNISTD_H
 #define _UAPI_ALPHA_UNISTD_H
 
+/* These are traditionally the names linux-alpha uses for
+ * the two otherwise generic system calls */
+#define __NR_umount	__NR_umount2
+#define __NR_osf_shmat	__NR_shmat
+
+/* These return an extra value but can be used as aliases */
+#define __NR_getpid	__NR_getxpid
+#define __NR_getuid	__NR_getxuid
+#define __NR_getgid	__NR_getxgid
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 792586038808..bf497b8b0ec6 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1253,7 +1253,7 @@ struct timex32 {
 
 SYSCALL_DEFINE1(old_adjtimex, struct timex32 __user *, txc_p)
 {
-        struct timex txc;
+	struct __kernel_timex txc;
 	int ret;
 
 	/* copy relevant bits of struct timex. */
@@ -1270,7 +1270,8 @@ SYSCALL_DEFINE1(old_adjtimex, struct timex32 __user *, txc_p)
 	if (copy_to_user(txc_p, &txc, offsetof(struct timex32, time)) ||
 	    (copy_to_user(&txc_p->tick, &txc.tick, sizeof(struct timex32) - 
 			  offsetof(struct timex32, tick))) ||
-	    (put_tv_to_tv32(&txc_p->time, &txc.time)))
+	    (put_user(txc.time.tv_sec, &txc_p->time.tv_sec)) ||
+	    (put_user(txc.time.tv_usec, &txc_p->time.tv_usec)))
 	  return -EFAULT;
 
 	return ret;
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 7b56a53be5e3..63ed39cbd3bd 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 19	common	lseek				sys_lseek
 20	common	getxpid				sys_getxpid
 21	common	osf_mount			sys_osf_mount
-22	common	umount				sys_umount
+22	common	umount2				sys_umount
 23	common	setuid				sys_setuid
 24	common	getxuid				sys_getxuid
 25	common	exec_with_loader		sys_ni_syscall
@@ -174,17 +174,17 @@
 187	common	osf_alt_sigpending		sys_ni_syscall
 188	common	osf_alt_setsid			sys_ni_syscall
 199	common	osf_swapon			sys_swapon
-200	common	msgctl				sys_msgctl
+200	common	msgctl				sys_old_msgctl
 201	common	msgget				sys_msgget
 202	common	msgrcv				sys_msgrcv
 203	common	msgsnd				sys_msgsnd
-204	common	semctl				sys_semctl
+204	common	semctl				sys_old_semctl
 205	common	semget				sys_semget
 206	common	semop				sys_semop
 207	common	osf_utsname			sys_osf_utsname
 208	common	lchown				sys_lchown
-209	common	osf_shmat			sys_shmat
-210	common	shmctl				sys_shmctl
+209	common	shmat				sys_shmat
+210	common	shmctl				sys_old_shmctl
 211	common	shmdt				sys_shmdt
 212	common	shmget				sys_shmget
 213	common	osf_mvalid			sys_ni_syscall
@@ -451,3 +451,15 @@
 520	common	preadv2				sys_preadv2
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents
+524	common	pkey_mprotect			sys_pkey_mprotect
+525	common	pkey_alloc			sys_pkey_alloc
+526	common	pkey_free			sys_pkey_free
+527	common	rseq				sys_rseq
+528	common	statfs64			sys_statfs64
+529	common	fstatfs64			sys_fstatfs64
+530	common	getegid				sys_getegid
+531	common	geteuid				sys_geteuid
+532	common	getppid				sys_getppid
+# all other architectures have common numbers for new syscall, alpha
+# is the exception.
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..1cfe4197146f 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -14,6 +14,7 @@ config ARC
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
+	select ARCH_32BIT_OFF_T
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index 3b3543fd151c..5eafa1115162 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -18,10 +18,12 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #define sys_mmap2 sys_mmap_pgoff
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..8933f7337e56 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2,6 +2,7 @@
 config ARM
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID && !KEXEC
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 88ef2ce1f69a..7a39e77984ef 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -26,10 +26,10 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_OLD_MMAP
 #define __ARCH_WANT_SYS_OLD_SELECT
-#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_UTIME32
 
 #if !defined(CONFIG_AEABI) || defined(CONFIG_OABI_COMPAT)
-#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_TIME32
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_ALARM
@@ -45,7 +45,6 @@
  * Unimplemented (or alternatively implemented) syscalls
  */
 #define __IGNORE_fadvise64_64
-#define __IGNORE_migrate_pages
 
 #ifdef __ARM_EABI__
 /*
diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 92ab36f38795..acd054a42ba2 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -317,10 +317,10 @@ struct oabi_sembuf {
 asmlinkage long sys_oabi_semtimedop(int semid,
 				    struct oabi_sembuf __user *tsops,
 				    unsigned nsops,
-				    const struct timespec __user *timeout)
+				    const struct old_timespec32 __user *timeout)
 {
 	struct sembuf *sops;
-	struct timespec local_timeout;
+	struct old_timespec32 local_timeout;
 	long err;
 	int i;
 
@@ -350,7 +350,7 @@ asmlinkage long sys_oabi_semtimedop(int semid,
 	} else {
 		mm_segment_t fs = get_fs();
 		set_fs(KERNEL_DS);
-		err = sys_semtimedop(semid, sops, nsops, timeout);
+		err = sys_semtimedop_time32(semid, sops, nsops, timeout);
 		set_fs(fs);
 	}
 	kfree(sops);
@@ -375,7 +375,7 @@ asmlinkage int sys_oabi_ipc(uint call, int first, int second, int third,
 		return  sys_oabi_semtimedop(first,
 					    (struct oabi_sembuf __user *)ptr,
 					    second,
-					    (const struct timespec __user *)fifth);
+					    (const struct old_timespec32 __user *)fifth);
 	default:
 		return sys_ipc(call, first, second, third, ptr, fifth);
 	}
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 8edf93b4490f..9016f4081bb9 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -24,7 +24,7 @@
 10	common	unlink			sys_unlink
 11	common	execve			sys_execve
 12	common	chdir			sys_chdir
-13	oabi	time			sys_time
+13	oabi	time			sys_time32
 14	common	mknod			sys_mknod
 15	common	chmod			sys_chmod
 16	common	lchown			sys_lchown16
@@ -36,12 +36,12 @@
 22	oabi	umount			sys_oldumount
 23	common	setuid			sys_setuid16
 24	common	getuid			sys_getuid16
-25	oabi	stime			sys_stime
+25	oabi	stime			sys_stime32
 26	common	ptrace			sys_ptrace
 27	oabi	alarm			sys_alarm
 # 28 was sys_fstat
 29	common	pause			sys_pause
-30	oabi	utime			sys_utime
+30	oabi	utime			sys_utime32
 # 31 was sys_stty
 # 32 was sys_gtty
 33	common	access			sys_access
@@ -137,7 +137,7 @@
 121	common	setdomainname		sys_setdomainname
 122	common	uname			sys_newuname
 # 123 was sys_modify_ldt
-124	common	adjtimex		sys_adjtimex
+124	common	adjtimex		sys_adjtimex_time32
 125	common	mprotect		sys_mprotect
 126	common	sigprocmask		sys_sigprocmask
 # 127 was sys_create_module
@@ -174,8 +174,8 @@
 158	common	sched_yield		sys_sched_yield
 159	common	sched_get_priority_max	sys_sched_get_priority_max
 160	common	sched_get_priority_min	sys_sched_get_priority_min
-161	common	sched_rr_get_interval	sys_sched_rr_get_interval
-162	common	nanosleep		sys_nanosleep
+161	common	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162	common	nanosleep		sys_nanosleep_time32
 163	common	mremap			sys_mremap
 164	common	setresuid		sys_setresuid16
 165	common	getresuid		sys_getresuid16
@@ -190,7 +190,7 @@
 174	common	rt_sigaction		sys_rt_sigaction
 175	common	rt_sigprocmask		sys_rt_sigprocmask
 176	common	rt_sigpending		sys_rt_sigpending
-177	common	rt_sigtimedwait		sys_rt_sigtimedwait
+177	common	rt_sigtimedwait		sys_rt_sigtimedwait_time32
 178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo
 179	common	rt_sigsuspend		sys_rt_sigsuspend
 180	common	pread64			sys_pread64		sys_oabi_pread64
@@ -254,12 +254,12 @@
 237	common	fremovexattr		sys_fremovexattr
 238	common	tkill			sys_tkill
 239	common	sendfile64		sys_sendfile64
-240	common	futex			sys_futex
+240	common	futex			sys_futex_time32
 241	common	sched_setaffinity	sys_sched_setaffinity
 242	common	sched_getaffinity	sys_sched_getaffinity
 243	common	io_setup		sys_io_setup
 244	common	io_destroy		sys_io_destroy
-245	common	io_getevents		sys_io_getevents
+245	common	io_getevents		sys_io_getevents_time32
 246	common	io_submit		sys_io_submit
 247	common	io_cancel		sys_io_cancel
 248	common	exit_group		sys_exit_group
@@ -272,26 +272,26 @@
 # 255 for get_thread_area
 256	common	set_tid_address		sys_set_tid_address
 257	common	timer_create		sys_timer_create
-258	common	timer_settime		sys_timer_settime
-259	common	timer_gettime		sys_timer_gettime
+258	common	timer_settime		sys_timer_settime32
+259	common	timer_gettime		sys_timer_gettime32
 260	common	timer_getoverrun	sys_timer_getoverrun
 261	common	timer_delete		sys_timer_delete
-262	common	clock_settime		sys_clock_settime
-263	common	clock_gettime		sys_clock_gettime
-264	common	clock_getres		sys_clock_getres
-265	common	clock_nanosleep		sys_clock_nanosleep
+262	common	clock_settime		sys_clock_settime32
+263	common	clock_gettime		sys_clock_gettime32
+264	common	clock_getres		sys_clock_getres_time32
+265	common	clock_nanosleep		sys_clock_nanosleep_time32
 266	common	statfs64		sys_statfs64_wrapper
 267	common	fstatfs64		sys_fstatfs64_wrapper
 268	common	tgkill			sys_tgkill
-269	common	utimes			sys_utimes
+269	common	utimes			sys_utimes_time32
 270	common	arm_fadvise64_64	sys_arm_fadvise64_64
 271	common	pciconfig_iobase	sys_pciconfig_iobase
 272	common	pciconfig_read		sys_pciconfig_read
 273	common	pciconfig_write		sys_pciconfig_write
 274	common	mq_open			sys_mq_open
 275	common	mq_unlink		sys_mq_unlink
-276	common	mq_timedsend		sys_mq_timedsend
-277	common	mq_timedreceive		sys_mq_timedreceive
+276	common	mq_timedsend		sys_mq_timedsend_time32
+277	common	mq_timedreceive		sys_mq_timedreceive_time32
 278	common	mq_notify		sys_mq_notify
 279	common	mq_getsetattr		sys_mq_getsetattr
 280	common	waitid			sys_waitid
@@ -314,19 +314,19 @@
 297	common	recvmsg			sys_recvmsg
 298	common	semop			sys_semop		sys_oabi_semop
 299	common	semget			sys_semget
-300	common	semctl			sys_semctl
+300	common	semctl			sys_old_semctl
 301	common	msgsnd			sys_msgsnd
 302	common	msgrcv			sys_msgrcv
 303	common	msgget			sys_msgget
-304	common	msgctl			sys_msgctl
+304	common	msgctl			sys_old_msgctl
 305	common	shmat			sys_shmat
 306	common	shmdt			sys_shmdt
 307	common	shmget			sys_shmget
-308	common	shmctl			sys_shmctl
+308	common	shmctl			sys_old_shmctl
 309	common	add_key			sys_add_key
 310	common	request_key		sys_request_key
 311	common	keyctl			sys_keyctl
-312	common	semtimedop		sys_semtimedop		sys_oabi_semtimedop
+312	common	semtimedop		sys_semtimedop_time32	sys_oabi_semtimedop
 313	common	vserver
 314	common	ioprio_set		sys_ioprio_set
 315	common	ioprio_get		sys_ioprio_get
@@ -340,7 +340,7 @@
 323	common	mkdirat			sys_mkdirat
 324	common	mknodat			sys_mknodat
 325	common	fchownat		sys_fchownat
-326	common	futimesat		sys_futimesat
+326	common	futimesat		sys_futimesat_time32
 327	common	fstatat64		sys_fstatat64		sys_oabi_fstatat64
 328	common	unlinkat		sys_unlinkat
 329	common	renameat		sys_renameat
@@ -349,8 +349,8 @@
 332	common	readlinkat		sys_readlinkat
 333	common	fchmodat		sys_fchmodat
 334	common	faccessat		sys_faccessat
-335	common	pselect6		sys_pselect6
-336	common	ppoll			sys_ppoll
+335	common	pselect6		sys_pselect6_time32
+336	common	ppoll			sys_ppoll_time32
 337	common	unshare			sys_unshare
 338	common	set_robust_list		sys_set_robust_list
 339	common	get_robust_list		sys_get_robust_list
@@ -362,13 +362,13 @@
 345	common	getcpu			sys_getcpu
 346	common	epoll_pwait		sys_epoll_pwait
 347	common	kexec_load		sys_kexec_load
-348	common	utimensat		sys_utimensat
+348	common	utimensat		sys_utimensat_time32
 349	common	signalfd		sys_signalfd
 350	common	timerfd_create		sys_timerfd_create
 351	common	eventfd			sys_eventfd
 352	common	fallocate		sys_fallocate
-353	common	timerfd_settime		sys_timerfd_settime
-354	common	timerfd_gettime		sys_timerfd_gettime
+353	common	timerfd_settime		sys_timerfd_settime32
+354	common	timerfd_gettime		sys_timerfd_gettime32
 355	common	signalfd4		sys_signalfd4
 356	common	eventfd2		sys_eventfd2
 357	common	epoll_create1		sys_epoll_create1
@@ -379,14 +379,14 @@
 362	common	pwritev			sys_pwritev
 363	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
 364	common	perf_event_open		sys_perf_event_open
-365	common	recvmmsg		sys_recvmmsg
+365	common	recvmmsg		sys_recvmmsg_time32
 366	common	accept4			sys_accept4
 367	common	fanotify_init		sys_fanotify_init
 368	common	fanotify_mark		sys_fanotify_mark
 369	common	prlimit64		sys_prlimit64
 370	common	name_to_handle_at	sys_name_to_handle_at
 371	common	open_by_handle_at	sys_open_by_handle_at
-372	common	clock_adjtime		sys_clock_adjtime
+372	common	clock_adjtime		sys_clock_adjtime32
 373	common	syncfs			sys_syncfs
 374	common	sendmmsg		sys_sendmmsg
 375	common	setns			sys_setns
@@ -413,4 +413,27 @@
 396	common	pkey_free		sys_pkey_free
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
-399	common	io_pgetevents		sys_io_pgetevents
+399	common	io_pgetevents		sys_io_pgetevents_time32
+400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
+# 402 is unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a7b1fc58ffdf..d1dd93436e1e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		400
+#define __NR_compat_syscalls		424
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 04ee190b90fe..5590f2623690 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -270,7 +270,7 @@ __SYSCALL(__NR_uname, sys_newuname)
 			/* 123 was sys_modify_ldt */
 __SYSCALL(123, sys_ni_syscall)
 #define __NR_adjtimex 124
-__SYSCALL(__NR_adjtimex, compat_sys_adjtimex)
+__SYSCALL(__NR_adjtimex, sys_adjtimex_time32)
 #define __NR_mprotect 125
 __SYSCALL(__NR_mprotect, sys_mprotect)
 #define __NR_sigprocmask 126
@@ -344,9 +344,9 @@ __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 160
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
 #define __NR_sched_rr_get_interval 161
-__SYSCALL(__NR_sched_rr_get_interval, compat_sys_sched_rr_get_interval)
+__SYSCALL(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32)
 #define __NR_nanosleep 162
-__SYSCALL(__NR_nanosleep, compat_sys_nanosleep)
+__SYSCALL(__NR_nanosleep, sys_nanosleep_time32)
 #define __NR_mremap 163
 __SYSCALL(__NR_mremap, sys_mremap)
 #define __NR_setresuid 164
@@ -376,7 +376,7 @@ __SYSCALL(__NR_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 176
 __SYSCALL(__NR_rt_sigpending, compat_sys_rt_sigpending)
 #define __NR_rt_sigtimedwait 177
-__SYSCALL(__NR_rt_sigtimedwait, compat_sys_rt_sigtimedwait)
+__SYSCALL(__NR_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
 #define __NR_rt_sigqueueinfo 178
 __SYSCALL(__NR_rt_sigqueueinfo, compat_sys_rt_sigqueueinfo)
 #define __NR_rt_sigsuspend 179
@@ -502,7 +502,7 @@ __SYSCALL(__NR_tkill, sys_tkill)
 #define __NR_sendfile64 239
 __SYSCALL(__NR_sendfile64, sys_sendfile64)
 #define __NR_futex 240
-__SYSCALL(__NR_futex, compat_sys_futex)
+__SYSCALL(__NR_futex, sys_futex_time32)
 #define __NR_sched_setaffinity 241
 __SYSCALL(__NR_sched_setaffinity, compat_sys_sched_setaffinity)
 #define __NR_sched_getaffinity 242
@@ -512,7 +512,7 @@ __SYSCALL(__NR_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 244
 __SYSCALL(__NR_io_destroy, sys_io_destroy)
 #define __NR_io_getevents 245
-__SYSCALL(__NR_io_getevents, compat_sys_io_getevents)
+__SYSCALL(__NR_io_getevents, sys_io_getevents_time32)
 #define __NR_io_submit 246
 __SYSCALL(__NR_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 247
@@ -538,21 +538,21 @@ __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 #define __NR_timer_create 257
 __SYSCALL(__NR_timer_create, compat_sys_timer_create)
 #define __NR_timer_settime 258
-__SYSCALL(__NR_timer_settime, compat_sys_timer_settime)
+__SYSCALL(__NR_timer_settime, sys_timer_settime32)
 #define __NR_timer_gettime 259
-__SYSCALL(__NR_timer_gettime, compat_sys_timer_gettime)
+__SYSCALL(__NR_timer_gettime, sys_timer_gettime32)
 #define __NR_timer_getoverrun 260
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
 #define __NR_timer_delete 261
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
 #define __NR_clock_settime 262
-__SYSCALL(__NR_clock_settime, compat_sys_clock_settime)
+__SYSCALL(__NR_clock_settime, sys_clock_settime32)
 #define __NR_clock_gettime 263
-__SYSCALL(__NR_clock_gettime, compat_sys_clock_gettime)
+__SYSCALL(__NR_clock_gettime, sys_clock_gettime32)
 #define __NR_clock_getres 264
-__SYSCALL(__NR_clock_getres, compat_sys_clock_getres)
+__SYSCALL(__NR_clock_getres, sys_clock_getres_time32)
 #define __NR_clock_nanosleep 265
-__SYSCALL(__NR_clock_nanosleep, compat_sys_clock_nanosleep)
+__SYSCALL(__NR_clock_nanosleep, sys_clock_nanosleep_time32)
 #define __NR_statfs64 266
 __SYSCALL(__NR_statfs64, compat_sys_aarch32_statfs64)
 #define __NR_fstatfs64 267
@@ -560,7 +560,7 @@ __SYSCALL(__NR_fstatfs64, compat_sys_aarch32_fstatfs64)
 #define __NR_tgkill 268
 __SYSCALL(__NR_tgkill, sys_tgkill)
 #define __NR_utimes 269
-__SYSCALL(__NR_utimes, compat_sys_utimes)
+__SYSCALL(__NR_utimes, sys_utimes_time32)
 #define __NR_arm_fadvise64_64 270
 __SYSCALL(__NR_arm_fadvise64_64, compat_sys_aarch32_fadvise64_64)
 #define __NR_pciconfig_iobase 271
@@ -574,9 +574,9 @@ __SYSCALL(__NR_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 275
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
 #define __NR_mq_timedsend 276
-__SYSCALL(__NR_mq_timedsend, compat_sys_mq_timedsend)
+__SYSCALL(__NR_mq_timedsend, sys_mq_timedsend_time32)
 #define __NR_mq_timedreceive 277
-__SYSCALL(__NR_mq_timedreceive, compat_sys_mq_timedreceive)
+__SYSCALL(__NR_mq_timedreceive, sys_mq_timedreceive_time32)
 #define __NR_mq_notify 278
 __SYSCALL(__NR_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 279
@@ -622,7 +622,7 @@ __SYSCALL(__NR_semop, sys_semop)
 #define __NR_semget 299
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 300
-__SYSCALL(__NR_semctl, compat_sys_semctl)
+__SYSCALL(__NR_semctl, compat_sys_old_semctl)
 #define __NR_msgsnd 301
 __SYSCALL(__NR_msgsnd, compat_sys_msgsnd)
 #define __NR_msgrcv 302
@@ -630,7 +630,7 @@ __SYSCALL(__NR_msgrcv, compat_sys_msgrcv)
 #define __NR_msgget 303
 __SYSCALL(__NR_msgget, sys_msgget)
 #define __NR_msgctl 304
-__SYSCALL(__NR_msgctl, compat_sys_msgctl)
+__SYSCALL(__NR_msgctl, compat_sys_old_msgctl)
 #define __NR_shmat 305
 __SYSCALL(__NR_shmat, compat_sys_shmat)
 #define __NR_shmdt 306
@@ -638,7 +638,7 @@ __SYSCALL(__NR_shmdt, sys_shmdt)
 #define __NR_shmget 307
 __SYSCALL(__NR_shmget, sys_shmget)
 #define __NR_shmctl 308
-__SYSCALL(__NR_shmctl, compat_sys_shmctl)
+__SYSCALL(__NR_shmctl, compat_sys_old_shmctl)
 #define __NR_add_key 309
 __SYSCALL(__NR_add_key, sys_add_key)
 #define __NR_request_key 310
@@ -646,7 +646,7 @@ __SYSCALL(__NR_request_key, sys_request_key)
 #define __NR_keyctl 311
 __SYSCALL(__NR_keyctl, compat_sys_keyctl)
 #define __NR_semtimedop 312
-__SYSCALL(__NR_semtimedop, compat_sys_semtimedop)
+__SYSCALL(__NR_semtimedop, sys_semtimedop_time32)
 #define __NR_vserver 313
 __SYSCALL(__NR_vserver, sys_ni_syscall)
 #define __NR_ioprio_set 314
@@ -674,7 +674,7 @@ __SYSCALL(__NR_mknodat, sys_mknodat)
 #define __NR_fchownat 325
 __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_futimesat 326
-__SYSCALL(__NR_futimesat, compat_sys_futimesat)
+__SYSCALL(__NR_futimesat, sys_futimesat_time32)
 #define __NR_fstatat64 327
 __SYSCALL(__NR_fstatat64, sys_fstatat64)
 #define __NR_unlinkat 328
@@ -692,9 +692,9 @@ __SYSCALL(__NR_fchmodat, sys_fchmodat)
 #define __NR_faccessat 334
 __SYSCALL(__NR_faccessat, sys_faccessat)
 #define __NR_pselect6 335
-__SYSCALL(__NR_pselect6, compat_sys_pselect6)
+__SYSCALL(__NR_pselect6, compat_sys_pselect6_time32)
 #define __NR_ppoll 336
-__SYSCALL(__NR_ppoll, compat_sys_ppoll)
+__SYSCALL(__NR_ppoll, compat_sys_ppoll_time32)
 #define __NR_unshare 337
 __SYSCALL(__NR_unshare, sys_unshare)
 #define __NR_set_robust_list 338
@@ -718,7 +718,7 @@ __SYSCALL(__NR_epoll_pwait, compat_sys_epoll_pwait)
 #define __NR_kexec_load 347
 __SYSCALL(__NR_kexec_load, compat_sys_kexec_load)
 #define __NR_utimensat 348
-__SYSCALL(__NR_utimensat, compat_sys_utimensat)
+__SYSCALL(__NR_utimensat, sys_utimensat_time32)
 #define __NR_signalfd 349
 __SYSCALL(__NR_signalfd, compat_sys_signalfd)
 #define __NR_timerfd_create 350
@@ -728,9 +728,9 @@ __SYSCALL(__NR_eventfd, sys_eventfd)
 #define __NR_fallocate 352
 __SYSCALL(__NR_fallocate, compat_sys_aarch32_fallocate)
 #define __NR_timerfd_settime 353
-__SYSCALL(__NR_timerfd_settime, compat_sys_timerfd_settime)
+__SYSCALL(__NR_timerfd_settime, sys_timerfd_settime32)
 #define __NR_timerfd_gettime 354
-__SYSCALL(__NR_timerfd_gettime, compat_sys_timerfd_gettime)
+__SYSCALL(__NR_timerfd_gettime, sys_timerfd_gettime32)
 #define __NR_signalfd4 355
 __SYSCALL(__NR_signalfd4, compat_sys_signalfd4)
 #define __NR_eventfd2 356
@@ -752,7 +752,7 @@ __SYSCALL(__NR_rt_tgsigqueueinfo, compat_sys_rt_tgsigqueueinfo)
 #define __NR_perf_event_open 364
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_recvmmsg 365
-__SYSCALL(__NR_recvmmsg, compat_sys_recvmmsg)
+__SYSCALL(__NR_recvmmsg, compat_sys_recvmmsg_time32)
 #define __NR_accept4 366
 __SYSCALL(__NR_accept4, sys_accept4)
 #define __NR_fanotify_init 367
@@ -766,7 +766,7 @@ __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at 371
 __SYSCALL(__NR_open_by_handle_at, compat_sys_open_by_handle_at)
 #define __NR_clock_adjtime 372
-__SYSCALL(__NR_clock_adjtime, compat_sys_clock_adjtime)
+__SYSCALL(__NR_clock_adjtime, sys_clock_adjtime32)
 #define __NR_syncfs 373
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_sendmmsg 374
@@ -821,6 +821,51 @@ __SYSCALL(__NR_statx, sys_statx)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_migrate_pages 400
+__SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
+#define __NR_kexec_file_load 401
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
+/* 402 is unused */
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SYSCALL(__NR_pselect6_time64, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SYSCALL(__NR_ppoll_time64, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SYSCALL(__NR_recvmmsg_time64, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceive_time64 419
+__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SYSCALL(__NR_rt_sigtimedwait_time64, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index dae1584cf017..4703d218663a 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -17,5 +17,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 456e154674d1..e5cd3c5f8399 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -6,6 +6,7 @@
 
 config C6X
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 6b2fe792de9d..79b724c39d9b 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -17,7 +17,9 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c845f5..6959e0b1e956 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -1,5 +1,6 @@
 config CSKY
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index 224c9a9ab45b..ec60e49cea66 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -2,6 +2,8 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 6472a0685470..c071da34e081 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config H8300
         def_bool y
+	select ARCH_32BIT_OFF_T
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
 	select VIRT_TO_BUS
diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
index 628195823816..eb7bc0012af5 100644
--- a/arch/h8300/include/uapi/asm/unistd.h
+++ b/arch/h8300/include/uapi/asm/unistd.h
@@ -2,5 +2,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index fb2fbfcfc532..ac441680dcc0 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -4,6 +4,7 @@ comment "Linux Kernel Configuration for Hexagon"
 
 config HEXAGON
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	select HAVE_OPROFILE
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index c91ca7d02461..432c4db1b623 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -30,9 +30,11 @@
 #define sys_mmap2 sys_mmap_pgoff
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 0b08ebd2dfde..9ba6110b10b9 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -12,20 +12,6 @@
 
 #define NR_syscalls		__NR_syscalls /* length of syscall table */
 
-/*
- * The following defines stop scripts/checksyscalls.sh from complaining about
- * unimplemented system calls.  Glibc provides for each of these by using
- * more modern equivalent system calls.
- */
-#define __IGNORE_fork		/* clone() */
-#define __IGNORE_time		/* gettimeofday() */
-#define __IGNORE_alarm		/* setitimer(ITIMER_REAL, ... */
-#define __IGNORE_pause		/* rt_sigprocmask(), rt_sigsuspend() */
-#define __IGNORE_utime		/* utimes() */
-#define __IGNORE_getpgrp	/* getpgid() */
-#define __IGNORE_vfork		/* clone() */
-#define __IGNORE_umount2	/* umount() */
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_UTIME
 
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index b2513922dcb5..013e0bcacc39 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
 
 #define __NR_Linux      1024
 
+#define __NR_umount __NR_umount2
+
 #include <asm/unistd_64.h>
 
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b22203b40bfe..ab9cda5f6136 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 17	common	getpid				sys_getpid
 18	common	getppid				sys_getppid
 19	common	mount				sys_mount
-20	common	umount				sys_umount
+20	common	umount2				sys_umount
 21	common	setuid				sys_setuid
 22	common	getuid				sys_getuid
 23	common	geteuid				sys_geteuid
@@ -335,3 +335,12 @@
 323	common	copy_file_range			sys_copy_file_range
 324	common	preadv2				sys_preadv2
 325	common	pwritev2			sys_pwritev2
+326	common	statx				sys_statx
+327	common	io_pgetevents			sys_io_pgetevents
+328	common	perf_event_open			sys_perf_event_open
+329	common	seccomp				sys_seccomp
+330	common	pkey_mprotect			sys_pkey_mprotect
+331	common	pkey_alloc			sys_pkey_alloc
+332	common	pkey_free			sys_pkey_free
+333	common	rseq				sys_rseq
+# 334 through 423 are reserved to sync up with other architectures
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index e173ea2ff395..b54206408f91 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,6 +2,7 @@
 config M68K
 	bool
 	default y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 49d5de18646b..2e0047cf86f8 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -15,8 +15,8 @@
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_TIME32
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 1a95c4a1bc0d..125c14178979 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -20,7 +20,7 @@
 10	common	unlink				sys_unlink
 11	common	execve				sys_execve
 12	common	chdir				sys_chdir
-13	common	time				sys_time
+13	common	time				sys_time32
 14	common	mknod				sys_mknod
 15	common	chmod				sys_chmod
 16	common	chown				sys_chown16
@@ -32,12 +32,12 @@
 22	common	umount				sys_oldumount
 23	common	setuid				sys_setuid16
 24	common	getuid				sys_getuid16
-25	common	stime				sys_stime
+25	common	stime				sys_stime32
 26	common	ptrace				sys_ptrace
 27	common	alarm				sys_alarm
 28	common	oldfstat			sys_fstat
 29	common	pause				sys_pause
-30	common	utime				sys_utime
+30	common	utime				sys_utime32
 # 31 was stty
 # 32 was gtty
 33	common	access				sys_access
@@ -131,7 +131,7 @@
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
 123	common	cacheflush			sys_cacheflush
-124	common	adjtimex			sys_adjtimex
+124	common	adjtimex			sys_adjtimex_time32
 125	common	mprotect			sys_mprotect
 126	common	sigprocmask			sys_sigprocmask
 127	common	create_module			sys_ni_syscall
@@ -168,8 +168,8 @@
 158	common	sched_yield			sys_sched_yield
 159	common	sched_get_priority_max		sys_sched_get_priority_max
 160	common	sched_get_priority_min		sys_sched_get_priority_min
-161	common	sched_rr_get_interval		sys_sched_rr_get_interval
-162	common	nanosleep			sys_nanosleep
+161	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+162	common	nanosleep			sys_nanosleep_time32
 163	common	mremap				sys_mremap
 164	common	setresuid			sys_setresuid16
 165	common	getresuid			sys_getresuid16
@@ -184,7 +184,7 @@
 174	common	rt_sigaction			sys_rt_sigaction
 175	common	rt_sigprocmask			sys_rt_sigprocmask
 176	common	rt_sigpending			sys_rt_sigpending
-177	common	rt_sigtimedwait			sys_rt_sigtimedwait
+177	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
 178	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
 179	common	rt_sigsuspend			sys_rt_sigsuspend
 180	common	pread64				sys_pread64
@@ -242,7 +242,7 @@
 232	common	removexattr			sys_removexattr
 233	common	lremovexattr			sys_lremovexattr
 234	common	fremovexattr			sys_fremovexattr
-235	common	futex				sys_futex
+235	common	futex				sys_futex_time32
 236	common	sendfile64			sys_sendfile64
 237	common	mincore				sys_mincore
 238	common	madvise				sys_madvise
@@ -250,7 +250,7 @@
 240	common	readahead			sys_readahead
 241	common	io_setup			sys_io_setup
 242	common	io_destroy			sys_io_destroy
-243	common	io_getevents			sys_io_getevents
+243	common	io_getevents			sys_io_getevents_time32
 244	common	io_submit			sys_io_submit
 245	common	io_cancel			sys_io_cancel
 246	common	fadvise64			sys_fadvise64
@@ -262,26 +262,26 @@
 252	common	remap_file_pages		sys_remap_file_pages
 253	common	set_tid_address			sys_set_tid_address
 254	common	timer_create			sys_timer_create
-255	common	timer_settime			sys_timer_settime
-256	common	timer_gettime			sys_timer_gettime
+255	common	timer_settime			sys_timer_settime32
+256	common	timer_gettime			sys_timer_gettime32
 257	common	timer_getoverrun		sys_timer_getoverrun
 258	common	timer_delete			sys_timer_delete
-259	common	clock_settime			sys_clock_settime
-260	common	clock_gettime			sys_clock_gettime
-261	common	clock_getres			sys_clock_getres
-262	common	clock_nanosleep			sys_clock_nanosleep
+259	common	clock_settime			sys_clock_settime32
+260	common	clock_gettime			sys_clock_gettime32
+261	common	clock_getres			sys_clock_getres_time32
+262	common	clock_nanosleep			sys_clock_nanosleep_time32
 263	common	statfs64			sys_statfs64
 264	common	fstatfs64			sys_fstatfs64
 265	common	tgkill				sys_tgkill
-266	common	utimes				sys_utimes
+266	common	utimes				sys_utimes_time32
 267	common	fadvise64_64			sys_fadvise64_64
 268	common	mbind				sys_mbind
 269	common	get_mempolicy			sys_get_mempolicy
 270	common	set_mempolicy			sys_set_mempolicy
 271	common	mq_open				sys_mq_open
 272	common	mq_unlink			sys_mq_unlink
-273	common	mq_timedsend			sys_mq_timedsend
-274	common	mq_timedreceive			sys_mq_timedreceive
+273	common	mq_timedsend			sys_mq_timedsend_time32
+274	common	mq_timedreceive			sys_mq_timedreceive_time32
 275	common	mq_notify			sys_mq_notify
 276	common	mq_getsetattr			sys_mq_getsetattr
 277	common	waitid				sys_waitid
@@ -299,7 +299,7 @@
 289	common	mkdirat				sys_mkdirat
 290	common	mknodat				sys_mknodat
 291	common	fchownat			sys_fchownat
-292	common	futimesat			sys_futimesat
+292	common	futimesat			sys_futimesat_time32
 293	common	fstatat64			sys_fstatat64
 294	common	unlinkat			sys_unlinkat
 295	common	renameat			sys_renameat
@@ -308,8 +308,8 @@
 298	common	readlinkat			sys_readlinkat
 299	common	fchmodat			sys_fchmodat
 300	common	faccessat			sys_faccessat
-301	common	pselect6			sys_pselect6
-302	common	ppoll				sys_ppoll
+301	common	pselect6			sys_pselect6_time32
+302	common	ppoll				sys_ppoll_time32
 303	common	unshare				sys_unshare
 304	common	set_robust_list			sys_set_robust_list
 305	common	get_robust_list			sys_get_robust_list
@@ -323,13 +323,13 @@
 313	common	kexec_load			sys_kexec_load
 314	common	getcpu				sys_getcpu
 315	common	epoll_pwait			sys_epoll_pwait
-316	common	utimensat			sys_utimensat
+316	common	utimensat			sys_utimensat_time32
 317	common	signalfd			sys_signalfd
 318	common	timerfd_create			sys_timerfd_create
 319	common	eventfd				sys_eventfd
 320	common	fallocate			sys_fallocate
-321	common	timerfd_settime			sys_timerfd_settime
-322	common	timerfd_gettime			sys_timerfd_gettime
+321	common	timerfd_settime			sys_timerfd_settime32
+322	common	timerfd_gettime			sys_timerfd_gettime32
 323	common	signalfd4			sys_signalfd4
 324	common	eventfd2			sys_eventfd2
 325	common	epoll_create1			sys_epoll_create1
@@ -349,7 +349,7 @@
 339	common	prlimit64			sys_prlimit64
 340	common	name_to_handle_at		sys_name_to_handle_at
 341	common	open_by_handle_at		sys_open_by_handle_at
-342	common	clock_adjtime			sys_clock_adjtime
+342	common	clock_adjtime			sys_clock_adjtime32
 343	common	syncfs				sys_syncfs
 344	common	setns				sys_setns
 345	common	process_vm_readv		sys_process_vm_readv
@@ -378,7 +378,7 @@
 368	common	recvfrom			sys_recvfrom
 369	common	recvmsg				sys_recvmsg
 370	common	shutdown			sys_shutdown
-371	common	recvmmsg			sys_recvmmsg
+371	common	recvmmsg			sys_recvmmsg_time32
 372	common	sendmmsg			sys_sendmmsg
 373	common	userfaultfd			sys_userfaultfd
 374	common	membarrier			sys_membarrier
@@ -387,3 +387,39 @@
 377	common	preadv2				sys_preadv2
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
+380	common	seccomp				sys_seccomp
+381	common	pkey_mprotect			sys_pkey_mprotect
+382	common	pkey_alloc			sys_pkey_alloc
+383	common	pkey_free			sys_pkey_free
+384	common	rseq				sys_rseq
+# room for arch specific calls
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl
+397	common	shmat				sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd
+401	common	msgrcv				sys_msgrcv
+402	common	msgctl				sys_msgctl
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 58aff2653d86..a51b965b3b82 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_NO_SWAP
 	select ARCH_HAS_DMA_COHERENT_TO_PFN if MMU
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index 9b7c2c4eaf12..d79d35ac6253 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -21,8 +21,8 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_TIME32
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a24d09e937dd..8ee3a8c18498 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -20,7 +20,7 @@
 10	common	unlink				sys_unlink
 11	common	execve				sys_execve
 12	common	chdir				sys_chdir
-13	common	time				sys_time
+13	common	time				sys_time32
 14	common	mknod				sys_mknod
 15	common	chmod				sys_chmod
 16	common	lchown				sys_lchown
@@ -32,12 +32,12 @@
 22	common	umount				sys_oldumount
 23	common	setuid				sys_setuid
 24	common	getuid				sys_getuid
-25	common	stime				sys_stime
+25	common	stime				sys_stime32
 26	common	ptrace				sys_ptrace
 27	common	alarm				sys_alarm
 28	common	oldfstat			sys_ni_syscall
 29	common	pause				sys_pause
-30	common	utime				sys_utime
+30	common	utime				sys_utime32
 31	common	stty				sys_ni_syscall
 32	common	gtty				sys_ni_syscall
 33	common	access				sys_access
@@ -131,7 +131,7 @@
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
 123	common	modify_ldt			sys_ni_syscall
-124	common	adjtimex			sys_adjtimex
+124	common	adjtimex			sys_adjtimex_time32
 125	common	mprotect			sys_mprotect
 126	common	sigprocmask			sys_sigprocmask
 127	common	create_module			sys_ni_syscall
@@ -168,8 +168,8 @@
 158	common	sched_yield			sys_sched_yield
 159	common	sched_get_priority_max		sys_sched_get_priority_max
 160	common	sched_get_priority_min		sys_sched_get_priority_min
-161	common	sched_rr_get_interval		sys_sched_rr_get_interval
-162	common	nanosleep			sys_nanosleep
+161	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+162	common	nanosleep			sys_nanosleep_time32
 163	common	mremap				sys_mremap
 164	common	setresuid			sys_setresuid
 165	common	getresuid			sys_getresuid
@@ -184,7 +184,7 @@
 174	common	rt_sigaction			sys_rt_sigaction
 175	common	rt_sigprocmask			sys_rt_sigprocmask
 176	common	rt_sigpending			sys_rt_sigpending
-177	common	rt_sigtimedwait			sys_rt_sigtimedwait
+177	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
 178	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
 179	common	rt_sigsuspend			sys_rt_sigsuspend
 180	common	pread64				sys_pread64
@@ -247,14 +247,14 @@
 237	common	fremovexattr			sys_fremovexattr
 238	common	tkill				sys_tkill
 239	common	sendfile64			sys_sendfile64
-240	common	futex				sys_futex
+240	common	futex				sys_futex_time32
 241	common	sched_setaffinity		sys_sched_setaffinity
 242	common	sched_getaffinity		sys_sched_getaffinity
 243	common	set_thread_area			sys_ni_syscall
 244	common	get_thread_area			sys_ni_syscall
 245	common	io_setup			sys_io_setup
 246	common	io_destroy			sys_io_destroy
-247	common	io_getevents			sys_io_getevents
+247	common	io_getevents			sys_io_getevents_time32
 248	common	io_submit			sys_io_submit
 249	common	io_cancel			sys_io_cancel
 250	common	fadvise64			sys_fadvise64
@@ -267,18 +267,18 @@
 257	common	remap_file_pages		sys_remap_file_pages
 258	common	set_tid_address			sys_set_tid_address
 259	common	timer_create			sys_timer_create
-260	common	timer_settime			sys_timer_settime
-261	common	timer_gettime			sys_timer_gettime
+260	common	timer_settime			sys_timer_settime32
+261	common	timer_gettime			sys_timer_gettime32
 262	common	timer_getoverrun		sys_timer_getoverrun
 263	common	timer_delete			sys_timer_delete
-264	common	clock_settime			sys_clock_settime
-265	common	clock_gettime			sys_clock_gettime
-266	common	clock_getres			sys_clock_getres
-267	common	clock_nanosleep			sys_clock_nanosleep
+264	common	clock_settime			sys_clock_settime32
+265	common	clock_gettime			sys_clock_gettime32
+266	common	clock_getres			sys_clock_getres_time32
+267	common	clock_nanosleep			sys_clock_nanosleep_time32
 268	common	statfs64			sys_statfs64
 269	common	fstatfs64			sys_fstatfs64
 270	common	tgkill				sys_tgkill
-271	common	utimes				sys_utimes
+271	common	utimes				sys_utimes_time32
 272	common	fadvise64_64			sys_fadvise64_64
 273	common	vserver				sys_ni_syscall
 274	common	mbind				sys_mbind
@@ -286,8 +286,8 @@
 276	common	set_mempolicy			sys_set_mempolicy
 277	common	mq_open				sys_mq_open
 278	common	mq_unlink			sys_mq_unlink
-279	common	mq_timedsend			sys_mq_timedsend
-280	common	mq_timedreceive			sys_mq_timedreceive
+279	common	mq_timedsend			sys_mq_timedsend_time32
+280	common	mq_timedreceive			sys_mq_timedreceive_time32
 281	common	mq_notify			sys_mq_notify
 282	common	mq_getsetattr			sys_mq_getsetattr
 283	common	kexec_load			sys_kexec_load
@@ -306,7 +306,7 @@
 296	common	mkdirat				sys_mkdirat
 297	common	mknodat				sys_mknodat
 298	common	fchownat			sys_fchownat
-299	common	futimesat			sys_futimesat
+299	common	futimesat			sys_futimesat_time32
 300	common	fstatat64			sys_fstatat64
 301	common	unlinkat			sys_unlinkat
 302	common	renameat			sys_renameat
@@ -315,8 +315,8 @@
 305	common	readlinkat			sys_readlinkat
 306	common	fchmodat			sys_fchmodat
 307	common	faccessat			sys_faccessat
-308	common	pselect6			sys_pselect6
-309	common	ppoll				sys_ppoll
+308	common	pselect6			sys_pselect6_time32
+309	common	ppoll				sys_ppoll_time32
 310	common	unshare				sys_unshare
 311	common	set_robust_list			sys_set_robust_list
 312	common	get_robust_list			sys_get_robust_list
@@ -327,23 +327,23 @@
 317	common	move_pages			sys_move_pages
 318	common	getcpu				sys_getcpu
 319	common	epoll_pwait			sys_epoll_pwait
-320	common	utimensat			sys_utimensat
+320	common	utimensat			sys_utimensat_time32
 321	common	signalfd			sys_signalfd
 322	common	timerfd_create			sys_timerfd_create
 323	common	eventfd				sys_eventfd
 324	common	fallocate			sys_fallocate
-325	common	semtimedop			sys_semtimedop
-326	common	timerfd_settime			sys_timerfd_settime
-327	common	timerfd_gettime			sys_timerfd_gettime
-328	common	semctl				sys_semctl
+325	common	semtimedop			sys_semtimedop_time32
+326	common	timerfd_settime			sys_timerfd_settime32
+327	common	timerfd_gettime			sys_timerfd_gettime32
+328	common	semctl				sys_old_semctl
 329	common	semget				sys_semget
 330	common	semop				sys_semop
-331	common	msgctl				sys_msgctl
+331	common	msgctl				sys_old_msgctl
 332	common	msgget				sys_msgget
 333	common	msgrcv				sys_msgrcv
 334	common	msgsnd				sys_msgsnd
 335	common	shmat				sys_shmat
-336	common	shmctl				sys_shmctl
+336	common	shmctl				sys_old_shmctl
 337	common	shmdt				sys_shmdt
 338	common	shmget				sys_shmget
 339	common	signalfd4			sys_signalfd4
@@ -374,13 +374,13 @@
 364	common	pwritev				sys_pwritev
 365	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
 366	common	perf_event_open			sys_perf_event_open
-367	common	recvmmsg			sys_recvmmsg
+367	common	recvmmsg			sys_recvmmsg_time32
 368	common	fanotify_init			sys_fanotify_init
 369	common	fanotify_mark			sys_fanotify_mark
 370	common	prlimit64			sys_prlimit64
 371	common	name_to_handle_at		sys_name_to_handle_at
 372	common	open_by_handle_at		sys_open_by_handle_at
-373	common	clock_adjtime			sys_clock_adjtime
+373	common	clock_adjtime			sys_clock_adjtime32
 374	common	syncfs				sys_syncfs
 375	common	setns				sys_setns
 376	common	sendmmsg			sys_sendmmsg
@@ -406,5 +406,26 @@
 396	common	pkey_alloc			sys_pkey_alloc
 397	common	pkey_free			sys_pkey_free
 398	common	statx				sys_statx
-399	common	io_pgetevents			sys_io_pgetevents
+399	common	io_pgetevents			sys_io_pgetevents_time32
 400	common	rseq				sys_rseq
+# 401 and 402 are unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0d14f51d0002..616fc853a46d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2,6 +2,7 @@
 config MIPS
 	bool
 	default y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index b23d74a601b3..071053ece677 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -45,29 +45,16 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_32BIT
 #  define __ARCH_WANT_STAT64
-#  define __ARCH_WANT_SYS_TIME
+#  define __ARCH_WANT_SYS_TIME32
 # endif
 # ifdef CONFIG_MIPS32_O32
-#  define __ARCH_WANT_COMPAT_SYS_TIME
+#  define __ARCH_WANT_SYS_TIME32
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
 /* whitelists for checksyscalls */
-#define __IGNORE_select
-#define __IGNORE_vfork
-#define __IGNORE_time
-#define __IGNORE_uselib
 #define __IGNORE_fadvise64_64
-#define __IGNORE_getdents64
-#if _MIPS_SIM == _MIPS_SIM_NABI32
-#define __IGNORE_truncate64
-#define __IGNORE_ftruncate64
-#define __IGNORE_stat64
-#define __IGNORE_lstat64
-#define __IGNORE_fstat64
-#define __IGNORE_fstatat64
-#endif
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 53d5862649ae..15f4117900ee 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -37,11 +37,11 @@
 27	n32	madvise				sys_madvise
 28	n32	shmget				sys_shmget
 29	n32	shmat				sys_shmat
-30	n32	shmctl				compat_sys_shmctl
+30	n32	shmctl				compat_sys_old_shmctl
 31	n32	dup				sys_dup
 32	n32	dup2				sys_dup2
 33	n32	pause				sys_pause
-34	n32	nanosleep			compat_sys_nanosleep
+34	n32	nanosleep			sys_nanosleep_time32
 35	n32	getitimer			compat_sys_getitimer
 36	n32	setitimer			compat_sys_setitimer
 37	n32	alarm				sys_alarm
@@ -71,12 +71,12 @@
 61	n32	uname				sys_newuname
 62	n32	semget				sys_semget
 63	n32	semop				sys_semop
-64	n32	semctl				compat_sys_semctl
+64	n32	semctl				compat_sys_old_semctl
 65	n32	shmdt				sys_shmdt
 66	n32	msgget				sys_msgget
 67	n32	msgsnd				compat_sys_msgsnd
 68	n32	msgrcv				compat_sys_msgrcv
-69	n32	msgctl				compat_sys_msgctl
+69	n32	msgctl				compat_sys_old_msgctl
 70	n32	fcntl				compat_sys_fcntl
 71	n32	flock				sys_flock
 72	n32	fsync				sys_fsync
@@ -133,11 +133,11 @@
 123	n32	capget				sys_capget
 124	n32	capset				sys_capset
 125	n32	rt_sigpending			compat_sys_rt_sigpending
-126	n32	rt_sigtimedwait			compat_sys_rt_sigtimedwait
+126	n32	rt_sigtimedwait			compat_sys_rt_sigtimedwait_time32
 127	n32	rt_sigqueueinfo			compat_sys_rt_sigqueueinfo
 128	n32	rt_sigsuspend			compat_sys_rt_sigsuspend
 129	n32	sigaltstack			compat_sys_sigaltstack
-130	n32	utime				compat_sys_utime
+130	n32	utime				sys_utime32
 131	n32	mknod				sys_mknod
 132	n32	personality			sys_32_personality
 133	n32	ustat				compat_sys_ustat
@@ -152,7 +152,7 @@
 142	n32	sched_getscheduler		sys_sched_getscheduler
 143	n32	sched_get_priority_max		sys_sched_get_priority_max
 144	n32	sched_get_priority_min		sys_sched_get_priority_min
-145	n32	sched_rr_get_interval		compat_sys_sched_rr_get_interval
+145	n32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
 146	n32	mlock				sys_mlock
 147	n32	munlock				sys_munlock
 148	n32	mlockall			sys_mlockall
@@ -161,7 +161,7 @@
 151	n32	pivot_root			sys_pivot_root
 152	n32	_sysctl				compat_sys_sysctl
 153	n32	prctl				sys_prctl
-154	n32	adjtimex			compat_sys_adjtimex
+154	n32	adjtimex			sys_adjtimex_time32
 155	n32	setrlimit			compat_sys_setrlimit
 156	n32	chroot				sys_chroot
 157	n32	sync				sys_sync
@@ -202,7 +202,7 @@
 191	n32	fremovexattr			sys_fremovexattr
 192	n32	tkill				sys_tkill
 193	n32	reserved193			sys_ni_syscall
-194	n32	futex				compat_sys_futex
+194	n32	futex				sys_futex_time32
 195	n32	sched_setaffinity		compat_sys_sched_setaffinity
 196	n32	sched_getaffinity		compat_sys_sched_getaffinity
 197	n32	cacheflush			sys_cacheflush
@@ -210,7 +210,7 @@
 199	n32	sysmips				__sys_sysmips
 200	n32	io_setup			compat_sys_io_setup
 201	n32	io_destroy			sys_io_destroy
-202	n32	io_getevents			compat_sys_io_getevents
+202	n32	io_getevents			sys_io_getevents_time32
 203	n32	io_submit			compat_sys_io_submit
 204	n32	io_cancel			sys_io_cancel
 205	n32	exit_group			sys_exit_group
@@ -223,29 +223,29 @@
 212	n32	fcntl64				compat_sys_fcntl64
 213	n32	set_tid_address			sys_set_tid_address
 214	n32	restart_syscall			sys_restart_syscall
-215	n32	semtimedop			compat_sys_semtimedop
+215	n32	semtimedop			sys_semtimedop_time32
 216	n32	fadvise64			sys_fadvise64_64
 217	n32	statfs64			compat_sys_statfs64
 218	n32	fstatfs64			compat_sys_fstatfs64
 219	n32	sendfile64			sys_sendfile64
 220	n32	timer_create			compat_sys_timer_create
-221	n32	timer_settime			compat_sys_timer_settime
-222	n32	timer_gettime			compat_sys_timer_gettime
+221	n32	timer_settime			sys_timer_settime32
+222	n32	timer_gettime			sys_timer_gettime32
 223	n32	timer_getoverrun		sys_timer_getoverrun
 224	n32	timer_delete			sys_timer_delete
-225	n32	clock_settime			compat_sys_clock_settime
-226	n32	clock_gettime			compat_sys_clock_gettime
-227	n32	clock_getres			compat_sys_clock_getres
-228	n32	clock_nanosleep			compat_sys_clock_nanosleep
+225	n32	clock_settime			sys_clock_settime32
+226	n32	clock_gettime			sys_clock_gettime32
+227	n32	clock_getres			sys_clock_getres_time32
+228	n32	clock_nanosleep			sys_clock_nanosleep_time32
 229	n32	tgkill				sys_tgkill
-230	n32	utimes				compat_sys_utimes
+230	n32	utimes				sys_utimes_time32
 231	n32	mbind				compat_sys_mbind
 232	n32	get_mempolicy			compat_sys_get_mempolicy
 233	n32	set_mempolicy			compat_sys_set_mempolicy
 234	n32	mq_open				compat_sys_mq_open
 235	n32	mq_unlink			sys_mq_unlink
-236	n32	mq_timedsend			compat_sys_mq_timedsend
-237	n32	mq_timedreceive			compat_sys_mq_timedreceive
+236	n32	mq_timedsend			sys_mq_timedsend_time32
+237	n32	mq_timedreceive			sys_mq_timedreceive_time32
 238	n32	mq_notify			compat_sys_mq_notify
 239	n32	mq_getsetattr			compat_sys_mq_getsetattr
 240	n32	vserver				sys_ni_syscall
@@ -263,7 +263,7 @@
 252	n32	mkdirat				sys_mkdirat
 253	n32	mknodat				sys_mknodat
 254	n32	fchownat			sys_fchownat
-255	n32	futimesat			compat_sys_futimesat
+255	n32	futimesat			sys_futimesat_time32
 256	n32	newfstatat			sys_newfstatat
 257	n32	unlinkat			sys_unlinkat
 258	n32	renameat			sys_renameat
@@ -272,8 +272,8 @@
 261	n32	readlinkat			sys_readlinkat
 262	n32	fchmodat			sys_fchmodat
 263	n32	faccessat			sys_faccessat
-264	n32	pselect6			compat_sys_pselect6
-265	n32	ppoll				compat_sys_ppoll
+264	n32	pselect6			compat_sys_pselect6_time32
+265	n32	ppoll				compat_sys_ppoll_time32
 266	n32	unshare				sys_unshare
 267	n32	splice				sys_splice
 268	n32	sync_file_range			sys_sync_file_range
@@ -287,14 +287,14 @@
 276	n32	epoll_pwait			compat_sys_epoll_pwait
 277	n32	ioprio_set			sys_ioprio_set
 278	n32	ioprio_get			sys_ioprio_get
-279	n32	utimensat			compat_sys_utimensat
+279	n32	utimensat			sys_utimensat_time32
 280	n32	signalfd			compat_sys_signalfd
 281	n32	timerfd				sys_ni_syscall
 282	n32	eventfd				sys_eventfd
 283	n32	fallocate			sys_fallocate
 284	n32	timerfd_create			sys_timerfd_create
-285	n32	timerfd_gettime			compat_sys_timerfd_gettime
-286	n32	timerfd_settime			compat_sys_timerfd_settime
+285	n32	timerfd_gettime			sys_timerfd_gettime32
+286	n32	timerfd_settime			sys_timerfd_settime32
 287	n32	signalfd4			compat_sys_signalfd4
 288	n32	eventfd2			sys_eventfd2
 289	n32	epoll_create1			sys_epoll_create1
@@ -306,14 +306,14 @@
 295	n32	rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
 296	n32	perf_event_open			sys_perf_event_open
 297	n32	accept4				sys_accept4
-298	n32	recvmmsg			compat_sys_recvmmsg
+298	n32	recvmmsg			compat_sys_recvmmsg_time32
 299	n32	getdents64			sys_getdents64
 300	n32	fanotify_init			sys_fanotify_init
 301	n32	fanotify_mark			sys_fanotify_mark
 302	n32	prlimit64			sys_prlimit64
 303	n32	name_to_handle_at		sys_name_to_handle_at
 304	n32	open_by_handle_at		sys_open_by_handle_at
-305	n32	clock_adjtime			compat_sys_clock_adjtime
+305	n32	clock_adjtime			sys_clock_adjtime32
 306	n32	syncfs				sys_syncfs
 307	n32	sendmmsg			compat_sys_sendmmsg
 308	n32	setns				sys_setns
@@ -341,3 +341,24 @@
 330	n32	statx				sys_statx
 331	n32	rseq				sys_rseq
 332	n32	io_pgetevents			compat_sys_io_pgetevents
+# 333 through 402 are unassigned to sync up with generic numbers
+403	n32	clock_gettime64			sys_clock_gettime
+404	n32	clock_settime64			sys_clock_settime
+405	n32	clock_adjtime64			sys_clock_adjtime
+406	n32	clock_getres_time64		sys_clock_getres
+407	n32	clock_nanosleep_time64		sys_clock_nanosleep
+408	n32	timer_gettime64			sys_timer_gettime
+409	n32	timer_settime64			sys_timer_settime
+410	n32	timerfd_gettime64		sys_timerfd_gettime
+411	n32	timerfd_settime64		sys_timerfd_settime
+412	n32	utimensat_time64		sys_utimensat
+413	n32	pselect6_time64			compat_sys_pselect6_time64
+414	n32	ppoll_time64			compat_sys_ppoll_time64
+416	n32	io_pgetevents_time64		sys_io_pgetevents
+417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
+418	n32	mq_timedsend_time64		sys_mq_timedsend
+419	n32	mq_timedreceive_time64		sys_mq_timedreceive
+420	n32	semtimedop_time64		sys_semtimedop
+421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
+422	n32	futex_time64			sys_futex
+423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index a8286ccbb66c..c85502e67b44 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -37,7 +37,7 @@
 27	n64	madvise				sys_madvise
 28	n64	shmget				sys_shmget
 29	n64	shmat				sys_shmat
-30	n64	shmctl				sys_shmctl
+30	n64	shmctl				sys_old_shmctl
 31	n64	dup				sys_dup
 32	n64	dup2				sys_dup2
 33	n64	pause				sys_pause
@@ -71,12 +71,12 @@
 61	n64	uname				sys_newuname
 62	n64	semget				sys_semget
 63	n64	semop				sys_semop
-64	n64	semctl				sys_semctl
+64	n64	semctl				sys_old_semctl
 65	n64	shmdt				sys_shmdt
 66	n64	msgget				sys_msgget
 67	n64	msgsnd				sys_msgsnd
 68	n64	msgrcv				sys_msgrcv
-69	n64	msgctl				sys_msgctl
+69	n64	msgctl				sys_old_msgctl
 70	n64	fcntl				sys_fcntl
 71	n64	flock				sys_flock
 72	n64	fsync				sys_fsync
@@ -337,3 +337,4 @@
 326	n64	statx				sys_statx
 327	n64	rseq				sys_rseq
 328	n64	io_pgetevents			sys_io_pgetevents
+# 329 through 423 are reserved to sync up with other architectures
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 3d5a47b80d2b..2e063d0f837e 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -20,7 +20,7 @@
 10	o32	unlink				sys_unlink
 11	o32	execve				sys_execve			compat_sys_execve
 12	o32	chdir				sys_chdir
-13	o32	time				sys_time			compat_sys_time
+13	o32	time				sys_time32
 14	o32	mknod				sys_mknod
 15	o32	chmod				sys_chmod
 16	o32	lchown				sys_lchown
@@ -33,13 +33,13 @@
 22	o32	umount				sys_oldumount
 23	o32	setuid				sys_setuid
 24	o32	getuid				sys_getuid
-25	o32	stime				sys_stime			compat_sys_stime
+25	o32	stime				sys_stime32
 26	o32	ptrace				sys_ptrace			compat_sys_ptrace
 27	o32	alarm				sys_alarm
 # 28 was sys_fstat
 28	o32	unused28			sys_ni_syscall
 29	o32	pause				sys_pause
-30	o32	utime				sys_utime			compat_sys_utime
+30	o32	utime				sys_utime32
 31	o32	stty				sys_ni_syscall
 32	o32	gtty				sys_ni_syscall
 33	o32	access				sys_access
@@ -135,7 +135,7 @@
 121	o32	setdomainname			sys_setdomainname
 122	o32	uname				sys_newuname
 123	o32	modify_ldt			sys_ni_syscall
-124	o32	adjtimex			sys_adjtimex			compat_sys_adjtimex
+124	o32	adjtimex			sys_adjtimex_time32
 125	o32	mprotect			sys_mprotect
 126	o32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
 127	o32	create_module			sys_ni_syscall
@@ -176,8 +176,8 @@
 162	o32	sched_yield			sys_sched_yield
 163	o32	sched_get_priority_max		sys_sched_get_priority_max
 164	o32	sched_get_priority_min		sys_sched_get_priority_min
-165	o32	sched_rr_get_interval		sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-166	o32	nanosleep			sys_nanosleep			compat_sys_nanosleep
+165	o32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+166	o32	nanosleep			sys_nanosleep_time32
 167	o32	mremap				sys_mremap
 168	o32	accept				sys_accept
 169	o32	bind				sys_bind
@@ -208,7 +208,7 @@
 194	o32	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
 195	o32	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
 196	o32	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
-197	o32	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+197	o32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
 198	o32	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 199	o32	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 200	o32	pread64				sys_pread64			sys_32_pread
@@ -249,12 +249,12 @@
 235	o32	fremovexattr			sys_fremovexattr
 236	o32	tkill				sys_tkill
 237	o32	sendfile64			sys_sendfile64
-238	o32	futex				sys_futex			compat_sys_futex
+238	o32	futex				sys_futex_time32
 239	o32	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
 240	o32	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
 241	o32	io_setup			sys_io_setup			compat_sys_io_setup
 242	o32	io_destroy			sys_io_destroy
-243	o32	io_getevents			sys_io_getevents		compat_sys_io_getevents
+243	o32	io_getevents			sys_io_getevents_time32
 244	o32	io_submit			sys_io_submit			compat_sys_io_submit
 245	o32	io_cancel			sys_io_cancel
 246	o32	exit_group			sys_exit_group
@@ -269,23 +269,23 @@
 255	o32	statfs64			sys_statfs64			compat_sys_statfs64
 256	o32	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
 257	o32	timer_create			sys_timer_create		compat_sys_timer_create
-258	o32	timer_settime			sys_timer_settime		compat_sys_timer_settime
-259	o32	timer_gettime			sys_timer_gettime		compat_sys_timer_gettime
+258	o32	timer_settime			sys_timer_settime32
+259	o32	timer_gettime			sys_timer_gettime32
 260	o32	timer_getoverrun		sys_timer_getoverrun
 261	o32	timer_delete			sys_timer_delete
-262	o32	clock_settime			sys_clock_settime		compat_sys_clock_settime
-263	o32	clock_gettime			sys_clock_gettime		compat_sys_clock_gettime
-264	o32	clock_getres			sys_clock_getres		compat_sys_clock_getres
-265	o32	clock_nanosleep			sys_clock_nanosleep		compat_sys_clock_nanosleep
+262	o32	clock_settime			sys_clock_settime32
+263	o32	clock_gettime			sys_clock_gettime32
+264	o32	clock_getres			sys_clock_getres_time32
+265	o32	clock_nanosleep			sys_clock_nanosleep_time32
 266	o32	tgkill				sys_tgkill
-267	o32	utimes				sys_utimes			compat_sys_utimes
+267	o32	utimes				sys_utimes_time32
 268	o32	mbind				sys_mbind			compat_sys_mbind
 269	o32	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
 270	o32	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
 271	o32	mq_open				sys_mq_open			compat_sys_mq_open
 272	o32	mq_unlink			sys_mq_unlink
-273	o32	mq_timedsend			sys_mq_timedsend		compat_sys_mq_timedsend
-274	o32	mq_timedreceive			sys_mq_timedreceive		compat_sys_mq_timedreceive
+273	o32	mq_timedsend			sys_mq_timedsend_time32
+274	o32	mq_timedreceive			sys_mq_timedreceive_time32
 275	o32	mq_notify			sys_mq_notify			compat_sys_mq_notify
 276	o32	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
 277	o32	vserver				sys_ni_syscall
@@ -303,7 +303,7 @@
 289	o32	mkdirat				sys_mkdirat
 290	o32	mknodat				sys_mknodat
 291	o32	fchownat			sys_fchownat
-292	o32	futimesat			sys_futimesat			compat_sys_futimesat
+292	o32	futimesat			sys_futimesat_time32
 293	o32	fstatat64			sys_fstatat64			sys_newfstatat
 294	o32	unlinkat			sys_unlinkat
 295	o32	renameat			sys_renameat
@@ -312,8 +312,8 @@
 298	o32	readlinkat			sys_readlinkat
 299	o32	fchmodat			sys_fchmodat
 300	o32	faccessat			sys_faccessat
-301	o32	pselect6			sys_pselect6			compat_sys_pselect6
-302	o32	ppoll				sys_ppoll			compat_sys_ppoll
+301	o32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+302	o32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
 303	o32	unshare				sys_unshare
 304	o32	splice				sys_splice
 305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
@@ -327,14 +327,14 @@
 313	o32	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 314	o32	ioprio_set			sys_ioprio_set
 315	o32	ioprio_get			sys_ioprio_get
-316	o32	utimensat			sys_utimensat			compat_sys_utimensat
+316	o32	utimensat			sys_utimensat_time32
 317	o32	signalfd			sys_signalfd			compat_sys_signalfd
 318	o32	timerfd				sys_ni_syscall
 319	o32	eventfd				sys_eventfd
 320	o32	fallocate			sys_fallocate			sys32_fallocate
 321	o32	timerfd_create			sys_timerfd_create
-322	o32	timerfd_gettime			sys_timerfd_gettime		compat_sys_timerfd_gettime
-323	o32	timerfd_settime			sys_timerfd_settime		compat_sys_timerfd_settime
+322	o32	timerfd_gettime			sys_timerfd_gettime32
+323	o32	timerfd_settime			sys_timerfd_settime32
 324	o32	signalfd4			sys_signalfd4			compat_sys_signalfd4
 325	o32	eventfd2			sys_eventfd2
 326	o32	epoll_create1			sys_epoll_create1
@@ -346,13 +346,13 @@
 332	o32	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
 333	o32	perf_event_open			sys_perf_event_open
 334	o32	accept4				sys_accept4
-335	o32	recvmmsg			sys_recvmmsg			compat_sys_recvmmsg
+335	o32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
 336	o32	fanotify_init			sys_fanotify_init
 337	o32	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
 338	o32	prlimit64			sys_prlimit64
 339	o32	name_to_handle_at		sys_name_to_handle_at
 340	o32	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
-341	o32	clock_adjtime			sys_clock_adjtime		compat_sys_clock_adjtime
+341	o32	clock_adjtime			sys_clock_adjtime32
 342	o32	syncfs				sys_syncfs
 343	o32	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
 344	o32	setns				sys_setns
@@ -379,4 +379,35 @@
 365	o32	pkey_free			sys_pkey_free
 366	o32	statx				sys_statx
 367	o32	rseq				sys_rseq
-368	o32	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+368	o32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+# room for arch specific calls
+393	o32	semget				sys_semget
+394	o32	semctl				sys_semctl			compat_sys_semctl
+395	o32	shmget				sys_shmget
+396	o32	shmctl				sys_shmctl			compat_sys_shmctl
+397	o32	shmat				sys_shmat			compat_sys_shmat
+398	o32	shmdt				sys_shmdt
+399	o32	msgget				sys_msgget
+400	o32	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	o32	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	o32	msgctl				sys_msgctl			compat_sys_msgctl
+403	o32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	o32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	o32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	o32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	o32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	o32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	o32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	o32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	o32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	o32	utimensat_time64		sys_utimensat			sys_utimensat
+413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	o32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	o32	futex_time64			sys_futex			sys_futex
+423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index dda1906bba11..addb7f5f5264 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -5,6 +5,7 @@
 
 config NDS32
         def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index c2c3a3e34083..4ec8f543103f 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -3,6 +3,8 @@
 
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYNC_FILE_RANGE2
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 532343eebf89..c3e913ef4f0c 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config NIOS2
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_SWAP
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index d9948d88790b..0b4bb1d41b28 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -20,6 +20,8 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 09ab59e942ae..a5e361fbb75a 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -6,6 +6,7 @@
 
 config OPENRISC
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index ec37df18d8ed..566f8c4f8047 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -21,8 +21,10 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 7ca2c3ebad64..c8e621296092 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config PARISC
 	def_bool y
+	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_OPROFILE
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index c2c2afb28941..b0838dc4dfee 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -10,11 +10,7 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
-#define __IGNORE_select			/* newselect */
 #define __IGNORE_fadvise64		/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
@@ -156,10 +152,8 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_SYS_TIME32
 #define __ARCH_WANT_COMPAT_SYS_SCHED_RR_GET_INTERVAL
-#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
@@ -174,6 +168,11 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 
+#ifdef CONFIG_64BIT
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #undef STR
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 9bbd2f9f56c8..b26766c6647d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -20,7 +20,8 @@
 10	common	unlink			sys_unlink
 11	common	execve			sys_execve			compat_sys_execve
 12	common	chdir			sys_chdir
-13	common	time			sys_time			compat_sys_time
+13	32	time			sys_time32
+13	64	time			sys_time
 14	common	mknod			sys_mknod
 15	common	chmod			sys_chmod
 16	common	lchown			sys_lchown
@@ -32,12 +33,14 @@
 22	common	bind			sys_bind
 23	common	setuid			sys_setuid
 24	common	getuid			sys_getuid
-25	common	stime			sys_stime			compat_sys_stime
+25	32	stime			sys_stime32
+25	64	stime			sys_stime
 26	common	ptrace			sys_ptrace			compat_sys_ptrace
 27	common	alarm			sys_alarm
 28	common	fstat			sys_newfstat			compat_sys_newfstat
 29	common	pause			sys_pause
-30	common	utime			sys_utime			compat_sys_utime
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
 31	common	connect			sys_connect
 32	common	listen			sys_listen
 33	common	access			sys_access
@@ -133,7 +136,8 @@
 121	common	setdomainname		sys_setdomainname
 122	common	sendfile		sys_sendfile			compat_sys_sendfile
 123	common	recvfrom		sys_recvfrom
-124	common	adjtimex		sys_adjtimex			compat_sys_adjtimex
+124	32	adjtimex		sys_adjtimex_time32
+124	64	adjtimex		sys_adjtimex
 125	common	mprotect		sys_mprotect
 126	common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 # 127 was create_module
@@ -171,8 +175,10 @@
 158	common	sched_yield		sys_sched_yield
 159	common	sched_get_priority_max	sys_sched_get_priority_max
 160	common	sched_get_priority_min	sys_sched_get_priority_min
-161	common	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-162	common	nanosleep		sys_nanosleep			compat_sys_nanosleep
+161	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+161	64	sched_rr_get_interval	sys_sched_rr_get_interval
+162	32	nanosleep		sys_nanosleep_time32
+162	64	nanosleep		sys_nanosleep
 163	common	mremap			sys_mremap
 164	common	setresuid		sys_setresuid
 165	common	getresuid		sys_getresuid
@@ -187,7 +193,8 @@
 174	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
 175	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
 176	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
-177	common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+177	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+177	64	rt_sigtimedwait		sys_rt_sigtimedwait
 178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 180	common	chown			sys_chown
@@ -223,14 +230,16 @@
 207	64	readahead		sys_readahead
 208	common	tkill			sys_tkill
 209	common	sendfile64		sys_sendfile64			compat_sys_sendfile64
-210	common	futex			sys_futex			compat_sys_futex
+210	32	futex			sys_futex_time32
+210	64	futex			sys_futex
 211	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
 212	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
 # 213 was set_thread_area
 # 214 was get_thread_area
 215	common	io_setup		sys_io_setup			compat_sys_io_setup
 216	common	io_destroy		sys_io_destroy
-217	common	io_getevents		sys_io_getevents		compat_sys_io_getevents
+217	32	io_getevents		sys_io_getevents_time32
+217	64	io_getevents		sys_io_getevents
 218	common	io_submit		sys_io_submit			compat_sys_io_submit
 219	common	io_cancel		sys_io_cancel
 # 220 was alloc_hugepages
@@ -241,11 +250,14 @@
 225	common	epoll_ctl		sys_epoll_ctl
 226	common	epoll_wait		sys_epoll_wait
 227	common	remap_file_pages	sys_remap_file_pages
-228	common	semtimedop		sys_semtimedop			compat_sys_semtimedop
+228	32	semtimedop		sys_semtimedop_time32
+228	64	semtimedop		sys_semtimedop
 229	common	mq_open			sys_mq_open			compat_sys_mq_open
 230	common	mq_unlink		sys_mq_unlink
-231	common	mq_timedsend		sys_mq_timedsend		compat_sys_mq_timedsend
-232	common	mq_timedreceive		sys_mq_timedreceive		compat_sys_mq_timedreceive
+231	32	mq_timedsend		sys_mq_timedsend_time32
+231	64	mq_timedsend		sys_mq_timedsend
+232	32	mq_timedreceive		sys_mq_timedreceive_time32
+232	64	mq_timedreceive		sys_mq_timedreceive
 233	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
 234	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
 235	common	waitid			sys_waitid			compat_sys_waitid
@@ -265,14 +277,20 @@
 248	common	lremovexattr		sys_lremovexattr
 249	common	fremovexattr		sys_fremovexattr
 250	common	timer_create		sys_timer_create		compat_sys_timer_create
-251	common	timer_settime		sys_timer_settime		compat_sys_timer_settime
-252	common	timer_gettime		sys_timer_gettime		compat_sys_timer_gettime
+251	32	timer_settime		sys_timer_settime32
+251	64	timer_settime		sys_timer_settime
+252	32	timer_gettime		sys_timer_gettime32
+252	64	timer_gettime		sys_timer_gettime
 253	common	timer_getoverrun	sys_timer_getoverrun
 254	common	timer_delete		sys_timer_delete
-255	common	clock_settime		sys_clock_settime		compat_sys_clock_settime
-256	common	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
-257	common	clock_getres		sys_clock_getres		compat_sys_clock_getres
-258	common	clock_nanosleep		sys_clock_nanosleep		compat_sys_clock_nanosleep
+255	32	clock_settime		sys_clock_settime32
+255	64	clock_settime		sys_clock_settime
+256	32	clock_gettime		sys_clock_gettime32
+256	64	clock_gettime		sys_clock_gettime
+257	32	clock_getres		sys_clock_getres_time32
+257	64	clock_getres		sys_clock_getres
+258	32	clock_nanosleep		sys_clock_nanosleep_time32
+258	64	clock_nanosleep		sys_clock_nanosleep
 259	common	tgkill			sys_tgkill
 260	common	mbind			sys_mbind			compat_sys_mbind
 261	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
@@ -287,13 +305,16 @@
 270	common	inotify_add_watch	sys_inotify_add_watch
 271	common	inotify_rm_watch	sys_inotify_rm_watch
 272	common	migrate_pages		sys_migrate_pages
-273	common	pselect6		sys_pselect6			compat_sys_pselect6
-274	common	ppoll			sys_ppoll			compat_sys_ppoll
+273	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+273	64	pselect6		sys_pselect6
+274	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+274	64	ppoll			sys_ppoll
 275	common	openat			sys_openat			compat_sys_openat
 276	common	mkdirat			sys_mkdirat
 277	common	mknodat			sys_mknodat
 278	common	fchownat		sys_fchownat
-279	common	futimesat		sys_futimesat			compat_sys_futimesat
+279	32	futimesat		sys_futimesat_time32
+279	64	futimesat		sys_futimesat
 280	common	fstatat64		sys_fstatat64
 281	common	unlinkat		sys_unlinkat
 282	common	renameat		sys_renameat
@@ -316,15 +337,18 @@
 298	common	statfs64		sys_statfs64			compat_sys_statfs64
 299	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 300	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-301	common	utimensat		sys_utimensat			compat_sys_utimensat
+301	32	utimensat		sys_utimensat_time32
+301	64	utimensat		sys_utimensat
 302	common	signalfd		sys_signalfd			compat_sys_signalfd
 # 303 was timerfd
 304	common	eventfd			sys_eventfd
 305	32	fallocate		parisc_fallocate
 305	64	fallocate		sys_fallocate
 306	common	timerfd_create		sys_timerfd_create
-307	common	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
-308	common	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
+307	32	timerfd_settime		sys_timerfd_settime32
+307	64	timerfd_settime		sys_timerfd_settime
+308	32	timerfd_gettime		sys_timerfd_gettime32
+308	64	timerfd_gettime		sys_timerfd_gettime
 309	common	signalfd4		sys_signalfd4			compat_sys_signalfd4
 310	common	eventfd2		sys_eventfd2
 311	common	epoll_create1		sys_epoll_create1
@@ -335,12 +359,14 @@
 316	common	pwritev	sys_pwritev	compat_sys_pwritev
 317	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
 318	common	perf_event_open		sys_perf_event_open
-319	common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
+319	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+319	64	recvmmsg		sys_recvmmsg
 320	common	accept4			sys_accept4
 321	common	prlimit64		sys_prlimit64
 322	common	fanotify_init		sys_fanotify_init
 323	common	fanotify_mark		sys_fanotify_mark		sys32_fanotify_mark
-324	common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+324	32	clock_adjtime		sys_clock_adjtime32
+324	64	clock_adjtime		sys_clock_adjtime
 325	common	name_to_handle_at	sys_name_to_handle_at
 326	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
 327	common	syncfs			sys_syncfs
@@ -352,7 +378,8 @@
 333	common	finit_module		sys_finit_module
 334	common	sched_setattr		sys_sched_setattr
 335	common	sched_getattr		sys_sched_getattr
-336	common	utimes			sys_utimes			compat_sys_utimes
+336	32	utimes			sys_utimes_time32
+336	64	utimes			sys_utimes
 337	common	renameat2		sys_renameat2
 338	common	seccomp			sys_seccomp
 339	common	getrandom		sys_getrandom
@@ -366,4 +393,30 @@
 347	common	preadv2			sys_preadv2			compat_sys_preadv2
 348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 349	common	statx			sys_statx
-350	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+350	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+350	64	io_pgetevents		sys_io_pgetevents
+351	common	pkey_mprotect		sys_pkey_mprotect
+352	common	pkey_alloc		sys_pkey_alloc
+353	common	pkey_free		sys_pkey_free
+354	common	rseq			sys_rseq
+# 355 through 402 are unassigned to sync up with generic numbers
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..375d0dc0dc7d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -128,6 +128,7 @@ config PPC
 	#
 	# Please keep this list sorted alphabetically.
 	#
+	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index a3c35e6d6ffb..f44dbc65e38e 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -29,8 +29,8 @@
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_TIME32
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
@@ -45,8 +45,8 @@
 #define __ARCH_WANT_OLD_STAT
 #endif
 #ifdef CONFIG_PPC64
-#define __ARCH_WANT_COMPAT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME32
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index db3bbb8744af..b18abb0c3dae 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -20,7 +20,9 @@
 10	common	unlink				sys_unlink
 11	nospu	execve				sys_execve			compat_sys_execve
 12	common	chdir				sys_chdir
-13	common	time				sys_time			compat_sys_time
+13	32	time				sys_time32
+13	64	time				sys_time
+13	spu	time				sys_time
 14	common	mknod				sys_mknod
 15	common	chmod				sys_chmod
 16	common	lchown				sys_lchown
@@ -36,14 +38,17 @@
 22	spu	umount				sys_ni_syscall
 23	common	setuid				sys_setuid
 24	common	getuid				sys_getuid
-25	common	stime				sys_stime			compat_sys_stime
+25	32	stime				sys_stime32
+25	64	stime				sys_stime
+25	spu	stime				sys_stime
 26	nospu	ptrace				sys_ptrace			compat_sys_ptrace
 27	common	alarm				sys_alarm
 28	32	oldfstat			sys_fstat			sys_ni_syscall
 28	64	oldfstat			sys_ni_syscall
 28	spu	oldfstat			sys_ni_syscall
 29	nospu	pause				sys_pause
-30	nospu	utime				sys_utime			compat_sys_utime
+30	32	utime				sys_utime32
+30	64	utime				sys_utime
 31	common	stty				sys_ni_syscall
 32	common	gtty				sys_ni_syscall
 33	common	access				sys_access
@@ -157,7 +162,9 @@
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
 123	common	modify_ldt			sys_ni_syscall
-124	common	adjtimex			sys_adjtimex			compat_sys_adjtimex
+124	32	adjtimex			sys_adjtimex_time32
+124	64	adjtimex			sys_adjtimex
+124	spu	adjtimex			sys_adjtimex
 125	common	mprotect			sys_mprotect
 126	32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
 126	64	sigprocmask			sys_ni_syscall
@@ -198,8 +205,12 @@
 158	common	sched_yield			sys_sched_yield
 159	common	sched_get_priority_max		sys_sched_get_priority_max
 160	common	sched_get_priority_min		sys_sched_get_priority_min
-161	common	sched_rr_get_interval		sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-162	common	nanosleep			sys_nanosleep			compat_sys_nanosleep
+161	32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+161	64	sched_rr_get_interval		sys_sched_rr_get_interval
+161	spu	sched_rr_get_interval		sys_sched_rr_get_interval
+162	32	nanosleep			sys_nanosleep_time32
+162	64	nanosleep			sys_nanosleep
+162	spu	nanosleep			sys_nanosleep
 163	common	mremap				sys_mremap
 164	common	setresuid			sys_setresuid
 165	common	getresuid			sys_getresuid
@@ -213,7 +224,8 @@
 173	nospu	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
 174	nospu	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
 175	nospu	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
-176	nospu	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+176	32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+176	64	rt_sigtimedwait			sys_rt_sigtimedwait
 177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 179	common	pread64				sys_pread64			compat_sys_pread64
@@ -260,7 +272,9 @@
 218	common	removexattr			sys_removexattr
 219	common	lremovexattr			sys_lremovexattr
 220	common	fremovexattr			sys_fremovexattr
-221	common	futex				sys_futex			compat_sys_futex
+221	32	futex				sys_futex_time32
+221	64	futex				sys_futex
+221	spu	futex				sys_futex
 222	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
 223	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
 # 224 unused
@@ -268,7 +282,9 @@
 226	32	sendfile64			sys_sendfile64			compat_sys_sendfile64
 227	common	io_setup			sys_io_setup			compat_sys_io_setup
 228	common	io_destroy			sys_io_destroy
-229	common	io_getevents			sys_io_getevents		compat_sys_io_getevents
+229	32	io_getevents			sys_io_getevents_time32
+229	64	io_getevents			sys_io_getevents
+229	spu	io_getevents			sys_io_getevents
 230	common	io_submit			sys_io_submit			compat_sys_io_submit
 231	common	io_cancel			sys_io_cancel
 232	nospu	set_tid_address			sys_set_tid_address
@@ -280,19 +296,33 @@
 238	common	epoll_wait			sys_epoll_wait
 239	common	remap_file_pages		sys_remap_file_pages
 240	common	timer_create			sys_timer_create		compat_sys_timer_create
-241	common	timer_settime			sys_timer_settime		compat_sys_timer_settime
-242	common	timer_gettime			sys_timer_gettime		compat_sys_timer_gettime
+241	32	timer_settime			sys_timer_settime32
+241	64	timer_settime			sys_timer_settime
+241	spu	timer_settime			sys_timer_settime
+242	32	timer_gettime			sys_timer_gettime32
+242	64	timer_gettime			sys_timer_gettime
+242	spu	timer_gettime			sys_timer_gettime
 243	common	timer_getoverrun		sys_timer_getoverrun
 244	common	timer_delete			sys_timer_delete
-245	common	clock_settime			sys_clock_settime		compat_sys_clock_settime
-246	common	clock_gettime			sys_clock_gettime		compat_sys_clock_gettime
-247	common	clock_getres			sys_clock_getres		compat_sys_clock_getres
-248	common	clock_nanosleep			sys_clock_nanosleep		compat_sys_clock_nanosleep
+245	32	clock_settime			sys_clock_settime32
+245	64	clock_settime			sys_clock_settime
+245	spu	clock_settime			sys_clock_settime
+246	32	clock_gettime			sys_clock_gettime32
+246	64	clock_gettime			sys_clock_gettime
+246	spu	clock_gettime			sys_clock_gettime
+247	32	clock_getres			sys_clock_getres_time32
+247	64	clock_getres			sys_clock_getres
+247	spu	clock_getres			sys_clock_getres
+248	32	clock_nanosleep			sys_clock_nanosleep_time32
+248	64	clock_nanosleep			sys_clock_nanosleep
+248	spu	clock_nanosleep			sys_clock_nanosleep
 249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
 249	64	swapcontext			ppc64_swapcontext
 249	spu	swapcontext			sys_ni_syscall
 250	common	tgkill				sys_tgkill
-251	common	utimes				sys_utimes			compat_sys_utimes
+251	32	utimes				sys_utimes_time32
+251	64	utimes				sys_utimes
+251	spu	utimes				sys_utimes
 252	common	statfs64			sys_statfs64			compat_sys_statfs64
 253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
 254	32	fadvise64_64			ppc_fadvise64_64
@@ -308,8 +338,10 @@
 261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
 262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
 263	nospu	mq_unlink			sys_mq_unlink
-264	nospu	mq_timedsend			sys_mq_timedsend		compat_sys_mq_timedsend
-265	nospu	mq_timedreceive			sys_mq_timedreceive		compat_sys_mq_timedreceive
+264	32	mq_timedsend			sys_mq_timedsend_time32
+264	64	mq_timedsend			sys_mq_timedsend
+265	32	mq_timedreceive			sys_mq_timedreceive_time32
+265	64	mq_timedreceive			sys_mq_timedreceive
 266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
 267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
 268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
@@ -324,8 +356,10 @@
 277	nospu	inotify_rm_watch		sys_inotify_rm_watch
 278	nospu	spu_run				sys_spu_run
 279	nospu	spu_create			sys_spu_create
-280	nospu	pselect6			sys_pselect6			compat_sys_pselect6
-281	nospu	ppoll				sys_ppoll			compat_sys_ppoll
+280	32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+280	64	pselect6			sys_pselect6
+281	32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
+281	64	ppoll				sys_ppoll
 282	common	unshare				sys_unshare
 283	common	splice				sys_splice
 284	common	tee				sys_tee
@@ -334,7 +368,9 @@
 287	common	mkdirat				sys_mkdirat
 288	common	mknodat				sys_mknodat
 289	common	fchownat			sys_fchownat
-290	common	futimesat			sys_futimesat			compat_sys_futimesat
+290	32	futimesat			sys_futimesat_time32
+290	64	futimesat			sys_futimesat
+290	spu	utimesat			sys_futimesat
 291	32	fstatat64			sys_fstatat64
 291	64	newfstatat			sys_newfstatat
 291	spu	newfstatat			sys_newfstatat
@@ -350,15 +386,21 @@
 301	common	move_pages			sys_move_pages			compat_sys_move_pages
 302	common	getcpu				sys_getcpu
 303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
-304	common	utimensat			sys_utimensat			compat_sys_utimensat
+304	32	utimensat			sys_utimensat_time32
+304	64	utimensat			sys_utimensat
+304	spu	utimensat			sys_utimensat
 305	common	signalfd			sys_signalfd			compat_sys_signalfd
 306	common	timerfd_create			sys_timerfd_create
 307	common	eventfd				sys_eventfd
 308	common	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
 309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
 310	nospu	subpage_prot			sys_subpage_prot
-311	common	timerfd_settime			sys_timerfd_settime		compat_sys_timerfd_settime
-312	common	timerfd_gettime			sys_timerfd_gettime		compat_sys_timerfd_gettime
+311	32	timerfd_settime			sys_timerfd_settime32
+311	64	timerfd_settime			sys_timerfd_settime
+311	spu	timerfd_settime			sys_timerfd_settime
+312	32	timerfd_gettime			sys_timerfd_gettime32
+312	64	timerfd_gettime			sys_timerfd_gettime
+312	spu	timerfd_gettime			sys_timerfd_gettime
 313	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
 314	common	eventfd2			sys_eventfd2
 315	common	epoll_create1			sys_epoll_create1
@@ -389,11 +431,15 @@
 340	common	getsockopt			sys_getsockopt			compat_sys_getsockopt
 341	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
 342	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
-343	common	recvmmsg			sys_recvmmsg			compat_sys_recvmmsg
+343	32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+343	64	recvmmsg			sys_recvmmsg
+343	spu	recvmmsg			sys_recvmmsg
 344	common	accept4				sys_accept4
 345	common	name_to_handle_at		sys_name_to_handle_at
 346	common	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
-347	common	clock_adjtime			sys_clock_adjtime		compat_sys_clock_adjtime
+347	32	clock_adjtime			sys_clock_adjtime32
+347	64	clock_adjtime			sys_clock_adjtime
+347	spu	clock_adjtime			sys_clock_adjtime
 348	common	syncfs				sys_syncfs
 349	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
 350	common	setns				sys_setns
@@ -414,6 +460,7 @@
 363	spu	switch_endian			sys_ni_syscall
 364	common	userfaultfd			sys_userfaultfd
 365	common	membarrier			sys_membarrier
+# 366-377 originally left for IPC, now unused
 378	nospu	mlock2				sys_mlock2
 379	nospu	copy_file_range			sys_copy_file_range
 380	common	preadv2				sys_preadv2			compat_sys_preadv2
@@ -424,4 +471,37 @@
 385	nospu	pkey_free			sys_pkey_free
 386	nospu	pkey_mprotect			sys_pkey_mprotect
 387	nospu	rseq				sys_rseq
-388	nospu	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+388	32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+388	64	io_pgetevents			sys_io_pgetevents
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl			compat_sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl			compat_sys_shmctl
+397	common	shmat				sys_shmat			compat_sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl				sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 1f3bd3ebbb0d..0e2eeeb1fd27 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -17,6 +17,7 @@
 
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
 #endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index eed1c137f618..fec62b24df89 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -2,9 +2,11 @@
 
 # Symbols present in the vdso
 vdso-syms  = rt_sigreturn
+ifdef CONFIG_64BIT
 vdso-syms += gettimeofday
 vdso-syms += clock_gettime
 vdso-syms += clock_getres
+endif
 vdso-syms += getcpu
 vdso-syms += flush_icache
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b09eb3f..b6e3d0653002 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -75,6 +75,7 @@ config S390
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
@@ -379,6 +380,7 @@ config COMPAT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	select HAVE_UID16
 	depends on MULTIUSER
 	help
 	  Select this option if you want to enable your system kernel to
diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..5596c5c625d2
--- /dev/null
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - s390 specific wrappers to syscall definitions
+ *
+ */
+
+#ifndef _ASM_S390_SYSCALL_WRAPPER_H
+#define _ASM_S390_SYSCALL_WRAPPER_H
+
+#ifdef CONFIG_COMPAT
+#define __SC_COMPAT_TYPE(t, a) \
+	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
+
+#define __SC_COMPAT_CAST(t, a)						\
+({									\
+	long __ReS = a;							\
+									\
+	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
+		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t) &&		\
+		     !__TYPE_IS_LL(t));					\
+	if (__TYPE_IS_L(t))						\
+		__ReS = (s32)a;						\
+	if (__TYPE_IS_UL(t))						\
+		__ReS = (u32)a;						\
+	if (__TYPE_IS_PTR(t))						\
+		__ReS = a & 0x7fffffff;					\
+	if (__TYPE_IS_LL(t))						\
+		return -ENOSYS;						\
+	(t)__ReS;							\
+})
+
+#define __S390_SYS_STUBx(x, name, ...)					\
+	asmlinkage long __s390_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
+	ALLOW_ERROR_INJECTION(__s390_sys##name, ERRNO);			\
+	asmlinkage long __s390_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
+	{								\
+		long ret = __s390x_sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		return ret;						\
+	}
+
+/*
+ * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
+ * named __s390x_sys_*()
+ */
+#define COMPAT_SYSCALL_DEFINE0(sname)					\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __s390_compat_sys_##sname(void);		\
+	ALLOW_ERROR_INJECTION(__s390_compat__sys_##sname, ERRNO);	\
+	asmlinkage long __s390_compat_sys_##sname(void)
+
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __s390x_sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
+	asmlinkage long __s390_sys_##sname(void)			\
+		__attribute__((alias(__stringify(__s390x_sys_##sname)))); \
+	asmlinkage long __s390x_sys_##sname(void)
+
+#define COND_SYSCALL(name)						\
+	cond_syscall(__s390x_sys_##name);				\
+	cond_syscall(__s390_sys_##name)
+
+#define SYS_NI(name)							\
+	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);		\
+	SYSCALL_ALIAS(__s390_sys_##name, sys_ni_posix_timers)
+
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
+	__diag_push();								\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long __s390_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __s390_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
+	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{									\
+		long ret = __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		return ret;							\
+	}									\
+	__diag_pop();								\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+/*
+ * As some compat syscalls may not be implemented, we need to expand
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
+ * kernel/time/posix-stubs.c to cover this case as well.
+ */
+#define COND_SYSCALL_COMPAT(name)					\
+	cond_syscall(__s390_compat_sys_##name)
+
+#define COMPAT_SYS_NI(name)						\
+	SYSCALL_ALIAS(__s390_compat_sys_##name, sys_ni_posix_timers)
+
+#else /* CONFIG_COMPAT */
+
+#define __S390_SYS_STUBx(x, fullname, name, ...)
+
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __s390x_sys_##sname(void);			\
+	ALLOW_ERROR_INJECTION(__s390x_sys_##sname, ERRNO);		\
+	asmlinkage long __s390x_sys_##sname(void)
+
+#define COND_SYSCALL(name)						\
+	cond_syscall(__s390x_sys_##name)
+
+#define SYS_NI(name)							\
+	SYSCALL_ALIAS(__s390x_sys_##name, sys_ni_posix_timers);
+
+#endif /* CONFIG_COMPAT */
+
+#define __SYSCALL_DEFINEx(x, name, ...)						\
+	__diag_push();								\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long __s390x_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_sys##name))));		\
+	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	__S390_SYS_STUBx(x, name, __VA_ARGS__)					\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{									\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		return ret;							\
+	}									\
+	__diag_pop();								\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#endif /* _ASM_X86_SYSCALL_WRAPPER_H */
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index a1fbf15d53aa..b6755685c7b8 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -10,11 +10,6 @@
 #include <uapi/asm/unistd.h>
 #include <asm/unistd_nr.h>
 
-#define __IGNORE_time
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
@@ -33,7 +28,7 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
-#   define __ARCH_WANT_COMPAT_SYS_TIME
+#   define __ARCH_WANT_SYS_TIME32
 #   define __ARCH_WANT_SYS_UTIME32
 # endif
 #define __ARCH_WANT_SYS_FORK
diff --git a/arch/s390/include/uapi/asm/posix_types.h b/arch/s390/include/uapi/asm/posix_types.h
index 2a3fc638414b..1913613e71b6 100644
--- a/arch/s390/include/uapi/asm/posix_types.h
+++ b/arch/s390/include/uapi/asm/posix_types.h
@@ -20,6 +20,12 @@ typedef long            __kernel_ssize_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+#ifdef __KERNEL__
+typedef unsigned short __kernel_old_uid_t;
+typedef unsigned short __kernel_old_gid_t;
+#define __kernel_old_uid_t __kernel_old_uid_t
+#endif
+
 #ifndef __s390x__
 
 typedef unsigned long   __kernel_ino_t;
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index e216e116a9a9..4e188a7be501 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_HIBERNATION)	+= suspend.o swsusp.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
-obj-$(CONFIG_COMPAT)		+= compat_wrapper.o $(compat-obj-y)
+obj-$(CONFIG_COMPAT)		+= $(compat-obj-y)
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 8ac38d51ed7d..f9d418d1b619 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -34,7 +34,6 @@
 #include <linux/stat.h>
 #include <linux/filter.h>
 #include <linux/highmem.h>
-#include <linux/highuid.h>
 #include <linux/mman.h>
 #include <linux/ipv6.h>
 #include <linux/in.h>
@@ -58,245 +57,13 @@
 
 #include "compat_linux.h"
 
-/* For this source file, we want overflow handling. */
-
-#undef high2lowuid
-#undef high2lowgid
-#undef low2highuid
-#undef low2highgid
-#undef SET_UID16
-#undef SET_GID16
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#undef SET_OLDSTAT_UID
-#undef SET_OLDSTAT_GID
-#undef SET_STAT_UID
-#undef SET_STAT_GID
-
-#define high2lowuid(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
-#define high2lowgid(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid)
-#define low2highuid(uid) ((uid) == (u16)-1) ? (uid_t)-1 : (uid_t)(uid)
-#define low2highgid(gid) ((gid) == (u16)-1) ? (gid_t)-1 : (gid_t)(gid)
-#define SET_UID16(var, uid)	var = high2lowuid(uid)
-#define SET_GID16(var, gid)	var = high2lowgid(gid)
-#define NEW_TO_OLD_UID(uid)	high2lowuid(uid)
-#define NEW_TO_OLD_GID(gid)	high2lowgid(gid)
-#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = high2lowuid(uid)
-#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = high2lowgid(gid)
-#define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
-#define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
-
-COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
-		       u16, user, u16, group)
-{
-	return ksys_chown(filename, low2highuid(user), low2highgid(group));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
-		       filename, u16, user, u16, group)
-{
-	return ksys_lchown(filename, low2highuid(user), low2highgid(group));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_fchown16, unsigned int, fd, u16, user, u16, group)
-{
-	return ksys_fchown(fd, low2highuid(user), low2highgid(group));
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_setregid16, u16, rgid, u16, egid)
-{
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setgid16, u16, gid)
-{
-	return sys_setgid(low2highgid(gid));
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_setreuid16, u16, ruid, u16, euid)
-{
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setuid16, u16, uid)
-{
-	return sys_setuid(low2highuid(uid));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_setresuid16, u16, ruid, u16, euid, u16, suid)
-{
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
-			     low2highuid(suid));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_getresuid16, u16 __user *, ruidp,
-		       u16 __user *, euidp, u16 __user *, suidp)
-{
-	const struct cred *cred = current_cred();
-	int retval;
-	u16 ruid, euid, suid;
-
-	ruid = high2lowuid(from_kuid_munged(cred->user_ns, cred->uid));
-	euid = high2lowuid(from_kuid_munged(cred->user_ns, cred->euid));
-	suid = high2lowuid(from_kuid_munged(cred->user_ns, cred->suid));
-
-	if (!(retval   = put_user(ruid, ruidp)) &&
-	    !(retval   = put_user(euid, euidp)))
-		retval = put_user(suid, suidp);
-
-	return retval;
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_setresgid16, u16, rgid, u16, egid, u16, sgid)
-{
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
-			     low2highgid(sgid));
-}
-
-COMPAT_SYSCALL_DEFINE3(s390_getresgid16, u16 __user *, rgidp,
-		       u16 __user *, egidp, u16 __user *, sgidp)
-{
-	const struct cred *cred = current_cred();
-	int retval;
-	u16 rgid, egid, sgid;
-
-	rgid = high2lowgid(from_kgid_munged(cred->user_ns, cred->gid));
-	egid = high2lowgid(from_kgid_munged(cred->user_ns, cred->egid));
-	sgid = high2lowgid(from_kgid_munged(cred->user_ns, cred->sgid));
-
-	if (!(retval   = put_user(rgid, rgidp)) &&
-	    !(retval   = put_user(egid, egidp)))
-		retval = put_user(sgid, sgidp);
-
-	return retval;
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setfsuid16, u16, uid)
-{
-	return sys_setfsuid(low2highuid(uid));
-}
-
-COMPAT_SYSCALL_DEFINE1(s390_setfsgid16, u16, gid)
-{
-	return sys_setfsgid(low2highgid(gid));
-}
-
-static int groups16_to_user(u16 __user *grouplist, struct group_info *group_info)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	int i;
-	u16 group;
-	kgid_t kgid;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		kgid = group_info->gid[i];
-		group = (u16)from_kgid_munged(user_ns, kgid);
-		if (put_user(group, grouplist+i))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-static int groups16_from_user(struct group_info *group_info, u16 __user *grouplist)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	int i;
-	u16 group;
-	kgid_t kgid;
-
-	for (i = 0; i < group_info->ngroups; i++) {
-		if (get_user(group, grouplist+i))
-			return  -EFAULT;
-
-		kgid = make_kgid(user_ns, (gid_t)group);
-		if (!gid_valid(kgid))
-			return -EINVAL;
-
-		group_info->gid[i] = kgid;
-	}
-
-	return 0;
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_getgroups16, int, gidsetsize, u16 __user *, grouplist)
-{
-	const struct cred *cred = current_cred();
-	int i;
-
-	if (gidsetsize < 0)
-		return -EINVAL;
-
-	get_group_info(cred->group_info);
-	i = cred->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize) {
-			i = -EINVAL;
-			goto out;
-		}
-		if (groups16_to_user(grouplist, cred->group_info)) {
-			i = -EFAULT;
-			goto out;
-		}
-	}
-out:
-	put_group_info(cred->group_info);
-	return i;
-}
-
-COMPAT_SYSCALL_DEFINE2(s390_setgroups16, int, gidsetsize, u16 __user *, grouplist)
-{
-	struct group_info *group_info;
-	int retval;
-
-	if (!may_setgroups())
-		return -EPERM;
-	if ((unsigned)gidsetsize > NGROUPS_MAX)
-		return -EINVAL;
-
-	group_info = groups_alloc(gidsetsize);
-	if (!group_info)
-		return -ENOMEM;
-	retval = groups16_from_user(group_info, grouplist);
-	if (retval) {
-		put_group_info(group_info);
-		return retval;
-	}
-
-	groups_sort(group_info);
-	retval = set_current_groups(group_info);
-	put_group_info(group_info);
-
-	return retval;
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_getuid16)
-{
-	return high2lowuid(from_kuid_munged(current_user_ns(), current_uid()));
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_geteuid16)
-{
-	return high2lowuid(from_kuid_munged(current_user_ns(), current_euid()));
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_getgid16)
-{
-	return high2lowgid(from_kgid_munged(current_user_ns(), current_gid()));
-}
-
-COMPAT_SYSCALL_DEFINE0(s390_getegid16)
-{
-	return high2lowgid(from_kgid_munged(current_user_ns(), current_egid()));
-}
-
 #ifdef CONFIG_SYSVIPC
 COMPAT_SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, compat_ulong_t, second,
 		compat_ulong_t, third, compat_uptr_t, ptr)
 {
 	if (call >> 16)		/* hack for backward compatibility */
 		return -EINVAL;
-	return compat_sys_ipc(call, first, second, third, ptr, third);
+	return compat_ksys_ipc(call, first, second, third, ptr, third);
 }
 #endif
 
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
deleted file mode 100644
index 48c4ce668244..000000000000
--- a/arch/s390/kernel/compat_wrapper.c
+++ /dev/null
@@ -1,186 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Compat system call wrappers.
- *
- *    Copyright IBM Corp. 2014
- */
-
-#include <linux/syscalls.h>
-#include <linux/compat.h>
-#include "entry.h"
-
-#define COMPAT_SYSCALL_WRAP1(name, ...) \
-	COMPAT_SYSCALL_WRAPx(1, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP2(name, ...) \
-	COMPAT_SYSCALL_WRAPx(2, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP3(name, ...) \
-	COMPAT_SYSCALL_WRAPx(3, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP4(name, ...) \
-	COMPAT_SYSCALL_WRAPx(4, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP5(name, ...) \
-	COMPAT_SYSCALL_WRAPx(5, _##name, __VA_ARGS__)
-#define COMPAT_SYSCALL_WRAP6(name, ...) \
-	COMPAT_SYSCALL_WRAPx(6, _##name, __VA_ARGS__)
-
-#define __SC_COMPAT_TYPE(t, a) \
-	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
-
-#define __SC_COMPAT_CAST(t, a)						\
-({									\
-	long __ReS = a;							\
-									\
-	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
-		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));		\
-	if (__TYPE_IS_L(t))						\
-		__ReS = (s32)a;						\
-	if (__TYPE_IS_UL(t))						\
-		__ReS = (u32)a;						\
-	if (__TYPE_IS_PTR(t))						\
-		__ReS = a & 0x7fffffff;					\
-	(t)__ReS;							\
-})
-
-/*
- * The COMPAT_SYSCALL_WRAP macro generates system call wrappers to be used by
- * compat tasks. These wrappers will only be used for system calls where only
- * the system call arguments need sign or zero extension or zeroing of the upper
- * 33 bits of pointers.
- * Note: since the wrapper function will afterwards call a system call which
- * again performs zero and sign extension for all system call arguments with
- * a size of less than eight bytes, these compat wrappers only touch those
- * system call arguments with a size of eight bytes ((unsigned) long and
- * pointers). Zero and sign extension for e.g. int parameters will be done by
- * the regular system call wrappers.
- */
-#define COMPAT_SYSCALL_WRAPx(x, name, ...)					\
-asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));			\
-asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));\
-asmlinkage long notrace compat_sys##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))	\
-{										\
-	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));		\
-}
-
-COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
-COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
-COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
-COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);
-COMPAT_SYSCALL_WRAP1(oldumount, char __user *, name);
-COMPAT_SYSCALL_WRAP2(access, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP2(rename, const char __user *, oldname, const char __user *, newname);
-COMPAT_SYSCALL_WRAP2(mkdir, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP1(rmdir, const char __user *, pathname);
-COMPAT_SYSCALL_WRAP1(pipe, int __user *, fildes);
-COMPAT_SYSCALL_WRAP1(brk, unsigned long, brk);
-COMPAT_SYSCALL_WRAP2(signal, int, sig, __sighandler_t, handler);
-COMPAT_SYSCALL_WRAP1(acct, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(umount, char __user *, name, int, flags);
-COMPAT_SYSCALL_WRAP1(chroot, const char __user *, filename);
-COMPAT_SYSCALL_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask);
-COMPAT_SYSCALL_WRAP2(sethostname, char __user *, name, int, len);
-COMPAT_SYSCALL_WRAP2(symlink, const char __user *, old, const char __user *, new);
-COMPAT_SYSCALL_WRAP3(readlink, const char __user *, path, char __user *, buf, int, bufsiz);
-COMPAT_SYSCALL_WRAP1(uselib, const char __user *, library);
-COMPAT_SYSCALL_WRAP2(swapon, const char __user *, specialfile, int, swap_flags);
-COMPAT_SYSCALL_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd, void __user *, arg);
-COMPAT_SYSCALL_WRAP2(munmap, unsigned long, addr, size_t, len);
-COMPAT_SYSCALL_WRAP3(syslog, int, type, char __user *, buf, int, len);
-COMPAT_SYSCALL_WRAP1(swapoff, const char __user *, specialfile);
-COMPAT_SYSCALL_WRAP2(setdomainname, char __user *, name, int, len);
-COMPAT_SYSCALL_WRAP1(newuname, struct new_utsname __user *, name);
-COMPAT_SYSCALL_WRAP3(mprotect, unsigned long, start, size_t, len, unsigned long, prot);
-COMPAT_SYSCALL_WRAP3(init_module, void __user *, umod, unsigned long, len, const char __user *, uargs);
-COMPAT_SYSCALL_WRAP2(delete_module, const char __user *, name_user, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(quotactl, unsigned int, cmd, const char __user *, special, qid_t, id, void __user *, addr);
-COMPAT_SYSCALL_WRAP2(bdflush, int, func, long, data);
-COMPAT_SYSCALL_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2);
-COMPAT_SYSCALL_WRAP5(llseek, unsigned int, fd, unsigned long, high, unsigned long, low, loff_t __user *, result, unsigned int, whence);
-COMPAT_SYSCALL_WRAP3(msync, unsigned long, start, size_t, len, int, flags);
-COMPAT_SYSCALL_WRAP2(mlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP2(munlock, unsigned long, start, size_t, len);
-COMPAT_SYSCALL_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param);
-COMPAT_SYSCALL_WRAP5(mremap, unsigned long, addr, unsigned long, old_len, unsigned long, new_len, unsigned long, flags, unsigned long, new_addr);
-COMPAT_SYSCALL_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds, int, timeout);
-COMPAT_SYSCALL_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3, unsigned long, arg4, unsigned long, arg5);
-COMPAT_SYSCALL_WRAP2(getcwd, char __user *, buf, unsigned long, size);
-COMPAT_SYSCALL_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr);
-COMPAT_SYSCALL_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data);
-COMPAT_SYSCALL_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist);
-COMPAT_SYSCALL_WRAP3(getresuid, uid_t __user *, ruid, uid_t __user *, euid, uid_t __user *, suid);
-COMPAT_SYSCALL_WRAP3(getresgid, gid_t __user *, rgid, gid_t __user *, egid, gid_t __user *, sgid);
-COMPAT_SYSCALL_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group);
-COMPAT_SYSCALL_WRAP2(pivot_root, const char __user *, new_root, const char __user *, put_old);
-COMPAT_SYSCALL_WRAP3(mincore, unsigned long, start, size_t, len, unsigned char __user *, vec);
-COMPAT_SYSCALL_WRAP3(madvise, unsigned long, start, size_t, len, int, behavior);
-COMPAT_SYSCALL_WRAP5(setxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP5(lsetxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP5(fsetxattr, int, fd, const char __user *, name, const void __user *, value, size_t, size, int, flags);
-COMPAT_SYSCALL_WRAP3(getdents64, unsigned int, fd, struct linux_dirent64 __user *, dirent, unsigned int, count);
-COMPAT_SYSCALL_WRAP4(getxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP4(lgetxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP4(fgetxattr, int, fd, const char __user *, name, void __user *, value, size_t, size);
-COMPAT_SYSCALL_WRAP3(listxattr, const char __user *, path, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP3(llistxattr, const char __user *, path, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size);
-COMPAT_SYSCALL_WRAP2(removexattr, const char __user *, path, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(lremovexattr, const char __user *, path, const char __user *, name);
-COMPAT_SYSCALL_WRAP2(fremovexattr, int, fd, const char __user *, name);
-COMPAT_SYSCALL_WRAP1(set_tid_address, int __user *, tidptr);
-COMPAT_SYSCALL_WRAP4(epoll_ctl, int, epfd, int, op, int, fd, struct epoll_event __user *, event);
-COMPAT_SYSCALL_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events, int, maxevents, int, timeout);
-COMPAT_SYSCALL_WRAP1(io_destroy, aio_context_t, ctx);
-COMPAT_SYSCALL_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb, struct io_event __user *, result);
-COMPAT_SYSCALL_WRAP1(mq_unlink, const char __user *, name);
-COMPAT_SYSCALL_WRAP5(add_key, const char __user *, tp, const char __user *, dsc, const void __user *, pld, size_t, len, key_serial_t, id);
-COMPAT_SYSCALL_WRAP4(request_key, const char __user *, tp, const char __user *, dsc, const char __user *, info, key_serial_t, id);
-COMPAT_SYSCALL_WRAP5(remap_file_pages, unsigned long, start, unsigned long, size, unsigned long, prot, unsigned long, pgoff, unsigned long, flags);
-COMPAT_SYSCALL_WRAP3(inotify_add_watch, int, fd, const char __user *, path, u32, mask);
-COMPAT_SYSCALL_WRAP3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode);
-COMPAT_SYSCALL_WRAP4(mknodat, int, dfd, const char __user *, filename, umode_t, mode, unsigned, dev);
-COMPAT_SYSCALL_WRAP5(fchownat, int, dfd, const char __user *, filename, uid_t, user, gid_t, group, int, flag);
-COMPAT_SYSCALL_WRAP3(unlinkat, int, dfd, const char __user *, pathname, int, flag);
-COMPAT_SYSCALL_WRAP4(renameat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname);
-COMPAT_SYSCALL_WRAP5(linkat, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, int, flags);
-COMPAT_SYSCALL_WRAP3(symlinkat, const char __user *, oldname, int, newdfd, const char __user *, newname);
-COMPAT_SYSCALL_WRAP4(readlinkat, int, dfd, const char __user *, path, char __user *, buf, int, bufsiz);
-COMPAT_SYSCALL_WRAP3(fchmodat, int, dfd, const char __user *, filename, umode_t, mode);
-COMPAT_SYSCALL_WRAP3(faccessat, int, dfd, const char __user *, filename, int, mode);
-COMPAT_SYSCALL_WRAP1(unshare, unsigned long, unshare_flags);
-COMPAT_SYSCALL_WRAP6(splice, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(getcpu, unsigned __user *, cpu, unsigned __user *, node, struct getcpu_cache __user *, cache);
-COMPAT_SYSCALL_WRAP2(pipe2, int __user *, fildes, int, flags);
-COMPAT_SYSCALL_WRAP5(perf_event_open, struct perf_event_attr __user *, attr_uptr, pid_t, pid, int, cpu, int, group_fd, unsigned long, flags);
-COMPAT_SYSCALL_WRAP5(clone, unsigned long, newsp, unsigned long, clone_flags, int __user *, parent_tidptr, int __user *, child_tidptr, unsigned long, tls);
-COMPAT_SYSCALL_WRAP4(prlimit64, pid_t, pid, unsigned int, resource, const struct rlimit64 __user *, new_rlim, struct rlimit64 __user *, old_rlim);
-COMPAT_SYSCALL_WRAP5(name_to_handle_at, int, dfd, const char __user *, name, struct file_handle __user *, handle, int __user *, mnt_id, int, flag);
-COMPAT_SYSCALL_WRAP5(kcmp, pid_t, pid1, pid_t, pid2, int, type, unsigned long, idx1, unsigned long, idx2);
-COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, flags);
-COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
-COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
-COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
-COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, void __user *, uargs)
-COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
-COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
-COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
-COMPAT_SYSCALL_WRAP3(s390_pci_mmio_write, const unsigned long, mmio_addr, const void __user *, user_buffer, const size_t, length);
-COMPAT_SYSCALL_WRAP3(s390_pci_mmio_read, const unsigned long, mmio_addr, void __user *, user_buffer, const size_t, length);
-COMPAT_SYSCALL_WRAP4(socketpair, int, family, int, type, int, protocol, int __user *, usockvec);
-COMPAT_SYSCALL_WRAP3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen);
-COMPAT_SYSCALL_WRAP3(connect, int, fd, struct sockaddr __user *, uservaddr, int, addrlen);
-COMPAT_SYSCALL_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr, int __user *, upeer_addrlen, int, flags);
-COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
-COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
-COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
-COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
-COMPAT_SYSCALL_WRAP6(copy_file_range, int, fd_in, loff_t __user *, off_in, int, fd_out, loff_t __user *, off_out, size_t, len, unsigned int, flags);
-COMPAT_SYSCALL_WRAP2(s390_guarded_storage, int, command, struct gs_cb *, gs_cb);
-COMPAT_SYSCALL_WRAP5(statx, int, dfd, const char __user *, path, unsigned, flags, unsigned, mask, struct statx __user *, buffer);
-COMPAT_SYSCALL_WRAP4(s390_sthyi, unsigned long, code, void __user *, info, u64 __user *, rc, unsigned long, flags);
-COMPAT_SYSCALL_WRAP5(kexec_file_load, int, kernel_fd, int, initrd_fd, unsigned long, cmdline_len, const char __user *, cmdline_ptr, unsigned long, flags)
-COMPAT_SYSCALL_WRAP4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 39191a0feed1..583d65ef5007 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -1512,7 +1512,7 @@ cleanup_critical:
 	.quad   .Lsie_skip - .Lsie_entry
 #endif
 	.section .rodata, "a"
-#define SYSCALL(esame,emu)	.long esame
+#define SYSCALL(esame,emu)	.long __s390x_ ## esame
 	.globl	sys_call_table
 sys_call_table:
 #include "asm/syscall_table.h"
@@ -1520,7 +1520,7 @@ sys_call_table:
 
 #ifdef CONFIG_COMPAT
 
-#define SYSCALL(esame,emu)	.long emu
+#define SYSCALL(esame,emu)	.long __s390_ ## emu
 	.globl	sys_call_table_emu
 sys_call_table_emu:
 #include "asm/syscall_table.h"
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 31cefe0c28c0..202fa73ac167 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -58,6 +58,7 @@ SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
 	return error;
 }
 
+#ifdef CONFIG_SYSVIPC
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls.
  */
@@ -74,19 +75,28 @@ SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, unsigned long, second,
 	 * Therefore we can call the generic variant by simply passing the
 	 * third parameter also as fifth parameter.
 	 */
-	return sys_ipc(call, first, second, third, ptr, third);
+	return ksys_ipc(call, first, second, third, ptr, third);
 }
+#endif /* CONFIG_SYSVIPC */
 
 SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
 {
-	unsigned int ret;
+	unsigned int ret = current->personality;
 
 	if (personality(current->personality) == PER_LINUX32 &&
 	    personality(personality) == PER_LINUX)
 		personality |= PER_LINUX32;
-	ret = sys_personality(personality);
+
+	if (personality != 0xffffffff)
+		set_personality(personality);
+
 	if (personality(ret) == PER_LINUX32)
 		ret &= ~PER_LINUX32;
 
 	return ret;
 }
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return -ENOSYS;
+}
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 022fc099b628..02579f95f391 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -15,86 +15,86 @@
 5    common	open			sys_open			compat_sys_open
 6    common	close			sys_close			sys_close
 7    common	restart_syscall		sys_restart_syscall		sys_restart_syscall
-8    common	creat			sys_creat			compat_sys_creat
-9    common	link			sys_link			compat_sys_link
-10   common	unlink			sys_unlink			compat_sys_unlink
+8    common	creat			sys_creat			sys_creat
+9    common	link			sys_link			sys_link
+10   common	unlink			sys_unlink			sys_unlink
 11   common	execve			sys_execve			compat_sys_execve
-12   common	chdir			sys_chdir			compat_sys_chdir
-13   32		time			-				compat_sys_time
-14   common	mknod			sys_mknod			compat_sys_mknod
-15   common	chmod			sys_chmod			compat_sys_chmod
-16   32		lchown			-				compat_sys_s390_lchown16
+12   common	chdir			sys_chdir			sys_chdir
+13   32		time			-				sys_time32
+14   common	mknod			sys_mknod			sys_mknod
+15   common	chmod			sys_chmod			sys_chmod
+16   32		lchown			-				sys_lchown16
 19   common	lseek			sys_lseek			compat_sys_lseek
 20   common	getpid			sys_getpid			sys_getpid
 21   common	mount			sys_mount			compat_sys_mount
-22   common	umount			sys_oldumount			compat_sys_oldumount
-23   32		setuid			-				compat_sys_s390_setuid16
-24   32		getuid			-				compat_sys_s390_getuid16
-25   32		stime			-				compat_sys_stime
+22   common	umount			sys_oldumount			sys_oldumount
+23   32		setuid			-				sys_setuid16
+24   32		getuid			-				sys_getuid16
+25   32		stime			-				sys_stime32
 26   common	ptrace			sys_ptrace			compat_sys_ptrace
 27   common	alarm			sys_alarm			sys_alarm
 29   common	pause			sys_pause			sys_pause
-30   common	utime			sys_utime			compat_sys_utime
-33   common	access			sys_access			compat_sys_access
+30   common	utime			sys_utime			sys_utime32
+33   common	access			sys_access			sys_access
 34   common	nice			sys_nice			sys_nice
 36   common	sync			sys_sync			sys_sync
 37   common	kill			sys_kill			sys_kill
-38   common	rename			sys_rename			compat_sys_rename
-39   common	mkdir			sys_mkdir			compat_sys_mkdir
-40   common	rmdir			sys_rmdir			compat_sys_rmdir
+38   common	rename			sys_rename			sys_rename
+39   common	mkdir			sys_mkdir			sys_mkdir
+40   common	rmdir			sys_rmdir			sys_rmdir
 41   common	dup			sys_dup				sys_dup
-42   common	pipe			sys_pipe			compat_sys_pipe
+42   common	pipe			sys_pipe			sys_pipe
 43   common	times			sys_times			compat_sys_times
-45   common	brk			sys_brk				compat_sys_brk
-46   32		setgid			-				compat_sys_s390_setgid16
-47   32		getgid			-				compat_sys_s390_getgid16
-48   common	signal			sys_signal			compat_sys_signal
-49   32		geteuid			-				compat_sys_s390_geteuid16
-50   32		getegid			-				compat_sys_s390_getegid16
-51   common	acct			sys_acct			compat_sys_acct
-52   common	umount2			sys_umount			compat_sys_umount
+45   common	brk			sys_brk				sys_brk
+46   32		setgid			-				sys_setgid16
+47   32		getgid			-				sys_getgid16
+48   common	signal			sys_signal			sys_signal
+49   32		geteuid			-				sys_geteuid16
+50   32		getegid			-				sys_getegid16
+51   common	acct			sys_acct			sys_acct
+52   common	umount2			sys_umount			sys_umount
 54   common	ioctl			sys_ioctl			compat_sys_ioctl
 55   common	fcntl			sys_fcntl			compat_sys_fcntl
 57   common	setpgid			sys_setpgid			sys_setpgid
 60   common	umask			sys_umask			sys_umask
-61   common	chroot			sys_chroot			compat_sys_chroot
+61   common	chroot			sys_chroot			sys_chroot
 62   common	ustat			sys_ustat			compat_sys_ustat
 63   common	dup2			sys_dup2			sys_dup2
 64   common	getppid			sys_getppid			sys_getppid
 65   common	getpgrp			sys_getpgrp			sys_getpgrp
 66   common	setsid			sys_setsid			sys_setsid
 67   common	sigaction		sys_sigaction			compat_sys_sigaction
-70   32		setreuid		-				compat_sys_s390_setreuid16
-71   32		setregid		-				compat_sys_s390_setregid16
-72   common	sigsuspend		sys_sigsuspend			compat_sys_sigsuspend
+70   32		setreuid		-				sys_setreuid16
+71   32		setregid		-				sys_setregid16
+72   common	sigsuspend		sys_sigsuspend			sys_sigsuspend
 73   common	sigpending		sys_sigpending			compat_sys_sigpending
-74   common	sethostname		sys_sethostname			compat_sys_sethostname
+74   common	sethostname		sys_sethostname			sys_sethostname
 75   common	setrlimit		sys_setrlimit			compat_sys_setrlimit
 76   32		getrlimit		-				compat_sys_old_getrlimit
 77   common	getrusage		sys_getrusage			compat_sys_getrusage
 78   common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
 79   common	settimeofday		sys_settimeofday		compat_sys_settimeofday
-80   32		getgroups		-				compat_sys_s390_getgroups16
-81   32		setgroups		-				compat_sys_s390_setgroups16
-83   common	symlink			sys_symlink			compat_sys_symlink
-85   common	readlink		sys_readlink			compat_sys_readlink
-86   common	uselib			sys_uselib			compat_sys_uselib
-87   common	swapon			sys_swapon			compat_sys_swapon
-88   common	reboot			sys_reboot			compat_sys_reboot
+80   32		getgroups		-				sys_getgroups16
+81   32		setgroups		-				sys_setgroups16
+83   common	symlink			sys_symlink			sys_symlink
+85   common	readlink		sys_readlink			sys_readlink
+86   common	uselib			sys_uselib			sys_uselib
+87   common	swapon			sys_swapon			sys_swapon
+88   common	reboot			sys_reboot			sys_reboot
 89   common	readdir			-				compat_sys_old_readdir
 90   common	mmap			sys_old_mmap			compat_sys_s390_old_mmap
-91   common	munmap			sys_munmap			compat_sys_munmap
+91   common	munmap			sys_munmap			sys_munmap
 92   common	truncate		sys_truncate			compat_sys_truncate
 93   common	ftruncate		sys_ftruncate			compat_sys_ftruncate
 94   common	fchmod			sys_fchmod			sys_fchmod
-95   32		fchown			-				compat_sys_s390_fchown16
+95   32		fchown			-				sys_fchown16
 96   common	getpriority		sys_getpriority			sys_getpriority
 97   common	setpriority		sys_setpriority			sys_setpriority
 99   common	statfs			sys_statfs			compat_sys_statfs
 100  common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101  32		ioperm			-				-
 102  common	socketcall		sys_socketcall			compat_sys_socketcall
-103  common	syslog			sys_syslog			compat_sys_syslog
+103  common	syslog			sys_syslog			sys_syslog
 104  common	setitimer		sys_setitimer			compat_sys_setitimer
 105  common	getitimer		sys_getitimer			compat_sys_getitimer
 106  common	stat			sys_newstat			compat_sys_newstat
@@ -104,76 +104,76 @@
 111  common	vhangup			sys_vhangup			sys_vhangup
 112  common	idle			-				-
 114  common	wait4			sys_wait4			compat_sys_wait4
-115  common	swapoff			sys_swapoff			compat_sys_swapoff
+115  common	swapoff			sys_swapoff			sys_swapoff
 116  common	sysinfo			sys_sysinfo			compat_sys_sysinfo
 117  common	ipc			sys_s390_ipc			compat_sys_s390_ipc
 118  common	fsync			sys_fsync			sys_fsync
 119  common	sigreturn		sys_sigreturn			compat_sys_sigreturn
-120  common	clone			sys_clone			compat_sys_clone
-121  common	setdomainname		sys_setdomainname		compat_sys_setdomainname
-122  common	uname			sys_newuname			compat_sys_newuname
-124  common	adjtimex		sys_adjtimex			compat_sys_adjtimex
-125  common	mprotect		sys_mprotect			compat_sys_mprotect
+120  common	clone			sys_clone			sys_clone
+121  common	setdomainname		sys_setdomainname		sys_setdomainname
+122  common	uname			sys_newuname			sys_newuname
+124  common	adjtimex		sys_adjtimex			sys_adjtimex_time32
+125  common	mprotect		sys_mprotect			sys_mprotect
 126  common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 127  common	create_module		-				-
-128  common	init_module		sys_init_module			compat_sys_init_module
-129  common	delete_module		sys_delete_module		compat_sys_delete_module
+128  common	init_module		sys_init_module			sys_init_module
+129  common	delete_module		sys_delete_module		sys_delete_module
 130  common	get_kernel_syms		-				-
-131  common	quotactl		sys_quotactl			compat_sys_quotactl
+131  common	quotactl		sys_quotactl			sys_quotactl
 132  common	getpgid			sys_getpgid			sys_getpgid
 133  common	fchdir			sys_fchdir			sys_fchdir
-134  common	bdflush			sys_bdflush			compat_sys_bdflush
-135  common	sysfs			sys_sysfs			compat_sys_sysfs
+134  common	bdflush			sys_bdflush			sys_bdflush
+135  common	sysfs			sys_sysfs			sys_sysfs
 136  common	personality		sys_s390_personality		sys_s390_personality
 137  common	afs_syscall		-				-
-138  32		setfsuid		-				compat_sys_s390_setfsuid16
-139  32		setfsgid		-				compat_sys_s390_setfsgid16
-140  32		_llseek			-				compat_sys_llseek
+138  32		setfsuid		-				sys_setfsuid16
+139  32		setfsgid		-				sys_setfsgid16
+140  32		_llseek			-				sys_llseek
 141  common	getdents		sys_getdents			compat_sys_getdents
 142  32		_newselect		-				compat_sys_select
 142  64		select			sys_select			-
 143  common	flock			sys_flock			sys_flock
-144  common	msync			sys_msync			compat_sys_msync
+144  common	msync			sys_msync			sys_msync
 145  common	readv			sys_readv			compat_sys_readv
 146  common	writev			sys_writev			compat_sys_writev
 147  common	getsid			sys_getsid			sys_getsid
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
 149  common	_sysctl			sys_sysctl			compat_sys_sysctl
-150  common	mlock			sys_mlock			compat_sys_mlock
-151  common	munlock			sys_munlock			compat_sys_munlock
+150  common	mlock			sys_mlock			sys_mlock
+151  common	munlock			sys_munlock			sys_munlock
 152  common	mlockall		sys_mlockall			sys_mlockall
 153  common	munlockall		sys_munlockall			sys_munlockall
-154  common	sched_setparam		sys_sched_setparam		compat_sys_sched_setparam
-155  common	sched_getparam		sys_sched_getparam		compat_sys_sched_getparam
-156  common	sched_setscheduler	sys_sched_setscheduler		compat_sys_sched_setscheduler
+154  common	sched_setparam		sys_sched_setparam		sys_sched_setparam
+155  common	sched_getparam		sys_sched_getparam		sys_sched_getparam
+156  common	sched_setscheduler	sys_sched_setscheduler		sys_sched_setscheduler
 157  common	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
 158  common	sched_yield		sys_sched_yield			sys_sched_yield
 159  common	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
 160  common	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
-161  common	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-162  common	nanosleep		sys_nanosleep			compat_sys_nanosleep
-163  common	mremap			sys_mremap			compat_sys_mremap
-164  32		setresuid		-				compat_sys_s390_setresuid16
-165  32		getresuid		-				compat_sys_s390_getresuid16
+161  common	sched_rr_get_interval	sys_sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162  common	nanosleep		sys_nanosleep			sys_nanosleep_time32
+163  common	mremap			sys_mremap			sys_mremap
+164  32		setresuid		-				sys_setresuid16
+165  32		getresuid		-				sys_getresuid16
 167  common	query_module		-				-
-168  common	poll			sys_poll			compat_sys_poll
+168  common	poll			sys_poll			sys_poll
 169  common	nfsservctl		-				-
-170  32		setresgid		-				compat_sys_s390_setresgid16
-171  32		getresgid		-				compat_sys_s390_getresgid16
-172  common	prctl			sys_prctl			compat_sys_prctl
+170  32		setresgid		-				sys_setresgid16
+171  32		getresgid		-				sys_getresgid16
+172  common	prctl			sys_prctl			sys_prctl
 173  common	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
 174  common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
 175  common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
 176  common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
-177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time32
 178  common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 180  common	pread64			sys_pread64			compat_sys_s390_pread64
 181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
-182  32		chown			-				compat_sys_s390_chown16
-183  common	getcwd			sys_getcwd			compat_sys_getcwd
-184  common	capget			sys_capget			compat_sys_capget
-185  common	capset			sys_capset			compat_sys_capset
+182  32		chown			-				sys_chown16
+183  common	getcwd			sys_getcwd			sys_getcwd
+184  common	capget			sys_capget			sys_capget
+185  common	capset			sys_capset			sys_capset
 186  common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
 187  common	sendfile		sys_sendfile64			compat_sys_sendfile
 188  common	getpmsg			-				-
@@ -187,7 +187,7 @@
 195  32		stat64			-				compat_sys_s390_stat64
 196  32		lstat64			-				compat_sys_s390_lstat64
 197  32		fstat64			-				compat_sys_s390_fstat64
-198  32		lchown32		-				compat_sys_lchown
+198  32		lchown32		-				sys_lchown
 198  64		lchown			sys_lchown			-
 199  32		getuid32		-				sys_getuid
 199  64		getuid			sys_getuid			-
@@ -201,21 +201,21 @@
 203  64		setreuid		sys_setreuid			-
 204  32		setregid32		-				sys_setregid
 204  64		setregid		sys_setregid			-
-205  32		getgroups32		-				compat_sys_getgroups
+205  32		getgroups32		-				sys_getgroups
 205  64		getgroups		sys_getgroups			-
-206  32		setgroups32		-				compat_sys_setgroups
+206  32		setgroups32		-				sys_setgroups
 206  64		setgroups		sys_setgroups			-
 207  32		fchown32		-				sys_fchown
 207  64		fchown			sys_fchown			-
 208  32		setresuid32		-				sys_setresuid
 208  64		setresuid		sys_setresuid			-
-209  32		getresuid32		-				compat_sys_getresuid
+209  32		getresuid32		-				sys_getresuid
 209  64		getresuid		sys_getresuid			-
 210  32		setresgid32		-				sys_setresgid
 210  64		setresgid		sys_setresgid			-
-211  32		getresgid32		-				compat_sys_getresgid
+211  32		getresgid32		-				sys_getresgid
 211  64		getresgid		sys_getresgid			-
-212  32		chown32			-				compat_sys_chown
+212  32		chown32			-				sys_chown
 212  64		chown			sys_chown			-
 213  32		setuid32		-				sys_setuid
 213  64		setuid			sys_setuid			-
@@ -225,169 +225,204 @@
 215  64		setfsuid		sys_setfsuid			-
 216  32		setfsgid32		-				sys_setfsgid
 216  64		setfsgid		sys_setfsgid			-
-217  common	pivot_root		sys_pivot_root			compat_sys_pivot_root
-218  common	mincore			sys_mincore			compat_sys_mincore
-219  common	madvise			sys_madvise			compat_sys_madvise
-220  common	getdents64		sys_getdents64			compat_sys_getdents64
+217  common	pivot_root		sys_pivot_root			sys_pivot_root
+218  common	mincore			sys_mincore			sys_mincore
+219  common	madvise			sys_madvise			sys_madvise
+220  common	getdents64		sys_getdents64			sys_getdents64
 221  32		fcntl64			-				compat_sys_fcntl64
 222  common	readahead		sys_readahead			compat_sys_s390_readahead
 223  32		sendfile64		-				compat_sys_sendfile64
-224  common	setxattr		sys_setxattr			compat_sys_setxattr
-225  common	lsetxattr		sys_lsetxattr			compat_sys_lsetxattr
-226  common	fsetxattr		sys_fsetxattr			compat_sys_fsetxattr
-227  common	getxattr		sys_getxattr			compat_sys_getxattr
-228  common	lgetxattr		sys_lgetxattr			compat_sys_lgetxattr
-229  common	fgetxattr		sys_fgetxattr			compat_sys_fgetxattr
-230  common	listxattr		sys_listxattr			compat_sys_listxattr
-231  common	llistxattr		sys_llistxattr			compat_sys_llistxattr
-232  common	flistxattr		sys_flistxattr			compat_sys_flistxattr
-233  common	removexattr		sys_removexattr			compat_sys_removexattr
-234  common	lremovexattr		sys_lremovexattr		compat_sys_lremovexattr
-235  common	fremovexattr		sys_fremovexattr		compat_sys_fremovexattr
+224  common	setxattr		sys_setxattr			sys_setxattr
+225  common	lsetxattr		sys_lsetxattr			sys_lsetxattr
+226  common	fsetxattr		sys_fsetxattr			sys_fsetxattr
+227  common	getxattr		sys_getxattr			sys_getxattr
+228  common	lgetxattr		sys_lgetxattr			sys_lgetxattr
+229  common	fgetxattr		sys_fgetxattr			sys_fgetxattr
+230  common	listxattr		sys_listxattr			sys_listxattr
+231  common	llistxattr		sys_llistxattr			sys_llistxattr
+232  common	flistxattr		sys_flistxattr			sys_flistxattr
+233  common	removexattr		sys_removexattr			sys_removexattr
+234  common	lremovexattr		sys_lremovexattr		sys_lremovexattr
+235  common	fremovexattr		sys_fremovexattr		sys_fremovexattr
 236  common	gettid			sys_gettid			sys_gettid
 237  common	tkill			sys_tkill			sys_tkill
-238  common	futex			sys_futex			compat_sys_futex
+238  common	futex			sys_futex			sys_futex_time32
 239  common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
 240  common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
 241  common	tgkill			sys_tgkill			sys_tgkill
 243  common	io_setup		sys_io_setup			compat_sys_io_setup
-244  common	io_destroy		sys_io_destroy			compat_sys_io_destroy
-245  common	io_getevents		sys_io_getevents		compat_sys_io_getevents
+244  common	io_destroy		sys_io_destroy			sys_io_destroy
+245  common	io_getevents		sys_io_getevents		sys_io_getevents_time32
 246  common	io_submit		sys_io_submit			compat_sys_io_submit
-247  common	io_cancel		sys_io_cancel			compat_sys_io_cancel
+247  common	io_cancel		sys_io_cancel			sys_io_cancel
 248  common	exit_group		sys_exit_group			sys_exit_group
 249  common	epoll_create		sys_epoll_create		sys_epoll_create
-250  common	epoll_ctl		sys_epoll_ctl			compat_sys_epoll_ctl
-251  common	epoll_wait		sys_epoll_wait			compat_sys_epoll_wait
-252  common	set_tid_address		sys_set_tid_address		compat_sys_set_tid_address
+250  common	epoll_ctl		sys_epoll_ctl			sys_epoll_ctl
+251  common	epoll_wait		sys_epoll_wait			sys_epoll_wait
+252  common	set_tid_address		sys_set_tid_address		sys_set_tid_address
 253  common	fadvise64		sys_fadvise64_64		compat_sys_s390_fadvise64
 254  common	timer_create		sys_timer_create		compat_sys_timer_create
-255  common	timer_settime		sys_timer_settime		compat_sys_timer_settime
-256  common	timer_gettime		sys_timer_gettime		compat_sys_timer_gettime
+255  common	timer_settime		sys_timer_settime		sys_timer_settime32
+256  common	timer_gettime		sys_timer_gettime		sys_timer_gettime32
 257  common	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
 258  common	timer_delete		sys_timer_delete		sys_timer_delete
-259  common	clock_settime		sys_clock_settime		compat_sys_clock_settime
-260  common	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
-261  common	clock_getres		sys_clock_getres		compat_sys_clock_getres
-262  common	clock_nanosleep		sys_clock_nanosleep		compat_sys_clock_nanosleep
+259  common	clock_settime		sys_clock_settime		sys_clock_settime32
+260  common	clock_gettime		sys_clock_gettime		sys_clock_gettime32
+261  common	clock_getres		sys_clock_getres		sys_clock_getres_time32
+262  common	clock_nanosleep		sys_clock_nanosleep		sys_clock_nanosleep_time32
 264  32		fadvise64_64		-				compat_sys_s390_fadvise64_64
 265  common	statfs64		sys_statfs64			compat_sys_statfs64
 266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-267  common	remap_file_pages	sys_remap_file_pages		compat_sys_remap_file_pages
+267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
 268  common	mbind			sys_mbind			compat_sys_mbind
 269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
 270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
 271  common	mq_open			sys_mq_open			compat_sys_mq_open
-272  common	mq_unlink		sys_mq_unlink			compat_sys_mq_unlink
-273  common	mq_timedsend		sys_mq_timedsend		compat_sys_mq_timedsend
-274  common	mq_timedreceive		sys_mq_timedreceive		compat_sys_mq_timedreceive
+272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
+273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
+274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
 275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
 276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
 277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-278  common	add_key			sys_add_key			compat_sys_add_key
-279  common	request_key		sys_request_key			compat_sys_request_key
+278  common	add_key			sys_add_key			sys_add_key
+279  common	request_key		sys_request_key			sys_request_key
 280  common	keyctl			sys_keyctl			compat_sys_keyctl
 281  common	waitid			sys_waitid			compat_sys_waitid
 282  common	ioprio_set		sys_ioprio_set			sys_ioprio_set
 283  common	ioprio_get		sys_ioprio_get			sys_ioprio_get
 284  common	inotify_init		sys_inotify_init		sys_inotify_init
-285  common	inotify_add_watch	sys_inotify_add_watch		compat_sys_inotify_add_watch
+285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
 286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
 287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
 288  common	openat			sys_openat			compat_sys_openat
-289  common	mkdirat			sys_mkdirat			compat_sys_mkdirat
-290  common	mknodat			sys_mknodat			compat_sys_mknodat
-291  common	fchownat		sys_fchownat			compat_sys_fchownat
-292  common	futimesat		sys_futimesat			compat_sys_futimesat
+289  common	mkdirat			sys_mkdirat			sys_mkdirat
+290  common	mknodat			sys_mknodat			sys_mknodat
+291  common	fchownat		sys_fchownat			sys_fchownat
+292  common	futimesat		sys_futimesat			sys_futimesat_time32
 293  32		fstatat64		-				compat_sys_s390_fstatat64
 293  64		newfstatat		sys_newfstatat			-
-294  common	unlinkat		sys_unlinkat			compat_sys_unlinkat
-295  common	renameat		sys_renameat			compat_sys_renameat
-296  common	linkat			sys_linkat			compat_sys_linkat
-297  common	symlinkat		sys_symlinkat			compat_sys_symlinkat
-298  common	readlinkat		sys_readlinkat			compat_sys_readlinkat
-299  common	fchmodat		sys_fchmodat			compat_sys_fchmodat
-300  common	faccessat		sys_faccessat			compat_sys_faccessat
-301  common	pselect6		sys_pselect6			compat_sys_pselect6
-302  common	ppoll			sys_ppoll			compat_sys_ppoll
-303  common	unshare			sys_unshare			compat_sys_unshare
+294  common	unlinkat		sys_unlinkat			sys_unlinkat
+295  common	renameat		sys_renameat			sys_renameat
+296  common	linkat			sys_linkat			sys_linkat
+297  common	symlinkat		sys_symlinkat			sys_symlinkat
+298  common	readlinkat		sys_readlinkat			sys_readlinkat
+299  common	fchmodat		sys_fchmodat			sys_fchmodat
+300  common	faccessat		sys_faccessat			sys_faccessat
+301  common	pselect6		sys_pselect6			compat_sys_pselect6_time32
+302  common	ppoll			sys_ppoll			compat_sys_ppoll_time32
+303  common	unshare			sys_unshare			sys_unshare
 304  common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 305  common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-306  common	splice			sys_splice			compat_sys_splice
+306  common	splice			sys_splice			sys_splice
 307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
-308  common	tee			sys_tee				compat_sys_tee
+308  common	tee			sys_tee				sys_tee
 309  common	vmsplice		sys_vmsplice			compat_sys_vmsplice
 310  common	move_pages		sys_move_pages			compat_sys_move_pages
-311  common	getcpu			sys_getcpu			compat_sys_getcpu
+311  common	getcpu			sys_getcpu			sys_getcpu
 312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
-313  common	utimes			sys_utimes			compat_sys_utimes
+313  common	utimes			sys_utimes			sys_utimes_time32
 314  common	fallocate		sys_fallocate			compat_sys_s390_fallocate
-315  common	utimensat		sys_utimensat			compat_sys_utimensat
+315  common	utimensat		sys_utimensat			sys_utimensat_time32
 316  common	signalfd		sys_signalfd			compat_sys_signalfd
 317  common	timerfd			-				-
 318  common	eventfd			sys_eventfd			sys_eventfd
 319  common	timerfd_create		sys_timerfd_create		sys_timerfd_create
-320  common	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
-321  common	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
+320  common	timerfd_settime		sys_timerfd_settime		sys_timerfd_settime32
+321  common	timerfd_gettime		sys_timerfd_gettime		sys_timerfd_gettime32
 322  common	signalfd4		sys_signalfd4			compat_sys_signalfd4
 323  common	eventfd2		sys_eventfd2			sys_eventfd2
 324  common	inotify_init1		sys_inotify_init1		sys_inotify_init1
-325  common	pipe2			sys_pipe2			compat_sys_pipe2
+325  common	pipe2			sys_pipe2			sys_pipe2
 326  common	dup3			sys_dup3			sys_dup3
 327  common	epoll_create1		sys_epoll_create1		sys_epoll_create1
 328  common	preadv			sys_preadv			compat_sys_preadv
 329  common	pwritev			sys_pwritev			compat_sys_pwritev
 330  common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-331  common	perf_event_open		sys_perf_event_open		compat_sys_perf_event_open
+331  common	perf_event_open		sys_perf_event_open		sys_perf_event_open
 332  common	fanotify_init		sys_fanotify_init		sys_fanotify_init
 333  common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
-334  common	prlimit64		sys_prlimit64			compat_sys_prlimit64
-335  common	name_to_handle_at	sys_name_to_handle_at		compat_sys_name_to_handle_at
+334  common	prlimit64		sys_prlimit64			sys_prlimit64
+335  common	name_to_handle_at	sys_name_to_handle_at		sys_name_to_handle_at
 336  common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-337  common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+337  common	clock_adjtime		sys_clock_adjtime		sys_clock_adjtime32
 338  common	syncfs			sys_syncfs			sys_syncfs
 339  common	setns			sys_setns			sys_setns
 340  common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
 341  common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
 342  common	s390_runtime_instr	sys_s390_runtime_instr		sys_s390_runtime_instr
-343  common	kcmp			sys_kcmp			compat_sys_kcmp
-344  common	finit_module		sys_finit_module		compat_sys_finit_module
-345  common	sched_setattr		sys_sched_setattr		compat_sys_sched_setattr
-346  common	sched_getattr		sys_sched_getattr		compat_sys_sched_getattr
-347  common	renameat2		sys_renameat2			compat_sys_renameat2
-348  common	seccomp			sys_seccomp			compat_sys_seccomp
-349  common	getrandom		sys_getrandom			compat_sys_getrandom
-350  common	memfd_create		sys_memfd_create		compat_sys_memfd_create
-351  common	bpf			sys_bpf				compat_sys_bpf
-352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		compat_sys_s390_pci_mmio_write
-353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		compat_sys_s390_pci_mmio_read
+343  common	kcmp			sys_kcmp			sys_kcmp
+344  common	finit_module		sys_finit_module		sys_finit_module
+345  common	sched_setattr		sys_sched_setattr		sys_sched_setattr
+346  common	sched_getattr		sys_sched_getattr		sys_sched_getattr
+347  common	renameat2		sys_renameat2			sys_renameat2
+348  common	seccomp			sys_seccomp			sys_seccomp
+349  common	getrandom		sys_getrandom			sys_getrandom
+350  common	memfd_create		sys_memfd_create		sys_memfd_create
+351  common	bpf			sys_bpf				sys_bpf
+352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		sys_s390_pci_mmio_write
+353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		sys_s390_pci_mmio_read
 354  common	execveat		sys_execveat			compat_sys_execveat
 355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
 356  common	membarrier		sys_membarrier			sys_membarrier
-357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
+357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg_time32
 358  common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
 359  common	socket			sys_socket			sys_socket
-360  common	socketpair		sys_socketpair			compat_sys_socketpair
-361  common	bind			sys_bind			compat_sys_bind
-362  common	connect			sys_connect			compat_sys_connect
+360  common	socketpair		sys_socketpair			sys_socketpair
+361  common	bind			sys_bind			sys_bind
+362  common	connect			sys_connect			sys_connect
 363  common	listen			sys_listen			sys_listen
-364  common	accept4			sys_accept4			compat_sys_accept4
+364  common	accept4			sys_accept4			sys_accept4
 365  common	getsockopt		sys_getsockopt			compat_sys_getsockopt
 366  common	setsockopt		sys_setsockopt			compat_sys_setsockopt
-367  common	getsockname		sys_getsockname			compat_sys_getsockname
-368  common	getpeername		sys_getpeername			compat_sys_getpeername
-369  common	sendto			sys_sendto			compat_sys_sendto
+367  common	getsockname		sys_getsockname			sys_getsockname
+368  common	getpeername		sys_getpeername			sys_getpeername
+369  common	sendto			sys_sendto			sys_sendto
 370  common	sendmsg			sys_sendmsg			compat_sys_sendmsg
 371  common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 372  common	recvmsg			sys_recvmsg			compat_sys_recvmsg
 373  common	shutdown		sys_shutdown			sys_shutdown
-374  common	mlock2			sys_mlock2			compat_sys_mlock2
-375  common	copy_file_range		sys_copy_file_range		compat_sys_copy_file_range
+374  common	mlock2			sys_mlock2			sys_mlock2
+375  common	copy_file_range		sys_copy_file_range		sys_copy_file_range
 376  common	preadv2			sys_preadv2			compat_sys_preadv2
 377  common	pwritev2		sys_pwritev2			compat_sys_pwritev2
-378  common	s390_guarded_storage	sys_s390_guarded_storage	compat_sys_s390_guarded_storage
-379  common	statx			sys_statx			compat_sys_statx
-380  common	s390_sthyi		sys_s390_sthyi			compat_sys_s390_sthyi
-381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
+378  common	s390_guarded_storage	sys_s390_guarded_storage	sys_s390_guarded_storage
+379  common	statx			sys_statx			sys_statx
+380  common	s390_sthyi		sys_s390_sthyi			sys_s390_sthyi
+381  common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
 382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
-383  common	rseq			sys_rseq			compat_sys_rseq
+383  common	rseq			sys_rseq			sys_rseq
+384  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
+385  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
+386  common	pkey_free		sys_pkey_free			sys_pkey_free
+# room for arch specific syscalls
+392	64	semtimedop		sys_semtimedop			-
+393  common	semget			sys_semget			sys_semget
+394  common	semctl			sys_semctl			compat_sys_semctl
+395  common	shmget			sys_shmget			sys_shmget
+396  common	shmctl			sys_shmctl			compat_sys_shmctl
+397  common	shmat			sys_shmat			compat_sys_shmat
+398  common	shmdt			sys_shmdt 			sys_shmdt
+399  common	msgget			sys_msgget			sys_msgget
+400  common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401  common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402  common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64		-				sys_clock_gettime
+404	32	clock_settime64		-				sys_clock_settime
+405	32	clock_adjtime64		-				sys_clock_adjtime
+406	32	clock_getres_time64	-				sys_clock_getres
+407	32	clock_nanosleep_time64	-				sys_clock_nanosleep
+408	32	timer_gettime64		-				sys_timer_gettime
+409	32	timer_settime64		-				sys_timer_settime
+410	32	timerfd_gettime64	-				sys_timerfd_gettime
+411	32	timerfd_settime64	-				sys_timerfd_settime
+412	32	utimensat_time64	-				sys_utimensat
+413	32	pselect6_time64		-				compat_sys_pselect6_time64
+414	32	ppoll_time64		-				compat_sys_ppoll_time64
+416	32	io_pgetevents_time64	-				sys_io_pgetevents
+417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64	-				sys_mq_timedsend
+419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
+420	32	semtimedop_time64	-				sys_semtimedop
+421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64		-				sys_futex
+423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a9c36f95744a..d9a9144dec35 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -62,6 +62,7 @@ config SUPERH
 
 config SUPERH32
 	def_bool "$(ARCH)" = "sh"
+	select ARCH_32BIT_OFF_T
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index a97f93ca3bd7..9c7d9d9999c6 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -16,8 +16,8 @@
 # define __ARCH_WANT_SYS_IPC
 # define __ARCH_WANT_SYS_PAUSE
 # define __ARCH_WANT_SYS_SIGNAL
-# define __ARCH_WANT_SYS_TIME
-# define __ARCH_WANT_SYS_UTIME
+# define __ARCH_WANT_SYS_TIME32
+# define __ARCH_WANT_SYS_UTIME32
 # define __ARCH_WANT_SYS_WAITPID
 # define __ARCH_WANT_SYS_SOCKETCALL
 # define __ARCH_WANT_SYS_FADVISE64
diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
deleted file mode 100644
index 31c85aa251ab..000000000000
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ /dev/null
@@ -1,403 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_SH_UNISTD_32_H
-#define __ASM_SH_UNISTD_32_H
-
-/*
- * Copyright (C) 1999  Niibe Yutaka
- */
-
-/*
- * This file contains the system call numbers.
- */
-
-#define __NR_restart_syscall	  0
-#define __NR_exit		  1
-#define __NR_fork		  2
-#define __NR_read		  3
-#define __NR_write		  4
-#define __NR_open		  5
-#define __NR_close		  6
-#define __NR_waitpid		  7
-#define __NR_creat		  8
-#define __NR_link		  9
-#define __NR_unlink		 10
-#define __NR_execve		 11
-#define __NR_chdir		 12
-#define __NR_time		 13
-#define __NR_mknod		 14
-#define __NR_chmod		 15
-#define __NR_lchown		 16
-				 /* 17 was sys_break */
-#define __NR_oldstat		 18
-#define __NR_lseek		 19
-#define __NR_getpid		 20
-#define __NR_mount		 21
-#define __NR_umount		 22
-#define __NR_setuid		 23
-#define __NR_getuid		 24
-#define __NR_stime		 25
-#define __NR_ptrace		 26
-#define __NR_alarm		 27
-#define __NR_oldfstat		 28
-#define __NR_pause		 29
-#define __NR_utime		 30
-				 /* 31 was sys_stty */
-				 /* 32 was sys_gtty */
-#define __NR_access		 33
-#define __NR_nice		 34
-				 /* 35 was sys_ftime */
-#define __NR_sync		 36
-#define __NR_kill		 37
-#define __NR_rename		 38
-#define __NR_mkdir		 39
-#define __NR_rmdir		 40
-#define __NR_dup		 41
-#define __NR_pipe		 42
-#define __NR_times		 43
-				 /* 44 was sys_prof */
-#define __NR_brk		 45
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_signal		 48
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
-#define __NR_acct		 51
-#define __NR_umount2		 52
-				 /* 53 was sys_lock */
-#define __NR_ioctl		 54
-#define __NR_fcntl		 55
-				 /* 56 was sys_mpx */
-#define __NR_setpgid		 57
-				 /* 58 was sys_ulimit */
-				 /* 59 was sys_olduname */
-#define __NR_umask		 60
-#define __NR_chroot		 61
-#define __NR_ustat		 62
-#define __NR_dup2		 63
-#define __NR_getppid		 64
-#define __NR_getpgrp		 65
-#define __NR_setsid		 66
-#define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_sigsuspend		 72
-#define __NR_sigpending		 73
-#define __NR_sethostname	 74
-#define __NR_setrlimit		 75
-#define __NR_getrlimit		 76	/* Back compatible 2Gig limited rlimit */
-#define __NR_getrusage		 77
-#define __NR_gettimeofday	 78
-#define __NR_settimeofday	 79
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-				 /* 82 was sys_oldselect */
-#define __NR_symlink		 83
-#define __NR_oldlstat		 84
-#define __NR_readlink		 85
-#define __NR_uselib		 86
-#define __NR_swapon		 87
-#define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
-#define __NR_munmap		 91
-#define __NR_truncate		 92
-#define __NR_ftruncate		 93
-#define __NR_fchmod		 94
-#define __NR_fchown		 95
-#define __NR_getpriority	 96
-#define __NR_setpriority	 97
-				 /* 98 was sys_profil */
-#define __NR_statfs		 99
-#define __NR_fstatfs		100
-				/* 101 was sys_ioperm */
-#define __NR_socketcall		102
-#define __NR_syslog		103
-#define __NR_setitimer		104
-#define __NR_getitimer		105
-#define __NR_stat		106
-#define __NR_lstat		107
-#define __NR_fstat		108
-#define __NR_olduname		109
-				/* 110 was sys_iopl */
-#define __NR_vhangup		111
-				/* 112 was sys_idle */
-				/* 113 was sys_vm86old */
-#define __NR_wait4		114
-#define __NR_swapoff		115
-#define __NR_sysinfo		116
-#define __NR_ipc		117
-#define __NR_fsync		118
-#define __NR_sigreturn		119
-#define __NR_clone		120
-#define __NR_setdomainname	121
-#define __NR_uname		122
-#define __NR_cacheflush		123
-#define __NR_adjtimex		124
-#define __NR_mprotect		125
-#define __NR_sigprocmask	126
-				/* 127 was sys_create_module */
-#define __NR_init_module	128
-#define __NR_delete_module	129
-				/* 130 was sys_get_kernel_syms */
-#define __NR_quotactl		131
-#define __NR_getpgid		132
-#define __NR_fchdir		133
-#define __NR_bdflush		134
-#define __NR_sysfs		135
-#define __NR_personality	136
-				/* 137 was sys_afs_syscall */
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
-#define __NR__llseek		140
-#define __NR_getdents		141
-#define __NR__newselect		142
-#define __NR_flock		143
-#define __NR_msync		144
-#define __NR_readv		145
-#define __NR_writev		146
-#define __NR_getsid		147
-#define __NR_fdatasync		148
-#define __NR__sysctl		149
-#define __NR_mlock		150
-#define __NR_munlock		151
-#define __NR_mlockall		152
-#define __NR_munlockall		153
-#define __NR_sched_setparam		154
-#define __NR_sched_getparam		155
-#define __NR_sched_setscheduler		156
-#define __NR_sched_getscheduler		157
-#define __NR_sched_yield		158
-#define __NR_sched_get_priority_max	159
-#define __NR_sched_get_priority_min	160
-#define __NR_sched_rr_get_interval	161
-#define __NR_nanosleep		162
-#define __NR_mremap		163
-#define __NR_setresuid		164
-#define __NR_getresuid		165
-				/* 166 was sys_vm86 */
-				/* 167 was sys_query_module */
-#define __NR_poll		168
-#define __NR_nfsservctl		169
-#define __NR_setresgid		170
-#define __NR_getresgid		171
-#define __NR_prctl              172
-#define __NR_rt_sigreturn	173
-#define __NR_rt_sigaction	174
-#define __NR_rt_sigprocmask	175
-#define __NR_rt_sigpending	176
-#define __NR_rt_sigtimedwait	177
-#define __NR_rt_sigqueueinfo	178
-#define __NR_rt_sigsuspend	179
-#define __NR_pread64		180
-#define __NR_pwrite64		181
-#define __NR_chown		182
-#define __NR_getcwd		183
-#define __NR_capget		184
-#define __NR_capset		185
-#define __NR_sigaltstack	186
-#define __NR_sendfile		187
-				/* 188 reserved for sys_getpmsg */
-				/* 189 reserved for sys_putpmsg */
-#define __NR_vfork		190
-#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#define __NR_lchown32		198
-#define __NR_getuid32		199
-#define __NR_getgid32		200
-#define __NR_geteuid32		201
-#define __NR_getegid32		202
-#define __NR_setreuid32		203
-#define __NR_setregid32		204
-#define __NR_getgroups32	205
-#define __NR_setgroups32	206
-#define __NR_fchown32		207
-#define __NR_setresuid32	208
-#define __NR_getresuid32	209
-#define __NR_setresgid32	210
-#define __NR_getresgid32	211
-#define __NR_chown32		212
-#define __NR_setuid32		213
-#define __NR_setgid32		214
-#define __NR_setfsuid32		215
-#define __NR_setfsgid32		216
-#define __NR_pivot_root		217
-#define __NR_mincore		218
-#define __NR_madvise		219
-#define __NR_getdents64		220
-#define __NR_fcntl64		221
-				/* 222 is reserved for tux */
-				/* 223 is unused */
-#define __NR_gettid		224
-#define __NR_readahead		225
-#define __NR_setxattr		226
-#define __NR_lsetxattr		227
-#define __NR_fsetxattr		228
-#define __NR_getxattr		229
-#define __NR_lgetxattr		230
-#define __NR_fgetxattr		231
-#define __NR_listxattr		232
-#define __NR_llistxattr		233
-#define __NR_flistxattr		234
-#define __NR_removexattr	235
-#define __NR_lremovexattr	236
-#define __NR_fremovexattr	237
-#define __NR_tkill		238
-#define __NR_sendfile64		239
-#define __NR_futex		240
-#define __NR_sched_setaffinity	241
-#define __NR_sched_getaffinity	242
-				/* 243 is reserved for set_thread_area */
-				/* 244 is reserved for get_thread_area */
-#define __NR_io_setup		245
-#define __NR_io_destroy		246
-#define __NR_io_getevents	247
-#define __NR_io_submit		248
-#define __NR_io_cancel		249
-#define __NR_fadvise64		250
-				/* 251 is unused */
-#define __NR_exit_group		252
-#define __NR_lookup_dcookie	253
-#define __NR_epoll_create	254
-#define __NR_epoll_ctl		255
-#define __NR_epoll_wait		256
-#define __NR_remap_file_pages	257
-#define __NR_set_tid_address	258
-#define __NR_timer_create	259
-#define __NR_timer_settime	(__NR_timer_create+1)
-#define __NR_timer_gettime	(__NR_timer_create+2)
-#define __NR_timer_getoverrun	(__NR_timer_create+3)
-#define __NR_timer_delete	(__NR_timer_create+4)
-#define __NR_clock_settime	(__NR_timer_create+5)
-#define __NR_clock_gettime	(__NR_timer_create+6)
-#define __NR_clock_getres	(__NR_timer_create+7)
-#define __NR_clock_nanosleep	(__NR_timer_create+8)
-#define __NR_statfs64		268
-#define __NR_fstatfs64		269
-#define __NR_tgkill		270
-#define __NR_utimes		271
-#define __NR_fadvise64_64	272
-				/* 273 is reserved for vserver */
-#define __NR_mbind              274
-#define __NR_get_mempolicy      275
-#define __NR_set_mempolicy      276
-#define __NR_mq_open            277
-#define __NR_mq_unlink          (__NR_mq_open+1)
-#define __NR_mq_timedsend       (__NR_mq_open+2)
-#define __NR_mq_timedreceive    (__NR_mq_open+3)
-#define __NR_mq_notify          (__NR_mq_open+4)
-#define __NR_mq_getsetattr      (__NR_mq_open+5)
-#define __NR_kexec_load		283
-#define __NR_waitid		284
-#define __NR_add_key		285
-#define __NR_request_key	286
-#define __NR_keyctl		287
-#define __NR_ioprio_set		288
-#define __NR_ioprio_get		289
-#define __NR_inotify_init	290
-#define __NR_inotify_add_watch	291
-#define __NR_inotify_rm_watch	292
-				/* 293 is unused */
-#define __NR_migrate_pages	294
-#define __NR_openat		295
-#define __NR_mkdirat		296
-#define __NR_mknodat		297
-#define __NR_fchownat		298
-#define __NR_futimesat		299
-#define __NR_fstatat64		300
-#define __NR_unlinkat		301
-#define __NR_renameat		302
-#define __NR_linkat		303
-#define __NR_symlinkat		304
-#define __NR_readlinkat		305
-#define __NR_fchmodat		306
-#define __NR_faccessat		307
-#define __NR_pselect6		308
-#define __NR_ppoll		309
-#define __NR_unshare		310
-#define __NR_set_robust_list	311
-#define __NR_get_robust_list	312
-#define __NR_splice		313
-#define __NR_sync_file_range	314
-#define __NR_tee		315
-#define __NR_vmsplice		316
-#define __NR_move_pages		317
-#define __NR_getcpu		318
-#define __NR_epoll_pwait	319
-#define __NR_utimensat		320
-#define __NR_signalfd		321
-#define __NR_timerfd_create	322
-#define __NR_eventfd		323
-#define __NR_fallocate		324
-#define __NR_timerfd_settime	325
-#define __NR_timerfd_gettime	326
-#define __NR_signalfd4		327
-#define __NR_eventfd2		328
-#define __NR_epoll_create1	329
-#define __NR_dup3		330
-#define __NR_pipe2		331
-#define __NR_inotify_init1	332
-#define __NR_preadv		333
-#define __NR_pwritev		334
-#define __NR_rt_tgsigqueueinfo	335
-#define __NR_perf_event_open	336
-#define __NR_fanotify_init	337
-#define __NR_fanotify_mark	338
-#define __NR_prlimit64		339
-
-/* Non-multiplexed socket family */
-#define __NR_socket		340
-#define __NR_bind		341
-#define __NR_connect		342
-#define __NR_listen		343
-#define __NR_accept		344
-#define __NR_getsockname	345
-#define __NR_getpeername	346
-#define __NR_socketpair		347
-#define __NR_send		348
-#define __NR_sendto		349
-#define __NR_recv		350
-#define __NR_recvfrom		351
-#define __NR_shutdown		352
-#define __NR_setsockopt		353
-#define __NR_getsockopt		354
-#define __NR_sendmsg		355
-#define __NR_recvmsg		356
-#define __NR_recvmmsg		357
-#define __NR_accept4		358
-#define __NR_name_to_handle_at	359
-#define __NR_open_by_handle_at	360
-#define __NR_clock_adjtime	361
-#define __NR_syncfs		362
-#define __NR_sendmmsg		363
-#define __NR_setns		364
-#define __NR_process_vm_readv	365
-#define __NR_process_vm_writev	366
-#define __NR_kcmp		367
-#define __NR_finit_module	368
-#define __NR_sched_getattr	369
-#define __NR_sched_setattr	370
-#define __NR_renameat2		371
-#define __NR_seccomp		372
-#define __NR_getrandom		373
-#define __NR_memfd_create	374
-#define __NR_bpf		375
-#define __NR_execveat		376
-#define __NR_userfaultfd	377
-#define __NR_membarrier		378
-#define __NR_mlock2		379
-#define __NR_copy_file_range	380
-#define __NR_preadv2		381
-#define __NR_pwritev2		382
-
-#ifdef __KERNEL__
-#define __NR_syscalls		383
-#endif
-
-#endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 21ec75288562..bfda678576e4 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -20,7 +20,7 @@
 10	common	unlink				sys_unlink
 11	common	execve				sys_execve
 12	common	chdir				sys_chdir
-13	common	time				sys_time
+13	common	time				sys_time32
 14	common	mknod				sys_mknod
 15	common	chmod				sys_chmod
 16	common	lchown				sys_lchown16
@@ -32,12 +32,12 @@
 22	common	umount				sys_oldumount
 23	common	setuid				sys_setuid16
 24	common	getuid				sys_getuid16
-25	common	stime				sys_stime
+25	common	stime				sys_stime32
 26	common	ptrace				sys_ptrace
 27	common	alarm				sys_alarm
 28	common	oldfstat			sys_fstat
 29	common	pause				sys_pause
-30	common	utime				sys_utime
+30	common	utime				sys_utime32
 # 31 was stty
 # 32 was gtty
 33	common	access				sys_access
@@ -131,7 +131,7 @@
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
 123	common	cacheflush			sys_cacheflush
-124	common	adjtimex			sys_adjtimex
+124	common	adjtimex			sys_adjtimex_time32
 125	common	mprotect			sys_mprotect
 126	common	sigprocmask			sys_sigprocmask
 # 127 was create_module
@@ -168,8 +168,8 @@
 158	common	sched_yield			sys_sched_yield
 159	common	sched_get_priority_max		sys_sched_get_priority_max
 160	common	sched_get_priority_min		sys_sched_get_priority_min
-161	common	sched_rr_get_interval		sys_sched_rr_get_interval
-162	common	nanosleep			sys_nanosleep
+161	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+162	common	nanosleep			sys_nanosleep_time32
 163	common	mremap				sys_mremap
 164	common	setresuid			sys_setresuid16
 165	common	getresuid			sys_getresuid16
@@ -184,7 +184,7 @@
 174	common	rt_sigaction			sys_rt_sigaction
 175	common	rt_sigprocmask			sys_rt_sigprocmask
 176	common	rt_sigpending			sys_rt_sigpending
-177	common	rt_sigtimedwait			sys_rt_sigtimedwait
+177	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
 178	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
 179	common	rt_sigsuspend			sys_rt_sigsuspend
 180	common	pread64				sys_pread_wrapper
@@ -247,14 +247,14 @@
 237	common	fremovexattr			sys_fremovexattr
 238	common	tkill				sys_tkill
 239	common	sendfile64			sys_sendfile64
-240	common	futex				sys_futex
+240	common	futex				sys_futex_time32
 241	common	sched_setaffinity		sys_sched_setaffinity
 242	common	sched_getaffinity		sys_sched_getaffinity
 # 243 is reserved for set_thread_area
 # 244 is reserved for get_thread_area
 245	common	io_setup			sys_io_setup
 246	common	io_destroy			sys_io_destroy
-247	common	io_getevents			sys_io_getevents
+247	common	io_getevents			sys_io_getevents_time32
 248	common	io_submit			sys_io_submit
 249	common	io_cancel			sys_io_cancel
 250	common	fadvise64			sys_fadvise64
@@ -267,18 +267,18 @@
 257	common	remap_file_pages		sys_remap_file_pages
 258	common	set_tid_address			sys_set_tid_address
 259	common	timer_create			sys_timer_create
-260	common	timer_settime			sys_timer_settime
-261	common	timer_gettime			sys_timer_gettime
+260	common	timer_settime			sys_timer_settime32
+261	common	timer_gettime			sys_timer_gettime32
 262	common	timer_getoverrun		sys_timer_getoverrun
 263	common	timer_delete			sys_timer_delete
-264	common	clock_settime			sys_clock_settime
-265	common	clock_gettime			sys_clock_gettime
-266	common	clock_getres			sys_clock_getres
-267	common	clock_nanosleep			sys_clock_nanosleep
+264	common	clock_settime			sys_clock_settime32
+265	common	clock_gettime			sys_clock_gettime32
+266	common	clock_getres			sys_clock_getres_time32
+267	common	clock_nanosleep			sys_clock_nanosleep_time32
 268	common	statfs64			sys_statfs64
 269	common	fstatfs64			sys_fstatfs64
 270	common	tgkill				sys_tgkill
-271	common	utimes				sys_utimes
+271	common	utimes				sys_utimes_time32
 272	common	fadvise64_64			sys_fadvise64_64_wrapper
 # 273 is reserved for vserver
 274	common	mbind				sys_mbind
@@ -286,8 +286,8 @@
 276	common	set_mempolicy			sys_set_mempolicy
 277	common	mq_open				sys_mq_open
 278	common	mq_unlink			sys_mq_unlink
-279	common	mq_timedsend			sys_mq_timedsend
-280	common	mq_timedreceive			sys_mq_timedreceive
+279	common	mq_timedsend			sys_mq_timedsend_time32
+280	common	mq_timedreceive			sys_mq_timedreceive_time32
 281	common	mq_notify			sys_mq_notify
 282	common	mq_getsetattr			sys_mq_getsetattr
 283	common	kexec_load			sys_kexec_load
@@ -306,7 +306,7 @@
 296	common	mkdirat				sys_mkdirat
 297	common	mknodat				sys_mknodat
 298	common	fchownat			sys_fchownat
-299	common	futimesat			sys_futimesat
+299	common	futimesat			sys_futimesat_time32
 300	common	fstatat64			sys_fstatat64
 301	common	unlinkat			sys_unlinkat
 302	common	renameat			sys_renameat
@@ -315,8 +315,8 @@
 305	common	readlinkat			sys_readlinkat
 306	common	fchmodat			sys_fchmodat
 307	common	faccessat			sys_faccessat
-308	common	pselect6			sys_pselect6
-309	common	ppoll				sys_ppoll
+308	common	pselect6			sys_pselect6_time32
+309	common	ppoll				sys_ppoll_time32
 310	common	unshare				sys_unshare
 311	common	set_robust_list			sys_set_robust_list
 312	common	get_robust_list			sys_get_robust_list
@@ -327,13 +327,13 @@
 317	common	move_pages			sys_move_pages
 318	common	getcpu				sys_getcpu
 319	common	epoll_pwait			sys_epoll_pwait
-320	common	utimensat			sys_utimensat
+320	common	utimensat			sys_utimensat_time32
 321	common	signalfd			sys_signalfd
 322	common	timerfd_create			sys_timerfd_create
 323	common	eventfd				sys_eventfd
 324	common	fallocate			sys_fallocate
-325	common	timerfd_settime			sys_timerfd_settime
-326	common	timerfd_gettime			sys_timerfd_gettime
+325	common	timerfd_settime			sys_timerfd_settime32
+326	common	timerfd_gettime			sys_timerfd_gettime32
 327	common	signalfd4			sys_signalfd4
 328	common	eventfd2			sys_eventfd2
 329	common	epoll_create1			sys_epoll_create1
@@ -364,11 +364,11 @@
 354	common	getsockopt			sys_getsockopt
 355	common	sendmsg				sys_sendmsg
 356	common	recvmsg				sys_recvmsg
-357	common	recvmmsg			sys_recvmmsg
+357	common	recvmmsg			sys_recvmmsg_time32
 358	common	accept4				sys_accept4
 359	common	name_to_handle_at		sys_name_to_handle_at
 360	common	open_by_handle_at		sys_open_by_handle_at
-361	common	clock_adjtime			sys_clock_adjtime
+361	common	clock_adjtime			sys_clock_adjtime32
 362	common	syncfs				sys_syncfs
 363	common	sendmmsg			sys_sendmmsg
 364	common	setns				sys_setns
@@ -390,3 +390,39 @@
 380	common	copy_file_range			sys_copy_file_range
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
+383	common	statx				sys_statx
+384	common	pkey_mprotect			sys_pkey_mprotect
+385	common	pkey_alloc			sys_pkey_alloc
+386	common	pkey_free			sys_pkey_free
+387	common	rseq				sys_rseq
+# room for arch specific syscalls
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl
+397	common	shmat				sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd
+401	common	msgrcv				sys_msgrcv
+402	common	msgctl				sys_msgctl
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index d5dd652fb8cc..40f8f4f73fe8 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -49,6 +49,7 @@ config SPARC
 
 config SPARC32
 	def_bool !64BIT
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 5194d86ef72d..1e66278ba4a5 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -30,8 +30,8 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_SIGNAL
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_TIME32
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
@@ -43,8 +43,8 @@
 #ifdef __32bit_syscall_numbers__
 #define __ARCH_WANT_SYS_IPC
 #else
-#define __ARCH_WANT_COMPAT_SYS_TIME
-#define __ARCH_WANT_SYS_UTIME32
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
@@ -59,9 +59,4 @@
 #define __IGNORE_getresgid
 #endif
 
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 274ed0b9b3e0..9825ca6a6020 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -28,8 +28,9 @@
 #include <linux/random.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
-
+#include <linux/timex.h>
 #include <linux/uaccess.h>
+
 #include <asm/utrap.h>
 #include <asm/unistd.h>
 
@@ -344,7 +345,7 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 			goto out;
 		case SEMTIMEDOP:
 			err = sys_semtimedop(first, ptr, (unsigned int)second,
-				(const struct timespec __user *)
+				(const struct __kernel_timespec __user *)
 					     (unsigned long) fifth);
 			goto out;
 		case SEMGET:
@@ -544,6 +545,62 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 	return err;
 }
 
+SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
+{
+	struct timex txc;		/* Local copy of parameter */
+	struct __kernel_timex *kt = (void *)&txc;
+	int ret;
+
+	/* Copy the user data space into the kernel copy
+	 * structure. But bear in mind that the structures
+	 * may change
+	 */
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+		return -EFAULT;
+
+	/*
+	 * override for sparc64 specific timeval type: tv_usec
+	 * is 32 bit wide instead of 64-bit in __kernel_timex
+	 */
+	kt->time.tv_usec = txc.time.tv_usec;
+	ret = do_adjtimex(kt);
+	txc.time.tv_usec = kt->time.tv_usec;
+
+	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+}
+
+SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex __user *, txc_p)
+{
+	struct timex txc;		/* Local copy of parameter */
+	struct __kernel_timex *kt = (void *)&txc;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		pr_err_once("process %d (%s) attempted a POSIX timer syscall "
+		    "while CONFIG_POSIX_TIMERS is not set\n",
+		    current->pid, current->comm);
+
+		return -ENOSYS;
+	}
+
+	/* Copy the user data space into the kernel copy
+	 * structure. But bear in mind that the structures
+	 * may change
+	 */
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+		return -EFAULT;
+
+	/*
+	 * override for sparc64 specific timeval type: tv_usec
+	 * is 32 bit wide instead of 64-bit in __kernel_timex
+	 */
+	kt->time.tv_usec = txc.time.tv_usec;
+	ret = do_clock_adjtime(which_clock, kt);
+	txc.time.tv_usec = kt->time.tv_usec;
+
+	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+}
+
 SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
 		utrap_handler_t, new_p, utrap_handler_t, new_d,
 		utrap_handler_t __user *, old_p,
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c8c77c05ea97..b9a5a04b2d2c 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -44,7 +44,8 @@
 28	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
 29	32    	pause			sys_pause
 29	64    	pause			sys_nis_syscall
-30	common	utime			sys_utime			compat_sys_utime
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
 31	32    	lchown32		sys_lchown
 32	32    	fchown32		sys_fchown
 33	common	access			sys_access
@@ -128,7 +129,8 @@
 102	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
 103	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
 104	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
-105	common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+105	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+105	64	rt_sigtimedwait		sys_rt_sigtimedwait
 106	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 107	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 108	32	setresuid32		sys_setresuid
@@ -168,11 +170,13 @@
 135	common	socketpair		sys_socketpair
 136	common	mkdir			sys_mkdir
 137	common	rmdir			sys_rmdir
-138	common	utimes			sys_utimes			compat_sys_utimes
+138	32	utimes			sys_utimes_time32
+138	64	utimes			sys_utimes
 139	common	stat64			sys_stat64			compat_sys_stat64
 140	common	sendfile64		sys_sendfile64
 141	common	getpeername		sys_getpeername
-142	common	futex			sys_futex			compat_sys_futex
+142	32	futex			sys_futex_time32
+142	64	futex			sys_futex
 143	common	gettid			sys_gettid
 144	common	getrlimit		sys_getrlimit			compat_sys_getrlimit
 145	common	setrlimit		sys_setrlimit			compat_sys_setrlimit
@@ -258,7 +262,8 @@
 216	64	sigreturn		sys_nis_syscall
 217	common	clone			sys_clone
 218	common	ioprio_get		sys_ioprio_get
-219	common	adjtimex		sys_adjtimex			compat_sys_adjtimex
+219	32	adjtimex		sys_adjtimex_time32
+219	64	adjtimex		sys_sparc_adjtimex
 220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 220	64	sigprocmask		sys_nis_syscall
 221	common	create_module		sys_ni_syscall
@@ -271,9 +276,10 @@
 228	common	setfsuid		sys_setfsuid16
 229	common	setfsgid		sys_setfsgid16
 230	common	_newselect		sys_select			compat_sys_select
-231	32	time			sys_time			compat_sys_time
+231	32	time			sys_time32
 232	common	splice			sys_splice
-233	common	stime			sys_stime			compat_sys_stime
+233	32	stime			sys_stime32
+233	64	stime			sys_stime
 234	common	statfs64		sys_statfs64			compat_sys_statfs64
 235	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
 236	common	_llseek			sys_llseek
@@ -288,8 +294,10 @@
 245	common	sched_yield		sys_sched_yield
 246	common	sched_get_priority_max	sys_sched_get_priority_max
 247	common	sched_get_priority_min	sys_sched_get_priority_min
-248	common	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-249	common	nanosleep		sys_nanosleep			compat_sys_nanosleep
+248	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+248	64	sched_rr_get_interval	sys_sched_rr_get_interval
+249	32	nanosleep		sys_nanosleep_time32
+249	64	nanosleep		sys_nanosleep
 250	32	mremap			sys_mremap
 250	64	mremap			sys_64_mremap
 251	common	_sysctl			sys_sysctl			compat_sys_sysctl
@@ -298,14 +306,20 @@
 254	32	nfsservctl		sys_ni_syscall			sys_nis_syscall
 254	64	nfsservctl		sys_nis_syscall
 255	common	sync_file_range		sys_sync_file_range		compat_sys_sync_file_range
-256	common	clock_settime		sys_clock_settime		compat_sys_clock_settime
-257	common	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
-258	common	clock_getres		sys_clock_getres		compat_sys_clock_getres
-259	common	clock_nanosleep		sys_clock_nanosleep		compat_sys_clock_nanosleep
+256	32	clock_settime		sys_clock_settime32
+256	64	clock_settime		sys_clock_settime
+257	32	clock_gettime		sys_clock_gettime32
+257	64	clock_gettime		sys_clock_gettime
+258	32	clock_getres		sys_clock_getres_time32
+258	64	clock_getres		sys_clock_getres
+259	32	clock_nanosleep		sys_clock_nanosleep_time32
+259	64	clock_nanosleep		sys_clock_nanosleep
 260	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
 261	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
-262	common	timer_settime		sys_timer_settime		compat_sys_timer_settime
-263	common	timer_gettime		sys_timer_gettime		compat_sys_timer_gettime
+262	32	timer_settime		sys_timer_settime32
+262	64	timer_settime		sys_timer_settime
+263	32	timer_gettime		sys_timer_gettime32
+263	64	timer_gettime		sys_timer_gettime
 264	common	timer_getoverrun	sys_timer_getoverrun
 265	common	timer_delete		sys_timer_delete
 266	common	timer_create		sys_timer_create		compat_sys_timer_create
@@ -315,11 +329,14 @@
 269	common	io_destroy		sys_io_destroy
 270	common	io_submit		sys_io_submit			compat_sys_io_submit
 271	common	io_cancel		sys_io_cancel
-272	common	io_getevents		sys_io_getevents		compat_sys_io_getevents
+272	32	io_getevents		sys_io_getevents_time32
+272	64	io_getevents		sys_io_getevents
 273	common	mq_open			sys_mq_open			compat_sys_mq_open
 274	common	mq_unlink		sys_mq_unlink
-275	common	mq_timedsend		sys_mq_timedsend		compat_sys_mq_timedsend
-276	common	mq_timedreceive		sys_mq_timedreceive		compat_sys_mq_timedreceive
+275	32	mq_timedsend		sys_mq_timedsend_time32
+275	64	mq_timedsend		sys_mq_timedsend
+276	32	mq_timedreceive		sys_mq_timedreceive_time32
+276	64	mq_timedreceive		sys_mq_timedreceive
 277	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
 278	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
 279	common	waitid			sys_waitid			compat_sys_waitid
@@ -331,7 +348,8 @@
 285	common	mkdirat			sys_mkdirat
 286	common	mknodat			sys_mknodat
 287	common	fchownat		sys_fchownat
-288	common	futimesat		sys_futimesat			compat_sys_futimesat
+288	32	futimesat		sys_futimesat_time32
+288	64	futimesat		sys_futimesat
 289	common	fstatat64		sys_fstatat64			compat_sys_fstatat64
 290	common	unlinkat		sys_unlinkat
 291	common	renameat		sys_renameat
@@ -340,8 +358,10 @@
 294	common	readlinkat		sys_readlinkat
 295	common	fchmodat		sys_fchmodat
 296	common	faccessat		sys_faccessat
-297	common	pselect6		sys_pselect6			compat_sys_pselect6
-298	common	ppoll			sys_ppoll			compat_sys_ppoll
+297	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+297	64	pselect6		sys_pselect6
+298	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+298	64	ppoll			sys_ppoll
 299	common	unshare			sys_unshare
 300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
@@ -353,13 +373,16 @@
 307	common	move_pages		sys_move_pages			compat_sys_move_pages
 308	common	getcpu			sys_getcpu
 309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
-310	common	utimensat		sys_utimensat			compat_sys_utimensat
+310	32	utimensat		sys_utimensat_time32
+310	64	utimensat		sys_utimensat
 311	common	signalfd		sys_signalfd			compat_sys_signalfd
 312	common	timerfd_create		sys_timerfd_create
 313	common	eventfd			sys_eventfd
 314	common	fallocate		sys_fallocate			compat_sys_fallocate
-315	common	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
-316	common	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
+315	32	timerfd_settime		sys_timerfd_settime32
+315	64	timerfd_settime		sys_timerfd_settime
+316	32	timerfd_gettime		sys_timerfd_gettime32
+316	64	timerfd_gettime		sys_timerfd_gettime
 317	common	signalfd4		sys_signalfd4			compat_sys_signalfd4
 318	common	eventfd2		sys_eventfd2
 319	common	epoll_create1		sys_epoll_create1
@@ -371,13 +394,15 @@
 325	common	pwritev			sys_pwritev			compat_sys_pwritev
 326	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
 327	common	perf_event_open		sys_perf_event_open
-328	common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
+328	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+328	64	recvmmsg		sys_recvmmsg
 329	common	fanotify_init		sys_fanotify_init
 330	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
 331	common	prlimit64		sys_prlimit64
 332	common	name_to_handle_at	sys_name_to_handle_at
 333	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-334	common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+334	32	clock_adjtime		sys_clock_adjtime32
+334	64	clock_adjtime		sys_sparc_clock_adjtime
 335	common	syncfs			sys_syncfs
 336	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
 337	common	setns			sys_setns
@@ -406,4 +431,41 @@
 358	common	preadv2			sys_preadv2			compat_sys_preadv2
 359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 360	common	statx			sys_statx
-361	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+361	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+361	64	io_pgetevents		sys_io_pgetevents
+362	common	pkey_mprotect		sys_pkey_mprotect
+363	common	pkey_alloc		sys_pkey_alloc
+364	common	pkey_free		sys_pkey_free
+365	common	rseq			sys_rseq
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget			sys_semget
+394	common	semctl			sys_semctl			compat_sys_semctl
+395	common	shmget			sys_shmget
+396	common	shmctl			sys_shmctl			compat_sys_shmctl
+397	common	shmat			sys_shmat			compat_sys_shmat
+398	common	shmdt			sys_shmdt
+399	common	msgget			sys_msgget
+400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c3a41bfe161b..a7f1ae58d211 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config UNICORE32
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 1e8fe5941b8a..54a7378a70b1 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -12,8 +12,10 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
-#define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..13c988009b2d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -47,6 +47,7 @@ config X86
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
+	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d1..955ab6a3b61f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -24,7 +24,7 @@
 10	i386	unlink			sys_unlink			__ia32_sys_unlink
 11	i386	execve			sys_execve			__ia32_compat_sys_execve
 12	i386	chdir			sys_chdir			__ia32_sys_chdir
-13	i386	time			sys_time			__ia32_compat_sys_time
+13	i386	time			sys_time32			__ia32_sys_time32
 14	i386	mknod			sys_mknod			__ia32_sys_mknod
 15	i386	chmod			sys_chmod			__ia32_sys_chmod
 16	i386	lchown			sys_lchown16			__ia32_sys_lchown16
@@ -36,12 +36,12 @@
 22	i386	umount			sys_oldumount			__ia32_sys_oldumount
 23	i386	setuid			sys_setuid16			__ia32_sys_setuid16
 24	i386	getuid			sys_getuid16			__ia32_sys_getuid16
-25	i386	stime			sys_stime			__ia32_compat_sys_stime
+25	i386	stime			sys_stime32			__ia32_sys_stime32
 26	i386	ptrace			sys_ptrace			__ia32_compat_sys_ptrace
 27	i386	alarm			sys_alarm			__ia32_sys_alarm
 28	i386	oldfstat		sys_fstat			__ia32_sys_fstat
 29	i386	pause			sys_pause			__ia32_sys_pause
-30	i386	utime			sys_utime			__ia32_compat_sys_utime
+30	i386	utime			sys_utime32			__ia32_sys_utime32
 31	i386	stty
 32	i386	gtty
 33	i386	access			sys_access			__ia32_sys_access
@@ -135,7 +135,7 @@
 121	i386	setdomainname		sys_setdomainname		__ia32_sys_setdomainname
 122	i386	uname			sys_newuname			__ia32_sys_newuname
 123	i386	modify_ldt		sys_modify_ldt			__ia32_sys_modify_ldt
-124	i386	adjtimex		sys_adjtimex			__ia32_compat_sys_adjtimex
+124	i386	adjtimex		sys_adjtimex_time32			__ia32_sys_adjtimex_time32
 125	i386	mprotect		sys_mprotect			__ia32_sys_mprotect
 126	i386	sigprocmask		sys_sigprocmask			__ia32_compat_sys_sigprocmask
 127	i386	create_module
@@ -172,8 +172,8 @@
 158	i386	sched_yield		sys_sched_yield			__ia32_sys_sched_yield
 159	i386	sched_get_priority_max	sys_sched_get_priority_max	__ia32_sys_sched_get_priority_max
 160	i386	sched_get_priority_min	sys_sched_get_priority_min	__ia32_sys_sched_get_priority_min
-161	i386	sched_rr_get_interval	sys_sched_rr_get_interval	__ia32_compat_sys_sched_rr_get_interval
-162	i386	nanosleep		sys_nanosleep			__ia32_compat_sys_nanosleep
+161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32	__ia32_sys_sched_rr_get_interval_time32
+162	i386	nanosleep		sys_nanosleep_time32		__ia32_sys_nanosleep_time32
 163	i386	mremap			sys_mremap			__ia32_sys_mremap
 164	i386	setresuid		sys_setresuid16			__ia32_sys_setresuid16
 165	i386	getresuid		sys_getresuid16			__ia32_sys_getresuid16
@@ -188,7 +188,7 @@
 174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
 175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_sys_rt_sigprocmask
 176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
-177	i386	rt_sigtimedwait		sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait
+177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
 179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_sys_rt_sigsuspend
 180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
@@ -251,14 +251,14 @@
 237	i386	fremovexattr		sys_fremovexattr		__ia32_sys_fremovexattr
 238	i386	tkill			sys_tkill			__ia32_sys_tkill
 239	i386	sendfile64		sys_sendfile64			__ia32_sys_sendfile64
-240	i386	futex			sys_futex			__ia32_compat_sys_futex
+240	i386	futex			sys_futex_time32		__ia32_sys_futex_time32
 241	i386	sched_setaffinity	sys_sched_setaffinity		__ia32_compat_sys_sched_setaffinity
 242	i386	sched_getaffinity	sys_sched_getaffinity		__ia32_compat_sys_sched_getaffinity
 243	i386	set_thread_area		sys_set_thread_area		__ia32_sys_set_thread_area
 244	i386	get_thread_area		sys_get_thread_area		__ia32_sys_get_thread_area
 245	i386	io_setup		sys_io_setup			__ia32_compat_sys_io_setup
 246	i386	io_destroy		sys_io_destroy			__ia32_sys_io_destroy
-247	i386	io_getevents		sys_io_getevents		__ia32_compat_sys_io_getevents
+247	i386	io_getevents		sys_io_getevents_time32		__ia32_sys_io_getevents_time32
 248	i386	io_submit		sys_io_submit			__ia32_compat_sys_io_submit
 249	i386	io_cancel		sys_io_cancel			__ia32_sys_io_cancel
 250	i386	fadvise64		sys_fadvise64			__ia32_compat_sys_x86_fadvise64
@@ -271,18 +271,18 @@
 257	i386	remap_file_pages	sys_remap_file_pages		__ia32_sys_remap_file_pages
 258	i386	set_tid_address		sys_set_tid_address		__ia32_sys_set_tid_address
 259	i386	timer_create		sys_timer_create		__ia32_compat_sys_timer_create
-260	i386	timer_settime		sys_timer_settime		__ia32_compat_sys_timer_settime
-261	i386	timer_gettime		sys_timer_gettime		__ia32_compat_sys_timer_gettime
+260	i386	timer_settime		sys_timer_settime32		__ia32_sys_timer_settime32
+261	i386	timer_gettime		sys_timer_gettime32		__ia32_sys_timer_gettime32
 262	i386	timer_getoverrun	sys_timer_getoverrun		__ia32_sys_timer_getoverrun
 263	i386	timer_delete		sys_timer_delete		__ia32_sys_timer_delete
-264	i386	clock_settime		sys_clock_settime		__ia32_compat_sys_clock_settime
-265	i386	clock_gettime		sys_clock_gettime		__ia32_compat_sys_clock_gettime
-266	i386	clock_getres		sys_clock_getres		__ia32_compat_sys_clock_getres
-267	i386	clock_nanosleep		sys_clock_nanosleep		__ia32_compat_sys_clock_nanosleep
+264	i386	clock_settime		sys_clock_settime32		__ia32_sys_clock_settime32
+265	i386	clock_gettime		sys_clock_gettime32		__ia32_sys_clock_gettime32
+266	i386	clock_getres		sys_clock_getres_time32		__ia32_sys_clock_getres_time32
+267	i386	clock_nanosleep		sys_clock_nanosleep_time32	__ia32_sys_clock_nanosleep_time32
 268	i386	statfs64		sys_statfs64			__ia32_compat_sys_statfs64
 269	i386	fstatfs64		sys_fstatfs64			__ia32_compat_sys_fstatfs64
 270	i386	tgkill			sys_tgkill			__ia32_sys_tgkill
-271	i386	utimes			sys_utimes			__ia32_compat_sys_utimes
+271	i386	utimes			sys_utimes_time32		__ia32_sys_utimes_time32
 272	i386	fadvise64_64		sys_fadvise64_64		__ia32_compat_sys_x86_fadvise64_64
 273	i386	vserver
 274	i386	mbind			sys_mbind			__ia32_sys_mbind
@@ -290,8 +290,8 @@
 276	i386	set_mempolicy		sys_set_mempolicy		__ia32_sys_set_mempolicy
 277	i386	mq_open			sys_mq_open			__ia32_compat_sys_mq_open
 278	i386	mq_unlink		sys_mq_unlink			__ia32_sys_mq_unlink
-279	i386	mq_timedsend		sys_mq_timedsend		__ia32_compat_sys_mq_timedsend
-280	i386	mq_timedreceive		sys_mq_timedreceive		__ia32_compat_sys_mq_timedreceive
+279	i386	mq_timedsend		sys_mq_timedsend_time32		__ia32_sys_mq_timedsend_time32
+280	i386	mq_timedreceive		sys_mq_timedreceive_time32	__ia32_sys_mq_timedreceive_time32
 281	i386	mq_notify		sys_mq_notify			__ia32_compat_sys_mq_notify
 282	i386	mq_getsetattr		sys_mq_getsetattr		__ia32_compat_sys_mq_getsetattr
 283	i386	kexec_load		sys_kexec_load			__ia32_compat_sys_kexec_load
@@ -310,7 +310,7 @@
 296	i386	mkdirat			sys_mkdirat			__ia32_sys_mkdirat
 297	i386	mknodat			sys_mknodat			__ia32_sys_mknodat
 298	i386	fchownat		sys_fchownat			__ia32_sys_fchownat
-299	i386	futimesat		sys_futimesat			__ia32_compat_sys_futimesat
+299	i386	futimesat		sys_futimesat_time32		__ia32_sys_futimesat_time32
 300	i386	fstatat64		sys_fstatat64			__ia32_compat_sys_x86_fstatat
 301	i386	unlinkat		sys_unlinkat			__ia32_sys_unlinkat
 302	i386	renameat		sys_renameat			__ia32_sys_renameat
@@ -319,8 +319,8 @@
 305	i386	readlinkat		sys_readlinkat			__ia32_sys_readlinkat
 306	i386	fchmodat		sys_fchmodat			__ia32_sys_fchmodat
 307	i386	faccessat		sys_faccessat			__ia32_sys_faccessat
-308	i386	pselect6		sys_pselect6			__ia32_compat_sys_pselect6
-309	i386	ppoll			sys_ppoll			__ia32_compat_sys_ppoll
+308	i386	pselect6		sys_pselect6_time32		__ia32_compat_sys_pselect6_time32
+309	i386	ppoll			sys_ppoll_time32		__ia32_compat_sys_ppoll_time32
 310	i386	unshare			sys_unshare			__ia32_sys_unshare
 311	i386	set_robust_list		sys_set_robust_list		__ia32_compat_sys_set_robust_list
 312	i386	get_robust_list		sys_get_robust_list		__ia32_compat_sys_get_robust_list
@@ -331,13 +331,13 @@
 317	i386	move_pages		sys_move_pages			__ia32_compat_sys_move_pages
 318	i386	getcpu			sys_getcpu			__ia32_sys_getcpu
 319	i386	epoll_pwait		sys_epoll_pwait			__ia32_sys_epoll_pwait
-320	i386	utimensat		sys_utimensat			__ia32_compat_sys_utimensat
+320	i386	utimensat		sys_utimensat_time32		__ia32_sys_utimensat_time32
 321	i386	signalfd		sys_signalfd			__ia32_compat_sys_signalfd
 322	i386	timerfd_create		sys_timerfd_create		__ia32_sys_timerfd_create
 323	i386	eventfd			sys_eventfd			__ia32_sys_eventfd
 324	i386	fallocate		sys_fallocate			__ia32_compat_sys_x86_fallocate
-325	i386	timerfd_settime		sys_timerfd_settime		__ia32_compat_sys_timerfd_settime
-326	i386	timerfd_gettime		sys_timerfd_gettime		__ia32_compat_sys_timerfd_gettime
+325	i386	timerfd_settime		sys_timerfd_settime32		__ia32_sys_timerfd_settime32
+326	i386	timerfd_gettime		sys_timerfd_gettime32		__ia32_sys_timerfd_gettime32
 327	i386	signalfd4		sys_signalfd4			__ia32_compat_sys_signalfd4
 328	i386	eventfd2		sys_eventfd2			__ia32_sys_eventfd2
 329	i386	epoll_create1		sys_epoll_create1		__ia32_sys_epoll_create1
@@ -348,13 +348,13 @@
 334	i386	pwritev			sys_pwritev			__ia32_compat_sys_pwritev
 335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		__ia32_compat_sys_rt_tgsigqueueinfo
 336	i386	perf_event_open		sys_perf_event_open		__ia32_sys_perf_event_open
-337	i386	recvmmsg		sys_recvmmsg			__ia32_compat_sys_recvmmsg
+337	i386	recvmmsg		sys_recvmmsg_time32		__ia32_compat_sys_recvmmsg_time32
 338	i386	fanotify_init		sys_fanotify_init		__ia32_sys_fanotify_init
 339	i386	fanotify_mark		sys_fanotify_mark		__ia32_compat_sys_fanotify_mark
 340	i386	prlimit64		sys_prlimit64			__ia32_sys_prlimit64
 341	i386	name_to_handle_at	sys_name_to_handle_at		__ia32_sys_name_to_handle_at
 342	i386	open_by_handle_at	sys_open_by_handle_at		__ia32_compat_sys_open_by_handle_at
-343	i386	clock_adjtime		sys_clock_adjtime		__ia32_compat_sys_clock_adjtime
+343	i386	clock_adjtime		sys_clock_adjtime32		__ia32_sys_clock_adjtime32
 344	i386	syncfs			sys_syncfs			__ia32_sys_syncfs
 345	i386	sendmmsg		sys_sendmmsg			__ia32_compat_sys_sendmmsg
 346	i386	setns			sys_setns			__ia32_sys_setns
@@ -396,5 +396,36 @@
 382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
 383	i386	statx			sys_statx			__ia32_sys_statx
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
-385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
+385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
+# don't use numbers 387 through 392, add new calls at the end
+393	i386	semget			sys_semget    			__ia32_sys_semget
+394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
+395	i386	shmget			sys_shmget    			__ia32_sys_shmget
+396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
+397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
+398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
+399	i386	msgget			sys_msgget    			__ia32_sys_msgget
+400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
+401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
+402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
+403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
+404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
+405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
+406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
+407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nanosleep
+408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
+409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
+410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
+411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
+412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
+413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
+414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
+416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
+417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
+418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
+419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedreceive
+420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
+421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
+422	i386	futex_time64		sys_futex			__ia32_sys_futex
+423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sys_sched_rr_get_interval
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..2ae92fddb6d5 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -361,7 +363,7 @@
 520	x32	execve			__x32_compat_sys_execve/ptregs
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
 524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
 525	x32	sigaltstack		__x32_compat_sys_sigaltstack
 526	x32	timer_create		__x32_compat_sys_timer_create
@@ -375,7 +377,7 @@
 534	x32	preadv			__x32_compat_sys_preadv64
 535	x32	pwritev			__x32_compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
 538	x32	sendmmsg		__x32_compat_sys_sendmmsg
 539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
 540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index dc4ed8bc2382..146859efd83c 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -23,8 +23,8 @@
 
 #  include <asm/unistd_64.h>
 #  include <asm/unistd_64_x32.h>
-#  define __ARCH_WANT_COMPAT_SYS_TIME
-#  define __ARCH_WANT_SYS_UTIME32
+#  define __ARCH_WANT_SYS_TIME
+#  define __ARCH_WANT_SYS_UTIME
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
@@ -48,8 +48,8 @@
 # define __ARCH_WANT_SYS_SIGPENDING
 # define __ARCH_WANT_SYS_SIGPROCMASK
 # define __ARCH_WANT_SYS_SOCKETCALL
-# define __ARCH_WANT_SYS_TIME
-# define __ARCH_WANT_SYS_UTIME
+# define __ARCH_WANT_SYS_TIME32
+# define __ARCH_WANT_SYS_UTIME32
 # define __ARCH_WANT_SYS_WAITPID
 # define __ARCH_WANT_SYS_FORK
 # define __ARCH_WANT_SYS_VFORK
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index f518b4744ff8..ab14e6f73ca4 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -17,6 +17,7 @@ config 64BIT
 config X86_32
 	def_bool !64BIT
 	select HAVE_AOUT
+	select ARCH_32BIT_OFF_T
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index ce91682770cb..963986a48c62 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config XTENSA
 	def_bool y
+	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index 0d34629dafc5..30af4dc3ce7b 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -7,21 +7,9 @@
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_UTIME32
 #define __ARCH_WANT_SYS_GETPGRP
 
-/* 
- * Ignore legacy system calls in the checksyscalls.sh script
- */
-
-#define __IGNORE_fork				/* use clone */
-#define __IGNORE_time
-#define __IGNORE_alarm				/* use setitimer */
-#define __IGNORE_pause
-#define __IGNORE_mmap				/* use mmap2 */
-#define __IGNORE_vfork				/* use clone */
-#define __IGNORE_fadvise64			/* use fadvise64_64 */
-
 #define NR_syscalls				__NR_syscalls
 
 #endif /* _XTENSA_UNISTD_H */
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 69cf91b03b26..6af49929de85 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -72,8 +72,8 @@
 61	common	fcntl64				sys_fcntl64
 62	common	fallocate			sys_fallocate
 63	common	fadvise64_64			xtensa_fadvise64_64
-64	common	utime				sys_utime
-65	common	utimes				sys_utimes
+64	common	utime				sys_utime32
+65	common	utimes				sys_utimes_time32
 66	common	ioctl				sys_ioctl
 67	common	fcntl				sys_fcntl
 68	common	setxattr			sys_setxattr
@@ -103,7 +103,7 @@
 91	common	madvise				sys_madvise
 92	common	shmget				sys_shmget
 93	common	shmat				xtensa_shmat
-94	common	shmctl				sys_shmctl
+94	common	shmctl				sys_old_shmctl
 95	common	shmdt				sys_shmdt
 # Socket Operations
 96	common	socket				sys_socket
@@ -174,15 +174,15 @@
 158	common	capget				sys_capget
 159	common	capset				sys_capset
 160	common	ptrace				sys_ptrace
-161	common	semtimedop			sys_semtimedop
+161	common	semtimedop			sys_semtimedop_time32
 162	common	semget				sys_semget
 163	common	semop				sys_semop
-164	common	semctl				sys_semctl
+164	common	semctl				sys_old_semctl
 165	common	available165			sys_ni_syscall
 166	common	msgget				sys_msgget
 167	common	msgsnd				sys_msgsnd
 168	common	msgrcv				sys_msgrcv
-169	common	msgctl				sys_msgctl
+169	common	msgctl				sys_old_msgctl
 170	common	available170			sys_ni_syscall
 # File System
 171	common	umount2				sys_umount
@@ -206,11 +206,11 @@
 188	common	setrlimit			sys_setrlimit
 189	common	getrlimit			sys_getrlimit
 190	common	getrusage			sys_getrusage
-191	common	futex				sys_futex
+191	common	futex				sys_futex_time32
 192	common	gettimeofday			sys_gettimeofday
 193	common	settimeofday			sys_settimeofday
-194	common	adjtimex			sys_adjtimex
-195	common	nanosleep			sys_nanosleep
+194	common	adjtimex			sys_adjtimex_time32
+195	common	nanosleep			sys_nanosleep_time32
 196	common	getgroups			sys_getgroups
 197	common	setgroups			sys_setgroups
 198	common	sethostname			sys_sethostname
@@ -234,7 +234,7 @@
 215	common	sched_getscheduler		sys_sched_getscheduler
 216	common	sched_get_priority_max		sys_sched_get_priority_max
 217	common	sched_get_priority_min		sys_sched_get_priority_min
-218	common	sched_rr_get_interval		sys_sched_rr_get_interval
+218	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
 219	common	sched_yield			sys_sched_yield
 222	common	available222			sys_ni_syscall
 # Signal Handling
@@ -244,14 +244,14 @@
 226	common	rt_sigaction			sys_rt_sigaction
 227	common	rt_sigprocmask			sys_rt_sigprocmask
 228	common	rt_sigpending			sys_rt_sigpending
-229	common	rt_sigtimedwait			sys_rt_sigtimedwait
+229	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
 230	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
 231	common	rt_sigsuspend			sys_rt_sigsuspend
 # Message
 232	common	mq_open				sys_mq_open
 233	common	mq_unlink			sys_mq_unlink
-234	common	mq_timedsend			sys_mq_timedsend
-235	common	mq_timedreceive			sys_mq_timedreceive
+234	common	mq_timedsend			sys_mq_timedsend_time32
+235	common	mq_timedreceive			sys_mq_timedreceive_time32
 236	common	mq_notify			sys_mq_notify
 237	common	mq_getsetattr			sys_mq_getsetattr
 238	common	available238			sys_ni_syscall
@@ -259,17 +259,17 @@
 # IO
 240	common	io_destroy			sys_io_destroy
 241	common	io_submit			sys_io_submit
-242	common	io_getevents			sys_io_getevents
+242	common	io_getevents			sys_io_getevents_time32
 243	common	io_cancel			sys_io_cancel
-244	common	clock_settime			sys_clock_settime
-245	common	clock_gettime			sys_clock_gettime
-246	common	clock_getres			sys_clock_getres
-247	common	clock_nanosleep			sys_clock_nanosleep
+244	common	clock_settime			sys_clock_settime32
+245	common	clock_gettime			sys_clock_gettime32
+246	common	clock_getres			sys_clock_getres_time32
+247	common	clock_nanosleep			sys_clock_nanosleep_time32
 # Timer
 248	common	timer_create			sys_timer_create
 249	common	timer_delete			sys_timer_delete
-250	common	timer_settime			sys_timer_settime
-251	common	timer_gettime			sys_timer_gettime
+250	common	timer_settime			sys_timer_settime32
+251	common	timer_gettime			sys_timer_gettime32
 252	common	timer_getoverrun		sys_timer_getoverrun
 # System
 253	common	reserved253			sys_ni_syscall
@@ -291,8 +291,8 @@
 269	common	tee				sys_tee
 270	common	vmsplice			sys_vmsplice
 271	common	available271			sys_ni_syscall
-272	common	pselect6			sys_pselect6
-273	common	ppoll				sys_ppoll
+272	common	pselect6			sys_pselect6_time32
+273	common	ppoll				sys_ppoll_time32
 274	common	epoll_pwait			sys_epoll_pwait
 275	common	epoll_create1			sys_epoll_create1
 276	common	inotify_init			sys_inotify_init
@@ -316,9 +316,9 @@
 293	common	linkat				sys_linkat
 294	common	symlinkat			sys_symlinkat
 295	common	readlinkat			sys_readlinkat
-296	common	utimensat			sys_utimensat
+296	common	utimensat			sys_utimensat_time32
 297	common	fchownat			sys_fchownat
-298	common	futimesat			sys_futimesat
+298	common	futimesat			sys_futimesat_time32
 299	common	fstatat64			sys_fstatat64
 300	common	fchmodat			sys_fchmodat
 301	common	faccessat			sys_faccessat
@@ -327,14 +327,14 @@
 304	common	signalfd			sys_signalfd
 # 305 was timerfd
 306	common	eventfd				sys_eventfd
-307	common	recvmmsg			sys_recvmmsg
+307	common	recvmmsg			sys_recvmmsg_time32
 308	common	setns				sys_setns
 309	common	signalfd4			sys_signalfd4
 310	common	dup3				sys_dup3
 311	common	pipe2				sys_pipe2
 312	common	timerfd_create			sys_timerfd_create
-313	common	timerfd_settime			sys_timerfd_settime
-314	common	timerfd_gettime			sys_timerfd_gettime
+313	common	timerfd_settime			sys_timerfd_settime32
+314	common	timerfd_gettime			sys_timerfd_gettime32
 315	common	available315			sys_ni_syscall
 316	common	eventfd2			sys_eventfd2
 317	common	preadv				sys_preadv
@@ -349,7 +349,7 @@
 326	common	sync_file_range2		sys_sync_file_range2
 327	common	perf_event_open			sys_perf_event_open
 328	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
-329	common	clock_adjtime			sys_clock_adjtime
+329	common	clock_adjtime			sys_clock_adjtime32
 330	common	prlimit64			sys_prlimit64
 331	common	kcmp				sys_kcmp
 332	common	finit_module			sys_finit_module
@@ -372,3 +372,25 @@
 349	common	pkey_alloc			sys_pkey_alloc
 350	common	pkey_free			sys_pkey_free
 351	common	statx				sys_statx
+352	common	rseq				sys_rseq
+# 353 through 402 are unassigned to sync up with generic numbers
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 48f3594a7458..79bd102c9bbc 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -124,7 +124,7 @@ static int ptp_clock_gettime(struct posix_clock *pc, struct timespec64 *tp)
 	return err;
 }
 
-static int ptp_clock_adjtime(struct posix_clock *pc, struct timex *tx)
+static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	struct ptp_clock_info *ops;
diff --git a/fs/aio.c b/fs/aio.c
index b906ff70c90f..4394d3fe116a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2198,11 +2198,11 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
 
 #if defined(CONFIG_COMPAT_32BIT_TIME)
 
-COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
-		       compat_long_t, min_nr,
-		       compat_long_t, nr,
-		       struct io_event __user *, events,
-		       struct old_timespec32 __user *, timeout)
+SYSCALL_DEFINE5(io_getevents_time32, __u32, ctx_id,
+		__s32, min_nr,
+		__s32, nr,
+		struct io_event __user *, events,
+		struct old_timespec32 __user *, timeout)
 {
 	struct timespec64 t;
 	int ret;
diff --git a/fs/select.c b/fs/select.c
index d0f35dbc0e8f..6cbc9ff56ba0 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1379,7 +1379,7 @@ COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
 
 #if defined(CONFIG_COMPAT_32BIT_TIME)
 
-COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
+COMPAT_SYSCALL_DEFINE6(pselect6_time32, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
 	struct old_timespec32 __user *, tsp, void __user *, sig)
 {
@@ -1402,7 +1402,7 @@ COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
 #endif
 
 #if defined(CONFIG_COMPAT_32BIT_TIME)
-COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
+COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds,
 	unsigned int,  nfds, struct old_timespec32 __user *, tsp,
 	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
 {
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 803ca070d42e..6a6fc8aa1de7 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -560,7 +560,7 @@ SYSCALL_DEFINE2(timerfd_gettime, int, ufd, struct __kernel_itimerspec __user *,
 }
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
+SYSCALL_DEFINE4(timerfd_settime32, int, ufd, int, flags,
 		const struct old_itimerspec32 __user *, utmr,
 		struct old_itimerspec32 __user *, otmr)
 {
@@ -577,7 +577,7 @@ COMPAT_SYSCALL_DEFINE4(timerfd_settime, int, ufd, int, flags,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE2(timerfd_gettime, int, ufd,
+SYSCALL_DEFINE2(timerfd_gettime32, int, ufd,
 		struct old_itimerspec32 __user *, otmr)
 {
 	struct itimerspec64 kotmr;
diff --git a/fs/utimes.c b/fs/utimes.c
index bdcf2daf39c1..350c9c16ace1 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -224,8 +224,8 @@ SYSCALL_DEFINE2(utime, char __user *, filename, struct utimbuf __user *, times)
  * of sys_utimes.
  */
 #ifdef __ARCH_WANT_SYS_UTIME32
-COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
-		       struct old_utimbuf32 __user *, t)
+SYSCALL_DEFINE2(utime32, const char __user *, filename,
+		struct old_utimbuf32 __user *, t)
 {
 	struct timespec64 tv[2];
 
@@ -240,7 +240,7 @@ COMPAT_SYSCALL_DEFINE2(utime, const char __user *, filename,
 }
 #endif
 
-COMPAT_SYSCALL_DEFINE4(utimensat, unsigned int, dfd, const char __user *, filename, struct old_timespec32 __user *, t, int, flags)
+SYSCALL_DEFINE4(utimensat_time32, unsigned int, dfd, const char __user *, filename, struct old_timespec32 __user *, t, int, flags)
 {
 	struct timespec64 tv[2];
 
@@ -276,14 +276,14 @@ static long do_compat_futimesat(unsigned int dfd, const char __user *filename,
 	return do_utimes(dfd, filename, t ? tv : NULL, 0);
 }
 
-COMPAT_SYSCALL_DEFINE3(futimesat, unsigned int, dfd,
+SYSCALL_DEFINE3(futimesat_time32, unsigned int, dfd,
 		       const char __user *, filename,
 		       struct old_timeval32 __user *, t)
 {
 	return do_compat_futimesat(dfd, filename, t);
 }
 
-COMPAT_SYSCALL_DEFINE2(utimes, const char __user *, filename, struct old_timeval32 __user *, t)
+SYSCALL_DEFINE2(utimes_time32, const char __user *, filename, struct old_timeval32 __user *, t)
 {
 	return do_compat_futimesat(AT_FDCWD, filename, t);
 }
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 056be0d03722..ebddcb6cfcf8 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -132,37 +132,6 @@ struct compat_tms {
 	compat_clock_t		tms_cstime;
 };
 
-struct compat_timex {
-	compat_uint_t modes;
-	compat_long_t offset;
-	compat_long_t freq;
-	compat_long_t maxerror;
-	compat_long_t esterror;
-	compat_int_t status;
-	compat_long_t constant;
-	compat_long_t precision;
-	compat_long_t tolerance;
-	struct old_timeval32 time;
-	compat_long_t tick;
-	compat_long_t ppsfreq;
-	compat_long_t jitter;
-	compat_int_t shift;
-	compat_long_t stabil;
-	compat_long_t jitcnt;
-	compat_long_t calcnt;
-	compat_long_t errcnt;
-	compat_long_t stbcnt;
-	compat_int_t tai;
-
-	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
-	compat_int_t:32; compat_int_t:32; compat_int_t:32; compat_int_t:32;
-	compat_int_t:32; compat_int_t:32; compat_int_t:32;
-};
-
-struct timex;
-int compat_get_timex(struct timex *, const struct compat_timex __user *);
-int compat_put_timex(struct compat_timex __user *, const struct timex *);
-
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
 
 typedef struct {
@@ -551,11 +520,6 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 asmlinkage long compat_sys_io_setup(unsigned nr_reqs, u32 __user *ctx32p);
 asmlinkage long compat_sys_io_submit(compat_aio_context_t ctx_id, int nr,
 				     u32 __user *iocb);
-asmlinkage long compat_sys_io_getevents(compat_aio_context_t ctx_id,
-					compat_long_t min_nr,
-					compat_long_t nr,
-					struct io_event __user *events,
-					struct old_timespec32 __user *timeout);
 asmlinkage long compat_sys_io_pgetevents(compat_aio_context_t ctx_id,
 					compat_long_t min_nr,
 					compat_long_t nr,
@@ -648,7 +612,7 @@ asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
 				    compat_loff_t __user *offset, compat_size_t count);
 
 /* fs/select.c */
-asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
+asmlinkage long compat_sys_pselect6_time32(int n, compat_ulong_t __user *inp,
 				    compat_ulong_t __user *outp,
 				    compat_ulong_t __user *exp,
 				    struct old_timespec32 __user *tsp,
@@ -658,7 +622,7 @@ asmlinkage long compat_sys_pselect6_time64(int n, compat_ulong_t __user *inp,
 				    compat_ulong_t __user *exp,
 				    struct __kernel_timespec __user *tsp,
 				    void __user *sig);
-asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
+asmlinkage long compat_sys_ppoll_time32(struct pollfd __user *ufds,
 				 unsigned int nfds,
 				 struct old_timespec32 __user *tsp,
 				 const compat_sigset_t __user *sigmask,
@@ -688,19 +652,6 @@ asmlinkage long compat_sys_newfstat(unsigned int fd,
 
 /* fs/sync.c: No generic prototype for sync_file_range and sync_file_range2 */
 
-/* fs/timerfd.c */
-asmlinkage long compat_sys_timerfd_gettime(int ufd,
-				   struct old_itimerspec32 __user *otmr);
-asmlinkage long compat_sys_timerfd_settime(int ufd, int flags,
-				   const struct old_itimerspec32 __user *utmr,
-				   struct old_itimerspec32 __user *otmr);
-
-/* fs/utimes.c */
-asmlinkage long compat_sys_utimensat(unsigned int dfd,
-				     const char __user *filename,
-				     struct old_timespec32 __user *t,
-				     int flags);
-
 /* kernel/exit.c */
 asmlinkage long compat_sys_waitid(int, compat_pid_t,
 		struct compat_siginfo __user *, int,
@@ -709,9 +660,6 @@ asmlinkage long compat_sys_waitid(int, compat_pid_t,
 
 
 /* kernel/futex.c */
-asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
-		struct old_timespec32 __user *utime, u32 __user *uaddr2,
-		u32 val3);
 asmlinkage long
 compat_sys_set_robust_list(struct compat_robust_list_head __user *head,
 			   compat_size_t len);
@@ -719,10 +667,6 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
-/* kernel/hrtimer.c */
-asmlinkage long compat_sys_nanosleep(struct old_timespec32 __user *rqtp,
-				     struct old_timespec32 __user *rmtp);
-
 /* kernel/itimer.c */
 asmlinkage long compat_sys_getitimer(int which,
 				     struct compat_itimerval __user *it);
@@ -740,20 +684,6 @@ asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
 asmlinkage long compat_sys_timer_create(clockid_t which_clock,
 			struct compat_sigevent __user *timer_event_spec,
 			timer_t __user *created_timer_id);
-asmlinkage long compat_sys_timer_gettime(timer_t timer_id,
-				 struct old_itimerspec32 __user *setting);
-asmlinkage long compat_sys_timer_settime(timer_t timer_id, int flags,
-					 struct old_itimerspec32 __user *new,
-					 struct old_itimerspec32 __user *old);
-asmlinkage long compat_sys_clock_settime(clockid_t which_clock,
-					 struct old_timespec32 __user *tp);
-asmlinkage long compat_sys_clock_gettime(clockid_t which_clock,
-					 struct old_timespec32 __user *tp);
-asmlinkage long compat_sys_clock_getres(clockid_t which_clock,
-					struct old_timespec32 __user *tp);
-asmlinkage long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
-					   struct old_timespec32 __user *rqtp,
-					   struct old_timespec32 __user *rmtp);
 
 /* kernel/ptrace.c */
 asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
@@ -766,8 +696,6 @@ asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
 asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
 				     unsigned int len,
 				     compat_ulong_t __user *user_mask_ptr);
-asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
-						 struct old_timespec32 __user *interval);
 
 /* kernel/signal.c */
 asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
@@ -785,7 +713,7 @@ asmlinkage long compat_sys_rt_sigprocmask(int how, compat_sigset_t __user *set,
 					  compat_size_t sigsetsize);
 asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
 					 compat_size_t sigsetsize);
-asmlinkage long compat_sys_rt_sigtimedwait(compat_sigset_t __user *uthese,
+asmlinkage long compat_sys_rt_sigtimedwait_time32(compat_sigset_t __user *uthese,
 		struct compat_siginfo __user *uinfo,
 		struct old_timespec32 __user *uts, compat_size_t sigsetsize);
 asmlinkage long compat_sys_rt_sigtimedwait_time64(compat_sigset_t __user *uthese,
@@ -808,7 +736,6 @@ asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
 asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
 		struct timezone __user *tz);
-asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
 
 /* kernel/timer.c */
 asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
@@ -817,14 +744,6 @@ asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
 asmlinkage long compat_sys_mq_open(const char __user *u_name,
 			int oflag, compat_mode_t mode,
 			struct compat_mq_attr __user *u_attr);
-asmlinkage long compat_sys_mq_timedsend(mqd_t mqdes,
-			const char __user *u_msg_ptr,
-			compat_size_t msg_len, unsigned int msg_prio,
-			const struct old_timespec32 __user *u_abs_timeout);
-asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes,
-			char __user *u_msg_ptr,
-			compat_size_t msg_len, unsigned int __user *u_msg_prio,
-			const struct old_timespec32 __user *u_abs_timeout);
 asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
 			const struct compat_sigevent __user *u_notification);
 asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
@@ -840,8 +759,6 @@ asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
 
 /* ipc/sem.c */
 asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
-asmlinkage long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
-		unsigned nsems, const struct old_timespec32 __user *timeout);
 
 /* ipc/shm.c */
 asmlinkage long compat_sys_shmctl(int first, int second, void __user *uptr);
@@ -899,7 +816,7 @@ asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 asmlinkage long compat_sys_recvmmsg_time64(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags,
 				    struct __kernel_timespec __user *timeout);
-asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+asmlinkage long compat_sys_recvmmsg_time32(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags,
 				    struct old_timespec32 __user *timeout);
 asmlinkage long compat_sys_wait4(compat_pid_t pid,
@@ -910,8 +827,6 @@ asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
 					     struct file_handle __user *handle,
 					     int flags);
-asmlinkage long compat_sys_clock_adjtime(clockid_t which_clock,
-					 struct compat_timex __user *tp);
 asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags);
 asmlinkage ssize_t compat_sys_process_vm_readv(compat_pid_t pid,
@@ -952,8 +867,6 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 /* __ARCH_WANT_SYSCALL_NO_AT */
 asmlinkage long compat_sys_open(const char __user *filename, int flags,
 				umode_t mode);
-asmlinkage long compat_sys_utimes(const char __user *filename,
-				  struct old_timeval32 __user *t);
 
 /* __ARCH_WANT_SYSCALL_NO_FLAGS */
 asmlinkage long compat_sys_signalfd(int ufd,
@@ -967,12 +880,6 @@ asmlinkage long compat_sys_newlstat(const char __user *filename,
 				    struct compat_stat __user *statbuf);
 
 /* __ARCH_WANT_SYSCALL_DEPRECATED */
-asmlinkage long compat_sys_time(old_time32_t __user *tloc);
-asmlinkage long compat_sys_utime(const char __user *filename,
-				 struct old_utimbuf32 __user *t);
-asmlinkage long compat_sys_futimesat(unsigned int dfd,
-				     const char __user *filename,
-				     struct old_timeval32 __user *t);
 asmlinkage long compat_sys_select(int n, compat_ulong_t __user *inp,
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
 		struct old_timeval32 __user *tvp);
@@ -1007,9 +914,6 @@ asmlinkage long compat_sys_sigaction(int sig,
                                    struct compat_old_sigaction __user *oact);
 #endif
 
-/* obsolete: kernel/time/time.c */
-asmlinkage long compat_sys_stime(old_time32_t __user *tptr);
-
 /* obsolete: net/socket.c */
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a60693e..d019df946cb2 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,7 +12,7 @@
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
 #ifndef force_o_largefile
-#define force_o_largefile() (BITS_PER_LONG != 32)
+#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
 
 #if BITS_PER_LONG == 32
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index 3a3bc71017d5..18674d7d5b1c 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -51,7 +51,7 @@ struct posix_clock;
 struct posix_clock_operations {
 	struct module *owner;
 
-	int  (*clock_adjtime)(struct posix_clock *pc, struct timex *tx);
+	int  (*clock_adjtime)(struct posix_clock *pc, struct __kernel_timex *tx);
 
 	int  (*clock_gettime)(struct posix_clock *pc, struct timespec64 *ts);
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..94369f5bd8e5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -54,7 +54,7 @@ struct __sysctl_args;
 struct sysinfo;
 struct timespec;
 struct timeval;
-struct timex;
+struct __kernel_timex;
 struct timezone;
 struct tms;
 struct utimbuf;
@@ -297,6 +297,11 @@ asmlinkage long sys_io_getevents(aio_context_t ctx_id,
 				long nr,
 				struct io_event __user *events,
 				struct __kernel_timespec __user *timeout);
+asmlinkage long sys_io_getevents_time32(__u32 ctx_id,
+				__s32 min_nr,
+				__s32 nr,
+				struct io_event __user *events,
+				struct old_timespec32 __user *timeout);
 asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
@@ -522,11 +527,19 @@ asmlinkage long sys_timerfd_settime(int ufd, int flags,
 				    const struct __kernel_itimerspec __user *utmr,
 				    struct __kernel_itimerspec __user *otmr);
 asmlinkage long sys_timerfd_gettime(int ufd, struct __kernel_itimerspec __user *otmr);
+asmlinkage long sys_timerfd_gettime32(int ufd,
+				   struct old_itimerspec32 __user *otmr);
+asmlinkage long sys_timerfd_settime32(int ufd, int flags,
+				   const struct old_itimerspec32 __user *utmr,
+				   struct old_itimerspec32 __user *otmr);
 
 /* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
 				struct __kernel_timespec __user *utimes,
 				int flags);
+asmlinkage long sys_utimensat_time32(unsigned int dfd,
+				const char __user *filename,
+				struct old_timespec32 __user *t, int flags);
 
 /* kernel/acct.c */
 asmlinkage long sys_acct(const char __user *name);
@@ -555,6 +568,9 @@ asmlinkage long sys_unshare(unsigned long unshare_flags);
 asmlinkage long sys_futex(u32 __user *uaddr, int op, u32 val,
 			struct __kernel_timespec __user *utime, u32 __user *uaddr2,
 			u32 val3);
+asmlinkage long sys_futex_time32(u32 __user *uaddr, int op, u32 val,
+			struct old_timespec32 __user *utime, u32 __user *uaddr2,
+			u32 val3);
 asmlinkage long sys_get_robust_list(int pid,
 				    struct robust_list_head __user * __user *head_ptr,
 				    size_t __user *len_ptr);
@@ -564,6 +580,8 @@ asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
+asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
+				     struct old_timespec32 __user *rmtp);
 
 /* kernel/itimer.c */
 asmlinkage long sys_getitimer(int which, struct itimerval __user *value);
@@ -591,7 +609,7 @@ asmlinkage long sys_timer_gettime(timer_t timer_id,
 asmlinkage long sys_timer_getoverrun(timer_t timer_id);
 asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				const struct __kernel_itimerspec __user *new_setting,
-				struct itimerspec __user *old_setting);
+				struct __kernel_itimerspec __user *old_setting);
 asmlinkage long sys_timer_delete(timer_t timer_id);
 asmlinkage long sys_clock_settime(clockid_t which_clock,
 				const struct __kernel_timespec __user *tp);
@@ -602,6 +620,20 @@ asmlinkage long sys_clock_getres(clockid_t which_clock,
 asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
 				const struct __kernel_timespec __user *rqtp,
 				struct __kernel_timespec __user *rmtp);
+asmlinkage long sys_timer_gettime32(timer_t timer_id,
+				 struct old_itimerspec32 __user *setting);
+asmlinkage long sys_timer_settime32(timer_t timer_id, int flags,
+					 struct old_itimerspec32 __user *new,
+					 struct old_itimerspec32 __user *old);
+asmlinkage long sys_clock_settime32(clockid_t which_clock,
+				struct old_timespec32 __user *tp);
+asmlinkage long sys_clock_gettime32(clockid_t which_clock,
+				struct old_timespec32 __user *tp);
+asmlinkage long sys_clock_getres_time32(clockid_t which_clock,
+				struct old_timespec32 __user *tp);
+asmlinkage long sys_clock_nanosleep_time32(clockid_t which_clock, int flags,
+				struct old_timespec32 __user *rqtp,
+				struct old_timespec32 __user *rmtp);
 
 /* kernel/printk.c */
 asmlinkage long sys_syslog(int type, char __user *buf, int len);
@@ -627,6 +659,8 @@ asmlinkage long sys_sched_get_priority_max(int policy);
 asmlinkage long sys_sched_get_priority_min(int policy);
 asmlinkage long sys_sched_rr_get_interval(pid_t pid,
 				struct __kernel_timespec __user *interval);
+asmlinkage long sys_sched_rr_get_interval_time32(pid_t pid,
+						 struct old_timespec32 __user *interval);
 
 /* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
@@ -695,7 +729,8 @@ asmlinkage long sys_gettimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
-asmlinkage long sys_adjtimex(struct timex __user *txc_p);
+asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
+asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
 
 /* kernel/timer.c */
 asmlinkage long sys_getpid(void);
@@ -714,9 +749,18 @@ asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t
 asmlinkage long sys_mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct __kernel_timespec __user *abs_timeout);
 asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
 asmlinkage long sys_mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
+asmlinkage long sys_mq_timedreceive_time32(mqd_t mqdes,
+			char __user *u_msg_ptr,
+			unsigned int msg_len, unsigned int __user *u_msg_prio,
+			const struct old_timespec32 __user *u_abs_timeout);
+asmlinkage long sys_mq_timedsend_time32(mqd_t mqdes,
+			const char __user *u_msg_ptr,
+			unsigned int msg_len, unsigned int msg_prio,
+			const struct old_timespec32 __user *u_abs_timeout);
 
 /* ipc/msg.c */
 asmlinkage long sys_msgget(key_t key, int msgflg);
+asmlinkage long sys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp,
 				size_t msgsz, long msgtyp, int msgflg);
@@ -726,14 +770,19 @@ asmlinkage long sys_msgsnd(int msqid, struct msgbuf __user *msgp,
 /* ipc/sem.c */
 asmlinkage long sys_semget(key_t key, int nsems, int semflg);
 asmlinkage long sys_semctl(int semid, int semnum, int cmd, unsigned long arg);
+asmlinkage long sys_old_semctl(int semid, int semnum, int cmd, unsigned long arg);
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 				unsigned nsops,
 				const struct __kernel_timespec __user *timeout);
+asmlinkage long sys_semtimedop_time32(int semid, struct sembuf __user *sops,
+				unsigned nsops,
+				const struct old_timespec32 __user *timeout);
 asmlinkage long sys_semop(int semid, struct sembuf __user *sops,
 				unsigned nsops);
 
 /* ipc/shm.c */
 asmlinkage long sys_shmget(key_t key, size_t size, int flag);
+asmlinkage long sys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 asmlinkage long sys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg);
 asmlinkage long sys_shmdt(char __user *shmaddr);
@@ -867,7 +916,9 @@ asmlinkage long sys_open_by_handle_at(int mountdirfd,
 				      struct file_handle __user *handle,
 				      int flags);
 asmlinkage long sys_clock_adjtime(clockid_t which_clock,
-				struct timex __user *tx);
+				struct __kernel_timex __user *tx);
+asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
+				struct old_timex32 __user *tx);
 asmlinkage long sys_syncfs(int fd);
 asmlinkage long sys_setns(int fd, int nstype);
 asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
@@ -1003,6 +1054,7 @@ asmlinkage long sys_alarm(unsigned int seconds);
 asmlinkage long sys_getpgrp(void);
 asmlinkage long sys_pause(void);
 asmlinkage long sys_time(time_t __user *tloc);
+asmlinkage long sys_time32(old_time32_t __user *tloc);
 #ifdef __ARCH_WANT_SYS_UTIME
 asmlinkage long sys_utime(char __user *filename,
 				struct utimbuf __user *times);
@@ -1011,6 +1063,13 @@ asmlinkage long sys_utimes(char __user *filename,
 asmlinkage long sys_futimesat(int dfd, const char __user *filename,
 			      struct timeval __user *utimes);
 #endif
+asmlinkage long sys_futimesat_time32(unsigned int dfd,
+				     const char __user *filename,
+				     struct old_timeval32 __user *t);
+asmlinkage long sys_utime32(const char __user *filename,
+				 struct old_utimbuf32 __user *t);
+asmlinkage long sys_utimes_time32(const char __user *filename,
+				  struct old_timeval32 __user *t);
 asmlinkage long sys_creat(const char __user *pathname, umode_t mode);
 asmlinkage long sys_getdents(unsigned int fd,
 				struct linux_dirent __user *dirent,
@@ -1035,6 +1094,7 @@ asmlinkage long sys_fork(void);
 
 /* obsolete: kernel/time/time.c */
 asmlinkage long sys_stime(time_t __user *tptr);
+asmlinkage long sys_stime32(old_time32_t __user *tptr);
 
 /* obsolete: kernel/signal.c */
 asmlinkage long sys_sigpending(old_sigset_t __user *uset);
@@ -1185,6 +1245,10 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			      unsigned long prot, unsigned long flags,
 			      unsigned long fd, unsigned long pgoff);
 ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
+int ksys_ipc(unsigned int call, int first, unsigned long second,
+	unsigned long third, void __user * ptr, long fifth);
+int compat_ksys_ipc(u32 call, int first, int second,
+	u32 third, u32 ptr, u32 fifth);
 
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
diff --git a/include/linux/time32.h b/include/linux/time32.h
index 118b9977080c..0a1f302a1753 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/time64.h>
+#include <linux/timex.h>
 
 #define TIME_T_MAX	(time_t)((1UL << ((sizeof(time_t) << 3) - 1)) - 1)
 
@@ -35,13 +36,42 @@ struct old_utimbuf32 {
 	old_time32_t	modtime;
 };
 
+struct old_timex32 {
+	u32 modes;
+	s32 offset;
+	s32 freq;
+	s32 maxerror;
+	s32 esterror;
+	s32 status;
+	s32 constant;
+	s32 precision;
+	s32 tolerance;
+	struct old_timeval32 time;
+	s32 tick;
+	s32 ppsfreq;
+	s32 jitter;
+	s32 shift;
+	s32 stabil;
+	s32 jitcnt;
+	s32 calcnt;
+	s32 errcnt;
+	s32 stbcnt;
+	s32 tai;
+
+	s32:32; s32:32; s32:32; s32:32;
+	s32:32; s32:32; s32:32; s32:32;
+	s32:32; s32:32; s32:32;
+};
+
 extern int get_old_timespec32(struct timespec64 *, const void __user *);
 extern int put_old_timespec32(const struct timespec64 *, void __user *);
 extern int get_old_itimerspec32(struct itimerspec64 *its,
 			const struct old_itimerspec32 __user *uits);
 extern int put_old_itimerspec32(const struct itimerspec64 *its,
 			struct old_itimerspec32 __user *uits);
-
+struct __kernel_timex;
+int get_old_timex32(struct __kernel_timex *, const struct old_timex32 __user *);
+int put_old_timex32(struct old_timex32 __user *, const struct __kernel_timex *);
 
 #if __BITS_PER_LONG == 64
 
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 05634afba0db..f38d382ffec1 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -7,14 +7,6 @@
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
 
-/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
- * and 32-bit emulation.
- */
-#ifndef CONFIG_64BIT_TIME
-#define __kernel_timespec timespec
-#define __kernel_itimerspec itimerspec
-#endif
-
 #include <uapi/linux/time.h>
 
 struct timespec64 {
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 39c25dbebfe8..ce0859763670 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -151,7 +151,9 @@ extern unsigned long tick_nsec;		/* SHIFTED_HZ period (nsec) */
 #define NTP_INTERVAL_FREQ  (HZ)
 #define NTP_INTERVAL_LENGTH (NSEC_PER_SEC/NTP_INTERVAL_FREQ)
 
-extern int do_adjtimex(struct timex *);
+extern int do_adjtimex(struct __kernel_timex *);
+extern int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex * ktx);
+
 extern void hardpps(const struct timespec64 *, const struct timespec64 *);
 
 int read_current_timer(unsigned long *timer_val);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d90127298f12..12cdf611d217 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -38,8 +38,10 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
-__SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
+__SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
+#endif
 
 /* fs/xattr.c */
 #define __NR_setxattr 5
@@ -179,7 +181,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -222,10 +224,12 @@ __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
 /* fs/select.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
-__SC_COMP(__NR_pselect6, sys_pselect6, compat_sys_pselect6)
+__SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
 #define __NR_ppoll 73
-__SC_COMP(__NR_ppoll, sys_ppoll, compat_sys_ppoll)
+__SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
+#endif
 
 /* fs/signalfd.c */
 #define __NR_signalfd4 74
@@ -269,16 +273,20 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
 /* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
-__SC_COMP(__NR_timerfd_settime, sys_timerfd_settime, \
-	  compat_sys_timerfd_settime)
+__SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
+	  sys_timerfd_settime)
 #define __NR_timerfd_gettime 87
-__SC_COMP(__NR_timerfd_gettime, sys_timerfd_gettime, \
-	  compat_sys_timerfd_gettime)
+__SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
+	  sys_timerfd_gettime)
+#endif
 
 /* fs/utimes.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
-__SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
+__SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
+#endif
 
 /* kernel/acct.c */
 #define __NR_acct 89
@@ -309,8 +317,10 @@ __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 __SYSCALL(__NR_unshare, sys_unshare)
 
 /* kernel/futex.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
-__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
+__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -319,8 +329,10 @@ __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
 /* kernel/hrtimer.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
-__SC_COMP(__NR_nanosleep, sys_nanosleep, compat_sys_nanosleep)
+__SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
+#endif
 
 /* kernel/itimer.c */
 #define __NR_getitimer 102
@@ -341,23 +353,29 @@ __SYSCALL(__NR_delete_module, sys_delete_module)
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
-__SC_COMP(__NR_timer_gettime, sys_timer_gettime, compat_sys_timer_gettime)
+__SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
+#endif
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
-__SC_COMP(__NR_timer_settime, sys_timer_settime, compat_sys_timer_settime)
+__SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
+#endif
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
-__SC_COMP(__NR_clock_settime, sys_clock_settime, compat_sys_clock_settime)
+__SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
 #define __NR_clock_gettime 113
-__SC_COMP(__NR_clock_gettime, sys_clock_gettime, compat_sys_clock_gettime)
+__SC_3264(__NR_clock_gettime, sys_clock_gettime32, sys_clock_gettime)
 #define __NR_clock_getres 114
-__SC_COMP(__NR_clock_getres, sys_clock_getres, compat_sys_clock_getres)
+__SC_3264(__NR_clock_getres, sys_clock_getres_time32, sys_clock_getres)
 #define __NR_clock_nanosleep 115
-__SC_COMP(__NR_clock_nanosleep, sys_clock_nanosleep, \
-	  compat_sys_clock_nanosleep)
+__SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
+	  sys_clock_nanosleep)
+#endif
 
 /* kernel/printk.c */
 #define __NR_syslog 116
@@ -388,9 +406,11 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
-__SC_COMP(__NR_sched_rr_get_interval, sys_sched_rr_get_interval, \
-	  compat_sys_sched_rr_get_interval)
+__SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
+	  sys_sched_rr_get_interval)
+#endif
 
 /* kernel/signal.c */
 #define __NR_restart_syscall 128
@@ -411,9 +431,11 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
-__SC_COMP(__NR_rt_sigtimedwait, sys_rt_sigtimedwait, \
-	  compat_sys_rt_sigtimedwait)
+__SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
+	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
+#endif
 #define __NR_rt_sigqueueinfo 138
 __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
 	  compat_sys_rt_sigqueueinfo)
@@ -467,10 +489,15 @@ __SYSCALL(__NR_uname, sys_newuname)
 __SYSCALL(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
 __SYSCALL(__NR_setdomainname, sys_setdomainname)
+
+#ifdef __ARCH_WANT_SET_GET_RLIMIT
+/* getrlimit and setrlimit are superseded with prlimit64 */
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
 __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
+#endif
+
 #define __NR_getrusage 165
 __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
@@ -481,12 +508,14 @@ __SYSCALL(__NR_prctl, sys_prctl)
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
 /* kernel/time.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
 #define __NR_settimeofday 170
 __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 #define __NR_adjtimex 171
-__SC_COMP(__NR_adjtimex, sys_adjtimex, compat_sys_adjtimex)
+__SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
+#endif
 
 /* kernel/timer.c */
 #define __NR_getpid 172
@@ -511,11 +540,13 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
-__SC_COMP(__NR_mq_timedsend, sys_mq_timedsend, compat_sys_mq_timedsend)
+__SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
-__SC_COMP(__NR_mq_timedreceive, sys_mq_timedreceive, \
-	  compat_sys_mq_timedreceive)
+__SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
+	  sys_mq_timedreceive)
+#endif
 #define __NR_mq_notify 184
 __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 185
@@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
+__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+#endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
 
@@ -658,8 +691,10 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
-__SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
+__SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
+#endif
 
 /*
  * Architectures may provide up to 16 syscalls of their own
@@ -667,8 +702,10 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
  */
 #define __NR_arch_specific_syscall 244
 
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
+#endif
 #define __NR_prlimit64 261
 __SYSCALL(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
@@ -678,10 +715,11 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
-__SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
+__SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
+#endif
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -734,15 +772,60 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
-__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+__SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
+#endif
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
+#if __BITS_PER_LONG == 32
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceive_time64 419
+__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 424
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..b03f8717c312 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,19 +42,15 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
-#ifndef __kernel_timespec
 struct __kernel_timespec {
 	__kernel_time64_t       tv_sec;                 /* seconds */
 	long long               tv_nsec;                /* nanoseconds */
 };
-#endif
 
-#ifndef __kernel_itimerspec
 struct __kernel_itimerspec {
 	struct __kernel_timespec it_interval;    /* timer period */
 	struct __kernel_timespec it_value;       /* timer expiration */
 };
-#endif
 
 /*
  * legacy timeval structure, only embedded in structures that
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 92685d826444..9f517f9010bb 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -92,6 +92,45 @@ struct timex {
 	int  :32; int  :32; int  :32;
 };
 
+struct __kernel_timex_timeval {
+	__kernel_time64_t       tv_sec;
+	long long		tv_usec;
+};
+
+struct __kernel_timex {
+	unsigned int modes;	/* mode selector */
+	int :32;            /* pad */
+	long long offset;	/* time offset (usec) */
+	long long freq;	/* frequency offset (scaled ppm) */
+	long long maxerror;/* maximum error (usec) */
+	long long esterror;/* estimated error (usec) */
+	int status;		/* clock command/status */
+	int :32;            /* pad */
+	long long constant;/* pll time constant */
+	long long precision;/* clock precision (usec) (read only) */
+	long long tolerance;/* clock frequency tolerance (ppm)
+				   * (read only)
+				   */
+	struct __kernel_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	long long tick;	/* (modified) usecs between clock ticks */
+
+	long long ppsfreq;/* pps frequency (scaled ppm) (ro) */
+	long long jitter; /* pps jitter (us) (ro) */
+	int shift;              /* interval duration (s) (shift) (ro) */
+	int :32;            /* pad */
+	long long stabil;            /* pps stability (scaled ppm) (ro) */
+	long long jitcnt; /* jitter limit exceeded (ro) */
+	long long calcnt; /* calibration intervals (ro) */
+	long long errcnt; /* calibration errors (ro) */
+	long long stbcnt; /* stability limit exceeded (ro) */
+
+	int tai;		/* TAI offset (ro) */
+
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32;
+};
+
 /*
  * Mode codes (timex.mode)
  */
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c595bed7bfcb..c839bf83231d 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1471,10 +1471,10 @@ static int compat_prepare_timeout(const struct old_timespec32 __user *p,
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes,
-		       const char __user *, u_msg_ptr,
-		       compat_size_t, msg_len, unsigned int, msg_prio,
-		       const struct old_timespec32 __user *, u_abs_timeout)
+SYSCALL_DEFINE5(mq_timedsend_time32, mqd_t, mqdes,
+		const char __user *, u_msg_ptr,
+		unsigned int, msg_len, unsigned int, msg_prio,
+		const struct old_timespec32 __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
@@ -1486,10 +1486,10 @@ COMPAT_SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes,
 	return do_mq_timedsend(mqdes, u_msg_ptr, msg_len, msg_prio, p);
 }
 
-COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
-		       char __user *, u_msg_ptr,
-		       compat_size_t, msg_len, unsigned int __user *, u_msg_prio,
-		       const struct old_timespec32 __user *, u_abs_timeout)
+SYSCALL_DEFINE5(mq_timedreceive_time32, mqd_t, mqdes,
+		char __user *, u_msg_ptr,
+		unsigned int, msg_len, unsigned int __user *, u_msg_prio,
+		const struct old_timespec32 __user *, u_abs_timeout)
 {
 	struct timespec64 ts, *p = NULL;
 	if (u_abs_timeout) {
diff --git a/ipc/msg.c b/ipc/msg.c
index 0833c6405915..8dec945fa030 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -567,9 +567,8 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	return err;
 }
 
-long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
+static long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf, int version)
 {
-	int version;
 	struct ipc_namespace *ns;
 	struct msqid64_ds msqid64;
 	int err;
@@ -577,7 +576,6 @@ long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
 	if (msqid < 0 || cmd < 0)
 		return -EINVAL;
 
-	version = ipc_parse_version(&cmd);
 	ns = current->nsproxy->ipc_ns;
 
 	switch (cmd) {
@@ -613,9 +611,23 @@ long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
 
 SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, struct msqid_ds __user *, buf)
 {
-	return ksys_msgctl(msqid, cmd, buf);
+	return ksys_msgctl(msqid, cmd, buf, IPC_64);
 }
 
+#ifdef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
+long ksys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
+{
+	int version = ipc_parse_version(&cmd);
+
+	return ksys_msgctl(msqid, cmd, buf, version);
+}
+
+SYSCALL_DEFINE3(old_msgctl, int, msqid, int, cmd, struct msqid_ds __user *, buf)
+{
+	return ksys_old_msgctl(msqid, cmd, buf);
+}
+#endif
+
 #ifdef CONFIG_COMPAT
 
 struct compat_msqid_ds {
@@ -689,12 +701,11 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 	}
 }
 
-long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr)
+static long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr, int version)
 {
 	struct ipc_namespace *ns;
 	int err;
 	struct msqid64_ds msqid64;
-	int version = compat_ipc_parse_version(&cmd);
 
 	ns = current->nsproxy->ipc_ns;
 
@@ -734,8 +745,22 @@ long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr)
 
 COMPAT_SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, void __user *, uptr)
 {
-	return compat_ksys_msgctl(msqid, cmd, uptr);
+	return compat_ksys_msgctl(msqid, cmd, uptr, IPC_64);
 }
+
+#ifdef CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+long compat_ksys_old_msgctl(int msqid, int cmd, void __user *uptr)
+{
+	int version = compat_ipc_parse_version(&cmd);
+
+	return compat_ksys_msgctl(msqid, cmd, uptr, version);
+}
+
+COMPAT_SYSCALL_DEFINE3(old_msgctl, int, msqid, int, cmd, void __user *, uptr)
+{
+	return compat_ksys_old_msgctl(msqid, cmd, uptr);
+}
+#endif
 #endif
 
 static int testmsg(struct msg_msg *msg, long type, int mode)
diff --git a/ipc/sem.c b/ipc/sem.c
index 745dc6187e84..80909464acff 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1634,9 +1634,8 @@ static int semctl_down(struct ipc_namespace *ns, int semid,
 	return err;
 }
 
-long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg)
+static long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg, int version)
 {
-	int version;
 	struct ipc_namespace *ns;
 	void __user *p = (void __user *)arg;
 	struct semid64_ds semid64;
@@ -1645,7 +1644,6 @@ long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg)
 	if (semid < 0)
 		return -EINVAL;
 
-	version = ipc_parse_version(&cmd);
 	ns = current->nsproxy->ipc_ns;
 
 	switch (cmd) {
@@ -1691,9 +1689,23 @@ long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg)
 
 SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
 {
-	return ksys_semctl(semid, semnum, cmd, arg);
+	return ksys_semctl(semid, semnum, cmd, arg, IPC_64);
 }
 
+#ifdef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
+long ksys_old_semctl(int semid, int semnum, int cmd, unsigned long arg)
+{
+	int version = ipc_parse_version(&cmd);
+
+	return ksys_semctl(semid, semnum, cmd, arg, version);
+}
+
+SYSCALL_DEFINE4(old_semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
+{
+	return ksys_old_semctl(semid, semnum, cmd, arg);
+}
+#endif
+
 #ifdef CONFIG_COMPAT
 
 struct compat_semid_ds {
@@ -1744,12 +1756,11 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 	}
 }
 
-long compat_ksys_semctl(int semid, int semnum, int cmd, int arg)
+static long compat_ksys_semctl(int semid, int semnum, int cmd, int arg, int version)
 {
 	void __user *p = compat_ptr(arg);
 	struct ipc_namespace *ns;
 	struct semid64_ds semid64;
-	int version = compat_ipc_parse_version(&cmd);
 	int err;
 
 	ns = current->nsproxy->ipc_ns;
@@ -1792,8 +1803,22 @@ long compat_ksys_semctl(int semid, int semnum, int cmd, int arg)
 
 COMPAT_SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, int, arg)
 {
-	return compat_ksys_semctl(semid, semnum, cmd, arg);
+	return compat_ksys_semctl(semid, semnum, cmd, arg, IPC_64);
 }
+
+#ifdef CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+long compat_ksys_old_semctl(int semid, int semnum, int cmd, int arg)
+{
+	int version = compat_ipc_parse_version(&cmd);
+
+	return compat_ksys_semctl(semid, semnum, cmd, arg, version);
+}
+
+COMPAT_SYSCALL_DEFINE4(old_semctl, int, semid, int, semnum, int, cmd, int, arg)
+{
+	return compat_ksys_old_semctl(semid, semnum, cmd, arg);
+}
+#endif
 #endif
 
 /* If the task doesn't already have a undo_list, then allocate one
@@ -2225,7 +2250,7 @@ long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 	return do_semtimedop(semid, tsems, nsops, NULL);
 }
 
-COMPAT_SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsems,
+SYSCALL_DEFINE4(semtimedop_time32, int, semid, struct sembuf __user *, tsems,
 		       unsigned int, nsops,
 		       const struct old_timespec32 __user *, timeout)
 {
diff --git a/ipc/shm.c b/ipc/shm.c
index 0842411cb0e9..ce1ca9f7c6e9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1137,16 +1137,15 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
 	return err;
 }
 
-long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf)
+static long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf, int version)
 {
-	int err, version;
+	int err;
 	struct ipc_namespace *ns;
 	struct shmid64_ds sem64;
 
 	if (cmd < 0 || shmid < 0)
 		return -EINVAL;
 
-	version = ipc_parse_version(&cmd);
 	ns = current->nsproxy->ipc_ns;
 
 	switch (cmd) {
@@ -1194,8 +1193,22 @@ long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf)
 
 SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
 {
-	return ksys_shmctl(shmid, cmd, buf);
+	return ksys_shmctl(shmid, cmd, buf, IPC_64);
+}
+
+#ifdef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
+long ksys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf)
+{
+	int version = ipc_parse_version(&cmd);
+
+	return ksys_shmctl(shmid, cmd, buf, version);
+}
+
+SYSCALL_DEFINE3(old_shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
+{
+	return ksys_old_shmctl(shmid, cmd, buf);
 }
+#endif
 
 #ifdef CONFIG_COMPAT
 
@@ -1319,11 +1332,10 @@ static int copy_compat_shmid_from_user(struct shmid64_ds *out, void __user *buf,
 	}
 }
 
-long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr)
+long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr, int version)
 {
 	struct ipc_namespace *ns;
 	struct shmid64_ds sem64;
-	int version = compat_ipc_parse_version(&cmd);
 	int err;
 
 	ns = current->nsproxy->ipc_ns;
@@ -1378,8 +1390,22 @@ long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr)
 
 COMPAT_SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, void __user *, uptr)
 {
-	return compat_ksys_shmctl(shmid, cmd, uptr);
+	return compat_ksys_shmctl(shmid, cmd, uptr, IPC_64);
 }
+
+#ifdef CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+long compat_ksys_old_shmctl(int shmid, int cmd, void __user *uptr)
+{
+	int version = compat_ipc_parse_version(&cmd);
+
+	return compat_ksys_shmctl(shmid, cmd, uptr, version);
+}
+
+COMPAT_SYSCALL_DEFINE3(old_shmctl, int, shmid, int, cmd, void __user *, uptr)
+{
+	return compat_ksys_old_shmctl(shmid, cmd, uptr);
+}
+#endif
 #endif
 
 /*
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 1ac06e3983c0..581bdff4e7c5 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -17,8 +17,8 @@
 #include <linux/shm.h>
 #include <linux/uaccess.h>
 
-SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
-		unsigned long, third, void __user *, ptr, long, fifth)
+int ksys_ipc(unsigned int call, int first, unsigned long second,
+	unsigned long third, void __user * ptr, long fifth)
 {
 	int version, ret;
 
@@ -47,7 +47,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 			return -EINVAL;
 		if (get_user(arg, (unsigned long __user *) ptr))
 			return -EFAULT;
-		return ksys_semctl(first, second, third, arg);
+		return ksys_old_semctl(first, second, third, arg);
 	}
 
 	case MSGSND:
@@ -75,7 +75,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 	case MSGGET:
 		return ksys_msgget((key_t) first, second);
 	case MSGCTL:
-		return ksys_msgctl(first, second,
+		return ksys_old_msgctl(first, second,
 				   (struct msqid_ds __user *)ptr);
 
 	case SHMAT:
@@ -100,12 +100,18 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 	case SHMGET:
 		return ksys_shmget(first, second, third);
 	case SHMCTL:
-		return ksys_shmctl(first, second,
+		return ksys_old_shmctl(first, second,
 				   (struct shmid_ds __user *) ptr);
 	default:
 		return -ENOSYS;
 	}
 }
+
+SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
+		unsigned long, third, void __user *, ptr, long, fifth)
+{
+	return ksys_ipc(call, first, second, third, ptr, fifth);
+}
 #endif
 
 #ifdef CONFIG_COMPAT
@@ -121,8 +127,8 @@ struct compat_ipc_kludge {
 };
 
 #ifdef CONFIG_ARCH_WANT_OLD_COMPAT_IPC
-COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
-	u32, third, compat_uptr_t, ptr, u32, fifth)
+int compat_ksys_ipc(u32 call, int first, int second,
+	u32 third, compat_uptr_t ptr, u32 fifth)
 {
 	int version;
 	u32 pad;
@@ -146,7 +152,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 			return -EINVAL;
 		if (get_user(pad, (u32 __user *) compat_ptr(ptr)))
 			return -EFAULT;
-		return compat_ksys_semctl(first, second, third, pad);
+		return compat_ksys_old_semctl(first, second, third, pad);
 
 	case MSGSND:
 		return compat_ksys_msgsnd(first, ptr, second, third);
@@ -171,7 +177,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 	case MSGGET:
 		return ksys_msgget(first, second);
 	case MSGCTL:
-		return compat_ksys_msgctl(first, second, compat_ptr(ptr));
+		return compat_ksys_old_msgctl(first, second, compat_ptr(ptr));
 
 	case SHMAT: {
 		int err;
@@ -190,10 +196,16 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 	case SHMGET:
 		return ksys_shmget(first, (unsigned int)second, third);
 	case SHMCTL:
-		return compat_ksys_shmctl(first, second, compat_ptr(ptr));
+		return compat_ksys_old_shmctl(first, second, compat_ptr(ptr));
 	}
 
 	return -ENOSYS;
 }
+
+COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
+	u32, third, compat_uptr_t, ptr, u32, fifth)
+{
+	return compat_ksys_ipc(call, first, second, third, ptr, fifth);
+}
 #endif
 #endif
diff --git a/ipc/util.h b/ipc/util.h
index d768fdbed515..e272be622ae7 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -160,10 +160,7 @@ static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
 	}
 }
 
-#ifndef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
-/* On IA-64, we always use the "64-bit version" of the IPC structures.  */
-# define ipc_parse_version(cmd)	IPC_64
-#else
+#ifdef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
 int ipc_parse_version(int *cmd);
 #endif
 
@@ -246,13 +243,9 @@ int get_compat_ipc64_perm(struct ipc64_perm *,
 
 static inline int compat_ipc_parse_version(int *cmd)
 {
-#ifdef	CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	int version = *cmd & IPC_64;
 	*cmd &= ~IPC_64;
 	return version;
-#else
-	return IPC_64;
-#endif
 }
 #endif
 
@@ -261,29 +254,29 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
 		     const struct __kernel_timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
-long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
+long ksys_old_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
-long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
+long ksys_old_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 long ksys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
 		 long msgtyp, int msgflg);
 long ksys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz,
 		 int msgflg);
 long ksys_shmget(key_t key, size_t size, int shmflg);
 long ksys_shmdt(char __user *shmaddr);
-long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
+long ksys_old_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct old_timespec32 __user *timeout);
 #ifdef CONFIG_COMPAT
-long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
-long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
+long compat_ksys_old_semctl(int semid, int semnum, int cmd, int arg);
+long compat_ksys_old_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
 			compat_long_t msgtyp, int msgflg);
 long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
 		       compat_ssize_t msgsz, int msgflg);
-long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr);
+long compat_ksys_old_shmctl(int shmid, int cmd, void __user *uptr);
 #endif /* CONFIG_COMPAT */
 
 #endif
diff --git a/kernel/compat.c b/kernel/compat.c
index f01affa17e22..d8a36c6ad7c9 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -20,7 +20,6 @@
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/security.h>
-#include <linux/timex.h>
 #include <linux/export.h>
 #include <linux/migrate.h>
 #include <linux/posix-timers.h>
@@ -30,69 +29,6 @@
 
 #include <linux/uaccess.h>
 
-int compat_get_timex(struct timex *txc, const struct compat_timex __user *utp)
-{
-	struct compat_timex tx32;
-
-	memset(txc, 0, sizeof(struct timex));
-	if (copy_from_user(&tx32, utp, sizeof(struct compat_timex)))
-		return -EFAULT;
-
-	txc->modes = tx32.modes;
-	txc->offset = tx32.offset;
-	txc->freq = tx32.freq;
-	txc->maxerror = tx32.maxerror;
-	txc->esterror = tx32.esterror;
-	txc->status = tx32.status;
-	txc->constant = tx32.constant;
-	txc->precision = tx32.precision;
-	txc->tolerance = tx32.tolerance;
-	txc->time.tv_sec = tx32.time.tv_sec;
-	txc->time.tv_usec = tx32.time.tv_usec;
-	txc->tick = tx32.tick;
-	txc->ppsfreq = tx32.ppsfreq;
-	txc->jitter = tx32.jitter;
-	txc->shift = tx32.shift;
-	txc->stabil = tx32.stabil;
-	txc->jitcnt = tx32.jitcnt;
-	txc->calcnt = tx32.calcnt;
-	txc->errcnt = tx32.errcnt;
-	txc->stbcnt = tx32.stbcnt;
-
-	return 0;
-}
-
-int compat_put_timex(struct compat_timex __user *utp, const struct timex *txc)
-{
-	struct compat_timex tx32;
-
-	memset(&tx32, 0, sizeof(struct compat_timex));
-	tx32.modes = txc->modes;
-	tx32.offset = txc->offset;
-	tx32.freq = txc->freq;
-	tx32.maxerror = txc->maxerror;
-	tx32.esterror = txc->esterror;
-	tx32.status = txc->status;
-	tx32.constant = txc->constant;
-	tx32.precision = txc->precision;
-	tx32.tolerance = txc->tolerance;
-	tx32.time.tv_sec = txc->time.tv_sec;
-	tx32.time.tv_usec = txc->time.tv_usec;
-	tx32.tick = txc->tick;
-	tx32.ppsfreq = txc->ppsfreq;
-	tx32.jitter = txc->jitter;
-	tx32.shift = txc->shift;
-	tx32.stabil = txc->stabil;
-	tx32.jitcnt = txc->jitcnt;
-	tx32.calcnt = txc->calcnt;
-	tx32.errcnt = txc->errcnt;
-	tx32.stbcnt = txc->stbcnt;
-	tx32.tai = txc->tai;
-	if (copy_to_user(utp, &tx32, sizeof(struct compat_timex)))
-		return -EFAULT;
-	return 0;
-}
-
 static int __compat_get_timeval(struct timeval *tv, const struct old_timeval32 __user *ctv)
 {
 	return (!access_ok(ctv, sizeof(*ctv)) ||
diff --git a/kernel/futex.c b/kernel/futex.c
index fdd312da0992..26fb8a0909ad 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3815,7 +3815,7 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 #endif /* CONFIG_COMPAT */
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
+SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 		struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d8d76a65cfdd..c09d0bd9377a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5265,9 +5265,8 @@ SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
 }
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE2(sched_rr_get_interval,
-		       compat_pid_t, pid,
-		       struct old_timespec32 __user *, interval)
+SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t, pid,
+		struct old_timespec32 __user *, interval)
 {
 	struct timespec64 t;
 	int retval = sched_rr_get_interval(pid, &t);
diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..af27629918cf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3397,7 +3397,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time64, compat_sigset_t __user *, uthese,
 }
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
+COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32, compat_sigset_t __user *, uthese,
 		struct compat_siginfo __user *, uinfo,
 		struct old_timespec32 __user *, uts, compat_size_t, sigsetsize)
 {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index ab9d0e3c6d50..85e5ccec0955 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -42,9 +42,11 @@ COND_SYSCALL(io_destroy);
 COND_SYSCALL(io_submit);
 COND_SYSCALL_COMPAT(io_submit);
 COND_SYSCALL(io_cancel);
+COND_SYSCALL(io_getevents_time32);
 COND_SYSCALL(io_getevents);
+COND_SYSCALL(io_pgetevents_time32);
 COND_SYSCALL(io_pgetevents);
-COND_SYSCALL_COMPAT(io_getevents);
+COND_SYSCALL_COMPAT(io_pgetevents_time32);
 COND_SYSCALL_COMPAT(io_pgetevents);
 
 /* fs/xattr.c */
@@ -114,9 +116,9 @@ COND_SYSCALL_COMPAT(signalfd4);
 /* fs/timerfd.c */
 COND_SYSCALL(timerfd_create);
 COND_SYSCALL(timerfd_settime);
-COND_SYSCALL_COMPAT(timerfd_settime);
+COND_SYSCALL(timerfd_settime32);
 COND_SYSCALL(timerfd_gettime);
-COND_SYSCALL_COMPAT(timerfd_gettime);
+COND_SYSCALL(timerfd_gettime32);
 
 /* fs/utimes.c */
 
@@ -135,7 +137,7 @@ COND_SYSCALL(capset);
 
 /* kernel/futex.c */
 COND_SYSCALL(futex);
-COND_SYSCALL_COMPAT(futex);
+COND_SYSCALL(futex_time32);
 COND_SYSCALL(set_robust_list);
 COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
@@ -187,9 +189,9 @@ COND_SYSCALL(mq_open);
 COND_SYSCALL_COMPAT(mq_open);
 COND_SYSCALL(mq_unlink);
 COND_SYSCALL(mq_timedsend);
-COND_SYSCALL_COMPAT(mq_timedsend);
+COND_SYSCALL(mq_timedsend_time32);
 COND_SYSCALL(mq_timedreceive);
-COND_SYSCALL_COMPAT(mq_timedreceive);
+COND_SYSCALL(mq_timedreceive_time32);
 COND_SYSCALL(mq_notify);
 COND_SYSCALL_COMPAT(mq_notify);
 COND_SYSCALL(mq_getsetattr);
@@ -197,6 +199,7 @@ COND_SYSCALL_COMPAT(mq_getsetattr);
 
 /* ipc/msg.c */
 COND_SYSCALL(msgget);
+COND_SYSCALL(old_msgctl);
 COND_SYSCALL(msgctl);
 COND_SYSCALL_COMPAT(msgctl);
 COND_SYSCALL(msgrcv);
@@ -206,14 +209,16 @@ COND_SYSCALL_COMPAT(msgsnd);
 
 /* ipc/sem.c */
 COND_SYSCALL(semget);
+COND_SYSCALL(old_semctl);
 COND_SYSCALL(semctl);
 COND_SYSCALL_COMPAT(semctl);
 COND_SYSCALL(semtimedop);
-COND_SYSCALL_COMPAT(semtimedop);
+COND_SYSCALL(semtimedop_time32);
 COND_SYSCALL(semop);
 
 /* ipc/shm.c */
 COND_SYSCALL(shmget);
+COND_SYSCALL(old_shmctl);
 COND_SYSCALL(shmctl);
 COND_SYSCALL_COMPAT(shmctl);
 COND_SYSCALL(shmat);
@@ -285,7 +290,7 @@ COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
 COND_SYSCALL(recvmmsg);
 COND_SYSCALL(recvmmsg_time32);
-COND_SYSCALL_COMPAT(recvmmsg);
+COND_SYSCALL_COMPAT(recvmmsg_time32);
 COND_SYSCALL_COMPAT(recvmmsg_time64);
 
 /*
@@ -366,6 +371,7 @@ COND_SYSCALL(kexec_file_load);
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);
 COND_SYSCALL(s390_pci_mmio_write);
+COND_SYSCALL(s390_ipc);
 COND_SYSCALL_COMPAT(s390_ipc);
 
 /* powerpc */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f5cfa1b73d6f..0f5f96075110 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1771,7 +1771,7 @@ SYSCALL_DEFINE2(nanosleep, struct __kernel_timespec __user *, rqtp,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
-COMPAT_SYSCALL_DEFINE2(nanosleep, struct old_timespec32 __user *, rqtp,
+SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 		       struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 tu;
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 36a2bef00125..92a90014a925 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -188,13 +188,13 @@ static inline int is_error_status(int status)
 			&& (status & (STA_PPSWANDER|STA_PPSERROR)));
 }
 
-static inline void pps_fill_timex(struct timex *txc)
+static inline void pps_fill_timex(struct __kernel_timex *txc)
 {
 	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->jitter	   = pps_jitter;
 	if (!(time_status & STA_NANO))
-		txc->jitter /= NSEC_PER_USEC;
+		txc->jitter = pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = pps_shift;
 	txc->stabil	   = pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
@@ -220,7 +220,7 @@ static inline int is_error_status(int status)
 	return status & (STA_UNSYNC|STA_CLOCKERR);
 }
 
-static inline void pps_fill_timex(struct timex *txc)
+static inline void pps_fill_timex(struct __kernel_timex *txc)
 {
 	/* PPS is not implemented, so these are zero */
 	txc->ppsfreq	   = 0;
@@ -633,7 +633,7 @@ void ntp_notify_cmos_timer(void)
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(const struct timex *txc)
+static inline void process_adj_status(const struct __kernel_timex *txc)
 {
 	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		time_state = TIME_OK;
@@ -656,7 +656,8 @@ static inline void process_adj_status(const struct timex *txc)
 }
 
 
-static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai)
+static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
+					  s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
 		process_adj_status(txc);
@@ -707,7 +708,8 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
  * adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
+int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
+		  s32 *time_tai)
 {
 	int result;
 
@@ -729,7 +731,7 @@ int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
 		if (!(time_status & STA_NANO))
-			txc->offset /= NSEC_PER_USEC;
+			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
 
 	result = time_state;	/* mostly `TIME_OK' */
@@ -754,7 +756,7 @@ int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
 	txc->time.tv_sec = (time_t)ts->tv_sec;
 	txc->time.tv_usec = ts->tv_nsec;
 	if (!(time_status & STA_NANO))
-		txc->time.tv_usec /= NSEC_PER_USEC;
+		txc->time.tv_usec = ts->tv_nsec / NSEC_PER_USEC;
 
 	/* Handle leapsec adjustments */
 	if (unlikely(ts->tv_sec >= ntp_next_leap_sec)) {
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index c24b0e13f011..40e6122e634e 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,6 +8,6 @@ extern void ntp_clear(void);
 extern u64 ntp_tick_length(void);
 extern ktime_t ntp_get_next_leap(void);
 extern int second_overflow(time64_t secs);
-extern int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai);
+extern int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts, s32 *time_tai);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 425bbfce6819..ec960bb939fd 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -228,7 +228,7 @@ static void put_clock_desc(struct posix_clock_desc *cd)
 	fput(cd->fp);
 }
 
-static int pc_clock_adjtime(clockid_t id, struct timex *tx)
+static int pc_clock_adjtime(clockid_t id, struct __kernel_timex *tx)
 {
 	struct posix_clock_desc cd;
 	int err;
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index a51895486e5e..67df65f887ac 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -45,6 +45,7 @@ SYS_NI(timer_delete);
 SYS_NI(clock_adjtime);
 SYS_NI(getitimer);
 SYS_NI(setitimer);
+SYS_NI(clock_adjtime32);
 #ifdef __ARCH_WANT_SYS_ALARM
 SYS_NI(alarm);
 #endif
@@ -150,16 +151,16 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYS_NI(timer_create);
-COMPAT_SYS_NI(clock_adjtime);
-COMPAT_SYS_NI(timer_settime);
-COMPAT_SYS_NI(timer_gettime);
 COMPAT_SYS_NI(getitimer);
 COMPAT_SYS_NI(setitimer);
 #endif
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
-		       struct old_timespec32 __user *, tp)
+SYS_NI(timer_settime32);
+SYS_NI(timer_gettime32);
+
+SYSCALL_DEFINE2(clock_settime32, const clockid_t, which_clock,
+		struct old_timespec32 __user *, tp)
 {
 	struct timespec64 new_tp;
 
@@ -171,8 +172,8 @@ COMPAT_SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 	return do_sys_settimeofday64(&new_tp, NULL);
 }
 
-COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
-		       struct old_timespec32 __user *, tp)
+SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
+		struct old_timespec32 __user *, tp)
 {
 	int ret;
 	struct timespec64 kernel_tp;
@@ -186,8 +187,8 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
-		       struct old_timespec32 __user *, tp)
+SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
+		struct old_timespec32 __user *, tp)
 {
 	struct timespec64 rtn_tp = {
 		.tv_sec = 0,
@@ -206,9 +207,9 @@ COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
 	}
 }
 
-COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
-		       struct old_timespec32 __user *, rqtp,
-		       struct old_timespec32 __user *, rmtp)
+SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
+		struct old_timespec32 __user *, rqtp,
+		struct old_timespec32 __user *, rmtp)
 {
 	struct timespec64 t;
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0e84bb72a3da..29176635991f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -179,7 +179,7 @@ static int posix_clock_realtime_set(const clockid_t which_clock,
 }
 
 static int posix_clock_realtime_adj(const clockid_t which_clock,
-				    struct timex *t)
+				    struct __kernel_timex *t)
 {
 	return do_adjtimex(t);
 }
@@ -730,8 +730,8 @@ SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
-COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
-		       struct old_itimerspec32 __user *, setting)
+SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
+		struct old_itimerspec32 __user *, setting)
 {
 	struct itimerspec64 cur_setting;
 
@@ -903,9 +903,9 @@ SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
 }
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
-		       struct old_itimerspec32 __user *, new,
-		       struct old_itimerspec32 __user *, old)
+SYSCALL_DEFINE4(timer_settime32, timer_t, timer_id, int, flags,
+		struct old_itimerspec32 __user *, new,
+		struct old_itimerspec32 __user *, old)
 {
 	struct itimerspec64 new_spec, old_spec;
 	struct itimerspec64 *rtn = old ? &old_spec : NULL;
@@ -1047,22 +1047,28 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	return error;
 }
 
-SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex * ktx)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
-	struct timex ktx;
-	int err;
 
 	if (!kc)
 		return -EINVAL;
 	if (!kc->clock_adj)
 		return -EOPNOTSUPP;
 
+	return kc->clock_adj(which_clock, ktx);
+}
+
+SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
+		struct __kernel_timex __user *, utx)
+{
+	struct __kernel_timex ktx;
+	int err;
+
 	if (copy_from_user(&ktx, utx, sizeof(ktx)))
 		return -EFAULT;
 
-	err = kc->clock_adj(which_clock, &ktx);
+	err = do_clock_adjtime(which_clock, &ktx);
 
 	if (err >= 0 && copy_to_user(utx, &ktx, sizeof(ktx)))
 		return -EFAULT;
@@ -1090,8 +1096,8 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
-COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
-		       struct old_timespec32 __user *, tp)
+SYSCALL_DEFINE2(clock_settime32, clockid_t, which_clock,
+		struct old_timespec32 __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 ts;
@@ -1105,8 +1111,8 @@ COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
 	return kc->clock_set(which_clock, &ts);
 }
 
-COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
-		       struct old_timespec32 __user *, tp)
+SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
+		struct old_timespec32 __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 ts;
@@ -1123,40 +1129,26 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT
-
-COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
-		       struct compat_timex __user *, utp)
+SYSCALL_DEFINE2(clock_adjtime32, clockid_t, which_clock,
+		struct old_timex32 __user *, utp)
 {
-	const struct k_clock *kc = clockid_to_kclock(which_clock);
-	struct timex ktx;
+	struct __kernel_timex ktx;
 	int err;
 
-	if (!kc)
-		return -EINVAL;
-	if (!kc->clock_adj)
-		return -EOPNOTSUPP;
-
-	err = compat_get_timex(&ktx, utp);
+	err = get_old_timex32(&ktx, utp);
 	if (err)
 		return err;
 
-	err = kc->clock_adj(which_clock, &ktx);
+	err = do_clock_adjtime(which_clock, &ktx);
 
 	if (err >= 0)
-		err = compat_put_timex(utp, &ktx);
+		err = put_old_timex32(utp, &ktx);
 
 	return err;
 }
 
-#endif
-
-#ifdef CONFIG_COMPAT_32BIT_TIME
-
-COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
-		       struct old_timespec32 __user *, tp)
+SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
+		struct old_timespec32 __user *, tp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 ts;
@@ -1212,9 +1204,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
 
-COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
-		       struct old_timespec32 __user *, rqtp,
-		       struct old_timespec32 __user *, rmtp)
+SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
+		struct old_timespec32 __user *, rqtp,
+		struct old_timespec32 __user *, rmtp)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timespec64 t;
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index ddb21145211a..de5daa6d975a 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -8,7 +8,7 @@ struct k_clock {
 			     const struct timespec64 *tp);
 	int	(*clock_get)(const clockid_t which_clock,
 			     struct timespec64 *tp);
-	int	(*clock_adj)(const clockid_t which_clock, struct timex *tx);
+	int	(*clock_adj)(const clockid_t which_clock, struct __kernel_timex *tx);
 	int	(*timer_create)(struct k_itimer *timer);
 	int	(*nsleep)(const clockid_t which_clock, int flags,
 			  const struct timespec64 *);
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 2edb5088a70b..c3f756f8534b 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -98,11 +98,11 @@ SYSCALL_DEFINE1(stime, time_t __user *, tptr)
 
 #endif /* __ARCH_WANT_SYS_TIME */
 
-#ifdef CONFIG_COMPAT
-#ifdef __ARCH_WANT_COMPAT_SYS_TIME
+#ifdef CONFIG_COMPAT_32BIT_TIME
+#ifdef __ARCH_WANT_SYS_TIME32
 
 /* old_time32_t is a 32 bit "long" and needs to get converted. */
-COMPAT_SYSCALL_DEFINE1(time, old_time32_t __user *, tloc)
+SYSCALL_DEFINE1(time32, old_time32_t __user *, tloc)
 {
 	old_time32_t i;
 
@@ -116,7 +116,7 @@ COMPAT_SYSCALL_DEFINE1(time, old_time32_t __user *, tloc)
 	return i;
 }
 
-COMPAT_SYSCALL_DEFINE1(stime, old_time32_t __user *, tptr)
+SYSCALL_DEFINE1(stime32, old_time32_t __user *, tptr)
 {
 	struct timespec64 tv;
 	int err;
@@ -134,7 +134,7 @@ COMPAT_SYSCALL_DEFINE1(stime, old_time32_t __user *, tptr)
 	return 0;
 }
 
-#endif /* __ARCH_WANT_COMPAT_SYS_TIME */
+#endif /* __ARCH_WANT_SYS_TIME32 */
 #endif
 
 SYSCALL_DEFINE2(gettimeofday, struct timeval __user *, tv,
@@ -263,35 +263,99 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 }
 #endif
 
-SYSCALL_DEFINE1(adjtimex, struct timex __user *, txc_p)
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
+	struct __kernel_timex txc;		/* Local copy of parameter */
 	int ret;
 
 	/* Copy the user data space into the kernel copy
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(struct __kernel_timex)))
 		return -EFAULT;
 	ret = do_adjtimex(&txc);
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(struct __kernel_timex)) ? -EFAULT : ret;
 }
+#endif
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
+int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user *utp)
+{
+	struct old_timex32 tx32;
+
+	memset(txc, 0, sizeof(struct __kernel_timex));
+	if (copy_from_user(&tx32, utp, sizeof(struct old_timex32)))
+		return -EFAULT;
+
+	txc->modes = tx32.modes;
+	txc->offset = tx32.offset;
+	txc->freq = tx32.freq;
+	txc->maxerror = tx32.maxerror;
+	txc->esterror = tx32.esterror;
+	txc->status = tx32.status;
+	txc->constant = tx32.constant;
+	txc->precision = tx32.precision;
+	txc->tolerance = tx32.tolerance;
+	txc->time.tv_sec = tx32.time.tv_sec;
+	txc->time.tv_usec = tx32.time.tv_usec;
+	txc->tick = tx32.tick;
+	txc->ppsfreq = tx32.ppsfreq;
+	txc->jitter = tx32.jitter;
+	txc->shift = tx32.shift;
+	txc->stabil = tx32.stabil;
+	txc->jitcnt = tx32.jitcnt;
+	txc->calcnt = tx32.calcnt;
+	txc->errcnt = tx32.errcnt;
+	txc->stbcnt = tx32.stbcnt;
+
+	return 0;
+}
+
+int put_old_timex32(struct old_timex32 __user *utp, const struct __kernel_timex *txc)
+{
+	struct old_timex32 tx32;
+
+	memset(&tx32, 0, sizeof(struct old_timex32));
+	tx32.modes = txc->modes;
+	tx32.offset = txc->offset;
+	tx32.freq = txc->freq;
+	tx32.maxerror = txc->maxerror;
+	tx32.esterror = txc->esterror;
+	tx32.status = txc->status;
+	tx32.constant = txc->constant;
+	tx32.precision = txc->precision;
+	tx32.tolerance = txc->tolerance;
+	tx32.time.tv_sec = txc->time.tv_sec;
+	tx32.time.tv_usec = txc->time.tv_usec;
+	tx32.tick = txc->tick;
+	tx32.ppsfreq = txc->ppsfreq;
+	tx32.jitter = txc->jitter;
+	tx32.shift = txc->shift;
+	tx32.stabil = txc->stabil;
+	tx32.jitcnt = txc->jitcnt;
+	tx32.calcnt = txc->calcnt;
+	tx32.errcnt = txc->errcnt;
+	tx32.stbcnt = txc->stbcnt;
+	tx32.tai = txc->tai;
+	if (copy_to_user(utp, &tx32, sizeof(struct old_timex32)))
+		return -EFAULT;
+	return 0;
+}
 
-COMPAT_SYSCALL_DEFINE1(adjtimex, struct compat_timex __user *, utp)
+SYSCALL_DEFINE1(adjtimex_time32, struct old_timex32 __user *, utp)
 {
-	struct timex txc;
+	struct __kernel_timex txc;
 	int err, ret;
 
-	err = compat_get_timex(&txc, utp);
+	err = get_old_timex32(&txc, utp);
 	if (err)
 		return err;
 
 	ret = do_adjtimex(&txc);
 
-	err = compat_put_timex(utp, &txc);
+	err = put_old_timex32(utp, &txc);
 	if (err)
 		return err;
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ac5dbf2cd4a2..f986e1918d12 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2234,7 +2234,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 /**
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
-static int timekeeping_validate_timex(const struct timex *txc)
+static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
@@ -2300,7 +2300,7 @@ static int timekeeping_validate_timex(const struct timex *txc)
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
  */
-int do_adjtimex(struct timex *txc)
+int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
diff --git a/net/compat.c b/net/compat.c
index 959d1c51826d..2fef7b9db434 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -822,7 +822,7 @@ COMPAT_SYSCALL_DEFINE5(recvmmsg_time64, int, fd, struct compat_mmsghdr __user *,
 }
 
 #ifdef CONFIG_COMPAT_32BIT_TIME
-COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+COMPAT_SYSCALL_DEFINE5(recvmmsg_time32, int, fd, struct compat_mmsghdr __user *, mmsg,
 		       unsigned int, vlen, unsigned int, flags,
 		       struct old_timespec32 __user *, timeout)
 {
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index cf931003395f..a18b47695f55 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -30,12 +30,14 @@ cat << EOF
 #define __IGNORE_readlink	/* readlinkat */
 #define __IGNORE_symlink	/* symlinkat */
 #define __IGNORE_utimes		/* futimesat */
-#if BITS_PER_LONG == 64
 #define __IGNORE_stat		/* fstatat */
 #define __IGNORE_lstat		/* fstatat */
-#else
 #define __IGNORE_stat64		/* fstatat64 */
 #define __IGNORE_lstat64	/* fstatat64 */
+
+#ifndef __ARCH_WANT_SET_GET_RLIMIT
+#define __IGNORE_getrlimit	/* getrlimit */
+#define __IGNORE_setrlimit	/* setrlimit */
 #endif
 
 /* Missing flags argument */
@@ -84,6 +86,26 @@ cat << EOF
 #define __IGNORE_statfs64
 #define __IGNORE_llseek
 #define __IGNORE_mmap2
+#define __IGNORE_clock_gettime64
+#define __IGNORE_clock_settime64
+#define __IGNORE_clock_adjtime64
+#define __IGNORE_clock_getres_time64
+#define __IGNORE_clock_nanosleep_time64
+#define __IGNORE_timer_gettime64
+#define __IGNORE_timer_settime64
+#define __IGNORE_timerfd_gettime64
+#define __IGNORE_timerfd_settime64
+#define __IGNORE_utimensat_time64
+#define __IGNORE_pselect6_time64
+#define __IGNORE_ppoll_time64
+#define __IGNORE_io_pgetevents_time64
+#define __IGNORE_recvmmsg_time64
+#define __IGNORE_mq_timedsend_time64
+#define __IGNORE_mq_timedreceive_time64
+#define __IGNORE_semtimedop_time64
+#define __IGNORE_rt_sigtimedwait_time64
+#define __IGNORE_futex_time64
+#define __IGNORE_sched_rr_get_interval_time64
 #else
 #define __IGNORE_sendfile
 #define __IGNORE_ftruncate
@@ -98,6 +120,33 @@ cat << EOF
 #define __IGNORE_statfs
 #define __IGNORE_lseek
 #define __IGNORE_mmap
+#define __IGNORE_clock_gettime
+#define __IGNORE_clock_settime
+#define __IGNORE_clock_adjtime
+#define __IGNORE_clock_getres
+#define __IGNORE_clock_nanosleep
+#define __IGNORE_timer_gettime
+#define __IGNORE_timer_settime
+#define __IGNORE_timerfd_gettime
+#define __IGNORE_timerfd_settime
+#define __IGNORE_utimensat
+#define __IGNORE_pselect6
+#define __IGNORE_ppoll
+#define __IGNORE_io_pgetevents
+#define __IGNORE_recvmmsg
+#define __IGNORE_mq_timedsend
+#define __IGNORE_mq_timedreceive
+#define __IGNORE_semtimedop
+#define __IGNORE_rt_sigtimedwait
+#define __IGNORE_futex
+#define __IGNORE_sched_rr_get_interval
+#define __IGNORE_gettimeofday
+#define __IGNORE_settimeofday
+#define __IGNORE_wait4
+#define __IGNORE_adjtimex
+#define __IGNORE_nanosleep
+#define __IGNORE_io_getevents
+#define __IGNORE_recvmmsg
 #endif
 
 /* i386-specific or historical system calls */

