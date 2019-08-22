Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2701C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B5122CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BkpRitEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfHVFGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 01:06:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6731 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbfHVFGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:06:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46DXYR1J3Hz9tygb;
        Thu, 22 Aug 2019 07:06:03 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BkpRitEX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id S6X_i_dSBXy6; Thu, 22 Aug 2019 07:06:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46DXYR05QWz9tygX;
        Thu, 22 Aug 2019 07:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566450363; bh=uczfUv3hnybC8UExT8P+EcZ1T/EfN1469uNM/tj0H6A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BkpRitEX2o9PA/vIhLtEKfnzZrsui3ZJjjWvIrcsMx8koUrySSY8ivASlF+09RAmP
         gpQNLFiBZl0emVtdPbxh36E+GPgwgdtx8Z58713B2SOY/bBxOro9H3JL+W0PBXwq51
         u3FbR9+kV/GAGVJV2G9iLn2uQj+gOjf0GagmOvC8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C728F8B791;
        Thu, 22 Aug 2019 07:06:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id erEJnxsK7q5p; Thu, 22 Aug 2019 07:06:03 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69A0D8B752;
        Thu, 22 Aug 2019 07:06:03 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc: Convert ____flush_dcache_icache_phys() to C
To:     Alastair D'Silva <alastair@au1.ibm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <de7a813c71c4823797bb351bea8be15acae83be2.1565970465.git.christophe.leroy@c-s.fr>
 <9887dada07278cb39051941d1a47d50349d9fde0.camel@au1.ibm.com>
 <a0ad8dd8-2f5d-256d-9e88-e9c236335bb8@c-s.fr>
 <fcc94e7f347c3759a1698444239a7250b22cde7d.camel@au1.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c22dfd19-872a-afe1-40c6-82e11b0af9e1@c-s.fr>
Date:   Thu, 22 Aug 2019 07:06:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fcc94e7f347c3759a1698444239a7250b22cde7d.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/08/2019 à 02:27, Alastair D'Silva a écrit :
> On Wed, 2019-08-21 at 22:27 +0200, Christophe Leroy wrote:
>>
>> Le 20/08/2019 à 06:36, Alastair D'Silva a écrit :
>>> On Fri, 2019-08-16 at 15:52 +0000, Christophe Leroy wrote:
>>
>> [...]
>>
>>>
>>> Thanks Christophe,
>>>
>>> I'm trying a somewhat different approach that requires less
>>> knowledge
>>> of assembler. Handling of CPU_FTR_COHERENT_ICACHE is outside this
>>> function. The code below is not a patch as my tree is a bit messy,
>>> sorry:
>>
>> Can we be 100% sure that GCC won't add any code accessing some
>> global
>> data or stack while the Data MMU is OFF ?
>>
>> Christophe
>>
> 
> +mpe
> 
> I'm not sure how we would go about making such a guarantee, but I've
> tied every variable used to a register and addr is passed in a
> register, so there is no stack usage, and every call in there only
> operates on it's operands.
> 
> The calls to the inline cache helpers (for the PPC32 case) are all
> constants, so I can't see a reasonable scenario where there would be a
> function call and reordered to after the DR bit is turned off, but I
> guess if we want to be paranoid, we could always add an mb() call
> before the DR bit is manipulated to prevent the compiler from
> reordering across the section where the data MMU is disabled.
> 
> 

Anyway, I think the benefit of converting that function to C is pretty 
small. flush_dcache_range() and friends were converted to C mainly in 
order to inline them. But this __flush_dcache_icache_phys() is too big 
to be worth inlining, yet small and stable enough to remain in assembly 
for the time being.

So I suggest you keep it aside your series for now, just move 
PURGE_PREFETCHED_INS inside it directly as it will be the only remaining 
user of it.

Christophe
