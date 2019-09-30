Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42020C388F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23588218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfI3FYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:24:30 -0400
Received: from foss.arm.com ([217.140.110.172]:47314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3FY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1964228;
        Sun, 29 Sep 2019 22:24:29 -0700 (PDT)
Received: from [10.162.43.119] (p8cg001049571a15.blr.arm.com [10.162.43.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D583F739;
        Sun, 29 Sep 2019 22:27:03 -0700 (PDT)
Subject: Re: [PATCH v4] arm64: use generic free_initrd_mem()
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1569657746-31672-1-git-send-email-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4267bfb4-db55-49a5-634f-7d1b1fce650e@arm.com>
Date:   Mon, 30 Sep 2019 10:54:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1569657746-31672-1-git-send-email-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/28/2019 01:32 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> arm64 calls memblock_free() for the initrd area in its implementation of
> free_initrd_mem(), but this call has no actual effect that late in the boot
> process. By the time initrd is freed, all the reserved memory is managed by
> the page allocator and the memblock.reserved is unused, so the only purpose
> of the memblock_free() call is to keep track of initrd memory for debugging
> and accounting.

Thats correct. memblock_free_all() gets called before free_initrd_mem().

> 
> Without the memblock_free() call the only difference between arm64 and the
> generic versions of free_initrd_mem() is the memory poisoning.
> 
> Move memblock_free() call to the generic code, enable it there
> for the architectures that define ARCH_KEEP_MEMBLOCK and use the generic
> implementation of free_initrd_mem() on arm64.

This improves free_initrd_mem() generic implementation for others to use.

> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Tested-by: Anshuman Khandual <anshuman.khandual@arm.com>	#arm64
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> 
> v4:
> * memblock_free() aligned area around the initrd
> 
> v3:
> * fix powerpc build
> 
> v2:
> * add memblock_free() to the generic free_initrd_mem()
> * rebase on the current upstream
> 
> 
>  arch/arm64/mm/init.c | 12 ------------
>  init/initramfs.c     |  8 ++++++++
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 45c00a5..87a0e3b 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -580,18 +580,6 @@ void free_initmem(void)
>  	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
>  }
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	unsigned long aligned_start, aligned_end;
> -
> -	aligned_start = __virt_to_phys(start) & PAGE_MASK;
> -	aligned_end = PAGE_ALIGN(__virt_to_phys(end));
> -	memblock_free(aligned_start, aligned_end - aligned_start);
> -	free_reserved_area((void *)start, (void *)end, 0, "initrd");
> -}
> -#endif
> -
>  /*
>   * Dump out memory limit information on panic.
>   */
> diff --git a/init/initramfs.c b/init/initramfs.c
> index c47dad0..8ec1be4 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -10,6 +10,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/utime.h>
>  #include <linux/file.h>
> +#include <linux/memblock.h>
>  
>  static ssize_t __init xwrite(int fd, const char *p, size_t count)
>  {
> @@ -529,6 +530,13 @@ extern unsigned long __initramfs_size;
>  
>  void __weak free_initrd_mem(unsigned long start, unsigned long end)
>  {
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
> +	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
> +
> +	memblock_free(__pa(aligned_start), aligned_end - aligned_start);
> +#endif
> +
>  	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
>  			"initrd");
>  }
> 
