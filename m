Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3693620850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQSNtXP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKSBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:01:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37777 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKSBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:01:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so4021735vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiTdxbR/Lnuud6AEHWf71vo3FVoh7MoNjxOQrobPs0A=;
        b=OQSNtXP5SB8zFweDIqdroMcA8DOQ7BIg0sNCujk2AEYm5QgLHJMFrTsBGlHdr4QCB6
         TZVhjNOSWr+7r4qxJIyQ5U74m8Yu1LM62r07CgW37uPwtVg2nTInCLyW9VpUb7ZwIS4d
         /NZd23hVSc9lIJuxxmAtwDVJwQ5U+c5kPpCxW9K393aT/gcdwKigUsEAZjJVBwBxC2un
         Hx3c/3nos5T0VVUZck3PuKBEY5OC7IvF/Z7EWKAugZTTryc/XqX7qsydX4xDEZmrOQQl
         172hvtduYLQw7esbIJjyn9pzjngPalCOjbRmUJjxRykEsUL0GtfJ8OZMotO/kb9otYI/
         FpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiTdxbR/Lnuud6AEHWf71vo3FVoh7MoNjxOQrobPs0A=;
        b=QcpahauPNID+rz+SUiVQOaEOLGb0kUXNTJkAP00dQrr4SSv/qybbhMz7DqimJ/sznr
         FqDNRTXHo0D0Th16Ab26T/rCDv1IwkyFQaKXaw/oZQ/YdreS5KKpoPaubetUlRkPDRqa
         g4YnlCRK6PvZsy3Zqvjhy0691BoXpq4Jn2PDjYrp9Cgh+Hiot2jeAwT+UrhIVepUC7WA
         V99kAnP8j9r3PupqoUT6ZQmHSHOgYhiVZBtUOyVZiVLJgBjJWlvytpiALk7NHkHOOKAy
         CsS2NWvH411/387dKBDQ2Uun30NbN8YNOIKlniberzC3a/rjcH0hHSMU9ic5E1qK1N3a
         ikkw==
X-Gm-Message-State: APjAAAXkdTJBkCQAtFZZ1KLsJiflTHF8/V1uPlY5OtQ5eNz7v05xDeEU
        kXiWqoF3syfTEA9ZljsFNuipe/lXjHpRNkWh+z5pOA==
X-Google-Smtp-Source: APXvYqx8XPYiDgHZ0gQYochFd76iE1WBRHxNlh0I6aqddVTYYC0kJWigXoZpVKvXflsFBaTv0baSlBp1u9qGYNPenUA=
X-Received: by 2002:a67:fa95:: with SMTP id f21mr28367782vsq.180.1555005679726;
 Thu, 11 Apr 2019 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190411124739.5542-1-cai@lca.pw> <CAPDyKFqmP3pORhufTsCg1nuqSPGz8hEQNTpZgr24fFqk13hM3w@mail.gmail.com>
 <CAJZ5v0hWL1dGPZX0aotcJ7cT_LdHvreZvx-fR7B_9Y=mqxSyzw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hWL1dGPZX0aotcJ7cT_LdHvreZvx-fR7B_9Y=mqxSyzw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 20:00:43 +0200
Message-ID: <CAPDyKFpVsNB3T7FtveK1rcTOtmOzEOQrSZ3zS+ze6jexVqw9nA@mail.gmail.com>
Subject: Re: [PATCH -next] power/domain_governor: fix a compilation error
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Lina Iyer <lina.iyer@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 16:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 11, 2019 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 11 Apr 2019 at 14:48, Qian Cai <cai@lca.pw> wrote:
> > >
> > > The commit 50899f7d5078 ("PM / Domains: Add genpd governor for CPUs")
> > > introduced a compilation error on arm64 with CONFIG_CPU_IDLE=n because
> > > cpuidle_devices is undefined there.
> > >
> > > drivers/base/power/domain_governor.o: In function `cpu_power_down_ok':
> > > drivers/base/power/domain_governor.c:263: undefined reference to
> > > 'cpuidle_devices' ld: drivers/base/power/domain_governor.o: relocation
> > > R_AARCH64_ADR_PREL_PG_HI21 against symbol 'cpuidle_devices' which may
> > > bind externally can not be used when making a shared object; recompile
> > > with -fPIC
> > > drivers/base/power/domain_governor.c:263:(.text+0x638): dangerous
> > > relocation: unsupported relocation
> > > drivers/base/power/domain_governor.c:263: undefined reference to
> > > 'cpuidle_devices'
> > > make: *** [Makefile:1047: vmlinux] Error 1
> > >
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> >
> > Qian, thanks for you patch!
> >
> > > ---
> > >  drivers/base/power/domain_governor.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> > > index 39c8a699cb53..252d88fcf760 100644
> > > --- a/drivers/base/power/domain_governor.c
> > > +++ b/drivers/base/power/domain_governor.c
> > > @@ -270,11 +270,13 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > >          */
> > >         domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > >         for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > > -               dev = per_cpu(cpuidle_devices, cpu);
> > > -               if (dev) {
> > > -                       next_hrtimer = READ_ONCE(dev->next_hrtimer);
> > > -                       if (ktime_before(next_hrtimer, domain_wakeup))
> > > -                               domain_wakeup = next_hrtimer;
> > > +               if (IS_ENABLED(CONFIG_CPU_IDLE)) {
> > > +                       dev = per_cpu(cpuidle_devices, cpu);
> > > +                       if (dev) {
> > > +                               next_hrtimer = READ_ONCE(dev->next_hrtimer);
> > > +                               if (ktime_before(next_hrtimer, domain_wakeup))
> > > +                                       domain_wakeup = next_hrtimer;
> > > +                       }
> >
> > This works as quick fix, but I think there is two possible options
> > that is probably better in long run.
> >
> > 1) Extend the cpuidle interface with a new function:
> >
> > struct cpuidle_device *cpuidle_get_cpu_device(unsigned int cpu)
> >
> > Then when CONFIG_CPU_IDLE is unset, we can just have a stub function
> > returning NULL.
>
> So why exactly cpu_power_down_ok() would be still needed with
> CONFIG_CPU_IDLE unset?
>
> > 2) Have the struct dev_power_governor pm_domain_cpu_gov to be defined
> > (and the corresponding functionality), but only when CONFIG_CPU_IDLE
> > is set and when CONFIG_PM_GENERIC_DOMAINS is set.
>
> So please do that.
>
> Can you please send a replacement patch for the [4/4] in the series
> with this fixed?

Yes, I do that!

Kind regards
Uffe
