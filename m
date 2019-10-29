Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87012CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A60C2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572379131;
	bh=WAdeg+B9VRaoa2GUGbY801lVq9HtWmhjZYVHysrysc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sQufRgYDFM/fEBg4bb1ek046Aoq0E1Q7P7OR8Ub0kW1iNNrNAr/Ve91cIlOVgMxsC
	 jUeAEZiy15YDFj5h8pGXR52sqFt5ZT1WAH6MV+QJ9TNn4CN8iGCAoi57JwiSttScXB
	 4sLDAnvkc65OQ61uGIingMb+WGQmFQ72lBqy69Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfJ2T6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfJ2T6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:58:50 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863B7217F9;
        Tue, 29 Oct 2019 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572379128;
        bh=WAdeg+B9VRaoa2GUGbY801lVq9HtWmhjZYVHysrysc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NWcGI6t4d1C6w5YAcjerwQGwR40yf9qK1MLh8rjyF/petI083MZCWoDGvmAGjUNT+
         osJVzDa0YEBwPO7Aa83PkbOI33Q1gE7pAw7jcVi8uWmcZglhBgxr0bcxGIyj55LVjE
         ZoNK5yzBU/vrK/+f+MwxjVdJElZhbsS1weXQZGvA=
Received: by mail-qt1-f178.google.com with SMTP id t26so12065009qtr.5;
        Tue, 29 Oct 2019 12:58:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWZd5iDblHh3dzs6lYXpuUIOZWwl3viiUKOtN3jkcnqgOUkGYDM
        QcvxvTqRpFCYjkaw/KFP2b+mR7a6C02y2Gu2ZQ==
X-Google-Smtp-Source: APXvYqzRmnIY3wGUVkxDxaAMji2JuEUN2V6Oi2AOYbmEqJQcYn6zDifp/TQUReouyPTdjsRGjIdcrF3l7Z6nybIbzJE=
X-Received: by 2002:ac8:48c5:: with SMTP id l5mr469360qtr.110.1572379127527;
 Tue, 29 Oct 2019 12:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191016010544.14561-1-slongerbeam@gmail.com> <20191016010544.14561-3-slongerbeam@gmail.com>
 <20191027212121.GA3049@bogus> <2daa37a6-83a7-ec08-b89c-a07268b3ea4a@gmail.com>
In-Reply-To: <2daa37a6-83a7-ec08-b89c-a07268b3ea4a@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Oct 2019 14:58:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJK5CzQDpCWGZWKgp_8dPG7x0W1HLe+B3zHRP-Te9SToA@mail.gmail.com>
Message-ID: <CAL_JsqJK5CzQDpCWGZWKgp_8dPG7x0W1HLe+B3zHRP-Te9SToA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: timer: imx: gpt: Add pin group bindings
 for input capture
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 6:59 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Hi Rob,
>
> Thanks for reviewing.
>
> On 10/27/19 2:21 PM, Rob Herring wrote:
> > On Tue, Oct 15, 2019 at 06:05:44PM -0700, Steve Longerbeam wrote:
> >> Add pin group bindings to support input capture function of the i.MX
> >> GPT.
> >>
> >> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> >> ---
> >>   .../devicetree/bindings/timer/fsl,imxgpt.txt  | 28 +++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> >> index 5d8fd5b52598..32797b7b0d02 100644
> >> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> >> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> >> @@ -33,6 +33,13 @@ Required properties:
> >>              an entry for each entry in clock-names.
> >>   - clock-names : must include "ipg" entry first, then "per" entry.
> >>
> >> +Optional properties:
> >> +
> >> +- pinctrl-0: For the i.MX GPT to support the Input Capture function,
> >> +         the input capture channel pin groups must be listed here.
> >> +- pinctrl-names: must be "default".
> >> +
> >> +
> >>   Example:
> >>
> >>   gpt1: timer@10003000 {
> >> @@ -43,3 +50,24 @@ gpt1: timer@10003000 {
> >>               <&clks IMX27_CLK_PER1_GATE>;
> >>      clock-names = "ipg", "per";
> >>   };
> >> +
> >> +
> >> +Example with input capture channel 0 support:
> >> +
> >> +pinctrl_gpt_input_capture0: gptinputcapture0grp {
> >> +    fsl,pins = <
> >> +            MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1 0x1b0b0
> >> +    >;
> >> +};
> >> +
> >> +gpt: gpt@2098000 {
> > timer@...
>
> Ok.
>
> >
> > I don't really think this merits another example though.
>
> Ok.
>
> But for version 2 of this patch-set I'd like to run some ideas by you.
>
> Because in this version I did not make any attempt to create a generic
> timer capture framework. I just exported a couple imx-specific functions
> to request and free a timer input capture channel in the imx-gpt driver.
>
> So for version 2 I am thinking about a simple framework that other SoC
> timers with timer input capture support can make use of.
>
> To begin with I don't see that timer input capture warrants the
> definition of a new device. At least for imx, timer input capture is
> just one function of the imx GPT, where the other is Output Compare
> which is used for the system timer. I think that is likely the case for
> most all SoC timers, that is, input capture and output compare are
> tightly interwoven functions of general purpose timers.
>
> So I'm thinking there needs to be an additional #input-capture-cells
> property that defines how many input capture channels the timer
> contains, where a channel refers to a single input signal edge that can
> capture the timer counter. The imx GPT has two input capture channels (2
> separate input signals).

#foo-cells is not how many of something, but how many u32 parameters a
'foos' consumer property has. But seems like that's what you meant
based on the example.

>
> For example, on imx:
>
> gpt: timer@2098000 {
>         compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
>         /* ... */
>         #input-capture-cells = <1>;
>         pinctrl-names = "default", "icap1";
>         pinctrl-0 = <&pinctrl_gpt_input_capture0>;
>         pinctrl-1 = <&pinctrl_gpt_input_capture1>;
> };
>
>
> A device that is a listener/consumer of an timer capture event would then refer to a timer capture channel:
>
> some-device {
>         /* ... */
>         timer-input-capture = <&gpt 0>;
> };

We'd want to be more consistent in the naming, but seems reasonable.
One of the challenges with timers is selecting which timer is used for
what function. This helps as you can know if a timer is used for input
capture or not. One issue will be is having '#input-capture-cells'
enough to decide that, or does one have to walk the DT and find all
the 'timer-input-capture' properties (shouldn't be a lot)? You could
also want to use input capture, but not describe the connection in DT.

Another thought is should it be just 'timers' to cover both input
capture and output compare with those being selected with flags (like
GPIO).

My other question is just what are some real examples of devices
needing to describe this connection. Timers have had input capture
forever, but I've rarely seen it used. Output compare even less so.

Rob
