Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8280420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="saHLzU1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfJIO0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:26:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:34486 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJIO0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:26:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C7D452D4EA5;
        Wed,  9 Oct 2019 10:26:35 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id chzLZUjzv7Br; Wed,  9 Oct 2019 10:26:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4DB2D2D4EA2;
        Wed,  9 Oct 2019 10:26:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4DB2D2D4EA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1570631195;
        bh=zQBCzrowsLT4cBHl8zPuvrIzg3YiTYc8FYnFIPEC0T0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=saHLzU1+G6B5VQquT2kJjnvW9HVBSJbVUCgNIMDO4JuX7ayZde1yRxJ/LrZmKHIxo
         2JVBQHu/JbJRhkuI/DpvWhqJ+DDJ8vyJS9anHJqqRVnhyv/HnXiGexfb4JqQdxK/7A
         GLBo4MBwSiWrXIhbipYhkAsirHgvmDJPHqKoVNJ98vq+cXg0uBrbS3gyJLuf34bB0z
         CdKiCe0e+xEf2abrdc+qFIqexBIdckgy8dUVeXSpF+ogq/wfdcoYqAWfsiXfddbxcS
         wxmllzbW/Nv2k8ylqjAvN9hONM1clvlY/TxcC3AxZ3pb/Kz96dddJ46UCEuspyOPLk
         PK3d7WRfgETxQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id XavpBy5VmdOx; Wed,  9 Oct 2019 10:26:35 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 332572D4E8A;
        Wed,  9 Oct 2019 10:26:35 -0400 (EDT)
Date:   Wed, 9 Oct 2019 10:26:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        rostedt <rostedt@goodmis.org>, bristot <bristot@redhat.com>,
        paulmck <paulmck@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        paulmck <paulmck@kernel.org>
Message-ID: <968659278.8871.1570631195078.JavaMail.zimbra@efficios.com>
In-Reply-To: <20191009130754.GL2311@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org> <20190827181147.053490768@infradead.org> <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org> <20191003082751.GQ4536@hirez.programming.kicks-ass.net> <20191003110106.GI4581@hirez.programming.kicks-ass.net> <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org> <20191009130754.GL2311@hirez.programming.kicks-ass.net>
Subject: Re: x86/kprobes bug? (was: [PATCH 1/3] x86/alternatives: Teach
 text_poke_bp() to emulate instructions)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3869 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3869)
Thread-Topic: x86/kprobes bug? (was: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate instructions)
Thread-Index: LLYvab/Mj0/RNx7p0VNgToLIJ0jjQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ hpa, paulmck

----- On Oct 9, 2019, at 9:07 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Fri, Oct 04, 2019 at 10:45:40PM +0900, Masami Hiramatsu wrote:
> 
>> > > > >  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
>> > > > > -		     op->optinsn.insn);
>> > > > > +		     emulate_buff);
>> > > > >  }
>> > > 
>> > > As argued in a previous thread, text_poke_bp() is broken when it changes
>> > > more than a single instruction at a time.
>> > > 
>> > > Now, ISTR optimized kprobes does something like:
>> > > 
>> > > 	poke INT3
>> > 
>> > Hmm, it does this using text_poke(), but lacks a
>> > on_each_cpu(do_sync_core, NULL, 1), which I suppose is OK-ish IFF you do
>> > that synchronize_rcu_tasks() after it, but less so if you don't.
>> > 
>> > That is, without either, you can't really tell if the kprobe is in
>> > effect or not.
>> 
>> Yes, it doesn't wait the change by design at this moment.
> 
> Right, this might surprise some, I suppose, and I might've found a small
> issue with it, see below.
> 
>> > > 	synchronize_rcu_tasks() /* waits for all tasks to schedule
>> > > 				   guarantees instructions after INT3
>> > > 				   are unused */
>> > > 	install optimized probe /* overwrites multiple instrctions with
>> > > 				   JMP.d32 */
>> > > 
>> > > And the above then undoes that by:
>> > > 
>> > > 	poke INT3 on top of the optimzed probe
>> > > 
>> > > 	poke tail instructions back /* guaranteed safe because the
>> > > 				       above INT3 poke ensures the
>> > > 				       JMP.d32 instruction is unused */
>> > > 
>> > > 	poke head byte back
>> 
>> Yes, anyway, the last poke should recover another INT3... (for kprobe)
> 
> It does indeed.
> 
>> > > Is this correct? If so, we should probably put a comment in there
>> > > explaining how all this is unusual but safe.
> 
> So from what I can tell of kernel/kprobes.c, what it does is something like:
> 
> ARM: (__arm_kprobe)
>	text_poke(INT3)
>	/* guarantees nothing, INT3 will become visible at some point, maybe */
> 
>     (kprobe_optimizer)
>	if (opt) {
>		/* guarantees the bytes after INT3 are unused */
>		syncrhonize_rcu_tasks();
>		text_poke_bp(JMP32);
>		/* implies IPI-sync, kprobe really is enabled */
>	}
> 
> 
> DISARM: (__unregister_kprobe_top)
>	if (opt) {
>		text_poke_bp(INT3 + tail);
>		/* implies IPI-sync, so tail is guaranteed visible */
>	}
>	text_poke(old);
> 
> 
> FREE: (__unregister_kprobe_bottom)
>	/* guarantees 'old' is visible and the kprobe really is unused, maybe */
>	synchronize_rcu();
>	free();
> 
> 
> Now the problem is that I don't think the synchronize_rcu() at free
> implies enough to guarantee 'old' really is visible on all CPUs.
> Similarly, I don't think synchronize_rcu_tasks() is sufficient on the
> ARM side either. It only provides the guarantee -provided- the INT3 is
> actually visible. If it is not, all bets are off.
> 
> I'd feel much better if we switch arch_arm_kprobe() over to using
> text_poke_bp(). Or at the very least add the on_each_cpu(do_sync_core)
> to it.
> 
> Hmm?

Yes, I think you are right on both counts. synchronize_rcu() is not enough
to guarantee that other cores have observed the required core serializing
instructions.

I would also be more comfortable if we ensure core serialization for all
cores after arming the kprobe with text_poke() (before doing the text_poke_bp
to JMP32), and after the text_poke(old) in DISARM (before freeing, and possibly
re-using, the memory).

I think originally it might have been OK to text_poke the INT3 without core serialization
before introducing optimized kprobes, since it would only switch back and forth between
the original instruction { 0xAA, 0xBB, 0xCC, ... } and the breakpoint
{ INT3, 0xBB, 0xCC, ... }. But now that the optimized kprobes are adding
additional states, we end up requiring core serialization in case a core
observes the original instruction and the optimized kprobes jump without
observing the INT3.

The follow up patch you propose at https://lore.kernel.org/lkml/20191009132844.GG2359@hirez.programming.kicks-ass.net/
makes sense.

Now depending on whether we care mostly about speed or robustness in this
code, there is a small tweak we could do. The approach you propose aims for
robustness by issuing a text_poke_sync() after each ARM/DISARM, which
effectively adds IPIs to all cores even in !opt cases. If we aim for speed
in the !opt case, we might want to move the text_poke_sync() within the
if (opt) branches so it only IPIs if the probe happens to be optimized.

In my personal opinion, I would prefer simple and robust over clever and fast
for inserting kprobes, but you guys know more about the performance trade-offs
than I do.

hpa provided very insightful feedback in the original text_poke_bp implementation
thread with respect to those corner-cases, so having his feedback here would
be great.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
