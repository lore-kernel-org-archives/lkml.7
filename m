Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FA21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfCVCqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfCVCqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:46:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A94E218FE;
        Fri, 22 Mar 2019 02:46:05 +0000 (UTC)
Date:   Thu, 21 Mar 2019 22:46:02 -0400
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
Message-ID: <20190321224602.1e31aded@oasis.local.home>
In-Reply-To: <155289139725.7218.17265500814527931961.stgit@devnote2>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
        <155289139725.7218.17265500814527931961.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 15:43:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> WARN_ON_IN_IRQ() assumes that the access_ok() and following
> user memory access can sleep. But this assumption is not
> always correct; when the pagefault is disabled, following
> memory access will just returns -EFAULT and never sleep.
> 
> Add pagefault_disabled() check in WARN_ON_ONCE() so that
> it can ignore the case we call it with disabling pagefault.
> For this purpose, this modified pagefault_disabled() as
> an inline function.
> 

Actually, accessing user space from an interrupt doesn't really make
sense. Now I'm differentiating a true interrupt (like a device handler)
from an exception. The difference is that an exception is synchronous
with the execution of the code, but an interrupt is something where you
don't know what task is running. A uaccess in this type of interrupt
will randomly grab some user space memory but have no idea what task is
running.

The one time this makes sense is if you are doing some kind of
profiling, where the randomness is fine.

I'm curious, what interrupt handler are kprobes executing in that needs
random user space addresses?

-- Steve
