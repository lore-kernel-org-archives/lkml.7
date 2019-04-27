Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13790C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4951206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hKG4NwvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfD0QL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:11:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfD0QL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:11:28 -0400
Received: from zn.tnic (p200300EC2F1D4200C9F1D41AFD83C4FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:4200:c9f1:d41a:fd83:c4fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 131F41EC0469;
        Sat, 27 Apr 2019 18:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556381486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=92Adu0xBHOyqjn2w5IOR2ZooSb46MP+b89bte9Cxr78=;
        b=hKG4NwvRBlwmA400X7xEqiTvin+5/dluvFmljDMM1Re2DWytUulHrirZ3jGId97ccLE7U0
        /eSkMDDqxhFB9qbm8lc/ZFH8R9oIaRCWanEEaAh14FxrqcY95KIcoNAQDCY8pidl2/Ou1y
        DRr1aitNioZiReR8A1q/L/ecpkheOE0=
Date:   Sat, 27 Apr 2019 18:11:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, hpa@zytor.com
Subject: Re: [PATCH v5 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190427161121.GC12360@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424092944.30481-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:29:43PM +0800, Baoquan He wrote:
> From: Kairui Song <kasong@redhat.com>
> 
> The current code only builds identity mapping for physical memory during
> kexec-type loading. The regions reserved by firmware are not covered.
> In the next patch, the boot decompressing code of kexec-ed kernel tries

There's no guarantee that when this patch gets applied, the next patch
will be the one you mean. So explain what you mean here instead.

> to access EFI systab and ACPI tables, lacking identity mapping for them
> will cause error and reset system to firmware.
> 
> This error doesn't happen on all systems. Because kexec enables gbpages
> to build identity mapping, the EFI systab and ACPI tables could have been
> covered if they share the same 1 GB area with physical memory. To make
> sure, we should map them always.
> 
> So here add mapping for them.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

When you send someone else's patch, you need to add your SOB. Lemme
point you to

  Documentation/process/submitting-patches.rst

again. Please have a deeper look.

> ---
>  arch/x86/kernel/machine_kexec_64.c | 86 ++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index ceba408ea982..77b40c3e28d7 100644
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
> @@ -29,6 +30,48 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  
> +#ifdef CONFIG_ACPI
> +/**

Two stars '**' are kernel-doc style but this comment is implementation
detail and is irrelevant for kernel-doc ouput.

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
> +	return kernel_ident_mapping_init(data->info,
> +			data->level4p, mstart, mend);

Do not break that line.

> +}
> +
> +static int init_acpi_pgtable(struct x86_mapping_info *info,
> +				   pgd_t *level4p)

static int
map_acpi_tables(...)

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
> +static int init_acpi_pgtable(struct x86_mapping_info *info,
> +				   pgd_t *level4p)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_KEXEC_FILE
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  		&kexec_bzImage64_ops,
> @@ -36,6 +79,37 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  };
>  #endif
>  
> +#ifdef CONFIG_EFI
> +static int init_efi_systab_pgtable(struct x86_mapping_info *info,
> +				   pgd_t *level4p)

This function's name is wrong. Make it like this:

static int
map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
{
#ifdef CONFIG_EFI

	...

#endif

	return 0;
}

and drop the #else ifdeffery.


> +{
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
> +	if (mstart)
> +		return kernel_ident_mapping_init(info,
> +				level4p, mstart, mend);

Flip that logic:

	if (!mstart)
		return 0;

	return kernel_ident_mapping_init(info, level4p, mstart, mend);

and let the function stick out.

> +
> +	return 0;
> +}
> +#else
> +static inline int init_efi_systab_pgtable(struct x86_mapping_info *info,
> +					  pgd_t *level4p)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static void free_transition_pgtable(struct kimage *image)
>  {
>  	free_page((unsigned long)image->arch.p4d);
> @@ -159,6 +233,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  			return result;
>  	}
>  
> +	/**

Two stars '**' are kernel-doc style comments above function names but
not here.

> +	 * Prepare EFI systab and ACPI table mapping for kexec kernel,
> +	 * since they are not covered by pfn_mapped.
> +	 */
> +	result = init_efi_systab_pgtable(&info, level4p);
> +	if (result)
> +		return result;
> +
> +	result = init_acpi_pgtable(&info, level4p);
> +	if (result)
> +		return result;
> +
>  	return init_transition_pgtable(image, level4p);
>  }
>  
> -- 
> 2.17.2
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
