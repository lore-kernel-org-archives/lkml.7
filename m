Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF33BC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A503320674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv0mLxLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406000AbfIIUUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:20:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43929 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfIIUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:20:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id d15so9975359pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f8kcD/av2IHtuxWBUd9aJrd7r9hFL0IzQqelqnKxuvQ=;
        b=Hv0mLxLcScQ94ymOj99jHE5Kt1cXtpZWue2SaJ5v6OKjJ7L7Ao4eWhXannThE12GW7
         Wmci9TLL/AR6PRHyLB0Vzog+19uWg4E1/Wh4sroDjJQQtKGvmyOj1OK7+pxbQv4DPC55
         SiExlpS1JidbNG1Zt22gYsII4PKp7RVNf7dPjpcaahb/ZV3ZF/nvnrvfuOLdP9kkwjZ1
         C3zLNhMfI+gSlZAByou/WFjhDKrnZxdjifSD8dlozMMvgWBVEpcdy9VtDy4UCkoXWpIl
         n1jg2pl9cWP3Bdf53t4EUovTYOauq8gC109oHaF7/HBraLt4RfNnL/DVqPZEjwWy2aFm
         LzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f8kcD/av2IHtuxWBUd9aJrd7r9hFL0IzQqelqnKxuvQ=;
        b=VyaM68HRpnOi6mQBCyyFwuaRKlvzr4LQTElXachFvsZwefvEH3GTKcoIyvXhog9LMB
         C66+n/gaofjTRbi5a8ov+YgapjX2dixLNtMfIdYq3/sc4g2bHEvMCahkYfWX6WEMycvv
         da/ELx0ATtZAj3H6rl77IyThtRvuVgW7nrvkJ2l+Beh2hiDPb6UDwl1uMpMbabI2x4mm
         BcdteY0aRmjbP7YnjoMGPRA8NyV8sxvEhd95974Zg9COLJM7O5h5q4s3FL2pT+SUJEsJ
         +Ar8JeVvqMQHzbCHEEymDFGxAAgA9LhlwljSEC9WQRxFPxledTo+vp5J//FBUNPrGIp5
         csQw==
X-Gm-Message-State: APjAAAUgzzOU4ylIE1Wxk0HNSbPj/gfiHur+QdObg1rX3bTl6kGlkRTC
        E5XYOtOVsmu2zXggBP9Gi6E=
X-Google-Smtp-Source: APXvYqzFYT+lG/hdw0tQ+UPPVLQYZKqrbn7uN1Vn51POIuZlnzmyKI1abdpHBuq7s3lqUdd3yDYsSg==
X-Received: by 2002:a63:3046:: with SMTP id w67mr24304918pgw.37.1568060409962;
        Mon, 09 Sep 2019 13:20:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r30sm32034684pfl.42.2019.09.09.13.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Sep 2019 13:20:09 -0700 (PDT)
Date:   Mon, 9 Sep 2019 13:19:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: fsl_asrc: update supported sample format
Message-ID: <20190909201945.GC10344@Asurada-Nvidia.nvidia.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
 <f62fda1f49af8159eb23a978147a321dd6849d1a.1568025083.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62fda1f49af8159eb23a978147a321dd6849d1a.1568025083.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:33:20PM -0400, Shengjiu Wang wrote:
> The ASRC support 24bit/16bit/8bit input width, so S20_3LE format
> should not be supported, it is word width is 20bit.

I thought 3LE used 24-bit physical width. And the driver assigns
ASRC_WIDTH_24_BIT to "width" for all non-16bit cases, so 20-bit
would go for that 24-bit slot also. I don't clearly recall if I
had explicitly tested S20_3LE, but I feel it should work since
I put there...

Thanks
Nicolin

> So replace S20_3LE with S24_3LE in supported list and add S8
> format in TX supported list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 4d3804a1ea55..584badf956d2 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -624,7 +624,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
>  
>  #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
>  				 SNDRV_PCM_FMTBIT_S16_LE | \
> -				 SNDRV_PCM_FMTBIT_S20_3LE)
> +				 SNDRV_PCM_FMTBIT_S24_3LE)
>  
>  static struct snd_soc_dai_driver fsl_asrc_dai = {
>  	.probe = fsl_asrc_dai_probe,
> @@ -635,7 +635,8 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
>  		.rate_min = 5512,
>  		.rate_max = 192000,
>  		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_ASRC_FORMATS,
> +		.formats = FSL_ASRC_FORMATS |
> +			   SNDRV_PCM_FMTBIT_S8,
>  	},
>  	.capture = {
>  		.stream_name = "ASRC-Capture",
> -- 
> 2.21.0
> 
