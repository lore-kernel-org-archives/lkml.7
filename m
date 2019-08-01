Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587FC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD28216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="r04tkst3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbfHAJdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:33:49 -0400
Received: from onstation.org ([52.200.56.107]:49214 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAJds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:33:48 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6556D3E910;
        Thu,  1 Aug 2019 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564652027;
        bh=a7jk3oZqV6hjmmCfmpPubw/i3qx5j3DufQPR1lxReFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r04tkst3UI4t72iV457sH2NZ0cIemxdGIfDLN5kyy2ScN1ZCr0u6nFV8/JwX6LxSO
         u6COlXDOsxyTqHS7piMEfL2qoCvH/typtIqLpKq9Y3KlsdtgBMCukrn16QD2YZsVJV
         eOlWR+K/Ch6LCyp9CNkGODgMWgcXaWH/KCAZGmmY=
Date:   Thu, 1 Aug 2019 05:33:47 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: tsl2772: Use devm_add_action_or_reset
Message-ID: <20190801093347.GA27653@onstation.org>
References: <20190801073557.9578-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801073557.9578-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 03:35:57PM +0800, Chuhong Yuan wrote:
> Use devm_add_action_or_reset to remove the call to
> tsl2772_disable_regulators_action to simplify the error path.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

For the whole series:

Reviewed-by: Brian Masney <masneyb@onstation.org>

I forgot to mention this before, but next time please use a cover letter
if you're sending more than one patch: git format-patch --cover-letter.

Brian


> ---
> Changes in v4:
>   - Split v3 into three patches.
>   - Revise description to make it more precise.
> 
>  drivers/iio/light/tsl2772.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 83cece921843..29cfd8ae2700 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1807,10 +1807,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  		return PTR_ERR(chip->vdd_supply);
>  	}
>  
> -	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> -			      chip);
> +	ret = devm_add_action_or_reset(&clientp->dev,
> +					tsl2772_disable_regulators_action,
> +					chip);
>  	if (ret < 0) {
> -		tsl2772_disable_regulators_action(chip);
>  		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
>  			ret);
>  		return ret;
> -- 
> 2.20.1
