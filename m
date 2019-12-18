Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDBDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD93424672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NfyaHaGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLRNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:13:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37659 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfLRNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:13:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dFnp3pW4z9sS9;
        Thu, 19 Dec 2019 00:13:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576674832;
        bh=jvXS9QaYUnBeyhFeR7eMtCXv8w7JTHZthgsAYwtfgoU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NfyaHaGP9zOdUM8yUYmFTOJTQD8ZA4DPbTcZZfO1UsuG6p8s+uA+Qusa3Hw+AT2Y9
         7nSZ7Q3zUruXevd2KInEdVnRTL6p7RPT1HDKV0lROjcLdmPUgDeSzQ9K5e9kutklPz
         NWkb15XZfl65oFmLC/jUpXMUna1cULqg/HdAY66dorouQmPnFogtr6HMCCDWcIAzEi
         RQW2yMfBhh5rMUasuFU+asmqljUaNKu16YQO4P0MOXhXNOrXQE7u/m3U4uOtN52dkD
         7f5qwiIESOiBBCieQ1eRi7gvF+y3fGob3KPFjn4L7eltOM7GCIGiWhkVxexhYclLfq
         8u2PXuWC8/Glw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, will@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch allocation failure and flush
In-Reply-To: <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com> <20191218053530.73053-2-aneesh.kumar@linux.ibm.com> <20191218091733.GO2844@hirez.programming.kicks-ass.net> <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
Date:   Thu, 19 Dec 2019 00:13:48 +1100
Message-ID: <87v9qdn5df.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> On 12/18/19 2:47 PM, Peter Zijlstra wrote:
>> On Wed, Dec 18, 2019 at 11:05:29AM +0530, Aneesh Kumar K.V wrote:
>>> From: Peter Zijlstra <peterz@infradead.org>
>>>
>>> Architectures for which we have hardware walkers of Linux page table should
>>> flush TLB on mmu gather batch allocation failures and batch flush. Some
>>> architectures like POWER supports multiple translation modes (hash and radix)
>> 
>> nohash, hash and radix in fact :-)
>> 
>>> and in the case of POWER only radix translation mode needs the above TLBI.
>> 
>>> This is because for hash translation mode kernel wants to avoid this extra
>>> flush since there are no hardware walkers of linux page table. With radix
>>> translation, the hardware also walks linux page table and with that, kernel
>>> needs to make sure to TLB invalidate page walk cache before page table pages are
>>> freed.
>>>
>>> More details in
>>> commit: d86564a2f085 ("mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE")
>>>
>>> Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>> 
>>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
>>> index b2c0be93929d..7f3a8b902325 100644
>>> --- a/arch/powerpc/include/asm/tlb.h
>>> +++ b/arch/powerpc/include/asm/tlb.h
>>> @@ -26,6 +26,17 @@
>>>   
>>>   #define tlb_flush tlb_flush
>>>   extern void tlb_flush(struct mmu_gather *tlb);
>>> +/*
>>> + * book3s:
>>> + * Hash does not use the linux page-tables, so we can avoid
>>> + * the TLB invalidate for page-table freeing, Radix otoh does use the
>>> + * page-tables and needs the TLBI.
>>> + *
>>> + * nohash:
>>> + * We still do TLB invalidate in the __pte_free_tlb routine before we
>>> + * add the page table pages to mmu gather table batch.
>> 
>> I'm a little confused though; if nohash is a software TLB fill, why do
>> you need a TLBI for tables?
>> 
>
> nohash (AKA book3e) has different mmu modes. I don't follow all the 
> details w.r.t book3e. Paul or Michael might be able to explain the need 
> for table flush with book3e.

Some of the Book3E CPUs have a partial hardware table walker. The IBM one (A2)
did, before we ripped that support out. And the Freescale (NXP) e6500
does, see eg:

  28efc35fe68d ("powerpc/e6500: TLB miss handler with hardware tablewalk support")

They only support walking one level IIRC, ie. you can create a TLB entry
that points to a PTE page, and the hardware will dereference that to get
a PTE and load that into the TLB.

cheers
