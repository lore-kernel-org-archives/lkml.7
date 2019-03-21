Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E7AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C4421874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njlLCWti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfCUJhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:37:04 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36761 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbfCUJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:37:03 -0400
Received: by mail-vs1-f67.google.com with SMTP id n4so3293874vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCxLXvXaY7ulCCXNYwkzauzgMFoKBefBBO+XuvvpP4c=;
        b=njlLCWtiwTIMS31z0kshrH2Odx+Qxo7PmBah8voA9HftZoWqdUgPP9w4NDz5VX6Q+k
         aRxhgnrrwIozpKJyhqDmI6ELrZOSXIkr6AuFhjK5UE0MT64E1z/Zu1pte12ZmitGw7z8
         d+jgugDejYj1ytuBDhJ8567NMVJ0JXn1QWDrZHUWZr2ZnsWoxFEGKPW+ao5+qAnP6m0Q
         uReAX0AfMBYwB5lL02EVQGKjV5RXTfqmzauL6Zm9ap0YWWQ9h9u72mqNCq+YOc2S1iZl
         NYnMSreYv1bgvWuJbouG8BwR083ZBlNbCTxpCHXt7pvDmh+V/Ywr8ac7oZaAi2Kf9Acz
         SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCxLXvXaY7ulCCXNYwkzauzgMFoKBefBBO+XuvvpP4c=;
        b=tel8GQGTc4blsc5utINcHmqk3xHQqStPJ9NM2vNgiVVGEJKFNbMj9tFmA/kI/Kl+UP
         gOXVErV5LevWRMrMG5WyIzZwWxZpDvZPvJr8qJj9lu487FyivQmIv5PBaxYGoXx6VBOU
         E3dLtQqE/pPY7/hM87XguRR0m054BebZaOEDgkgjqUOnvJdJ2Yz72SoU+THkk9Gp3nVe
         jANt8Nqm4pLIoJAKWrqLSFRp2TlTCSqjMkaFmxyY2k3XfNUIy5ED5sJ+3IxKNPUu3vJl
         H97tHyqh+UYkFblWKNeuVDGhSWf9a5oAKcxVfYpTNMhR7YVCQ+e9HQ7Jf5wRUKkEsnXF
         pFjA==
X-Gm-Message-State: APjAAAWJ8CuUuoDIeleS+4l2raIywFdcufhFyN/SjmfCI7UBBY/SGrFe
        MGWlLvAvzg8QAls93AFbWepQ9AygizIm19Rl0VD4zQ==
X-Google-Smtp-Source: APXvYqwLgsF9eekLNguBUMpzqSsu7ibAoBCfnT7t5sEcsYIXR1IGBptplZxDI3sge5U4g1UI9yUv44HKMKz/vmR+xI8=
X-Received: by 2002:a67:e451:: with SMTP id n17mr1319234vsm.35.1553161022447;
 Thu, 21 Mar 2019 02:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-2-ulf.hansson@linaro.org> <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
In-Reply-To: <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 10:36:25 +0100
Message-ID: <CAPDyKFoz8d2DTKTtBPn7+1wf_gGsANwU12++Wkb_KKndqGwWZQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, 21 Mar 2019 at 08:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 27/02/2019 20:58, Ulf Hansson wrote:
> > Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> > backend driver to store per state specific data. To introduce the pointer,
> > we need to change the way genpd deals with freeing of the corresponding
> > allocated data.
> >
> > More precisely, let's clarify the responsibility of whom that shall free
> > the data, by adding a ->free_states() callback to the struct
> > generic_pm_domain. The one allocating the data shall assign the callback,
> > to allow genpd to invoke it from genpd_remove().
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v12:
> >       - None.
> >
> > ---
> >  drivers/base/power/domain.c | 12 ++++++++++--
> >  include/linux/pm_domain.h   |  4 +++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 2c334c01fc43..03885c003c6a 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1685,6 +1685,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> >  }
> >  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
> >
> > +static void genpd_free_default_power_state(struct genpd_power_state *states,
> > +                                        unsigned int state_count)
> > +{
> > +     kfree(states);
> > +}
> > +
> >  static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >  {
> >       struct genpd_power_state *state;
> > @@ -1695,7 +1701,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >
> >       genpd->states = state;
> >       genpd->state_count = 1;
> > -     genpd->free = state;
> > +     genpd->free_states = genpd_free_default_power_state;
> >
> >       return 0;
> >  }
> > @@ -1811,7 +1817,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >       list_del(&genpd->gpd_list_node);
> >       genpd_unlock(genpd);
> >       cancel_work_sync(&genpd->power_off_work);
> > -     kfree(genpd->free);
> > +     if (genpd->free_states)
>
> Is this test necessary as the free_states function is initialized with
> the genpd_set_default_power_state() in any case?

That's the case when the genpd provider did not allocate states, so
then we know genpd deals with this properly for us.

In the other case, when genpd provider has allocates states, then we
need to check that the provider has assigned the ->free_states()
callback before we invokes it, as there is no guarantees that it had.

I was initially tempted to do this check already at pm_genpd_init(),
as it would allow us to check for the error condition and return an
error code if it's not been assigned. However, that requires me to
change all providers that currently "allocates" their states, so that
isn't really a smooth way forward. Perhaps, we should simply print a
message to the log about this condition in pm_genpd_init(), as to
start with!? I can add a patch on top doing that.

>
> > +             genpd->free_states(genpd->states, genpd->state_count);
> > +
> >       pr_debug("%s: removed %s\n", __func__, genpd->name);
> >

[...]

Kind regards
Uffe
