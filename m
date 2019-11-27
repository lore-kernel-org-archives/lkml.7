Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A696C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9920678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qShOcQlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0OsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:48:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3892 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfK0Or7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:47:59 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NNt42w4mz9v0w8;
        Wed, 27 Nov 2019 15:47:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qShOcQlp; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8sFkpU0CXzhx; Wed, 27 Nov 2019 15:47:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NNt41sghz9v0w7;
        Wed, 27 Nov 2019 15:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574866076; bh=1W4pkRYIjtnmMfpsH0+nUm20obpBPvjB7NQtbwdPbAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qShOcQlpbWQM5NtWwBZbdajuJz0eN5wq724KlbQz34m8lFL7s4RHqwM8jlaCWdJIL
         QI2JlUtzjP1dhjX/CqWwIHMlfgttBdUGO0026MqcIXsMafnMvZGnQBT+S6IAIPIhWX
         J5+OtTVJMQb+DY2Bo+5kGyf7ptCdtz2BHTd7UBIM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B38BE8B862;
        Wed, 27 Nov 2019 15:47:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5E_wXZJsK45e; Wed, 27 Nov 2019 15:47:57 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 16C128B85A;
        Wed, 27 Nov 2019 15:47:57 +0100 (CET)
Subject: Re: [PATCH v3 4/8] powerpc/vdso32: inline __get_datapage()
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1572342582.git.christophe.leroy@c-s.fr>
 <9c9fe32df8633e6ba8e670274dc3eef82a1b5a65.1572342582.git.christophe.leroy@c-s.fr>
 <874kywbrjv.fsf@mpe.ellerman.id.au> <871ru0beke.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <dd5e359b-5864-f8e3-876a-ec606b51eb65@c-s.fr>
Date:   Wed, 27 Nov 2019 15:47:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <871ru0beke.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Le 22/11/2019 à 07:38, Michael Ellerman a écrit :
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> __get_datapage() is only a few instructions to retrieve the
>>> address of the page where the kernel stores data to the VDSO.
>>>
>>> By inlining this function into its users, a bl/blr pair and
>>> a mflr/mtlr pair is avoided, plus a few reg moves.
>>>
>>> The improvement is noticeable (about 55 nsec/call on an 8xx)
>>>
>>> vdsotest before the patch:
>>> gettimeofday:    vdso: 731 nsec/call
>>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>>
>>> vdsotest after the patch:
>>> gettimeofday:    vdso: 677 nsec/call
>>> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
>>> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> This doesn't build with gcc 4.6.3:
>>
>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler messages:
>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:41: Error: unsupported relocation against __kernel_datapage_offset
>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:86: Error: unsupported relocation against __kernel_datapage_offset
>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:213: Error: unsupported relocation against __kernel_datapage_offset
>>    /linux/arch/powerpc/kernel/vdso32/gettimeofday.S:247: Error: unsupported relocation against __kernel_datapage_offset
>>    make[4]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
> 
> Actually I guess it's binutils, which is v2.22 in this case.
> 
> Needed this:
> 
> diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
> index 12785f72f17d..0048db347ddf 100644
> --- a/arch/powerpc/include/asm/vdso_datapage.h
> +++ b/arch/powerpc/include/asm/vdso_datapage.h
> @@ -117,7 +117,7 @@ extern struct vdso_data *vdso_data;
>   .macro get_datapage ptr, tmp
>   	bcl	20, 31, .+4
>   	mflr	\ptr
> -	addi	\ptr, \ptr, __kernel_datapage_offset - (.-4)
> +	addi	\ptr, \ptr, (__kernel_datapage_offset - (.-4))@l
>   	lwz	\tmp, 0(\ptr)
>   	add	\ptr, \tmp, \ptr
>   .endm
> 

Are you still planning to getting this series merged ? Do you need any 
help / rebase / re-spin ?

Christophe
