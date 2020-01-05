Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8BC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016F221582
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2fI5KGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAELEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 06:04:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgAELEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 06:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578222270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1IydaXSKWsa/oJmPiKhE8Jw3548E2NmBPgMyeuqdSXs=;
        b=L2fI5KGvYSel+KO3i0jIVCNy5Mfh5Ar6wQy5/5zkwuWi+o3Ml39YK3491knAVSljDy6L3S
        sMHE9oKnJ/8oLMonvj8oXyW3pQRNja1/wpdwLqndxx+Jv751mh938SMZ7uwiz4dUGykM/4
        AHZ1NtsB/31jftePapWvCv9ay1Miibc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-20rM-tDgPXONrYWW47xE7A-1; Sun, 05 Jan 2020 06:04:28 -0500
X-MC-Unique: 20rM-tDgPXONrYWW47xE7A-1
Received: by mail-qv1-f72.google.com with SMTP id e26so5375635qvb.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 03:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1IydaXSKWsa/oJmPiKhE8Jw3548E2NmBPgMyeuqdSXs=;
        b=ewppNHnSWBNZlrbZxxRpAUho5SUmtQlqrWxNt72ALjyHkAan9vM3jbjsazsTiJ7Mf5
         hfbVaqVQY4Qwg3LrP7l5Gpnip1ENkDzfVvkYFgS2M1E/PBPB6Gctj1kjTBYhahQA7qcu
         r5eGrGVNhmKkJYYwW6zTRKhIruwxvji5qYPM29oLl0isJJv81NAN667JjqQk/iuvlSdi
         FXoBoe2DO7pwaqkqrP+ytAlzNUgpV4Ru57/vs5mrDOYJ1xjzZA1ff2nkJTrsAV3ykxzC
         SuHNOIFfXSYrBDKdQTkc/3b8yBwAQbXIt9sn78ktKUWN2T0G9n2xsSeabLkr64bOh9X6
         0bDQ==
X-Gm-Message-State: APjAAAU4NWHbmu5+HNWNCskFaDTvsH0eq78hj55KJ4FA2u/cX4dWdGa3
        K232B6qjSxj9QjNkdcY+EE3dhbZXe+5jvhps85HfunqXiRqpNsrkJrtQF3YUNmHR2/aRY/z90aA
        qlj8MfWvlkoShU/ueKXJMfmM4
X-Received: by 2002:ac8:7201:: with SMTP id a1mr70690477qtp.51.1578222265955;
        Sun, 05 Jan 2020 03:04:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoR3DdCusNKAwwfnc3T9c+t799Y3533vCjPgP01VeA1L5hGg0P7CSYn7kQPj2x1y/A2FdbyA==
X-Received: by 2002:ac8:7201:: with SMTP id a1mr70690449qtp.51.1578222265444;
        Sun, 05 Jan 2020 03:04:25 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id q25sm19322810qkq.88.2020.01.05.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 03:04:24 -0800 (PST)
Date:   Sun, 5 Jan 2020 06:04:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Message-ID: <20200105054412-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 10:50:23AM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
> 
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specific
> VMExits in following cases, which would considerably slow down the
> performance:
> 
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
> 
> We proposed to update virtio over MMIO to version 3[1] to add the
> following new features and enhance the performance.
> 
> 1) Support Message Signaled Interrupt(MSI), which increases the
>    interrupt performance for virtio multi-queue devices
> 2) Support per-queue doorbell, so the guest kernel may directly write
>    to the doorbells provided by virtio devices.

Do we need to come up with new "doorbell" terminology?
virtio spec calls these available event notifications,
let's stick to this.


> 
> The following is the network tcp_rr performance testing report, tested
> with virtio-pci device, vanilla virtio-mmio device and patched
> virtio-mmio device (run test 3 times for each case):
> 
> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
> 
> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> 	trans/s	    9536	6939		9500
> 	trans/s	    9734	7029		9749
> 	trans/s	    9894	7095		9318
> 
> [1] https://lkml.org/lkml/2019/12/20/113
> 
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>


