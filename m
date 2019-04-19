Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6856AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvP10dfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfDSS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:28:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDSS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:28:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so2997036pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONT5+2CVkj6hhrYr8uWDTX1Rkzzw8yLeZIpjJqMpjY0=;
        b=PvP10dfsssoEwVuVGPSsDItBuLoNejtOxSAekgSyrDu81+aFomxA7AAm5XNUVHWMHb
         CH3AuYdpeLXnxnHx8pKlCwf7BglN8b7FFuuTSMoRLxdRVMiShgysz9XmHN/3ufYD6j8f
         Gb15kSDSpN5e03RQZd36eUWqf2fHKL79qyZm5oslfSAilc3K21Djqht9HBBe2ZgNDbN/
         AGo4bY9XFVIS1xjDDto7O8kMPt6zEPVl5ToqrQanfQIPApz+DGWqqBh3W719QhVjtew6
         9qE0xHdyKlp1n9wodh05AanIgIFEZ9Z47SM2HbChPlVloODQVNgrneYvMhI3nqvG9TFX
         JbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONT5+2CVkj6hhrYr8uWDTX1Rkzzw8yLeZIpjJqMpjY0=;
        b=AzfPxrUUF/otThH+KoPP+BqhQ6Kz0XSj6k8/o1gmMjdlsll4UihtIHZCg17xwnWR99
         2I7NxibvZ4hQlRjewxvg23/043RF6ag3Qa9+Vj65ZA2GUS+/UX9v+W21QQ8ZTMhsBAg1
         Dp+YQctL5xksE0wOJLWsMRYrGPQce+tUOWjS1YailqxDZVbAfYDMdNrbGpnakl+vC4LX
         MzIU9Y2vRnJX/ac/BtyVumN/A/NTu+3jnVq6uacfqmi9qt7w6cNxHmkqDzHKS9G03kN7
         1H3QwEDg5wd1ISntUMDI0ISR+Rz8HSmUvEegsstVc19oBC5S+8KELtgTCwldp9k+ZVLs
         KNJA==
X-Gm-Message-State: APjAAAUAIdwFgMXGG+p+SWD9OYw51zYKlWlGnNkAxr5iQXouM/UZU1e1
        BkeO6Aq6afQdnEq/dXGxGe8=
X-Google-Smtp-Source: APXvYqxOZDlhdHXIyQAfJzT3kfqLbILpkD0tXAUB5zcEOxBPI836iychiUOwMplbjzAl3G8Gtx39wQ==
X-Received: by 2002:a63:5c43:: with SMTP id n3mr5188956pgm.163.1555698496395;
        Fri, 19 Apr 2019 11:28:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f2sm8558920pgc.30.2019.04.19.11.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 11:28:15 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:28:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190419182812.GC1136@Asurada-Nvidia.nvidia.com>
References: <cover.1555669068.git.shengjiu.wang@nxp.com>
 <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b450010bb24e18e01b78d32067d6efdb572a9cc4.1555669068.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:23:56AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the
> 12kHz/24kHz/128kHz to the support list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 2c4bbc3499db..0d06e738264a 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -27,13 +27,14 @@
>  	dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index, ##__VA_ARGS__)
>  
>  /* Corresponding to process_option */
> -static int supported_input_rate[] = {
> -	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
> -	96000, 176400, 192000,
> +static unsigned int supported_asrc_rate[] = {
> +	5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
> +	64000, 88200, 96000, 128000, 176400, 192000,
>  };
>  
> -static int supported_asrc_rate[] = {
> -	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
> +static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints = {
> +	.count = ARRAY_SIZE(supported_asrc_rate),
> +	.list = supported_asrc_rate,
>  };
>  
>  /**
> @@ -293,11 +294,11 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>  	ideal = config->inclk == INCLK_NONE;
>  
>  	/* Validate input and output sample rates */
> -	for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
> -		if (inrate == supported_input_rate[in])
> +	for (in = 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> +		if (inrate == supported_asrc_rate[in])
>  			break;

Not sure if we still need it upon having hw_constraint. Maybe m2m
needs it?
