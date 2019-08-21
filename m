Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02397C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99AD22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfHUMYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:24:41 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48587 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHUMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:24:40 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C6283100009;
        Wed, 21 Aug 2019 12:24:36 +0000 (UTC)
Date:   Wed, 21 Aug 2019 14:24:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 02/10] clk: sunxi-ng: Mark AR100 clocks as critical
Message-ID: <20190821122436.k3s7srhraphfnvgp@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-3-samuel@sholland.org>
 <20190820071142.2bgfsnt75xfeyusp@flea>
 <3b67534a-eb1b-c1e8-b5e8-e0a74ae85792@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="snmlyl3zckhtzbxo"
Content-Disposition: inline
In-Reply-To: <3b67534a-eb1b-c1e8-b5e8-e0a74ae85792@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--snmlyl3zckhtzbxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 08:02:55AM -0500, Samuel Holland wrote:
> On 8/20/19 2:11 AM, Maxime Ripard wrote:
> > On Mon, Aug 19, 2019 at 10:23:03PM -0500, Samuel Holland wrote:
> >> On sun8i, sun9i, and sun50i SoCs, system suspend/resume support requires
> >> firmware running on the AR100 coprocessor (the "SCP"). Such firmware can
> >> provide additional features, such as thermal monitoring and poweron/off
> >> support for boards without a PMIC.
> >>
> >> Since the AR100 may be running critical firmware, even if Linux does not
> >> know about it or directly interact with it (all requests may go through
> >> an intermediary interface such as PSCI), Linux must not turn off its
> >> clock.
>
> This paragraph here is the key. The firmware won't necessarily have a device
> tree node, and in the current design it will not, since Linux never communicates
> with it directly. All communication goes through ATF via PSCI.

Sorry, I'm a bit lost in all those ARM firmware interfaces.

I thought SCPI was supposed to be a separate interface that had
nothing to do with PSCI?

Anyway, my main concern is that I don't really want to make exceptions
to the clock handling for everyone's usecase, and this creates a
precedent (and not even a permanent one, since eventually the plan is
to have all the clock handling happening in the firmware, right?).

There's the protected-clocks property in the DT though that will
achieve the same goal. The code to deal with it is not generic at the
moment, but it could be made that way. Would patching the DT to
protect the clock you care about, when you care about protecting them,
be an option for you?

> >> At this time, such power management firmware only exists for the A64 and
> >> H5 SoCs.  However, it makes sense to take care of all CCU drivers now
> >> for consistency, and to ease the transition in the future once firmware
> >> is ported to the other SoCs.
> >>
> >> Leaving the clock running is safe even if no firmware is present, since
> >> the AR100 stays in reset by default. In most cases, the AR100 clock is
> >> kept enabled by Linux anyway, since it is the parent of all APB0 bus
> >> peripherals. This change only prevents Linux from turning off the AR100
> >> clock in the rare case that no peripherals are in use.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >
> > So I'm not really sure where you want to go with this.
> >
> > That clock is only useful where you're having a firmware running on
> > the AR100, and that firmware would have a device tree node of its own,
> > where we could list the clocks needed for the firmware to keep
> > running, if it ever runs. If the driver has not been compiled in /
> > loaded, then we don't care either.
>
> See above. I don't expect that the firmware would have a device tree node,
> because the firmware doesn't need any Linux drivers.
>
> > But more fundamentally, if we're going to use SCPI, then those clocks
> > will not be handled by that driver anyway, but by the firmware, right?
>
> In the future, we might use SCPI clocks/sensors/regulators/etc. from Linux, but
> that's not the plan at the moment. Given that it's already been two years since
> I started this project, I'm trying to limit its scope so I can get at least some
> part merged. The first step is to integrate a firmware that provides
> suspend/resume functionality only. That firmware does implement SCPI, and if the
> top-level Linux SCPI driver worked with multiple mailbox channels, it could
> query the firmware's version and fetures. But all of the SCPI commands used for
> suspend/resume must go through ATF via PSCI.

I didn't know that you could / should do that with PSCI / SCPI.

> > So I'm not really sure that we should do it statically this way, and
> > that we should do it at all.
>
> Do you have a better way to model "firmware uses this clock behind the scenes,
> so Linux please don't touch it"? It's unfortunate that we have Linux and
> firmware fighting over the R_CCU, but since we didn't have firmware (e.g. SCPI
> clocks) in the beginning, it's where we are today.
>
> The AR100 clock doesn't actually have a gate, and it generally has dependencies
> like R_INTC in use. So as I mentioned in the commit message, the clock will
> normally be on anyway. The goal was to model the fact that there are users of
> this clock that Linux doesn't/can't know about.

Like I said, if that's an option, I'd prefer to have protected-clocks
work for everyone / for sunxi.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--snmlyl3zckhtzbxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV04BAAKCRDj7w1vZxhR
xS0LAQDZ8OikHErqcPJLseJu5A6h3Khvp5dBxyNeyrFMp0lL8wEArJwL9KB6PPko
ri9L7Fwdaj4FYWJQt1qILg/laEndlg0=
=irmF
-----END PGP SIGNATURE-----

--snmlyl3zckhtzbxo--
