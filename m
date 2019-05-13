Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A2C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011B3208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEMBnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 21:43:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfEMBnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 21:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0262A3086272;
        Mon, 13 May 2019 01:43:11 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD1A10018FB;
        Mon, 13 May 2019 01:43:07 +0000 (UTC)
Date:   Mon, 13 May 2019 09:43:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190513014248.GA16774@MiWiFi-R3L-srv>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429135536.GC2324@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 13 May 2019 01:43:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 04/29/19 at 03:55pm, Borislav Petkov wrote:
> From: Kairui Song <kasong@redhat.com>
> Date: Mon, 29 Apr 2019 08:23:18 +0800
> Subject: [PATCH] x86/kexec: Add the EFI system tables and ACPI tables to the ident map

> 
> Currently, only the whole physical memory is identity-mapped for the
> kexec kernel and the regions reserved by firmware are ignored.
> 
> However, the recent addition of RSDP parsing in the decompression stage
> and especially:
> 
>   33f0df8d843d ("x86/boot: Search for RSDP in the EFI tables")
> 
> which tries to access EFI system tables and to dig out the RDSP address
> from there, becomes a problem because in certain configurations, they
> might not be mapped in the kexec'ed kernel's address space.
> 
> What is more, this problem doesn't appear on all systems because the
> kexec kernel uses gigabyte pages to build the identity mapping. And
> the EFI system tables and ACPI tables can, depending on the system
> configuration, end up being mapped as part of all physical memory, if
> they share the same 1 GB area with the physical memory.
> 
> Therefore, make sure they're always mapped.
> 
>  [ bp: productize half-baked patch:
>    - rewrite commit message.
>    - s/init_acpi_pgtable/map_acpi_tables/ in the !ACPI case. ]

Can this patchset be merged, or picked into tip?

Thanks
Baoquan

> Signed-off-by: Kairui Song <kasong@redhat.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: dyoung@redhat.com
> Cc: fanc.fnst@cn.fujitsu.com
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: j-nomura@ce.jp.nec.com
> Cc: kexec@lists.infradead.org
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Lianbo Jiang <lijiang@redhat.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20190429002318.GA25400@MiWiFi-R3L-srv
> ---
>  arch/x86/kernel/machine_kexec_64.c | 75 ++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index ceba408ea982..3c77bdf7b32a 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -18,6 +18,7 @@
>  #include <linux/io.h>
>  #include <linux/suspend.h>
>  #include <linux/vmalloc.h>
> +#include <linux/efi.h>
>  
>  #include <asm/init.h>
>  #include <asm/pgtable.h>
> @@ -29,6 +30,43 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  
> +#ifdef CONFIG_ACPI
> +/*
> + * Used while adding mapping for ACPI tables.
> + * Can be reused when other iomem regions need be mapped
> + */
> +struct init_pgtable_data {
> +	struct x86_mapping_info *info;
> +	pgd_t *level4p;
> +};
> +
> +static int mem_region_callback(struct resource *res, void *arg)
> +{
> +	struct init_pgtable_data *data = arg;
> +	unsigned long mstart, mend;
> +
> +	mstart = res->start;
> +	mend = mstart + resource_size(res) - 1;
> +
> +	return kernel_ident_mapping_init(data->info, data->level4p, mstart, mend);
> +}
> +
> +static int
> +map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
> +{
> +	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +	struct init_pgtable_data data;
> +
> +	data.info = info;
> +	data.level4p = level4p;
> +	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
> +				   &data, mem_region_callback);
> +}
> +#else
> +static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
> +#endif
> +
>  #ifdef CONFIG_KEXEC_FILE
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  		&kexec_bzImage64_ops,
> @@ -36,6 +74,31 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  };
>  #endif
>  
> +static int
> +map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> +{
> +#ifdef CONFIG_EFI
> +	unsigned long mstart, mend;
> +
> +	if (!efi_enabled(EFI_BOOT))
> +		return 0;
> +
> +	mstart = (boot_params.efi_info.efi_systab |
> +			((u64)boot_params.efi_info.efi_systab_hi<<32));
> +
> +	if (efi_enabled(EFI_64BIT))
> +		mend = mstart + sizeof(efi_system_table_64_t);
> +	else
> +		mend = mstart + sizeof(efi_system_table_32_t);
> +
> +	if (!mstart)
> +		return 0;
> +
> +	return kernel_ident_mapping_init(info, level4p, mstart, mend);
> +#endif
> +	return 0;
> +}
> +
>  static void free_transition_pgtable(struct kimage *image)
>  {
>  	free_page((unsigned long)image->arch.p4d);
> @@ -159,6 +222,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  			return result;
>  	}
>  
> +	/*
> +	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
> +	 * not covered by pfn_mapped.
> +	 */
> +	result = map_efi_systab(&info, level4p);
> +	if (result)
> +		return result;
> +
> +	result = map_acpi_tables(&info, level4p);
> +	if (result)
> +		return result;
> +
>  	return init_transition_pgtable(image, level4p);
>  }
>  
> -- 
> 2.21.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
