Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D91C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8532B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AslU0E22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfDXOJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:09:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22856 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfDXOJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:09:37 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44q2Hy3QfJz9v1Lv;
        Wed, 24 Apr 2019 16:09:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AslU0E22; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id geB8DTC6TZOy; Wed, 24 Apr 2019 16:09:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44q2Hy1mrTz9v1Ls;
        Wed, 24 Apr 2019 16:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556114974; bh=zwwAZWJV1BE8AwI49JQnbFk7+vD7247Kx8wwTVrhxzw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AslU0E22efgpUvJCJ+mk30KTUlre3aJ81f+Zuj9EcbFgpK0at+iwSSE2GR0SnDtMO
         951JakSrNa7ejQN10hVbLaw6E8plxjM7FmVKTCEPZjfBFMlEjA6oyuQ8xciSJ6o/Cb
         PcP2GaFc5drqQGzynohSSymu9qtZ3TYwi1l+17v0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8E428B913;
        Wed, 24 Apr 2019 16:09:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 59CSbUfY2pt7; Wed, 24 Apr 2019 16:09:35 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 961908B8FB;
        Wed, 24 Apr 2019 16:09:35 +0200 (CEST)
Subject: Re: [PATCH v1 01/27] powerpc/mm: Don't BUG() in hugepd_page()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
 <9d6b0fe78346ff8e81a969a75a616bab59bc5cf5.1553076180.git.christophe.leroy@c-s.fr>
 <87r2a93xto.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bdeba4a0-451e-ab57-d844-197d7c8ae761@c-s.fr>
Date:   Wed, 24 Apr 2019 16:09:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87r2a93xto.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/04/2019 à 07:39, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Don't BUG(), just warn and return NULL.
>> If the NULL value is not handled, it will get catched anyway.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/hugetlb.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
>> index 8d40565ad0c3..48c29686c78e 100644
>> --- a/arch/powerpc/include/asm/hugetlb.h
>> +++ b/arch/powerpc/include/asm/hugetlb.h
>> @@ -14,7 +14,8 @@
>>    */
>>   static inline pte_t *hugepd_page(hugepd_t hpd)
>>   {
>> -	BUG_ON(!hugepd_ok(hpd));
>> +	if (WARN_ON(!hugepd_ok(hpd)))
>> +		return NULL;
> 
> We should not find that true. That BUG_ON was there to catch errors
> when changing pte formats. May be switch that VM_BUG_ON()?

Ok, I'll switch to VM_BUG_ON()

Christophe

> 
>>   	/*
>>   	 * We have only four bits to encode, MMU page size
>>   	 */
>> @@ -42,7 +43,8 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>>   
>>   static inline pte_t *hugepd_page(hugepd_t hpd)
>>   {
>> -	BUG_ON(!hugepd_ok(hpd));
>> +	if (WARN_ON(!hugepd_ok(hpd)))
>> +		return NULL;
>>   #ifdef CONFIG_PPC_8xx
>>   	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
>>   #else
>> -- 
>> 2.13.3
