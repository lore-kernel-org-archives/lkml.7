Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC38C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90B4218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ik55Wz8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfCUGAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:00:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34571 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfCUGAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:00:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Px2s3S2VzB09ZN;
        Thu, 21 Mar 2019 07:00:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Ik55Wz8u; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wswbAT7RI93K; Thu, 21 Mar 2019 07:00:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Px2s2JGMzB09ZM;
        Thu, 21 Mar 2019 07:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553148005; bh=Iw6NoawQM0GrtLmPpbr42oycLqMZGHJByjvdQTVvx8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ik55Wz8uVogNzpAewAr4LAyO7zslcDWA8fZoqloH+6Ajl0q30XMPWaervWp6PK/uk
         Yssm34mYuAayxU3iTtRSdhpMrov7CQZMCxvswDyfI1ZYkuSmmWUnsHAuLTZPeoYolx
         HXlVJ+tRkOEYTjds6uqLV2gqs9ROmlL2DdZw25Fk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B5708B7CC;
        Thu, 21 Mar 2019 07:00:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xRVnTIWARwtR; Thu, 21 Mar 2019 07:00:06 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 771D68B74C;
        Thu, 21 Mar 2019 07:00:05 +0100 (CET)
Subject: Re: [PATCH] powerpc/highmem: change BUG_ON() to WARN_ON()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <0365f99ce2b9273e269a241394957cba924f995e.1551951985.git.christophe.leroy@c-s.fr>
 <87va0c23s8.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9048ba12-a014-3ebe-c414-26f87401c758@c-s.fr>
Date:   Thu, 21 Mar 2019 07:00:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87va0c23s8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/03/2019 à 06:29, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> In arch/powerpc/mm/highmem.c, BUG_ON() is called only when
>> CONFIG_DEBUG_HIGHMEM is selected, this means the BUG_ON() is
>> not vital and can be replaced by a a WARN_ON
>>
>> At the sametime, use IS_ENABLED() instead of #ifdef to clean a bit.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/highmem.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
>> index 82a0e37557a5..b68c9f20fbdf 100644
>> --- a/arch/powerpc/mm/highmem.c
>> +++ b/arch/powerpc/mm/highmem.c
>> @@ -56,7 +54,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
>>   void __kunmap_atomic(void *kvaddr)
>>   {
>>   	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
>> -	int type __maybe_unused;
>> +	int type;
> 
> Why don't we move type into the block below.

Yes you're right, when Mathieu introduced the __maybe_unused, I was 
wrongly thinging that kmap_atomic_idx() was doing something important 
that had to be done also when DEBUG was not selected, but indeed it does 
nothing else than returning the type.

I'll send a new patch.

Christophe

> 
> eg:
> 
>> @@ -66,12 +64,11 @@ void __kunmap_atomic(void *kvaddr)
>>   
> -  	type = kmap_atomic_idx();
>>   
>> -#ifdef CONFIG_DEBUG_HIGHMEM
>> -	{
>> +	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) {
>    		int type = kmap_atomic_idx();
>>   		unsigned int idx;
>>   
>>   		idx = type + KM_TYPE_NR * smp_processor_id();
>> -		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
>> +		WARN_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
> 
> 
> cheers
> 
