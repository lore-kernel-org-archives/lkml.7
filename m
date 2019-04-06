Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3FEC282DD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5594A21019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Xl764JPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDFXGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:06:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46335 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDFXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:06:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so5330018pfj.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n1w7o6jHm/pHouk7zr8EtkZZ+fNE+0alYUOjtyCyUaE=;
        b=Xl764JPfHP3SqgGW7yGApBi3+MhQMYj8wOzHugFbIucsanvF5LobN57mC/p/kxSHi9
         +xu5ptuKmT7Z/ptYeF1Tyt0baJzZ2DOGdQbiq56TrIDqC1o49YuFJGt0ICOy62iikNwx
         OZQChlrA/dDp+P3zapLo0q2RcPegAuJYbKNjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n1w7o6jHm/pHouk7zr8EtkZZ+fNE+0alYUOjtyCyUaE=;
        b=KEnzTtJd4Wx9IYvzcXFQXNCNNB2RXQ46cG6ZEM6qx7mZWBaQTi2p+s4MLKPRIrkPzw
         OWnr6aIafi6xlpAbLRJA9KPAWYscJe9U5eV0sPSJGOqtH3Tvf5xMXgx0NIe1GN941Ssd
         DvZQk7clOsZ3PnN+an3zM9etXZXZOj6BRZCk7aaDgO3mql6jGF+YBLdKWQg+u4R6lRgd
         byEmbzEtYKhQzi43vFiAhUcCl09c4OXmG5hzKkbQVKulsWJc05x0VsL1BdYOezv/UHPM
         X6Mt8v/7G3q3ofqg68Luamf4ygPgpG/+fXqh5FeVPsYmzXSYOtiN7aOUPKZ2NiET/F55
         hmmw==
X-Gm-Message-State: APjAAAXlOJl4tuo3pHZpwUE80S8kueHpkIZ7vc6nqV2ymr3NIfKCbUpt
        KcE2ApSQn8XOscbvVd0hIYyAVA==
X-Google-Smtp-Source: APXvYqy3x+z0j6ljP2y9ZLSCPRcpvlTWYzP/gRTSOFIOwsH2M0tphoYzDjUuBvFgWrRv4+2jKifFqw==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr20986864pfd.24.1554591976078;
        Sat, 06 Apr 2019 16:06:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c130sm42254103pfb.145.2019.04.06.16.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 16:06:14 -0700 (PDT)
Date:   Sat, 6 Apr 2019 19:06:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Message-ID: <20190406230613.GA187766@google.com>
References: <20190402142816.GA13084@linux.ibm.com>
 <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
 <20190402152334.GC4102@linux.ibm.com>
 <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
 <20190403133243.GE4102@linux.ibm.com>
 <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405232835.GA24702@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:28:35PM -0700, Paul E. McKenney wrote:
