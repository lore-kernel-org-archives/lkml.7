Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B141C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06182075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1G1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:27:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42479 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfC1G1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:27:42 -0400
X-IronPort-AV: E=Sophos;i="5.60,278,1549900800"; 
   d="scan'208";a="57898735"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Mar 2019 14:27:36 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3A70F4CD5D25;
        Thu, 28 Mar 2019 14:27:34 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 28 Mar 2019 14:27:40 +0800
Date:   Thu, 28 Mar 2019 14:26:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190328062645.GG4234@localhost.localdomain>
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
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 3A70F4CD5D25.AC066
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:17:16AM +0000, Junichi Nomura wrote:
>On 2019/03/27 10:48, bhe@redhat.com wrote:
>>>> So efi_get_rsdp_addr() needs to be refactored in such a way so that at
>>>> least the loop towards the end gets carved out into a separate function
>>>> - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
>>>> size as arguments and finds the RSDP address in the kexec-ed kernel.
>>>
>>> You need to carve out the loop at the end and make it into a separate
>>> __efi_get_rsdp_addr() function which gets the physical or the virtual
>>> address.
>> 
>> I guess Boris is suggesting code like below. Please correct me if I am
>> wrong.
>> 
>> static acpi_physical_address _efi_get_rsdp_addr(efi_config_table tbl, ...)
>> {
>> 	/* Get EFI tables from systab. */
>> 	for (i = 0; i < nr_tables; i++) {
>> 		...
>> 	}
>> 	return rsdp_addr;
>> }
>> 
>> static acpi_physical_address efi_get_rsdp_addr(void)
>> {
>> 	...
>> 	/* Get systab from boot params. */		
>> 	...
>> 	/* Handle EFI bitness properly */
>> 	...
>> 	return _efi_get_rsdp_addr();
>> }
>> 
>> 
>> static acpi_physical_address kexec_get_rsdp_addr(void)
>> {
>> 	if (!is_kexec_booted)
>> 		return 0;
>> 
>> 	efi_get_setup_data_addr();
>> 	...
>> 	/* Handle EFI bitness properly */
>> 	...
>> 	return _efi_get_rsdp_addr();
>> }
>
>I still don't get it... We still need systab for kexec case as well
>to get nr_tables. Don't we?
>
>> acpi_physical_address get_rsdp_addr(void)
>> {
>>          acpi_physical_address pa;
>> 
>>          pa = get_acpi_rsdp();
>> 
>>          if (!pa)
>>                  pa = boot_params->acpi_rsdp_addr;
>> 
>> 
>> 	/**
>> 	/*I think here we should check if it's kexec booted firstly.
>> 	 * Skip it if not kexec. this can avoid the wrong kexec virt
>> 	 * addr parsing./
>>          if (!pa)
>>                  pa = kexec_get_rdsp_addr();             <--- new function
>> 
>>          if (!pa)
>>                  pa = efi_get_rsdp_addr();
>> 
>
>Shouldn't t efi_get_rsdp_addr() check "is_kexec_booted" and exit
>early so that it never tries to use virtual config_tables pointer
>if for some unknown resason kexec_get_rsdp_addr() failed.

In my understanding, in EFI issue, RSDP is from efi_get_rsdp_addr() or
kexec_get_rdsp_addr()(only in kexec environment). So in these two functions
only one can be excuted, so how about this:

if (is_kexec_booted)
	pa = kexec_get_rdsp_addr();	<--- new function
else
	pa = efi_get_rsdp_addr();

And also split the same code as _efi_get_rsdp_addr().
If there is something wrong in my understanding, please let me know.

Thanks,
Chao Fan

>
>Currently I check "is_kexec_booted" by subset of efi_get_setup_data_addr().
>Do you know a simpler way to check "is_kexec_booted"?
>
>>          if (!pa)
>>                  pa = bios_get_rsdp_addr();
>> 
>>          return pa;
>> }
>
>-- 
>Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
>


