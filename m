Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFFAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745B82086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HRz2dE0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403922AbfJCQbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:31:52 -0400
Received: from mail.efficios.com ([167.114.142.138]:40570 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbfJCQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:31:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0E47B33ACF0;
        Thu,  3 Oct 2019 12:31:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZMVYT95oWAXT; Thu,  3 Oct 2019 12:31:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 84E1733ACED;
        Thu,  3 Oct 2019 12:31:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 84E1733ACED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1570120298;
        bh=Xa4tdzxQuYNj6KgrYhA4aLJ8ZuVzRaG5b/3vwfcSUKY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HRz2dE0k19vaOBDAn9NaI8MfJQ8pY9RF4PTVC0Xlwep0nYLWyNHK+05Ai1OXf0VXG
         T6E84w097FHLOUm8iPHe57pX8N8ziTZmZVlLQIMk/89aaVHBxIauDQtVPJMN32vrnG
         bh5gIT4Uh2ARfLkGH1BB7nBq/u3pSN9j6LPr4AXnzPI/Ow5WGtnRrrz0i6mw91dfhx
         L3o5WtRhJNkGZSkalrE27yydwfyShXQlC6+6JfD/uXinC3LnaHytIYEt4oxxmSqjh1
         U01Pu9I7Ex8pyxwoDBDM6S7CResfW/fzBn58MPRSdnss2s0WTyJpkHjrRDSt1YtZYt
         ZLq5hKlLD6Sqg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 9g9rzWrEvl57; Thu,  3 Oct 2019 12:31:38 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 611F333ACD2;
        Thu,  3 Oct 2019 12:31:38 -0400 (EDT)
Date:   Thu, 3 Oct 2019 12:31:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     David Howells <dhowells@redhat.com>, paulmck@kernel.org,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Message-ID: <561448323.948.1570120298211.JavaMail.zimbra@efficios.com>
In-Reply-To: <20191003090850.1e2561b3@gandalf.local.home>
References: <20191003014310.13262-1-paulmck@kernel.org> <20191003014153.GA13156@paulmck-ThinkPad-P72> <25408.1570091957@warthog.procyon.org.uk> <20191003090850.1e2561b3@gandalf.local.home>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: Upgrade rcu_swap_protected() to rcu_replace()
Thread-Index: V+Isuv29ciiT7lw1a+SgtJRKwn+KMg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 3, 2019, at 9:08 AM, rostedt rostedt@goodmis.org wrote:

> On Thu, 03 Oct 2019 09:39:17 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
>> paulmck@kernel.org wrote:
>> 
>> > +#define rcu_replace(rcu_ptr, ptr, c)					\
>> > +({									\
>> > +	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
>> > +	rcu_assign_pointer((rcu_ptr), (ptr));				\
>> > +	__tmp;								\
>> > +})
>> 
>> Does it make sense to actually use xchg() if that's supported by the arch?
>> 
> 
> Hmm, is there really any arch that doesn't support xchg()? It would be
> very hard to do any kind of atomic operations without it.
> 
> cmpxchg() is the one that I understand is optional by the arch.

I remember going through all kernel arch headers myself and introduce
irq-off-based xchg and cmpxchg generic implementations for all UP
architectures lacking cmpxchg/xchg instructions.

We might want to consider simply using xchg() here.

FWIW, the API exposed by the Userspace RCU project (liburcu) for this
is:

  rcu_xchg_pointer()

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
