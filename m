Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E14C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D64E216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LpkytxuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfFPIVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 04:21:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37407 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfFPIVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 04:21:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45RS3N3ySYz9v19p;
        Sun, 16 Jun 2019 10:21:04 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LpkytxuO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oOyNzZ6g3_Ow; Sun, 16 Jun 2019 10:21:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45RS3N2lq6z9v19n;
        Sun, 16 Jun 2019 10:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560673264; bh=MJqSgQzXgPmNRPH0n1stQKb77v16xTqSmd2hmNpUr2w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LpkytxuOtptABTtek2rOH7LeGpz8Or6fj84OACjTSEJDJQIvNnHE5/j8krvqEwpxE
         vO+F+wOkd3yWlb1uvraSVvekL98iyLv/W8MwKn/7jafLNGynKgTIkt4T7+UpY7mlqY
         QJkYO7mPH8RA9QDnRZYWr/QtKRwyr5gNtEOJhE+I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37F1C8B7D1;
        Sun, 16 Jun 2019 10:21:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KGIqsT9_FfFn; Sun, 16 Jun 2019 10:21:07 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 949188B7CD;
        Sun, 16 Jun 2019 10:21:06 +0200 (CEST)
Subject: Re: [PATCH v5 13/16] powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <877e9n9gng.fsf@igel.home>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <1c271e47-6917-2f29-97b6-f3160ddf5117@c-s.fr>
Date:   Sun, 16 Jun 2019 10:01:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <877e9n9gng.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190616-0, 16/06/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/06/2019 à 14:28, Andreas Schwab a écrit :
> On Feb 21 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index a000768a5cc9..6e56a6240bfa 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -353,7 +353,10 @@ void mark_initmem_nx(void)
>>   	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
>>   				 PFN_DOWN((unsigned long)_sinittext);
>>   
>> -	change_page_attr(page, numpages, PAGE_KERNEL);
>> +	if (v_block_mapped((unsigned long)_stext) + 1)
> 
> That is always true.
> 

Did you boot with 'nobats' kernel parameter ?

If not, that's normal to be true, it means that memory is mapped with BATs.

When you boot with 'nobats' parameter, this should return false.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

