Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57286C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3663920656
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKUOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:41:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKUOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:41:56 -0500
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1iXneJ-000425-JC; Thu, 21 Nov 2019 15:41:35 +0100
Date:   Thu, 21 Nov 2019 15:41:34 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, ravi.patel@xilinx.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, m.tretter@pengutronix.de
Subject: Re: [PATCH 7/7] clk: zynqmp: Fix fractional clock check
Message-ID: <20191121154134.404304c9@litschi.hi.pengutronix.de>
In-Reply-To: <1573564580-9006-8-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
        <1573564580-9006-8-git-send-email-rajan.vaja@xilinx.com>
Organization: Pengutronix
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe6a:8db5
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 05:16:20 -0800, Rajan Vaja wrote:
> Firmware driver sets BIT(4) to BIT(7) as custom type flags. To make
> divider as fractional divider firmware sets BIT(4). So add support
> for custom type flag and use BIT(4) of custom type flag as CLOCK_FRAC
> bit.
> 
> Add a new field to the clock_topology to store custom type flags.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/clk/zynqmp/clk-zynqmp.h | 1 +
>  drivers/clk/zynqmp/clkc.c       | 4 ++++
>  drivers/clk/zynqmp/divider.c    | 7 +++----
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/clk-zynqmp.h b/drivers/clk/zynqmp/clk-zynqmp.h
> index fec9a15..5beeb41 100644
> --- a/drivers/clk/zynqmp/clk-zynqmp.h
> +++ b/drivers/clk/zynqmp/clk-zynqmp.h
> @@ -30,6 +30,7 @@ struct clock_topology {
>  	u32 type;
>  	u32 flag;
>  	u32 type_flag;
> +	u8 custom_type_flag;
>  };
>  
>  struct clk_hw *zynqmp_clk_register_pll(const char *name, u32 clk_id,
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index 10e89f2..4dd8413 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -84,6 +84,7 @@ struct name_resp {
>  
>  struct topology_resp {
>  #define CLK_TOPOLOGY_TYPE		GENMASK(3, 0)
> +#define CLK_TOPOLOGY_CUSTOM_TYPE_FLAGS	GENMASK(7, 4)
>  #define CLK_TOPOLOGY_FLAGS		GENMASK(23, 8)
>  #define CLK_TOPOLOGY_TYPE_FLAGS		GENMASK(31, 24)
>  	u32 topology[CLK_GET_TOPOLOGY_RESP_WORDS];
> @@ -396,6 +397,9 @@ static int __zynqmp_clock_get_topology(struct clock_topology *topology,
>  		topology[*nnodes].type_flag =
>  				FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
>  					  response->topology[i]);
> +		topology[*nnodes].custom_type_flag =
> +			FIELD_GET(CLK_TOPOLOGY_CUSTOM_TYPE_FLAGS,
> +				  response->topology[i]);
>  		(*nnodes)++;
>  	}
>  
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index 67aa88c..e700504 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -25,7 +25,7 @@
>  #define to_zynqmp_clk_divider(_hw)		\
>  	container_of(_hw, struct zynqmp_clk_divider, hw)
>  
> -#define CLK_FRAC	BIT(13) /* has a fractional parent */
> +#define CLK_FRAC	BIT(4) /* has a fractional parent */

Still NACK. This breaks the compatibility with the mainline TF-A. The
bit is now a different from the bit than in the previous version of
that patch. Moving the flag to custom_type_flags is fine, but please
make sure that you stay backwards compatible to existing versions of the
TF-A.

Michael

>  
>  /**
>   * struct zynqmp_clk_divider - adjustable divider clock
> @@ -279,13 +279,12 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
>  
>  	init.name = name;
>  	init.ops = &zynqmp_clk_divider_ops;
> -	/* CLK_FRAC is not defined in the common clk framework */
> -	init.flags = nodes->flag & ~CLK_FRAC;
> +	init.flags = nodes->flag;
>  	init.parent_names = parents;
>  	init.num_parents = 1;
>  
>  	/* struct clk_divider assignments */
> -	div->is_frac = !!(nodes->flag & CLK_FRAC);
> +	div->is_frac = !!(nodes->custom_type_flag & CLK_FRAC);
>  	div->flags = nodes->type_flag;
>  	div->hw.init = &init;
>  	div->clk_id = clk_id;
