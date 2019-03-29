Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C712C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A42173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfC2Htz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfC2Hty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CE22C049D40;
        Fri, 29 Mar 2019 07:49:54 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F5FE83B97;
        Fri, 29 Mar 2019 07:49:49 +0000 (UTC)
Date:   Fri, 29 Mar 2019 15:49:47 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190329074947.GD7627@MiWiFi-R3L-srv>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190329072037.GA5840@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329072037.GA5840@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 29 Mar 2019 07:49:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/19 at 07:20am, Junichi Nomura wrote:
> Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> in the early parsing code tries to search RSDP from EFI table but
> that will crash because the table address is virtual when the kernel
> was booted by kexec.
> 
> In the case of kexec, physical address of EFI tables is provided
> via efi_setup_data in boot_params, which is set up by kexec(1).
> 
> Factor out the table parsing code and use different pointers depending
> on whether the kernel is booted by kexec or not.
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
> @@ -44,17 +44,109 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return addr;
>  }
>  
> +#ifdef CONFIG_EFI
> +static unsigned long efi_get_kexec_setup_data_addr(void)
> +{
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
> +	return 0;
> +}
> +
>  /* Search EFI system tables for RSDP. */
> -static acpi_physical_address efi_get_rsdp_addr(void)
> +static acpi_physical_address
> +__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
> +		    bool efi_64)
>  {
>  	acpi_physical_address rsdp_addr = 0;
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
> +
> +	return rsdp_addr;
> +}
> +#endif
>  
> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
>  #ifdef CONFIG_EFI
> -	unsigned long systab, systab_tables, config_tables;
> +	efi_system_table_64_t *systab;
> +	struct efi_setup_data *esd;
> +	struct efi_info *ei;
> +	char *sig;
> +
> +	esd = (struct efi_setup_data *) efi_get_kexec_setup_data_addr();
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
> +	/*
> +	 * EFI/kexec support is only added for 64bit. So we don't have to
> +	 * care 32bit case.
> +	 */
I would put the doc above kexec_get_rsdp_addr(). Other than this, it
looks good to me. Thanks for the effort.

Acked-by: Baoquan He <bhe@redhat.com>


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
> +	return __efi_get_rsdp_addr((unsigned long) esd->tables,
> +				   systab->nr_tables, true);
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
> @@ -221,6 +284,9 @@ acpi_physical_address get_rsdp_addr(void)
>  		pa = boot_params->acpi_rsdp_addr;
>  
>  	if (!pa)
> +		pa = kexec_get_rsdp_addr();
> +
> +	if (!pa)
>  		pa = efi_get_rsdp_addr();
>  
>  	if (!pa)
