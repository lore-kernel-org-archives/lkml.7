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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C292086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3DDTJZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfF1XvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:51:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37405 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1XvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:51:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so10391159wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E/8G2PjZazjY+3koArK1GNsdz2h0E+2RlYWcCl/197M=;
        b=O3DDTJZYIWWPfnAp3HyoJ+2BKJJYwV9YAcHXhNbab8OkXYmj7TCDn6L1ciJ5mH1KO2
         xHOPWC7xq8XznaLHUGH79kWjTEul8jEn7/tJpqaFaRNmyDHm3Jkly+sfvdNAt+0SJC+c
         vIKNnCau9BWNg8JNN5Z5Hd4/aTnl00+f74nhzJSJ7Mrzw3lNFTsw+zvGB7Boe6M2PKzX
         y6wyI6YsWiJAO8E+8XyelBuZkOklteNg6eBGOUyP2bbZIb5FeZ6LQpQMQIb8nnywub2k
         EatzrG99+rp2SHBrvEFe5kCeu6Lrz0T+8z2fIkHTmPp6Vq+5hNQUVqFhjW/cwapYHIwV
         FC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/8G2PjZazjY+3koArK1GNsdz2h0E+2RlYWcCl/197M=;
        b=rZEYaHi+ussniaKZuPXD0SErNNDqCiNRw4tK1yJD/9qEAIjPx255Bgfp/Q0s+iH3KG
         zDJJMsHjVLisqdAz2bso26nzbgGgd6xh0QtlBVmBK2SpcvKqBHxqWywoVUbWvrmuZe6M
         o/jt3zTHWRwbbqAgmXqieGMuinDDERDQ5HXm7tCDa9R7QKd+nWm7fEwIQHvRZjyw40mU
         s/7mQ8IOb1sjmiU/8/g4qQoTzXU5zcBiLiAfU6XyC71DcflJqq1kwnoKqSMrL4xUCPCW
         dvpUFNNusw1wqmkXAfur+F8qhbklOYF4CzOVHM2NQ3iG7oum4fmjYKqUnjE+W3yqkppX
         dRBQ==
X-Gm-Message-State: APjAAAWE1+jlBryaIkq/QdbXzDtbVTafu+LkahSQA37L8X8VR4srOICe
        8CgctFbTSYCqjvH05Cz1ffo=
X-Google-Smtp-Source: APXvYqwwYIGX0BKFhNZzNRBY6/lBKez08qsNZRlKhSbmT7GM7lr64gjllaB0S3ROfyfooX0EEFWCOg==
X-Received: by 2002:a1c:9ac9:: with SMTP id c192mr9275089wme.0.1561765858237;
        Fri, 28 Jun 2019 16:50:58 -0700 (PDT)
Received: from localhost (p200300E41F2AB200021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f2a:b200:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id t14sm3634009wrr.33.2019.06.28.16.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 16:50:57 -0700 (PDT)
Date:   Sat, 29 Jun 2019 01:50:56 +0200
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
Subject: Re: [PATCH v5 5/7] drm/panel: simple: Use display_timing for AUO
 b101ean01
Message-ID: <20190628235056.GD1189@mithrandir>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-6-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <20190401171724.215780-6-dianders@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:17:22AM -0700, Douglas Anderson wrote:
> Convert the AUO b101ean01 from using a fixed mode to specifying a
> display timing with min/typ/max values.
>=20
> The AUO b101ean01's datasheet says:
> * Vertical blanking min is 12
> * Horizontal blanking min is 60
> * Pixel clock is between 65.3 MHz and 75 MHz
>=20
> The goal here is to be able to specify the proper timing in device
> tree to use on rk3288-veyron-minnie to match what the downstream
> kernel is using so that it can used the fixed PLL.
>=20
> Changes in v4:
>  - display_timing for AUO b101ean01 new for v4.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  drivers/gpu/drm/panel/panel-simple.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Wp+AACgkQ3SOs138+
s6EvcQ//Tbw0f5ozO/fe70CrFitDkI3rMEe8H/oX9vrS8glGIG4EjzpDwgvGTK2Q
D/DP0Y3lmDH7qbvuGkMI2PEOqpraUK6utBFaN1SFu5ZtnSHi44GsqRP8y8lnaRNi
1qsxORATUYK+CpxTPW0/YMCDse/fXHGoMAV7yN4Ml4ufhYL/08XR95rEc/doFZyc
QcERscJUhv5lMegiv+y+aCmRqnvkHWvWonxhE6yCzh54KnfpJeUNI3A2zsZMTw0W
/HUt0DEu2qi9OkoDOG2YCji4yfGjMLsHG1oLTvSZxDmDUOc7C4k12XV25RswW8if
EpckvCxfI+4/JWuK53ofikg5s172SFvDZTLpgMM1M94R/36fp86pX6phZ+CV2Q4H
vARuHnLEFIgs9J5p33EDhRG5pH4xToEzme7wAaJuSpXv24LdsrMp4ewVm17tJ4Ki
koosRochNUaH85RqSs7H1gi5GqWlONIZCj4hG91IvDYDoHbQNzTFWknx85Yge4hG
K8tKn5JpKJg9kKsQQuQbHXO9ziJDta1lmrhykCv8dYENNncEwpK3vwrZaOEmweqQ
w5GZyH7U/gXwhUaSNPeTefo6jZH6185HouIBfPj+BQ0ZKgzSnYN9yEgYxcpWHnaw
4jM6jsv4tpohTfiGOXlbQU5Poz23azF0Q7Jl8Cm7KSgit41OMzY=
=5nXl
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
