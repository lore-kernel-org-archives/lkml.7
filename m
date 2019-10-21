Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D55C49EAB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34D621929
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571630709;
	bh=tAIvrEShK24iwCrT+7TENtkPwG+TsS24xTixtOiBwJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6xdbZQ0xTJMTyt//C6m+by5BRbyQda25H3NzyUOy6AQnh3R+9lI1eErHyBFRTZdt
	 2ZaaV0Eax/xiZ+28JgkWlnxRaRXKz5gxhxch3b5zw7lSB6Wp40E/YhFdv77WEA4C92
	 PGx7LSm+HMk1IpOQEtXb2EJAyynfJzR1BZpqQME8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfJUEFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 00:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfJUEFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 00:05:02 -0400
Received: from localhost (unknown [122.167.89.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26CFC21928;
        Mon, 21 Oct 2019 04:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571630701;
        bh=tAIvrEShK24iwCrT+7TENtkPwG+TsS24xTixtOiBwJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n82N5AjIN7M14aT1MT9wAewEDfYsDFIS42VTa4mqQ5Uj0P9qTO8cziJA3yyv73PYN
         cGVk2p6jv3Fi3+T2t2wEuf1+vnRXqsLycfsKk3L3oAG2a04sfhBcQtQIVZuccgOK+M
         JasGPnFLxUlMC8wC3XgOaNlcXT5n2PC9uhDnA+Ic=
Date:   Mon, 21 Oct 2019 09:34:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v2 2/5] soundwire: cadence_master: add hw_reset
 capability in debugfs
Message-ID: <20191021040458.GX2654@vkoul-mobl>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
 <20190916190952.32388-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916190952.32388-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-19, 14:09, Pierre-Louis Bossart wrote:
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
> index e3d06330d125..5f900cf2acb9 100644
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
> +		return -EINVAL;
> +
> +	ret = sdw_cdns_exit_reset(cdns);

So we are performing reset of the device behind the kernel, so I think
it makes sense to mark the kernel as tainted.

> +
> +	dev_dbg(cdns->dev, "link hw_reset done: %d\n", ret);
> +
> +	return ret;

We may want to get rid of the debug and do:
        return sdw_cdns_exit_reset();


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
