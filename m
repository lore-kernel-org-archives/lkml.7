Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1333CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D02084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfKDUIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:08:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:12893 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbfKDUIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:08:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 12:08:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="376445080"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.83.74]) ([10.251.83.74])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2019 12:08:47 -0800
Subject: Re: [PATCH 13/14] soundwire: intel: free all resources on hw_free()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-14-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <42403ea0-e337-81b6-f11a-2a32c1473750@intel.com>
Date:   Mon, 4 Nov 2019 21:08:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023212823.608-14-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 23:28, Pierre-Louis Bossart wrote:
> Make sure all calls to the SoundWire stream API are done and involve
> callback
> 
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/intel.c | 40 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index af24fa048add..cad1c0b64ee3 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -548,6 +548,25 @@ static int intel_params_stream(struct sdw_intel *sdw,
>   	return -EIO;
>   }
>   
> +static int intel_free_stream(struct sdw_intel *sdw,
> +			     struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai,
> +			     int link_id)
> +{
> +	struct sdw_intel_link_res *res = sdw->link_res;
> +	struct sdw_intel_stream_free_data free_data;
> +
> +	free_data.substream = substream;
> +	free_data.dai = dai;
> +	free_data.link_id = link_id;
> +
> +	if (res->ops && res->ops->free_stream && res->dev)

Can res->dev even be null?

> +		return res->ops->free_stream(res->dev,
> +					     &free_data);
> +
> +	return 0;
> +}
> +
>   /*
>    * bank switch routines
>    */
> @@ -816,6 +835,7 @@ static int
>   intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>   {
>   	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_intel *sdw = cdns_to_intel(cdns);
>   	struct sdw_cdns_dma_data *dma;
>   	int ret;
>   
> @@ -823,12 +843,28 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>   	if (!dma)
>   		return -EIO;
>   
> +	ret = sdw_deprepare_stream(dma->stream);
> +	if (ret) {
> +		dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
> +		return ret;
> +	}
> +

I understand that you want to be transparent to caller with failure 
reasons via dev_err/_warn. However, sdw_deprepare_stream already dumps 
all the logs we need. The same applies for most of the other calls (and 
not just in this patch..).

Do we really need to be that verbose? Maybe just agree on caller -or- 
subject being the source for the messaging, align existing usages and 
thus preventing further duplication?

Not forcing anything, just asking for your opinion on this.

>   	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
> -	if (ret < 0)
> +	if (ret < 0) {
>   		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
>   			dma->stream->name, ret);
> +		return ret;
> +	}
>   
> -	return ret;
> +	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
> +	if (ret < 0) {
> +		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
> +		return ret;
> +	}
> +
> +	sdw_release_stream(dma->stream);
> +
> +	return 0;
>   }

Given the structure of this function, shouldn't the generic flow be 
handled by upper layer i.e. part of sdw core?. Apart from 
intel_free_stream, the rest looks pretty generic to me and this sole 
call could easily be extracted into ops.

>   
>   static void intel_shutdown(struct snd_pcm_substream *substream,
> 
