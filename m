Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C5FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A122720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="denaVW6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfHSFk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:40:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47850 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHSFk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:40:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46BjT12gM4z9txRw;
        Mon, 19 Aug 2019 07:40:53 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=denaVW6w; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0hzF2hOGeWtK; Mon, 19 Aug 2019 07:40:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46BjT11ZJdz9txRv;
        Mon, 19 Aug 2019 07:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566193253; bh=slCIs1ABIzIVXZpwN19CyhQdc00di8vdt1eulyooFrU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=denaVW6wEh0EnnNoMhBYxRB+4Tbl1rFqoVmwq6lLxJQC/ezVanpfP9iNq5ywveCx0
         BS9e24PC3BSxw9NaD5h2Pkl/QaPXR4rYWUOI8RJA/SzPPW8sJOgzy3dMAH+zu/OOKs
         OkDyAtNwICEV1cIhQV9GPNGd3wU4ip0M4SQ84a9E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 184A08B77F;
        Mon, 19 Aug 2019 07:40:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 82Bdaw2RJIVW; Mon, 19 Aug 2019 07:40:58 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE7A58B74F;
        Mon, 19 Aug 2019 07:40:57 +0200 (CEST)
Subject: Re: [PATCH] powerpc: optimise WARN_ON()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190817090442.C5FEF106613@localhost.localdomain>
 <20190818120135.GV31406@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f1c0d9d9-d978-794f-82ce-494d2e52d743@c-s.fr>
Date:   Mon, 19 Aug 2019 07:40:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818120135.GV31406@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/08/2019 à 14:01, Segher Boessenkool a écrit :
> On Sat, Aug 17, 2019 at 09:04:42AM +0000, Christophe Leroy wrote:
>> Unlike BUG_ON(x), WARN_ON(x) uses !!(x) as the trigger
>> of the t(d/w)nei instruction instead of using directly the
>> value of x.
>>
>> This leads to GCC adding unnecessary pair of addic/subfe.
> 
> And it has to, it is passed as an "r" to an asm, GCC has to put the "!!"
> value into a register.
> 
>> By using (x) instead of !!(x) like BUG_ON() does, the additional
>> instructions go away:
> 
> But is it correct?  What happens if you pass an int to WARN_ON, on a
> 64-bit kernel?

On a 64-bit kernel, an int is still in a 64-bit register, so there would 
be no problem with tdnei, would it ? an int 0 is the same as an long 0, 
right ?

It is on 32-bit kernel that I see a problem, if one passes a long long 
to WARN_ON(), the forced cast to long will just drop the upper size of 
it. So as of today, BUG_ON() is buggy for that.

> 
> (You might want to have 64-bit generate either tw or td.  But, with
> your __builtin_trap patch, all that will be automatic).
> 

Yes I'll discard this patch and focus on the __builtin_trap() one which 
should solve most issues.

Christophe
