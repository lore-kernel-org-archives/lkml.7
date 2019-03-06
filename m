Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E446DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD93920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfCFHgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:36:10 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49169 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfCFHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:36:09 -0500
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 534AE1C0015;
        Wed,  6 Mar 2019 07:36:06 +0000 (UTC)
Date:   Wed, 6 Mar 2019 08:36:05 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Subject: Re: Banana Pi-R1 stabil
Message-ID: <20190306073605.modlx4yhdzbg7sfz@flea>
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
 <20190227092023.nvr34byfjranujfm@flea>
 <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
 <20190228093516.abual3564dkvx6un@flea>
 <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
 <20190301093038.oz56z22ivpntdcfw@flea>
 <8ad8fbeb-fad8-d39a-9cc6-e7f1deab0b4f@wiesinger.com>
 <20190305092830.ef45kxzhdnxlh63g@flea>
 <9f189569-bf76-22d2-3bf7-db710f616998@wiesinger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o75bzzlkdlwciv3j"
Content-Disposition: inline
In-Reply-To: <9f189569-bf76-22d2-3bf7-db710f616998@wiesinger.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o75bzzlkdlwciv3j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 08:21:02PM +0100, Gerhard Wiesinger wrote:
> > > > Run https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-str=
ess-test
> > > >=20
> > > > > But it doesn't explaing that it works with kernel 4.7.4 without a=
ny
> > > > > problems.
> > > > My best guess would be that cpufreq wasn't enabled at that time, or
> > > > without voltage scaling.
> > > >=20
> > > Where can I see the voltage scaling parameters?
> > >=20
> > > on DTS I don't see any difference between kernel 4.7.4 and 4.20.10 re=
garding
> > > voltage:
> > >=20
> > > dtc -I dtb -O dts -o
> > > /boot/dtb-4.20.10-200.fc29.armv7hl/sun7i-a20-lamobo-r1.dts
> > > /boot/dtb-4.20.10-200.fc29.armv7hl/sun7i-a20-lamobo-r1.dtb
> > This can be also due to configuration being changed, driver support, et=
c.
>=20
> Where will the voltages for scaling then be set in detail (drivers, etc.)?

The operating points are in the DT, but how to change it (cpufreq
drivers, clock drivers, regulators drivers) aren't, and the
configuration will tell if those drivers are included, and which
governor is going to be the default.

> > > There is another strange thing (tested with
> > > kernel-5.0.0-0.rc8.git1.1.fc31.armv7hl, kernel-4.19.8-300.fc29.armv7h=
l,
> > > kernel-4.20.13-200.fc29.armv7hl, kernel-4.20.10-200.fc29.armv7hl):
> > >=20
> > > There is ALWAYS high CPU of around 10% in kworker:
> > >=20
> > >  =A0 PID USER=A0=A0=A0=A0=A0 PR=A0 NI=A0=A0=A0 VIRT=A0=A0=A0 RES=A0=
=A0=A0 SHR S=A0 %CPU=A0 %MEM TIME+ COMMAND
> > > 18722 root=A0=A0=A0=A0=A0 20=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0 0 I=A0=A0 9.5=A0=A0 0.0 0:47.52
> > > [kworker/1:3-events_freezable_power_]
> > >=20
> > >  =A0 PID USER=A0=A0=A0=A0=A0 PR=A0 NI=A0=A0=A0 VIRT=A0=A0=A0 RES=A0=
=A0=A0 SHR S=A0 %CPU=A0 %MEM TIME+ COMMAND
> > >  =A0 776 root=A0=A0=A0=A0=A0 20=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0 0 I=A0=A0 8.6=A0=A0 0.0 0:02.77
> > > [kworker/0:4-events]
> > The first one looks like it's part of the workqueue code.
>=20
> Any guessed reason for that?

None, I'm not familiar with the workqueue code.

> > > BTW: Still stable at aboout 2,5days on both devices. So solution IS t=
he
> > > performance governor.
> > No, the performance governor prevents any change in frequency. My
> > guess is that a lower frequency operating point is not working and is
> > crashing the CPU.
> >=20
>=20
> Yes, there might at least 2 scenarios:
>=20
> 1.) Frequency switching itself is the problem

But that code is also the one being used by the BananaPro, which you
reported as stable.

> 2.) lower frequency/voltage operating points are not stable.
>=20
> For both scenarios: it might be possible that the crash happens on idle C=
PU,
> high CPU load or just randomly. Therefore just "waiting" might be better
> than 100% CPU utilization.But will test also 100% CPU.
>=20
> Therefore it would be good to see where the voltages for different
> frequencies for the SoC are defined (to compare).

In the device tree.

> I'm currently testing 2 different settings on the 2 new Banana Pi R1 with
> newest kernel (see below), so 2 static frequencies:
>=20
> # Set to specific frequency 144000 (currently testing on Banana Pi R1 #1)
>=20
> # Set to specific frequency 312000 (currently testing on Banana Pi R1 #2)
>=20
> If that's fine I'll test also further frequencies (with different loads).

Look, you can come up with whatever program you want for this, but if
I insist on running that cpustress program (for the 4th time now), is
that it's actually good at it and caught all the cpufreq issues we've
seen so far.

Feel free to not trust me on this, but I'm not sure how the discussion
can continue if you do.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o75bzzlkdlwciv3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH94ZQAKCRDj7w1vZxhR
xb5vAP9omEQE7Ew2d9KdT9TaBwLf/pj0fDYL8wcklX4q3ak8eAD+J2xpcLaJWHLX
s+dBzrM8KllbuLtR+eC6yBOSsC4+0QE=
=Byx2
-----END PGP SIGNATURE-----

--o75bzzlkdlwciv3j--
