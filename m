Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB17C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3492189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Cfx8ykrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfH2Ii7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:38:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37944 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfH2Ii6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:38:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Jwxq4GPGz9tyg4;
        Thu, 29 Aug 2019 10:38:55 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Cfx8ykrB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HE3GtSajPGhf; Thu, 29 Aug 2019 10:38:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Jwxq37BMz9tyg2;
        Thu, 29 Aug 2019 10:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567067935; bh=tXCF7AbKTiavyowWoh/vYmV9ZQwmX5kJekIVsIYLj/g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cfx8ykrBnE57ra6XU5KLHpxPOOQwPT5hI0EjyMJRgp6NeO5DaE5nxD1gsv/4AqXPf
         1+7OA+ffewODFsUE1eySj/y6mRHDDcd3hLrwLDc9eJdMdofqX90rSO68LRTSMsNGs5
         79MBd5DK+jm5kCtYycshxVcLfoaVvN+qbeMeRIzc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82CBD8B8AB;
        Thu, 29 Aug 2019 10:38:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PPFRhYuRjlPE; Thu, 29 Aug 2019 10:38:56 +0200 (CEST)
Received: from [192.168.204.43] (unknown [192.168.204.43])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8CFC8B7B2;
        Thu, 29 Aug 2019 10:38:53 +0200 (CEST)
Subject: Re: [PATCH v3 3/4] powerpc/64: make buildable without CONFIG_COMPAT
To:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christian Brauner <christian@brauner.io>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <cover.1567007242.git.msuchanek@suse.de>
 <0ad51b41aebf65b3f3fcb9922f0f00b47932725d.1567007242.git.msuchanek@suse.de>
 <20190829064624.GA28508@infradead.org>
 <CAK8P3a2qgLTbud+2Fw8Rr0RXV8-xwBMiBg3hFuqqBinN1zS90A@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b3f74049-be82-be3c-5156-69a18010537e@c-s.fr>
Date:   Thu, 29 Aug 2019 10:38:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2qgLTbud+2Fw8Rr0RXV8-xwBMiBg3hFuqqBinN1zS90A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/08/2019 à 10:01, Arnd Bergmann a écrit :
> On Thu, Aug 29, 2019 at 8:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> 
>>> @@ -277,7 +277,7 @@ static void do_signal(struct task_struct *tsk)
>>>
>>>        rseq_signal_deliver(&ksig, tsk->thread.regs);
>>>
>>> -     if (is32) {
>>> +     if ((IS_ENABLED(CONFIG_PPC32) || IS_ENABLED(CONFIG_COMPAT)) && is32) {
>>
>> I think we should fix the is_32bit_task definitions instead so that
>> callers don't need this mess.  I'd suggest something like:
>>
>> #ifdef CONFIG_COMPAT
>> #define is_32bit_task()         test_thread_flag(TIF_32BIT)
>> #else
>> #define is_32bit_task()         IS_ENABLED(CONFIG_PPC32)
>> #endif
> 
> Are there actually any (correct) uses of is_32bit_task() outside of
> #ifdef CONFIG_PPC64?

There is at least  stack_maxrandom_size()
Also  brk_rnd() and do_signal()

Christophe

> 
> I suspect most if not all could be changed to the generic
> in_compat_syscall() that we use outside of architecture specific
> code.
> 
>         Arnd
> 
