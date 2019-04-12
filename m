Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7158C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DF12186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDLLUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:20:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38798 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDLLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:20:11 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEuE2-00057O-JI; Fri, 12 Apr 2019 13:20:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     wen.yang99@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/5] pinctrl: rockchip: fix leaked of_node references
Date:   Fri, 12 Apr 2019 13:20:06 +0200
Message-ID: <1737000.EArop0DIDs@diego>
In-Reply-To: <201904121645298604058@zte.com.cn>
References: <201904121645298604058@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 12. April 2019, 10:45:29 CEST schrieb wen.yang99@zte.com.cn:
> > > The call to of_parse_phandle returns a node pointer with refcount
> > > incremented thus it must be explicitly decremented after the last
> > > usage.
> > >
> > > Detected by coccinelle with the following warnings:
> > > ./drivers/pinctrl/pinctrl-rockchip.c:3221:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3196, but without a corresponding object release within this function.
> > > ./drivers/pinctrl/pinctrl-rockchip.c:3223:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3196, but without a corresponding object release within this function.
> > >
> > > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: linux-gpio@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  drivers/pinctrl/pinctrl-rockchip.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> > > index 16bf21b..e22d387 100644
> > > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > > @@ -3195,6 +3195,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
> > >
> > >          node = of_parse_phandle(bank->of_node->parent,
> > >                      "rockchip,pmu", 0);
> > > +        of_node_put(node);
> > >          if (!node) {
> > >              if (of_address_to_resource(bank->of_node, 1, &res)) {
> > >                  dev_err(info->dev, "cannot find IO resource for bank\n");
> > >
> > 
> > hmm, the conditional does still use the node pointer, so the of_node_put
> > should probably be below the whole if clause?
> 
> Thank you for your comments.
> 
> There may be two methods to fix this issue here.
> Method 1, Add of_node_put after the conditional statement:
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 16bf21b..5f822e6 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -3198,12 +3198,15 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
>                 if (!node) {
>                         if (of_address_to_resource(bank->of_node, 1, &res)) {
>                                 dev_err(info->dev, "cannot find IO resource for bank\n");
> +                               of_node_put(node);
>                                 return -ENOENT;
>                         }
> 
>                         base = devm_ioremap_resource(info->dev, &res);
> -                       if (IS_ERR(base))
> +                       if (IS_ERR(base)) {
> +                               of_node_put(node);
>                                 return PTR_ERR(base);
> +                       }
>                         rockchip_regmap_config.max_register =
>                                                     resource_size(&res) - 4;
>                         rockchip_regmap_config.name =
> @@ -3212,6 +3215,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
>                                                     base,
>                                                     &rockchip_regmap_config);
>                 }
> +               of_node_put(node);
>         }
> 
>         bank->irq = irq_of_parse_and_map(bank->of_node, 0)
> 
> Method 2, Add of_node_put before conditional statement:
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 16bf21b..e22d387 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -3195,6 +3195,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
> 
>                 node = of_parse_phandle(bank->of_node->parent,
>                                         "rockchip,pmu", 0);
> +               of_node_put(node);
>                 if (!node) {
>                         if (of_address_to_resource(bank->of_node, 1, &res)) {
>                                 dev_err(info->dev, "cannot find IO resource for bank\n");
> 
> Since we're just determining whether the node pointer is null, and don't need to dereference the node pointer.
> So if we use the Method 2, it might be a little bit simpler.
> Thanks.

personally I prefer to do it cleanly honoring the rules of using of_nodes.

So while your method 2 may make it simpler people possibly editing the
code later then need to remember that the node actually is already put
when it is checked (or possibly even used in some later patch)


Heiko


