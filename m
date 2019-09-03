Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924C4C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5152721897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="hzUWKvrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICF5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:57:32 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:63694 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfICF5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567490251; x=1599026251;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=QUJerUTXX9JAsklG4v6RV3thlgDGpzVUjBirsY+DGFc=;
  b=hzUWKvrB+ucT24GNoLRzsr9PjzVOTNvrFdtcP8V0U8N1saR49aTtffp2
   2JPmT4qMiG3FhWUKkYIbiq3j4mIDM9r+1M7reUDGfS/jOZj5YXUORuXln
   +Mfrpu9SXynx54jAHX7yyUQtilUWCWfSj/HLfoinTxuKZiZDh3Y820pw0
   5xJkagaBLJUUc6dsBbcKBMPqyLvqeDbGP321xqPKVI4o/EvHypV/L/iXu
   uUwfzwGhhPeM94Yo5BAFi/J1/hjjz2QqOlyDFJ2Hs/6B8yM3Wm4VVHJJ8
   mzM0jyetLEG8j3D1NsSVBPHSf8UAz1BFJhcQtgI9pTt2/FLiikcsdfBEf
   Q==;
IronPort-SDR: hCalSpmrxZRdmbqqSrd5jeI0eMtO+ePSaAMBo/+zpkFzuztlViOeGjC+JhqxbMoPz94OJVjroj
 JRG6T462NU1tcSVFVZyKbFSO/lcjqLhW2pG6hw4JLI+UoFzYaCoK/gn6KH8/VdE8XHOl8ofNg8
 fy8qDuWA9bBHOwhuF3tkxqUyDt0cZtncHreYv8vUnsSaaquKaVc6uT4nAr32q1LEydCMphmxoZ
 xgNzDZPyR0+lkxvRDjGUSzTxyRN/fjl7uTExblvnCn1tVuncR9m01nFlhzxP9KKDSeMAzNMagf
 J8E=
IronPort-PHdr: =?us-ascii?q?9a23=3AthF4SxFC5XFK98+jD1cmHJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zo8ywAkXT6L1XgUPTWs2DsrQY0rCQ6v+5EjVYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdu8sLjYdtN6o91g?=
 =?us-ascii?q?fFqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBJ63YYkSAOobJetXoIf9qFkOoxWwBgeiGf3hxSNTi3/qwaE3yf?=
 =?us-ascii?q?gtHR3a0AEiGd8FrXTarM/yNKcXSe26zqjIzDTDb/NL3jf29YvHchA7rvGNQL?=
 =?us-ascii?q?l9dsrQyEgvFwzfj1WctZDpMj2O2+QQr2eb9fBsWvyyhG46sgx8pCWkyMkrio?=
 =?us-ascii?q?nMnI0Vy1bE+D1iz4YyIt24VEp7Yd+iEJdKqy6aMI52T8U/SG9roCY30qMKtY?=
 =?us-ascii?q?K/cSQQy5kqxwTTZ+Kbf4WL+B7vSeKcLDN+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcJEA7j6vbK5o4zr40lJ?=
 =?us-ascii?q?ofrF3PHiHrlEjyiKKabEok+u+v6+ToZrXpuIWQOJNzigH7Kqgum8q/DvokMg?=
 =?us-ascii?q?UWQWSX5eCx2Kfg8ED5WrlGkOE6n6rDvJzHIckWora1AwpP3YYi7xa/AS2m0N?=
 =?us-ascii?q?MdnXQfLFNEeRKHgJLoO13SPPz1A+yyg0mwnzdx3fzJIKDuAojVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcrydBf5pRUCqwOIf7qWU/+qsbYDhknPAyw2OvnFtp92Z0EWW6VAa?=
 =?us-ascii?q?+WLrnSsVmW6eIrOeWMY5UVuDmuY8QistfqgG8wn1MHcOGD0J8Tb3a5VqBvJ0?=
 =?us-ascii?q?iJaHzgmNpHG2oOug04TcTgj1qeVT9VIX21WvRvyCs8DdeXDJXDW4flsryI3W?=
 =?us-ascii?q?/vD49Wb2EeUgukDHzyMYiIRqFfO2qpPsZ9n2lcBvCaQIg72ETr7Veixg=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EQAADL/21dgMfQVdFlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBVQQBAQELAQGDA4EFKoQhg0qLQoIPk3aFJIF7AQgBAQEOGxQBAYQ?=
 =?us-ascii?q?7AgICgm0jNgcOAgMIAQEFAQEBAQEGBAEBAhABAQkNCQgnhTcMQgEQAYFmKQG?=
 =?us-ascii?q?BSywNZAEBAQMSEQRSEAsLDQICHwcCAiISAQUBHAYTIoMBggoFng2BAzyLJH8?=
 =?us-ascii?q?zg3iEdQEIDIFDBhJ6KAGLd4IXg241PoQNg0KCWASBLgEBAY1EhxaWDQEGAoI?=
 =?us-ascii?q?NFIZzhTyILBuCM4tTimAtkFSVVw8hgTYLgX8zGiV/BmeBToJOFxWDOopzIzC?=
 =?us-ascii?q?GXIY4glQBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EQAADL/21dgMfQVdFlGwEBAQEDAQEBBwMBAQGBVQQBA?=
 =?us-ascii?q?QELAQGDA4EFKoQhg0qLQoIPk3aFJIF7AQgBAQEOGxQBAYQ7AgICgm0jNgcOA?=
 =?us-ascii?q?gMIAQEFAQEBAQEGBAEBAhABAQkNCQgnhTcMQgEQAYFmKQGBSywNZAEBAQMSE?=
 =?us-ascii?q?QRSEAsLDQICHwcCAiISAQUBHAYTIoMBggoFng2BAzyLJH8zg3iEdQEIDIFDB?=
 =?us-ascii?q?hJ6KAGLd4IXg241PoQNg0KCWASBLgEBAY1EhxaWDQEGAoINFIZzhTyILBuCM?=
 =?us-ascii?q?4tTimAtkFSVVw8hgTYLgX8zGiV/BmeBToJOFxWDOopzIzCGXIY4glQBAQ?=
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="74360963"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 22:57:28 -0700
Received: by mail-lj1-f199.google.com with SMTP id s4so1393024ljs.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 22:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1RORfpQlqn9qnf8gs9wti52uT3aQVT/Fl4fUvQUgpM=;
        b=iJuSVX7+9yep980rpMgowTlPbHOuR6mr1yPVfwy1unmuxJNzvK+rUjP3JrHNlhzsw3
         pm/waDMcg46jEm151Ctbmup452ZCNXhxpj2cIo8MLGAczRljVtaYwMEuSCmsixwZ/Qd6
         9WtFeaJ/oVGciWOJ1axuyPXlcP7qsCiKUJqNaJPDXGIjGLvua+N2/f6IopCIoKJT/hhK
         St6bCfxse9HBCjv8pNy70mDp0SZ67kHLMOC+K+V9TyhD/picIygX/cNU1H6RU1xnist1
         56SZRzKG7wgAVUNfkExculkm07s9UHq3yXzvl/IG/8kUCk2oI81GtAD7S6GKxFrAHdjB
         yWdg==
