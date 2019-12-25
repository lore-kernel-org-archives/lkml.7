Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA3C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6502073B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNjq1wPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLYTBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 14:01:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48754 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbfLYTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 14:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577300502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXL6M/v1cLO/JOoBiBUbtLoMBRFpX7bcoPYQWy5enEk=;
        b=ZNjq1wPqGWTk2zBgJuEV8qAdjy/Ofzzv3ALDakDQyMOzIVI7RSL6kzy7/yEXzZ99ox9xs6
        aytW1xpLpDqF9k1Kq4KtjudxWnyGNlptZVjHJZ9/JFKgMNpp3Gj2ZEVlpu53ndk3YIA+FY
        8YnEQwuKp2xfHVX/gc9750zBaBkDyf0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Dnn3m2oMPYqPaHJLLNt-FQ-1; Wed, 25 Dec 2019 14:01:36 -0500
X-MC-Unique: Dnn3m2oMPYqPaHJLLNt-FQ-1
Received: by mail-pj1-f71.google.com with SMTP id n90so4472541pji.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 11:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXL6M/v1cLO/JOoBiBUbtLoMBRFpX7bcoPYQWy5enEk=;
        b=k/BgDBJG+5UlB9B/9VlPTXDPePae4e0bVdeSeVjS0BQUFHvpXv0g/V78VExOk/3/n2
         293OrdkfqQPglfM0RceNYdXdI4EXgyCyiB/QtH299qnuprmQaAsjZrsXdz7uuz6G38MF
         dJ3CXNUHFkLLeEjVGsPCDiddJg0j9Iwv4qWRPxGDT50yYDSVygrjY72rJ3VQk7Ji0l2d
         Xqb53VBKjL8XF3xjeF8BNxVyPiXqjOMF2wipQrgHn1Yg4jtKFgz7pYDIh5FFgxdGjKON
         M/ULJOD/OhrrBiajeFqROjjTOJPRbrYMPKjcftPY+duC5e+le6x104oolhX2h/ODB6Dw
         9XYQ==
X-Gm-Message-State: APjAAAXeQNcz0u4u1XIlf8SEU5DocFzDUsPd3n8XQ6OOMF9pAkfg1i0h
        vNDBQ9Z+Ow/uyBhpsTaZ/qPWgG6QLQXDUVlo8pERW/gm2+HKnj8HO5Zv1RUylWpdgTHVNlAM+6+
        3L6XVv2OPA65Bd1bnevGT7ZZw
X-Received: by 2002:a62:1746:: with SMTP id 67mr28390457pfx.45.1577300495264;
        Wed, 25 Dec 2019 11:01:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIwvYJF0Vmy7pc049WdLIXroBQQIkXYRns8gxHAM77TrZXjaETfikXFa/P4h4Wb8/yLyJk/A==
X-Received: by 2002:a62:1746:: with SMTP id 67mr28390426pfx.45.1577300494996;
        Wed, 25 Dec 2019 11:01:34 -0800 (PST)
Received: from localhost.localdomain ([122.177.237.105])
        by smtp.gmail.com with ESMTPSA id hg11sm7447136pjb.14.2019.12.25.11.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 11:01:34 -0800 (PST)
Subject: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com>
 <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com>
Date:   Thu, 26 Dec 2019 00:31:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 12/12/2019 04:02 PM, James Morse wrote:
> Hi Bhupesh,
> 
> On 29/11/2019 19:59, Bhupesh Sharma wrote:
>> vabits_actual variable on arm64 indicates the actual VA space size,
>> and allows a single binary to support both 48-bit and 52-bit VA
>> spaces.
>>
>> If the ARMv8.2-LVA optional feature is present, and we are running
>> with a 64KB page size; then it is possible to use 52-bits of address
>> space for both userspace and kernel addresses. However, any kernel
>> binary that supports 52-bit must also be able to fall back to 48-bit
>> at early boot time if the hardware feature is not present.
>>
>> Since TCR_EL1.T1SZ indicates the size offset of the memory region
>> addressed by TTBR1_EL1 (and hence can be used for determining the
>> vabits_actual value) it makes more sense to export the same in
>> vmcoreinfo rather than vabits_actual variable, as the name of the
>> variable can change in future kernel versions, but the architectural
>> constructs like TCR_EL1.T1SZ can be used better to indicate intended
>> specific fields to user-space.
>>
>> User-space utilities like makedumpfile and crash-utility, need to
>> read/write this value from/to vmcoreinfo
> 
> (write?)

