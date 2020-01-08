Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24372C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0060620880
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgAHLTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:19:02 -0500
Received: from foss.arm.com ([217.140.110.172]:42644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgAHLS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:18:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4F7630E;
        Wed,  8 Jan 2020 03:18:58 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1133F703;
        Wed,  8 Jan 2020 03:18:57 -0800 (PST)
Subject: Re: [PATCH RFT v1 1/3] drm/panfrost: enable devfreq based the
 "operating-points-v2" property
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
 <20200107230626.885451-2-martin.blumenstingl@googlemail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a85f2063-f412-9762-58d1-47fdffb24af9@arm.com>
Date:   Wed, 8 Jan 2020 11:18:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107230626.885451-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 11:06 pm, Martin Blumenstingl wrote:
> Decouple the check to see whether we want to enable devfreq for the GPU
> from dev_pm_opp_set_regulators(). This is preparation work for adding
> back support for regulator control (which means we need to call
> dev_pm_opp_set_regulators() before dev_pm_opp_of_add_table(), which
> means having a check for "is devfreq enabled" that is not tied to
> dev_pm_opp_of_add_table() makes things easier).

Hmm, what about cases like the SCMI DVFS protocol where the OPPs are 
dynamically discovered rather than statically defined in DT?

Robin.

> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 413987038fbf..1471588763ce 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -5,6 +5,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>   #include <linux/clk.h>
> +#include <linux/property.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include "panfrost_device.h"
> @@ -79,10 +80,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct devfreq *devfreq;
>   	struct thermal_cooling_device *cooling;
>   
> -	ret = dev_pm_opp_of_add_table(dev);
> -	if (ret == -ENODEV) /* Optional, continue without devfreq */
> +	if (!device_property_present(dev, "operating-points-v2"))
> +		/* Optional, continue without devfreq */
>   		return 0;
> -	else if (ret)
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret)
>   		return ret;
>   
>   	panfrost_devfreq_reset(pfdev);
> 
