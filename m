Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B000C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566D72073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hZkK/m8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfLLQ3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:29:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:61781 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfLLQ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:29:08 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47YfPs2NwxzB09Zb;
        Thu, 12 Dec 2019 17:29:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hZkK/m8H; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7szMB8CuQCrE; Thu, 12 Dec 2019 17:29:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47YfPs1CttzB09ZY;
        Thu, 12 Dec 2019 17:29:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576168145; bh=GqFn+uBl1T1SHKz7HkTW4UtcdVqHhLnzfzrSD9BDta0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hZkK/m8HNu6crHPRFQeyTlxplW8itx03feClS8KjZ4yIjdVlEkwbbG+iGfL8Z26Ez
         rXXgv8/DU7MVt5qteRHEOUo0dRKAk3HeLBP/vPAlPHLQ/KIuqVZst1u1MrtOgvn4NN
         zy9JLTLo/cFdvfuHIUIwxlTzZK81Nko5IGSQd2gg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C2EDE8B876;
        Thu, 12 Dec 2019 17:29:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3HzLIrD_1spS; Thu, 12 Dec 2019 17:29:06 +0100 (CET)
Received: from [172.25.230.112] (po15451.idsi0.si.c-s.fr [172.25.230.112])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FB778B872;
        Thu, 12 Dec 2019 17:29:06 +0100 (CET)
Subject: Re: [PATCH] powerpc/irq: don't use current_stack_pointer() in
 do_IRQ()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1bb34d3ea006c308221706290613e6cc5dc3cb74.1575802064.git.christophe.leroy@c-s.fr>
 <20191212125116.GA3381@infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <185df2a7-e6c4-0d2d-59cd-760df94fa3c6@c-s.fr>
Date:   Thu, 12 Dec 2019 17:29:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191212125116.GA3381@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/12/2019 à 13:51, Christoph Hellwig a écrit :
> Why can't current_stack_pointer be turned into an inline function using
> inline assembly?  That would reduce the overhead for all callers.
> 

In the old days, it was a macro, and it was changed into an assembly 
function by commit 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfe9a2cfe91a

It was later renamed from __get_SP() to current_stack_pointer() by 
commit 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=acf620ecf56cfc4edaffaf158250e128539cdd26

But in fact this function is badly named as it doesn't provide the 
current stack pointer but a pointer to the parent's stack frame.

Having it as an extern function forces GCC to set a stack frame in the 
calling function. If inline assembly is used instead, there's a risk of 
not getting a stack frame in the calling function, in which case the 
current_stack_pointer() will return the grandparent's stackframe pointer 
instead of the parent's one.

Christophe
