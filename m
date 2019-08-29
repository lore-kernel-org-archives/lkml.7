Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C676C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4402173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 23:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfH2XYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:24:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfH2XYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:24:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 713967F763;
        Thu, 29 Aug 2019 23:24:42 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD6F85D713;
        Thu, 29 Aug 2019 23:24:41 +0000 (UTC)
Date:   Thu, 29 Aug 2019 18:24:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190829232439.w3whzmci2vqtq53s@treble>
References: <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble>
 <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 29 Aug 2019 23:24:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:40:01PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 5:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Aug 28, 2019 at 5:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > On Wed, Aug 28, 2019 at 05:13:59PM +0200, Arnd Bergmann wrote:
> > > >
> > > > When CONFIG_KASAN is set, clang decides to use memset() to set
> > > > the first two struct members in this function:
> > > >
> > > >  static inline void sas_ss_reset(struct task_struct *p)
> > > >  {
> > > >         p->sas_ss_sp = 0;
> > > >         p->sas_ss_size = 0;
> > > >         p->sas_ss_flags = SS_DISABLE;
> > > >  }
> > > >
> > > > and that is called from save_altstack_ex(). Adding a barrier() after
> > > > the sas_ss_sp() works around the issue, but is certainly not the
> > > > best solution. Any other ideas?
> > >
> > > Wow, is the compiler allowed to insert memset calls like that?  Seems a
> > > bit overbearing, at least in a kernel context.  I don't recall GCC ever
> > > doing it.
> >
> > Yes, it's free to assume that any standard library function behaves
> > as defined, so it can and will turn struct assignments into memcpy
> > or back, or replace string operations with others depending on what
> > seems better for optimization.
> >
> > clang is more aggressive than gcc here, and this has caused some
> > other problems in the past, but it's usually harmless.
> >
> > In theory, we could pass -ffreestanding to tell the compiler
> > not to make assumptions about standard library function behavior,
> > but that turns off all kinds of useful optimizations. The problem
> > is really that the kernel is neither exactly hosted nor freestanding.
> 
> A slightly better workaround is to move the sas_ss_reset() out of
> the try/catch block. Not sure if this is safe.
> 
>       Arnd
> 
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 1cee10091b9f..14f8decf0ebc 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -379,6 +379,9 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
>                 put_user_ex(*((u64 *)&code), (u64 __user *)frame->retcode);
>         } put_user_catch(err);
> 
> +       if (current->sas_ss_flags & SS_AUTODISARM)
> +               sas_ss_reset(current);
> +
>         err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
>         err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
>                                      regs, set->sig[0]);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 8eb7193e158d..fd49d28abbc5 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -414,6 +414,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>                  */
>                 put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
>         } put_user_catch(err);
> +
> +       if (current->sas_ss_flags & SS_AUTODISARM)
> +               sas_ss_reset(current);
> 
>         err |= copy_siginfo_to_user(&frame->info, &ksig->info);
>         err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index a320495fd577..f5e36931e029 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -520,8 +520,6 @@ int __compat_save_altstack(compat_stack_t __user
> *, unsigned long);
>         put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp),
> &__uss->ss_sp); \
>         put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
>         put_user_ex(t->sas_ss_size, &__uss->ss_size); \
> -       if (t->sas_ss_flags & SS_AUTODISARM) \
> -               sas_ss_reset(t); \
>  } while (0);
> 
>  /*
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 67ceb6d7c869..9056239787f7 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -435,8 +435,6 @@ int __save_altstack(stack_t __user *, unsigned long);
>         put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
>         put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
>         put_user_ex(t->sas_ss_size, &__uss->ss_size); \
> -       if (t->sas_ss_flags & SS_AUTODISARM) \
> -               sas_ss_reset(t); \
>  } while (0);
> 
>  #ifdef CONFIG_PROC_FS

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
