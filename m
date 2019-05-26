Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3BDC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEE420863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1uQWPIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfEZSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 14:47:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34881 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfEZSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 14:47:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id s69so5593579ybi.2;
        Sun, 26 May 2019 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dH+6euD3B/9U0jUYqmwCTtJnJvDIWL4nGrMm/sJmAbk=;
        b=q1uQWPIXf6n7CSZVMkB81U0t5u4wk16K6Z4bYxaUjaY6GyKMNeUNBq1UregxK9PZJD
         5pG/s/7VAQS0uBM0QzSa6AFpPBr1HXM7KPbb1z3etQgMn31w3cf1hoi4PTCAOVIHAWFE
         x7uKPAMdYaWCGVuAn/dXAX2Sg8IJSFXCr2bf28Nx8M6yi731QAJm9TttmwRJ+7uIStDR
         cykxfVwBxPxXYXD6G/8PjJwDWBS93kHa4sXAB6SM7c2NIH64KBqzu9kT26/h6HULwJIF
         7wvkLvKxaywz/7T9bac3bCb8TRciPUKT3XO8PzdaSGfe3qIYAcTzJBuRvYR2doocDDuW
         oBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dH+6euD3B/9U0jUYqmwCTtJnJvDIWL4nGrMm/sJmAbk=;
        b=DlQ/e5LgSjZPJRIfJr6JUv0X5H/uAWJsGlAzwc343CqS+ISQl3yYAXcBmIRZDGCPvL
         lIc3t/TiZQwLuTj47C4Rlh7V/LCzwMxw4RwPud23fSCLxMGMnPUNlTOFIRsOpE7JsElx
         7+SBU87zHaAenJcdBgNwCGc9gej6hpPucYQIh7Itu1AR6ntFiPRlpwZ8v/IYSrZoSxvI
         aXUerNhn6Tb2CI+U91ypbU7WZG1aPpt4/bpAQTYWmul1HwL99enGSVJeZ75IeHJfM/y5
         4F2NJlsoMi+Xg7LVrPt5YzW7Sx5OPjii9ViXLKEk00S6zLVLJ77hLCLei4r4o+/WbAK5
         eRBg==
X-Gm-Message-State: APjAAAXlbJSKj4Loe1zq7D08brfq82xopqJdtW3iK1XW1zDlohsBCUDQ
        1a2/tzzAIZrgB/KpPGJng2HBld4DGVspCIxXXgw=
X-Google-Smtp-Source: APXvYqxyveUEULLdiXn9xTempg9RokzTgBzz+s8S8SgwFeVu0aCdcbHIFT8+mi573Ck83EXCxT0cCvaTPPxJknmnL0U=
X-Received: by 2002:a25:340e:: with SMTP id b14mr13139570yba.82.1558896466232;
 Sun, 26 May 2019 11:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190525162323.20216-1-peron.clem@gmail.com> <20190525162323.20216-2-peron.clem@gmail.com>
 <20190526182220.hgajlcyssujjkmiu@flea>
In-Reply-To: <20190526182220.hgajlcyssujjkmiu@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 26 May 2019 20:47:35 +0200
Message-ID: <CAJiuCcf4d-5-U++wQ4wkrcSSk_SyeuHnxyz0DMvHaS4YuOsx3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Sun, 26 May 2019 at 20:22, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Sat, May 25, 2019 at 06:23:17PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > size and a sligher difference in memory mapping compare to H3/A64.
> >
> > This make it not compatible with the previous generation.
> >
> > Introduce a specific bindings for H6 SoC.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.=
txt b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> > index 0c64a209c2e9..c0fbb50a4df9 100644
> > --- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> > +++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> > @@ -7,10 +7,11 @@ For now only playback is supported.
> >
> >  Required properties:
> >
> > -  - compatible               : should be one of the following:
> > +  - compatible               : Should be one of the following:
> >      - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> >      - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
> >      - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
> > +    - "allwinner,sun50i-h6-spdif": for the allwinner H6 SoC
>
> This won't apply anymore on top of next, we've moved to a YAML
> schemas.

Indeed I have based this series on sunxi instead of sound.
Thanks for pointing out that.
Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
