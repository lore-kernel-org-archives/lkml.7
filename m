Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFABDCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDFA2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572898177;
	bh=EU1/SX/keEEgUTayzX1NFwMcrOXiP/VIUH4HHOybqts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=afDqJ7nFrYuMjQXuATNICWT96kh/pD+ictDIVIFWDcpGvwdKUEgtXSZGObwXK5m5S
	 6To2CC4BMM0tb+GWWrsUcLilc8TiDCUyfrvl2mHFcnU0Tkr+EXb/jpBIYYmilauN9n
	 0Qy2aFN549Xes/J3JuBsdCtNhgaM4aVmuEcLBPZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfKDUJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfKDUJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:09:36 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A782084D;
        Mon,  4 Nov 2019 20:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572898174;
        bh=EU1/SX/keEEgUTayzX1NFwMcrOXiP/VIUH4HHOybqts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OjZquek1oGIZOJG4Bo1+y18MJNC2srJlMFvycxCwu4hodnhPqFujdqsc57X83mhI/
         0pn0SQIIsVB07pxoOJbLjV4HMGJAdP8LRb6oBJDj9NT0Z5sLdXOhxFHb1BwFEjmHnD
         yJHoXHY9BBxbxUrjFJZ2w8I1pBawfpWS+oNrKTQU=
Received: by mail-qt1-f174.google.com with SMTP id p20so7588493qtq.5;
        Mon, 04 Nov 2019 12:09:34 -0800 (PST)
X-Gm-Message-State: APjAAAUon5WzenRpE91eSsyjVvA4m81/jbUKj0Kfwh3Jr0/gPflT3rKU
        EBVwxKHR0YbcmXSD3zFl4JozfhfpvA/mIeVuDA==
X-Google-Smtp-Source: APXvYqx8BFxJhPpB7ipxT9HsMek753Eb9mzZ3MiHBcLAxgxg+1ySvjemvoO1+BxwDu/0+pIotu8Up2TnBSmc7148Ndg=
X-Received: by 2002:ad4:5446:: with SMTP id h6mr23633630qvt.20.1572898173835;
 Mon, 04 Nov 2019 12:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20191016010544.14561-1-slongerbeam@gmail.com> <20191016010544.14561-3-slongerbeam@gmail.com>
 <20191027212121.GA3049@bogus> <2daa37a6-83a7-ec08-b89c-a07268b3ea4a@gmail.com>
 <CAL_JsqJK5CzQDpCWGZWKgp_8dPG7x0W1HLe+B3zHRP-Te9SToA@mail.gmail.com> <ef514e28-e92f-d8fc-0a5f-330a6207b638@gmail.com>
In-Reply-To: <ef514e28-e92f-d8fc-0a5f-330a6207b638@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Nov 2019 14:09:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1X_62+Xc76GH-n+sBeBqZo6Nw7Viq+1R9SAWHAFmDDQ@mail.gmail.com>
Message-ID: <CAL_Jsq+1X_62+Xc76GH-n+sBeBqZo6Nw7Viq+1R9SAWHAFmDDQ@mail.gmail.com>
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

