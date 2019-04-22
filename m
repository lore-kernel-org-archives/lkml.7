Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D49C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6521320859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+7P1ki6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDVBJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:09:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36935 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfDVBJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:09:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so5036156ply.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYjkYcNTZnFMpLl1Ud45Nz+rQvZvAbAY0HkqRk3d/w4=;
        b=u+7P1ki6TX3QOwwlvqXhU4Wx4+40w2bznUai3u5nQchIwh2RxXIttP/KfEGh+q+UDU
         dt6FMgkNTnKUcYOCUi4zXgYLtIhjiEi53cIZDJ3yKw5SAh6b95khiWrhbb8W0EYT+JGp
         tnS5XIlun7uUjrEu/dXuDX1UEBe/oA679fFJ38P00IDeqce0n2schXUiQuEW0XePGgIO
         YojSpAQvgJndT/0M8CZs8SUKinWvZRoqPM+7prOymEx4T+4/dwNz/RrFCEr93grxG57j
         C8O8N2HbLmnwxM/QS2q/q6NhNE3eIQmnGE7sbdyn0jO0kRjYjdNujMfhblbuky8r9nBU
         IC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYjkYcNTZnFMpLl1Ud45Nz+rQvZvAbAY0HkqRk3d/w4=;
        b=lAoZ8Q+TN9Rl+gZ2Th284cI8jAPzJxPP8+z5npECxnPBIAGZOnBRM2FOvIpqaEvccB
         8cssCt0NVQOEb7sTi1kTULWFrZ14ppqEcn+CM+lCcV4XwLZzYQDqHem4cuDR3IQp60aH
         zYmdH2LMaqgZ42qtND62ZUJ+bChUJcRJctOeoi0hnP6CMdOp4LNKs2l4fD6lLVeyt7rL
         hT/0yft++Zem11vk1cYcUFLZ2LTMbDFQu+2YHujMlk/5gYqLiQfVOljU9+XxsstYd3+l
         u3wUJbVWoH9jUlisbb3J7Qe8kR1QulLTvkLbhjY6lMerZXW2EmRWeCFsp8F64bnLYlyZ
         3maw==
X-Gm-Message-State: APjAAAUQEz7Eckt6UpLHO7759nkFRlo44WM18SjEqjTdifZdCfur6NTi
        J4tPjuQwJa47f7yPeuNp6B0=
X-Google-Smtp-Source: APXvYqytCei3XKWWbcucBiYP0cznKxL5+Vkt66ofnt1jiHbcf+8CxVBOLdCfxjVqDznWddsRo4ubEg==
X-Received: by 2002:a17:902:2d04:: with SMTP id o4mr17638908plb.88.1555895391183;
        Sun, 21 Apr 2019 18:09:51 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id c3sm14691763pfo.2.2019.04.21.18.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 18:09:50 -0700 (PDT)
Date:   Sun, 21 Apr 2019 18:09:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3 v2] ASoC: fsl_sai: Add support for runtime pm
Message-ID: <20190422010945.GB8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 07:39:09PM +0000, Daniel Baluta wrote:
> Basically the same actions as for system PM, so make use
> of pm_runtime_force_suspend/pm_runtime_force_resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index d9df98975cf8..8623b7f882b9 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -9,6 +9,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> @@ -900,6 +901,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_component,
>  			&fsl_sai_dai, 1);
>  	if (ret)
> @@ -911,6 +914,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>  }
>  
> +static int fsl_sai_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
>  static const struct of_device_id fsl_sai_ids[] = {
>  	{ .compatible = "fsl,vf610-sai", },
>  	{ .compatible = "fsl,imx6sx-sai", },
> @@ -919,8 +927,8 @@ static const struct of_device_id fsl_sai_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, fsl_sai_ids);
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int fsl_sai_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int fsl_sai_runtime_suspend(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
>  
> @@ -930,7 +938,7 @@ static int fsl_sai_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int fsl_sai_resume(struct device *dev)
> +static int fsl_sai_runtime_resume(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
>  
> @@ -942,14 +950,18 @@ static int fsl_sai_resume(struct device *dev)
>  	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
>  	return regcache_sync(sai->regmap);
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#endif /* CONFIG_PM */
>  
>  static const struct dev_pm_ops fsl_sai_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
> +	SET_RUNTIME_PM_OPS(fsl_sai_runtime_suspend,
> +			   fsl_sai_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  };
>  
>  static struct platform_driver fsl_sai_driver = {
>  	.probe = fsl_sai_probe,
> +	.remove = fsl_sai_remove,
>  	.driver = {
>  		.name = "fsl-sai",
>  		.pm = &fsl_sai_pm_ops,
> -- 
> 2.17.1
> 
