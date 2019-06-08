Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A11AC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F552173C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfFHTWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:22:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:48556 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfFHTWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:22:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 12:22:14 -0700
X-ExtLoop1: 1
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.93.16]) ([10.251.93.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2019 12:22:10 -0700
Subject: Re: [RFC PATCH 1/6] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-2-srinivas.kandagatla@linaro.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <13bfb632-f743-c416-2224-c7acb5b28604@intel.com>
Date:   Sat, 8 Jun 2019 21:22:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607085643.932-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-07 10:56, Srinivas Kandagatla wrote:
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
> index f5d70041108f..9f90b936fd9a 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -177,6 +177,7 @@ struct snd_soc_dai_ops {
>   
>   	int (*set_sdw_stream)(struct snd_soc_dai *dai,
>   			void *stream, int direction);
> +	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>   	/*
>   	 * DAI digital mute - optional.
>   	 * Called by soc-core to minimise any pops.
> @@ -385,4 +386,13 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>   		return -ENOTSUPP;
>   }
>   
> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai, int direction)

Exceeds character limit?

> +{
> +	if (dai->driver->ops->get_sdw_stream)
> +		return dai->driver->ops->get_sdw_stream(dai, direction);
> +	else
> +		return NULL;

set_ equivalent returns -ENOTSUPP instead.
ERR_PTR seems to make more sense here.

> +

Unnecessary newline.

> +}
> +
>   #endif
> 
