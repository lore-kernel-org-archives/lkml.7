Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA4AC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA542084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556188357;
	bh=ikNdpMJYg29HonRPDwbbNZqSQGpOz28XgRvY4DOUgIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZjHsWcsoEoJy/4uBQ3wTRadsUI9Vbj5OXYZCzvlosbUH3q0ASBYtyItdAZeDUYKzf
	 gSBd7pEi2ANr5Lqw4HJjL9lxMRtRi62ifrV+2q+pyzAKUyaYUijV0wTQrP+1/XWO0w
	 U0UvHMIzqnbRz2b9WiViFuYP0NByu7dr8Ufomsn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfDYKcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:32:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40534 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfDYKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:32:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so18937467otp.7;
        Thu, 25 Apr 2019 03:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbTspqmMHl6lzjfEGJMBs25JPgJC8+QH26Jub2MLcuA=;
        b=J38U4GMsj4+7ghcExtIftFztX8fa+0OXkL6+0Q7TI8qtOvBI8HXYWkaFnqrIpE0F9w
         Y/AJaCcV3AOZdX40d6nN+WajBqum1lnbQO6AkyUu6oCo8/E9sBl4n3e5qD25qazHefiD
         kazgdm/KwV16tm5AzemHTRqBusl/T9K/kwVZ7iV8Uqz1iTaK40t8SYp0Q/WWS84vCm1O
         IhPlZxMOmV4JqtMw6ffvDXiWC9wZNX1nN82aaQtxeAeGhilFpX0sNZadCRuPrEQKEioj
         bRpDO7MQyg9T4f0LBCeCkatb8PtLIHAjJ+L8KusCafxSDv5g928Kxy+wmyzytRnYg0hk
         Fu1w==
X-Gm-Message-State: APjAAAWq1caJIDCg7Td/HRxBb3cDI5B1eqlH0BXx73d+RztX6tT0MPBT
        S0Un6A74bs2LD4e4997A5iXWoR8MKP92tK9dNzH7nw==
X-Google-Smtp-Source: APXvYqz65yVA0+fR3WR/Mam5YBG86jsLjcQX7fsqonTQle8rgCvclLHD/zRTjk7zZMU3EBJiW/TQf+qsskV73yHZy+8=
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr23202213otr.65.1556188354951;
 Thu, 25 Apr 2019 03:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
 <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
 <CAJZ5v0jTRF1wvcYTxfSd59ByhnzXdLL8CVg1qnUfQhAj1L1qLA@mail.gmail.com> <CAPDyKFq3QTjX5m9HoNYFTd-e-p_BXsqPH8s+P_yQ5YEJvHBoag@mail.gmail.com>
In-Reply-To: <CAPDyKFq3QTjX5m9HoNYFTd-e-p_BXsqPH8s+P_yQ5YEJvHBoag@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 12:32:24 +0200
Message-ID: <CAJZ5v0iK03ajPVE2LdkJHKBQzeeS+dkkaYfvUuVYAcZKStU-EQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 25 Apr 2019 at 12:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Apr 25, 2019 at 12:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > > > > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > > > > because of the virtual device that genpd allocates in this path.
> > > > >
> > > > > In this series, this limitation is addressed, together with a few other related
> > > > > fixes/cleanups.
> > > > >
> > > > > Ulf Hansson (4):
> > > > >   PM / Domains: Use the base device for
> > > > >     driver_deferred_probe_check_state()
> > > > >   PM / Domains: Drop unused in-parameter to some genpd functions
> > > > >   PM / Domains: Search for the CPU device outside the genpd lock
> > > > >   PM / Domains: Allow to attach a CPU via
> > > > >     genpd_dev_pm_attach_by_id|name()
> > > > >
> > > > >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> > > > >  include/linux/pm_domain.h   |  1 +
> > > > >  2 files changed, 36 insertions(+), 38 deletions(-)
> > > >
> > > > Are there any dependencies between this and the series you've recently posted?
> > >
> > > Yep. I should have stated that, sorry. This should be applied on top.
> >
> > On top of which series?
>
> [PATCH 0/3] PM / Domains: Improve support for multi PM domains
>
> and
>
> [PATCH v13 0/4] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)

OK, thanks!