> On Wed, Apr 03, 2019 at 09:20:39AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 03, 2019 at 10:27:42AM -0400, Mathieu Desnoyers wrote:
> > > ----- On Apr 3, 2019, at 9:32 AM, paulmck paulmck@linux.ibm.com wrote:
> > > 
> > > > On Tue, Apr 02, 2019 at 11:34:07AM -0400, Mathieu Desnoyers wrote:
> > > >> ----- On Apr 2, 2019, at 11:23 AM, paulmck paulmck@linux.ibm.com wrote:
> > > >> 
> > > >> > On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
> > > >> >> ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:
> > > >> >> 
> > > >> >> > Hello!
> > > >> >> > 
> > > >> >> > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> > > >> >> > by loadable modules.  The reason for this prohibition is the fact
> > > >> >> > that using these two macros within modules requires that the size of
> > > >> >> > the reserved region be increased, which is not something we want to
> > > >> >> > be doing all that often.  Instead, loadable modules should define an
> > > >> >> > srcu_struct and invoke init_srcu_struct() from their module_init function
> > > >> >> > and cleanup_srcu_struct() from their module_exit function.  Note that
> > > >> >> > modules using call_srcu() will also need to invoke srcu_barrier() from
> > > >> >> > their module_exit function.
> > > >> >> 
> > > >> >> This arbitrary API limitation seems weird.
> > > >> >> 
> > > >> >> Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
> > > >> >> while implementing them with dynamic allocation under the hood ?
> > > >> > 
> > > >> > Although call_srcu() already has initialization hooks, some would
> > > >> > also be required in srcu_read_lock(), and I am concerned about adding
> > > >> > memory allocation at that point, especially given the possibility
> > > >> > of memory-allocation failure.  And the possibility that the first
> > > >> > srcu_read_lock() happens in an interrupt handler or similar.
> > > >> > 
> > > >> > Or am I missing a trick here?
> > > >> 
> > > >> I was more thinking that under #ifdef MODULE, both DEFINE_SRCU and
> > > >> DEFINE_STATIC_SRCU could append data in a dedicated section. module.c
> > > >> would additionally lookup that section on module load, and deal with
> > > >> those statically defined SRCU entries as if they were dynamically
> > > >> allocated ones. It would of course cleanup those resources on module
> > > >> unload.
> > > >> 
> > > >> Am I missing some subtlety there ?
> > > > 
> > > > If I understand you correctly, that is actually what is already done.  The
> > > > size of this dedicated section is currently set by PERCPU_MODULE_RESERVE,
> > > > and the additions of DEFINE{_STATIC}_SRCU() in modules was requiring that
> > > > this to be increased frequently.  That led to a request that something
> > > > be done, in turn leading to this patch series.
> > > 
> > > I think we are not expressing quite the same idea.
> > > 
> > > AFAIU, yours is to have DEFINE*_SRCU directly define per-cpu data within modules,
> > > which ends up using percpu module reserved memory.
> > > 
> > > My idea is to make DEFINE*_SRCU have a different behavior under #ifdef MODULE.
> > > It could emit a _global variable_ (_not_ per-cpu) within a new section. That
> > > section would then be used by module init/exit code to figure out what "srcu
> > > descriptors" are present in the modules. It would therefore rely on dynamic
> > > allocation for those, therefore removing the need to involve the percpu module
> > > reserved pool at all.
> > > 
> > > > 
> > > > I don't see a way around this short of changing module loading to do
> > > > alloc_percpu() and then updating the relocation based on this result.
> > > > Which would admittedly be far more convenient.  I was assuming that
> > > > this would be difficult due to varying CPU offsets or the like.
> > > > 
> > > > But if it can be done reasonably, it would be quite a bit nicer than
> > > > forcing dynamic allocation in cases where it is not otherwise needed.
> > > 
> > > Hopefully my explanation above helps clear out what I have in mind.
> > > 
> > > You can find similar tricks performed by include/linux/tracepoint.h:
> > > 
> > > #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> > > static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > {
> > >         return offset_to_ptr(p);
> > > }
> > > 
> > > #define __TRACEPOINT_ENTRY(name)                                        \
> > >         asm("   .section \"__tracepoints_ptrs\", \"a\"          \n"     \
> > >             "   .balign 4                                       \n"     \
> > >             "   .long   __tracepoint_" #name " - .              \n"     \
> > >             "   .previous                                       \n")
> > > #else
> > > static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > {
> > >         return *p;
> > > }
> > > 
> > > #define __TRACEPOINT_ENTRY(name)                                         \
> > >         static tracepoint_ptr_t __tracepoint_ptr_##name __used           \
> > >         __attribute__((section("__tracepoints_ptrs"))) =                 \
> > >                 &__tracepoint_##name
> > > #endif
> > > 
> > > [...]
> > > 
> > > #define DEFINE_TRACE_FN(name, reg, unreg)                                \
> > >         static const char __tpstrtab_##name[]                            \
> > >         __attribute__((section("__tracepoints_strings"))) = #name;       \
> > >         struct tracepoint __tracepoint_##name                            \
> > >         __attribute__((section("__tracepoints"), used)) =                \
> > >                 { __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
> > >         __TRACEPOINT_ENTRY(name);
> > > 
> > > And kernel/module.c:
> > > 
> > > find_module_sections():
> > > 
> > > #ifdef CONFIG_TRACEPOINTS
> > >         mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
> > >                                              sizeof(*mod->tracepoints_ptrs),
> > >                                              &mod->num_tracepoints);
> > > #endif
> > > 
> > > And kernel/tracepoint.c:tracepoint_module_notify() for the module coming/going
> > > notifier.
> > > 
> > > Basically you would want to have your own structure within your own section of
> > > the module which describes the srcu domain, and have a module coming/going
> > > notifier responsible for dynamically allocating the srcu domain on "coming", and
> > > doing a srcu barrier and cleanup the domain on "going".
> > 
> > Ah, sounds like an excellent approach!  I will give it a shot, thank you!
> 
> Please see below for an untested shot.
> 
> The original commits posted in this series are still available within
> the -srcu tree at branch srcunomod.2019.04.05a.  Yes, I am a digital
> packrat.  Why do you ask?
> 
> Thoughts?  Or more accurately, given that this is the first time I
> have used linker sections, what did I mess up?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit e24a0dab1414c563bb96bcb28d5963c9df18b1e8
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Fri Apr 5 16:15:00 2019 -0700
> 
>     srcu: Allocate per-CPU data for DEFINE_SRCU() in modules
>     
>     Adding DEFINE_SRCU() or DEFINE_STATIC_SRCU() to a loadable module requires
>     that the size of the reserved region be increased, which is not something
>     we want to be doing all that often.  One approach would be to require
>     that loadable modules define an srcu_struct and invoke init_srcu_struct()
>     from their module_init function and cleanup_srcu_struct() from their
>     module_exit function.  However, this is more than a bit user unfriendly.
>     
>     This commit therefore creates an ___srcu_struct_ptrs linker section,
>     and pointers to srcu_struct structures created by DEFINE_SRCU() and
>     DEFINE_STATIC_SRCU() within a module are placed into that module's
>     ___srcu_struct_ptrs section.  The required init_srcu_struct() and
>     cleanup_srcu_struct() functions are then automatically invoked as needed
>     when that module is loaded and unloaded, thus allowing modules to continue
>     to use DEFINE_SRCU() and DEFINE_STATIC_SRCU() while avoiding the need
>     to increase the size of the reserved region.
>     
>     Many of the algorithms and some of the code was cheerfully cherry-picked
>     from other code making use of linker sections, perhaps most notably from
>     tracepoints.  All bugs are nevertheless the sole property of the author.
>     
>     Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f8f6f04c4453..c2d919a1566e 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -338,6 +338,10 @@
>  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>  		__stop___tracepoints_ptrs = .;				\
>  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> +		. = ALIGN(8);						\
> +		__start___srcu_struct = .;				\
> +		*(___srcu_struct_ptrs)					\
> +		__end___srcu_struct = .;				\
>  	}								\

This vmlinux linker modification is not needed. I tested without it and srcu
torture works fine with rcutorture built as a module. Putting further prints
in kernel/module.c verified that the kernel is able to find the srcu structs
just fine. You could squash the below patch into this one or apply it on top
of the dev branch.

Thanks!

---8<-----------------------

From 369ad090f706ce8e1facdd18eb10828b5f7e2b72 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Sat, 6 Apr 2019 18:57:17 -0400
Subject: [PATCH] srcu: Remove unused vmlinux srcu linker entries

The SRCU for modules optimization introduced vmlinux linker entries
which is unused since it applies only to the built-in vmlinux. So remove
it to prevent any space usage due to the 8 byte alignment.

Tested with SRCU torture_type and rcutorture.

Cc: kernel-team@android.com
Cc: paulmck@linux.vnet.ibm.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/asm-generic/vmlinux.lds.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c2d919a1566e..f8f6f04c4453 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -338,10 +338,6 @@
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
 		__stop___tracepoints_ptrs = .;				\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
-		. = ALIGN(8);						\
-		__start___srcu_struct = .;				\
-		*(___srcu_struct_ptrs)					\
-		__end___srcu_struct = .;				\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
-- 
2.21.0.392.gf8f6787159e-goog

