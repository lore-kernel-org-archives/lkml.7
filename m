Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC77BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968942080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfGORDT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:03:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18951 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbfGORDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:03:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45nVGW70Kkz9v6sM;
        Mon, 15 Jul 2019 19:03:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6-l72iaIQAXe; Mon, 15 Jul 2019 19:03:15 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45nVGW5x2hz9v6sL;
        Mon, 15 Jul 2019 19:03:15 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 986702436; Mon, 15 Jul 2019 19:03:22 +0200 (CEST)
Received: from 37.165.107.183 ([37.165.107.183]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Mon, 15 Jul 2019 19:03:22 +0200
Date:   Mon, 15 Jul 2019 19:03:22 +0200
Message-ID: <20190715190322.Horde.n1joFeQA_2PKT82_Wohz2Q1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/32: activate ARCH_HAS_PMEM_API and
 ARCH_HAS_UACCESS_FLUSHCACHE
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
 <0e779b35cf66fd4aa5ec0ec09fb7820f6c518cb3.1557824379.git.christophe.leroy@c-s.fr>
 <87y30z94hp.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y30z94hp.fsf@concordia.ellerman.id.au>
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
>> PPC32 also have flush_dcache_range() so it can also support
>> ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE without changes.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index d7996cfaceca..cf6e30f637be 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -127,13 +127,13 @@ config PPC
>>  	select ARCH_HAS_KCOV
>>  	select ARCH_HAS_MMIOWB			if PPC64
>>  	select ARCH_HAS_PHYS_TO_DMA
>> -	select ARCH_HAS_PMEM_API                if PPC64
>> +	select ARCH_HAS_PMEM_API
>>  	select ARCH_HAS_PTE_SPECIAL
>>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
>>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64
>>  	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) &&  
>> !RELOCATABLE && !HIBERNATION)
>>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
>> -	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
>> +	select ARCH_HAS_UACCESS_FLUSHCACHE
>>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>>  	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
>>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>
> This didn't build for me, probably due to something that's changed in
> the long period between you posting it and me applying it?
>
> corenet32_smp_defconfig:
>
>   powerpc64-unknown-linux-gnu-ld: lib/iov_iter.o: in function  
> `_copy_from_iter_flushcache':
>   powerpc64-unknown-linux-gnu-ld:  
> /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined  
> reference to `memcpy_page_flushcache'
>   powerpc64-unknown-linux-gnu-ld:  
> /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined  
> reference to `memcpy_flushcache'
>   powerpc64-unknown-linux-gnu-ld:  
> /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined  
> reference to `__copy_from_user_flushcache'
>   powerpc64-unknown-linux-gnu-ld:  
> /scratch/michael/build/maint/build~/../lib/iov_iter.c:825: undefined  
> reference to `memcpy_flushcache'
>


Looks like arch/powerpc/lib/Makefile only builds pmem.o for ppc64

Moving it from obj64-y to obj-y should do it.

I'll update the patch when I'm back in two weeks unless you can fix it before.

Christophe


