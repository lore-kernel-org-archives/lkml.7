Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F344C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C63214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqUxwX/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDWGXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:23:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43957 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:23:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id j20so11507219edq.10;
        Mon, 22 Apr 2019 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+ee48vbZLISdDZkyHG6SCZLYTIDZDGi2Hax1YAuvFY=;
        b=WqUxwX/LxHCayNtu983rUMlo2qPvrw+Vo4ZgqW+eoMuI3gyfT10IS6KL6O9JnQUNoM
         sYFNDi9zjpb5jGg7ECL1IMab25Dw7Y45H4tlH/gH5vGWorpt/VRtye67eS/zwlTgfUxn
         HK8oOxCXHsNqzDwUs/xg2dWUI9jzZSgVgtIsd2gu2iVx0rdiy/amJxR6jiN2sgNvASyP
         Rgx1eQcJ5pUXjZeSvxHUqTUFGg6agfi5SRuSTM7oiP6uyikDrspsrz2RxR+w6HaFrT11
         HqOeb/5HciSXUctapc9+RAQ9zPp7SoH13lMiVtS7jxPc04CJIoWxXLeNlUy6jQRJA1p6
         5xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+ee48vbZLISdDZkyHG6SCZLYTIDZDGi2Hax1YAuvFY=;
        b=GkpO1UfnygzprsqPT9yI7iFSTEEfWEbVYhBOqbmP8pXBdoNyVn7gpRprT0DIkzIZRQ
         K+LdfwkYkOSG9+FYJtKqbNxL8tUcVfHz5+k+ljCQKt+LtmrFvPhnzfVNnXnihx2eNWh8
         TGUvglaEUXMpRMuYpVfnBwrGOv6b+rqkO7nxF9KZI2Swe8EMhNWtgjItdSMtv41Cb2Up
         FxQlugsd//8AXT7fu7JfqEwH9MEk55lwxOmFKrZfWO1vX2rkvHkyB8wVfPAdv0zc0SET
         P/gLOFxvXuTaxYTajlZ4xuKgLu3LHsALFijMCfHHh33oTLMO6PafIY3NOF9vRJ5aYC9J
         i/SA==
X-Gm-Message-State: APjAAAVW9eNGvYdhQXqUMyKCqsTur4uXHIbRJbn+FsXkQEaLsvjE/b9F
        EcKljYrkMnHlVOVjab2XmQZ337Rko2LYm7g+HwA=
X-Google-Smtp-Source: APXvYqw7c9bRvYFqj32p6ELv1N3THBgesEVV8JigpRtrvU0rP8NnhKBWtXM2KMV6z2qnuTi+M2JI9nxgeONs7kDXvMg=
X-Received: by 2002:a17:906:2481:: with SMTP id e1mr11889258ejb.22.1556000579082;
 Mon, 22 Apr 2019 23:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190422193542.2853-1-daniel.baluta@nxp.com> <20190422193542.2853-3-daniel.baluta@nxp.com>
 <20190423051738.tmyto7nvm4w5zt4r@pengutronix.de>
In-Reply-To: <20190423051738.tmyto7nvm4w5zt4r@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 23 Apr 2019 09:22:48 +0300
Message-ID: <CAEnQRZD5506EdkO5ESwWe+=J-uEeZw9m47_XNj8DUHy4Hck78g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Tue, Apr 23, 2019 at 8:19 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Daniel,
>
> On 19-04-22 19:36, Daniel Baluta wrote:
> > i.MX8MM has one wm8524 audio codec connected with
> > SAI3 digital audio interface.
> >
> > This patch uses simple-card machine driver in order
> > to enable wm8524 codec.
> >
> > We need to set:
> >       * SAI3 pinctrl configuration
> >       * clock hierarchy
> >       * codec node
> >       * simple-card configuration
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 48 ++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > index 2d5d89475b76..207b13266a96 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > @@ -37,6 +37,35 @@
> >               gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> >               enable-active-high;
> >       };
> > +
> > +     wm8524: audio-codec {
> > +             #sound-dai-cells = <0>;
> > +             compatible = "wlf,wm8524";
> > +             wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
>
> I would mux the gpio where I use them.

I'm not sure I understand this. Can you provide an example.
>
> > +     };
> > +
> > +     sound-wm8524 {
> > +             compatible = "simple-audio-card";
> > +             simple-audio-card,name = "wm8524-audio";
> > +             simple-audio-card,format = "i2s";
> > +             simple-audio-card,frame-master = <&cpudai>;
> > +             simple-audio-card,bitclock-master = <&cpudai>;
> > +             simple-audio-card,widgets =
> > +                     "Line", "Left Line Out Jack",
> > +                     "Line", "Right Line Out Jack";
> > +             simple-audio-card,routing =
> > +                     "Left Line Out Jack", "LINEVOUTL",
> > +                     "Right Line Out Jack", "LINEVOUTR";
> > +
> > +             cpudai: simple-audio-card,cpu {
> > +                     sound-dai = <&sai3>;
> > +             };
> > +
> > +             link_codec: simple-audio-card,codec {
>
> Can you drop that phandle?

I see your point here. But for symmetry and consistency with
imx8mm-evk I would prefer
to keep it like that.

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mq-evk.dts?h=for-next#n59
