Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05608CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1A32080F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRH7Xz/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfKCQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:02:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfKCQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:02:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so10470625pfp.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7sWMPxjMogbNdVChwCfU5TwyajZHKLbfHqaOEelOtrA=;
        b=CRH7Xz/W55tPqb/Ku5GSyawEDhcr4nwZu90YigT6PqzdTCYkeMIFvWWlo4RMb858ZH
         8tBeTZe/L9QsY+FtJH6i4wtbFv2WqwwPEp0PodFkogt/GwzOmp22upyD5ILLy+LVFY0T
         Jlqara+Z5zJ6sAP4HS84RWZYgSg2NshxMDxe4HDYIcASC49k9pGFtEdICNJHG5nt4EO4
         eNrgsFZsgcthr7fihIfroiAS6g1FtsFoyQ+wB+w6tR9KHqg3FhhbqD9f9xc0Eb0ii3H9
         PClL+2o6yAdKFb8/xAwmgiN15QskUtaROPgzZ4tFzaqVOaby2K4iKjYdHAevAwV5JRzt
         yqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7sWMPxjMogbNdVChwCfU5TwyajZHKLbfHqaOEelOtrA=;
        b=Pqf8grAau6dOl5a1L/IHiNVTBQLXL5457hJrkQVOhofreHes5vyqIMfsXIdzIfHThn
         u937suv/RTwWid1Iko2J8TOC66Qg1mhfulvZ15ORUAVdOCtrF9aIDIpRvsWjmOw4gsY9
         VOgYHiNGxc7z6BOlfEZF2uHhUA96l86LBcx06bhJtMBG53csjwIQFkrZfr8PEznJxCYZ
         wC52M5m0OCblTMDb+y+ofAAGPR3FAhQ0FQ8fAnd8FodTtdWdiRZJoSin3RYBQcF1jMZw
         UmNGzIK1TfJcUdoDr/nhdPcRHWpdnj4CASHc74cpLrOVm5p+c7G8B+DUA65bvSnrwp1A
         N49g==
X-Gm-Message-State: APjAAAUmQRKwyUlD30s3iVHoKo53Jdiy1VEHRMafKs4bwAcYz1Q15ohl
        +YvmOAeSow0FJUAut8RPUvO9GQ==
X-Google-Smtp-Source: APXvYqzA7QdHuXrCTyyKnKuHqvn6wHDbYYvz0ZYdM6XkIpJ4kegFQfJQIWXxdaX+U9bluZX4o88EJg==
X-Received: by 2002:a63:5406:: with SMTP id i6mr23453227pgb.1.1572796952128;
        Sun, 03 Nov 2019 08:02:32 -0800 (PST)
Received: from sspatil-glaptop2.roam.corp.google.com ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id 3sm13877845pfh.45.2019.11.03.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:02:31 -0800 (PST)
Date:   Sun, 3 Nov 2019 08:02:25 -0800
From:   sspatil@google.com
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org, afd@ti.com,
        labbott@redhat.com, benjamin.gaignard@linaro.org,
        sumit.semwal@linaro.org, lmark@codeaurora.org,
        pratikp@codeaurora.org, Brian.Starkey@arm.com,
        Vincent.Donnefort@arm.com, Sudipto.Paul@arm.com, hch@infradead.org,
        fengc@google.com, astrachan@google.com, hridya@google.com,
        hdanton@sina.com, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, sspatil+mutt@google.com
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
Message-ID: <20191103160225.GA13344@google.com>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101214238.78015-2-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks a lot for doing this. I really hope we get to move to dmabuf based
heaps and away from ion for Android soon. One of the nice things this
implementation will give us is also to add granular SELinux based controls on
which components / processes of android get to allocate from a pre-defined,
generic set of heaps.


