Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A1AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959082166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfGZIin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:38:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51930 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfGZIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:38:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 24CCF1A0413;
        Fri, 26 Jul 2019 10:38:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 17CB21A0966;
        Fri, 26 Jul 2019 10:38:41 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F0415205E6;
        Fri, 26 Jul 2019 10:38:40 +0200 (CEST)
Date:   Fri, 26 Jul 2019 11:38:40 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx8mn: Keep uart clocks on for early console
Message-ID: <20190726083840.k26dyjgpq4b56gab@fsr-ub1664-175>
References: <20190724075017.11003-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724075017.11003-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-24 15:50:17, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Call imx_register_uart_clocks() API to keep uart clocks enabled
> when earlyprintk or earlycon is active.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mn.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 07481a5..ecd1062 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -355,6 +355,14 @@ static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sy
>  static struct clk *clks[IMX8MN_CLK_END];
>  static struct clk_onecell_data clk_data;
>  
> +static struct clk ** const uart_clks[] = {
> +	&clks[IMX8MN_CLK_UART1_ROOT],
> +	&clks[IMX8MN_CLK_UART2_ROOT],
> +	&clks[IMX8MN_CLK_UART3_ROOT],
> +	&clks[IMX8MN_CLK_UART4_ROOT],
> +	NULL
> +};
> +
>  static int imx8mn_clocks_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -612,6 +620,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  		goto unregister_clks;
>  	}
>  
> +	imx_register_uart_clocks(uart_clks);
> +
>  	return 0;
>  
>  unregister_clks:
> -- 
> 2.7.4
> 
