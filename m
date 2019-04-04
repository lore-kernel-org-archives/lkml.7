Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53076C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246892075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDDHlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfDDHlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:41:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 899F030832E9;
        Thu,  4 Apr 2019 07:41:09 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A6A862669;
        Thu,  4 Apr 2019 07:41:05 +0000 (UTC)
Date:   Thu, 4 Apr 2019 15:41:02 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404074102.GA5970@dhcp-128-65.nay.redhat.com>
References: <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
 <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
 <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
 <20190404030037.GT7627@MiWiFi-R3L-srv>
 <20190404031030.GU7627@MiWiFi-R3L-srv>
 <20190404032238.GA16267@dhcp-128-65.nay.redhat.com>
 <20190404064130.GA5530@dhcp-128-65.nay.redhat.com>
 <20190404072007.GL1555@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404072007.GL1555@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 04 Apr 2019 07:41:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,
On 04/04/19 at 03:20pm, Chao Fan wrote:
> On Thu, Apr 04, 2019 at 02:41:30PM +0800, Dave Young wrote:
> >On 04/04/19 at 11:22am, Dave Young wrote:
> >> On 04/04/19 at 11:10am, Baoquan He wrote:
> >> > On 04/04/19 at 11:00am, Baoquan He wrote:
> >> > > On 04/04/19 at 10:52am, Dave Young wrote:
> >> > > > On 04/04/19 at 01:23am, Junichi Nomura wrote:
> >> >  +	/* Save RSDP address for later use. */
> >> >  +	boot_params->acpi_rsdp_addr = get_rsdp_addr();
> >> >  +
> >> >  +	error("Hang kernel for kexec debugging");
> >> > 
> >> > Sorry, here I means calling error() to hang kernel after calling
> >> > get_rsdp_addr().
> >> 
> >> Thanks, it did not hang, it always reset to firmware/grub boot menu.
> >> I'm pretty sure now the bug exists in get_rsdp_addr().
> >
> >static acpi_physical_address kexec_get_rsdp_addr(void)
> >{
> >...
> >        /* Get systab from boot params. */
> >        systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> >        if (!systab)
> >              error("EFI system table not found in kexec boot_params.");
> > 
> >...
> >  -> add error("hang me") here will have a hang
> >...
> >        return __efi_get_rsdp_addr((unsigned long)esd->tables,
> >                                   systab->nr_tables, true);
> > 
> 
> I have an idea, but not sure whether is a problem.
> In code of Nomura:
> 
> #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
> [...]
>         if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
>                 debug_putstr("Wrong kexec EFI loader signature.\n");
>                 return 0;
>         }
> 
>         /* Get systab from boot params. */
>         systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> [...]
> #endif
> 
> After review agian, I wonder what will happen if 32bit-efi boot 64bit
> OS.

It is hard to find 32bit efi hardware, I can confirm all the laptop I
have are 64bit efi.

In case 32bit efi EFI64_LOADER_SIGNATURE checking will be false.
