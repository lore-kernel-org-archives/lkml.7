Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EF9C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AA9206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGZT2Bp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfLZIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 03:40:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbfLZIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 03:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577349656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BetayLBkfzhyPO4EM0iArOCYMIIksq9EMq0hYpaLKHM=;
        b=iGZT2Bp9lMAiclURL/EvgjQgVhRooSptbY2DZj7shTZKBwLH7cm85rTO8E33+HeI6L3cB+
        lgUCbOM7bFH2B0y9yeKjrMxmx4OweUh/kTq7cIELIAN9azTeXKciwtDGk4HxKYkYdk0cJI
        kQ5HuVaSybqxdC+gh3bQpQ8VCBc0qrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-OBG6dK_cMr6CoVTrPEFuOQ-1; Thu, 26 Dec 2019 03:40:52 -0500
X-MC-Unique: OBG6dK_cMr6CoVTrPEFuOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E91BE1804174;
        Thu, 26 Dec 2019 08:40:49 +0000 (UTC)
Received: from [10.72.12.162] (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 130C660BEC;
        Thu, 26 Dec 2019 08:40:24 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
To:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
Date:   Thu, 26 Dec 2019 16:40:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
>
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specifi=
c
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
>     interrupt performance for virtio multi-queue devices
> 2) Support per-queue doorbell, so the guest kernel may directly write
>     to the doorbells provided by virtio devices.
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
> ---
>   drivers/virtio/virtio_mmio.c     | 226 ++++++++++++++++++++++++++++++=
++++++---
>   include/uapi/linux/virtio_mmio.h |  28 +++++
>   2 files changed, 240 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> index e09edb5..065c083 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -68,8 +68,8 @@
>   #include <linux/virtio_config.h>
>   #include <uapi/linux/virtio_mmio.h>
>   #include <linux/virtio_ring.h>
> -
> -
> +#include <linux/msi.h>
> +#include <asm/irqdomain.h>
>  =20
>   /* The alignment to use between consumer and producer parts of vring.
>    * Currently hardcoded to the page size. */
> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>   	/* a list of queues so we can dispatch IRQs */
>   	spinlock_t lock;
>   	struct list_head virtqueues;
> +
> +	int doorbell_base;
> +	int doorbell_scale;


It's better to use the terminology defined by spec, e.g=20
notify_base/notify_multiplexer etc.

And we usually use unsigned type for offset.


