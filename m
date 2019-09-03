Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DAAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2743223431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NadPAAvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfICO2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:28:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45354 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfICO2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:28:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46N8ST1qcLz9ttRm;
        Tue,  3 Sep 2019 16:28:09 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NadPAAvo; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YIqAoA6_GE1M; Tue,  3 Sep 2019 16:28:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46N8ST0jlLz9ttRl;
        Tue,  3 Sep 2019 16:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567520889; bh=kXB46zG+6q2eXqvLmy0/IgVzs9oH8tQXmcdlQmiB+wg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NadPAAvoij6yX6RdAFRjaR6rpb/dkxjSxBl8j5gqqihJMv86k9SOHVFf3G90VUqTH
         HhMohZu/PT9TKaaLsqXnapF2ZadS/o7ZcSFQpAKcQalYSpNNzAXTk3ElF93YgzXC+H
         dhY/cDlTR4wrqUoaKBESSfRJofXwcs3s7TZF1fdA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 934488B86E;
        Tue,  3 Sep 2019 16:28:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6LTJD3JQLISg; Tue,  3 Sep 2019 16:28:10 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 663128B868;
        Tue,  3 Sep 2019 16:28:09 +0200 (CEST)
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Alastair D'Silva <alastair@au1.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, alastair@d-silva.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-4-alastair@au1.ibm.com>
 <20190903130430.GC31406@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
Date:   Tue, 3 Sep 2019 16:28:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903130430.GC31406@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2019 à 15:04, Segher Boessenkool a écrit :
> Hi!
> 
> On Tue, Sep 03, 2019 at 03:23:57PM +1000, Alastair D'Silva wrote:
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> 
>> +#if !defined(CONFIG_PPC_8xx) & !defined(CONFIG_PPC64)
> 
> Please write that as &&?  That is more usual, and thus, easier to read.
> 
>> +static void flush_dcache_icache_phys(unsigned long physaddr)
> 
>> +	asm volatile(
>> +		"   mtctr %2;"
>> +		"   mtmsr %3;"
>> +		"   isync;"
>> +		"0: dcbst   0, %0;"
>> +		"   addi    %0, %0, %4;"
>> +		"   bdnz    0b;"
>> +		"   sync;"
>> +		"   mtctr %2;"
>> +		"1: icbi    0, %1;"
>> +		"   addi    %1, %1, %4;"
>> +		"   bdnz    1b;"
>> +		"   sync;"
>> +		"   mtmsr %5;"
>> +		"   isync;"
>> +		: "+r" (loop1), "+r" (loop2)
>> +		: "r" (nb), "r" (msr), "i" (bytes), "r" (msr0)
>> +		: "ctr", "memory");
> 
> This outputs as one huge assembler statement, all on one line.  That's
> going to be fun to read or debug.

Do you mean \n has to be added after the ; ?

> 
> loop1 and/or loop2 can be assigned the same register as msr0 or nb.  They
> need to be made earlyclobbers.  (msr is fine, all of its reads are before
> any writes to loop1 or loop2; and bytes is fine, it's not a register).

Can you explicit please ? Doesn't '+r' means that they are input and 
output at the same time ?

"to be made earlyclobbers", what does this means exactly ? How to do that ?

Christophe
