Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C138920840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AJ3IPk8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfHMJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:22:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45327 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:22:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190813092252euoutp0114b7f0932e2b0d77f9e481da18b08b26~6cRjcd0Cu3141631416euoutp011;
        Tue, 13 Aug 2019 09:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190813092252euoutp0114b7f0932e2b0d77f9e481da18b08b26~6cRjcd0Cu3141631416euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565688172;
        bh=T4+Ixi/rhjKG7XkH4ac3WeLD0AAHGpxcrxrnxU+6RdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJ3IPk8YAaMXoQ33ZqsL9y5EBoIvyBWKKpkhrLGxSEYNew7KurlTSt4+Pk4pA9tnR
         GH3uCeZ2XmjW0dfbZcOeqo9yph8RPD423JMUEt4LyGNtkQOZ+JDnxVspTTwnOID2ze
         +Zuh1FCRCDMT7McEO+eEdEy0+SaXU7qEDp3kNT78=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813092251eucas1p23a81a1c1ed64fad40bdd08a99ec28d39~6cRi9FeN81319213192eucas1p2D;
        Tue, 13 Aug 2019 09:22:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 90.73.04469.B61825D5; Tue, 13
        Aug 2019 10:22:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190813092250eucas1p268947b3a9e15c2d2721e6311db8c3965~6cRh7qyUm1319613196eucas1p2D;
        Tue, 13 Aug 2019 09:22:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813092250eusmtrp1c2d5584ef9c129639c35046e2ef39c16~6cRhrsuWT2217022170eusmtrp1v;
        Tue, 13 Aug 2019 09:22:50 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-36-5d52816b853d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.BC.04117.A61825D5; Tue, 13
        Aug 2019 10:22:50 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190813092250eusmtip1a18ce1c5d922217681dcaa0e289b4e84~6cRhh5_AU2373523735eusmtip1W;
        Tue, 13 Aug 2019 09:22:49 +0000 (GMT)
From:   =?utf-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     robh@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        "linux-samsung-soc\@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: Bad file pattern in MAINTAINERS section 'SAMSUNG EXYNOS TRUE
 RANDOM NUMBER GENERATOR (TRNG) DRIVER'
