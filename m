Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE1C76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7F2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 06:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGHQ4E1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfG0GbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 02:31:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34304 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfG0GbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 02:31:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so56522654wrm.1;
        Fri, 26 Jul 2019 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKeMdrdWBgdGTKyoRuJP3d49YclQQWgce18ijijgk9I=;
        b=AGHQ4E1M37EE6M5F7RtEuQX4fkGB62kY4xRAU4L+AEosvTGG1SlsCDHK/o1yzkzkDs
         dIXgIfZkTv5prHK3S04NTfBitoJAJxa2qMEF2hXgq7kcHz/Ph+bnLSuGJ6xuuopOZFDw
         6uuBk4Vxg8Cczbs0i0DHfpYyQXXpLe4C83J19nZ5t8hJ3C13Z9IFgCOGRHXtYUaxunpD
         C8pDK25kbahOed4KZT9hdXJ35VWXDaf3pe7uE3M8lH2RhTE0NiZMb0IfzfwLPyFq8KYa
         1Ow0QA9gE6SIWSxWWNN1mLHBF71kHuLo1XlD8aJmTl7YQoevnv6ebF+Y0TT/XY22mpXB
         uPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKeMdrdWBgdGTKyoRuJP3d49YclQQWgce18ijijgk9I=;
        b=SZOynE7dBSmJShozwmpz3FlZYfvyo39kfYJDWY5U0Qh2ZiBBVA3Zr6XwglXFcquoSV
         8iF8VYGea3PfURjlQpHB8hdI5Sqk7IB8eh9T67YzK/uUyNvhDFKVKmilxkyVKs9KrF6a
         7zOTXUgeQx4Les/+XPNpW04GpWRI8gnyLNLl2vkMvGMshArKhrlAtxWPA3CRabXSU9Aq
         gU1jETVnv4X0BLlVVMJwjs1HsHocdkr90V9osAX4vX3/1ke5Efda6lKSDx6WsUenZrQw
         vycHmfLDcpYW/8IZl1vifvFQjyghk2PsD2SuUXlAgCnkv6TeDbqJ2Z5XEC2b0KRIta1Q
         Ho4Q==
X-Gm-Message-State: APjAAAWXnsfNYir6P/lURbALO4OX2vLWcPlBs+nGezKcRE5Y05EDcIlu
        UdThDapV+yshvvOD/BO6aDjC2srJHW0ekeDypRw=
X-Google-Smtp-Source: APXvYqzdgecswj3pdUxE5wMpc0iYUFA3hEfoHHf/1a5LOh9kiFNqb77jfKSfAfUuh+1oWpfs5nRNP7Da4/Vx0J4QRJc=
X-Received: by 2002:adf:f450:: with SMTP id f16mr74204830wrp.335.1564209068259;
 Fri, 26 Jul 2019 23:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <1561453316-11481-1-git-send-email-abel.vesa@nxp.com>
 <20190625223223.3B8EC2053B@mail.kernel.org> <20190705085218.lvvqnqx6nfph2era@fsr-ub1664-175>
 <20190722212537.41C9121900@mail.kernel.org>
In-Reply-To: <20190722212537.41C9121900@mail.kernel.org>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 27 Jul 2019 09:30:57 +0300
Message-ID: <CAEnQRZAFdvSzh-pDJ-rsyaEJw83ymSVW0CC2+QZyWwAPeTOyBw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Mark AHB clock as critical
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 6:17 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Abel Vesa (2019-07-05 01:52:19)
> > On 19-06-25 15:32:22, Stephen Boyd wrote:
> > > Quoting Abel Vesa (2019-06-25 02:01:56)
> > > > Keep the AHB clock always on since there is no driver to control it and
> > > > all the other clocks that use it as parent rely on it being always enabled.
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > > ---
> > > >  drivers/clk/imx/clk-imx8mq.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> > > > index 5fbc2a7..b48268b 100644
> > > > --- a/drivers/clk/imx/clk-imx8mq.c
> > > > +++ b/drivers/clk/imx/clk-imx8mq.c
> > > > @@ -398,7 +398,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
> > > >         clks[IMX8MQ_CLK_NOC_APB] = imx8m_clk_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
> > > >
> > > >         /* AHB */
> > > > -       clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite("ahb", imx8mq_ahb_sels, base + 0x9000);
> > > > +       clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite_critical("ahb", imx8mq_ahb_sels, base + 0x9000);
> > >
> > > Please add a comment into the code why it's critical.
> >
> > Comment explaining why the AHB bus clock is critical ?
> > Isn't that self-explanatory ?
>
> Nope, it isn't self-explanatory, because nothing on this line says "bus"
> and it could be that someone reading this code isn't well versed in the
> concepts of ARM world AHB to connect the two.

Agree with Stephen. Commit message should try to give as much details
as possible
also maybe educate the readers who might not have that much knowledge.

Abel, I understand that for someone who works daily with this part of the kernel
this change might look trivial.

Also, without this patch linux-next hangs on imx8mq.

With the explanation added you can add my:

Tested-by: Daniel Baluta <daniel.baluta@nxp.com>

thanks,
Daniel.
