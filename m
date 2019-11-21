Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D400CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7143206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUOdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:33:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37907 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:33:38 -0500
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1iXnWH-00030p-Ep; Thu, 21 Nov 2019 15:33:17 +0100
Date:   Thu, 21 Nov 2019 15:33:16 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, ravi.patel@xilinx.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        m.tretter@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH 4/7] clk: zynqmp: Add support for get max divider
Message-ID: <20191121153316.39e551e5@litschi.hi.pengutronix.de>
In-Reply-To: <1573564580-9006-5-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
        <1573564580-9006-5-git-send-email-rajan.vaja@xilinx.com>
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

On Tue, 12 Nov 2019 05:16:17 -0800, Rajan Vaja wrote:
> To achieve best possible rate, maximum limit of divider is required
> while computation. Get maximum supported divisor from firmware. To
> maintain backward compatibility assign maximum possible value(0xFFFF)
> if query for max divisor is not successful.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/clk/zynqmp/divider.c         | 19 +++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> index d8f5b70d..b79cd45 100644
> --- a/drivers/clk/zynqmp/divider.c
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -41,6 +41,7 @@ struct zynqmp_clk_divider {
>  	bool is_frac;
>  	u32 clk_id;
>  	u32 div_type;
> +	u16 max_div;
>  };
>  
>  static inline int zynqmp_divider_get_val(unsigned long parent_rate,
> @@ -195,6 +196,9 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
>  	struct clk_hw *hw;
>  	struct clk_init_data init;
>  	int ret;
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +	struct zynqmp_pm_query_data qdata = {0};
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
>  
>  	/* allocate the divider */
>  	div = kzalloc(sizeof(*div), GFP_KERNEL);
> @@ -215,6 +219,21 @@ struct clk_hw *zynqmp_clk_register_divider(const char *name,
>  	div->clk_id = clk_id;
>  	div->div_type = nodes->type;
>  
> +	/*
> +	 * To achieve best possible rate, maximum limit of divider is required
> +	 * while computation. Get maximum supported divisor from firmware. To
> +	 * maintain backward compatibility assign maximum possible value(0xFFFF)
> +	 * if query for max divisor is not successful.
> +	 */
> +	qdata.qid = PM_QID_CLOCK_GET_MAX_DIVISOR;
> +	qdata.arg1 = clk_id;
> +	qdata.arg2 = nodes->type;
> +	ret = eemi_ops->query_data(qdata, ret_payload);
> +	if (ret)
> +		div->max_div = U16_MAX;
> +	else
> +		div->max_div = ret_payload[1];

Add a helper function for retrieving the max divisor. The clk_register
function should really not be mixed with code to access the firmware.

Michael

> +
>  	hw = &div->hw;
>  	ret = clk_hw_register(NULL, hw);
>  	if (ret) {
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index f019d1c..f0d4558 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -114,6 +114,7 @@ enum pm_query_id {
>  	PM_QID_CLOCK_GET_PARENTS,
>  	PM_QID_CLOCK_GET_ATTRIBUTES,
>  	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
> +	PM_QID_CLOCK_GET_MAX_DIVISOR,
>  };
>  
>  enum zynqmp_pm_reset_action {
