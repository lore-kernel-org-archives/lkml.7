Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3EC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B018C20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgAIGPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:15:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:1180 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgAIGPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:15:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 22:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,412,1571727600"; 
   d="scan'208";a="223775552"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.238.130.147]) ([10.238.130.147])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2020 22:15:52 -0800
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <20200105054412-mutt-send-email-mst@kernel.org>
Message-ID: <c7a8fc93-9493-c0b3-623a-02426995f0f8@linux.intel.com>
Date:   Thu, 9 Jan 2020 14:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200105054412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2020 7:04 PM, Michael S. Tsirkin wrote:
> On Wed, Dec 25, 2019 at 10:50:23AM +0800, Zha Bin wrote:
>> From: Liu Jiang<gerry@linux.alibaba.com>
>>
>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>> virtio over mmio devices as a lightweight machine model for modern
>> cloud. The standard virtio over MMIO transport layer only supports one
>> legacy interrupt, which is much heavier than virtio over PCI transport
>> layer using MSI. Legacy interrupt has long work path and causes specific
>> VMExits in following cases, which would considerably slow down the
>> performance:
>>
>> 1) read interrupt status register
>> 2) update interrupt status register
>> 3) write IOAPIC EOI register
>>
>> We proposed to update virtio over MMIO to version 3[1] to add the
>> following new features and enhance the performance.
>>
>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>     interrupt performance for virtio multi-queue devices
>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>     to the doorbells provided by virtio devices.
> Do we need to come up with new "doorbell" terminology?
> virtio spec calls these available event notifications,
> let's stick to this.

Yes, let's keep virtio words, which just calls notifications.

>> The following is the network tcp_rr performance testing report, tested
>> with virtio-pci device, vanilla virtio-mmio device and patched
>> virtio-mmio device (run test 3 times for each case):
>>
>> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>
>> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>> 	trans/s	    9536	6939		9500
>> 	trans/s	    9734	7029		9749
>> 	trans/s	    9894	7095		9318
>>
>> [1]https://lkml.org/lkml/2019/12/20/113
>>
>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> Do we need a new version though? What is wrong with
> a feature bit? This way we can create compatible devices
> and drivers.

We considered using 1 feature bit of 24~37 to specify MSI capability, but

this feature bit only means for mmio transport layer, but not representing

comment feature negotiation of the virtio device. So we're not sure if 
this is a good choice.

>> [...]
>>   
>> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>> +{
>> +	struct device *dev = desc->dev;
>> +	struct virtio_device *vdev = dev_to_virtio(dev);
>> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>> +	void __iomem *pos = vm_dev->base;
>> +	uint16_t cmd = VIRTIO_MMIO_MSI_CMD(VIRTIO_MMIO_MSI_CMD_UPDATE,
>> +			desc->platform.msi_index);
>> +
>> +	writel(msg->address_lo, pos + VIRTIO_MMIO_MSI_ADDRESS_LOW);
>> +	writel(msg->address_hi, pos + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
>> +	writel(msg->data, pos + VIRTIO_MMIO_MSI_DATA);
>> +	writew(cmd, pos + VIRTIO_MMIO_MSI_COMMAND);
>> +}
> All this can happen when IRQ affinity changes while device
> is sending interrupts. An interrupt sent between the writel
> operations will then be directed incorrectly.

When investigating kernel MSI behavior, I found in most case there's no 
action during IRQ affinity changes to avoid the interrupt coming.

For example, when migrate_one_irq, it masks the irq before 
irq_do_set_affinity. But for others, like user setting any irq affinity

via /proc/, it only holds desc->lock instead of disable/mask irq. In 
such case, how can it ensure the interrupt sending between writel ops?


>> [...]
>> +
>> +/* RO: MSI feature enabled mask */
>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK	0x8000
> I don't understand the comment. Is this a way for
> a version 3 device to say "I want/do not want MSI"?
> Why not just use a feature bit? We are not short on these.

This is just used for current MSI enabled/disabled status, after all MSI 
configurations setup finished.

Not for showing MSI capability.

In other words, since the concern of feature bit, we choose to update 
the virtio mmio

version that devices with v3 have MSI capability and notifications.


Thanks,

Jing

