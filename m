Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F42133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfDJKUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:20:00 -0400
Received: from foss.arm.com ([217.140.101.70]:51268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfDJKT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:19:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F9015AB;
        Wed, 10 Apr 2019 03:19:58 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09C523F59C;
        Wed, 10 Apr 2019 03:19:55 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b52052a3-141e-d6fd-f99a-9f7ddb611d96@arm.com>
Date:   Wed, 10 Apr 2019 11:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 22:04, Rob Herring wrote:
> On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
>>
>> On 01/04/2019 08:47, Rob Herring wrote:
>>> This adds the initial driver for panfrost which supports Arm Mali
>>> Midgard and Bifrost family of GPUs. Currently, only the T860 and
>>> T760 Midgard GPUs have been tested.
> 
> [...]
> 
>>> +     case 0xD3: return "TRANSTAB_BUS_FAULT_LEVEL3";
>>> +     case 0xD4: return "TRANSTAB_BUS_FAULT_LEVEL4";
>>> +     case 0xD8: return "ACCESS_FLAG";
>>> +     }
>>> +
>>> +     if (panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
>>
>> There's not a great deal of point in this conditional - you won't get
>> the below exception codes from hardware which doesn't support it AARCH64
>> page tables.
> 
> I wasn't sure if "UNKNOWN" types could happen or not.
> 
>>
>>> +             switch (exception_code) {
>>> +             case 0xC9 ... 0xCF: return "PERMISSION_FAULT";
>>> +             case 0xD9 ... 0xDF: return "ACCESS_FLAG";
>>> +             case 0xE0 ... 0xE7: return "ADDRESS_SIZE_FAULT";
>>> +             case 0xE8 ... 0xEF: return "MEMORY_ATTRIBUTES_FAULT";
>>> +             }
>>> +     }
>>> +
>>> +     return "UNKNOWN";
>>> +}
> 
>>> +static inline int panfrost_model_cmp(struct panfrost_device *pfdev, s32 id)
>>> +{
>>> +     s32 match_id = pfdev->features.id;
>>> +
>>> +     if (match_id & 0xf000)
>>> +             match_id &= 0xf00f;
>>
>> I'm puzzled by this, and really not sure if it's going to work out
>> ignoring the ARCH_MINOR/ARCH_REV fields. But for now there's no real
>> Bifrost support.
> 
> That seemed to be enough for kbase to select features/issues.

I can't deny that it seems to work for now, and indeed looking more
closely at kbase that does seem to be the effect of the current code.

>>> +     switch (param->param) {
>>> +     case DRM_PANFROST_PARAM_GPU_ID:
>>> +             param->value = pfdev->features.id;
>>
>> This is unfortunate naming - this parameter is *not* the GPU_ID. It is
>> the top half of the GPU_ID which kbase calls the PRODUCT_ID.
> 
> I can rename it.

It would help prevent confusion, thanks!

>> I'm also somewhat surprised that you don't need loads of other
>> properties from the GPU - in particular knowing the number of shader
>> cores is useful for allocating the right amount of memory for TLS (and
>> can't be obtained purely from the GPU_ID).
> 
> We'll add them as userspace needs them.

Fair enough. I'm not sure how much you want to provide "forward
compatibility" by providing them early - the basic definitions are
already in kbase. I found it a bit surprising that some feature
registers are printed on probe, but not available to be queried.

>>> +static int
>>> +panfrost_lookup_bos(struct drm_device *dev,
>>> +               struct drm_file *file_priv,
>>> +               struct drm_panfrost_submit *args,
>>> +               struct panfrost_job *job)
>>> +{
>>> +     u32 *handles;
>>> +     int ret = 0;
>>> +
>>> +     job->bo_count = args->bo_handle_count;
>>> +
>>> +     if (!job->bo_count)
>>> +             return 0;
>>> +
>>> +     job->bos = kvmalloc_array(job->bo_count,
>>> +                               sizeof(struct drm_gem_object *),
>>> +                               GFP_KERNEL | __GFP_ZERO);
>>> +     if (!job->bos)
>>
>> If we return here then job->bo_count has been set, but job->bos is
>> invalid - this means that panfrost_job_cleanup() will then dereference
>> NULL. Although maybe this is better fixed in panfrost_job_cleanup().
> 
> Good catch. The fence arrays have the same problem. As does V3D which we copied.
> 
>>> +             return -ENOMEM;
>>> +
>>> +     job->implicit_fences = kvmalloc_array(job->bo_count,
>>> +                               sizeof(struct dma_fence *),
>>> +                               GFP_KERNEL | __GFP_ZERO);
>>> +     if (!job->implicit_fences)
>>> +             return -ENOMEM;
> 
>>> +static irqreturn_t panfrost_gpu_irq_handler(int irq, void *data)
>>> +{
>>> +     struct panfrost_device *pfdev = data;
>>> +     u32 state = gpu_read(pfdev, GPU_INT_STAT);
>>> +     u32 fault_status = gpu_read(pfdev, GPU_FAULT_STATUS);
>>> +     u64 address;
>>> +     bool done = false;
>>> +
>>> +     if (!state)
>>> +             return IRQ_NONE;
>>> +
>>> +     if (state & GPU_IRQ_MASK_ERROR) {
>>> +             address = (u64) gpu_read(pfdev, GPU_FAULT_ADDRESS_HI) << 32;
>>> +             address |= gpu_read(pfdev, GPU_FAULT_ADDRESS_LO);
>>> +
>>> +             dev_warn(pfdev->dev, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
>>> +                      fault_status & 0xFF, panfrost_exception_name(pfdev, fault_status),
>>> +                      address);
>>> +
>>> +             if (state & GPU_IRQ_MULTIPLE_FAULT)
>>> +                     dev_warn(pfdev->dev, "There were multiple GPU faults - some have not been reported\n");
>>> +
>>> +             gpu_write(pfdev, GPU_INT_MASK, 0);
>>
>> Do you intend to mask off future GPU interrupts?
> 
> Yes, maybe?
> 
> If we fault here, then we are going to reset the gpu on timeout which
> then re-enables interrupts.

Well fair enough. But there's no actual need to force a GPU reset.
Really there's nothing you can do other than report a GPU fault. kbase
simply reports it and otherwise ignores it (no GPU reset).

Also will you actually trigger the GPU timeout? This won't mask of the
JOB completion IRQ, so jobs can still complete.

When you integrate other GPU irq sources (counters/power management)
then you almost certainly don't want to mask those off just because of a
GPU fault.

>>> +static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
>>> +{
>>> +     struct panfrost_device *pfdev = data;
>>> +     u32 status = job_read(pfdev, JOB_INT_STAT);
>>> +     int j;
>>> +
>>> +     dev_dbg(pfdev->dev, "jobslot irq status=%x\n", status);
>>> +
>>> +     if (!status)
>>> +             return IRQ_NONE;
>>> +
>>> +     pm_runtime_mark_last_busy(pfdev->dev);
>>> +
>>> +     for (j = 0; status; j++) {
>>> +             u32 mask = MK_JS_MASK(j);
>>> +
>>> +             if (!(status & mask))
>>> +                     continue;
>>> +
>>> +             job_write(pfdev, JOB_INT_CLEAR, mask);
>>> +
>>> +             if (status & JOB_INT_MASK_ERR(j)) {
>>> +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
>>> +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
>>
>> Hard-stopping an already completed job isn't likely to do very much :)
>> Also you are using the "_0" version which is only valid when "job chain
>> disambiguation" is present.
>>
>> I suspect in this case you should also be signalling the fence? At the
>> moment you rely on the GPU timeout recovering from the fault.
> 
> I'll defer to Tomeu who wrote this (IIRC).
> 
> 
>>> +static void lock_region(struct panfrost_device *pfdev, u32 as_nr,
>>> +                     u64 iova, size_t size)
>>> +{
>>> +     u8 region_width;
>>> +     u64 region = iova & PAGE_MASK;
>>> +     /*
>>> +      * fls returns (given the ASSERT above):
>>
>> But where's the assert? :p
>>
>>> +      * 1 .. 32
>>> +      *
>>> +      * 10 + fls(num_pages)
>>> +      * results in the range (11 .. 42)
>>> +      */
>>> +
>>> +     size = round_up(size, PAGE_SIZE);
>>
>> I'm not sure it matters, but this will break if called on a (small, i.e.
>> less than a page) region spanning two pages. "region" will be rounded
>> down to the page (iova & PAGE_MASK), but size will only be rounded up to
>> the nearest page. This can miss the start of the second page.
> 
> This is probably redundant. Everything the driver does with memory is
> in units of pages. Maybe imported buffers could be unaligned. Not sure
> and we'd probably break in other places if that was the case.

Yes I don't think this case will occur at the moment. I just noticed it
because the interface was changed from kbase (kbase passes in a page
offset, this version uses a byte offset).

>>> +             /* terminal fault, print info about the fault */
>>> +             dev_err(pfdev->dev,
>>> +                     "Unhandled Page fault in AS%d at VA 0x%016llX\n"
>>> +                     "Reason: %s\n"
>>> +                     "raw fault status: 0x%X\n"
>>> +                     "decoded fault status: %s\n"
>>> +                     "exception type 0x%X: %s\n"
>>> +                     "access type 0x%X: %s\n"
>>> +                     "source id 0x%X\n",
>>> +                     i, addr,
>>> +                     "TODO",
>>> +                     fault_status,
>>> +                     (fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
>>> +                     exception_type, panfrost_exception_name(pfdev, exception_type),
>>> +                     access_type, access_type_name(pfdev, fault_status),
>>> +                     source_id);
>>> +
>>> +             mmu_write(pfdev, MMU_INT_CLEAR, mask);
>>
>> To fully handle the fault you will need to issue an MMU command (i.e.
>> call mmu_hw_do_operation()) - obviously after doing something to fix the
>> cause (e.g. mapping a page or switching the GPU to UNMAPPED mode to kill
>> off the job). Otherwise you may see that the GPU hangs. Although in
>> practice at this stage of the driver the generic timeout is probably the
>> simplest way of handling an MMU fault.
> 
> Any fault currently is unexpected so all we really care about at this
> point is getting a message.

No problem. It will become relevant when you schedule work from multiple
applications at the same time.

[...]
>>
>> This is with the below simple reproducer:
>>
>> ----8<----
>> #include <sys/ioctl.h>
>> #include <fcntl.h>
>> #include <stdio.h>
>>
>> #include <libdrm/drm.h>
>> #include "panfrost_drm.h"
>>
>> int main(int argc, char **argv)
>> {
>>         int fd;
>>
>>         if (argc == 2)
>>                 fd = open(argv[1], O_RDWR);
>>         else
>>                 fd = open("/dev/dri/renderD128", O_RDWR);
>>         if (fd == -1) {
>>                 perror("Failed to open");
>>                 return 0;
>>         }
>>
>>         struct drm_panfrost_submit submit = {
>>                 .jc = 0,
>>         };
>>         return ioctl(fd, DRM_IOCTL_PANFROST_SUBMIT, &submit);
>> }
>> ----8<----
>>
>> Any ideas? I'm not an expert on DRM, so I got somewhat lost!

Interestingly this actually looks similar to this bug for amdgpu:

https://bugs.freedesktop.org/show_bug.cgi?id=109692

There's a patch on there changing the drm scheduler which might be
relevant. I haven't had chance to try it out.

Steve
