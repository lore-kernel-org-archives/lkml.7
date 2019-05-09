Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742C7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447F7217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfEIQW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:22:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45704 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfEIQW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:22:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819E3374;
        Thu,  9 May 2019 09:22:57 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7424C3F6C4;
        Thu,  9 May 2019 09:22:56 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Only put sync_out if non-NULL
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20190507080405.GA9436@mwanda>
 <20190509082151.8823-1-tomeu.vizoso@collabora.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <963a53ae-5a70-3ba3-c910-889e70304032@arm.com>
Date:   Thu, 9 May 2019 17:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509082151.8823-1-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2019 09:21, Tomeu Vizoso wrote:
> Dan Carpenter's static analysis tool reported:
> 
> drivers/gpu/drm/panfrost/panfrost_drv.c:222 panfrost_ioctl_submit()
> error: we previously assumed 'sync_out' could be null (see line 216)
> 
> Indeed, sync_out could be NULL if userspace doesn't send a sync object
> ID for the out fence.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lists.freedesktop.org/archives/dri-devel/2019-May/217014.html

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 94b0819ad50b..d11e2281dde6 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -219,7 +219,8 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
>  fail_job:
>  	panfrost_job_put(job);
>  fail_out_sync:
> -	drm_syncobj_put(sync_out);
> +	if (sync_out)
> +		drm_syncobj_put(sync_out);
>  
>  	return ret;
>  }
> 

