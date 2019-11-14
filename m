Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B08206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKNRWm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:22:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47171 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfKNRWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:22:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47DSwZ3GWsz9tyQj;
        Thu, 14 Nov 2019 18:22:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OHKAN8ebFxEF; Thu, 14 Nov 2019 18:22:38 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47DSwZ2V60z9tyQQ;
        Thu, 14 Nov 2019 18:22:38 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id F2FC68E8; Thu, 14 Nov 2019 18:24:24 +0100 (CET)
Received: from 37.171.113.99 ([37.171.113.99]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 14 Nov 2019 18:24:24 +0100
Date:   Thu, 14 Nov 2019 18:24:24 +0100
Message-ID: <20191114182424.Horde.vUb7nGovT-Sg_Gzpih2Gsg3@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/hw_breakpoints: Rewrite 8xx breakpoints to
 allow any address range size.
References: <b1142845c040b9702d1609d5ec473d97595dc0c3.1566925029.git.christophe.leroy@c-s.fr>
 <1ed0de54ce6021fa0fdf50e938365546a4f5e316.1566925030.git.christophe.leroy@c-s.fr>
 <87zhgyzu7a.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zhgyzu7a.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Unlike standard powerpc, Powerpc 8xx doesn't have SPRN_DABR, but
>> it has a breakpoint support based on a set of comparators which
>> allow more flexibility.
>>
>> Commit 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint")
>> implemented breakpoints by emulating the DABR behaviour. It did
>> this by setting one comparator the match 4 bytes at breakpoint address
>> and the other comparator to match 4 bytes at breakpoint address + 4.
>>
>> Rewrite 8xx hw_breakpoint to make breakpoints match all addresses
>> defined by the breakpoint address and length by making full use of
>> comparators.
>>
>> Now, comparator E is set to match any address greater than breakpoint
>> address minus one. Comparator F is set to match any address lower than
>> breakpoint address plus breakpoint length.
>>
>> When the breakpoint range starts at address 0, the breakpoint is set
>> to match comparator F only. When the breakpoint range end at address
>> 0xffffffff, the breakpoint is set to match comparator E only.
>> Otherwise the breakpoint is set to match comparator E and F.
>>
>> At the same time, use registers bit names instead of hardcode values.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/reg_8xx.h  | 14 ++++++++++
>>  arch/powerpc/kernel/hw_breakpoint.c |  3 ++
>>  arch/powerpc/kernel/process.c       | 55  
>> ++++++++++++++++++++++---------------
>>  3 files changed, 50 insertions(+), 22 deletions(-)
>
> I thought Ravi was going to pick this up in his series, but seems not.
> So now this no longer applies since I merged that series.
>
> Can one of you rebase and resend please?

I'm on holiday in the Alps for two weeks. Won't be able to do it  
before 26th Nov.

Christophe

>
> cheers
>
>> diff --git a/arch/powerpc/include/asm/reg_8xx.h  
>> b/arch/powerpc/include/asm/reg_8xx.h
>> index abc663c0f1db..98e97c22df8b 100644
>> --- a/arch/powerpc/include/asm/reg_8xx.h
>> +++ b/arch/powerpc/include/asm/reg_8xx.h
>> @@ -37,7 +37,21 @@
>>  #define SPRN_CMPE	152
>>  #define SPRN_CMPF	153
>>  #define SPRN_LCTRL1	156
>> +#define   LCTRL1_CTE_GT		0xc0000000
>> +#define   LCTRL1_CTF_LT		0x14000000
>> +#define   LCTRL1_CRWE_RW	0x00000000
>> +#define   LCTRL1_CRWE_RO	0x00040000
>> +#define   LCTRL1_CRWE_WO	0x000c0000
>> +#define   LCTRL1_CRWF_RW	0x00000000
>> +#define   LCTRL1_CRWF_RO	0x00010000
>> +#define   LCTRL1_CRWF_WO	0x00030000
>>  #define SPRN_LCTRL2	157
>> +#define   LCTRL2_LW0EN		0x80000000
>> +#define   LCTRL2_LW0LA_E	0x00000000
>> +#define   LCTRL2_LW0LA_F	0x04000000
>> +#define   LCTRL2_LW0LA_EandF	0x08000000
>> +#define   LCTRL2_LW0LADC	0x02000000
>> +#define   LCTRL2_SLW0EN		0x00000002
>>  #ifdef CONFIG_PPC_8xx
>>  #define SPRN_ICTRL	158
>>  #endif
>> diff --git a/arch/powerpc/kernel/hw_breakpoint.c  
>> b/arch/powerpc/kernel/hw_breakpoint.c
>> index 28ad3171bb82..d8bd4dbef561 100644
>> --- a/arch/powerpc/kernel/hw_breakpoint.c
>> +++ b/arch/powerpc/kernel/hw_breakpoint.c
>> @@ -163,6 +163,9 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>>  	 */
>>  	if (!ppc_breakpoint_available())
>>  		return -ENODEV;
>> +	/* 8xx can setup a range without limitation */
>> +	if (IS_ENABLED(CONFIG_PPC_8xx))
>> +		return 0;
>>  	length_max = 8; /* DABR */
>>  	if (dawr_enabled()) {
>>  		length_max = 512 ; /* 64 doublewords */
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index 8fc4de0d22b4..79e4f072a746 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -751,28 +751,6 @@ static inline int __set_dabr(unsigned long  
>> dabr, unsigned long dabrx)
>>  		mtspr(SPRN_DABRX, dabrx);
>>  	return 0;
>>  }
>> -#elif defined(CONFIG_PPC_8xx)
>> -static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
>> -{
>> -	unsigned long addr = dabr & ~HW_BRK_TYPE_DABR;
>> -	unsigned long lctrl1 = 0x90000000; /* compare type: equal on E & F */
>> -	unsigned long lctrl2 = 0x8e000002; /* watchpoint 1 on cmp E | F */
>> -
>> -	if ((dabr & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_READ)
>> -		lctrl1 |= 0xa0000;
>> -	else if ((dabr & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_WRITE)
>> -		lctrl1 |= 0xf0000;
>> -	else if ((dabr & HW_BRK_TYPE_RDWR) == 0)
>> -		lctrl2 = 0;
>> -
>> -	mtspr(SPRN_LCTRL2, 0);
>> -	mtspr(SPRN_CMPE, addr);
>> -	mtspr(SPRN_CMPF, addr + 4);
>> -	mtspr(SPRN_LCTRL1, lctrl1);
>> -	mtspr(SPRN_LCTRL2, lctrl2);
>> -
>> -	return 0;
>> -}
>>  #else
>>  static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
>>  {
>> @@ -793,6 +771,37 @@ static inline int set_dabr(struct  
>> arch_hw_breakpoint *brk)
>>  	return __set_dabr(dabr, dabrx);
>>  }
>>
>> +static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
>> +{
>> +	unsigned long lctrl1 = LCTRL1_CTE_GT | LCTRL1_CTF_LT | LCTRL1_CRWE_RW |
>> +			       LCTRL1_CRWF_RW;
>> +	unsigned long lctrl2 = LCTRL2_LW0EN | LCTRL2_LW0LADC | LCTRL2_SLW0EN;
>> +
>> +	if (brk->address == 0)
>> +		lctrl2 |= LCTRL2_LW0LA_F;
>> +	else if (brk->address + brk->len == 0)
>> +		lctrl2 |= LCTRL2_LW0LA_E;
>> +	else
>> +		lctrl2 |= LCTRL2_LW0LA_EandF;
>> +
>> +	mtspr(SPRN_LCTRL2, 0);
>> +
>> +	if ((brk->type & HW_BRK_TYPE_RDWR) == 0)
>> +		return 0;
>> +
>> +	if ((brk->type & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_READ)
>> +		lctrl1 |= LCTRL1_CRWE_RO | LCTRL1_CRWF_RO;
>> +	if ((brk->type & HW_BRK_TYPE_RDWR) == HW_BRK_TYPE_WRITE)
>> +		lctrl1 |= LCTRL1_CRWE_WO | LCTRL1_CRWF_WO;
>> +
>> +	mtspr(SPRN_CMPE, brk->address - 1);
>> +	mtspr(SPRN_CMPF, brk->address + brk->len);
>> +	mtspr(SPRN_LCTRL1, lctrl1);
>> +	mtspr(SPRN_LCTRL2, lctrl2);
>> +
>> +	return 0;
>> +}
>> +
>>  void __set_breakpoint(struct arch_hw_breakpoint *brk)
>>  {
>>  	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
>> @@ -800,6 +809,8 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
>>  	if (dawr_enabled())
>>  		// Power8 or later
>>  		set_dawr(brk);
>> +	else if (IS_ENABLED(CONFIG_PPC_8xx))
>> +		set_breakpoint_8xx(brk);
>>  	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
>>  		// Power7 or earlier
>>  		set_dabr(brk);
>> --
>> 2.13.3


