Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_TVD_FUZZY_SECURITIES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1917C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554757465;
	bh=yzuXJ9W8bPU5MyFLHF0g1NMIYL6IdF2TPars33+T9Wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O3vCh2l5zy/vP9/cyiZT7J6aFLdlA6QYqYJCY0Orz+Q/whi3fn4bzo3eZaGcHoUSe
	 j8MA6Gx42YLAGA4FYk0WN4f6AcSJCqUIANiZpmEh+cj0TkdaHFtOU8imx81zp4c5Hr
	 O7TPLsz+Fsp/qomDnuAtxYrB8ugjY3hxrrVWs8YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDHVEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:04:24 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5844D218EA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554757462;
        bh=yzuXJ9W8bPU5MyFLHF0g1NMIYL6IdF2TPars33+T9Wc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EcsVO5X8YhjsqsxSGSK6l8nVCTc/9nHbLVvg6lqUfyStHjq7tXRjuPOu0CRvPka25
         3a1cxkw3SjQtzM9GHImuGbIVGXyXgOLJF6xFmjUzY8TK88EKw4E2lVlliRSp1+DKOW
         a4/flaNgUyaJ3xi8I8mrDy5Xr0hakMZGHjUaCtX8=
Received: by mail-qk1-f176.google.com with SMTP id g1so8941135qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:04:22 -0700 (PDT)
X-Gm-Message-State: APjAAAWPD5lxsUauE9WeeisM0KXZxuaC5JQ6YhqdFWv/PoQUO6aT2Xie
        yB1/dMaePJT3EDe262pH1CicwUHC8bZJ/RYkSw==
X-Google-Smtp-Source: APXvYqw+9e+7hSGuNnc/3PFOD9ZG2hX3bcriKwNIAbIuxtQh6qSknCgxTSn3kbT+HIxf/vZhflJfIXqC7GK3NoL2bcQ=
X-Received: by 2002:a37:6441:: with SMTP id y62mr24227562qkb.158.1554757461449;
 Mon, 08 Apr 2019 14:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
In-Reply-To: <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Apr 2019 16:04:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
Message-ID: <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
>
> On 01/04/2019 08:47, Rob Herring wrote:
> > This adds the initial driver for panfrost which supports Arm Mali
> > Midgard and Bifrost family of GPUs. Currently, only the T860 and
> > T760 Midgard GPUs have been tested.

[...]

> > +     case 0xD3: return "TRANSTAB_BUS_FAULT_LEVEL3";
> > +     case 0xD4: return "TRANSTAB_BUS_FAULT_LEVEL4";
> > +     case 0xD8: return "ACCESS_FLAG";
> > +     }
> > +
> > +     if (panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
>
> There's not a great deal of point in this conditional - you won't get
> the below exception codes from hardware which doesn't support it AARCH64
> page tables.

I wasn't sure if "UNKNOWN" types could happen or not.

>
> > +             switch (exception_code) {
> > +             case 0xC9 ... 0xCF: return "PERMISSION_FAULT";
> > +             case 0xD9 ... 0xDF: return "ACCESS_FLAG";
> > +             case 0xE0 ... 0xE7: return "ADDRESS_SIZE_FAULT";
> > +             case 0xE8 ... 0xEF: return "MEMORY_ATTRIBUTES_FAULT";
> > +             }
> > +     }
> > +
> > +     return "UNKNOWN";
> > +}

