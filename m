Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C23921897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YEpPQAEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405386AbfHWML2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:11:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405336AbfHWML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:11:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so8431129wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRAIEkmwp6JE/WX2NGJMgDWxiWJMs7wvHv42hCwyQfI=;
        b=YEpPQAEvWA9shVqsD3mh8d8r/uR1cXm76LWodn7SiQ5pxKz7XzPS/ZenBR9boBZyaG
         caGIKN8nTkYwxmJT/mzu7KBhHgk4GeQi8KzLsfjZvbcWPNgfjk8U7abtLLKyXdj5Iamh
         WEsHh//w59EZk4ZHq2zco+dvqKcSqeOpqKfAgAxs24rR3jk7qj70m/eSqghKeO27BCbg
         57q5BniRpmfS+Onee+Wyw2JZmiPvY2YoeKKMT+7msYpvsBdu8lDwXAgn8HTnnVp8Mqhf
         ANB5y7OGnpvyOk+4i8bGpz2IwFMlbb8/P8hrdq+BDZUs4bKztK084OcOQFc10fpgUOCS
         PrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRAIEkmwp6JE/WX2NGJMgDWxiWJMs7wvHv42hCwyQfI=;
        b=V0+FxKgEPhr+nHcKgarSZ7TLmCJmWOlnM4wSNijlQn3kWubjz9/zIxP/dq2c7ndzIb
         G8u5ZOYnCeo0HmDDe7cD+9Hgbu5gosJoFr+eIyOrMvfpGe1EcUOiT7ncX8yYzlVvnLo9
         8/EsHGFj0cnfO5IuSMc0XKTsFG2WygIfPfVs2/B2r+rA6TS1gMORhDemV0mu0EkU+ytM
         ZJY9inqakkapuMPib3vrCWHkurh5W9I5qCxHb0L/8EDEQHyUiq1et1FT7tX+2VLxP8mT
         cNyqM/eoU17eo8bdelEToeINTEmr4ccVcwi0IU0SclictqYzie+Xl9/sl8Jh+m32nibc
         7dEA==
X-Gm-Message-State: APjAAAUwnFxoJupEBEXTY01GeNkDttkyBtGx0Yq5PBYNXAZU57mQNkaf
        /7AoEzng00xzpRLSrlGVNlO0tyj87mj4VU2Edu1Tsg==
X-Google-Smtp-Source: APXvYqweuPNty8ifIydMeMGqUfpAmO11I/wuZUHMJ01iiMWWORMqB38dG8e4+ued1WCyfTwxqp2l51dVxUm9msyVfcc=
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr4728857wrv.323.1566562285504;
 Fri, 23 Aug 2019 05:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190822084131.114764-1-anup.patel@wdc.com> <20190822084131.114764-16-anup.patel@wdc.com>
 <09d74212-4fa3-d64c-5a63-d556e955b88c@amazon.com> <CAAhSdy36q5-x8cXM=M5S3cnE2nvCMhcsfuQayVt7jahd58HWFw@mail.gmail.com>
 <CA3A6A8A-0227-4B92-B892-86A0C7CA369E@amazon.com> <CAAhSdy2FFmCZJhNnMojp8QbiD-t6=4XrNtE9KGnCG_-mPb19-A@mail.gmail.com>
 <e369eba6-e659-2892-9cb9-a631dd10153a@amazon.com>
In-Reply-To: <e369eba6-e659-2892-9cb9-a631dd10153a@amazon.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Aug 2019 17:41:13 +0530
Message-ID: <CAAhSdy2sknED0W5-SpS4cP46cnS6biHYs_jRDgCj_Ucw5PUYzg@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] RISC-V: KVM: Add timer functionality
To:     Alexander Graf <graf@amazon.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 5:19 PM Alexander Graf <graf@amazon.com> wrote:
>
>
>
> On 23.08.19 13:46, Anup Patel wrote:
> > On Fri, Aug 23, 2019 at 5:03 PM Graf (AWS), Alexander <graf@amazon.com> wrote:
> >>
> >>
> >>
> >>> Am 23.08.2019 um 13:05 schrieb Anup Patel <anup@brainfault.org>:
> >>>
> >>>> On Fri, Aug 23, 2019 at 1:23 PM Alexander Graf <graf@amazon.com> wrote:
> >>>>
> >>>>> On 22.08.19 10:46, Anup Patel wrote:
> >>>>> From: Atish Patra <atish.patra@wdc.com>
> >>>>>
> >>>>> The RISC-V hypervisor specification doesn't have any virtual timer
> >>>>> feature.
> >>>>>
> >>>>> Due to this, the guest VCPU timer will be programmed via SBI calls.
> >>>>> The host will use a separate hrtimer event for each guest VCPU to
> >>>>> provide timer functionality. We inject a virtual timer interrupt to
> >>>>> the guest VCPU whenever the guest VCPU hrtimer event expires.
> >>>>>
> >>>>> The following features are not supported yet and will be added in
> >>>>> future:
> >>>>> 1. A time offset to adjust guest time from host time
> >>>>> 2. A saved next event in guest vcpu for vm migration
> >>>>
> >>>> Implementing these 2 bits right now should be trivial. Why wait?
> >>>
>
> [...]
>
> >>>> ... in fact, I feel like I'm missing something obvious here. How does
> >>>> the guest trigger the timer event? What is the argument it uses for that
> >>>> and how does that play with the tbfreq in the earlier patch?
> >>>
> >>> We have SBI call inferface between Hypervisor and Guest. One of the
> >>> SBI call allows Guest to program time event. The next event is specified
> >>> as absolute cycles. The Guest can read time using TIME CSR which
> >>> returns system timer value (@ tbfreq freqency).
> >>>
> >>> Guest Linux will know the tbfreq from DTB passed by QEMU/KVMTOOL
> >>> and it has to be same as Host tbfreq.
> >>>
> >>> The TBFREQ config register visible to user-space is a read-only CONFIG
> >>> register which tells user-space tools (QEMU/KVMTOOL) about Host tbfreq.
> >>
> >> And it's read-only because you can not trap on TB reads?
> >
> > There is no TB registers.
> >
> > The tbfreq can only be know through DT/ACPI kind-of HW description
> > for both Host and Guest.
> >
> > The KVM user-space tool needs to know TBFREQ so that it can set correct
> > value in generated DT for Guest Linux.
>
> So what access methods do get influenced by TBFREQ? If it's only the SBI
> timer, we can control the frequency, which means we can make TBFREQ
> read/write.

There are two things influenced by TBFREQ:
1. TIME CSR which is a free running counter
2. SBI calls for programming next timer event

The Guest TIME CSR will be at same rate as Host TIME CSR so
we cannot show different TBFREQ to Guest Linux.

In future, we will be having a dedicated RISC-V timer extension which
will have all programming done via CSRs but until then we are stuck
with TIME CSR + SBI call combination.

Regards,
Anup

>
>
> Alex
