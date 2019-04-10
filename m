Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD5EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D1B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="beaqE3PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfDJROp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:14:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39764 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfDJROp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:14:45 -0400
Received: from zn.tnic (p200300EC2F0CAE00295B1FE58D6681B0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:295b:1fe5:8d66:81b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B95B1EC0400;
        Wed, 10 Apr 2019 19:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554916478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9qmfhGR/+eVSbiyqb9P6ggy930HT5aQlWmwMm39jB70=;
        b=beaqE3PGWV+RvTn9lScPdeAmy3ZkSnCJvpzBxNcpylODvYKHde/Hu3g/cSy66E3qDU0tvL
        RQxYvf4oTqufhNhPeqWyX0YUYeus3ZrCLGm7ao3pCU/QdbEQi6ElSjlNBTHjwBggLAa/ZI
        CNONLaUYwyjgPJ9cQRSgBi+/5ARdAtk=
Date:   Wed, 10 Apr 2019 19:14:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190410171431.GE26580@zn.tnic>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:10:17PM +0000, Junichi Nomura wrote:
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
> Acked-by: Baoquan He <bhe@redhat.com>
> Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dave Young <dyoung@redhat.com>
> 
> --
> Original post:
>   https://lore.kernel.org/lkml/20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp/
> 
> v2: Added comments above __efi_get_rsdp_addr() and kexec_get_rsdp_addr() 
> 
> v3: Properly ifdef out 64bit-only kexec code to avoid 32bit build warnings
> 
> v4:
>  - Make sure to avoid efi_get_rsdp_addr() when kexec setup_data exists
>    even if the data is invalid.
>  - Return instead of hang if systab is 0 in kexec_get_rsdp_addr().
>  - Check 32bit EFI loader signature in the case of kexec as well.
>  - Factor out EFI-related boot_params handling into efi_read_boot_params() to
>    avoid duplication between efi_get_rsdp_addr() and kexec_get_rsdp_addr().
> 
> The patch was tested on 3 different models of EFI-booted physical machines
> for both normal kexec and panic kexec.
> 
> There is a report, that similar problem still happens even with this patch:
>   https://lore.kernel.org/lkml/20190404140809.GA7789@dhcp-128-65.nay.redhat.com/
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 0ef4ad5..2bc8dca 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -44,71 +44,80 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return addr;
>  }
>  
> -/* Search EFI system tables for RSDP. */
> -static acpi_physical_address efi_get_rsdp_addr(void)
> +#ifdef CONFIG_EFI
> +static unsigned long kexec_efi_setup_data;
> +static unsigned long efi_systab;
> +static bool efi_booted;
> +static bool efi_64;
> +
> +static unsigned long efi_get_kexec_setup_data_addr(void)
>  {
> -	acpi_physical_address rsdp_addr = 0;
> +#if defined(CONFIG_X86_64)
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
>  
> -#ifdef CONFIG_EFI
> -	unsigned long systab, systab_tables, config_tables;
> -	unsigned int nr_tables;
> +static void efi_read_boot_params(void)
> +{
> +	struct efi_setup_data *esd;
>  	struct efi_info *ei;
> -	bool efi_64;
> -	int size, i;
>  	char *sig;
>  
> +	kexec_efi_setup_data = efi_get_kexec_setup_data_addr();

Why is that written here and tested in another function?!?

> +
>  	ei = &boot_params->efi_info;
>  	sig = (char *)&ei->efi_loader_signature;
>  
>  	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
>  		efi_64 = true;
> +		efi_booted = true;

What is that ugliness for? Have you heard of functions returning values?

This patch has gone all downhill.

> +/*
> + * EFI/kexec support is only added for 64bit. So we don't have to
> + * care 32bit case.
> + */
> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
> +#if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
> +	struct efi_setup_data *esd;
> +	unsigned int nr_tables;
> +
> +	if (!efi_booted || !kexec_efi_setup_data)
> +		return 0;
> +
> +	esd = (struct efi_setup_data *) kexec_efi_setup_data;
> +
> +	if (!esd->tables) {
> +		debug_putstr("Wrong kexec SETUP_EFI data.\n");
> +		return 0;
> +	}
> +
> +	if (!efi_systab) {
> +		debug_putstr("EFI system table not found in kexec boot_params.");
> +		return 0;
> +	}
> +
> +	/* Handle EFI bitness properly */
> +	if (efi_64) {
> +		efi_system_table_64_t *stbl = (efi_system_table_64_t *)efi_systab;
> +
> +		nr_tables	= stbl->nr_tables;
> +	} else {
> +		efi_system_table_32_t *stbl = (efi_system_table_32_t *)efi_systab;
> +
> +		nr_tables	= stbl->nr_tables;
> +	}
> +
> +	return __efi_get_rsdp_addr((unsigned long) esd->tables, nr_tables);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static acpi_physical_address efi_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	unsigned long config_tables;
> +	unsigned int nr_tables;
> +
> +	efi_read_boot_params();

Why do you read boot params here?

No, no, no.

First you do

	efi_get_rsdp_addr()

if you cannot get an address, you

	- parse boot params
	- then parse EFI tables from the address the kexeced kernel received

No intermixing of code paths and assigning variables in one function and
using them in another.

You were on the right track with v3...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
