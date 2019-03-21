Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B68C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2372190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSpaRGZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfCUS3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:29:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KIgCN+5l8zWFTBFf/0pmAEOxMyRF9y6yveWutetaS30=; b=XSpaRGZ3ru7i4e6OlmuCxKI3N
        57qOzAhOl86mxpulkHmyNlb4TOOVxEIVTgBjkcJdWMzB0Drb3qMn8Gm0BraP30Q519AvNWhfzjiZk
        dTskBAg4xVeOZGD0tJQ9dG+nILenuiy33iRV946DNy8xQ6ij+sD4Ij2TX2ywpVT+2ZDOb0wlR8xvK
        J7TF7Xz6aCrptQf/9bJbDKgPb08eBT952KSJn+DbwULZGsCukvv1QucR42My5rbrD+V6mTLUQ6SoT
        2hXI14kG1yc1BOK1erXhFY3m+s89M0wRm+5WfSBw4U2ZgHVk1Pt4F7xboLeEfi4DPgCu3dRQ3IZgE
        VVZcu3A1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h72QZ-0002p1-Po; Thu, 21 Mar 2019 18:28:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50C7C2393EEE2; Thu, 21 Mar 2019 19:28:30 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:28:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321182830.GV5996@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net>
 <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home>
 <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <20190321141020.641e313f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321141020.641e313f@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:10:20PM -0400, Steven Rostedt wrote:
> On Thu, 21 Mar 2019 11:05:06 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
> 
> > In the long run, I think the right solution is to rewrite even more of
> > this mess in C.  We really ought to be able to put the IRQ flag
> > tracing and the context tracking into C code.
> 
> And once we do that, we can work on getting the irq tracing
> incorporated into a jump_label type that we could possibly enable
> lockdep at start up, and then disable it later, even on production
> systems! That is, to be able to turn it off and bring the system back
> up to full speed.

You forget the stupid amount of data bloat that lockdep brings.
