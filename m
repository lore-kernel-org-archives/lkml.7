Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3384AC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF212166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+zov0oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfHJJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 05:47:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35913 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfHJJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 05:47:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so7650463wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iij52VdnIxKgrAmCJ+5BwvJNqGzmX18SaZQUx0VGI7E=;
        b=U+zov0oAsWTx1mE4/BAWgExHMXrejokAEI7u5t01zaiXTbB8p3ZfIb3o2HHrx9s4sL
         71ThlcdFFJacToU4yrwtlas/NzEXjEDdeKIUrcChsLeWa/WaKnnRAOtLrgPldaOatSPP
         pusExBj4sYtbNT+GBXRprENtseLiYu7zZj0V3UoP+i+pJ6kaCMcxr17dxK50Ve+zz+HA
         SnpTYvWek49cDA7CoLawA+hJJSsPxhV+8aiX9MsbOyBNh1/W7zWyPZTlOEvTdNQ0kq46
         GqqCUqJ2HRo3AqyRe0bKmzp3GPtL4Z9c7Jek8XZQULqDsM7s3m20sNjn5PFC7FTohl17
         QNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iij52VdnIxKgrAmCJ+5BwvJNqGzmX18SaZQUx0VGI7E=;
        b=lNJLj+mDquQaRApfJUWe1px+Is5S3s2GUncdllqREFvQWxqiDjrO5ml49FszPbTT7x
         DVnlajYlmgEvj22hu3VtS3qrDb3Lk4A4HcoLYlSdCi2uFPbNWFglmPgv9uUBiUjgIfU0
         SWDnkBfuvcvnszN0QNH/xGbw4EeBdGi6K+XedBT0fGFoA3/93KcRChGcNF1q9D4Pp0Nv
         ZZ9auyu9aTkdduNWteX4sYQGxc8ZqdEe/J1a84CJSwAThw0oIWGNGEmxXj3nG+KruhOc
         88E0IxvZyFcogx7WtBLpGjkRqUQOS2s86r0uMiuXumD2CqQ0alQQ3QYPlVgq4MRUAPaT
         UgPw==
X-Gm-Message-State: APjAAAUvpIKCXcGy+IqO9Bh4aSCzyjLMT2RTmRme79R/ZJH7mEBFvvAP
        L6E2hbC59DMGCh7cjKOenk0HKZuZxBXT9Hhensw=
X-Google-Smtp-Source: APXvYqw5QlCtgYF1ORpUnKZHcUFEQKWYjdN4hoYseKoTaCF3MzytysQQ+RwpOSlNm9vDP+xK2Q1hGLyOYc8onem2TyM=
X-Received: by 2002:a1c:c915:: with SMTP id f21mr15212246wmb.173.1565430449202;
 Sat, 10 Aug 2019 02:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com>
 <a98ba3d0-5596-664a-a1ee-5777cff0ddd9@kernel.org> <6fd4d706-b66d-6390-749a-8a06b17cb487@huawei.com>
 <alpine.DEB.2.21.1907221723450.2082@nanos.tec.linutronix.de> <8e1201a7-3e69-e048-6aa3-3b87e86d55ac@huawei.com>
In-Reply-To: <8e1201a7-3e69-e048-6aa3-3b87e86d55ac@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 10 Aug 2019 17:47:17 +0800
Message-ID: <CACVXFVPMZpUrDORA4YDQiwd+VG-OoOhv1G0NeeqSdz7Udfzryg@mail.gmail.com>
Subject: Re: About threaded interrupt handler CPU affinity
To:     John Garry <john.garry@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 1:40 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/07/2019 16:34, Thomas Gleixner wrote:
> > John,
> >
>
> Hi Thomas,
>
> > On Mon, 22 Jul 2019, John Garry wrote:
> >> On 22/07/2019 15:41, Marc Zyngier wrote:
> >>> On 22/07/2019 15:14, John Garry wrote:
> >>>> I have a question on commit cbf8699996a6 ("genirq: Let irq thread follow
> >>>> the effective hard irq affinity"), if you could kindly check:
> >>>>
> >>>> Here we set the thread affinity to be the same as the hard interrupt
> >>>> affinity. For an arm64 system with GIC ITS, this will be a single CPU,
> >>>> the lowest in the interrupt affinity mask. So, in this case, effectively
> >>>> the thread will be bound to a single CPU. I think APIC is the same for
> >>>> this.
> >>>>
> >>>> The commit message describes the problem that we solve here is that the
> >>>> thread may become affine to a different CPU to the hard interrupt - does
> >>>> it mean that the thread CPU mask could not cover that of the hard
> >>>> interrupt? I couldn't follow the reason.
> >>>
> >>> Assume a 4 CPU system. If the interrupt affinity is on CPU0-1, you could
> >>> end up with the effective interrupt affinity on CPU0 (which would be
> >>> typical of the ITS), and the thread running on CPU1. Not great.
> >>
> >> Sure, not great. But the thread can possibly still run on CPU0.
> >
> > Sure. It could, but it's up to the scheduler to decide. In general it's the
> > right thing to run the threaded handler on the CPU which handles the
> > interrupt.
>
> I'd agree.
>
> >With single CPU affinity thats surely a limitation.
> >
> >>>> We have experimented with fixing the thread mask to be the same as the
> >>>> interrupt mask (we're using managed interrupts), like before, and get a
> >>>> significant performance boost at high IO datarates on our storage
> >>>> controller - like ~11%.
> >>>
> >>> My understanding is that this patch does exactly that. Does it result in
> >>> a regression?
> >>
> >> Not in the strictest sense for us, I don't know about others. Currently we use
> >> tasklets, and we find that the CPUs servicing the interrupts (and hence
> >> tasklets) are heavily loaded. We experience the same for when experimenting
> >> with threaded interrupt handlers - which would be as expected.
> >>
> >> But, when we make the change as mentioned, our IOPS goes from ~3M -> 3.4M.
> >
> > So your interrupt is affined to more than one CPU, but due to the ITS
> > limitation the effective affinity is a single CPU, which in turn restricts
> > the thread handler affinity to the same single CPU.
>
> Even though this is an ITS limitation, the same thing is effectively
> done for x86 APIC as policy, right? I'm referring to commit fdba46ffb4c2
> ("x86/apic: Get rid of multi CPU affinity")
>
>   If you lift that
> > restriction and let it be affine to the full affinity set of the interrupt
> > then you get better performance, right?
>
> Right
>
>   Probably because the other CPU(s)
> > in the affinity set are less loaded than the one which handles the hard
> > interrupt.
>
> I will look to get some figures for CPU loading to back this up.
>
> >
> > This is heavily use case dependent I assume, so making this a general
> > change is perhaps not a good idea, but we could surely make this optional.
>
> That sounds reasonable. So would the idea be to enable this optionally
> at the request threaded irq call?

I'd suggest to do it for managed IRQ at default, because managed IRQ affinity
is NUMA locality and setup gracefully. And the idea behind is good since the IRQ
handler should have been run in the specified CPUs, especially the thread part
often takes more CPU.


Thanks,
Ming Lei
