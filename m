Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50360C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B51204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfCKLE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:04:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57010 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKLE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:04:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1E4EF807EB; Mon, 11 Mar 2019 12:04:17 +0100 (CET)
Date:   Mon, 11 Mar 2019 12:04:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] elf: don't be afraid of overflow
Message-ID: <20190311110423.GC14118@amd>
References: <20190204202715.GA27482@avx2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <20190204202715.GA27482@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-02-04 23:27:15, Alexey Dobriyan wrote:
> Number of ELF program headers is 16-bit by spec, so total size
> comfortably fits into "unsigned int".

If it can't overflow, gcc should know too, and optimize checks
out... right?

> @@ -429,13 +430,9 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr=
 *elf_ex,
>  		goto out;
> =20
>  	/* Sanity check the number of program headers... */
> -	if (elf_ex->e_phnum < 1 ||
> -		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
> -		goto out;
> -
>  	/* ...and their total size. */

This is just wrong. You removed check for zero, and I'm pretty sure
sizeof() is not 1, so this one can trigger, too.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlyGQLcACgkQMOfwapXb+vI3mwCgw9lSJuIZfUlaqX8/r0ddjAJ5
YQEAli6e4zYRH89oPhuuPiDn3HIcEjs=
=ZGfu
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
