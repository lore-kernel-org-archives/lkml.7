Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C757C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08213218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbfIIIdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:33:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43954 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfIIIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:33:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6F7C680868; Mon,  9 Sep 2019 10:33:18 +0200 (CEST)
Date:   Mon, 9 Sep 2019 10:33:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: sysrq: don't recommend 'S' 'U' before 'B'
Message-ID: <20190909083331.GA27626@amd>
References: <20190903160840.56652-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20190903160840.56652-1-kilobyte@angband.pl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-09-03 18:08:40, Adam Borowski wrote:
> This advice is obsolete and slightly harmful for filesystems from this
> millenium: any modern filesystem can handle unexpected crashes without
> requiring fsck -- and on the other hand, trying to write to the disk when
> the kernel is in a bad state risks introducing corruption.

Actually no, I don't think it is good idea.

sync is still useful these days -- you want the current data to be
written to disk; true, you'll not have to do fsck, but you may lose
your current data.

Best regards,
									Pavel

> For ext2, any unsafe shutdown meant widespread breakage, but it's no long=
er
> a reasonable filesystem for any non-special use.
>=20
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  Documentation/admin-guide/sysrq.rst | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-gu=
ide/sysrq.rst
> index 7b9035c01a2e..72b2cfb066f4 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -171,22 +171,20 @@ It seems others find it useful as (System Attention=
 Key) which is
>  useful when you want to exit a program that will not let you switch cons=
oles.
>  (For example, X or a svgalib program.)
> =20
> -``reboot(b)`` is good when you're unable to shut down. But you should al=
so
> -``sync(s)`` and ``umount(u)`` first.
> +``reboot(b)`` is good when you're unable to shut down, it is an equivale=
nt
> +of pressing the "reset" button.
> =20
>  ``crash(c)`` can be used to manually trigger a crashdump when the system=
 is hung.
>  Note that this just triggers a crash if there is no dump mechanism avail=
able.
> =20
> -``sync(s)`` is great when your system is locked up, it allows you to syn=
c your
> -disks and will certainly lessen the chance of data loss and fscking. Note
> -that the sync hasn't taken place until you see the "OK" and "Done" appear
> -on the screen. (If the kernel is really in strife, you may not ever get =
the
> -OK or Done message...)
> +``sync(s)`` is handy before yanking removable medium or after using a re=
scue
> +shell that provides no graceful shutdown -- it will ensure your data is
> +safely written to the disk. Note that the sync hasn't taken place until =
you see
> +the "OK" and "Done" appear on the screen.
> =20
> -``umount(u)`` is basically useful in the same ways as ``sync(s)``. I gen=
erally
> -``sync(s)``, ``umount(u)``, then ``reboot(b)`` when my system locks. It'=
s saved
> -me many a fsck. Again, the unmount (remount read-only) hasn't taken plac=
e until
> -you see the "OK" and "Done" message appear on the screen.
> +``umount(u)`` can be used to mark filesystems as properly unmounted. Fro=
m the
> +running system's point of view, they will be remounted read-only. The re=
mount
> +isn't complete until you see the "OK" and "Done" message appear on the s=
creen.
> =20
>  The loglevels ``0``-``9`` are useful when your console is being flooded =
with
>  kernel messages you do not want to see. Selecting ``0`` will prevent all=
 but

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl12DlsACgkQMOfwapXb+vKfWQCfSk//T5/EfUVNB7DboM8KBRSe
gTYAnArx0zEgZSiQZ3Tu+m8ljpitMu0p
=bG3h
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
