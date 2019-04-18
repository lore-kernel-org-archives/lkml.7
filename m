Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A204C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B866C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555575092;
	bh=FRZlBCGJ5gI/9PZBFpMQ3voCiccMKVd28kLehCJ9NDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kp32k0Ge/mh+4lupvqUp10PLhJfI8jOannBcjRb/DufS9iRxlEfFeN6eePinV9J1F
	 0sA41XJXezpQdAXvXXTMohQwrJWECyiH8Od2HFHyvTGLR5JrVIQoTIomP0XxwFbJj8
	 dPa0Txgf2wQSWVPR2F759cSjHkcr4qBknmIjeMCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfDRILb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRILb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:11:31 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B9720693;
        Thu, 18 Apr 2019 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555575089;
        bh=FRZlBCGJ5gI/9PZBFpMQ3voCiccMKVd28kLehCJ9NDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=unKOWXvyoQatT0ZKuFHuZRJAHWPZptbAdUC2EDZBzYlk5AvJQCvJQj0QroV+vEVDk
         orEzZSZQoy2UahcYQrltVV1m2x94vyyE1U9048dULNriBkhn8HhjrCL8frQFAjvHCR
         7wz5Et3w5mkiXKY54+UTVDFV9q+hTYfNrbpp2xnQ=
Received: by mail-wm1-f45.google.com with SMTP id c1so1690092wml.4;
        Thu, 18 Apr 2019 01:11:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXNIW+tW2VIZh6WPuCzEvOwYSEGY+dY+NCc6yDfJCW3QHl6hkvG
        L5BkBfqwvFXayYw5zPdpjp0DUnFqc7qRPja/xzE=
X-Google-Smtp-Source: APXvYqxm9/XP61RNFwNb29/i2AWpYy6YDq/Ws78U0OFefOngK3g+iYU0QjMk0LtU+eT5cnFj8ZsWbvJ4iQbXAdmQJBs=
X-Received: by 2002:a1c:658a:: with SMTP id z132mr2118197wmb.92.1555575087924;
 Thu, 18 Apr 2019 01:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <1555038945-10245-1-git-send-email-light.hsieh@mediatek.com>
 <CAGp9LzpVRMbf3uWp8rAeM29dDqF6z5rG62rFXsrhyGCczkNBmA@mail.gmail.com> <1555396824.349.20.camel@mtkswgap22>
In-Reply-To: <1555396824.349.20.camel@mtkswgap22>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 18 Apr 2019 01:11:16 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpCLgVEJSefQm_g7Fk4WqmeYp8Lh9YY5gvPtDAWOSrhUQ@mail.gmail.com>
Message-ID: <CAGp9LzpCLgVEJSefQm_g7Fk4WqmeYp8Lh9YY5gvPtDAWOSrhUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: Add alternative way for specifying register bases
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Light

I knew your idea, but the patch really depends on a separate patch
about the update of the corresponding dt-binding document for your
newly added properties. You can find out dt-binding document
pinctrl-mt8183.txt in linux-pinctrl.git branch for-next that is just
being merged two weeks ago and can be reused for all drivers using the
same base.

So, to keep the work moving on, we need a v2 including the change on
dt-binding document and the patch and then see some inputs from Rob
and Matthias.

         Sean

