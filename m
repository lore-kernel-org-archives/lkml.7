Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B70C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222F920880
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jQua3D83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQO1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 10:27:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:49058 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfHQO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 10:27:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3FE75248D6E;
        Sat, 17 Aug 2019 10:27:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 14AgsATZ_lSe; Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BC5F8248D68;
        Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BC5F8248D68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1566052059;
        bh=8PAadQmTbfoT1oF0WNim+VJLgVgIahTwrBprtlAyTH8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jQua3D83eIjTVGJK3lHlb2a3kGPbLMISP1rvIizncZlYVB9tflcnvIMbtnO66rlFk
         TmZuTMssXSsGYhHK8h8G+hxXzxUhXiI7ZSxm4tRkGp5WyqOkfNKrLa0O9YDdQ1A+j9
         p0k7qg5UEilhMGmJ1KJN95b+M7sgVoJcg6CqcjNKb63BIuLRKQh09fvKTAtV81RVJg
         0Si+vKHXqEpqtscTna2nSWFspaRluN4DmZEbSjsOpU7fb4pkf8GfoWv4EHno7d7WTf
         9LfQlDDSUXwHgAIelWMb/jeGUnCJG/GNW7wOlN7ktscH/UZNn9dy/hWi0xW7rClM5S
         EjOslq44DhVFA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id vxT2syFBLlA4; Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A231C248D5A;
        Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
Date:   Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
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
Message-ID: <621310481.23873.1566052059389.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190816151541.6864ff30@oasis.local.home>
References: <00000000000076ecf3059030d3f1@google.com> <20190816142643.13758-1-mathieu.desnoyers@efficios.com> <20190816122539.34fada7b@oasis.local.home> <623129606.21592.1565975960497.JavaMail.zimbra@efficios.com> <20190816151541.6864ff30@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: 2iKNHxIOjPEV7wrhVk3stR4l3NWvdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 3:15 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 16 Aug 2019 13:19:20 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Aug 16, 2019, at 12:25 PM, rostedt rostedt@goodmis.org wrote:
>> 
>> > On Fri, 16 Aug 2019 10:26:43 -0400 Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> [...]
>> >> 
>> >> Also, write and read to/from those variables should be done with
>> >> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
>> >> probes without holding the sched_register_mutex.
>> >>   
>> > 
>> > I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
>> > It's done while holding the mutex. It's not that critical of a path,
>> > and makes the code look ugly.
>> 
>> The update is done while holding the mutex, but the read-side does not
>> hold that mutex, so it can observe the intermediate state caused by
>> store-tearing or invented stores which can be generated by the compiler
>> on the update-side.
>> 
>> Please refer to the following LWN article:
>> 
>> https://lwn.net/Articles/793253/
>> 
>> Sections:
>> - "Store tearing"
>> - "Invented stores"
>> 
>> Arguably, based on that article, store tearing is only observed in the
>> wild for constants (which is not the case here), and invented stores
>> seem to require specific code patterns. But I wonder why we would ever want to
>> pair a fragile non-volatile store with a READ_ONCE() ? Considering the pain
>> associated to reproduce and hunt down this kind of issue in the wild, I would
>> be tempted to enforce that any READ_ONCE() operating on a variable would either
>> need to be paired with WRITE_ONCE() or with atomic operations, so those can
>> eventually be validated by static code checkers and code sanitizers.
> 
> My issue is that this is just a case to decide if we should cache a
> comm or not. It's a helper, nothing more. There's no guarantee that
> something will get cached.

I get your point wrt WRITE_ONCE(): since it's a cache it should not have
user-visible effects if a temporary incorrect value is observed. Well in
reality, it's not a cache: if the lookup fails, it returns "<...>" instead,
so cache lookup failure ends up not providing any useful data in the trace.
Let's assume this is a known and documented tracer limitation.

However, wrt READ_ONCE(), things are different. The variable read ends up
being used to control various branches in the code, and the compiler could
decide to re-fetch the variable (with a different state), and therefore
cause _some_ of the branches to be inconsistent. See
tracing_record_taskinfo_sched_switch() and tracing_record_taskinfo() @flags
parameter.

AFAIU the current code should not generate any out-of-bound writes in case of
re-fetch, but no comment in there documents how fragile this is.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
