Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B64C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AB5208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL0Jh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:37:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:6989 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0JhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:37:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 01:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,362,1571727600"; 
   d="scan'208";a="220469731"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.238.130.143]) ([10.238.130.143])
  by orsmga003.jf.intel.com with ESMTP; 27 Dec 2019 01:37:23 -0800
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
To:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
Message-ID: <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
Date:   Fri, 27 Dec 2019 17:37:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for reviewing the patches!

  [...]
>> -
>> +#include <linux/msi.h>
>> +#include <asm/irqdomain.h>
>>     /* The alignment to use between consumer and producer parts of 
>> vring.
>>    * Currently hardcoded to the page size. */
>> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>>       /* a list of queues so we can dispatch IRQs */
>>       spinlock_t lock;
>>       struct list_head virtqueues;
>> +
>> +    int doorbell_base;
>> +    int doorbell_scale;
>
>
> It's better to use the terminology defined by spec, e.g 
> notify_base/notify_multiplexer etc.
>
> And we usually use unsigned type for offset.

We will fix this in next version.


>
>
>> +    bool msi_enabled;
>> +    /* Name strings for interrupts. */
>> +    char (*vm_vq_names)[256];
>>   };
>>     struct virtio_mmio_vq_info {
>> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>>   };
>>     +static void vm_free_msi_irqs(struct virtio_device *vdev);
>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int 
>> nirqs);
>>     /* Configuration interface */
>>   @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *vq)
>>   {
>>       struct virtio_mmio_device *vm_dev = 
>> to_virtio_mmio_device(vq->vdev);
>>   +    if (vm_dev->version == 3) {
>> +        int offset = vm_dev->doorbell_base +
>> +                 vm_dev->doorbell_scale * vq->index;
>> +        writel(vq->index, vm_dev->base + offset);
>
>
> In virtio-pci we store the doorbell address in vq->priv to avoid doing 
> multiplication in fast path.

Good suggestion. We will fix this in next version.

[...]

>> +
>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int 
>> nirqs)
>> +{
>> +    struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>> +    int irq, err;
>> +    u16 csr = readw(vm_dev->base + VIRTIO_MMIO_MSI_STATUS);
>> +
>> +    if (vm_dev->msi_enabled || (csr & VIRTIO_MMIO_MSI_ENABLE_MASK) 
>> == 0)
>> +        return -EINVAL;
>> +
>> +    vm_dev->vm_vq_names = kmalloc_array(nirqs, 
>> sizeof(*vm_dev->vm_vq_names),
>> +            GFP_KERNEL);
>> +    if (!vm_dev->vm_vq_names)
>> +        return -ENOMEM;
>> +
>> +    if (!vdev->dev.msi_domain)
>> +        vdev->dev.msi_domain = platform_msi_get_def_irq_domain();
>> +    err = platform_msi_domain_alloc_irqs(&vdev->dev, nirqs,
>> +            mmio_write_msi_msg);
>
>
> Can platform_msi_domain_alloc_irqs check msi_domain vs NULL?
>
Actually here, we need to firstly consider the cases that @dev doesn't 
have @msi_domain,

according to the report by lkp.

For the platform_msi_domain_alloc_irqs, it can help check inside.


> [...]
>>         rc = register_virtio_device(&vm_dev->vdev);
>>       if (rc)
>> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct 
>> platform_device *pdev)
>>       return 0;
>>   }
>>   -
>> -
>
>
> Unnecessary changes.

Got it. Will remove it later.


> [...]
>>   +/* MSI related registers */
>> +
>> +/* MSI status register */
>> +#define VIRTIO_MMIO_MSI_STATUS        0x0c0
>> +/* MSI command register */
>> +#define VIRTIO_MMIO_MSI_COMMAND        0x0c2
>> +/* MSI low 32 bit address, 64 bits in two halves */
>> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW    0x0c4
>> +/* MSI high 32 bit address, 64 bits in two halves */
>> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH    0x0c8
>> +/* MSI data */
>> +#define VIRTIO_MMIO_MSI_DATA        0x0cc
>
>
> I wonder what's the advantage of using registers instead of memory 
> mapped tables as PCI did. Is this because MMIO doesn't have capability 
> list which makes it hard to be extended if we have variable size of 
> tables?
>
Yes, mmio doesn't have capability which limits the extension.

It need some registers to specify the msi table/mask table/pending table 
offsets if using what pci did.

As comments previously, mask/pending can be easily extended by MSI command.

>
>> +
>> +/* RO: MSI feature enabled mask */
>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK    0x8000
>> +/* RO: Maximum queue size available */
>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK    0x07ff
>> +/* Reserved */
>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED    0x7800
>> +
>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE    0x1
>
>
> I believe we need a command to read the number of vectors supported by 
> the device, or 2048 is assumed to be a fixed size here?

For not bringing much complexity, we proposed vector per queue and fixed 
relationship between events and vectors.

So the number of vectors supported by device is equal to the total 
number of vqs and config.

We will try to explicitly highlight this point in spec for later version.


Thanks!

Jing

>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
