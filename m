Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8F722DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jRqX+OjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfHUPsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:48:46 -0400
Received: from mail.efficios.com ([167.114.142.138]:45314 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfHUPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:48:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 784882CAD29;
        Wed, 21 Aug 2019 11:48:44 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id mKb2H5X-fXvj; Wed, 21 Aug 2019 11:48:44 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id ED4C02CAD26;
        Wed, 21 Aug 2019 11:48:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ED4C02CAD26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566402524;
        bh=raMzDsvLp2MJ0A1zw+jKNPt3gxA/18NTfDpige5zLCY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jRqX+OjZQ6VhTLFZHTptD7xsc3YuLNYTya2TMd6WSqBIyN1tKztU7CLM3LSQ0kybQ
         DfDziPTvjxbLtwDQTqxyNwKBYdIh03/Pr6vabmpHkVoigfBJv2YVx7QXickH3JGZjs
         FktrhJ2DWoLRYNnrto5ss/FTRkyIdmROakhtfsm3g681aBTJNvjjLEQvO+t1+D6OTv
         LreQUem9N10M+M/UqZuk1Q0/Oq/zjEY903C76NU9gCNJeHDdKUyhxJNU3azSFFRqYP
         vNU72FQYu0kd1GwtFod/ah2fum0GrQLPj2HWDJAm/Enw14HILvg5gcQ1IA5FHa2MLs
         FPpGeww027mEg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id FFjmIk5DJO4F; Wed, 21 Aug 2019 11:48:43 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D48832CAD1C;
        Wed, 21 Aug 2019 11:48:43 -0400 (EDT)
Date:   Wed, 21 Aug 2019 11:48:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck <paulmck@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Message-ID: <52600272.1909.1566402523680.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190821153325.GD2349@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org> <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com> <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com> <20190820135612.GS2332@hirez.programming.kicks-ass.net> <20190820202932.GW28441@linux.ibm.com> <20190821103200.kpufwtviqhpbuv2n@willie-the-truck> <20190821132310.GC28441@linux.ibm.com> <20190821153325.GD2349@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: vUNKpvAVCmtLIvMwU3k3Nuab82BXLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 21, 2019, at 8:33 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Aug 21, 2019 at 06:23:10AM -0700, Paul E. McKenney wrote:
>> On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:
> 
>> > and so it is using a store-pair instruction to reduce the complexity in
>> > the immediate generation. Thus, the 64-bit store will only have 32-bit
>> > atomicity. In fact, this is scary because if I change bar to:
>> > 
>> > void bar(u64 *x)
>> > {
>> > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
>> > }
>> > 
>> > then I get:
>> > 
>> > bar:
>> > 	mov	w1, 61200
>> > 	movk	w1, 0xabcd, lsl 16
>> > 	str	w1, [x0]
>> > 	str	w1, [x0, 4]
>> > 	ret
>> > 
>> > so I'm not sure that WRITE_ONCE would even help :/
>> 
>> Well, I can have the LWN article cite your email, then.  So thank you
>> very much!
>> 
>> Is generation of this code for a 64-bit volatile store considered a bug?
>> Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
>> would guess that Thomas and Linus would ask a similar bugginess question
>> for normal stores.  ;-)
> 
> I'm calling this a compiler bug; the way I understand volatile this is
> very much against the intentended use case. That is, this is buggy even
> on UP vs signals or MMIO.

And here is a simpler reproducer on my gcc-8.3.0 (aarch64) compiled with O2:

volatile unsigned long a;
 
void fct(void)
{
        a = 0x1234567812345678ULL;
}

void fct(void)
{
        a = 0x1234567812345678ULL;
   0:   90000000        adrp    x0, 8 <fct+0x8>
   4:   528acf01        mov     w1, #0x5678                     // #22136
   8:   72a24681        movk    w1, #0x1234, lsl #16
   c:   f9400000        ldr     x0, [x0]
  10:   b9000001        str     w1, [x0]
  14:   b9000401        str     w1, [x0, #4]
}
  18:   d65f03c0        ret

And the non-volatile case uses stp (is it a single store to memory ?):

unsigned long a;
  
void fct(void)
{
        a = 0x1234567812345678ULL;
}

void fct(void)
{
        a = 0x1234567812345678ULL;
   0:   90000000        adrp    x0, 8 <fct+0x8>
   4:   528acf01        mov     w1, #0x5678                     // #22136
   8:   72a24681        movk    w1, #0x1234, lsl #16
   c:   f9400000        ldr     x0, [x0]
  10:   29000401        stp     w1, w1, [x0]
}
  14:   d65f03c0        ret

It would probably be a good idea to audit other architectures, since this
is done by the compiler backend.

Thanks,

Mathieu








-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
