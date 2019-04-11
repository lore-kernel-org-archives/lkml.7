Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB6CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891EA2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrBxyLg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDKIDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:03:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33586 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKIDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:03:49 -0400
Received: by mail-yb1-f196.google.com with SMTP id i10so1887806ybk.0;
        Thu, 11 Apr 2019 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G1Eh5XGlUhBTroTN8KlOG5VLbPVWXMJdN5t7O2mNSbQ=;
        b=IrBxyLg8sILajktZW0qEBknc4m3hjivo8+QW+gCNq39o7K4BVq+YagRG9u7FRKGw5e
         SOsY2WMarU7e42GMqfCQg3MLXhEDr2JEg4gQ5Ui9hD8jxTOwRIfRQogZ8df/Jq24JP8E
         5+rL8hpW/M0aJzFslHJ1ucPSEvSReL6Xq+g8Al2fQoCyAQDe+zCh+t16ECD0xJ89ciMX
         eCrgHdFrzRtO3fr3p2rUnU2RVExkI5ENpnpjJ4xlgrzejcJ6kphwmZUTLki+TlaAsubk
         psk4SafvHZ2gwhzlpwdN/iczohsD2Z3cRkHwZjmw9aOMRH69RtvuFXzLbmBhTnwB2TZa
         Tj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G1Eh5XGlUhBTroTN8KlOG5VLbPVWXMJdN5t7O2mNSbQ=;
        b=jfZn6OXTt9AJ6SvSUeff4nj1RrmXBYRSrmtEUOgXWC+UzJyUmsyQ6QggfNtg1RLfiV
         XUi7Axui9SR+70IZ2r13PS4mVOR24rfRj2o2a8R7+z0qEyx0agTuZkbeae7tI0WWLzmm
         PhU7fb7eyjxKL3fuosm9qajpRBAmKDcgA9pMcPbRuj2qU1bp/P8nvRHqtndKBszqLE4P
         qYrBfCY+ZoNbPzyus2WMFx/pqHOESdTRE/E3RI9j33Z2jhjCrbhLcwVuzaVGNLLLPXlr
         tGnHol1ZXoDUd+MOU2jCv6H/xNF+IQQIlW3aLx5sO8h28ABOVLQ8NwFj7eQkVDALTjTV
         NQ/A==
X-Gm-Message-State: APjAAAVpO4y6jGICRqDIEvEMbeXREm4qE7d0/AWh0YsbLLGbEcxuS94s
        Za9pYIkOeJ7llmvFil2JvG/pzM6XAhwpKD8FOqY=
X-Google-Smtp-Source: APXvYqwLxmj4W8a587doUdO7xouO3dU/6ssH2Ec3DZnsc8wd0wzxobExNiLooOWRDs/m6ptT4LIs31HdQH+QGgY9rs4=
X-Received: by 2002:a25:ba87:: with SMTP id s7mr39161683ybg.49.1554969828276;
 Thu, 11 Apr 2019 01:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190410232543.13297-1-peron.clem@gmail.com> <20190410232543.13297-4-peron.clem@gmail.com>
 <20190411072724.qdhfvdhjce5sopzi@flea>
In-Reply-To: <20190411072724.qdhfvdhjce5sopzi@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 11 Apr 2019 10:03:29 +0200
Message-ID: <CAJiuCcdo2etQhiVpLS98cv=dt1N+2p-+fGhieBDS2iaBCeORPg@mail.gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2019 at 09:27, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Thu, Apr 11, 2019 at 01:25:38AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > This add the H6 mali compatible in the dt-bindings to later support
> > specific implementation.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../devicetree/bindings/gpu/arm,mali-midgard.txt          | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt=
 b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > index 2e8bbce35695..9e71146b5c8a 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >      + "arm,mali-t860"
> >      + "arm,mali-t880"
> >    * which must be preceded by one of the following vendor specifics:
> > +    + "allwinner,sun50i-h6-mali"
> >      + "amlogic,meson-gxm-mali"
> >      + "rockchip,rk3288-mali"
> >      + "rockchip,rk3399-mali"
> > @@ -49,9 +50,14 @@ Vendor-specific bindings
> >  ------------------------
> >
> >  The Mali GPU is integrated very differently from one SoC to
> > -another. In order to accomodate those differences, you have the option
> > +another. In order to accommodate those differences, you have the optio=
n
> >  to specify one more vendor-specific compatible, among:
> >
> > +- "allwinner,sun50i-h6-mali"
> > +  Required properties:
> > +  - resets: Should contain phandle of :
> > +    + GPU reset line
> > +
>
> And clocks, I assume?
Yes you're right clocks are also required for the H6.

Clement
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
