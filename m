Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDEE2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfDXGSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfDXGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:18:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27F0930C45A5;
        Wed, 24 Apr 2019 06:18:40 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-149.pek2.redhat.com [10.72.12.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF985C28D;
        Wed, 24 Apr 2019 06:18:35 +0000 (UTC)
Date:   Wed, 24 Apr 2019 14:18:31 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Message-ID: <20190424061831.GA9059@dhcp-128-65.nay.redhat.com>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
 <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
 <24f1dc7c-1dea-79b0-d364-0dc7d605ce01@ce.jp.nec.com>
 <20190424054135.GG3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424054135.GG3584@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Apr 2019 06:18:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/19 at 01:41pm, Baoquan He wrote:
> On 04/24/19 at 02:47am, Junichi Nomura wrote:
> > On 4/24/19 2:15 AM, Kairui Song wrote:
> > > On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
> > >> Is the mapping of ACPI tables just by luck, too?
> > > 
> > > Good question, they should have same issue with systab, I ignored this one.
> > > Then in first kernel when doing kexec it should ensure both ACPI
> > > tables and the EFI systab are mapped, that should cover everything and
> > > make it work.
> > 
> > Right.
> > 
> > > Is there anything else missing?
> > No, as far as I looked around get_rsdp_addr().
> 
> Have made a draft patch to build ident mapping for ACPI tables too, it's
> based on Kairui's patch. Dave has tested on his t400s laptop, and
> passed. Please check if this adding is OK.
> 
> Kairui, you can add this into your patch to make a new one and resend.
> Or I can combine them and send for you today.
> 
> From 7f17fcb12a6fddbb0f5e56e5137cc81f25c04af4 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 24 Apr 2019 09:57:01 +0800
> Subject: [PATCH] x86/kexec: Prepare ACPI table mapping for kexec kernel
> 
> If the kernel decompressing code accesses ACPI tabels in kexec-ed kernel,
> they also need be 1:1 mapped.
> 
> ---
>  arch/x86/kernel/machine_kexec_64.c | 54 ++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index d5da54893f97..e2948aea27d4 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -30,6 +30,48 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  
> +#ifdef CONFIG_ACPI
> +/**
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
> +	struct init_pgtable_data *data= arg;
> +	unsigned long mstart, mend;
> +
> +	mstart = res->start;
> +	mend = mstart + resource_size(res) - 1;
> +
> +	return kernel_ident_mapping_init(data->info,
> +			data->level4p, mstart, mend);
> +}
> +
> +static int init_acpi_pgtable(struct x86_mapping_info *info,
> +				   pgd_t *level4p)
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
> @@ -114,6 +156,8 @@ static void *alloc_pgt_page(void *data)
>  	return p;
>  }
>  
> +
> +
>  #ifdef CONFIG_EFI
>  static int init_efi_systab_pgtable(struct x86_mapping_info *info,
>  				   pgd_t *level4p)
> @@ -191,14 +235,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  			return result;
>  	}
>  
> -	/*
> -	 * Prepare EFI systab mapping for kexec kernel, systab is not
> -	 * covered by pfn_mapped.
> +	/**
> +	 * Prepare EFI systab and ACPI table mapping for kexec kernel,
> +	 * since they are not covered by pfn_mapped.
>  	 */
>  	result = init_efi_systab_pgtable(&info, level4p);
>  	if (result)
>  		return result;
>  
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

Since I can not reproduce the acpi table accessing fault with Kairui's patch,
the test is just sanity testing on same hardware. But the patch looks
good.

With Kairui's fix+ this acpi fix and Junichi's patch everything works.
Can anyone send them for example patch 1/2: kexec early mapping for
efi/acpi,  patch 2/2: Junichi's previous patch.

With these fixes I think kexec will just work.  Maybe we can go with
these fixes and leave other issues like the loader type flag etc as 
future issue.

Thanks
Dave
