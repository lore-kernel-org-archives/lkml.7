Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E26020665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="oyQ71NyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbfIWTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:13:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41513 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfIWTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:13:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so13993508edv.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stujTPtuGxuh59HTJ15B3m0skvzv4BxR2W0z7AHqmAs=;
        b=oyQ71NyOLCUCt3yrY4nzC3lmDE+RcloHR0cEYYRhtoJqaMrnTmBYWSRql93lKpdu/2
         bQrXfU9nfGQiEaAJlAXpotQPEAdsSUEJzcK1TJZdtDuOUgQpzT68LYoBtLzhCFlZpTRJ
         sOnLNz+ZCb/ooZ7Iz+F3s9J4d0eKTxzB9FAn34SubnMWewIiyOjoe9FDaI1tIMpIlgun
         AK+RuOBGaMOfBm1D/kLl4+++0qsBgwRznMqymwyisovqATfNnGBGb/epBk1cSr2HYziZ
         oBCaqwi4skj15AXxVrdUY03bPLGkEMGpebrDS+lLUEFOg8+Rrbn4NAaqNBqr7ymyjR8s
         BdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stujTPtuGxuh59HTJ15B3m0skvzv4BxR2W0z7AHqmAs=;
        b=jQyZ2E1ZAiGNtOn1UTLX2cEkGkPu3REUZ2k6awoLktELBbyHkxMkOaPQfC6i8Q75WF
         wGhE+zLTUgbYEvM2Sheb6kkN5cVIshqOuEx/Vod8SuLHxYKWMO1XaMPYrcr72amP9P3H
         oWh2JLms3tzkU41B8rWUiYKkOvpjYCKaeloXgywwQqSRMFtkuTlyqAXKcBUBhRHyP2en
         4sT7J1biAJ2qb+BMXp999RBFwqFvtEGcF9X9hxbWffGnfSsuuZ6MaggoFVnkA9ENXTbk
         r5NCCyeeTo1n6n93wRY2BT1N+gUz3Wy3FMDYBBnWF0ha952jbL4JO8J6WPN2kM2Hu6VQ
         WGAQ==
X-Gm-Message-State: APjAAAU4j2Oya4tz5a9QmNA6yqp6HV/spw5ocQU60qlPpXnV57h1E06N
        Ur0eWL1mPD10vx8Io244qTpo5DlZUQpRrSQRQW9Rfw==
X-Google-Smtp-Source: APXvYqwRmTK/cSlvNliNjYHt44n1Pba7VrLA3KdlnvROdyhykOSCNlF6ArPxqorDu7Day5E1074ogmGxE30V3X5XG3E=
X-Received: by 2002:aa7:d7d3:: with SMTP id e19mr1824376eds.80.1569266002752;
 Mon, 23 Sep 2019 12:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190722103330.255312-1-marc.zyngier@arm.com> <CA+CK2bAFgDcc6ySCz7zzyeN0wg5WTcxFrKYQ6y5sz7grw-BfAw@mail.gmail.com>
 <86k1c9nrsa.wl-marc.zyngier@arm.com>
In-Reply-To: <86k1c9nrsa.wl-marc.zyngier@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 23 Sep 2019 15:13:11 -0400
Message-ID: <CA+CK2bBzoxDz2BgqbJn8-MzL-aaSon+mqKuAmikH-nBnwm0O2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: Allow early timestamping of kernel log
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 3:17 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On Mon, 22 Jul 2019 21:52:42 +0100,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 3:33 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > >
> > > So far, we've let the arm64 kernel start its meaningful time stamping
> > > of the kernel log pretty late, which is caused by sched_clock() being
> > > initialised rather late compared to other architectures.
> > >
> > > Pavel Tatashin proposed[1] to move the initialisation of sched_clock
> > > much earlier, which I had objections to. The reason for initialising
> > > sched_clock late is that a number of systems have broken counters, and
> > > we need to apply all kind of terrifying workarounds to avoid time
> > > going backward on the affected platforms. Being able to identify the
> > > right workaround comes pretty late in the kernel boot, and providing
> > > an unreliable sched_clock, even for a short period of time, isn't an
> > > appealing prospect.
> > >
> > > To address this, I'm proposing that we allow an architecture to chose
> > > to (1) divorce time stamping and sched_clock during the early phase of
> > > booting, and (2) inherit the time stamping clock as the new epoch the
> > > first time a sched_sched clock gets registered.

Hi Marc,

I know we briefly discussed this at plumbers, but I want to bring it
up again, because I am still puzzled why it is not possible to
stabilize unstable clock early in boot.

Here is an example where clock is stabilized:
https://soleen.com/source/xref/linux/kernel/sched/clock.c?r=457c8996#265

It uses a value that is read at last ticks to normalize clock, and
because ticks are not available early in boot instead we can make sure
that early in boot sched_clock() never returns value smaller than
previously returned value, and if we want to be extra careful, we can
also make sure that sched_clock() early in boot does not jump ahead by
more than some fixed amount of time i.e. more than one hour.

If sched_clock() is available early we will get the benefit of having
other tracers that use it to debug early boot information.

Pasha
