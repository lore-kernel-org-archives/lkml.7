Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DC12243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574243167;
	bh=e/IS2pBWaOg09uLOOG2B8kpIs9cs+w8+po6Zlbhs8Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cQbzoaGYWM13J6SOntu9xs8HsbSbClGdip7WN7zILpGgxe9DebT+bENZV5kOaSP12
	 B9/YbYXaRZoWn2TG1UbtztMSWsXYIuVm+3wBs4KeuNJNISLwSfOtVQBGQAYhqnJexu
	 Kdf3kenb6JxZrv7+IUx6lIEXGQUTSKKsxJu88WcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfKTJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:46:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40041 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfKTJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:46:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id q15so14499406wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RAhdh2tnItZ3POnX8c4y3ndSXIm0f8aUQEoZeMZ/B0=;
        b=sh3TwcZ7v491OTgiZk5NBHODp+Zdvo4R6zCpZTTYlWeiZ30evfKIaNIl8U7T0L+Sfe
         QHJpqWv1JEAgQMZg47nH8MY7039yZPxX3nbTtn0AboLw6+bdK4vYuluR4gcfBVF3wcGX
         ZxkGckBFTh5n5F/PqF2h4iKOEwP1jDvSFt7Nj+1zLAcqcZ98BVK96gxF2SZUb0v8pcpj
         3cYsxNulSW58A1qNYtrO5jrDNrrY6mh51KhcHZyq9sEJkKOiSAaQHpOjyfxizlYA1IKH
         cJlFAACBZNSEbO2BzBEVQmnmSIfsKn/HFcVOtt2+xQ/hJdxp5H0n54mjyKPH09wIC3eU
         78PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RAhdh2tnItZ3POnX8c4y3ndSXIm0f8aUQEoZeMZ/B0=;
        b=nyqYKp1fpqFyR6kmkPq/RvkNboBhgANQz/08aiPmh05kWIY40ue/zD5Io2MKkmfebf
         LTQoXxIAaKuqrDYYD026JDA9LkL2JGa+r6fyv/GIc9RDWMeAQ890NRt+QzazZOZA6hhk
         hTJ2xm/GgTj1/f+wU94dQTADWf9paXdlZtuJpxjxuysevMF/4N03DIpcPiFbwLOssJIr
         Pah4TX/ySvqQvwVfcp7CIoGR3GYleVSHfGJinR5rgOu0oEXNK7L3yN3IpE5A/WJh8GUh
         rQQ8v/F/+IUTtWCTrC4VxxzFZyvXkHjX8I7iOF7dct09X3yMARZgBWFGk74fY1sLX61C
         /Ocg==
X-Gm-Message-State: APjAAAUXDRxQo9uUII2LIOT8K6C3KdmNmmPEjZmi8UT05QdgHuYFZLEY
        H/R+vNsm7u2Esa3h/uNA5bQ=
X-Google-Smtp-Source: APXvYqz5RW0lTrp7SLdKhFZVBKUwXm4mE9xhRuYHhJbKVoIX0iVZnJ+/ODUf6/0CPdsMLBTW9oV3Pw==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr2014301wrv.7.1574243159736;
        Wed, 20 Nov 2019 01:45:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x8sm30225216wrm.7.2019.11.20.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 01:45:58 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:45:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT RFC PULL kcsan] KCSAN commits for 5.5
Message-ID: <20191120094556.GA83113@gmail.com>
References: <20191119145618.GA19028@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119145618.GA19028@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi Paul,

* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo,
> 
> This pull request contains base kernel concurrency sanitizer
> (KCSAN) enablement for x86, courtesy of Marco Elver.  KCSAN is a
> sampling watchpoint-based data-race detector, and is documented in
> Documentation/dev-tools/kcsan.rst.  KCSAN was announced in September,
> and much feedback has since been incorporated:
> 
> http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> 
> The data races located thus far have resulted in a number of fixes:
> 
> https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> 
> Additional information may be found here:
> 
> https://lore.kernel.org/lkml/20191114180303.66955-1-elver@google.com/
> 
> This has been subject to kbuild test robot and -next testing.  The
> -next testing located a Kconfig conflict called out here:
> 
> https://lore.kernel.org/lkml/20191119183042.5839ef00@canb.auug.org.au/
> 
> Marco is satisfied with Stephen's resolution, and it looks good to me
> as well.
> 
> The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:
> 
>   Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 40d04110f87940b6a03bf0aa19cd29e84f465f20:
> 
>   x86, kcsan: Enable KCSAN for x86 (2019-11-16 07:23:16 -0800)
> 
> ----------------------------------------------------------------
> Marco Elver (9):
>       kcsan: Add Kernel Concurrency Sanitizer infrastructure
>       include/linux/compiler.h: Introduce data_race(expr) macro
>       kcsan: Add Documentation entry in dev-tools
>       objtool, kcsan: Add KCSAN runtime functions to whitelist
>       build, kcsan: Add KCSAN build exceptions
>       seqlock, kcsan: Add annotations for KCSAN
>       seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
>       locking/atomics, kcsan: Add KCSAN instrumentation
>       x86, kcsan: Enable KCSAN for x86
> 
>  Documentation/dev-tools/index.rst         |   1 +
>  Documentation/dev-tools/kcsan.rst         | 256 ++++++++++++
>  MAINTAINERS                               |  11 +
>  Makefile                                  |   3 +-
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/boot/Makefile                    |   2 +
>  arch/x86/boot/compressed/Makefile         |   2 +
>  arch/x86/entry/vdso/Makefile              |   3 +
>  arch/x86/include/asm/bitops.h             |   6 +-
>  arch/x86/kernel/Makefile                  |   4 +
>  arch/x86/kernel/cpu/Makefile              |   3 +
>  arch/x86/lib/Makefile                     |   4 +
>  arch/x86/mm/Makefile                      |   4 +
>  arch/x86/purgatory/Makefile               |   2 +
>  arch/x86/realmode/Makefile                |   3 +
>  arch/x86/realmode/rm/Makefile             |   3 +
>  drivers/firmware/efi/libstub/Makefile     |   2 +
>  include/asm-generic/atomic-instrumented.h | 393 ++++++++++---------
>  include/linux/compiler-clang.h            |   9 +
>  include/linux/compiler-gcc.h              |   7 +
>  include/linux/compiler.h                  |  57 ++-
>  include/linux/kcsan-checks.h              |  97 +++++
>  include/linux/kcsan.h                     | 115 ++++++
>  include/linux/sched.h                     |   4 +
>  include/linux/seqlock.h                   |  51 ++-
>  init/init_task.c                          |   8 +
>  init/main.c                               |   2 +
>  kernel/Makefile                           |   6 +
>  kernel/kcsan/Makefile                     |  11 +
>  kernel/kcsan/atomic.h                     |  27 ++
>  kernel/kcsan/core.c                       | 626 ++++++++++++++++++++++++++++++
>  kernel/kcsan/debugfs.c                    | 275 +++++++++++++
>  kernel/kcsan/encoding.h                   |  94 +++++
>  kernel/kcsan/kcsan.h                      | 108 ++++++
>  kernel/kcsan/report.c                     | 320 +++++++++++++++
>  kernel/kcsan/test.c                       | 121 ++++++
>  kernel/sched/Makefile                     |   6 +
>  lib/Kconfig.debug                         |   2 +
>  lib/Kconfig.kcsan                         | 118 ++++++
>  lib/Makefile                              |   3 +
>  mm/Makefile                               |   8 +
>  scripts/Makefile.kcsan                    |   6 +
>  scripts/Makefile.lib                      |  10 +
>  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
>  tools/objtool/check.c                     |  18 +
>  45 files changed, 2623 insertions(+), 206 deletions(-)
>  create mode 100644 Documentation/dev-tools/kcsan.rst
>  create mode 100644 include/linux/kcsan-checks.h
>  create mode 100644 include/linux/kcsan.h
>  create mode 100644 kernel/kcsan/Makefile
>  create mode 100644 kernel/kcsan/atomic.h
>  create mode 100644 kernel/kcsan/core.c
>  create mode 100644 kernel/kcsan/debugfs.c
>  create mode 100644 kernel/kcsan/encoding.h
>  create mode 100644 kernel/kcsan/kcsan.h
>  create mode 100644 kernel/kcsan/report.c
>  create mode 100644 kernel/kcsan/test.c
>  create mode 100644 lib/Kconfig.kcsan
>  create mode 100644 scripts/Makefile.kcsan

Thanks - this looks clean and well-structured to me.

The biggest interaction with locking code is via the 
include/asm-generic/atomic-instrumented.h changes:

>  include/asm-generic/atomic-instrumented.h | 393 ++++++++++---------

But this is basically an instrumentation-cleanup patch that factors out 
the KASAN callbacks, and then ~2 more lines to add in the KCSAN 
callbacks, so in reality it's an overall win.

I couldn't help to notice & fix a few minor details while reading the 
patches, see the patch below. :-)

Anyway, I pulled it into tip:WIP.locking/kcsan with the intention of 
merging it over into tip:locking/kcsan in a couple of days if all goes 
well.

If anyone on Cc: has any objections then please holler!

Thanks,

	Ingo

=======================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 20 Nov 2019 10:41:43 +0100
Subject: [PATCH] kcsan: Improve code readability

  - Fix typos and grammar, improve wording.

  - Remove spurious newlines that are col80 warning artifacts where the
    resulting line-break is worse than the disease it's curing.

  - Use core kernel coding style to improve readability and reduce
    spurious code pattern variations.

  - Use better vertical alignment for structure definitions and initialization
    sequences.

  - Misc other small details.

