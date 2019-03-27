Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5938F20449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711179;
	bh=tp4bs9pLFhnpsVuH8B58KoxTwoBEXKPx9L8+v175Nxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uzocFPlTIaUyAjuvs55+Mrhwa+oqbVr9xlKOxivP3KPHEQ576ZNNwkECKDP9D0v6T
	 hNple5eceiDYvSac523GN8nlt7Bfx9yseSEhj1367f2H+vBeTYfxmWYqvPJ/emQMFe
	 3Cq6AIDplJdONKkdd+5JBy7+DqeI8tiQNvA7B6MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404038AbfC0S0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391222AbfC0SZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:25:59 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480EC21738;
        Wed, 27 Mar 2019 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711158;
        bh=tp4bs9pLFhnpsVuH8B58KoxTwoBEXKPx9L8+v175Nxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddNzBhXOgZ+J4nZzPv798abe0MurYL7AP56toJIFfkmMnoXu09+CmzDL5Jl1BAkOf
         lJggKBHVMTPfWYBbX/LwpEQ6ODVw+pFApywDw8Ivzeo9llzv9VG0ZARHJVY51b28Wm
         h413CnkM9agaiKYkrwqzmkdyhetyEMfl+2HmZmH4=
Date:   Wed, 27 Mar 2019 23:53:54 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
Message-ID: <20190327145354.GA4514@kroah.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551819273-640-2-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 12:54:29PM -0800, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> This framework allows a unified userspace interface for dma-buf
> exporters, allowing userland to allocate specific types of
> memory for use in dma-buf sharing.
> 
> Each heap is given its own device node, which a user can
> allocate a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
> 
> This code is an evoluiton of the Android ION implementation,
> and a big thanks is due to its authors/maintainers over time
> for their effort:
>   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
>   Laura Abbott, and many other contributors!

Comments just on the user/kernel api and how it interacts with the
driver model.  Not on the "real" functionality of this code :)

> +#define DEVNAME "dma_heap"
> +
> +#define NUM_HEAP_MINORS 128

Why a max?

> +static DEFINE_IDR(dma_heap_idr);
> +static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */

Move to use xarray now so that Matthew doesn't have to send patches
converting this code later :)

It also allows you to drop the mutex.

> +
> +dev_t dma_heap_devt;
> +struct class *dma_heap_class;
> +struct list_head dma_heap_list;
> +struct dentry *dma_heap_debug_root;

Global variables?

> +
> +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				 unsigned int flags)
> +{
> +	len = PAGE_ALIGN(len);
> +	if (!len)
> +		return -EINVAL;
> +
> +	return heap->ops->allocate(heap, len, flags);
> +}
> +
> +static int dma_heap_open(struct inode *inode, struct file *filp)
> +{
> +	struct dma_heap *heap;
> +
> +	mutex_lock(&minor_lock);
> +	heap = idr_find(&dma_heap_idr, iminor(inode));
> +	mutex_unlock(&minor_lock);
> +	if (!heap) {
> +		pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
> +		return -ENODEV;
> +	}
> +
> +	/* instance data as context */
> +	filp->private_data = heap;
> +	nonseekable_open(inode, filp);
> +
> +	return 0;
> +}
> +
> +static int dma_heap_release(struct inode *inode, struct file *filp)
> +{
> +	filp->private_data = NULL;

Why does this matter?  release should only be called on the way out of
here, no need to do anything as nothing else can be called, right?

release shouldn't be needed from what I can tell.

> +
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DMA_HEAP_IOC_ALLOC:
> +	{
> +		struct dma_heap_allocation_data heap_allocation;
> +		struct dma_heap *heap = filp->private_data;
> +		int fd;
> +
> +		if (copy_from_user(&heap_allocation, (void __user *)arg,
> +				   sizeof(heap_allocation)))
> +			return -EFAULT;
> +
> +		if (heap_allocation.fd ||
> +		    heap_allocation.reserved0 ||
> +		    heap_allocation.reserved1 ||
> +		    heap_allocation.reserved2) {
> +			pr_warn_once("dma_heap: ioctl data not valid\n");
> +			return -EINVAL;
> +		}

Good job in forcing the reserved fields to be 0!

> +		if (heap_allocation.flags & ~DMA_HEAP_VALID_FLAGS) {
> +			pr_warn_once("dma_heap: flags has invalid or unsupported flags set\n");
> +			return -EINVAL;
> +		}
> +
> +		fd = dma_heap_buffer_alloc(heap, heap_allocation.len,
> +					   heap_allocation.flags);

No max value checking for .len?  Can you really ask for anything?

> +		if (fd < 0)
> +			return fd;
> +
> +		heap_allocation.fd = fd;
> +
> +		if (copy_to_user((void __user *)arg, &heap_allocation,
> +				 sizeof(heap_allocation)))
> +			return -EFAULT;
> +
> +		break;
> +	}
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct file_operations dma_heap_fops = {
> +	.owner          = THIS_MODULE,
> +	.open		= dma_heap_open,
> +	.release	= dma_heap_release,
> +	.unlocked_ioctl = dma_heap_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	= dma_heap_ioctl,
> +#endif

Why is compat_ioctl even needed?

> +};
> +
> +int dma_heap_add(struct dma_heap *heap)
> +{
> +	struct device *dev_ret;
> +	int ret;
> +
> +	if (!heap->name || !strcmp(heap->name, "")) {
> +		pr_err("dma_heap: Cannot add heap without a name\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!heap->ops || !heap->ops->allocate) {
> +		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Find unused minor number */
> +	mutex_lock(&minor_lock);
> +	ret = idr_alloc(&dma_heap_idr, heap, 0, NUM_HEAP_MINORS, GFP_KERNEL);
> +	mutex_unlock(&minor_lock);

Again, xarray.

But I will ask you to back up, why need a major number at all?  Why not
just use the misc subsystem?  How many of these are you going to have
over time in a "normal" system?  How about a "abnormal system"?

We have seen people running Android in "containers" such that they
needed binderfs to handle huge numbers of individual android systems
running at the same time.  Will this api break those systems if you have
a tiny maximum number you an allocate?

> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to get minor number for heap\n");
> +		return ret;
> +	}
> +	heap->minor = ret;
> +
> +	/* Create device */
> +	heap->heap_devt = MKDEV(MAJOR(dma_heap_devt), heap->minor);
> +	dev_ret = device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);

No parent?  Can't hang this off of anything?  Ok, having it show up in
/sys/devices/virtual/ is probably good enough.

> +	if (IS_ERR(dev_ret)) {
> +		pr_err("dma_heap: Unable to create char device\n");
> +		return PTR_ERR(dev_ret);
> +	}
> +
> +	/* Add device */
> +	cdev_init(&heap->heap_cdev, &dma_heap_fops);
> +	ret = cdev_add(&heap->heap_cdev, dma_heap_devt, NUM_HEAP_MINORS);
> +	if (ret < 0) {
> +		device_destroy(dma_heap_class, heap->heap_devt);
> +		pr_err("dma_heap: Unable to add char device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(dma_heap_add);

EXPORT_SYMBOL_GPL() please?  For core stuff like this it's good.

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
> +
> +	return 0;
> +}
> +subsys_initcall(dma_heap_init);

Overall, looks sane, the comments above are all really minor.


> --- /dev/null
> +++ b/include/uapi/linux/dma-heap.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Wrong license for a uapi .h file :(

thanks,

greg k-h
