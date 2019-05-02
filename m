Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA2CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17752081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EXLy1HDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEBLnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 07:43:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5179 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:43:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44vtg83SdBzB09ZH;
        Thu,  2 May 2019 13:43:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EXLy1HDZ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KxwpglQ6XV5S; Thu,  2 May 2019 13:43:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44vtg82KKYzB09ZF;
        Thu,  2 May 2019 13:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556797380; bh=cMkTXTCMVvl2JDSWZdRJlzPRMgw1uvnG3jkjZKVvvsk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EXLy1HDZv52mN/1dlOI3ETPX2N0L3qyIz1HsaOh/OyZ9yN0bXdxRFyNe84tECqkd+
         sd/uksma7l8uPfYyZkNThvD/GsjFZI3suXI2876n57CgQ39O7jlfvQzCErWRKc3ga/
         LPuKAgdU93mOX+1JFnoJjjxOVCX8/FPFZqpp0BFM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F5A18B8F7;
        Thu,  2 May 2019 13:43:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Hd4E6wWeUzz0; Thu,  2 May 2019 13:43:01 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49A5B8B899;
        Thu,  2 May 2019 13:43:01 +0200 (CEST)
Subject: Re: [PATCH v1 3/4] powerpc/mm: Move book3s32 specifics in
 subdirectory mm/book3s64
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1553853405.git.christophe.leroy@c-s.fr>
 <12c1ba4fc9e2e55ca44c5c57225669b296d48c74.1553853405.git.christophe.leroy@c-s.fr>
 <87tvedxfa6.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9577f0d2-2447-5407-0b69-339a89cf40e1@c-s.fr>
Date:   Thu, 2 May 2019 13:43:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tvedxfa6.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/05/2019 à 13:32, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Several files in arch/powerpc/mm are only for book3S32. This patch
>> creates a subdirectory for them.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/Makefile                            | 3 +--
>>   arch/powerpc/mm/book3s32/Makefile                   | 6 ++++++
>>   arch/powerpc/mm/{ => book3s32}/hash_low_32.S        | 0
>>   arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c | 0
>>   arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c         | 0
>>   arch/powerpc/mm/{ => book3s32}/tlb_hash32.c         | 0
>>   6 files changed, 7 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/powerpc/mm/book3s32/Makefile
>>   rename arch/powerpc/mm/{ => book3s32}/hash_low_32.S (100%)
>>   rename arch/powerpc/mm/{ => book3s32}/mmu_context_hash32.c (100%)
>>   rename arch/powerpc/mm/{ => book3s32}/ppc_mmu_32.c (100%)
>>   rename arch/powerpc/mm/{ => book3s32}/tlb_hash32.c (100%)
> 
> I shortened them to:
> 
>    arch/powerpc/mm/{hash_low_32.S => book3s32/hash_low.S}
>    arch/powerpc/mm/{ppc_mmu_32.c => book3s32/mmu.c}

To be consistent with what you did in nohash/ dir, shouldn't we rename 
the above 'ppc.c' or 'ppc_32.c' instead of 'mmu.c' ?

Christophe

>    arch/powerpc/mm/{mmu_context_hash32.c => book3s32/mmu_context.c}
>    arch/powerpc/mm/{tlb_hash32.c => book3s32/tlb.c}
> 
> cheers
> 
