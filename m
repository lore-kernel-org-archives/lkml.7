Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B4EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2155B218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfCUNEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfCUNEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:04:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6777F218E2;
        Thu, 21 Mar 2019 13:04:23 +0000 (UTC)
Date:   Thu, 21 Mar 2019 09:04:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321090422.067ab491@gandalf.local.home>
In-Reply-To: <20190321083317.GL6058@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
        <20190321083317.GL6058@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 09:33:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 20, 2019 at 10:15:34PM -0400, Steven Rostedt wrote:
> 
> > And it would crash similarly each time I tried it, but always at a
> > different place. After spending the day on this, I finally figured it
> > out. The bug is happening in entry_64.S right after error_entry.
> > There's two TRACE_IRQS_OFF in that code path, which if I comment out,
> > the bug goes away. Then it dawned on me that the crash always happens
> > when systemd does a normal page fault. We had this bug before, and it
> > was with the exception trace points.  
> 
> 0ac09f9f8cd1 ("x86, trace: Fix CR2 corruption when tracing page faults")
> d4078e232267 ("x86, trace: Further robustify CR2 handling vs tracing")

Probably these two, as I remember more about the discussions around
them, and not the actual commits. Although, I did take a look at the
do_page_fault() code that was added because of them. I just didn't do a
git blame to see what added it.

> 
> Or were you talking about:
> 
> 70fb74a5420f ("x86: Save cr2 in NMI in case NMIs take a page fault (for i386)")
> 
> > The issue is that a tracepoint can fault (reading vmalloc or whatever).
> > And doing a userspace stack trace most definitely will fault. But if we
> > are coming from a legitimate page fault, the address of that fault (in
> > the CR2 register) will be lost if we fault before we get to the page
> > fault handler. That's exactly what is happening.  
> 
> Shees, that could've been written much clearer. So you're saying:

I wrote this just before going to bed. It was the best I could come up
with at the time.

> 
> idtentry page_fault             do_page_fault           has_error_code=1
>   call error_entry
>     TRACE_IRQS_OFF
>       call trace_hardirqs_off*
>         <tracer stuff>
> 	  <fault> # modifies CR2
>   call do_page_fault
>     address = read_cr2(); /* whoopsie */
> 
> Right?

Yes.

> 
> > To solve this, a TRACE_IRQS_OFF_CR2 (and ON for consistency) was added
> > that saves the CR2 register. A new trace_hardirqs_off_thunk_cr2 is
> > created that stores the cr2 register, calls the
> > trace_hardirqs_off_caller, then on return restores the cr2 register if
> > it changed, before returning.  
> 
> Yuck.. also, not consistent with the actual patch. The thunk doesn't
> save/restore CR2.

Well, the thunk calls the caller_cr2 that does, which is just a helper
function for the thunk.

> 
> I really hate making this special TRACE_IRQS_OFF_CR2 thing, it feels far
> too fragile. I'd _much_ rather push the #PF CR2 read much earlier.
> 
> Also, argh I fscking hate context tracking. That makes all this so much
> more complicated. It if weren't for CALL_enter_from_user_mode, we could
> pull that TRACE_IRQS_OFF out of error_entry.

Yeah, and I didn't even test this with context tracking enabled yet.

-- Steve


> 
> Damn... Andy, any bright ideas?

