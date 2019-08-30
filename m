Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E42341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfH3PO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfH3PO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:14:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A52394E926;
        Fri, 30 Aug 2019 15:14:25 +0000 (UTC)
Received: from treble (ovpn-125-111.rdu2.redhat.com [10.10.125.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E0E102BD86;
        Fri, 30 Aug 2019 15:14:24 +0000 (UTC)
Date:   Fri, 30 Aug 2019 10:14:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190830151422.o4pbvjyravrz2wre@treble>
References: <20190827192255.wbyn732llzckmqmq@treble>
 <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
 <20190829232439.w3whzmci2vqtq53s@treble>
 <CAK8P3a0ddxbGVj974XS+PM_mSJDu=aGfTGarjmqMCuLKn81mRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0ddxbGVj974XS+PM_mSJDu=aGfTGarjmqMCuLKn81mRg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Aug 2019 15:14:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:44:24PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 30, 2019 at 1:24 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Wed, Aug 28, 2019 at 05:40:01PM +0200, Arnd Bergmann wrote:
> > > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > > index 8eb7193e158d..fd49d28abbc5 100644
> > > --- a/arch/x86/kernel/signal.c
> > > +++ b/arch/x86/kernel/signal.c
> > > @@ -414,6 +414,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> > >                  */
> > >                 put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
> > >         } put_user_catch(err);
> > > +
> > > +       if (current->sas_ss_flags & SS_AUTODISARM)
> > > +               sas_ss_reset(current);
> > >
> > >         err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> > >         err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
> 
> > > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > > index 67ceb6d7c869..9056239787f7 100644
> > > --- a/include/linux/signal.h
> > > +++ b/include/linux/signal.h
> > > @@ -435,8 +435,6 @@ int __save_altstack(stack_t __user *, unsigned long);
> > >         put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
> > >         put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
> > >         put_user_ex(t->sas_ss_size, &__uss->ss_size); \
> > > -       if (t->sas_ss_flags & SS_AUTODISARM) \
> > > -               sas_ss_reset(t); \
> > >  } while (0);
> > >
> > >  #ifdef CONFIG_PROC_FS
> >
> > Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Thanks! Before I submit this version for inclusion, let's make sure this
> is the best variant. I noticed later that save_altstack_ex() is meant to
> behave the same as __save_altstack(), but my patch breaks that
> assumption.

Good point.

There's also compat_save_altstack_ex() -- which presumably needs the
same fix? -- and __compat_save_altstack().

> Two other alternatives I can think of are
> 
> - completely open-code save_altstack_ex() in its only call site on x86,
>   in addition to the change above

But it has two call sites: the 32-bit and 64-bit versions of
save_altstack_ex().

> - explicitly mark memset() as an exception in objtool in
>   uaccess_safe_builtin[], assuming that is actually safe.

I wonder if this might open up more theoretical SMAP holes for other
callers to memset().

What about just adding a couple of WRITE_ONCE's to sas_ss_reset()?  That
would probably be the least disruptive option.

Or even better, it would be great if we could get Clang to change their
memset() insertion heuristics, so that KASAN acts more like non-KASAN
code in that regard.

-- 
Josh
