Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B766C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2AF21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVvhH+6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfGVX2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:28:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43667 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:28:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so18109976pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wSQtAl/BKHIR2bEagKQGgSIzTu7KU5nm4IPVH8BsvBo=;
        b=SVvhH+6n6D/y6AsX2r4mek0w7SL0p32ucsNE8lp3g3ndnYfStZL0IZ8MGvc6T5S/pb
         Dk1DbIHoUptS8HId+DEVWbDiUHVE0Qlox4nOjoZSqpccv2xlFB/Wnv6oLInlvp7q3Kfy
         MXqkafuYHYUZiVGRE1usqeXWpo70b0eOo7D1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSQtAl/BKHIR2bEagKQGgSIzTu7KU5nm4IPVH8BsvBo=;
        b=dGJoIUKfY54lvnQq37V6QzFfjeiZMl5UNoqdwFNZO7MMES45gkwt+qBj6XSdhjnTIe
         WAQdd6dXRQUBfFk75WtaZFt3GMKbUp+gZKZMH5KbpRm0ZNtYvM6uCFsa1xIIIT2WUqNa
         1TCUb/+mMDMZ3OzVNIizfkaWmXFy9LzPqfafxwjEJDzD1SQWkihqii8347mQdrH7kjFP
         wcJwaRn6qIja5pWPQAlM1rWnUMe3yjpuoJRdD5fqUSqXLvbMgCaQuD2kde9R8fa5hKp2
         giGDXoYmhpzGnxFuQt4QXm5EjY81mfp0VZdK7uyq6gOXkQXvadoxZ+3kK+uIUIIKc0jn
         erBw==
X-Gm-Message-State: APjAAAX5++rDt06wwVNZcRpNB1a4CYoMdJzEdRA9MuuZ10VoxmvFyTZF
        bmGYzUWglBi5BEeYqHvqpSEwNj00EU8=
X-Google-Smtp-Source: APXvYqxOsuc/IU/+IFh6pYCP4ANsNXXpa48nQG7t5mkezvjLjGYpH/AlIGhUOOeTZSANnEMfPVrsKQ==
X-Received: by 2002:a17:90a:8a91:: with SMTP id x17mr79700084pjn.95.1563838102875;
        Mon, 22 Jul 2019 16:28:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v138sm46591363pfc.15.2019.07.22.16.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 16:28:22 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:28:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
Message-ID: <201907221620.F31B9A082@keescook>
References: <20190719170343.GA13680@linux.intel.com>
 <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net>
 <201907221012.41504DCD@keescook>
 <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
 <201907221135.2C2D262D8@keescook>
 <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:17:16PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 22, 2019 at 11:39 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jul 22, 2019 at 08:31:32PM +0200, Thomas Gleixner wrote:
