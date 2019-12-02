Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B223A2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dz3vZEta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLBICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:02:16 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36113 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBICP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:02:15 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47RHdX1YxWz9txsq;
        Mon,  2 Dec 2019 09:02:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dz3vZEta; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Nugd4Uyqk_4B; Mon,  2 Dec 2019 09:02:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47RHdX0WK3z9txsn;
        Mon,  2 Dec 2019 09:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575273728; bh=R0DzOApn8sfF6b/fIqfYO/uTeigqDJ/6K0S4/0UVFJk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dz3vZEtadKms4NZFO1roHSBY77uzZ4IfNjpoaJ37R8kS7ULKFb7jlQ8u9G4hLdEvn
         nRQ/4smn+bRRPHn2mXT6WrHGYhdvlRAANdOw5gh0HPPOvewfgcAHAWRABgChxxXmAp
         e8xvSG7vOaqC5RZ2eqPwjrm9Sf+iGEL/CMn5LhCg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9F248B79B;
        Mon,  2 Dec 2019 09:02:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kizfJgE835l1; Mon,  2 Dec 2019 09:02:12 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5ED478B770;
        Mon,  2 Dec 2019 09:02:12 +0100 (CET)
Subject: Re: [PATCH v3 4/8] powerpc/vdso32: inline __get_datapage()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
 <9c9fe32df8633e6ba8e670274dc3eef82a1b5a65.1572342582.git.christophe.leroy@c-s.fr>
 <874kywbrjv.fsf@mpe.ellerman.id.au> <871ru0beke.fsf@mpe.ellerman.id.au>
 <dd5e359b-5864-f8e3-876a-ec606b51eb65@c-s.fr>
 <87sgm8zhw0.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <688fe6fa-5bca-4fa6-dda3-603e515be60d@c-s.fr>
Date:   Mon, 2 Dec 2019 08:02:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87sgm8zhw0.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2019 05:31 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 22/11/2019 à 07:38, Michael Ellerman a écrit :
>>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>> __get_datapage() is only a few instructions to retrieve the
>>>>> address of the page where the kernel stores data to the VDSO.
>>>>>
>>>>> By inlining this function into its users, a bl/blr pair and
>>>>> a mflr/mtlr pair is avoided, plus a few reg moves.
>>>>>
>>>>> The improvement is noticeable (about 55 nsec/call on an 8xx)
>>>>>
>>>>> vdsotest before the patch:
>>>>> gettimeofday:    vdso: 731 nsec/call
>>>>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>>>>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>>>>
>>>>> vdsotest after the patch:
>>>>> gettimeofday:    vdso: 677 nsec/call
>>>>> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
>>>>> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>
>>>> This doesn't build with gcc 4.6.3:
>>>>
>>>>     /linux/arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
>>>>     /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:41: Error: unsupported relocation against __kernel_datapage_offset
>>>>     /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:86: Error: unsupported relocation against __kernel_datapage_offset
>>>>     /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:213: Error: unsupported relocation against __kernel_datapage_offset
>>>>     /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:247: Error: unsupported relocation against __kernel_datapage_offset
>>>>     make[4]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
>>>
>>> Actually I guess it's binutils, which is v2.22 in this case.
>>>
>>> Needed this:
>>>
>>> diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
>>> index 12785f72f17d..0048db347ddf 100644
>>> --- a/arch/powerpc/include/asm/vdso_datapage.h
>>> +++ b/arch/powerpc/include/asm/vdso_datapage.h
>>> @@ -117,7 +117,7 @@ extern struct vdso_data *vdso_data;
>>>    .macro get_datapage ptr, tmp
>>>    	bcl	20, 31, .+4
>>>    	mflr	\ptr
>>> -	addi	\ptr, \ptr, __kernel_datapage_offset - (.-4)
>>> +	addi	\ptr, \ptr, (__kernel_datapage_offset - (.-4))@l
>>>    	lwz	\tmp, 0(\ptr)
>>>    	add	\ptr, \tmp, \ptr
>>>    .endm
>>>
>>
>> Are you still planning to getting this series merged ? Do you need any
>> help / rebase / re-spin ?
> 
> Not sure. I'll possibly send a 2nd pull request next week with it
> included.
> 

v3 conflicts with 2038 cleanup series from Arnd merged yesterday by 
Linus (ceb307474506 ("Merge tag 'y2038-cleanups-5.5' of 
git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground"))

Not seen your Ack in that series.

I sent out v4 of my series, rebased on top of 2038 cleanup series.

Christophe
