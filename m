Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC67ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7093921835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jeyw1ZDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406801AbfJQVzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:55:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36887 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391375AbfJQVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:55:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so2123174pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MJq2EdV7BErF5lJZPOikwtBvnPNcMCKE+E09QYJDAoE=;
        b=Jeyw1ZDd5uAKRjJQmfyb+T0v/f6rIVWTceUIwX20g2+Ga6I91WfJuBnTL/DPxTZL5z
         HKJjnkJAncD5XImoBq7AkDzdyK97rJN/7OH0yKTx8fzWkLRU1nyrjtxhEcw8zzso+0U2
         DJNGBkyCFX7HUwCQF+cTvU0l7AsQXoDkoevKLz3/HfKu55M/n9GQXtxQkwzao4e7UJAt
         W44oCFETT+1Hrfn9p/iGgjnkyGZMFObQP/F3nt5x+0IWbC4EIUW38BB7Srk5IZT63tzm
         SCfHVu2649tchRM12hl8UrKMunl00VbS/rcr8+rQayKOIAhfuW3jbPskVlbfAmqjS92i
         ygcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJq2EdV7BErF5lJZPOikwtBvnPNcMCKE+E09QYJDAoE=;
        b=GQ14+qT3Y63JleWbNcPQkX+JQngh/PEL0+cso4pK98cUv0eTXfRYOTKw4F06PFYn/d
         YHdj/obmQsesSURivj/Cf1hMSgyOoL3VhzY/ZQA0T34ytvcdy+zN9e0ZCBzj7QRCXL9K
         ueWetqDg8hu1h89i13unsYqqcB2GRz/3b/9ZbbTJDqbMZmfSm0MjYIKPnmsUyNdes4to
         AO7XQjVQAPmtIaMm3zLoVIs0EzrPgOScxu8fSdyL+xWy/RlfNYKXd1wEvHNadM8NLLM0
         lKGimdUU2ZReO9cumMywN/+lkPtjXVhCl/ltHcuei4nUS+64SdV9bChhw/NPVfKij29/
         jGqA==
X-Gm-Message-State: APjAAAWqVtj/M/M7wJzc9W9YevCppj2OcnucPvLnGzT6YVzH9b1otdJR
        hQRVkngBSz39yeYS053JQWE=
X-Google-Smtp-Source: APXvYqw78bUK9yECzvnmzVx8o9WcY5erYsU7dMfmJka8ZozhZHP1ynlTvAkvFQxYqlruVSaWIpHZTg==
X-Received: by 2002:aa7:93de:: with SMTP id y30mr2552141pff.98.1571349321994;
        Thu, 17 Oct 2019 14:55:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y8sm3577837pgs.34.2019.10.17.14.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 14:55:21 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:54:53 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: refine the setting of internal clock
 divider
Message-ID: <20191017215452.GA19069@Asurada-Nvidia.nvidia.com>
References: <1571293268-5146-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571293268-5146-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shengjiu,

On Thu, Oct 17, 2019 at 02:21:08PM +0800, Shengjiu Wang wrote:
> For P2P output, the output divider should align with the output sample

I think we should avoid "P2P" (or "M2M") keyword in the mainline
code as we know M2M will never get merged while somebody working
with the mainline and caring about new feature might be confused.

> rate, if use ideal sample rate, there will be a lot of overload, which
> would cause underrun.

If I understand it correctly, setting to ideal ratio provides a
faster converting speed but increases the load of the processor
of ASRC. So we choose a slower converting speed here since real-
time playback mode doesn't really need a faster conversion?

It makes sense to me, yet I feel that the delay at the beginning
of the audio playback might be longer as a compromise. I am okay
with this decision though...

