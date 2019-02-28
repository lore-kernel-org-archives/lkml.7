Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA92C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB22D20675
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWi3is83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfB1W1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:27:19 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43554 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfB1W1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:27:18 -0500
Received: by mail-vk1-f196.google.com with SMTP id e131so5152818vkf.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSdy0dD/okpWB6MwCrRF1+d+PMUuX1LvB7Qun4Hn7IA=;
        b=aWi3is83eHbl6Sar+TDaKiE7QA5M/HWwQ/M39hKu/AGIGqUJ/akXmYIoHI2y7LmS2G
         SqamlCU3qkQ3bPibzB+4agXBPtDmUvcygV/cA5jocokxIHPRc/VsX03if6GPmcPdRoR5
         abhFjQL3qcI2PDUrKl1+OuZU9SoLAYrTGAoeu8Aq3TQsxAh6ijR8Sfl40N6uk6FlNibG
         PBFl36xhPK2R31N9biOvfEBCP984l5egdtT18BRiqqa8bK3YEQucHP9Rek9wktXdPk0I
         0jhaQkxuMYdE+5k9lg+8alpgpGRSki3AgJ+gxmx69tj9pCARpeGx/KYCk6bHuVeyzE1c
         WFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSdy0dD/okpWB6MwCrRF1+d+PMUuX1LvB7Qun4Hn7IA=;
        b=By7wqpPlEZHisHQIImV4hXD/wmhk0ZUKTkFzDNa7VO15569HfZew70zAKdvFlBG4B6
         gPiJVPvutuk6rkca/86F6EE3KxgOEO3AG4q6cQvb2FX+EOx2yvNXKJKMcXuwDXllaryY
         MLp26h0+HETZYuQ3s6/JJVZiZRP08XjFwkZGHAKNB41KlqsaZzO4CE4gVxyrKAvooFg8
         ROvd9roRZfMiuBFD2bAePxUPwbH8eAt/da3Jz4LXDowYvDmf6B1OfCqIhbLVNkv7H6yr
         gSp0cVdcVuvxs/Ygnm9tixrpcww1ECaCdqIXl/3bt9xToewlBf7Otrf3UHa+v0586Q8y
         L3xA==
X-Gm-Message-State: APjAAAXWjNx/oMZKJtwj5xju79R1hSKTUOq2RPWFclP2Q+112L70kWAg
        Se21Jp00rnWXqgJo/WQo7fWCad0cj+v+rN/KaBJkSg==
X-Google-Smtp-Source: APXvYqyC+ntOaxO2dFmLRrb+9A1f7N/xQKajL9jHj2L+QV1E+NktqBefV13nH4rGr+S1NjUxSqPsUeyEqLtT2WxuWsg=
X-Received: by 2002:a1f:1408:: with SMTP id 8mr1067715vku.36.1551392837563;
 Thu, 28 Feb 2019 14:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
In-Reply-To: <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Feb 2019 23:26:41 +0100
Message-ID: <CAPDyKFrdwkERTGOkfjCZv-cb0sTvDqtNWY6kKyaeWLHSumRp1A@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, 28 Feb 2019 at 16:40, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/02/2019 14:59, Ulf Hansson wrote:
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
>
> why -1 ?

Because of the WFI state. The cpuidle-arm driver always carries this
state at index 0, which also is never used in
psci_cpu_suspend_enter(), where the similar is taken into account.

It's a bit of magic, so perhaps someone should post a patch that
documents this a bit better in the code, wherever it makes sense.

>
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
> >

Again, thanks a lot for reviewing!

Kind regards
Uffe
