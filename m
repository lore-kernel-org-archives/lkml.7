Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99129C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A0F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 03:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK8OVjTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfEFDmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 23:42:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36030 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 23:42:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id c14so3280919qke.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 20:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evolvfc+v/PDNzMrluV2UQ6Ca3y538x1hstsH93Ra8w=;
        b=YK8OVjTBIW7T1GEvXYMhHWYCjfY3CgPx2TBCu4U4XnziD9WfeBWmRvw2MH656182yn
         v5E0ELEy7ybRGIf2LIaEXC7e1+AM0CnRv5xRiw1C471J0xEK8w1mhdkecvwfAYvxvjDY
         yEi6/iycQ4h9EvgcyvKoe2ixzmmhGCYpefZa5Z+PLYdasB/4vegCtIs2bXERfCL4hSay
         UXvHLowEBEas4JJHnZhu0G8PzVTc/fIyGDuHJ45a68VqBtnLLtlGc6xoy1ALDydOn6jo
         WSh7oYMiR6uJnW4+hL/thRHdHwH9vVKxcgfV2U2qQsp4JbN+vWZh7cOIaPCJ9+1SOKs2
         MF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evolvfc+v/PDNzMrluV2UQ6Ca3y538x1hstsH93Ra8w=;
        b=GIqfRaA6s2C4uvaTTDsfpAUb3YKH9l2M9tc3MgbT1/APwFlsUVd0n6zXxVsyajYo5t
         bA76pngmGGFI7wXMQiHTwcoYOAgd5C+Qjjv5L69RuKQXNcftFIXwtSI1O4kGKlZzB8ej
         20aXjk1YcAJpmdMLYdXscMwxRWfez9bapZcyxGj9H0Ah5I5k/Q18NGuH1wQX1TzqYnGY
         CrMSG8fA5inbB9Sy7kpyohv4I84WT8/SYJUiEygIz63XIDHubQSMD1W8d/4f9NrinWLb
         9Gi572hp16JubYYmUAZ2UG05dqd4eWEaNERYZRmqdxvL+ozc/C35h1WSK08YIXbWtItx
         G3pQ==
X-Gm-Message-State: APjAAAWc5+G0NlstmFFkhe+WrXhtf3ajXu63XlX2890VlAEn0+1yMeYV
        ItgyHexPiSrz1/hU8PZmhR5LIHmmhqVEoK4FcwaBjg4QQ/ICJg==
X-Google-Smtp-Source: APXvYqzU2ai2PliPSf6C3qkb0Wsn8YH7PTRkcyfGmoYYVW+WtUlIKFpIeosC5YtXgT9nqOiKc5vDmanRuyCqoRkt7eg=
X-Received: by 2002:a37:404b:: with SMTP id n72mr18080998qka.98.1557114136488;
 Sun, 05 May 2019 20:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-20-duyuyang@gmail.com>
 <20190425193247.GU12232@hirez.programming.kicks-ass.net> <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
 <20190430121148.GV2623@hirez.programming.kicks-ass.net> <CAHttsrYfCdpNwQ81ppFQ9b_57tuLYOb=xi=CbRBysnB+LgjGGg@mail.gmail.com>
In-Reply-To: <CAHttsrYfCdpNwQ81ppFQ9b_57tuLYOb=xi=CbRBysnB+LgjGGg@mail.gmail.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Mon, 6 May 2019 11:42:05 +0800
Message-ID: <CAHttsrZKx0cgs6t9ahxmV7ENp6QWG4H9N7KMvsgrucQ_rsqTJQ@mail.gmail.com>
Subject: Re: [PATCH 19/28] locking/lockdep: Optimize irq usage check when
 marking lock usage bit
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 at 11:05, Yuyang Du <duyuyang@gmail.com> wrote:
>
> On Tue, 30 Apr 2019 at 20:12, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > IOW he's going to massively explode this storage.
> > >
> > > If I understand correctly, he is not going to.
> > >
> > > First of all, we can divide the whole usage thing into tracking and checking.
> > >
> > > Frederic's fine-grained soft vector state is applied to usage
> > > tracking, i.e., which specific vectors a lock is used or enabled.
> > >
> > > But for usage checking, which vectors are does not really matter. So,
> > > the current size of the arrays and bitmaps are good enough. Right?
> >
> > Frederic? My understanding was that he really was going to split the
> > whole thing. The moment you allow masking individual soft vectors, you
> > get per-vector dependency chains.
>
> It seems so. What I understand is: for IRQ usage, the difference is:
>
> Each lock has a new usage mask:
>
>         softirq10, ..., softirq1, hardirq
>
> where softirq1 | softirq2 | ... | softirq10 = softirq
>
> where softirq, exactly what was, virtually is used in the checking.
> This is mainly because, any irq vector has any usage, the lock has
> that usage, be it hard or soft.
>
> If that is right, hardirq can be split too (why not if softirq does
> :)). So, maybe a bitmap to do them all for tracking, and optionally
> maintain aggregate softirq and hardirq for checking as before.
> Regardless, may irq-safe reachability thing is not affected.
>
> And for the chain, which is mainly for caching does not really matter
> split or not (either way, the outcome will be the same?), because
> there will be a hash for a chain anyway, which is the same. Right?

Oh, another look at the patch, I was wrong, it can be very different
if consider: used in vector X vs. enabled on vector Y (which is ok),
when enablement can be so fine-grained as well, which is actually the
point of the patch, though no difference for now :(