On Mon, Apr 15, 2019 at 11:40 PM Light Hsieh <light.hsieh@mediatek.com> wrote:
>
> Hi, Sean:
>
> On Sun, 2019-04-14 at 16:01 -0700, Sean Wang wrote:
> > Hi, Light
> >
> > On Thu, Apr 11, 2019 at 8:15 PM Light Hsieh <light.hsieh@mediatek.com> wrote:
> > >
> > > The orginal PINCTRL_MTK_PARIS/PINCTRL_MTK_MOORE need more effort for
> > > specifying register bases when porting platform driver:
> > > 1. Write mtXXXX_pinctrl_register_base_name[] array in pinctrl-mtXXXX.c
> > >    to specify names of register bases, for exmaple:
> > >
> > >         static const char * const mt6765_pinctrl_register_base_names[] = {
> > >                 "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4", "iocfg5",
> > >                 "iocfg6", "iocfg7",
> > >         };
> > > 2. Write reg = <...>, ..., <...>; in mtXXXX.dts to specify register
> > >    bases. Each member of reg contain address range cloned from
> > >    pre-generated devicetree node.
> > > 3. Write reg-names = "...", ..., "..."; in mtXXXX.dts to specify
> > >    names of register bases. The sequence of names in reg-names shall match
> > >    sequence of names that specified in pinctrl-mtXXXX.c.
> > >    Besides, the seqeunce of names in reg-names shall also match sequence of
> > >    address range in reg, for exmaple:
> > >
> > >         pio: pinctrl {
> > >                 compatible = "mediatek,mt6765-pinctrl";
> > >                 reg = <0 0x10005000 0 0x1000>,
> > >                       <0 0x10002C00 0 0x200>,
> > >                       <0 0x10002800 0 0x200>,
> > >                       <0 0x10002A00 0 0x200>,
> > >                       <0 0x10002000 0 0x200>,
> > >                       <0 0x10002200 0 0x200>,
> > >                       <0 0x10002400 0 0x200>,
> > >                       <0 0x10002600 0 0x200>,
> > >                       <0 0x1000b000 0 0x1000>;
> > >                 reg-names = "iocfg0", "iocfg1", "iocfg2", "iocfg3",
> > >                             "iocfg4", "iocfg5", "iocfg6", "iocfg7",
> > >                             "eint";
> > >
> > > To reduce porting effort, this patch add an alternative way for specifying
> > > register bases:
> > > 1. Write reg_bases = <...>, ..., <...>; and reg_base_eint = <&eint>;
> > >    in mtXXXX.dtsi where members in reg_bases and &eint are labels for
> > >    pre-generated devicetree nodes, for example:
> > >         pio: pinctrl {
> > >                 compatible = "mediatek,mt6765-pinctrl";
> > >                 reg_bases = <&gpio0>,
> > >                             <&iocfg0>,
> > >                             <&iocfg1>,
> > >                             <&iocfg2>,
> > >                             <&iocfg3>,
> > >                             <&iocfg4>,
> > >                             <&iocfg5>,
> > >                             <&iocfg6>,
> > >                             <&iocfg7>;
> > >                 reg_base_eint = <&eint>;
> >
> > reg and reg-names both are generic properties used in all of DT-based
> > device and driver, described in
> > Documentation/devicetree/bindings/resource-names.txt, but reg_based
> > and reg_base_eint aren't.
> >
> > If these properties are not hardware specific related, I personally
> > will encourage reusing those generic properties and relevant helpers
> > because those generic properties handling in the base driver are
> > almost bug-free, well maintained and even keep be extended in the
> > future. This way can help driver people put more concentration on
> > hardware specific stuff in the driver.
> >
>
> This modification is somewhat like mtk pinctrl driver V1. In V1,
> you may have the following devicetree (refer to
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt):
> :
>         syscfg_pctl_a: syscfg-pctl-a@10005000 {
>                 compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
>                 reg = <0 0x10005000 0 0x1000>;
>         };
>
>         syscfg_pctl_b: syscfg-pctl-b@1020c020 {
>                 compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
>                 reg = <0 0x1020C020 0 0x1000>;
>         };
>
>         pinctrl@1c20800 {
>                 compatible = "mediatek,mt8135-pinctrl";
>                 mediatek,pctl-regmap = <&syscfg_pctl_a &syscfg_pctl_b>;
>
>
> and have following code in pinctrl-mtk-common.c:
>         node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
>         node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);
>
> "mediatek, pctl-regmap" is self-defined devicetree property only used
> by mtk pinctrl drver V1.
>
> Now, I use similar logic with another property name.So I don't think
> the can add risk.
> Besides, since this way reduce porting effort and avoid human-error
> when writing devicetree and c code about device tree porting, it also
> help driver people put more concentration on hardware specific stuff in
> the driver.
>
> > >
> > >    Since this pre-generated nodes had already specify address range,
> > >    it is not necessary to specify address range again in pinctrl node.
> > >
> > > Using this way, porting effort is reduced and therefore typo can occur with
> > > less chance.
> > >
> > > Change-Id: I55f5e328919f4f736ca4b9f8d1593e069f179637
> > > ---
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 19 +++++---
> > >  drivers/pinctrl/mediatek/pinctrl-paris.c         | 62 ++++++++++++++++--------
> > >  2 files changed, 54 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > index b1c3684..16b4863 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/io.h>
> > >  #include <linux/of_irq.h>
> > > +#include <linux/of_address.h>
> > >
> > >  #include "mtk-eint.h"
> > >  #include "pinctrl-mtk-common-v2.h"
> > > @@ -310,7 +311,7 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> > >
> > >  int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
> > >  {
> > > -       struct device_node *np = pdev->dev.of_node;
> > > +       struct device_node *np = pdev->dev.of_node, *node;
> > >         struct resource *res;
> > >
> > >         if (!IS_ENABLED(CONFIG_EINT_MTK))
> > > @@ -323,13 +324,19 @@ int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
> > >         if (!hw->eint)
> > >                 return -ENOMEM;
> > >
> > > -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eint");
> > > -       if (!res) {
> > > -               dev_err(&pdev->dev, "Unable to get eint resource\n");
> > > -               return -ENODEV;
> > > +       node = of_parse_phandle(np, "reg_base_eint", 0);
> > > +       if (node) {
> > > +               hw->eint->base = of_iomap(node, 0);
> > > +       } else {
> > > +               res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > +                       "eint");
> > > +               if (!res) {
> > > +                       dev_err(&pdev->dev, "Unable to get eint resource\n");
> > > +                       return -ENODEV;
> > > +               }
> > > +               hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
> > >         }
> > >
> > > -       hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
> > >         if (IS_ERR(hw->eint->base))
> > >                 return PTR_ERR(hw->eint->base);
> > >
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > > index b59e108..8ddb995 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > > @@ -9,6 +9,7 @@
> > >   *        Hongzhou.Yang <hongzhou.yang@mediatek.com>
> > >   */
> > >
> > > +#include <linux/of_address.h>
> > >  #include <linux/gpio/driver.h>
> > >  #include <dt-bindings/pinctrl/mt65xx.h>
> > >  #include "pinctrl-paris.h"
> > > @@ -815,10 +816,11 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
> > >  int mtk_paris_pinctrl_probe(struct platform_device *pdev,
> > >                             const struct mtk_pin_soc *soc)
> > >  {
> > > +       struct device_node *np = pdev->dev.of_node, *node;
> > >         struct pinctrl_pin_desc *pins;
> > >         struct mtk_pinctrl *hw;
> > >         struct resource *res;
> > > -       int err, i;
> > > +       int err, i, get_base_pass;
> > >
> > >         hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
> > >         if (!hw)
> > > @@ -828,31 +830,49 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
> > >         hw->soc = soc;
> > >         hw->dev = &pdev->dev;
> > >
> > > -       if (!hw->soc->nbase_names) {
> > > -               dev_err(&pdev->dev,
> > > -                       "SoC should be assigned at least one register base\n");
> > > -               return -EINVAL;
> > > -       }
> > > -
> > > -       hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
> > > +       if (hw->soc->nbase_names) {
> > > +               hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
> > >                                       sizeof(*hw->base), GFP_KERNEL);
> > > -       if (!hw->base)
> > > -               return -ENOMEM;
> > > +               if (!hw->base)
> > > +                       return -ENOMEM;
> > > +
> > > +               for (i = 0; i < hw->soc->nbase_names; i++) {
> > > +                       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > +                                                       hw->soc->base_names[i]);
> > > +                       if (!res) {
> > > +                               dev_err(&pdev->dev, "missing IO resource\n");
> > > +                               return -ENXIO;
> > > +                       }
> > >
> > > -       for (i = 0; i < hw->soc->nbase_names; i++) {
> > > -               res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > -                                                  hw->soc->base_names[i]);
> > > -               if (!res) {
> > > -                       dev_err(&pdev->dev, "missing IO resource\n");
> > > -                       return -ENXIO;
> > > +                       hw->base[i] = devm_ioremap_resource(&pdev->dev, res);
> > > +                       if (IS_ERR(hw->base[i]))
> > > +                               return PTR_ERR(hw->base[i]);
> > >                 }
> > >
> > > -               hw->base[i] = devm_ioremap_resource(&pdev->dev, res);
> > > -               if (IS_ERR(hw->base[i]))
> > > -                       return PTR_ERR(hw->base[i]);
> > > -       }
> > > +               hw->nbase = hw->soc->nbase_names;
> > > +       } else {
> > > +               for (get_base_pass = 0; get_base_pass < 2; get_base_pass++) {
> > > +                       for (i = 0;; i++) {
> > > +                               node = of_parse_phandle(np, "reg_bases", i);
> > > +                               if (!node)
> > > +                                       break;
> > > +                               if (get_base_pass == 1)
> > > +                                       hw->base[i] = of_iomap(node, 0);
> > > +                               of_node_put(node);
> > > +                       }
> > >
> > > -       hw->nbase = hw->soc->nbase_names;
> > > +                       if (i == 0)
> > > +                               return -EINVAL;
> > > +                       if (get_base_pass == 0) {
> > > +                               hw->nbase = i;
> > > +                               hw->base = devm_kmalloc_array(&pdev->dev, i,
> > > +                                       sizeof(*hw->base),
> > > +                                       GFP_KERNEL | __GFP_ZERO);
> > > +                               if (IS_ERR(hw->base))
> > > +                                       return PTR_ERR(hw->base);
> > > +                       }
> > > +               }
> > > +       }
> > >
> > >         err = mtk_pctrl_build_state(pdev);
> > >         if (err) {
> > > --
> > > 1.8.1.1.dirty
> > >
>
>
