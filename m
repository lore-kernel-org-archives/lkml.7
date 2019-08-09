Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AF0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486802173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405992AbfHIJWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:22:10 -0400
Received: from foss.arm.com ([217.140.110.172]:44050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732885AbfHIJWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2483B15A2;
        Fri,  9 Aug 2019 02:22:09 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D8F53F575;
        Fri,  9 Aug 2019 02:22:08 -0700 (PDT)
Subject: Re: [PATCH] coresight: tmc-etr: Remove perf_data check.
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190808193122.76679-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <84df6071-ef7e-c3d6-6ffa-fcfcbab0c8e6@arm.com>
Date:   Fri, 9 Aug 2019 10:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808193122.76679-1-yabinc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yabin,


Thank you for the analysis and the patch.

On 08/08/2019 20:31, Yabin Cui wrote:
> When tracing etm data of multiple threads on multiple cpus through
> perf interface, each cpu has a unique etr_perf_buffer while sharing
> the same etr device. There is no guarantee that the last cpu starts
> etm tracing also stops last. So the perf_data check is no longer valid.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 9 ---------
>   drivers/hwtracing/coresight/coresight-tmc.h     | 2 --
>   2 files changed, 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..0418440e0141 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1484,20 +1484,12 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   		goto out;
>   	}
>   
> -	if (WARN_ON(drvdata->perf_data != etr_perf)) {
> -		lost = true;
> -		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -		goto out;
> -	}
> -

I think some sort of sanity check is a good idea to make sure we don't loose the
context. Even when different CPUs have different etr_perf buffer, the underlying
etr_buf should be the same. So, we should be able to simply convert the check
to, something like :

	struct etr_perf_buffer *perf_buf = drvdata->perf_data;

	...

	if (WARN_ON(perf_buf->etr_buf != etr_perf->buf)) {
		....
	}

Does that solve the problem for you ?

Suzuki
