Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79642C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D74123405
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfH2RyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:54:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:64903 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfH2RyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:54:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 10:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="265064623"
Received: from sauravna-mobl.amr.corp.intel.com (HELO [10.251.11.53]) ([10.251.11.53])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2019 10:54:22 -0700
Subject: Re: [alsa-devel] [PATCH v5 4/4] ASoC: codecs: add wsa881x amplifier
 support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
 <20190829144442.6210-5-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <33e04646-ac7e-3ba1-3e09-a4f27a1b250b@linux.intel.com>
Date:   Thu, 29 Aug 2019 11:36:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829144442.6210-5-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int wsa881x_ramp_pa_gain(struct snd_soc_component *comp,
> +				int min_gain, int max_gain, int udelay)
> +{
> +	int val;
> +
> +	for (val = min_gain; max_gain <= val; val--) {
> +		snd_soc_component_update_bits(comp, WSA881X_SPKR_DRV_GAIN,
> +					      0xF0, val << 4);
> +		/*
> +		 * 1ms delay is needed for every step change in gain as per
> +		 * HW requirement.
> +		 */
> +		usleep_range(udelay, udelay + 10);

nit-pick: it'd be nicer to have udelay explicitly set here instead of in 
the caller below for consistency with the comments.

> +			wsa881x_ramp_pa_gain(comp, min_gain, max_gain, 1000);

But apart from that I didn't see anything blatantly wrong, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
