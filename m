Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F098C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5652070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lQpGkMDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJGNJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:09:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38815 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfJGNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:09:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so12276224wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Yxiscxu+rZkv0GpmY7e29YwdJRbkupuEUcx7F9xs4Y=;
        b=lQpGkMDvN/2Eed7/RTDHAN2UcBi2nFQADyY9PVT3VaiYOCiSFsgFgRiuy4uP4CydW0
         P8x8h1y5pyvNgAVj0lUGwlw7ttIKfRMZrg249mxq3omYa0lWWRvQeEWuVMKsjAUV4spV
         NVGAC2ghvUUHQoSVo4anzGLgReED5Nw/UqvR+LmUqh131GwQBPguL0+DWdRAnwN1cMbF
         g93RMQtD/FWuehAXR8DiHx3RP0rePS1AYheyMPJR3KPx+AcRzP3hL9fnPnTYNYc/i9AQ
         eCy+QnzYEVk6Zhr28ND5KRY2H9+RulZbcbJmIkd3bMSKG9CJzWL8Ga6HKp0pZGeuba6B
         yKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Yxiscxu+rZkv0GpmY7e29YwdJRbkupuEUcx7F9xs4Y=;
        b=BQfBSpbNImlzNj1a0CeY3bFdHKfxzo8CmQZL5UEOUx7msGck21+S65zj7OW2WUBfdJ
         /eWe99e6GdaH30CCrs/9YtZHSwt9EPuRm5eZawpF3wO7UgWU68EBwlFT164oc2tnOaub
         50WQj3pVXDjKGONR29WWZQlcjz0W6rwap1xJTV1CPxRqFN5JhND1IffYQrAYVB05uqfa
         cDaLl4mg55aIEtmRGZeYAui2xZPdlsa3+3ASL30x0SoG6amE0NWq7Oei9sBLXspsGhCs
         gg5MI2ssrEjH31tNA4Tm9bnxMM9YChqjrn8VN8T+dsZYKexxLWW4WwLeTIaHMcr2SIt6
         8CWg==
X-Gm-Message-State: APjAAAUwKCOqANjJ+LlDlJVq7ci18zCakpLN1MX82kerIkQ55rpE+Y5F
        G9LTw8k14mPUOL4gjJzAZo5VrQK5gJwOgQ==
X-Google-Smtp-Source: APXvYqxhSlP6tgHLGwZF0K+gT65dqgHRfBuMb3yg/O2HCi/wlkhDIPXttpCNEy0jM3In/UeU3ftjJQ==
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr21619096wmc.167.1570453743043;
        Mon, 07 Oct 2019 06:09:03 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t13sm39728301wra.70.2019.10.07.06.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 06:09:02 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Handle resetting on timeout better
To:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191007125014.12595-1-steven.price@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <81430487-0aa0-8c93-653f-d7a608f3dbff@baylibre.com>
Date:   Mon, 7 Oct 2019 15:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007125014.12595-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 07/10/2019 14:50, Steven Price wrote:
> Panfrost uses multiple schedulers (one for each slot, so 2 in reality),
> and on a timeout has to stop all the schedulers to safely perform a
> reset. However more than one scheduler can trigger a timeout at the same
> time. This race condition results in jobs being freed while they are
> still in use.
> 
> When stopping other slots use cancel_delayed_work_sync() to ensure that
> any timeout started for that slot has completed. Also use
> mutex_trylock() to obtain reset_lock. This means that only one thread
> attempts the reset, the other threads will simply complete without doing
> anything (the first thread will wait for this in the call to
> cancel_delayed_work_sync()).
> 
> While we're here and since the function is already dependent on
> sched_job not being NULL, let's remove the unnecessary checks, along
> with a commented out call to panfrost_core_dump() which has never
> existed in mainline.
> 

A Fixes: tags would be welcome here so it would be backported to v5.3

> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> This is a tidied up version of the patch orginally posted here:
> http://lkml.kernel.org/r/26ae2a4d-8df1-e8db-3060-41638ed63e2a%40arm.com
> 
>  drivers/gpu/drm/panfrost/panfrost_job.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index a58551668d9a..dcc9a7603685 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -381,13 +381,19 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
>  		job_read(pfdev, JS_TAIL_LO(js)),
>  		sched_job);
>  
> -	mutex_lock(&pfdev->reset_lock);
> +	if (!mutex_trylock(&pfdev->reset_lock))
> +		return;
>  
> -	for (i = 0; i < NUM_JOB_SLOTS; i++)
> -		drm_sched_stop(&pfdev->js->queue[i].sched, sched_job);
> +	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> +		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
> +
> +		drm_sched_stop(sched, sched_job);
> +		if (js != i)
> +			/* Ensure any timeouts on other slots have finished */
> +			cancel_delayed_work_sync(&sched->work_tdr);
> +	}
>  
> -	if (sched_job)
> -		drm_sched_increase_karma(sched_job);
> +	drm_sched_increase_karma(sched_job);

Indeed looks cleaner.

>  
>  	spin_lock_irqsave(&pfdev->js->job_lock, flags);
>  	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> @@ -398,7 +404,6 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
>  	}
>  	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
>  
> -	/* panfrost_core_dump(pfdev); */

This should be cleaned in another patch !

>  
>  	panfrost_devfreq_record_transition(pfdev, js);
>  	panfrost_device_reset(pfdev);
> 

Thanks,
Testing it right now with the last change removed (doesn't apply on v5.3 with it),
results in a few hours... or minutes !


Neil
