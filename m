Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F84C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1882171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mzQPBa13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406301AbfHIKNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:13:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33253 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHIKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:13:17 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190809101314euoutp02966d05fcc703c36400abcab81cb4d8a8~5OYZL8Lb31175911759euoutp02Q;
        Fri,  9 Aug 2019 10:13:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190809101314euoutp02966d05fcc703c36400abcab81cb4d8a8~5OYZL8Lb31175911759euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565345594;
        bh=On0a66YZsNhqmW6GFpk7DdmlHp6VUZfe3/Xvo17x8cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzQPBa13fJoj+yhPpyw0Kddf0CXPPwEMF1cJ16xq85Azd+XGWFXrBBrSVp6oM6cz+
         W3ShLvKNipV10QOmWjAokOtMX+E5RjmQ2lODj+FvPPfnn58RaR6skgN7wSsH2RH3Dj
         VOux87E8aYqP+yB2BK0G2vdOkI+enpu0Iw7lW1M0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190809101313eucas1p2bbf588fa70e7b0fd281b1ea7d9e9e6d7~5OYYu2XUL2491324913eucas1p23;
        Fri,  9 Aug 2019 10:13:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.1C.04469.9374D4D5; Fri,  9
        Aug 2019 11:13:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190809101313eucas1p1363a5f60c06081bd9b2ef9b45248414f~5OYYAtYbc0554705547eucas1p1a;
        Fri,  9 Aug 2019 10:13:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190809101312eusmtrp18326d54ae492d6195deedb7e1e676044~5OYXyaCwD2706727067eusmtrp1R;
        Fri,  9 Aug 2019 10:13:12 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-48-5d4d4739b99a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.17.04117.8374D4D5; Fri,  9
        Aug 2019 11:13:12 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190809101312eusmtip220a64e082a563ff754044ed53efe3b10~5OYXm0p6b2333223332eusmtip2j;
        Fri,  9 Aug 2019 10:13:12 +0000 (GMT)
