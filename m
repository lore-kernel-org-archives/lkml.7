Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8640F218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RdxyEV2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfCVGBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:01:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44561 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfCVGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:01:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id u9so533629lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pzuvn3kB50GPLaliBlOtU4DbSAi8LjYbJJOGPno2nJg=;
        b=RdxyEV2qm2CG1bVNJ5mQShnba0e0EWlTtM6ISw31DgKMbmnVpbXV6AIjUqJmhiXPRi
         2DmvCdsYXrT9y2eMX4+ppXlPuuWDhlk+ADmdZ7tgC1fM3FqqhpFk65J+EqCz8ZvCj7qE
         01t7VGx7s6qu1gLAIXZ3CeDmuHJ3OTbrVDdPiM3VaW3RhWGnvvMZuOYQxwn8NYJYFizh
         gQHt/XB5kBSZGz3kvcdk9HSiauaCbY9XXag9K2qtFqkv54+l5HMf0nfOO5wlgRr54Ez1
         lxOJQa0x0XSVzDxxxxz4o+BAWgGmOc1zzjlhIS14YXxHTlBNZaWsTnXnzg1UuNZ62D0u
         kUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pzuvn3kB50GPLaliBlOtU4DbSAi8LjYbJJOGPno2nJg=;
        b=tjRSd1bn/u3+5h1P9qxizqEdsjU4zWmiz0WhULNeC9XUG+b3l2M4RpE2yRTS3Zjt5X
         gSmzUXi1B1Xa9jwzKoCWD9xJXdQsDtEsEqbjVbxlncf0PyL1I+0TCrTHDaKXnMMGrP8j
         U+PyOn1jWV3BeqpwPG4r32bskI8RYVt4TEo7X2C0FkkmGEnJ9i29IxwOV7RlYdiRf1yp
         WAgzyia9H0737WJwyrQsGP+PrS1QFk5cR++bxCA1KGEw6of+ruRE+Bgo27Hmg13Vla7e
         4P9ggEczWEOje6HBbNAlsseYB3pxHmNusr+FPaUZ63YFS733Z3S9Jutqs7OXTSGEkJng
         6yjw==
X-Gm-Message-State: APjAAAVs6bLnNdSPQDUZxxJ2fVvi4HNHXOckY/b/+0VdNUAufakRJU2s
        LSZhhkaD086hhMUE5bm/6527XIxi9/lo9z4JhJY4qg==
X-Google-Smtp-Source: APXvYqwgD/OVNs4C7yzuPn/z3e06Z9lmDVUv/8aRXYjqaK3aYJ4eOBJt+CxcoNAzmm6anFQelTb3SEDQbP6UvVECrhY=
X-Received: by 2002:ac2:48b7:: with SMTP id u23mr223754lfg.115.1553234496157;
 Thu, 21 Mar 2019 23:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
 <1553082728-9232-3-git-send-email-yash.shah@sifive.com> <20190321133340.GB7047@nazgul.tnic>
In-Reply-To: <20190321133340.GB7047@nazgul.tnic>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 22 Mar 2019 11:30:59 +0530
Message-ID: <CAJ2_jOHBHXrVHyVdd7+pDYDyb2sT3iL4W=FhYVCvxG_rx+3ZyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000 chip
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, mchehab@kernel.org,
        devicetree@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 7:03 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 20, 2019 at 05:22:08PM +0530, Yash Shah wrote:
> > This EDAC driver supports:
> > - Initial configuration reporting on bootup via debug logs
> > - ECC event monitoring and reporting through the EDAC framework
> > - ECC event injection
> >
> > This driver is partially based on pnd2_edac.c and altera_edac.c
> >
> > Initially L2 Cache controller is added as a subcomponent to
> > this EDAC driver.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>
> ...
>
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index e286b5b..112d9d1 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -440,6 +440,19 @@ config EDAC_ALTERA_SDMMC
> >         Support for error detection and correction on the
> >         Altera SDMMC FIFO Memory for Altera SoCs.
> >
> > +config EDAC_SIFIVE
> > +     tristate "Sifive ECC"
> > +     depends on RISCV
> > +     help
> > +       Support for error detection and correction on the SiFive SoCs.
> > +
> > +config EDAC_SIFIVE_L2
>
> That config item is unused. Drop it.

Sure, will drop it.

> > +static irqreturn_t sifive_edac_l2_int_handler(int irq, void *device)
> > +{
> > +     struct edac_device_ctl_info *dci =
> > +                                     (struct edac_device_ctl_info *)device;
>
> No ugly linebreaks like that - just let it stick out even if it is > 80
> cols long.

Ok. Will let it stick out.

> > +
> > +/*
> > + * sifive_edac_device_probe()
> > + *   This is a generic EDAC device driver that will support
> > + *   various SiFive memory devices as well as the memories
> > + *   for other peripherals. Module specific initialization is
> > + *   done by passing the function index in the device tree.
>
> This comment doesn't have anything to do with that function but rather
> belongs at the top of this file.

Will move it at the top.

>
> > + */
> > +static int sifive_edac_device_probe(struct platform_device *pdev)
> > +{
> > +     struct edac_device_ctl_info *dci;
> > +     struct sifive_edac_device_dev *drvdata;
> > +     int rc, i;
> > +     struct resource *res;
> > +     void __iomem *baseaddr;
> > +     struct device_node *np = pdev->dev.of_node;
> > +     char *ecc_name = (char *)np->name;
> > +     static int dev_instance;
>
> Please sort function local variables declaration in a reverse christmas
> tree order:
>
>         <type_a> longest_variable_name;
>         <type_b> shorter_var_name;
>         <type_c> even_shorter;
>         <type_d> i;
>

Sure, will be done.

> > +
> > +     rc = edac_device_add_device(dci);
> > +     if (rc) {
> > +             dev_err(&pdev->dev, "failed to register with EDAC core\n");
> > +             goto del_edac_device;
> > +     }
>
> Call setup_sifive_debug() in the success case here so that you don't
> have to teardown below.

Ok.

>
> > +
> > +     return rc;
> > +
> > +del_edac_device:
> > +     teardown_sifive_debug();
> > +     edac_device_del_device(&pdev->dev);
> > +     edac_device_free_ctl_info(dci);
>
> Those three can be replaced by a call to sifive_edac_device_remove() ?

Since now there won't be a need to teardown, I will stick with this
(bottom two function calls).

>
> Btw, you have prefixed your static functions with "sifive_edac_" which
> doesn't make much sense and you have long names for no good reason.

Will remove the prefix "sifive_edac_" on static functions wherever feasible.

> > +static struct platform_driver sifive_edac_device_driver = {
> > +     .driver = {
> > +              .name = "sifive_edac_device",
>
> "device"? I think it is clear that it is a device and thus kinda
> tautological. "sifive_edac" should be enough...

Sure. Will keep it just "sifive_edac"

>
> Last but not least, building this driver with the riscv64 cross compilers from
> here:
>
> http://cdn.kernel.org/pub/tools/crosstool/files/bin/
>
> fails like below. With the riscv32 compiler it fails the same.
>
> Provided I'm not doing anything wrong, you should not be sending me
> half-baked stuff which doesn't even build.

Sorry about that. It fails if configured as 'module'.
I intended this driver to be built-in only hence I never came across
these errors while testing.
I somehow missed it in Kconfig file.
I will make the correction in Kconfig (change 'tristate' to 'bool')
and make sure everything builds fine.

> --
> Regards/Gruss,
>     Boris.

Thanks for your comments.

- Yash

>
> ECO tip #101: Trim your mails when you reply.
> --
