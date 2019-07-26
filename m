Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6333C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E5321743
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rx0+UFWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbfGZOYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:24:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42225 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGZOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:24:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id v15so53472284eds.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkUcOf0ydA+KKuluIvIb7Xy/IXTYqkk4lpoXnmpOp5Y=;
        b=Rx0+UFWuP+pfapsIi/dvMT7L7ha7aPBlk89E7/oppXApi7d1NI5QPDUwlRlW5s5mSy
         q1aey0LXSoAVbe5Wdl5DaP2vIvyz7K/mChUaKxLP5VxrrhGA+qmOG+cwAPbV6Yiv87/N
         E0mFseeM77jST+wqYSm2ivuIsVjwLhqfsIuk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hkUcOf0ydA+KKuluIvIb7Xy/IXTYqkk4lpoXnmpOp5Y=;
        b=SOOfwo5JoJcrD+HwmQYajNiwpxtdnToTHidYFB5tOILXdP4t+IZlWVpWpQjp/HyvK1
         Z3ajvzFppqGKi+0/hzpLYPkH8Z70SpZ6mCyExtQR8/hciQA7OFygaEcrXpliBlrk/XdM
         NMM9ZGnQQ/tgoV5KjMtGlVwcWjDv15FzMshgXgXq7VAhTmkUwdrdY/YZadU6ZhmL2Sbs
         Jt+pfXLjusCZUGenCUw3JhHp+IAGEcCtrsE5kQ3wAUKwrSrdfUncIFVByImPGRdzo5Bn
         pWbwsXWychLUBUPBDcfb5bt8GctF+fffdLNSvkHTQXV2qu48hSM6U7OXJpjf8rx0dJtD
         kjTQ==
X-Gm-Message-State: APjAAAXIl6pp2Ey1q2DN1QFiKHCJCMc5Jf0vD5NqE5MbKsrJY5WFQuP4
        NhxOnEBXUK2CQRPTZBFaZWc=
X-Google-Smtp-Source: APXvYqx6A0XL0N1neMFyUVBMB5rD0gK8wO/m8LMT7Jy6fxmIUv/h+V5CAFBcqVqIRQBoBV2s03YSkw==
X-Received: by 2002:a17:906:4894:: with SMTP id v20mr70646164ejq.120.1564151039742;
        Fri, 26 Jul 2019 07:23:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w4sm10166343eja.34.2019.07.26.07.23.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 07:23:58 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:23:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Skips the invalid writeback job
Message-ID: <20190726142356.GI15868@phenom.ffwll.local>
Mail-Followup-To: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
References: <1564128758-23553-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564128758-23553-1-git-send-email-lowry.li@arm.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:13:00AM +0000, Lowry Li (Arm Technology China) wrote:
> Current DRM-CORE accepts the writeback_job with a empty fb, but that
> is an invalid job for HW, so need to skip it when commit it to HW.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>

Hm, this sounds a bit like an oversight in core writeback code? Not sure
how this can even happen, setting up a writeback job without an fb sounds
a bit like a bug to me at least ...

If we don't have a good reason for why other hw needs to accept this, then
imo this needs to be rejected in shared code. For consistent behaviour
across all writeback supporting drivers.
-Daniel

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c         | 2 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 2fed1f6..372e99a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -265,7 +265,7 @@ void komeda_crtc_handle_event(struct komeda_crtc *kcrtc,
>  		komeda_pipeline_update(slave, old->state);
>  
>  	conn_st = wb_conn ? wb_conn->base.base.state : NULL;
> -	if (conn_st && conn_st->writeback_job)
> +	if (conn_st && conn_st->writeback_job && conn_st->writeback_job->fb)
>  		drm_writeback_queue_job(&wb_conn->base, conn_st);
>  
>  	/* step 2: notify the HW to kickoff the update */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 9787745..8e2ef63 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -52,9 +52,16 @@
>  	struct komeda_data_flow_cfg dflow;
>  	int err;
>  
> -	if (!writeback_job || !writeback_job->fb)
> +	if (!writeback_job)
>  		return 0;
>  
> +	if (!writeback_job->fb) {
> +		if (writeback_job->out_fence)
> +			DRM_DEBUG_ATOMIC("Out fence required on a invalid writeback job.\n");
> +
> +		return writeback_job->out_fence ? -EINVAL : 0;
> +	}
> +
>  	if (!crtc_st->active) {
>  		DRM_DEBUG_ATOMIC("Cannot write the composition result out on a inactive CRTC.\n");
>  		return -EINVAL;
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
