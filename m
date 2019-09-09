Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF5C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7250D2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdqQMjFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfIIGqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:46:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37688 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfIIGqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:46:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id g13so14587084qtj.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aArNse2b8Vb6qSqbvpv6BdKnL+SJhQZhCu9HW5eprFg=;
        b=XdqQMjFFEEy2OS5lPf2wk0FMcfAyop0Nfrxp52bZxXf01/f2Y2c7ySSOz4Nh7YW6DZ
         zCy6L+2Zzl+hVfEQculf8iuxoOB3m6vU2pwRND9lrQnmz90rUNnJZpO/ofUpiSGfEDd2
         AmAj2Em69pA071Sn6xFnaG5daPq5OmHFIU7BmqycpzdE/5FgePbzFlv8X17w03gys19g
         VG643VcvF1IRTtvu8h3TZ9qjQkRW7476bhUrs776hJcW45OVpUW18Bpgg9nIkhS2++uR
         LAGvcAJ+QuOheAL2qpFognzRnoaojdV97sla3bavjgwhmmI6Yu2QTvWCqkTLa6qsUvb0
         5tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aArNse2b8Vb6qSqbvpv6BdKnL+SJhQZhCu9HW5eprFg=;
        b=ELi24SQme/tZX7Tha8IkTghwCCvw2J7z/5QRgbHugtdWhy04qIfqwbloQfvXYXRL4W
         bYsKsAjct4BFO97g847iJ3cEgCHLjt0AU80G82/D7kYAIO02Q5JqbfAkfUEFIcT6bPia
         EZoDTjuVEuS124cL/Bzzz5UgGguZ+Pih7Ra+JrSGn16/Jhq29mtOvsHAOKqpap0QBSf4
         RhyVTlrHAb/gz937pjkvbNY4gfB5vvayRWfyxMAUbpIDw1BgyW4fxfV3XGfn++NRtu0P
         ZxlexSyqDR7QCzi2eMYae3XB8h7hIIHoGlgflq8rEtUSh9IXEgnNR4njljogflbQpKci
         fSFQ==
X-Gm-Message-State: APjAAAUBRfHnyMEhhsIwV5tjkgaG8UScyAvhg8feuohepwXNLudv4+CI
        Jn2cwikRKTuYG6CQJBF99oQbtRyC/SDDtFa7SwrW+w==
X-Google-Smtp-Source: APXvYqyGZJScBE9xWT2qOjjqhZF2pPSBJRJZqAWkZ6GHz1ACUR3z6cIVBPgLQiPEzw80Rs0c7TEl9ecAz41kOtgnSZg=
X-Received: by 2002:a05:6214:2e4:: with SMTP id h4mr5286591qvu.127.1568011564855;
 Sun, 08 Sep 2019 23:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000df42500592047e0a@google.com> <CAHk-=wgZneAegyitz7f+JLjB6=28ewtvT7M4xy_a-wqsTjOX_w@mail.gmail.com>
In-Reply-To: <CAHk-=wgZneAegyitz7f+JLjB6=28ewtvT7M4xy_a-wqsTjOX_w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Sep 2019 07:45:53 +0100
Message-ID: <CACT4Y+aC9FDNxpiQTQ0KeVr--NT7+qAj989-MDeP87pH88q7Fg@mail.gmail.com>
Subject: Re: general protection fault in qdisc_put
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+d5870a903591faaca4ae@syzkaller.appspotmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 6:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Sep 7, 2019 at 11:08 PM syzbot
> <syzbot+d5870a903591faaca4ae@syzkaller.appspotmail.com> wrote:
> >
> > The bug was bisected to:
> >
> > commit e41d58185f1444368873d4d7422f7664a68be61d
> > Author: Dmitry Vyukov <dvyukov@google.com>
> > Date:   Wed Jul 12 21:34:35 2017 +0000
> >
> >      fault-inject: support systematic fault injection
>
> That commit does seem a bit questionable, but not the cause of this
> problem (just the trigger).
>
> I think the questionable part is that the new code doesn't honor the
> task filtering, and will fail even for protected tasks. Dmitry?

That commit added a new fault injection mode with a new API that is
used by syzkaller to inject faults. Before that commit the fault
inject is not working for syzkaller at all. I think this bisection
result simply means "the GPF is related to an earlier failure".

> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 9699 Comm: syz-executor169 Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:qdisc_put+0x25/0x90 net/sched/sch_generic.c:983
>
> Yes, looks like 'qdisc' is NULL.
>
> This is the
>
>         qdisc_put(q->qdisc);
>
> in sfb_destroy(), called from qdisc_create().
>
> I think what is happening is this (in qdisc_create()):
>
>         if (ops->init) {
>                 err = ops->init(sch, tca[TCA_OPTIONS], extack);
>                 if (err != 0)
>                         goto err_out5;
>         }
>         ...
> err_out5:
>         /* ops->init() failed, we call ->destroy() like qdisc_create_dflt() */
>         if (ops->destroy)
>                 ops->destroy(sch);
>
> and "ops->init" is sfb_init(), which will not initialize q->qdisc if
> tcf_block_get() fails.
>
> I see two solutions:
>
>  (a) move the
>
>         q->qdisc = &noop_qdisc;
>
>      up earlier in sfb_init(), so that qdisc is always initialized
> after sfb_init(), even on failure.
>
>  (b) just make qdisc_put(NULL) just silently work as a no-op.
>
>  (c) change all the semantics to not call ->destroy if ->init failed.
>
> Honestly, (a) seems very fragile - do all the other init routines do
> this? And (c) sounds like a big change, and very fragile too.
>
> So I'd suggest that qdisc_put() be made to just ignore a NULL pointer
> (and maybe an error pointer too?).
>
> But I'll leave it to the maintainers to sort out the proper fix.
> Maybe people prefer (a)?
>
>                    Linus
