Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5724C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5A2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntcAz/iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfF1Xud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:50:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1Xuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:50:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so7838786wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNV4HFwYEt0yMBPXIayN1RSWc1G6NoGgFBBw4GTp5vk=;
        b=ntcAz/iX3Za+9ICjms1KoX9O6oWxXHxtQyDQwCbgMtkqPtk18/HptKLGS6omz63608
         bJU9/zeMqmKOPtdM+RoyfYd/q8NZtn+hlFteOxVYWQ0baUiHP/Dp7qn1LHLcwe1/NQTF
         n58RcsjDnxlmuKe688QDphz0tSXV7FlLD0WGnmmEK08j/NRUNmJCIhyDnpiZzzGeqGi1
         azbIwGfNPGLKNPk0FUf+HxtcM5FpYTc48xjxV6euLmPHk0U7vh2n2FD25akO0letVvPY
         m4XD1MGVns6LUmGSq736lCwKlUDkxZFJenjANpe2th+KMb8U6FD3xp3Jc38BO7m5keTh
         x+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNV4HFwYEt0yMBPXIayN1RSWc1G6NoGgFBBw4GTp5vk=;
        b=QI4BPYbDh5Ag6R1U6i0whrq0rBXzlBO0CzFoDDlNWeYpMKIBNGjBchEVWg1ajRwB6B
         aY0MwYD5V7HGFGMXEu64Sxm2RE/OXyVuW/DB7vCwDaSLQiKeYcMUw6jR2oH8DGF38fzj
         FAke7UNZPw2+TfQGQS36qUa3H1lzF8upF5/VltwWBfCJCKld+tHvkGNYVcUh8JkcIWXR
         u+7UDJFF2cD5HQi6qdrnxiQrUQwa0DNL7ZtYiqE3rgQrn4YyhZFo4acS5Ty//IFaJQzv
         Kip2Pv/p4OhU36hmOJOSt0UwoWKksoXSOibq99AZ6RmFRVXVZXPEHijmCvZ8pidISscB
         Fkyw==
X-Gm-Message-State: APjAAAU6Se9PxWwBckZWiTLMNNocPONGxlgA0JzPkgvGBu1aSqVkGKGy
        kHITqyLnR5pQ3CB6KClNFW8=
X-Google-Smtp-Source: APXvYqwqZ6SOsptqFa/q0p+yLVXdp/0KY0BruP6v8sEZ6TBSCu0PSTL3/w4chYZ3COstYSLzG9RhTw==
X-Received: by 2002:adf:de90:: with SMTP id w16mr9322571wrl.217.1561765830682;
        Fri, 28 Jun 2019 16:50:30 -0700 (PDT)
Received: from localhost (p200300E41F2AB200021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f2a:b200:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id n2sm423403wmi.38.2019.06.28.16.50.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 16:50:29 -0700 (PDT)
Date:   Sat, 29 Jun 2019 01:50:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?utf-8?B?QmFsbGV0YsOy?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 4/7] drm/panel: simple: Use display_timing for Innolux
 n116bge
Message-ID: <20190628235028.GC1189@mithrandir>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20190401171724.215780-5-dianders@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:17:21AM -0700, Douglas Anderson wrote:
> Convert the Innolux n116bge from using a fixed mode to specifying a
> display timing with min/typ/max values.
>=20
> Note that the n116bge's datasheet doesn't fit too well into DRM's way
> of specifying things.  Specifically the panel's datasheet just
> specifies the vertical blanking period and horizontal blanking period
> and doesn't break things out.  For now we'll leave everything as a
> fixed value but just allow adjusting the pixel clock.  I've added a
> comment on what the datasheet claims so someone could later expand
> things to fit their needs if they wanted to test other blanking
> periods.
>=20
> The goal here is to be able to specify the panel timings in the device
> tree for several rk3288 Chromebooks (like rk3288-veryon-jerry).  These
> Chromebooks have all been running in the downstream kernel with the
> standard porches and sync lengths but just with a slightly slower
> pixel clock because the 76.42 MHz clock is not achievable from the
> fixed PLL that was available.  These Chromebooks only achieve a
> refresh rate of ~58 Hz.  While it's probable that we could adjust the
> timings to achieve 60 Hz it's probably wisest to match what's been
> running on these devices all these years.
>=20
> I'll note that though the upstream kernel has always tried to achieve
> 76.42 MHz, it has actually been running at 74.25 MHz also since the
> video processor is parented off the same fixed PLL.
>=20
> Changes in v4:
>  - display_timing for Innolux n116bge new for v4.
>=20
> Changes in v5:
>  - Added Heiko's Tested-by
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>=20
>  drivers/gpu/drm/panel/panel-simple.c | 37 +++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 14 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Wp8QACgkQ3SOs138+
s6EONRAAnI/lLg3nbvC+NPG+zh2EdypmFBjJwDAq/ZiG0VNTPe0pgjIbyg+vVcKD
TS4SdyIlPL3I043HPwObBM/Y+O1MOcWwuEMxlnTSN0+R0pgyifAawX55sCE14MW0
gf0GUEJcysayA0957o8Zfrvlh74nTmNOPyfp0MlpIXMoKZ7Zh3TMD7i0e4J7rfxM
39xPhrNSLUYM0+fiTAYO3hcy3KGZ01CpLP17+djBgsDDjV+0uDXl6I6FNm9oHvNa
bgbwx2urFytaX9PkFc/DfYYf6o/olkB1XZHxRRJfMZuys2L1cjQB+5zy6PjQ8GIM
mScJALEwkxAKaidmyZ9lPm+a4CsMJF/s+XeG5MpVp6J63w8RdRCyqPRYQFcJkExR
FyxI76LaRZ/wntJOBPgayCa19n3eNyL8KzEy259zNvOhluuzYpKQA+rqjGk2iXy/
hQPgNnKtbu9x2Gh3AnzfxDwqalLX7/+ksHbTDXoXnuxa9HMlBDXuwbw721MMmzea
k4MfVF5pUkQAFp5OODbhg5tlZH4zV0RIZdMvHR2/elsSP23+27kgvxqS7tDor493
jUnLz3GuOGarkedkx9ywBbiNZJOlr6xAJlxW6jgr/hUNmaZ5Da4JwJr8S/3MCUyD
xxMPQvzI/Sacn0JL2kD9cE1ojFOJOxLskiTWEv0tZtChQR2hoXk=
=ZuxI
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
