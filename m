Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD6420823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ns7oJbxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfC1Pw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:52:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53226 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfC1Pw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:52:56 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE88E1EC0943;
        Thu, 28 Mar 2019 16:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553788375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wo9rKSTDq9ZPCxGcvvx0Hma3gRN7hm7x2SW3A2GqGhw=;
        b=Ns7oJbxJcKsSvPKA10n7mXqqkWXxUdFGGpZc0zdeq9JvnX+LlkaAnYvW5YaSNwOiK6JZrU
        ToVUjG2VRngipl/bFTtKZVUjOlnhkdBJ4HhEsOX/pgwr/tXmiJkE2v1FNrxLUFj/2gTL9s
        0Zsm/V5Cp5+D5Gf5/SjgzmJ2O6JXZfw=
Date:   Thu, 28 Mar 2019 16:52:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190328155256.GP22720@zn.tnic>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:43:38AM +0000, Junichi Nomura wrote:
>  /* Search EFI system tables for RSDP. */
> -static acpi_physical_address efi_get_rsdp_addr(void)
> +static acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables, int size, bool efi_64)

Break this line like this:

static acpi_physical_address
__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
                    int size, bool efi_64)


>  {
>  	acpi_physical_address rsdp_addr = 0;

You don't need that variable and can return "table" or 0 after the endif
below.

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
> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	struct efi_setup_data *esd;
> +	efi_system_table_64_t *systab;
> +	struct efi_info *ei;
> +	char *sig;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	esd = (struct efi_setup_data *) efi_get_kexec_setup_data_addr();
> +	if (!esd)
> +		return 0;

<---- newline here.

> +	if (!esd->tables) {
> +		debug_putstr("Wrong kexec SETUP_EFI data.\n");
> +		return 0;
> +	}
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		debug_putstr("Wrong EFI loader signature.\n");

  "Wrong kexec EFI loader signature."

so that it differs from the other error message and we can know where we
are when debugging.

> +		return 0;
> +	}
> +
> +	/* Get systab from boot params. */
> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> +	if (!systab)
> +		error("EFI system table not found.");

Ditto.

> +
> +	return __efi_get_rsdp_addr((unsigned long) esd->tables, systab->nr_tables, sizeof(efi_config_table_64_t), true);

You can easily break that line - no need to let it stick out.

> +#else
> +	return 0;
> +#endif
> +}

Other than those nitpicks, yes, it looks ok to me. Please send a proper
patch.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
