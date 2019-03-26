Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE38CC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B92820856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="STYA/823"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCZGC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:02:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5345 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfCZGC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:02:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44T0sq3PSJz9v1Lc;
        Tue, 26 Mar 2019 07:02:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=STYA/823; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SgS_Hp3vGlkR; Tue, 26 Mar 2019 07:02:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44T0sq2HRtz9v1L3;
        Tue, 26 Mar 2019 07:02:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553580175; bh=Fy6LPoOdBs73WrsGgbOPU6qskDPR3fq9ggj5GTIfUTI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=STYA/823aLEMykfaZpZWjkFn6b0mXN5WeJmw/gopLjkZ9xPdnJHqW/2fN4QkjK8+H
         aFfQ/gKFPQlQr+r/j3C0W52SxHyDLn2bjka6i6Q8pOL1E/Tgym8ze1f4USXZ31xhQA
         l3QrHTc+eO/hKyaXoRy2t7HJa/xd3SId7zeM4jls=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1330E8B77C;
        Tue, 26 Mar 2019 07:02:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xor2vUAwR2nm; Tue, 26 Mar 2019 07:02:55 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CE1D8B74C;
        Tue, 26 Mar 2019 07:02:55 +0100 (CET)
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
 <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <686abdd5-863a-02ce-5ac9-f573208b8315@c-s.fr>
Date:   Tue, 26 Mar 2019 07:02:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Le 25/03/2019 à 07:44, Masahiro Yamada a écrit :
> Hi Christophe,
> 
> 
> On Sat, Mar 23, 2019 at 5:27 PM LEROY Christophe
> <christophe.leroy@c-s.fr> wrote:
>>
>> Arnd Bergmann <arnd@arndb.de> a écrit :
>>
>>> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>>
>>>> I've added your patch to my randconfig test setup and will let you
>>>> know if I see anything noticeable. I'm currently testing clang-arm32,
>>>> clang-arm64 and gcc-x86.
>>>
>>> This is the only additional bug that has come up so far:
>>>
>>> `.exit.text' referenced in section `.alt.smp.init' of
>>> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
>>> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
>>
>> Wouldn't it be useful to activate -Winline gcc warning to ease finding
>> out problematic usage of inline keyword ?
> 
> 
> Yes, it is useful to find out
> which function is causing the error.
> Thanks for the tip.
> 

I did a mass build on kisskb. Almost ok, see results at 
http://kisskb.ellerman.id.au/kisskb/head/203d912edf8dde291977c71aa64024065e197f79/

ps3_defconfig with GCC 5 fails 
(http://kisskb.ellerman.id.au/kisskb/buildresult/13742711/) with:

arch/powerpc/mm/tlb-radix.c:148:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:148:2: error: impossible constraint in 'asm'
arch/powerpc/mm/tlb-radix.c:118:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]

ps3_defconfig with GCC 4.6 fails 
(http://kisskb.ellerman.id.au/kisskb/buildresult/13742591/) with:

arch/powerpc/mm/tlb-radix.c:148:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:118:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]

randconfig with GCC 4.6 fails 
(http://kisskb.ellerman.id.au/kisskb/buildresult/13742698/) with:

arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'

Christophe
