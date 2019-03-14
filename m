Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1E2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCNOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:22:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45439 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCNOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:22:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id 125so4063993pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POuKTkkOp6hpixOyLDOSStCD0dO0pbIsQZmjw5z0GA0=;
        b=Mc/J8UtV+bG0Kn/6Mig1DwRIBjWQHL8RqOtoARk+SIOY2IRcNO5eHNSVQogxF9ISZn
         AdRzz3VXKd2ENgxovoc3nCmSr+5Cbymfq1b6fjIux7a+guqaSG8cuKedpCaXJujh3+CS
         zrRES3Vd0jtAVboe1t9ULg67bylX8387Ivyk9gZ8AqvTz2nspV4XD584NYXqpG90MQen
         Zm1WP+4MBgKqj2e5qnhdgPiT2Z4yxnmVsDTz57pd/b75o/pFaKyQY7QOFC9jIxnVrM7n
         QayhfgA2hbEkNPMpbuYP9jauhzJHZHngNFrW82Z++PU3Fen8qlwMQ7iCV0gqUzq95BbV
         e5eg==
X-Gm-Message-State: APjAAAX2Pe2S15HGVYHQ1s5kUJ5kllwivF4UgzgtBTvIph6nHgnR4RYo
        SQigDR0N5dxfwmuxAGIErqkDhw==
X-Google-Smtp-Source: APXvYqzqkNXgmj9z2vZwc+Uhr8GESRGGe/Ikis+IAXgJdivIUvGI9O9nWRKw5QEAQJ5FF7xHmYeR9w==
X-Received: by 2002:a63:da43:: with SMTP id l3mr45865521pgj.164.1552573355724;
        Thu, 14 Mar 2019 07:22:35 -0700 (PDT)
Received: from localhost.localdomain ([106.215.118.61])
        by smtp.gmail.com with ESMTPSA id f65sm23771178pff.21.2019.03.14.07.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:22:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS'
 to vmcoreinfo
To:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <6dac3aec-3f18-de67-f620-aed063986a17@redhat.com>
Date:   Thu, 14 Mar 2019 19:52:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kazu,

On 03/13/2019 01:17 AM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>> Right now user-space tools like 'makedumpfile' and 'crash' need to rely
>> on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
>> supported by underlying kernel.
>>
>> This value is used in user-space code to calculate the bit-space
>> required to store a section for SPARESMEM (similar to the existing
>> calculation method used in the kernel implementation):
>>
>>    #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
>>
>> Now, regressions have been reported in user-space utilities
>> like 'makedumpfile' and 'crash' on arm64, with the recently added
>> kernel support for 52-bit physical address space, as there is
>> no clear method of determining this value in user-space
>> (other than reading kernel CONFIG flags).
>>
>> As per suggestion from makedumpfile maintainer (Kazu), it makes more
>> sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
>> rather than in arch-specific code, so that the user-space code for other
>> archs can also benefit from this addition to the vmcoreinfo and use it
>> as a standard way of determining 'SECTIONS_SHIFT' value in user-land.
>>
>> A reference 'makedumpfile' implementation which reads the
>> 'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
>> is available here:
>>
>> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471
>>
>> Cc: Boris Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Cc: x86@kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   kernel/crash_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 093c9f917ed0..44b90368e183 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
>>   	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>>   #endif
>> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> 
> Some architectures define MAX_PHYSMEM_BITS only with CONFIG_SPARSEMEM,
> so we need to move this to the #ifdef section that exports some
> mem_section things.
> 
> Thanks!
> Kazu

Sorry for the late response, I wanted to make sure I check almost all  
archs to understand if a proposal would work for all.

As per my current understanding, we can protect the export of  
'MAX_PHYSMEM_BITS' via a #ifdef section against CONFIG_SPARSEMEM, and it  
should work for all archs. Here are some arguments to support the same,  
would request maintainers of various archs (in Cc) to correct me if I am  
missing something here:

1. SPARSEMEM is dependent upon on (!SELECT_MEMORY_MODEL &&  
ARCH_SPARSEMEM_ENABLE) || SPARSEMEM_MANUAL:

config SPARSEMEM
	def_bool y
	depends on (!SELECT_MEMORY_MODEL && ARCH_SPARSEMEM_ENABLE) ||  
SPARSEMEM_MANUAL

2. For a couple of archs, this option is already turned on by default in  
their respective defconfigs:

$ grep -nrw "CONFIG_SPARSEMEM_MANUAL" *
arch/ia64/configs/gensparse_defconfig:18:CONFIG_SPARSEMEM_MANUAL=y
arch/powerpc/configs/ppc64e_defconfig:30:CONFIG_SPARSEMEM_MANUAL=y

3. Note that other archs use ARCH_SPARSEMEM_DEFAULT to define if  
CONFIG_SPARSEMEM_MANUAL is set by default:

choice
	prompt "Memory model"
         ..
	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT

3a.

$ grep -nrw -A 2 "ARCH_SPARSEMEM_DEFAULT" *
arch/s390/Kconfig:621:config ARCH_SPARSEMEM_DEFAULT
arch/s390/Kconfig-622-	def_bool y
--
arch/x86/Kconfig:1623:config ARCH_SPARSEMEM_DEFAULT
arch/x86/Kconfig-1624-	def_bool y
arch/x86/Kconfig-1625-	depends on X86_64
--
arch/powerpc/Kconfig:614:config ARCH_SPARSEMEM_DEFAULT
arch/powerpc/Kconfig-615-	def_bool y
arch/powerpc/Kconfig-616-	depends on PPC_BOOK3S_64
--
arch/arm64/Kconfig:850:config ARCH_SPARSEMEM_DEFAULT
arch/arm64/Kconfig-851-	def_bool ARCH_SPARSEMEM_ENABLE
--
arch/sh/mm/Kconfig:138:config ARCH_SPARSEMEM_DEFAULT
arch/sh/mm/Kconfig-139-	def_bool y
--
arch/sparc/Kconfig:315:config ARCH_SPARSEMEM_DEFAULT
arch/sparc/Kconfig-316-	def_bool y if SPARC64
--
arch/arm/Kconfig:1591:config ARCH_SPARSEMEM_DEFAULT
arch/arm/Kconfig-1592-	def_bool ARCH_SPARSEMEM_ENABLE

Since most archs (except MIPS) set  
CONFIG_ARCH_SPARSEMEM_DEFAULT/CONFIG_ARCH_SPARSEMEM_ENABLE to y in the  
default configurations, so even though they don't protect  
'MAX_PHYSMEM_BITS' define in CONFIG_SPARSEMEM ifdef sections, we still  
would be ok protecting the 'MAX_PHYSMEM_BITS' vmcoreinfo export inside a  
CONFIG_SPARSEMEM ifdef section.

Thanks for your inputs, I will include this change in the v3.

Regards,
Bhupesh
