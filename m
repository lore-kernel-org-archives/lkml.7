Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D831C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FB22339E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="eBK49+bx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfICUy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:54:59 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37380 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICUy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:54:58 -0400
Received: by mail-yb1-f196.google.com with SMTP id t5so6470299ybt.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/Cfewt0pLyQh7lWltSphkxLah1C/x9kO5VArxPKuys=;
        b=eBK49+bx/culM6xuAHOvmDYVCNCGH94aLJ4OnUm65R88og+FKRJzn30BV6cNdTlim9
         85tjwlzcVf9lK9sJdppF19XiwtCnnMUPeWL8K01LnSEz4nREquz8o/sbQJXLDqEXxxQO
         MwgpNdm+UuXK+ePqi1camR42cEn9Um6L4ebfVKQNBSujU2itT1QBxJbH+ImmGKHwykJC
         5sG1QioFiegJQjmr+GZdTad/3YZadcY0gvXreIkraJQbk4Sh/mjHYYiZyLCHXMwrvqI7
         gNxswxe2trVjuyPdTdmwhxOFB+fkQL/02593sq3Ua+gGaruBfYOUMqKxLvJP+eX3mjEc
         3FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/Cfewt0pLyQh7lWltSphkxLah1C/x9kO5VArxPKuys=;
        b=ZpRh+4Pb5RInimqfU0eACfyejJE+DENDQtCLHNvT4abCIpB6lZEcpGWu3AX0uVqgRI
         eOOZYAAA44BwCttVy1vNAiZA1c4DyES6xea35VFG2QjhxqoH9gcQpg1rZouKr/HRhj0/
         hzXdj4Z1NXC3agYWHAOYAfBH7jCNjLK0+WF7uPxBFxQp0QyJ4JJGUt6Uys80EuN9xl34
         ZvE9iNmcjulUZb0ojOhe4EOA/+p0yQCUkcO0MAyGz2iUJdXZxmjYL7Hb5ZzPGE9vEY3H
         Jt17baWJNOvgRUrYTV1IAH8Gcrh42vBmYdyjg/tVlj6GcGi14bKrxXO9acYqJqWuWlb9
         9dXQ==
X-Gm-Message-State: APjAAAXO6c6LNBi6FCRpQlBajJy+GKvav9eCBU7YNpPLf5cYXLfS0n5H
        rd5AFnK4rLS7qiH5rstRld3OxGIBhcUHGw==
X-Google-Smtp-Source: APXvYqzJbum5Ic9rfk/ivIXRdszIjRN4tJfnxZ7KPXjR2zR8nhD3mthSxemy+21G0MhiehLcBSOm1w==
X-Received: by 2002:a5b:949:: with SMTP id x9mr25303608ybq.419.1567544097784;
        Tue, 03 Sep 2019 13:54:57 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id u196sm3459062ywu.72.2019.09.03.13.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 13:54:57 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:54:57 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH 10/10] drm/msm: add atomic traces
Message-ID: <20190903205457.GO218215@art_vandelay>
References: <20190829164601.11615-1-robdclark@gmail.com>
 <20190829164601.11615-11-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829164601.11615-11-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:45:18AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This was useful for debugging fps drops.  I suspect it will be useful
> again.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

