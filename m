Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DFBC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89BE20989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 08:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ru2p0jnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGFI0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 04:26:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9518 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfGFI0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 04:26:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45glDq6ZjYz9vBmT;
        Sat,  6 Jul 2019 10:26:51 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ru2p0jnF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AECzU9flJshk; Sat,  6 Jul 2019 10:26:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45glDq4qGpz9vBmQ;
        Sat,  6 Jul 2019 10:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1562401611; bh=mh8ujrNVmKQnrW9nDzbu+49uRl2+DM2LFGY+iQ49uaE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ru2p0jnF3ids7fmZpTgeYrASFyvoVkL72KL/HeYQ+FTu3BKXtl3xPhH5MVCevoRU5
         ujz7aVUOcCi7kYFlJeRsd9lMWRlLVvjxRFDOamnDYT9QN93qZB0IWNb1IKUooXuOTZ
         rE509HWZ5soWFRwGVdAFSl/JOYdXdrOteQE3s3Ok=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA47F8B768;
        Sat,  6 Jul 2019 10:26:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IektAObbTzti; Sat,  6 Jul 2019 10:26:52 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 47A948B74C;
        Sat,  6 Jul 2019 10:26:52 +0200 (CEST)
Subject: Re: [PATCH] powerpc/hw_breakpoint: move instruction stepping out of
 hw_breakpoint_handler()
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <f8cdc3f1c66ad3c43ebc568abcc6c39ed4676284.1561737231.git.christophe.leroy@c-s.fr>
 <57148696-b9a5-d3c1-1e29-82673c558927@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bef43f48-fa40-284e-a299-bc73ebc3e725@c-s.fr>
Date:   Sat, 6 Jul 2019 10:26:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <57148696-b9a5-d3c1-1e29-82673c558927@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/07/2019 à 08:20, Ravi Bangoria a écrit :
> 
> 
> On 6/28/19 9:25 PM, Christophe Leroy wrote:
>> On 8xx, breakpoints stop after executing the instruction, so
>> stepping/emulation is not needed. Move it into a sub-function and
>> remove the #ifdefs.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Just one neat below...

Thanks for the review.

> 
> [...]
> 
>> -#ifndef CONFIG_PPC_8xx
>> -	/* Do not emulate user-space instructions, instead single-step them */
>> -	if (user_mode(regs)) {
>> -		current->thread.last_hit_ubp = bp;
>> -		regs->msr |= MSR_SE;
>> +	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info->address))
> 
> May be split this line. It's 86 chars long and checkpatch.pl is warning
> about this:

Didn't you use arch/powerpc/tools/checkpatch.sh ?

powerpc accepts 90 chars per line.

Christophe

> 
> WARNING: line over 80 characters
> #257: FILE: arch/powerpc/kernel/hw_breakpoint.c:282:
> +	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info->address))
> 
