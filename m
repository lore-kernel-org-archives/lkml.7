Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A923C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAD42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUX9VT8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfCML3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:29:25 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33748 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfCML3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:29:24 -0400
Received: by mail-ed1-f54.google.com with SMTP id d12so1189204edp.0;
        Wed, 13 Mar 2019 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaHS6lLWgrNLAc+oodSpbhdPL3EOi9KHTDGrU9ZVgp0=;
        b=XUX9VT8pVXcb8+bqb7zXGK2Cb57iRvC3/QqMbj3Sjge+2wT6FOsu+VIz5vg139EQNk
         sm/WIJjV1tQjGYc2ZlBJszYSXQAzk0wK1Krz9hYxbGrs30dVYD4Ypp2SqbFJrMzi4Esk
         GsBbZCUVjGFEY4BvJeRWMwk6UjPboOvjnG0tgrpy+416xFCVRZeoQaDUfEV9wkxigoHu
         qNfVUx9VQwczy+v/Szi9aJW+9ZRCx63OgPuHqAPaVkjTUEjcvm3wPiPZ1JdbcYMjCU2z
         cC6VT/6hwYYlAlUd2nPSGR0qexcHQ8p+9bHPSR87Eq47yClq+nCVhmM57MNxQeskQXTU
         tXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaHS6lLWgrNLAc+oodSpbhdPL3EOi9KHTDGrU9ZVgp0=;
        b=IwrlV0WyZqlXgPSKoENaDC87539ViO/B2GggzId3bTlcx0k47CEGndFjqEb4BLOdkD
         JPCpj75yGpEIZcU/00uA7qEBWQR9vv8Kx8fOh8s/Q6/HBdn+Na314mu2U7kPAC3M9OBK
         sotsGUICQX7QzRibTfJ/81TDW71L4ZcBIbkxIpY1p/N91pozE3CnTFzXJMhyMWuhyvk0
         HFO5uoYr1knOgKYntpiwdJRwec1JyEKR/CW/lvisLFZwMoLbeYgPLs2OWQGPYy8Rk6sk
         UH2+SJSeJv6fh3Ub5qB53uHfHKD06SfJXBlQyzfJz/wC7Dfj3TtRlXEigxlOBRQlkshN
         XjUQ==
X-Gm-Message-State: APjAAAXBuwJx04WhkaS3kLVs4J+U1IUDfI2p74tmmeqIombqux5hCqwt
        vMMoUcAJUniB3X7tUaCdi0xM1HzaOmA77A4E8FHlV1Pz
X-Google-Smtp-Source: APXvYqwGrL3664lc8agee0fLVURsnokfYzQuhvdfuRL6Y9zG555x9Obt4UcFOxl6C48AsijpAmamcMypSq+OH83p/8Y=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr7273283edc.67.1552476562574;
 Wed, 13 Mar 2019 04:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <1551950425-7346-1-git-send-email-abel.vesa@nxp.com>
 <20190311102825.g7d5mmorcltxnnzf@pengutronix.de> <20190311104140.n65jvamx76rzkonr@fsr-ub1664-175>
 <20190313104149.blhwqgn53lsgow6z@pengutronix.de>
In-Reply-To: <20190313104149.blhwqgn53lsgow6z@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 13 Mar 2019 13:29:10 +0200
Message-ID: <CAEnQRZAHTjKVZwviNnXSwMEn1f6PN1fV2==3xeG9kZ462ryYhw@mail.gmail.com>
Subject: Re: [RFC] clk: imx: Allow re-parenting by default on set rate
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:42 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Mon, Mar 11, 2019 at 10:41:40AM +0000, Abel Vesa wrote:
> > On 19-03-11 11:28:25, Sascha Hauer wrote:
> > > Hi Abel,
> > >
> > > On Thu, Mar 07, 2019 at 09:20:37AM +0000, Abel Vesa wrote:
> > > > By default, the muxes should re-parent on set_rate.
> > > > This would allow the drivers to control only the leaf clock node,
> > > > leaving the rest to the clock driver, that way simplifying the
> > > > clock control.
> > >
> > > I am afraid of this change. Besides the rate there might be other
> > > reasons to choose one mux input over another, consider for example low
> > > power audio playback where we need one specific mux setting because it
> > > provides a clock which runs at low power mode.
> > > On the IPU on i.MX5/6 there are clocks being used as pixel clocks
> > > derived from different muxes. I don't think you want to pick an input
> > > clock just because it happens to deliver the best clock rate at that
> > > point in time, but really is shared with some other clock that changes
> > > its rate in the next moment.
> > >
> >
> > > I have no concrete examples for things that break with this change, but
> > > I would be more confident if we change the behaviour explicitly only for
> > > the muxes that we have reviewed to cope with this change.
> > >
> >
> > Fair enough. We could replace all the imx_clk_mux with imx_clk_mux_noreparent
> > and after that we can independently switch the clocks that are safe (to switch)
> > to imx_clk_mux (which would not have the noreparent flag set).
>
> Ok with me.
>
> >
> > The main idea is to simplify the clock control from drivers point of view.
>
> Which drivers do you have in mind? I hardly ever missed reparenting on
> rate changes, so where is this feature useful?

Hi Sascha,

Reparenting is very useful for Audio IPs (SAI, SPDIF, PDM, FSL DSP).
We often need clock rates that are multiples of 8000 or 11025
which can be obtain from different PLLs. But in order for this to work
we need to have the correct parent.

In our current tree we do the re parenting manually inside drivers. For example:

https://source.codeaurora.org/external/imx/linux-imx/tree/sound/soc/fsl/fsl_sai.c?h=imx_4.14.78_1.0.0_ga#n244

This is far from optimal. Abel's patch will be of a great help for Audio.

thanks,
Daniel.
