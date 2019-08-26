Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E11C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C12217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Y/SwOjPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfHZNkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:40:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9243 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbfHZNkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:40:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46HCmf2BRGz9v6M8;
        Mon, 26 Aug 2019 15:40:02 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Y/SwOjPQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RGrgdY2y_xm7; Mon, 26 Aug 2019 15:40:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46HCmf17Bcz9v6M7;
        Mon, 26 Aug 2019 15:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566826802; bh=yY3k41gmYf/DTKvMuEJLOJQmABAXRkhQIZBCeG8ju+s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y/SwOjPQCG5asoLq8HEiW+NmcAW6rp7X9WBxmSHDBLAgvDkYIo2M2gj6I191Fm1oT
         wmYMKR+1N+9Gr7hTTnQPr80A67lICgWnilEeGHZTO6YKv9nOBGP8zqn/dpvoFYFcoG
         F8x0WGFlmLGe/3/5b4sGJsBtIX/R1pUkq5kwk4xk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B5D58B7E1;
        Mon, 26 Aug 2019 15:40:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Jyrpu0M7eqWM; Mon, 26 Aug 2019 15:40:07 +0200 (CEST)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 113768B7DE;
        Mon, 26 Aug 2019 15:40:07 +0200 (CEST)
Subject: Re: [PATCH] powerpc/time: use feature fixup in __USE_RTC() instead of
 cpu feature.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <55c267ac6e0cd289970accfafbf9dda11a324c2e.1566802736.git.christophe.leroy@c-s.fr>
 <87blwc40i4.fsf@concordia.ellerman.id.au>
 <60da7620a43dc29317a062f1d58dcfde8d32b258.camel@kernel.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bbfb63db-4d73-b638-79f3-9bee3b6749f9@c-s.fr>
Date:   Mon, 26 Aug 2019 15:40:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <60da7620a43dc29317a062f1d58dcfde8d32b258.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/08/2019 à 15:25, Benjamin Herrenschmidt a écrit :
> On Mon, 2019-08-26 at 21:41 +1000, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> sched_clock(), used by printk(), calls __USE_RTC() to know
>>> whether to use realtime clock or timebase.
>>>
>>> __USE_RTC() uses cpu_has_feature() which is initialised by
>>> machine_init(). Before machine_init(), __USE_RTC() returns true,
>>> leading to a program check exception on CPUs not having realtime
>>> clock.
>>>
>>> In order to be able to use printk() earlier, use feature fixup.
>>> Feature fixups are applies in early_init(), enabling the use of
>>> printk() earlier.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/include/asm/time.h | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> The other option would be just to make this a compile time decision, eg.
>> add CONFIG_PPC_601 and use that to gate whether we use RTC.
>>
>> Given how many 601 users there are, maybe 1?, I think that would be a
>> simpler option and avoids complicating the code / binary for everyone
>> else.
> 
> Didn't we ditch 601 support years ago anyway ? We had workaround we
> threw out I think...

There are still workarounds for 601 in the kernel, for exemple (in 
arch/powerpc/include/asm/ppc_asm.h)

/* various errata or part fixups */
#ifdef CONFIG_PPC601_SYNC_FIX
#define SYNC				\
BEGIN_FTR_SECTION			\
	sync;				\
	isync;				\
END_FTR_SECTION_IFSET(CPU_FTR_601)
#define SYNC_601			\
BEGIN_FTR_SECTION			\
	sync;				\
END_FTR_SECTION_IFSET(CPU_FTR_601)
#define ISYNC_601			\
BEGIN_FTR_SECTION			\
	isync;				\
END_FTR_SECTION_IFSET(CPU_FTR_601)
#else
#define	SYNC
#define SYNC_601
#define ISYNC_601
#endif

But if you think we can get rid of 601 completely, I'm happy with that.

Christophe


> 
> Cheers,
> Ben.
> 
>> cheers
>>
>>> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
>>> index 54f4ec1f9fab..3455cb54c333 100644
>>> --- a/arch/powerpc/include/asm/time.h
>>> +++ b/arch/powerpc/include/asm/time.h
>>> @@ -42,7 +42,14 @@ struct div_result {
>>>   /* Accessor functions for the timebase (RTC on 601) registers. */
>>>   /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
>>>   #ifdef CONFIG_PPC_BOOK3S_32
>>> -#define __USE_RTC()	(cpu_has_feature(CPU_FTR_USE_RTC))
>>> +static inline bool __USE_RTC(void)
>>> +{
>>> +	asm_volatile_goto(ASM_FTR_IFCLR("nop;", "b %1;", %0) ::
>>> +			  "i" (CPU_FTR_USE_RTC) :: l_use_rtc);
>>> +	return false;
>>> +l_use_rtc:
>>> +	return true;
>>> +}
>>>   #else
>>>   #define __USE_RTC()	0
>>>   #endif
>>> -- 
>>> 2.13.3
