Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56156C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 15:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2DC20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 15:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLYPU6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 10:20:58 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57532 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfLYPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 10:20:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TlvFgXf_1577287249;
Received: from 192.168.0.100(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0TlvFgXf_1577287249)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 23:20:50 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
Date:   Wed, 25 Dec 2019 23:20:07 +0800
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        jing2.liu@intel.com, chao.p.peng@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
> 
> 
> On 2019/12/25 上午10:50, Zha Bin wrote:
>> From: Liu Jiang <gerry@linux.alibaba.com>
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
>>    interrupt performance for virtio multi-queue devices
>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>    to the doorbells provided by virtio devices.
>> 
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
>> [1] https://lkml.org/lkml/2019/12/20/113
> 
> 
> Thanks for the patch. Two questions after a quick glance:
> 
> 1) In PCI we choose to support MSI-X instead of MSI for having extra flexibility like alias, independent data and address (e.g for affinity) . Any reason for not start from MSI-X? E.g having MSI-X table and PBA (both of which looks pretty independent).
Hi Jason,
	Thanks for reviewing patches on Christmas Day:)
	The PCI MSI-x has several advantages over PCI MSI, mainly 
1) support 2048 vectors, much more than 32 vectors supported by MSI.
2) dedicated address/data for each vector,
3) per vector mask/pending bits.
The proposed MMIO MSI extension supports both 1) and 2), but the extension doesn’t support 3) because
we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.

On the other hand, we want to simplify VMM implementations as simple as possible, and mimicking the PCI MSI-x
will cause some complexity to VMM implementations.

> 2) It's better to split notify_multiplexer out of MSI support to ease the reviewers (apply to spec patch as well)
Great suggestion, we will try to split the patch.

Thanks,
Gerry

> 
> Thanks

