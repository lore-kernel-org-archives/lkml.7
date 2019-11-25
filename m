Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B6AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 05:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933152071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 05:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfKYFBT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 00:01:19 -0500
Received: from ozlabs.org ([203.11.71.1]:50261 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfKYFBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 00:01:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Lvy31TZzz9sP3;
        Mon, 25 Nov 2019 16:01:15 +1100 (AEDT)
Date:   Mon, 25 Nov 2019 16:01:13 +1100
User-Agent: K-9 Mail for Android
In-Reply-To: <87v9r8g3oe.fsf@dja-thinkpad.axtens.net>
References: <1567199630.5576.39.camel@lca.pw> <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org> <87ef0vpfbc.fsf@mpe.ellerman.id.au> <87v9r8g3oe.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: lockdep warning while booting POWER9 PowerNV
To:     Daniel Axtens <dja@axtens.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@lca.pw>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <michael@ellerman.id.au>
Message-ID: <EA225D34-2394-4C77-B989-38C275818590@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 November 2019 12:12:01 pm AEDT, Daniel Axtens <dja@axtens.net> wrote:
>Hi Michael,
>
>>>> Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH)
>would generate
>>>> a warning in lockdep_register_key() at,
>>>> 
>>>> if (WARN_ON_ONCE(static_obj(key)))
>>>> 
>>>> because
>>>> 
>>>> key = 0xc0000000019ad118
>>>> &_stext = 0xc000000000000000
>>>> &_end = 0xc0000000049d0000
>>>> 
>>>> i.e., it will cause static_obj() returns 1.
>>>
>>> (back from a trip)
>>>
>>> Hi Qian,
>>>
>>> Does this mean that on POWER9 it can happen that a dynamically
>allocated 
>>> object has an address that falls between &_stext and &_end?
>>
>> I thought that was true on all arches due to initmem, but seems not.
>>
>> I guess we have the same problem as s390 and we need to define
>> arch_is_kernel_initmem_freed().
>>
>> Qian, can you try this:
>>
>> diff --git a/arch/powerpc/include/asm/sections.h
>b/arch/powerpc/include/asm/sections.h
>> index 4a1664a8658d..616b1b7b7e52 100644
>> --- a/arch/powerpc/include/asm/sections.h
>> +++ b/arch/powerpc/include/asm/sections.h
>> @@ -5,8 +5,22 @@
>>  
>>  #include <linux/elf.h>
>>  #include <linux/uaccess.h>
>> +
>> +#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
>> +
>>  #include <asm-generic/sections.h>
>>  
>> +extern bool init_mem_is_free;
>> +
>> +static inline int arch_is_kernel_initmem_freed(unsigned long addr)
>> +{
>> +	if (!init_mem_is_free)
>> +		return 0;
>> +
>> +	return addr >= (unsigned long)__init_begin &&
>> +		addr < (unsigned long)__init_end;
>> +}
>> +
>>  extern char __head_end[];
>>  
>>  #ifdef __powerpc64__
>>
>
>This also fixes the following syzkaller bug:
>https://syzkaller-ppc64.appspot.com/bug?id=cfdf75cd985012d0124cd41e6fa095d33e7d0f6b
>https://github.com/linuxppc/issues/issues/284
>
>Would you like me to do up a nice commit message for it?

That'd be great, thanks.

cheers
