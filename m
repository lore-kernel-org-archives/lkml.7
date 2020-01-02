Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACDEC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4F21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgABJNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:13:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:44707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgABJNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:13:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 01:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,386,1571727600"; 
   d="scan'208";a="214099642"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.238.130.173]) ([10.238.130.173])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2020 01:13:28 -0800
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
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
Date:   Thu, 2 Jan 2020 17:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>>
>>>> +
>>>> +/* RO: MSI feature enabled mask */
>>>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK    0x8000
>>>> +/* RO: Maximum queue size available */
>>>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK    0x07ff
>>>> +/* Reserved */
>>>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED    0x7800
>>>> +
>>>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE    0x1
>>>
>>>
>>> I believe we need a command to read the number of vectors supported 
>>> by the device, or 2048 is assumed to be a fixed size here?
>>
>> For not bringing much complexity, we proposed vector per queue and 
>> fixed relationship between events and vectors.
>
>
> It's a about the number of MSIs not the mapping between queues to 
> MSIs.And it looks to me it won't bring obvious complexity, just need a 
> register to read the #MSIs. Device implementation may stick to a fixed 
> size.

Based on that assumption, the device supports #MSIs = #queues + #config. 
Then driver need not read the register.

We're trying to make such kind of agreement on spec level.

>
> Having few pages for a device that only have one queue is kind of a 
> waste.

Could I ask what's the meaning of few pages here? BTW, we didn't define 
MSIx-like tables for virtio-mmio.

Thanks,

Jing

>
> Thanks
>
>
>>
>>
>> So the number of vectors supported by device is equal to the total 
>> number of vqs and config.
>>
>> We will try to explicitly highlight this point in spec for later 
>> version.
>>
>>
>> Thanks!
>>
>> Jing
>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>
>
