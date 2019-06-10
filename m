Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB0C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45F20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9BQ9KsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfFJKWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:22:19 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38034 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388937AbfFJKWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:22:18 -0400
Received: by mail-ua1-f67.google.com with SMTP id j2so2814754uaq.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15Mv27CpOqcY/QGlaDdYOaxwUvkGE7VrIq+6M5Rz0FU=;
        b=s9BQ9KsFHX7r67adKcBwj8x+BIiC1XiicdzH46J+YsO3WPlHQMjCJ/t2E24Bq3kiKD
         +Bg3PsRj14xJfdhcC+LOuy4BR9Xkwfz3SPO2dsCcygvloePKw5wrInVKtfDBKW57eQm9
         4UkH+z4+9Ck49Km3+5u06HRJY5h5q7+K/DOCqolnYmquXsQ7ocAyECXW2l+0L+byHT3j
         PKXJa36XaZ+BpR4tBZNYB2mFSC6H69CAkdArGNOYIrWO7vAgTXCznGvw42YfFzh5cnaz
         gTJTXwymRKiZ9jf6nd1DkSHEdQQwuslE5sDsGDvN8V7pkWRln0K33K9p++EaAFmskLD5
         rXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15Mv27CpOqcY/QGlaDdYOaxwUvkGE7VrIq+6M5Rz0FU=;
        b=J7v9r9lPmZl6xORtZgmEYrC4ZMkLc45gHG7SNwy7D41J3ON/8ul1P+q+1N47+BrBKe
         j2X1oZ7KSJ8QGlU/1/XnAkCtKoYvL0fEuojgXYdHBo7uY3XbIAW16P2hD08Icu8fqMhX
         lqp+MN3HpZmOaye4Wvnz42AmM46rmPTUYACxyDo+kYDPbnvkoy6PR6uBLTKHan0l9n72
         M6p7S1GhMxVLafaii/nYEScOfrlUm3zOYIA+HwBvKIAq2eJabd3UwJRbUbVRtE6fMi43
         aVU4lWWE42L5i3Dw+g60ciW2C9kGloXvtkq26Z6p7uU/gYynvZHsqrZRTz0uwnngCry1
         8g0Q==
X-Gm-Message-State: APjAAAVQV+nuRhZWK2OY5+F/lw5/X/UCpr41gOI11ZjNj6EOia9yT/Mg
        22M4PxB3e8B743oBXSsepxhaENJU248qZTJdD2KGqg==
X-Google-Smtp-Source: APXvYqzsDubn8C/uZ4YbyQpXtJ3AHSgnXkBYLL2nEvxRnxsGCAl3OTHTeHkcpSedWHXhXx7UFiOxD441yVY/xNRMflE=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr8218485uad.15.1560162137549;
 Mon, 10 Jun 2019 03:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-10-ulf.hansson@linaro.org>
 <20190607152751.GH15577@e107155-lin>
In-Reply-To: <20190607152751.GH15577@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jun 2019 12:21:41 +0200
Message-ID: <CAPDyKFq3FFZEAEKrPfvBPUpAGKaTo05zS0-5sfgBjGFhRZ0b=w@mail.gmail.com>
Subject: Re: [PATCH 09/18] drivers: firmware: psci: Add support for PM domains
 using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 17:27, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:51PM +0200, Ulf Hansson wrote:
> > When the hierarchical CPU topology layout is used in DT, we need to setup
> > the corresponding PM domain data structures, as to allow a CPU and a group
> > of CPUs to be power managed accordingly. Let's enable this by deploying
> > support through the genpd interface.
> >
> > Additionally, when the OS initiated mode is supported by the PSCI FW, let's
> > also parse the domain idle states DT bindings as to make genpd responsible
> > for the state selection, when the states are compatible with
> > "domain-idle-state". Otherwise, when only Platform Coordinated mode is
> > supported, we rely solely on the state selection to be managed through the
> > regular cpuidle framework.
> >
> > If the initialization of the PM domain data structures succeeds and the OS
> > initiated mode is supported, we try to switch to it. In case it fails,
> > let's fall back into a degraded mode, rather than bailing out and returning
> > an error code.
> >
> > Due to that the OS initiated mode may become enabled, we need to adjust to
> > maintain backwards compatibility for a kernel started through a kexec call.
> > Do this by explicitly switch to Platform Coordinated mode during boot.
> >
> > Finally, the actual initialization of the PM domain data structures, is
> > done via calling the new shared function, psci_dt_init_pm_domains().
> > However, this is implemented by subsequent changes.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes:
> >       - Simplify code setting domain_state at power off.
> >       - Use the genpd ->free_state() callback to manage freeing of states.
> >       - Fixup a bogus while loop.
> >
> > ---
> >  drivers/firmware/psci/Makefile         |   2 +-
> >  drivers/firmware/psci/psci.c           |   7 +-
> >  drivers/firmware/psci/psci.h           |   5 +
> >  drivers/firmware/psci/psci_pm_domain.c | 268 +++++++++++++++++++++++++
> >  4 files changed, 280 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/firmware/psci/psci_pm_domain.c
> >
> > diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> > index 1956b882470f..ff300f1fec86 100644
> > --- a/drivers/firmware/psci/Makefile
> > +++ b/drivers/firmware/psci/Makefile
> > @@ -1,4 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> > -obj-$(CONFIG_ARM_PSCI_FW)    += psci.o
> > +obj-$(CONFIG_ARM_PSCI_FW)    += psci.o psci_pm_domain.o
> >  obj-$(CONFIG_ARM_PSCI_CHECKER)       += psci_checker.o
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 0e91d864e346..bfef300b7ebe 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -721,9 +721,14 @@ static int __init psci_1_0_init(struct device_node *np)
> >       if (err)
> >               return err;
> >
> > -     if (psci_has_osi_support())
> > +     if (psci_has_osi_support()) {
> >               pr_info("OSI mode supported.\n");
> >
> > +             /* Make sure we default to PC mode. */
> > +             invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> > +                            PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
> > +     }
> > +
>
> This can go on it's own, any issues with that ?

