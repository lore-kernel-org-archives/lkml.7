Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE27C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37290206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfI0GU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:20:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfI0GU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:20:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42AC328;
        Thu, 26 Sep 2019 23:20:27 -0700 (PDT)
Received: from [10.162.41.136] (p8cg001049571a15.blr.arm.com [10.162.41.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1FC93F739;
        Thu, 26 Sep 2019 23:23:00 -0700 (PDT)
Subject: Re: [PATCH v3] arm64: use generic free_initrd_mem()
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1569388180-28274-1-git-send-email-rppt@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <76b49810-c59f-8cf1-7401-1f7262873601@arm.com>
Date:   Fri, 27 Sep 2019 11:50:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1569388180-28274-1-git-send-email-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/25/2019 10:39 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> arm64 calls memblock_free() for the initrd area in its implementation of
> free_initrd_mem(), but this call has no actual effect that late in the boot
> process. By the time initrd is freed, all the reserved memory is managed by
> the page allocator and the memblock.reserved is unused, so the only purpose
> of the memblock_free() call is to keep track of initrd memory for debugging
> and accounting.
> 
> Without the memblock_free() call the only difference between arm64 and the
> generic versions of free_initrd_mem() is the memory poisoning.
> 
> Move memblock_free() call to the generic code, enable it there
> for the architectures that define ARCH_KEEP_MEMBLOCK and use the generic
> implementaion of free_initrd_mem() on arm64.

Small nit. s/implementaion/implementation.

> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
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
>  init/initramfs.c     |  5 +++++
>  2 files changed, 5 insertions(+), 12 deletions(-)
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
> index c47dad0..3d61e13 100644
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
> @@ -531,6 +532,10 @@ void __weak free_initrd_mem(unsigned long start, unsigned long end)
>  {
>  	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
>  			"initrd");
> +
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK

Should not the addresses here be aligned first before calling memblock_free() ?
Without alignment, it breaks present behavior on arm64 which was explicitly added
with 13776f9d40a0 ("arm64: mm: free the initrd reserved memblock in a aligned manner").
Or does initrd always gets allocated with page alignment on other architectures.

> +	memblock_free(__pa(start), end - start);
> +#endif
>  }
>  
>  #ifdef CONFIG_KEXEC_CORE
> 
