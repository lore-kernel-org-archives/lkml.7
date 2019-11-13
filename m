Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FC4C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850CC222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKMIly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:41:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:45956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfKMIly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:41:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2237BB11F;
        Wed, 13 Nov 2019 08:41:49 +0000 (UTC)
Date:   Wed, 13 Nov 2019 09:41:37 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell Currey <ruscur@russell.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 31/33] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20191113084137.GI2770@kitsune.suse.cz>
References: <cover.1573576649.git.msuchanek@suse.de>
 <13fa324dc879a7f325290bf2e131b87eb491cd7b.1573576649.git.msuchanek@suse.de>
 <1573613683.ylw9dz9mlc.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573613683.ylw9dz9mlc.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 01:02:34PM +1000, Nicholas Piggin wrote:
> Michal Suchanek's on November 13, 2019 2:52 am:
> > There are numerous references to 32bit functions in generic and 64bit
> > code so ifdef them out.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> For the most part these seem okay to me.
> 
> > diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> > index 45f1d5e54671..35874119b398 100644
> > --- a/arch/powerpc/kernel/Makefile
> > +++ b/arch/powerpc/kernel/Makefile
> > @@ -44,16 +44,16 @@ CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
> >  endif
> >  
> >  obj-y				:= cputable.o ptrace.o syscalls.o \
> > -				   irq.o align.o signal_32.o pmc.o vdso.o \
> > +				   irq.o align.o signal_$(BITS).o pmc.o vdso.o \
> >  				   process.o systbl.o idle.o \
> >  				   signal.o sysfs.o cacheinfo.o time.o \
> >  				   prom.o traps.o setup-common.o \
> >  				   udbg.o misc.o io.o misc_$(BITS).o \
> >  				   of_platform.o prom_parse.o
> > -obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
> > -				   signal_64.o ptrace32.o \
> > +obj-$(CONFIG_PPC64)		+= setup_64.o \
> >  				   paca.o nvram_64.o firmware.o note.o \
> >  				   syscall_64.o
> > +obj-$(CONFIG_COMPAT)		+= sys_ppc32.o ptrace32.o signal_32.o
> >  obj-$(CONFIG_VDSO32)		+= vdso32/
> >  obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
> >  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 00173cc904ef..c339a984958f 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -52,8 +52,10 @@
> >  SYS_CALL_TABLE:
> >  	.tc sys_call_table[TC],sys_call_table
> >  
> > +#ifdef CONFIG_COMPAT
> >  COMPAT_SYS_CALL_TABLE:
> >  	.tc compat_sys_call_table[TC],compat_sys_call_table
> > +#endif
> >  
> >  /* This value is used to mark exception frames on the stack. */
> >  exception_marker:
> > diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> > index 60436432399f..61678cb0e6a1 100644
> > --- a/arch/powerpc/kernel/signal.c
> > +++ b/arch/powerpc/kernel/signal.c
> > @@ -247,7 +247,6 @@ static void do_signal(struct task_struct *tsk)
> >  	sigset_t *oldset = sigmask_to_save();
> >  	struct ksignal ksig = { .sig = 0 };
> >  	int ret;
> > -	int is32 = is_32bit_task();
> >  
> >  	BUG_ON(tsk != current);
> >  
> > @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
> >  
> >  	rseq_signal_deliver(&ksig, tsk->thread.regs);
> >  
> > -	if (is32) {
> > +	if (is_32bit_task()) {
> >          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> >  			ret = handle_rt_signal32(&ksig, oldset, tsk);
> >  		else
> 
> This is just a clean up I guess.

It also expands directly to if(0) or if(1) for the !COMPAT cases. I am
not sure how it would work with the intermediate variable.

There was more complex change initially but after some additional
cleanups removing the variable is the only part left.

> 
> > diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
> > index d00cfc4a39a9..319ebd4f494d 100644
> > --- a/arch/powerpc/kernel/syscall_64.c
> > +++ b/arch/powerpc/kernel/syscall_64.c
> > @@ -17,7 +17,6 @@ typedef long (*syscall_fn)(long, long, long, long, long, long);
> >  
> >  long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8, unsigned long r0, struct pt_regs *regs)
> >  {
> > -	unsigned long ti_flags;
> >  	syscall_fn f;
> >  
> >  	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
> > @@ -64,8 +63,7 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
> >  
> >  	__hard_irq_enable();
> >  
> > -	ti_flags = current_thread_info()->flags;
> > -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> > +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
> >  		/*
> >  		 * We use the return value of do_syscall_trace_enter() as the
> >  		 * syscall number. If the syscall was rejected for any reason
> > @@ -81,7 +79,7 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
> >  	/* May be faster to do array_index_nospec? */
> >  	barrier_nospec();
> >  
> > -	if (unlikely(ti_flags & _TIF_32BIT)) {
> > +	if (unlikely(is_32bit_task())) {
> >  		f = (void *)compat_sys_call_table[r0];
> >  
> >  		r3 &= 0x00000000ffffffffULL;
> 
> I guess this is okay, I did want to be careful about where ti_flags
> was loaded exactly, but I think DOTRACE and 32BIT are not volatile.
> Is it possible to define _TIF_32BIT to zero for 64-bit !compat case
> and have the original branch eliminated, or does that cause other
> problems?

is_32bit_task() expands to 0 or 1 constant unless CONFIG_COMPAT is set.
That's why the test needs replacing here.

Unsetting _TIF_32BIT might also be feasible but it is not necessary.

Thanks

Michal