Sure, I can move that out to a separate patch.

>
> >       return 0;
> >  }
> >
> > diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> > index f2277c3ad405..00d2e3dcef49 100644
> > --- a/drivers/firmware/psci/psci.h
> > +++ b/drivers/firmware/psci/psci.h
> > @@ -11,6 +11,11 @@ bool psci_has_osi_support(void);
> >  #ifdef CONFIG_CPU_IDLE
> >  void psci_set_domain_state(u32 state);
> >  int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> > +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> > +int psci_dt_init_pm_domains(struct device_node *np);
> > +#else
> > +static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> > +#endif
> >  #endif
> >
> >  #endif /* __PSCI_H */
> > diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> > new file mode 100644
> > index 000000000000..3c6ca846caf4
> > --- /dev/null
> > +++ b/drivers/firmware/psci/psci_pm_domain.c
> > @@ -0,0 +1,268 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PM domains for CPUs via genpd - managed by PSCI.
> > + *
> > + * Copyright (C) 2019 Linaro Ltd.
> > + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > + *
> > + */
> > +
> > +#define pr_fmt(fmt) "psci: " fmt
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +
> > +#include "psci.h"
> > +
> > +#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_PM_GENERIC_DOMAINS_OF)
> > +
> > +struct psci_pd_provider {
> > +     struct list_head link;
> > +     struct device_node *node;
> > +};
> > +
> > +static LIST_HEAD(psci_pd_providers);
> > +static bool osi_mode_enabled;
> > +
> > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +
> > +     /* If we have failed to enable OSI mode, then abort power off. */
> > +     if (psci_has_osi_support() && !osi_mode_enabled)
> > +             return -EBUSY;
> > +
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     /* When OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     psci_set_domain_state(*pd_state);
> > +
> > +     return 0;
> > +}
> > +
> > +static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> > +                             int state_count)
> > +{
> > +     int i, ret;
> > +     u32 psci_state, *psci_state_buf;
> > +
> > +     for (i = 0; i < state_count; i++) {
> > +             ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
> > +                                     &psci_state);
> > +             if (ret)
> > +                     goto free_state;
> > +
> > +             psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> > +             if (!psci_state_buf) {
> > +                     ret = -ENOMEM;
> > +                     goto free_state;
> > +             }
> > +             *psci_state_buf = psci_state;
> > +             states[i].data = psci_state_buf;
> > +     }
> > +
> > +     return 0;
> > +
> > +free_state:
> > +     i--;
> > +     for (; i >= 0; i--)
> > +             kfree(states[i].data);
> > +     return ret;
> > +}
> > +
> > +static int psci_pd_parse_states(struct device_node *np,
> > +                     struct genpd_power_state **states, int *state_count)
> > +{
> > +     int ret;
> > +
> > +     /* Parse the domain idle states. */
> > +     ret = of_genpd_parse_idle_states(np, states, state_count);
> > +     if (ret)
> > +             return ret;
> > +
>
>
> Lots of things here in this file are not psci specific. They can be
> moved as generic CPU PM domain support.

What exactly do you mean by CPU PM domain support?

The current split is based upon how the generic PM domain (genpd)
supports CPU devices (see GENPD_FLAG_CPU_DOMAIN), which is already
available.

I agree that finding the right balance between what can be made
generic and driver specific is not always obvious. Often it's better
to start with having more things in the driver code, then move things
into a common framework, later on, when that turns out to make sense.

>
> > +     /* Fill out the PSCI specifics for each found state. */
> > +     ret = psci_pd_parse_state_nodes(*states, *state_count);
> > +     if (ret)
> > +             kfree(*states);
> > +
>
> Things like above are PSCI.
>
> I am trying to see if we can do something to achieve partitions like we
> have today: psci.c just has PSCI specific stuff and dt_idle_states.c
> deals with generic idle stuff.

I am open to any suggestions. Although, I am not sure I understand
your comment and nor the reason to why you want me to change.

So, what is the problem with having the code that you refer to, inside
drivers/firmware/psci/psci_pm_domain.c? Can't we just start with that
and see how it plays?

Kind regards
Uffe