On Sun, Nov 3, 2019 at 2:20 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
>
>
> On 10/29/19 12:58 PM, Rob Herring wrote:
> > On Mon, Oct 28, 2019 at 6:59 PM Steve Longerbeam <slongerbeam@gmail.com> wrote:
> >> Hi Rob,
> >>
> >> Thanks for reviewing.
> >>
> >> On 10/27/19 2:21 PM, Rob Herring wrote:
> >>> On Tue, Oct 15, 2019 at 06:05:44PM -0700, Steve Longerbeam wrote:
> >>>> Add pin group bindings to support input capture function of the i.MX
> >>>> GPT.
> >>>>
> >>>> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> >>>> ---
> >>>>    .../devicetree/bindings/timer/fsl,imxgpt.txt  | 28 +++++++++++++++++++
> >>>>    1 file changed, 28 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> >>>> index 5d8fd5b52598..32797b7b0d02 100644
> >>>> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> >>>> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> >>>> @@ -33,6 +33,13 @@ Required properties:
> >>>>               an entry for each entry in clock-names.
> >>>>    - clock-names : must include "ipg" entry first, then "per" entry.
> >>>>
> >>>> +Optional properties:
> >>>> +
> >>>> +- pinctrl-0: For the i.MX GPT to support the Input Capture function,
> >>>> +         the input capture channel pin groups must be listed here.
> >>>> +- pinctrl-names: must be "default".
> >>>> +
> >>>> +
> >>>>    Example:
> >>>>
> >>>>    gpt1: timer@10003000 {
> >>>> @@ -43,3 +50,24 @@ gpt1: timer@10003000 {
> >>>>                <&clks IMX27_CLK_PER1_GATE>;
> >>>>       clock-names = "ipg", "per";
> >>>>    };
> >>>> +
> >>>> +
> >>>> +Example with input capture channel 0 support:
> >>>> +
> >>>> +pinctrl_gpt_input_capture0: gptinputcapture0grp {
> >>>> +    fsl,pins = <
> >>>> +            MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1 0x1b0b0
> >>>> +    >;
> >>>> +};
> >>>> +
> >>>> +gpt: gpt@2098000 {
> >>> timer@...
> >> Ok.
> >>
> >>> I don't really think this merits another example though.
> >> Ok.
> >>
> >> But for version 2 of this patch-set I'd like to run some ideas by you.
> >>
> >> Because in this version I did not make any attempt to create a generic
> >> timer capture framework. I just exported a couple imx-specific functions
> >> to request and free a timer input capture channel in the imx-gpt driver.
> >>
> >> So for version 2 I am thinking about a simple framework that other SoC
> >> timers with timer input capture support can make use of.
> >>
> >> To begin with I don't see that timer input capture warrants the
> >> definition of a new device. At least for imx, timer input capture is
> >> just one function of the imx GPT, where the other is Output Compare
> >> which is used for the system timer. I think that is likely the case for
> >> most all SoC timers, that is, input capture and output compare are
> >> tightly interwoven functions of general purpose timers.
> >>
> >> So I'm thinking there needs to be an additional #input-capture-cells
> >> property that defines how many input capture channels the timer
> >> contains, where a channel refers to a single input signal edge that can
> >> capture the timer counter. The imx GPT has two input capture channels (2
> >> separate input signals).
> > #foo-cells is not how many of something, but how many u32 parameters a
> > 'foos' consumer property has. But seems like that's what you meant
> > based on the example.
>
> Sorry yes that's what I meant, my wording was imprecise. If a timer has
> only one input capture channel, no arguments are needed to specify the
> channel in the timer-input-capture property and #input-capture-cells
> would be <0>.
>
>
> >
> >> For example, on imx:
> >>
> >> gpt: timer@2098000 {
> >>          compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
> >>          /* ... */
> >>          #input-capture-cells = <1>;
> >>          pinctrl-names = "default", "icap1";
> >>          pinctrl-0 = <&pinctrl_gpt_input_capture0>;
> >>          pinctrl-1 = <&pinctrl_gpt_input_capture1>;
> >> };
> >>
> >>
> >> A device that is a listener/consumer of an timer capture event would then refer to a timer capture channel:
> >>
> >> some-device {
> >>          /* ... */
> >>          timer-input-capture = <&gpt 0>;
> >> };
> > We'd want to be more consistent in the naming, but seems reasonable.
>
> Yeah, maybe rename the properties to #timer-capture-cells and timer-capture.
>
>
> > One of the challenges with timers is selecting which timer is used for
> > what function. This helps as you can know if a timer is used for input
> > capture or not. One issue will be is having '#input-capture-cells'
> > enough to decide that,
>
>
> Yes, it does bother me somewhat that
>
> timer-capture = <&gpt 0>;
>
> is referring to the timer itself and not its input-capture functionality.
>
> Maybe it would be better, since the timer has multiple functions, to
> make the timer compatible with simple-mfd, so that a timer-capture
> sub-device can be defined, for example on i.MX6:
>
> gpt: timer@2098000 {
>          compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt", "simple-mfd";
>          /* ... */
>
>         tcap: timer-capture {
>                 compatible = "fsl,imx6q-gpt-capture";
>                 #timer-capture-cells = <1>;
>                 pinctrl-names = "default", "icap1";
>                 pinctrl-0 = <&pinctrl_gpt_input_capture0>;
>                 pinctrl-1 = <&pinctrl_gpt_input_capture1>;
>         };
> };
>
> some-device {
>          /* ... */
>          timer-capture = <&tcap 0>;
> };

No, worse IMO. It's not really a separate h/w block to make it a child
node. A single node can be multiple providers.

> >   or does one have to walk the DT and find all
> > the 'timer-input-capture' properties (shouldn't be a lot)?
> >   You could
> > also want to use input capture, but not describe the connection in DT.
>
> That's a thought, but I'm not sure how the kernel API would look in that
> case, i.e. it would not be as straightforward to locate the timer
> clocksource driver that contains the timer capture support. The
> advantage of using a 'timer-capture' property that contains a timer
> phandle, is that it is simple to locate the clocksource driver that has
> the timer capture function.

Ignoring issues with clocksources not being drivers, anything could be
an input capture provider whether DT provides that info or you just
have some API to register an input capture device. IOW, it could be
implicit in DT if you know you always want to expose the
functionality.

> > Another thought is should it be just 'timers' to cover both input
> > capture and output compare with those being selected with flags (like
> > GPIO).
> >
> > My other question is just what are some real examples of devices
> > needing to describe this connection. Timers have had input capture
> > forever, but I've rarely seen it used. Output compare even less so.
>
> In this specific use-case, the i.MX6 CSI often cannot recover from
> corrupted frame synchronization info in the incoming video frames,
> especially for BT.656 sources (too many or too few lines between two
> SAV/EAV codes, or missing codes altogether). The result is loss of
> vertical sync in the captured frames. The only indication of this error
> condition on i.MX6 is a drop in the captured frame intervals. So a
> workaround is to implement a frame interval monitor that measures the
> FI's and reports a V4L2 event to userspace when a FI falls outside some
> tolerance value. Userspace can then take corrective action such as
> restarting video streaming. Finally getting to the use-case here, the
> most accurate way to measure FI's is to capture a timer counter between
> two falling edges of a VSYNC signal from the video source.

I would think VSYNC is slow enough you could just use a GPIO interrupt
unless it's 1 bad frame only and a small change in the timing.

Rob
