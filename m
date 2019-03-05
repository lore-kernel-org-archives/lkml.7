Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9664AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FFC2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCEGrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:47:33 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7683 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfCEGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:47:33 -0500
X-UUID: ec8dac3808814ced961640f8fa9c834d-20190305
X-UUID: ec8dac3808814ced961640f8fa9c834d-20190305
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 5754758; Tue, 05 Mar 2019 14:47:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Mar 2019 14:47:19 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 14:47:19 +0800
Message-ID: <1551768439.22671.4.camel@mtksdaap41>
Subject: Re: [PATCH v5 6/9] clk: mediatek: Add flags support for mtk_gate
 data
From:   James Liao <jamesjj.liao@mediatek.com>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>
Date:   Tue, 5 Mar 2019 14:47:19 +0800
In-Reply-To: <20190305050546.23431-8-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
         <20190305050546.23431-8-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 0E10E9245FAF60DDD434A58853703841B68ED3D382D830D07834079350ECE0632000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 13:05 +0800, Weiyi Lu wrote:
> On some Mediatek platforms, there are critical clocks of
> clock gate type.
> To register clock gate with flags CLK_IS_CRITICAL,
> we need to add the flags field in mtk_gate data and register APIs.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-by: James Liao <jamesjj.liao@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-gate.c | 5 +++--
>  drivers/clk/mediatek/clk-gate.h | 3 ++-
>  drivers/clk/mediatek/clk-mtk.c  | 3 ++-
>  drivers/clk/mediatek/clk-mtk.h  | 1 +
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
> index 934bf0e45e26..85daf826619a 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -157,7 +157,8 @@ struct clk *mtk_clk_register_gate(
>  		int clr_ofs,
>  		int sta_ofs,
>  		u8 bit,
> -		const struct clk_ops *ops)
> +		const struct clk_ops *ops,
> +		unsigned long flags)
>  {
>  	struct mtk_clk_gate *cg;
>  	struct clk *clk;
> @@ -168,7 +169,7 @@ struct clk *mtk_clk_register_gate(
>  		return ERR_PTR(-ENOMEM);
>  
>  	init.name = name;
> -	init.flags = CLK_SET_RATE_PARENT;
> +	init.flags = flags | CLK_SET_RATE_PARENT;
>  	init.parent_names = parent_name ? &parent_name : NULL;
>  	init.num_parents = parent_name ? 1 : 0;
>  	init.ops = ops;
> diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
> index 72ef89b3ad7b..9f766dfe1d57 100644
> --- a/drivers/clk/mediatek/clk-gate.h
> +++ b/drivers/clk/mediatek/clk-gate.h
> @@ -47,6 +47,7 @@ struct clk *mtk_clk_register_gate(
>  		int clr_ofs,
>  		int sta_ofs,
>  		u8 bit,
> -		const struct clk_ops *ops);
> +		const struct clk_ops *ops,
> +		unsigned long flags);
>  
>  #endif /* __DRV_CLK_GATE_H */
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 9c0ae4278a94..35359e5397c7 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -130,7 +130,8 @@ int mtk_clk_register_gates(struct device_node *node,
>  				gate->regs->set_ofs,
>  				gate->regs->clr_ofs,
>  				gate->regs->sta_ofs,
> -				gate->shift, gate->ops);
> +				gate->shift, gate->ops,
> +				gate->flags);
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %ld\n",
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 11b5517903d0..928905496c4b 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -158,6 +158,7 @@ struct mtk_gate {
>  	const struct mtk_gate_regs *regs;
>  	int shift;
>  	const struct clk_ops *ops;
> +	unsigned long flags;
>  };
>  
>  int mtk_clk_register_gates(struct device_node *node,