Do we need a new version though? What is wrong with
a feature bit? This way we can create compatible devices
and drivers.

> ---
>  drivers/virtio/virtio_mmio.c     | 226 ++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/virtio_mmio.h |  28 +++++
>  2 files changed, 240 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5..065c083 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -68,8 +68,8 @@
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> -
> -
> +#include <linux/msi.h>
> +#include <asm/irqdomain.h>
>  
>  /* The alignment to use between consumer and producer parts of vring.
>   * Currently hardcoded to the page size. */
> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> +
> +	int doorbell_base;
> +	int doorbell_scale;
> +	bool msi_enabled;
> +	/* Name strings for interrupts. */
> +	char (*vm_vq_names)[256];

Add a comment explaining 256 pls.

>  };
>  
>  struct virtio_mmio_vq_info {
> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>  };
>  
>  
> +static void vm_free_msi_irqs(struct virtio_device *vdev);
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs);
>  
>  /* Configuration interface */
>  
> @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
>  
> +	if (vm_dev->version == 3) {
> +		int offset = vm_dev->doorbell_base +
> +			     vm_dev->doorbell_scale * vq->index;
> +		writel(vq->index, vm_dev->base + offset);
> +	} else
>  	/* We write the queue's selector into the notification register to
>  	 * signal the other end */
> -	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +		writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
>  	return true;
>  }

You might want to support VIRTIO_F_NOTIFICATION_DATA too.


