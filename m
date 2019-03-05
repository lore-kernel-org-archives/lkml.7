Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE232075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCEGrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:47:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:22698 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbfCEGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:47:02 -0500
X-UUID: 77ac64e786c34eb9a1d578e37c77d0d1-20190305
X-UUID: 77ac64e786c34eb9a1d578e37c77d0d1-20190305
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2030606328; Tue, 05 Mar 2019 14:46:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Mar 2019 14:46:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 14:46:51 +0800
Message-ID: <1551768411.22671.3.camel@mtksdaap41>
Subject: Re: [PATCH v5 3/9] clk: mediatek: Add configurable pcwibits and
 fmin to mtk_pll_data
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
Date:   Tue, 5 Mar 2019 14:46:51 +0800
In-Reply-To: <20190305050546.23431-5-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
         <20190305050546.23431-5-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 13:05 +0800, Weiyi Lu wrote:
> From: Owen Chen <owen.chen@mediatek.com>
> 
> 1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
>    add a variable to indicate this change and
>    backward-compatible.
> 2. fmin: The pll freqency lower-bound is vary from 1GMhz to
>    1.5Ghz, add a variable to indicate platform-dependent.
> 
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Acked-by: Sean Wang <sean.wang@kernel.org>

Reviewed-by: James Liao <jamesjj.liao@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  drivers/clk/mediatek/clk-pll.c | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index f83c2bbb677e..11b5517903d0 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -214,8 +214,10 @@ struct mtk_pll_data {
>  	unsigned int flags;
>  	const struct clk_ops *ops;
>  	u32 rst_bar_mask;
> +	unsigned long fmin;
>  	unsigned long fmax;
>  	int pcwbits;
> +	int pcwibits;
>  	uint32_t pcw_reg;
>  	int pcw_shift;
>  	const struct mtk_pll_div_table *div_table;
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 18842d660317..67aaa3082d9b 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -32,6 +32,8 @@
>  #define AUDPLL_TUNER_EN		BIT(31)
>  
>  #define POSTDIV_MASK		0x7
> +
> +/* default 7 bits integer, can be overridden with pcwibits. */
>  #define INTEGER_BITS		7
>  
>  /*
> @@ -68,12 +70,15 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  		u32 pcw, int postdiv)
>  {
>  	int pcwbits = pll->data->pcwbits;
> -	int pcwfbits;
> +	int pcwfbits = 0;
> +	int ibits;
>  	u64 vco;
>  	u8 c = 0;
>  
>  	/* The fractional part of the PLL divider. */
> -	pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> +	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +	if (pcwbits > ibits)
> +		pcwfbits = pcwbits - ibits;
>  
>  	vco = (u64)fin * pcw;
>  
> @@ -170,9 +175,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>  		u32 freq, u32 fin)
>  {
> -	unsigned long fmin = 1000 * MHZ;
> +	unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
>  	const struct mtk_pll_div_table *div_table = pll->data->div_table;
>  	u64 _pcw;
> +	int ibits;
>  	u32 val;
>  
>  	if (freq > pll->data->fmax)
> @@ -196,7 +202,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>  	}
>  
>  	/* _pcw = freq * postdiv / fin * 2^pcwfbits */
> -	_pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> +	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +	_pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
>  	do_div(_pcw, fin);
>  
>  	*pcw = (u32)_pcw;


