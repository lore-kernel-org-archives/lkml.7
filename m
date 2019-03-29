Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C21C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90F52173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfC2Ieo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:34:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45645 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfC2Ieo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:34:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2ECD880525; Fri, 29 Mar 2019 09:34:33 +0100 (CET)
Date:   Fri, 29 Mar 2019 09:34:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329083440.GA12945@amd>
References: <20190329040922.34ab01c6@nic.cz>
 <20190329062253.GA9659@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20190329062253.GA9659@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-29 07:22:53, Greg Kroah-Hartman wrote:
> On Fri, Mar 29, 2019 at 04:09:22AM +0100, Marek Behun wrote:
> > Hello Tejun and Greg,
> >=20
> > kernfs_fop_open/read/write allocates a buffer for the ->read, ->write,
> > or ->seq_read methods. This buffer is either preallocated or allocated
> > on the spot, with minimum size being PAGE_SIZE, if ->atomic_write_len
> > is not given.
> >=20
> > There is a question/problem currently in the led-trigger API, that the
> > PAGE_SIZE buffer can in some specific scenarios be too short.
>=20
> And that file is in sysfs?  That's a huge abuse of the sysfs api
> then :(

Yes, that's how we do selection from the list in sysfs, and
led-trigger is not alone there:

pavel@amd:~/cip$ cat /sys/power/state
freeze mem disk
pavel@amd:~/cip$ cat /sys/class/leds/phy0-led/trigger
none bluetooth-power rfkill-any rfkill-none kbd-scrolllock kbd-numlock
kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock kbd-ctrllock
kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock kbd-ctrlrlock
AC-online BAT0-charging-or-full BAT0-charging BAT0-full
BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
phy0radio [phy0tpt] mmc0 timer heartbeat audio-mute audio-micmute
rfkill1 hci0-power rfkill8
pavel@amd:~/cip$

Now problem is that list grew long over time... and it is too late to
change the API now (and alternatives seem worse than present
solution).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyd2KAACgkQMOfwapXb+vJFBACfQEaQSH2y/qtJmyCTc7/tGYtT
QNMAoKUskK51dXQT4OJUZNBiHjfwecuY
=Echn
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
