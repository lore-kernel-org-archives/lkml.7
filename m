Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E3C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FDC2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564747012;
	bh=+J34gvcAYkLjRMmKzsumfEwWslDwfUO0ZXmj5OdI3ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1wMAzo4xkVb6no1NfTTFVW3NUC03eUPtwyQgnfKbrRRRjxLuDwf0U7XLduPAOzLXb
	 BqYdOOD/o2xUkZ+0EmRxB02Mlla4EwL3x3WZTPqpBxvkfdur5jOffLkwyDhWHH6Dq2
	 rjUn47VBH1WRODLesx9bOXgHONLuXc9Ep8tiyXkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392467AbfHBL4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbfHBL4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:56:50 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657B72171F;
        Fri,  2 Aug 2019 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564747010;
        bh=+J34gvcAYkLjRMmKzsumfEwWslDwfUO0ZXmj5OdI3ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UH1hQM0G+9glJwBtz2BNd0Hvj8jLLpXUKfztFAbZXkwSJwuQIXRAxS1hhxaCOzd4B
         OjjZjB2XH7ByhDGVZGJSuWP/W6Dg/CQwA+G0TP9+1Q2PXGMywOt7QJS/YPimNHfU65
         VuxP6nGxyxOZc/OXDpoTtLVldT5tgS11fLobOWdA=
Date:   Fri, 2 Aug 2019 17:25:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 06/40] soundwire: intel: prevent possible dereference
 in hw_params
Message-ID: <20190802115537.GI12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> This should not happen in production systems but we should test for
> all callback arguments before invoking the config_stream callback.

so you are saying callback arg is mandatory, if so please document that
assumption

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 68832e613b1e..497879dd9c0d 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -509,7 +509,7 @@ static int intel_config_stream(struct sdw_intel *sdw,
>  			       struct snd_soc_dai *dai,
>  			       struct snd_pcm_hw_params *hw_params, int link_id)
>  {
> -	if (sdw->res->ops && sdw->res->ops->config_stream)
> +	if (sdw->res->ops && sdw->res->ops->config_stream && sdw->res->arg)
>  		return sdw->res->ops->config_stream(sdw->res->arg,
>  				substream, dai, hw_params, link_id);
>  
> -- 
> 2.20.1

-- 
~Vinod
