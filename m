Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF32085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfHLKpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:45:32 -0400
Received: from foss.arm.com ([217.140.110.172]:48106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfHLKpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:45:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA0715AB;
        Mon, 12 Aug 2019 03:45:31 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677F73F706;
        Mon, 12 Aug 2019 03:45:30 -0700 (PDT)
Subject: Re: [PATCH] coresight: tmc-etr: Fix perf_data check.
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190809202330.51183-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8b154f20-60d9-74a4-8e5d-65ad612dc387@arm.com>
Date:   Mon, 12 Aug 2019 11:45:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809202330.51183-1-yabinc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2019 21:23, Yabin Cui wrote:
> When tracing etm data of multiple threads on multiple cpus through
> perf interface, each cpu has a unique etr_perf_buffer while sharing
> the same etr device. There is no guarantee that the last cpu starts
> etm tracing also stops last. This makes perf_data check fail.
> 
> Fix it by checking etr_buf instead of etr_perf_buffer.

Please could you add a Fixes tag for this:

Fixes: 3147da92a8a81fc3 ("coresight: tmc-etr: Allocate and free ETR memory 
buffers for CPU-wide scenarios")

as the problem was introduced as a side effect of the above patch ?

> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..f466f05afe08 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1484,7 +1484,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   		goto out;
>   	}
>   
> -	if (WARN_ON(drvdata->perf_data != etr_perf)) {
> +	if (WARN_ON(drvdata->perf_data != etr_buf)) {
>   		lost = true;
>   		spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   		goto out;
> @@ -1556,7 +1556,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>   	}
>   
>   	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
> -	drvdata->perf_data = etr_perf;
> +	drvdata->perf_data = etr_perf->etr_buf;

minor nit: Now that we are storing the etr_buf instead of the etr_perf_buf in
perf_data, we could make the "perf_data" => "perf_buf" inline with the
sysfs_buf.

Either ways:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