On Fri, Nov 01, 2019 at 09:42:34PM +0000, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> This framework allows a unified userspace interface for dma-buf
> exporters, allowing userland to allocate specific types of memory
> for use in dma-buf sharing.
> 
> Each heap is given its own device node, which a user can allocate
> a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
> 
> Additionally should the interface grow in the future, we have a
> DMA_HEAP_IOC_GET_FEATURES ioctl which can return future feature
> flags.
> 
> This code is an evoluiton of the Android ION implementation,
> and a big thanks is due to its authors/maintainers over time
> for their effort:
>   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
>   Laura Abbott, and many other contributors!
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

I have a couple of nits below and one question about how you expect the
features check to work for uninitialized user space variables

Other than that, this LGTM.

Please feel free to add if you end up re-spinning this.

Acked-by: Sandeep Patil <sspatil@android.com>

> ---
> v2:
> * Folded down fixes I had previously shared in implementing
>   heaps
> * Make flags a u64 (Suggested by Laura)
> * Add PAGE_ALIGN() fix to the core alloc funciton
> * IOCTL fixups suggested by Brian
> * Added fixes suggested by Benjamin
> * Removed core stats mgmt, as that should be implemented by
>   per-heap code
> * Changed alloc to return a dma-buf fd, rather than a buffer
>   (as it simplifies error handling)
> v3:
> * Removed scare-quotes in MAINTAINERS email address
> * Get rid of .release function as it didn't do anything (from
>   Christoph)
> * Renamed filp to file (suggested by Christoph)
> * Split out ioctl handling to separate function (suggested by
>   Christoph)
> * Add comment documenting PAGE_ALIGN usage (suggested by Brian)
> * Switch from idr to Xarray (suggested by Brian)
> * Fixup cdev creation (suggested by Brian)
> * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
>   Brian)
> * Make struct dma_heap internal only (folded in from Andrew)
> * Small cleanups suggested by GregKH
> * Provide class->devnode callback to get consistent /dev/
>   subdirectory naming (Suggested by Bjorn)
> v4:
> * Folded down dma-heap.h change that was in a following patch
> * Added fd_flags entry to allocation structure and pass it
>   through to heap code for use on dma-buf fd creation (suggested
>   by Benjamin)
> v5:
> * Minor cleanups
> v6:
> * Improved error path handling, minor whitespace fixes, both
>   suggested by Brian
> v7:
> * Longer Kconfig description to quiet checkpatch warnings
> * Re-add compat_ioctl bits (Hridya noticed 32bit userland wasn't
>   working)
> v8:
> * Make struct dma_heap_ops consts (Suggested by Christoph)
> * Checkpatch whitespace fixups
> v9:
> * Minor cleanups suggested by Brian Starkey
> * Rename dma_heap_get_data->dma_heap_get_drvdata suggested
>   by Hilf Danton
> v11:
> * Kconfig text improvements suggested by Randy Dunlap
> v12:
> * Add logic to prevent duplicately named heaps being added
> * Add symbol exports for heaps as modules
> v13:
> * Re-remove symbol exports per discussion w/ Brian. Will
>   resubmit in a separte patch for review
> v14:
> * Reworked ioctl handler to zero fill any difference in
>   structure size, similar to what the DRM core does, as
>   suggested by Dave Airlie
> * Removed now unnecessary reserved bits in allocate_data
> * Added get_features ioctl as suggested by Dave Airlie
> * Removed pr_warn_once messages as requested by Dave
>   Airlie
> ---
>  MAINTAINERS                   |  18 ++
>  drivers/dma-buf/Kconfig       |   9 +
>  drivers/dma-buf/Makefile      |   1 +
>  drivers/dma-buf/dma-heap.c    | 313 ++++++++++++++++++++++++++++++++++
>  include/linux/dma-heap.h      |  59 +++++++
>  include/uapi/linux/dma-heap.h |  77 +++++++++
>  6 files changed, 477 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6c34d04ce95..77c3e993fb2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4940,6 +4940,24 @@ F:	include/linux/*fence.h
>  F:	Documentation/driver-api/dma-buf.rst
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
> +DMA-BUF HEAPS FRAMEWORK
> +M:	Sumit Semwal <sumit.semwal@linaro.org>
> +R:	Andrew F. Davis <afd@ti.com>
> +R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
> +R:	Liam Mark <lmark@codeaurora.org>
> +R:	Laura Abbott <labbott@redhat.com>
> +R:	Brian Starkey <Brian.Starkey@arm.com>
> +R:	John Stultz <john.stultz@linaro.org>
> +S:	Maintained
> +L:	linux-media@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> +F:	include/uapi/linux/dma-heap.h
> +F:	include/linux/dma-heap.h
> +F:	drivers/dma-buf/dma-heap.c
> +F:	drivers/dma-buf/heaps/*
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +
>  DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
>  M:	Vinod Koul <vkoul@kernel.org>
>  L:	dmaengine@vger.kernel.org
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index a23b6752d11a..bffa58fc3e6e 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -44,4 +44,13 @@ config DMABUF_SELFTESTS
>  	default n
>  	depends on DMA_SHARED_BUFFER
>  

nit: whitespace
> +menuconfig DMABUF_HEAPS
> +	bool "DMA-BUF Userland Memory Heaps"
> +	select DMA_SHARED_BUFFER
> +	help
> +	  Choose this option to enable the DMA-BUF userland memory heaps.
> +	  This options creates per heap chardevs in /dev/dma_heap/ which
> +	  allows userspace to allocate dma-bufs that can be shared
> +	  between drivers.
> +
>  endmenu
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index 03479da06422..caee5eb3d351 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
>  	 dma-resv.o seqno-fence.o
> +obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
>  obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
>  obj-$(CONFIG_UDMABUF)		+= udmabuf.o
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> new file mode 100644
> index 000000000000..7cdd7179e5fa
> --- /dev/null
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Framework for userspace DMA-BUF allocations
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/xarray.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/syscalls.h>
> +#include <linux/dma-heap.h>
> +#include <uapi/linux/dma-heap.h>
> +
> +#define DEVNAME "dma_heap"
> +
> +#define NUM_HEAP_MINORS 128
> +
> +/**
> + * struct dma_heap - represents a dmabuf heap in the system
> + * @name:		used for debugging/device-node name
> + * @ops:		ops struct for this heap
> + * @minor		minor number of this heap device
> + * @heap_devt		heap device node
> + * @heap_cdev		heap char device
> + *
> + * Represents a heap of memory from which buffers can be made.
> + */
> +struct dma_heap {
> +	const char *name;
> +	const struct dma_heap_ops *ops;
> +	void *priv;
> +	unsigned int minor;
nit: do you need this one in the presence of the heap_devt below?
'minor' can just as easily by a local in the dmabuf_heap_add() function
below and for any code that comes after, we can extract it from 'heap_devt'.
> +	dev_t heap_devt;
> +	struct list_head list;
nit: what is the list for? May be a different name and a comment above
will be nice?
> +	struct cdev heap_cdev;
> +};
> +
> +static LIST_HEAD(heap_list);
> +static DEFINE_MUTEX(heap_list_lock);
> +static dev_t dma_heap_devt;
> +static struct class *dma_heap_class;
> +static DEFINE_XARRAY_ALLOC(dma_heap_minors);
> +
> +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				 unsigned int fd_flags,
> +				 unsigned int heap_flags)
> +{
> +	/*
> +	 * Allocations from all heaps have to begin
> +	 * and end on page boundaries.
> +	 */
> +	len = PAGE_ALIGN(len);
> +	if (!len)
> +		return -EINVAL;
> +
> +	return heap->ops->allocate(heap, len, fd_flags, heap_flags);
> +}
> +
> +static int dma_heap_open(struct inode *inode, struct file *file)
> +{
> +	struct dma_heap *heap;
> +
> +	heap = xa_load(&dma_heap_minors, iminor(inode));
> +	if (!heap) {
> +		pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
> +		return -ENODEV;
> +	}
> +
> +	/* instance data as context */
> +	file->private_data = heap;
> +	nonseekable_open(inode, file);
> +
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl_get_features(struct file *file, void *data)
> +{
> +	struct dma_heap_get_features_data *heap_features = data;
> +
> +	/* nothing should be passed in */
> +	if (heap_features->features)
> +		return -EINVAL;

curious, what are we trying to protect here? Unless I misunderstood this, you
are forcing userspace to 0 initialize the structure passed into the ioctl.
So an uninitialized stack variable passed into ioctl() will end up returning
-EINVAL .. I am not sure thats ok?

Plus, the point is pointing into the kmalloc'ed memory or the local 'char
stack_data[128] from the ioctl() function, so not sure if this check was
intentional? If so, may be easier to 0 initialize *kdata in the ioctl
function below?
> +
> +	heap_features->features = DMA_HEAP_SUPPORTED_FEATURES;
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl_allocate(struct file *file, void *data)
> +{
> +	struct dma_heap_allocation_data *heap_allocation = data;
> +	struct dma_heap *heap = file->private_data;
> +	int fd;
> +
> +	if (heap_allocation->fd)
> +		return -EINVAL;
> +
> +	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
> +		return -EINVAL;
> +
> +	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> +		return -EINVAL;
> +
> +	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
> +				   heap_allocation->fd_flags,
> +				   heap_allocation->heap_flags);
> +	if (fd < 0)
> +		return fd;
> +
> +	heap_allocation->fd = fd;
> +
> +	return 0;
> +}
> +
> +unsigned int dma_heap_ioctl_cmds[] = {
> +	DMA_HEAP_IOC_GET_FEATURES,
> +	DMA_HEAP_IOC_ALLOC,
> +};
> +
> +static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
> +			   unsigned long arg)
> +{
> +	char stack_kdata[128];
> +	char *kdata = stack_kdata;
> +	unsigned int kcmd;
> +	unsigned int in_size, out_size, drv_size, ksize;
> +	int nr = _IOC_NR(ucmd);
> +	int ret = 0;
> +
> +	if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
> +		return -EINVAL;
> +
> +	/* Get the kernel ioctl cmd that matches */
> +	kcmd = dma_heap_ioctl_cmds[nr];
> +
> +	/* Figure out the delta between user cmd size and kernel cmd size */
> +	drv_size = _IOC_SIZE(kcmd);
> +	out_size = _IOC_SIZE(ucmd);
> +	in_size = out_size;
> +	if ((ucmd & kcmd & IOC_IN) == 0)
> +		in_size = 0;
> +	if ((ucmd & kcmd & IOC_OUT) == 0)
> +		out_size = 0;
> +	ksize = max(max(in_size, out_size), drv_size);
> +
> +	/* If necessary, allocate buffer for ioctl argument */
> +	if (ksize > sizeof(stack_kdata)) {
> +		kdata = kmalloc(ksize, GFP_KERNEL);
> +		if (!kdata)
> +			return -ENOMEM;
> +	}
> +
> +	if (copy_from_user(kdata, (void __user *)arg, in_size) != 0) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	/* zero out any difference between the kernel/user structure size */
> +	if (ksize > in_size)
> +		memset(kdata + in_size, 0, ksize - in_size);
> +
> +	switch (kcmd) {
> +	case DMA_HEAP_IOC_GET_FEATURES:
> +		ret = dma_heap_ioctl_get_features(file, kdata);
> +		break;
> +	case DMA_HEAP_IOC_ALLOC:
> +		ret = dma_heap_ioctl_allocate(file, kdata);
> +		break;
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
> +		ret = -EFAULT;
> +err:
> +	if (kdata != stack_kdata)
> +		kfree(kdata);
> +	return ret;
> +}
> +
> +static const struct file_operations dma_heap_fops = {
> +	.owner          = THIS_MODULE,
> +	.open		= dma_heap_open,
> +	.unlocked_ioctl = dma_heap_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= dma_heap_ioctl,
> +#endif
> +};
> +
> +/**
> + * dma_heap_get_drvdata() - get per-subdriver data for the heap
> + * @heap: DMA-Heap to retrieve private data for
> + *
> + * Returns:
> + * The per-subdriver data for the heap.
> + */
> +void *dma_heap_get_drvdata(struct dma_heap *heap)
> +{
> +	return heap->priv;
> +}
> +
> +struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
> +{
> +	struct dma_heap *heap, *h, *err_ret;
> +	struct device *dev_ret;
> +	int ret;
> +
> +	if (!exp_info->name || !strcmp(exp_info->name, "")) {
> +		pr_err("dma_heap: Cannot add heap without a name\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!exp_info->ops || !exp_info->ops->allocate) {
> +		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* check the name is unique */
> +	mutex_lock(&heap_list_lock);
> +	list_for_each_entry(h, &heap_list, list) {
> +		if (!strcmp(h->name, exp_info->name)) {
> +			mutex_unlock(&heap_list_lock);
> +			pr_err("dma_heap: Already registered heap named %s\n",
> +			       exp_info->name);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +	mutex_unlock(&heap_list_lock);
> +
> +	heap = kzalloc(sizeof(*heap), GFP_KERNEL);
> +	if (!heap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	heap->name = exp_info->name;
> +	heap->ops = exp_info->ops;
> +	heap->priv = exp_info->priv;
> +
> +	/* Find unused minor number */
> +	ret = xa_alloc(&dma_heap_minors, &heap->minor, heap,
> +		       XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to get minor number for heap\n");
> +		err_ret = ERR_PTR(ret);
> +		goto err0;
> +	}
> +
> +	/* Create device */
> +	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
> +
> +	cdev_init(&heap->heap_cdev, &dma_heap_fops);
> +	ret = cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to add char device\n");
> +		err_ret = ERR_PTR(ret);
> +		goto err1;
> +	}
> +
> +	dev_ret = device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);
> +	if (IS_ERR(dev_ret)) {
> +		pr_err("dma_heap: Unable to create device\n");
> +		err_ret = ERR_CAST(dev_ret);
> +		goto err2;
> +	}
> +	/* Add heap to the list */
> +	mutex_lock(&heap_list_lock);
> +	list_add(&heap->list, &heap_list);
> +	mutex_unlock(&heap_list_lock);
> +
> +	return heap;
> +
> +err2:
> +	cdev_del(&heap->heap_cdev);
> +err1:
> +	xa_erase(&dma_heap_minors, heap->minor);
> +err0:
> +	kfree(heap);
> +	return err_ret;
> +}
> +
> +static char *dma_heap_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
> +}
> +
> +static int dma_heap_init(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&dma_heap_devt, 0, NUM_HEAP_MINORS, DEVNAME);
> +	if (ret)
> +		return ret;
> +
> +	dma_heap_class = class_create(THIS_MODULE, DEVNAME);
> +	if (IS_ERR(dma_heap_class)) {
> +		unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> +		return PTR_ERR(dma_heap_class);
> +	}
> +	dma_heap_class->devnode = dma_heap_devnode;
> +
> +	return 0;
> +}
> +subsys_initcall(dma_heap_init);
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> new file mode 100644
> index 000000000000..454e354d1ffb
> --- /dev/null
> +++ b/include/linux/dma-heap.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMABUF Heaps Allocation Infrastructure
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#ifndef _DMA_HEAPS_H
> +#define _DMA_HEAPS_H
> +
> +#include <linux/cdev.h>
> +#include <linux/types.h>
> +
> +struct dma_heap;
> +
> +/**
> + * struct dma_heap_ops - ops to operate on a given heap
> + * @allocate:		allocate dmabuf and return fd
> + *
> + * allocate returns dmabuf fd  on success, -errno on error.
> + */
> +struct dma_heap_ops {
> +	int (*allocate)(struct dma_heap *heap,
> +			unsigned long len,
> +			unsigned long fd_flags,
> +			unsigned long heap_flags);
> +};
> +
> +/**
> + * struct dma_heap_export_info - information needed to export a new dmabuf heap
> + * @name:	used for debugging/device-node name
> + * @ops:	ops struct for this heap
> + * @priv:	heap exporter private data
> + *
> + * Information needed to export a new dmabuf heap.
> + */
> +struct dma_heap_export_info {
> +	const char *name;
> +	const struct dma_heap_ops *ops;
> +	void *priv;
> +};
> +
> +/**
> + * dma_heap_get_drvdata() - get per-heap driver data
> + * @heap: DMA-Heap to retrieve private data for
> + *
> + * Returns:
> + * The per-heap data for the heap.
> + */
> +void *dma_heap_get_drvdata(struct dma_heap *heap);
> +
> +/**
> + * dma_heap_add - adds a heap to dmabuf heaps
> + * @exp_info:		information needed to register this heap
> + */
> +struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info);
> +
> +#endif /* _DMA_HEAPS_H */
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
> new file mode 100644
> index 000000000000..22f620991758
> --- /dev/null
> +++ b/include/uapi/linux/dma-heap.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * DMABUF Heaps Userspace API
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +#ifndef _UAPI_LINUX_DMABUF_POOL_H
> +#define _UAPI_LINUX_DMABUF_POOL_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: DMABUF Heaps Userspace API
> + */
> +
> +#define DMA_HEAP_FEATURE_NONE (0x0)
> +
> +/* Currrently no supported features */
> +#define DMA_HEAP_SUPPORTED_FEATURES (DMA_HEAP_FEATURE_NONE)
> +
> +/**
> + * struct dma_heap_get_features_data - metadata passed from userspace for
> + *                                    getting interface features
> + * @features:		features flag returned from kernel
> + *
> + * Provided by userspace as an argument to the ioctl
> + */
> +struct dma_heap_get_features_data {
> +	__u64 features;
> +};
> +
> +/* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
> +#define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
> +
> +/* Currently no heap flags */
> +#define DMA_HEAP_VALID_HEAP_FLAGS (0)
> +
> +/**
> + * struct dma_heap_allocation_data - metadata passed from userspace for
> + *                                      allocations
> + * @len:		size of the allocation
> + * @fd:			will be populated with a fd which provdes the
> + *			handle to the allocated dma-buf
> + * @fd_flags:		file descriptor flags used when allocating
> + * @heap_flags:		flags passed to heap
> + *
> + * Provided by userspace as an argument to the ioctl
> + */
> +struct dma_heap_allocation_data {
> +	__u64 len;
> +	__u32 fd;
> +	__u32 fd_flags;
> +	__u64 heap_flags;
> +};
> +
> +#define DMA_HEAP_IOC_MAGIC		'H'
> +
> +/**
> + * DOC: DMA_HEAP_IOC_GET_FEATURES - Get interface features
> + *
> + * Takes an dma_heap_features_data struct and returns it with the features
> + * flages set with the interfaces supported features.
> + */
> +#define DMA_HEAP_IOC_GET_FEATURES _IOR(DMA_HEAP_IOC_MAGIC, 0x0,\
> +				       struct dma_heap_get_features_data)
> +/**
> + * DOC: DMA_HEAP_IOC_ALLOC - allocate memory from pool
> + *
> + * Takes an dma_heap_allocation_data struct and returns it with the fd field
> + * populated with the dmabuf handle of the allocation.
> + */
> +#define DMA_HEAP_IOC_ALLOC	_IOWR(DMA_HEAP_IOC_MAGIC, 0x1,\
> +				      struct dma_heap_allocation_data)
> +
> +#endif /* _UAPI_LINUX_DMABUF_POOL_H */
> -- 
> 2.17.1
> 
