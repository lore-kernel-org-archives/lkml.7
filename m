Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4591DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E71C2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfKGQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:49:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47761 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:49:52 -0500
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1iSkyR-0001OE-Fq; Thu, 07 Nov 2019 17:49:31 +0100
Date:   Thu, 7 Nov 2019 17:49:28 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] clk: zynqmp: Add support for custom type flags
Message-ID: <20191107174928.71a921f0@litschi.hi.pengutronix.de>
In-Reply-To: <1573117086-7405-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573117086-7405-1-git-send-email-rajan.vaja@xilinx.com>
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

On Thu, 07 Nov 2019 00:58:06 -0800, Rajan Vaja wrote:
> Store extra custom type flags received from firmware.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/clk/zynqmp/clkc.c    | 8 +++++++-
>  drivers/clk/zynqmp/divider.c | 4 ++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index a11f93e..0dea55e 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -2,7 +2,7 @@
>  /*
>   * Zynq UltraScale+ MPSoC clock controller
>   *
> - *  Copyright (C) 2016-2018 Xilinx
> + *  Copyright (C) 2016-2019 Xilinx
>   *
>   * Based on drivers/clk/zynq/clkc.c
>   */
> @@ -86,6 +86,8 @@ struct topology_resp {
>  #define CLK_TOPOLOGY_TYPE		GENMASK(3, 0)
>  #define CLK_TOPOLOGY_FLAGS		GENMASK(23, 8)
>  #define CLK_TOPOLOGY_TYPE_FLAGS		GENMASK(31, 24)
> +#define CLK_TOPOLOGY_TYPE_FLAG2		GENMASK(7, 4)

What kind of function do these flags indicate? The name is really not
obvious to me.

I would prefer if the defines are kept in the order of the bits in the
field, i.e., the new define should go between CLK_TOPOLOGY_TYPE and
CLK_TOPOLOGY_FLAGS.

> +#define CLK_TOPOLOGY_TYPE_FLAG_BITS	8
>  	u32 topology[CLK_GET_TOPOLOGY_RESP_WORDS];
>  };
>  
> @@ -396,6 +398,10 @@ static int __zynqmp_clock_get_topology(struct clock_topology *topology,
>  		topology[*nnodes].type_flag =
>  				FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
>  					  response->topology[i]);
> +		topology[*nnodes].type_flag |=
> +			FIELD_GET(CLK_TOPOLOGY_TYPE_FLAG2,
> +				  response->topology[i]) <<
> +			CLK_TOPOLOGY_TYPE_FLAG_BITS;

Shifting the new flags into the existing type_flag field seems like a
source for code that is really difficult to read. Maybe use a new field
in the topology for the new flags with a proper name?

>  		(*nnodes)++;
>  	}
>  
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index d8f5b70d..d376529 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -2,7 +2,7 @@
>  /*
>   * Zynq UltraScale+ MPSoC Divider support
>   *
> - *  Copyright (C) 2016-2018 Xilinx
> + *  Copyright (C) 2016-2019 Xilinx
>   *
>   * Adjustable divider clock implementation
>   */
> @@ -37,7 +37,7 @@
>   */
>  struct zynqmp_clk_divider {
>  	struct clk_hw hw;
> -	u8 flags;
> +	u16 flags;

This change looks unrelated to the remaining patch.

Michael

>  	bool is_frac;
>  	u32 clk_id;
>  	u32 div_type;
