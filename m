Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5183C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7DC233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="U9H25fzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfH2NFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:05:19 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34289 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfH2NFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:05:19 -0400
Received: by mail-yb1-f195.google.com with SMTP id u68so1166356ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oB2V2oDizn+bNjnsA+L5QLEbTNlVkIvvrIN1uWftWrg=;
        b=U9H25fzzLjdZoYhtHqFGUY3b98H0cDFO731+o/hSSZ0eioY2hFRWZdjBuvMpRQ0xHv
         AMOD3Cyc9cIexJAtUUv1IbVzWyPJe2IDpPBoxBnxIcEMqrqkDvtw9xwOmYk9gBKR4SR6
         LH9WXux5/7elAEqCOdhP2eyfgpXTFTxz2g1yV02yPQOhdKwhPu+EhJ3GGZCTdMCeSUYX
         7ZC8Nh5RF20p7Byg5crPUB8WY6iBT1V0FGX7z7dqHG30MEdC6in/EhKUfGQXiHZzr/dF
         f2wk95GvwBeR5gLJ4JrucKTdwQ1oo55H1lWzJNpnHTvkzMSgADu+PLyedpto83ree3JT
         7XnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oB2V2oDizn+bNjnsA+L5QLEbTNlVkIvvrIN1uWftWrg=;
        b=RPQ9M6EuEQiUpNGg0ce/A0Pc1220HddL8ydYlrh1qQ85X3fUwbYtArh3d6yi5a7QE+
         Fc7xTQKJj0G+FeDTmOmkPPFoc2yj74FHUapbEMBDc2llGmyV2LnFwxDUTfsDKMzr93D/
         guWmOZE1ZycYTCzEEm1rKpyQ2Sp74gmbLDX3OvC3F8WS+IfgeD8boKRHZbODo4X429fH
         ywGwhoNVjVEGpDkN7puXmAU06R+8hlexhoJIaTCvz+z7032pm/boWeAAj2wm4lwnmD59
         UC2T+aEngN/7gj5zjgb1dmQNrioWqMSpUnSnn0G3e7kBOxY+t0XMt4EUGixiokZW2DcF
         t8sw==
X-Gm-Message-State: APjAAAW2LU7REQ5/3SjnZ4ySTsrOnhArw5nkvfzQ8f2m/w9zq2SmHAhA
        Uui4I910VZY4DKOFGVgFmkAoFw==
X-Google-Smtp-Source: APXvYqy3wdzMLg3v5Q+SrsMPjUG+o+wglzgDVSqgPFv2VxRd+X3LU/XXXvGIlxHb+l+DdNIc3Rwk4g==
X-Received: by 2002:a25:747:: with SMTP id 68mr7097126ybh.41.1567083917958;
        Thu, 29 Aug 2019 06:05:17 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id l4sm467267ywd.0.2019.08.29.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:05:17 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:05:17 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Bruce Wang <bzwang@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] drm/msm/dpu: handle_frame_done() from vblank irq
Message-ID: <20190829130517.GH218215@art_vandelay>
References: <20190827213421.21917-1-robdclark@gmail.com>
 <20190827213421.21917-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827213421.21917-4-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:33:33PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Previously the callback was called from whoever called wait_for_vblank(),
> but that isn't a great plan when wait_for_vblank() stops getting called,
> and results in frame_done_timer expiring.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |  7 +-----
>  .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  | 25 ++++++-------------
>  2 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index c3f7154017c4..e7354aef9805 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -311,12 +311,7 @@ static void dpu_crtc_frame_event_work(struct kthread_work *work)
>  				| DPU_ENCODER_FRAME_EVENT_PANEL_DEAD)) {
>  
>  		if (atomic_read(&dpu_crtc->frame_pending) < 1) {
> -			/* this should not happen */
> -			DRM_ERROR("crtc%d ev:%u ts:%lld frame_pending:%d\n",
> -					crtc->base.id,
> -					fevent->event,
> -					ktime_to_ns(fevent->ts),
> -					atomic_read(&dpu_crtc->frame_pending));
> +			/* ignore vblank when not pending */
>  		} else if (atomic_dec_return(&dpu_crtc->frame_pending) == 0) {
>  			/* release bandwidth and other resources */
>  			trace_dpu_crtc_frame_event_done(DRMID(crtc),
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 7c73b09894f0..b9c84fb4d4a1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -324,6 +324,10 @@ static void dpu_encoder_phys_vid_vblank_irq(void *arg, int irq_idx)
>  
>  	/* Signal any waiting atomic commit thread */
>  	wake_up_all(&phys_enc->pending_kickoff_wq);
> +
> +	phys_enc->parent_ops->handle_frame_done(phys_enc->parent, phys_enc,
> +			DPU_ENCODER_FRAME_EVENT_DONE);
> +
>  	DPU_ATRACE_END("vblank_irq");
>  }
>  
> @@ -483,8 +487,8 @@ static void dpu_encoder_phys_vid_get_hw_resources(
>  	hw_res->intfs[phys_enc->intf_idx - INTF_0] = INTF_MODE_VIDEO;
>  }
>  
> -static int _dpu_encoder_phys_vid_wait_for_vblank(
> -		struct dpu_encoder_phys *phys_enc, bool notify)
> +static int dpu_encoder_phys_vid_wait_for_vblank(
> +		struct dpu_encoder_phys *phys_enc)
>  {
>  	struct dpu_encoder_wait_info wait_info;
>  	int ret;
> @@ -499,10 +503,6 @@ static int _dpu_encoder_phys_vid_wait_for_vblank(
>  	wait_info.timeout_ms = KICKOFF_TIMEOUT_MS;
>  
>  	if (!dpu_encoder_phys_vid_is_master(phys_enc)) {
> -		if (notify && phys_enc->parent_ops->handle_frame_done)
> -			phys_enc->parent_ops->handle_frame_done(
> -					phys_enc->parent, phys_enc,
> -					DPU_ENCODER_FRAME_EVENT_DONE);
>  		return 0;
>  	}
>  
> @@ -512,20 +512,11 @@ static int _dpu_encoder_phys_vid_wait_for_vblank(
>  
>  	if (ret == -ETIMEDOUT) {
>  		dpu_encoder_helper_report_irq_timeout(phys_enc, INTR_IDX_VSYNC);
> -	} else if (!ret && notify && phys_enc->parent_ops->handle_frame_done)
> -		phys_enc->parent_ops->handle_frame_done(
> -				phys_enc->parent, phys_enc,
> -				DPU_ENCODER_FRAME_EVENT_DONE);
> +	}
>  
>  	return ret;
>  }
>  
> -static int dpu_encoder_phys_vid_wait_for_vblank(
> -		struct dpu_encoder_phys *phys_enc)
> -{
> -	return _dpu_encoder_phys_vid_wait_for_vblank(phys_enc, true);
> -}
> -
>  static int dpu_encoder_phys_vid_wait_for_commit_done(
>  		struct dpu_encoder_phys *phys_enc)
>  {
> @@ -615,7 +606,7 @@ static void dpu_encoder_phys_vid_disable(struct dpu_encoder_phys *phys_enc)
>  	 * scanout buffer) don't latch properly..
>  	 */
>  	if (dpu_encoder_phys_vid_is_master(phys_enc)) {
> -		ret = _dpu_encoder_phys_vid_wait_for_vblank(phys_enc, false);
> +		ret = dpu_encoder_phys_vid_wait_for_vblank(phys_enc);
>  		if (ret) {
>  			atomic_set(&phys_enc->pending_kickoff_cnt, 0);
>  			DRM_ERROR("wait disable failed: id:%u intf:%d ret:%d\n",
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
