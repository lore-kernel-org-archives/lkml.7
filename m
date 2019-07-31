Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A88C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7F4218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="houTSLkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfGaHSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:18:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50623 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGaHSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:18:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so59614898wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtSNFiPVmHNMGf6EfCgApRoebnc5Uef1+tJZX1b5aA8=;
        b=houTSLkWhFruGS1YjP+F2HpMrtJKvRK3yOUcGB2tYJsjZigE90sUSKY40izByu2hKj
         Ure9Oo/Xq6LZXTR/nbw7gSnqxopbYu1OetoClC7ERoctUDTXYJlQwLBybE5F9t0F3ofF
         rE+qSdtkpKNe6aXBNmD8Hjarz9xZmxkqK0jbCnSNGOO+w3DC1u+SP3nnPYpW3+yIRvnL
         Ov45LxDeqCEV/YWYIZZhigyrxKlCiTOKqycngm3y6+Dqe7zpRJiRtqq26iDY2nZM/VXj
         jRGa5W72huDFQJUPtvtE656mqeZ9BBuJpCXC0SKZPozz1akAEzSAVEJE6wHgrQcJib0I
         0MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtSNFiPVmHNMGf6EfCgApRoebnc5Uef1+tJZX1b5aA8=;
        b=oZ6FaDhTcgjWFZ6LxeB3YW1oGQDC4unE77lsO7kRPRH7SvP69JfukuNKvXUx06wBoA
         oM1R1ESFPc/19r9MwCYayeNqSnLcFAJ4R/6RxWDJI5ZUGhZ/0kHZUeCybaP2KeZecIQm
         Y32VfQHPJ0Cadqht+c/vJ0wkuc8MIipkKc/RYfxBydMCPGBxbfgLE83sSTg1f6+XAe37
         bhiSI0NjqXh5gxSm0h9/nuNcHXKVJhjEE6W5EkcN+dM9sWkIIoQaH1rF0G7750qD020q
         UmR6Te7a3tqhX1mzCUNbjCjautn6ukuwTDcOdg/JMagpl4gqA13bceF+/HESzPiflXqH
         XGSQ==
X-Gm-Message-State: APjAAAX0ZvVAz2lzQrZurbw/iRH+f/9VLR+QG+ni6U7BR74/BuQeGhyf
        IekIzc5oAv2Mu/q0V2acdwbsfYr8/sonkBcsTUB3zJp7
X-Google-Smtp-Source: APXvYqy52+S5rr0NnlEGRsA77YNyOQmNKrtlbAN8NxTIIT8HZ+91Pp6OkSOIRc4QpchzintHUX5ziKABydJCtuPT/iY=
X-Received: by 2002:a1c:be05:: with SMTP id o5mr110753474wmf.52.1564557532038;
 Wed, 31 Jul 2019 00:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190729115544.17895-1-anup.patel@wdc.com> <20190729115544.17895-14-anup.patel@wdc.com>
 <abedb067-b91f-8821-9bce-d27f6c4efdee@redhat.com> <7fe9e845c33e49e4c215e12b1ee1b5ed86a95bc1.camel@wdc.com>
 <0be68aeb-06de-71c7-375e-95f82112dae1@redhat.com>
In-Reply-To: <0be68aeb-06de-71c7-375e-95f82112dae1@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 31 Jul 2019 12:48:40 +0530
Message-ID: <CAAhSdy2KoYW0BiuUhZ9BEYH1wmh5xg6zcifF-rHPk5iktBBytQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/16] RISC-V: KVM: Add timer functionality
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:28 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 31/07/19 03:55, Atish Patra wrote:
> > On Tue, 2019-07-30 at 13:26 +0200, Paolo Bonzini wrote:
> >> On 29/07/19 13:57, Anup Patel wrote:
> >>> +   if (delta_ns > VCPU_TIMER_PROGRAM_THRESHOLD_NS) {
> >>> +           hrtimer_start(&t->hrt, ktime_add_ns(ktime_get(),
> >>> delta_ns),
> >>
> >> I think the guest would prefer if you saved the time before enabling
> >> interrupts on the host, and use that here instead of ktime_get().
> >> Otherwise the timer could be delayed arbitrarily by host interrupts.
> >>
> >> (Because the RISC-V SBI timer is relative only---which is
> >> unfortunate---
> >
> > Just to clarify: RISC-V SBI timer call passes absolute time.
> >
> > https://elixir.bootlin.com/linux/v5.3-rc2/source/drivers/clocksource/timer-riscv.c#L32
> >
> > That's why we compute a delta between absolute time passed via SBI and
> > current time. hrtimer is programmed to trigger only after the delta
> > time from now.
>
> Nevermind, I got lost in all the conversions.
>
> One important issue is the lack of ability to program a delta between
> HS/HU-mode cycles and VS/VU-mode cycles.  Without this, it's impossible
> to do virtual machine migration (except with hcounteren
> trap-and-emulate, which I think we agree is not acceptable).  I found
> the open issue at https://github.com/riscv/riscv-isa-manual/issues/298
> and commented on it.

This Github issue is open since quite some time now.

Thanks for commenting. I have pinged RISC-V spec maintainers as well.

Regards,
Anup
