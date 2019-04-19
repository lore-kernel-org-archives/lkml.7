Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE2E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701156;
	bh=8s/XEr2PFDkv1yvGhVRJT++i5v6cppzQicwQWNxNm2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yyn5hLnqoUijpdTPW1EJFIMZlhuvrrqhUOHF8kQHLoOU62L42N2PEnyoKHAGInDsI
	 pyLl5eOdoD2zMNu9/A7pI6P4XUQrKf+EagwsCWYJHLpk17aFf3cjtzKq5m0dy9buqe
	 BAbUDyj7RIVgK0QW9iZfw/+Vb1Veewg/oSgyshc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfDSTMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:12:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36412 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfDSTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:12:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so3475032wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nAgdjGuZSCG92Lwm/XCaXb+k4k+fq+wHi5WoVqh+rKk=;
        b=GfwOWfCHp11HV/MjFHCboSRL3Yqhx+uluJjI1cOcTy0Ne/xxC0fXDjR4A712qSabog
         LQv09tfcBdb2PFmvBT9PGf5voN9vHEG6W6i1OYApBACUfPqJj1fpNFNJYGEAygsZ1nLd
         AwXeCsxJuevE6U5nXahS/9IsNsbouviG81RqKnxleXVdotioLxpxElX15jBaRWmegwrZ
         VWqH74OBpMYzpB6b4vWF+G6NQ/WUcXhH82dcjHqrtg8qFkyWyp5NUcG5UbAIb6wX76om
         HPa2WRUYPJ+MJ+Ob6flt8N5lkD2SeNYQ6zefUiPIgKdvxEDM9SBANv3AqmWumFjU8jYk
         pHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nAgdjGuZSCG92Lwm/XCaXb+k4k+fq+wHi5WoVqh+rKk=;
        b=HrSqcXlqVr0tMx31iMVfS6UtHI3wNxdEMLGMs2Jo9plOuQ5rmw7pR2vU4T9HHG8oK+
         a4tgapbf8RvuJMjLfCSR36lUT1PhCwUszfxoNWa5R6D7RJjQy3tGLaLEwoLU/bA7uLl2
         k+T3V5tXmsGksSM1G5ntc+DXwasTsimi+BoiAWzhX2LMgGXr+245Xd9ba0cfU//JWzy0
         Jee664kPj4bf4l8TuYe/JqBAhGbY2FRBKMEFKLoBNkIuqERvo/Qf9ZDw3wVRRB5MkaPE
         HYz+OMwxAhaLQN0DuDxAqkdQMsp70nXxKRpu8dhlsJDTdIKb9abau10Gd1p4iidmveV9
         Vylg==
X-Gm-Message-State: APjAAAVaQvq/CxX0OAfP6nAwGudoBQtBLtmMYys5sXx63KPEhY1t4r6j
        3K7ttekXJoASia8lKBBNTixqIdid
X-Google-Smtp-Source: APXvYqypyYuEzXHYfA5Cbd+D3YT7M5foZcKx7gMMargge+x/gLKR10psuK2CrUpIkrBNwvFXM0y6/g==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr2242668wrm.277.1555668520856;
        Fri, 19 Apr 2019 03:08:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s18sm4801382wmc.41.2019.04.19.03.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:08:39 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:08:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Slavomir Kaslev <kaslevs@vmware.com>
Subject: [PATCH] compiler.h, tracing: Remove CONFIG_PROFILE_ALL_BRANCHES
Message-ID: <20190419100837.GA19406@gmail.com>
References: <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
 <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
 <20190307171709.dap5hfeof4yo3nsc@treble>
 <20190307173810.GI32477@hirez.programming.kicks-ass.net>
 <CAHk-=wi_vuD9fKk36=_DNG9=+S9rbTRu2FTFe9tECunC8oOtfg@mail.gmail.com>
 <20190307131841.3b5d9e00@oasis.local.home>
 <20190310131620.GL2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190310131620.GL2482@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 07, 2019 at 01:18:41PM -0500, Steven Rostedt wrote:
