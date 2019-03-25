Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9FE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfCYXL5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:11:57 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:35786 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:11:57 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x2PNBP3r032569
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Mar 2019 08:11:25 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2PNBPMq003911;
        Tue, 26 Mar 2019 08:11:25 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x2PN9a3f020489;
        Tue, 26 Mar 2019 08:11:25 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3658210; Tue, 26 Mar 2019 08:10:02 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Tue,
 26 Mar 2019 08:10:01 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
CC:     "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Topic: [PATCH v2] x86/boot: Use EFI setup data if provided
Thread-Index: AQHU4uSRSF49+PGwf02T2oxnk4CVXaYbdAGAgAAWloCAAAX6gIAAF9OAgAAF7gCAAAKjgIAAsh8A
Date:   Mon, 25 Mar 2019 23:10:01 +0000
Message-ID: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
References: <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
In-Reply-To: <20190325123229.GL12016@zn.tnic>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <438C23D6AA3FC84F84B3753EDDE5A2C3@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 9:32 PM, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 08:23:02PM +0800, Dave Young wrote:
>> Kexec saved the original physical addresses, and pass them to kexeced
>> kernel via x86 setup_data, so  both the early parsing or efi init code
>> need to get those physical values from setup_data.
> 
> So efi_get_rsdp_addr() needs to be refactored in such a way so that at
> least the loop towards the end gets carved out into a separate function
> - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
> size as arguments and finds the RSDP address in the kexec-ed kernel.

Since we still need to read systab for nr_tables and do signature
check to determine if it's 32bit or 64bit for kexec-ed kernel,
everything except the address of config_tables are common between
normal boot and kexec boot.

> So we'd need something like that:
> 
> acpi_physical_address get_rsdp_addr(void)
> {
>         acpi_physical_address pa;
> 
>         pa = get_acpi_rsdp();
> 
>         if (!pa)
>                 pa = boot_params->acpi_rsdp_addr;
> 
>         if (!pa)
>                 pa = efi_get_rsdp_addr();
> 
> 	if (!pa)
> 		pa = kexec_get_rdsp_addr();		<--- new function
> 
>         if (!pa)
>                 pa = bios_get_rsdp_addr();
> 
>         return pa;
> }
> 
> which would get config_tables from setup_data and call
> __efi_get_rsdp_addr() to dig it out in the kexec'ed kernel.
> 
> Junichi, ask if it is still unclear what needs to be done.

efi_get_rsdp_addr() and kexec_get_rsdp_addr() could be implemented
like this (sorry about the pseudo code):

  /* This is also used to check if the kernel is kexec-ed. */
  unsigned long efi_get_setup_data_addr(void) {
    return the address of efi_setup_data if kexec-ed or 0 if not;
  }

  acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables) {
    // Do mostly same as the current efi_get_rsdp_addr().
    // If config_tables is non-zero, use it instead of systab->tables.
  }

  acpi_physical_address efi_get_rsdp_addr(void) {
    if (efi_get_setup_data_addr())
      return 0;
    return __efi_get_rsdp_addr(0);
  }

  acpi_physical_address kexec_get_rsdp_addr(void) {
    esd = (struct efi_setup_data *) efi_get_setup_data_addr();
    if (esd && esd->tables)
      return __efi_get_rsdp_addr((unsigned long) esd->tables);
    return 0;
  }

I don't think it looks nice.. Does this match what you envisage?

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