> > > On Mon, 22 Jul 2019, Kees Cook wrote:
> > > > Just so I'm understanding: the vDSO change introduced code to make an
> > > > actual syscall on i386, which for most seccomp filters would be rejected?
> > >
> > > No. The old x86 specific VDSO implementation had a fallback syscall as
> > > well, i.e. clock_gettime(). On 32bit clock_gettime() uses the y2038
> > > endangered timespec.
> > >
> > > So when the VDSO was made generic we changed the internal data structures
> > > to be 2038 safe right away. As a consequence the fallback syscall is not
> > > clock_gettime(), it's clock_gettime64(). which seems to surprise seccomp.
> >
> > Okay, it's didn't add a syscall, it just changed it. Results are the
> > same: conservative filters suddenly start breaking due to the different
> > call. (And now I see why Andy's alias suggestion would help...)
> >
> > I'm not sure which direction to do with this. It seems like an alias
> > list is a large hammer for this case, and a "seccomp-bypass when calling
> > from vDSO" solution seems too fragile?
> >
> 
> I don't like the seccomp bypass at all.  If someone uses seccomp to
> disallow all clock_gettime() variants, there shouldn't be a back door
> to learn the time.
> 
> Here's the restart_syscall() logic that makes me want aliases: we have
> different syscall numbers for restart_syscall() on 32-bit and 64-bit.
> The logic to decide which one to use is dubious at best.  I'd like to
> introduce a restart_syscall2() that is identical to restart_syscall()
> except that it has the same number on both variants.

I've built a straw-man for this idea... but I have to say I don't
like it. This can lead to really unexpected behaviors if someone
were to have differing filters for the two syscalls. For example,
let's say someone was doing a paranoid audit of 2038-unsafe clock usage
and marked clock_gettime() with RET_KILL and marked clock_gettime64()
with RET_LOG. This aliasing would make clock_gettime64() trigger with
RET_KILL...

There's no sense of "default" in BPF so we can't check for "and they
weren't expecting it", and we can't check for exact matches since the
filter might be using a balance tree to bucket the allowed syscalls.

Anyway, here it is in case it sparks some more thoughts...


diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28418d5..1e82bd43286c 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -13,6 +13,7 @@
  */
 #undef CONFIG_64BIT
 #undef CONFIG_X86_64
+#undef CONFIG_COMPAT
 #undef CONFIG_PGTABLE_LEVELS
 #undef CONFIG_ILLEGAL_POINTER_VALUE
 #undef CONFIG_SPARSEMEM_VMEMMAP
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 2bd1338de236..5d0da5ee1b61 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -6,6 +6,12 @@
 
 #ifdef CONFIG_X86_32
 #define __NR_seccomp_sigreturn		__NR_sigreturn
+#define seccomp_syscall_alias(arch, syscall)			\
+	({							\
+		(syscall) == __NR_clock_gettime64 ?		\
+			__NR_clock_gettime :			\
+			-1;					\
+	})
 #endif
 
 #ifdef CONFIG_COMPAT
@@ -14,6 +20,13 @@
 #define __NR_seccomp_write_32		__NR_ia32_write
 #define __NR_seccomp_exit_32		__NR_ia32_exit
 #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
+#define seccomp_syscall_alias(arch, syscall)			\
+	({							\
+		(arch) != AUDIT_ARCH_I386 ? -1 :		\
+		(syscall) == __NR_ia32_clock_gettime64 ?	\
+			__NR_ia32_clock_gettime :		\
+			-1;					\
+	})
 #endif
 
 #include <asm-generic/seccomp.h>
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 84868d37b35d..06f5ca81d756 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -83,6 +83,14 @@ static inline int seccomp_mode(struct seccomp *s)
 #ifdef CONFIG_SECCOMP_FILTER
 extern void put_seccomp_filter(struct task_struct *tsk);
 extern void get_seccomp_filter(struct task_struct *tsk);
+/*
+ * Allow architectures to provide syscall aliases for special cases
+ * when attempting to make invisible transitions to new syscalls that
+ * have no arguments (e.g. clock_gettime64, restart_syscall).
+ */
+# ifndef seccomp_syscall_alias
+#  define seccomp_syscall_alias(arch, syscall)		(-1)
+# endif
 #else  /* CONFIG_SECCOMP_FILTER */
 static inline void put_seccomp_filter(struct task_struct *tsk)
 {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index dba52a7db5e8..5153c6155d9a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -807,6 +807,26 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION_FULL;
 
+	/* Handle syscall aliases when result is not SECCOMP_RET_ALLOW. */
+	if (unlikely(action != SECCOMP_RET_ALLOW)) {
+		int alias;
+
+		alias = seccomp_syscall_alias(sd->arch, sd->nr);
+		if (unlikely(alias != -1)) {
+			/* Use sd_local for an aliased syscall. */
+			if (sd != &sd_local) {
+				sd_local = *sd;
+				sd = &sd_local;
+			}
+			sd_local.nr = alias;
+
+			/* Run again, with the alias, accepting the results. */
+			filter_ret = seccomp_run_filters(sd, &match);
+			data = filter_ret & SECCOMP_RET_DATA;
+			action = filter_ret & SECCOMP_RET_ACTION_FULL;
+		}
+	}
+
 	switch (action) {
 	case SECCOMP_RET_ERRNO:
 		/* Set low-order bits as an errno, capped at MAX_ERRNO. */
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6ef7f16c4cf5..778619d145ea 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3480,6 +3519,55 @@ TEST(seccomp_get_notif_sizes)
 	EXPECT_EQ(sizes.seccomp_notif_resp, sizeof(struct seccomp_notif_resp));
 }
 
+#if defined(__i386__)
+TEST(seccomp_syscall_alias)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_sigreturn
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_sigreturn, 6, 0),
+#endif
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_read, 5, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit, 4, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_rt_sigreturn, 3, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_restart_syscall, 2, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_write, 1, 0),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_clock_gettime, 0, 1),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	unsigned char buffer[128];
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel refused to install seccomp filter!");
+	}
+
+	/* We allow clock_gettime explicitly. */
+	EXPECT_EQ(0, syscall(__NR_clock_gettime, CLOCK_REALTIME, &buffer)) {
+		TH_LOG("Failed __NR_clock_gettime!?");
+	}
+
+	/* With aliases, clock_gettime64 should be allowed too. */
+	EXPECT_EQ(0, syscall(__NR_clock_gettime64, CLOCK_REALTIME, &buffer)) {
+		TH_LOG("Failed __NR_clock_gettime64!");
+	}
+
+	syscall(__NR_exit, 0);
+}
+#endif
+
 /*
  * TODO:
  * - add microbenchmarks

-- 
Kees Cook
