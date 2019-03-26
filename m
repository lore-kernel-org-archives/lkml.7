Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DAC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8737320811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553616412;
	bh=n+YQMdyNixtA3ulybEQw/Fkej+e5djvPVPNuICR2uMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZamVYWg/X9NV09HJHL80r1jZcBeqr5xIJauHvXzr4hlclnU3XnY9saqRTRCD+HqEa
	 aLtRp8R7i2D0TF68ZRdjcLm5OOEWnpaALIsweN9/wECWPFsVdw0Vd30hHew20ATK1V
	 gYa23/ncv0x2AM8OK6zD/Itvw0mVt6ByfDe0+uMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfCZQGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfCZQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:06:51 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C29E2070D;
        Tue, 26 Mar 2019 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553616409;
        bh=n+YQMdyNixtA3ulybEQw/Fkej+e5djvPVPNuICR2uMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pi5bLvU2FZBHeGJvRQqjKqG+eIkpmTPgEtizBYefEnYDWSeqv7ZW2dW1vDipEou77
         gnyDfAI8XgWawFuCMJFVynbx0fZ3D52BrCcyM/H09bcPucFhQUfcS3/wjVurOPq5Ns
         5lNBr2KCTmEbdQFtstuoHZCoG1oEQFt3/bgF1A/s=
Received: by mail-qt1-f176.google.com with SMTP id k14so15248575qtb.0;
        Tue, 26 Mar 2019 09:06:49 -0700 (PDT)
X-Gm-Message-State: APjAAAX9izjE93Al6u5buIKFwXrzikBYzKBVbLYQOY75vDDtPOjkYuHL
        2iDl4Z3xvEr6IBga1MzJZj4zyAQe9oJQLYoXyg==
X-Google-Smtp-Source: APXvYqw83pPW8sTtnMW2/pivRygJIjkI7wQqunXKiwHrug9V4B++sp0PWbD9ZXw2VfcCpKx9ph3knTwET/1WllkreNQ=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr26094887qtv.76.1553616408717;
 Tue, 26 Mar 2019 09:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190316142138.65860d88@archlinux> <55b4aaba-a94f-2a9d-c96d-e591877fe075@mind.be>
In-Reply-To: <55b4aaba-a94f-2a9d-c96d-e591877fe075@mind.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Mar 2019 11:06:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmtr7Gojx9kfPay=HUJ-Xpg0W1dB-K4bfWDnhsA3KAyA@mail.gmail.com>
Message-ID: <CAL_JsqKmtr7Gojx9kfPay=HUJ-Xpg0W1dB-K4bfWDnhsA3KAyA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
To:     Arnout Vandecappelle <arnout@mind.be>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:43 AM Arnout Vandecappelle <arnout@mind.be> wrote:
>
>  [Full disclosure: I'm a colleague of Patrick.]
>
> On 2019-03-16 14:21:38, Jonathan Cameron wrote:
>
> > On Tue, 12 Mar 2019 14:09:52 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> > > > FlexTimer quadrature decoder driver.
> > > >
> > > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > > > ---
> > > > Changes v2
> > > > - None
> > > > ---
> > > > .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
> > > > 1 file changed, 18 insertions(+)
> > > > create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt \
> > > > b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt new file mode 100644
> > > > index 000000000000..4d18cd722074
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > > > @@ -0,0 +1,18 @@
> > > > +FlexTimer Quadrature decoder counter
> > > > +
> > > > +This driver exposes a simple counter for the quadrature decoder mode.
> > >
> > > Seems like this is more a mode of a h/w block than describing a h/w
> > > block. Bindings should do the latter.
>
>
>   As Jonathan writes below, it really is a "hardware mode", since it is tied
> very closely to how the device is wired up.

Okay, as it is describing what is attached, I agree.

The thing to consider is whether you will need to describe more than
just the mode. We often start adding properties of an attached device
in the controller node only to realize later that we should have a
node for the device itself. Even for something as simple as an LED
we've ended up there.

>  Basically, the same block can be used for pretty diverse functions: a PWM where
> the pins are output, a counter where the pins are input, or a timer where the
> interrupt or timer value is used purely internally.
>
>  This smells a bit like an MFD, but IMO it really isn't, because only one of the
> functions can be enabled. So indeed, it's more like a mode.

Agreed.

> > The snag is that we need to dig ourselves out of the hole set by:
> > fsl,vf610-ftm-pwm etc.
> >
> > Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> > Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> > (I'm assuming these are the same IP block).
> >
> > Can probably be sorted out though.  One core driver binds against the
> > ftm and deals with instantiating the others depending on the configuration
> > (note that this mode for instance does make sense in DT as it's
> > really reflecting the fact there is a quadrature encoder
> > connected to the ftm).
> >
> > Fiddly though :)
>
>
>  The way I see it, there are 3 ways this could be modelled (other than the
> current way: several nodes with the same address).
>
>
> 1. The SoC's .dtsi defines a single node, and the compatible string (which would
> be defined by the board .dts) both enables the node and sets the compatible
> string. The .dtsi would also define the static properties of all the different
> functions: some "static" properties, e.g. reg, but also some function
> specific-properties, e.g.#pwm-cells (only for PWM), interrupts (only for timer).
> The driver (selected through compatible) anyway only uses the properties that it
> needs, so it doesn't hurt to have those other-function properties there.
>
>
> 2. Like 1, but instead of defining the compatible string in the .dts, use a
> single compatible string for all the different drivers which is set in the
> .dtsi, and add a mode property (to be set in the .dts) to select the driver. The
> selection can be done either by having a top-level driver that calls out to the
> subsystem-specific one based on the mode, or by having each driver bail out of
> its probe function if the mode is not as expected.
>
>
> 3. Have a common node that essentially does nothing except occupy the memory
> resource, and sub-nodes for each function. This can again be combined with a
> common driver that does the common resource allocation, or each function driver
> can just look at its parent node to find the resources. A disadvantage of this
> one is that it is possible to enable several functions in the DT, while only one
> can actually work.
>
>
>  Option 3 is what is used for e.g. stm32-lptimer. It also uses an mfd driver to
> model the common part. But possibly it actually allows the different functions
> to operate simultaneously.

I'm not all that thrilled with how that one ended up.

>  Option 3 has the additional disadvantage that it requires changes in existing
> DTs for ftm-pwm and ftm-timer, because some properties are moved one level down.
> Since we need to retain backward compatibility, we'd need to look for those
> properties both in the node itself and in the parent node. In particular, the
> common driver part would be fairly complicated to implement in a backward
> compatible way because it's not enough to do a simple devm_of_platform_populate().
>
>
>  Personally I don't like the common driver part too much. This common driver
> does almost nothing (iomap and clock) and it creates dependencies between
> different drivers. Combined with the backward compatibility problem, I don't see
> much point to it.
>
>
>  I personally like option 2 the most. It's easy to be backward compatible (if
> mode is not set, revert to the current behaviour, i.e. assume that the
> compatible string has encoded the mode and that you're the only driver). It
> doesn't introduce subnodes that have no hardware equivalent. The only messy
> thing about it is that properties belonging to the different modes are mixed
> together in a single node. And also, I don't think this kind of model is
> currently used anywhere else in the kernel.

Option 2 seems best to me.

Rob