Yes, also write so that the vmcoreinfo from an (crashing) arm64 system 
can be used for analysis of the root-cause of panic/crash on say an 
x86_64 host using utilities like crash-utility/gdb.

>> for determining if a virtual address lies in the linear map range.
> 
> I think this is a fragile example. The debugger shouldn't need to know this.

Well that the current user-space utility design, so I am not sure we can 
tweak that too much.

>> The user-space computation for determining whether an address lies in
>> the linear map range is the same as we have in kernel-space:
>>
>>    #define __is_lm_address(addr)	(!(((u64)addr) & BIT(vabits_actual - 1)))
> 
> This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA space"). If user-space
> tools rely on 'knowing' the kernel memory layout, they must have to constantly be fixed
> and updated. This is a poor argument for adding this to something that ends up as ABI.

See above. The user-space has to rely on some ABI/guaranteed 
hardware-symbols which can be used for 'determining' the kernel memory 
layout.

> I think a better argument is walking the kernel page tables from the core dump.
> Core code's vmcoreinfo exports the location of the kernel page tables, but in the example
> above you can't walk them without knowing how T1SZ was configured.

Sure, both makedumpfile and crash-utility (which walks the kernel page 
tables from the core dump) use this (and similar) information currently 
in the user-space.

> On older kernels, user-space that needs this would have to assume the value it computes
> from VA_BITs (also in vmcoreinfo) is the value in use.

Yes, backward compatibility has been handled in the user-space already.

> ---%<---
>> I have sent out user-space patches for makedumpfile and crash-utility
>> to add features for obtaining vabits_actual value from TCR_EL1.T1SZ (see
>> [0] and [1]).
>>
>> Akashi reported that he was able to use this patchset and the user-space
>> changes to get user-space working fine with the 52-bit kernel VA
>> changes (see [2]).
>>
>> [0]. http://lists.infradead.org/pipermail/kexec/2019-November/023966.html
>> [1]. http://lists.infradead.org/pipermail/kexec/2019-November/024006.html
>> [2]. http://lists.infradead.org/pipermail/kexec/2019-November/023992.html
> ---%<---
> 
> This probably belongs in the cover letter instead of the commit log.

Ok.

> (From-memory: one of vmcore/kcore is virtually addressed, the other physically. Does this
> fix your poblem in both cases?)
> 
> 
>> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
>> index ca4c3e12d8c5..f78310ba65ea 100644
>> --- a/arch/arm64/kernel/crash_core.c
>> +++ b/arch/arm64/kernel/crash_core.c
>> @@ -7,6 +7,13 @@
>>   #include <linux/crash_core.h>
>>   #include <asm/memory.h>
> 
> You need to include asm/sysreg.h for read_sysreg(), and asm/pgtable-hwdef.h for the macros
> you added.

Ok. Will check as I did not get any compilation errors without the same 
and build-bot also did not raise a flag for the missing include files.

>> +static inline u64 get_tcr_el1_t1sz(void);

> Why do you need to do this?

Without this I was getting a missing declaration error, while compiling 
the code.

>> +static inline u64 get_tcr_el1_t1sz(void)
>> +{
>> +	return (read_sysreg(tcr_el1) & TCR_T1SZ_MASK) >> TCR_T1SZ_OFFSET;
>> +}
> 
> (We don't modify this one, and its always the same one very CPU, so this is fine.
> This function is only called once when the stringy vmcoreinfo elf_note is created...)

Right.

>>   void arch_crash_save_vmcoreinfo(void)
>>   {
>>   	VMCOREINFO_NUMBER(VA_BITS);
>> @@ -15,5 +22,7 @@ void arch_crash_save_vmcoreinfo(void)
>>   						kimage_voffset);
>>   	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
>>   						PHYS_OFFSET);
>> +	vmcoreinfo_append_str("NUMBER(tcr_el1_t1sz)=0x%llx\n",
>> +						get_tcr_el1_t1sz());
> 
> You document the name as being upper-case.
> The two values either values either side are upper-case.
Ok, will fix this in v6. Thanks for your inputs.

>>   	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>>   }

Thanks,
Bhupesh

