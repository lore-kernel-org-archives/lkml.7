Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE912177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1Gns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfC1Gns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:43:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F9FF330244;
        Thu, 28 Mar 2019 06:43:48 +0000 (UTC)
Received: from localhost (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 441E41001E69;
        Thu, 28 Mar 2019 06:43:45 +0000 (UTC)
Date:   Thu, 28 Mar 2019 14:43:43 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190328064343.GA1877@MiWiFi-R3L-srv>
References: <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 28 Mar 2019 06:43:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/19 at 04:17am, Junichi Nomura wrote:
> On 2019/03/27 10:48, bhe@redhat.com wrote:
> >>> So efi_get_rsdp_addr() needs to be refactored in such a way so that at
> >>> least the loop towards the end gets carved out into a separate function
> >>> - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
> >>> size as arguments and finds the RSDP address in the kexec-ed kernel.
> >>
> >> You need to carve out the loop at the end and make it into a separate
> >> __efi_get_rsdp_addr() function which gets the physical or the virtual
> >> address.
> > 
> > I guess Boris is suggesting code like below. Please correct me if I am
> > wrong.
> > 
> > static acpi_physical_address _efi_get_rsdp_addr(efi_config_table tbl, ...)
> > {
> > 	/* Get EFI tables from systab. */
> > 	for (i = 0; i < nr_tables; i++) {
> > 		...
> > 	}
> > 	return rsdp_addr;
> > }
> > 
> > static acpi_physical_address efi_get_rsdp_addr(void)
> > {
> > 	...
> > 	/* Get systab from boot params. */		
> > 	...
> > 	/* Handle EFI bitness properly */
> > 	...
> > 	return _efi_get_rsdp_addr();
> > }
> > 
> > 
> > static acpi_physical_address kexec_get_rsdp_addr(void)
> > {
> > 	if (!is_kexec_booted)
> > 		return 0;
> > 
> > 	efi_get_setup_data_addr();
> > 	...
> > 	/* Handle EFI bitness properly */
> > 	...
> > 	return _efi_get_rsdp_addr();
> > }
> 
> I still don't get it... We still need systab for kexec case as well
> to get nr_tables. Don't we?

Yes, simpler.

As Dave replied in another mail, efi/kexec is only added for x86_64. See
how it does in setup_linux_system_parameters() of kexec_tools utility,
and we only have bzImage64 handling in kernel for kexec_file loading,
see prepare_add_efi_setup_data().

You may only need to get kexec ei_info to use directly.

> 
> > acpi_physical_address get_rsdp_addr(void)
> > {
> >          acpi_physical_address pa;
> > 
> >          pa = get_acpi_rsdp();
> > 
> >          if (!pa)
> >                  pa = boot_params->acpi_rsdp_addr;
> > 
> > 
> > 	/**
> > 	/*I think here we should check if it's kexec booted firstly.
> > 	 * Skip it if not kexec. this can avoid the wrong kexec virt
> > 	 * addr parsing./
> >          if (!pa)
> >                  pa = kexec_get_rdsp_addr();             <--- new function
> > 
> >          if (!pa)
> >                  pa = efi_get_rsdp_addr();
> > 
> 
> Shouldn't t efi_get_rsdp_addr() check "is_kexec_booted" and exit
> early so that it never tries to use virtual config_tables pointer
> if for some unknown resason kexec_get_rsdp_addr() failed.

Well, you can just call your efi_get_setup_data_addr() in
kexec_get_rdsp_addr(), if succeed, go ahead to read ei_info and call
_efi_get_rsdp_addr(). If failed, return to try efi_get_rsdp_addr().

> 
> Currently I check "is_kexec_booted" by subset of efi_get_setup_data_addr().
> Do you know a simpler way to check "is_kexec_booted"?

There seems to be no another way to check, I think your way is good.
Tryint to get it in kexec_get_rdsp_addr() earlier, you don't need to
judge specifically in efi_get_rsdp_addr() again.

> 
> >          if (!pa)
> >                  pa = bios_get_rsdp_addr();
> > 
> >          return pa;
> > }
> 
> -- 
> Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
