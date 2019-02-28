Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6724C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99202085A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn5+DrI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfB1WNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:13:46 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36876 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfB1WNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:13:46 -0500
Received: by mail-ua1-f68.google.com with SMTP id v26so20559807uap.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRhswVLUmWEZ8ZYnthCAU41Qq83maWxBpoDRzhyn2LA=;
        b=fn5+DrI62stv+zYS7HsttmqZlNJk2+i6nsNhG3rUX0LgO2xc63O5p5hXHbQdjCvCb7
         fr161YWe22SyU0xKwTac7xWSAyGGF/5Hc1Oub+71z9C1bVFCdS66qkvKGlpspDtg4T/Y
         Dcgx2Ps46ESM80K4k2aAPZADl1Hor7m6vhgwOqXwThebrBUVeHnoEZNzdvy5JuwiYsIc
         cfsomvscosW1XM3DCtjTCfvz9OQvrlrjxguGvoIYkT0y/bqTDgn8AChxUP6gkMvNVo1N
         tSzM92ZOEROJWz0eriiL0pKOuSZy3qEZ3hjxcJh/9xua1oq6A+vc5LFRZaY8xwfIee4I
         y5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRhswVLUmWEZ8ZYnthCAU41Qq83maWxBpoDRzhyn2LA=;
        b=IIYUj+uWwZe8xUyrKJJrUy5I266/LH0eoTIh2PLvHm4lIBRphcMrFhpPpry7AHJZYN
         fNB8zfz83rTZrsNMeeSeXrFBBTLYlFhmTn6XKITAMKd7qy4kLLu8IZXCu5sSawhsW5H4
         9cfN2f6bTcqzb8kiQdXklDi0i/kjkQSo1UCLeRjPUhHdoQ/gMpY4VfbqZwhU9XRuJzjD
         WxAYYJXHdBKG8JfZeycG8crJpU+6tEFGRHaW+kLAcVyrxXYDlDwfYqn7ILvHUHjW2OWX
         V34/Qxdfspk6QAolTxfgamT28Lc4sZDaQ1Wlmz9bvqTnhu/p/fCVOLC3VTF7q0liqiFr
         Ftpg==
X-Gm-Message-State: APjAAAUiNxUZIn7/MqIAU02BDNH6HLC4iwxI2EQ/RWGy8V2ajCEiSeC1
        NKR/6L9V9lTnZqIOaEpEEKPJwZqQK5W5I1JbXEX7iQ==
X-Google-Smtp-Source: APXvYqy9/s9edOdB0K00pNIaMXmCxWH5+nSnOdw5d9w5dN8DYYDLLCbfhsQEJL4nNmDB2RTq+h4FOrUQ5OaFRhj5CFU=
X-Received: by 2002:ab0:6016:: with SMTP id j22mr767965ual.119.1551392024919;
 Thu, 28 Feb 2019 14:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-4-ulf.hansson@linaro.org>
 <02a96f2c-dde1-73be-683d-b51d8c6b1b03@linaro.org>
In-Reply-To: <02a96f2c-dde1-73be-683d-b51d8c6b1b03@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Feb 2019 23:13:09 +0100
Message-ID: <CAPDyKFo8nZwNHuxY0Vr3CXW=Z5B4ho7dy_iiDD5pS3yUWGBA7A@mail.gmail.com>
Subject: Re: [PATCH 3/7] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
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

On Thu, 28 Feb 2019 at 15:42, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/02/2019 14:59, Ulf Hansson wrote:
> > Let's split the psci_dt_cpu_init_idle() function into two functions. This
> > makes the code clearer and provides better re-usability.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> but one question below.
>
>
> > ---
> >  drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index c80ec1d03274..9788bfc1cf8b 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
> >  #ifdef CONFIG_CPU_IDLE
> >  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> >
> > +static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > +{
> > +     int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> > +
> > +     if (err) {
> > +             pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
> > +             return err;
> > +     }
> > +
> > +     if (!psci_power_state_is_valid(*state)) {
> > +             pr_warn("Invalid PSCI power state %#x\n", *state);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
> >  {
> > -     int i, ret, count = 0;
> > +     int i, ret = 0, count = 0;
>
> Why do you need to intialize the ret variable? If the count is zero we
> go directly to return 0, otherwise we enter in the loop and ret is
> affected with the new function call.

Depending on the compiler and the compiler flags, one could otherwise
potentially get a warning about using an uninitialized variable at the
free_mem label (not shown in the patch).

So, I just wanted to play safe.

Thanks a lot for reviewing!

Kind regards
Uffe
