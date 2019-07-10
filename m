Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B73C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C9214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDMNkG9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGJWLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:11:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44214 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:11:32 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so2869363oib.11;
        Wed, 10 Jul 2019 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0fNZ+VwPek5C+viI1snkH/my4gCM3GRy8SEqIEurFg=;
        b=FDMNkG9C/a/JXOKXykARV0Tgu5YnEa+mdKXbnNdqxZB8C8/0GpR1qgIShCPQ015R+/
         rXagG3fo+XoxkQSBmh7wQSI2U0ZELZ+DI5FuNydFTxqfmKxbfDBtHY5sm3CkM2mEyTwJ
         ECmHfCFgxnIx7XbU8ZlyeesZhkNpMf150ltwtgo3VqfYRAcZXDMry+c2Gj9GG9js9jHp
         4qk2fkGpojRs+P7zVMsrK/tu5Pi113FcVZUZV2HU/bFr+Dn+IHSQhcPa6uPnbGuBpCt8
         5AniWOjqbOCSJAC0N8+qxBtPkT97+cOImG7CW8xEVi/DKYKmK6sf0s6Zs3Iag/vsvDJL
         pmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0fNZ+VwPek5C+viI1snkH/my4gCM3GRy8SEqIEurFg=;
        b=oErIKz4CH0POmYfQzJlvgEGpt9OSpXACilePRxaK+8NGTjymGuAk0DrM31BXhM5DNf
         zJoDqTOJTT/NOEtOAxSCdAQGD1ub/C6uqsGE41K/iIYG98pH62kmeMZQgalwqDbVCXPo
         OpMY48OkJ5UMmM3TV0z3YIPqH3usyLzL0C/XPiTVG4JDp4WySK7tISgUyVmIQkkh3x8E
         URAmqLEVh3VSx3CWMtpUrBbVVdoIUj7FhFLgguN+6Ay03gUYZMpUGgobIeRo64UgWZfX
         UIADYd2udsSRW1YihRu6ysXqyQQzYBZYTLSpXV+YKpB+5gRMzah33vKnBGyquVB3FgfA
         TJ2g==
X-Gm-Message-State: APjAAAWfjvsbYmpQQGWyiWwo1/e521tfpGXUym1pWbimvWZ9kT7+cK1m
        3gGVWSNqvqY9sRZ2lI9azOOjKKf83blJJFF2uYU=
X-Google-Smtp-Source: APXvYqy5OXN836oo7SWmrQ7Vg9tlideKoCNYHP1ilr/cbrOyEfNDRMdydeIgqr0QsvHASXs5J1ioQHTHS5HXQQG1cGQ=
X-Received: by 2002:aca:f552:: with SMTP id t79mr353341oih.145.1562796690656;
 Wed, 10 Jul 2019 15:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190607062802.m5wslx3imiqooq5a@flea> <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com>
 <20190607094030.GA12373@lst.de> <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
 <20190612152022.c3cfhp4cauhzhfyr@flea> <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com>
 <20190701095842.fvganvycce2cy7jn@flea> <CA+E=qVdsYV2Bxk245=Myq=otd7-7WHzUnSJN8_1dciAzvSOG8g@mail.gmail.com>
 <20190709085532.cdqv7whuesrjs64c@flea> <CA+E=qVdz4vfU3rtTTKjYdM+4UA+=FWheJfWOMaDtFMnWQ1rHbw@mail.gmail.com>
 <20190710114042.ybgavnxb4hgqrtor@flea>
In-Reply-To: <20190710114042.ybgavnxb4hgqrtor@flea>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 10 Jul 2019 15:11:04 -0700
Message-ID: <CA+E=qVdFoT137pADfxz3uMwhOqjqrA9+6hBeOfbJxuH-M-3Pjw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, Torsten Duwe <duwe@lst.de>,
        Harald Geyer <harald@ccbib.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 4:40 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jul 09, 2019 at 01:30:18PM -0700, Vasily Khoruzhick wrote:
