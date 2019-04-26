Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA28C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60DA20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lFf0jaGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDZD4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:56:52 -0400
Received: from ozlabs.org ([203.11.71.1]:49811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDZD4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:56:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 44r0c12QKZz9s47; Fri, 26 Apr 2019 13:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1556251009;
        bh=FVNYHxmT33tZ0XNsFLm46OIVI9r1YxnWqMiWaU8p1Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFf0jaGWIQwswcoJZgzt0JSeFyHgRwSuSZF0PGhKjgLIEtFKfnvSr/bOSh0d5cTZh
         9Bf4tWrtd7o9ju4QlVAsV5+Kj2hALs+hJyu27gD2UTTKWt+MKEiduPfbsR+YFV0OeJ
         w3hhfCul5SBUjVuLVShFEBlNWr8RusUD7zmgzLls=
Date:   Fri, 26 Apr 2019 13:56:43 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Ellerman <michael@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: powerpc hugepage leak caused by 576ed913 "block: use
 bio_add_page in bio_iov_iter_get_pages"
Message-ID: <20190426035643.GB7378@umbus.fritz.box>
References: <20190423054131.GB31496@umbus.fritz.box>
 <20190425061958.GA7881@lst.de>
 <20190426010517.GA7378@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20190426010517.GA7378@umbus.fritz.box>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 11:05:17AM +1000, David Gibson wrote:
> On Thu, Apr 25, 2019 at 08:19:58AM +0200, Christoph Hellwig wrote:
> > Just curious:  What exact trees do you see this with?  This area
> > changed a lot with the multipage bvec support, and subsequent fixes.
>=20
> So, I tried it with 576ed913 itself and with 576ed913^ to verify that
> it didn't happen there.  The problem also occurred with Linus' tree as
> of when I started bisecting, which appears to have been 444fe991.
> Actually, come to that, here's the whole bisect log in case it's
> helpful:
>=20
> # git bisect log
> git bisect start
> # good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
> git bisect good bebc6082da0a9f5d47a1ea2edc099bf671058bd4
> # bad: [444fe991353987c1c9bc5ab1f903d01f1b4ad415] Merge tag 'riscv-for-li=
nus-5.1-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-=
linux
> git bisect bad 444fe991353987c1c9bc5ab1f903d01f1b4ad415
> # good: [399c4129eba6145924ab90363352b7bdcd554751] Merge tag 'pxa-for-4.1=
9-dma_slave_map' of https://github.com/rjarzmik/linux
> git bisect good 399c4129eba6145924ab90363352b7bdcd554751
> # bad: [73b6f96cbc0162787bcbdac5f538167084c8d605] Merge branch 'drm-fixes=
-4.20' of git://people.freedesktop.org/~agd5f/linux into drm-fixes
> git bisect bad 73b6f96cbc0162787bcbdac5f538167084c8d605
> # good: [85a585918fb4122ad26b6febaec5c3c90bf2535c] Merge tag 'loadpin-sec=
urity-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux i=
nto next-loadpin
> git bisect good 85a585918fb4122ad26b6febaec5c3c90bf2535c
> # bad: [3acbd2de6bc3af215c6ed7732dfc097d1e238503] Merge tag 'sound-4.20-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect bad 3acbd2de6bc3af215c6ed7732dfc097d1e238503
> # good: [8f18da47211554f1ef674fef627c05f23b75a8e0] Merge branch 'master' =
of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
> git bisect good 8f18da47211554f1ef674fef627c05f23b75a8e0
> # bad: [0d1b82cd8ac2e8856ae9045c97782ac1c359929c] Merge branch 'ras-core-=
for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad 0d1b82cd8ac2e8856ae9045c97782ac1c359929c
> # bad: [1650ac53066577a5e83fe3e9d992c9311597ff8c] Merge tag 'mmc-v4.20' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> git bisect bad 1650ac53066577a5e83fe3e9d992c9311597ff8c
> # bad: [6ab9e09238fdfd742fe23b81e2d385a1cab49d9b] Merge tag 'for-4.20/blo=
ck-20181021' of git://git.kernel.dk/linux-block
> git bisect bad 6ab9e09238fdfd742fe23b81e2d385a1cab49d9b
> # good: [528985117126f11beea339cf39120ee99da04cd2] Merge tag 'arm64-upstr=
eam' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 528985117126f11beea339cf39120ee99da04cd2
> # bad: [2cf99bbd106f89fc72f778e8ad9d5538f1ef939b] lightnvm: pblk: add hel=
pers for chunk addresses
> git bisect bad 2cf99bbd106f89fc72f778e8ad9d5538f1ef939b
> # bad: [33b14f67a4e1eabd219fd6543da8f15ed86b641c] nvme: register ns_id at=
tributes as default sysfs groups
> git bisect bad 33b14f67a4e1eabd219fd6543da8f15ed86b641c
> # bad: [27ca1d4ed04ea29dc77b47190a3cc82697023e76] block: move req_gap_bac=
k_merge to blk.h
> git bisect bad 27ca1d4ed04ea29dc77b47190a3cc82697023e76
> # bad: [07b05bcc3213ac9f8c28c9d835b4bf3d5798cc60] blkcg: convert blkg_loo=
kup_create to find closest blkg
> git bisect bad 07b05bcc3213ac9f8c28c9d835b4bf3d5798cc60
> # good: [cbeb869a3d1110450186b738199963c5e68c2a71] block, bfq: correctly =
charge and reset entity service in all cases
> git bisect good cbeb869a3d1110450186b738199963c5e68c2a71
> # bad: [576ed9135489c723fb39b97c4e2c73428d06dd78] block: use bio_add_page=
 in bio_iov_iter_get_pages
> git bisect bad 576ed9135489c723fb39b97c4e2c73428d06dd78
> # good: [c8765de0adfcaaf4ffb2d951e07444f00ffa9453] blok, bfq: do not plug=
 I/O if all queues are weight-raised
> git bisect good c8765de0adfcaaf4ffb2d951e07444f00ffa9453
> # first bad commit: [576ed9135489c723fb39b97c4e2c73428d06dd78] block: use=
 bio_add_page in bio_iov_iter_get_pages
>=20
> The problem also occurred with the RHEL8 downstream kernel tree.
> That's based on 4.18, but has 576ed913 backported.
>=20
> > So I'd be really curious if it can be reproduced with Jens' latest
> > block for-5.2 tree (which should be in latest linux-next).
>=20
> I'll see if I can try that when I next get access to the machine.

Ok, I've now had a chance to test the next-20190423 tree.

I can still reproduce the problem: in fact it is substantially worse,
and somewhat more consistent.

Previously I usually lost 2-3 hugepages per run, though I'd
occasionally seen other values between 0 and 8.  With the next tree, I
lost 46 hugepages on most runs, though I also saw 45 and 48
occasionally.

Hope this is illuminating.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzCgXkACgkQbDjKyiDZ
s5KhyQ//U0PhkfcaHHgBt0CyVLodLIzgp4IhEJPmzKpWjZOtj3fAvdzy1ZUXJruk
rEbM7ohq6Bam+FU6Pv29M9hsimJwHXFZ+uC0DBbanZ+ZOsjNexrTDvKFTFaFtOh6
y0x42WzBxoT2iDvSfc+niUOYPyvZqDbgWSyBlaq1OpHWoj+zCZbXkDV9jDQJkBuQ
kvqHHx2OrIaT8X7UO5WloklAxkNecMRmatYa1hAXF8g7YoR2v/kE8El4Jc1bqVQk
a2lECh31Krd5Iwu+n6MgLQR517EXsWLmfbGIzQBTB3ZmL44hT3dS4wGn3CZiReoD
ERzX4U3sbJCbNxxVt8G0u7Ynb5dZpUXGz7ykdodfXQMb7pNQLZ+AibWCLmi9Ap2G
lOBC3fbiyPyw03MeOPme3qOUGWgt0HyekMbh6gJ6RVwKWVTjPdJ5otrl8aVoD69d
q98H91+65yUauwUifjwEIweFBTp33YIECrSWAQbIRJqeWqNi9IRe9W6ws7BjIJPA
H+ADzvlSbJhPz1FQpUcA4lqQZLM4hfk+HyHQH1Wz4rR15rMCUXRnAfDIBOk45tuq
90qRpU3NdN2R3pR1JgNbxhE5BIpvQvHmHtIHd7H3KoIKLjs8sUvMKcOaE1SfIyMi
N1XkmwwSpYkLGkYdUsD+wycf/OXXXDpqFNGiu5Jkbd+TQuYzaNQ=
=SUkN
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
