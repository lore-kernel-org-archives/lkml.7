Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B1421900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RVZd5uYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfDXOJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:09:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63339 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfDXOJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:09:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44q2JK5T9Xz9v1Lt;
        Wed, 24 Apr 2019 16:09:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RVZd5uYe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9yeek82dQeMp; Wed, 24 Apr 2019 16:09:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44q2JK4J1gz9v1Ls;
        Wed, 24 Apr 2019 16:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556114993; bh=ZkxYiuuTQWNhHiGcWoMonTQOzxq5tb0F+/oyGFfaqlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RVZd5uYe+Vl+jg9lEZa4y6Dsm4vinqkZuJxdY21Cu/EbQFiAn/uLsrSkHGiwrIFPF
         iJqlcaIEEAeDagf/li/14uiFbZpiuJJaVxV51noz5jkqIRSCvdbUy+2AumC1mSsrAK
         L4pvqWNmRpPKllcsBe9QCuqodAOzTIpBhun9quR0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C28E8B913;
        Wed, 24 Apr 2019 16:09:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id diAqZ10rf9Ks; Wed, 24 Apr 2019 16:09:55 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2D4C8B8FB;
        Wed, 24 Apr 2019 16:09:54 +0200 (CEST)
Subject: Re: [PATCH v1 03/27] powerpc/mm: don't BUG() in slice_mask_for_size()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
 <f67363798e1ffb7603cd6619cb867563e4126d9a.1553076180.git.christophe.leroy@c-s.fr>
 <87lg0h3xpo.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <609ef207-614c-1abf-6ebc-770735ca94c7@c-s.fr>
Date:   Wed, 24 Apr 2019 16:09:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lg0h3xpo.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/04/2019 à 07:41, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> When no mask is found for the page size, WARN() and return NULL
>> instead of BUG()ing.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/slice.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index aec91dbcdc0b..011d470ea340 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -165,7 +165,8 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
>>   	if (psize == MMU_PAGE_16G)
>>   		return &mm->context.mask_16g;
>>   #endif
>> -	BUG();
>> +	WARN_ON(true);
>> +	return NULL;
>>   }
> 
> 
> Same here. There are not catching runtime errors. We should never find
> that true. This is to catch mistakes during development changes. Switch
> to VM_BUG_ON?

Ok, I'll switch to VM_BUG_ON()

Christophe

> 
> 
>>   #elif defined(CONFIG_PPC_8xx)
>>   static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
>> @@ -178,7 +179,8 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
>>   	if (psize == MMU_PAGE_8M)
>>   		return &mm->context.mask_8m;
>>   #endif
>> -	BUG();
>> +	WARN_ON(true);
>> +	return NULL;
>>   }
>>   #else
>>   #error "Must define the slice masks for page sizes supported by the platform"
>> -- 
>> 2.13.3