From:   =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 0/7] Fix broken references to files under
 Documentation/*
Date:   Fri, 09 Aug 2019 12:13:07 +0200
In-Reply-To: <cover.1564140865.git.mchehab+samsung@kernel.org> (Mauro
        Carvalho Chehab's message of "Fri, 26 Jul 2019 08:47:20 -0300")
Message-ID: <87a7ciejf0.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87qW7r6xBm0zNC0WrfjOYtH9Ssbi
        /PkN7BYL25awWFzeNYfN4v2nTiaLBdv6GC1a9x5hd+Dw2HZA1WPTqk42j76XGxg9Pm+S82g/
        0M0UwBrFZZOSmpNZllqkb5fAlTF79xuWgi7Jio7Ne5kaGL8LdzFyckgImEjMeXWArYuRi0NI
        YAWjxI62PewQzhdGifZ375ghnM+MEuc/9DLDtPy9cQ6qZTmjRMOBi4wQznNGie77newgVWwC
        9hL9R/axdDFycIgIFEgsOZQGUsMssJ9RYv67RiaQGmEBf4nl096A2SwCqhJf7zQzgRRxCrQz
        SrQePgc2iFfAWGLZtu2MILaogKXEvb67bBBxQYmTM5+wgNjMArkSM8+/YYQ47xK7xLvNMhC2
        i8S9uw0sELawxKvjW9ghbBmJ05N7wI6TEKiXmDzJDGSvhEAPo8S2OT+g6q0lDh+/yAphO0os
        vNHNDFHPJ3HjrSDEWj6JSdumQ4V5JTrahCCqVSTW9e+BmiIl0ftqBdRlHhI39s9lhYTVREaJ
        Tb9+ME9gVJiF5JtZSL6ZBTSWWUBTYv0ufYiwtsSyha+ZIWxbiXXr3rMsYGRdxSieWlqcm55a
        bJiXWq5XnJhbXJqXrpecn7uJEZikTv87/mkH49dLSYcYBTgYlXh4GxR9YoVYE8uKK3MPMaoA
        TXq0YfUFRimWvPy8VCUR3iscvrFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRm
        p6YWpBbBZJk4OKUaGNerzHD8+TtWnTdM8NGBntkpNW7V7xO3Wwb65e3TqPf7Pefk8pbAuW3f
        mOb9V7rYefGutkbGg9KlEibF77423z7WJc/2ZYa2kdy0jhVpMYWnly7f1X1i8lz//WwHCw10
        /hQLVoR7NqRorXjzJUEj6KT8BffvK5OjM+tKJycuWdR/bfuTjzHrJiqxFGckGmoxFxUnAgDe
        rcSEWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7oW7r6xBr07TC0WrfjOYtH9Ssbi
        /PkN7BYL25awWFzeNYfN4v2nTiaLBdv6GC1a9x5hd+Dw2HZA1WPTqk42j76XGxg9Pm+S82g/
        0M0UwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        lzF79xuWgi7Jio7Ne5kaGL8LdzFyckgImEj8vXGOrYuRi0NIYCmjxMxtF9i7GDmAElISK+em
        Q9QIS/y51gVV85RRYu/dKawgCTYBe4n+I/tYQGwRgTyJzSs2sIIUMQvsZpT4M/s4E0hCWMBX
        4vOxG2ANQgK2EnM7l4I1sAioSny908wE0sAp0M4osa7xDVgRr4CxxLJt2xlBbFEBS4l7fXfZ
        IOKCEidnPgFrZhbIlvi6+jnzBEaBWUhSs5CkZgE9wSygKbF+lz5EWFti2cLXzBC2rcS6de9Z
        FjCyrmIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMsW3Hfm7Zwdj1LvgQowAHoxIPr4a8T6wQ
        a2JZcWXuIUYVoDGPNqy+wCjFkpefl6okwnuFwzdWiDclsbIqtSg/vqg0J7X4EKMp0KMTmaVE
        k/OBaSGvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAPjJtUj1v2b
        H/38sN/9bO7Crd6vEnRYpNc1PtyRx+meGZK0bXYNc+7+7BeCcdxlJadWmf5etMaF86fRiVNS
        Bl+jPJ/X7Zi3+2LR/VkPws7OFpjKrlHoYv9TLWPfit8B/x35Dz1cJv7YYOIFDc+Gl3dD9E81
        Oh9It0svmbb16e+APbefKk+KF7L/qMRSnJFoqMVcVJwIAPNJgjLTAgAA
X-CMS-MailID: 20190809101313eucas1p1363a5f60c06081bd9b2ef9b45248414f
X-Msg-Generator: CA
X-RootMTR: 20190809101313eucas1p1363a5f60c06081bd9b2ef9b45248414f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190809101313eucas1p1363a5f60c06081bd9b2ef9b45248414f
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
        <CGME20190809101313eucas1p1363a5f60c06081bd9b2ef9b45248414f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2019-07-26 pi=C4=85 13:47>, when Mauro Carvalho Chehab wrote:
> Solves most of the pending broken references upstream, except for two of
> them:
>
> 	$ ./scripts/documentation-file-ref-check=20
> 	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.t=
xt
> 	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-tr=
ng.txt

Please apply the patch https://patchwork.kernel.org/patch/10758009/

> As written at boot-image-header.txt, it is waiting for the addition of
> a future file:=20
>
> 	"The complete booting guide will be available at
> 	  Documentation/riscv/booting.txt."
>
> The second is due to this patch, pending to be merged:
> 	https://lore.kernel.org/patchwork/patch/994210/
>
> I'm not a DT expert, but I can't see any issue with this patch, except
> for a missing acked-by a DT maintainer, and a possible conversion to
> yaml. IMO, the best fix for this would be to merge the DT patch.
>
> Patch 1 was already submitted before, together with the v1 of
> my PDF fix series.
>
> Mauro Carvalho Chehab (7):
>   docs: fix broken doc references due to renames
>   docs: generic-counter.rst: fix broken references for ABI file
>   MAINTAINERS: fix reference to net phy ABI file
>   MAINTAINERS: fix a renamed DT reference
>   docs: cgroup-v1/blkio-controller.rst: remove a CFQ left over
>   docs: zh_CN: howto.rst: fix a broken reference
>   docs: dt: fix a sound binding broken reference
>
>  Documentation/RCU/rculist_nulls.txt                |  2 +-
>  .../admin-guide/cgroup-v1/blkio-controller.rst     |  6 ------
>  .../devicetree/bindings/arm/idle-states.txt        |  2 +-
>  .../devicetree/bindings/sound/sun8i-a33-codec.txt  |  2 +-
>  Documentation/driver-api/generic-counter.rst       |  4 ++--
>  Documentation/locking/spinlocks.rst                |  4 ++--
>  Documentation/memory-barriers.txt                  |  2 +-
>  .../translations/ko_KR/memory-barriers.txt         |  2 +-
>  Documentation/translations/zh_CN/process/howto.rst |  2 +-
>  Documentation/watchdog/hpwdt.rst                   |  2 +-
>  MAINTAINERS                                        | 14 +++++++-------
>  drivers/gpu/drm/drm_modes.c                        |  2 +-
>  drivers/i2c/busses/i2c-nvidia-gpu.c                |  2 +-
>  drivers/scsi/hpsa.c                                |  4 ++--
>  14 files changed, 22 insertions(+), 28 deletions(-)

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl1NRzMACgkQsK4enJil
gBCx9wf/Xz4VEP3ZoqTg+7U+hPCgXFt6Kx0rBgkk+XBo7u/gnSSZrXWR3vH+3iKk
0m2PsNAhOZO/nEHKFckBUps5YMz4b6UU8lk+D36OPxdR9VjB5pzL/uHl5DovD8hc
o6oi3VV7fQCyOQqKni47KGmC4GZfS9AOoAc1khUUlt+3HaxXhwc/YEeclYu3cQ3W
SvoK9ji7jnEl0BMzKk8uESXspBOf5UIyI9v7BUm2A6pxQUzJgDn4GEbL2GHDCnpm
ybuoD4WqfNe0eUsfgXFL0YWBkSyjvK9ZzWLeLUw9xdnBgDCoryk1Y1MupfRps2Y7
3YC45VH8kZQSy7J4C/v7KgJJVQe0Ag==
=joGJ
-----END PGP SIGNATURE-----
--=-=-=--
