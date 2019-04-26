Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB32C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38322206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OijZ2QGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfDZSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:54:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556304881; x=1587840881;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QCkduY6i7W/0GLFHHqUFRDPtKBVpibe/l2EmUd8Fo8A=;
  b=OijZ2QGGe0EhfUybWihq3XWaAVonuqKco00TmmRyUernh9xeArQSpJDr
   oQCPyYep+8IJteP3uBlFf4fUlasC6aVcW3ULNmKtbVRBoWpgVf6h/L1jg
   54EcZ2XOfdGlgxVIAmTPeXNa/txcv7ds/2lTs+S4U+XE5qXe41/j3KM1u
   kOPoVZzCTgmCfTsqsEexdwtSabxtkxDfgkkSI2SjRcqtA5kkSY+4NHDMr
   uRosplOMVxfGa79ZCQ7jDGgfW0oeG44wVxHDBO1TZrl1szzBeaE1n2YRL
   nEALlIr+oRRSSrq2GuFCcvzqndU/GfnsdAFXHDXvlkojDPMKTatZaMoQO
   A==;
X-IronPort-AV: E=Sophos;i="5.60,398,1549900800"; 
   d="scan'208";a="108145182"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2019 02:54:37 +0800
IronPort-SDR: MOaxUSXw9+MVxiEXGIGv07c/jxm2ibfFaO6Mqjd9wSwet+IYr12a2YhwVtHW7UpaFJ0g8JBoiY
 twHpXVxHKUX1KrVoeX2V2QoAPvBrxJJ4JazIhWZ7jh86UodeQEhynqoio2bSHOILQTJx0pjhMa
 mJApzb3olCrQkq2+hMdQNXCK9FqiJYxW5VKyukTHpCqhMESMZOC9cbou8IkwwtsNRGP6S5rMKS
 9c2Zt1UpmlfXRWypfFsJFFk8PeiJqx7Y1iTq3uUJopLF/XkskXE7ug9zKqvmpFGoLNE0cnVkTf
 omJGQ2AQthzTbKWTVNIHi/OO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Apr 2019 11:31:05 -0700
IronPort-SDR: mZkLVynK7jt6WXjY4sPbvQvHPQg51BEHjcxxXPl630IB/Z+DtHp6ObrhYoi5jTczGevJJWyjbX
 3ZZdbtGl/JDQED4u/z3Zxfj4+CzUj0NL0hoYSkepePfftWptMl3RanIKnSj/HoTdbyAlwFPSRb
 nIe5k4mdvDJk4ueHhRphFmtwcmVHbpTMWsmZZW1714qdzXOR6n1cSdr/NkOElMvXQkA6mqrue8
 x8gHXkR5q5pfUfeJWD3sLkmYLqajsOkg0Gk7ldD1mq3TDpwDGdC+MfOqgRacRUZuKzCaiRQQS/
 OeM=
Received: from unknown (HELO [10.86.51.128]) ([10.86.51.128])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2019 11:54:37 -0700
Subject: Re: [2/3] RISC-V: Update tlb flush counters
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>
References: <mhng-beb18d22-55b3-4a5f-9e29-a560ab168dff@palmer-si-x1e>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <9a05ed69-3916-fbd8-8728-1d247f6b61b2@wdc.com>
Date:   Fri, 26 Apr 2019 11:54:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-beb18d22-55b3-4a5f-9e29-a560ab168dff@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 10:31 PM, Palmer Dabbelt wrote:
> On Wed, 10 Apr 2019 15:44:48 PDT (-0700), atish.patra@wdc.com wrote:
>> The TLB flush counters under vmstat seems to be very helpful while
>> debugging TLB flush performance in RISC-V.
>>
>> Update the counters in every TLB flush methods respectively.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/tlbflush.h |  5 +++++
>>   arch/riscv/mm/tlbflush.c          | 12 ++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> index 29a780ca232a..19779a083f52 100644
>> --- a/arch/riscv/include/asm/tlbflush.h
>> +++ b/arch/riscv/include/asm/tlbflush.h
>> @@ -9,6 +9,7 @@
>>   #define _ASM_RISCV_TLBFLUSH_H
>>
>>   #include <linux/mm_types.h>
>> +#include <linux/vmstat.h>
>>
>>   /*
>>    * Flush entire local TLB.  'sfence.vma' implicitly fences with the instruction
>> @@ -16,11 +17,13 @@
>>    */
>>   static inline void local_flush_tlb_all(void)
>>   {
>> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>>   	__asm__ __volatile__ ("sfence.vma" : : : "memory");
>>   }
>>
>>   static inline void local_flush_tlb_mm(struct mm_struct *mm)
>>   {
>> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>>   	/* Flush ASID 0 so that global mappings are not affected */
>>   	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (0) : "memory");
>>   }
>> @@ -28,6 +31,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
>>   static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>>   	unsigned long addr)
>>   {
>> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
>>   	__asm__ __volatile__ ("sfence.vma %0, %1"
>>   			      : : "r" (addr), "r" (0)
>>   			      : "memory");
>> @@ -35,6 +39,7 @@ static inline void local_flush_tlb_page(struct vm_area_struct *vma,
>>
>>   static inline void local_flush_tlb_kernel_page(unsigned long addr)
>>   {
>> +	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
>>   	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
>>   }
>>
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index ceee76f14a0a..8072d7da32bb 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -4,6 +4,8 @@
>>    */
>>
>>   #include <linux/mm.h>
>> +#include <linux/vmstat.h>
>> +#include <linux/cpumask.h>
>>   #include <asm/sbi.h>
>>
>>   #define SFENCE_VMA_FLUSH_ALL ((unsigned long) -1)
>> @@ -110,6 +112,7 @@ static void ipi_remote_sfence_vma(void *info)
>>   	unsigned long size = data->size;
>>   	unsigned long i;
>>
>> +	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
>>   	if (size == SFENCE_VMA_FLUSH_ALL) {
>>   		local_flush_tlb_all();
>>   	}
>> @@ -129,6 +132,8 @@ static void ipi_remote_sfence_vma_asid(void *info)
>>   	unsigned long size = data->size;
>>   	unsigned long i;
>>
>> +	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
>> +	/* Flush entire MM context */
>>   	if (size == SFENCE_VMA_FLUSH_ALL) {
>>   		__asm__ __volatile__ ("sfence.vma x0, %0"
>>   				      : : "r" (asid)
>> @@ -158,6 +163,13 @@ static void remote_sfence_vma(unsigned long start, unsigned long size)
>>   static void remote_sfence_vma_asid(cpumask_t *mask, unsigned long start,
>>   				   unsigned long size, unsigned long asid)
>>   {
>> +	int cpuid = smp_processor_id();
>> +
>> +	if (cpumask_equal(mask, cpumask_of(cpuid)))
>> +		count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>> +	else
>> +		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
>> +
>>   	if (tlbi_ipi) {
>>   		struct tlbi info = {
>>   			.start = start,
> 
> Looks good, but it's not applying on for-next (based on rc6).  Do you mind
> re-spinning the patches?
> 
> 

This patch depends is based on Gary's TLB flush patch series

https://patchwork.kernel.org/project/linux-riscv/list/?series=97315

So it should only be merged on top of it.

Regards,
Atish
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

