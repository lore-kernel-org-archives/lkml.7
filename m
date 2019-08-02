Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCAC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5122217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564767122;
	bh=xzeUvxNQZP/5YdCw/FcqyiP94v61eID4Y+IJB6rOLZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PUls6/+AXc9v3fNoXhBqhYMvdGfthLOMwxIZBCLF8HX9ktIbqP9pX0SPqen7Wow7i
	 2Xr08/upwXjgUc1KcCsRmZAMEe0LvsPkTGJzNAHAG7OBmL5O4eI6d+Km/GeISS/gP8
	 E+axMc7JAMQrBSNBb8iIDauGEg5fjbj5zr+ZjOpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405357AbfHBRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405145AbfHBRcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:32:01 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D79217D6;
        Fri,  2 Aug 2019 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564767120;
        bh=xzeUvxNQZP/5YdCw/FcqyiP94v61eID4Y+IJB6rOLZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foz5wlEbhJylMNd02mn/a+5p6LgJbzCZtUdZov47IEY0AUIs3qfTwx8jMbpWmJZUi
         du/LPrDYAuJ11VgWg9XwtV1mvCQWXc/WMgXulA5z37aUjtUfB/K975WSFsYkmWdhFW
         JiYvmvpnHp0dkHKvX9Or12XweqtV6GluNW7+nvCE=
Date:   Fri, 2 Aug 2019 23:00:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 34/40] soundwire: intel: ignore disabled links for
 suspend/resume
Message-ID: <20190802173047.GD12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-35-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:

Please add explanation why..

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 1477c35f616f..a976480d6f36 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -1161,6 +1161,12 @@ static int intel_suspend(struct device *dev)
>  
>  	sdw = dev_get_drvdata(dev);
>  
> +	if (sdw->cdns.bus.prop.hw_disabled) {
> +		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
> +			sdw->cdns.bus.link_id);
> +		return 0;
> +	}
> +
>  	ret = intel_link_power_down(sdw);
>  	if (ret) {
>  		dev_err(dev, "Link power down failed: %d", ret);
> @@ -1179,6 +1185,12 @@ static int intel_resume(struct device *dev)
>  
>  	sdw = dev_get_drvdata(dev);
>  
> +	if (sdw->cdns.bus.prop.hw_disabled) {
> +		dev_dbg(dev, "SoundWire master %d is disabled, ignoring\n",
> +			sdw->cdns.bus.link_id);
> +		return 0;
> +	}
> +
>  	ret = intel_init(sdw);
>  	if (ret) {
>  		dev_err(dev, "%s failed: %d", __func__, ret);
> -- 
> 2.20.1

-- 
~Vinod
