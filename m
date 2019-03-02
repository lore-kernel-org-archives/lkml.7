Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9D3C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB59F20815
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Gva++6U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCBCaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:30:13 -0500
Received: from ozlabs.org ([203.11.71.1]:53113 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfCBCaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:30:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44B9HQ5x12z9s70;
        Sat,  2 Mar 2019 13:30:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551493811;
        bh=viONznM0aNKcavWKQqbIpMIYaHZ31PzHLY8helsa0fY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gva++6U1lPaMt+EJOFEIuLSHEwJaquvkU+0jzhBDi8x2BPGk0pZ7AoWFxm9td503V
         b4alRDIL8SLSlBkZJDVSKMuWppSVXhdMrZOlCdnKhLqORUCybgNpbcQPuTh1/nAz5X
         rV2J6Lj7ge0eQqGoeAn+5UNMH9TIPNrcu3+z4LGswTWtCrE4FKuTaqV9ZGyNl4hwpl
         +g74gmvvnCPkqWmmgF24LCSX8F6ek+S5jTQXff+jHdOraBAZineNInjdPUJYvvFwQW
         3FDO0XJK5tRUBCcpPupdcctr+P8Pq/GGmKEU/2Ewzzo5Bgox2S+9UfrXqn9MprhIzQ
         i4o/UWQc9301Q==
Date:   Sat, 2 Mar 2019 13:30:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, natechancellor@gmail.com, niravd@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: clean up headers
Message-ID: <20190302133010.135cd3ad@canb.auug.org.au>
In-Reply-To: <20190302132750.0916adc4@canb.auug.org.au>
References: <20190302000715.130116-1-ndesaulniers@google.com>
        <20190302132750.0916adc4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//rcWLvHZTsIVY=DLbp1W8Fk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//rcWLvHZTsIVY=DLbp1W8Fk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Sat, 2 Mar 2019 13:27:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Fri,  1 Mar 2019 16:07:14 -0800 Nick Desaulniers <ndesaulniers@google.=
com> wrote:
> >
> > It turns out that arch/x86/boot/string.c doesn't actually need
> > linux/kernel.h, simply linux/limits.h and linux/compiler.h. Include the=
m,
> > and sort the headers alphabetically. =20
>=20
> One small nit: please do not do the sort in the same commit as the bug
> fix.  It just complicates the review and has (a remote) possibility of
> adding a new problem.  (Not a big issue here, but in general cleanups
> and bug fixes should be separate.)

Also it is *very* common for headers to be included in the order:
linux/ asm/ and then local.

--=20
Cheers,
Stephen Rothwell

--Sig_//rcWLvHZTsIVY=DLbp1W8Fk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx56rIACgkQAVBC80lX
0Gyq3Af/fhjAdEW2O7W+6Y5DppOtwQcN8PH2G/RK067OmD4JSN5588RkOOUc6Sj3
kD23JR+DpjtAE2hhk272jtDkPWEmIimhvQrsdwC8pU2dERoRkq7g7ci2wGxYvmx2
gwCJ3EGKsyGOMZIepWRlUdnjtq5d3ECJxfo3iJUb4V8Ig2okF9St034GGPg7Psge
mIUPK4lh0Cvp6YzzL+ua8LM/c8KjDXXS8v/xv8Gh3leQducSzegFwKivKWy9pVP+
LH27hmFpaDmDP461LA58KRFlhszE3Tw8nF1cDNfJOhHNZdRxi3EaSkV7Lh9wfNPV
1eMdzAVZIg4YdS4T4mLngpfbwqdL7A==
=yKYe
-----END PGP SIGNATURE-----

--Sig_//rcWLvHZTsIVY=DLbp1W8Fk--
