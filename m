Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE3FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF8217AB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 12:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOBps9Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfK1MSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:18:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53513 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK1MSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:18:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so10732671wmc.3;
        Thu, 28 Nov 2019 04:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sFnw8MD4jHwQnFsI2R3PlXPaqZK7gGQfobFNAVzerVY=;
        b=FOBps9VxWVD4kcRhzSmwbU5CH8SGByglnoWeX0RAjNcmh8jxE8WPHZkpGT2bRl4lYQ
         m43Q3Dz9+l7v85u2T++5ijaVu3KCiRlCAdMsoDrUII5sx/MPJpvxdzNyAjZD2CGRPCMe
         Hb7LLwmdElfoPelJOzrgnKxTzTd3D6wn3TrM4E0AN+JYe2yVmrssgz6Um9nQNuSkPu8a
         BXEeyvlSx/qn96I1mQGtPILU7jo8q9yK2KtUlh3zkkY42ys/WKkFEgpcfqcRQC3CFMim
         LHbtsgtU90E+lzjYI7/to06enj7elEN7vJB4hjBEe8c5q0Nrg3mkwu/dRnUai8b8kDQS
         6PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFnw8MD4jHwQnFsI2R3PlXPaqZK7gGQfobFNAVzerVY=;
        b=qA7rh4A8BJcIZ4k7WHMIkTxnJ9eomIm2jv1tRUeEgxFZS6Ls1Y1CxK9JOFroyNbyzK
         Jdk1e27MflIDus1vcfktcAl1Iyi8b1pWXAg2DTOUX3FXMDArpDq8H+FBVKp4XQwzT7qn
         al0U9ebxbh/R/quvYT7SAzTLZnhn1i1JfG+LYstVauJ82mmQ7gZFO+0fAmaTx5rztWIJ
         dgZRf8/CNjnO3I1lRSFC8Cg4a7kZfbACatSZsRh0wXSzXJuaOkwO1BC8F9MlJz57MWvy
         UW4E8R+mUF5P5oSVlw3wuIA7abq87iO2QRnjIF1OJ0BqOufFHy0SOPRQIcgHYs6GgRzf
         scjg==
X-Gm-Message-State: APjAAAUa6DaMhNOnkpWvj55nL7/CP4hciUnxC60FjRNQ53x6vtZW7uKL
        uiI8td6bVVL06tAR/uZqoICqcnZ8B8E=
X-Google-Smtp-Source: APXvYqyoEYperiKWwpN364JjNb40LJ5GgP3v7HBpOLgvSD5I4/C5TUnfe/aKs9+5yQUc8KO3b+1qwA==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr9066437wma.39.1574943526990;
        Thu, 28 Nov 2019 04:18:46 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id a26sm9907809wmm.14.2019.11.28.04.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:18:45 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:18:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] dt-bindings: clock: tegra: Remove pmc clock ids
 from clock dt-bindings
Message-ID: <20191128121844.GA2300319@ulmo>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <1574830773-14892-7-git-send-email-skomatineni@nvidia.com>
 <22ab4e93-bf94-5c73-b4b9-6cf36d329b97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <22ab4e93-bf94-5c73-b4b9-6cf36d329b97@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 05:32:30PM +0300, Dmitry Osipenko wrote:
