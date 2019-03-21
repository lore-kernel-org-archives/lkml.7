Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38ED218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QY+7sXuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfCUIdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:33:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfCUIdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lm6Ht1nRh5ZijQir8LLqGfhx33+hBPtNZBQ0yg69ceI=; b=QY+7sXufr7WtC9R/2011x58ss
        qZ6ZFUkzGeTy+eYRzwhoNC0pGIF0nyZQZgN7BBSGzCe6QXJ0txBTjLob/sqVK2i/4SdHtT1sgKbsy
        zhmIwIqNWdojoddsFvD8I0iwLLMKmX5zEjpJ8IHIyb9MIZpZyW6al1kbCXbQ6mzRvCF9v8roKNAAB
        XMtRJjVK/6JP4aiTVRgxwCmoqxWY5Cn9HB0yr3NcsmhCZwuRreFC5YpeFbmLp19d5hQHxI471mth9
        hh3OlfKEiDPAXNmAHgD+1FYwQikREWNI4cCQL89QlilggYLybZbH2/mm0C86g1OXF7YJWuWb0CRGx
        MeMoLA1eA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6t8Z-0006jV-8d; Thu, 21 Mar 2019 08:33:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69FAF2855FC6D; Thu, 21 Mar 2019 09:33:17 +0100 (CET)
Date:   Thu, 21 Mar 2019 09:33:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20190321083317.GL6058@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320221534.165ab87b@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:15:34PM -0400, Steven Rostedt wrote:

> And it would crash similarly each time I tried it, but always at a
> different place. After spending the day on this, I finally figured it
> out. The bug is happening in entry_64.S right after error_entry.
> There's two TRACE_IRQS_OFF in that code path, which if I comment out,
> the bug goes away. Then it dawned on me that the crash always happens
> when systemd does a normal page fault. We had this bug before, and it
> was with the exception trace points.

0ac09f9f8cd1 ("x86, trace: Fix CR2 corruption when tracing page faults")
d4078e232267 ("x86, trace: Further robustify CR2 handling vs tracing")

Or were you talking about:

70fb74a5420f ("x86: Save cr2 in NMI in case NMIs take a page fault (for i386)")

> The issue is that a tracepoint can fault (reading vmalloc or whatever).
> And doing a userspace stack trace most definitely will fault. But if we
> are coming from a legitimate page fault, the address of that fault (in
> the CR2 register) will be lost if we fault before we get to the page
> fault handler. That's exactly what is happening.

Shees, that could've been written much clearer. So you're saying:

idtentry page_fault             do_page_fault           has_error_code=1
  call error_entry
    TRACE_IRQS_OFF
      call trace_hardirqs_off*
        <tracer stuff>
	  <fault> # modifies CR2
  call do_page_fault
    address = read_cr2(); /* whoopsie */

Right?

> To solve this, a TRACE_IRQS_OFF_CR2 (and ON for consistency) was added
> that saves the CR2 register. A new trace_hardirqs_off_thunk_cr2 is
> created that stores the cr2 register, calls the
> trace_hardirqs_off_caller, then on return restores the cr2 register if
> it changed, before returning.

Yuck.. also, not consistent with the actual patch. The thunk doesn't
save/restore CR2.

I really hate making this special TRACE_IRQS_OFF_CR2 thing, it feels far
too fragile. I'd _much_ rather push the #PF CR2 read much earlier.

Also, argh I fscking hate context tracking. That makes all this so much
more complicated. It if weren't for CALL_enter_from_user_mode, we could
pull that TRACE_IRQS_OFF out of error_entry.

Damn... Andy, any bright ideas?
