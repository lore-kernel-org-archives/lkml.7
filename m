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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9772086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vG3d8acL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfF1Xtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:49:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42660 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1Xtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:49:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so7838293wrl.9;
        Fri, 28 Jun 2019 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q7IEImnfjv+A3lRFXyTXResy2KVoDPFK5pOWIOXw67k=;
        b=vG3d8acLaTa36M8Qk+1Ig6NnkHOM4RXcyJFhhNYvfAeittbGLBIk42dMPmgjNUsdn5
         FuYVQa5cR7tHr2HSfddbCSHiQE09EEBRNwSaFvQfSxIOOjgnN2uv5TAD5a7xmftR1T5T
         pwq8FCkeB+h/d/mMeVatdy/dOi9jzYpHc8DizVguo7L2LBu1Frni/N7D6Ji4+QESaydA
         6CkAd7WRlSIFr1DbePAevzpDomH5OxStI3Qj/Gndq12vMLl42ZMaSDAnZbNnui7niT0N
         L8iltdGDiezmYdLexEiKRS5zIuJc3XejBOaAIAXAiVoL2uKNPXt8Eu2bcyM+3tG1iuQq
         qUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7IEImnfjv+A3lRFXyTXResy2KVoDPFK5pOWIOXw67k=;
        b=efl1VCKG1NYIg7r+3lfhRYNejOx43sBJ1Kc0eXNNu6mVfCP1b0u039z0+Gu5t4YtbY
         rH+BL4TgleBliOVN31BPRCOzkDbe1OViXRs5DldV77zTQClyvnXEgV3lbtu7UaGBUNih
         W+F4nIAEtEmc3qDk51CGuTm97WqMsg6fwc0T/DaDqtDBuvIFuZ/ceEccnT854sJsLgmx
         xQQTyB+GxosAkuVrNL6nd1BITc7oyKvafTWroIV8LG61yi+j3JzAzyBBqJNqQ6brsZJe
         K8dLlJropWuXwSirFrKY+Hu6fl45XrpiOryzY2/+XqBMEpWjQ5H2CKPy5PkvaDERzOFB
         NNnA==
X-Gm-Message-State: APjAAAX2eakf8urgZovgroMVsn46EWD7AxdNBWQ5jVyDumcByputo/Pk
        lqctfBICko/r4hQMy/9VYlw=
X-Google-Smtp-Source: APXvYqxqv88pnNrGXl9e9tW3mOegaQe/CRnhjJlMga0gyKaLHiB23YZKxAYNn9ymY4Gf8UHD1YMp7A==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr9877353wrs.97.1561765788237;
        Fri, 28 Jun 2019 16:49:48 -0700 (PDT)
Received: from localhost (p200300E41F2AB200021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f2a:b200:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id s188sm3658105wmf.40.2019.06.28.16.49.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 16:49:47 -0700 (PDT)
Date:   Sat, 29 Jun 2019 01:49:46 +0200
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
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override
 typical timing
Message-ID: <20190628234946.GB1189@mithrandir>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20190401171724.215780-3-dianders@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 10:17:19AM -0700, Douglas Anderson wrote:
> From: Sean Paul <seanpaul@chromium.org>
>=20
> This patch adds the ability to override the typical display timing for a
> given panel. This is useful for devices which have timing constraints
> that do not apply across the entire display driver (eg: to avoid
> crosstalk between panel and digitizer on certain laptops). The rules are
> as follows:
>=20
> - panel must not specify fixed mode (since the override mode will
>   either be the same as the fixed mode, or we'll be unable to
>   check the bounds of the overried)
> - panel must specify at least one display_timing range which will be
>   used to ensure the override mode fits within its bounds
>=20
> Changes in v2:
>  - Parse the full display-timings node (using the native-mode) (Rob)
> Changes in v3:
>  - No longer parse display-timings subnode, use panel-timing (Rob)
> Changes in v4:
>  - Don't add mode from timing if override was specified (Thierry)
>  - Add warning if timing and fixed mode was specified (Thierry)
>  - Don't add fixed mode if timing was specified (Thierry)
>  - Refactor/rename a bit to avoid extra indentation from "if" tests
>  - i should be unsigned (Thierry)
>  - Add annoying WARN_ONs for some cases (Thierry)
>  - Simplify 'No display_timing found' handling (Thierry)
>  - Rename to panel_simple_parse_override_mode() (Thierry)
> Changes in v5:
>  - Added Heiko's Tested-by
>=20
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
>=20
>  drivers/gpu/drm/panel/panel-simple.c | 109 +++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Wp5oACgkQ3SOs138+
s6HkOA//aJRj++gDyHqyv+35Dnz1qJOb04MLQT25wHlW53LhiXm6APFDfKgu6GY1
jEhdqsfBT7y0c+yM8SQRwJx44H4QN8YbkqpH0jFsvLli7S8oalKWtu6ti1nRv1XB
oW2oTzn340rTKD1zeqQL1A26GF7G3COyKIOBhW+yHNAGA4gqi3XMi3RwKP0tLYWa
1zpI7ZMQw8kwprzPZZbsEnfRYj1R5YUfBO1252HaixMStJbJGj5vfhKFE2H7wTJv
zCz0JlxX6kepkO7aHmrwOWHYgnvrcCaphJy8YBWMhsBRN7UdOlLjjcBtvqGidKbc
5bBZucu8NOKSBVKP9V7HlWgQjoCI4uPXSJ+Z9G+NemzcqFtLOYAgGezKiTVjnw1T
AvEbEQ2ed9MPm2Yt93ozVgR0fvTqeJu0t5ybGaVhUXqevtek7HTCDbCiY+oFLBGs
ubaXXPCJaYls415YuHWxeIOBuyuyAkSihPy9JB2SZ5jZbXgRiXFrppGI+/zcTklX
InfVw9QwQMMHay+FhcnET0HkWiD47kvEnVBmaeHoMEnYKrE3p1IVZMXlzQsLqefL
ADaFGSl0UIS5kyS6yB/b82C2XkyuyFqG40ohDu3qpa2ShzY7iovd1rJBRFmI22/3
05j4j/3dS0eGTqoVVM1zpmdAaIvHaw7GbVjIEsd0BtG+51TIhW4=
=P4R1
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
