Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11AEC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A7D2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555912910;
	bh=ERp3AUcbxNL/NNK9WJkRCB59rPqO28F1ePzU79i4F+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J8JCVOzgQRglnJdRE+zM4pffQ8R8VFP1aq0UqTBfET66Ux5G9dCKjlK+X3KWnFI/L
	 d2WACXWmm5SJsYcnJM+sHFahzWvcS3kkR4tPU/nvMaj0FgB2sMsvZfI2f7MuWziyY4
	 aZreJ2m64JyLYAZ2pdpqCsFYF+GF/tCNFEuJpifo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfDVGBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDVGBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:01:48 -0400
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A480F20811;
        Mon, 22 Apr 2019 06:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555912908;
        bh=ERp3AUcbxNL/NNK9WJkRCB59rPqO28F1ePzU79i4F+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBnM6ASprLwnsi4IMrnl5wP5M2nS744fe8UDuh8zrXQvU2+h99OkTRYb3wKbWiLTZ
         gQfeok/Kzq1EbotjfO4FaENrL5UGClB0vJlPqN3oC6jhjHG4N6oYYazU4vWSOfFdu/
         SQ4+yPBFw9CvW8aXkUuPRGf9UWsqK1aPmgUA7a6A=
Date:   Mon, 22 Apr 2019 11:31:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Message-ID: <20190422060141.GW28103@vkoul-mobl>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-19, 14:46, Pierre-Louis Bossart wrote:
> The mechanism should be
> 
> config CODEC_XYX_SDW
>        depends on SOUNDWIRE
>        select REGMAP_SOUNDWIRE
> 
> config REGMAP_SOUNDWIRE
>        select SOUNDWIRE_BUS
> 
> SOUNDWIRE_BUS can be independently selected by the SOC driver. The SOC
> driver should not know or care about REGMAP_SOUNDWIRE.

lgtm, Mark can I have ypu ack so that I can carry the series thru
soundwire tree

Thanks

> Fixes: 7c22ce6e2184 ('03fc8746f7915b5a391d8227f7e1')
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/base/regmap/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 6ad5ef48b61e..c12e3f1fb110 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -44,7 +44,7 @@ config REGMAP_IRQ
>  
>  config REGMAP_SOUNDWIRE
>  	tristate
> -	depends on SOUNDWIRE_BUS
> +	select SOUNDWIRE_BUS
>  
>  config REGMAP_SCCB
>  	tristate
> -- 
> 2.17.1

-- 
~Vinod
