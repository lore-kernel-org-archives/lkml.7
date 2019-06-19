Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63675C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA74206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560938942;
	bh=KKvDwu+I2C1EkI77Psheqy+KG+PofgRIdUQS/TBoP64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=enyNqWtiiitkCfH3DdaGlEGqfxubnzQBQf866pSVfEgKygszglEXz3yqasi2PqZlo
	 TtdMEzFxOendz/k2V9ye1dQLDGicobF4CVufQxVi5VnXSeZqb8tkNJfWgojfu7pCH6
	 iSlUwPMuYwdqvWwhEKmRHwdDEZZs2Y+ySD8rSQow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfFSKJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfFSKJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:09:00 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B470821655;
        Wed, 19 Jun 2019 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560938939;
        bh=KKvDwu+I2C1EkI77Psheqy+KG+PofgRIdUQS/TBoP64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UyI997+YuS2xnVlzmo5wKGej2P2Ay4u//ydoLlc1kZ+fFsr7x3BNtk8A0JXPQUdwq
         4pAeNxELN5wdf1nLJ2k16enZ9Qqdvouqb+NrFeoPAcupz2NXKOVuidBk9XfNdANmvD
         dsWBqVIKvgVTu7uEGfO2DZbWBZVi572XTeuej3Do=
Received: by mail-lf1-f43.google.com with SMTP id j29so11628561lfk.10;
        Wed, 19 Jun 2019 03:08:58 -0700 (PDT)
X-Gm-Message-State: APjAAAU20NTH3nBMNafAt4qP/xVtCwF2h7tf/EgtaJAXezBpQg34L38i
        yV7HyLikbg7H7TXtL1dKAl0GvDLcJsHDhGb8xeQ=
X-Google-Smtp-Source: APXvYqw8QzBck4su84jvxKMOq+3rh/piGZ7mbYb6bKW0wol+fphlsvgB8RGiXr8AGwrbQ/+jguHe0FrtMGU6s3ny/Uk=
X-Received: by 2002:a19:4f50:: with SMTP id a16mr253073lfk.24.1560938936806;
 Wed, 19 Jun 2019 03:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190618190534.4951-1-krzk@kernel.org> <CGME20190618190551epcas2p38f3c93da2a05117c7741468bb5a7784c@epcas2p3.samsung.com>
 <20190618190534.4951-2-krzk@kernel.org> <9d16d4f7-8353-e0f0-a005-1b04457d70f0@samsung.com>
In-Reply-To: <9d16d4f7-8353-e0f0-a005-1b04457d70f0@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 19 Jun 2019 12:08:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeBBXd2vhBPq6BMzvdRf1_f8d9Pd=_N1X0chHLVbhi0rQ@mail.gmail.com>
Message-ID: <CAJKOXPeBBXd2vhBPq6BMzvdRf1_f8d9Pd=_N1X0chHLVbhi0rQ@mail.gmail.com>
Subject: Re: [RFT 01/10] dt-bindings: gpu: mali: Add Samsung compatibles for
 Midgard and Utgard
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 at 12:01, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzysztof,
>
> On 2019-06-18 21:05, Krzysztof Kozlowski wrote:
> > Add vendor compatibles for specific implementation of Mali Utgard
> > (Exynos3250, Exynos4-family) and Midgard (Exynos5433, Exynos7).
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 1 +
> >   Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt  | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > index e5ad3b2afe17..9b298edec5b2 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > @@ -17,6 +17,7 @@ Required properties:
> >     * which must be preceded by one of the following vendor specifics:
> >       + "allwinner,sun50i-h6-mali"
> >       + "amlogic,meson-gxm-mali"
> > +    + "samsung,exynos5433-mali"
> >       + "rockchip,rk3288-mali"
> >       + "rockchip,rk3399-mali"
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > index ae63f09fda7d..519018cb860b 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
> > @@ -17,6 +17,7 @@ Required properties:
> >         + amlogic,meson8b-mali
> >         + amlogic,meson-gxbb-mali
> >         + amlogic,meson-gxl-mali
> > +      + samsung,exynos3250-mali
> I would prefer 'samsung,exynos4-mali', because historically Exynos4 was
> the first SoC with Mali400 and such prefix is already used for many hw
> blocks.

Then maybe samsung,exynos4210-mali so it will not be confused with Exynos4415?

Best regards,
Krzysztof
