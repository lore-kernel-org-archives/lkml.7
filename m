Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C9620659
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pVKePB43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF1Qjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:39:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8807 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfF1Qjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:39:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b2YN3C52zB09Zb;
        Fri, 28 Jun 2019 18:39:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pVKePB43; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YV9INxoLhf96; Fri, 28 Jun 2019 18:39:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b2YN1sxvzB09ZZ;
        Fri, 28 Jun 2019 18:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561739992; bh=uppHxiv76x3DLKs7pLhlu/yXbeshcJ3XT1kuNUTvaPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pVKePB433jkcqO4D8bb2+BUMLdTABMAkxqnveFnbO1rdXjkO3/uFx5gQgU0imVgrU
         dvssKi2YNnNQ3gtKgdjNuKSxGeQ6f/FNCC+HAwKyiyzSAQB1hKEZbaCljM48zle36I
         jaJoCycDiu/lUGojW6IdvtaWngvG9AthpyWo2nl4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5B5E8B975;
        Fri, 28 Jun 2019 18:39:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f00KyCZdoUwa; Fri, 28 Jun 2019 18:39:53 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C2B188B955;
        Fri, 28 Jun 2019 18:39:53 +0200 (CEST)
Subject: Re: [RFC PATCH v2 02/12] powerpc/ptrace: drop unnecessary #ifdefs
 CONFIG_PPC64
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
 <34af3942cd27f6b5365caae772fb8e0af44763d5.1561735587.git.christophe.leroy@c-s.fr>
 <874l49mzuv.fsf@igel.home>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7dd19eae-793e-b334-e621-7681998ddf2e@c-s.fr>
Date:   Fri, 28 Jun 2019 18:39:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <874l49mzuv.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/06/2019 à 18:36, Andreas Schwab a écrit :
> On Jun 28 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
>> index f5f1ccc740fc..37d7befbb8dc 100644
>> --- a/arch/powerpc/include/uapi/asm/ptrace.h
>> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
>> @@ -43,12 +43,11 @@ struct pt_regs
>>   	unsigned long link;
>>   	unsigned long xer;
>>   	unsigned long ccr;
>> -#ifdef __powerpc64__
>> -	unsigned long softe;		/* Soft enabled/disabled */
>> -#else
>> -	unsigned long mq;		/* 601 only (not used at present) */
>> +	union {
>> +		unsigned long softe;	/* Soft enabled/disabled */
>> +		unsigned long mq;	/* 601 only (not used at present) */
>>   					/* Used on APUS to hold IPL value. */
>> -#endif
>> +	};
> 
> Anonymous unions are a C11 feature.
> 

Is that a problem ?

Kernel has a minimum GCC requirement of version 4.6, doesn't 4.6 support 
C11 ?

Christophe
