Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBCBC388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1372190F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfI0Q7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:59:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42145 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0Q7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:59:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E7E01804F6; Fri, 27 Sep 2019 18:59:26 +0200 (CEST)
Date:   Fri, 27 Sep 2019 18:59:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-leds@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 1/1] leds: remove PAGE_SIZE limit of
 /sys/class/leds/<led>/trigger
Message-ID: <20190927165940.GA25928@amd>
References: <1568387004-3802-1-git-send-email-akinobu.mita@gmail.com>
 <1568387004-3802-2-git-send-email-akinobu.mita@gmail.com>
 <20190927063547.GA1786569@kroah.com>
 <CAC5umyjdM1+4nPg_6UaCjcpikESamdA_ZpmP4Xfjx7_-1f=+0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <CAC5umyjdM1+4nPg_6UaCjcpikESamdA_ZpmP4Xfjx7_-1f=+0A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >       down_read(&triggers_list_lock);
> > >       down_read(&led_cdev->trigger_lock);
> > >
> > > -     if (!led_cdev->trigger)
> > > -             len +=3D scnprintf(buf+len, PAGE_SIZE - len, "[none] ");
> > > +     len =3D led_trigger_format(NULL, 0, true, led_cdev);
> > > +     data =3D kvmalloc(len + 1, GFP_KERNEL);
> >
> > Why kvmalloc() and not just kmalloc()?  How big is this buffer you are
> > expecting to have here?
>=20
> The ledtrig-cpu supports upto 9999 cpus.  If all these cpus were availabl=
e,
> the buffer size would be 78,890 bytes.
> (for i in `seq 0 9999`;do echo -n " cpu$i"; done | wc -c)
>=20
> The intention of this kvmalloc() allocation is to avoid costly allocation
> if possible.

Sounds good.

> > > -             else
> > > -                     len +=3D scnprintf(buf+len, PAGE_SIZE - len, "%=
s ",
> > > -                                      trig->name);
> > > -     }
> > >       up_read(&led_cdev->trigger_lock);
> > >       up_read(&triggers_list_lock);
> >
> > Two locks?  Why not 3?  5?  How about just 1?  :)
>=20
> I don't touch these locks in this patch :)

Nor should you :-).

> > Just return -ENOMEM above if !data, which makes this much simpler.
>=20
> We are holding the two locks, so we need to release them before return.
> Which one do you prefer?
>=20
>         ...
>         data =3D kvmalloc(len + 1, GFP_KERNEL);
>         if (data)
>                 len =3D led_trigger_format(data, len + 1, false, led_cdev=
);
>         else
>                 len =3D -ENOMEM;
>=20
>         up_read(&led_cdev->trigger_lock);
>         up_read(&triggers_list_lock);
>=20
>         if (len < 0)
>                 return len;
>=20
> vs.
>=20
>         ...
>         data =3D kvmalloc(len + 1, GFP_KERNEL);
>         if (!data) {
>                 up_read(&led_cdev->trigger_lock);
>                 up_read(&triggers_list_lock);
>                 return -ENOMEM;
>         }
>         len =3D led_trigger_format(data, len + 1, false, led_cdev);
>=20
>         up_read(&led_cdev->trigger_lock);
>         up_read(&triggers_list_lock);

Second one is better. Using goto to jump to error path doing cleanups
is also acceptable.=20

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2OP/wACgkQMOfwapXb+vIE7ACfZhiMja1kNbemJQ6IkRMMZl3U
y8UAnjNyoJVFR2DhWvqFadYDZA93uGyf
=d/TE
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
