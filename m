Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B88EC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675EF21871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGCWdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:33:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39158 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfGCWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:33:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B04AA8060F; Thu,  4 Jul 2019 00:33:39 +0200 (CEST)
Date:   Thu, 4 Jul 2019 00:33:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@llwyncelyn.cymru>,
        Jiri Slaby <jslaby@suse.cz>,
        Peter Hurley <peter@hurleysoftware.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] serdev support for n_gsm
Message-ID: <20190703223350.GA1762@amd>
References: <20190114012528.2367-1-tony@atomide.com>
 <20190118115958.GA5532@kroah.com>
 <20190121105735.GI3691@localhost>
 <20190121170116.GA5544@atomide.com>
 <20190124163932.GZ3691@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20190124163932.GZ3691@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> and sorry about the reply latency. This is quite a lot to think about.
>=20
> I'm also adding Kishon and Mark on CC (e.g. for the phy and ASoC
> bits).

I just wanted to ask... any news here?

> > For some user space examples, I have posted scripts to send and receive
> > SMS at [3], and Pavel has ofono patches [4] below. Seems like we can
> > also add support to ModemManager along the similar lines. And for the
> > serdev drivers, those implement standard Linux interfaces for apps
> > to use.
> >=20
> > For PM, about a year ago I tried making things work with a user space
> > solution and it sucked big time[5]. The power management makes sense
> > to do in the kernel driver at least in this case as there are shared
> > GPIO pins between the USB PHY and TS 27.010 UART. The shared GPIOs
> > are handled by the phy-mapphone-mdm6600 driver.
> >=20
> > With the serdev n_gsm MFD driver, the only thing that needs to be done
> > to idle the modem is to enable autosuspend for the OHCI interface. So
> > no spefific coordination between various components is needed for PM
> > beyond that. Things idle just fine using PM runtime.
>=20
> Yeah, I don't envy you trying to get this to work (and now I'm getting
> dragged into it ;) ).

Yeah, and now I'm in, too. I'd really like to have an useful
phone. Droid4 seems like best candidate.

> It would really help with a high-level outline of the modem and its
> components. I've done my best to derive it from these patches and the
> code you link to, but that info needs to go in the patch descriptions
> (or cover letter).

Are you ready for the crazyness?

There are two modems in droid 4. I don't care about the LTE one. The
GSM one is connected with few USB channels, and few multiplexed
channels over UART.

One of USB channels is standard AT commands.
One of USB channels is QMI.
But using USB means big power consumption, so it is better to use
multiplexed channels over UART.

Few of those look vaguely like AT commands, but voice and sms and
=2E.. are going over separate channels. One of those contains NMEA data
(packet in AT lookalike).

> > Sure that's doable. But notice that we actually need to kick the
> > serdev GNSS interface to get more data. It's not a passive GNSS
> > data feed in this case. So it's not going to be just a case of
> > cat /dev/motmdm4 > /dev/ugnss. Without the serdev GNSS driver,
> > it would be some-custom-app -i /dev/motmdm4 -o /dev/ugnss.
>=20
> Yeah, I remember us discussing that briefly off list.
> =20
> > And without the n_gsm serdev support, it's a mess of some app
> > similar to [5] initializing n_gsm, trying to deal with the USB
> > PHY PM, dealing with Motorola custom packet numbering, kicking
> > GNSS device, feeding data to /dev/ugnss. Hmm I think I've already
> > been there just to be able to type AT commands to the modem and
> > it did not work :)
>=20
> It's a mess indeed, but I'd rather see user-space dealing with until we
> figure out how best to do it in the kernel. ;)

Userspace should be shielded from hardware-specific mess :-(.

> > Anyways, for the serdev kernel drivers, the criteria I've tried
> > to follow is: "Can this serdev device driver make user space
> > apps use standard Linux interfaces for the hardware?"
> >=20
> > So for the serdev Alsa ASoC driver, user space can use the standard
> > Alsa interface for setting voice call volume. And for the serdev
> > GNSS driver, user space can use /dev/gnss0.
>=20
> I understand. Both drivers appears to be using AT commands for control.
> It would be interesting to hear what Mark has to say about the codec
> driver too. Moving AT handling into the kernel scares me a bit. If we
> already have a telephony stack to deal with it in user-space, my
> inclination is to let it continue to handle it.

These "Motorola AT" commands are really a bit different from standard
AT commands. I was working on userspace, and got something... but
could not get SMSes to work.

> Modem-managed GNSS is also different from receivers connected directly
> to the host. It's really the modem that drives the GNSS receiver, and
> offers a higher-level interface to the host, for example, by buffering
> output which the host can later request. It may or may not be the
> kernel's job to periodically poll the modem to recreate an NMEA feed so
> to speak.
>=20
> But the end-result of having it accessible through a standard interface
> is of course appealing.

We'd really like unified interface for the GPS receivers, please. In
the Droid4 case, there's separate channel on the UART that has just
the GPS... so it is really quite similar to normal GPS.

We won't have proper driver for the modem anytime soon, but it would
be good to be able to use the GPS in the meantime.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0dLU4ACgkQMOfwapXb+vJW5gCgmYIFuIwzONDK9HMxxjeYazDy
zG0AnAwd55BTAOguHDpuIumZ7Y7CKmmU
=s0eS
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
