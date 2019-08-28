Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24ECC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD77E22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfH1P3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:29:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43730 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1P3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:29:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so75534qkd.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAe1wjp9JN1ttLqqfLIB3tUk3jgO2VwykepSQ75JmU4=;
        b=LKnsPJSaTlG4mZKZYKw5NaEql/fynIUSfIvqm7to6OjPXfDZpLJEiUE8Aiook8ryFf
         ziGNiaq3pqodL2Xm5Z+L6aVUMCR6G5D6SYgFeajUXp5tTwFJELgmxTLIPi+gBnMSlfla
         rEWk6+GJDDSMwnYiCOVJ/cnRZCwU1Yyg10WX7WK3rknEpE38b8WsBBq+fed55AFNotQu
         kkvOlX1Vs3MelfyHUqXPMscXtaaTRabmvoRw1hFQtprSW4UfkdJGJqYRYR4mUsakUay7
         O8pNyzTrLrXYz3ZVfHcTHUa7oRtfw9b601UVr/1WGNH/vNo8jKVHb4jdZbN4iAcYSuPa
         9SeA==
X-Gm-Message-State: APjAAAVQaWuNsUkJ1FYq7C9UGXkJa8K21lqNuMRTy9i7mNoKo7IuIItA
        wAQqS6h5ZzRqRxaGnZA/B390ZEJKmEp9a1ItEy0=
X-Google-Smtp-Source: APXvYqyBc7cLJzmMCd2Y39mzszTMAggeXra6JZI2DfOgfk96SVOch19MaiL98x8Ri9d7VL39d4izHLYG1D5eaQ6EYAs=
X-Received: by 2002:a37:bd44:: with SMTP id n65mr4552576qkf.286.1567006147108;
 Wed, 28 Aug 2019 08:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com> <20190828152226.r6pl64ij5kol6d4p@treble>
In-Reply-To: <20190828152226.r6pl64ij5kol6d4p@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Aug 2019 17:28:50 +0200
Message-ID: <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
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

On Wed, Aug 28, 2019 at 5:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Aug 28, 2019 at 05:13:59PM +0200, Arnd Bergmann wrote:
> > On Wed, Aug 28, 2019 at 11:00 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Aug 27, 2019 at 11:22 PM 'Nick Desaulniers' via Clang Built Linux <clang-built-linux@googlegroups.com> wrote:
> > I figured this one out as well:
> >
> > > http://paste.ubuntu.com/p/XjdDsypRxX/
> > > 0x5BA1B7A1:arch/x86/ia32/ia32_signal.o: warning: objtool:
> > > ia32_setup_rt_frame()+0x238: call to memset() with UACCESS enabled
> > > 0x5BA1B7A1:arch/x86/kernel/signal.o: warning: objtool:
> > > __setup_rt_frame()+0x5b8: call to memset() with UACCESS enabled
> >
> > When CONFIG_KASAN is set, clang decides to use memset() to set
> > the first two struct members in this function:
> >
> >  static inline void sas_ss_reset(struct task_struct *p)
> >  {
> >         p->sas_ss_sp = 0;
> >         p->sas_ss_size = 0;
> >         p->sas_ss_flags = SS_DISABLE;
> >  }
> >
> > and that is called from save_altstack_ex(). Adding a barrier() after
> > the sas_ss_sp() works around the issue, but is certainly not the
> > best solution. Any other ideas?
>
> Wow, is the compiler allowed to insert memset calls like that?  Seems a
> bit overbearing, at least in a kernel context.  I don't recall GCC ever
> doing it.

Yes, it's free to assume that any standard library function behaves
as defined, so it can and will turn struct assignments into memcpy
or back, or replace string operations with others depending on what
seems better for optimization.

clang is more aggressive than gcc here, and this has caused some
other problems in the past, but it's usually harmless.

In theory, we could pass -ffreestanding to tell the compiler
not to make assumptions about standard library function behavior,
but that turns off all kinds of useful optimizations. The problem
is really that the kernel is neither exactly hosted nor freestanding.

       Arnd
