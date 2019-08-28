Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4607C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89882208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfH1PkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:40:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39448 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1PkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:40:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so6935qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQd1Wd6sIuwfQa9t3LgHt+gZSyF0tuNs40fO1Z3cv/Y=;
        b=OJ+RG7Y8BXVonRa3sK9sFOIjLM1b5fgpFIqT7K4lz4esBmD4jwV67YgSSebMz4pR7g
         fJ21TN8bhRQKK1oadkdCuF4kF+LEK0B/QWvqMem3LCVNE5UM/9mAUgKvfTnu6AQ3ORbg
         unB0JHE+I4K39kWY8Z33ClErMtIRkIzESH6F7EkFgL1jg6akjiKLQgMl4NmQmxHjhTCT
         GUFH6pUda7HvHRI2oF6peUWrMJcel69HQ2r6zaXmjHgegfbZEWf37IMJcEw1sokolAWA
         iH7qszRovgQ3E+Ab92Se1Z/QOgdZEUMf8tVuBsXkRi2kManrEOrMBFGg4a3olkiEtOCj
         xwwg==
X-Gm-Message-State: APjAAAXXiKwPQSglf1yANUFpBHS3wEDPerkNvMQFUMFLbb2DVUp1cSqf
        4D/z3szcbxY+c9ZvjHzVoWyrtGSdYXTNs/PNQDE=
X-Google-Smtp-Source: APXvYqyAJRrB72TLDct+UGKCrez9qZxvGXYYC2yVuNU5UMlaFj9BDeG5+PKDOBPnsCdJnaOowv8HIcDHPqkLwseaiVc=
X-Received: by 2002:a0c:d07a:: with SMTP id d55mr3168143qvh.93.1567006817240;
 Wed, 28 Aug 2019 08:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
In-Reply-To: <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 17:40:01 +0200
Message-ID: <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
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

On Wed, Aug 28, 2019 at 5:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Aug 28, 2019 at 5:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Wed, Aug 28, 2019 at 05:13:59PM +0200, Arnd Bergmann wrote:
> > >
> > > When CONFIG_KASAN is set, clang decides to use memset() to set
> > > the first two struct members in this function:
> > >
> > >  static inline void sas_ss_reset(struct task_struct *p)
> > >  {
> > >         p->sas_ss_sp = 0;
> > >         p->sas_ss_size = 0;
> > >         p->sas_ss_flags = SS_DISABLE;
> > >  }
> > >
> > > and that is called from save_altstack_ex(). Adding a barrier() after
> > > the sas_ss_sp() works around the issue, but is certainly not the
> > > best solution. Any other ideas?
> >
> > Wow, is the compiler allowed to insert memset calls like that?  Seems a
> > bit overbearing, at least in a kernel context.  I don't recall GCC ever
> > doing it.
>
> Yes, it's free to assume that any standard library function behaves
> as defined, so it can and will turn struct assignments into memcpy
> or back, or replace string operations with others depending on what
> seems better for optimization.
>
> clang is more aggressive than gcc here, and this has caused some
> other problems in the past, but it's usually harmless.
>
> In theory, we could pass -ffreestanding to tell the compiler
> not to make assumptions about standard library function behavior,
> but that turns off all kinds of useful optimizations. The problem
> is really that the kernel is neither exactly hosted nor freestanding.

A slightly better workaround is to move the sas_ss_reset() out of
the try/catch block. Not sure if this is safe.

      Arnd

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 1cee10091b9f..14f8decf0ebc 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -379,6 +379,9 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
                put_user_ex(*((u64 *)&code), (u64 __user *)frame->retcode);
        } put_user_catch(err);

+       if (current->sas_ss_flags & SS_AUTODISARM)
+               sas_ss_reset(current);
+
        err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
        err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
                                     regs, set->sig[0]);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193e158d..fd49d28abbc5 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -414,6 +414,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
                 */
                put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
        } put_user_catch(err);
+
+       if (current->sas_ss_flags & SS_AUTODISARM)
+               sas_ss_reset(current);

        err |= copy_siginfo_to_user(&frame->info, &ksig->info);
        err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
diff --git a/include/linux/compat.h b/include/linux/compat.h
index a320495fd577..f5e36931e029 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -520,8 +520,6 @@ int __compat_save_altstack(compat_stack_t __user
*, unsigned long);
        put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp),
&__uss->ss_sp); \
        put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
        put_user_ex(t->sas_ss_size, &__uss->ss_size); \
-       if (t->sas_ss_flags & SS_AUTODISARM) \
-               sas_ss_reset(t); \
 } while (0);

 /*
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 67ceb6d7c869..9056239787f7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -435,8 +435,6 @@ int __save_altstack(stack_t __user *, unsigned long);
        put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
        put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
        put_user_ex(t->sas_ss_size, &__uss->ss_size); \
-       if (t->sas_ss_flags & SS_AUTODISARM) \
-               sas_ss_reset(t); \
 } while (0);

 #ifdef CONFIG_PROC_FS
