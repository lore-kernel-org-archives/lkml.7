Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9C020850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfCYGBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:01:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfCYGBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B4EB307C94A;
        Mon, 25 Mar 2019 06:01:37 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68ABA5D9D5;
        Mon, 25 Mar 2019 06:01:34 +0000 (UTC)
Date:   Mon, 25 Mar 2019 14:01:28 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "bp@suse.de" <bp@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Message-ID: <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 25 Mar 2019 06:01:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/19 at 12:27am, Junichi Nomura wrote:
> On Fri, Mar 22, 2019 at 04:23:28PM +0100, Borislav Petkov wrote:
> > On Fri, Mar 22, 2019 at 11:03:43AM +0000, Junichi Nomura wrote:
> > > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > > in the early parsing code tries to search RSDP from EFI table but
> > > whose address is virtual.
> > > 
> > > Since kexec(1) provides physical address of config_table via boot_params,
> > > efi_get_rsdp_addr() should look for setup_data in the same way as
> > > efi_systab_init() in arch/x86/platform/efi/efi.c does.
> > 
> > If the kexec kernel should continue to use efi_systab_init() then you
> > should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
> 
> I'm not sure which way kexec devel is going. Added kexec list.
> Here is the version that exits early in efi_get_rsdp_addr().
> 
> [PATCH] x86/boot: Don't try to search RSDP from EFI when kexec-booted
> 
> Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> in the early parsing code tries to search RSDP from EFI table but
> whose address is virtual.
> 
> Normally kexec(1) provides physical address of config_table via boot_params
> and EFI code uses that during initialization.
> For the early boot code, we just exit efi_get_rsdp_addr() early if the kernel
> is booted by kexec.
> 
> Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: Borislav Petkov <bp@suse.de>
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 0ef4ad5..1cefc43 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -44,6 +44,24 @@ static acpi_physical_address get_acpi_rsdp(void)
>  	return addr;
>  }
>  
> +static bool is_kexec_booted(void)
> +{
> +	struct setup_data *data;
> +
> +	/*
> +	 * kexec-tools provides EFI setup data so that kexec-ed kernel
> +	 * can find proper tables.
> +	 */
> +	data = (struct setup_data *) boot_params->hdr.setup_data;
> +	while (data) {
> +		if (data->type == SETUP_EFI)
> +			return true;
> +		data = (struct setup_data *) data->next;
> +	}
> +
> +	return false;
> +}
> +
>  /* Search EFI system tables for RSDP. */
>  static acpi_physical_address efi_get_rsdp_addr(void)
>  {
> @@ -57,6 +75,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
>  	int size, i;
>  	char *sig;
>  
> +	/* If the system is kexec-booted, poking EFI systab may not work. */
> +	if (is_kexec_booted())
> +		return 0;
> +
>  	ei = &boot_params->efi_info;
>  	sig = (char *)&ei->efi_loader_signature;
>  
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Good catch, this way looks good to me.  But the function
is_kexec_booted can be compiled when #ifdef CONFIG_EFI

Otherwise:

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