> > +static inline int panfrost_model_cmp(struct panfrost_device *pfdev, s32 id)
> > +{
> > +     s32 match_id = pfdev->features.id;
> > +
> > +     if (match_id & 0xf000)
> > +             match_id &= 0xf00f;
>
> I'm puzzled by this, and really not sure if it's going to work out
> ignoring the ARCH_MINOR/ARCH_REV fields. But for now there's no real
> Bifrost support.

That seemed to be enough for kbase to select features/issues.

> > +     switch (param->param) {
> > +     case DRM_PANFROST_PARAM_GPU_ID:
> > +             param->value = pfdev->features.id;
>
> This is unfortunate naming - this parameter is *not* the GPU_ID. It is
> the top half of the GPU_ID which kbase calls the PRODUCT_ID.

I can rename it.

> I'm also somewhat surprised that you don't need loads of other
> properties from the GPU - in particular knowing the number of shader
> cores is useful for allocating the right amount of memory for TLS (and
> can't be obtained purely from the GPU_ID).

We'll add them as userspace needs them.

> > +static int
> > +panfrost_lookup_bos(struct drm_device *dev,
> > +               struct drm_file *file_priv,
> > +               struct drm_panfrost_submit *args,
> > +               struct panfrost_job *job)
> > +{
> > +     u32 *handles;
> > +     int ret = 0;
> > +
> > +     job->bo_count = args->bo_handle_count;
> > +
> > +     if (!job->bo_count)
> > +             return 0;
> > +
> > +     job->bos = kvmalloc_array(job->bo_count,
> > +                               sizeof(struct drm_gem_object *),
> > +                               GFP_KERNEL | __GFP_ZERO);
> > +     if (!job->bos)
>
> If we return here then job->bo_count has been set, but job->bos is
> invalid - this means that panfrost_job_cleanup() will then dereference
> NULL. Although maybe this is better fixed in panfrost_job_cleanup().

Good catch. The fence arrays have the same problem. As does V3D which we copied.

> > +             return -ENOMEM;
> > +
> > +     job->implicit_fences = kvmalloc_array(job->bo_count,
> > +                               sizeof(struct dma_fence *),
> > +                               GFP_KERNEL | __GFP_ZERO);
> > +     if (!job->implicit_fences)
> > +             return -ENOMEM;

> > +static irqreturn_t panfrost_gpu_irq_handler(int irq, void *data)
> > +{
> > +     struct panfrost_device *pfdev = data;
> > +     u32 state = gpu_read(pfdev, GPU_INT_STAT);
> > +     u32 fault_status = gpu_read(pfdev, GPU_FAULT_STATUS);
> > +     u64 address;
> > +     bool done = false;
> > +
> > +     if (!state)
> > +             return IRQ_NONE;
> > +
> > +     if (state & GPU_IRQ_MASK_ERROR) {
> > +             address = (u64) gpu_read(pfdev, GPU_FAULT_ADDRESS_HI) << 32;
> > +             address |= gpu_read(pfdev, GPU_FAULT_ADDRESS_LO);
> > +
> > +             dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
> > +                      fault_status & 0xFF, panfrost_exception_name(pfdev, fault_status),
> > +                      address);
> > +
> > +             if (state & GPU_IRQ_MULTIPLE_FAULT)
> > +                     dev_warn(pfdev->dev, "There were multiple GPU faults - some have not been reported\n");
> > +
> > +             gpu_write(pfdev, GPU_INT_MASK, 0);
>
> Do you intend to mask off future GPU interrupts?

Yes, maybe?

If we fault here, then we are going to reset the gpu on timeout which
then re-enables interrupts.


> > +static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
> > +{
> > +     struct panfrost_device *pfdev = data;
> > +     u32 status = job_read(pfdev, JOB_INT_STAT);
> > +     int j;
> > +
> > +     dev_dbg(pfdev->dev, "jobslot irq status=%x\n", status);
> > +
> > +     if (!status)
> > +             return IRQ_NONE;
> > +
> > +     pm_runtime_mark_last_busy(pfdev->dev);
> > +
> > +     for (j = 0; status; j++) {
> > +             u32 mask = MK_JS_MASK(j);
> > +
> > +             if (!(status & mask))
> > +                     continue;
> > +
> > +             job_write(pfdev, JOB_INT_CLEAR, mask);
> > +
> > +             if (status & JOB_INT_MASK_ERR(j)) {
> > +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
> > +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
>
> Hard-stopping an already completed job isn't likely to do very much :)
> Also you are using the "_0" version which is only valid when "job chain
> disambiguation" is present.
>
> I suspect in this case you should also be signalling the fence? At the
> moment you rely on the GPU timeout recovering from the fault.

I'll defer to Tomeu who wrote this (IIRC).


> > +static void lock_region(struct panfrost_device *pfdev, u32 as_nr,
> > +                     u64 iova, size_t size)
> > +{
> > +     u8 region_width;
> > +     u64 region = iova & PAGE_MASK;
> > +     /*
> > +      * fls returns (given the ASSERT above):
>
> But where's the assert? :p
>
> > +      * 1 .. 32
> > +      *
> > +      * 10 + fls(num_pages)
> > +      * results in the range (11 .. 42)
> > +      */
> > +
> > +     size = round_up(size, PAGE_SIZE);
>
> I'm not sure it matters, but this will break if called on a (small, i.e.
> less than a page) region spanning two pages. "region" will be rounded
> down to the page (iova & PAGE_MASK), but size will only be rounded up to
> the nearest page. This can miss the start of the second page.

This is probably redundant. Everything the driver does with memory is
in units of pages. Maybe imported buffers could be unaligned. Not sure
and we'd probably break in other places if that was the case.


> > +             /* terminal fault, print info about the fault */
> > +             dev_err(pfdev->dev,
> > +                     "Unhandled Page fault in AS%d at VA 0x%016llX\n"
> > +                     "Reason: %s\n"
> > +                     "raw fault status: 0x%X\n"
> > +                     "decoded fault status: %s\n"
> > +                     "exception type 0x%X: %s\n"
> > +                     "access type 0x%X: %s\n"
> > +                     "source id 0x%X\n",
> > +                     i, addr,
> > +                     "TODO",
> > +                     fault_status,
> > +                     (fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> > +                     exception_type, panfrost_exception_name(pfdev, exception_type),
> > +                     access_type, access_type_name(pfdev, fault_status),
> > +                     source_id);
> > +
> > +             mmu_write(pfdev, MMU_INT_CLEAR, mask);
>
> To fully handle the fault you will need to issue an MMU command (i.e.
> call mmu_hw_do_operation()) - obviously after doing something to fix the
> cause (e.g. mapping a page or switching the GPU to UNMAPPED mode to kill
> off the job). Otherwise you may see that the GPU hangs. Although in
> practice at this stage of the driver the generic timeout is probably the
> simplest way of handling an MMU fault.

Any fault currently is unexpected so all we really care about at this
point is getting a message.


> > +/**
> > + * struct drm_panfrost_create_bo - ioctl argument for creating Panfrost BOs.
> > + *
> > + * There are currently no values for the flags argument, but it may be
> > + * used in a future extension.
>
> You are probably going to want flags for at least:
>
>  * No execute/No read/No write (good for security, especially with
> buffer sharing between processes)
>
>  * Alignment (shader programs have quite strict alignment requirements,
> I believe kbase just ensures that the shader memory block doesn't cross
> a 16MB boundary which covers most cases).
>
>  * Page fault behaviour (kbase has GROW_ON_GPF)
>
>  * Coherency management

Yep, will add them as needed.

> One issue that I haven't got to the bottom of is that I can trigger a
> lockdep splat:
>
> -----8<------
> panfrost ffa30000.gpu: js fault, js=1, status=JOB_CONFIG_FAULT,
> head=0x0, tail=0x0
> root@debian:~/ddk_panfrost# panfrost ffa30000.gpu: gpu sched timeout,
> js=1, status=0x40, head=0x0, tail=0x0, sched_job=12a94ba6
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.0.0+ #32 Not tainted
> ------------------------------------------------------
> kworker/1:0/608 is trying to acquire lock:
> 89b1e2d8 (&(&js->job_lock)->rlock){-.-.}, at:
> dma_fence_remove_callback+0x14/0x50
>
> but task is already holding lock:
> a887e4b2 (&(&sched->job_list_lock)->rlock){-.-.}, at:
> drm_sched_stop+0x24/0x10c
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&(&sched->job_list_lock)->rlock){-.-.}:
>        drm_sched_process_job+0x60/0x208
>        dma_fence_signal+0x1dc/0x1fc
>        panfrost_job_irq_handler+0x160/0x194
>        __handle_irq_event_percpu+0x80/0x388
>        handle_irq_event_percpu+0x24/0x78
>        handle_irq_event+0x38/0x5c
>        handle_fasteoi_irq+0xb4/0x128
>        generic_handle_irq+0x18/0x28
>        __handle_domain_irq+0xa0/0xb4
>        gic_handle_irq+0x4c/0x78
>        __irq_svc+0x70/0x98
>        arch_cpu_idle+0x20/0x3c
>        arch_cpu_idle+0x20/0x3c
>        do_idle+0x11c/0x22c
>        cpu_startup_entry+0x18/0x20
>        start_kernel+0x398/0x420
>
> -> #0 (&(&js->job_lock)->rlock){-.-.}:
>        _raw_spin_lock_irqsave+0x50/0x64
>        dma_fence_remove_callback+0x14/0x50
>        drm_sched_stop+0x5c/0x10c
>        panfrost_job_timedout+0xd0/0x180
>        drm_sched_job_timedout+0x34/0x5c
>        process_one_work+0x2ac/0x6a4
>        worker_thread+0x28c/0x3fc
>        kthread+0x13c/0x158
>        ret_from_fork+0x14/0x20
>          (null)
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&sched->job_list_lock)->rlock);
>                                lock(&(&js->job_lock)->rlock);
>                                lock(&(&sched->job_list_lock)->rlock);
>   lock(&(&js->job_lock)->rlock);
>
>  *** DEADLOCK ***
>
> 3 locks held by kworker/1:0/608:
>  #0: 9b350627 ((wq_completion)"events"){+.+.}, at:
> process_one_work+0x1f8/0x6a4
>  #1: a802aa2d ((work_completion)(&(&sched->work_tdr)->work)){+.+.}, at:
> process_one_work+0x1f8/0x6a4
>  #2: a887e4b2 (&(&sched->job_list_lock)->rlock){-.-.}, at:
> drm_sched_stop+0x24/0x10c
>
> stack backtrace:
> CPU: 1 PID: 608 Comm: kworker/1:0 Not tainted 5.0.0+ #32
> Hardware name: Rockchip (Device Tree)
> Workqueue: events drm_sched_job_timedout
> [<c0111088>] (unwind_backtrace) from [<c010c9a8>] (show_stack+0x10/0x14)
> [<c010c9a8>] (show_stack) from [<c0773df4>] (dump_stack+0x9c/0xd4)
> [<c0773df4>] (dump_stack) from [<c016d034>]
> (print_circular_bug.constprop.15+0x1fc/0x2cc)
> [<c016d034>] (print_circular_bug.constprop.15) from [<c016f6c0>]
> (__lock_acquire+0xe5c/0x167c)
> [<c016f6c0>] (__lock_acquire) from [<c0170828>] (lock_acquire+0xc4/0x210)
> [<c0170828>] (lock_acquire) from [<c07920e0>]
> (_raw_spin_lock_irqsave+0x50/0x64)
> [<c07920e0>] (_raw_spin_lock_irqsave) from [<c0516784>]
> (dma_fence_remove_callback+0x14/0x50)
> [<c0516784>] (dma_fence_remove_callback) from [<c04def38>]
> (drm_sched_stop+0x5c/0x10c)
> [<c04def38>] (drm_sched_stop) from [<c04ec80c>]
> (panfrost_job_timedout+0xd0/0x180)
> [<c04ec80c>] (panfrost_job_timedout) from [<c04df340>]
> (drm_sched_job_timedout+0x34/0x5c)
> [<c04df340>] (drm_sched_job_timedout) from [<c013ec70>]
> (process_one_work+0x2ac/0x6a4)
> [<c013ec70>] (process_one_work) from [<c013fe48>]
> (worker_thread+0x28c/0x3fc)
> [<c013fe48>] (worker_thread) from [<c01452a0>] (kthread+0x13c/0x158)
> [<c01452a0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xeebd7fb0 to 0xeebd7ff8)
> 7fa0:                                     00000000 00000000 00000000
> 00000000
> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ----8<----
>
> This is with the below simple reproducer:
>
> ----8<----
> #include <sys/ioctl.h>
> #include <fcntl.h>
> #include <stdio.h>
>
> #include <libdrm/drm.h>
> #include "panfrost_drm.h"
>
> int main(int argc, char **argv)
> {
>         int fd;
>
>         if (argc == 2)
>                 fd = open(argv[1], O_RDWR);
>         else
>                 fd = open("/dev/dri/renderD128", O_RDWR);
>         if (fd == -1) {
>                 perror("Failed to open");
>                 return 0;
>         }
>
>         struct drm_panfrost_submit submit = {
>                 .jc = 0,
>         };
>         return ioctl(fd, DRM_IOCTL_PANFROST_SUBMIT, &submit);
> }
> ----8<----
>
> Any ideas? I'm not an expert on DRM, so I got somewhat lost!

Tomeu?

Rob
