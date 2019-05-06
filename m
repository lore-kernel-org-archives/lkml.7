Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D0EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB403206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEFLaC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:30:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47301 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEFLaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:30:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yLBG6Z5qz9s9T;
        Mon,  6 May 2019 21:29:58 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] powerpc/mm: convert Book3E 64 to pte_fragment
In-Reply-To: <0076ad26-9d0e-e408-3521-b8e17669bb04@c-s.fr>
References: <cover.1556293738.git.christophe.leroy@c-s.fr> <c440b242da6de3823c4ef51f35f38405bbd51430.1556293738.git.christophe.leroy@c-s.fr> <0076ad26-9d0e-e408-3521-b8e17669bb04@c-s.fr>
Date:   Mon, 06 May 2019 21:29:55 +1000
Message-ID: <8736lryg5o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 26/04/2019 à 17:58, Christophe Leroy a écrit :
>> Book3E 64 is the only subarch not using pte_fragment. In order
>> to allow refactorisation, this patch converts it to pte_fragment.
>> 
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu_context.h       |  6 -----
>>   arch/powerpc/include/asm/nohash/64/mmu.h     |  4 +++-
>>   arch/powerpc/include/asm/nohash/64/pgalloc.h | 33 ++++++++++------------------
>>   arch/powerpc/mm/Makefile                     |  4 ++--
>>   arch/powerpc/mm/mmu_context.c                |  2 +-
>>   5 files changed, 18 insertions(+), 31 deletions(-)
>> 
> [...]
>
>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>> index 3c1bd9fa23cd..138c772d58d1 100644
>> --- a/arch/powerpc/mm/Makefile
>> +++ b/arch/powerpc/mm/Makefile
>> @@ -9,6 +9,7 @@ CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>>   
>>   obj-y				:= fault.o mem.o pgtable.o mmap.o \
>>   				   init_$(BITS).o pgtable_$(BITS).o \
>> +				   pgtable-frag.o \
>>   				   init-common.o mmu_context.o drmem.o
>>   obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
>>   				   tlb_nohash_low.o
>> @@ -17,8 +18,7 @@ hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
>>   obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
>>   obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
>>   				   $(hash64-y) mmu_context_book3s64.o \
>> -				   pgtable-book3s64.o pgtable-frag.o
>> -obj-$(CONFIG_PPC32)		+= pgtable-frag.o
>> +				   pgtable-book3s64.o
>
> Looks like the removal of pgtable-frag.o for CONFIG_PPC_BOOK3S_64 didn't 
> survive the merge.

Hmm, I don't remember having problems there but clearly something went
wrong.

> Will send a patch to fix that.

Thanks.

cheers
