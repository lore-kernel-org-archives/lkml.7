Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC582C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B409B207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJ5Ct6f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfKYSWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:22:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34642 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYSWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:22:35 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so17390573iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cVwlCxiAU250fdIUygqGuSgrUnKM+wrEA6hlG5U8q6E=;
        b=NJ5Ct6f74/ik105ZgHLKnrpr8OvsypsU/S4Onras8XPDqySaED7X01YOGxLw4bUEmF
         e5MObc2aNWMgmE1La5SKhbPlxGVfdr7N96TbxMaYPEXClrwIXZ/Ub3u4hgYYk5a70m5G
         IeWYxf6M0K6J3cf6xTEOdaoRvkVEvdgF9APxMeOT3FhUQC2k6AINacSuxvRJeZEDntkC
         +RYOwTOPob1zKdV/nfXWOa/mAqcyiKoX2pgMJHYBYTLSDYOhTesW6cX7g1X1V/s3ybIr
         /Hy7lhIZvyTLw96J0d/KsOC8WBDb6f0vy04wWxht+/HCDYeUAmzArdS5RxA4U8QAuOTV
         ivjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cVwlCxiAU250fdIUygqGuSgrUnKM+wrEA6hlG5U8q6E=;
        b=gMx6okWzuVfEpK2+/ErTKkxYiINjiYL65AN0YO01K1IW923ZXaK5jUJEr/EWWDJBmS
         pYLa8eM/s0mFreB5RZE5xukl1UTTmwdScPP8kGkJ6cpkrt8UdyU9Q3d04Yq/MELFxJ39
         pKsnqJ0W3RLUKIlevLhxlZDGVgdnTB2wworbWmtSS9beWwj/cKdQrpDoxMZBv4Y6Ue0b
         0MOXrHkCcqqkDwn93PUj9396x1u8J8S4nI6sBm1UKEQeV1wzF3sFXAXDWA9JV/DhBG2o
         ztZjDr4+so35KqEXt0hY6ujSKQAeUmnpeeI5WcgTcv1b0Ey5DQJayzKigJL0z//NyAA0
         Lvpw==
X-Gm-Message-State: APjAAAXwIAoUQ2FdaxZmAzGxCGQmAQfDCZvtAOkNm+8F5iejEZf83iY3
        +4i/2RYOmZBZejf8WicAx1FgbymFkvY6Wj7lmJ9SSQ==
X-Google-Smtp-Source: APXvYqxsNAEF9R0xIOsts8MbsYvMRXfuAMQbvRHVJHBLGaU1K94BY0OSJKemzulGY15eFbL/dM9cfqzmlAMUtDrtLts=
X-Received: by 2002:a6b:7f43:: with SMTP id m3mr27643180ioq.72.1574706153655;
 Mon, 25 Nov 2019 10:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20191116170846.67220-1-paul@crapouillou.net> <20191116170846.67220-4-paul@crapouillou.net>
 <20191118225628.GA18243@xps15> <1574448902.3.3@crapouillou.net>
