Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270CC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F542341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfH3P7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:59:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45717 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3P7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:59:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id r15so2441819qtn.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1NptnaKsHGtVYobYo+gGBTUiMbQOSW0eYJzS/qWLqw=;
        b=cNmFO9Yo+WY/57uv8FaldRlQxzw1N88MublP/TFRqXgYJ2zRUxXdOhL6rmF0oj8Kfd
         0YXwsmTej1Jq+GTcNBHLEfcZayEg3x43ZvXBA2TKkgJGvdr8FSTj8UiMdwtAgz27hdbJ
         xSj7P4G42yQxfovbS7Q+lrS4ux65Wp5q0zgubAQonjFDF18hiqGLxi5D+YSbIcqdZ5V4
         veMLPxag0jaPNNxUgY7abAnjI4rGyyMpTq/gB12LF5FG1KnlMjfZegT3yPUtidkvO2WS
         /f4TLBfyPMKEWW8e9pFP+RRbsA5Dp0xaTU2xQzPIwFF1z6/YXgceI/sTWnKnNRTAMwKH
         xWwQ==
X-Gm-Message-State: APjAAAXZmB7ac/jMIFCjAX/1X0n2yL0/zXuaH6oYNF9AB27mDOGMfDuh
        FrThjEDFPEbsjgKd3up/VwHqzSLhZ/czuu4TEQ4=
X-Google-Smtp-Source: APXvYqz1jmm88ay9mIxv7qKKZj78yEMuvvLMBTTFiV++PZYrmJ6Y6HrhuhyYUrbOMz9431YgRGxVq3OfIuXMde5DQ4A=
X-Received: by 2002:a05:6214:80b:: with SMTP id df11mr3948711qvb.45.1567180738675;
 Fri, 30 Aug 2019 08:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
 <20190829232439.w3whzmci2vqtq53s@treble> <CAK8P3a0ddxbGVj974XS+PM_mSJDu=aGfTGarjmqMCuLKn81mRg@mail.gmail.com>
 <20190830151422.o4pbvjyravrz2wre@treble>
In-Reply-To: <20190830151422.o4pbvjyravrz2wre@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 17:58:41 +0200
Message-ID: <CAK8P3a33LQAzsReSUyB_aZxkws28RP=oJocQXonYbxxBky7aaQ@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 5:14 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Aug 30, 2019 at 12:44:24PM +0200, Arnd Bergmann wrote:
> > On Fri, Aug 30, 2019 at 1:24 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > On Wed, Aug 28, 2019 at 05:40:01PM +0200, Arnd Bergmann wrote:
> > > > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > > > index 8eb7193e158d..fd49d28abbc5 100644
> > > > --- a/arch/x86/kernel/signal.c
> > > > +++ b/arch/x86/kernel/signal.c
> > > > @@ -414,6 +414,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> > > >                  */
> > > >                 put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
> > > >         } put_user_catch(err);
> > > > +
> > > > +       if (current->sas_ss_flags & SS_AUTODISARM)
> > > > +               sas_ss_reset(current);
> > > >
> > > >         err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> > > >         err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
> >
> > > > diff --git a/include/linux/signal.h b/include/linux/signal.h
> > > > index 67ceb6d7c869..9056239787f7 100644
> > > > --- a/include/linux/signal.h
> > > > +++ b/include/linux/signal.h
> > > > @@ -435,8 +435,6 @@ int __save_altstack(stack_t __user *, unsigned long);
> > > >         put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
> > > >         put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
> > > >         put_user_ex(t->sas_ss_size, &__uss->ss_size); \
> > > > -       if (t->sas_ss_flags & SS_AUTODISARM) \
> > > > -               sas_ss_reset(t); \
> > > >  } while (0);
> > > >
> > > >  #ifdef CONFIG_PROC_FS
> > >
> > > Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >
> > Thanks! Before I submit this version for inclusion, let's make sure this
> > is the best variant. I noticed later that save_altstack_ex() is meant to
> > behave the same as __save_altstack(), but my patch breaks that
> > assumption.
>
> Good point.
>
> There's also compat_save_altstack_ex() -- which presumably needs the
> same fix? -- and __compat_save_altstack().

Yes, I meant both here of course (as in my earlier patch).

> > Two other alternatives I can think of are
> >
> > - completely open-code save_altstack_ex() in its only call site on x86,
> >   in addition to the change above
>
> But it has two call sites: the 32-bit and 64-bit versions of
> save_altstack_ex().

Ah, that's what I get for looking only at the compat version.

> > - explicitly mark memset() as an exception in objtool in
> >   uaccess_safe_builtin[], assuming that is actually safe.
>
> I wonder if this might open up more theoretical SMAP holes for other
> callers to memset().
>
> What about just adding a couple of WRITE_ONCE's to sas_ss_reset()?  That
> would probably be the least disruptive option.

Fine with me, too.

> Or even better, it would be great if we could get Clang to change their
> memset() insertion heuristics, so that KASAN acts more like non-KASAN
> code in that regard.

I suspect that's going to be harder. The clang-9 release is going to be
soon, and that change probably wouldn't be considered a regression fix.

Maybe Nick can find what happens, but I don't actually see any reference
to KASAN in the llvm source code related to the memset generation.

https://github.com/llvm-mirror/clang/blob/master/lib/CodeGen/CGExprAgg.cpp#L1803
has a check for >16 bytes, but that again does not match my observation.

     Arnd
