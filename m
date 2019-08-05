Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA108C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A362067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfHEHxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:53:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:38198 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfHEHxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:53:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 00:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="175516262"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2019 00:53:17 -0700
Date:   Mon, 5 Aug 2019 13:25:09 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [RFC PATCH 02/40] soundwire: cadence_master: add debugfs
 register dump
Message-ID: <20190805075509.GA22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:39:54PM -0500, Pierre-Louis Bossart wrote:
> Add debugfs file to dump the Cadence master registers
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
> is the use of scnprintf to avoid known issues with snprintf.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 98 ++++++++++++++++++++++++++++++
>  drivers/soundwire/cadence_master.h |  2 +
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index ff4badc9b3de..91e8bacb83e3 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/debugfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -223,6 +224,103 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
>  	return -EAGAIN;
>  }
>  
> +/*
> + * debugfs
> + */
> +
> +#define RD_BUF (2 * PAGE_SIZE)
> +
> +static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
> +			    char *buf, size_t pos, unsigned int reg)
> +{
> +	return scnprintf(buf + pos, RD_BUF - pos,
> +			 "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
> +}
> +
> +static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct sdw_cdns *cdns = file->private_data;
> +	char *buf;
> +	ssize_t ret;
> +	int i, j;
> +
> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
> +	for (i = 0; i < 8; i++) /* 8 MCP registers */
> +		ret += cdns_sprintf(cdns, buf, ret, i * 4);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nStatus & Intr Registers\n");
> +	for (i = 0; i < 13; i++) /* 13 Status & Intr registers */
> +		ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_STAT + i * 4);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nSSP & Clk ctrl Registers\n");
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nDPn B0 Registers\n");
> +	for (i = 0; i < 7; i++) {
> +		ret += scnprintf(buf + ret, RD_BUF - ret,
> +				 "\nDP-%d\n", i);
> +		for (j = 0; j < 6; j++)
> +			ret += cdns_sprintf(cdns, buf, ret,
> +					CDNS_DPN_B0_CONFIG(i) + j * 4);
> +	}
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nDPn B1 Registers\n");
> +	for (i = 0; i < 7; i++) {
> +		ret += scnprintf(buf + ret, RD_BUF - ret,
> +				 "\nDP-%d\n", i);
> +
> +		for (j = 0; j < 6; j++)
> +			ret += cdns_sprintf(cdns, buf, ret,
> +					CDNS_DPN_B1_CONFIG(i) + j * 4);
> +	}
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nDPn Control Registers\n");
> +	for (i = 0; i < 7; i++)
> +		ret += cdns_sprintf(cdns, buf, ret,
> +				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
> +
> +	ret += scnprintf(buf + ret, RD_BUF - ret,
> +			 "\nPDIn Config Registers\n");
> +	for (i = 0; i < 7; i++)

please use macros for all the hardcodings.

> +		ret += cdns_sprintf(cdns, buf, ret, CDNS_PDI_CONFIG(i));
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static const struct file_operations cdns_reg_fops = {
> +	.open = simple_open,
> +	.read = cdns_reg_read,
> +	.llseek = default_llseek,
> +};
> +
> +/**
> + * sdw_cdns_debugfs_init() - Cadence debugfs init
> + * @cdns: Cadence instance
> + * @root: debugfs root
> + */
> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
> +{
> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +}
> +EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
> +
>  /*
>   * IO Calls
>   */
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index fe2af62958b1..c0bf6ff00a44 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -163,6 +163,8 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>  		      struct sdw_cdns_stream_config config);
>  int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>  
> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
> +
>  int sdw_cdns_get_stream(struct sdw_cdns *cdns,
>  			struct sdw_cdns_streams *stream,
>  			u32 ch, u32 dir);
> -- 
> 2.20.1
> 

-- 
