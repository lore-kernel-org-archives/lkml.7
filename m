Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A892184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfC1XLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:11:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfC1XLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:11:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A8643086223;
        Thu, 28 Mar 2019 23:11:06 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 577A6600C0;
        Thu, 28 Mar 2019 23:11:03 +0000 (UTC)
Date:   Fri, 29 Mar 2019 07:11:00 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190328231100.GC1877@MiWiFi-R3L-srv>
References: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 28 Mar 2019 23:11:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/19 at 07:43am, Junichi Nomura wrote:
> On 2019/03/28 15:43, bhe@redhat.com wrote:
> > On 03/28/19 at 04:17am, Junichi Nomura wrote:
> >> I still don't get it... We still need systab for kexec case as well
> >> to get nr_tables. Don't we?
> > 
> > Yes, simpler.
> > 
> > As Dave replied in another mail, efi/kexec is only added for x86_64. See
> > how it does in setup_linux_system_parameters() of kexec_tools utility,
> > and we only have bzImage64 handling in kernel for kexec_file loading,
> > see prepare_add_efi_setup_data().
> > 
> > You may only need to get kexec ei_info to use directly.
> 
> OK, let me try. How does this look?

Yes, it looks great. Thanks.

Some tiny concenrns added in inline comments, please check.

> 
> Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> in the early parsing code tries to search RSDP from EFI table but
> that will crash because the table address is virtual when the kernel
> was booted by kexec.
> 
> Since kexec(1) provides physical address of the table via efi_setup_data,
> early boot code of kexec-ed kernel should look for setup_data in the same
> way as efi_systab_init() in arch/x86/platform/efi/efi.c does.
> 
> Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -44,17 +44,106 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return addr;
>  }
>  
> +static unsigned long efi_get_kexec_setup_data_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	struct setup_data *data;
> +	u64 pa_data;
> +
> +	pa_data = boot_params->hdr.setup_data;
> +	while (pa_data) {
> +		data = (struct setup_data *) pa_data;
> +		if (data->type == SETUP_EFI)
> +			return pa_data + sizeof(struct setup_data);
> +		pa_data = data->next;
> +	}
> +#endif
> +	return 0;
> +}
> +
>  /* Search EFI system tables for RSDP. */
> -static acpi_physical_address efi_get_rsdp_addr(void)
> +static acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables, int size, bool efi_64)

Here parameter 'size' and 'efi_64' seems a little duplicated on
functionality. Only passing efi_64 can deduce the size? Personal
opinion.

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
> +		config_tables += size;
> +
> +		if (efi_64) {
> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
> +
> +			guid  = tbl->guid;
> +			table = tbl->table;
> +
> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> +				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> +				return 0;
> +			}
> +		} else {
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
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

It might be worth adding code comments here to tell why we only care
about 64bit kexec booting?

> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	struct efi_setup_data *esd;
> +	efi_system_table_64_t *systab;
> +	struct efi_info *ei;
> +	char *sig;
> +
> +	esd = (struct efi_setup_data *) efi_get_kexec_setup_data_addr();
> +	if (!esd)
> +		return 0;
> +	if (!esd->tables) {
> +		debug_putstr("Wrong kexec SETUP_EFI data.\n");
> +		return 0;
> +	}
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		debug_putstr("Wrong EFI loader signature.\n");
> +		return 0;
> +	}
> +
> +	/* Get systab from boot params. */
> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> +	if (!systab)
> +		error("EFI system table not found.");
> +
> +	return __efi_get_rsdp_addr((unsigned long) esd->tables, systab->nr_tables, sizeof(efi_config_table_64_t), true);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	unsigned long systab, config_tables;
>  	unsigned int nr_tables;
>  	struct efi_info *ei;
>  	bool efi_64;
> -	int size, i;
> +	int size;
>  	char *sig;
>  
>  	ei = &boot_params->efi_info;
> @@ -100,37 +189,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
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
> +	return __efi_get_rsdp_addr(config_tables, nr_tables, size, efi_64);
> +#else
> +	return 0;
>  #endif
> -	return rsdp_addr;
>  }
>  
>  static u8 compute_checksum(u8 *buffer, u32 length)
> @@ -221,6 +283,9 @@ acpi_physical_address get_rsdp_addr(void)
>  		pa = boot_params->acpi_rsdp_addr;
>  
>  	if (!pa)
> +		pa = kexec_get_rsdp_addr();
> +
> +	if (!pa)
>  		pa = efi_get_rsdp_addr();
>  
>  	if (!pa)