> +/* Handle a configuration change */
> +static irqreturn_t vm_config_changed(int irq, void *opaque)
> +{
> +	struct virtio_mmio_device *vm_dev = opaque;
> +
> +	virtio_config_changed(&vm_dev->vdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /* Notify all virtqueues on an interrupt. */
>  static irqreturn_t vm_interrupt(int irq, void *opaque)
>  {
> @@ -307,7 +331,12 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>  	return ret;
>  }
>  
> +static int vm_msi_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	struct msi_desc *entry = first_msi_entry(dev);
>  
> +	return entry->irq + nr;
> +}
>  
>  static void vm_del_vq(struct virtqueue *vq)
>  {
> @@ -316,6 +345,12 @@ static void vm_del_vq(struct virtqueue *vq)
>  	unsigned long flags;
>  	unsigned int index = vq->index;
>  
> +	if (vm_dev->version == 3 && vm_dev->msi_enabled) {
> +		int irq = vm_msi_irq_vector(&vq->vdev->dev, index + 1);
> +
> +		free_irq(irq, vq);
> +	}
> +
>  	spin_lock_irqsave(&vm_dev->lock, flags);
>  	list_del(&info->node);
>  	spin_unlock_irqrestore(&vm_dev->lock, flags);


I think tying MSI to versions is a mistake.



> @@ -334,15 +369,41 @@ static void vm_del_vq(struct virtqueue *vq)
>  	kfree(info);
>  }
>  
> -static void vm_del_vqs(struct virtio_device *vdev)
> +static void vm_free_irqs(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	if (vm_dev->version == 3)
> +		vm_free_msi_irqs(vdev);
> +	else
> +		free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +}
> +
> +static void vm_del_vqs(struct virtio_device *vdev)
> +{
>  	struct virtqueue *vq, *n;
>  
>  	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>  		vm_del_vq(vq);
>  
> -	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +	vm_free_irqs(vdev);
> +}
> +
> +static int vm_request_single_irq(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int irq = platform_get_irq(vm_dev->pdev, 0);
> +	int err;
> +
> +	if (irq < 0) {
> +		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +		return irq;
> +	}
> +
> +	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
> +			dev_name(&vdev->dev), vm_dev);
> +
> +	return err;
>  }
>  
>  static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
> @@ -455,6 +516,72 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	return ERR_PTR(err);
>  }
>  
> +static inline void mmio_msi_set_enable(struct virtio_mmio_device *vm_dev,
> +		int enable)
> +{
> +	u16 status;
> +
> +	status = readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +	if (enable)
> +		status |= VIRTIO_MMIO_MSI_ENABLE_MASK;
> +	else
> +		status &= ~VIRTIO_MMIO_MSI_ENABLE_MASK;
> +	writew(status, vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +}
> +
> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvqs,
> +			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +			const char * const names[], const bool *ctx,
> +			struct irq_affinity *desc)
> +{
> +	int i, err, irq;
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	/* Allocate nvqs irqs for queues and one irq for configuration */
> +	err = vm_request_msi_vectors(vdev, nvqs + 1);
> +	if (err != 0)
> +		return err;

Not all devices need high speed.  Some might want to share
irqs between VQs, or even with config change callback.
Balloon is a case in point.
A hint about max # of MSI necessary would be a good
idea for this case.


Sharing MSI doesn't necessarily require dedicated registers like PCI has,
you can just program same vector in multiple VQs.

> +
> +	for (i = 0; i < nvqs; i++) {
> +		int index = i + 1;
> +
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
> +				ctx ? ctx[i] : false);
> +		if (IS_ERR(vqs[i])) {
> +			err = PTR_ERR(vqs[i]);
> +			goto error_find;
> +		}
> +
> +		if (!callbacks[i])
> +			continue;
> +
> +		irq = vm_msi_irq_vector(&vqs[i]->vdev->dev, index);
> +		/* allocate per-vq irq if available and necessary */
> +		snprintf(vm_dev->vm_vq_names[index],
> +			sizeof(*vm_dev->vm_vq_names),
> +			"%s-%s",
> +			dev_name(&vm_dev->vdev.dev), names[i]);
> +		err = request_irq(irq, vring_interrupt, 0,
> +				vm_dev->vm_vq_names[index], vqs[i]);
> +
> +		if (err)
> +			goto error_find;
> +	}
> +
> +	mmio_msi_set_enable(vm_dev, 1);
> +	vm_dev->msi_enabled = true;
> +
> +	return 0;
> +
> +error_find:
> +	vm_del_vqs(vdev);
> +	return err;
> +}
> +
>  static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		       struct virtqueue *vqs[],
>  		       vq_callback_t *callbacks[],
> @@ -463,16 +590,16 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		       struct irq_affinity *desc)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -	int irq = platform_get_irq(vm_dev->pdev, 0);
>  	int i, err, queue_idx = 0;
>  
> -	if (irq < 0) {
> -		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> -		return irq;
> +	if (vm_dev->version == 3) {
> +		err = vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +				names, ctx, desc);
> +		if (!err)
> +			return 0;
>  	}
>  
> -	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
> -			dev_name(&vdev->dev), vm_dev);
> +	err = vm_request_single_irq(vdev);
>  	if (err)
>  		return err;
>  
> @@ -493,6 +620,73 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  	return 0;
>  }
>  
> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct device *dev = desc->dev;
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	void __iomem *pos = vm_dev->base;
> +	uint16_t cmd = VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
> +			desc->platform.msi_index);
> +
> +	writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> +	writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> +	writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
> +	writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
> +}

All this can happen when IRQ affinity changes while device
is sending interrupts. An interrupt sent between the writel
operations will then be directed incorrectly.



