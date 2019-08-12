Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D4FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A322208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfHLKjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:39:03 -0400
Received: from foss.arm.com ([217.140.110.172]:47956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfHLKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:39:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9FC615AB;
        Mon, 12 Aug 2019 03:39:01 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EBDF3F706;
        Mon, 12 Aug 2019 03:39:01 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: Serialize enabling/disabling a link device.
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190809214538.29677-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <056f411f-eef2-752e-0c02-2e5ed803cc62@arm.com>
Date:   Mon, 12 Aug 2019 11:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809214538.29677-1-yabinc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yabin,

On 09/08/2019 22:45, Yabin Cui wrote:
> When tracing etm data of multiple threads on multiple cpus through perf
> interface, some link devices are shared between paths of different cpus.
> It creates race conditions when different cpus wants to enable/disable
> the same link device at the same time.
> 
> Example 1:
> Two cpus want to enable different ports of a coresight funnel, thus
> calling the funnel enable operation at the same time. But the funnel
> enable operation isn't reentrantable.
> 
> Example 2:
> For an enabled coresight dynamic replicator with refcnt=1, one cpu wants
> to disable it, while another cpu wants to enable it. Ideally we still have
> an enabled replicator with refcnt=1 at the end. But in reality the result
> is uncertain.
> 
> Since coresight devices claim themselves when enabled for self-hosted
> usage, the race conditions above usually make the link devices not usable
> after many cycles.
> 
> To fix the race conditions, this patch adds a spinlock to serialize
> enabling/disabling a link device.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> 
> v1 -> v2: extend lock range to protect read of refcnt in
> coresight_disable_link().

Thanks for this. Please find my comments below.

> 
> ---
>   drivers/hwtracing/coresight/coresight.c | 12 +++++++++++-
>   include/linux/coresight.h               |  3 +++
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 55db77f6410b..e526bdeaeb22 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -256,6 +256,7 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   	int ret;
>   	int link_subtype;
>   	int refport, inport, outport;
> +	unsigned long flags;
>   
>   	if (!parent || !child)
>   		return -EINVAL;
> @@ -274,15 +275,18 @@ static int coresight_enable_link(struct coresight_device *csdev,
>   	if (refport < 0)
>   		return refport;
>   
> +	spin_lock_irqsave(&csdev->spinlock, flags);
>   	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
>   		if (link_ops(csdev)->enable) {
>   			ret = link_ops(csdev)->enable(csdev, inport, outport);
>   			if (ret) {
>   				atomic_dec(&csdev->refcnt[refport]);
> +				spin_unlock_irqrestore(&csdev->spinlock, flags);
>   				return ret;
>   			}
>   		}
>   	}
> +	spin_unlock_irqrestore(&csdev->spinlock, flags);
>   
>   	csdev->enable = true;

Please could we move this inside the spin_lock () too ?

>   
> @@ -296,6 +300,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   	int i, nr_conns;
>   	int link_subtype;
>   	int refport, inport, outport;
> +	unsigned long flags;
>   
>   	if (!parent || !child)
>   		return;
> @@ -315,14 +320,18 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   		nr_conns = 1;
>   	}
>   
> +	spin_lock_irqsave(&csdev->spinlock, flags);
>   	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
>   		if (link_ops(csdev)->disable)
>   			link_ops(csdev)->disable(csdev, inport, outport);
>   	}
>   
>   	for (i = 0; i < nr_conns; i++)
> -		if (atomic_read(&csdev->refcnt[i]) != 0)
> +		if (atomic_read(&csdev->refcnt[i]) != 0) {
> +			spin_unlock_irqrestore(&csdev->spinlock, flags);
>   			return;
> +		}
> +	spin_unlock_irqrestore(&csdev->spinlock, flags);
>   
>   	csdev->enable = false;
>   }

And this too ? I understand this may not be used right now, but we can avoid any
surprises when we do so.

With the above fixed, :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
