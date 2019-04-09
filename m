Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F017C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E0E20663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p8RXRYuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDIIJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:09:03 -0400
Received: from ozlabs.org ([203.11.71.1]:58753 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfDIIJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:09:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dg0n1krNz9sNk;
        Tue,  9 Apr 2019 18:08:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554797340;
        bh=3Nq4WF0VrT2jEDeO/gtW2yc5tdXu472w5pkscgUFTJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8RXRYuB67ikTR0NxGz1bJCbRP3y1WqnbYXZCYG8T/EPb2EYubbbcgdEdazPN0OfE
         labtPAgHP4CmAEE6A4Sc2W4sMnoog9uxUR9TSktyaKURly+9UaEC2wNbE5MBDF1Omr
         stsZAXf09kAKgEyQqaffq2yvwzWp1w63Qs1ws4wae1AvAwS1/OThgFjCfGrdPnmna4
         A5KYNKZExzISHUzUsrP2dY0SblTWk0h0xB8ue4Ij9O4mr9HnwBuIwnwQn9DJoJK/A+
         lW7/2aOI1ShK7VYMAVTe9EhCp2ogeVqAzZdYlciLBwRzKw3EAIWbWCCuRrjHAGwp0Q
         /KjKSgDIL8l6w==
Date:   Tue, 9 Apr 2019 18:08:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190409180855.6a33e4e9@canb.auug.org.au>
In-Reply-To: <20190409072218.nepac7a4pngacweh@sirius.home.kraxel.org>
References: <20190409160849.391d3efa@canb.auug.org.au>
        <20190409072218.nepac7a4pngacweh@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/z3HVKEe3u0hM5_Y3vXgAWZB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z3HVKEe3u0hM5_Y3vXgAWZB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gerd,

On Tue, 9 Apr 2019 09:22:18 +0200 Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 04:08:49PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the drm-misc tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >=20
> > drivers/gpu/drm/cirrus/cirrus.c: In function 'cirrus_fb_blit_rect':
> > drivers/gpu/drm/cirrus/cirrus.c:310:25: error: implicit declaration of =
function '__io_virt'; did you mean '__do_irq'? [-Werror=3Dimplicit-function=
-declaration]
> >    drm_fb_memcpy_dstclip(__io_virt(cirrus->vram),
> >                          ^~~~~~~~~
> >                          __do_irq =20
>=20
> Probably just a missing arm/io.h include.

I assume you meant asm/io.h?

--=20
Cheers,
Stephen Rothwell

--Sig_/z3HVKEe3u0hM5_Y3vXgAWZB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlysUxcACgkQAVBC80lX
0Gzskgf/YCKaKjcJzoDMfYeruWGquXXzPKTwqS4mgnOxiAxQKG9YDbzTf4micFd2
PaUeRMwXd7MGVejYsfPUY0GAobdddYI5k2toUkpfzaAJKpcqQXWPxFVRcvY+vt+4
Qdhdad4ot2cm102kEkvUNZo8y/4cvUat7K3uCHhORYkhrOK1AfLAyl6cvs/ujXmN
pq5LqSJTTg+0QiS1QFygD5a0l2+e5frWVIpFSvzV9A1nZKlDeUSVCC4hN+59mB4T
Kixky5dbUpH7/PKtmNHmbFW0k94A4IegVxVOkpKQRjgMQj72CylRkCfs/V2JVZTn
zLHYloGeVYrsMP4JUKYkF3pPhSpdhg==
=cXB5
-----END PGP SIGNATURE-----

--Sig_/z3HVKEe3u0hM5_Y3vXgAWZB--
