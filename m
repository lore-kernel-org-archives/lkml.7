Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB42C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2FD22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567598241;
	bh=+NE03vk26gxXt4brBoR8Ly4u6W2a1FR4Kab3VIiTjZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uYQfzIF4n/ijqLDtLhAeTuF/T8xhEyLd7q3izwcPLZdBdXJAmJdHiPM6fs6Mmt7yI
	 Wl4kUVzsW/ZxJ0AI83tRznXzIKNi1V5mYD2HI8Ab6hUycvbU6dqq0yXST2s+ZM61MD
	 CSuk6ub8DCToTFx7fYyD+y2QlB9EwXnIGU+tj1/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfIDL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbfIDL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:57:19 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645FE22CF5;
        Wed,  4 Sep 2019 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567598238;
        bh=+NE03vk26gxXt4brBoR8Ly4u6W2a1FR4Kab3VIiTjZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afyuI5uzMEDH6a4KE6v9ld04B/V44tuOtu0HDeP2s00PF2PgdW4svvMA0PpojB91x
         4AXefCNj5lzT9UaF+iF1IHuVdFhhIqVZxC8HH/SKPvqleIGzM4td2zoVemL9aa2d2r
         DoiZ5w4GmcZneXcnQ3uFLqupuL525W6wc7r/epFA=
Date:   Wed, 4 Sep 2019 17:26:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: qcom-geni: Provide an option to select FIFO
 processing
Message-ID: <20190904115609.GW2672@vkoul-mobl>
References: <20190904113613.14997-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904113613.14997-1-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 12:36, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index a89bfce5388e..dfdbce067827 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -353,13 +353,16 @@ static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev *gi2c)
>  static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>  				u32 m_param)
>  {
> +	struct device_node *np = gi2c->se.dev->of_node;
>  	dma_addr_t rx_dma;
>  	unsigned long time_left;
> -	void *dma_buf;
> +	void *dma_buf = NULL;
>  	struct geni_se *se = &gi2c->se;
>  	size_t len = msg->len;
>  
> -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> +	if (!of_property_read_bool(np, "qcom,geni-se-fifo"))

Where is this property documented, I dont see anything in linux-next for
today

> +		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> +
>  	if (dma_buf)
>  		geni_se_select_mode(se, GENI_SE_DMA);
>  	else
> @@ -392,13 +395,16 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>  static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
>  				u32 m_param)
>  {
> +	struct device_node *np = gi2c->se.dev->of_node;
>  	dma_addr_t tx_dma;
>  	unsigned long time_left;
> -	void *dma_buf;
> +	void *dma_buf = NULL;
>  	struct geni_se *se = &gi2c->se;
>  	size_t len = msg->len;
>  
> -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> +	if (!of_property_read_bool(np, "qcom,geni-se-fifo"))
> +		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> +
>  	if (dma_buf)
>  		geni_se_select_mode(se, GENI_SE_DMA);
>  	else
> -- 
> 2.17.1

-- 
~Vinod
