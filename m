Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A38C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D4E21744
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WLei9OxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfHQOke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 10:40:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:52070 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfHQOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 10:40:34 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 95A0F2491AA;
        Sat, 17 Aug 2019 10:40:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qZRjFV6RaMAL; Sat, 17 Aug 2019 10:40:32 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 10CB22491A7;
        Sat, 17 Aug 2019 10:40:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 10CB22491A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566052832;
        bh=TS1G13kmsRjwoIQIvNEkJwY6UcVySKZ/KVCaVxTKf7o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WLei9OxX8V40Z63djdvNxGoVnM2y1Oh/kfOoZWt5oxuZlvBvhjsgXi3nij8l8+6/W
         Q1f1+kbFoB9AFndFL6FX3B44hLDs209f4kVVBEEoYaLCvDaquRUF8crruc7o/l/s6l
         3+awudF9ECn4GoAeDfGuRpOgmv5ELIXc3LdOm/OsctLsloHLxzaYLk3dcY99ORZPHK
         FwjkQTKVA2VufM98GBJG2pTeTwCssq91S7R3Iy3uwfcZQ0bfm2diIq7MCVBtkcdkOx
         POR090UFEWYqB0O9wlaqvLWZ5+u4TsiRsY5fDjq1kDQ/MbVOzhOWHe3bIUf6fB5Czg
         aZMPUt0XPH9OQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id SrRfkm7al2kj; Sat, 17 Aug 2019 10:40:31 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E95CC24919E;
        Sat, 17 Aug 2019 10:40:31 -0400 (EDT)
Date:   Sat, 17 Aug 2019 10:40:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Message-ID: <39888715.23900.1566052831673.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190816221313.4b05b876@oasis.local.home>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com> <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org> <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com> <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de> <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com> <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com> <20190816221313.4b05b876@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: WhYqs3l189QO/lMCG4WoQNYcI4NN8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 10:13 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 16 Aug 2019 21:36:49 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Aug 16, 2019, at 5:04 PM, Linus Torvalds torvalds@linux-foundation.org
>> wrote:
>> 
>> > On Fri, Aug 16, 2019 at 1:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >>
>> >> Can we finally put a foot down and tell compiler and standard committee
>> >> people to stop this insanity?
>> > 
>> > It's already effectively done.
>> > 
>> > Yes, values can be read from memory multiple times if they need
>> > reloading. So "READ_ONCE()" when the value can change is a damn good
>> > idea.
>> > 
>> > But it should only be used if the value *can* change. Inside a locked
>> > region it is actively pointless and misleading.
>> > 
>> > Similarly, WRITE_ONCE() should only be used if you have a _reason_ for
>> > using it (notably if you're not holding a lock).
>> > 
>> > If people use READ_ONCE/WRITE_ONCE when there are locks that prevent
>> > the values from changing, they are only making the code illegible.
>> > Don't do it.
>> 
>> I agree with your argument in the case where both read-side and write-side
>> are protected by the same lock: READ/WRITE_ONCE are useless then. However,
>> in the scenario we have here, only the write-side is protected by the lock
>> against concurrent updates, but reads don't take any lock.
> 
> And because reads are not protected by any lock or memory barrier,
> using READ_ONCE() is pointless. The CPU could be doing a lot of hidden
> manipulation of that variable too.

Please enlighten me by providing some details on what the CPU could do to
this word-aligned, word-sized variable in the absence of lock and barrier
that is relevant to this specific use-case ?

I suspect most of the barriers you refer to here are taken care of by the
tracepoint code which uses RCU to synchronize probe registration wrt
probe callback execution.

> 
> Again, this is just to enable caching of the comm. Nothing more. It's a
> "best effort" algorithm. We get it, we then can map a pid to a name. If
> not, we just have a pid and we map "<...>".
> 
> Next you'll be asking for the memory barriers to guarantee a real hit.
> And honestly, this information is not worth any overhead.

No, that's not my intent to add overhead to guarantee trace data
availability near trace beginning and end. However, considering that
READ_ONCE() and WRITE_ONCE() can provide additional data availability
guarantees in the middle of traces at no runtime cost, it seems like a
good trade off.

It's easier for an analysis to disregard missing information at the
beginning and end of trace without generating false-positive reports
than when it happens spuriously in the middle of traces.

> 
> And most often we enable this before we enable the tracepoint we want
> this information from, which requires modification of the text area and
> will do a bunch of syncs across CPUs. That alone will most likely keep
> any race from happening.

Indeed the tracepoint use of RCU to synchronize registration vs probes
should take care of those barriers.

> 
> The only real bug is the check to know if we should add the probe or
> not was done outside the lock, and when we hit the race, we could add a
> probe twice, causing the kernel to spit out a warning. You fixed that,
> and that's all that needs to be done.

I just sent that fix in a separate patch.

> I'm now even more against adding the READ_ONCE() or WRITE_ONCE().

I'm not convinced by your arguments.

Thanks,

Mathieu

> 
> 
> -- Steve
> 
> 
> 
>> 
>> If WRITE_ONCE has any use at all (protecting against store tearing and
>> invented stores), it should be used even with a lock held in this
>> scenario, because the lock does not prevent READ_ONCE() from observing
>> transient states caused by lack of WRITE_ONCE() for the update.
>> 
>> So why does WRITE_ONCE exist in the first place ? Is it for documentation
>> purposes only or are there actual situations where omitting it can cause
>> bugs with real-life compilers ?
>> 
>> In terms of code change, should we favor only introducing WRITE_ONCE
>> in new code, or should existing code matching those conditions be
>> moved to WRITE_ONCE as bug fixes ?
>> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
