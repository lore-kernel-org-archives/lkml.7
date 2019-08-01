Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8668C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE30E20665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BZlKvGge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfHAFve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:51:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAFve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:51:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zfYZ6r8Wz9sMr;
        Thu,  1 Aug 2019 15:51:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564638691;
        bh=/62k792BfxFERGOmjoiYc7ClHGXD9/CJUmCUrtuFKLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZlKvGge7miwFMRP7xN0Ct+hIuT97ZrJJ+Haxw2NTVNq99G0bxa+Z8JcNBdYJy92m
         MyCMtRIDIN1+giKCxkn9WMNYkcdn2xKhcJjqXqIlUKlYh0ij4XAPRB73/FTqOBYQf0
         Vf5qRXhqrKTi9l9Zne3XfMUqYZbZm4PsbfoliIic7DHUof8WyizE1ix6zoB8Iu8yPt
         V9b3d3miMhUhboY6J/y3nLg2FA+xrFxIDduze02Sn85BsVCzVa664F3KAcGFsg8iaw
         p2KtO1chCyRrBoDNBoOHOOAmDbC4ON1fdnz+DRPl6K5DwMqt8I/e5IkBm6PLZC8VNz
         gPPTFwGh7xxRg==
Date:   Thu, 1 Aug 2019 15:51:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190801155130.29a07b1b@canb.auug.org.au>
In-Reply-To: <1564554484.28000.3.camel@mtkswgap22>
References: <20190731161151.26ef081e@canb.auug.org.au>
        <1564554484.28000.3.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cn_2R/.2_9jSH7EOBRcRI.J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cn_2R/.2_9jSH7EOBRcRI.J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miles,

On Wed, 31 Jul 2019 14:28:04 +0800 Miles Chen <miles.chen@mediatek.com> wro=
te:
>
> On Wed, 2019-07-31 at 16:11 +1000, Stephen Rothwell wrote:
> >=20
> > After merging the akpm-current tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> >=20
> > mm/memcontrol.c: In function 'invalidate_reclaim_iterators':
> > mm/memcontrol.c:1160:11: warning: suggest parentheses around assignment=
 used as truth value [-Wparentheses]
> >   } while (memcg =3D parent_mem_cgroup(memcg));
> >            ^~~~~
> >  =20
>=20
> Hi Stephen,
>=20
> Thanks for the telling me this. Sorry for the build warning.=20
> Should I send patch v5 to the mailing list to fix this?=20

You might as well (cc'ing Andrew, of course).

I would suggest finishing that loop like this:

		memcg =3D parent_mem_cgroup(memcg);
	} while (memcg);

rather than adding a set of parentheses.

--=20
Cheers,
Stephen Rothwell

--Sig_/cn_2R/.2_9jSH7EOBRcRI.J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CfeIACgkQAVBC80lX
0GwQowf7BtHd6N/Ql7+u/YSYkputgNQzecVwhI/kvO5/6qYvqqJNRd2sRhcOs6kG
wyZMwf1WJAd8wglrKjvdo0Ib1DXGSUwbYDAIX7QAWCjMetfCnGtGY3bf806rOOEc
Q0ZSgMiuIqYd3JZ1aSCy8kQgQyDWO4BugZwxevrxkhKMhPeJTlL6FeODBOBqvk3s
A0DcoZ9cKZr1gHfzY0qvy2X90hG+3y871kg7sVU0pRF45w8fjIjhNS9F3u9/li1p
VxAEv+xl55NJFvMbbwqNCbjhoD5KjqnhLU7vGQMWh7vBs/AamfUTyQ1dAWCHgt00
G4laLXZuprNoceHSSicDZIX0ncB2Ig==
=HXp9
-----END PGP SIGNATURE-----

--Sig_/cn_2R/.2_9jSH7EOBRcRI.J--
