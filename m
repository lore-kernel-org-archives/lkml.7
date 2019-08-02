Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB14C32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96C7217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564747115;
	bh=wg1TVivugkT9AShchO3kL9mJx3kBK6RvLWgk7noK1jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2nd3KQAIIkOFyHRog52HSuWLH3RKZkr2MxBzsFpYScIASN7IBwcJchv61WI12hyuu
	 38I74/nBXMzf9PtwIHAvpHpsGx3pjZ8t9IoIJ4Sm25lfA1bE2vC1qiGwFoDHl/GVcu
	 Tkz5PgBhSsZydj/YKQSBIN7oCuYeQYznIaIFqlTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392478AbfHBL6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfHBL6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:58:34 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F7021726;
        Fri,  2 Aug 2019 11:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564747113;
        bh=wg1TVivugkT9AShchO3kL9mJx3kBK6RvLWgk7noK1jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJnDK709i8msN2ZlkE4Rf681VV5Hqb7yn6TC1VgSRDoY/LfqwRj36pwTJy9w1Vh3v
         4HwAsyYMfFWlngs173KzNMGip3vwmvGT5XEmoJ1OkMG/I81jh8TKfTm7cIP1Iy4jl3
         zn9ttp59yCXnGDR0PJBuGfGWHzvbiouAxLKSH/Ak=
Date:   Fri, 2 Aug 2019 17:27:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 07/40] soundwire: intel: fix channel number reported
 by hardware
Message-ID: <20190802115719.GJ12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-8-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-8-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
> PDI2 reports an invalid count, force the correct hardware-supported
> value
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 497879dd9c0d..51990b192dc0 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -401,6 +401,15 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
>  
>  	if (pcm) {
>  		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
> +
> +		/*
> +		 * TODO: pdi number 2 reports channel count as 1 even though
> +		 * it supports 8 channel. Performing hardcoding for pdi
> +		 * number 2.
> +		 */
> +		if (pdi_num == 2)
> +			count = 7;

Is that true for all Intel controllers or some generations. Would it not
be better to put this under some flag which is set on platform basis?

> +
>  	} else {
>  		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
>  		count = ((count & SDW_SHIM_PDMSCAP_CPSS) >>
> -- 
> 2.20.1

-- 
~Vinod
