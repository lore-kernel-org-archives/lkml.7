Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615BAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344DF2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEFPj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfEFPj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:39:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E77205C9;
        Mon,  6 May 2019 15:39:25 +0000 (UTC)
Date:   Mon, 6 May 2019 11:39:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [RFC PATCH v6 1/6] x86/uaccess: Allow access_ok() in irq
 context if pagefault_disabled
Message-ID: <20190506113923.4fbd56ae@gandalf.local.home>
In-Reply-To: <20190507002203.1db020838c07a12bec87ca73@kernel.org>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
        <155289139725.7218.17265500814527931961.stgit@devnote2>
        <20190321224602.1e31aded@oasis.local.home>
        <20190507002203.1db020838c07a12bec87ca73@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 00:22:03 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> It seems I missed this message...

No problem. The number of times I missed messages... ugh.

> 
> > 
> > I'm curious, what interrupt handler are kprobes executing in that needs
> > random user space addresses?  
> 
> Sorry for confusion. Kprobes is using an exception (of course!). So the
> title can mislead, it should be "in exception" instead of "in irq context",
> However, current code checks it by "!in_task()", which includes both of
> IRQ and exception. A better solution might change it to "in_irq()".

That makes sense.

> 
> However, I could not find a way to distinguish the "exception" and
> "external IRQ" by the execution context (based on the preempt count)
> because exception is treated as a kind of IRQ.
> Thus, in this patch, I changed it as not only checking what the context
> is, but also whether it is appropriately called.
> 

As exceptions typically disable interrupts, we treat them as their own
context. Especially for looking at recursion detection algorithms,
which allow for different contexts to recurse.

Normal-context -> softirq -> exception / IRQ -> NMI


Anyway, that WARN_ON_IN_IRQ() should come with a big comment about why
we allow it if we have pagefault_disable() set.

This will need to go through the x86 maintainers. I'll go and review
the tracing patches of this series and give an ack / reviewed-by if
there's no issues.

-- Steve
