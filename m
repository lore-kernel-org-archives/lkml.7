Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E12C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A14C20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OeGdVBad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437482AbfFLNPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:15:45 -0400
Received: from ozlabs.org ([203.11.71.1]:40037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbfFLNPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:15:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45P6n72c4Fz9s7h;
        Wed, 12 Jun 2019 23:15:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560345341;
        bh=m3ulouF3seJudKzCN91mGBHIDhKeg6NrhQEyoc7Uu6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OeGdVBadpLkeHc6WDmaemrvgCxAtc8E/v2k+b8BWyBH9NUqyDzHI2H3l+pIsSnxrV
         jSzbXue3OAgKS7uI/SuWV270Sz2k8QwhsFbgXsbDAan05XPwoaNoJuPqnRor72VEfA
         tgsRcCbWvDuc3GDY8DR7xNovwoeFNuAzV2KF2n1d6615QG9tSW8D3t4ej6N0l5Ahti
         JrNSZeoV5FjkT1dAIF2Gb4OwTE9lri4BFQzYYkhhUt4J7NPgN5oo4gayCwEvMxj+5A
         bmLtmz36ORVVfaZ3/8mo8jj5PXQ0NcIY5+NZU5Vq+/7K/wq7fyGDtVCtipUhh8ObjM
         4lUN0R7NP7KCA==
Date:   Wed, 12 Jun 2019 23:15:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612231535.253a8a20@canb.auug.org.au>
In-Reply-To: <20190612093229.7f14a1e2@coco.lan>
References: <20190611102528.44ad5783@canb.auug.org.au>
        <20190612081929.GA1687@kunai>
        <20190612080226.45d2115a@coco.lan>
        <20190612110904.qhuoxyljgoo76yjj@ninjato>
        <20190612084824.16671efa@coco.lan>
        <20190612120439.GB2805@kunai>
        <20190612093229.7f14a1e2@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D_X6Efm71FC9C3REMQXnZ/e"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D_X6Efm71FC9C3REMQXnZ/e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 12 Jun 2019 09:32:29 -0300 Mauro Carvalho Chehab <mchehab@infradead=
.org> wrote:
>
> Em Wed, 12 Jun 2019 14:04:39 +0200
> Wolfram Sang <wsa@the-dreams.de> escreveu:
>=20
> > > > OK, so that means I should send my pull request after yours in the =
next
> > > > merge window? To avoid the build breakage?   =20
> > >=20
> > > Either that or you can apply my patch on your tree before the
> > > patch that caused the breakage.=20
> > >=20
> > > Just let me know what works best for you.   =20
> >=20
> > Hmm, the offending patch is already in -next and I don't rebase my tree.
> > So, I guess it's the merge window dependency then.
> >  =20
> Ok, I'll merge it through my tree then.

It should go into the i2c tree (since that is where the *warning* was
introduced).  It is only a warning and there won't be many patches
between the patch that introduced the warning and this one that fixes
it.  This patch could then have a Fixes tag that makes sense i.e. it
will reference a previous commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/D_X6Efm71FC9C3REMQXnZ/e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0A+vcACgkQAVBC80lX
0GwkiQf+PSLLJ32HJwYk/tNmjjZMB7vvinDaqj/Xk9IS92cD0vviuO4RKMOQSvZ2
Lr7Bzlpr4gNX+rrvXfD9sdawTKV6G0/RFaWboCso1Y/nPiEmJymp9G1PAfQDHNMu
fF6SGhbQNM2F7rc+vuq35f7D6+YFMhZB0WlrrwZoqOGh8h8ph7t56dktt0rD0s6O
AKUwIpeM+jNIoSxtJgwRVEvVgQR4MYfzdyeyXHR49s8zyF6/LYjiDk1KVHA74reU
70USaIxD3qu6NA75JDig8sTe7kgasLiV+rP5PvxNW5aEadCz7+9YhOO78+J5kf6f
FhXdH43qRgg2mQOZ/UoDNx+b07++EQ==
=9yjZ
-----END PGP SIGNATURE-----

--Sig_/D_X6Efm71FC9C3REMQXnZ/e--
