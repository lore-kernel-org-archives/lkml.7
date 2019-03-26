Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76A82075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaJl87bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZLaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:30:30 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41703 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCZLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:30:30 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so7378725vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhUEgjNRNgTc30sxj0UUXn4H7N0bkT21t+Udf71BA04=;
        b=AaJl87bMvta5uABhGN6Un/EJU/GM+ATpLcVkmuSPTnS/8nXXX6wrFEl77GD1aXI4qG
         N/ZWmHikT7WZ3zZaYzz8B01f8Ro+maK4ZdVdcqiK4v+dxdIMiRa1aXUv6/redzk3Z8z2
         qGzS9jDAfCq13z164+zsaMRMHEDZ2PZ3Kx4OPJQSRK0TSbWN+nysFTg218RZvfaRWST8
         7OK7qybQHNdrxWXLsg+oP9aIteaLcx+aZmqFffACv7yQA7t1V1nyqrESu9wt6iqAFHb4
         enCqS1WoaL220pcDsHmkG47EWbVV0z3eVDu9hO/RU+JqKGEIuu0M2tZCeA0r+LgZgmZK
         ztqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhUEgjNRNgTc30sxj0UUXn4H7N0bkT21t+Udf71BA04=;
        b=H37aR5eMHIfSu/JDrQskQVbZsqFvyMBK06Be6n0iB/d3LoWbWWTza/5RFu3J2OUMLW
         BLnyXJ2ys8T5C6LGRpyNjwN0xL7JvHx6/1tz5YWGmn+pWCbuN0MQDzvxByfmX+6v3Mch
         +edd017DVqhss0cDokZLuc9xOsWg9lblFLnpkp1sQiZS05O5zN/JAb3afKwp7lFno2RP
         D0eJU8e2wluAthNuQP6nU1YCCSLueXLH3EgFcMXth0sv4AX0ZUDr0ggSds95q2Ck8uLe
         47/XfoTIzPsHJDlwrpQLUkHthaZ/ee+mcPa6kmSF9BFXiUZtMx1FKABGJC+nCK3zQ8WA
         cW+Q==
X-Gm-Message-State: APjAAAXmbFiRFQDfdHepp1sUfOwaAE3ANaDL0WcHQbhzQIFTv4ZH4KUU
        yJL8lz07ddl9NWVhECjSabn+b1D7biPnMeymMsDn0Q==
X-Google-Smtp-Source: APXvYqwwDYUHIA9yNpb8J5UoF6dHpB1rEn3Q5o8GTEVqL+HFoLizxVH/6Mvi76JCz5GgPiWpLpTvQfJBG379++DFK/k=
X-Received: by 2002:a67:ec03:: with SMTP id d3mr10878596vso.165.1553599829328;
 Tue, 26 Mar 2019 04:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-4-ulf.hansson@linaro.org> <2942111.nn8VVVUCAL@aspire.rjw.lan>
 <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com> <CAJZ5v0gHpX0=Urwj5z+FS=PKibM1VO0B5ZEQvwnvqXbUV_=fpg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHpX0=Urwj5z+FS=PKibM1VO0B5ZEQvwnvqXbUV_=fpg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Mar 2019 12:29:52 +0100
Message-ID: <CAPDyKFrWF8x=G2Zz9z8nGNp0mmcnRUhKof=giOmcQbJ4BkLjsw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 at 11:36, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Mar 25, 2019 at 3:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 25 Mar 2019 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Wednesday, February 27, 2019 8:58:35 PM CET Ulf Hansson wrote:
> > > > To be able to predict the sleep duration for a CPU that is entering idle,
> > > > knowing when the next timer/tick is going to expire, is extremely useful.
> > > > Both the teo and the menu cpuidle governors already makes use of this
> > > > information, while selecting an idle state.
> > > >
>
> [cut]
>
> > >
> > > > +
> > > >       if (cpuidle_state_is_coupled(drv, index))
> > > >               return cpuidle_enter_state_coupled(dev, drv, index);
> > > >       return cpuidle_enter_state(dev, drv, index);
> > >
> > > Also I would clear next_hrtimer here to avoid dragging stale values
> > > around.
> >
> > Right, I can do that.
> >
> > However, at least in my case it would be an unnecessary update of the
> > variable, as I am never in a path where the value can be "stale".
>
> It easily can AFAICS.  After all, cpu_power_down_ok() need not run on
> the same CPU that is setting next_hrtimer here.

That's correct.

>
> > Even if one theoretically could use a stale value, it's seems likely to not
> > be an issue, don't you think?
>
> That would be because of the locking in the ->enter() callback I
> suppose?  But is it actually universally guaranteed that setting
> next_hrtimer will never be reordered with acquiring the lock?

In the PSCI case and for those CPUs that shares the same genpd
governor (even hierarchically), then yes.

Unfortunate, I haven't been able to explore this in that great detail
for other legacy ARM32 platforms, so maybe it's just better to play
safe, as you suggest and avoid a stale value.

>
> Also, there is some overhead to be avoided if cpu_power_down_ok()
> checked the next_hrtimer of the other CPUs against 0 explicitly, isn't
> it?

In regards to overhead and when using genpd for CPUs, there are a
couple of things I have in mind that we could try to improve. Yes,
checking for next_hrtimer against 0 could be one thing to consider.

Kind regards
Uffe
