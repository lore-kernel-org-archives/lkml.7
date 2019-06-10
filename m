Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04861C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52702085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfFJNgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:36:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390071AbfFJNgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:36:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38F21ADC1;
        Mon, 10 Jun 2019 13:36:43 +0000 (UTC)
Subject: Re: [PATCH 1/7] clk: actions: Fix factor clk struct member access
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sboyd@kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <29ef33a9-f1f1-fe10-9288-8103714d40fa@suse.de>
Date:   Mon, 10 Jun 2019 15:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> Since the helper "owl_factor_helper_round_rate" is shared between factor
> and composite clocks, using the factor clk specific helper function
> like "hw_to_owl_factor" to access its members will create issues when
> called from composite clk specific code. Hence, pass the "factor_hw"
> struct pointer directly instead of fetching it using factor clk specific
> helpers.
> 
> This issue has been observed when a composite clock like "sd0_clk" tried
> to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> error.
> 
> Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/clk/actions/owl-factor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
> index 317d4a9e112e..f419dfdd334f 100644
> --- a/drivers/clk/actions/owl-factor.c
> +++ b/drivers/clk/actions/owl-factor.c
> @@ -64,11 +64,10 @@ static unsigned int _get_table_val(const struct clk_factor_table *table,
>  	return val;
>  }
>  
> -static int clk_val_best(struct clk_hw *hw, unsigned long rate,
> +static int clk_val_best(const struct owl_factor_hw *factor_hw,
> +			struct clk_hw *hw, unsigned long rate,
>  			unsigned long *best_parent_rate)
>  {
> -	struct owl_factor *factor = hw_to_owl_factor(hw);
> -	struct owl_factor_hw *factor_hw = &factor->factor_hw;
>  	const struct clk_factor_table *clkt = factor_hw->table;
>  	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
>  	unsigned long parent_rate_saved = *best_parent_rate;
> @@ -126,7 +125,7 @@ long owl_factor_helper_round_rate(struct owl_clk_common *common,
>  	const struct clk_factor_table *clkt = factor_hw->table;
>  	unsigned int val, mul = 0, div = 1;
>  
> -	val = clk_val_best(&common->hw, rate, parent_rate);
> +	val = clk_val_best(factor_hw, &common->hw, rate, parent_rate);
>  	_get_table_div_mul(clkt, val, &mul, &div);
>  
>  	return *parent_rate * mul / div;

While at it, I think it would be a good idea to rename it to
owl_clk_val_best. Pretty confusing that you're touching only owl files
for a clk_ refactoring, which sounds like common clk code.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
