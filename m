Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8338C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88560216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567963143;
	bh=Icw6fgX/ukych6H4A+wyJb3QuuIXWcIfUtiqbqfzALk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FQqEfkbeqd+qr9njakdbcpOO/K8r2pb4DroJshYqtYTnZ3NzpRXoQFFga4BI6ag+q
	 xRW/FVGd8PMbX07T4r2pyezC4jY2Y0/rJUxr+uLmXBEQ4ZfEuv5aMIgkPTIsohHcfe
	 svwHGwBMoCzKv8yzEkTsCtd+FALujuHVLpKmWfDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfIHRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 13:19:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37921 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbfIHRTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 13:19:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so10105802ljn.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MN/k8JnJCOEcYirzdoyavFDle+e4eQE4j09q5zgR3Mc=;
        b=P/fOWPzFGuUw2HnbXH0aGI1vTJtMlTcyLYQJDi7B1Fc6zZotQHBs4dKyvRTgVICulo
         PAakjj5F8cfS2TJ/i/Gj9latl50LmDpUKB3ppf/OcTYNuOfab5BrnCwLljNSj7BTCk5m
         QcvzdjLjAqPpiaGGVmEn+6xGYd0KEMGPisGGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MN/k8JnJCOEcYirzdoyavFDle+e4eQE4j09q5zgR3Mc=;
        b=LAVW9ZPmUrdmZdQCnPpupyenp7elCb5C7FL6xLKyRIO3A9T6d28T68IhtzKXLRxIJ2
         /JfL+mosBDEIZmi6xTs7tLfRr+XddaWahlmGs5jyijgdpHDLRGXqvzAjFY4DzRdqFyvF
         vsE0hPGw0eDjpKue+mtP5PAzQpJN9yDNyFiK4YZxikX0xXEMLFkwubkwS2QeCKIWVWEj
         HwW2ElDa0UPr+AcabTAla7Tjm7MGhvfxKknWJ6P6A73FYww2oIePEB5Y76gmwTfr+Fso
         KQsQTBiNGMQOKm2+BNeVE81/S6Uiz1/PKuqUTEHDeCbH3vqAvqA6gfcrtXEy6xu9ZleU
         3+LQ==
X-Gm-Message-State: APjAAAVRiETnlU70Oorur/6HMdO2vUACLuTW/9IgnzAKNT0Yja5yQSBJ
        tcd6m5sipr6c6kSyBTU58Ql5jZWS1VY=
X-Google-Smtp-Source: APXvYqwIPNecbIcMZydoVRn5pP4X0y7y/39q0MdFGzURUz/Px+VASOF3cFdvY8ncFVQmmDGLgL6U4Q==
X-Received: by 2002:a2e:8103:: with SMTP id d3mr13167332ljg.105.1567963139866;
        Sun, 08 Sep 2019 10:18:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a14sm2330873lfg.74.2019.09.08.10.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2019 10:18:58 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 7so10418312ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 10:18:58 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr5088745ljo.180.1567963138439;
 Sun, 08 Sep 2019 10:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000df42500592047e0a@google.com>
In-Reply-To: <000000000000df42500592047e0a@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Sep 2019 10:18:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZneAegyitz7f+JLjB6=28ewtvT7M4xy_a-wqsTjOX_w@mail.gmail.com>
Message-ID: <CAHk-=wgZneAegyitz7f+JLjB6=28ewtvT7M4xy_a-wqsTjOX_w@mail.gmail.com>
Subject: Re: general protection fault in qdisc_put
To:     syzbot <syzbot+d5870a903591faaca4ae@syzkaller.appspotmail.com>
Cc:     akinobu.mita@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>, jhs@mojatatu.com,
        jiri@resnulli.us,
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

On Sat, Sep 7, 2019 at 11:08 PM syzbot
<syzbot+d5870a903591faaca4ae@syzkaller.appspotmail.com> wrote:
>
> The bug was bisected to:
>
> commit e41d58185f1444368873d4d7422f7664a68be61d
> Author: Dmitry Vyukov <dvyukov@google.com>
> Date:   Wed Jul 12 21:34:35 2017 +0000
>
>      fault-inject: support systematic fault injection

That commit does seem a bit questionable, but not the cause of this
problem (just the trigger).

I think the questionable part is that the new code doesn't honor the
task filtering, and will fail even for protected tasks. Dmitry?

> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 9699 Comm: syz-executor169 Not tainted 5.3.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:qdisc_put+0x25/0x90 net/sched/sch_generic.c:983

Yes, looks like 'qdisc' is NULL.

This is the

        qdisc_put(q->qdisc);

in sfb_destroy(), called from qdisc_create().

I think what is happening is this (in qdisc_create()):

        if (ops->init) {
                err = ops->init(sch, tca[TCA_OPTIONS], extack);
                if (err != 0)
                        goto err_out5;
        }
        ...
err_out5:
        /* ops->init() failed, we call ->destroy() like qdisc_create_dflt() */
        if (ops->destroy)
                ops->destroy(sch);

and "ops->init" is sfb_init(), which will not initialize q->qdisc if
tcf_block_get() fails.

I see two solutions:

 (a) move the

        q->qdisc = &noop_qdisc;

     up earlier in sfb_init(), so that qdisc is always initialized
after sfb_init(), even on failure.

 (b) just make qdisc_put(NULL) just silently work as a no-op.

 (c) change all the semantics to not call ->destroy if ->init failed.

Honestly, (a) seems very fragile - do all the other init routines do
this? And (c) sounds like a big change, and very fragile too.

So I'd suggest that qdisc_put() be made to just ignore a NULL pointer
(and maybe an error pointer too?).

But I'll leave it to the maintainers to sort out the proper fix.
Maybe people prefer (a)?

                   Linus
