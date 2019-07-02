Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E55C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404FB20659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FozwyicY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGBIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:49:26 -0400
Received: from ozlabs.org ([203.11.71.1]:56957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBIt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:49:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45dHwg3379z9s00;
        Tue,  2 Jul 2019 18:49:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562057363;
        bh=gTRgi/qq43v5o8pfIOGzntWmYy82jfwfGWMRemOEIXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FozwyicYdTlc7/LkB9Mf+e8SdGYTkKuOqMw6IRbAuq7F73TUDg0tOKi1hR+eOdU3U
         BfwNAmhT85/wwu9yNYPi4XkS+IvJhfiAHmakMpKrNr+DDSoz+gebRawigpSBohSYv0
         8XpbUiX6s80cQaXFqxrrgFvOlcEg4vUSLsAxC3NaajaV8FVpG2pPJ9yEYjxavxaSmG
         MLFTHygDrlJQezoOUk+SsYNIVXGkNA+xKKY5BhNE/6uJutZhRqqHJjVRNEWqfr5V3M
         2sPO3+82zy5+HLjOQ2/zWiFMDVkMauacKo3Hns+DqAaHYh6hcqKj4A3jTNY0XU9ta4
         gHddDFfjns6aQ==
Date:   Tue, 2 Jul 2019 18:49:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <gustavo@embeddedor.com>, <keescook@chromium.org>
Subject: Re: linux-next: build warning after merge of the mfd tree
Message-ID: <20190702184916.5f0f9e99@canb.auug.org.au>
In-Reply-To: <1b5aa183-6e33-ee15-4c65-5b4cdf7655af@ti.com>
References: <20190627151140.232a87e2@canb.auug.org.au>
        <1b5aa183-6e33-ee15-4c65-5b4cdf7655af@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cIaeb/Ckqi8gBoR3+=duWq6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cIaeb/Ckqi8gBoR3+=duWq6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 27 Jun 2019 11:29:18 +0530 Keerthy <j-keerthy@ti.com> wrote:
>
> On 27/06/19 10:41 AM, Stephen Rothwell wrote:
> > Hi Lee,
> >=20
> > After merging the mfd tree, today's linux-next build (x86_64 allmodconf=
ig)
> > produced this warning:
> >=20
> > drivers/regulator/lp87565-regulator.c: In function 'lp87565_regulator_p=
robe':
> > drivers/regulator/lp87565-regulator.c:182:11: warning: this statement m=
ay fall through [-Wimplicit-fallthrough=3D]
> >     max_idx =3D LP87565_BUCK_3210; =20
>=20
> Missed adding a break here. Can i send a patch on top of linux-next?
>=20
> >     ~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > drivers/regulator/lp87565-regulator.c:183:2: note: here
> >    default:
> >    ^~~~~~~
> >=20
> > Introduced by commit
> >=20
> >    7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator sup=
port")
> >=20
> > I get these warnings because I am building with -Wimplicit-fallthrough
> > in attempt to catch new additions early.  The gcc warning can be turned
> > off by adding a /* fall through */ comment at the point the fall through
> > happens (assuming that the fall through is intentional).
> >  =20

I am still seeing this warning ...

--=20
Cheers,
Stephen Rothwell

--Sig_/cIaeb/Ckqi8gBoR3+=duWq6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0bGowACgkQAVBC80lX
0Gy5mwf/TDyd34fqPsnzR8Tb74QB1mW9HsasEM6CiT8XLxp+zm3/lnNzmvk62ao4
fLczVa3ctQI4lZ96Nf0py3QAFu3kY6kCY7/NPfbwAnm22/iM2yrCt3xgMgLSIUIe
r13rSfGHVFawnHhewA/yk9KBilGGJQNMwyH55xsJFR3WsVnKLUbdXcJ3RFjYxdxj
Tas3NJ8P6tlYXyIpzBzaE+PLSm9oi5zITCrW/y+6CkaDpPpx+YxFHgR1DOSUUnpX
t4DoQoGNFgtyuug58CZl5aYy+Luqadh/TRpEUXTRXT/xCBxR2/pCBtJUXMEwQ8SV
ZZ+tO0Cp7/QTfsymt2KdCgzTRgbOGg==
=iLBb
-----END PGP SIGNATURE-----

--Sig_/cIaeb/Ckqi8gBoR3+=duWq6--
