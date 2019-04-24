Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40A821902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="quuhednZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfDXOJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:09:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39232 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfDXOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:09:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44q2J84G2rz9v1Lt;
        Wed, 24 Apr 2019 16:09:44 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=quuhednZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zrzfazMFTSvO; Wed, 24 Apr 2019 16:09:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44q2J83CBCz9v1Ls;
        Wed, 24 Apr 2019 16:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556114984; bh=xQN7h10aWi1DnY/iufPD4r/GJNAFv5Lh+X8Fwjl3xuA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=quuhednZkE5e2Q/t59v2MskthE3G7GNH0P6PAmso0j9sD7q+ssJsw/Q4x/derMTDN
         aF4Ptjd/CbpqzWt7NgoMyzMstua543oVs8W5XUkHOSwyfPbojbmTzvsin84NlyCMeS
         gK2kF+PhW4bQF7XuRiYtnNVp5W3ixZ9Uk5eJWvlw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5D488B913;
        Wed, 24 Apr 2019 16:09:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tX0Jt38mbcCm; Wed, 24 Apr 2019 16:09:45 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C217C8B8FB;
        Wed, 24 Apr 2019 16:09:45 +0200 (CEST)
Subject: Re: [PATCH v1 02/27] powerpc/mm: don't BUG in add_huge_page_size()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
 <02e312b13129a9bf96f0cd4a30b1802be0644900.1553076180.git.christophe.leroy@c-s.fr>
 <87o95d3xqe.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2025a657-da62-ffd3-6c77-b93f677704cc@c-s.fr>
Date:   Wed, 24 Apr 2019 16:09:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87o95d3xqe.fsf@linux.ibm.com>
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
>> No reason to BUG() in add_huge_page_size(). Just WARN and
>> reject the add.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/hugetlbpage.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 9e732bb2c84a..cf2978e235f3 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -634,7 +634,8 @@ static int __init add_huge_page_size(unsigned long long size)
>>   	}
>>   #endif
>>   
>> -	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
>> +	if (WARN_ON(mmu_psize_defs[mmu_psize].shift != shift))
>> +		return -EINVAL;
> 
> Same here. There are not catching runtime errors. We should never find
> that true. This is to catch mistakes during development changes. Switch
> to VM_BUG_ON?

Ok, I'll switch to VM_BUG_ON()

Christophe

> 
> 
>>   
>>   	/* Return if huge page size has already been setup */
>>   	if (size_to_hstate(size))
>> -- 
>> 2.13.3
