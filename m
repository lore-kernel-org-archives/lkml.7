Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F22C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D99620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfDDHUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:20:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46323 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbfDDHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:20:16 -0400
X-IronPort-AV: E=Sophos;i="5.60,306,1549900800"; 
   d="scan'208";a="58457312"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Apr 2019 15:20:12 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C60684CD7EE6;
        Thu,  4 Apr 2019 15:20:10 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 4 Apr 2019 15:20:18 +0800
Date:   Thu, 4 Apr 2019 15:20:07 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Dave Young <dyoung@redhat.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404072007.GL1555@localhost.localdomain>
References: <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
 <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
 <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
 <20190404030037.GT7627@MiWiFi-R3L-srv>
 <20190404031030.GU7627@MiWiFi-R3L-srv>
 <20190404032238.GA16267@dhcp-128-65.nay.redhat.com>
 <20190404064130.GA5530@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190404064130.GA5530@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C60684CD7EE6.ACFD0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:41:30PM +0800, Dave Young wrote:
>On 04/04/19 at 11:22am, Dave Young wrote:
>> On 04/04/19 at 11:10am, Baoquan He wrote:
>> > On 04/04/19 at 11:00am, Baoquan He wrote:
>> > > On 04/04/19 at 10:52am, Dave Young wrote:
>> > > > On 04/04/19 at 01:23am, Junichi Nomura wrote:
>> >  +	/* Save RSDP address for later use. */
>> >  +	boot_params->acpi_rsdp_addr = get_rsdp_addr();
>> >  +
>> >  +	error("Hang kernel for kexec debugging");
>> > 
>> > Sorry, here I means calling error() to hang kernel after calling
>> > get_rsdp_addr().
>> 
>> Thanks, it did not hang, it always reset to firmware/grub boot menu.
>> I'm pretty sure now the bug exists in get_rsdp_addr().
>
>static acpi_physical_address kexec_get_rsdp_addr(void)
>{
>...
>        /* Get systab from boot params. */
>        systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
>        if (!systab)
>              error("EFI system table not found in kexec boot_params.");
> 
>...
>  -> add error("hang me") here will have a hang
>...
>        return __efi_get_rsdp_addr((unsigned long)esd->tables,
>                                   systab->nr_tables, true);
> 

I have an idea, but not sure whether is a problem.
In code of Nomura:

#if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
[...]
        if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
                debug_putstr("Wrong kexec EFI loader signature.\n");
                return 0;
        }

        /* Get systab from boot params. */
        systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
[...]
#endif

After review agian, I wonder what will happen if 32bit-efi boot 64bit
OS.

Ever meet a problem:
https://lkml.org/lkml/2019/2/8/845

It's a efi32 bootloader to boot a 64bit OS, then a problem happened.


Thanks,
Chao Fan

>But add error("hang me") in __efi_get_rsdp_addr it did not hang.
> 
>It seems reference the systab pointer cause a system reset.
> 
>A question is does the identity mapping covered the memory address of
>systab?
> 
>In my case it is 0xdad9ef18
> 
>If the memory is mapped on demand, then there will be problems, it
>should cover setup_data and efi table space.
> 
>Thanks
>Dave
>
>
>


