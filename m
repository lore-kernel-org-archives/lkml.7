Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79591CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19A21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405637AbfJWNLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:11:03 -0400
Received: from [217.140.110.172] ([217.140.110.172]:51720 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfJWNLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:11:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593254A7;
        Wed, 23 Oct 2019 06:10:44 -0700 (PDT)
Received: from [10.37.9.47] (unknown [10.37.9.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17FFD3F6C4;
        Wed, 23 Oct 2019 06:10:42 -0700 (PDT)
Subject: Re: [PATCH v4] coresight: Serialize enabling/disabling a link device.
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191018181403.106836-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d4b10a7f-6823-8b6d-c63d-a1df3c719a2e@arm.com>
Date:   Wed, 23 Oct 2019 14:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191018181403.106836-1-yabinc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2019 07:14 PM, Yabin Cui wrote:
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
> To fix the race conditions, this patch uses spinlocks to serialize
> enabling/disabling link devices.
> 
> Fixes: a06ae8609b3d ("coresight: add CoreSight core layer framework")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> 
> v3 -> v4: moved lock from coresight_enable/disable_link() to
> enable/disable functions of each link device.
> 
> I also removed lock protection of csdev->enable in v3. Because that
> needs to move csdev->enable inside the enable/disable functions of
> each link device. That's much effort with almost no benefits.
> csdev->enable seems only used for source devices in sysfs interface.
> 
> ---
>   .../hwtracing/coresight/coresight-funnel.c    | 29 ++++++++----
>   .../coresight/coresight-replicator.c          | 31 +++++++++----
>   .../hwtracing/coresight/coresight-tmc-etf.c   | 39 ++++++++--------
>   drivers/hwtracing/coresight/coresight.c       | 45 ++++++-------------
>   4 files changed, 77 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 05f7896c3a01..8326d03a0d03 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -44,6 +44,7 @@ struct funnel_drvdata {
>   	struct clk		*atclk;
>   	struct coresight_device	*csdev;
>   	unsigned long		priority;
> +	spinlock_t		spinlock;
>   };
>   
>   static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
> @@ -76,12 +77,20 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
>   {
>   	int rc = 0;
>   	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
>   
> -	if (drvdata->base)
> -		rc = dynamic_funnel_enable_hw(drvdata, inport);
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_inc_return(&csdev->refcnt[inport]) == 1) {
> +		if (drvdata->base)
> +			rc = dynamic_funnel_enable_hw(drvdata, inport);
>   
> -	if (!rc)
> -		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
> +		if (rc)
> +			atomic_dec(&csdev->refcnt[inport]);
> +		else
> +			dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
> +				inport);
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   	return rc;
>   }
>   
> @@ -107,11 +116,15 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
>   			   int outport)
>   {
>   	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
>   
> -	if (drvdata->base)
> -		dynamic_funnel_disable_hw(drvdata, inport);
> -
> -	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_dec_return(&csdev->refcnt[inport]) == 0) {
> +		if (drvdata->base)
> +			dynamic_funnel_disable_hw(drvdata, inport);
> +		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   }
>   
>   static const struct coresight_ops_link funnel_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b29ba640eb25..427d8b8d0917 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -36,6 +36,7 @@ struct replicator_drvdata {
>   	void __iomem		*base;
>   	struct clk		*atclk;
>   	struct coresight_device	*csdev;
> +	spinlock_t		spinlock;
>   };
>   
>   static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> @@ -97,11 +98,20 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>   {
>   	int rc = 0;
>   	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	if (drvdata->base)
> -		rc = dynamic_replicator_enable(drvdata, inport, outport);
> -	if (!rc)
> -		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_inc_return(&csdev->refcnt[outport]) == 1) {

Since we now have the spinlock to protect us, we could simply do an
atomic_read() and then do the hw_enable() followed by an atomic_inc(),
if we are successful. That way we could make it more cleaner and avoid
the atomic_dec() if we encounter a failure. In fact we could simply get
away with the refcnt and replace them with a simple integer, but that
may be a different patch.


> +		if (drvdata->base)
> +			rc = dynamic_replicator_enable(drvdata, inport,
> +						       outport);
> +
> +		if (rc)
> +			atomic_dec(&csdev->refcnt[outport]);
> +		else
> +			dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   	return rc;
>   }
>   
> @@ -137,10 +147,15 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>   			       int outport)
>   {
>   	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
>   
> -	if (drvdata->base)
> -		dynamic_replicator_disable(drvdata, inport, outport);
> -	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_dec_return(&csdev->refcnt[outport]) == 0) {
> +		if (drvdata->base)
> +			dynamic_replicator_disable(drvdata, inport, outport);
> +		dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);


>   }
>   
>   static const struct coresight_ops_link replicator_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 807416b75ecc..cb4a38541bf8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -334,23 +334,25 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
>   static int tmc_enable_etf_link(struct coresight_device *csdev,
>   			       int inport, int outport)
>   {
> -	int ret;
> +	int ret = 0;
>   	unsigned long flags;
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>   
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (drvdata->reading) {
> -		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -		return -EBUSY;
> +	if (atomic_inc_return(&csdev->refcnt[0]) == 1) {
> +		if (drvdata->reading)
> +			ret = -EBUSY;

Could we not check the drvdata->reading before the refcount and bail
out early ? We are protected by the spinlock anyway. Similar to the
above case we could check the refcount and only increment when we have
enabled.


Cheers
Suzuki
