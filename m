Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08889C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8E20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngOih2XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfGOTT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:19:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37526 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfGOTT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:19:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id w13so16575736eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMx9vapOigGOTwjLxXUo2InQBXCmRL05UybT81nmsi4=;
        b=ngOih2XWy2FuUfJWjAXcpaZ4cXN60SVhp2G5wzxPZlSoEU7s0eZqv6t8qm+m+URSZw
         IQtHFls/1t42QKkUE+WEmhGM5/Ue6OtlJMEqpXyGG0Mo6biPdMh80CJ4i8/KgcxDfbAi
         nqAERIXpDEasSL4HaVInfBKaK6e5gOE87ABiEw+Cd3LYeDHTrZOUy/ZE3eVbr5H+HPLQ
         nTdXkawXqE0yL5M7OwctT1aUW38jLsdEkwOY0K8DHrBCUYw+R+rmX3Ri/fGmcX+NLOyq
         dl9sJvy4lu3BKm2VxDI4JTWXV+kFm9HJYvi9Dl6zGAc02O/tjw2EIBY6PsTgIC5gyzop
         MRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMx9vapOigGOTwjLxXUo2InQBXCmRL05UybT81nmsi4=;
        b=YiTlHID9s5c9Ud2b6vBRbhbr1/FtsJgdLf3eXKjwWPl3vf7kbOrRAAwKcR6Y2fM7sE
         bWV8nsscl6EKouapJLka3z/dubpG1+HhA5Z296MTk7WOH+BWTuCPyJuQk6tcZkefPiYE
         uIoz4wCw/0aPORl7EdboFMoXiqZO/YAgkNp/f63GAGrg9o2/teFZrtRXUgccudRPvA1C
         f02YsZiIOi6jl+ch++2uaTN6GQZYI0iVWLoKhzeWs/WASEvLhQpd1JNOioff8fBeE3/2
         Nqj0kcQIV/z6babdP0qEhNkscD+agejsqJuQgoRZnL1njnq4w/cnaU95oJnyrY+5ExgG
         pUQw==
X-Gm-Message-State: APjAAAV7RHZ6R/8Jh/ZbA3ydKsWClM5S9cOYCZdOrdU240oUZ2vv8IOw
        lpqxeum/q2+82ShDYRk4Vp0vaC4DzSH5b0mhWJc=
X-Google-Smtp-Source: APXvYqyzTDNsXjjcPyXLwaW3mOqp86Uzkst9l5SDI7as2SOj3aCAsLAvqAPGyjq+bZdw44ZV1fk+ad44rsXfrFYXe6A=
X-Received: by 2002:a05:6402:129a:: with SMTP id w26mr24907280edv.167.1563218367166;
 Mon, 15 Jul 2019 12:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <8736j7gsza.fsf@linux.intel.com> <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 15 Jul 2019 21:19:16 +0200
Message-ID: <CAFULd4bcB8tsgZuxZJm_ksp5zyDQXjO=v_Ov622Bmhx=fr7KuA@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 8:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 15 Jul 2019, Andi Kleen wrote:
> > Uros Bizjak <ubizjak@gmail.com> writes:
> >
> > > Recent patch [1] disabled a self-snoop feature on a list of processor
> > > models with a known errata, so we are confident that the feature
> > > should work on remaining models also for other purposes than to speed
> > > up MTRR programming.
> >
> > MTRR is very different than TLBs.
> >
> > >From my understanding not flushing with PAT is only safe everywhere when
> > the memory is only used for coherent devices (like the Internal GPU on
> > Intel CPUs). We don't have any infrastructure to track or enforce
> > this unfortunately.
>
> Right, we don't know where the PAT invocation comes from and whether they
> are safe to omit flushing the cache. The module load code would be one
> obvious candidate.
>
> But unless there is some really worthwhile speedup, e.g. for boot, then
> adding some flag to let CPA know about the safe 'no flush' operation might
> be not worth it.

For the reference, FreeBSD implements this approach, later changed to
use pmap_invalidate_cache_range ifunc (that calls
pmap_invalidate_cache_range_selfsnoop for targets with self-snoop
capability) and pmap_force_invalidate_cache_range [1]. The full
cross-referenced source is at [2].

[1] https://reviews.freebsd.org/D16736
[2] http://fxr.watson.org/fxr/source/amd64/amd64/pmap.c

Uros.
