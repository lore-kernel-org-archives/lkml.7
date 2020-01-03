Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9BAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 06:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01842084D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 06:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgACGvT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 01:51:19 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44591 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgACGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 01:51:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TmiZm5._1578034269;
Received: from 127.0.0.1(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0TmiZm5._1578034269)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 14:51:13 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <16000124-bf6f-5762-845c-80514d1e6ea7@redhat.com>
Date:   Fri, 3 Jan 2020 14:50:13 +0800
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        jing2.liu@intel.com, chao.p.peng@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <05C9E588-82A0-469D-9364-9ECF9EBE0531@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
 <16000124-bf6f-5762-845c-80514d1e6ea7@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 2, 2020, at 2:28 PM, Jason Wang <jasowang@redhat.com> wrote:
> 
> 
> On 2019/12/26 下午9:16, Liu, Jiang wrote:
>> 
>>> On Dec 26, 2019, at 4:09 PM, Jason Wang <jasowang@redhat.com> wrote:
>>> 
>>> 
>>> On 2019/12/25 下午11:20, Liu, Jiang wrote:
>>>>> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
>>>>> 
>>>>> 
>>>>> On 2019/12/25 上午10:50, Zha Bin wrote:
>>>>>> From: Liu Jiang <gerry@linux.alibaba.com>
>>>>>> 
>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>>> cloud. The standard virtio over MMIO transport layer only supports one
>>>>>> legacy interrupt, which is much heavier than virtio over PCI transport
>>>>>> layer using MSI. Legacy interrupt has long work path and causes specific
>>>>>> VMExits in following cases, which would considerably slow down the
>>>>>> performance:
>>>>>> 
>>>>>> 1) read interrupt status register
>>>>>> 2) update interrupt status register
>>>>>> 3) write IOAPIC EOI register
>>>>>> 
>>>>>> We proposed to update virtio over MMIO to version 3[1] to add the
>>>>>> following new features and enhance the performance.
>>>>>> 
>>>>>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>>>>>    interrupt performance for virtio multi-queue devices
>>>>>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>>>>>    to the doorbells provided by virtio devices.
>>>>>> 
>>>>>> The following is the network tcp_rr performance testing report, tested
>>>>>> with virtio-pci device, vanilla virtio-mmio device and patched
>>>>>> virtio-mmio device (run test 3 times for each case):
>>>>>> 
>>>>>> 	netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>>>>> 
>>>>>> 		Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>>>>>> 	trans/s	    9536	6939		9500
>>>>>> 	trans/s	    9734	7029		9749
>>>>>> 	trans/s	    9894	7095		9318
>>>>>> 
>>>>>> [1] https://lkml.org/lkml/2019/12/20/113
>>>>> Thanks for the patch. Two questions after a quick glance:
>>>>> 
>>>>> 1) In PCI we choose to support MSI-X instead of MSI for having extra flexibility like alias, independent data and address (e.g for affinity) . Any reason for not start from MSI-X? E.g having MSI-X table and PBA (both of which looks pretty independent).
>>>> Hi Jason,
>>>> 	Thanks for reviewing patches on Christmas Day:)
>>>> 	The PCI MSI-x has several advantages over PCI MSI, mainly
>>>> 1) support 2048 vectors, much more than 32 vectors supported by MSI.
>>>> 2) dedicated address/data for each vector,
>>>> 3) per vector mask/pending bits.
>>>> The proposed MMIO MSI extension supports both 1) and 2),
>>> 
>>> Aha right, I mis-read the patch. But more questions comes:
>>> 
>>> 1) The association between vq and MSI-X vector is fixed. This means it can't work for a device that have more than 2047 queues. We probably need something similar to virtio-pci to allow a dynamic association.
>> We have considered both the PCI MSI-x like dynamic association design and fix mapping design.
>> The fix mapping design simplifies both the interrupt configuration process and VMM implementations.
> 
> 
> Well, for VMM just an indirection and for guest, it can choose to use fixed mapping, just need to program once during probe.
> 
> 
>> And the virtio mmio transport layer is mainly used by light VMMs to support small scale virtual machines,
> 
> 
> Let's not limit the interface to be used by a specific case :). Eliminating PCIE would be appealing for other scenarios.
> 
> 
>>   2048 vectors should be enough for these usage cases.
>> So the fix mapping design has been used.
>> 
>>> 2) The mask and unmask control is missed
>>> 
>>> 
>>>>  but the extension doesn’t support 3) because
>>>> we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.
>>> 
>>> Not directly used but masking/unmasking is widely used in irq subsystem which allows lots of optimizations.
>>> 
>>> 
>>>> On the other hand, we want to simplify VMM implementations as simple as possible, and mimicking the PCI MSI-x
>>>> will cause some complexity to VMM implementations.
>>> 
>>> I agree to simplify VMM implementation, but it looks to me introducing masking/pending won't cost too much code in the VMM implementation. Just new type of command for VIRTIO_MMIO_MSI_COMMAND.
>> We want to make VMM implementations as simple as possible:)
>> And based on following observations, we have disabled support of mask/unmask,
>> 1) MSI is edge triggering, which means it won’t be shared with other interrupt sources,
> 
> 
> Is this true? I think the spec does not forbid such usages, e.g using the same MSI address/command for different queues or devices?
Yes, the spec doesn’t forbid this.
We could share the same MSIx vector for multiple queues, rx/tax etc.
But we can’t share a Linux MSI interrupt for different devices/MSIx vectors, this is an implementation constraint of the Linux interrupt subsystem.

> 
> 
>> so masking/unmasking won’t be used for normal interrupt management logic.
>> 2) Linux virtio mmio transport layer doesn’t support  suspend/resume yet, so there’s no need to quiesce the device by masking interrupts.
> 
> 
> Yes, but it's a limitation only for virtio mmio transport. We can add it.
> 
> 
>> 3) The legacy PCI 2.2 devices doesn’t support irq masking/unmasking, so irq masking/unmasking may be optional operations.
> 
> 
> Yes, but as you said, it helps for performance and some other cases. I still prefer to implement that consider it is not complex. If we do MSI without masking/unmasking, I suspect we will implement MSI-X finally somedays then maintaining MSI will become a burden... (still takes virtio-pci as an example, it choose to implement MSI-X not MSI).
> 
> 
>> So we skipped support of irq masking/unmasking. We will recheck whether irq masking/unmasking is mandatory for MMIO devices.
>> On the other hand, we may enhance the spec to define command codes for masking/unmasking, and VMM may optionally support masking/unmasking.
> 
> 
> Yes, thanks.
> 
> 
>> 
>> Thanks,
>> Gerry
>> 
>>> Thanks
>>> 
>>> 
>>>>> 2) It's better to split notify_multiplexer out of MSI support to ease the reviewers (apply to spec patch as well)
>>>> Great suggestion, we will try to split the patch.
>>>> 
>>>> Thanks,
>>>> Gerry
>>>> 
>>>>> Thanks

