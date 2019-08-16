Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683AC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DE205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="m1Np0DLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHPRmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:42:03 -0400
Received: from mail.efficios.com ([167.114.142.138]:52614 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:42:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B21A22C7427;
        Fri, 16 Aug 2019 13:42:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Kdg3i7hBaWqV; Fri, 16 Aug 2019 13:42:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 235012C741F;
        Fri, 16 Aug 2019 13:42:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 235012C741F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1565977320;
        bh=j/iWpJC7S2VTPE4TQ/7wBReGyb0P4Sv1rymnA4u2WTs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=m1Np0DLyMdwFFVexRh7mu3VN3GrvXx/9SfeyH1JzeVm+G57bXooAFfIS43FN58inQ
         2crWB3W60dPjlmznACIlDzaOjQlKIMEG7be2v8yepgdkmBY7wB0vsiIM13DVskK63d
         swUaLc2qUGu0lEQ5n4jgyNOUFzMR+GBhCXwAuzuM6yoBfJhusQBai+43JfpovM0QUz
         fHWo27uydZwQVxAIcajRH+hCO0ycJkpVlM/duVDtnX0sSgv3slKwz8FQP7jef0Vcyf
         BHU1JSpvUbguUqXNKxfQNzYPgdwt9TbpHhN8GQ20Jo6CRP7ItGyoFklgE18zAL9Qux
         m8BUHQC7Wp/7w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dKBcm3YeFfeT; Fri, 16 Aug 2019 13:42:00 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 088382C740F;
        Fri, 16 Aug 2019 13:42:00 -0400 (EDT)
Date:   Fri, 16 Aug 2019 13:41:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190816130440.07cc0a30@oasis.local.home>
References: <00000000000076ecf3059030d3f1@google.com> <20190816142643.13758-1-mathieu.desnoyers@efficios.com> <20190816122539.34fada7b@oasis.local.home> <28afb801-6b76-f86b-9e1b-09488fb7c8ce@arm.com> <20190816130440.07cc0a30@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: tCTIhLRfwsNJzC/XdZY3OMmGz0773Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 1:04 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 16 Aug 2019 17:48:59 +0100
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
>> On 16/08/2019 17:25, Steven Rostedt wrote:
>> >> Also, write and read to/from those variables should be done with
>> >> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
>> >> probes without holding the sched_register_mutex.
>> >>  
>> > 
>> > I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
>> > It's done while holding the mutex. It's not that critical of a path,
>> > and makes the code look ugly.
>> >   
>> 
>> I seem to recall something like locking primitives don't protect you from
>> store tearing / invented stores, so if you can have concurrent readers
>> using READ_ONCE(), there should be a WRITE_ONCE() on the writer side, even
>> if it's done in a critical section.
> 
> But for this, it really doesn't matter. The READ_ONCE() is for going
> from 0->1 or 1->0 any other change is the same as 1.

Let's consider this "invented store" scenario (even though as I noted in my
earlier email, I suspect this particular instance of the code does not appear
to fit the requirements to generate this in the wild with current compilers):

intial state:

sched_tgid_ref = 10;

Thread A                                Thread B

registration                            tracepoint probe
sched_tgid_ref++
  - compiler decides to invent a
    store: sched_tgid_ref = 0
                                        READ_ONCE(sched_tgid_ref) -> observes 0,
                                        but should really see either 10 or 11.
  - compiler stores 11 into
    sched_tgid_ref

This kind of scenario could cause spurious missing data in the middle of a
trace caused by another user trying to increment the reference count, which
is really unexpected.

A similar scenario can happen for "store tearing" if the compiler decides
to break the store into many stores close to the 16-bit overflow value when
updating a 32-bit reference count. Spurious 1 -> 0 -> 1 transitions could be
observed by readers.

> When we enable trace events, we start recording the tasks comms such
> that we can possibly map them to the pids. When we disable trace
> events, we stop recording the comms so that we don't overwrite the
> cache when not needed. Note, if more than the max cache of tasks are
> recorded during a session, we are likely to miss comms anyway.
> 
> Thinking about this more, the READ_ONCE() and WRTIE_ONCE() are not even
> needed, because this is just a best effort anyway.

If you choose not to use READ_ONCE(), then the "load tearing" issue can
cause similar spurious 1 -> 0 -> 1 transitions near 16-bit counter
overflow as described above. The "Invented load" also becomes an issue,
because the compiler could use the loaded value for a branch, and re-load
that value between two branches which are expected to use the same value,
effectively generating a corrupted state.

I think we need a statement about whether READ_ONCE/WRITE_ONCE should
be used in this kind of situation, or if we are fine dealing with the
awkward compiler side-effects when they will occur.

Thanks,

Mathieu

> 
> The only real fix was to move the check into the mutex protect area,
> because that can cause a real bug if there was a race.
> 
> {
> -	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
> +	bool sched_register;
> +
> 	mutex_lock(&sched_register_mutex);
> +	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
> 
> Thus, I'd like to see a v2 of this patch without the READ_ONCE() or
> WRITE_ONCE() added.
> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