In-Reply-To: <1574448902.3.3@crapouillou.net>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 25 Nov 2019 11:22:22 -0700
Message-ID: <CANLsYkyEedaqSbW42uZoo2vLQ5dRe+xiFAA7Tj6xPtgbPg4BxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] remoteproc: ingenic: Added remoteproc driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 at 11:55, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Mathieu,
>
>
> Le lun., nov. 18, 2019 at 15:56, Mathieu Poirier
> <mathieu.poirier@linaro.org> a =C3=A9crit :
> > Hi Paul,
> >
> > On Sat, Nov 16, 2019 at 06:08:46PM +0100, Paul Cercueil wrote:
> >>  This driver is used to boot, communicate with and load firmwares to
> >> the
> >>  MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
> >>  Ingenic.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>
> >>  Notes:
> >>      v2: Remove exception for always-mapped memories
> >>      v3: - Use clk_bulk API
> >>          - Move device-managed code to its own patch [3/4]
> >>              - Move devicetree table right above ingenic_rproc_driver
> >>              - Removed #ifdef CONFIG_OF around devicetree table
> >>              - Removed .owner =3D THIS_MODULE in ingenic_rproc_driver
> >>              - Removed useless platform_set_drvdata()
> >>
> >>   drivers/remoteproc/Kconfig         |   8 +
> >>   drivers/remoteproc/Makefile        |   1 +
> >>   drivers/remoteproc/ingenic_rproc.c | 242
> >> +++++++++++++++++++++++++++++
> >>   3 files changed, 251 insertions(+)
> >>   create mode 100644 drivers/remoteproc/ingenic_rproc.c
> >>
> >>  diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >>  index 94afdde4bc9f..f7d4b183d152 100644
> >>  --- a/drivers/remoteproc/Kconfig
> >>  +++ b/drivers/remoteproc/Kconfig
> >>  @@ -214,6 +214,14 @@ config STM32_RPROC
> >>
> >>        This can be either built-in or a loadable module.
> >>
> >>  +config INGENIC_RPROC
> >
> > Are you sure you don't want to make this something like
> > INGENIC_RPROC_JZ47XX_VPU so that future remote proc system from
> > Ingenic can be
> > added easily?
>
> Ingenic SoCs aren't named JZ47xx anymore; I'll name the symbol
> INGENIC_VPU_RPROC then.
>
> >>  +   tristate "Ingenic JZ47xx VPU remoteproc support"
> >>  +   depends on MIPS || COMPILE_TEST
> >>  +   help
> >>  +     Say y or m here to support the VPU in the JZ47xx SoCs from
> >> Ingenic.
> >>  +     This can be either built-in or a loadable module.
> >>  +     If unsure say N.
> >>  +
> >>   endif # REMOTEPROC
> >>
> >>   endmenu
> >>  diff --git a/drivers/remoteproc/Makefile
> >> b/drivers/remoteproc/Makefile
> >>  index 00f09e658cb3..6eb0137abbc7 100644
> >>  --- a/drivers/remoteproc/Makefile
> >>  +++ b/drivers/remoteproc/Makefile
> >>  @@ -10,6 +10,7 @@ remoteproc-y                              +=3D remo=
teproc_sysfs.o
> >>   remoteproc-y                               +=3D remoteproc_virtio.o
> >>   remoteproc-y                               +=3D remoteproc_elf_loade=
r.o
> >>   obj-$(CONFIG_IMX_REMOTEPROC)               +=3D imx_rproc.o
> >>  +obj-$(CONFIG_INGENIC_RPROC)                        +=3D ingenic_rpro=
c.a
> >
> > This comes out as one tab to many on my side.
> >
> >>   obj-$(CONFIG_OMAP_REMOTEPROC)              +=3D omap_remoteproc.o
> >>   obj-$(CONFIG_WKUP_M3_RPROC)                +=3D wkup_m3_rproc.o
> >>   obj-$(CONFIG_DA8XX_REMOTEPROC)             +=3D da8xx_remoteproc.o
> >>  diff --git a/drivers/remoteproc/ingenic_rproc.c
> >> b/drivers/remoteproc/ingenic_rproc.c
> >>  new file mode 100644
> >>  index 000000000000..5a7c7d8d9a90
> >>  --- /dev/null
> >>  +++ b/drivers/remoteproc/ingenic_rproc.c
> >>  @@ -0,0 +1,242 @@
> >>  +// SPDX-License-Identifier: GPL-2.0+
> >>  +/*
> >>  + * Ingenic JZ47xx remoteproc driver
> >>  + * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
> >>  + */
> >>  +
> >>  +#include <linux/bitops.h>
> >>  +#include <linux/clk.h>
> >>  +#include <linux/err.h>
> >>  +#include <linux/interrupt.h>
> >>  +#include <linux/io.h>
> >>  +#include <linux/module.h>
> >>  +#include <linux/platform_device.h>
> >>  +#include <linux/remoteproc.h>
> >>  +
> >>  +#include "remoteproc_internal.h"
> >>  +
> >>  +#define REG_AUX_CTRL               0x0
> >>  +#define REG_AUX_MSG_ACK            0x10
> >>  +#define REG_AUX_MSG                0x14
> >>  +#define REG_CORE_MSG_ACK   0x18
> >>  +#define REG_CORE_MSG               0x1C
> >>  +
> >>  +#define AUX_CTRL_SLEEP             BIT(31)
> >>  +#define AUX_CTRL_MSG_IRQ_EN        BIT(3)
> >>  +#define AUX_CTRL_NMI_RESETS        BIT(2)
> >>  +#define AUX_CTRL_NMI               BIT(1)
> >>  +#define AUX_CTRL_SW_RESET  BIT(0)
> >>  +
> >>  +struct vpu_mem_map {
> >>  +   const char *name;
> >>  +   unsigned int da;
> >>  +};
> >>  +
> >>  +struct vpu_mem_info {
> >>  +   const struct vpu_mem_map *map;
> >>  +   unsigned long len;
> >>  +   void __iomem *base;
> >>  +};
> >>  +
> >>  +static const struct vpu_mem_map vpu_mem_map[] =3D {
> >>  +   { "tcsm0", 0x132b0000 },
> >>  +   { "tcsm1", 0xf4000000 },
> >>  +   { "sram",  0x132f0000 },
> >>  +};
> >>  +
> >>  +/* Device data */
> >>  +struct vpu {
> >>  +   int irq;
> >>  +   struct clk_bulk_data clks[2];
> >>  +   void __iomem *aux_base;
> >>  +   struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
> >>  +   struct device *dev;
> >>  +};
> >
> > Documentation of structure fields is always appreciated but it is up
> > to Bjorn to
> > decide on this one.
>
> It's a private structure within a driver, does it matter that much?
> Besides, it's pretty much self-explanatory.

