Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B962073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfDPGkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:40:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28178 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727180AbfDPGkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:31 -0400
X-UUID: e2fd0b26fc054348a1c1c4d1ccbf09e4-20190416
X-UUID: e2fd0b26fc054348a1c1c4d1ccbf09e4-20190416
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1959458083; Tue, 16 Apr 2019 14:40:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 14:40:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 14:40:24 +0800
Message-ID: <1555396824.349.20.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] pinctrl: Add alternative way for specifying
 register bases
From:   Light Hsieh <light.hsieh@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Apr 2019 14:40:24 +0800
In-Reply-To: <CAGp9LzpVRMbf3uWp8rAeM29dDqF6z5rG62rFXsrhyGCczkNBmA@mail.gmail.com>
References: <1555038945-10245-1-git-send-email-light.hsieh@mediatek.com>
         <CAGp9LzpVRMbf3uWp8rAeM29dDqF6z5rG62rFXsrhyGCczkNBmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sean:

On Sun, 2019-04-14 at 16:01 -0700, Sean Wang wrote:
> Hi, Light
> 
> On Thu, Apr 11, 2019 at 8:15 PM Light Hsieh <light.hsieh@mediatek.com> wrote:
> >
> > The orginal PINCTRL_MTK_PARIS/PINCTRL_MTK_MOORE need more effort for
> > specifying register bases when porting platform driver:
> > 1. Write mtXXXX_pinctrl_register_base_name[] array in pinctrl-mtXXXX.c
> >    to specify names of register bases, for exmaple:
> >
> >         static const char * const mt6765_pinctrl_register_base_names[] = {
> >                 "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4", "iocfg5",
> >                 "iocfg6", "iocfg7",
> >         };
> > 2. Write reg = <...>, ..., <...>; in mtXXXX.dts to specify register
> >    bases. Each member of reg contain address range cloned from
> >    pre-generated devicetree node.
> > 3. Write reg-names = "...", ..., "..."; in mtXXXX.dts to specify
> >    names of register bases. The sequence of names in reg-names shall match
> >    sequence of names that specified in pinctrl-mtXXXX.c.
> >    Besides, the seqeunce of names in reg-names shall also match sequence of
> >    address range in reg, for exmaple:
> >
> >         pio: pinctrl {
> >                 compatible = "mediatek,mt6765-pinctrl";
> >                 reg = <0 0x10005000 0 0x1000>,
> >                       <0 0x10002C00 0 0x200>,
> >                       <0 0x10002800 0 0x200>,
> >                       <0 0x10002A00 0 0x200>,
> >                       <0 0x10002000 0 0x200>,
> >                       <0 0x10002200 0 0x200>,
> >                       <0 0x10002400 0 0x200>,
> >                       <0 0x10002600 0 0x200>,
> >                       <0 0x1000b000 0 0x1000>;
> >                 reg-names = "iocfg0", "iocfg1", "iocfg2", "iocfg3",
> >                             "iocfg4", "iocfg5", "iocfg6", "iocfg7",
> >                             "eint";
> >
> > To reduce porting effort, this patch add an alternative way for specifying
> > register bases:
> > 1. Write reg_bases = <...>, ..., <...>; and reg_base_eint = <&eint>;
> >    in mtXXXX.dtsi where members in reg_bases and &eint are labels for
> >    pre-generated devicetree nodes, for example:
> >         pio: pinctrl {
> >                 compatible = "mediatek,mt6765-pinctrl";
> >                 reg_bases = <&gpio0>,
> >                             <&iocfg0>,
> >                             <&iocfg1>,
> >                             <&iocfg2>,
> >                             <&iocfg3>,
> >                             <&iocfg4>,
> >                             <&iocfg5>,
> >                             <&iocfg6>,
> >                             <&iocfg7>;
> >                 reg_base_eint = <&eint>;
> 
> reg and reg-names both are generic properties used in all of DT-based
> device and driver, described in
> Documentation/devicetree/bindings/resource-names.txt, but reg_based
> and reg_base_eint aren't.
> 
> If these properties are not hardware specific related, I personally
> will encourage reusing those generic properties and relevant helpers
> because those generic properties handling in the base driver are
> almost bug-free, well maintained and even keep be extended in the
> future. This way can help driver people put more concentration on
> hardware specific stuff in the driver.
> 

This modification is somewhat like mtk pinctrl driver V1. In V1,
you may have the following devicetree (refer to
Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt):
:
	syscfg_pctl_a: syscfg-pctl-a@10005000 {
		compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
		reg = <0 0x10005000 0 0x1000>;
	};

	syscfg_pctl_b: syscfg-pctl-b@1020c020 {
		compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
		reg = <0 0x1020C020 0 0x1000>;
	};

	pinctrl@1c20800 {
		compatible = "mediatek,mt8135-pinctrl";
		mediatek,pctl-regmap = <&syscfg_pctl_a &syscfg_pctl_b>;


and have following code in pinctrl-mtk-common.c:
	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
	node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);

"mediatek, pctl-regmap" is self-defined devicetree property only used
by mtk pinctrl drver V1.

Now, I use similar logic with another property name.So I don't think
the can add risk.
Besides, since this way reduce porting effort and avoid human-error
when writing devicetree and c code about device tree porting, it also
help driver people put more concentration on hardware specific stuff in
the driver.

> >
> >    Since this pre-generated nodes had already specify address range,
> >    it is not necessary to specify address range again in pinctrl node.
> >
> > Using this way, porting effort is reduced and therefore typo can occur with
> > less chance.
> >
> > Change-Id: I55f5e328919f4f736ca4b9f8d1593e069f179637
> > ---
> >  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 19 +++++---
> >  drivers/pinctrl/mediatek/pinctrl-paris.c         | 62 ++++++++++++++++--------
> >  2 files changed, 54 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > index b1c3684..16b4863 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> >  #include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> >
> >  #include "mtk-eint.h"
> >  #include "pinctrl-mtk-common-v2.h"
> > @@ -310,7 +311,7 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
> >
> >  int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
> >  {
> > -       struct device_node *np = pdev->dev.of_node;
> > +       struct device_node *np = pdev->dev.of_node, *node;
> >         struct resource *res;
> >
> >         if (!IS_ENABLED(CONFIG_EINT_MTK))
> > @@ -323,13 +324,19 @@ int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
> >         if (!hw->eint)
> >                 return -ENOMEM;
> >
> > -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eint");
> > -       if (!res) {
> > -               dev_err(&pdev->dev, "Unable to get eint resource\n");
> > -               return -ENODEV;
> > +       node = of_parse_phandle(np, "reg_base_eint", 0);
> > +       if (node) {
> > +               hw->eint->base = of_iomap(node, 0);
> > +       } else {
> > +               res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                       "eint");
> > +               if (!res) {
> > +                       dev_err(&pdev->dev, "Unable to get eint resource\n");
> > +                       return -ENODEV;
> > +               }
> > +               hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
> >         }
> >
> > -       hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
> >         if (IS_ERR(hw->eint->base))
> >                 return PTR_ERR(hw->eint->base);
> >
> > diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > index b59e108..8ddb995 100644
> > --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> > +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> > @@ -9,6 +9,7 @@
> >   *        Hongzhou.Yang <hongzhou.yang@mediatek.com>
> >   */
> >
> > +#include <linux/of_address.h>
> >  #include <linux/gpio/driver.h>
> >  #include <dt-bindings/pinctrl/mt65xx.h>
> >  #include "pinctrl-paris.h"
> > @@ -815,10 +816,11 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
> >  int mtk_paris_pinctrl_probe(struct platform_device *pdev,
> >                             const struct mtk_pin_soc *soc)
> >  {
> > +       struct device_node *np = pdev->dev.of_node, *node;
> >         struct pinctrl_pin_desc *pins;
> >         struct mtk_pinctrl *hw;
> >         struct resource *res;
> > -       int err, i;
> > +       int err, i, get_base_pass;
> >
> >         hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
> >         if (!hw)
> > @@ -828,31 +830,49 @@ int mtk_paris_pinctrl_probe(struct platform_device *pdev,
> >         hw->soc = soc;
> >         hw->dev = &pdev->dev;
> >
> > -       if (!hw->soc->nbase_names) {
> > -               dev_err(&pdev->dev,
> > -                       "SoC should be assigned at least one register base\n");
> > -               return -EINVAL;
> > -       }
> > -
> > -       hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
> > +       if (hw->soc->nbase_names) {
> > +               hw->base = devm_kmalloc_array(&pdev->dev, hw->soc->nbase_names,
> >                                       sizeof(*hw->base), GFP_KERNEL);
> > -       if (!hw->base)
> > -               return -ENOMEM;
> > +               if (!hw->base)
> > +                       return -ENOMEM;
> > +
> > +               for (i = 0; i < hw->soc->nbase_names; i++) {
> > +                       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                                                       hw->soc->base_names[i]);
> > +                       if (!res) {
> > +                               dev_err(&pdev->dev, "missing IO resource\n");
> > +                               return -ENXIO;
> > +                       }
> >
> > -       for (i = 0; i < hw->soc->nbase_names; i++) {
> > -               res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > -                                                  hw->soc->base_names[i]);
> > -               if (!res) {
> > -                       dev_err(&pdev->dev, "missing IO resource\n");
> > -                       return -ENXIO;
> > +                       hw->base[i] = devm_ioremap_resource(&pdev->dev, res);
> > +                       if (IS_ERR(hw->base[i]))
> > +                               return PTR_ERR(hw->base[i]);
> >                 }
> >
> > -               hw->base[i] = devm_ioremap_resource(&pdev->dev, res);
> > -               if (IS_ERR(hw->base[i]))
> > -                       return PTR_ERR(hw->base[i]);
> > -       }
> > +               hw->nbase = hw->soc->nbase_names;
> > +       } else {
> > +               for (get_base_pass = 0; get_base_pass < 2; get_base_pass++) {
> > +                       for (i = 0;; i++) {
> > +                               node = of_parse_phandle(np, "reg_bases", i);
> > +                               if (!node)
> > +                                       break;
> > +                               if (get_base_pass == 1)
> > +                                       hw->base[i] = of_iomap(node, 0);
> > +                               of_node_put(node);
> > +                       }
> >
> > -       hw->nbase = hw->soc->nbase_names;
> > +                       if (i == 0)
> > +                               return -EINVAL;
> > +                       if (get_base_pass == 0) {
> > +                               hw->nbase = i;
> > +                               hw->base = devm_kmalloc_array(&pdev->dev, i,
> > +                                       sizeof(*hw->base),
> > +                                       GFP_KERNEL | __GFP_ZERO);
> > +                               if (IS_ERR(hw->base))
> > +                                       return PTR_ERR(hw->base);
> > +                       }
> > +               }
> > +       }
> >
> >         err = mtk_pctrl_build_state(pdev);
> >         if (err) {
> > --
> > 1.8.1.1.dirty
> >


