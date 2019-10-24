Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5137DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C24921872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393190AbfJXKH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:07:26 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46852 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJXKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:07:26 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 32F3F25B768;
        Thu, 24 Oct 2019 21:07:23 +1100 (AEDT)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 8C36236BD; Thu, 24 Oct 2019 12:07:20 +0200 (CEST)
Date:   Thu, 24 Oct 2019 12:07:20 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        Thomas.Lendacky@amd.com, bhe@redhat.com, x86@kernel.org,
        kexec@lists.infradead.org, dhowells@redhat.com, mingo@redhat.com,
        bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com,
        tglx@linutronix.de, dyoung@redhat.com, vgoyal@redhat.com,
        d.hatayama@fujitsu.com
Subject: Re: [PATCH 1/2 v5] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191024100719.GC11441@verge.net.au>
References: <20191023141912.29110-1-lijiang@redhat.com>
 <20191023141912.29110-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023141912.29110-2-lijiang@redhat.com>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linbo,

thanks for your patch.

On Wed, Oct 23, 2019 at 10:19:11PM +0800, Lianbo Jiang wrote:
> Kdump kernel will reuse the first 640k region because the real mode
> trampoline has to work in this area. When the vmcore is dumped, the
> old memory in this area may be accessed, therefore, kernel has to
> copy the contents of the first 640k area to a backup region so that
> kdump kernel can read the old memory from the backup area of the
> first 640k area, which is done in the purgatory().
> 
> But, the current handling of copying the first 640k area runs into
> problems when SME is enabled, kernel does not properly copy these
> old memory to the backup area in the purgatory(), thereby, kdump
> kernel reads out the encrypted contents, because the kdump kernel
> must access the first kernel's memory with the encryption bit set
> when SME is enabled in the first kernel. Please refer to this link:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
> 
> Finally, it causes the following errors, and the crash tool gets
> invalid pointers when parsing the vmcore.
> 
> crash> kmem -s|grep -i invalid
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
> crash>
> 
> To avoid the above errors, when the crashkernel option is specified,
> lets reserve the remaining low 1MiB memory(after reserving real mode
> memory) so that the allocated memory does not fall into the low 1MiB
> area, which makes us not to copy the first 640k content to a backup
> region in purgatory(). This indicates that it does not need to be
> included in crash dumps or used for anything except the processor
> trampolines that must live in the low 1MiB.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> BTW:I also tried to fix the above problem in purgatory(), but there
> are too many restricts in purgatory() context, for example: i can't
> allocate new memory to create the identity mapping page table for
> SME situation.
> 
> Currently, there are two places where the first 640k area is needed,
> the first one is in the find_trampoline_placement(), another one is
> in the reserve_real_mode(), and their content doesn't matter.
> 
> In addition, also need to clean all the code related to the backup
> region later.
> 
>  arch/x86/realmode/init.c |  2 ++
>  include/linux/kexec.h    |  2 ++
>  kernel/kexec_core.c      | 13 +++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 7dce39c8c034..064cc79a015d 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -3,6 +3,7 @@
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/set_memory.h>
>  #include <asm/pgtable.h>
> @@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
>  
>  	memblock_reserve(mem, size);
>  	set_real_mode_mem(mem);
> +	kexec_reserve_low_1MiB();
>  }
>  
>  static void __init setup_real_mode(void)
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 1776eb2e43a4..30acf1d738bc 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -306,6 +306,7 @@ extern void __crash_kexec(struct pt_regs *);
>  extern void crash_kexec(struct pt_regs *);
>  int kexec_should_crash(struct task_struct *);
>  int kexec_crash_loaded(void);
> +void __init kexec_reserve_low_1MiB(void);
>  void crash_save_cpu(struct pt_regs *regs, int cpu);
>  extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  
> @@ -397,6 +398,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
>  static inline void crash_kexec(struct pt_regs *regs) { }
>  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>  static inline int kexec_crash_loaded(void) { return 0; }
> +static inline void __init kexec_reserve_low_1MiB(void) { }
>  #define kexec_in_progress false
>  #endif /* CONFIG_KEXEC_CORE */
>  
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 15d70a90b50d..5bd89f1fee42 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/frame.h>
> +#include <linux/memblock.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -70,6 +71,18 @@ struct resource crashk_low_res = {
>  	.desc  = IORES_DESC_CRASH_KERNEL
>  };
>  
> +/*
> + * When the crashkernel option is specified, only use the low
> + * 1MiB for the real mode trampoline.
> + */
> +void __init kexec_reserve_low_1MiB(void)
> +{
> +	if (strstr(boot_command_line, "crashkernel=")) {

Could you comment on the issue of using strstr which
was raised by Hatayama-san in response to an earlier revision
of this patch?

Thanks in advance!

> +		memblock_reserve(0, 1<<20);
> +		pr_info("Reserving the low 1MiB of memory for crashkernel\n");
> +	}
> +}
> +
>  int kexec_should_crash(struct task_struct *p)
>  {
>  	/*
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
