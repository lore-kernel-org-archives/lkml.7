Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664292054F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaVZaDsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfDWL5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:57:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:57:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so19834004wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5TUQCVKKlbEw7YNfwsQu4+fGGYNLKYnvGksRiV9e1nM=;
        b=iaVZaDsfNNFhIxA/UIlcHkWpEzAxxM4qlwtS/HikDufwvUQdceS/pHSgNxpbwKbknZ
         nmK+aSz2N6pp5O4LQFmfOS2SAF4dEHf45GhNv7YAU7KDYjyiwbpTj3ei0znngqRL1jfX
         tvN+U2cVwtYZUFvKBlk2ogD35UCMugAXwwtvh7iiVKLTVh2UsDXfyOjm2NA+JsfoYB4L
         U1pKyDI23PiE9xPPhRPrvvvXrmXJzyPwwzF/mc+TctljxNjuIb9BFEZNqZ5PqyO4IhJp
         hekOa10bgLpjr34IfeM9oN1jf6A0bn0mkVCDI4+A2wcGnxjBaTvjqU61X6/wPB490gf2
         qZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5TUQCVKKlbEw7YNfwsQu4+fGGYNLKYnvGksRiV9e1nM=;
        b=bHjwBhwy7bBt+T3C0jgUqFNCcPLiTy+QXnJExggsW/hck1S8fahYfngSCjwbJMkoBO
         hS0vRciNDLh6VluyYaeGW25Rt2x7eNn7QynkwyesM5IJTJt5Yt/+j/oV5g+E5IiCUdyE
         I5Dqum05BaB1WklIP7Hgr/ckaphqrAvLNw2KmlYepFDfo0LtKPGITk7lLX1kgQBGMgCD
         0hSS/vpwPcxNjRb7eZOmU/QfZKNQK6xARI30D/gzvumP5uIuozUS/8u2QaIuBCquHqLC
         pk+nk3GgawSN2eDj0GV2Rg0fsRb34zL18UezaR49kQfQDoqXawNIfBiD9ePlnsPcNAQK
         +cDA==
X-Gm-Message-State: APjAAAVBSdiYCgWsN8E5CPh6oMu6gLjf24N6ZDw28qx4ImV9aEucgi5k
        jaJDGIMUKuzT5uiWV3CIuBY=
X-Google-Smtp-Source: APXvYqyR9r/qyobqAkKZaGpBlg+B4zHbAZmaY/kZQBZZxQTO9vBEqv9im+eMwsSQIClQTgmHc0Sz+Q==
X-Received: by 2002:adf:db10:: with SMTP id s16mr16963915wri.181.1556020641920;
        Tue, 23 Apr 2019 04:57:21 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v184sm24677408wma.6.2019.04.23.04.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 04:57:21 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:57:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: simple: Fix panel_simple_dsi_probe
Message-ID: <20190423115720.GF23448@ulmo>
References: <20190226081153.31334-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <20190226081153.31334-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 10:11:53AM +0200, Peter Ujfalusi wrote:
> In case mipi_dsi_attach() fails remove the registered panel to avoid added
> panel without corresponding device.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly+/Z8ACgkQ3SOs138+
s6EnLxAAuah4/vnrfPb3N1xTCPbkH2qUq7O4Qsc6aE3/28+k93rET22g5UP2Gqxr
/O0zI6L9MvQA1SqO89MWrzyYZEDt010MdSO2CTFBb6uj8H0tRraaUe1jU+OiVuKA
BVfxEAtMOgHfP/2melHdz8BTSVUU/gzUXAd3487ecrISDXAFaJrAmLxaMTpzE5X5
UO01IRJptDlLOM0cN/1nW5Ry1laF18rkYjzHtCqibd3xGoC2DFeahrEl3P4w+KEy
/bgQ+dnf3xhkowlbgwV1nCZJ7C+LVoyCtxSV8vLcMUZvj/Fj3xQ8cmNQXFncmbTy
NAEcLBsIM+k2fnpI6vEnCk87dBGHiQqLi+dr1mzPzwhp24YFPz8Knsdz/De6Mugk
WMN6nCRmQcvozz01PydB7F85YRNAg6dujinoGq1ejzGsZRTfKwR2FB9IjxsjzYLI
nffOBLebYxItuqbGWM0qjlWrJxjKN0yD9gMT1nQMT6/TDQ7WGOvBezlqDl06H1I+
1a1OBGUDvPkxEWlD3L8pDcIOKzLbCaVudhYoyLE9ppI+6JYH5RUVtpnNqIlMcjZX
A0Z2yC29I3oW9TsrNADolr9Pa8F5EAjQ2vxHRoWutpnu+fVBhJFhBFzo2h9ByeGp
+czroew7KDFaIJF+WGa1JH+J/a9bTqwr3MinELJhRB8hySaR3Zw=
=7XFk
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
