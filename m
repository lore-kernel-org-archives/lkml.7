Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B11C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F15206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFEUIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:08:05 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:37188 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfFEUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:08:05 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-64-161-nat.elisa-mobile.fi [85.76.64.161])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id B9366400BA;
        Wed,  5 Jun 2019 23:08:00 +0300 (EEST)
Date:   Wed, 5 Jun 2019 23:08:00 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc: fix kexec failure on book3s/32
Message-ID: <20190605200800.GK3538@darkstar.musicnaut.iki.fi>
References: <56efc3b317622d5f607d1f7a35894b194c385492.1559549824.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56efc3b317622d5f607d1f7a35894b194c385492.1559549824.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 03, 2019 at 08:20:28AM +0000, Christophe Leroy wrote:
> In the old days, _PAGE_EXEC didn't exist on 6xx aka book3s/32.
> Therefore, allthough __mapin_ram_chunk() was already mapping kernel
> text with PAGE_KERNEL_TEXT and the rest with PAGE_KERNEL, the entire
> memory was executable. Part of the memory (first 512kbytes) was
> mapped with BATs instead of page table, but it was also entirely
> mapped as executable.
> 
> In commit 385e89d5b20f ("powerpc/mm: add exec protection on
> powerpc 603"), we started adding exec protection to some 6xx, namely
> the 603, for pages mapped via pagetables.
> 
> Then, in commit 63b2bc619565 ("powerpc/mm/32s: Use BATs for
> STRICT_KERNEL_RWX"), the exec protection was extended to BAT mapped
> memory, so that really only the kernel text could be executed.
> 
> The problem here is that kexec is based on copying some code into
> upper part of memory then executing it from there in order to install
> a fresh new kernel at its definitive location.
> 
> However, the code is position independant and first part of it is
> just there to deactivate the MMU and jump to the second part. So it
> is possible to run this first part inplace instead of running the
> copy. Once the MMU is off, there is no protection anymore and the
> second part of the code will just run as before.
> 
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  Aaro, can you test this patch ? Thanks.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

>  arch/powerpc/include/asm/kexec.h       | 3 +++
>  arch/powerpc/kernel/machine_kexec_32.c | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 4a585cba1787..c68476818753 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -94,6 +94,9 @@ static inline bool kdump_in_progress(void)
>  	return crashing_cpu >= 0;
>  }
>  
> +void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_code_buffer,
> +			 unsigned long start_address) __noreturn;
> +
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops kexec_elf64_ops;
>  
> diff --git a/arch/powerpc/kernel/machine_kexec_32.c b/arch/powerpc/kernel/machine_kexec_32.c
> index affe5dcce7f4..2b160d68db49 100644
> --- a/arch/powerpc/kernel/machine_kexec_32.c
> +++ b/arch/powerpc/kernel/machine_kexec_32.c
> @@ -30,7 +30,6 @@ typedef void (*relocate_new_kernel_t)(
>   */
>  void default_machine_kexec(struct kimage *image)
>  {
> -	extern const unsigned char relocate_new_kernel[];
>  	extern const unsigned int relocate_new_kernel_size;
>  	unsigned long page_list;
>  	unsigned long reboot_code_buffer, reboot_code_buffer_phys;
> @@ -58,6 +57,9 @@ void default_machine_kexec(struct kimage *image)
>  				reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
>  	printk(KERN_INFO "Bye!\n");
>  
> +	if (!IS_ENABLED(CONFIG_FSL_BOOKE) && !IS_ENABLED(CONFIG_44x))
> +		relocate_new_kernel(page_list, reboot_code_buffer_phys, image->start);
> +
>  	/* now call it */
>  	rnk = (relocate_new_kernel_t) reboot_code_buffer;
>  	(*rnk)(page_list, reboot_code_buffer_phys, image->start);
> -- 
> 2.13.3
> 
