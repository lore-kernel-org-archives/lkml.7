Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CC4C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B172075C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 16:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfEZQJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 12:09:00 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59573 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEZQJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 12:09:00 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E836A240005;
        Sun, 26 May 2019 16:08:48 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH REBASE v2 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE
 config in arch/Kconfig
References: <20190526125038.8419-1-alex@ghiti.fr>
 <20190526125038.8419-2-alex@ghiti.fr> <20190526144230.GA13220@gmail.com>
Message-ID: <2c1c9ad4-257a-faba-7ae0-0eb2dd0d09b3@ghiti.fr>
Date:   Sun, 26 May 2019 12:08:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190526144230.GA13220@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/19 10:42 AM, Ingo Molnar wrote:
> * Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> ARCH_WANT_HUGE_PMD_SHARE config was declared in both architectures:
>> move this declaration in arch/Kconfig and make those architectures
>> select it.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>   arch/Kconfig       | 3 +++
>>   arch/arm64/Kconfig | 2 +-
>>   arch/x86/Kconfig   | 4 +---
>>   3 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index c47b328eada0..d2f212dc8e72 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -577,6 +577,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>   config HAVE_ARCH_HUGE_VMAP
>>   	bool
>>   
>> +config ARCH_WANT_HUGE_PMD_SHARE
>> +	bool
>> +
>>   config HAVE_ARCH_SOFT_DIRTY
>>   	bool
>>   
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4780eb7af842..dee7f750c42f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -70,6 +70,7 @@ config ARM64
>>   	select ARCH_SUPPORTS_NUMA_BALANCING
>>   	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>>   	select ARCH_WANT_FRAME_POINTERS
>> +	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>   	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>   	select ARM_AMBA
>>   	select ARM_ARCH_TIMER
>> @@ -884,7 +885,6 @@ config SYS_SUPPORTS_HUGETLBFS
>>   	def_bool y
>>   
>>   config ARCH_WANT_HUGE_PMD_SHARE
>> -	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>   
>>   config ARCH_HAS_CACHE_LINE_SIZE
>>   	def_bool y
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 2bbbd4d1ba31..fa021ec38803 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -93,6 +93,7 @@ config X86
>>   	select ARCH_USE_QUEUED_SPINLOCKS
>>   	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>>   	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>> +	select ARCH_WANT_HUGE_PMD_SHARE
>>   	select ARCH_WANTS_THP_SWAP		if X86_64
>>   	select BUILDTIME_EXTABLE_SORT
>>   	select CLKEVT_I8253
>> @@ -301,9 +302,6 @@ config ARCH_HIBERNATION_POSSIBLE
>>   config ARCH_SUSPEND_POSSIBLE
>>   	def_bool y
>>   
>> -config ARCH_WANT_HUGE_PMD_SHARE
>> -	def_bool y
>> -
>>   config ARCH_WANT_GENERAL_HUGETLB
>>   	def_bool y
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks !

Alex

>
> Thanks,
>
> 	Ingo
