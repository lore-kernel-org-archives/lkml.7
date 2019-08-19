Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F19222CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566233911;
	bh=g7kVlBCVAodPzDkYY1OcJfHcsAghNjnMJvDNyNo04NM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wsXkCXui1R9DaBKOGjThMFJyLFe27AUZ4ar9Jaw3J8mGeM+vz6Qwc9W74C6loUymk
	 HGjbIqcEjNccHvJQLYUHVs/ippIM0U1mqhHDBsSuLwWPMbwcjtBmQg/U60mhA5pLqi
	 33oWVmnveFiw6bCPz2lOQZG4whdvqFa0yGfTTpEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfHSQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfHSQ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:58:29 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6A722CEA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566233908;
        bh=g7kVlBCVAodPzDkYY1OcJfHcsAghNjnMJvDNyNo04NM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sP51mE9Gddo1yJclORSeMLnhVoqH2kNg8A2jM7pJ1CsHDAeFng9MpZTHQKDBcwMbv
         +fvjHKDzmB6BtPIILI7Ak1qHw8pXQWM0U8Fcg2eR++l5aX0VjJ3thWq2CiTpwbEUYK
         WXURB/tIvO7Ypp5/ZE3yYg77sas50TcLxS9ZkHoA=
Received: by mail-qt1-f174.google.com with SMTP id 44so2640862qtg.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:58:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXNkOgfuOFcgK7/WYMCLVI2KcX0HjRDgxVlBTYXWmo8c3i1j0es
        KzQkh+fudbEHe6aN+iNt41tP355dg3xezgezqw==
X-Google-Smtp-Source: APXvYqyC4K6hDEfKTOtWD8dHY6tdS5htlOWoxGZdKVdQyuAu1jI2/uEG4E/+K43Xo4WtMeeUYdGX/l4DqM3gSJFtut8=
X-Received: by 2002:ac8:386f:: with SMTP id r44mr22408374qtb.300.1566233907616;
 Mon, 19 Aug 2019 09:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190816093107.30518-2-steven.price@arm.com>
In-Reply-To: <20190816093107.30518-2-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 11:58:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJKm7n=SuQrPTxfWR=Cgqn-gR-bgOrOdTVyR_XCae0FQg@mail.gmail.com>
Message-ID: <CAL_JsqJKm7n=SuQrPTxfWR=Cgqn-gR-bgOrOdTVyR_XCae0FQg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Queue jobs on the hardware
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 4:31 AM Steven Price <steven.price@arm.com> wrote:
>
> The hardware has a set of '_NEXT' registers that can hold a second job
> while the first is executing. Make use of these registers to enqueue a
> second job per slot.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Note that this is based on top of Rob Herring's "per FD address space"
> patch[1].
>
> [1] https://marc.info/?i=20190813150115.30338-1-robh%20()%20kernel%20!%20org
>
>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c    | 76 ++++++++++++++++++----
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    |  2 +-
>  3 files changed, 67 insertions(+), 15 deletions(-)

LGTM, but I'll give Tomeu a chance to comment.

Rob

