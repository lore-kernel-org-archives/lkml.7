Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF75C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0076217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfHEJyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:54:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:20851 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfHEJyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:54:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 02:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="349059850"
Received: from buildpc-hp-z230.iind.intel.com (HELO buildpc-HP-Z230) ([10.223.89.34])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2019 02:54:28 -0700
Date:   Mon, 5 Aug 2019 15:26:20 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
Subject: Re: [RFC PATCH 23/40] soundwire: stream: fix disable sequence
Message-ID: <20190805095620.GD22437@buildpc-HP-Z230>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:40:15PM -0500, Pierre-Louis Bossart wrote:
> When we disable the stream and then call hw_free, two bank switches
> will be handled and as a result we re-enable the stream on hw_free.
>

I didnt quite get why there will be two bank switches as part of disable flow
which leads to enabling of stream?

> Make sure the stream is disabled on both banks.
> 
> TODO: we need to completely revisit all this and make sure we have a
> mirroring mechanism between current and alternate banks.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 53f5e790fcd7..75b9ad1fb1a6 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>  		}
>  	}
>  
> -	return do_bank_switch(stream);
> +	ret = do_bank_switch(stream);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* make sure alternate bank (previous current) is also disabled */
> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +		bus = m_rt->bus;
> +		/* Disable port(s) */
> +		ret = sdw_enable_disable_ports(m_rt, false);
> +		if (ret < 0) {
> +			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.20.1
> 

-- 
