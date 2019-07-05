Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F27C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CAD21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfGEKvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:51:08 -0400
Received: from foss.arm.com ([217.140.110.172]:35804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfGEKvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:51:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D92252B;
        Fri,  5 Jul 2019 03:51:06 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA563F703;
        Fri,  5 Jul 2019 03:51:01 -0700 (PDT)
Subject: Re: [PATCH] remove the initrd resource in /proc/iomem as theinitrdhas
 freed the reserved memblock.
To:     huang.junhua@zte.com.cn
Cc:     wang.yi59@zte.com.cn, catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        f.fainelli@gmail.com, logang@deltatee.com, robin.murphy@arm.com,
        ghackmann@android.com, hannes@cmpxchg.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, jiang.xuexin@zte.com.cn,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <201907031942125390348@zte.com.cn>
From:   James Morse <james.morse@arm.com>
Message-ID: <d25eadb8-266f-6b95-d375-1c2db2144e5f@arm.com>
Date:   Fri, 5 Jul 2019 11:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201907031942125390348@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(CC: +devicetree list:
memreserving the initrd, which linux then frees causes a zombie memreserve in all future
kexec'd kernels)

On 03/07/2019 12:42, huang.junhua@zte.com.cn wrote:
>>>> On 02/07/2019 11:34, Yi Wang wrote:
>>>>> From: Junhua Huang <huang.junhua@zte.com.cn>
>>>>> The 'commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")'
>>>>> show the reserved memblock in /proc/iomem. But the initrd's reserved memblock
>>>>> will be freed in free_initrd_mem(), which executes after the reserve_memblock_reserved_regions().
>>>>> So there are some incorrect information shown in /proc/iomem. e.g.:
>>>>> 80000000-bbdfffff : System RAM
>>>>>   80080000-813effff : Kernel code
>>>>>   813f0000-8156ffff : reserved
>>>>>   81570000-817fcfff : Kernel data
>>>>>   83400000-83ffffff : reserved
>>>>>   90000000-90004fff : reserved
>>>>>   b0000000-b2618fff : reserved
>>>>>   b8c00000-bbbfffff : reserved
>>>>> In this case, the range from b0000000 to b2618fff is reserved for initrd, which should be
>>>>> clean from the resource tree after it was freed.
>>>>
>>>> (There was some discussion about this over-estimate on the list, but it didn't make it
>>>> into the commit message.) I think a reserved->free change is fine. If user-space thinks
>>>> its still reserved nothing bad happens.
>>
>>>>> As kexec-tool will collect the iomem reserved info 
>>>>> and use it in second kernel, which causes error message generated a second time.
>>
>>>> What error message?
>>
>>> Sorry, it's my mistake. The kexec-tool could not use iomem reserved info in the second kernel.
>>> The error message I mean is that the initrd reserved memblock region will be shown in 
>>> second kernel /proc/iomem. But this message comes from the dtb's memreserve node, 
>>> not the first kernel /proc/iomem.
>>
>> This doesn't sound right.
>> Is kexec-tool spraying anything reserved in /proc/iomem into the DT as memreserve?

> No, it isn't. The kexec-tool could not spray resserved info to DT as memreserve.

(well, it generates the second DT, and it has the reserved /proc/iomem entries on hand)


> After we started the kernel from uboot, the /sys/firmware/fdt in this kernel has been add some infos,
> incluing the dtb memreserve and ramdisk memreserve info.

Aha! Ugh.
arm64_memblock_init() memblock_reserves() this, as does fdt_init_reserved_mem().
But then we memblock_free() it in free_initrd_mem().


> And then we use this fdt as the kexec dtb, and the second kernel would read 
> the memreserve node and reserve the memblock.

> So we can see the first kernel initrd reserved info from the second kernel /proc/iomem.

[...]

> This phenomenon is not caused by first kernel /proc/iomem or kexec, but dtb.

Right, so the options are:

(1) Delete the memreserve node from the DT when we free the initrd. I don't think this is
the sort of thing the kernel should be doing.

(2) Memreserving the initramfs implies 'keepinitrd' on the commandline. The DT has told us
to "exclude reserved memory from normal usage". If the bootloader didn't mean for us to
reserve this memory forever, it should drop the memreserve.

(3) kexec-tools determines this memreserve is no longer needed and removes it from the new
DT. It has the details to do this: /sys/firmware/fdt will show the physical addresses of
the initramfs. With your patch /proc/iomem will show that this region is regular memory.
(not covered by any reserved type). This is safe with older kernels.


My preference is 2 then 3.

[...]

> I agree. The kexec-tool will use the second-level reserved info to avoid the load address 
> conflict with the important thing, It is true that if the image load address kexec-tools set 
> would belong to other important thing, something would go wrong. 
> So I think we need clean the initrd reserved info from /proc/iomem, it is useless.

If we've freed the memory and we can update that file, sure.
I think at the time of that patch the assumption was only the arch code does
memblock_reserve() early, so we never need to update /proc/iomem.


Thanks,

James
