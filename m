Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A396C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391805AbfHBRUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:20:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:56340 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388134AbfHBRUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:20:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 10:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="197270088"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2019 10:20:12 -0700
Received: from cwhanson-mobl.amr.corp.intel.com (unknown [10.252.133.191])
        by linux.intel.com (Postfix) with ESMTP id 6A9885805B9;
        Fri,  2 Aug 2019 10:20:11 -0700 (PDT)
Subject: Re: [RFC PATCH 17/40] soundwire: bus: use runtime_pm_get_sync/pm when
 enabled
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <20190802165816.GU12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1ca3579b-00ac-39a7-d60b-908d1447677c@linux.intel.com>
Date:   Fri, 2 Aug 2019 12:20:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802165816.GU12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 11:58 AM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
>> Not all platforms support runtime_pm for now, let's use runtime_pm
>> only when enabled.
> 
> We discussed this with Ulf sometime back and it was a consensus the core
> should handle it, but that may take a while.
> 
> So that led me to explore what others do notably ASoC, based on this I
> feel we should not check the error code. We handle the non streaming
> case here but streaming is handled in ASoC which doesnt check the return
> 
> Pierre, can you verify the below patch and let me know if that is fine
> for Intel platforms

So if for some reason we cannot resume, then we'd still initiate a 
transaction and have even more issues to sort out.

Fail big and fail early would really be my preference.

Also the user of this function is largely the Slave driver, which 
typically doesn't do any streaming operation but controls the imp-def 
registers. The bus driver will only use this routine for standard 
registers and that's a very small part of the total traffic.

> 
> --- >8 ---
> 
> From: Vinod Koul <vkoul@kernel.org>
> Date: Fri, 2 Aug 2019 22:15:11 +0530
> Subject: [PATCH] soundwire: dont check return of pm_runtime_get_sync()
> 
> Soundwire core checks pm_runtime_get_sync() return. But in case the
> driver has not enabled runtime pm we get an error.
> 
> To fix this, dont check the return. We handle the non streaming case in
> framework but streaming case has similar handling in ASoC so make it
> same across use cases
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/soundwire/bus.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index fe745830a261..9cdf7e9e0852 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -326,9 +326,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_get_sync(slave->bus->dev);
>   
>   	ret = sdw_transfer(slave->bus, &msg);
>   	pm_runtime_put(slave->bus->dev);
> @@ -354,9 +352,7 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> -		return ret;
> +	pm_runtime_get_sync(slave->bus->dev);
>   
>   	ret = sdw_transfer(slave->bus, &msg);
>   	pm_runtime_put(slave->bus->dev);
> 