No change in functionality intended.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig               |  2 +-
 include/linux/compiler-clang.h |  2 +-
 include/linux/compiler.h       |  2 +-
 include/linux/kcsan-checks.h   | 22 ++++++---------
 include/linux/kcsan.h          | 23 ++++++----------
 include/linux/seqlock.h        |  8 +++---
 kernel/kcsan/atomic.h          |  2 +-
 kernel/kcsan/core.c            | 59 ++++++++++++++++++----------------------
 kernel/kcsan/debugfs.c         | 62 ++++++++++++++++++++----------------------
 kernel/kcsan/encoding.h        | 25 +++++++++--------
 kernel/kcsan/kcsan.h           | 11 ++++----
 kernel/kcsan/report.c          | 42 ++++++++++++++--------------
 kernel/kcsan/test.c            |  6 ++--
 kernel/sched/Makefile          |  2 +-
 lib/Kconfig.kcsan              | 16 +++++------
 15 files changed, 131 insertions(+), 153 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 94351b2be3ca..a436266da7b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -226,7 +226,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
-	select HAVE_ARCH_KCSAN if X86_64
+	select HAVE_ARCH_KCSAN			if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index a213eb55e725..2cb42d8bdedc 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -16,7 +16,7 @@
 #define KASAN_ABI_VERSION 5
 
 #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
-/* emulate gcc's __SANITIZE_ADDRESS__ flag */
+/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
 		__attribute__((no_sanitize("address", "hwaddress")))
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7d3e77781578..ad8c76144a3c 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -313,7 +313,7 @@ unsigned long read_word_at_a_time(const void *addr)
 #include <linux/kcsan.h>
 
 /*
- * data_race: macro to document that accesses in an expression may conflict with
+ * data_race(): macro to document that accesses in an expression may conflict with
  * other concurrent accesses resulting in data races, but the resulting
  * behaviour is deemed safe regardless.
  *
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index e78220661086..ef3ee233a3fa 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -8,17 +8,17 @@
 /*
  * Access type modifiers.
  */
-#define KCSAN_ACCESS_WRITE 0x1
+#define KCSAN_ACCESS_WRITE  0x1
 #define KCSAN_ACCESS_ATOMIC 0x2
 
 /*
- * __kcsan_*: Always calls into runtime when KCSAN is enabled. This may be used
+ * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
  * even in compilation units that selectively disable KCSAN, but must use KCSAN
- * to validate access to an address.   Never use these in header files!
+ * to validate access to an address. Never use these in header files!
  */
 #ifdef CONFIG_KCSAN
 /**
- * __kcsan_check_access - check generic access for data race
+ * __kcsan_check_access - check generic access for data races
  *
  * @ptr address of access
  * @size size of access
@@ -32,7 +32,7 @@ static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 #endif
 
 /*
- * kcsan_*: Only calls into runtime when the particular compilation unit has
+ * kcsan_*: Only calls into the runtime when the particular compilation unit has
  * KCSAN instrumentation enabled. May be used in header files.
  */
 #ifdef __SANITIZE_THREAD__
@@ -77,16 +77,12 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
 /*
- * Check for atomic accesses: if atomic access are not ignored, this simply
- * aliases to kcsan_check_access, otherwise becomes a no-op.
+ * Check for atomic accesses: if atomic accesses are not ignored, this simply
+ * aliases to kcsan_check_access(), otherwise becomes a no-op.
  */
 #ifdef CONFIG_KCSAN_IGNORE_ATOMICS
-#define kcsan_check_atomic_read(...)                                           \
-	do {                                                                   \
-	} while (0)
-#define kcsan_check_atomic_write(...)                                          \
-	do {                                                                   \
-	} while (0)
+#define kcsan_check_atomic_read(...)	do { } while (0)
+#define kcsan_check_atomic_write(...)	do { } while (0)
 #else
 #define kcsan_check_atomic_read(ptr, size)                                     \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC)
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 9047048fee84..1019e3a2c689 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -94,21 +94,14 @@ void kcsan_atomic_next(int n);
 
 #else /* CONFIG_KCSAN */
 
-static inline void kcsan_init(void) { }
-
-static inline void kcsan_disable_current(void) { }
-
-static inline void kcsan_enable_current(void) { }
-
-static inline void kcsan_nestable_atomic_begin(void) { }
-
-static inline void kcsan_nestable_atomic_end(void) { }
-
-static inline void kcsan_flat_atomic_begin(void) { }
-
-static inline void kcsan_flat_atomic_end(void) { }
-
-static inline void kcsan_atomic_next(int n) { }
+static inline void kcsan_init(void)			{ }
+static inline void kcsan_disable_current(void)		{ }
+static inline void kcsan_enable_current(void)		{ }
+static inline void kcsan_nestable_atomic_begin(void)	{ }
+static inline void kcsan_nestable_atomic_end(void)	{ }
+static inline void kcsan_flat_atomic_begin(void)	{ }
+static inline void kcsan_flat_atomic_end(void)		{ }
+static inline void kcsan_atomic_next(int n)		{ }
 
 #endif /* CONFIG_KCSAN */
 
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index af5169a7f0c0..239701cae376 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -48,7 +48,7 @@
  *
  * As a consequence, we take the following best-effort approach for raw usage
  * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
- * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
+ * pessimistically mark the next KCSAN_SEQLOCK_REGION_MAX memory accesses as
  * atomics; if there is a matching read_seqcount_retry() call, no following
  * memory operations are considered atomic. Usage of seqlocks via seqlock_t
  * interface is not affected.
@@ -265,7 +265,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
- * Note that, writes surrounding the barrier should be declared atomic (e.g.
+ * Note that writes surrounding the barrier should be declared atomic (e.g.
  * via WRITE_ONCE): a) to ensure the writes become visible to other threads
  * atomically, avoiding compiler optimizations; b) to document which writes are
  * meant to propagate to the reader critical section. This is necessary because
@@ -465,7 +465,7 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
 	unsigned ret = read_seqcount_begin(&sl->seqcount);
 
-	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry */
+	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
 	kcsan_flat_atomic_begin();
 	return ret;
 }
@@ -473,7 +473,7 @@ static inline unsigned read_seqbegin(const seqlock_t *sl)
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
 	/*
-	 * Assume not nested: read_seqretry may be called multiple times when
+	 * Assume not nested: read_seqretry() may be called multiple times when
 	 * completing read critical section.
 	 */
 	kcsan_flat_atomic_end();
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index c9c3fe628011..576e03ddd6a3 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -6,7 +6,7 @@
 #include <linux/jiffies.h>
 
 /*
- * Helper that returns true if access to ptr should be considered as an atomic
+ * Helper that returns true if access to @ptr should be considered an atomic
  * access, even though it is not explicitly atomic.
  *
  * List all volatile globals that have been observed in races, to suppress
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d9410d58c93e..3314fc29e236 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -19,10 +19,10 @@ bool kcsan_enabled;
 
 /* Per-CPU kcsan_ctx for interrupts */
 static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
-	.disable_count = 0,
-	.atomic_next = 0,
-	.atomic_nest_count = 0,
-	.in_flat_atomic = false,
+	.disable_count		= 0,
+	.atomic_next		= 0,
+	.atomic_nest_count	= 0,
+	.in_flat_atomic		= false,
 };
 
 /*
@@ -50,11 +50,11 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
  *   slot=9:  [10, 11,  9]
  *   slot=63: [64, 65, 63]
  */
-#define NUM_SLOTS (1 + 2 * KCSAN_CHECK_ADJACENT)
+#define NUM_SLOTS (1 + 2*KCSAN_CHECK_ADJACENT)
 #define SLOT_IDX(slot, i) (slot + ((i + KCSAN_CHECK_ADJACENT) % NUM_SLOTS))
 
 /*
- * SLOT_IDX_FAST is used in fast-path. Not first checking the address's primary
+ * SLOT_IDX_FAST is used in the fast-path. Not first checking the address's primary
  * slot (middle) is fine if we assume that data races occur rarely. The set of
  * indices {SLOT_IDX(slot, i) | i in [0, NUM_SLOTS)} is equivalent to
  * {SLOT_IDX_FAST(slot, i) | i in [0, NUM_SLOTS)}.
@@ -68,9 +68,9 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
  * zero-initialized state matches INVALID_WATCHPOINT.
  *
  * Add NUM_SLOTS-1 entries to account for overflow; this helps avoid having to
- * use more complicated SLOT_IDX_FAST calculation with modulo in fast-path.
+ * use more complicated SLOT_IDX_FAST calculation with modulo in the fast-path.
  */
-static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS - 1];
+static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
 
 /*
  * Instructions to skip watching counter, used in should_watch(). We use a
@@ -78,7 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS - 1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
-static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
+static inline atomic_long_t *find_watchpoint(unsigned long addr,
+					     size_t size,
 					     bool expect_write,
 					     long *encoded_watchpoint)
 {
@@ -110,8 +111,8 @@ static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
 	return NULL;
 }
 
-static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
-					       bool is_write)
+static inline atomic_long_t *
+insert_watchpoint(unsigned long addr, size_t size, bool is_write)
 {
 	const int slot = watchpoint_slot(addr);
 	const long encoded_watchpoint = encode_watchpoint(addr, size, is_write);
@@ -120,21 +121,16 @@ static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
 
 	/* Check slot index logic, ensuring we stay within array bounds. */
 	BUILD_BUG_ON(SLOT_IDX(0, 0) != KCSAN_CHECK_ADJACENT);
