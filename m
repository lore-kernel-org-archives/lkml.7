Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFDCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0D021D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwmWtewK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfJYV7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:59:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37039 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:59:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so2491332pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eW3QcADxWiA9bB+f1V3Z1+dcU/1XE8CGZphcypGekbY=;
        b=qwmWtewKTdVLT5daUxPBZ5FzRpQl/egXLrBQ+UeZlpbEcHCiFqCaJklDEfi4dFeioG
         /XiO73dbDOzSSEE0e8De1pxiRwZ82JdWzsFQbae0oD79Pxhqy6EVKuu4BKTBEkvC1nMa
         m3nTmAaZ5lJOwxsHqbeokO4CRoYMoCgFlTZrR2iNULK3dzXeUmsnDqhk1sIspgID48YJ
         jKHqlgxD3nXUuqVQk2uwhEI9NgoalG4q+9bExzO5fTaykJS13q4yv6FQ6bKvkosayM2c
         ySkyd6GIpHirJ0zV2dZlTAiKIXtdOi7lS9lY13KClqTq1nv1w3qqvyeAPyYB1sKvas75
         WFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eW3QcADxWiA9bB+f1V3Z1+dcU/1XE8CGZphcypGekbY=;
        b=nag2HEZaFNXv/noJWxEVhCOww1vIszixzNLPCoWKeEmNkt7zaFYuQt5i6DGwhA7qAv
         +WdzbC3bGaUMY4DeszJLcvs0xvxFrKw2K+X90Sd4i1Do794R7AtZ85N2UMU21Yf0pnS9
         ie3bxPSC1zb05X1+/y17LKYxOuBp0S4M0Ta+gkNUneAp91NEvMT1wtG0qEOzQLe3rZ39
         qYjWd09/ca0VXTF38gtAmCzFewgBym2Ba4XAsGHBpHpf51DRRSj5mvIIujFh3M0EjBC4
         NOURUCN2LhrBcL4j6ZguiX+l9DrzLiujb6MM0FdkG9wUHVKQhQlAFShg6kk5sfw2klb8
         FyIg==
X-Gm-Message-State: APjAAAX+bwC24ZO3JBOrE40OBdMbf3I4CiYXZzZSfHYtuT5HwwTqDXoJ
        EFaXQf/pVMKXu153yCjmaCk=
X-Google-Smtp-Source: APXvYqzAlyQ6QgA1OIplwWAdTMmiF8dDyvSSD0lN3oGKWYGdoPCg4gqnizy04m7h1H3tGg509ldamQ==
X-Received: by 2002:a17:90a:d351:: with SMTP id i17mr6807596pjx.36.1572040779795;
        Fri, 25 Oct 2019 14:59:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d5sm2815101pjw.31.2019.10.25.14.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 14:59:39 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:59:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ASoC: fsl_asrc: refine the setting of internal clock
 divider
Message-ID: <20191025215919.GB15101@Asurada-Nvidia.nvidia.com>
References: <a0cd2ecf5e833fbdc064ba73391481d6073e7254.1571986398.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0cd2ecf5e833fbdc064ba73391481d6073e7254.1571986398.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:13:22PM +0800, Shengjiu Wang wrote:
> The output divider should align with the output sample
> rate, if use ideal sample rate, there will be a lot of overload,
> which would cause underrun.
> 
> The maximum divider of asrc clock is 1024, but there is no
> judgement for this limitaion in driver, which may cause the divider

typo: "limitaion" => "limitation"

> setting not correct.
> 
> For non-ideal ratio mode, the clock rate should divide the sample
> rate with no remainder, and the quotient should be less than 1024.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

And some comments inline. Please add my ack once they are fixed:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0bf91a6f54b9..89cf333154c7 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -259,8 +259,11 @@ static int fsl_asrc_set_ideal_ratio(struct fsl_asrc_pair *pair,
>   * It configures those ASRC registers according to a configuration instance
>   * of struct asrc_config which includes in/output sample rate, width, channel
>   * and clock settings.
> + *
> + * Note:
> + * use_ideal_rate = true is need by some case which need higher performance.

I feel we can have a detailed one here and drop those inline comments, e.g.:

+ * Note:
+ * The ideal ratio configuration can work with a flexible clock rate setting.
+ * Using IDEAL_RATIO_RATE gives a faster converting speed but overloads ASRC.
+ * For a regular audio playback, the clock rate should not be slower than an
+ * clock rate aligning with the output sample rate; For a use case requiring
+ * faster conversion, set use_ideal_rate to have the faster speed.

> @@ -351,8 +355,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	/* We only have output clock for ideal ratio mode */
>  	clk = asrc_priv->asrck_clk[clk_index[ideal ? OUT : IN]];
>  
> -	div[IN] = clk_get_rate(clk) / inrate;
> -	if (div[IN] == 0) {
> +	clk_rate = clk_get_rate(clk);
> +	rem[IN] = do_div(clk_rate, inrate);
> +	div[IN] = (u32)clk_rate;

> +	if (div[IN] == 0 || (!ideal && (div[IN] > 1024 || rem[IN] != 0))) {

Should have some comments to explain this like:
	/*
	 * The divider range is [1, 1024], defined by the hardware. For non-
	 * ideal ratio configuration, clock rate has to be strictly aligned
	 * with the sample rate. For ideal ratio configuration, clock rates
	 * only result in different converting speeds. So remainder does not
	 * matter, as long as we keep the divider within its valid range.
	 */
>  		pair_err("failed to support input sample rate %dHz by asrck_%x\n",
>  				inrate, clk_index[ideal ? OUT : IN]);
>  		return -EINVAL;

And move the min() behind this if-condition with no more comments:
+	div[IN] = min_t(u32, 1024, div[IN]);

> @@ -360,18 +366,29 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  
>  	clk = asrc_priv->asrck_clk[clk_index[OUT]];
>  
> -	/* Use fixed output rate for Ideal Ratio mode (INCLK_NONE) */
> -	if (ideal)
> -		div[OUT] = clk_get_rate(clk) / IDEAL_RATIO_RATE;
> +	/*
> +	 * Output rate should be align with the out samplerate. If set too
> +	 * high output rate, there will be lots of Overload.
> +	 * But some case need higher performance, then we can use
> +	 * IDEAL_RATIO_RATE specifically for such case.
> +	 */

Can drop this since we have the detailed comments at the top.

> +	clk_rate = clk_get_rate(clk);
> +	if (ideal && use_ideal_rate)
> +		rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
>  	else
> -		div[OUT] = clk_get_rate(clk) / outrate;
> +		rem[OUT] = do_div(clk_rate, outrate);
> +	div[OUT] = clk_rate;
>  
> -	if (div[OUT] == 0) {

And add before this if-condition:

	/* Output divider has the same limitation as the input one */

> +	if (div[OUT] == 0 || (!ideal && (div[OUT] > 1024 || rem[OUT] != 0))) {
>  		pair_err("failed to support output sample rate %dHz by asrck_%x\n",
>  				outrate, clk_index[OUT]);
>  		return -EINVAL;
>  	}
>  
> +	/* Divider range is [1, 1024] */

Can drop this too.

> +	div[IN] = min_t(u32, 1024, div[IN]);
> +	div[OUT] = min_t(u32, 1024, div[OUT]);

