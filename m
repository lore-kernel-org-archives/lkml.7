Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A478FC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFD214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbfIYJze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:55:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732778AbfIYJze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:55:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48794308402D;
        Wed, 25 Sep 2019 09:55:33 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D49A95C1D4;
        Wed, 25 Sep 2019 09:55:29 +0000 (UTC)
Date:   Wed, 25 Sep 2019 17:55:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20190925095527.GE31919@MiWiFi-R3L-srv>
References: <20190919160521.13820-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919160521.13820-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 25 Sep 2019 09:55:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/19 at 12:05am, Kairui Song wrote:
> Currently, kernel fails to boot on some HyperV VMs when using EFI.
> And it's a potential issue on all platforms.
> 
> It's caused a broken kernel relocation on EFI systems, when below three
> conditions are met:
> 
> 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
>    by the loader.
> 2. There isn't enough room to contain the kernel, starting from the
>    default load address (eg. something else occupied part the region).
> 3. In the memmap provided by EFI firmware, there is a memory region
>    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
>    kernel.

Thanks for the effort, Kairui.

Let me summarize what I got from this issue, please correct me if
anything missed:

***
Problem:
This bug is reported on Hyper-V platform. The kernel will reset to
firmware w/o any console printing in 1st kernel and kdump kernel
sometime.

***
Root cause:
With debugging, the resetting to firmware is triggered when execute
'rep     movsq' line of /boot/compressed/head_64.S. The reason is that
efi boot stub may put kernel image below 16M, then later head_64.S will
relocate kernel to 16M directly. That relocation will conflict with some
efi reserved region, then cause the resetting.

A more detail process based on the problem occurred on that HyperV
machine:

- kernel (INIT_SIZE: 56820K) got loaded at 0x3c881000 (not aligned,
  and not equal to pref_address 0x1000000), need to relocate.

- efi_relocate_kernel is called, try to allocate INIT_SIZE of memory
  at pref_address, failed, something else occupied this region.

- efi_relocate_kernel call efi_low_alloc as fallback, and got the address
  0x800000 (Below 0x1000000)

- Later in arch/x86/boot/compressed/head_64.S:108, LOAD_PHYSICAL_ADDR is
  force used as the new load address as the current address is lower than
  that. Then kernel try relocate to 0x1000000.

- However the memory starting from 0x1000000 is not allocated from EFI
  firmware, writing to this region caused the system to reset.

***
Solution:
Alwasys search area above LOAD_PHYSICAL_ADDR, namely 16M to put kernel
image in /boot/compressed/eboot.c. Then efi boot stub in eboot.c will
search an suitable area in efi memmap, to make sure no any reserved
region will conflict with the target area of kernel image. Besides,
kernel won't be relocated in /boot/compressed/head_64.S since it has
been above 16M. 

#ifdef CONFIG_RELOCATABLE
        leaq    startup_32(%rip) /* - $startup_32 */, %rbp
        movl    BP_kernel_alignment(%rsi), %eax
        decl    %eax
        addq    %rax, %rbp
        notq    %rax
        andq    %rax, %rbp
        cmpq    $LOAD_PHYSICAL_ADDR, %rbp
        jge     1f
#endif
        movq    $LOAD_PHYSICAL_ADDR, %rbp
1:

        /* Target address to relocate to for decompression */
        movl    BP_init_size(%rsi), %ebx
        subl    $_end, %ebx
        addq    %rbp, %rbx


***
I have one concerns about this patch:

Why this only happen in Hyper-V platform. Qemu/kvm, baremetal, vmware
ESI don't have this issue? What's the difference?


By the way, I personally like this way better. Because it is fixing a
potention issue. Efi boot stub code may put kernel below 16M, but the
relocation code in boot/compressed/head_64.S doesn't consider the
possible conflict, and head_64.S have no way to know the efi memmap
information. If this patch can't be accepted, woring around it in
Hyper-V may be a way.

Thanks
Baoquan

