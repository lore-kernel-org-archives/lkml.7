Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B70620811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfDWJgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDWJgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:36:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93CB5AC52;
        Tue, 23 Apr 2019 09:36:13 +0000 (UTC)
Subject: Re: [PATCH 2/2] xen/pvh: correctly setup the PV EFI interface for
 dom0
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, platform-driver-x86@vger.kernel.org
References: <20190423092829.67915-1-roger.pau@citrix.com>
 <20190423092829.67915-2-roger.pau@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ec713432-338e-9d14-f626-759b0f3f94d7@suse.com>
Date:   Tue, 23 Apr 2019 11:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423092829.67915-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2019 11:28, Roger Pau Monne wrote:
> This involves initializing the boot params EFI related fields and the
> efi global variable.
> 
> Without this fix a PVH dom0 doesn't detect when booted from EFI, and
> thus doesn't support accessing any of the EFI related data.
> 
> Reported-by: PGNet Dev <pgnet.dev@gmail.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  arch/x86/platform/pvh/enlighten.c |  9 ++++++---
>  arch/x86/xen/efi.c                | 12 ++++++------
>  arch/x86/xen/enlighten_pv.c       |  2 +-
>  arch/x86/xen/xen-ops.h            |  8 --------
>  include/xen/xen-ops.h             |  8 +++++++-
>  5 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
> index 62f5c7045944..a748d2ea2d90 100644
> --- a/arch/x86/platform/pvh/enlighten.c
> +++ b/arch/x86/platform/pvh/enlighten.c
> @@ -11,6 +11,7 @@
>  #include <asm/xen/interface.h>
>  
>  #include <xen/xen.h>
> +#include <xen/xen-ops.h>
>  #include <xen/interface/hvm/start_info.h>
>  
>  /*
> @@ -44,8 +45,6 @@ void __init __weak mem_map_via_hcall(struct boot_params *ptr __maybe_unused)
>  
>  static void __init init_pvh_bootparams(bool xen_guest)
>  {
> -	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
> -
>  	if ((pvh_start_info.version > 0) && (pvh_start_info.memmap_entries)) {
>  		struct hvm_memmap_table_entry *ep;
>  		int i;
> @@ -111,8 +110,10 @@ void __init __weak xen_pvh_init(void)
>  
>  static void hypervisor_specific_init(bool xen_guest)
>  {
> -	if (xen_guest)
> +	if (xen_guest) {
>  		xen_pvh_init();
> +		xen_efi_init(&pvh_bootparams);
> +	}
>  }
>  
>  /*
> @@ -131,6 +132,8 @@ void __init xen_prepare_pvh(void)
>  		BUG();
>  	}
>  
> +	memset(&pvh_bootparams, 0, sizeof(pvh_bootparams));
> +
>  	hypervisor_specific_init(xen_guest);
>  
>  	init_pvh_bootparams(xen_guest);
> diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
> index 1fbb629a9d78..0d3365cb64de 100644
> --- a/arch/x86/xen/efi.c
> +++ b/arch/x86/xen/efi.c
> @@ -158,7 +158,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
>  	return efi_secureboot_mode_unknown;
>  }
>  
> -void __init xen_efi_init(void)
> +void __init xen_efi_init(struct boot_params *boot_params)
>  {
>  	efi_system_table_t *efi_systab_xen;
>  
> @@ -167,12 +167,12 @@ void __init xen_efi_init(void)
>  	if (efi_systab_xen == NULL)
>  		return;
>  
> -	strncpy((char *)&boot_params.efi_info.efi_loader_signature, "Xen",
> -			sizeof(boot_params.efi_info.efi_loader_signature));
> -	boot_params.efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
> -	boot_params.efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
> +	strncpy((char *)&boot_params->efi_info.efi_loader_signature, "Xen",
> +			sizeof(boot_params->efi_info.efi_loader_signature));
> +	boot_params->efi_info.efi_systab = (__u32)__pa(efi_systab_xen);
> +	boot_params->efi_info.efi_systab_hi = (__u32)(__pa(efi_systab_xen) >> 32);
>  
> -	boot_params.secure_boot = xen_efi_get_secureboot();
> +	boot_params->secure_boot = xen_efi_get_secureboot();
>  
>  	set_bit(EFI_BOOT, &efi.flags);
>  	set_bit(EFI_PARAVIRT, &efi.flags);
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index c54a493e139a..4722ba2966ac 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1403,7 +1403,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>  	/* We need this for printk timestamps */
>  	xen_setup_runstate_info(0);
>  
> -	xen_efi_init();
> +	xen_efi_init(&boot_params);
>  
>  	/* Start the world */
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
> index 0e60bd918695..357eb3fa2144 100644
> --- a/arch/x86/xen/xen-ops.h
> +++ b/arch/x86/xen/xen-ops.h
> @@ -121,14 +121,6 @@ static inline void __init xen_init_vga(const struct dom0_vga_console_info *info,
>  
>  void __init xen_init_apic(void);
>  
> -#ifdef CONFIG_XEN_EFI
> -extern void xen_efi_init(void);
> -#else
> -static inline void __init xen_efi_init(void)
> -{
> -}
> -#endif
> -
>  __visible void xen_irq_enable_direct(void);
>  __visible void xen_irq_disable_direct(void);
>  __visible unsigned long xen_save_fl_direct(void);
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index 4969817124a8..51ef98e96d88 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -209,6 +209,7 @@ int xen_xlate_map_ballooned_pages(xen_pfn_t **pfns, void **vaddr,
>  
>  bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
>  
> +#ifdef CONFIG_XEN_EFI
>  efi_status_t xen_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
>  efi_status_t xen_efi_set_time(efi_time_t *tm);
>  efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
> @@ -233,7 +234,12 @@ efi_status_t xen_efi_query_capsule_caps(efi_capsule_header_t **capsules,
>  					int *reset_type);
>  void xen_efi_reset_system(int reset_type, efi_status_t status,
>  			  unsigned long data_size, efi_char16_t *data);
> -
> +extern void xen_efi_init(struct boot_params *boot_params);
> +#else
> +static inline void __init xen_efi_init(struct boot_params *boot_params)

Is struct boot_params defined on ARM?


Juergen
