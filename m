Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147AAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77A4206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf6nMCdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfC2LUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:20:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43621 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfC2LUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:20:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so1673855ede.10;
        Fri, 29 Mar 2019 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZNxiNe/9OvgDUZwBzWW1bjx24BWsVYokMBMaOI4hMM=;
        b=Bf6nMCdiOWwlEsapP9pvE+F5T/yysxaRa9Lr1TpwuN+LqVHZxy361SJCtmp+mtY540
         LYEbndCPKnaqJRP4idRETOktS2uFNGX+Vsiossi22uocxQHkQctdi7vdbGScQvmENPQc
         xVpoVi+xyi6QaXC5bLe1ztqzhT4pN6ANMQBGT01NSG0VIQS3gb1jku0LpmRceySdaYZe
         +Rx1BqV1gNb04+kW6H7WmBa6b2E1yg/CzcZXXLIp5CNbtvumR4kZh7DTnL1WMet+osPV
         fV3Vcj4YvCk0FZZZIHr4gqHXhIDdFz6BTnnSesEL0vaObxvSHYwf6F9SXIQBsSU7XWh7
         nF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZNxiNe/9OvgDUZwBzWW1bjx24BWsVYokMBMaOI4hMM=;
        b=U22VnmPECnDhR10EMLbu5T1ibovlDi5WsjjVfgc4nUB88diJNP3T3kN2VwPLOoKHLp
         JmAudDpRI96uijvLvy59ADtjNVcHUUje4jOkUVX1zT014tRUsLtUky85vUV4ZmWMVRbv
         hoCB/VVmI30rMoERDX71KwBA+OW50xPZbHu4S62Yy5tr6W+PpnXhk8RszloHA2tnJScN
         K4j6mpQ5WBGen48unRW897SnmtQj6wfh+U4mNniC+QsZNrQEdTwVfVLTSCFBz2dBwmMK
         j73ZSLF1WatqIpTF+ukenITa7yKnWaSSctZ94So49RL9Eh5beYgfgTvnYSY5VZBNH9Z/
         PmoQ==
X-Gm-Message-State: APjAAAXwaYaGKwuBtODjDAyiej4LVG49HR7yvEv1SanHwycn52er4rL9
        U39X8PPMOF1Ua7K1dwHBqEz/Hk0iI6a4wPktMmw=
X-Google-Smtp-Source: APXvYqwc/A+osu0nfPQEWyActGgLrwzVXHz7qlyvcN2NHkdYyATaef5piS29qvYnnCXKamoO/0k1ojNd28vU0esTVJ0=
X-Received: by 2002:a50:90e4:: with SMTP id d33mr31389213eda.265.1553858412442;
 Fri, 29 Mar 2019 04:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190328133828.20999-1-angus@akkea.ca> <20190328133828.20999-2-angus@akkea.ca>
 <AM0PR04MB421112C3EE79B279953A9252805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421112C3EE79B279953A9252805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 29 Mar 2019 13:20:00 +0200
Message-ID: <CAEnQRZCjCAhi2OqpSGN8rmGYCqyOmLP=+=L0djcq2C6ksk29LQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:11 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Angus Ainslie (Purism) [mailto:angus@akkea.ca]
> > Sent: Thursday, March 28, 2019 9:38 PM
> >
> > Fix a typo in the compatible string
> >
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 81d5ce1b1ec1..07099f82965e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -720,7 +720,7 @@
> >                       };
> >
> >                       sdma1: sdma@30bd0000 {
> > -                             compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
> > +                             compatible = "fsl,mx8mq-sdma","fsl,imx7d-sdma";
>
> This is a bit strange.
> If binding doc says like that, probably we'd better fix the typo in binding doc
> to use the same style.

Oh, indeed.

Angus, shouldn't this be fsl,imx8mq-sdma instead of fsl,mx8mq-sdma. I
was just paying
attention to the extra space in my patch.