> +	bool msi_enabled;
> +	/* Name strings for interrupts. */
> +	char (*vm_vq_names)[256];
>   };
>  =20
>   struct virtio_mmio_vq_info {
> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>   };
>  =20
>  =20
> +static void vm_free_msi_irqs(struct virtio_device *vdev);
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirq=
s);
>  =20
>   /* Configuration interface */
>  =20
> @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>   {
>   	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->vdev=
);
>  =20
> +	if (vm_dev->version =3D=3D 3) {
> +		int offset =3D vm_dev->doorbell_base +
> +			     vm_dev->doorbell_scale * vq->index;
> +		writel(vq->index, vm_dev->base + offset);


In virtio-pci we store the doorbell address in vq->priv to avoid doing=20
multiplication in fast path.


> +	} else
>   	/* We write the queue's selector into the notification register to
>   	 * signal the other end */
> -	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +		writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
>   	return true;
>   }
>  =20
> +/* Handle a configuration change */
> +static irqreturn_t vm_config_changed(int irq, void *opaque)
> +{
> +	struct virtio_mmio_device *vm_dev =3D opaque;
> +
> +	virtio_config_changed(&vm_dev->vdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   /* Notify all virtqueues on an interrupt. */
>   static irqreturn_t vm_interrupt(int irq, void *opaque)
>   {
> @@ -307,7 +331,12 @@ static irqreturn_t vm_interrupt(int irq, void *opa=
que)
>   	return ret;
>   }
>  =20
> +static int vm_msi_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	struct msi_desc *entry =3D first_msi_entry(dev);
>  =20
> +	return entry->irq + nr;
> +}
>  =20
>   static void vm_del_vq(struct virtqueue *vq)
>   {
> @@ -316,6 +345,12 @@ static void vm_del_vq(struct virtqueue *vq)
>   	unsigned long flags;
>   	unsigned int index =3D vq->index;
>  =20
> +	if (vm_dev->version =3D=3D 3 && vm_dev->msi_enabled) {
> +		int irq =3D vm_msi_irq_vector(&vq->vdev->dev, index + 1);
> +
> +		free_irq(irq, vq);
> +	}
> +
>   	spin_lock_irqsave(&vm_dev->lock, flags);
>   	list_del(&info->node);
>   	spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -334,15 +369,41 @@ static void vm_del_vq(struct virtqueue *vq)
>   	kfree(info);
>   }
>  =20
> -static void vm_del_vqs(struct virtio_device *vdev)
> +static void vm_free_irqs(struct virtio_device *vdev)
>   {
>   	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +	if (vm_dev->version =3D=3D 3)
> +		vm_free_msi_irqs(vdev);
> +	else
> +		free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +}
> +
> +static void vm_del_vqs(struct virtio_device *vdev)
> +{
>   	struct virtqueue *vq, *n;
>  =20
>   	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>   		vm_del_vq(vq);
>  =20
> -	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +	vm_free_irqs(vdev);
> +}
> +
> +static int vm_request_single_irq(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +	int irq =3D platform_get_irq(vm_dev->pdev, 0);
> +	int err;
> +
> +	if (irq < 0) {
> +		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +		return irq;
> +	}
> +
> +	err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
> +			dev_name(&vdev->dev), vm_dev);
> +
> +	return err;
>   }
>  =20
>   static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsi=
gned index,
> @@ -455,6 +516,72 @@ static struct virtqueue *vm_setup_vq(struct virtio=
_device *vdev, unsigned index,
>   	return ERR_PTR(err);
>   }
>  =20
> +static inline void mmio_msi_set_enable(struct virtio_mmio_device *vm_d=
ev,
> +		int enable)
> +{
> +	u16 status;
> +
> +	status =3D readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +	if (enable)
> +		status |=3D VIRTIO_MMIO_MSI_ENABLE_MASK;
> +	else
> +		status &=3D ~VIRTIO_MMIO_MSI_ENABLE_MASK;
> +	writew(status, vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +}
> +
> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nv=
qs,
> +			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +			const char * const names[], const bool *ctx,
> +			struct irq_affinity *desc)
> +{
> +	int i, err, irq;
> +	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +	/* Allocate nvqs irqs for queues and one irq for configuration */
> +	err =3D vm_request_msi_vectors(vdev, nvqs + 1);
> +	if (err !=3D 0)
> +		return err;
> +
> +	for (i =3D 0; i < nvqs; i++) {
> +		int index =3D i + 1;
> +
> +		if (!names[i]) {
> +			vqs[i] =3D NULL;
> +			continue;
> +		}
> +		vqs[i] =3D vm_setup_vq(vdev, i, callbacks[i], names[i],
> +				ctx ? ctx[i] : false);
> +		if (IS_ERR(vqs[i])) {
> +			err =3D PTR_ERR(vqs[i]);
> +			goto error_find;
> +		}
> +
> +		if (!callbacks[i])
> +			continue;
> +
> +		irq =3D vm_msi_irq_vector(&vqs[i]->vdev->dev, index);
> +		/* allocate per-vq irq if available and necessary */
> +		snprintf(vm_dev->vm_vq_names[index],
> +			sizeof(*vm_dev->vm_vq_names),
> +			"%s-%s",
> +			dev_name(&vm_dev->vdev.dev), names[i]);
> +		err =3D request_irq(irq, vring_interrupt, 0,
> +				vm_dev->vm_vq_names[index], vqs[i]);
> +
> +		if (err)
> +			goto error_find;
> +	}
> +
> +	mmio_msi_set_enable(vm_dev, 1);
> +	vm_dev->msi_enabled =3D true;
> +
> +	return 0;
> +
> +error_find:
> +	vm_del_vqs(vdev);
> +	return err;
> +}
> +
>   static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   		       struct virtqueue *vqs[],
>   		       vq_callback_t *callbacks[],
> @@ -463,16 +590,16 @@ static int vm_find_vqs(struct virtio_device *vdev=
, unsigned nvqs,
>   		       struct irq_affinity *desc)
>   {
>   	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> -	int irq =3D platform_get_irq(vm_dev->pdev, 0);
>   	int i, err, queue_idx =3D 0;
>  =20
> -	if (irq < 0) {
> -		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> -		return irq;
> +	if (vm_dev->version =3D=3D 3) {
> +		err =3D vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +				names, ctx, desc);
> +		if (!err)
> +			return 0;
>   	}
>  =20
> -	err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
> -			dev_name(&vdev->dev), vm_dev);
> +	err =3D vm_request_single_irq(vdev);
>   	if (err)
>   		return err;
>  =20
> @@ -493,6 +620,73 @@ static int vm_find_vqs(struct virtio_device *vdev,=
 unsigned nvqs,
>   	return 0;
>   }
>  =20
> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *=
msg)
> +{
> +	struct device *dev =3D desc->dev;
> +	struct virtio_device *vdev =3D dev_to_virtio(dev);
> +	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +	void __iomem *pos =3D vm_dev->base;
> +	uint16_t cmd =3D VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
> +			desc->platform.msi_index);
> +
> +	writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> +	writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> +	writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
> +	writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
> +}
> +
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirq=
s)
> +{
> +	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +	int irq, err;
> +	u16 csr =3D readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
> +
> +	if (vm_dev->msi_enabled || (csr & VIRTIO_MMIO_MSI_ENABLE_MASK) =3D=3D=
 0)
> +		return -EINVAL;
> +
> +	vm_dev->vm_vq_names =3D kmalloc_array(nirqs, sizeof(*vm_dev->vm_vq_na=
mes),
> +			GFP_KERNEL);
> +	if (!vm_dev->vm_vq_names)
> +		return -ENOMEM;
> +
> +	if (!vdev->dev.msi_domain)
> +		vdev->dev.msi_domain =3D platform_msi_get_def_irq_domain();
> +	err =3D platform_msi_domain_alloc_irqs(&vdev->dev, nirqs,
> +			mmio_write_msi_msg);


Can platform_msi_domain_alloc_irqs check msi_domain vs NULL?


> +	if (err)
> +		goto error_free_mem;
> +
> +	/* The first MSI vector is used for configuration change events. */
> +	snprintf(vm_dev->vm_vq_names[0], sizeof(*vm_dev->vm_vq_names),
> +			"%s-config", dev_name(&vdev->dev));
> +	irq =3D vm_msi_irq_vector(&vdev->dev, 0);
> +	err =3D request_irq(irq, vm_config_changed, 0, vm_dev->vm_vq_names[0]=
,
> +			vm_dev);
> +	if (err)
> +		goto error_free_mem;
> +
> +	return 0;
> +
> +error_free_mem:
> +	kfree(vm_dev->vm_vq_names);
> +	vm_dev->vm_vq_names =3D NULL;
> +	return err;
> +}
> +
> +static void vm_free_msi_irqs(struct virtio_device *vdev)
> +{
> +	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> +
> +	if (vm_dev->msi_enabled) {
> +		mmio_msi_set_enable(vm_dev, 0);
> +		free_irq(vm_msi_irq_vector(&vdev->dev, 0), vm_dev);
> +		platform_msi_domain_free_irqs(&vdev->dev);
> +		kfree(vm_dev->vm_vq_names);
> +		vm_dev->vm_vq_names =3D NULL;
> +		vm_dev->msi_enabled =3D false;
> +	}
> +}
> +
>   static const char *vm_bus_name(struct virtio_device *vdev)
>   {
>   	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> @@ -567,7 +761,7 @@ static int virtio_mmio_probe(struct platform_device=
 *pdev)
>  =20
>   	/* Check device version */
>   	vm_dev->version =3D readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -	if (vm_dev->version < 1 || vm_dev->version > 2) {
> +	if (vm_dev->version < 1 || vm_dev->version > 3) {
>   		dev_err(&pdev->dev, "Version %ld not supported!\n",
>   				vm_dev->version);
>   		return -ENXIO;
> @@ -603,6 +797,12 @@ static int virtio_mmio_probe(struct platform_devic=
e *pdev)
>   		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Tryin=
g to continue, but this might not work.\n");
>  =20
>   	platform_set_drvdata(pdev, vm_dev);
> +	if (vm_dev->version =3D=3D 3) {
> +		u32 db =3D readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +		vm_dev->doorbell_base =3D db & 0xffff;
> +		vm_dev->doorbell_scale =3D (db >> 16) & 0xffff;
> +	}
>  =20
>   	rc =3D register_virtio_device(&vm_dev->vdev);
>   	if (rc)
> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct platform_devic=
e *pdev)
>   	return 0;
>   }
>  =20
> -
> -


Unnecessary changes.


>   /* Devices list parameter */
>  =20
>   #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virt=
io_mmio.h
> index c4b0968..148895e 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,34 @@
>   #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
>   #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
>  =20
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


I wonder what's the advantage of using registers instead of memory=20
mapped tables as PCI did. Is this because MMIO doesn't have capability=20
list which makes it hard to be extended if we have variable size of table=
s?


> +
> +/* RO: MSI feature enabled mask */
> +#define VIRTIO_MMIO_MSI_ENABLE_MASK	0x8000
> +/* RO: Maximum queue size available */
> +#define VIRTIO_MMIO_MSI_STATUS_QMASK	0x07ff
> +/* Reserved */
> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED	0x7800
> +
> +#define VIRTIO_MMIO_MSI_CMD_UPDATE	0x1


I believe we need a command to read the number of vectors supported by=20
the device, or 2048 is assumed to be a fixed size here?

Thanks


> +#define VIRTIO_MMIO_MSI_CMD_OP_MASK	0xf000
> +#define VIRTIO_MMIO_MSI_CMD_ARG_MASK	0x0fff
> +#define VIRTIO_MMIO_MSI_CMD(op, arg)	((op) << 12 | (arg))
> +#define VIRITO_MMIO_MSI_CMD_ARG(cmd)	((cmd) & VIRTIO_MMIO_MSI_CMD_ARG_=
MASK)
> +#define VIRTIO_MMIO_MSI_CMD_OP(cmd)	\
> +		(((cmd) & VIRTIO_MMIO_MSI_CMD_OP_MASK) >> 12)
> +
>   /* Configuration atomicity value */
>   #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
>  =20

