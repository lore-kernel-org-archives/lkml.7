Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0D0C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE3821707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556583431;
	bh=QT6S6NiqLDuf6uLxFZ4ko7gd/kGE9Fl2HUC1VAVYb6E=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=LXznKVq/22JSIWMBAR1EaJhAc/lokdsztPmWs2gUUKLXkridW2T/r12N6OG8Jj3h6
	 UJgVxd7FQP8cKiR3Z34OA2vS8wJfFdnBz/HEBOEWYWwkUiV083uZsH4lfjLsEtsqHR
	 AxFqHaLqoZBhqSYUnv8YPqSy6XhJw4AmzPfhgX6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfD3ARK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfD3ARK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:17:10 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A1821670;
        Tue, 30 Apr 2019 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556583428;
        bh=QT6S6NiqLDuf6uLxFZ4ko7gd/kGE9Fl2HUC1VAVYb6E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=q9mfYrxSE6XIRr6nkfMOsuR/ivTvyB5vdyb8iDXMzuQV+QiURH7xfFjHbFbG3DCa6
         HDcmWeCPzGGaSJaHFVEPT296DkPBKATOIsoOiI7uBF5yDv41hke/D/CqNaaA7HnvXz
         3e5PUKXOmFFhvmLfkewjJ2rg2OAgSInUeMNmTGXk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl> <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com> <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl> <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com> <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: Add silabs,si5341
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <155658342800.168659.4922821141203707564@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 17:17:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-04-27 02:42:56)
> On 27-04-19 02:44, Stephen Boyd wrote:
> > Quoting Mike Looijmans (2019-04-25 23:51:15)
> >> On 26-04-19 01:04, Stephen Boyd wrote:
> >>>> +
> >>>> +Optional properties:
> >>>> +- silabs,pll-m-num, silabs,pll-m-den: Numerator and denominator for=
 PLL
> >>>> +  feedback divider. Must be such that the PLL output is in the vali=
d range. For
> >>>> +  example, to create 14GHz from a 48MHz xtal, use m-num=3D14000 and=
 m-den=3D48. Only
> >>>> +  the fraction matters, using 3500 and 12 will deliver the exact sa=
me result.
> >>>> +  If these are not specified, and the PLL is not yet programmed whe=
n the driver
> >>>> +  probes, the PLL will be set to 14GHz.
> >>>
> >>> Can this be done via assigned-clock-rates? Possibly with a table in t=
he
> >>> clk driver to tell us how to generate those rates.
> >>
> >> The PLL frequency choice determines who'll get jitter and who won't. I=
t's
> >> ridiculously accurate too.
> >>
> >> For example, if you need a 26 MHz and a 100 MHz output, there's no sol=
ution
> >> for the PLL that makes both clocks an integer divider (SI is vague abo=
ut it,
> >> but apparently integer dividers have less jitter on output). Only the =
enduser
> >> can say which clock will get the better quality.

Right. So maybe we make tables of rates and put it in the driver and
keep adding code in there? I'm worried about having these properties in
DT and then having to work around them later on by "fixing" the DT. If
it's only in the driver then we're able to tweak the values to get
better jitter numbers, etc.

> >>
> >>>
> >>>> +- silabs,reprogram: When present, the driver will always assume the=
 device must
> >>>> +  be initialized, and always performs the soft-reset routine. Since=
 this will
> >>>> +  temporarily stop all output clocks, don't do this if the chip is =
generating
> >>>> +  the CPU clock for example.
> >>>
> >>> Could this be done with the reset framework? It almost sounds like if
> >>> the clk is a CLK_IS_CRITICAL then we shouldn't do the reset, otherwise
> >>> we probably should reset the chip when the driver probes. If we don't
> >>> have a case where it's going to be supplying a critical clk for a long
> >>> time then perhaps we shouldn't even consider this topic until later.
> >>
> >> The driver can sort of see that the chips is already configured. This =
tells
> >> the driver whether that's expected or just coincidence.
> >>
> >> Maybe it'd be clearer if I reversed the logic and name this
> >> "silabs,preprogrammed", which will skip the driver's initialization ro=
utine?
> >>
> >=20
> > Maybe? Is there any way to look at some register to figure out for sure
> > if it's been pre-programmed or not? Could TOOL_VERSION be used or
> > ACTIVE_NVM_BANK or DESIGN_ID0-7?
>=20
> I've experimentally determined that TOOL_VERSION and DESIGN_IDx=20
> apparently get filled with zeroes by the clockbuilder anyway.
>=20
> ACTIVE_NVM_BANK works reliably for self-programmed chips.
>=20
> The flag is about "is this chip under full kernel control, or is it=20
> generating clocks the kernel doesn't know about (e.g. for realtime cores =

> or FPGA logic)".
>=20

Alright.

