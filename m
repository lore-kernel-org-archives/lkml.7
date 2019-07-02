Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8035C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77D62146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGBPSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:18:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfGBPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:18:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C99328;
        Tue,  2 Jul 2019 08:18:18 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E647C3F246;
        Tue,  2 Jul 2019 08:18:15 -0700 (PDT)
Subject: Re: [PATCH] remove the initrd resource in /proc/iomem as the initrd
 has freed the reserved memblock.
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        f.fainelli@gmail.com, logang@deltatee.com, robin.murphy@arm.com,
        ghackmann@android.com, hannes@cmpxchg.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, jiang.xuexin@zte.com.cn,
        Junhua Huang <huang.junhua@zte.com.cn>
References: <1562063693-1541-1-git-send-email-wang.yi59@zte.com.cn>
From:   James Morse <james.morse@arm.com>
Message-ID: <0bb7eebf-0db9-50d1-b5fc-41e2f0083b15@arm.com>
Date:   Tue, 2 Jul 2019 16:18:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562063693-1541-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 02/07/2019 11:34, Yi Wang wrote:
> From: Junhua Huang <huang.junhua@zte.com.cn>
> 
> The 'commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")'
> show the reserved memblock in /proc/iomem. But the initrd's reserved memblock
> will be freed in free_initrd_mem(), which executes after the reserve_memblock_reserved_regions().
> So there are some incorrect information shown in /proc/iomem. e.g.:
> 80000000-bbdfffff : System RAM
>   80080000-813effff : Kernel code
>   813f0000-8156ffff : reserved
>   81570000-817fcfff : Kernel data
>   83400000-83ffffff : reserved
>   90000000-90004fff : reserved
>   b0000000-b2618fff : reserved
>   b8c00000-bbbfffff : reserved
> In this case, the range from b0000000 to b2618fff is reserved for initrd, which should be
> clean from the resource tree after it was freed.

(There was some discussion about this over-estimate on the list, but it didn't make it
into the commit message.) I think a reserved->free change is fine. If user-space thinks
its still reserved nothing bad happens.


> As kexec-tool will collect the iomem reserved info 
> and use it in second kernel, which causes error message generated a second time.

What error message?

These second-level reserved regions are to avoid kexec overwriting ACPI tables, or bits of
the UEFI memory map with its data.

The second kernel should not expect to find the initramfs here...


> At the same time, we should free the reserved memblock in an aligned manner because 
> the initrd reserves the memblock in an aligned manner in arm64_memblock_init(). 
> Otherwise there are some fragments in memblock_reserved regions. e.g.:
> /sys/kernel/debug/memblock # cat reserved 
>    0: 0x0000000080080000..0x00000000817fafff
>    1: 0x0000000083400000..0x0000000083ffffff
>    2: 0x0000000090000000..0x000000009000407f
>    3: 0x00000000b0000000..0x00000000b000003f
>    4: 0x00000000b26184ea..0x00000000b2618fff
> The fragments like the ranges from b0000000 to b000003f and from b26184ea to b2618fff 
> should be freed.

I agree we should fix this. Could it be done as a separate patch, as this is a different
issue?


> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d2adffb81b5d..14ba8113eab5 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -580,8 +580,16 @@ void free_initmem(void)
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +	struct resource *res = NULL;

>  	free_reserved_area((void *)start, (void *)end, 0, "initrd");

Could we do this last? This calls __free_pages(), once we've done that it could be
allocated somewhere else, but memblock and iomem still say this is reserved memory.


> -	memblock_free(__virt_to_phys(start), end - start);
> +	start = __virt_to_phys(start) & PAGE_MASK;
> +	end = PAGE_ALIGN(__virt_to_phys(end));
> +	memblock_free(start, end - start);

> +	res = lookup_resource(&iomem_resource, memblock_start_of_DRAM());
> +	if (res != NULL)

("if (res)" is the preferred style)

> +		__release_region(res, start, end - start);

Hmm, I can't see where __release_region() splits start/end out of an existing resource...

I think this means if you have memblock_reserved() pages either size of the initramfs they
get merged by memblock and put into iomem_resource as one entry. We'd hit
__release_regions()s:
|		if (res->start != start || res->end != end)
|			break;
[...]
|	printk(KERN_WARNING "Trying to free nonexistent resource "
|		"<%016llx-%016llx>\n", (unsigned long long)start,
|		(unsigned long long)end);

It looks like __release_region() is only for exactly the region you reserved. We need it
to split one resource into two, the reverse of what reserve_region_with_split() does.

I can't see a helper that would do this.


An alternative is to explicitly create an iomem_resource for the initramfs, like we do for
the kernel text/data. reserve_region_with_split() will then fill in the gaps around it if
there are any, and you can pass it to release_resource() in here instead of searching for it.

It should be possible to test by rounding the initramfs base/size in arm64_memblock_init()
by a bit more.


Thanks,

James