> 27.11.2019 07:59, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra pmc clocks.
> >=20
> > This patch removes ids for these clocks from Tegra clock dt-bindings.
> >=20
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
> >  include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
> >  include/dt-bindings/clock/tegra20-car.h         |  2 +-
> >  include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
> >  include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
> >  5 files changed, 29 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bind=
ings/clock/tegra114-car.h
> > index bb5c2c999c05..9175cd0571b5 100644
> > --- a/include/dt-bindings/clock/tegra114-car.h
> > +++ b/include/dt-bindings/clock/tegra114-car.h
> > @@ -270,10 +270,10 @@
> >  #define TEGRA114_CLK_AUDIO3 242
> >  #define TEGRA114_CLK_AUDIO4 243
> >  #define TEGRA114_CLK_SPDIF 244
> > -#define TEGRA114_CLK_CLK_OUT_1 245
> > -#define TEGRA114_CLK_CLK_OUT_2 246
> > -#define TEGRA114_CLK_CLK_OUT_3 247
> > -#define TEGRA114_CLK_BLINK 248
> > +/* 245 */
> > +/* 246 */
> > +/* 247 */
> > +/* 248 */
> >  /* 249 */
> >  /* 250 */
> >  /* 251 */
> > @@ -333,9 +333,9 @@
> >  #define TEGRA114_CLK_AUDIO3_MUX 303
> >  #define TEGRA114_CLK_AUDIO4_MUX 304
> >  #define TEGRA114_CLK_SPDIF_MUX 305
> > -#define TEGRA114_CLK_CLK_OUT_1_MUX 306
> > -#define TEGRA114_CLK_CLK_OUT_2_MUX 307
> > -#define TEGRA114_CLK_CLK_OUT_3_MUX 308
> > +/* 306 */
> > +/* 307 */
> > +/* 308 */
> >  #define TEGRA114_CLK_DSIA_MUX 309
> >  #define TEGRA114_CLK_DSIB_MUX 310
> >  #define TEGRA114_CLK_XUSB_SS_DIV2 311
> > diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/=
dt-bindings/clock/tegra124-car-common.h
> > index 0c4f5be0a742..90a0c5e7eb5f 100644
> > --- a/include/dt-bindings/clock/tegra124-car-common.h
> > +++ b/include/dt-bindings/clock/tegra124-car-common.h
> > @@ -269,10 +269,10 @@
> >  #define TEGRA124_CLK_AUDIO3 242
> >  #define TEGRA124_CLK_AUDIO4 243
> >  #define TEGRA124_CLK_SPDIF 244
> > -#define TEGRA124_CLK_CLK_OUT_1 245
> > -#define TEGRA124_CLK_CLK_OUT_2 246
> > -#define TEGRA124_CLK_CLK_OUT_3 247
> > -#define TEGRA124_CLK_BLINK 248
> > +/* 245 */
> > +/* 246 */
> > +/* 247 */
> > +/* 248 */
> >  /* 249 */
> >  /* 250 */
> >  /* 251 */
> > @@ -332,9 +332,9 @@
> >  #define TEGRA124_CLK_AUDIO3_MUX 303
> >  #define TEGRA124_CLK_AUDIO4_MUX 304
> >  #define TEGRA124_CLK_SPDIF_MUX 305
> > -#define TEGRA124_CLK_CLK_OUT_1_MUX 306
> > -#define TEGRA124_CLK_CLK_OUT_2_MUX 307
> > -#define TEGRA124_CLK_CLK_OUT_3_MUX 308
> > +/* 306 */
> > +/* 307 */
> > +/* 308 */
> >  /* 309 */
> >  /* 310 */
> >  #define TEGRA124_CLK_SOR0_LVDS 311 /* deprecated */
> > diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindi=
ngs/clock/tegra20-car.h
> > index b21a0eb32921..fe541f627965 100644
> > --- a/include/dt-bindings/clock/tegra20-car.h
> > +++ b/include/dt-bindings/clock/tegra20-car.h
> > @@ -131,7 +131,7 @@
> >  #define TEGRA20_CLK_CCLK 108
> >  #define TEGRA20_CLK_HCLK 109
> >  #define TEGRA20_CLK_PCLK 110
> > -#define TEGRA20_CLK_BLINK 111
> > +/* 111 */
> >  #define TEGRA20_CLK_PLL_A 112
> >  #define TEGRA20_CLK_PLL_A_OUT0 113
> >  #define TEGRA20_CLK_PLL_C 114
> > diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bind=
ings/clock/tegra210-car.h
> > index 44f60623f99b..a3d8d3e75728 100644
> > --- a/include/dt-bindings/clock/tegra210-car.h
> > +++ b/include/dt-bindings/clock/tegra210-car.h
> > @@ -304,10 +304,10 @@
> >  #define TEGRA210_CLK_AUDIO3 274
> >  #define TEGRA210_CLK_AUDIO4 275
> >  #define TEGRA210_CLK_SPDIF 276
> > -#define TEGRA210_CLK_CLK_OUT_1 277
> > -#define TEGRA210_CLK_CLK_OUT_2 278
> > -#define TEGRA210_CLK_CLK_OUT_3 279
> > -#define TEGRA210_CLK_BLINK 280
> > +/* 277 */
> > +/* 278 */
> > +/* 279 */
> > +/* 280 */
> >  #define TEGRA210_CLK_SOR0_LVDS 281 /* deprecated */
> >  #define TEGRA210_CLK_SOR0_OUT 281
> >  #define TEGRA210_CLK_SOR1_OUT 282
> > @@ -386,9 +386,9 @@
> >  #define TEGRA210_CLK_AUDIO3_MUX 353
> >  #define TEGRA210_CLK_AUDIO4_MUX 354
> >  #define TEGRA210_CLK_SPDIF_MUX 355
> > -#define TEGRA210_CLK_CLK_OUT_1_MUX 356
> > -#define TEGRA210_CLK_CLK_OUT_2_MUX 357
> > -#define TEGRA210_CLK_CLK_OUT_3_MUX 358
> > +/* 356 */
> > +/* 357 */
> > +/* 358 */
> >  #define TEGRA210_CLK_DSIA_MUX 359
> >  #define TEGRA210_CLK_DSIB_MUX 360
> >  /* 361 */
> > diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindi=
ngs/clock/tegra30-car.h
> > index 3c90f1535551..20ef2462d9e1 100644
> > --- a/include/dt-bindings/clock/tegra30-car.h
> > +++ b/include/dt-bindings/clock/tegra30-car.h
> > @@ -230,11 +230,11 @@
> >  #define TEGRA30_CLK_AUDIO3 204
> >  #define TEGRA30_CLK_AUDIO4 205
> >  #define TEGRA30_CLK_SPDIF 206
> > -#define TEGRA30_CLK_CLK_OUT_1 207 /* (extern1) */
> > -#define TEGRA30_CLK_CLK_OUT_2 208 /* (extern2) */
> > -#define TEGRA30_CLK_CLK_OUT_3 209 /* (extern3) */
> > +/* 207 */
> > +/* 208 */
> > +/* 209 */
> >  #define TEGRA30_CLK_SCLK 210
> > -#define TEGRA30_CLK_BLINK 211
> > +/* 211 */
> >  #define TEGRA30_CLK_CCLK_G 212
> >  #define TEGRA30_CLK_CCLK_LP 213
> >  #define TEGRA30_CLK_TWD 214
> > @@ -260,9 +260,9 @@
> >  /* 297 */
> >  /* 298 */
> >  /* 299 */
> > -#define TEGRA30_CLK_CLK_OUT_1_MUX 300
> > -#define TEGRA30_CLK_CLK_OUT_2_MUX 301
> > -#define TEGRA30_CLK_CLK_OUT_3_MUX 302
> > +/* 300 */
> > +/* 301 */
> > +/* 302 */
> >  #define TEGRA30_CLK_AUDIO0_MUX 303
> >  #define TEGRA30_CLK_AUDIO1_MUX 304
> >  #define TEGRA30_CLK_AUDIO2_MUX 305
> >=20
>=20
> This a device-tree ABI breakage and I'm not sure that it's okay to break
> older device-trees (Pixel C Smaug board), maybe some kind of fallback is
> needed.