-	BUILD_BUG_ON(SLOT_IDX(0, KCSAN_CHECK_ADJACENT + 1) != 0);
-	BUILD_BUG_ON(SLOT_IDX(CONFIG_KCSAN_NUM_WATCHPOINTS - 1,
-			      KCSAN_CHECK_ADJACENT) !=
-		     ARRAY_SIZE(watchpoints) - 1);
-	BUILD_BUG_ON(SLOT_IDX(CONFIG_KCSAN_NUM_WATCHPOINTS - 1,
-			      KCSAN_CHECK_ADJACENT + 1) !=
-		     ARRAY_SIZE(watchpoints) - NUM_SLOTS);
+	BUILD_BUG_ON(SLOT_IDX(0, KCSAN_CHECK_ADJACENT+1) != 0);
+	BUILD_BUG_ON(SLOT_IDX(CONFIG_KCSAN_NUM_WATCHPOINTS-1, KCSAN_CHECK_ADJACENT) != ARRAY_SIZE(watchpoints)-1);
+	BUILD_BUG_ON(SLOT_IDX(CONFIG_KCSAN_NUM_WATCHPOINTS-1, KCSAN_CHECK_ADJACENT+1) != ARRAY_SIZE(watchpoints) - NUM_SLOTS);
 
 	for (i = 0; i < NUM_SLOTS; ++i) {
 		long expect_val = INVALID_WATCHPOINT;
 
 		/* Try to acquire this slot. */
 		watchpoint = &watchpoints[SLOT_IDX(slot, i)];
-		if (atomic_long_try_cmpxchg_relaxed(watchpoint, &expect_val,
-						    encoded_watchpoint))
+		if (atomic_long_try_cmpxchg_relaxed(watchpoint, &expect_val, encoded_watchpoint))
 			return watchpoint;
 	}
 
@@ -150,11 +146,10 @@ static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
  *	2. the thread that set up the watchpoint already removed it;
  *	3. the watchpoint was removed and then re-used.
  */
