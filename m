Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4C20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391751AbfJWMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:50:35 -0400
Received: from [217.140.110.172] ([217.140.110.172]:51214 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfJWMue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:50:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15964A7;
        Wed, 23 Oct 2019 05:50:05 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A62D3F6C4;
        Wed, 23 Oct 2019 05:50:04 -0700 (PDT)
Subject: Re: [PATCH v2] panfrost: Properly undo pm_runtime_enable when
 deferring a probe
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20191023120925.30668-1-tomeu.vizoso@collabora.com>
 <20191023122157.32067-1-tomeu.vizoso@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6952956c-ba58-71de-05c9-fa39333484d9@arm.com>
Date:   Wed, 23 Oct 2019 13:49:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023122157.32067-1-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 1:21 pm, Tomeu Vizoso wrote:
> When deferring the probe because of a missing regulator, we were calling
> pm_runtime_disable even if pm_runtime_enable wasn't called.
> 
> Move the call to pm_runtime_disable to the right place.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reported-by: Chen-Yu Tsai <wens@csie.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: f4a3c6a44b35 ("drm/panfrost: Disable PM on probe failure")

I think that commit was right at the time, but actually we missed 
reordering the cleanup path to match the change in 635430797d3f. 
Otherwise, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index bc2ddeb55f5d..f21bc8a7ee3a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -556,11 +556,11 @@ static int panfrost_probe(struct platform_device *pdev)
>   	return 0;
>   
>   err_out2:
> +	pm_runtime_disable(pfdev->dev);
>   	panfrost_devfreq_fini(pfdev);
>   err_out1:
>   	panfrost_device_fini(pfdev);
>   err_out0:
> -	pm_runtime_disable(pfdev->dev);
>   	drm_dev_put(ddev);
>   	return err;
>   }
> 