I'm a simple man, I see tracepoints patches and R-b tracepoints patches :)

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
>  drivers/gpu/drm/msm/Makefile                 |   1 +
>  drivers/gpu/drm/msm/msm_atomic.c             |  24 +++-
>  drivers/gpu/drm/msm/msm_atomic_trace.h       | 110 +++++++++++++++++++
>  drivers/gpu/drm/msm/msm_atomic_tracepoints.c |   3 +
>  drivers/gpu/drm/msm/msm_gpu_trace.h          |   2 +-
>  5 files changed, 136 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/msm_atomic_trace.h
>  create mode 100644 drivers/gpu/drm/msm/msm_atomic_tracepoints.c
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 7a05cbf2f820..1579cf0d828f 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -75,6 +75,7 @@ msm-y := \
>  	disp/dpu1/dpu_rm.o \
>  	disp/dpu1/dpu_vbif.o \
>  	msm_atomic.o \
> +	msm_atomic_tracepoints.o \
>  	msm_debugfs.o \
>  	msm_drv.o \
>  	msm_fb.o \
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 80536538967b..fb247aa1081e 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -6,6 +6,7 @@
>  
>  #include <drm/drm_atomic_uapi.h>
>  
> +#include "msm_atomic_trace.h"
>  #include "msm_drv.h"
>  #include "msm_gem.h"
>  #include "msm_kms.h"
> @@ -33,11 +34,13 @@ static void msm_atomic_async_commit(struct msm_kms *kms, int crtc_idx)
>  {
>  	unsigned crtc_mask = BIT(crtc_idx);
>  
> +	trace_msm_atomic_async_commit_start(crtc_mask);
> +
>  	mutex_lock(&kms->commit_lock);
>  
>  	if (!(kms->pending_crtc_mask & crtc_mask)) {
>  		mutex_unlock(&kms->commit_lock);
> -		return;
> +		goto out;
>  	}
>  
>  	kms->pending_crtc_mask &= ~crtc_mask;
> @@ -47,19 +50,24 @@ static void msm_atomic_async_commit(struct msm_kms *kms, int crtc_idx)
>  	/*
>  	 * Flush hardware updates:
>  	 */
> -	DRM_DEBUG_ATOMIC("triggering async commit\n");
> +	trace_msm_atomic_flush_commit(crtc_mask);
>  	kms->funcs->flush_commit(kms, crtc_mask);
>  	mutex_unlock(&kms->commit_lock);
>  
>  	/*
>  	 * Wait for flush to complete:
>  	 */
> +	trace_msm_atomic_wait_flush_start(crtc_mask);
>  	kms->funcs->wait_flush(kms, crtc_mask);
> +	trace_msm_atomic_wait_flush_finish(crtc_mask);
>  
>  	mutex_lock(&kms->commit_lock);
>  	kms->funcs->complete_commit(kms, crtc_mask);
>  	mutex_unlock(&kms->commit_lock);
>  	kms->funcs->disable_commit(kms);
> +
> +out:
> +	trace_msm_atomic_async_commit_finish(crtc_mask);
>  }
>  
>  static enum hrtimer_restart msm_atomic_pending_timer(struct hrtimer *t)
> @@ -144,13 +152,17 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  	bool async = kms->funcs->vsync_time &&
>  			can_do_async(state, &async_crtc);
>  
> +	trace_msm_atomic_commit_tail_start(async, crtc_mask);
> +
>  	kms->funcs->enable_commit(kms);
>  
>  	/*
>  	 * Ensure any previous (potentially async) commit has
>  	 * completed:
>  	 */
> +	trace_msm_atomic_wait_flush_start(crtc_mask);
>  	kms->funcs->wait_flush(kms, crtc_mask);
> +	trace_msm_atomic_wait_flush_finish(crtc_mask);
>  
>  	mutex_lock(&kms->commit_lock);
>  
> @@ -201,6 +213,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  		drm_atomic_helper_commit_hw_done(state);
>  		drm_atomic_helper_cleanup_planes(dev, state);
>  
> +		trace_msm_atomic_commit_tail_finish(async, crtc_mask);
> +
>  		return;
>  	}
>  
> @@ -213,14 +227,16 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  	/*
>  	 * Flush hardware updates:
>  	 */
> -	DRM_DEBUG_ATOMIC("triggering commit\n");
> +	trace_msm_atomic_flush_commit(crtc_mask);
>  	kms->funcs->flush_commit(kms, crtc_mask);
>  	mutex_unlock(&kms->commit_lock);
>  
>  	/*
>  	 * Wait for flush to complete:
>  	 */
> +	trace_msm_atomic_wait_flush_start(crtc_mask);
>  	kms->funcs->wait_flush(kms, crtc_mask);
> +	trace_msm_atomic_wait_flush_finish(crtc_mask);
>  
>  	mutex_lock(&kms->commit_lock);
>  	kms->funcs->complete_commit(kms, crtc_mask);
> @@ -229,4 +245,6 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  
>  	drm_atomic_helper_commit_hw_done(state);
>  	drm_atomic_helper_cleanup_planes(dev, state);
> +
> +	trace_msm_atomic_commit_tail_finish(async, crtc_mask);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_atomic_trace.h b/drivers/gpu/drm/msm/msm_atomic_trace.h
> new file mode 100644
> index 000000000000..b4ca0ed3b4a3
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/msm_atomic_trace.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if !defined(_MSM_GPU_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
> +#define _MSM_GPU_TRACE_H_
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM drm_msm_atomic
> +#define TRACE_INCLUDE_FILE msm_atomic_trace
> +
> +TRACE_EVENT(msm_atomic_commit_tail_start,
> +	    TP_PROTO(bool async, unsigned crtc_mask),
> +	    TP_ARGS(async, crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(bool, async)
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->async = async;
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("async=%d crtc_mask=%x",
> +		    __entry->async, __entry->crtc_mask)
> +);
> +
> +TRACE_EVENT(msm_atomic_commit_tail_finish,
> +	    TP_PROTO(bool async, unsigned crtc_mask),
> +	    TP_ARGS(async, crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(bool, async)
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->async = async;
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("async=%d crtc_mask=%x",
> +		    __entry->async, __entry->crtc_mask)
> +);
> +
> +TRACE_EVENT(msm_atomic_async_commit_start,
> +	    TP_PROTO(unsigned crtc_mask),
> +	    TP_ARGS(crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("crtc_mask=%x",
> +		    __entry->crtc_mask)
> +);
> +
> +TRACE_EVENT(msm_atomic_async_commit_finish,
> +	    TP_PROTO(unsigned crtc_mask),
> +	    TP_ARGS(crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("crtc_mask=%x",
> +		    __entry->crtc_mask)
> +);
> +
> +TRACE_EVENT(msm_atomic_wait_flush_start,
> +	    TP_PROTO(unsigned crtc_mask),
> +	    TP_ARGS(crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("crtc_mask=%x",
> +		    __entry->crtc_mask)
> +);
> +
> +TRACE_EVENT(msm_atomic_wait_flush_finish,
> +	    TP_PROTO(unsigned crtc_mask),
> +	    TP_ARGS(crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("crtc_mask=%x",
> +		    __entry->crtc_mask)
> +);
> +
> +TRACE_EVENT(msm_atomic_flush_commit,
> +	    TP_PROTO(unsigned crtc_mask),
> +	    TP_ARGS(crtc_mask),
> +	    TP_STRUCT__entry(
> +		    __field(u32, crtc_mask)
> +		    ),
> +	    TP_fast_assign(
> +		    __entry->crtc_mask = crtc_mask;
> +		    ),
> +	    TP_printk("crtc_mask=%x",
> +		    __entry->crtc_mask)
> +);
> +
> +#endif
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH ../../drivers/gpu/drm/msm
> +#include <trace/define_trace.h>
> diff --git a/drivers/gpu/drm/msm/msm_atomic_tracepoints.c b/drivers/gpu/drm/msm/msm_atomic_tracepoints.c
> new file mode 100644
> index 000000000000..011dc881f391
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/msm_atomic_tracepoints.c
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include "msm_atomic_trace.h"
> diff --git a/drivers/gpu/drm/msm/msm_gpu_trace.h b/drivers/gpu/drm/msm/msm_gpu_trace.h
> index 1155118a27a1..122b84789238 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_trace.h
> +++ b/drivers/gpu/drm/msm/msm_gpu_trace.h
> @@ -5,7 +5,7 @@
>  #include <linux/tracepoint.h>
>  
>  #undef TRACE_SYSTEM
> -#define TRACE_SYSTEM drm_msm
> +#define TRACE_SYSTEM drm_msm_gpu
>  #define TRACE_INCLUDE_FILE msm_gpu_trace
>  
>  TRACE_EVENT(msm_gpu_submit,
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
