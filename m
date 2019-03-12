Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4B6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCLJh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:37:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57027 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfCLJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:37:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C700380167; Tue, 12 Mar 2019 10:37:47 +0100 (CET)
Date:   Tue, 12 Mar 2019 10:37:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] elf: don't be afraid of overflow
Message-ID: <20190312093754.GB28905@amd>
References: <20190204202715.GA27482@avx2>
 <20190311110423.GC14118@amd>
 <20190311171006.GA2141@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20190311171006.GA2141@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-11 20:10:06, Alexey Dobriyan wrote:
> On Mon, Mar 11, 2019 at 12:04:23PM +0100, Pavel Machek wrote:
> > On Mon 2019-02-04 23:27:15, Alexey Dobriyan wrote:
> > > Number of ELF program headers is 16-bit by spec, so total size
> > > comfortably fits into "unsigned int".
> >=20
> > If it can't overflow, gcc should know too, and optimize checks
> > out... right?
>=20
> Turns out it doesn't.

Tells me you are doing something wrong.

> > > @@ -429,13 +430,9 @@ static struct elf_phdr *load_elf_phdrs(struct el=
fhdr *elf_ex,
> > >  		goto out;
> > > =20
> > >  	/* Sanity check the number of program headers... */
> > > -	if (elf_ex->e_phnum < 1 ||
> > > -		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
> > > -		goto out;
> > > -
> > >  	/* ...and their total size. */
> >=20
> > This is just wrong. You removed check for zero, and I'm pretty sure
> > sizeof() is not 1, so this one can trigger, too.
>=20
> No. ->e_phnum is 65535 max.

That does not invalidate my argument.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyHffIACgkQMOfwapXb+vIDHwCeIsw7EdmZvLlQ/5w8vzCv27Fy
w/cAnjLhSltKflD/jpIUOwL1wqufvOxX
=REi1
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
