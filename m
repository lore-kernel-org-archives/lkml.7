Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BCAC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0266520854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzgD3Jbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbfJNQ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:57:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50510 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJNQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:57:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so18046566wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llON5toOWi2bZ+EE1q0Z/QUJpndkKf2DNgWPmwYksfQ=;
        b=ZzgD3Jbn2ktYUCG1ShTxDW6V90lyllgeMmDKv8Ub8GF0rxsJxYn5YqATRlKmu+4GsV
         vgx5YoGWzta0LlB6m9iz3FsiCGANPQv23KuM5zEC+HrcUXXhRxk7QOkGiq5KC55RjCPw
         O+gK8mChRm2vA7ly4iOLv7RIs8Ey2Kp+Jrlk8XIBLwCceOR4KFVqfYYf9hNupQ5fwRRN
         1e1+6wbAKix07wTye8AyGnZ5EnhmgWVD7C5vpAZbikYCnjmyv8gOn+xm5H5RmA90urNk
         dXW1nejEkqDyZ7u7+uBx9PQ55IGedX/rq9ZWSEXN6BiRLBUH2U50wqk1Gbcgg2VRJ1PV
         v46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llON5toOWi2bZ+EE1q0Z/QUJpndkKf2DNgWPmwYksfQ=;
        b=GIuPIGXH3bMiT96iqH0tiB4mTWNHLwSr2UntetTIHJld3U/WjDSS68gqQ96IYPxKGc
         8YN4vxPeH+f8KRpnmbtD4Ythl43BiRQ+Nzk1Im+mSlEcjON8VEulWqDgdGJR46gNj1SW
         fkygr/94l/CkzVqOAZ7tP1GASx1ZhY7CGwf5ibMJfvotH+i8q1NCGiSMdqxSVF5rLsy+
         KXXyNWhSez+im/bIZvEr1Ljw9ckoMaC8qUrP+h9ODzTGjSSNrDqWOmEikQqfmSHkb3BX
         CSeqhtQW1KR6KUZgrMBrYPx27WoF66ZreAeYE6CIbUrq0Y+6fcaQp7qf8afmKqZ3vBFA
         fVpQ==
X-Gm-Message-State: APjAAAWkscyT/VArwaz6ZfUMQvpCdNo2ehzmUKMGgilQeOEthJt1hpjn
        1Tt91VGVxv9aQkIAhIbuMNaQ9n1Tw7iOEjbPTqY61w==
X-Google-Smtp-Source: APXvYqxWnHQOjzcs7wXVKeBx8Rfnrc4denkCs9byW/mRpcJYeegYV/fsEXUw6MvLUzIFiNdhTH5aFimyaebe3sK4AFU=
X-Received: by 2002:a1c:a9c5:: with SMTP id s188mr14432821wme.61.1571072262432;
 Mon, 14 Oct 2019 09:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-2-suzuki.poulose@arm.com> <20191011113620.GG27757@arm.com>
 <4ba5c423-4e2a-d810-cd36-32a16ad42c91@arm.com> <20191011142137.GH27757@arm.com>
 <418b0c4b-cbcd-4263-276d-1e9edc5eee0b@arm.com> <20191014145204.GS27757@arm.com>
 <12e002e7-42e8-c205-e42c-3348359d2f98@arm.com> <20191014155009.GM24047@e103592.cambridge.arm.com>