>=20
>=20
> >>>> +=3D=3DChild nodes=3D=3D
> >>>> +
> >>>> +Each of the clock outputs can be overwritten individually by
> >>>> +using a child node to the I2C device node. If a child node for a cl=
ock
> >>>> +output is not set, the configuration remains unchanged.
> >>>> +
> >>>> +Required child node properties:
> >>>> +- reg: number of clock output.
> >>>> +
> >>>> +Optional child node properties:
> >>>> +- silabs,format: Output format, see [1], 1=3Ddifferential, 2=3Dlow-=
power, 4=3DLVCMOS
> >>>> +- silabs,common-mode: Output common mode, depends on standard.
> >>>> +- silabs,amplitude: Output amplitude, depends on standard.
> >>>> +- silabs,synth-source: Select which multisynth to use for this outp=
ut
> >>>> +- silabs,synth-frequency: Sets the frequency for the multisynth con=
nected to
> >>>> +  this output. This will affect other outputs connected to this mul=
tisynth. The
> >>>> +  setting is applied before silabs,synth-master and clock-frequency.
> >>>> +- silabs,synth-master: If present, this output is allowed to change=
 the
> >>>> +  multisynth frequency dynamically.
> >>>
> >>> These above properties look like highly detailed configuration data to
> >>> let the driver configure the clk output exactly how it's supposed to =
be
> >>> configured. Can these properties be rewritten in more high-level terms
> >>> that a system integrator would understand? Ideally, I shouldn't have =
to
> >>> read the datasheet and the driver and then figure out what DT propert=
ies
> >>> need the values from the datasheet in them so that the driver writes
> >>> them to a particular register. I don't know if that's possible here,
> >>> because I haven't read the driver or the datasheet too closely yet, b=
ut
> >>> that should be the goal.
> >>
> >> The datasheet is not very helpful in this regard. Silabs just assumes =
you'll
> >> use their clockbuilder software for writing these values, which is how=
 we got
> >> to the "LVDS 3v3" values.
> >=20
> > I hope that can be determined by looking at vdd<N>-supply voltages?
>=20
> Not really, and when asked for a bit more detail, Silabs just says to=20
> use the excellent developer friendly clockbuilder software that almost=20
> runs on almost any platform.
>=20
> >> I could put in a table of "common" values, so that you can say:
> >>
> >> silabs,output-standard =3D "lvds";
> >>
> >> And then use the "raw" properties to expand or override on that.
> >>
> >> Extra defines might help, e.g.:
> >>
> >> silabs,format =3D <SI5341_FORMAT_DIFFERENTIAL>;
> >=20
> > I suppose you'll need to reverse engineer the clock builder software to
> > figure out why a SI5341_FORMAT_DIFFERENTIAL would be specified instead
> > of some other value. Ideally we don't need any of these vendor specific
> > properties and the drivers using these clks can ask the clk framework to
> > configure these properties, or we need to look at making more properties
> > like 'assigned-clock-parents' that lets us configure things generically.
>=20
> These properties are about how you soldered things together, but yeah,=20
> if the clock outputs go to expansion slots, some driver or devicetree=20
> fragment control would be desirable, so you can switch the clock mode=20
> from differential to single ended for example.

Hmm.. Perhaps we need a clk_set_mode() API? Possibly be an internal API
that lets the DT configure the mode to be differential or single ended?
Nobody has required this so far so it's very rare, but I'd like to see
the properties become standard instead of vendor specific if possible.

>=20
>=20
> >>>> +- always-on: Immediately and permanently enable this output. Partic=
ulary
> >>>> +  useful when combined with assigned-clocks, since that does not pr=
epare clocks.
> >>>
> >>> Looks like you want CLK_IS_CRITICAL in DT. We've had that discussion
> >>> before but maybe we should revisit it here and add a way to indicate
> >>> that some clk should never be turned off instead of assuming that we
> >>> can do this from C code all the time.
> >>
> >> My issue was that assigned-clocks does not call clk_prepare. If the cl=
ock is
> >> not running, assigned-clocks will not turn it on (at least, that is th=
e case
> >> on the 4.14 kernel I tested this on), it apparently only prevents it f=
rom
> >> being turned off by marking it as "in use". This just provides a way t=
o use
> >> assigned-clocks.
> >>
> > Do you want the clks to always be prepared and enabled? What use-case is
> > this? It still looks like CLK_IS_CRITICAL flag needs to be expressed in
> > DT here.
>=20
> The use case is pretty simple, it's just to enable the clock. Or in this =

> case, "prepare" it, because the I2C client needs to be able to sleep and =

> all actions must be done in the prepare part.
>=20
> Suppose I use the si5341 to generate a 26MHz clock that would normally=20
> be provides by a hardware oscillator. The driver itself doesn't have any =

> clock properties to set. Then I'd put into that device's devicetree node =

> the following:
>=20
> assigned-clocks =3D <&si5341 2>;
> assigned-clock-rates =3D <26000000>;
>=20
> When the system boots, the clock framework indeed calls=20
> "set_rate(26000000)" before that driver probes, but it never calls=20
> "clk_prepare", so the clock's frequency is set okay but the clock won't=20
> be running and the device won't function.

Why can't that driver call clk_prepare_enable()? Is there some sort of
assumption that this clk will always be enabled and not have a driver
that configures the rate and gates/ungates it?

