Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB60C41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C650422CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoH/Dtjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfIDUfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:35:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41535 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbfIDUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:35:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so13394pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9dPfxiGVl9B5eQCHDgsbYOLG2ykYyi/7SM+jtLAnog=;
        b=IoH/DtjsZSHeuM5ZH1ZL9Fy+rFnrY2sGhJTxYoxekXhLlmUNBAwbZWtGkaZWeLkrWB
         p/OHUOdc3ZVgXUSWEXgPCdOxzHj6ou+8a/ZlebDKFUrcBI8Zk36WiZ7RUbG2Hn1T5Xy6
         q4NVyGK9q203NBKeABXcjGCfEhXMgChZweccIQ+Inc7zwHL8h+V9H4Eoo0tWROMxKNck
         zeuF2Fq/ec/RE8H+zHbNtYl55DYiCg2BVdGE41d25DtwtA1Bl1qs11JMSGCNhXZoNW7G
         GszHlkzz1S81UpO64iP8lHJFTqcYhkcuFgvYXx6J8GUw8BLi/FgP2ITaAvZ2KhBllLib
         M6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9dPfxiGVl9B5eQCHDgsbYOLG2ykYyi/7SM+jtLAnog=;
        b=Eb2KMwgKOTINqPZphCrJOpT7ID/KnIryt5/ZF5LXIk2+OtwUWyZyTkWM6DPlqlnGKX
         bzK5QcSJ1P8HwZuksMqc/RILfdftIeUUBm2iRRSTPi/5WzmDuFlkf2v2d/mNjbWGz57Q
         fsyZk+wJ93ID1fZwkm4u4qJ8d5V1LUgMqBwDyd0ypR8QR0+TxYkgVSKsD88Ik7eBgfK2
         I1sXGUev+0yPlW941tHoIXvnovOPKvSDtJT9WxgpCn5HIlimzVDsF4evf4uZjbUcfSk8
         QNPwkk8bDIr3Cxt4FrxcPd2Dgqf1Oxgx16WqL86VCpjqT5HkqtzTBHzaq+V2EH8EKOit
         Ei2Q==
X-Gm-Message-State: APjAAAXN0dXYlUvmmfU6Yec6orgVqGPCRFiXKgdEUm0GxWPQxEpb9WAg
        0yK3egnRfNVePK0M3ETFUmto4Q==
X-Google-Smtp-Source: APXvYqyNUCdVh4CrjvfM5UYakm4eAZf3UXsz8CmJ1f360GpgwL9mGAfC1CL0i304toSE0+cTRHBGxA==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr38808pgc.348.1567629351901;
        Wed, 04 Sep 2019 13:35:51 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h70sm14724pgc.36.2019.09.04.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 13:35:51 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:35:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: qcom-geni: Provide an option to select FIFO
 processing
Message-ID: <20190904203548.GC580@tuxbook-pro>
References: <20190904113613.14997-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904113613.14997-1-lee.jones@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Sep 04:36 PDT 2019, Lee Jones wrote:

The subject implies that we select FIFO mode instead of DMA, but that's
not really true, because with DMA enabled we still fall back to FIFO for
messages below 32 bytes. 

So what this does it to disable DMA, which neither the subject or the DT
property describes.

Also missing is a description of why this is needed.

Regards,
Bjorn

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
> 
