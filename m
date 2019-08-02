Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01861C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83722183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564746914;
	bh=sWoyemYZ9hmRo2SD2T14xHR8u76Tax1dvnuelEUu/0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2kXP1flYyJmEgYI2JkEhK0obRejXKjowFIjatY21WZpB4atbzC3jX+NbTjlyZEOH4
	 4UkV63GFIVqiyhpzyPuwnNnfaATugcudRNStKU1XfDYwoYLQEin6EdBfM+r3kh6UzP
	 jUQprtG05ILCjo79MKvpWXbcXg0PbtCMObytgrkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392455AbfHBLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbfHBLzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:55:13 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1542067D;
        Fri,  2 Aug 2019 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564746912;
        bh=sWoyemYZ9hmRo2SD2T14xHR8u76Tax1dvnuelEUu/0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdeftaTW+0MnAlzhnw6VEkCnAXk6sr9nf9eiZGPYjN+j9RvegFC2izQec9qS4rNoy
         whOK3DE9pB+2Heyznu7wwZk07AjmQnTdEL49wniApETiqMm04c9Zpq4MBT2dAwiMWo
         /16+H+VXxoGFLlslWhKA0CIwdZueVthTtRuj8mc0=
Date:   Fri, 2 Aug 2019 17:23:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 05/40] soundwire: intel: move interrupt enable after
 interrupt handler registration
Message-ID: <20190802115359.GH12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-6-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> Not sure why the existing code would enable interrupts without the
> ability to deal with them.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index aeadc341c0a3..68832e613b1e 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -981,8 +981,6 @@ static int intel_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_init;
>  
> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> -
>  	/* Read the PDI config and initialize cadence PDI */
>  	intel_pdi_init(sdw, &config);
>  	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
> @@ -1000,6 +998,8 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns);

we should also handle the return

-- 
~Vinod
