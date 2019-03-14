Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E13FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE4320854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCNMQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:16:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44609 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCNMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:16:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 556AF80693; Thu, 14 Mar 2019 13:16:33 +0100 (CET)
Date:   Thu, 14 Mar 2019 13:16:39 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/4] leds: netdev trigger: use memcpy in device_name_store
Message-ID: <20190314121639.GB19072@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-2-linux@rasmusvillemoes.dk>
 <20190314101419.GA14455@amd>
 <9324dc3c-a9dd-e179-6fc5-17b2fdaab74b@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <9324dc3c-a9dd-e179-6fc5-17b2fdaab74b@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> If userspace doesn't end the input with a newline (which can easily
> >> happen if the write happens from a C program that does write(fd,
> >> iface, strlen(iface))), we may end up including garbage from a
> >> previous, longer value in the device_name. For example
> >>
> >> # cat device_name
> >>
> >> # printf 'eth12' > device_name
> >> # cat device_name
> >> eth12
> >> # printf 'eth3' > device_name
> >> # cat device_name
> >> eth32
> >>
> >> I highly doubt anybody is relying on this behaviour, so switch to
> >> simply copying the bytes (we've already checked that size is <
> >> IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
> >> still have to strip a trailing newline.
> >=20
> >   char device_name[IFNAMSIZ];
> >=20
> > Ok, good catch reporting the bug, but are you sure the fix is right?
> >=20
> > AFAICT the design is that device_name does _not_ have to be zero
> > terminated, and your fix incorrectly limits the size of device_name.
>=20
> Yes, I'm sure.
>=20
> /**
>  *      dev_valid_name - check if name is okay for network device
>  *      @name: name string
>  *
>  *      Network device names need to be valid file names to
>  *      to allow sysfs to work.  We also disallow any kind of
>  *      whitespace.
>  */
> bool dev_valid_name(const char *name)
> {
>         if (*name =3D=3D '\0')
>                 return false;
>         if (strnlen(name, IFNAMSIZ) =3D=3D IFNAMSIZ)
>                 return false;
>=20
> so no netdevice name has a string length > 15 (IOW, there must be a nul
> byte within the first 16 bytes of name). Also note all the places a
> net_device->name is printed with a simple %s, so they are definitely
> always 0-terminated.
>=20
> Moreover, I'm actually not limiting anything more than was already done;
> we already reject any input from userspace >=3D 16 bytes. I'm simply
> ensuring that we're never confused by leftover garbage.

Ok. Sorry for the noise.

> >> --- a/drivers/leds/trigger/ledtrig-netdev.c
> >> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> >> @@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *de=
v,
> >>  		trigger_data->net_dev =3D NULL;
> >>  	}
> >> =20
> >> -	strncpy(trigger_data->device_name, buf, size);
> >> +	memcpy(trigger_data->device_name, buf, size);
> >> +	trigger_data->device_name[size] =3D '\0';
> >=20
> > I'd do =3D 0 for consistency with code below.
>=20
> I'd rather the other way around :) but yeah, let's just be consistent.
> I'll fix in next version.

Or just use your version and fix both places :-). Your option, as long
as it is consistent.=20

> > I believe the strncpy() is right to use here, but code should be
> > modified so that zero-termination is not required.
>=20
> So, I believe the above should convince you that strncpy is wrong. Or
> rather, strncpy is really just a convoluted memcpy: the userspace input
> doesn't contain a nul among the size bytes [1], so the "copy all the
> bytes, but don't nul-terminate" semantics of strncpy kick in - which is
> often a security bug, but the code is such that the zero at
> device_name[15] (because it was originally kzalloc'ed) is never
> overwritten. So in theory, we could keep strncpy and just add the
> nul-termination, but the str* prefix is very misleading (which is
> probably why the bug happened in the first place).
>=20
> [1] And if it did, the "zero the rest of the output buffer" semantics
> kick in. That's functionally equivalent to my memcpy() + write one nul
> byte, since nothing after that first nul byte in device_name would ever
> be inspected.

Actually "zero the rest" semantics kind of makes sense here.

No, I'm sorry, I don't understand. How are you getting stale data
there?

> >> # printf 'eth12' > device_name
> >> # cat device_name
> >> eth12
> >> # printf 'eth3' > device_name
> >> # cat device_name
> >> eth32

strncpy() should zero the rest, and you should get "eth3"...?!

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyKRicACgkQMOfwapXb+vIjwgCfduXA/6kZKv1i59goSO1ZCrtc
y88AmwUj98ZvcR5MLZtu5DngzJqzluUB
=BlIj
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
