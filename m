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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7115C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AA92083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqToZ/ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfFTJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:07:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39092 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:07:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so2314550wma.4;
        Thu, 20 Jun 2019 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMLC0UjeVndE6cwUWtdBVuBJxQ2ZnMRhYWK+s7JXyLM=;
        b=NqToZ/ZSVmmCTY4A/gk7pQCnUSpLKfJazYKltxEIZq3TKVMZxYziIJWKH1ad5J+8X6
         KRSxvfuf7M4Z0xI36IybU82GFicEn+CharNpV214AZQEgPCI0f5CuQQoir3B18ZDP2bv
         qSJoLyneMJLJMhQOYb/c+wquZX60y0eiz/ppIcy5hu7WSQA9YK/0cSIYh+qH9CR6ti5W
         aGLPUFMl/c/9N8cSClmiX+7ED6rvzQF6PUhp4HQ5qsFLo7gdOliRYknqQpeTHC5D6Z8y
         tH2tFLXAfvLKK9ufbG/EBjP+0dfAkH1F82kZu3KwTrXP29MhHZ87jptowjI9fY+q45V/
         6yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMLC0UjeVndE6cwUWtdBVuBJxQ2ZnMRhYWK+s7JXyLM=;
        b=lSwrAQmsEP/k2llX4HZbHPMHK8A3HL3xCFvw4CWCtPRMDHxsTfVxKwWMuzo3p53jCm
         9Fg13OvjKPYWdyxwYCO7eoiTxDGGkok2b8OQlYCjzmRYJhAyLm7cA7crPgLKQcbvibfH
         IPTY6jGhvuRz/ozPLV53fO1SbfkA9TSCjDugI1y/cYAwRg9nLBETN+3qwKk4QyaMrMOv
         X7h1E3GF7XOFiusTsrReJI0Y0fAXr261t0/+H66+BaIChSPr1xkgHlVmTjXlNBjp9CMd
         u4uz+aY5oo4E9YX9vQ8GaDXS4DzHIaqXq57oh5phA5fbD3UOYh132qiAWXkUlDu66LR/
         hiFA==
X-Gm-Message-State: APjAAAVgNiMZTVJcHAgOtTzaA7QPEqY2hEpy9m0+i6Nygdu9l5wqbDg2
        wPQMWBwXF+WU9obKjnYoWww=
X-Google-Smtp-Source: APXvYqxPbf9Xd5arqQa1kZ0i/rECTVCH6BEUdMPQonyjrf/B5lGzLobyPIlNoNB1lm5COCbm9zZn0w==
X-Received: by 2002:a1c:630a:: with SMTP id x10mr2044678wmb.113.1561021642104;
        Thu, 20 Jun 2019 02:07:22 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id b2sm26630918wrp.72.2019.06.20.02.07.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:07:21 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:07:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 4/4] dt-bindings: display: Convert innolux,ee101ia-01
 panel to DT schema
Message-ID: <20190620090720.GE26689@ulmo>
References: <20190619215156.27795-1-robh@kernel.org>
 <20190619215156.27795-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20190619215156.27795-4-robh@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 03:51:56PM -0600, Rob Herring wrote:
> Convert the innolux,ee101ia-01 LVDS panel binding to DT schema.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/panel/innolux,ee101ia-01d.txt     |  7 -------
>  .../display/panel/innolux,ee101ia-01d.yaml    | 21 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 7 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/innol=
ux,ee101ia-01d.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/innol=
ux,ee101ia-01d.yaml

Acked-by: Thierry Reding <treding@nvidia.com>

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LTMgACgkQ3SOs138+
s6HTnA//XpMRpvIzlsj6bjRvDhdgl8TvPHw+KHstPrkShJJAVgRtW2KVQLdY5nTm
24C05Hn72m0VpcFpczml93ye6xWbctMc2fTEVXEEoA9sSi3n0MPPP07qoun+aDHk
gA+NM90RqQVW68KAckevmejVJxzhlN8IsmvLuZLxx4x2EcbEqFO5z9yt199zvItU
M41Xi2lWdLvDJplQHd5kKPYPHVYxyXNVd5mZA/LbFbWjVxp3RpcHOGDSIwLchLIP
exole/KJ1H7RECQyShMq1FRkL8I7cxQKF39b1SA8qY0zsUo+t49247jZrCJgkU8u
dvIRdNsT4mEVpIAuPIUTLeRxZigihvqbz2Ay00C6eGU7iL8HQX97dQKhn1/MImxe
ck662ma0pZHNNgCkcN3Bf+4fxvHVsBt1a2X3V0MM3cDLc8Bu0TiIuIpH3H9Bh44h
PbQzzH+1052oizKdXIiFtmoyGfJpZ5jHRuNQGbzE4ykAy6lb7uey8epWmDql9B14
kBUOHgAOdF+LKKZZMH02p5ISXGMAJ4Pe6HoHL/ox5DfosyMUnUGRIflYpUenliZe
Mgwr3ThVkTKeLwOpyhQdMvJStL1I3WafYH9vGYDgju0Vqn9jLCrf9+GonIj8NKVV
vsn6jEkuy9AQi56DWl3YRFUyv8J8lJyIHkcTWYxGe60cYnkbQeU=
=wPVf
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
