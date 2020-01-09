Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C015EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC1020661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq0kqv2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgAIN07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:26:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50950 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727861AbgAIN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDW4kFEJcV7khKj9tUNrAy6PW5pTvKYBuBt2mwolSEc=;
        b=cq0kqv2bbakyJsCiroOjY+sPsv/NF6KL0fLW1tYjA60Jb0/laQbpYhobZ+fcE95Fr2YsUh
        ge64XiKZjmttnl5QIQh1Ks62zfrngGz2f8I5YYCMUBcll8jTTdKnv9FOIbR4hfxIdQTK8A
        oURkgnN/NyatXJLpTzFV+OxCFiCm1TY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-xM2y8ITKOVOjRz_9wt6jUw-1; Thu, 09 Jan 2020 08:26:55 -0500
X-MC-Unique: xM2y8ITKOVOjRz_9wt6jUw-1
Received: by mail-qv1-f72.google.com with SMTP id e14so4109306qvr.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QDW4kFEJcV7khKj9tUNrAy6PW5pTvKYBuBt2mwolSEc=;
        b=gLNzyhIGi1VrgfSM2JAfauYkGTSPc28KkRcGGYZ4eiZ0m5A6Yp3c6Hw/q/+uSj7mu4
         ZtyY1IimTHePC9qlCcgKiVlFpVwE2owK7u0Z7JsEQdct4QzR32oQjzmp/8pFYWK7pbeL
         81L035mUr7kkU4zJnB2g24WLKKA4hrFRMbMhH7K7Pc5AZ0MPJDI2oV9d40XDl933n1ca
         aS/RbdEcSGlOtUa6Im5GIuW5KSaqS6xI4p1/e4rHVGK82m0H1NNgC/CkUpfbLW7VZJPq
         yLMFsI6djZ8Xg7vGSfiSprpDD5iPlkZzNUaP5XxvUGQQX9WFRY3cOoTfROFrvfXNuY35
         k14w==
X-Gm-Message-State: APjAAAV4b+LT9BGg0gYpFkKn9FfNH8k4XlOHN6wm0umvEGctgGA0KSmY
        thps2ckvBnG6e9isB5JjuIoXly+4UJSQWApcUuM2OVlzZMnPmfqAhKe4AKz8OGD0pzd95CmY+z6
        JXw6j4VoUIQj3oBVt+Iq+jNrL
X-Received: by 2002:a37:ef07:: with SMTP id j7mr9530149qkk.354.1578576414284;
        Thu, 09 Jan 2020 05:26:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyA4grr7d5V54Sl2N0V8A2QOR7cAx6nTNpi6MdKr8HDBlYAi2aEPSCISCkB9DnOupJV55okUg==
X-Received: by 2002:a37:ef07:: with SMTP id j7mr9530118qkk.354.1578576413957;
        Thu, 09 Jan 2020 05:26:53 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id x6sm2981814qkh.20.2020.01.09.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:26:53 -0800 (PST)
Date:   Thu, 9 Jan 2020 08:26:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Message-ID: <20200109082209-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
 <c7a8fc93-9493-c0b3-623a-02426995f0f8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a8fc93-9493-c0b3-623a-02426995f0f8@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:15:51PM +0800, Liu, Jing2 wrote:
> 
> On 1/5/2020 7:04 PM, Michael S. Tsirkin wrote:
> > On Wed, Dec 25, 2019 at 10:50:23AM +0800, Zha Bin wrote:
> > > From: Liu Jiang<gerry@linux.alibaba.com>
> > > 
> > > Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> > > virtio over mmio devices as a lightweight machine model for modern
> > > cloud. The standard virtio over MMIO transport layer only supports one
> > > legacy interrupt, which is much heavier than virtio over PCI transport
> > > layer using MSI. Legacy interrupt has long work path and causes specific
> > > VMExits in following cases, which would considerably slow down the
> > > performance:
> > > 
> > > 1) read interrupt status register
> > > 2) update interrupt status register
> > > 3) write IOAPIC EOI register
> > > 
> > > We proposed to update virtio over MMIO to version 3[1] to add the
> > > following new features and enhance the performance.
> > > 
> > > 1) Support Message Signaled Interrupt(MSI), which increases the
> > >     interrupt performance for virtio multi-queue devices
> > > 2) Support per-queue doorbell, so the guest kernel may directly write
> > >     to the doorbells provided by virtio devices.
> > Do we need to come up with new "doorbell" terminology?
> > virtio spec calls these available event notifications,
> > let's stick to this.
> 
> Yes, let's keep virtio words, which just calls notifications.
> 
> > > The following is the network tcp_rr performance testing report, tested
> > > with virtio-pci device, vanilla virtio-mmio device and patched
> > > virtio-mmio device (run test 3 times for each case):
> > > 
> > > 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
> > > 
> > > 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
> > > 	trans/s	    9536	6939		9500
> > > 	trans/s	    9734	7029		9749
> > > 	trans/s	    9894	7095		9318
> > > 
> > > [1]https://lkml.org/lkml/2019/12/20/113
> > > 
> > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > Do we need a new version though? What is wrong with
> > a feature bit? This way we can create compatible devices
> > and drivers.
> 
> We considered using 1 feature bit of 24~37 to specify MSI capability, but
> 
> this feature bit only means for mmio transport layer, but not representing
> 
> comment feature negotiation of the virtio device. So we're not sure if this
> is a good choice.

We are not short on bits, just don't use bits below 32
since these are for legacy devices.


> > > [...]
> > > +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > > +{
> > > +	struct device *dev = desc->dev;
> > > +	struct virtio_device *vdev = dev_to_virtio(dev);
> > > +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> > > +	void __iomem *pos = vm_dev->base;
> > > +	uint16_t cmd = VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
> > > +			desc->platform.msi_index);
> > > +
> > > +	writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> > > +	writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> > > +	writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
> > > +	writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
> > > +}
> > All this can happen when IRQ affinity changes while device
> > is sending interrupts. An interrupt sent between the writel
> > operations will then be directed incorrectly.
> 
> When investigating kernel MSI behavior, I found in most case there's no
> action during IRQ affinity changes to avoid the interrupt coming.
> 
> For example, when migrate_one_irq, it masks the irq before
> irq_do_set_affinity. But for others, like user setting any irq affinity
> 
> via /proc/, it only holds desc->lock instead of disable/mask irq. In such
> case, how can it ensure the interrupt sending between writel ops?

Could be a bug too. E.g. PCI spec explicitly says it's illegal to
change non-masked interrupts exactly for this reason.



> 
> > > [...]
> > > +
> > > +/* RO: MSI feature enabled mask */
> > > +#define VIRTIO_MMIO_MSI_ENABLE_MASK	0x8000
> > I don't understand the comment. Is this a way for
> > a version 3 device to say "I want/do not want MSI"?
> > Why not just use a feature bit? We are not short on these.
> 
> This is just used for current MSI enabled/disabled status, after all MSI
> configurations setup finished.
> 
> Not for showing MSI capability.
> 
> In other words, since the concern of feature bit, we choose to update the
> virtio mmio
> 
> version that devices with v3 have MSI capability and notifications.
> 
> 
> Thanks,
> 
> Jing

MSI looks like an optimization. I don't see how that
justifies incrementing a major version and breaking
compat with all existing guests.

-- 
MST