-static inline bool try_consume_watchpoint(atomic_long_t *watchpoint,
-					  long encoded_watchpoint)
+static inline bool
+try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
 {
-	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint,
-					       CONSUMED_WATCHPOINT);
+	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
 }
 
 /*
@@ -162,14 +157,13 @@ static inline bool try_consume_watchpoint(atomic_long_t *watchpoint,
  */
 static inline bool remove_watchpoint(atomic_long_t *watchpoint)
 {
-	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) !=
-	       CONSUMED_WATCHPOINT;
+	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
 }
 
 static inline struct kcsan_ctx *get_ctx(void)
 {
 	/*
-	 * In interrupt, use raw_cpu_ptr to avoid unnecessary checks, that would
+	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
 	 * also result in calls that generate warnings in uaccess regions.
 	 */
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
@@ -260,7 +254,8 @@ static inline unsigned int get_delay(void)
  */
 
 static noinline void kcsan_found_watchpoint(const volatile void *ptr,
-					    size_t size, bool is_write,
+					    size_t size,
+					    bool is_write,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
@@ -296,8 +291,8 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	user_access_restore(flags);
 }
 
-static noinline void kcsan_setup_watchpoint(const volatile void *ptr,
-					    size_t size, bool is_write)
+static noinline void
+kcsan_setup_watchpoint(const volatile void *ptr, size_t size, bool is_write)
 {
 	atomic_long_t *watchpoint;
 	union {
@@ -346,8 +341,8 @@ static noinline void kcsan_setup_watchpoint(const volatile void *ptr,
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
 		/*
-		 * Out of capacity: the size of `watchpoints`, and the frequency
-		 * with which `should_watch()` returns true should be tweaked so
+		 * Out of capacity: the size of 'watchpoints', and the frequency
+		 * with which should_watch() returns true should be tweaked so
 		 * that this case happens very rarely.
 		 */
 		kcsan_counter_inc(KCSAN_COUNTER_NO_CAPACITY);
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 041d520a0183..bec42dab32ee 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -24,39 +24,31 @@ static atomic_long_t counters[KCSAN_COUNTER_COUNT];
  * whitelist or blacklist.
  */
 static struct {
-	unsigned long *addrs; /* array of addresses */
-	size_t size; /* current size */
-	int used; /* number of elements used */
-	bool sorted; /* if elements are sorted */
-	bool whitelist; /* if list is a blacklist or whitelist */
+	unsigned long	*addrs;		/* array of addresses */
+	size_t		size;		/* current size */
+	int		used;		/* number of elements used */
+	bool		sorted;		/* if elements are sorted */
+	bool		whitelist;	/* if list is a blacklist or whitelist */
 } report_filterlist = {
-	.addrs = NULL,
-	.size = 8, /* small initial size */
-	.used = 0,
-	.sorted = false,
-	.whitelist = false, /* default is blacklist */
+	.addrs		= NULL,
+	.size		= 8,		/* small initial size */
+	.used		= 0,
+	.sorted		= false,
+	.whitelist	= false,	/* default is blacklist */
 };
 static DEFINE_SPINLOCK(report_filterlist_lock);
 
 static const char *counter_to_name(enum kcsan_counter_id id)
 {
 	switch (id) {
-	case KCSAN_COUNTER_USED_WATCHPOINTS:
-		return "used_watchpoints";
-	case KCSAN_COUNTER_SETUP_WATCHPOINTS:
-		return "setup_watchpoints";
-	case KCSAN_COUNTER_DATA_RACES:
-		return "data_races";
-	case KCSAN_COUNTER_NO_CAPACITY:
-		return "no_capacity";
-	case KCSAN_COUNTER_REPORT_RACES:
-		return "report_races";
-	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:
-		return "races_unknown_origin";
-	case KCSAN_COUNTER_UNENCODABLE_ACCESSES:
-		return "unencodable_accesses";
-	case KCSAN_COUNTER_ENCODING_FALSE_POSITIVES:
-		return "encoding_false_positives";
+	case KCSAN_COUNTER_USED_WATCHPOINTS:		return "used_watchpoints";
+	case KCSAN_COUNTER_SETUP_WATCHPOINTS:		return "setup_watchpoints";
+	case KCSAN_COUNTER_DATA_RACES:			return "data_races";
+	case KCSAN_COUNTER_NO_CAPACITY:			return "no_capacity";
+	case KCSAN_COUNTER_REPORT_RACES:		return "report_races";
+	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:	return "races_unknown_origin";
+	case KCSAN_COUNTER_UNENCODABLE_ACCESSES:	return "unencodable_accesses";
+	case KCSAN_COUNTER_ENCODING_FALSE_POSITIVES:	return "encoding_false_positives";
 	case KCSAN_COUNTER_COUNT:
 		BUG();
 	}
@@ -116,7 +108,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 
 	if (!kallsyms_lookup_size_offset(func_addr, &symbolsize, &offset))
 		return false;
-	func_addr -= offset; /* get function start */
+	func_addr -= offset; /* Get function start */
 
 	spin_lock_irqsave(&report_filterlist_lock, flags);
 	if (report_filterlist.used == 0)
@@ -195,6 +187,7 @@ static ssize_t insert_report_filterlist(const char *func)
 
 out:
 	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+
 	return ret;
 }
 
@@ -226,8 +219,8 @@ static int debugfs_open(struct inode *inode, struct file *file)
 	return single_open(file, show_info, NULL);
 }
 
-static ssize_t debugfs_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *off)
+static ssize_t
+debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *off)
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
@@ -264,10 +257,13 @@ static ssize_t debugfs_write(struct file *file, const char __user *buf,
 	return count;
 }
 
-static const struct file_operations debugfs_ops = { .read = seq_read,
-						    .open = debugfs_open,
-						    .write = debugfs_write,
-						    .release = single_release };
+static const struct file_operations debugfs_ops =
+{
+	.read	 = seq_read,
+	.open	 = debugfs_open,
+	.write	 = debugfs_write,
+	.release = single_release
+};
 
 void __init kcsan_debugfs_init(void)
 {
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index e17bdac0e54b..b63890e86449 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -10,7 +10,8 @@
 #include "kcsan.h"
 
 #define SLOT_RANGE PAGE_SIZE
-#define INVALID_WATCHPOINT 0
+
+#define INVALID_WATCHPOINT  0
 #define CONSUMED_WATCHPOINT 1
 
 /*
@@ -34,24 +35,24 @@
  * Both these are assumed to be very unlikely. However, in case it still happens
  * happens, the report logic will filter out the false positive (see report.c).
  */
-#define WATCHPOINT_ADDR_BITS (BITS_PER_LONG - 1 - WATCHPOINT_SIZE_BITS)
+#define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
 
 /*
  * Masks to set/retrieve the encoded data.
  */
-#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG - 1)
+#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
 #define WATCHPOINT_SIZE_MASK                                                   \
-	GENMASK(BITS_PER_LONG - 2, BITS_PER_LONG - 2 - WATCHPOINT_SIZE_BITS)
+	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
 #define WATCHPOINT_ADDR_MASK                                                   \
-	GENMASK(BITS_PER_LONG - 3 - WATCHPOINT_SIZE_BITS, 0)
+	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
 	return size <= MAX_ENCODABLE_SIZE;
 }
 
-static inline long encode_watchpoint(unsigned long addr, size_t size,
-				     bool is_write)
+static inline long
+encode_watchpoint(unsigned long addr, size_t size, bool is_write)
 {
 	return (long)((is_write ? WATCHPOINT_WRITE_MASK : 0) |
 		      (size << WATCHPOINT_ADDR_BITS) |
@@ -59,17 +60,17 @@ static inline long encode_watchpoint(unsigned long addr, size_t size,
 }
 
 static inline bool decode_watchpoint(long watchpoint,
-				     unsigned long *addr_masked, size_t *size,
+				     unsigned long *addr_masked,
+				     size_t *size,
 				     bool *is_write)
 {
 	if (watchpoint == INVALID_WATCHPOINT ||
 	    watchpoint == CONSUMED_WATCHPOINT)
 		return false;
 
-	*addr_masked = (unsigned long)watchpoint & WATCHPOINT_ADDR_MASK;
-	*size = ((unsigned long)watchpoint & WATCHPOINT_SIZE_MASK) >>
-		WATCHPOINT_ADDR_BITS;
-	*is_write = !!((unsigned long)watchpoint & WATCHPOINT_WRITE_MASK);
+	*addr_masked =    (unsigned long)watchpoint & WATCHPOINT_ADDR_MASK;
+	*size	     =   ((unsigned long)watchpoint & WATCHPOINT_SIZE_MASK) >> WATCHPOINT_ADDR_BITS;
+	*is_write    = !!((unsigned long)watchpoint & WATCHPOINT_WRITE_MASK);
 
 	return true;
 }
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 1bb2f1c0d61e..d3b9a96ac8a4 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -72,14 +72,14 @@ enum kcsan_counter_id {
 /*
  * Increment/decrement counter with given id; avoid calling these in fast-path.
  */
-void kcsan_counter_inc(enum kcsan_counter_id id);
-void kcsan_counter_dec(enum kcsan_counter_id id);
+extern void kcsan_counter_inc(enum kcsan_counter_id id);
+extern void kcsan_counter_dec(enum kcsan_counter_id id);
 
 /*
  * Returns true if data races in the function symbol that maps to func_addr
  * (offsets are ignored) should *not* be reported.
  */
-bool kcsan_skip_report_debugfs(unsigned long func_addr);
+extern bool kcsan_skip_report_debugfs(unsigned long func_addr);
 
 enum kcsan_report_type {
 	/*
@@ -99,10 +99,11 @@ enum kcsan_report_type {
 	 */
 	KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
 };
+
 /*
  * Print a race report from thread that encountered the race.
  */
-void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
-		  bool value_change, int cpu_id, enum kcsan_report_type type);
+extern void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
+			 bool value_change, int cpu_id, enum kcsan_report_type type);
 
 #endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ead5610bafa7..0eea05a3135b 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -22,13 +22,13 @@
  * the reports, with reporting being in the slow-path.
  */
 static struct {
-	const volatile void *ptr;
-	size_t size;
-	bool is_write;
-	int task_pid;
-	int cpu_id;
-	unsigned long stack_entries[NUM_STACK_ENTRIES];
-	int num_stack_entries;
+	const volatile void	*ptr;
+	size_t			size;
+	bool			is_write;
+	int			task_pid;
+	int			cpu_id;
+	unsigned long		stack_entries[NUM_STACK_ENTRIES];
+	int			num_stack_entries;
 } other_info = { .ptr = NULL };
 
 /*
@@ -40,8 +40,8 @@ static DEFINE_SPINLOCK(report_lock);
 /*
  * Special rules to skip reporting.
  */
-static bool skip_report(bool is_write, bool value_change,
-			unsigned long top_frame)
+static bool
+skip_report(bool is_write, bool value_change, unsigned long top_frame)
 {
 	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) && is_write &&
 	    !value_change) {
@@ -105,6 +105,7 @@ static int sym_strcmp(void *addr1, void *addr2)
 
 	snprintf(buf1, sizeof(buf1), "%pS", addr1);
 	snprintf(buf2, sizeof(buf2), "%pS", addr2);
+
 	return strncmp(buf1, buf2, sizeof(buf1));
 }
 
@@ -116,8 +117,7 @@ static bool print_report(const volatile void *ptr, size_t size, bool is_write,
 			 enum kcsan_report_type type)
 {
 	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
-	int num_stack_entries =
-		stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
+	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
 	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
 	int other_skipnr;
 
@@ -131,7 +131,7 @@ static bool print_report(const volatile void *ptr, size_t size, bool is_write,
 		other_skipnr = get_stack_skipnr(other_info.stack_entries,
 						other_info.num_stack_entries);
 
-		/* value_change is only known for the other thread */
+		/* @value_change is only known for the other thread */
 		if (skip_report(other_info.is_write, value_change,
 				other_info.stack_entries[other_skipnr]))
 			return false;
@@ -241,13 +241,12 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 		if (other_info.ptr != NULL)
 			break; /* still in use, retry */
 
-		other_info.ptr = ptr;
-		other_info.size = size;
-		other_info.is_write = is_write;
-		other_info.task_pid = in_task() ? task_pid_nr(current) : -1;
-		other_info.cpu_id = cpu_id;
-		other_info.num_stack_entries = stack_trace_save(
-			other_info.stack_entries, NUM_STACK_ENTRIES, 1);
+		other_info.ptr			= ptr;
+		other_info.size			= size;
+		other_info.is_write		= is_write;
+		other_info.task_pid		= in_task() ? task_pid_nr(current) : -1;
+		other_info.cpu_id		= cpu_id;
+		other_info.num_stack_entries	= stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
 
 		spin_unlock_irqrestore(&report_lock, *flags);
 
@@ -299,6 +298,7 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 	}
 
 	spin_unlock_irqrestore(&report_lock, *flags);
+
 	goto retry;
 }
 
@@ -309,9 +309,7 @@ void kcsan_report(const volatile void *ptr, size_t size, bool is_write,
 
 	kcsan_disable_current();
 	if (prepare_report(&flags, ptr, size, is_write, cpu_id, type)) {
-		if (print_report(ptr, size, is_write, value_change, cpu_id,
-				 type) &&
-		    panic_on_warn)
+		if (print_report(ptr, size, is_write, value_change, cpu_id, type) && panic_on_warn)
 			panic("panic_on_warn set ...\n");
 
 		release_report(&flags, type);
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
index 0bae63c5ca65..cc6000239dc0 100644
--- a/kernel/kcsan/test.c
+++ b/kernel/kcsan/test.c
@@ -34,7 +34,7 @@ static bool test_encode_decode(void)
 		if (WARN_ON(!check_encodable(addr, size)))
 			return false;
 
-		/* encode and decode */
+		/* Encode and decode */
 		{
 			const long encoded_watchpoint =
 				encode_watchpoint(addr, size, is_write);
@@ -42,7 +42,7 @@ static bool test_encode_decode(void)
 			size_t verif_size;
 			bool verif_is_write;
 
-			/* check special watchpoints */
+			/* Check special watchpoints */
 			if (WARN_ON(decode_watchpoint(
 				    INVALID_WATCHPOINT, &verif_masked_addr,
 				    &verif_size, &verif_is_write)))
@@ -52,7 +52,7 @@ static bool test_encode_decode(void)
 				    &verif_size, &verif_is_write)))
 				return false;
 
-			/* check decoding watchpoint returns same data */
+			/* Check decoding watchpoint returns same data */
 			if (WARN_ON(!decode_watchpoint(
 				    encoded_watchpoint, &verif_masked_addr,
 				    &verif_size, &verif_is_write)))
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index e9307a9c54e7..5fc9c9b70862 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,7 +7,7 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
-# There are numerous races here, however, most of them due to plain accesses.
+# There are numerous data races here, however, most of them are due to plain accesses.
 # This would make it even harder for syzbot to find reproducers, because these
 # bugs trigger without specific input. Disable by default, but should re-enable
 # eventually.
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 5dd464e52ab4..3f78b1434375 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -6,7 +6,6 @@ config HAVE_ARCH_KCSAN
 menuconfig KCSAN
 	bool "KCSAN: watchpoint-based dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
-	default n
 	help
 	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
 	  uses a watchpoint-based sampling approach to detect races. See
@@ -16,13 +15,12 @@ if KCSAN
 
 config KCSAN_DEBUG
 	bool "Debugging of KCSAN internals"
-	default n
 
 config KCSAN_SELFTEST
 	bool "Perform short selftests on boot"
 	default y
 	help
-	  Run KCSAN selftests on boot. On test failure, causes kernel to panic.
+	  Run KCSAN selftests on boot. On test failure, causes the kernel to panic.
 
 config KCSAN_EARLY_ENABLE
 	bool "Early enable during boot"
@@ -62,7 +60,8 @@ config KCSAN_DELAY_RANDOMIZE
 	default y
 	help
 	  If delays should be randomized, where the maximum is KCSAN_UDELAY_*.
-	  If false, the chosen delays are always KCSAN_UDELAY_* defined above.
+	  If false, the chosen delays are always the KCSAN_UDELAY_* values
+	  as defined above.
 
 config KCSAN_SKIP_WATCH
 	int "Skip instructions before setting up watchpoint"
@@ -86,9 +85,9 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 # parameters, to optimize for the common use-case, we avoid this because: (a)
 # it would impact performance (and we want to avoid static branch for all
 # {READ,WRITE}_ONCE, atomic_*, bitops, etc.), and (b) complicate the design
-# without real benefit. The main purpose of the below options are for use in
-# fuzzer configs to control reported data races, and are not expected to be
-# switched frequently by a user.
+# without real benefit. The main purpose of the below options is for use in
+# fuzzer configs to control reported data races, and they are not expected
+# to be switched frequently by a user.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
@@ -103,13 +102,12 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	bool "Only report races where watcher observed a data value change"
 	default y
 	help
-	  If enabled and a conflicting write is observed via watchpoint, but
+	  If enabled and a conflicting write is observed via a watchpoint, but
 	  the data value of the memory location was observed to remain
 	  unchanged, do not report the data race.
 
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
-	default n
 	help
 	  If enabled, never instruments marked atomic accesses. This results in
 	  not reporting data races where one access is atomic and the other is
