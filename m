Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A963C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF5B20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyCW48L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfDVBI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:08:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44371 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfDVBI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:08:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so4914297pfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XaoaARy9E92KPIsK7OPHAPD9rRmm+5Hg1tDM+cIDRGE=;
        b=DyCW48L0mFL6JzmBGpzEJdJZdDZhG9y04ThGxRQuzAbbR6MW0vldd/jqVYYWDmiD18
         BcsnxVdsZl6TcLgQCnYvTYt23+kZ04a+NCXaJCHpB9FW4fwpXy52Ts1q9ERK3+L9jKGU
         +GZUiLqvD2F4ToXS3bDxt5XHxmcJq0raMGu7c58N9QFX6fCfxllGuXyEpLuUxKDetGyO
         vtukzTGQEpmJFE0NdfQbe5u/fdIBS758QFkJ9e5qdNxxwGxpGRFRrwgVF1LGOe7mx4do
         DACDsE+R+YEAMpw74QI4TFlEa18tUVh0WbcNj81sk5/IstgV7NvisdVuQteBoTRnOf8l
         Oiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XaoaARy9E92KPIsK7OPHAPD9rRmm+5Hg1tDM+cIDRGE=;
        b=Z5CYvGI2kqfOks+iYQxP78F7fwJdLMR3NRL0I0OOjOrSqBg+OWqpA3ik851tk2lIXD
         pGtCxZTLFtgGVZcQHhm7r0/CNW51ZAB8zdtBqMxfv5pR7+dUQHt8nc+qE57Imt1GCT/T
         6mEe5Y7PCiOmWqXHaR028iVQs91M4v49iJZGEQZfpC428vFHH4sCIUmnovNbeHmVh6u/
         ly6yyXECKbtXhsnBA7ejkZe4zsEhWZCMw2QbgVj3Z2aRAfiRHCsGVUhZiwH5MoTVT23r
         rVfO0LxJ/fqH/TkVSkGkz+lXWVXlAB5k1BzmfenISQ/xxY46imuomcD4dTjLX2lC6l9o
         9JjA==
X-Gm-Message-State: APjAAAXsssEMy7tUWZZviKn9qyNVGqgSJtx/xmXPQkVDbhdVgBhMRqC9
        LVbZ5oc0v55vHXxRkOM1q+Y=
X-Google-Smtp-Source: APXvYqzUB/tfzIUVnitaIU68cStO0NeEu7VySpo/Aq+/u3y1qihjbpc4H+vv43BGBoHxO28sKski1w==
X-Received: by 2002:a62:12d0:: with SMTP id 77mr17825872pfs.15.1555895335454;
        Sun, 21 Apr 2019 18:08:55 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id y3sm13791248pge.7.2019.04.21.18.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 18:08:54 -0700 (PDT)
Date:   Sun, 21 Apr 2019 18:08:47 -0700
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
Subject: Re: [PATCH 1/3 v2] ASoC: fsl_sai: Update is_slave_mode with correct
 value
Message-ID: <20190422010846.GA8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 07:39:08PM +0000, Daniel Baluta wrote:
> is_slave_mode defaults to false because sai structure
> that contains it is kzalloc'ed.
> 
> Anyhow, if we decide to set the following configuration
> SAI slave -> SAI master, is_slave_mode will remain set on true
> although SAI being master it should be set to false.
> 
> Fix this by updating is_slave_mode for each call of
> fsl_sai_set_dai_fmt.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b563004fb89f..d9df98975cf8 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -268,12 +268,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> +		sai->is_slave_mode = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		sai->is_slave_mode = true;
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFM:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
> +		sai->is_slave_mode = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFS:
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -- 
> 2.17.1
> 
