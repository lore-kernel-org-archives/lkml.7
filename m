Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47631CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C9420856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571916244;
	bh=g+R7dOXwcKElWRvz7nfCK0CoS/QqY5FvmWjQtXYXq/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CF/1wcg+aHQ96L+csXMWqF5quF2VAw+ypsuaVtt9l/Zvz6D3qcvLUIrwFeN6tiZh2
	 wferxBn9kjZeR34a9lou51q01NJdqXaXC+W6gMz6Aecewq7yQ2hZ+M0sF5wu2B6QgT
	 EMw1W+pD6pmsCo6M+EgSKM0ydyKcur8tXnUUL74w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438940AbfJXLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436501AbfJXLYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:24:02 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2152084C;
        Thu, 24 Oct 2019 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571916241;
        bh=g+R7dOXwcKElWRvz7nfCK0CoS/QqY5FvmWjQtXYXq/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/diBaZcHhDWIo+d+S3cwC1M/W56n2/OKrdFxsOE29WIddOrDJOiJE939fYB6f+wr
         ODZud7Q8KKyseuJi4mAQmDp58BR7ZJLemuOE7wiIq5XXXpa78RfGKwxczTO//LyzZ0
         JJwSN3501O/+N/dCEA6sXvX2WxPHxRLcNGf5NhfM=
Date:   Thu, 24 Oct 2019 16:53:56 +0530
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
Subject: Re: [PATCH] soundwire: intel: fix PDI/stream mapping for Bulk
Message-ID: <20191024112356.GA2620@vkoul-mobl>
References: <20191022232948.17156-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022232948.17156-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:29, Pierre-Louis Bossart wrote:
> The previous formula is incorrect for PDI0/1, the mapping is not
> linear but has a discontinuity between PDI1 and PDI2.
> 
> This change has no effect on PCM PDIs (same mapping).
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index b403ccc832b6..c984261fcc33 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -480,7 +480,10 @@ intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
>  	unsigned int link_id = sdw->instance;
>  	int pdi_conf = 0;
>  
> -	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
> +	/* the Bulk and PCM streams are not contiguous */
> +	pdi->intel_alh_id = (link_id * 16) + pdi->num + 3;
> +	if (pdi->num >= 2)
> +		pdi->intel_alh_id += 2;
>  
>  	/*
>  	 * Program stream parameters to stream SHIM register
> @@ -509,7 +512,10 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
>  	unsigned int link_id = sdw->instance;
>  	unsigned int conf;
>  
> -	pdi->intel_alh_id = (link_id * 16) + pdi->num + 5;
> +	/* the Bulk and PCM streams are not contiguous */
> +	pdi->intel_alh_id = (link_id * 16) + pdi->num + 3;
> +	if (pdi->num >= 2)
> +		pdi->intel_alh_id += 2;

The change is repeated so how about:

        intel_pdi_update_alh() or similar which does this rather than
repeat the pattern

>  
>  	/* Program Stream config ALH register */
>  	conf = intel_readl(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id));
> -- 
> 2.20.1

-- 
~Vinod
