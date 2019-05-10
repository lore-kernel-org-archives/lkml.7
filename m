Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1AC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633B420989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfEJVmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:42:11 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44879 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfEJVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:42:11 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id AF7EC240002;
        Fri, 10 May 2019 21:42:07 +0000 (UTC)
Date:   Fri, 10 May 2019 23:42:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] clk: at91: sckc: add support for SAM9X60
Message-ID: <20190510214207.GG7622@piout.net>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557487388-32098-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 11:23:40+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add support for SAM9X60's slow clock.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/sckc.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index 2a4ac548de80..2c410f41b413 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -415,6 +415,80 @@ static void __init of_sama5d3_sckc_setup(struct device_node *np)
>  CLK_OF_DECLARE(sama5d3_clk_sckc, "atmel,sama5d3-sckc",
>  	       of_sama5d3_sckc_setup);
>  
> +static const struct clk_slow_bits at91sam9x60_bits = {
> +	.cr_osc32en = BIT(1),
> +	.cr_osc32byp = BIT(2),
> +	.cr_oscsel = BIT(24),
> +};
> +
> +static void __init of_sam9x60_sckc_setup(struct device_node *np)
> +{
> +	void __iomem *regbase = of_iomap(np, 0);
> +	struct clk_hw_onecell_data *clk_data;
> +	struct clk_hw *slow_rc, *slow_osc;
> +	const char *xtal_name;
> +	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
> +	bool bypass;
> +	int ret;
> +
> +	if (!regbase)
> +		return;
> +
> +	slow_rc = clk_hw_register_fixed_rate(NULL, parent_names[0], NULL, 0,
> +					     32768);
> +	if (IS_ERR(slow_rc))
> +		return;
> +
> +	xtal_name = of_clk_get_parent_name(np, 0);
> +	if (!xtal_name)
> +		goto unregister_slow_rc;
> +
> +	bypass = of_property_read_bool(np, "atmel,osc-bypass");
> +	slow_osc = at91_clk_register_slow_osc(regbase, parent_names[1],
> +					      xtal_name, 5000000, bypass,
> +					      &at91sam9x60_bits);
> +	if (IS_ERR(slow_osc))
> +		goto unregister_slow_rc;
> +
> +	clk_data = kzalloc(sizeof(*clk_data) + (2 * sizeof(struct clk_hw *)),
> +			   GFP_KERNEL);
> +	if (!clk_data)
> +		goto unregister_slow_osc;
> +
> +	/* MD_SLCK and TD_SLCK. */
> +	clk_data->num = 2;
> +	clk_data->hws[0] = clk_hw_register_fixed_rate(NULL, "md_slck",
> +						      parent_names[0],
> +						      0, 32768);
> +	if (IS_ERR(clk_data->hws[0]))
> +		goto clk_data_free;
> +
> +	clk_data->hws[1] = at91_clk_register_sam9x5_slow(regbase, "td_slck",
> +							 parent_names, 2,
> +							 &at91sam9x60_bits);
> +	if (IS_ERR(clk_data->hws[1]))
> +		goto unregister_md_slck;
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
> +	if (WARN_ON(ret))
> +		goto unregister_td_slck;
> +
> +	return;
> +
> +unregister_td_slck:
> +	clk_hw_unregister(clk_data->hws[1]);
> +unregister_md_slck:
> +	clk_hw_unregister(clk_data->hws[0]);
> +clk_data_free:
> +	kfree(clk_data);
> +unregister_slow_osc:
> +	clk_hw_unregister(slow_osc);
> +unregister_slow_rc:
> +	clk_hw_unregister(slow_rc);
> +}
> +CLK_OF_DECLARE(sam9x60_clk_sckc, "microchip,sam9x60-sckc",
> +	       of_sam9x60_sckc_setup);
> +
>  static int clk_sama5d4_slow_osc_prepare(struct clk_hw *hw)
>  {
>  	struct clk_sama5d4_slow_osc *osc = to_clk_sama5d4_slow_osc(hw);
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
