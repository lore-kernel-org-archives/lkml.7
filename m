Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79823ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A2720854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpztbZNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfJOKab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:30:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJOKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:30:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so7292243wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vxr/mA2PFXfH1I5ZAiT9cSLptniY090zS8qQy+lMTjk=;
        b=PpztbZNSd0sJALMrC6skU3NKQ6IxZq83Ff70p9uXTvDd1YwHJ9KqKmDLew6lEULwMe
         8U5aWt/7a/qMOg+6Q/oqf1kWzOn3R0k8Z+gvaBkhHEYc5Euz6kwQDxcdCWMBKbac4KGc
         /WQ+Iu0VWRXZyTJSpj/0s8b0zZ1kXu38VGGzFnrkx67f7oECLXo7r4Lxpha2zoTg5ntE
         HSYHMdI9SSAARcpjhirChvQpfbZwDR/BRUl90lRTbdYlSqTfsNvGYjcyXRZyB/oYVW+A
         JV6aPgAD/sPITmW+EJ6TzmM/al0EzTTrJtnAGFcXBbmBcUtddYNSGRxjBU8SqL2Ytdqx
         nXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vxr/mA2PFXfH1I5ZAiT9cSLptniY090zS8qQy+lMTjk=;
        b=CTniDd9xkg2xLrrLRXMwDyZoZH3MnfaW57qhoojriAoUj6lXA4rpAOa/oopdMucwL6
         +L+MLZ4mTpvewV06Rdot+6vWun+qUJxSmo7ymbPOFpucYLbZ/rPusn/bYHHrpMqS2ikH
         +7opuQiUxlDgxfYPpZBhK+j1AVcAtXW7SQCcr72roSFTRJBQXSglQeRbD/e+VEHXR65X
         vV7B7nlPtlUI4JzOseuBPC4DxU+FlJbmDCaEsUEFbCCZT1U1ODfaFIPdMP1UzUTvRaXl
         bpDgWwWqp4a1xdzUvk2mO9BzZeaoTvD2Xylwyyxbnu4P5VNjfcxzItRnQMKKWh0DeO0L
         7Pyg==
X-Gm-Message-State: APjAAAXL/MtQPMBKn3OOARJbBikHFxcd6ldbpjjdQNACDwzBmM6emCfb
        Ynxp6n3g9a1DNLebvN6u2O6J60zDJzmE+85d0gAaHWejBzOjig==
X-Google-Smtp-Source: APXvYqz3U7DItFZtfxqDafI7c4psAZb6eu9qBfRKzmkwCFeD6YGAtitMNt/eOj121YTD5ntAmTBAdpMlTv2pyd6O3RM=
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr28202302wrw.32.1571135427048;
 Tue, 15 Oct 2019 03:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com> <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com> <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com> <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com> <20191014155009.GM24047@e103592.cambridge.arm.com>
 <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com> <20191015102459.GV27757@arm.com>
