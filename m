Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542912084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPybfnOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfCYOYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:24:05 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34387 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfCYOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:24:04 -0400
Received: by mail-vk1-f193.google.com with SMTP id k64so1985461vke.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=18Uy2+5EeK7lK1NTsT1PhmlbcUQuf+mmQID+bLSg5mI=;
        b=NPybfnOjuYYvfG5P4rUPY46w6oJ+pu+1nvaFz3rSOexY5JI6jJwcZSiKwzUzZrsRsY
         mDrICkRcbzGwX0ct8NIYXBV7T+Bo79nVVBxs9FqkNnFVQpw5Cyuba/vuSA7L7nDuZbX+
         Kc+cdGd8TZqVGpdAKVd5sXnWLHZQKoXU6WlR5ZCOM1zLrhaiqCpWq8FZxW1QfNqBZqGg
         gKpSVQqB31F/6nMY3yE8PpU2hRpDQcyYHYrX3CRasyrWnQjVNGseKCG17YqaZ762RKSt
         44HsJWWbUK4Nxkhxo1NeDjSWziS5Mk7W6RV+zcH2PiYbhuGQGy130/18ZvicwrSkLWgj
         oPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=18Uy2+5EeK7lK1NTsT1PhmlbcUQuf+mmQID+bLSg5mI=;
        b=DEIvhHWrcko0qAB95nEP1zWjmr2mdNQtkEu62LSgNjdMQgsXFjAZRzPl22up3pCK+e
         EM9dVynx5hskWCFuMLOklQqXcleg+NkMWxR4jvv7UeMJD2zbAdAlXAKb1tQdp9QUByfY
         xpj6NFhv9K8HDlNewAn+6P8MMPPYchOx2It45ChbpG2/fvTUrkDWU+kCnd8xJ5As6kOO
         ftAJzCS/MUjkjtmVzXYiY/DeQFeLFkVNQh6jLJw7GZD79SLu2z+w4nfppzPLXU369Lr2
         l8XXifEIOYSnLqN7KzeulKFuSWe4ia11m382wjN7fp1Y03bdFrMfzpg3RBNh+zsYS3Bz
         WrsQ==
X-Gm-Message-State: APjAAAUKuMaGHV14XPvDNbAtDfs+Lbl6f36NRJ6QE60BRA6zDMP6jt+h
        D6lVTnC3cAONs269wS5TlPXELFhU8xGnDNZ9NrVmSA==
X-Google-Smtp-Source: APXvYqyK5Sj8t0/bmtqkpbdMu8pleiBUSOsqzKm1/sXL0Xmus+qPMB2fDPyYUiHVAUaC20uNARhr/OqBhC599wkycao=
X-Received: by 2002:a1f:3458:: with SMTP id b85mr3910490vka.4.1553523843044;
 Mon, 25 Mar 2019 07:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-4-ulf.hansson@linaro.org> <2942111.nn8VVVUCAL@aspire.rjw.lan>
In-Reply-To: <2942111.nn8VVVUCAL@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 15:23:27 +0100
Message-ID: <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
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

On Mon, 25 Mar 2019 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, February 27, 2019 8:58:35 PM CET Ulf Hansson wrote:
> > To be able to predict the sleep duration for a CPU that is entering idle,
> > knowing when the next timer/tick is going to expire, is extremely useful.
> > Both the teo and the menu cpuidle governors already makes use of this
> > information, while selecting an idle state.
> >
> > Moving forward, the similar prediction needs to be done, but for a group of
> > idle CPUs rather than for a single idle CPU. Following changes implements a
> > new genpd governor, which needs this.
> >
> > Support this, by sharing a new function called
> > tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
> > tick, whatever that expires first.
> >
> > Additionally, when cpuidle is about to invoke the ->enter() callback, then
> > call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
> > struct cpuidle_device, as to make it available outside cpuidle.
> >
> > Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
> > governor's ->select() callback has already made a decision whether to stop
> > the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
> > the next timer expiration, whatever origin.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v12:
> >       - New patch.
> >
> > ---
> >  drivers/cpuidle/cpuidle.c |  8 ++++++++
> >  include/linux/cpuidle.h   |  1 +
> >  include/linux/tick.h      |  7 ++++++-
> >  kernel/time/tick-sched.c  | 12 ++++++++++++
> >  4 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index 7f108309e871..255365b1a6ab 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -328,6 +328,14 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >  int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >                 int index)
> >  {
> > +     /*
> > +      * Store the next hrtimer, which becomes either next tick or the next
> > +      * timer event, whatever expires first. Additionally, to make this data
> > +      * useful for consumers outside cpuidle, we rely on that the governor's
> > +      * ->select() callback have decided, whether to stop the tick or not.
> > +      */
> > +     dev->next_hrtimer = tick_nohz_get_next_hrtimer();
>
> I would use WRITE_ONCE() to set next_hrtimer here and READ_ONCE() for
> reading that value in the next patch, as a matter of annotation if
> nothing else.

Okay!

>
> > +
> >       if (cpuidle_state_is_coupled(drv, index))
> >               return cpuidle_enter_state_coupled(dev, drv, index);
> >       return cpuidle_enter_state(dev, drv, index);
>
> Also I would clear next_hrtimer here to avoid dragging stale values
> around.

Right, I can do that.

However, at least in my case it would be an unnecessary update of the
variable, as I am never in a path where the value can be "stale". Even
if one theoretically could use a stale value, it's seems likely to not
be an issue, don't you think? Anyway, if I don't hear from you, I do
the change as you suggested.

>
> Apart from this the series LGTM.

Great, thanks. I re-spin a new version.

Kind regards
Uffe
