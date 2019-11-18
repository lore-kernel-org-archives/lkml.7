Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284D52192B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKRRqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:46:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:50804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfKRRp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9B64AF22;
        Mon, 18 Nov 2019 17:45:56 +0000 (UTC)
Message-ID: <061822b6ad80094a52d27f27f3e37594adb313c2.camel@suse.de>
Subject: Re: [PATCH v2] ARM: dt: check MPIDR on MP devices built without SMP
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        "kernelci.org bot" <bot@kernelci.org>, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Nov 2019 18:45:55 +0100
In-Reply-To: <20191118125540.GW25745@shell.armlinux.org.uk>
References: <20191004155232.17209-1-nsaenzjulienne@suse.de>
         <5abdcb0e0e1043a101f579ea65d07a1f6b91f896.camel@suse.de>
         <20191118125540.GW25745@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+YvWotUDyLir6gMkee5u"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+YvWotUDyLir6gMkee5u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russell, thanks for the review.

On Mon, 2019-11-18 at 12:55 +0000, Russell King - ARM Linux admin wrote:
> On Mon, Nov 18, 2019 at 12:49:04PM +0100, Nicolas Saenz Julienne wrote:
> > On Fri, 2019-10-04 at 17:52 +0200, Nicolas Saenz Julienne wrote:
> > > On SMP builds, in order to properly link CPU devices with their
> > > respective DT nodes we start by matching the boot CPU. This is achiev=
ed
> > > by comparing the 'reg' property on each of the CPU DT nodes with the
> > > MPIDR. The association is necessary as to validate the whole CPU logi=
cal
> > > map, which ultimately links CPU devices and their DT nodes.
>=20
> No, that is not the primary purpose of the CPU logical map.  The CPU=20
> logical map is there to map the CPU logical number to a hardware number,
> necessary for programming hardware.

Noted.

> > > On setups built without SMP, no MPIDR read is performed. The only thi=
ng
> > > expected is for the 'reg' property in the CPU DT node to contain the
> > > value 0x0.
> > >=20
> > > This causes problems on MP setups built without SMP. As their boot CP=
U
> > > DT node contains the relevant MPIDR as opposed to 0x0. No match is th=
en
> > > possible. This causes troubles further down the line as drivers are
> > > unable to get the CPU's DT node.
>=20
> So the DT is incorrect for the platform - it is not describing the
> hardware.  Why can't the DT be fixed?  Clearly, it would have never
> worked with the mainline kernel today.

Sorry but I don't see any incorrect DT here. From the ARM CPU bindings I ga=
ther
that (at least since ARMv7) every CPU node should contain its corresponding
MPIDR. It transpires that ARM's DT cpu map init code should take that into
account regardles of whether the kernel supports SMP, isn't it?

Regards,
Nicolas


--=-+YvWotUDyLir6gMkee5u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3S2NMACgkQlfZmHno8
x/4D7gf/XdwPq75qRoHvHJjo1VIzJp33WcYC4bhmll+p0iM/2O4t/b7f8jOyNWVG
YlxA+fal6q1N6nyrjbXydq76hDgZK8bxHy0nQWZhJKuQaTfB0YcoMniZV+sDjF/N
NC/MvPupcRLkTbRbnW8Af0f345b62bu3r6zL7DL/AbAyVptOD3+yCGnbI4d8hVcU
dolO9kU7i4aKrZ9aF/u/mQQbqt/rZpPL5cFNOA5F920ryW6sWLlEfqrigBxq8Oy3
JB5+ZZXHTqJ593gIecn4dy+iRpU8ttTN0gdHEdy0TnFbmlh5xF4GbXzjwhKHpm7x
7D+Qbqp96Qpf6ZsVySaavz/svIiLJg==
=fulJ
-----END PGP SIGNATURE-----

--=-+YvWotUDyLir6gMkee5u--