> > On Tue, Jul 9, 2019 at 1:55 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Jul 08, 2019 at 05:49:21PM -0700, Vasily Khoruzhick wrote:
> > > > > > Maybe instead of edp-connector one would introduce integrator's specific
> > > > > > connector, for example with compatible "olimex,teres-edp-connector"
> > > > > > which should follow edp abstract connector rules? This will be at least
> > > > > > consistent with below presentation[1] - eDP requirements depends on
> > > > > > integrator. Then if olimex has standard way of dealing with panels
> > > > > > present in olimex/teres platforms the driver would then create
> > > > > > drm_panel/drm_connector/drm_bridge(?) according to these rules, I guess.
> > > > > > Anyway it still looks fishy for me :), maybe because I am not
> > > > > > familiarized with details of these platforms.
> > > > >
> > > > > That makes sense yes
> > > >
> > > > Actually, it makes no sense at all. Current implementation for anx6345
> > > > driver works fine as is with any panel specified assuming panel delays
> > > > are long enough for connected panel. It just doesn't use panel timings
> > > > from the driver. Creating a platform driver for connector itself looks
> > > > redundant since it can't be reused, it doesn't describe actual
> > > > hardware and it's just defeats purpose of DT by introducing
> > > > board-specific code.
> > >
> > > I'm not sure where you got the idea that the purpose of DT is to not
> > > have any board-specific code.
> >
> > I believe DT was an attempt to move to declarative approach for
> > describing hardware. Yes, we have different compatibles for different
> > devices but they're specific to particular device rather than
> > particular board. Device interconnection is described in DT along with
> > some properties rather than in board-specific C-file.
>
> You're right, but it's not incompatible with having some code to deal
> with some board quirk.
>
> > Introducing board-specific compatible for a connector isn't looking
> > right to me.
>
> If that board has a board-specific behaviour for it's connector, then
> what's the issue?
>
> You can't describe all the quirks in the all boards using purely
> properties.
>
> > > It's perfectly fine to have some, that's even why there's a compatible
> > > assigned to each and every board.
> > >
> > > What the DT is about is allowing us to have a generic behaviour that
> > > we can detect: we can have a given behaviour for a given board, and a
> > > separate one for another one, and this will be evaluated at runtime.
> > >
> > > This is *exactly* what this is about: we can have a compatible that
> > > sets a given, more specific, behaviour (olimex,teres-edp-connector)
> > > while saying that this is compatible with the generic behaviour
> > > (edp-connector). That way, any OS will know what quirk to apply if
> > > needed, and if not that it can use the generic behaviour.
> > >
> > > And we could create a generic driver, for the generic behaviour if
> > > needed.
> > >
> > > > There's another issue: if we introduce edp-connector we'll have to
> > > > specify power up delays somewhere (in dts? or in platform driver?), so
> > > > edp-connector doesn't really solve the issue of multiple panels with
> > > > same motherboard.
> > >
> > > And that's what that compatible is about :)
> >
> > Sorry, I fail to see how it would be different from using existing
> > panels infrastructure and different panels compatibles. I think Rob's
> > idea was to introduce generic edp-connector.
>
> Again, there's no such thing as a generic edp-connector. The spec
> doesn't define anything related to the power sequence for example.
>
> > If we can't make it generic then let's use panel infrastructure.
>
> Which uses a device specific compatible. Really, I'm not sure what
> your objection and / or argument is here.
>
> In addition, when that was brought up in the discussion, you rejected
> it because it was inconvenient:
> https://patchwork.freedesktop.org/patch/283012/?series=56163&rev=1#comment_535206

It is inconvenient, but I don't understand how having board-specific
connectors fixes it.



> And I agree with you on that one.
>
> > > > I'd say DT overlays should be preferred solution here, not another
> > > > connector binding.
> > >
> > > Overlays are a way to apply a device tree dynamically. It's orthogonal
> > > to the binding.
> >
> > It isn't orthogonal to original problem though.
>
> It is. The original problem is that you want to power up whatever is
> on the other side of a eDP link using an arbitrary regulator.
>
> This is a "how do I describe that in my DT" problem, and it really has
> nothing to do with how the DT is being passed to the kernel.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
