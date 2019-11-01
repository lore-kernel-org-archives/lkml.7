Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6FACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936C521734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIOPCqlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfKAJsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:48:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36062 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKAJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:48:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so9107831wrt.3;
        Fri, 01 Nov 2019 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02u0JCDvZz83pKWtYtOAXWDlO3Ej+qpSEXuPMKs9XyM=;
        b=nIOPCqlj2m/kVj4iNA+bPyHgR8Bmxc3qmY6JwztFf+lf6V/yYL9urctl0qI6/XMVo3
         SUpf3ubuFRBytmEhA8/b6/ttk6ShfoSRqBsBeEiRNyoX+IQdd7bnOZJ9azk0a8L9vwO8
         w5AroBCmyXYNO15WXCqnuoRUQEbMrLp359MVYueuILzaGVqGRjQnOY31wtAZzqt545TD
         UdCoTjEOHB2of+aUQN4tdCjRFaqkv9RZ2uvwuuXGZF7h/Nf5tN8eWrsofGGTMva4Ii/s
         TSDkWPd8+L2m2q9QEKNiYJIk0Srm3tmFgE5x4O3d8Y5/GOdsmaeUmXVzH5b2WL+0CiqE
         HCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02u0JCDvZz83pKWtYtOAXWDlO3Ej+qpSEXuPMKs9XyM=;
        b=RD0pJ+lg8pcJKGL5dLtZZHqvZQM6L5W6lF1z+kqPuvhn3rulPsMzFAcrOpNmDaAe7+
         wRBqa96aF+NjeTBiU0XqthDW1Yx6gtBXLDizcPPx3xrKrh1nrTnzfSbW8rOf5glGAtFZ
         O+pIjHVY8RJJZemuP0fdudUjq6K6JgbdTAiPyAOG2UhJPM/vf5jmdxOS0aELGIABKsOO
         hcoo2pjx7hAYgwilONwwPNlTCDqS9h4esuWUBMBq8Go2ABgYou1Yby9t15fbdz7vcwYh
         amXG+AQPqXywmWWVR6M0aZGpPE5LT95WWl7iJ/yhkNLqqVMUaPfcRcqKBQOhluqx3gDc
         nhQg==
X-Gm-Message-State: APjAAAX0nLTMopPibWUjc4BumoJSZwqxKrzmRDDsIdVLL+qQeNE4MNaz
        d1mW6LhUiMfm0KzE3p5X9NU=
X-Google-Smtp-Source: APXvYqzMGFNs60pO4TBAqpwZQfZ6McYiT1yTswyweoMaYL4uonk5KQhKhABfkBJJP7CmS7jZiIXqzA==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr5129271wrt.335.1572601681474;
        Fri, 01 Nov 2019 02:48:01 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id b186sm6199897wmb.21.2019.11.01.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:47:59 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:47:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, mperttunen@nvidia.com,
        arnd@arndb.de, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] gpu: host1x: Fix compile test failure
Message-ID: <20191101094757.GA1167505@ulmo>
References: <20191030135458.27960-1-yuehaibing@huawei.com>
 <283304d6-bf23-8107-29b6-9f3e7dda943c@gmail.com>
 <cb0a976a-0148-d554-15ff-5f4059eccd37@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <cb0a976a-0148-d554-15ff-5f4059eccd37@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2019 at 09:33:38PM +0800, Yuehaibing wrote:
> On 2019/10/31 6:26, Dmitry Osipenko wrote:
> > 30.10.2019 16:54, YueHaibing =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> If IOMMU_SUPPORT is not set, but IOMMU_IOVA is m and
> >> COMPILE_TEST is y, building fails:
> >>
> >> drivers/gpu/host1x/dev.o: In function `host1x_remove':
> >> dev.c:(.text+0x624): undefined reference to `put_iova_domain'
> >> dev.c:(.text+0x624): relocation truncated to fit: R_AARCH64_CALL26 aga=
inst undefined symbol `put_iova_domain'
> >> dev.c:(.text+0x62c): undefined reference to `iova_cache_put'
> >> dev.c:(.text+0x62c): relocation truncated to fit: R_AARCH64_CALL26 aga=
inst undefined symbol `iova_cache_put'
> >>
> >> Select IOMMU_IOVA while COMPILE_TEST is set to fix this.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Fixes: 52499a6ad2ae ("gpu: host1x: select IOMMU_IOVA")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/gpu/host1x/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
> >> index cf987a3..354232d 100644
> >> --- a/drivers/gpu/host1x/Kconfig
> >> +++ b/drivers/gpu/host1x/Kconfig
> >> @@ -2,7 +2,7 @@
> >>  config TEGRA_HOST1X
> >>  	tristate "NVIDIA Tegra host1x driver"
> >>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
> >> -	select IOMMU_IOVA if IOMMU_SUPPORT
> >> +	select IOMMU_IOVA if (IOMMU_SUPPORT || COMPILE_TEST)
> >>  	help
> >>  	  Driver for the NVIDIA Tegra host1x hardware.
> >> =20
> >>
> >=20
> > It should be better to unconditionally select IOMMU_IOVA here.
> >=20
> > The same could be done for drivers/staging/media/tegra-vde/ and
> > drivers/gpu/host1x/, please see [1].
>=20
> Yep, I will repost, thanks!

No need to resend, I already have patches for that.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl27/0oACgkQ3SOs138+
s6EWPA//dBzkncU7+5Fx+wB0ll6n1Xc1ZFAP926QU2qICk9o6Uk+E/Nzua7dQFoe
ges3kWygaLZqdKbc2x84wRq8hu3FcFy33oE1ThrQBlJ7fSzhwuNYlz4fsFxRw6bJ
yE5vL412omLWlJuDntsxueODPjHO4KW3F/yBA2TM0WlpSYDzKPlnFSf6uw3ypQqf
SQkzPW+vJF2G1lboBg+vBqS6XN78wuThsHN6v+CAe+POAimqz/xAvijKqFQPLN+w
gSM/BlIpTFDRr2HnrKZG6rMxZFabPwxhTFeiM6zBMqhE63O2j5kPQ3LmbVRl/Otk
8zOX9VebV5AMjY+C/U43yGJ3UfkK8qmJjBZkD4HKDvuQxbkFxVkg4/whuBuRtEgr
JYkJy0k4PrhiUcvhqCOIX42VUeUsHRq2yC0yV4x2ORxXZjxlOvKSTj/2COdcMQml
R+Jz0e6odOetH2x4zAzYR4Mw6foZGwnsssnefVhuos7BVErYkIdhWWLy2kxL9JZW
XzprLVUg+TrRXgO3PUamO5aHg1fqKERl4I0MrlG1uCFBBVNUWzSL6nV8QgPlo0CS
HPaHYM9lOTwh0+dPTfQW5hdHeyo8hpfHNJu0li78bK9QZcP6qelqeL3r5IPEfBcv
RXQtNzxBUZVu147WKiiemWA3/VM/QrY7ZYTGMA9TDBu16BzMEZc=
=327H
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
