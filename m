Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD1C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BFF208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436736AbfHIPis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:38:48 -0400
Received: from foss.arm.com ([217.140.110.172]:49068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:38:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 729A915A2;
        Fri,  9 Aug 2019 08:38:47 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC3B3F575;
        Fri,  9 Aug 2019 08:38:46 -0700 (PDT)
Subject: Re: [PATCH] coresight: Serialize enabling/disabling a link device.
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190808191726.65806-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c7ac79dd-c15c-6edf-153f-71dd8f754a93@arm.com>
Date:   Fri, 9 Aug 2019 16:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808191726.65806-1-yabinc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,-

On 08/08/2019 20:17, Yabin Cui wrote:
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
>   drivers/hwtracing/coresight/coresight.c | 8 ++++++++
>   include/linux/coresight.h               | 3 +++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 55db77f6410b..90f97f4f99b2 100644
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
>   

> @@ -296,6 +300,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   	int i, nr_conns;
>   	int link_subtype;
>   	int refport, inport, outport;
> +	unsigned long flags;
>   
>   	if (!parent || !child)
>   		return;
> @@ -315,10 +320,12 @@ static void coresight_disable_link(struct coresight_device *csdev,
>   		nr_conns = 1;
>   	}
>   
> +	spin_lock_irqsave(&csdev->spinlock, flags);
>   	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
>   		if (link_ops(csdev)->disable)
>   			link_ops(csdev)->disable(csdev, inport, outport);
>   	}
> +	spin_unlock_irqrestore(&csdev->spinlock, flags);

You may also want to protect the refcount checks below with the same lock, just
to be consistent.

With that :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