> The maximum divider of asrc clock is 1024, but there is no judgement
> for this limitaion in driver, which may cause the divider setting not
> correct.
> 
> For non-ideal ratio mode, the clock rate should divide the sample rate
> with no remainder, and the quotient should be less than 1024.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0bf91a6f54b9..44d05ec28bd3 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -260,7 +260,7 @@ static int fsl_asrc_set_ideal_ratio(struct fsl_asrc_pair *pair,
>   * of struct asrc_config which includes in/output sample rate, width, channel
>   * and clock settings.
>   */
> -static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
> +static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool p2p)
>  {
>  	struct asrc_config *config = pair->config;
>  	struct fsl_asrc *asrc_priv = pair->asrc_priv;
> @@ -268,7 +268,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	enum asrc_word_width input_word_width;
>  	enum asrc_word_width output_word_width;
>  	u32 inrate, outrate, indiv, outdiv;
> -	u32 clk_index[2], div[2];
> +	u32 clk_index[2], div[2], rem[2];
> +	u64 clk_rate;
>  	int in, out, channels;
>  	int pre_proc, post_proc;
>  	struct clk *clk;
> @@ -351,7 +352,9 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	/* We only have output clock for ideal ratio mode */
>  	clk = asrc_priv->asrck_clk[clk_index[ideal ? OUT : IN]];
>  
> -	div[IN] = clk_get_rate(clk) / inrate;
> +	clk_rate = clk_get_rate(clk);

The fsl_asrc.c file has config.inclk being set to INCLK_NONE and
this sets the "ideal" in this function to true. So, although we
tend to not use ideal ratio setting for p2p cases, yet the input
clock is still not physically connected, so we still use output
clock for div[IN] calculation?

I am thinking something simplier: if we decided not to use ideal
ratio for "P2P", instead of adding "bool p2p" with the confusing
"ideal" in this function, could we just set config.inclk to the
same clock as the output one for "P2P"? By doing so, "P2P" won't
go through ideal ratio mode while still having a clock rate from
the output clock for div[IN] calculation here.

> +	rem[IN] = do_div(clk_rate, inrate);
> +	div[IN] = (u32)clk_rate;
>  	if (div[IN] == 0) {

Could we check div[IN] and rem[IN] here? Like:
  	if (div[IN] == 0 || div[IN] > 1024) {
		pair_err();
		goto out;
	}

	if (!ideal && rem[IN]) {
		pair_err();
		goto out;
	}

According to your commit log, I think the max-1024 limitation
should be applied to all cases, not confined to "!ideal" cases
right? And we should add some comments also, indicating it is
limited by hardware.

>  		pair_err("failed to support input sample rate %dHz by asrck_%x\n",
>  				inrate, clk_index[ideal ? OUT : IN]);
> @@ -360,11 +363,20 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  
>  	clk = asrc_priv->asrck_clk[clk_index[OUT]];
>  
> -	/* Use fixed output rate for Ideal Ratio mode (INCLK_NONE) */
> -	if (ideal)
> -		div[OUT] = clk_get_rate(clk) / IDEAL_RATIO_RATE;
> -	else
> -		div[OUT] = clk_get_rate(clk) / outrate;
> +	/*
> +	 * When P2P mode, output rate should align with the out samplerate.
> +	 * if set too high output rate, there will be lots of Overload.
> +	 * When M2M mode, output rate should also need to align with the out

For this "should", do you actually mean "M2M could also"? Sorry,
I'm just trying to understand everyting here, not intentionally
being picky at words. My understanding is that we still keep the
ideal ratio setting because "M2M" still uses it.

> +	 * samplerate, but M2M must use less time to achieve good performance.
> +	 */
> +	clk_rate = clk_get_rate(clk);
> +	if (p2p || !ideal) {
> +		rem[OUT] = do_div(clk_rate, outrate);
> +		div[OUT] = clk_rate;
> +	} else {
> +		rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
> +		div[OUT] = clk_rate;
> +	}
>  
>  	if (div[OUT] == 0) {
>  		pair_err("failed to support output sample rate %dHz by asrck_%x\n",
> @@ -372,6 +384,16 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  		return -EINVAL;
>  	}
>  
> +	if (!ideal && (div[IN] > 1024 || div[OUT] > 1024 ||
> +		       rem[IN] != 0 || rem[OUT] != 0)) {
> +	if (!ideal && (div[IN] > 1024 || div[OUT] > 1024 || rem[IN] || rem[OUT] != 0)) {

So for ideal == true, these limitaions are not applied any more?
Remember that the "ideal" is true for "p2p == true" cases here.

> +		pair_err("The divider can't be used for non ideal mode\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Divider range is [1, 1024] */
> +	div[IN] = min_t(u32, 1024, div[IN]);
> +	div[OUT] = min_t(u32, 1024, div[OUT]);

Hmm, this looks like we want to allow ideal ratio cases and p2p
cases to operate any way, even if the divider wasn't within the
range to get the in/out rates from the output clock?
