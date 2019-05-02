Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99482C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661DC208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FeqAubAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBHYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:24:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53079 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEBHYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:24:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44vmx06S8Lz9v0B5;
        Thu,  2 May 2019 09:24:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=FeqAubAK; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id w-82r1tBlzxt; Thu,  2 May 2019 09:24:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44vmx05QGrz9v0B4;
        Thu,  2 May 2019 09:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556781876; bh=G48SgTD8MZ7+zweAo8RFqAosj90VXu0rwEgFUQxNSew=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FeqAubAK5XKD82KCZj1diB10IxkVrKOKtgXy9Mk9wDtdouGln3Xdviu/ttUSOBv+M
         ZSDINo+m8k29cnXLxBV46gKgmmu6ghlRgmqnV9qfyRN3j8KD10e5LlIsyRPJdvpp6L
         S08avm9zPreoUEzPzi6MAyyOqGVEvy0PkQYtqv4Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B03BC8B74C;
        Thu,  2 May 2019 09:24:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G1ANH9jVu9tn; Thu,  2 May 2019 09:24:37 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52B378B880;
        Thu,  2 May 2019 09:24:37 +0200 (CEST)
Subject: Re: [PATCH 2/3] powerpc/module32: Use symbolic instructions names.
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <23167861f6095456b4ba3b52c55a514201ca738f.1556534520.git.christophe.leroy@c-s.fr>
 <14f88b27ff94f2d5a07a8cbc33ec75e2f8af9cf9.1556534520.git.christophe.leroy@c-s.fr>
 <20190429115431.GN8599@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e1b55a87-cde0-895b-4cef-2c1ae9b63763@c-s.fr>
Date:   Thu, 2 May 2019 09:24:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429115431.GN8599@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/04/2019 à 13:54, Segher Boessenkool a écrit :
> On Mon, Apr 29, 2019 at 10:43:27AM +0000, Christophe Leroy wrote:
>> To increase readability/maintainability, replace hard coded
>> instructions values by symbolic names.
> 
>> +	/* lis r12,sym@ha */
>> +#define ENTRY_JMP0(sym)	(PPC_INST_ADDIS | __PPC_RT(R12) | PPC_HA(sym))
>> +	/* addi r12,r12,sym@l */
>> +#define ENTRY_JMP1(sym)	(PPC_INST_ADDI | __PPC_RT(R12) | __PPC_RA(R12) | PPC_LO(sym))
> 
> Those aren't "jump" instructions though, as the name suggests...  And you
> only have names for the first two of the four insns.  ("2" and "3" were
> still available ;-) )

Well, the idea was to say they are defining the jump destination.
Anyway, as they are used only once, let's put it directly in.

> 
>> -	entry->jump[0] = 0x3d800000+((val+0x8000)>>16); /* lis r12,sym@ha */
>> -	entry->jump[1] = 0x398c0000 + (val&0xffff);     /* addi r12,r12,sym@l*/
>> -	entry->jump[2] = 0x7d8903a6;                    /* mtctr r12 */
>> -	entry->jump[3] = 0x4e800420;			/* bctr */
>> +	entry->jump[0] = ENTRY_JMP0(val);
>> +	entry->jump[1] = ENTRY_JMP1(val);
>> +	entry->jump[2] = PPC_INST_MTCTR | __PPC_RS(R12);
>> +	entry->jump[3] = PPC_INST_BCTR;
> 
> Deleting the comment here is not an improvement imo.

Ok, I'll leave them in as I did for module64

Christophe

> 
> 
> Segher
> 