> +
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int irq, err;
> +	u16 csr = readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +
> +	if (vm_dev->msi_enabled || (csr & VIRTIO_MMIO_MSI_ENABLE_MASK) == 0)
> +		return -EINVAL;
> +
> +	vm_dev->vm_vq_names = kmalloc_array(nirqs, sizeof(*vm_dev->vm_vq_names),
> +			GFP_KERNEL);
> +	if (!vm_dev->vm_vq_names)
> +		return -ENOMEM;
> +
> +	if (!vdev->dev.msi_domain)
> +		vdev->dev.msi_domain = platform_msi_get_def_irq_domain();
> +	err = platform_msi_domain_alloc_irqs(&vdev->dev, nirqs,
> +			mmio_write_msi_msg);
> +	if (err)
> +		goto error_free_mem;
> +
> +	/* The first MSI vector is used for configuration change events. */
> +	snprintf(vm_dev->vm_vq_names[0], sizeof(*vm_dev->vm_vq_names),
> +			"%s-config", dev_name(&vdev->dev));
> +	irq = vm_msi_irq_vector(&vdev->dev, 0);
> +	err = request_irq(irq, vm_config_changed, 0, vm_dev->vm_vq_names[0],
> +			vm_dev);
> +	if (err)
> +		goto error_free_mem;
> +
> +	return 0;
> +
> +error_free_mem:
> +	kfree(vm_dev->vm_vq_names);
> +	vm_dev->vm_vq_names = NULL;
> +	return err;
> +}
> +
> +static void vm_free_msi_irqs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	if (vm_dev->msi_enabled) {
> +		mmio_msi_set_enable(vm_dev, 0);
> +		free_irq(vm_msi_irq_vector(&vdev->dev, 0), vm_dev);
> +		platform_msi_domain_free_irqs(&vdev->dev);
> +		kfree(vm_dev->vm_vq_names);
> +		vm_dev->vm_vq_names = NULL;
> +		vm_dev->msi_enabled = false;
> +	}
> +}
> +
>  static const char *vm_bus_name(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> @@ -567,7 +761,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  
>  	/* Check device version */
>  	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -	if (vm_dev->version < 1 || vm_dev->version > 2) {
> +	if (vm_dev->version < 1 || vm_dev->version > 3) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
>  		return -ENXIO;
> @@ -603,6 +797,12 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
>  
>  	platform_set_drvdata(pdev, vm_dev);
> +	if (vm_dev->version == 3) {
> +		u32 db = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +		vm_dev->doorbell_base = db & 0xffff;
> +		vm_dev->doorbell_scale = (db >> 16) & 0xffff;
> +	}
>  
>  	rc = register_virtio_device(&vm_dev->vdev);
>  	if (rc)
> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -
> -
>  /* Devices list parameter */
>  
>  #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
> index c4b0968..148895e 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,34 @@
>  #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
>  #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
>  
> +/* MSI related registers */
> +
> +/* MSI status register */
> +#define VIRTIO_MMIO_MSI_STATUS		0x0c0
> +/* MSI command register */
> +#define VIRTIO_MMIO_MSI_COMMAND		0x0c2
> +/* MSI low 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW	0x0c4
> +/* MSI high 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH	0x0c8
> +/* MSI data */
> +#define VIRTIO_MMIO_MSI_DATA		0x0cc
> +
> +/* RO: MSI feature enabled mask */
> +#define VIRTIO_MMIO_MSI_ENABLE_MASK	0x8000

I don't understand the comment. Is this a way for
a version 3 device to say "I want/do not want MSI"?
Why not just use a feature bit? We are not short on these.

> +/* RO: Maximum queue size available */
> +#define VIRTIO_MMIO_MSI_STATUS_QMASK	0x07ff


I don't know what above is. Seems unused.

> +/* Reserved */
> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED	0x7800
> +
> +#define VIRTIO_MMIO_MSI_CMD_UPDATE	0x1
> +#define VIRTIO_MMIO_MSI_CMD_OP_MASK	0xf000
> +#define VIRTIO_MMIO_MSI_CMD_ARG_MASK	0x0fff
> +#define VIRTIO_MMIO_MSI_CMD(op, arg)	((op) << 12 | (arg))
> +#define VIRITO_MMIO_MSI_CMD_ARG(cmd)	((cmd) & VIRTIO_MMIO_MSI_CMD_ARG_MASK)
> +#define VIRTIO_MMIO_MSI_CMD_OP(cmd)	\
> +		(((cmd) & VIRTIO_MMIO_MSI_CMD_OP_MASK) >> 12)
> +
>  /* Configuration atomicity value */
>  #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
>  
> -- 
> 1.8.3.1

