Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69741C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA892067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EimbKafr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfKFQWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:22:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40111 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfKFQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:22:04 -0500
Received: by mail-io1-f67.google.com with SMTP id p6so27620463iod.7;
        Wed, 06 Nov 2019 08:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59XQ5SNoCKcU9R/PCRZyan3lCrtseemq8GIa0acmfkU=;
        b=EimbKafrvHiN3BqeZxgenZgrMpxL6E4An7CLk7ZVMlUQEPlY0T0b1oU+UNFZLUKz2j
         k5OrGyLdz9a8i5OyGiCqzCNp3/JA+iPYUNBmVa25SO237Jn3SGbT+D3VuAlDm94BFF+3
         pWBnQC+oXjBVTV9ecmFbZJwsM+UupVvXMQ7CrLWqtWXk0tK5X7WMLyruIv48PyK1yz44
         Fxbwl4/C53ZI61tzw4wzR1AifUolw3CeZWC2jqHBdIRytGo1jY435GE5rpcgLS70Q57v
         e8Tu149y9QKlxAkvgLd+ubV6GKlcXlFlSEa2p8xneHKzQiNN8/XmTNMWOu2qd28VR27r
         rYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59XQ5SNoCKcU9R/PCRZyan3lCrtseemq8GIa0acmfkU=;
        b=fv6uAZOM/K//QwwNFnlb+n+Aw7yBfx5MPK/GFEGNF5O1Be82sXqMfiOiR613KzkomY
         iIhD1kw7qjgXIY4ZcUHGJsqE8og8QotihI9uIYmu10afKozNrrX9q/7NUvpDwjuwps0G
         i8SbwJ3cQwmKymfmSEMFWUBhJY52iPi4rJ4zQBw6VWqOSR/ZAV23olheUeGWDfZqltF2
         MRNM0it3CfV2TkkPtKdH/DyiZDLhcP+NL1VMP05pl0R/NnFpvMmZ3tzl7KoqrzrpMeJu
         3OT57AQM03jv6Ez254tlg0znBzmMhH8JWHjZo3b2i2zut07nWs+EfZuktX/9R62ZUqLj
         wkKg==
X-Gm-Message-State: APjAAAX5I5Gj1vdfUq0y4I5C+F1etR065r54caxpFGIOqwZElKaV6J5L
        oyB1MxtrZakoR3CtOOGYyfnnTD86jUinRGWq8i4=
X-Google-Smtp-Source: APXvYqxLQgzXURaBRHPl1cBxULqCnEVqzdjEhkfMTD9htL1WTWIPDSZgvCkH+7/0Q5VQWQnNrR+kAlIJPF81zjHKrxI=
X-Received: by 2002:a5e:8c0a:: with SMTP id n10mr5241548ioj.78.1573057323206;
 Wed, 06 Nov 2019 08:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20191106142308.10511-1-aford173@gmail.com> <20191106161815.uwcoe7spn3seupaq@pengutronix.de>
In-Reply-To: <20191106161815.uwcoe7spn3seupaq@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 6 Nov 2019 10:21:52 -0600
Message-ID: <CAHCN7xLRJ8y7039iiCbrm5ZxgXyEdKtubYNNr8TcSBDHDNEENg@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: imx6q-logicpd: Enable ili2117a Touchscreen
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:18 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Adam,
>
> On 19-11-06 08:23, Adam Ford wrote:
> > The LCD used with the imx6q-logicpd board has an integrated
> > ili2117a touch controller connected to i2c1.
> >
> > This patch adds the node to enable this feature.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > ili2117 support is scheduled to be introduced for Kernel v5.5.
> >
> > V2:  Change node to touchscreen@26 and move comment about 5.5 to under the dashes
> >
> > diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
> > index d96ae54be338..7a3d1d3e54a9 100644
> > --- a/arch/arm/boot/dts/imx6q-logicpd.dts
> > +++ b/arch/arm/boot/dts/imx6q-logicpd.dts
> > @@ -73,6 +73,16 @@
> >       status = "okay";
> >  };
> >
> > +&i2c1 {
> > +     touchscreen@26 {
> > +             compatible = "ilitek,ili2117";
> > +             reg = <0x26>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_touchscreen>;
>
> This phandle already exists?

Yes it does exist, but it probably should not have been since there
was no user of it.  At least this fixes that.  :-)

adam

>
> Regards,
>   Marco
>
> > +             interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_RISING>;
> > +     };
> > +};
> > +
> >  &ldb {
> >       status = "okay";
> >
> > --
> > 2.20.1
> >
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
