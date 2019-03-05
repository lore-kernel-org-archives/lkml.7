Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC45C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71F220842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCEGsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:48:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25642 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfCEGsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:48:19 -0500
X-UUID: 11b64de2bb8b4993a089caa2fbe7f9c7-20190305
X-UUID: 11b64de2bb8b4993a089caa2fbe7f9c7-20190305
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 862671918; Tue, 05 Mar 2019 14:48:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Mar 2019 14:48:09 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 14:48:09 +0800
Message-ID: <1551768489.22671.6.camel@mtksdaap41>
Subject: Re: [PATCH v5 9/9] clk: mediatek: Allow changing PLL rate when it
 is off
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
Date:   Tue, 5 Mar 2019 14:48:09 +0800
In-Reply-To: <20190305050546.23431-11-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
         <20190305050546.23431-11-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: D3F8F38F3EC0752BE607BE7487D1CA55696D4ED0C9B57A0CCD88AC5ED3BFA9A22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 13:05 +0800, Weiyi Lu wrote:
> From: James Liao <jamesjj.liao@mediatek.com>
> 
> Some modules may need to change its clock rate before turn on it.
> So changing PLL's rate when it is off should be allowed.
> This patch removes PLL enabled check before set rate, so that
> PLLs can set new frequency even if they are off.
> 
> On MT8173 for example, ARMPLL's enable bit can be controlled by
> other HW. That means ARMPLL may be turned on even if we (CPU / SW)
> set ARMPLL's enable bit as 0. In this case, SW may want and can
> still change ARMPLL's rate by changing its pcw and postdiv settings.
> But without this patch, new pcw setting will not be applied because
> its enable bit is 0.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Acked-by: Michael Turquette <mturuqette@baylibre.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-by: James Liao <jamesjj.liao@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-pll.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 65cee1d6c400..8d556fc99fed 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -124,9 +124,6 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  		int postdiv)
>  {
>  	u32 chg, val;
> -	int pll_en;
> -
> -	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
>  
>  	/* disable tuner */
>  	__mtk_pll_tuner_disable(pll);
> @@ -147,12 +144,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  			pll->data->pcw_shift);
>  	val |= pcw << pll->data->pcw_shift;
>  	writel(val, pll->pcw_addr);
> -
> -	chg = readl(pll->pcw_chg_addr);
> -
> -	if (pll_en)
> -		chg |= PCW_CHG_MASK;
> -
> +	chg = readl(pll->pcw_chg_addr) | PCW_CHG_MASK;
>  	writel(chg, pll->pcw_chg_addr);
>  	if (pll->tuner_addr)
>  		writel(val + 1, pll->tuner_addr);
> @@ -160,8 +152,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  	/* restore tuner_en */
>  	__mtk_pll_tuner_enable(pll);
>  
> -	if (pll_en)
> -		udelay(20);
> +	udelay(20);
>  }
>  
>  /*


