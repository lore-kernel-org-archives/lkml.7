Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31910218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfCUKHk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:07:40 -0400
Received: from ozlabs.org ([203.11.71.1]:46007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfCUKHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:07:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Q2XS58nRz9sQv;
        Thu, 21 Mar 2019 21:07:36 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/highmem: change BUG_ON() to WARN_ON()
In-Reply-To: <9048ba12-a014-3ebe-c414-26f87401c758@c-s.fr>
References: <0365f99ce2b9273e269a241394957cba924f995e.1551951985.git.christophe.leroy@c-s.fr> <87va0c23s8.fsf@concordia.ellerman.id.au> <9048ba12-a014-3ebe-c414-26f87401c758@c-s.fr>
Date:   Thu, 21 Mar 2019 21:07:35 +1100
Message-ID: <87sgvg1qxk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 21/03/2019 à 06:29, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> In arch/powerpc/mm/highmem.c, BUG_ON() is called only when
>>> CONFIG_DEBUG_HIGHMEM is selected, this means the BUG_ON() is
>>> not vital and can be replaced by a a WARN_ON
>>>
>>> At the sametime, use IS_ENABLED() instead of #ifdef to clean a bit.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/mm/highmem.c | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
>>> index 82a0e37557a5..b68c9f20fbdf 100644
>>> --- a/arch/powerpc/mm/highmem.c
>>> +++ b/arch/powerpc/mm/highmem.c
>>> @@ -56,7 +54,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
>>>   void __kunmap_atomic(void *kvaddr)
>>>   {
>>>   	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
>>> -	int type __maybe_unused;
>>> +	int type;
>> 
>> Why don't we move type into the block below.
>
> Yes you're right, when Mathieu introduced the __maybe_unused, I was 
> wrongly thinging that kmap_atomic_idx() was doing something important 
> that had to be done also when DEBUG was not selected, but indeed it does 
> nothing else than returning the type.
>
> I'll send a new patch.

I can just fix it up when applying.

cheers
