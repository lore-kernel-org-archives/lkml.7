Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED00C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5140320818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NHqcjmFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKKIrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:47:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MWS4iDPKXqL9aeVZvrVY5JzKZIFEOsCQmC2rJZ7GvJc=; b=NHqcjmFTU72YEQ0NHLL0PvlhJ
        xmrjrC0pkf+ZWjbzkGG768hJ4OOzZ6NZsiYjbv4lGfcv42sKXJQJGhCxq75Ooo45OL01QBHliVmtS
        lsOGfX6aMkN5+3hNCGRQyGVfs+BLJ9hABBS6YFqYfqb8mKU5J53PYGHik7+oKseyZ2ZCH7YgP4YPo
        DIymuLRtZY9v4lKMXU6RMHFGuWQqN9+N9tBbCRlrz1jIarTi2Z5tPa/Uafai/Qjz21GnkxMFLdfUy
        K5kHQirn2/CRckRRDbA6FL7iV6UfNHkQ4jJdwNd+SG6kgYfcR+GhBbGkbPD/d5Y1/l18Y2lABz0IQ
        J+/iSQKIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iU5MB-0003TQ-31; Mon, 11 Nov 2019 08:47:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAB7B305615;
        Mon, 11 Nov 2019 09:46:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF09A2026E904; Mon, 11 Nov 2019 09:47:28 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:47:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191111084728.GO4131@hirez.programming.kicks-ass.net>
References: <20191108212834.594904349@goodmis.org>
 <20191108225100.ea3bhsbdf6oerj6g@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108225100.ea3bhsbdf6oerj6g@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:51:00PM -0600, Josh Poimboeuf wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] ftrace/x86: Tell objtool to ignore nondeterministic ftrace stack layout
> 
> Objtool complains about the new ftrace direct trampoline code:
> 
>   arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0x190: stack state mismatch: cfa1=7+16 cfa2=7+24
> 
> Typically, code has a deterministic stack layout, such that at a given
> instruction address, the stack frame size is always the same.
> 
> That's not the case for the new ftrace_regs_caller() code after it
> adjusts the stack for the direct case.  Just plead ignorance and assume
> it's always the non-direct path.  Note this creates a tiny window for
> ORC to get confused.

How is that not a problem for livepatch?
