Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1F0C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDAA21823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aglRMlJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfLECXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:23:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37203 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbfLECXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:23:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so823818pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 18:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1VUU4rUNg7kFJO0xACp+i6rdKuZ6Hw04Q1UCWcIN1I=;
        b=aglRMlJMdAULGfV+4x2klYHp9oyyrIwz3f1q0hoDKQJotHgJodNQPgDvNbiZevppxo
         BQM6xM/mqyzPvkKf7kt4NMp59Sm9OQCTMpy1gDhVWEH3tfO079d/zDI3qGeovh98hDKE
         VeVC5xtkNdnKAnjJCHBbaMTazkMa/jsA+8xUcqSrA0mq3oOo2NENR4XY1WexeTw+VyxJ
         /vTvSm5xCYVi9dBv/k7miIdxyLqSwKBpelvVPgcYzA3n2FFo597Z3mh++tJtZJKzroYC
         95t1Ad8Ibr0gUrZmOJDiJhST1NjFBqLSKMa48T55xBKnfKKH5fJOKUNcIotF/8F3p1If
         TwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1VUU4rUNg7kFJO0xACp+i6rdKuZ6Hw04Q1UCWcIN1I=;
        b=tHF+6pLHLUw4mgIZ4zx/vfYikG1MMniWkimhnTZVU3U9GQttYYPU3RttQDV1eswPlw
         WiOBNRtXF5gGQ3vOT6+WU3i1PYKBEbIWtfLdXTKHNo50b0PU9ZJBBsMegKF8TRJ1i7YH
         n7AF3sEDGrPTMTqNxMy2G6RhadKxGccKvLk3nhD1kGKppabmSuDGuwPY3Ijf5qlAaNVa
         221E/EDD8SfbAwFns2xBuGpci7f/YARVDV4Hke4tJIrv1MY2SutryUVBeng14s6+suwQ
         PjXLwOL1slF/3hqF3J+zVZqGXyCVWkuT4OCYKgQLwjBQtE2AQ+8Uf+knvfq1hf9g+yrI
         kbKg==
X-Gm-Message-State: APjAAAVPaIZnwrwmVuTNWrzqUfdVNPieRwSCUtTkppDatKUyyv1mA6Yk
        3CItdz7ezBACkttCHaOeT7M=
X-Google-Smtp-Source: APXvYqzkjBxfnQeluO+tqp7YsVDUANm1utWoTgwzql0A8Bkxp/7Um+nIn79aONqUfWZ+c2qIO6OiWQ==
X-Received: by 2002:a65:4381:: with SMTP id m1mr6893645pgp.43.1575512596508;
        Wed, 04 Dec 2019 18:23:16 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d26sm8722858pgv.66.2019.12.04.18.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 18:23:16 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:19:56 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] ASoC: fsl_audmix: add missed pm_runtime_disable
Message-ID: <20191205021955.GB1122@Asurada-Nvidia.nvidia.com>
References: <20191203111303.12933-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203111303.12933-1-hslester96@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 07:13:03PM +0800, Chuhong Yuan wrote:
> The driver forgets to call pm_runtime_disable in probe failure
> and remove.
> Add the missed calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_audmix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index a1db1bce330f..5faecbeb5497 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -505,15 +505,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
>  					      ARRAY_SIZE(fsl_audmix_dai));
>  	if (ret) {
>  		dev_err(dev, "failed to register ASoC DAI\n");
> -		return ret;
> +		goto err_disable_pm;
>  	}
>  
>  	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
>  	if (IS_ERR(priv->pdev)) {
>  		ret = PTR_ERR(priv->pdev);
>  		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
> +		goto err_disable_pm;
>  	}
>  
> +	return 0;
> +
> +err_disable_pm:
> +	pm_runtime_disable(dev);
>  	return ret;
>  }
>  
> @@ -521,6 +526,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
>  {
>  	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
>  
> +	pm_runtime_disable(&pdev->dev);
> +
>  	if (priv->pdev)
>  		platform_device_unregister(priv->pdev);
>  
> -- 
> 2.24.0
> 