It is a matter of time before people add complexity to the drivers and
more field in the structures.  If documentation is already present
then new fields get documented and things are easier to understand.

>
> >>  +
> >>  +static int ingenic_rproc_prepare(struct rproc *rproc)
> >>  +{
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +   int ret;
> >>  +
> >>  +   /* The clocks must be enabled for the firmware to be loaded in
> >> TCSM */
> >>  +   ret =3D clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks)=
;
> >>  +   if (ret)
> >>  +           dev_err(vpu->dev, "Unable to start clocks: %d", ret);
> >>  +
> >>  +   return ret;
> >>  +}
> >>  +
> >>  +static void ingenic_rproc_unprepare(struct rproc *rproc)
> >>  +{
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +
> >>  +   clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
> >>  +}
> >>  +
> >>  +static int ingenic_rproc_start(struct rproc *rproc)
> >>  +{
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +   u32 ctrl;
> >>  +
> >>  +   enable_irq(vpu->irq);
> >>  +
> >>  +   /* Reset the AUX and enable message IRQ */
> >>  +   ctrl =3D AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN=
;
> >>  +   writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
> >
> > Out of curiosity, there is no power domain associated with this
> > co-processor?  Clocks are all you need?
>
> That's correct.
>
> >>  +
> >>  +   return 0;
> >>  +}
> >>  +
> >>  +static int ingenic_rproc_stop(struct rproc *rproc)
> >>  +{
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +
> >>  +   /* Keep AUX in reset mode */
> >>  +   writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
> >>  +
> >>  +   disable_irq_nosync(vpu->irq);
> >
> > Also out of curiosity, why the need for _nosync()?
>
> It probably doesn't need it. I'll remove it.
>
> >>  +
> >>  +   return 0;
> >>  +}
> >>  +
> >>  +static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
> >>  +{
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +
> >>  +   writel(vqid, vpu->aux_base + REG_CORE_MSG);
> >>  +}
> >>  +
> >>  +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da,
> >> int len)
> >>  +{
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +   void __iomem *va =3D NULL;
> >>  +   unsigned int i;
> >>  +
> >>  +   if (len <=3D 0)
> >>  +           return NULL;
> >>  +
> >>  +   for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
> >>  +           const struct vpu_mem_info *info =3D &vpu->mem_info[i];
> >>  +           const struct vpu_mem_map *map =3D info->map;
> >>  +
> >>  +           if (da >=3D map->da && (da + len) < (map->da + info->len)=
) {
> >>  +                   va =3D info->base + (da - map->da);
> >>  +                   break;
> >>  +           }
> >>  +   }
> >>  +
> >>  +   return (__force void *)va;
> >>  +}
> >>  +
> >>  +static struct rproc_ops ingenic_rproc_ops =3D {
> >>  +   .prepare =3D ingenic_rproc_prepare,
> >>  +   .unprepare =3D ingenic_rproc_unprepare,
> >>  +   .start =3D ingenic_rproc_start,
> >>  +   .stop =3D ingenic_rproc_stop,
> >>  +   .kick =3D ingenic_rproc_kick,
> >>  +   .da_to_va =3D ingenic_rproc_da_to_va,
> >>  +};
> >>  +
> >>  +static irqreturn_t vpu_interrupt(int irq, void *data)
> >>  +{
> >>  +   struct rproc *rproc =3D data;
> >>  +   struct vpu *vpu =3D rproc->priv;
> >>  +   u32 vring;
> >>  +
> >>  +   vring =3D readl(vpu->aux_base + REG_AUX_MSG);
> >>  +
> >>  +   /* Ack the interrupt */
> >>  +   writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
> >>  +
> >>  +   return rproc_vq_interrupt(rproc, vring);
> >>  +}
> >>  +
> >>  +static int ingenic_rproc_probe(struct platform_device *pdev)
> >>  +{
> >>  +   struct device *dev =3D &pdev->dev;
> >>  +   struct resource *mem;
> >>  +   struct rproc *rproc;
> >>  +   struct vpu *vpu;
> >>  +   unsigned int i;
> >>  +   int ret;
> >>  +
> >>  +   rproc =3D devm_rproc_alloc(dev, "ingenic-vpu",
> >>  +                            &ingenic_rproc_ops, NULL, sizeof(*vpu));
> >>  +   if (!rproc)
> >>  +           return -ENOMEM;
> >>  +
> >>  +   vpu =3D rproc->priv;
> >>  +   vpu->dev =3D &pdev->dev;
> >>  +
> >>  +   mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux")=
;
> >>  +   vpu->aux_base =3D devm_ioremap_resource(dev, mem);
> >>  +   if (IS_ERR(vpu->aux_base)) {
> >>  +           dev_err(dev, "Failed to ioremap");
> >>  +           return PTR_ERR(vpu->aux_base);
> >>  +   }
> >>  +
> >>  +   for (i =3D 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
> >>  +           mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM=
,
> >>  +                                              vpu_mem_map[i].name);
> >>  +
> >>  +           vpu->mem_info[i].base =3D devm_ioremap_resource(dev, mem)=
;
> >>  +           if (IS_ERR(vpu->mem_info[i].base)) {
> >>  +                   ret =3D PTR_ERR(vpu->mem_info[i].base);
> >>  +                   dev_err(dev, "Failed to ioremap");
> >>  +                   return ret;
> >>  +           }
> >>  +
> >>  +           vpu->mem_info[i].len =3D resource_size(mem);
> >>  +           vpu->mem_info[i].map =3D &vpu_mem_map[i];
> >>  +   }
> >>  +
> >>  +   vpu->clks[0].id =3D "vpu";
> >>  +   vpu->clks[1].id =3D "aux";
> >>  +
> >>  +   ret =3D devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks), vpu->clks);
> >>  +   if (ret) {
> >>  +           dev_err(dev, "Failed to get clocks");
> >>  +           return ret;
> >>  +   }
> >>  +
> >>  +   vpu->irq =3D platform_get_irq(pdev, 0);
> >>  +   if (vpu->irq < 0) {
> >>  +           dev_err(dev, "Failed to get platform IRQ");
> >>  +           return vpu->irq;
> >>  +   }
> >>  +
> >>  +   ret =3D devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, "VPU",
> >> rproc);
> >>  +   if (ret < 0) {
> >>  +           dev_err(dev, "Failed to request IRQ");
> >>  +           return ret;
> >>  +   }
> >>  +
> >>  +   disable_irq_nosync(vpu->irq);
> >>  +
> >>  +   ret =3D devm_rproc_add(dev, rproc);
> >>  +   if (ret) {
> >>  +           dev_err(dev, "Failed to register remote processor");
> >>  +           return ret;
> >>  +   }
> >>  +
> >>  +   return 0;
> >>  +}
> >>  +
> >>  +static const struct of_device_id ingenic_rproc_of_matches[] =3D {
> >>  +   { .compatible =3D "ingenic,jz4770-vpu-rproc", },
> >>  +   {}
> >>  +};
> >>  +MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
> >>  +
> >>  +static struct platform_driver ingenic_rproc_driver =3D {
> >>  +   .probe =3D ingenic_rproc_probe,
> >>  +   .driver =3D {
> >>  +           .name =3D "ingenic-vpu",
> >>  +           .of_match_table =3D of_match_ptr(ingenic_rproc_of_matches=
),
> >>  +   },
> >>  +};
> >>  +module_platform_driver(ingenic_rproc_driver);
> >>  +
> >>  +MODULE_LICENSE("GPL");
> >>  +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> >>  +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control
> >> driver");
> >
> > Nice, clean and simple driver.  With the above and after rolling in
> > Julia's
> > patch:
> >
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Thanks!
>
> Cheers,
> -Paul
>
>