> > On Thu, 7 Mar 2019 09:45:35 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > On Thu, Mar 7, 2019 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > Also; it seems to me that something PT, or maybe even simply:
> > > >
> > > >   perf -e branches -e branch-misses
> > > >
> > > > would get you similar or sufficient information.  
> 
> > I currently have one of my engineers looking at the data and may be
> > sending patches soon. It's basically an entry level way to get into
> > kernel development. Note, no patch will be sent just because of the
> > data from the profiling. The task is to look at and understand the
> > code, and see if it can be optimized (with likely/unlikely or flow
> > changes). It's a way to get a better understanding of the kernel in
> > various locations. It is by no means "profiler said this, lets change
> > it." All changes must be rational, and make sense. The profiler is only
> > used to help find those places.
> 
> Can't you just have those same engineers look at perf data? This seems
> like a very expensive and convoluted way of getting something.

So since no-one offered objections to using perf branch profiling instead 
(which method allows so much more than CONFIG_PROFILE_ALL_BRANCHES: such 
as profiling glibc and other user-space, or allowing to branch-profile 
the kernel is an uninstrumented form not distorted by 
CONFIG_PROFILE_ALL_BRANCHES code generation artifacts), lemme propose the 
attached patch to remove if-tracing.

If the CONFIG_PROFILE_ALL_BRANCHES=y feature is required for anyone it 
can still be reverted privately or maintained out of tree - no need to 
burden the mainline kernel with this.

I've build tested this and it Looks Perfect Here™.

Thanks,

	Ingo

=============================>
From 3f689ed8a1555aabead90e015a47aefddd2a4e25 Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 19 Apr 2019 11:42:43 +0200
Subject: [PATCH] compiler.h, tracing: Remove CONFIG_PROFILE_ALL_BRANCHES

Redefining 'if' in compiler.h was a hideously wonderful hack back in 2008 when
we merged it via:

  2bcd521a684c: ("trace: profile all if conditionals")

Meanwhile the 'wonderful' novelty part wore off a bit in that decade, and 
what remained is the 'hideous', mostly. ;-)

Meanwhile #2: we also merged perf and hardware branch tracing 
capabilities (branch-miss events, but also BTS and aux hw tracing),
which can collect similar data and so much more:

  $ perf -e branches -e branch-misses

So let's remove this constant source of headaches for good. Anyone truly 
interested in this feature can revert this commit and/or maintain it out 
of tree - but the upstream pain isn't really worth it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/vmlinux.lds.h           | 11 +----
 include/linux/compiler.h                    | 24 -----------
 kernel/trace/Kconfig                        | 17 --------
 kernel/trace/trace_branch.c                 | 66 -----------------------------
 tools/perf/tests/bpf-script-test-prologue.c |  9 ----
 5 files changed, 1 insertion(+), 126 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f8f6f04c4453..9c477b2136c2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -126,14 +126,6 @@
 #define LIKELY_PROFILE()
 #endif
 
-#ifdef CONFIG_PROFILE_ALL_BRANCHES
-#define BRANCH_PROFILE()	__start_branch_profile = .;		\
-				KEEP(*(_ftrace_branch))			\
-				__stop_branch_profile = .;
-#else
-#define BRANCH_PROFILE()
-#endif
-
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
 				__start_kprobe_blacklist = .;		      \
@@ -266,8 +258,7 @@
 	__start___verbose = .;						\
 	KEEP(*(__verbose))                                              \
 	__stop___verbose = .;						\
-	LIKELY_PROFILE()		       				\
-	BRANCH_PROFILE()						\
+	LIKELY_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
 	TRACEPOINT_STR()
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d58aa0db05f9..c63105451c6a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -48,30 +48,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #  define unlikely(x)	(__branch_check__(x, 0, __builtin_constant_p(x)))
 # endif
 
