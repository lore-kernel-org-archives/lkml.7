Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D05C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7E922C7E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564150073;
	bh=2uuUK1ifiyV3Y744hTmQ7HeB0GK4yG8UQLMkmVM9zpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sTZLENCMjgoK750xSgEdM7eMlwCXEL5MEBrdbL3loTLoDjqfDlzr2LZoJMeX1z4pv
	 9GhEAzUx0zS+M6pRC5MAJEeitVNE+LRwVYx4BkvEkjtWbm7c6nf+NxsE2U8w6yRhsR
	 2YUSLedvQ/lv3yw5X3lBiu3/1dEUhz4Ik7YKmh0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfGZOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfGZOHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:07:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179AD218D3;
        Fri, 26 Jul 2019 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564150071;
        bh=2uuUK1ifiyV3Y744hTmQ7HeB0GK4yG8UQLMkmVM9zpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWp6qOTpA7EA0QuyZ00iA2kjV0qwj8DZ1fRMijoF4NxjWPJQOQ5BvSC+bVJX2sNaC
         +b57ip08/KFMI9dpgoX6yZbKyTvu7SYTD8ZFUQ7KIXvSWr5Cu05w5ab6mfFlzd9DqU
         mrCVTz10XLKAOk4dt7H9S8fHUzIwpAj68zoRAQXo=
Date:   Fri, 26 Jul 2019 16:07:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 37/40] soundwire: cadence_master: add hw_reset
 capability in debugfs
Message-ID: <20190726140749.GC8767@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:29PM -0500, Pierre-Louis Bossart wrote:
> This is to kick devices into reset and see what software does
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index fa7230b0f200..53278aa2436f 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -331,6 +331,25 @@ static const struct file_operations cdns_reg_fops = {
>  	.llseek = default_llseek,
>  };
>  
> +static int cdns_hw_reset(void *data, u64 value)
> +{
> +	struct sdw_cdns *cdns = data;
> +	int ret;
> +
> +	if (value != 1)
> +		return 0;
> +
> +	dev_info(cdns->dev, "starting link hw_reset\n");
> +
> +	ret = sdw_cdns_exit_reset(cdns);
> +
> +	dev_info(cdns->dev, "link hw_reset done\n");

Do not be noisy for when things always go right.  This looks like
debuggging code, please remove.

> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
> +
>  /**
>   * sdw_cdns_debugfs_init() - Cadence debugfs init
>   * @cdns: Cadence instance
> @@ -339,6 +358,9 @@ static const struct file_operations cdns_reg_fops = {
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>  {
>  	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +
> +	debugfs_create_file_unsafe("cdns-hw-reset", 0200, root, cdns,
> +				   &cdns_hw_reset_fops);

Why unsafe?

thanks,

greg k-h
