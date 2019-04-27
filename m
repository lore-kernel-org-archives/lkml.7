Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E3C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E3B20651
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HviJb4ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfD0K1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:27:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfD0K1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e/QQuLy0GymXijIDKvEURPIf1XYN89dwF9MEo0vwOts=; b=HviJb4aePK+o7aNHbssZBSoYs
        3Y7fomHk2VgqEhypKzge0QazqbQ0BjOrHh2APtMwaw/H3V5MyWqH3HFYUi3wqyxqYQHuKs9QZmy8q
        dVYT3RcYHjf2XSitar03r9kddwVuUzyj4qIL+e6zg3ZzFlLddI+8EkM8aJY1AtY7xdF8EM0UOxgBC
        CHriXRCiB6g0SKx1pPnlPcCv3IrpeeYdq5BZ3mC334RlXw4IASSgjhFPyziXm2K/C6I0Fo+rnL0k9
        ocUsnSDMw5Tv+Cjoys4Ls1DrHN2obfnp74/aytaROF+W9XLipqjvkKpZchtqpAuMcxvopym7KXMuY
        4Kad4xDxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKKXr-0000CF-Lt; Sat, 27 Apr 2019 10:26:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A370029D22407; Sat, 27 Apr 2019 12:26:57 +0200 (CEST)
Date:   Sat, 27 Apr 2019 12:26:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190427102657.GF2623@hirez.programming.kicks-ass.net>
References: <20190427100639.15074-1-nstange@suse.de>
 <20190427100639.15074-4-nstange@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427100639.15074-4-nstange@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:06:38PM +0200, Nicolai Stange wrote:
> ftrace_int3_handler()'s context is different from the interrupted call
> instruction's one, obviously. In order to be able to emulate the call
> within the original context, make ftrace_int3_handler() set its iret
> frame's ->ip to some helper stub. Upon return from the trap, this stub will
> then mimic the call by pushing the the return address onto the stack and
> issuing a jmp to the target address. As describe above, the jmp target
> will be either of ftrace_ops_list_func() or ftrace_regs_caller(). Provide
> one such stub implementation for each of the two cases.

Yuck; I'd much rather we get that static_call() stuff sorted such that
text_poke() and poke_int3_handler() can do CALL emulation.

Given all the back and forth, I think the solution where we shift
pt_regs a bit to allow the emulated PUSH is a viable solution; eg. I
think we collectively hated it least.
