Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B39E23405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfH3Kom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:44:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42023 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfH3Kom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:44:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so7066436qtp.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 03:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4h0OUIol2dgMokFQI+wRdinat+23fMLG2R8rHiotl0c=;
        b=tnPLkJxJ4axFu+vVBBRVMYx1D8wmDVEvIpGUcSfihwayvAq6pdKBoqKCjbgKjw2U74
         njnLcgKN1/wzVs6oSPEK1/VHaGhCZeu4rLzbeJ/LmtYzSN2SElWd2IArlzR8oFOpLEQn
         PaBlOuEZuiDEcfBwKJ3d2h+rWy0IN+b7EWhIjJi3UO96L5meGKVSCSmdsrGIThT/qJlQ
         vKtQgKGyRsuur5jgUX77Y3sP9UXFXWRcLfumZxNE8sEyykMrpCMeyRdOuXEhiyRrz1Wa
         1NoTMz2QbVtTlOlsCbU/b+Vmq/o8ufGTHKK1qVSU0DwQLeJHceE8kELtUxs0bQhvWIY6
         uuFg==
X-Gm-Message-State: APjAAAWyhAGXDRb6ngSXitfA7XpbpmCESGaNRnAKpIVb1oRU4meIA6Cr
        rKMkTz5+2tmVmlwSL/7cNf6BdOBl2GTq6S2EMhQ=
X-Google-Smtp-Source: APXvYqxSYYrV8XCSyQc6aL0RMcrZhirBQtG4P56p5ULLwt67x4djO7RaoXG/s/BQ9NcKDVTL2vcWfDQSVcNHm6sidAs=
X-Received: by 2002:ac8:117:: with SMTP id e23mr14525852qtg.18.1567161880911;
 Fri, 30 Aug 2019 03:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com> <20190829232439.w3whzmci2vqtq53s@treble>
In-Reply-To: <20190829232439.w3whzmci2vqtq53s@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 12:44:24 +0200
Message-ID: <CAK8P3a0ddxbGVj974XS+PM_mSJDu=aGfTGarjmqMCuLKn81mRg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 1:24 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Aug 28, 2019 at 05:40:01PM +0200, Arnd Bergmann wrote:
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index 8eb7193e158d..fd49d28abbc5 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -414,6 +414,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> >                  */
> >                 put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
> >         } put_user_catch(err);
> > +
> > +       if (current->sas_ss_flags & SS_AUTODISARM)
> > +               sas_ss_reset(current);
> >
> >         err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> >         err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,

> > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > index 67ceb6d7c869..9056239787f7 100644
> > --- a/include/linux/signal.h
> > +++ b/include/linux/signal.h
> > @@ -435,8 +435,6 @@ int __save_altstack(stack_t __user *, unsigned long);
> >         put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
> >         put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
> >         put_user_ex(t->sas_ss_size, &__uss->ss_size); \
> > -       if (t->sas_ss_flags & SS_AUTODISARM) \
> > -               sas_ss_reset(t); \
> >  } while (0);
> >
> >  #ifdef CONFIG_PROC_FS
>
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks! Before I submit this version for inclusion, let's make sure this
is the best variant. I noticed later that save_altstack_ex() is meant to
behave the same as __save_altstack(), but my patch breaks that
assumption.

Two other alternatives I can think of are

- completely open-code save_altstack_ex() in its only call site on x86,
  in addition to the change above

- explicitly mark memset() as an exception in objtool in
  uaccess_safe_builtin[], assuming that is actually safe.

      Arnd
