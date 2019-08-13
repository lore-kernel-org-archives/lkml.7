Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08221C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D821520840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfHMQDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:03:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:19105 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfHMQDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:03:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 09:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="177840021"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.1.240]) ([10.252.1.240])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2019 09:03:36 -0700
Subject: Re: [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, pierre-louis.bossart@linux.intel.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <95c517ab-7c63-5d13-a03a-1db01812bb69@intel.com>
Date:   Tue, 13 Aug 2019 18:03:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-13 10:35, Srinivas Kandagatla wrote:
> On platforms which have smart speaker amplifiers connected via
> soundwire and modeled as aux devices in ASoC, in such usecases machine
> driver should be able to get sdw master stream from dai so that it can
> use the runtime stream to setup slave streams.
> 
> soundwire already as a set function, get function would provide more
> flexibility to above configurations.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   include/sound/soc-dai.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index dc48fe081a20..1e01f4a302e0 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -202,6 +202,7 @@ struct snd_soc_dai_ops {
>   
>   	int (*set_sdw_stream)(struct snd_soc_dai *dai,
>   			void *stream, int direction);
> +	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>   	/*
>   	 * DAI digital mute - optional.
>   	 * Called by soc-core to minimise any pops.
> @@ -410,4 +411,13 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>   		return -ENOTSUPP;
>   }
>   
> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
> +					       int direction)
> +{
> +	if (dai->driver->ops->get_sdw_stream)
> +		return dai->driver->ops->get_sdw_stream(dai, direction);
> +	else
> +		return ERR_PTR(-ENOTSUPP);
> +}

Drop redundant else.

