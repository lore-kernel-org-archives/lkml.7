Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C5C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D9822CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfHTHLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:11:46 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50919 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTHLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:11:46 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A19A340002;
        Tue, 20 Aug 2019 07:11:42 +0000 (UTC)
Date:   Tue, 20 Aug 2019 09:11:42 +0200
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
Message-ID: <20190820071142.2bgfsnt75xfeyusp@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7cnfwqz3x4wuuzw"
Content-Disposition: inline
In-Reply-To: <20190820032311.6506-3-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7cnfwqz3x4wuuzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 19, 2019 at 10:23:03PM -0500, Samuel Holland wrote:
> On sun8i, sun9i, and sun50i SoCs, system suspend/resume support requires
> firmware running on the AR100 coprocessor (the "SCP"). Such firmware can
> provide additional features, such as thermal monitoring and poweron/off
> support for boards without a PMIC.
>
> Since the AR100 may be running critical firmware, even if Linux does not
> know about it or directly interact with it (all requests may go through
> an intermediary interface such as PSCI), Linux must not turn off its
> clock.
>
> At this time, such power management firmware only exists for the A64 and
> H5 SoCs.  However, it makes sense to take care of all CCU drivers now
> for consistency, and to ease the transition in the future once firmware
> is ported to the other SoCs.
>
> Leaving the clock running is safe even if no firmware is present, since
> the AR100 stays in reset by default. In most cases, the AR100 clock is
> kept enabled by Linux anyway, since it is the parent of all APB0 bus
> peripherals. This change only prevents Linux from turning off the AR100
> clock in the rare case that no peripherals are in use.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

So I'm not really sure where you want to go with this.

That clock is only useful where you're having a firmware running on
the AR100, and that firmware would have a device tree node of its own,
where we could list the clocks needed for the firmware to keep
running, if it ever runs. If the driver has not been compiled in /
loaded, then we don't care either.

But more fundamentally, if we're going to use SCPI, then those clocks
will not be handled by that driver anyway, but by the firmware, right?

So I'm not really sure that we should do it statically this way, and
that we should do it at all.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--i7cnfwqz3x4wuuzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVudLgAKCRDj7w1vZxhR
xUA2AP9aAfcTGshTf2qlHF7BN2TrmF218A9337dfKfbyq+0aCAD7Bcox3Vtd+uUp
V0EntkOUoyN+OLRb+3kD0UVgB/gcBwM=
=xm76
-----END PGP SIGNATURE-----

--i7cnfwqz3x4wuuzw--
