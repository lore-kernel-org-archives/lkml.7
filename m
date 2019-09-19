Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783FCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F21D207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNWSnXv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407691AbfISXtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 19:49:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33292 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407674AbfISXtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:49:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3326773pfl.0;
        Thu, 19 Sep 2019 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DO8lDkgH/09igYhmGE97oh8+8ahZBIflCShVrR9OrmU=;
        b=kNWSnXv4Q9H2UbWOSwbkFDyDYqrw5V5FmU8EqdV7tUgMVaqW5UnRoGaPbLRxAC+hEd
         3daoRlbwjVz6K32Az6qna8OmyjDaxJuCA2WvshtxpT7DkMnbifHYEJ0BsKiMtLFSyUv3
         xDtTO+b/VsYw08fNK30ntWhKO+BaL7AAi/8AlX1aHtOMrqbJ8T1WEIQpq9f5s4SWLwhz
         bMbeKs2DUZAbkByeqfxDZXfHVfm4ozWqy8uoRaFUJ9B0hw9MOXly7hJRc2nommYb7OBW
         jiKWP5+nLvTY4Ez/l9sDmXVwjP0y2WNKAAcZZMFAx8o/6PkqGygW6BcO7SHlaOPWr9Vk
         I92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DO8lDkgH/09igYhmGE97oh8+8ahZBIflCShVrR9OrmU=;
        b=ps7EeR6n6mMphZjjx426PeLztXGOhHT4Fy23OtGMIYX27yfTgpMe/Q2XGyeHIjh/EQ
         kmGSgBIq3cCNVNuuny+9vxqRsHkqgOcD2+3LjuGlDm/k+NHEJf8O4BzzDzr9bmzOkChT
         uqzTBX9/qaVmyrkP52CHfTsJ7BdK5oqv5dODnQYXHzvXPydzNhTJfJndOnMmFhngoP6b
         lqHuASoQw0z3FbBvxYt1fnRmYgoa1aYAKlA9Q0bH3gZR+cW3CkHkpDb4PpZ1gSohaDjI
         IaapHhH8BTIQPJOxy8O0ZRz3EMK7o43SyZEZlTtPWtNRyNXnHwcgA6zt0PIjEH7z3mYX
         VcBA==
X-Gm-Message-State: APjAAAWSmAvcszbkCp1840yV2HZfX0+sU06DFuCAkH+m81NLAG6MFOe5
        cz5amJoqcPP4WZNTYBVqN44=
X-Google-Smtp-Source: APXvYqxicFF4tS7Mcj+VMjT1qOkc2frSVMWmjKYUyhpoVLCZd7f7tLUEHubAzMDOxlG+EHV+svcZtA==
X-Received: by 2002:a62:1c16:: with SMTP id c22mr13829974pfc.10.1568936990878;
        Thu, 19 Sep 2019 16:49:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e21sm30169pgr.43.2019.09.19.16.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 16:49:50 -0700 (PDT)
Date:   Thu, 19 Sep 2019 16:48:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH V3 2/4] ASoC: fsl_asrc: update supported sample format
Message-ID: <20190919234857.GA14287@Asurada-Nvidia.nvidia.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
 <5811f393692a7668564fd4b9ef5708c1e3db8dc0.1568861098.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5811f393692a7668564fd4b9ef5708c1e3db8dc0.1568861098.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 08:11:40PM +0800, Shengjiu Wang wrote:
> The ASRC support 24bit/16bit/8bit input width, which is
> data width, not slot width.
> 
> For the S20_3LE format, the data with is 20bit, slot width
> is 24bit, if we set ASRMCR1n.IWD to be 24bits, the result
> is the volume is lower than expected, it likes 24bit data
> right shift 4 bits
> 
> So replace S20_3LE with S24_3LE in supported list and add S8
> format in TX supported list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

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
