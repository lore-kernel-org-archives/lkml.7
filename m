Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD922070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfHFPcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:32:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:14124 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHFPcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:32:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 08:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="174210315"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.15.113]) ([10.252.15.113])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2019 08:31:59 -0700
Subject: Re: [PATCH 09/17] soundwire: stream: remove unnecessary variable
 initializations
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-10-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a52b4fbd-1d97-d8b8-dd2c-fac30c6add4b@intel.com>
Date:   Tue, 6 Aug 2019 17:31:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806005522.22642-10-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-06 02:55, Pierre-Louis Bossart wrote:
> @@ -1493,6 +1493,11 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>   		}
>   	}
>   
> +	if (!bus) {
> +		pr_err("Configuration error in %s\n", __func__);
> +		return -EINVAL;
> +	}
> +

This should probably be located in separate path - not at all an 
initialization removal.

> @@ -1573,6 +1578,11 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>   		}
>   	}
>   
> +	if (!bus) {
> +		pr_err("Configuration error in %s\n", __func__);
> +		return -EINVAL;
> +	}
> +

Same here.

> @@ -1639,13 +1650,14 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>   
>   	ret = do_bank_switch(stream);
>   	if (ret < 0) {
> -		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> +		pr_err("Bank switch failed: %d\n", ret);
>   		return ret;
>   	}

Here too.

I might have missed something though I bet you got my point.
