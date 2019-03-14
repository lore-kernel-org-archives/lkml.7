Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E361C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599D42087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RSNseEI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCNLXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:23:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37886 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCNLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:23:40 -0400
Received: by mail-it1-f195.google.com with SMTP id z124so4216324itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chzv3sOGQssStbUGe1BwwWHSqMko4lYHgGB0WJRlk/o=;
        b=RSNseEI9RngBy2t5BRJQhqkvcNnhF/QzkeWbpwswNrI9tnNFkmJLJexMfvC4538X/R
         +lf8RBsQjvScH618Rt0JO54kEXXcEmnE1E5CLvPky4K84icV8iTfMGFjeDF6D7kqQcYT
         vdPbdNIWX+pe4Aw9h7lIax8UumaFo4keE4Qxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chzv3sOGQssStbUGe1BwwWHSqMko4lYHgGB0WJRlk/o=;
        b=JrDGn6iFUq9+zq6GyxPhi8slL76uaqZIsZ/nKIAPHb5VV9mr45kKJBQYzpjMhBNUIG
         9ViFb5cbChBGYELkbbNHzZCI8TFFkFEnbFZw7HqGQnuZ/7nvwtTyE9RblTrUmRm9HCB8
         U4izqhW6aHSoLyg9vRnf3GIrDq76o6+GXPiyMUu1kD68D2p9EsVDwk7a00uxhNx5Aa/5
         GgD5gsZ8EbbbtjnytLfswO2n7zB/lq+/OqdTf8OlHVwYB78pIZINzHfn1mA7w5QTorIF
         K+j5s4vxCDDO+vbLIJNhZQYSqXRmxWwzEqYcMCOp27N3ETm26AYvOVewxubCXFR6164r
         g/CQ==
X-Gm-Message-State: APjAAAVu8vNvngicMA2IGZMZQKAX6tPUOe/+bDxtcluq/DirWA/j/P/w
        39KNTy2A5tyvfMRbHx8T9XBoj1PRT10ABcCcBynuSg==
X-Google-Smtp-Source: APXvYqyNoZev3C2ex2+w6rYMdOTRyWPVtHOhChBzwAigvJZD+usdYOExROWmbDOnc5Cg8H2OQUgWUTBQbLdN7IRGoEs=
X-Received: by 2002:a24:3655:: with SMTP id l82mr1677725itl.107.1552562619471;
 Thu, 14 Mar 2019 04:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235211.28995-1-eric@anholt.net> <20190313235211.28995-2-eric@anholt.net>
In-Reply-To: <20190313235211.28995-2-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Thu, 14 Mar 2019 11:23:28 +0000
Message-ID: <CAApk1dUzZt+Aw21GoCXLbzct_2+4upatyxvcpAV61Ks6knFHhg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/v3d: Rename the fence signaled from IRQs to "irq_fence".
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 23:52, Eric Anholt <eric@anholt.net> wrote:
>
> We have another thing called the "done fence" that tracks when the
> scheduler considers the job done, and having the shared name was
> confusing.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.h   |  4 ++--
>  drivers/gpu/drm/v3d/v3d_gem.c   |  6 +++---
>  drivers/gpu/drm/v3d/v3d_irq.c   |  6 +++---
>  drivers/gpu/drm/v3d/v3d_sched.c | 12 ++++++------
>  4 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index a128cd5ee6ea..284ced85ff02 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -169,7 +169,7 @@ struct v3d_job {
>         struct dma_fence *in_fence;
>
>         /* v3d fence to be signaled by IRQ handler when the job is complete. */
> -       struct dma_fence *done_fence;
> +       struct dma_fence *irq_fence;
>
>         /* GPU virtual addresses of the start/end of the CL job. */
>         u32 start, end;
> @@ -216,7 +216,7 @@ struct v3d_tfu_job {
>         struct dma_fence *in_fence;
>
>         /* v3d fence to be signaled by IRQ handler when the job is complete. */
> -       struct dma_fence *done_fence;
> +       struct dma_fence *irq_fence;
>
>         struct v3d_dev *v3d;
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 8ebbc544c61e..b06bed0835c9 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -339,8 +339,8 @@ v3d_exec_cleanup(struct kref *ref)
>         dma_fence_put(exec->bin.in_fence);
>         dma_fence_put(exec->render.in_fence);
>
> -       dma_fence_put(exec->bin.done_fence);
> -       dma_fence_put(exec->render.done_fence);
> +       dma_fence_put(exec->bin.irq_fence);
> +       dma_fence_put(exec->render.irq_fence);
>
>         dma_fence_put(exec->bin_done_fence);
>         dma_fence_put(exec->render_done_fence);
> @@ -373,7 +373,7 @@ v3d_tfu_job_cleanup(struct kref *ref)
>         unsigned int i;
>
>         dma_fence_put(job->in_fence);
> -       dma_fence_put(job->done_fence);
> +       dma_fence_put(job->irq_fence);
>
>         for (i = 0; i < ARRAY_SIZE(job->bo); i++) {
>                 if (job->bo[i])
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index a09442ec7297..044062607577 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -96,7 +96,7 @@ v3d_irq(int irq, void *arg)
>
>         if (intsts & V3D_INT_FLDONE) {
>                 struct v3d_fence *fence =
> -                       to_v3d_fence(v3d->bin_job->bin.done_fence);
> +                       to_v3d_fence(v3d->bin_job->bin.irq_fence);
>
>                 trace_v3d_bcl_irq(&v3d->drm, fence->seqno);
>                 dma_fence_signal(&fence->base);
> @@ -105,7 +105,7 @@ v3d_irq(int irq, void *arg)
>
>         if (intsts & V3D_INT_FRDONE) {
>                 struct v3d_fence *fence =
> -                       to_v3d_fence(v3d->render_job->render.done_fence);
> +                       to_v3d_fence(v3d->render_job->render.irq_fence);
>
>                 trace_v3d_rcl_irq(&v3d->drm, fence->seqno);
>                 dma_fence_signal(&fence->base);
> @@ -141,7 +141,7 @@ v3d_hub_irq(int irq, void *arg)
>
>         if (intsts & V3D_HUB_INT_TFUC) {
>                 struct v3d_fence *fence =
> -                       to_v3d_fence(v3d->tfu_job->done_fence);
> +                       to_v3d_fence(v3d->tfu_job->irq_fence);
>
>                 trace_v3d_tfu_irq(&v3d->drm, fence->seqno);
>                 dma_fence_signal(&fence->base);
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index d0c68b7c8b41..e740f3b99aa5 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -156,9 +156,9 @@ static struct dma_fence *v3d_job_run(struct drm_sched_job *sched_job)
>         if (IS_ERR(fence))
>                 return NULL;
>
> -       if (job->done_fence)
> -               dma_fence_put(job->done_fence);
> -       job->done_fence = dma_fence_get(fence);
> +       if (job->irq_fence)
> +               dma_fence_put(job->irq_fence);
> +       job->irq_fence = dma_fence_get(fence);
>
>         trace_v3d_submit_cl(dev, q == V3D_RENDER, to_v3d_fence(fence)->seqno,
>                             job->start, job->end);
> @@ -199,9 +199,9 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
>                 return NULL;
>
>         v3d->tfu_job = job;
> -       if (job->done_fence)
> -               dma_fence_put(job->done_fence);
> -       job->done_fence = dma_fence_get(fence);
> +       if (job->irq_fence)
> +               dma_fence_put(job->irq_fence);
> +       job->irq_fence = dma_fence_get(fence);
>
>         trace_v3d_submit_tfu(dev, to_v3d_fence(fence)->seqno);
>
> --
> 2.20.1
>
