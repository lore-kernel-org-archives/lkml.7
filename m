Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3254BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF620693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdTchBIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfG3MCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:02:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53113 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfG3MCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:02:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so56873198wms.2;
        Tue, 30 Jul 2019 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tt3AOcyXKV0IKTdpiUgJmlQW7AFYrTvWnfWkl3EFYV0=;
        b=DdTchBIzR49p1do0ixk4FGygfA12+2grKmIoZ2yLj1ahaobmMEjFjuAVbAzJ75eEBJ
         W0BU0ufoQrtTv95Df+kramh8NuyZqPKkDG8Ehv8zjjnYMANetIi52daq984sEQdAhrj0
         TeMD6LnqG1kwFsfgJPUqO+yjQRoqPyHxArn6LwcuXc6/ZyAHtMZn7797XwY1BfBQxgkf
         xrqjR+q0LA/3J+aecFu4pB6tyFiAyF2CBbPbU5SeBkV/2fDw/DUgBp9YCS4f+gRQkvKI
         gygk4s9xcDwm4ueMdql/4ATbDD/OjKgwVQbUaJ44IVTu5nlv5GHfU4EEIe03lwhoDIhp
         O4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tt3AOcyXKV0IKTdpiUgJmlQW7AFYrTvWnfWkl3EFYV0=;
        b=TC30Dpg14SCEy+p4ILM1Qn1BVQKqENGJPxevvr+kIVNFhtfQZvWYO+lP3VHz5cyfzR
         y9ZQ+Cvxv3bc4Ce2qytWmkg+Ggtmo1WsIZqkk2zU4PxjGst4NTq84Qj6Eikl2rAO7rOk
         IytkmjoqKV7XrrHcaIXb/P8GZTSYobsE7kww86aOXRH5l1bmGuxIgQybqgHLh4upOuqG
         lJfhCKx+7PMaP4NA1aUXBycUK4BxlTs3OQ9iBMeb/Dh40CZ7G3idaHAFqmXGf9q7zTzQ
         NGo6uZm4J2etpWEWGJZIOBbYZYYBG8jgsFz/byNku0U0ZDycqoPRAa+NqlTsRL3Dt1xs
         SfOQ==
X-Gm-Message-State: APjAAAXW6/UkXzTQaWMnguDSPvsr/+tPsvf4Ta+7mQkZzJGhi1DOrTzo
        eoagy6ChVOXF7kMoFPyzpc57CecdW4hzvyNVE2s=
X-Google-Smtp-Source: APXvYqwghX6WkVGHF+i6a+U4+65mHT4/Hpn8Bch0SCYfGIaMV4TncRfMk7olObeb7KKke5CJSErAP7e2stA6hFGyGps=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr109385481wmj.13.1564488162043;
 Tue, 30 Jul 2019 05:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-8-daniel.baluta@nxp.com>
 <20190730080135.GB5892@Asurada>
In-Reply-To: <20190730080135.GB5892@Asurada>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 30 Jul 2019 15:02:30 +0300
Message-ID: <CAEnQRZAUOzmP2yPb4utyDTnYUDNyqesXJPb5-Ms0tfPy8TMBig@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 7/7] ASoC: dt-bindings: Introduce
 compatible strings for 7ULP and 8MQ
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:02 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 10:24:29PM +0300, Daniel Baluta wrote:
> > For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
> > strings to differentiate this.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index 2b38036a4883..b008e9cfedc1 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -8,7 +8,8 @@ codec/DSP interfaces.
> >  Required properties:
> >
> >    - compatible               : Compatible list, contains "fsl,vf610-sai",
> > -                       "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
> > +                       "fsl,imx6sx-sai", "fsl,imx6ul-sai",
> > +                       "fsl,imx7ulp-sai", "fsl,imx8mq-sai".
>
> A nit, could have that 'or' :)

I removed the 'or' on purpose because I don't want to move it
around each time we add a new compatible.

Anyhow, I can put it back if this is the convention.