> 
> Efi stub will perform a kernel relocation when condition 1 is met. But
> due to condition 2, efi stub can't relocate kernel to the preferred
> address, so it fallback to query and alloc from EFI firmware for lowest
> usable memory region.
> 
> It's incorrect to use the lowest memory address. In later stage, kernel
> will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> but efi stub will end up relocating kernel below it.
> 
> Then before the kernel decompressing. Kernel will do another relocation
> to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> over write the blockage at the default load address, which efi stub tried
> to avoid, and lead to unexpected behavior. Beside, the memory region it
> writes to is not allocated from EFI firmware, which is also wrong.
> 
> To fix it, just don't let efi stub relocate the kernel to any address
> lower than lowest acceptable address.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> 
> ---
> 
> Update from V1:
>  - Redo the commit message.
> 
>  arch/x86/boot/compressed/eboot.c               |  8 +++++---
>  drivers/firmware/efi/libstub/arm32-stub.c      |  2 +-
>  drivers/firmware/efi/libstub/arm64-stub.c      |  2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++++++----
>  include/linux/efi.h                            |  5 +++--
>  5 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 936bdb924ec2..8207e8aa297e 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -13,6 +13,7 @@
>  #include <asm/e820/types.h>
>  #include <asm/setup.h>
>  #include <asm/desc.h>
> +#include <asm/boot.h>
>  
>  #include "../string.h"
>  #include "eboot.h"
> @@ -432,7 +433,7 @@ struct boot_params *make_boot_params(struct efi_config *c)
>  	}
>  
>  	status = efi_low_alloc(sys_table, 0x4000, 1,
> -			       (unsigned long *)&boot_params);
> +			       (unsigned long *)&boot_params, 0);
>  	if (status != EFI_SUCCESS) {
>  		efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
>  		return NULL;
> @@ -817,7 +818,7 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>  
>  	gdt->size = 0x800;
>  	status = efi_low_alloc(sys_table, gdt->size, 8,
> -			   (unsigned long *)&gdt->address);
> +			       (unsigned long *)&gdt->address, 0);
>  	if (status != EFI_SUCCESS) {
>  		efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
>  		goto fail;
> @@ -842,7 +843,8 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
>  		status = efi_relocate_kernel(sys_table, &bzimage_addr,
>  					     hdr->init_size, hdr->init_size,
>  					     hdr->pref_address,
> -					     hdr->kernel_alignment);
> +					     hdr->kernel_alignment,
> +					     LOAD_PHYSICAL_ADDR);
>  		if (status != EFI_SUCCESS) {
>  			efi_printk(sys_table, "efi_relocate_kernel() failed!\n");
>  			goto fail;
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
> index e8f7aefb6813..bf6f954d6afe 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -220,7 +220,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
>  	*image_size = image->image_size;
>  	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
>  				     *image_size,
> -				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
> +				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
>  	if (status != EFI_SUCCESS) {
>  		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
>  		efi_free(sys_table, *reserve_size, *reserve_addr);
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 1550d244e996..3d2e517e10f4 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -140,7 +140,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>  	if (status != EFI_SUCCESS) {
>  		*reserve_size = kernel_memsize + TEXT_OFFSET;
>  		status = efi_low_alloc(sys_table_arg, *reserve_size,
> -				       MIN_KIMG_ALIGN, reserve_addr);
> +				       MIN_KIMG_ALIGN, reserve_addr, 0);
>  
>  		if (status != EFI_SUCCESS) {
>  			pr_efi_err(sys_table_arg, "Failed to relocate kernel\n");
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 3caae7f2cf56..00b00a2562aa 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -260,11 +260,11 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
>  }
>  
>  /*
> - * Allocate at the lowest possible address.
> + * Allocate at the lowest possible address that is not below 'min'.
>   */
>  efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>  			   unsigned long size, unsigned long align,
> -			   unsigned long *addr)
> +			   unsigned long *addr, unsigned long min)
>  {
>  	unsigned long map_size, desc_size, buff_size;
>  	efi_memory_desc_t *map;
> @@ -311,6 +311,9 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>  		start = desc->phys_addr;
>  		end = start + desc->num_pages * EFI_PAGE_SIZE;
>  
> +		if (start < min)
> +			start = min;
> +
>  		/*
>  		 * Don't allocate at 0x0. It will confuse code that
>  		 * checks pointers against NULL. Skip the first 8
> @@ -698,7 +701,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
>  				 unsigned long image_size,
>  				 unsigned long alloc_size,
>  				 unsigned long preferred_addr,
> -				 unsigned long alignment)
> +				 unsigned long alignment,
> +				 unsigned long min_addr)
>  {
>  	unsigned long cur_image_addr;
>  	unsigned long new_addr = 0;
> @@ -732,7 +736,7 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
>  	 */
>  	if (status != EFI_SUCCESS) {
>  		status = efi_low_alloc(sys_table_arg, alloc_size, alignment,
> -				       &new_addr);
> +				       &new_addr, min_addr);
>  	}
>  	if (status != EFI_SUCCESS) {
>  		pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index f87fabea4a85..cc947c0f3e06 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1587,7 +1587,7 @@ efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
>  
>  efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
>  			   unsigned long size, unsigned long align,
> -			   unsigned long *addr);
> +			   unsigned long *addr, unsigned long min);
>  
>  efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
>  			    unsigned long size, unsigned long align,
> @@ -1598,7 +1598,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
>  				 unsigned long image_size,
>  				 unsigned long alloc_size,
>  				 unsigned long preferred_addr,
> -				 unsigned long alignment);
> +				 unsigned long alignment,
> +				 unsigned long min_addr);
>  
>  efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
>  				  efi_loaded_image_t *image,
> -- 
> 2.21.0
> 
