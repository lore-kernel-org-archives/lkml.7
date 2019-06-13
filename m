Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065F02082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfFMPWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbfFMMmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 88D3A307CB37;
        Thu, 13 Jun 2019 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C84855DE68;
        Thu, 13 Jun 2019 12:41:59 +0000 (UTC)
Subject: Re: [PATCH] x86/mm: Create an SME workarea in the kernel for early
 encryption
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
References: <d565e0c8e9867132c75648fe67416c3f51a0efbd.1560346329.git.thomas.lendacky@amd.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <36ef7018-953e-4a86-f678-e5b71a6ec247@redhat.com>
Date:   Thu, 13 Jun 2019 20:41:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d565e0c8e9867132c75648fe67416c3f51a0efbd.1560346329.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Jun 2019 12:42:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After applied this patch, i made a test on the following machines. It works well.

[a] HPE ProLiant DL385 Gen10 (878612-B21) AMD EPYC 7251 8-Core Processor

[b] Dell PowerEdge R7425 AMD EPYC 7401 24-Core Processor

[c] AMD Speedway AMD Eng Sample: 2S1405A3VIHF4_28/14_N

[d] AMD Ethanol X AMD Eng Sample: 2S1402E2VJUG2_20/14_N

On the [a] machine, it works well in the crashkernel=160M case, but need
to remove the CONFIG_DEBUG_INFO from .config, otherwise it could happen the
OOM. And it also works well in all >= 256M(crashkernel) cases(no need to
remove the above option from .config).

On the [b][c][d] machine, it also works fine in the crashkernel=256M cases,
also need to remove the debug info, otherwise it could happen the OOM. And
it also works well in all >= 320M(crashkernel) cases.

Thanks.


Tested-by: Lianbo Jiang <lijiang@redhat.com>


在 2019年06月12日 21:32, Lendacky, Thomas 写道:
> The SME workarea used during early encryption of the kernel during boot
> is situated on a 2MB boundary after the end of the kernel text, data,
> etc. sections (_end).  This works well during initial boot of a compressed
> kernel because of the relocation used for decompression of the kernel.
> But when performing a kexec boot, there's a chance that the SME workarea
> may not be mapped by the kexec pagetables or that some of the other data
> used by kexec could exist in this range.
> 
> Create a section for SME in the vmlinux.lds.S.  Position it after "_end"
> so that the memory will be reclaimed during boot and, since it is all
> zeroes, it compresses well.  Since this new section will be part of the
> kernel, kexec will account for it in pagetable mappings and placement of
> data after the kernel.
> 
> Here's an example of a kernel size without and with the SME section:
> 	without:
> 		vmlinux:	36,501,616
> 		bzImage:	 6,497,344
> 
> 		100000000-47f37ffff : System RAM
> 		  1e4000000-1e47677d4 : Kernel code	(0x7677d4)
> 		  1e47677d5-1e4e2e0bf : Kernel data	(0x6c68ea)
> 		  1e5074000-1e5372fff : Kernel bss	(0x2fefff)
> 
> 	with:
> 		vmlinux:	44,419,408
> 		bzImage:	 6,503,136
> 
> 		880000000-c7ff7ffff : System RAM
> 		  8cf000000-8cf7677d4 : Kernel code	(0x7677d4)
> 		  8cf7677d5-8cfe2e0bf : Kernel data	(0x6c68ea)
> 		  8d0074000-8d0372fff : Kernel bss	(0x2fefff)
> 
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Lianbo Jiang <lijiang@redhat.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S      | 16 ++++++++++++++++
>  arch/x86/mm/mem_encrypt_identity.c | 22 ++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 0850b5149345..8c4377983e54 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -379,6 +379,22 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
>  	_end = .;
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * SME workarea section: Lives outside of the kernel proper
> +	 * (_text - _end) for performing in-place encryption. Resides
> +	 * on a 2MB boundary to simplify the pagetable setup used for
> +	 * the encryption.
> +	 */
> +	. = ALIGN(HPAGE_SIZE);
> +	.sme : AT(ADDR(.sme) - LOAD_OFFSET) {
> +		__sme_begin = .;
> +		*(.sme)
> +		. = ALIGN(HPAGE_SIZE);
> +		__sme_end = .;
> +	}
> +#endif
> +
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 4aa9b1480866..c55c2ec8fb12 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -73,6 +73,19 @@ struct sme_populate_pgd_data {
>  	unsigned long vaddr_end;
>  };
>  
> +/*
> + * This work area lives in the .sme section, which lives outside of
> + * the kernel proper. It is sized to hold the intermediate copy buffer
> + * and more than enough pagetable pages.
> + *
> + * By using this section, the kernel can be encrypted in place and we
> + * avoid any possibility of boot parameters or initramfs images being
> + * placed such that the in-place encryption logic overwrites them.  This
> + * section is 2MB aligned to allow for simple pagetable setup using only
> + * PMD entries (see vmlinux.lds.S).
> + */
> +static char sme_workarea[2 * PMD_PAGE_SIZE] __section(.sme);
> +
>  static char sme_cmdline_arg[] __initdata = "mem_encrypt";
>  static char sme_cmdline_on[]  __initdata = "on";
>  static char sme_cmdline_off[] __initdata = "off";
> @@ -314,8 +327,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	}
>  #endif
>  
> -	/* Set the encryption workarea to be immediately after the kernel */
> -	workarea_start = kernel_end;
> +	/*
> +	 * We're running identity mapped, so we must obtain the address to the
> +	 * SME encryption workarea using rip-relative addressing.
> +	 */
> +	asm ("lea sme_workarea(%%rip), %0"
> +	     : "=r" (workarea_start)
> +	     : "p" (sme_workarea));
>  
>  	/*
>  	 * Calculate required number of workarea bytes needed:
> 
