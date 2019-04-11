Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0344DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84F206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554993429;
	bh=1spjjDcBl1JC16VRaYTDE2FIeeAf/24aAaZMAmiQ2o8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rfe7+mEJjOD5VShsv0GSRY2dXiPv+NpnLx7sTBAhUeQb4aUyg6gfT2lFYGjiAZ4l4
	 CVUYA8rvcfQ8aQ4OwUlmUKkVYEsTX07reF/dQmW41bZ2EN4osrs9aqHkS0DzpHLCSE
	 S5CX7U1Ccv3xEPx96SPZtUvXEFz9NFOMeQucoMZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDKOhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:37:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41318 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:37:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so5076655oie.8;
        Thu, 11 Apr 2019 07:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RyWv2IjOnY8E9BKLZZdDtAURwJ7VKa07TEzKkexER8=;
        b=BDaz2BNN6gQvQfbIxuNgz2TVRTPYttKYDxzBMmKIoYadNqCeexqT9wQ5or7vO7tqk1
         wskYFd50AwyQYGQUZ5WZpl4NF7/hDi6r+o3y+MqyXYDskP+NuuoQaswLMnKF8SqvJHN3
         t6ukhNJNmpnndeRUx5u32zU7PREJejqwwy9GEgeZdTK3ATViohGO1WHbwaogZoV28HGy
         Ebpo5oo3jBPEm0zJZLMkM8ki3HJcfszJwYXpvYBK1C0HkxK0y+EDdsoUTEE3vb6EHZvc
         /rheWdBt2Sh4IEO981BwdREf/koKkYZ+gqhlzCJc0iuNIN9FPoH0p+nJQRrfKS+VRVVL
         sBkg==
X-Gm-Message-State: APjAAAVkoDKMAzaFfivpvuiocYn7ry8twvNIeI/3Hlg9Y43ZeiLYF0wS
        OmW39pZQ8jilDXrSac+K6N2DEwcq0VW4H+N6alA=
X-Google-Smtp-Source: APXvYqzCia9V5+Ea/bhezV3FwajsZ/pZzBNGUJBdfLik+r2X/RLooLz256LMn4wmtt+A6JLg+yZRORvEAxDTQdaFeTw=
X-Received: by 2002:aca:4c08:: with SMTP id z8mr342143oia.30.1554993427319;
 Thu, 11 Apr 2019 07:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190411124739.5542-1-cai@lca.pw> <CAPDyKFqmP3pORhufTsCg1nuqSPGz8hEQNTpZgr24fFqk13hM3w@mail.gmail.com>
In-Reply-To: <CAPDyKFqmP3pORhufTsCg1nuqSPGz8hEQNTpZgr24fFqk13hM3w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Apr 2019 16:36:56 +0200
Message-ID: <CAJZ5v0hWL1dGPZX0aotcJ7cT_LdHvreZvx-fR7B_9Y=mqxSyzw@mail.gmail.com>
Subject: Re: [PATCH -next] power/domain_governor: fix a compilation error
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, Apr 11, 2019 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 11 Apr 2019 at 14:48, Qian Cai <cai@lca.pw> wrote:
> >
> > The commit 50899f7d5078 ("PM / Domains: Add genpd governor for CPUs")
> > introduced a compilation error on arm64 with CONFIG_CPU_IDLE=n because
> > cpuidle_devices is undefined there.
> >
> > drivers/base/power/domain_governor.o: In function `cpu_power_down_ok':
> > drivers/base/power/domain_governor.c:263: undefined reference to
> > 'cpuidle_devices' ld: drivers/base/power/domain_governor.o: relocation
> > R_AARCH64_ADR_PREL_PG_HI21 against symbol 'cpuidle_devices' which may
> > bind externally can not be used when making a shared object; recompile
> > with -fPIC
> > drivers/base/power/domain_governor.c:263:(.text+0x638): dangerous
> > relocation: unsupported relocation
> > drivers/base/power/domain_governor.c:263: undefined reference to
> > 'cpuidle_devices'
> > make: *** [Makefile:1047: vmlinux] Error 1
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
>
> Qian, thanks for you patch!
>
> > ---
> >  drivers/base/power/domain_governor.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> > index 39c8a699cb53..252d88fcf760 100644
> > --- a/drivers/base/power/domain_governor.c
> > +++ b/drivers/base/power/domain_governor.c
> > @@ -270,11 +270,13 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> >          */
> >         domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> >         for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > -               dev = per_cpu(cpuidle_devices, cpu);
> > -               if (dev) {
> > -                       next_hrtimer = READ_ONCE(dev->next_hrtimer);
> > -                       if (ktime_before(next_hrtimer, domain_wakeup))
> > -                               domain_wakeup = next_hrtimer;
> > +               if (IS_ENABLED(CONFIG_CPU_IDLE)) {
> > +                       dev = per_cpu(cpuidle_devices, cpu);
> > +                       if (dev) {
> > +                               next_hrtimer = READ_ONCE(dev->next_hrtimer);
> > +                               if (ktime_before(next_hrtimer, domain_wakeup))
> > +                                       domain_wakeup = next_hrtimer;
> > +                       }
>
> This works as quick fix, but I think there is two possible options
> that is probably better in long run.
>
> 1) Extend the cpuidle interface with a new function:
>
> struct cpuidle_device *cpuidle_get_cpu_device(unsigned int cpu)
>
> Then when CONFIG_CPU_IDLE is unset, we can just have a stub function
> returning NULL.

So why exactly cpu_power_down_ok() would be still needed with
CONFIG_CPU_IDLE unset?

> 2) Have the struct dev_power_governor pm_domain_cpu_gov to be defined
> (and the corresponding functionality), but only when CONFIG_CPU_IDLE
> is set and when CONFIG_PM_GENERIC_DOMAINS is set.

So please do that.

Can you please send a replacement patch for the [4/4] in the series
with this fixed?
