Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBCBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CB72173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfC2JGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:06:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44742 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728741AbfC2JGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:06:48 -0400
X-IronPort-AV: E=Sophos;i="5.60,283,1549900800"; 
   d="scan'208";a="57994348"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Mar 2019 17:06:44 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 6D4EA4CD615C;
        Fri, 29 Mar 2019 17:06:39 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 29 Mar 2019 17:06:39 +0800
Date:   Fri, 29 Mar 2019 17:05:50 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "bhe@redhat.com" <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190329090550.GI4234@localhost.localdomain>
References: <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <0263068e-f2d0-1101-0438-0f570f0b38e7@ce.jp.nec.com>
 <20190329083920.GA21152@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190329083920.GA21152@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 6D4EA4CD615C.ADA96
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:39:20AM +0100, Borislav Petkov wrote:
>On Fri, Mar 29, 2019 at 03:05:52AM +0000, Junichi Nomura wrote:
>> > You don't need that variable and can return "table" or 0 after the endif
>> > below.
>> 
>> I could do that but it will slightly change the current logic.
>> 
>> Existing code does this:
>> 
>>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>>                         rsdp_addr = table;
>>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>>                         return table;
>> 
>> I thought it was to return the table for ACPI_20_TABLE_GUID
>> if both tables exist.  If we remove rsdp_addr, the code will be:
>> 
>>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>>                         return table;
>>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>>                         return table;
>> 
>> So if there are 2 tables, we return the one that comes first.
>> Is it ok?
>
>That's a good question.
>
>Chao, what was the intention there, ACPI_20_TABLE_GUID is the preferred
>table to return? If so, why?

Yes, ACPI_20_TABLE_GUID is preferred.

ACPI_20 means version 2.0 and later versions, ACPI_TABLE_GUID is version 1.0
which is earlier than 2003, it's too old. Version 2.0 has more features than 1.0.
Sure the new version is preferred.

So many codes prefers ACPI20, such as in drivers/acpi/osl.c where kernel
parses RSDP ACPI20 firstly. Documentation/ABI/testing/sysfs-firmware-efi says in
/sys/firmware/efi/systab, ACPI20 comes before ACPI. So that kexec-tools
code kexec/arch/i386/crashdump-x86.c can easily get ACPI_20(if there is
ACPI_20) before ACPI 1.0.
But in my code, I am not sure which version will be found firstly, so I
write this logical, if ACPI20 found, return directly, then consider ACPI 1.0.

Thanks,
Chao Fan

>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


