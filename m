Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26519CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4BE20679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 09:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YTLpRmAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfJ0JV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 05:21:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8025 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfJ0JV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 05:21:28 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 471C5c0KBSz9vC0b;
        Sun, 27 Oct 2019 10:21:24 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YTLpRmAB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NhDefIqlusly; Sun, 27 Oct 2019 10:21:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 471C5b6BLqz9vC0Z;
        Sun, 27 Oct 2019 10:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572168083; bh=5hjHvfXSMkcgXBmkACPGCMxpghIDPNJ8CFc7b3vEb8c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YTLpRmAByL4MjS715uXHks+1TNjjNQI4ISm64uPIsrvheYndqpxyNo3StEgFCSovP
         Pk0iFqQrOCEyhZyayeeN3LoJzRrLwSZIDHxrzaKcnxfDEtXWNPytsanojbyrvLOgGv
         abYiyFb9QH1nrR8N0IQeh5t88CTrMQrO62GgGRV8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C567F8B923;
        Sun, 27 Oct 2019 10:21:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bdT3vZYeqZTv; Sun, 27 Oct 2019 10:21:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C7798B922;
        Sun, 27 Oct 2019 10:21:26 +0100 (CET)
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        luto@kernel.org, vincenzo.frascino@arm.com,
        linuxppc-dev@lists.ozlabs.org
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
 <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
 <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr>
 <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
 <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de>
 <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr>
 <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de>
 <20191026230609.GY28442@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8e4d0b82-a7a1-b7f1-308e-df871b32d317@c-s.fr>
Date:   Sun, 27 Oct 2019 10:21:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191026230609.GY28442@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/10/2019 à 01:06, Segher Boessenkool a écrit :
> On Sat, Oct 26, 2019 at 08:48:27PM +0200, Thomas Gleixner wrote:
>> On Sat, 26 Oct 2019, Christophe Leroy wrote:
>> Let's look at the code:
>>
>> __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
>> {
>>          const struct vdso_data *vd = __arch_get_vdso_data();
>>
>>          if (likely(tv != NULL)) {
>> 		struct __kernel_timespec ts;
>>
>>                  if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
>>                          return gettimeofday_fallback(tv, tz);
>>
>>                  tv->tv_sec = ts.tv_sec;
>>                  tv->tv_usec = (u32)ts.tv_nsec / NSEC_PER_USEC;
>>
>> IIRC PPC did some magic math tricks to avoid that. Could you just for the
>> fun of it replace this division with
>>
>>         (u32)ts.tv_nsec >> 10;
> 
> On this particular CPU (the 885, right?) a division by 1000 is just 9
> cycles.  On other CPUs it can be more, say 19 cycles like on the 750; not
> cheap at all, but not hugely expensive either, comparatively.
> 
> (A 64/32->32 division is expensive on all 32-bit PowerPC: there is no
> hardware help for it at all, so it's all done in software.)
> 
> Of course the compiler won't do a division by a constant with a division
> instruction at all, so it's somewhat cheaper even, 5 or 6 cycles or so.
> 
>> One thing which might be worth to try as well is to mark all functions in
>> that file as inline. The speedup by the do_hres() inlining was impressive
>> on PPC.
> 
> The hand-optimised asm code will pretty likely win handsomely, whatever
> you do.  Especially on cores like the 885 (no branch prediction, single
> issue, small caches, etc.: every instruction counts).
> 
> Is there any reason to replace this hand-optimised code?  It was written
> for exacty this reason?  These functions are critical and should be as
> fast as possible.

Well, all this started with COARSE clocks not being supported by PPC32 
VDSO. I first submitted a series with a set of optimisations including 
the implementation of COARSE clocks 
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=126779)

Then after a comment received on patch 4 of the series from Santosh 
Sivaraj asking for a common implementation of it for PPC32 and PPC64, I 
started looking into making the whole VDSO source code common to PPC32 
and PPC64. Most functions are similar. Time functions are also rather 
similar but unfortunately don't use the same registers. They also don't 
cover all possible clocks. And getres() is also buggy, see series 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=110321

So instead of reworking the existing time functions, I started 
investigating whether we could plug powerpc to the generic 
implementation. One drawback of PPC is that we need to setup an ASM 
trampoline to handle the SO bit as it can't be handled from C directly, 
can it ?

How critical are these functions ? Although we have a slight degration 
with the C implementation, they are still way faster than the 
corresponding syscall.

Another thing I was wondering, is it worth using the 64 bit timebase on 
PPC32 ? As far as I understand, the timebase is there to calculate a 
linear date update since last VDSO datapage update. How often is the 
VDSO datapage updated ? On the 885 clocked at 132Mhz, the timebase is at 
8.25 Mhz, which means it needs more than 8 minutes to loop over 32 bits.

Christophe
