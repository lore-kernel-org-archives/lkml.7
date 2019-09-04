Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8302339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567581140;
	bh=6FzMAaty3Pfx4wMBupL6qy9d7B0suDpf8SXLsOO1+i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YeWubiFI21dqdkuqZ4AAFovD2GMWoLHXre0GT0zQR0UYZOtwVLzL4ihyIIhYItbuV
	 ucTuxZdekBgdH2KtAg6UQKmsUSgOpScvC3zXSQsnH8kvXenZudjG/U6yvD6lZtSWF2
	 vL12xjpgR+9mdrNIbLmzAG4vw3WXkL7wYlpLkIQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfIDHMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDHMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:12:19 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6952087E;
        Wed,  4 Sep 2019 07:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567581138;
        bh=6FzMAaty3Pfx4wMBupL6qy9d7B0suDpf8SXLsOO1+i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3GMOuhqFUBtHp537IpsnQHQSxNgXRBixH3xVmGUCbCHdEhSrjosmndKSFrh7JQ/0
         0MIkEv6HjoArq2iYH6bx4BzXlunsVN82CPS89UsmW/DweR1DsPh/3Ei6yIBWjEt2ru
         M5nqRRs9fXowyWyMYfAg+kI94BbiTK86iNLwuucU=
Date:   Wed, 4 Sep 2019 12:41:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/6] soundwire: fix startup sequence for Intel/Cadence
Message-ID: <20190904071108.GI2672@vkoul-mobl>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813213227.5163-2-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 16:32, Pierre-Louis Bossart wrote:
> Multiple changes squashed in single patch to avoid tick-tock effect.
> 
> 1. Per the hardware documentation, all changes to MCP_CONFIG,
> MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL need to be validated with a
> self-clearing write to MCP_CONFIG_UPDATE. Add a helper and do the
> update when the CONFIG is changed.
> 
> 2. Move interrupt enable after interrupt handler registration
> 
> 3. Add a new helper to start the hardware bus reset with maximum duration
> to make sure the Slave(s) correctly detect the reset pattern and to
> ensure electrical conflicts can be resolved.
> 
> 4. flush command FIFOs
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 84 +++++++++++++++++++++---------
>  drivers/soundwire/cadence_master.h |  1 +
>  drivers/soundwire/intel.c          | 14 ++++-
>  3 files changed, 73 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 502ed4ec8f07..046622e4b264 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -231,6 +231,22 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
>  	return -EAGAIN;
>  }
>  
> +/*
> + * all changes to the MCP_CONFIG, MCP_CONTROL, MCP_CMDCTRL and MCP_PHYCTRL
> + * need to be confirmed with a write to MCP_CONFIG_UPDATE
> + */
> +static int cdns_update_config(struct sdw_cdns *cdns)
> +{
> +	int ret;
> +
> +	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> +			     CDNS_MCP_CONFIG_UPDATE_BIT);
> +	if (ret < 0)
> +		dev_err(cdns->dev, "Config update timedout\n");
> +
> +	return ret;
> +}
> +
>  /*
>   * debugfs
>   */
> @@ -752,7 +768,42 @@ EXPORT_SYMBOL(sdw_cdns_thread);
>  /*
>   * init routines
>   */
> -static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
> +
> +/**
> + * sdw_cdns_exit_reset() - Program reset parameters and start bus operations
> + * @cdns: Cadence instance
> + */
> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns)
> +{
> +	int ret;
> +
> +	/* program maximum length reset to be safe */
> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
> +		     CDNS_MCP_CONTROL_RST_DELAY,
> +		     CDNS_MCP_CONTROL_RST_DELAY);
> +
> +	/* use hardware generated reset */
> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
> +		     CDNS_MCP_CONTROL_HW_RST,
> +		     CDNS_MCP_CONTROL_HW_RST);
> +
> +	/* enable bus operations with clock and data */
> +	cdns_updatel(cdns, CDNS_MCP_CONFIG,
> +		     CDNS_MCP_CONFIG_OP,
> +		     CDNS_MCP_CONFIG_OP_NORMAL);
> +
> +	/* commit changes */
> +	ret = cdns_update_config(cdns);
> +
> +	return ret;

return cdns_update_config() ?


> +}
> +EXPORT_SYMBOL(sdw_cdns_exit_reset);
> +
> +/**
> + * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
> + * @cdns: Cadence instance
> + */
> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  {
>  	u32 mask;
>  
> @@ -784,24 +835,8 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> -	return 0;
> -}
> -
> -/**
> - * sdw_cdns_enable_interrupt() - Enable SDW interrupts and update config
> - * @cdns: Cadence instance
> - */
> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
> -{
> -	int ret;
> -
> -	_cdns_enable_interrupt(cdns);
> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
> -	if (ret < 0)
> -		dev_err(cdns->dev, "Config update timedout\n");
> -
> -	return ret;
> +	/* commit changes */
> +	return cdns_update_config(cdns);
>  }
>  EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
>  
> @@ -975,6 +1010,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
>  	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, CDNS_DEFAULT_SSP_INTERVAL);
>  
> +	/* flush command FIFOs */
> +	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_RST,
> +		     CDNS_MCP_CONTROL_CMD_RST);
> +
>  	/* Set cmd accept mode */
>  	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
>  		     CDNS_MCP_CONTROL_CMD_ACCEPT);
> @@ -997,13 +1036,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>  	/* Set cmd mode for Tx and Rx cmds */
>  	val &= ~CDNS_MCP_CONFIG_CMD;
>  
> -	/* Set operation to normal */
> -	val &= ~CDNS_MCP_CONFIG_OP;
> -	val |= CDNS_MCP_CONFIG_OP_NORMAL;
> -
>  	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>  
> -	return 0;
> +	/* commit changes */
> +	return cdns_update_config(cdns);
>  }
>  EXPORT_SYMBOL(sdw_cdns_init);
>  
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index 0b72b7094735..1a67728c5000 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -161,6 +161,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
>  int sdw_cdns_init(struct sdw_cdns *cdns);
>  int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
> +int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 13c54eac0cc3..5f14c6acce80 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c

As I have said in the past it doesnt help having a patch touching two
components. The patch is titled cadence!

> @@ -1043,8 +1043,6 @@ static int intel_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_init;
>  
> -	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> -
>  	/* Read the PDI config and initialize cadence PDI */
>  	intel_pdi_init(sdw, &config);
>  	ret = sdw_cdns_pdi_init(&sdw->cdns, config);
> @@ -1062,6 +1060,18 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_init;
>  	}
>  
> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
> +	if (ret < 0) {
> +		dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
> +		goto err_init;
> +	}
> +
> +	ret = sdw_cdns_exit_reset(&sdw->cdns);
> +	if (ret < 0) {
> +		dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
> +		goto err_init;

Don't you want to disable interrupts at least... before you return
error? err_init does bus cleanup and not controller one

-- 
~Vinod
