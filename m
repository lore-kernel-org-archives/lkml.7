Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FF8C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D232086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="q7SbwO54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfHQPxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 11:53:43 -0400
Received: from mail.efficios.com ([167.114.142.138]:42870 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfHQPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 11:53:43 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D782524A7A4;
        Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qFI45D6gMud8; Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6793F24A7A1;
        Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6793F24A7A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566057221;
        bh=/T4G7ArHHgji3R5ir6TLD1LxJxJoJoiOBJH2ewhkMMw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=q7SbwO54FNs+aTBLllB8DXCrIiV2XiWrZWYf+70S74/RweQyV51zZ8HZq6Ai7G6Kd
         Dip219dU/Y3MqGHI+ju2/tZrgM1bZwA55oCbCp8DDWjArxswVSpaD+H06Zr5juKs5F
         /Cgrk8g8Ej1F9Ye3lKurG4sJYGxKpxqCwqDd7uNYOL5rzYeUedBeAljuCoolK7D9wy
         huNJnsnfLVENnfHvllH0Rw9xIEbqHQIIlpAoBRK1637eJRov8L2iTSlsXqygCwYqNH
         gAE7IF0e04ryU02rwbIM0lI6H2LGQsPlX9SGRdbOSpM8Cg4pve6oM/KJccPoMtfeRG
         Z+EKvwOKqEy3Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ZGW5WvScQiJO; Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 476C724A798;
        Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
Date:   Sat, 17 Aug 2019 11:53:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1982627598.23941.1566057221039.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190817114218.5cb3912b@oasis.local.home>
References: <00000000000076ecf3059030d3f1@google.com> <20190816142643.13758-1-mathieu.desnoyers@efficios.com> <20190816122539.34fada7b@oasis.local.home> <623129606.21592.1565975960497.JavaMail.zimbra@efficios.com> <20190816151541.6864ff30@oasis.local.home> <621310481.23873.1566052059389.JavaMail.zimbra@efficios.com> <20190817114218.5cb3912b@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: 7b3EKW1sq4uZwDDqdE+eSHoaFJdxSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 17, 2019, at 11:42 AM, rostedt rostedt@goodmis.org wrote:

> On Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I get your point wrt WRITE_ONCE(): since it's a cache it should not have
>> user-visible effects if a temporary incorrect value is observed. Well in
>> reality, it's not a cache: if the lookup fails, it returns "<...>" instead,
>> so cache lookup failure ends up not providing any useful data in the trace.
>> Let's assume this is a known and documented tracer limitation.
> 
> Note, this is done at every sched switch, for both next and prev tasks.
> And the update is only done at the enabling of a tracepoint (very rare
> occurrence) If it missed it scheduling in, it has a really good chance
> of getting it while scheduling out.
> 
> And 99.999% of my tracing that I do, the tasks scheduling in when
> enabling a tracepoint is not what I even care about, as I enable
> tracing then start what I want to trace.

Since it's refcount based, my concern is about the side-effect of
incrementing or decrementing that reference count without WRITE_ONCE
which would lead to a transient corrupted value observed by _another_
active tracing user.

For you use-case, it would lead to a missing comm when you are actively
tracing what you want to trace, caused by another user of that refcount
incrementing or decrementing it.

I agree with you that missing tracing data at the beginning or end of a
trace is not important.

>> 
>> However, wrt READ_ONCE(), things are different. The variable read ends up
>> being used to control various branches in the code, and the compiler could
>> decide to re-fetch the variable (with a different state), and therefore
>> cause _some_ of the branches to be inconsistent. See
>> tracing_record_taskinfo_sched_switch() and tracing_record_taskinfo() @flags
>> parameter.
> 
> I'm more OK with using a READ_ONCE() on the flags so it is consistent.
> But the WRITE_ONCE() is going a bit overboard.

Hence my request for additional guidance on the usefulness of WRITE_ONCE(),
whether it's mainly there for documentation purposes, or if we should consider
that it takes care of real-life problems introduced by compiler optimizations
in the wild. The LWN article seems to imply that it's not just a theoretical
issue, but I'll have to let the article authors justify their conclusions,
because I have limited time to investigate this myself.

> 
>> 
>> AFAIU the current code should not generate any out-of-bound writes in case of
>> re-fetch, but no comment in there documents how fragile this is.
> 
> Which part of the code are you talking about here?

kernel/trace/trace.c:tracing_record_taskinfo_sched_switch()
kernel/trace/trace.c:tracing_record_taskinfo()

where @flags is used to control a few branches. I don't think any of those
would end up causing corruption if the flags is re-fetched between two
branches, but it seems rather fragile.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
