Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F78EC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B1C208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EStluEZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfFXEP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:15:59 -0400
Received: from ozlabs.org ([203.11.71.1]:46163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFXEP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:15:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XGDq0h5rz9s3l;
        Mon, 24 Jun 2019 14:15:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561349755;
        bh=9riMMsbTfWEXQ3lscKQPqLcoMaG3jMzOSISEUDt+ogw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EStluEZ6UYgr0Dv05TMk1GsyB3Sah4JQ5RKyjvx+lIueiqPVzw8XhfUt28AAEgCTF
         QrFYIOQp5hbTz3ZzL9O3/6Cz9j8trzYvvCtpFs8+coto0Asmu/o8QN3vr8tx5ekVGF
         giVBwxrCQJerzzLns8TMVLIFn+XHpMONHNHYgRarXUMrUo7cMuwaDDc4U68cDSKcGc
         GOmPuAHgIqyDjVtZUPtVtOxgJRr+zTiJGPLX4+nJqWq6JDWP5QrApSOCimQY3UYnc2
         sRPr3tuTlCSk3jNSDMoWin4Ci2uJEFH5+FF6sD3rTV71Z1U1HlydW1HjhpCljb4a5u
         rpbO0Baqzk/PA==
Date:   Mon, 24 Jun 2019 14:15:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: linux-next: build failure after merge of the fbdev tree
Message-ID: <20190624141554.7aafe108@canb.auug.org.au>
In-Reply-To: <20190624114538.3531b28d@canb.auug.org.au>
References: <20190620114126.2f13ab9c@canb.auug.org.au>
        <20190624114538.3531b28d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mk3Ou2z25S+CbuKHtZ9n4iV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mk3Ou2z25S+CbuKHtZ9n4iV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 24 Jun 2019 11:45:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 20 Jun 2019 11:41:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the fbdev tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > x86_64-linux-gnu-ld: drivers/gpu/vga/vga_switcheroo.o: in function `vga=
_switchto_stage2':
> > vga_switcheroo.c:(.text+0x997): undefined reference to `fbcon_remap_all'
> >=20
> > Caused by commit
> >=20
> >   1cd51b5d200d ("vgaswitcheroo: call fbcon_remap_all directly")
> >=20
> > I have used the version of the fbdev tree from next-20190619 for today.=
 =20
>=20
> I am still getting this failure.

This has now been merged into the drm-intel and drm trees :-( .
Something has gone wrong as Daniel was cc'd on the original build
failure report.

I have reverted commits

  1cd51b5d200d ("vgaswitcheroo: call fbcon_remap_all directly")
  fe2d70d6f6ff ("fbcon: Call con2fb_map functions directly")

for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/mk3Ou2z25S+CbuKHtZ9n4iV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QTnoACgkQAVBC80lX
0Gxubgf9GSTtt9btn00u94XXVVz1g0pGwGhvhNCUWJfaafnmo8vOZOVyby1wG/Qe
oLSIorvCYPMTaKyKuYOXx7CXaSq0//+rQCcRYal1qd/A+zBGZzYZsG2flIxNnoBm
fJDxhZt2U8uY5N6XKokKtIf/39s5Xumchn6LHGHT8Yepk/yLk5VqJc04rMeWyjJg
UihzpQG7CHna7sKtYlZRpCsUbOkLNTbkvcuNZbNx2EWmAVqsenbmaZz8Dcg/S3nS
7ooa3d7/g4peTZEs+RdN4bnH2m12vvzX7pfimD2B7Rk1gIe2qbcVnQw9G+D1/eYx
mjintqUpgjoPJR4FPPFyGODUgF0hyQ==
=DhjA
-----END PGP SIGNATURE-----

--Sig_/mk3Ou2z25S+CbuKHtZ9n4iV--