X-Gm-Message-State: APjAAAX5QbK2oyVZrr+uoU9uwOtk8t6ZX4eaqvkuVOAHC2t4Q756VgtE
        0LJy7wIX1N8KGhFQO4msYZOQ0NLubZgzIIya+0awImFPPKL1LtdqW0ckLe4APJMUlx/DP6C0a2F
        buev9J18PX3cNARa6bObgLbv2rUpp+9inr+6rjL8jDw==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr20634535lfj.76.1567490246795;
        Mon, 02 Sep 2019 22:57:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyndhnhLpzhxkkkI6SThvTHdicVJOY9S3srLCaTZ/slSZSfLXjzDiqoXFXkBq6IPvvMjvo5t4Ex9aWEKpXwgNw=
X-Received: by 2002:a19:2d19:: with SMTP id k25mr20634522lfj.76.1567490246602;
 Mon, 02 Sep 2019 22:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190902222946.20548-1-yzhai003@ucr.edu> <20190902223650.GJ21922@piout.net>
In-Reply-To: <20190902223650.GJ21922@piout.net>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 2 Sep 2019 22:56:48 -0700
Message-ID: <CABvMjLRjeXAmhBwfZZPbmxdENq=FP9rR0Ld=T3veGXF6cjptxA@mail.gmail.com>
Subject: Re: [PATCH] clocksource: atmel-st: Variable sr in at91rm9200_timer_interrupt()
 could be uninitialized
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function regmap_read(),  there're two places which could make the read fail.

First, if "reg" and  "map->reg_stride" are not aligned, then remap_read() will
return -EINVAL without initialize variable "val".

Second, _regmap_read() could also fail and return error code if "val" is not
initialized. The caller remap_read() returns the same error code, but
at91rm9200_timer_interrupt() does not use this information.

On Mon, Sep 2, 2019 at 3:37 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 02/09/2019 15:29:46-0700, Yizhuo wrote:
> > Inside function at91rm9200_timer_interrupt(), variable sr could
> > be uninitialized if regmap_read() fails. However, sr is used
>
> Could you elaborate on how this could fail?
>
> > to decide the control flow later in the if statement, which is
> > potentially unsafe. We could check the return value of
> > regmap_read() and print an error here.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > ---
> >  drivers/clocksource/timer-atmel-st.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> > index ab0aabfae5f0..061a3f27847e 100644
> > --- a/drivers/clocksource/timer-atmel-st.c
> > +++ b/drivers/clocksource/timer-atmel-st.c
> > @@ -48,8 +48,14 @@ static inline unsigned long read_CRTR(void)
> >  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
> >  {
> >       u32 sr;
> > +     int ret;
> > +
> > +     ret = regmap_read(regmap_st, AT91_ST_SR, &sr);
> > +     if (ret) {
> > +             pr_err("Fail to read AT91_ST_SR.\n");
> > +             return ret;
> > +     }
> >
> > -     regmap_read(regmap_st, AT91_ST_SR, &sr);
> >       sr &= irqmask;
> >
> >       /*
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