-#ifdef CONFIG_PROFILE_ALL_BRANCHES
-/*
- * "Define 'is'", Bill Clinton
- * "Define 'if'", Steven Rostedt
- */
-#define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
-#define __trace_if(cond) \
-	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
-	({								\
-		int ______r;						\
-		static struct ftrace_branch_data			\
-			__aligned(4)					\
-			__section("_ftrace_branch")			\
-			______f = {					\
-				.func = __func__,			\
-				.file = __FILE__,			\
-				.line = __LINE__,			\
-			};						\
-		______r = !!(cond);					\
-		______r ? ______f.miss_hit[1]++ : ______f.miss_hit[0]++;\
-		______r;						\
-	}))
-#endif /* CONFIG_PROFILE_ALL_BRANCHES */
-
 #else
 # define likely(x)	__builtin_expect(!!(x), 1)
 # define unlikely(x)	__builtin_expect(!!(x), 0)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8bd1d6d001d7..169c34e0f16d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -366,23 +366,6 @@ config PROFILE_ANNOTATED_BRANCHES
 
 	  Note: this will add a significant overhead; only turn this
 	  on if you need to profile the system's use of these macros.
-
-config PROFILE_ALL_BRANCHES
-	bool "Profile all if conditionals" if !FORTIFY_SOURCE
-	select TRACE_BRANCH_PROFILING
-	imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
-	help
-	  This tracer profiles all branch conditions. Every if ()
-	  taken in the kernel is recorded whether it hit or miss.
-	  The results will be displayed in:
-
-	  /sys/kernel/debug/tracing/trace_stat/branch_all
-
-	  This option also enables the likely/unlikely profiler.
-
-	  This configuration, when enabled, will impose a great overhead
-	  on the system. This should only be enabled when the system
-	  is to be analyzed in much detail.
 endchoice
 
 config TRACING_BRANCHES
diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 3ea65cdff30d..be75301a9963 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -387,69 +387,3 @@ __init static int init_annotated_branch_stats(void)
 	return 0;
 }
 fs_initcall(init_annotated_branch_stats);
-
-#ifdef CONFIG_PROFILE_ALL_BRANCHES
-
-extern unsigned long __start_branch_profile[];
-extern unsigned long __stop_branch_profile[];
-
-static int all_branch_stat_headers(struct seq_file *m)
-{
-	seq_puts(m, "   miss      hit    % "
-		    "       Function                "
-		    "  File              Line\n"
-		    " ------- ---------  - "
-		    "       --------                "
-		    "  ----              ----\n");
-	return 0;
-}
-
-static void *all_branch_stat_start(struct tracer_stat *trace)
-{
-	return __start_branch_profile;
-}
-
-static void *
-all_branch_stat_next(void *v, int idx)
-{
-	struct ftrace_branch_data *p = v;
-
-	++p;
-
-	if ((void *)p >= (void *)__stop_branch_profile)
-		return NULL;
-
-	return p;
-}
-
-static int all_branch_stat_show(struct seq_file *m, void *v)
-{
-	struct ftrace_branch_data *p = v;
-	const char *f;
-
-	f = branch_stat_process_file(p);
-	return branch_stat_show_normal(m, p, f);
-}
-
-static struct tracer_stat all_branch_stats = {
-	.name = "branch_all",
-	.stat_start = all_branch_stat_start,
-	.stat_next = all_branch_stat_next,
-	.stat_headers = all_branch_stat_headers,
-	.stat_show = all_branch_stat_show
-};
-
-__init static int all_annotated_branch_stats(void)
-{
-	int ret;
-
-	ret = register_stat_tracer(&all_branch_stats);
-	if (!ret) {
-		printk(KERN_WARNING "Warning: could not register "
-				    "all branches stats\n");
-		return 1;
-	}
-	return 0;
-}
-fs_initcall(all_annotated_branch_stats);
-#endif /* CONFIG_PROFILE_ALL_BRANCHES */
diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
index 43f1e16486f4..1f048bd89b0d 100644
--- a/tools/perf/tests/bpf-script-test-prologue.c
+++ b/tools/perf/tests/bpf-script-test-prologue.c
@@ -10,15 +10,6 @@
 
 #include <uapi/linux/fs.h>
 
-/*
- * If CONFIG_PROFILE_ALL_BRANCHES is selected,
- * 'if' is redefined after include kernel header.
- * Recover 'if' for BPF object code.
- */
-#ifdef if
-# undef if
-#endif
-
 #define FMODE_READ		0x1
 #define FMODE_WRITE		0x2
 
