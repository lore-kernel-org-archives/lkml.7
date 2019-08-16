Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F232AC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B0520665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="N5lmhQtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfHPRTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:19:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:47166 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfHPRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:19:23 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3B78C2C7C6A;
        Fri, 16 Aug 2019 13:19:21 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iH71h6vOPbHe; Fri, 16 Aug 2019 13:19:20 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AE9712C7C67;
        Fri, 16 Aug 2019 13:19:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AE9712C7C67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1565975960;
        bh=dRZCtGUc8ff7Esnd76s/+zUaN9nyUrbF04PoA9avWvw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=N5lmhQtTZfnuhhXfVlDx0Jg8U+tdR5e+SZy0opYlA2OvbYqX/n3XMTJLOEM3RECs3
         vv5mYF3TgRrLxF/7Tj7rwSuaBhkGAVrR+YcRZETkbxfSONJC4HTk3rVmiLbqeT8C2K
         YGuitjfgrCc2CmGAQpxuMa0Ocj7TFyBe4IjafzlUa3y4FgPqSSdzIGFTouxyIb64rs
         ftD5+T43Bx8OCN2+OejzJH1yTBk4s6dypDLxYo4Zfb37MRskWazOSCoQ5r292qaEHL
         fmEwLxz+xtlCaakx/gmKzGQH3Oqb8I3zARprigXVzFsXshA3XhPci43Anc0EnaUQNh
         pxk2XlMdc5v1A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id E_bCK1LglO3i; Fri, 16 Aug 2019 13:19:20 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8D8782C7C5A;
        Fri, 16 Aug 2019 13:19:20 -0400 (EDT)
Date:   Fri, 16 Aug 2019 13:19:20 -0400 (EDT)
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
Message-ID: <623129606.21592.1565975960497.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190816122539.34fada7b@oasis.local.home>
References: <00000000000076ecf3059030d3f1@google.com> <20190816142643.13758-1-mathieu.desnoyers@efficios.com> <20190816122539.34fada7b@oasis.local.home>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: trace sched switch start/stop racy updates
Thread-Index: kTJxyZcfLyXWEp0VL5hmLbeCgzEhtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2019, at 12:25 PM, rostedt rostedt@goodmis.org wrote:

> On Fri, 16 Aug 2019 10:26:43 -0400 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
[...]
>> 
>> Also, write and read to/from those variables should be done with
>> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
>> probes without holding the sched_register_mutex.
>> 
> 
> I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
> It's done while holding the mutex. It's not that critical of a path,
> and makes the code look ugly.

The update is done while holding the mutex, but the read-side does not
hold that mutex, so it can observe the intermediate state caused by
store-tearing or invented stores which can be generated by the compiler
on the update-side.

Please refer to the following LWN article:

https://lwn.net/Articles/793253/

Sections:
- "Store tearing"
- "Invented stores"

Arguably, based on that article, store tearing is only observed in the
wild for constants (which is not the case here), and invented stores
seem to require specific code patterns. But I wonder why we would ever want to
pair a fragile non-volatile store with a READ_ONCE() ? Considering the pain
associated to reproduce and hunt down this kind of issue in the wild, I would
be tempted to enforce that any READ_ONCE() operating on a variable would either
need to be paired with WRITE_ONCE() or with atomic operations, so those can
eventually be validated by static code checkers and code sanitizers.

If coding style is your only concern here, we may want to consider
introducing new macros in compiler.h:

WRITE_ONCE_INC(v) /* v++ */
WRITE_ONCE_DEC(v) /* v-- */
WRITE_ONCE_ADD(v, count) /* v += count */
WRITE_ONCE_SUB(v, count) /* v -= count */

Thanks,

Mathieu

> 
> -- Steve
> 
> 
> 
>> [ Compile-tested only. I suspect it might fix the following syzbot
>>   report:
>> 
>>   syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com ]
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Joel Fernandes (Google) <joel@joelfernandes.org>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Paul E. McKenney <paulmck@linux.ibm.com>
>> ---
>>  kernel/trace/trace_sched_switch.c | 32 ++++++++++++++++++++++----------
>>  1 file changed, 22 insertions(+), 10 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_sched_switch.c
>> b/kernel/trace/trace_sched_switch.c
>> index e288168661e1..902e8bf59aeb 100644
>> --- a/kernel/trace/trace_sched_switch.c
>> +++ b/kernel/trace/trace_sched_switch.c
>> @@ -26,8 +26,8 @@ probe_sched_switch(void *ignore, bool preempt,
>>  {
>>  	int flags;
>>  
>> -	flags = (RECORD_TGID * !!sched_tgid_ref) +
>> -		(RECORD_CMDLINE * !!sched_cmdline_ref);
>> +	flags = (RECORD_TGID * !!READ_ONCE(sched_tgid_ref)) +
>> +		(RECORD_CMDLINE * !!READ_ONCE(sched_cmdline_ref));
>>  
>>  	if (!flags)
>>  		return;
>> @@ -39,8 +39,8 @@ probe_sched_wakeup(void *ignore, struct task_struct *wakee)
>>  {
>>  	int flags;
>>  
>> -	flags = (RECORD_TGID * !!sched_tgid_ref) +
>> -		(RECORD_CMDLINE * !!sched_cmdline_ref);
>> +	flags = (RECORD_TGID * !!READ_ONCE(sched_tgid_ref)) +
>> +		(RECORD_CMDLINE * !!READ_ONCE(sched_cmdline_ref));
>>  
>>  	if (!flags)
>>  		return;
>> @@ -89,21 +89,28 @@ static void tracing_sched_unregister(void)
>>  
>>  static void tracing_start_sched_switch(int ops)
>>  {
>> -	bool sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
>> +	bool sched_register;
>> +
>>  	mutex_lock(&sched_register_mutex);
>> +	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
>>  
>>  	switch (ops) {
>>  	case RECORD_CMDLINE:
>> -		sched_cmdline_ref++;
>> +		WRITE_ONCE(sched_cmdline_ref, sched_cmdline_ref + 1);
>>  		break;
>>  
>>  	case RECORD_TGID:
>> -		sched_tgid_ref++;
>> +		WRITE_ONCE(sched_tgid_ref, sched_tgid_ref + 1);
>>  		break;
>> +
>> +	default:
>> +		WARN_ONCE(1, "Unsupported tracing op: %d", ops);
>> +		goto end;
>>  	}
>>  
>> -	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
>> +	if (sched_register)
>>  		tracing_sched_register();
>> +end:
>>  	mutex_unlock(&sched_register_mutex);
>>  }
>>  
>> @@ -113,16 +120,21 @@ static void tracing_stop_sched_switch(int ops)
>>  
>>  	switch (ops) {
>>  	case RECORD_CMDLINE:
>> -		sched_cmdline_ref--;
>> +		WRITE_ONCE(sched_cmdline_ref, sched_cmdline_ref - 1);
>>  		break;
>>  
>>  	case RECORD_TGID:
>> -		sched_tgid_ref--;
>> +		WRITE_ONCE(sched_tgid_ref, sched_tgid_ref - 1);
>>  		break;
>> +
>> +	default:
>> +		WARN_ONCE(1, "Unsupported tracing op: %d", ops);
>> +		goto end;
>>  	}
>>  
>>  	if (!sched_cmdline_ref && !sched_tgid_ref)
>>  		tracing_sched_unregister();
>> +end:
>>  	mutex_unlock(&sched_register_mutex);
>>  }

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