In-Reply-To: <20191014155009.GM24047@e103592.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 14 Oct 2019 18:57:30 +0200
Message-ID: <CAKv+Gu83oa3+DKNFowVkE=mZfLorAvGQ3GVPiZtsXzQBcsMCWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: cpufeature: Fix the type of no FP/SIMD capability
To:     Dave P Martin <Dave.Martin@arm.com>
Cc:     Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 17:50, Dave P Martin <Dave.Martin@arm.com> wrote:
>
> On Mon, Oct 14, 2019 at 04:45:40PM +0100, Suzuki K Poulose wrote:
> >
> >
> > On 14/10/2019 15:52, Dave Martin wrote:
> > > On Fri, Oct 11, 2019 at 06:28:43PM +0100, Suzuki K Poulose wrote:
> > >>
> > >>
> > >> On 11/10/2019 15:21, Dave Martin wrote:
> > >>> On Fri, Oct 11, 2019 at 01:13:18PM +0100, Suzuki K Poulose wrote: > Hi Dave
> > >>>>
> > >>>> On 11/10/2019 12:36, Dave Martin wrote:
> > >>>>> On Thu, Oct 10, 2019 at 06:15:15PM +0100, Suzuki K Poulose wrote:
> > >>>>>> The NO_FPSIMD capability is defined with scope SYSTEM, which implies
> > >>>>>> that the "absence" of FP/SIMD on at least one CPU is detected only
> > >>>>>> after all the SMP CPUs are brought up. However, we use the status
> > >>>>>> of this capability for every context switch. So, let us change
> > >>>>>> the scop to LOCAL_CPU to allow the detection of this capability
> > >>>>>> as and when the first CPU without FP is brought up.
> > >>>>>>
> > >>>>>> Also, the current type allows hotplugged CPU to be brought up without
> > >>>>>> FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
> > >>>>>> up. Fix both of these issues by changing the capability to
> > >>>>>> BOOT_RESTRICTED_LOCAL_CPU_FEATURE.
> > >>>>>>
> > >>>>>> Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
> > >>>>>> Cc: Will Deacon <will@kernel.org>
> > >>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
> > >>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> > >>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > >>>>>> ---
> > >>>>>>   arch/arm64/kernel/cpufeature.c | 2 +-
> > >>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>>
> > >>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > >>>>>> index 9323bcc40a58..0f9eace6c64b 100644
> > >>>>>> --- a/arch/arm64/kernel/cpufeature.c
> > >>>>>> +++ b/arch/arm64/kernel/cpufeature.c
> > >>>>>> @@ -1361,7 +1361,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > >>>>>>        {
> > >>>>>>                /* FP/SIMD is not implemented */
> > >>>>>>                .capability = ARM64_HAS_NO_FPSIMD,
> > >>>>>> -              .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > >>>>>> +              .type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
> > >>>>>
> > >>>>> ARM64_HAS_NO_FPSIMD is really a disability, not a capability.
> > >>>>>
> > >>>>> Although we have other things that smell like this (CPU errata for
> > >>>>> example), I wonder whether inverting the meaning in the case would
> > >>>>> make the situation easier to understand.
> > >>>>
> > >>>> Yes, it is indeed a disability, more on that below.
> > >>>>
> > >>>>>
> > >>>>> So, we'd have ARM64_HAS_FPSIMD, with a minimum (signed) feature field
> > >>>>> value of 0.  Then this just looks like an ARM64_CPUCAP_SYSTEM_FEATURE
> > >>>>> IIUC.  We'd just need to invert the sense of the check in
> > >>>>> system_supports_fpsimd().
> > >>>>
> > >>>> This is particularly something we want to avoid with this patch. We want
> > >>>> to make sure that we have the up-to-date status of the disability right
> > >>>> when it happens. i.e, a CPU without FP/SIMD is brought up. With SYSTEM_FEATURE
> > >>>> you have to wait until we bring all the CPUs up. Also, for HAS_FPSIMD,
> > >>>> you must wait until all the CPUs are up, unlike the negated capability.
> > >>>
> > >>> I don't see why waiting for the random defective early CPU to come up is
> > >>> better than waiting for all the early CPUs to come up and then deciding.
> > >>>
> > >>> Kernel-mode NEON aside, the status of this cap should not matter until
> > >>> we enter userspace for the first time.
> > >>>
> > >>> The only issue is if e.g., crypto drivers that can use kernel-mode NEON
> > >>> probe for it before all early CPUs are up, and so cache the wrong
> > >>> decision.  The current approach doesn't cope with that anyway AFAICT.
> > >>
> > >> This approach does in fact. With LOCAL_CPU scope, the moment a defective
> > >> CPU turns up, we mark the "capability" and thus the kernel cannot use
> > >> the neon then onwards, unlike the existing case where we have time till
> > >> we boot all the CPUs (even when the boot CPU may be defective).
> > >
> > > I guess that makes sense.
> > >
> > > I'm now wondering what happens if anything tries to use kernel-mode NEON
> > > before SVE is initialised -- which doesn't happen until cpufeatures
> > > configures the system features.
> > >
> > > I don't think your proposed change makes anything worse here, but it may
> > > need looking into.
> >
> > We could throw in a WARN_ON() in kernel_neon() to make sure that the SVE
> > is initialised ?
>
> Could do, at least as an experiment.
>
> Ard, do you have any thoughts on this?
>

All in-kernel NEON code checks whether the NEON is usable, so I'd
expect that check to return 'false' if it is too early in the boot for
the NEON to be used at all.
