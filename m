Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD5C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A312189E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfHQPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 11:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfHQPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 11:42:32 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9FF2189D;
        Sat, 17 Aug 2019 15:42:31 +0000 (UTC)
Date:   Sat, 17 Aug 2019 11:42:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190817114218.5cb3912b@oasis.local.home>
In-Reply-To: <621310481.23873.1566052059389.JavaMail.zimbra@efficios.com>
References: <00000000000076ecf3059030d3f1@google.com>
        <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
        <20190816122539.34fada7b@oasis.local.home>
        <623129606.21592.1565975960497.JavaMail.zimbra@efficios.com>
        <20190816151541.6864ff30@oasis.local.home>
        <621310481.23873.1566052059389.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2019 10:27:39 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I get your point wrt WRITE_ONCE(): since it's a cache it should not have
> user-visible effects if a temporary incorrect value is observed. Well in
> reality, it's not a cache: if the lookup fails, it returns "<...>" instead,
> so cache lookup failure ends up not providing any useful data in the trace.
> Let's assume this is a known and documented tracer limitation.

Note, this is done at every sched switch, for both next and prev tasks.
And the update is only done at the enabling of a tracepoint (very rare
occurrence) If it missed it scheduling in, it has a really good chance
of getting it while scheduling out.

And 99.999% of my tracing that I do, the tasks scheduling in when
enabling a tracepoint is not what I even care about, as I enable
tracing then start what I want to trace.


> 
> However, wrt READ_ONCE(), things are different. The variable read ends up
> being used to control various branches in the code, and the compiler could
> decide to re-fetch the variable (with a different state), and therefore
> cause _some_ of the branches to be inconsistent. See
> tracing_record_taskinfo_sched_switch() and tracing_record_taskinfo() @flags
> parameter.

I'm more OK with using a READ_ONCE() on the flags so it is consistent.
But the WRITE_ONCE() is going a bit overboard.

> 
> AFAIU the current code should not generate any out-of-bound writes in case of
> re-fetch, but no comment in there documents how fragile this is.

Which part of the code are you talking about here?

-- Steve
