Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB511C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA73221882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfGCJnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:43:21 -0400
Received: from foss.arm.com ([217.140.110.172]:42802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfGCJnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB52344;
        Wed,  3 Jul 2019 02:43:20 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5CCC3F246;
        Wed,  3 Jul 2019 02:43:17 -0700 (PDT)
Subject: Re: [PATCH] remove the initrd resource in /proc/iomem as the
 initrdhas freed the reserved memblock.
To:     huang.junhua@zte.com.cn
Cc:     wang.yi59@zte.com.cn, catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        f.fainelli@gmail.com, logang@deltatee.com, robin.murphy@arm.com,
        ghackmann@android.com, hannes@cmpxchg.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, jiang.xuexin@zte.com.cn
References: <201907031716177178158@zte.com.cn>
From:   James Morse <james.morse@arm.com>
Message-ID: <8b394f16-5cc5-328c-a1c7-2c2ba352440b@arm.com>
Date:   Wed, 3 Jul 2019 10:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201907031716177178158@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/07/2019 10:16, huang.junhua@zte.com.cn wrote:
>> On 02/07/2019 11:34, Yi Wang wrote:
>>> From: Junhua Huang <huang.junhua@zte.com.cn>
>>> The 'commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")'
>>> show the reserved memblock in /proc/iomem. But the initrd's reserved memblock
>>> will be freed in free_initrd_mem(), which executes after the reserve_memblock_reserved_regions().
>>> So there are some incorrect information shown in /proc/iomem. e.g.:
>>> 80000000-bbdfffff : System RAM
>>>   80080000-813effff : Kernel code
>>>   813f0000-8156ffff : reserved
>>>   81570000-817fcfff : Kernel data
>>>   83400000-83ffffff : reserved
>>>   90000000-90004fff : reserved
>>>   b0000000-b2618fff : reserved
>>>   b8c00000-bbbfffff : reserved
>>> In this case, the range from b0000000 to b2618fff is reserved for initrd, which should be
>>> clean from the resource tree after it was freed.
>>
>> (There was some discussion about this over-estimate on the list, but it didn't make it
>> into the commit message.) I think a reserved->free change is fine. If user-space thinks
>> its still reserved nothing bad happens.

>>> As kexec-tool will collect the iomem reserved info 
>>> and use it in second kernel, which causes error message generated a second time.

>> What error message?

> Sorry, it's my mistake. The kexec-tool could not use iomem reserved info in the second kernel.
> The error message I mean is that the initrd reserved memblock region will be shown in 
> second kernel /proc/iomem. But this message comes from the dtb's memreserve node, 
> not the first kernel /proc/iomem.

This doesn't sound right.
Is kexec-tool spraying anything reserved in /proc/iomem into the DT as memreserve?


These top-level 'nomap' and second-level 'reserved' entries exist to stop kexec-tools
trying to write the new kernel over the top of something important. This only matters
between 'load' and 'exec' during the #1-kernel:

| kexec-tools reads /proc/iomem.
| kexec-tools tells #1-kernel "I want this 10MB image to be located at 0xf00".
| #1-kernel knows 0xf00 is in use, so it stores the data else where until kexec-time.
[some time passes]
| #1-kernel kexec's, copying the image to 0xf00
| #2-kernel now owns the machine

This goes wrong if 0xf00 belonged to firmware (nomap), or contained something important
(uefi memory map, acpi tables etc).

Once the second kernel has started running it should re-discover where this important
stuff is from the EFI and ACPI tables.

We deliberately over-estimate these second-level reserved regions as its the simplest
thing to do. (e.g. the per-cpu chunk allocations get swept up too)


Does this mean the amount of usable memory in the system reduces each time you kexec? That
shouldn't be true!


Thanks,

James
