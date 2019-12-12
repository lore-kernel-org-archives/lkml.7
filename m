Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F1EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3D206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 03:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576121650;
	bh=2+vbETdp46Q1p6ccV33S1783MXLvgwkedlRpfnVSvIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Na4WmKbMlI8p+6g3y1YfsXRuxNxg49TYvHCu+ycURc9xOP4w2CpSpFuKq+EHd9RNt
	 +1T8eOlP16y3lJ3iC7MO91sijE5p07HJgC1Dz55TEx8HoTGiLVfgtJD34+3dZXHpbO
	 88oknYBvhIiPDKoJsH5F1s25rutleG+REsLJDgVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLLDeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:34:10 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:37829 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfLLDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 22:34:09 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xBC3Xl0H013734;
        Thu, 12 Dec 2019 12:33:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xBC3Xl0H013734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576121628;
        bh=p1P3InDUiioyKsJ0uqaLYPyxVpYrR5VZ44BOVhRr6QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FdUxNb09tRix91rC7pFGfY91Alomf9VGqGWbt5CnOCadE5WbXoJg5TPifTUICLvWK
         LesPIlYRvDQDBtlsyO6qOj4DUBcy05EFUfaaIPppNaG6wXtfWE6+QFM3+BUxsmc0Aq
         DOh3Qjm0Q3M5HiAG3xgecFuFWSJ2oLbpNFA0osNVc2SwHOLl5l8DgByu6GYHdLMMrv
         rkYvYXDAjt6DAP9PTW/rNqdJJkckmBVkLGBtcXWlb8jnlZIHJG0kSJkXT7j9flOcZE
         q8NAQqaa0QUPV/XK+UyUcs8h4sK4R18uosuG/P4l3RBpr7Iebx9pi1anrFSlG+ULxp
         BZHYMF3jHk4+w==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id i18so1102vkk.7;
        Wed, 11 Dec 2019 19:33:47 -0800 (PST)
X-Gm-Message-State: APjAAAU1PQlTMP4/At5pbI8/0Qgw0s6rsdhMqtY/InVeNjF+vILP1l+B
        ubU/VEt66PmufqTbI+SSWcEZrDXO/I5gkJu0kdM=
X-Google-Smtp-Source: APXvYqxQv7H+yYlj4cHgvDygVGhBBZnFMhLd2OuGWfMmVY59MfZ4NEBI6ohS0rdhJMIe8WNTbhNsQh+3Do02yOmxJmQ=
X-Received: by 2002:a1f:2e4a:: with SMTP id u71mr3263415vku.96.1576121626675;
 Wed, 11 Dec 2019 19:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20191211054538.8283-1-yamada.masahiro@socionext.com>
 <20191211054538.8283-2-yamada.masahiro@socionext.com> <399bb8ab-74c5-1be3-4156-6d854738b548@denx.de>
In-Reply-To: <399bb8ab-74c5-1be3-4156-6d854738b548@denx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Dec 2019 12:33:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDcWV5sV3r6Rkv-4KMGDE5ZwyG525WDyjGEW85xSDF1g@mail.gmail.com>
Message-ID: <CAK7LNATDcWV5sV3r6Rkv-4KMGDE5ZwyG525WDyjGEW85xSDF1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mtd: rawnand: denali_dt: add reset controlling
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:05 AM Marek Vasut <marex@denx.de> wrote:
>
> On 12/11/19 6:45 AM, Masahiro Yamada wrote:
> [...]
> > diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
> > index 8b779a899dcf..9a294c3f6ec8 100644
> > --- a/drivers/mtd/nand/raw/denali_dt.c
> > +++ b/drivers/mtd/nand/raw/denali_dt.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/ioport.h>
> > @@ -14,6 +15,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> >
> >  #include "denali.h"
> >
> > @@ -22,6 +24,8 @@ struct denali_dt {
> >       struct clk *clk;        /* core clock */
> >       struct clk *clk_x;      /* bus interface clock */
> >       struct clk *clk_ecc;    /* ECC circuit clock */
> > +     struct reset_control *rst;      /* core reset */
> > +     struct reset_control *rst_reg;  /* register reset */
> >  };
> >
> >  struct denali_dt_data {
> > @@ -151,6 +155,14 @@ static int denali_dt_probe(struct platform_device *pdev)
> >       if (IS_ERR(dt->clk_ecc))
> >               return PTR_ERR(dt->clk_ecc);
> >
> > +     dt->rst = devm_reset_control_get_optional_shared(dev, "nand");
> > +     if (IS_ERR(dt->rst))
> > +             return PTR_ERR(dt->rst);
> > +
> > +     dt->rst_reg = devm_reset_control_get_optional_shared(dev, "reg");
> > +     if (IS_ERR(dt->rst_reg))
> > +             return PTR_ERR(dt->rst_reg);
> > +
> >       ret = clk_prepare_enable(dt->clk);
> >       if (ret)
> >               return ret;
> > @@ -166,10 +178,30 @@ static int denali_dt_probe(struct platform_device *pdev)
> >       denali->clk_rate = clk_get_rate(dt->clk);
> >       denali->clk_x_rate = clk_get_rate(dt->clk_x);
> >
> > -     ret = denali_init(denali);
> > +     /*
> > +      * Deassert the register reset, and the core reset in this order.
> > +      * Deasserting the core reset while the register reset is asserted
> > +      * will cause unpredictable behavior in the controller.
> > +      */
> > +     ret = reset_control_deassert(dt->rst_reg);
> >       if (ret)
> >               goto out_disable_clk_ecc;
> >
> > +     ret = reset_control_deassert(dt->rst);
> > +     if (ret)
> > +             goto out_assert_rst_reg;
> > +
> > +     /*
> > +      * When the reset is deasserted, the initialization sequence is kicked
> > +      * (bootstrap process). The driver must wait until it finished.
> > +      * Otherwise, it will result in unpredictable behavior.
> > +      */
> > +     usleep_range(200, 1000);
> > +
> > +     ret = denali_init(denali);
> > +     if (ret)
> > +             goto out_assert_rst;
> > +
> >       for_each_child_of_node(dev->of_node, np) {
> >               ret = denali_dt_chip_init(denali, np);
> >               if (ret) {
> > @@ -184,6 +216,10 @@ static int denali_dt_probe(struct platform_device *pdev)
> >
> >  out_remove_denali:
> >       denali_remove(denali);
> > +out_assert_rst:
> > +     reset_control_assert(dt->rst);
> > +out_assert_rst_reg:
> > +     reset_control_assert(dt->rst_reg);
>
> Maybe you can use devm_add_action_or_reset() here , like in e.g.
> drivers/input/touchscreen/ili210x.c , to avoid this unwinding ?


No.

Drivers should be explicit about what and when
to do about the hardware access.


This comes down to a question about why
Linux kernel does not have such APIs as:

devm_clk_prepare_enable()
devm_reset_control_deassert()
devm_regulator_enable()

In fact, I saw some people sending such patches in the past.


Mark Brown clearly answered the question.
https://lkml.org/lkml/2014/2/1/131

I really support his thinking.





--
Best Regards

Masahiro Yamada