In-Reply-To: <20191015102459.GV27757@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 15 Oct 2019 12:30:15 +0200
Message-ID: <CAKv+Gu_=jw94Hj5Vo=5w+hb5RcPR4SQvxOM02WQr9hDhyzE67g@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD capability
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 at 12:25, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Oct 14, 2019 at 06:57:30PM +0200, Ard Biesheuvel wrote:
> > On Mon, 14 Oct 2019 at 17:50, Dave P Martin <Dave.Martin@arm.com> wrote:
> > >
> > > On Mon, Oct 14, 2019 at 04:45:40PM +0100, Suzuki K Poulose wrote:
> > > >
> > > >
> > > > On 14/10/2019 15:52, Dave Martin wrote:
> > > > > On Fri, Oct 11, 2019 at 06:28:43PM +0100, Suzuki K Poulose wrote:
> > > > >>
> > > > >>
> > > > >> On 11/10/2019 15:21, Dave Martin wrote:
> > > > >>> On Fri, Oct 11, 2019 at 01:13:18PM +0100, Suzuki K Poulose wrote: > Hi Dave
> > > > >>>>
> > > > >>>> On 11/10/2019 12:36, Dave Martin wrote:
> > > > >>>>> On Thu, Oct 10, 2019 at 06:15:15PM +0100, Suzuki K Poulose wrote:
> > > > >>>>>> The NO_FPSIMD capability is defined with scope SYSTEM, which implies
> > > > >>>>>> that the "absence" of FP/SIMD on at least one CPU is detected only
> > > > >>>>>> after all the SMP CPUs are brought up. However, we use the status
> > > > >>>>>> of this capability for every context switch. So, let us change
> > > > >>>>>> the scop to LOCAL_CPU to allow the detection of this capability
> > > > >>>>>> as and when the first CPU without FP is brought up.
> > > > >>>>>>
> > > > >>>>>> Also, the current type allows hotplugged CPU to be brought up without
> > > > >>>>>> FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
> > > > >>>>>> up. Fix both of these issues by changing the capability to
> > > > >>>>>> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
> > > > >>>>>>
> > > > >>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
> > > > >>>>>> Cc: Will Deacon <will@kernel.org>
> > > > >>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
> > > > >>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > >>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > >>>>>> ---
> > > > >>>>>>   arch/arm64/kernel/cpufeature.c | 2 +-
> > > > >>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >>>>>>
> > > > >>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > > >>>>>> index 9323bcc40a58..0f9eace6c64b 100644
> > > > >>>>>> --- a/arch/arm64/kernel/cpufeature.c
> > > > >>>>>> +++ b/arch/arm64/kernel/cpufeature.c
> > > > >>>>>> @@ -1361,7 +1361,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > > > >>>>>>        {
> > > > >>>>>>                /* FP/SIMD is not implemented */
> > > > >>>>>>                .capability = ARM64_HAS_NO_FPSIMD,
> > > > >>>>>> -              .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > > >>>>>> +              .type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
> > > > >>>>>
> > > > >>>>> ARM64_HAS_NO_FPSIMD is really a disability, not a capability.
> > > > >>>>>
> > > > >>>>> Although we have other things that smell like this (CPU errata for
> > > > >>>>> example), I wonder whether inverting the meaning in the case would
> > > > >>>>> make the situation easier to understand.
> > > > >>>>
> > > > >>>> Yes, it is indeed a disability, more on that below.
> > > > >>>>
> > > > >>>>>
> > > > >>>>> So, we'd have ARM64_HAS_FPSIMD, with a minimum (signed) feature field
> > > > >>>>> value of 0.  Then this just looks like an ARM64_CPUCAP_SYSTEM_FEATURE
> > > > >>>>> IIUC.  We'd just need to invert the sense of the check in
> > > > >>>>> system_supports_fpsimd().
> > > > >>>>
> > > > >>>> This is particularly something we want to avoid with this patch. We want
> > > > >>>> to make sure that we have the up-to-date status of the disability right
> > > > >>>> when it happens. i.e, a CPU without FP/SIMD is brought up. With SYSTEM_FEATURE
> > > > >>>> you have to wait until we bring all the CPUs up. Also, for HAS_FPSIMD,
> > > > >>>> you must wait until all the CPUs are up, unlike the negated capability.
> > > > >>>
> > > > >>> I don't see why waiting for the random defective early CPU to come up is
> > > > >>> better than waiting for all the early CPUs to come up and then deciding.
> > > > >>>
> > > > >>> Kernel-mode NEON aside, the status of this cap should not matter until
> > > > >>> we enter userspace for the first time.
> > > > >>>
> > > > >>> The only issue is if e.g., crypto drivers that can use kernel-mode NEON
> > > > >>> probe for it before all early CPUs are up, and so cache the wrong
> > > > >>> decision.  The current approach doesn't cope with that anyway AFAICT.
> > > > >>
> > > > >> This approach does in fact. With LOCAL_CPU scope, the moment a defective
> > > > >> CPU turns up, we mark the "capability" and thus the kernel cannot use
> > > > >> the neon then onwards, unlike the existing case where we have time till
> > > > >> we boot all the CPUs (even when the boot CPU may be defective).
> > > > >
> > > > > I guess that makes sense.
> > > > >
> > > > > I'm now wondering what happens if anything tries to use kernel-mode NEON
> > > > > before SVE is initialised -- which doesn't happen until cpufeatures
> > > > > configures the system features.
> > > > >
> > > > > I don't think your proposed change makes anything worse here, but it may
> > > > > need looking into.
> > > >
> > > > We could throw in a WARN_ON() in kernel_neon() to make sure that the SVE
> > > > is initialised ?
> > >
> > > Could do, at least as an experiment.
> > >
> > > Ard, do you have any thoughts on this?
> > >
> >
> > All in-kernel NEON code checks whether the NEON is usable, so I'd
> > expect that check to return 'false' if it is too early in the boot for
> > the NEON to be used at all.
>
> My concern is that the check may be done once, at probe time, for crypto
> drivers.  If probing happens before system_supports_fpsimd() has
> stabilised, we may be stuck with the wrong probe decision.
>
> So: are crypto drivers and kernel_mode_neon() users definitely only
> probed _after_ all early CPUs are up?
>

Isn't SMP already up when initcalls are processed?
