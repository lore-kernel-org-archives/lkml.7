Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04542339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567581267;
	bh=NNC+RkkJ+eyITyoMs4o1gFL0TAFukDFGUWCl2aimc18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kepvgla9uzTWUACdkj7nwhSvaXyl5X/645BKkSrTpiBXzv6YNXd7HXtdiUqnxan2I
	 4y+l2ulrYP4zRCgmQjLltNo/xL299xFW9lzRLJQyv3s7klcPpOIAPrntI9ltubC6dP
	 1+hqyOWP64OOXHnroRRo4Qe4Uw48wEUXfIjyCuOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfIDHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDHO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:14:26 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A6D22CEA;
        Wed,  4 Sep 2019 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567581265;
        bh=NNC+RkkJ+eyITyoMs4o1gFL0TAFukDFGUWCl2aimc18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhBTLeuw97W8DprCY1IMVU6AdWo9PaTC7PJNuXO6HzMcs8KiXB+r/kBYAe39/5zir
         sPdcD6rlDeUxYQxDEk+mwM/j6EEXXjljTJX8YSfpZNvbLVdpcinoL2U9CQkPLszhz3
         VuVt9dCMUtswZmUlmQ428EVv4SMmMXfeV75K8qCk=
Date:   Wed, 4 Sep 2019 12:43:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/6] soundwire: cadence_master: add hw_reset capability
 in debugfs
Message-ID: <20190904071317.GJ2672@vkoul-mobl>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813213227.5163-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
> Provide debugfs capability to kick link and devices into hard-reset
> (as defined by MIPI). This capability is really useful when some
> devices are no longer responsive and/or to check the software handling
> of resynchronization.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 046622e4b264..bd58d80ff636 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -340,6 +340,23 @@ static int cdns_reg_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>  
> +static int cdns_hw_reset(void *data, u64 value)
> +{
> +	struct sdw_cdns *cdns = data;
> +	int ret;
> +
> +	if (value != 1)
> +		return 0;

Should this not be EINVAL to indicate invalid value passed?

> +
> +	ret = sdw_cdns_exit_reset(cdns);
> +
> +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
> +
>  /**
>   * sdw_cdns_debugfs_init() - Cadence debugfs init
>   * @cdns: Cadence instance
> @@ -348,6 +365,9 @@ DEFINE_SHOW_ATTRIBUTE(cdns_reg);
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>  {
>  	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +
> +	debugfs_create_file("cdns-hw-reset", 0200, root, cdns,
> +			    &cdns_hw_reset_fops);
>  }
>  EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
>  
> -- 
> 2.20.1

-- 
~Vinod
