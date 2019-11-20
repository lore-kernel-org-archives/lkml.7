Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320CD2240D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 02:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmNVGtxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKTCdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 21:33:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34638 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKTCdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:33:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so12569672pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 18:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Z/IN6uvk+OR5RO5BaDOhPXntcLMJd2gG/07pm3/lZg=;
        b=UmNVGtxCF/JlQeaIxodJH+zJ4yCN8D9jCQtcc+m9MCbdg5g/o/F3kZv14M9cPcrEdW
         YZMJW3xAivm9Ss1HMwRpk6wlarbkcQ3X797wooyhJs2aI4I44KZZg7YUjzGj4iChPDsn
         Dp5eLZShdL/29UIrMGRbc8Q/CfBBmQrEaBX7VTrlc45KVgLKkTMrPXhz4YPYmTVgw0TX
         20C0YTazDiXyuDZU38u8BH7D9BmdujKK0AQReUIsPld5aHpf4xU3evQPRXveNi603lJF
         qnGVU1kn64q/ila1t5xHOIR1frg5avV+zN/BfERpm9it/zuy6DgV9dka3XBfH6BjlBpV
         5n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Z/IN6uvk+OR5RO5BaDOhPXntcLMJd2gG/07pm3/lZg=;
        b=Cfm5N4hj6baPCeMIdGBTmrXjSINbWUZ/KgM7rUFOW6qbiIzOgf1dEV9S2gxEC9PXzS
         oN4gwuSiu1N8dXVmX2rVJvSr6w6b8IsV2/5LMs2C8WpJPXUcP22R2f0ltVF/ANyjO6dd
         BYy81Ik5a6VchYys/QOaDzmZ0rATOwzAkiWh8M4CY5frfE63VvQfw/eBq7LxI13xjH/w
         2How+gEWWoGCjh6PvED4NXlrB5oOiJ0NZEttcK8e8us6Ka0cG9fohKuMFL32kl1aBkDf
         5Oyes+qecV1oxs2IS7I7eDf9G0Ui103msh9MJwk1P5F9e5WwLcC6SnXJHgJ/jmQ3hAd6
         RX6w==
X-Gm-Message-State: APjAAAW6amelFT9p1WEq7pRzxQ9XnRLdCJW7Rr8x5c0vzEzuYPf6Cmml
        qEwopj8J3zfbxIZfgyNCLfZ0lg==
X-Google-Smtp-Source: APXvYqwS6W5xe+gKVXg0c9cTWPKG03EEIKCJDmSqhZhYfoRR//DVj1MLjdRI5FjEkWywPc7EJQJVbw==
X-Received: by 2002:a63:a50d:: with SMTP id n13mr433224pgf.72.1574217197946;
        Tue, 19 Nov 2019 18:33:17 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f24sm4747108pjp.12.2019.11.19.18.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 18:33:17 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:33:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, ulf.hansson@linaro.org, rnayak@codeaurora.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 5/6] soc: qcom: rpmhpd: Add SC7180 RPMH power-domains
Message-ID: <20191120023314.GN18024@yoga>
References: <20191118173944.27043-1-sibis@codeaurora.org>
 <0101016e7f99dc94-4513a473-16b3-418a-86cf-a89322016215-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e7f99dc94-4513a473-16b3-418a-86cf-a89322016215-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 09:40 PST 2019, Sibi Sankar wrote:

> Add support for cx/mx/gfx/lcx/lmx/mss power-domains found
> on SC7180 SoCs.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmhpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 3b109ee67a4d2..599208722650d 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -166,7 +166,26 @@ static const struct rpmhpd_desc sm8150_desc = {
>  	.num_pds = ARRAY_SIZE(sm8150_rpmhpds),
>  };
>  
> +/* SC7180 RPMH powerdomains */
> +
> +static struct rpmhpd *sc7180_rpmhpds[] = {
> +	[SC7180_CX] = &sdm845_cx,
> +	[SC7180_CX_AO] = &sdm845_cx_ao,
> +	[SC7180_GFX] = &sdm845_gfx,
> +	[SC7180_MX] = &sdm845_mx,
> +	[SC7180_MX_AO] = &sdm845_mx_ao,
> +	[SC7180_LMX] = &sdm845_lmx,
> +	[SC7180_LCX] = &sdm845_lcx,
> +	[SC7180_MSS] = &sdm845_mss,
> +};
> +
> +static const struct rpmhpd_desc sc7180_desc = {
> +	.rpmhpds = sc7180_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sc7180_rpmhpds),
> +};
> +
>  static const struct of_device_id rpmhpd_match_table[] = {
> +	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>  	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>  	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
>  	{ }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
