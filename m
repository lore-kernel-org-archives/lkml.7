Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654A6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3260521721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wBC98HFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbfJ2OB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:01:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65397 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfJ2OB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:01:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 472YCl24Zrz9v02H;
        Tue, 29 Oct 2019 15:01:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wBC98HFB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kQBmk6d20Oj7; Tue, 29 Oct 2019 15:01:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 472YCl11dzz9v023;
        Tue, 29 Oct 2019 15:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572357683; bh=ZT1h4VryA2wthS6A+f+Zm6rBjcB7Ostnjnhs7fAimsI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wBC98HFBxpusQdx5XlTeIcr0bnnfGYS7Qlpcqj8mQNmrXWJbSuoL5coLC2nGg8PoT
         NcE1hBTwJZVrl9s89SJ0iAqzZz5apgV9nouJ4rS7vRIVQB9NqDDE3YRmHO8qnq2ak7
         mbJ0beqC6RRo5eutEcUwPuOkN+qaxHqtzEESSA8U=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 829B28B869;
        Tue, 29 Oct 2019 15:01:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m5zGj5hczfzc; Tue, 29 Oct 2019 15:01:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C090B8B85C;
        Tue, 29 Oct 2019 15:01:23 +0100 (CET)
Subject: Re: [PATCH v6 0/7] Powerpc/Watchpoint: Few important fixes
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
 <10cce8b1-8142-39d3-cd91-58b85dac7c8c@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ecb3eda1-f111-9485-c28c-e20020ae1d46@c-s.fr>
Date:   Tue, 29 Oct 2019 15:01:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <10cce8b1-8142-39d3-cd91-58b85dac7c8c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/10/2019 à 05:54, Ravi Bangoria a écrit :
> 
> 
> On 10/17/19 3:01 PM, Ravi Bangoria wrote:
>> v5: 
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198069.html
>>
>> v5->v6:
>>   - patch 6/7: mpe reported that the perf-hwbreak.c doesn't compile 
>> with older
>>     gcc:
>>          perf-hwbreak.c:182:2: error: dereferencing type-punned 
>> pointer will
>>          break strict-aliasing rules [-Werror=strict-aliasing]
>>              temp16 = *((__u16 *)target);
>>              ^
>>     Fixed that.
>>
> 
> Hi Christophe, Are you ok with the series wrt 8xx?

Yes it looks ok on my 885:

root@vgoip:~# ./ptrace-hwbreak
test: ptrace-hwbreak
tags: git_version:v5.4-rc4-835-gb235e63aa9f0-dirty
PTRACE_SET_DEBUGREG, WO, len: 1: Ok
PTRACE_SET_DEBUGREG, WO, len: 2: Ok
PTRACE_SET_DEBUGREG, WO, len: 4: Ok
PTRACE_SET_DEBUGREG, WO, len: 8: Ok
PTRACE_SET_DEBUGREG, RO, len: 1: Ok
PTRACE_SET_DEBUGREG, RO, len: 2: Ok
PTRACE_SET_DEBUGREG, RO, len: 4: Ok
PTRACE_SET_DEBUGREG, RO, len: 8: Ok
PTRACE_SET_DEBUGREG, RW, len: 1: Ok
PTRACE_SET_DEBUGREG, RW, len: 2: Ok
PTRACE_SET_DEBUGREG, RW, len: 4: Ok
PTRACE_SET_DEBUGREG, RW, len: 8: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
success: ptrace-hwbreak

Also ok on book3s/32:
root@vgoippro:~# ./ptrace-hwbreak
test: ptrace-hwbreak
tags: git_version:v5.4-rc4-835-gb235e63aa9f0-dirty
PTRACE_SET_DEBUGREG, WO, len: 1: Ok
PTRACE_SET_DEBUGREG, WO, len: 2: Ok
PTRACE_SET_DEBUGREG, WO, len: 4: Ok
PTRACE_SET_DEBUGREG, WO, len: 8: Ok
PTRACE_SET_DEBUGREG, RO, len: 1: Ok
PTRACE_SET_DEBUGREG, RO, len: 2: Ok
PTRACE_SET_DEBUGREG, RO, len: 4: Ok
PTRACE_SET_DEBUGREG, RO, len: 8: Ok
PTRACE_SET_DEBUGREG, RW, len: 1: Ok
PTRACE_SET_DEBUGREG, RW, len: 2: Ok
PTRACE_SET_DEBUGREG, RW, len: 4: Ok
PTRACE_SET_DEBUGREG, RW, len: 8: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Ok
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RW, len: 6: Ok
success: ptrace-hwbreak

Christophe
