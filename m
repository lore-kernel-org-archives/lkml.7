Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE3DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6B9218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGCMmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:42:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCMmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:42:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3569A2B;
        Wed,  3 Jul 2019 05:42:35 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1223F703;
        Wed,  3 Jul 2019 05:42:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu: add support for drivers that manage iommu
 explicitly
To:     Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        aarch64-laptops@lists.linaro.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Joe Perches <joe@perches.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190702202631.32148-1-robdclark@gmail.com>
 <20190702202631.32148-2-robdclark@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2d612bbc-2d2d-f718-1499-79d5a55e0d00@arm.com>
Date:   Wed, 3 Jul 2019 13:42:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190702202631.32148-2-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2019 21:26, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Avoid attaching any non-driver managed domain if the driver indicates
> that it manages the iommu directly.
> 
> This solves a couple problems that drm/msm + arm-smmu has with the iommu
> framework:
> 
> 1) In some cases the bootloader takes the iommu out of bypass and
>     enables the display.  This is in particular a problem on the aarch64
>     laptops that exist these days, and modern snapdragon android devices.
>     (Older devices also enabled the display in bootloader but did not
>     take the iommu out of bypass.)  Attaching a DMA or IDENTITY domain
>     while scanout is active, before the driver has a chance to intervene,
>     makes things go *boom*

In the general case, we have to assume that things already went boom 
long ago, as soon as the IOMMU itself was probed and reset. By the time 
we get to the point of binding of a client driver, also assume that the 
IOMMU is already powered off and stopping traffic because the RPM device 
links aren't in place yet and it believes itself unused.

> 2) We are currently blocked on landing support for GPU per-context
>     pagetables because of the domain attached before driver's ->probe()
>     is called.

I'm getting a little fed up of explaining that that problem is specific 
to the current behaviour of one particular IOMMU driver and trying to 
work around it anywhere other than in that driver is at best an 
unreliable hack.

> This solves both problems.

For a very, very specific value of "solve"... ;)

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/iommu/iommu.c  | 11 +++++++++++
>   include/linux/device.h |  3 ++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c674d80c37f..efa0957f9772 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1573,6 +1573,17 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   	    domain->ops->is_attach_deferred(domain, dev))
>   		return 0;
>   
> +	/*
> +	 * If driver is going to manage iommu directly, then avoid
> +	 * attaching any non driver managed domain.  There could
> +	 * be already active dma underway (ie. scanout in case of
> +	 * bootloader enabled display), and interfering with that
> +	 * will make things go *boom*
> +	 */
> +	if ((domain->type != IOMMU_DOMAIN_UNMANAGED) &&
> +	    dev->driver && dev->driver->driver_manages_iommu)
> +		return 0;

This leaving things half-hanging is really ugly, but more than that it 
assumes that allocating a default domain in the first place isn't 
disruptive - I'm not 100% sure that's *always* the case today, and it's 
definitely likely to change in future as part of improving the current 
request_dm_for_dev() mechanism. As it happens, those proposed changes 
would not only break this idea, but make it redundant, since they're 
about forcing the default domain type to passthrough on a per-device 
basis, which leads to an equivalent end result to this patch, but in a 
cleaner and more robust manner.

Robin.

> +
>   	if (unlikely(domain->ops->attach_dev == NULL))
>   		return -ENODEV;
>   
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e138baabe01e..d98aa4d3c8c3 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -282,7 +282,8 @@ struct device_driver {
>   	struct module		*owner;
>   	const char		*mod_name;	/* used for built-in modules */
>   
> -	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
> +	bool driver_manages_iommu:1;	/* driver manages IOMMU explicitly */
>   	enum probe_type probe_type;
>   
>   	const struct of_device_id	*of_match_table;
> 
