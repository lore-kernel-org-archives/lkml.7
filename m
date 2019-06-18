Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36803C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B62C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qegwrawi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFRGum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:50:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50531 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfFRGum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:50:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45ScsR5HjJz9v2JK;
        Tue, 18 Jun 2019 08:01:31 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qegwrawi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H_7TJYDp76pN; Tue, 18 Jun 2019 08:01:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45ScsR46MYz9v2Hx;
        Tue, 18 Jun 2019 08:01:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560837691; bh=7MhG5BQkk93ena6b4Du32oIN3mMMrdzWABAMIxugFnc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qegwrawi6feoHNSh2Z6KCBFdsFriTp9GllNy2ti98hOfc27ImcSnjNl2rap3hlGOJ
         PuNFHQ5X1MoHA5k/uhh6YIWVg3nyzewpLjx/7fJBPCJ2aXMByBYco/YmW+94e1xMwz
         SubkBI8di+Pqeo2S9AjeMKRzB4hrk4u5c5cGIXMw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D29A8B880;
        Tue, 18 Jun 2019 08:01:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fjVvnbzRWAAh; Tue, 18 Jun 2019 08:01:31 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A5A758B78B;
        Tue, 18 Jun 2019 08:01:30 +0200 (CEST)
Subject: Re: [PATCH 0/5] Powerpc/hw-breakpoint: Fixes plus Code refactor
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2344165b-b55b-d1b9-fd96-e057500e8c74@c-s.fr>
Date:   Tue, 18 Jun 2019 08:01:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/06/2019 à 06:27, Ravi Bangoria a écrit :
> patch 1-3: Code refactor
> patch 4: Speedup disabling breakpoint
> patch 5: Fix length calculation for unaligned targets

While you are playing with hw breakpoints, did you have a look at 
https://github.com/linuxppc/issues/issues/38 ?

Christophe

> 
> Ravi Bangoria (5):
>    Powerpc/hw-breakpoint: Replace stale do_dabr() with do_break()
>    Powerpc/hw-breakpoint: Refactor hw_breakpoint_arch_parse()
>    Powerpc/hw-breakpoint: Refactor set_dawr()
>    Powerpc/hw-breakpoint: Optimize disable path
>    Powerpc/Watchpoint: Fix length calculation for unaligned target
> 
>   arch/powerpc/include/asm/hw_breakpoint.h | 10 ++--
>   arch/powerpc/kernel/hw_breakpoint.c      | 56 ++++++++++++----------
>   arch/powerpc/kernel/process.c            | 61 +++++++++++++++++++-----
>   arch/powerpc/kernel/ptrace.c             |  2 +-
>   4 files changed, 86 insertions(+), 43 deletions(-)
> 
