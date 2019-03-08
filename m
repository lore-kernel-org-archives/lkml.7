Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC95E20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuK1xl1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCHKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:37:27 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41678 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCHKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:37:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id m20so6374154vsq.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 02:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gT4k/aTRY356wZ9i43LeQnWQaiGJdGm7KuNy+Zvu3y4=;
        b=SuK1xl1rS6RGn8HLcCWg7QWoLaVypgKE8WEASWXP8/Q+IIip5S5o1g4GyXW0f4pAnR
         S6CvHEMJwxVrPFSp1fL7kD1JOdCTVC3ruohBV7hXzcAScuWqjQEBqN3Hj42fyMEMvWdu
         YJ9vjcUToETm0A3b+TUq+QZOeKQGXRzqdniHJKBujozuJH9ypCkB696/dZuLjxcmRnPj
         5wiPbg6SfCafmgppVbepFo7fJvmB138Hgv/YVFD3KBacEP6qbHeUS+FyxoLruTGxPpec
         VD3mjwnrhSVGxeHbKvPPizHt5sWKzn4TZg70YW+nrBMPQe9XhYzWXSzLo9b3gq/APe2v
         bRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gT4k/aTRY356wZ9i43LeQnWQaiGJdGm7KuNy+Zvu3y4=;
        b=umka2Gv6DJz4vl1tdN38RgFWm++WZXQoIvm5Qb+acurQjrj6/hyoTVOI8jx3f96uHF
         XhXc9cUHMSrb2Jlsc6fxHInl3f43JAuM0vhQhyxK0heG1rnPDORpB85qO19iK8iX7Alz
         oJYaZY8z2vdeZFvalzP30vpBl1Og3f16DvLbXDKLbR2UghxCNuyrL3Fh9OeocxAn4Zms
         yp4syaWdahEeuQQupXwmWj6bX3QpfZSfBy4whA/VvZnG/SV2BYUe/cm8pZjEiNtJtlZP
         YPVwZzLQFD2TV02zkFi1S0WNUWtoJDm4Bhw7w34bgATvdgkbEt/tbkWwz075Z7PSJWlC
         kOow==
X-Gm-Message-State: APjAAAU9AtR+AmQWPdL21UXBGL7nJwTON+0lr5/+qGw+OfO1Co/1q8Xd
        Qz3j1vAdtXcDDZEJRNGzdq0mdkxAuttcZjVPvP+IGA==
X-Google-Smtp-Source: APXvYqzQ8wen9dc/CR2ro3JxqKlD1x00ZgQ3hnNCDVWgo0wFJ0IbUlXExiTxbyQwd5JDP68ktLTK+pnaxyDbHXIdXs8=
X-Received: by 2002:a05:6102:157:: with SMTP id a23mr9531466vsr.34.1552041445307;
 Fri, 08 Mar 2019 02:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com> <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190306181519.GA3355@e107981-ln.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Mar 2019 11:36:49 +0100
Message-ID: <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
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

Lorenzo, Mark,

On Wed, 6 Mar 2019 at 19:15, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Mar 04, 2019 at 11:14:18AM +0100, Ulf Hansson wrote:
> > On Fri, 1 Mar 2019 at 18:28, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Feb 28, 2019 at 02:59:17PM +0100, Ulf Hansson wrote:
> > > > Instead of iterating through all the state nodes in DT, to find out how
> > > > many states that needs to be allocated, let's use the number already known
> > > > by the cpuidle driver. In this way we can drop the iteration altogether.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
> > > >  1 file changed, 12 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > > index d50b46a0528f..cbfc936d251c 100644
> > > > --- a/drivers/firmware/psci/psci.c
> > > > +++ b/drivers/firmware/psci/psci.c
> > > > @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > > >  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > > >                       struct device_node *cpu_node, int cpu)
> > > >  {
> > > > -     int i, ret = 0, count = 0;
> > > > +     int i, ret = 0, num_state_nodes = drv->state_count - 1;
> > > >       u32 *psci_states;
> > > >       struct device_node *state_node;
> > > >
> > > > -     /* Count idle states */
> > > > -     while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> > > > -                                           count))) {
> > > > -             count++;
> > > > -             of_node_put(state_node);
> > > > -     }
> > > > -
> > >
> > > To be honest, I'd rather not tighten the coupling with the cpuidle
> > > driver here. For example, I'm not that happy with the PSCI backend
> > > having to know the driver has a specific WFI state.
> >
> > If you ask me, the coupling is already there, only that it's hidden by
> > taking assumptions about the WFI state in the code.
>
> There is no assumption taken - I wrote it down here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/idle-states.txt?h=v5.0
>
>
> > However, I certainly agree with you, that this isn't very nice.
>
> The idea behind the generic ARM CPU idle driver is as follows:
>
> - A generic front-end in drivers/cpuidle/cpuidle-arm.c
> - An arch back-end (that is defined by the enable-method), on ARM64
>   it is PSCI
>
> As usual with the ARM CPUidle mess, there must be logic connecting
> the front-end and the back-end. An idle state index was used since
> I saw no other generic way. If there are better ideas they are welcome.
>
> Otherwise we must go back to having a PSCI specific CPUIdle driver
> and, on arch/arm, platform specific CPUidle drivers.

