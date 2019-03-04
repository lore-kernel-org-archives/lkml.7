Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E43EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E03520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NR3BgZJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCDKOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:14:55 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45736 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:14:55 -0500
Received: by mail-vk1-f195.google.com with SMTP id v187so997425vkf.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jcb3LghxA86J6H5hrrzLqeilT2B5EPT3y0nFjKRg8w=;
        b=NR3BgZJ7OnvqCsGrq4yDWYZ7I2074XR5d89ZXr21Ab4n1Dx6LFEBsG89Kvu1EhYOIe
         yh7cnvoHbzpcIVmXmS88ZPX1GZq0Q/QN10V2/aUrmBIqB1K1SnG79mpEnxU5O3UpxLLT
         TxVbitURBPgyyewN5AdCtizan5wkSfO0iK2Bl7GUwug8oIN2zS+NEkigZB9z69tLEuoL
         dKcah+u6ASbAiEFl3LuzsnYM7gRnB4pzb8LbsANVaV/zVr6pgTLHUzEtUjtVorbIW85g
         JYulH6MNz45nN/KFaN+drXPrlv8WlXVyLY15InQVmKij4QUpLRlGajdXGJtessSZVzdg
         55tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jcb3LghxA86J6H5hrrzLqeilT2B5EPT3y0nFjKRg8w=;
        b=Y9+Fg9ngw22jWrTKt04IbzoLBx24+WCWx07J4Qh5HIbHgePhmgSRBXl+2/+V81l7Q/
         FLVmVHVvWyDJ1zBBIebqoXeEAYRIsjST7AeUCukz/r21E5dGVqrkLpWIDGCulPK3tBBL
         EHgayr8JI0/y94V4IrX72UuCKY/o/2IpoupsKRat7mG5RwXeiunwE5cPbZcV04W6Yc3t
         SxHX3EM5HLjXgAR9yMBTGjBRstGD+ZDg/yeKuysDxVWZ7kSpk9E3cUYt/7yKlcD1LSAs
         i9bNYtCCYgHlEGYz+4tSkqgWGKB7rVOh0txsqzbc3fisO3uPYfQgxHiHR+tt4kIbLR6B
         bUjQ==
X-Gm-Message-State: APjAAAWkVbki9IErtkJe3iKEYEAy9w1DWm7iZEC21dDYL6McCVuQQwiV
        dRD6YzR7GZrlK1PukZxjGtKSGynQ5KA2Jr/omtbbLw==
X-Google-Smtp-Source: APXvYqxppkh7TkLRZjvGeU4agL5mIb4VsJzysF07bePBlsZVUhc6Xqi+Xlr2KTWEqyTGuPqDkJE98l/TS6t0ChZOdg4=
X-Received: by 2002:a1f:1408:: with SMTP id 8mr9041770vku.36.1551694493916;
 Mon, 04 Mar 2019 02:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com>
In-Reply-To: <20190301172810.GR15517@lakrids.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Mar 2019 11:14:18 +0100
Message-ID: <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 at 18:28, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Feb 28, 2019 at 02:59:17PM +0100, Ulf Hansson wrote:
> > Instead of iterating through all the state nodes in DT, to find out how
> > many states that needs to be allocated, let's use the number already known
> > by the cpuidle driver. In this way we can drop the iteration altogether.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index d50b46a0528f..cbfc936d251c 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> >                       struct device_node *cpu_node, int cpu)
> >  {
> > -     int i, ret = 0, count = 0;
> > +     int i, ret = 0, num_state_nodes = drv->state_count - 1;
> >       u32 *psci_states;
> >       struct device_node *state_node;
> >
> > -     /* Count idle states */
> > -     while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> > -                                           count))) {
> > -             count++;
> > -             of_node_put(state_node);
> > -     }
> > -
>
> To be honest, I'd rather not tighten the coupling with the cpuidle
> driver here. For example, I'm not that happy with the PSCI backend
> having to know the driver has a specific WFI state.

If you ask me, the coupling is already there, only that it's hidden by
taking assumptions about the WFI state in the code.

However, I certainly agree with you, that this isn't very nice.

>
> IIUC we could get rid of the explicit counting with something like:
>
>         count = of_parse_phandle_with_args(cpu_node, "cpu-idle-states", NULL);
>
> ... but I'm not sure that the overall change is a simplification.

In my opinion, no it doesn't.

To me, it seems a kind of silly (and in-efficient) to do an OF parsing
that has already been done and given the information we need.

>
> Does this change make it easier to plumb in something in future?

Yes, I need this for additional changes on top.

Note that, patch4 also provides the opportunity to do a similar
cleanup of the initialization code in drivers/soc/qcom/spm.c. I
haven't made that part of this series though.

I guess in the end, we need to accept that part of the psci driver is
really a cpuidle driver. Trying to keep them entirely separate,
doesn't come without complexity/churns.

While working on psci changes in the recent series I have posted, I
was even considering adding a completely new cpuidle driver for psci
(in drivers/cpuidle/*) and instead define a number of psci interface
functions, which that driver could call. That would probably be a
better split, but requires quite some changes.

So, what do you want me to do with this?

>
> Thanks,
> Mark.

Thanks a lot for reviewing!

Kind regards
Uffe

>
> > -     if (!count)
> > -             return -ENODEV;
> > -
> > -     psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> > +     psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> > +                     GFP_KERNEL);
> >       if (!psci_states)
> >               return -ENOMEM;
> >
> > -     for (i = 0; i < count; i++) {
> > +     for (i = 0; i < num_state_nodes; i++) {
> >               state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> > +             if (!state_node)
> > +                     break;
> > +
> >               ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
> >               of_node_put(state_node);
> >
> > @@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> >               pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
> >       }
> >
> > +     if (i != num_state_nodes) {
> > +             ret = -ENODEV;
> > +             goto free_mem;
> > +     }
> > +
> >       /* Idle states parsed correctly, initialize per-cpu pointer */
> >       per_cpu(psci_power_state, cpu) = psci_states;
> >       return 0;
> > --
> > 2.17.1
> >
