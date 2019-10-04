Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B0BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752FD2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfJDIgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:36:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731200AbfJDIgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:36:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFBEAAC0C;
        Fri,  4 Oct 2019 08:36:09 +0000 (UTC)
Message-ID: <2303772588b9f98f186abf967efb2af58bcb8349.camel@suse.de>
Subject: Re: [PATCH] ARM: dt: check MPIDR on MP devices built without SMP
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "kernelci.org bot" <bot@kernelci.org>, wahrenst@gmx.net
Date:   Fri, 04 Oct 2019 10:36:08 +0200
In-Reply-To: <0be9b704-4cc6-7b23-4435-256372e90ffd@gmail.com>
References: <20191002114508.1089-1-nsaenzjulienne@suse.de>
         <17976e82-04da-d22d-5779-f50db63f98a2@gmail.com>
         <2af0a5ad604064d8fcf9febce72f0c23f1a1a1db.camel@suse.de>
         <0be9b704-4cc6-7b23-4435-256372e90ffd@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ur3xg1tVzwpJPXsH9G28"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ur3xg1tVzwpJPXsH9G28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 16:47 -0700, Florian Fainelli wrote:
> On 10/3/19 12:39 PM, Nicolas Saenz Julienne wrote:
> > On Thu, 2019-10-03 at 11:08 -0700, Florian Fainelli wrote:
> > > On 10/2/19 4:45 AM, Nicolas Saenz Julienne wrote:
> > > > Currently, in arm_dt_init_cpu_maps(), the hwid of the boot CPU is r=
ead
> > > > from MPIDR on SMP devices and set to 0 for non SMP. This value is t=
hen
> > > > matched with the DT cpu nodes' reg property in order to find the bo=
ot
> > > > CPU in DT.
> > >=20
> > > The code you change is about the "mpidr" variable, yet in your commit
> > > message you refer to "hwid", that is a tad confusing for the reader.
> >=20
> > Sorry, it's indeed pretty confusing. I'll send a new version with a fix=
ed
> > description if there is no major push back.
> >=20
> > > > On MP devices build without SMP the cpu DT node contains the expect=
ed
> > > > MPIDR yet the hwid is set to 0. With this the function fails to mat=
ch
> > > > the cpus and uses the default CPU logical map. Making it impossible=
 to
> > > > get the CPU's DT node further down the line. This causes issues wit=
h
> > > > cpufreq-dt, as it triggers warnings when not finding a suitable DT =
node
> > > > on CPU0.
> > > >=20
> > > > Change the way we choose whether to get MPIDR or not. Instead of
> > > > depending on SMP check the number of CPUs defined in DT. Anything >=
 1
> > > > means MPIDR will be available.
> > >=20
> > > Except if someone accidentally wrote their Device Tree such as to hav=
e >
> > > 1 CPU nodes, yet the CPU is not MP capable and reading the MPIDR
> > > register does return the expected value, but that is wrong anyway.
> >=20
> > An UP device will most likely not have a MPIDR. That said I'm not sure =
this
> > is
> > always true. As per ARM1176JZ's TRM[1], the RPi1 CPU, if one was to get=
 the
> > MPIDR it would raise an undefined exception.
> >=20
> > The way I see it's an acceptable outcome as the DT is clearly wrong.
>=20
> It is, although you probably want to use of_get_available_child_count()
> instead of of_get_child_count() since we could imagine that a boot
> loader or some other boot program mangling the DT could intentionally
> put a 'status =3D "disabled"' property on the non-boot CPU node for
> whatever reason.

Good point, I'll fix it on v2.


--=-Ur3xg1tVzwpJPXsH9G28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2XBHgACgkQlfZmHno8
x/5YdQf9GN1rZ3KZuHx01XDB6XKFKmAytIseTr2ogtxDi05xhH5AnkT84tZ62fZb
yonXNXZPLUgCzaDuSQBorWu6gl7SnkLyAhNX9bF3kG9b0uQUOXAyBxt8ETXqQIq5
33l7g0QrY/BoR7sKP/ivdaRNmEtM6QpbCNubhlmB4We+06G1vzYZOGwE7kcLCGZp
HQokAmOqZ1J91s1y2AXVtTRgClhrqBa08SD0PqgNo0B9FW2m8c26gT8WI5K1+BuV
TFelueBrbPKz9RTUZw+VITZGqGAoG3iilnztkOwoXbpb/No123kGEbli50ajcEUQ
AoBRLomyXsPbW0AeVIzbl5ri+BLvqA==
=q3CM
-----END PGP SIGNATURE-----

--=-Ur3xg1tVzwpJPXsH9G28--