Date:   Tue, 13 Aug 2019 11:22:42 +0200
In-Reply-To: <f4e91a72-2d0d-b02e-706e-e53f6f9a2368@linux.com> (Denis
        Efremov's message of "Tue, 13 Aug 2019 10:09:26 +0300")
Message-ID: <87blwtctct.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/a+u2htPE7Lw5KosehieSmRRaYFkiOS1OhDieTK10u6C3vV
        tMhLH7TMVDS8pahFKrOWiYjNG7pM02TlRAK7aCqCpZZTsQua7jHw2/+c83v+58IjoMRGrkQQ
        o45ndGplnJRnTze9/mU+HJseEuaRYRXJh/pakPzhl3FabjbX8+UWYxlPXmxu58hXW5v5J3mK
        Bv1dnmJiqIijWNAPUwprw64g+pK9TwQTF5PI6Nx9w+2jG/smOdplnNRZOMdNQyOiLCQQAPaC
        F9U7spC9QIxrEVhzLIgECwjm5yo5JLAiMA038bOQne1FTfnMRqEGQemTai4JphA0tI1y1ike
        9oPcV+30unbCe6H5aQ9vHaJwL4LczFW0XnDEOqjLq7ZB9Bo0XlVn03Y4BWa6rbZ2QnwUfpum
        bKbb8TH4nPOJR/IO8KZkwsZTWAUl5u+2wQF38WFqJIdLZvWHpUUjj2hHmO5p3NjBBfoLsmly
        gVQoyPcmb7MRNJUt04Q5Dqae9xs+p6C89yOf8CL4MONA+oogv6mIImkh3MkQE1oGhtzWDRcJ
        3J+uRUQr4EdHGk2OlYdgtjAf5aHdpZvWKd20TumaLYUPwHOjO0m7QnXVN4roE2AwzNGViKtH
        zkwCq4piWE81c92NVarYBHWU21WNqgGt/aL+lZ75ZrQ4eKULYQGSbhMmhQeHibnKRDZZ1YVk
        a05f6+veIQmt1qgZqZNw0CskTCyMUCbfYHSay7qEOIbtQjsFtNRZeHPLaKgYRynjmViG0TK6
        /1WOwE6ShqShiTHLzp3FIr0sVTMf1AmeuHz/QFKxX6b03ulD+/IW3R4xqHtB4xOgizc4ezhZ
        Blz5KZMuD3zxMGU8M5Yeaek4m+kRYLlVce5af0juX5nD24KCjKXVPcEXXrZ5d/xJMfVmz/rf
        1q6MHXmskQQWU89Msgxty3n51siLFYHsTynNRis9D1I6VvkP8vQZM00DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7pZjUGxBoc+cVhcObWb0WL2/ccs
        FufPb2C3uLxrDpvFjPP7mCz+79nB7sDmsWlVJ5vHkyvTmTy+rLrG7PF5k1wAS5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpZTT5kKfghUHJz2
        nrWB8TZfFyMnh4SAicTyuW+Zuhi5OIQEljJK3Dl0n62LkQMoISWxcm46RI2wxJ9rXWwQNU8Z
        JbZff8sMkmATsJfoP7KPBcQWEVCV2LHmOFgRs8ARRomb2w6ygiSEBQokfpx7A1YkJGAj8XFL
        GzuIzQLU8HjhahaQZZwCdRKvbvODhHkFjCV+HX7OBGKLClhK3Ou7ywYRF5Q4OfMJ2BhmgWyJ
        r6ufM09gFJiFJDULSWoW0FRmAU2J9bv0IcLaEssWvmaGsG0l1q17z7KAkXUVo0hqaXFuem6x
        kV5xYm5xaV66XnJ+7iZGYBRtO/Zzyw7GrnfBhxgFOBiVeHgrEgJjhVgTy4orcw8xqgCNebRh
        9QVGKZa8/LxUJRHeSyZBsUK8KYmVValF+fFFpTmpxYcYTYHenMgsJZqcD4z8vJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjJzNH08JZHXe8Pk8K+D2Q83DZTZ+
        Aj7fV6cyzo+Of3Aqyv6j8l4dhSuvl92zjtH2Uvj7P64g8cNVzfOrfoV9EYln3cM+jatCduKj
        dodZPd22540sPJf17uI9ml22fvtKrokbtzTt/Jma1L4q6ot6Ho/wypMOV/8bVS96cnWGsdry
        ZeJ7hC4/PavEUpyRaKjFXFScCAD/KIeuxAIAAA==
X-CMS-MailID: 20190813092250eucas1p268947b3a9e15c2d2721e6311db8c3965
X-Msg-Generator: CA
X-RootMTR: 20190813092250eucas1p268947b3a9e15c2d2721e6311db8c3965
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813092250eucas1p268947b3a9e15c2d2721e6311db8c3965
References: <f4e91a72-2d0d-b02e-706e-e53f6f9a2368@linux.com>
        <CGME20190813092250eucas1p268947b3a9e15c2d2721e6311db8c3965@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2019-08-13 wto 09:09>, when Denis Efremov wrote:
> Hi All,
>
> Initially, I've prepared a patch and only after found this
> discussion. So, please, look at this patch no more than just a simple
> reminder that get_maintainers.pl still emits this warning.

NAK

The patch adding exynos525-trng.txt file exists[1], has been reviewed
and accepted and should be applied.

[1] https://patchwork.kernel.org/patch/10758009/

> ------------------------ >8 ------------------------
> Subject: [PATCH] MAINTAINERS: exynos trng: Remove samsung,exynos5250-trng=
.txt record
>
> Update MAINTAINERS to reflect that samsung,exynos5250-trng.txt
> file never existed.
>
> Cc: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ea3f82e256b..7d213e192626 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14033,7 +14033,6 @@ M:	=C5=81ukasz Stelmach <l.stelmach@samsung.com>
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/char/hw_random/exynos-trng.c
> -F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
>=20=20
>  SAMSUNG FRAMEBUFFER DRIVER
>  M:	Jingoo Han <jingoohan1@gmail.com>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl1SgWIACgkQsK4enJil
gBBtlAf9EhXavcWIa+xtfXObxm8sV4RPr+5mSsaKjsXY02hkcwtDYSsgDawLXsJW
OchLzH8P0qNg6CVS6tKkOI2yNRwveQFbNJySG7NXmcDmtzU7Ybp6+1DSlwcyvngB
79Az9DxIe+49S4aAsShIPtWra1BtMLH0KKYH2c9nY1Fg/rlf4i9uYWJYe+T1XTAb
fEfctVqZMjgohWVT82YKxjpx4tTUTXdUbbX9Kh1R65GluSJytmBVG3aVNctKeC0S
Q1bfMhMATBiL89NtnNZnxFOzvmkRDWmFzP1wmYmdMLnJiMLG0fL9tWltDIu2aQFd
Tp1l1gjEU5CoIPLRQVvkbZrRPY3+YQ==
=m7iZ
-----END PGP SIGNATURE-----
--=-=-=--
