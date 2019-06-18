Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F920665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Kez0CNpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfFRGus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:50:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28760 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfFRGun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:50:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Sd911hX5z9v32x;
        Tue, 18 Jun 2019 08:15:01 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Kez0CNpF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id M3PGQrwHcKMg; Tue, 18 Jun 2019 08:15:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Sd910ccgz9v32w;
        Tue, 18 Jun 2019 08:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560838501; bh=I7JZ9gFH0idmpMT36+ZfnaVxZu1dS6ov87xVghAIsHI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kez0CNpFgGZ3NO9Di1I6CyWydEgSaGBOUXCnxjRlwzyPH/feGNWpybrn9vWiZUNum
         VSREH721pYnrFfPLh5AbaKfQCUzVfax5o0bHPZXYq7J7u+RGb7mcBL5uWlkjfBCgLz
         qhRDSqMjghVBqNHreAcgwU4+hfHUXZMHIKr9Y3m0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0ED818B880;
        Tue, 18 Jun 2019 08:15:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IJKu8cZ1nbSz; Tue, 18 Jun 2019 08:15:00 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46ED58B78B;
        Tue, 18 Jun 2019 08:15:00 +0200 (CEST)
Subject: Re: [PATCH 1/5] Powerpc/hw-breakpoint: Replace stale do_dabr() with
 do_break()
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, naveen.n.rao@linux.vnet.ibm.com
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
 <20190618042732.5582-2-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ad944298-3418-cc94-c120-554ba0f03f0c@c-s.fr>
Date:   Tue, 18 Jun 2019 08:14:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618042732.5582-2-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject text should mention you are changing comments. Here it 
suggests you are changing code text.

Le 18/06/2019 à 06:27, Ravi Bangoria a écrit :
> do_dabr() was renamed with do_break() long ago. But I still see
> some comments mentioning do_dabr(). Replace it.

s/Replace it/Replace them/

Christophe

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c | 2 +-
>   arch/powerpc/kernel/ptrace.c        | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index a293a53b4365..1908e4fcc132 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -232,7 +232,7 @@ int hw_breakpoint_handler(struct die_args *args)
>   	 * Return early after invoking user-callback function without restoring
>   	 * DABR if the breakpoint is from ptrace which always operates in
>   	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
> -	 * generated in do_dabr().
> +	 * generated in do_break().
>   	 */
>   	if (bp->overflow_handler == ptrace_triggered) {
>   		perf_bp_event(bp, regs);
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 684b0b315c32..44b823e5e8c8 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -2373,7 +2373,7 @@ void ptrace_triggered(struct perf_event *bp,
>   	/*
>   	 * Disable the breakpoint request here since ptrace has defined a
>   	 * one-shot behaviour for breakpoint exceptions in PPC64.
> -	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> +	 * The SIGTRAP signal is generated automatically for us in do_break().
>   	 * We don't have to do anything about that here
>   	 */
>   	attr = bp->attr;
> 
