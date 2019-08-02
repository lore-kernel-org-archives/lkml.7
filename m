Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EFC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86A52173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564765172;
	bh=css3TiD9hFLpyOJyxwQpDcPAKn6XWOJ8sWPynjEeDxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AiVxKTYjnzFFhySZ4TyOfM1TAlG02OMPa+v/9KxQQH44pSZvdI8VqZL55CgjpY52l
	 SoAryLMCLV4uP4I/m5RyaDQxKgPIfYxn9pfHoL896spU8aegM59MzdoseOMablMBPp
	 HFyZhCdrktANz6G73Qx1X0PzUYL3cq4nVx1etmHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbfHBQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfHBQ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:59:31 -0400
Received: from localhost (unknown [106.51.106.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1952220644;
        Fri,  2 Aug 2019 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564765170;
        bh=css3TiD9hFLpyOJyxwQpDcPAKn6XWOJ8sWPynjEeDxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCEBW38XNwwGcSUNTevEsWJQrVwNiv5hlBRQrLnK7USqrL5mHxFbSTHR51HKDAL31
         G9MGwoi/fcMLXf+nP3t+4wsNCXmRuOjN53dPMozdQX8qXPDAmP8l/3mLSN7rvoKM2u
         djSvhTgnF1tMpGzcSpIP2QYZDCv6bvmPCJ4U4ua0=
Date:   Fri, 2 Aug 2019 22:28:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 17/40] soundwire: bus: use runtime_pm_get_sync/pm
 when enabled
Message-ID: <20190802165816.GU12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> Not all platforms support runtime_pm for now, let's use runtime_pm
> only when enabled.

We discussed this with Ulf sometime back and it was a consensus the core
should handle it, but that may take a while.

So that led me to explore what others do notably ASoC, based on this I
feel we should not check the error code. We handle the non streaming
case here but streaming is handled in ASoC which doesnt check the return

Pierre, can you verify the below patch and let me know if that is fine
for Intel platforms

--- >8 ---

From: Vinod Koul <vkoul@kernel.org>
Date: Fri, 2 Aug 2019 22:15:11 +0530
Subject: [PATCH] soundwire: dont check return of pm_runtime_get_sync()

Soundwire core checks pm_runtime_get_sync() return. But in case the
driver has not enabled runtime pm we get an error.

To fix this, dont check the return. We handle the non streaming case in
framework but streaming case has similar handling in ASoC so make it
same across use cases

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/bus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fe745830a261..9cdf7e9e0852 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -326,9 +326,7 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_get_sync(slave->bus->dev);
 
 	ret = sdw_transfer(slave->bus, &msg);
 	pm_runtime_put(slave->bus->dev);
@@ -354,9 +352,7 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(slave->bus->dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_get_sync(slave->bus->dev);
 
 	ret = sdw_transfer(slave->bus, &msg);
 	pm_runtime_put(slave->bus->dev);
-- 
2.20.1



> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 5ad4109dc72f..0a45dc5713df 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -332,12 +332,16 @@ int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> -		return ret;
> +	if (pm_runtime_enabled(slave->bus->dev)) {
> +		ret = pm_runtime_get_sync(slave->bus->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = sdw_transfer(slave->bus, &msg);
> -	pm_runtime_put(slave->bus->dev);
> +
> +	if (pm_runtime_enabled(slave->bus->dev))
> +		pm_runtime_put(slave->bus->dev);
>  
>  	return ret;
>  }
> @@ -359,13 +363,16 @@ int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>  			   slave->dev_num, SDW_MSG_FLAG_WRITE, val);
>  	if (ret < 0)
>  		return ret;
> -
> -	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> -		return ret;
> +	if (pm_runtime_enabled(slave->bus->dev)) {
> +		ret = pm_runtime_get_sync(slave->bus->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = sdw_transfer(slave->bus, &msg);
> -	pm_runtime_put(slave->bus->dev);
> +
> +	if (pm_runtime_enabled(slave->bus->dev))
> +		pm_runtime_put(slave->bus->dev);
>  
>  	return ret;
>  }
> -- 
> 2.20.1

-- 
~Vinod
