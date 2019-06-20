Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861382084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcC/P9eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfFTJGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:06:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33637 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:06:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so2221953wru.0;
        Thu, 20 Jun 2019 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLAB3Vbq6atzRDwMPLEQ9hXckVRJCFIUBFgi18+pmmQ=;
        b=gcC/P9eBiF17fUxfWGvp3H1k0IInMVdsQd5Gga1rvT6Mml9dJpAWVEfolEbctrwa00
         rZ/W1R0BV0KhM1IrIfgLroAv+CYj3c+Bfhvn7srrDbzVa1DPleQaC8jwziiBHJgbrCqL
         pEDVv5M1WccfSoL982XseDShKETpKkY6s+B3wXxktgUMxWHs7gz/88TckOxAvav47Xt8
         WLsMke/32WHXBg9d05+QxugtCZaJ+eR3hSi+HEMS3NW4uMOPazc8jNik/BUe2D56kkRc
         Ww1Weq9wz9UnM9/yeRV6Ljvz96ysbQJTugPWAsUxpbLySCApleZRgEN8X1bwV0eIEV10
         eG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLAB3Vbq6atzRDwMPLEQ9hXckVRJCFIUBFgi18+pmmQ=;
        b=B90SKlyvq/qV81sKFjRqiEb2AlCcxd5CBmdIphxVhZzD84zmyjEVBl3WWZre5db3Yu
         DfrpjxBv/2jwJjn4gVtdNy7Wbjq3LAwNSWQtm0PvIWn38amztyarprtUGZI6pWQ38e0r
         +D9+Drz0dyTsEK7tropkkTkn/Lk3hAxyoTdjFc+KkfjH/YYAu8pzxFsXau152v747kwZ
         /x5Mv+l3x2fq9b2xTHukk903kpzktMk28ZL40nZRe3/ZG1bUn6yYVMEY+N39JYYuJ4Js
         JSqLmpVSvJxkfmLSmd94dw6ZCbU23wPtAOh5cbjzhiF5/uydl9LtWeoK79ZEP/BAdSvi
         sLFg==
X-Gm-Message-State: APjAAAXoelg6u8L9LyqZNBPUbF6yC81WY0xEYs+UNQfBlbe/QhezxWq9
        aKi0dveze9Ylo5lE5dg7oQQ=
X-Google-Smtp-Source: APXvYqyIO+/N7WsyvX2722wWyUHnjXfpbHpEtG5nUFeC1Q2vNQjoqACgOF0Y5zw07hPT30TFVLPPlw==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr10352007wrx.199.1561021571455;
        Thu, 20 Jun 2019 02:06:11 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id j132sm4282541wmj.21.2019.06.20.02.06.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:06:10 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:06:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 3/4] dt-bindings: display: Convert panel-lvds to DT
 schema
Message-ID: <20190620090609.GD26689@ulmo>
References: <20190619215156.27795-1-robh@kernel.org>
 <20190619215156.27795-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20190619215156.27795-3-robh@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 03:51:55PM -0600, Rob Herring wrote:
> Convert the panel-lvds binding to use DT schema. The panel-lvds schema
> inherits from the panel-common.yaml schema and specific LVDS panel
> bindings should inherit from this schema.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/panel/panel-lvds.txt     | 121 ------------------
>  .../bindings/display/panel/panel-lvds.yaml    | 107 ++++++++++++++++
>  2 files changed, 107 insertions(+), 121 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/panel=
-lvds.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel=
-lvds.yaml

Similar to my comments on panel-common.yaml, perhaps make this just
lvds.yaml? Otherwise:

Acked-by: Thierry Reding <treding@nvidia.com>

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LTIEACgkQ3SOs138+
s6FLsw/+NC/6Khpjg6ysa3WInhNhqMUsQWEt+rIBtVK3wuiFuV3Fmhbj5eTi7pip
azMl6odp9t4TnQbzpAbqOwA73Xsp1KWdjGawLxeZTXcdckPrMMzTbiCbbLkw3nuA
26f+cj53Kp5vmuJlxOllFWS8YB3tPy0rV6+7DDBKqONdIne14CUu118dFgJMOcxq
ATqXCBQGd9SJE0XRkVwY5uixnKjeuy2SMr1JU+Ear6UQqF2hVc9Lrkxs4Dd4YbMc
GqcdrUuaSvUifujZ2dr1aZt6WleALu0yHfUnd/cuo3JOjBhsSJbrCg6EPMFdlsdh
QjiWZCVsAnaO6NMLsLrxzTkDOsZnBW8T38bh+jIPEXgCGsKTNIOKaXtXPrKqPkPK
5hy95N1u5UgvPNUw4BPVUVzjcuHgTuevyHrfnvR7cYa1BspbdVMhvwjifPTCR5Qa
pSAezwB/wVTLpLEeq3wySXAHj3VACaGtAfuunZ1i7V2x0hMe4W2wYj3SGWMEAUo6
srlTiiDZYxrZk5+ot2pRzlFIH4rC+iTTOKtnhnQzyeQA1kgqeouvHuHjJlBP2ZQD
mul4nf2BMRhopoccrOLOw2ElpoyVQebipi3xkkapvrBY+0Y+c2N3zt5v4QLmuBvN
4n9yVm1sJd8FTC3iRG9UnBCN8hxc3MnRlZd3nr1xDze2ujRNFUQ=
=Cr2T
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
