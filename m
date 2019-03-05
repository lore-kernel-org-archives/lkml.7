Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061ABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33992075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCEGmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:42:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53016 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfCEGmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:42:38 -0500
X-UUID: 24e9eab555344d77abf5a25844de455f-20190305
X-UUID: 24e9eab555344d77abf5a25844de455f-20190305
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 112004511; Tue, 05 Mar 2019 14:42:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Mar 2019 14:42:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 14:42:25 +0800
Message-ID: <1551768145.22671.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 1/9] clk: mediatek: Disable tuner_en before change
 PLL rate
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
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Owen Chen <owen.chen@mediatek.com>
Date:   Tue, 5 Mar 2019 14:42:25 +0800
In-Reply-To: <20190305050546.23431-3-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
         <20190305050546.23431-3-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: C84D10F38310784DA96446CFCF9CA963D6BE97A12C44D0C6035461A6235BDDC02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 13:05 +0800, Weiyi Lu wrote:
> From: Owen Chen <owen.chen@mediatek.com>
> 
> PLLs with tuner_en bit, such as APLL1, need to disable
> tuner_en before apply new frequency settings, or the new frequency
> settings (pcw) will not be applied.
> The tuner_en bit will be disabled during changing PLL rate
> and be restored after new settings applied.
> 
> Fixes: e2f744a82d725 (clk: mediatek: Add MT2712 clock support)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-by: James Liao <jamesjj.liao@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-pll.c | 48 ++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f54e4015b0b1..18842d660317 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -88,6 +88,32 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  	return ((unsigned long)vco + postdiv - 1) / postdiv;
>  }
>  
> +static void __mtk_pll_tuner_enable(struct mtk_clk_pll *pll)
> +{
> +	u32 r;
> +
> +	if (pll->tuner_en_addr) {
> +		r = readl(pll->tuner_en_addr) | BIT(pll->data->tuner_en_bit);
> +		writel(r, pll->tuner_en_addr);
> +	} else if (pll->tuner_addr) {
> +		r = readl(pll->tuner_addr) | AUDPLL_TUNER_EN;
> +		writel(r, pll->tuner_addr);
> +	}
> +}
> +
> +static void __mtk_pll_tuner_disable(struct mtk_clk_pll *pll)
> +{
> +	u32 r;
> +
> +	if (pll->tuner_en_addr) {
> +		r = readl(pll->tuner_en_addr) & ~BIT(pll->data->tuner_en_bit);
> +		writel(r, pll->tuner_en_addr);
> +	} else if (pll->tuner_addr) {
> +		r = readl(pll->tuner_addr) & ~AUDPLL_TUNER_EN;
> +		writel(r, pll->tuner_addr);
> +	}
> +}
> +
>  static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  		int postdiv)
>  {
> @@ -96,6 +122,9 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  
>  	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
>  
> +	/* disable tuner */
> +	__mtk_pll_tuner_disable(pll);
> +
>  	/* set postdiv */
>  	val = readl(pll->pd_addr);
>  	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
> @@ -122,6 +151,9 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  	if (pll->tuner_addr)
>  		writel(con1 + 1, pll->tuner_addr);
>  
> +	/* restore tuner_en */
> +	__mtk_pll_tuner_enable(pll);
> +
>  	if (pll_en)
>  		udelay(20);
>  }
> @@ -228,13 +260,7 @@ static int mtk_pll_prepare(struct clk_hw *hw)
>  	r |= pll->data->en_mask;
>  	writel(r, pll->base_addr + REG_CON0);
>  
> -	if (pll->tuner_en_addr) {
> -		r = readl(pll->tuner_en_addr) | BIT(pll->data->tuner_en_bit);
> -		writel(r, pll->tuner_en_addr);
> -	} else if (pll->tuner_addr) {
> -		r = readl(pll->tuner_addr) | AUDPLL_TUNER_EN;
> -		writel(r, pll->tuner_addr);
> -	}
> +	__mtk_pll_tuner_enable(pll);
>  
>  	udelay(20);
>  
> @@ -258,13 +284,7 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
>  		writel(r, pll->base_addr + REG_CON0);
>  	}
>  
> -	if (pll->tuner_en_addr) {
> -		r = readl(pll->tuner_en_addr) & ~BIT(pll->data->tuner_en_bit);
> -		writel(r, pll->tuner_en_addr);
> -	} else if (pll->tuner_addr) {
> -		r = readl(pll->tuner_addr) & ~AUDPLL_TUNER_EN;
> -		writel(r, pll->tuner_addr);
> -	}
> +	__mtk_pll_tuner_disable(pll);
>  
>  	r = readl(pll->base_addr + REG_CON0);
>  	r &= ~CON0_BASE_EN;


