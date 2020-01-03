Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 06:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D0D217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 06:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgACGPg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 01:15:36 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44094 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgACGPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 01:15:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=gerry@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TmiGTtC_1578032116;
Received: from 127.0.0.1(mailfrom:gerry@linux.alibaba.com fp:SMTPD_---0TmiGTtC_1578032116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 14:15:20 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
From:   "Liu, Jiang" <gerry@linux.alibaba.com>
In-Reply-To: <0c3d33de-3940-7895-2fe2-81de8714139c@redhat.com>
Date:   Fri, 3 Jan 2020 14:14:20 +0800
Cc:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, mst@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <46806720-1D1C-40C3-BEE2-EDB0D4DA39BF@linux.alibaba.com>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
 <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
 <0c3d33de-3940-7895-2fe2-81de8714139c@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 3, 2020, at 11:24 AM, Jason Wang <jasowang@redhat.com> wrote:
> 
> 
> On 2020/1/2 下午5:13, Liu, Jing2 wrote:
>> [...]
>> 
>>>>> 
>>>>>> +
>>>>>> +/* RO: MSI feature enabled mask */
>>>>>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK    0x8000
>>>>>> +/* RO: Maximum queue size available */
>>>>>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK    0x07ff
>>>>>> +/* Reserved */
>>>>>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED    0x7800
>>>>>> +
>>>>>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE    0x1
>>>>> 
>>>>> 
>>>>> I believe we need a command to read the number of vectors supported by the device, or 2048 is assumed to be a fixed size here?
>>>> 
>>>> For not bringing much complexity, we proposed vector per queue and fixed relationship between events and vectors.
>>> 
>>> 
>>> It's a about the number of MSIs not the mapping between queues to MSIs.And it looks to me it won't bring obvious complexity, just need a register to read the #MSIs. Device implementation may stick to a fixed size.
>> 
>> Based on that assumption, the device supports #MSIs = #queues + #config. Then driver need not read the register.
>> 
>> We're trying to make such kind of agreement on spec level.
> 
> 
> Ok, I get you now.
> 
> But still, having fixed number of MSIs is less flexible. E.g:
> 
> - for x86, processor can only deal with about 250 interrupt vectors.
> - driver may choose to share MSI vectors [1] (which is not merged but we will for sure need it)
Thanks for the info:)
X86 systems roughly have NCPU * 200 vectors available for device interrupts.
The proposed patch tries to map multiple event sources to an interrupt vector, to avoid running out of x86 CPU vectors.
Many virtio mmio devices may have several or tens of event sources, and it’s rare to have hundreds of event sources.
So could we treat the dynamic mapping between event sources and interrupt vectors as an advanced optional feature?

> 
> [1] https://lkml.org/lkml/2014/12/25/169
> 
> 
>> 
>>> 
>>> Having few pages for a device that only have one queue is kind of a waste.
>> 
>> Could I ask what's the meaning of few pages here? BTW, we didn't define MSIx-like tables for virtio-mmio.
> 
> 
> I thought you're using a fixed size (2048) for each device. But looks not :)
> 
> Thanks
> 
> 
>> 
>> Thanks,
>> 
>> Jing
>> 
>>> 
>>> Thanks
>>> 
>>> 
>>>> 
>>>> 
>>>> So the number of vectors supported by device is equal to the total number of vqs and config.
>>>> 
>>>> We will try to explicitly highlight this point in spec for later version.
>>>> 
>>>> 
>>>> Thanks!
>>>> 
>>>> Jing
>>>> 
>>>>> 
>>>>> ---------------------------------------------------------------------
>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>> 
>>>> 
>>> 
>> 
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

