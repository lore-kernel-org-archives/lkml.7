Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52772C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E3D2183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564747893;
	bh=ImImKWjCHy4YFIgagVeKR9W5LMcs+2219UOfhty+Q2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=omW65dcdAScZ5fkVQvmKP1t0wYv6mKXl++61M94UabLJNeg6v+zIvwMA5UkdzhfR5
	 YCTS6bZYh3+WwS+/LOTBnh91W6OhDDBmBOsdENXBDyzZRyMeHEmoszVzf/Y3cc8NNs
	 FmoDjoNbmayVAwi/lWFwipv+gch4BCt104yvHxDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbfHBMLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387812AbfHBMLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:11:31 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7084D217D7;
        Fri,  2 Aug 2019 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564747890;
        bh=ImImKWjCHy4YFIgagVeKR9W5LMcs+2219UOfhty+Q2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG0uqqW9SfKCzRmNjQdogBNzU9ZcXwEU97C4iAJKIyb5GU0bs7811iIC78ZY1dAcS
         KZKu59+7PfBeQWcsS0FsO0LUt7+c6AYr+is2uEOjn+POKJu734cfjXWlkfBaKuyUvp
         J68e1VrRBaDOxlf6mTzmy8pKu16vAFRpuLkkikl0=
Date:   Fri, 2 Aug 2019 17:40:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 12/40] soundwire: cadence_master: revisit interrupt
 settings
Message-ID: <20190802121016.GN12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-13-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-13-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Adding missing interrupt masks (parity, etc) and missing checks.
> Clarify which masks are for which usage.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index bdc3ed844829..0f3b9c160b01 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -76,9 +76,12 @@
>  #define CDNS_MCP_INT_DPINT			BIT(11)
>  #define CDNS_MCP_INT_CTRL_CLASH			BIT(10)
>  #define CDNS_MCP_INT_DATA_CLASH			BIT(9)
> +#define CDNS_MCP_INT_PARITY			BIT(8)
>  #define CDNS_MCP_INT_CMD_ERR			BIT(7)
> +#define CDNS_MCP_INT_RX_NE			BIT(3)
>  #define CDNS_MCP_INT_RX_WL			BIT(2)
>  #define CDNS_MCP_INT_TXE			BIT(1)
> +#define CDNS_MCP_INT_TXF			BIT(0)
>  
>  #define CDNS_MCP_INTSET				0x4C
>  
> @@ -689,6 +692,11 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
>  		}
>  	}
>  
> +	if (int_status & CDNS_MCP_INT_PARITY) {
> +		/* Parity error detected by Master */
> +		dev_err_ratelimited(cdns->dev, "Parity error\n");
> +	}
> +
>  	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
>  		/* Slave is driving bit slot during control word */
>  		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
> @@ -761,10 +769,21 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>  	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>  		    CDNS_MCP_SLAVE_INTMASK1_MASK);
>  
> +	/* enable detection of slave state changes */
>  	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
> -		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
> -		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
> +		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
> +
> +	/* enable detection of bus issues */
> +	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
> +		CDNS_MCP_INT_PARITY;
> +
> +	/* no detection of port interrupts for now */
> +
> +	/* enable detection of RX fifo level */
> +	mask |= CDNS_MCP_INT_RX_WL;
> +
> +	/* now enable all of the above */

I think this comment seems is at wrong line..?

> +	mask |= CDNS_MCP_INT_IRQ;
>  
>  	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
>  
> -- 
> 2.20.1

-- 
~Vinod
