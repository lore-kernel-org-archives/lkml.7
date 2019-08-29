Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B67C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31F32189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="d1DlSWL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH2M7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:59:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40071 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfH2M7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:59:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46K2jv1ydTz9txfW;
        Thu, 29 Aug 2019 14:58:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=d1DlSWL7; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id roj0O764YFSI; Thu, 29 Aug 2019 14:58:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46K2jv0q5Qz9txfT;
        Thu, 29 Aug 2019 14:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567083539; bh=ETDADYf+IUCVWupaeGrp+tk6VOk0Ifz5sDsNRRsIxEM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d1DlSWL78knKVNtpTsN23QPXzEkdN+PCnkoG6h0EOTzE09c66D0rhvYJVj2i2o3ys
         rFyEYohQLwv8QajUjpql0JKluJHVglf94GO5rhHjTA5z/122jEJLTwHpdWQQrxcNz3
         ByzsE+/YDX2xNTzuBRKI8XONNXkNtMz6aqwuTbUg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A3C58B8BF;
        Thu, 29 Aug 2019 14:59:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vUOO7oAfSdZy; Thu, 29 Aug 2019 14:59:00 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 323F68B8B4;
        Thu, 29 Aug 2019 14:59:00 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm: tell if a bad page fault on data is read or
 write.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <4f88d7e6fda53b5f80a71040ab400242f6c8cb93.1566400889.git.christophe.leroy@c-s.fr>
 <87o908tbgx.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5f539c22-532a-3319-afe8-cdfac4ab3ee6@c-s.fr>
Date:   Thu, 29 Aug 2019 14:59:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87o908tbgx.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/08/2019 à 14:14, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> DSISR has a bit to tell if the fault is due to a read or a write.
> 
> Except some CPUs don't have a DSISR?
> 
> Which is why we have page_fault_is_write() that's used in
> __do_page_fault().
> 
> Or is that old cruft?
> 
> I see eg. in head_40x.S we pass r5=0 for error code, and we don't set
> regs->dsisr anywhere AFAICS. So it might just contain some junk.

But then we have a problem with show_regs() as well, havent't we ?

	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
		pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
#else
		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
#endif

I need to look closer.

Christophe


> 
> cheers
> 
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 8432c281de92..b5047f9b5dec 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -645,6 +645,7 @@ NOKPROBE_SYMBOL(do_page_fault);
>>   void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>>   {
>>   	const struct exception_table_entry *entry;
>> +	int is_write = page_fault_is_write(regs->dsisr);
>>   
>>   	/* Are we prepared to handle this fault?  */
>>   	if ((entry = search_exception_tables(regs->nip)) != NULL) {
>> @@ -658,9 +659,10 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>>   	case 0x300:
>>   	case 0x380:
>>   	case 0xe00:
>> -		pr_alert("BUG: %s at 0x%08lx\n",
>> +		pr_alert("BUG: %s on %s at 0x%08lx\n",
>>   			 regs->dar < PAGE_SIZE ? "Kernel NULL pointer dereference" :
>> -			 "Unable to handle kernel data access", regs->dar);
>> +			 "Unable to handle kernel data access",
>> +			 is_write ? "write" : "read", regs->dar);
> 
>>   		break;
>>   	case 0x400:
>>   	case 0x480:
>> -- 
>> 2.13.3
