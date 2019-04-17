Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F38121773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MqulNFXR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MwvkwFPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfDQDeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:34:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDQDeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:34:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F3046110F; Wed, 17 Apr 2019 03:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555472043;
        bh=PzgmwJfnMi4Kpa1Xk54pqu2dCmWAYIrQ7kjuXbx9PGg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MqulNFXRrPriMCrU0qyBy3lo67fT3BtQ+v1sZR6u1P9fCAMxqncsUH1PTu1Lnamwz
         R1z340Pyh2cY60ulbDGjq9xzojixkB+OOitVGUcQvxz04Vl7STelUbWekoudDZsBCu
         0YC1oC8uxUPRjSJvQs4jEW0RJZVDq1sru1ekguU8=
Received: from [10.79.128.26] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03E3660CF0;
        Wed, 17 Apr 2019 03:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555472042;
        bh=PzgmwJfnMi4Kpa1Xk54pqu2dCmWAYIrQ7kjuXbx9PGg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MwvkwFPeOlhLD9sOV64latcnXfRh2YTGBeH26aTcra73sgUTCforqYFlBHTTeiz5z
         JPcT5ceb0wOkt+xy6DQNl2GZUZ6J3BSNZlWoR55XX51ktgFkvCnDtpbM8ciG3MSCG9
         8s9P5dqSvzXJId/2LXGJiPHAR1B/FBWbEGDAJV5w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03E3660CF0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] stm class: Fix out of bound access from bitmap allocation
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mulu He <muluhe@codeaurora.org>,
        David Laight <David.Laight@aculab.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
 <87mukqc7v8.fsf@ashishki-desk.ger.corp.intel.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c238838c-4155-c85c-8622-64b21d16712c@codeaurora.org>
Date:   Wed, 17 Apr 2019 09:03:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87mukqc7v8.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/2019 8:30 PM, Alexander Shishkin wrote:
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> writes:
> 
>> From: Mulu He <muluhe@codeaurora.org>
>>
>> Bitmap allocation works on array of unsigned longs and
>> for stm master allocation when the number of software
>> channels is 32, 4 bytes are allocated and there is a out of
>> bound access at the first 8 bytes access of bitmap region.
> 
> Does the below fix the problem for you?
> 
>  From fb22b9ab109b332e58d72df13563e270befbd0e3 Mon Sep 17 00:00:00 2001
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Date: Tue, 16 Apr 2019 17:47:02 +0300
> Subject: [PATCH] stm class: Fix channel bitmap on 32-bit systems
> 
> Commit 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace
> Module devices") naively calculates the channel bitmap size in 64-bit
> chunks regardless of the size of underlying unsigned long, making the
> bitmap half as big on a 32-bit system. This leads to an out of bounds
> access with the upper half of the bitmap.
> 
> Fix this by using BITS_TO_LONGS. While at it, convert to using
> struct_size() for the total size calculation of the master struct.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
> Reported-by: Mulu He <muluhe@codeaurora.org>
> Cc: stable@vger.kernel.org # v4.4+
> ---
>   drivers/hwtracing/stm/core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 5b5807cbcf7c..8c45e79e47db 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -166,11 +166,9 @@ stm_master(struct stm_device *stm, unsigned int idx)
>   static int stp_master_alloc(struct stm_device *stm, unsigned int idx)
>   {
>   	struct stp_master *master;
> -	size_t size;
>   
> -	size = ALIGN(stm->data->sw_nchannels, 8) / 8;
> -	size += sizeof(struct stp_master);
> -	master = kzalloc(size, GFP_ATOMIC);
> +	master = kzalloc(struct_size(master, chan_map, BITS_TO_LONGS(stm->data->sw_nchannels)),
> +			 GFP_ATOMIC);
>   	if (!master)
>   		return -ENOMEM;
>   
> 

++ David

Yes it does fix the issue. Actually initial fix internally was using
BITS_TO_LONGS, don't no why they deferred from it.

Anyways thanks for the patch.

- Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
