Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C97EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4BE2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGZP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:57:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:50199 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGZP5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:57:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="172262285"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.35.244])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2019 08:57:18 -0700
Date:   Fri, 26 Jul 2019 17:57:17 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 37/40] soundwire: cadence_master: add
 hw_reset capability in debugfs
Message-ID: <20190726155717.GM16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Both really should be dev_info()? Maybe at least one of them can be dev_dbg()?

Thanks
Guennadi

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
>  }
>  EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