To be clear, I am not proposing to change into this. But, since Mark
pointed out his concerns about the specifics around the WFI state, I
just wanted to share what has been on my mind in regards to this as
well.

There are positive/negative consequences with any design, it's not
more than that. If we want to re-design all this, there should be good
reasons and benefits for doing it. Maybe there is, I can't tell at
this point, without further exploring it.

More importantly, so far, I have been able fit my changes to the PSCI
code into the existing model - and with quite limited churns I think.
However, I do need the handle to the struct cpuidle_driver *, that we
use during initialization as patch4 and $subject patch suggests, for
future steps.

>
> The aim was to simplify but to do that we need a connection logic
> between drivers<->arch code, that's the only way we can have a generic
> idle driver and corresponding boilerplate.
>
> > > IIUC we could get rid of the explicit counting with something like:
> > >
> > >         count = of_parse_phandle_with_args(cpu_node, "cpu-idle-states", NULL);
> > >
> > > ... but I'm not sure that the overall change is a simplification.
> >
> > In my opinion, no it doesn't.
> >
> > To me, it seems a kind of silly (and in-efficient) to do an OF parsing
> > that has already been done and given the information we need.
>
> Yeah. It is boot path with idle states in the order of (max) dozens,
> silly and inefficient, maybe but that should be fine.

Yes, it certainly works as is today.

>
> See above.
>
> > > Does this change make it easier to plumb in something in future?
> >
> > Yes, I need this for additional changes on top.
> >
> > Note that, patch4 also provides the opportunity to do a similar
> > cleanup of the initialization code in drivers/soc/qcom/spm.c. I
> > haven't made that part of this series though.
> >
> > I guess in the end, we need to accept that part of the psci driver is
> > really a cpuidle driver. Trying to keep them entirely separate,
> > doesn't come without complexity/churns.
>
> PSCI driver is a kernel interface to firmware, it is not a CPUidle
> driver per-se, we tried to decouple firmware interfaces from kernel
> data structures as much as possible, again, see above.

I fully agree the PSCI firmware driver/code is not a CPUidle driver,
just wanted point out that *part* of that code, is in immediate
connection with CPUidle.

>
> > While working on psci changes in the recent series I have posted, I
> > was even considering adding a completely new cpuidle driver for psci
> > (in drivers/cpuidle/*) and instead define a number of psci interface
> > functions, which that driver could call. That would probably be a
> > better split, but requires quite some changes.
>
> It can be done but with it the whole generic ARM CPUidle driver
> infrastructure must go with it (and you will still have a standard wfi
> state in the PSCI idle state array anyway).
>
> The idea behind ARM64 cpu_ops clashes a bit with this approach so
> there is a discussion to be had here.

I am open to discuss whatever suggestion there is on the table. But is
there any? :-)

>
> > So, what do you want me to do with this?
>
> We need to answer the question above.

So, at this point, I am not suggesting to re-design the cpuidle-arm
driver into a psci cpuidle driver.

Instead, my suggestion is according to what I propose in patch 4 and
$subject patch, which means minor adjustments to be able to pass the
struct cpuidle_driver * to the init functions. This, I need it for
next steps, but already at this point it improves things as it avoids
some of the OF parsing, and that's good, isn't it?

>
> Thanks,
> Lorenzo
>

Thanks for you comments!

Kind regards
Uffe
