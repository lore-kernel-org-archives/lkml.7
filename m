Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B69C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858A320B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="l0SUFH/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfJINhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:37:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46459 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731138AbfJINhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:37:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46pFdg6jxgz9v0tt;
        Wed,  9 Oct 2019 15:37:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=l0SUFH/C; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gai2MFR_wdEX; Wed,  9 Oct 2019 15:37:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46pFdg5d9Xz9v06Z;
        Wed,  9 Oct 2019 15:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1570628263; bh=8Qdv5FuJwm79jqYF5/Ft1YdqyZGh8baYlRjV6rSPdwU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l0SUFH/CzinnBVUxOj7SsSXzKlvYANQaokKSuedFvNYGvWS+P2c1LQ8/9ZJHn2Cex
         yxBlYWtMF8EpU6vOPC+VzKtNHZuKI4jNwt5KGG/sf4nJl1Q4kk+LOpUrWKooP4glir
         EBphrvhKqVqzVkzt1IKZWECLhS+EiI0m4HgCTIcM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E433F8B87E;
        Wed,  9 Oct 2019 15:37:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Vg5Rl6wZSHxx; Wed,  9 Oct 2019 15:37:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 514318B8A5;
        Wed,  9 Oct 2019 15:37:44 +0200 (CEST)
Subject: Re: [PATCH v4 0/5] Powerpc/Watchpoint: Few important fixes
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
 <19b222ce-3013-7de5-1c04-48c6fd00fe81@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0d98e256-44ee-f920-cb2f-f79545584769@c-s.fr>
Date:   Wed, 9 Oct 2019 15:37:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <19b222ce-3013-7de5-1c04-48c6fd00fe81@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/10/2019 à 08:35, Ravi Bangoria a écrit :
> 
> 
> On 9/25/19 9:36 AM, Ravi Bangoria wrote:
>> v3: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-July/193339.html
>>
>> v3->v4:
>>   - Instead of considering exception as extraneous when dar is outside of
>>     user specified range, analyse the instruction and check for overlap
>>     between user specified range and actual load/store range.
>>   - Add selftest for the same in perf-hwbreak.c
>>   - Make ptrace-hwbreak.c selftest more strict by checking address in
>>     check_success.
>>   - Support for 8xx in ptrace-hwbreak.c selftest (Build tested only)
>>   - Rebase to powerpc/next
>>
>> @Christope, Can you please check Patch 5. I've just build-tested it
>> with ep88xc_defconfig.
> 
> @mpe, @mikey, Any feedback?
> 
> @Christophe, Is patch5 works for you on 8xx?
> 

Getting the following :

root@vgoip:~# ./ptrace-hwbreak
test: ptrace-hwbreak
tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
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
PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Fail
failure: ptrace-hwbreak

Christophe
