Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32FDC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62F12173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfIBHjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:39:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52047 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbfIBHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:39:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 25931816D6; Mon,  2 Sep 2019 09:39:18 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:39:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH] Parallel microcode update in Linux
Message-ID: <20190902073931.GA15850@amd>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <20190901172547.GD1047@bug>
 <5BACA033-7613-49A9-801C-9F75F4306909@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <5BACA033-7613-49A9-801C-9F75F4306909@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> +       u64 p0, p1;
> >>        int ret;
> >>=20
> >>        atomic_set(&late_cpus_in,  0);
> >>        atomic_set(&late_cpus_out, 0);
> >>=20
> >> +       p0 =3D rdtsc_ordered();
> >> +
> >>        ret =3D stop_machine_cpuslocked(__reload_late, NULL, cpu_online=
_mask);
> >> +
> >> +       p1 =3D rdtsc_ordered();
> >> +
> >>        if (ret > 0)
> >>                microcode_check();
> >>=20
> >>        pr_info("Reload completed, microcode revision: 0x%x\n", boot_cp=
u_data.microcode);
> >>=20
> >> +       pr_info("p0: %lld, p1: %lld, diff: %lld\n", p0, p1, p1 - p0);
> >> +
> >>        return ret;
> >> }
> >>=20
> >> We have used a machine with a broken microcode in BIOS and no microcod=
e in
> >> initramfs (to bypass early loading).
> >>=20
> >> Here are the results for parallel loading (we made two measurements):
> >=20
> >> [   18.197760] microcode: updated to revision 0x200005e, date =3D 2019=
-04-02
> >> [   18.201225] x86/CPU: CPU features have changed after loading microc=
ode, but might not take effect.
> >> [   18.201230] microcode: Reload completed, microcode revision: 0x2000=
05e
> >> [   18.201232] microcode: p0: 118138123843052, p1: 118138153732656, di=
ff: 29889604
> >=20
> >> Here are the results of serial loading:
> >>=20
> >> [   17.542518] microcode: updated to revision 0x200005e, date =3D 2019=
-04-02
> >> [   17.898365] x86/CPU: CPU features have changed after loading microc=
ode, but might not take effect.
> >> [   17.898370] microcode: Reload completed, microcode revision: 0x2000=
05e
> >> [   17.898372] microcode: p0: 149220216047388, p1: 149221058945422, di=
ff: 842898034
> >>=20
> >> One can see that the difference is an order magnitude.
> >=20
> > Well, that's impressive, but it seems to finish 300 msec later? Where d=
oes that difference
> > come from / how much real time do you gain by this?
>=20
> The difference comes from the large amount of cores/threads the machine h=
as: 72 in this case, but there are machines with more. As the commit messag=
e says initially the microcode was applied serially one by one and now the =
microcode is updated in parallel on all cores.
>=20
> 300ms seems nothing but it is enough to cause disruption in some critical=
 services (e.g. storage) - 300ms in which we do not execute anything on CPU=
s. Also this 300ms is increasing when the machine is fully loaded with gues=
ts.
>=20

Yes, but if you look at the dmesgs I quoted, paralel microcode update
actually finished 300msec _later_.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1sxzMACgkQMOfwapXb+vInxgCfYqV8iQD034oFJ7fn1Eom+E4C
4LwAn0bvqEXNfSVvV6tJGn6npo+HELO7
=9hh5
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