The Smaug support was never really official. I don't think anybody uses
upstream on it "for real" because there's a very limited set of features
that we do support. My understanding is that there is a community around
Pixel C that runs their own forks with some more features and they have
occasionally upstreamed bits and pieces of that.

So given how far behind we are with Smaug, I don't think breaking ABI
stability is really a problem in this case.

Jon, we used to have a Smaug system in our internal upstream testing,
but that's no longer the case. If we ever were to reinstate that
testing, updating the DTB shouldn't be a problem, right? My recollection
is that updating the DTB was always done hand in hand with the kernel
update.

Thierry

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3fuyEACgkQ3SOs138+
s6Ghgw//bCb6lt837QID9Q1WO7BEgi2+4lnNZfmuP/5OjKBXMtmgG/9fv1nSbT6s
GfJr6XUCbCTZXAiGF/STTPaa/1v+xlSklSVsSD38MXbqMueQqN09wfd/ho6r7FVH
/93BPk34DUtFFTQRSB5a230XwkiI3FS+Dx4j+Etx3jrGhXyVi+wNAmewwRG5aFna
O0XL3c2sghHtRXNwrBZFcqTe+Co27CAQQma5mwdW26SghRfmOkaPJ0FXZqBgAvr4
lCtel65eFWrQ0a2p7ncBh7r83seRmTVlgB3oj3WLgjfD4K9bLEkrfFTXbD+r1RHa
Qr9AQ4Xdd2rRbtRumYWGu9rMJxaJ0VkIVt2Xk6LTb5A2mbJSI3c/XPB0NYVRgr6m
jKdsw08GqidOYCBCD4Qt+IsECH6xas8XMK1j4SCbJyZApREK9srnAiAlpWRbv6Me
c03ulVk3uamy/ioBJeMxGQN3UJ/iM1YLL+XfKwowP3vcY8MYRD1n1dL4CmRUiQt/
4HBZLyPjb1zTJLE5vBEJQY4S3RJ1AdXKUsa6QIn0jotSLgcaZcoQ+gmf0eTuEiKB
CLHle2pcutTQfmhznmblf4Ak8Ic+PIfGQz7UYDU/WE4He6ErDV6bjwpxP1NnF6Vt
c1jYgV9XRZIOherjhHEvOvfG/AojaxjzymLjuFJKR7N2gHy5Fxo=
=6wWI
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