>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index f503c566e99f..0153defd6085 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -55,7 +55,7 @@ struct panfrost_devfreq_slot {
>         ktime_t busy_time;
>         ktime_t idle_time;
>         ktime_t time_last_update;
> -       bool busy;
> +       int busy;
>  };
>
>  struct panfrost_device {
> @@ -80,7 +80,7 @@ struct panfrost_device {
>
>         struct panfrost_job_slot *js;
>
> -       struct panfrost_job *jobs[NUM_JOB_SLOTS];
> +       struct panfrost_job *jobs[NUM_JOB_SLOTS][2];
>         struct list_head scheduled_jobs;
>
>         struct panfrost_perfcnt *perfcnt;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 05c85f45a0de..b2b5027af976 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -138,6 +138,37 @@ static void panfrost_job_write_affinity(struct panfrost_device *pfdev,
>         job_write(pfdev, JS_AFFINITY_NEXT_HI(js), affinity >> 32);
>  }
>
> +static int panfrost_job_count(struct panfrost_device *pfdev, int slot)
> +{
> +       if (pfdev->jobs[slot][0] == NULL)
> +               return 0;
> +       if (pfdev->jobs[slot][1] == NULL)
> +               return 1;
> +       return 2;
> +}
> +
> +static struct panfrost_job *panfrost_dequeue_job(
> +               struct panfrost_device *pfdev, int slot)
> +{
> +       struct panfrost_job *job = pfdev->jobs[slot][0];
> +
> +       pfdev->jobs[slot][0] = pfdev->jobs[slot][1];
> +       pfdev->jobs[slot][1] = NULL;
> +
> +       return job;
> +}
> +
> +static void panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
> +                                struct panfrost_job *job)
> +{
> +       if (pfdev->jobs[slot][0] == NULL) {
> +               pfdev->jobs[slot][0] = job;
> +               return;
> +       }
> +       WARN_ON(pfdev->jobs[slot][1] != NULL);
> +       pfdev->jobs[slot][1] = job;
> +}
> +
>  static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>  {
>         struct panfrost_device *pfdev = job->pfdev;
> @@ -150,13 +181,16 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>         if (ret < 0)
>                 return;
>
> -       if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js))))
> -               goto end;
> -
>         cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
>
> -       panfrost_devfreq_record_transition(pfdev, js);
>         spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
> +       panfrost_enqueue_job(pfdev, js, job);
> +
> +       if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js))))
> +               goto end;
> +
> +       if (panfrost_job_count(pfdev, js) == 1)
> +               panfrost_devfreq_record_transition(pfdev, js);
>
>         job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
>         job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
> @@ -186,9 +220,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>
>         job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
>
> +end:
>         spin_unlock_irqrestore(&pfdev->hwaccess_lock, flags);
>
> -end:
>         pm_runtime_mark_last_busy(pfdev->dev);
>         pm_runtime_put_autosuspend(pfdev->dev);
>  }
> @@ -336,8 +370,6 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
>         if (unlikely(job->base.s_fence->finished.error))
>                 return NULL;
>
> -       pfdev->jobs[slot] = job;
> -
>         fence = panfrost_fence_create(pfdev, slot);
>         if (IS_ERR(fence))
>                 return NULL;
> @@ -421,21 +453,36 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
>         struct panfrost_device *pfdev = data;
>         u32 status = job_read(pfdev, JOB_INT_STAT);
>         int j;
> +       unsigned long flags;
>
>         dev_dbg(pfdev->dev, "jobslot irq status=%x\n", status);
>
>         if (!status)
>                 return IRQ_NONE;
>
> +       spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
> +
>         pm_runtime_mark_last_busy(pfdev->dev);
>
>         for (j = 0; status; j++) {
>                 u32 mask = MK_JS_MASK(j);
> +               int jobs = panfrost_job_count(pfdev, j);
> +               int active;
>
>                 if (!(status & mask))
>                         continue;
>
>                 job_write(pfdev, JOB_INT_CLEAR, mask);
> +               active = (job_read(pfdev, JOB_INT_JS_STATE) &
> +                         JOB_INT_MASK_DONE(j)) ? 1 : 0;
> +
> +               if (!(status & JOB_INT_MASK_ERR(j))) {
> +                       /* Recheck RAWSTAT to check if there's a newly
> +                        * failed job (since JOB_INT_STAT was read)
> +                        */
> +                       status |= job_read(pfdev, JOB_INT_RAWSTAT) &
> +                               JOB_INT_MASK_ERR(j);
> +               }
>
>                 if (status & JOB_INT_MASK_ERR(j)) {
>                         job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
> @@ -447,20 +494,25 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
>                                 job_read(pfdev, JS_TAIL_LO(j)));
>
>                         drm_sched_fault(&pfdev->js->queue[j].sched);
> +                       jobs --;
>                 }
>
> -               if (status & JOB_INT_MASK_DONE(j)) {
> -                       struct panfrost_job *job = pfdev->jobs[j];
> +               while (jobs -- > active) {
> +                       struct panfrost_job *job =
> +                               panfrost_dequeue_job(pfdev, j);
>
> -                       pfdev->jobs[j] = NULL;
>                         panfrost_mmu_as_put(pfdev, &job->file_priv->mmu);
> -                       panfrost_devfreq_record_transition(pfdev, j);
>                         dma_fence_signal(job->done_fence);
>                 }
>
> +               if (!active)
> +                       panfrost_devfreq_record_transition(pfdev, j);
> +
>                 status &= ~mask;
>         }
>
> +       spin_unlock_irqrestore(&pfdev->hwaccess_lock, flags);
> +
>         return IRQ_HANDLED;
>  }
>
> @@ -491,7 +543,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>
>                 ret = drm_sched_init(&js->queue[j].sched,
>                                      &panfrost_sched_ops,
> -                                    1, 0, msecs_to_jiffies(500),
> +                                    2, 0, msecs_to_jiffies(500),
>                                      "pan_js");
>                 if (ret) {
>                         dev_err(pfdev->dev, "Failed to create scheduler: %d.", ret);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index f22d8f02568d..c25fd88ef437 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -147,7 +147,7 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
>         as = mmu->as;
>         if (as >= 0) {
>                 int en = atomic_inc_return(&mmu->as_count);
> -               WARN_ON(en >= NUM_JOB_SLOTS);
> +               WARN_ON(en >= NUM_JOB_SLOTS*2);
>
>                 list_move(&mmu->list, &pfdev->as_lru_list);
>                 goto out;
> --
> 2.20.1
>
