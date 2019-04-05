Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E912420652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfDEKdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:33:01 -0400
Received: from foss.arm.com ([217.140.101.70]:45624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbfDEKdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:33:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3052168F;
        Fri,  5 Apr 2019 03:32:59 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9003F557;
        Fri,  5 Apr 2019 03:32:56 -0700 (PDT)
Subject: Re: [PATCH] stm class: Fix channel free in stm output free path
To:     saiprakash.ranjan@codeaurora.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Cc:     rnayak@codeaurora.org, vivek.gautam@codeaurora.org,
        sibis@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        tingwei@codeaurora.org, stable@vger.kernel.org
References: <20190405102442.25718-1-saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <92837d44-f8b9-c8f1-864c-b4d051f3a317@arm.com>
Date:   Fri, 5 Apr 2019 11:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405102442.25718-1-saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2019 11:24, Sai Prakash Ranjan wrote:
> From: Tingwei Zhang <tingwei@codeaurora.org>
> 
> Number of free masters is not set correctly in stm
> free path. Fix this by properly adding the number
> of output channels before setting them to 0 in
> stm_output_disclaim().
> 
> Currently it is equivalent to doing nothing since
> master->nr_free is incremented by 0.
> 
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: stable@vger.kernel.org
> ---
>   drivers/hwtracing/stm/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index c7ba8acfd4d5..5b5807cbcf7c 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -218,8 +218,8 @@ stm_output_disclaim(struct stm_device *stm, struct stm_output *output)
>   	bitmap_release_region(&master->chan_map[0], output->channel,
>   			      ilog2(output->nr_chans));
>   
> -	output->nr_chans = 0;
>   	master->nr_free += output->nr_chans;
> +	output->nr_chans = 0;

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

