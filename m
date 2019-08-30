Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E94EC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA02343A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfH3Ufk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 16:35:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727246AbfH3Ufk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:35:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 041F2AF68;
        Fri, 30 Aug 2019 20:35:38 +0000 (UTC)
Date:   Fri, 30 Aug 2019 22:35:35 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Nicolai Stange <nstange@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Allison Randal <allison@lohutok.net>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v6 4/6] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20190830223535.7ef0b76f@kitsune.suse.cz>
In-Reply-To: <a04b5750-a160-01a1-c208-7950f4c495bd@c-s.fr>
References: <cover.1567188299.git.msuchanek@suse.de>
        <6192bddc4631d2691b98316908432ffabc5d4b40.1567188299.git.msuchanek@suse.de>
        <a04b5750-a160-01a1-c208-7950f4c495bd@c-s.fr>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 22:21:09 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Le 30/08/2019 à 20:57, Michal Suchanek a écrit :
> > There are numerous references to 32bit functions in generic and 64bit
> > code so ifdef them out.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2:
> > - fix 32bit ifdef condition in signal.c
> > - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> > - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> > v3:
> > - use IS_ENABLED and maybe_unused where possible
> > - do not ifdef declarations
> > - clean up Makefile
> > v4:
> > - further makefile cleanup
> > - simplify is_32bit_task conditions
> > - avoid ifdef in condition by using return
> > v5:
> > - avoid unreachable code on 32bit
> > - make is_current_64bit constant on !COMPAT
> > - add stub perf_callchain_user_32 to avoid some ifdefs
> > v6:
> > - consolidate current_is_64bit
> > ---
> >   arch/powerpc/include/asm/thread_info.h |  4 +--
> >   arch/powerpc/kernel/Makefile           |  7 +++--
> >   arch/powerpc/kernel/entry_64.S         |  2 ++
> >   arch/powerpc/kernel/signal.c           |  3 +--
> >   arch/powerpc/kernel/syscall_64.c       |  6 ++---
> >   arch/powerpc/kernel/vdso.c             |  5 ++--
> >   arch/powerpc/perf/callchain.c          | 37 +++++++++++++++-----------
> >   7 files changed, 33 insertions(+), 31 deletions(-)
> >   
> 
> [...]
> 
> > diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> > index b7cdcce20280..788ad2c63f18 100644
> > --- a/arch/powerpc/perf/callchain.c
> > +++ b/arch/powerpc/perf/callchain.c
> > @@ -15,7 +15,7 @@
> >   #include <asm/sigcontext.h>
> >   #include <asm/ucontext.h>
> >   #include <asm/vdso.h>
> > -#ifdef CONFIG_PPC64
> > +#ifdef CONFIG_COMPAT
> >   #include "../kernel/ppc32.h"
> >   #endif
> >   #include <asm/pte-walk.h>
> > @@ -268,16 +268,6 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> >   	}
> >   }
> >   
> > -static inline int current_is_64bit(void)
> > -{
> > -	/*
> > -	 * We can't use test_thread_flag() here because we may be on an
> > -	 * interrupt stack, and the thread flags don't get copied over
> > -	 * from the thread_info on the main stack to the interrupt stack.
> > -	 */
> > -	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> > -}
> > -
> >   #else  /* CONFIG_PPC64 */
> >   static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> >   {
> > @@ -314,11 +304,6 @@ static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry
> >   {
> >   }
> >   
> > -static inline int current_is_64bit(void)
> > -{
> > -	return 0;
> > -}
> > -
> >   static inline int valid_user_sp(unsigned long sp, int is_64)
> >   {
> >   	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
> > @@ -334,6 +319,7 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
> >   
> >   #endif /* CONFIG_PPC64 */
> >   
> > +#if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
> >   /*
> >    * Layout for non-RT signal frames
> >    */
> > @@ -475,6 +461,25 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> >   		sp = next_sp;
> >   	}
> >   }
> > +#else /* 32bit */
> > +static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> > +				   struct pt_regs *regs)
> > +{
> > +	(void)&read_user_stack_32; /* unused if !COMPAT */  
> 
> You don't need that anymore do you ?

Yes, this part is not needed. It was removed later anyway but this
state is broken.

Thanks

Michal

> 
> Christophe
> 
> > +}
> > +#endif /* 32bit */
> > +
> > +static inline int current_is_64bit(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_COMPAT))
> > +		return IS_ENABLED(CONFIG_PPC64);
> > +	/*
> > +	 * We can't use test_thread_flag() here because we may be on an
> > +	 * interrupt stack, and the thread flags don't get copied over
> > +	 * from the thread_info on the main stack to the interrupt stack.
> > +	 */
> > +	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> > +}
> >   
> >   void
> >   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
> >   

