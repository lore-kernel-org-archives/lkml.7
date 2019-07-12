Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F3C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB15A2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGLHAM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:00:12 -0400
Received: from ozlabs.org ([203.11.71.1]:36685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfGLHAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:00:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lP2107h2z9s00;
        Fri, 12 Jul 2019 17:00:09 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ulirch Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [PATCH v3 3/3] powerpc/module64: Use symbolic instructions names.
In-Reply-To: <9bc00fb4-379a-e19b-4d27-32fff8f9781b@c-s.fr>
References: <298f344bdb21ab566271f5d18c6782ed20f072b7.1556865423.git.christophe.leroy@c-s.fr> <6fb61d1c9104b0324d4a9c445f431c0928c7ea25.1556865423.git.christophe.leroy@c-s.fr> <87bly5ibsd.fsf@concordia.ellerman.id.au> <9bc00fb4-379a-e19b-4d27-32fff8f9781b@c-s.fr>
Date:   Fri, 12 Jul 2019 17:00:08 +1000
Message-ID: <87wogneo07.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 08/07/2019 à 02:56, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> To increase readability/maintainability, replace hard coded
>>> instructions values by symbolic names.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>> v3: fixed warning by adding () in an 'if' around X | Y (unlike said in v2 history, this change was forgotten in v2)
>>> v2: rearranged comments
>>>
>>>   arch/powerpc/kernel/module_64.c | 53 +++++++++++++++++++++++++++--------------
>>>   1 file changed, 35 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>>> index c2e1b06253b8..b33a5d5e2d35 100644
>>> --- a/arch/powerpc/kernel/module_64.c
>>> +++ b/arch/powerpc/kernel/module_64.c
>>> @@ -704,18 +711,21 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>> ...
>>>   			/*
>>>   			 * If found, replace it with:
>>>   			 *	addis r2, r12, (.TOC.-func)@ha
>>>   			 *	addi r2, r12, (.TOC.-func)@l
>>>   			 */
>>> -			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
>>> -			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
>>> +			((uint32_t *)location)[0] = PPC_INST_ADDIS | __PPC_RT(R2) |
>>> +						    __PPC_RA(R12) | PPC_HA(value);
>>> +			((uint32_t *)location)[1] = PPC_INST_ADDI | __PPC_RT(R2) |
>>> +						    __PPC_RA(R12) | PPC_LO(value);
>>>   			break;
>> 
>> This was crashing and it's amazing how long you can stare at a
>> disassembly and not see the difference between `r2` and `r12` :)
>
> Argh, yes. I was misleaded by the comment I guess. Sorry for that and 
> thanks for fixing.

No worries, yes the comment was the problem. I fixed that as well.

cheers
