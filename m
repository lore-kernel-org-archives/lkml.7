Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB46C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C0520868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfDPLln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:41:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfDPLlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BC62309265F;
        Tue, 16 Apr 2019 11:41:42 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B01119C71;
        Tue, 16 Apr 2019 11:41:38 +0000 (UTC)
Date:   Tue, 16 Apr 2019 19:41:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Message-ID: <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
References: <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <20190416095209.GG27892@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416095209.GG27892@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 16 Apr 2019 11:41:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/19 at 11:52am, Borislav Petkov wrote:
> I'll queue the below in the next days if there are no more complaints:

As for the kexec breakage, even with the V3 patch, kexec still hangs on
a Lenovo T420 laptop.  Kairui also reproduced the problem. So can we
wait a few days see if we can make some progress to find the cause?

> 
> ---
> From: Junichi Nomura <j-nomura@ce.jp.nec.com>
> 
> Commit
> 
>   3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> 
> broke kexec boot on EFI systems. efi_get_rsdp_addr() in the early
> parsing code tries to search RSDP from the EFI tables but that will
> crash because the table address is virtual when the kernel was booted by
> kexec (set_virtual_address_map() has run in the first kernel and cannot
> be run again in the second kernel).
> 
> In the case of kexec, the physical address of EFI tables is provided via
> efi_setup_data in boot_params, which is set up by kexec(1).
> 
> Factor out the table parsing code and use different pointers depending
> on whether the kernel is booted by kexec or not.
> 
>  [ bp: Massage. ]
> 
> Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dave Young <dyoung@redhat.com>
> Link: https://lkml.kernel.org/r/20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp
> ---
>  arch/x86/boot/compressed/acpi.c | 143 ++++++++++++++++++++++++--------
>  1 file changed, 107 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 0ef4ad55b29b..8cecce1ac0cd 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -44,17 +44,109 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return addr;
>  }
>  
> -/* Search EFI system tables for RSDP. */
> -static acpi_physical_address efi_get_rsdp_addr(void)
> +/*
> + * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
> + * ACPI_TABLE_GUID are found, take the former, which has more features.
> + */
> +static acpi_physical_address
> +__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
> +		    bool efi_64)
>  {
>  	acpi_physical_address rsdp_addr = 0;
>  
>  #ifdef CONFIG_EFI
> -	unsigned long systab, systab_tables, config_tables;
> +	int i;
> +
> +	/* Get EFI tables from systab. */
> +	for (i = 0; i < nr_tables; i++) {
> +		acpi_physical_address table;
> +		efi_guid_t guid;
> +
> +		if (efi_64) {
> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *) config_tables + i;
> +
> +			guid  = tbl->guid;
> +			table = tbl->table;
> +
> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> +				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> +				return 0;
> +			}
> +		} else {
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *) config_tables + i;
> +
> +			guid  = tbl->guid;
> +			table = tbl->table;
> +		}
> +
> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> +			rsdp_addr = table;
> +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> +			return table;
> +	}
> +#endif
> +	return rsdp_addr;
> +}
> +
> +/* EFI/kexec support is 64-bit only. */
> +#ifdef CONFIG_X86_64
> +static struct efi_setup_data *get_kexec_setup_data_addr(void)
> +{
> +	struct setup_data *data;
> +	u64 pa_data;
> +
> +	pa_data = boot_params->hdr.setup_data;
> +	while (pa_data) {
> +		data = (struct setup_data *)pa_data;
> +		if (data->type == SETUP_EFI)
> +			return (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
> +
> +		pa_data = data->next;
> +	}
> +	return NULL;
> +}
> +
> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
> +	efi_system_table_64_t *systab;
> +	struct efi_setup_data *esd;
> +	struct efi_info *ei;
> +	char *sig;
> +
> +	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
> +	if (!esd)
> +		return 0;
> +
> +	if (!esd->tables) {
> +		debug_putstr("Wrong kexec SETUP_EFI data.\n");
> +		return 0;
> +	}
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		debug_putstr("Wrong kexec EFI loader signature.\n");
> +		return 0;
> +	}
> +
> +	/* Get systab from boot params. */
> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> +	if (!systab)
> +		error("EFI system table not found in kexec boot_params.");
> +
> +	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
> +}
> +#else
> +static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
> +#endif /* CONFIG_X86_64 */
> +
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	unsigned long systab, config_tables;
>  	unsigned int nr_tables;
>  	struct efi_info *ei;
>  	bool efi_64;
> -	int size, i;
>  	char *sig;
>  
>  	ei = &boot_params->efi_info;
> @@ -88,49 +180,20 @@ static acpi_physical_address efi_get_rsdp_addr(void)
>  
>  		config_tables	= stbl->tables;
>  		nr_tables	= stbl->nr_tables;
> -		size		= sizeof(efi_config_table_64_t);
>  	} else {
>  		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
>  
>  		config_tables	= stbl->tables;
>  		nr_tables	= stbl->nr_tables;
> -		size		= sizeof(efi_config_table_32_t);
>  	}
>  
>  	if (!config_tables)
>  		error("EFI config tables not found.");
>  
> -	/* Get EFI tables from systab. */
> -	for (i = 0; i < nr_tables; i++) {
> -		acpi_physical_address table;
> -		efi_guid_t guid;
> -
> -		config_tables += size;
> -
> -		if (efi_64) {
> -			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
> -
> -			guid  = tbl->guid;
> -			table = tbl->table;
> -
> -			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> -				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> -				return 0;
> -			}
> -		} else {
> -			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
> -
> -			guid  = tbl->guid;
> -			table = tbl->table;
> -		}
> -
> -		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> -			rsdp_addr = table;
> -		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> -			return table;
> -	}
> +	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
> +#else
> +	return 0;
>  #endif
> -	return rsdp_addr;
>  }
>  
>  static u8 compute_checksum(u8 *buffer, u32 length)
> @@ -220,6 +283,14 @@ acpi_physical_address get_rsdp_addr(void)
>  	if (!pa)
>  		pa = boot_params->acpi_rsdp_addr;
>  
> +	/*
> +	 * Try to get EFI data from setup_data. This can happen when we're a
> +	 * kexec'ed kernel and kexec(1) has passed all the required EFI info to
> +	 * us.
> +	 */
> +	if (!pa)
> +		pa = kexec_get_rsdp_addr();
> +
>  	if (!pa)
>  		pa = efi_get_rsdp_addr();
>  
> -- 
> 2.21.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
