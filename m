Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77618C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8F8217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UH12Bwxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfHHIqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:46:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44019 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfHHIqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:46:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46426M58z8z9txqh;
        Thu,  8 Aug 2019 10:46:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UH12Bwxv; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id b77WLz6w-gsB; Thu,  8 Aug 2019 10:46:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46426M40Sdz9txqg;
        Thu,  8 Aug 2019 10:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565253995; bh=/j0L6U1ootYvUCLGn7BUQxjfLDtBKup0NqPdL/Ob6TY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UH12BwxvtavgiK4lPjeIoeLpZXpGNwS7KX7nZNNKTRvSBJwrEn3njbY85QnXA/AYy
         oFWdMTw98AgQuhjQbPgnGe7gLz7IzdJ1b3zytb1+LRma+usSGfgXOEd1GwGxFUpQ85
         Cy5lnvwQzv64T50DwJ6443s0c3fwJSWcIXCZPH48=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A81CA8B848;
        Thu,  8 Aug 2019 10:46:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PPwwiEIOCXua; Thu,  8 Aug 2019 10:46:36 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E466D8B7A0;
        Thu,  8 Aug 2019 10:46:35 +0200 (CEST)
Subject: Re: SMP lockup at boot on Freescale/NXP T2080 (powerpc 64)
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
References: <1564970785.27215.29.camel@alliedtelesis.co.nz>
 <4525a16cd3e65f89741b50daf2ec259b6baaab78.camel@alliedtelesis.co.nz>
 <87wofqv8a0.fsf@concordia.ellerman.id.au>
 <1565135404.16914.5.camel@alliedtelesis.co.nz>
 <87o911vktx.fsf@concordia.ellerman.id.au>
 <1565141097.19352.12.camel@alliedtelesis.co.nz>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b0ad453c-3a2b-6dd5-7bfc-5e275aa7bf62@c-s.fr>
Date:   Thu, 8 Aug 2019 10:46:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565141097.19352.12.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/08/2019 à 03:24, Chris Packham a écrit :
> On Wed, 2019-08-07 at 11:13 +1000, Michael Ellerman wrote:
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
>>>
>>> On Tue, 2019-08-06 at 21:32 +1000, Michael Ellerman wrote:
>>> The difference between a working and non working defconfig is
>>> CONFIG_PREEMPT specifically CONFIG_PREEMPT=y makes my system hang
>>> at
>>> boot.
>>>
>>> Is that now intentionally prohibited on 64-bit powerpc?
>> It's not prohibitied, but it probably should be because no one really
>> tests it properly. I have a handful of IBM machines where I boot a
>> PREEMPT kernel but that's about it.
>>
>> The corenet configs don't have PREEMPT enabled, which suggests it was
>> never really supported on those machines.
>>
>> But maybe someone from NXP can tell me otherwise.
>>
> 
> I think our workloads need CONFIG_PREEMPT=y because our systems have
> switch ASIC drivers implemented in userland and we need to be able to
> react quickly to network events in order to prevent loops. We have seen
> instances of this not happening simply because some other process is in
> the middle of a syscall.
> 
> One thing I am working on here is a setup with a few vendor boards and
> some of our own kit that we can test the upstream kernels on. Hopefully
> that'd make these kinds of reports more timely rather than just
> whenever we decide to move to a new kernel version.
> 
> 


The defconfig also sets CONFIG_DEBUG_PREEMPT. Have you tried without 
CONFIG_DEBUG_PREEMPT ?

Christophe
