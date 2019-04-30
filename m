Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65783C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FD72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PaVG+9Rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfD3KrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:47:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfD3KrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hqqOHMMUuBvpuVQELeBZmURuJXjgQFqffW8kA9cAK/I=; b=PaVG+9RwpCsXq15eaBB6EYSbN
        kSbHYkqvjqUvSv3jpTDD9Z/uLy3t//bG0X+q/rBM5tUljQmNVrSIAC16d5DWJjguWhS03TvhXFVke
        m2tBVj6tvBTp0mR573beuNeRyZSVhY3M1m+BidytXleKrDBBZqCaR6QJFLPSlaidaZ2HPF+y1bEwS
        WZ1t8L0HPIZFikNyRg3L6ZMurl0eejHBOFV4y+vUIr5iMBjfipjE7DJFdIwN7KNXOmwsbqnddIIb4
        x8YKCMOSStKAuoQRJbG7ZhKn3fq3uJb2stY/jCun14hfRD3yhi8H7az6tyHPLffJLOAMnz4bRGxeN
        41K2u1XDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQHi-0004y1-Ln; Tue, 30 Apr 2019 10:46:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F4112203E886A; Tue, 30 Apr 2019 12:46:48 +0200 (CEST)
Date:   Tue, 30 Apr 2019 12:46:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
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
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190430104648.GR2623@hirez.programming.kicks-ass.net>
References: <20190427100639.15074-1-nstange@suse.de>
 <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net>
 <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <20190429145250.1a5da6ed@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429145250.1a5da6ed@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 02:52:50PM -0400, Steven Rostedt wrote:
> On Mon, 29 Apr 2019 11:06:58 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > +void replace_call(void *addr, const void *opcode, size_t len, void *target)
> > +{
> > +	bp_int3_call_target = target;
> > +	bp_int3_call_return = addr + len;
> > +	bp_int3_handler_irqoff = emulate_call_irqoff;
> > +	text_poke_bp(addr, opcode, len, emulate_call_irqon);
> > +}
> 
> Note, the function tracer does not use text poke. It does it in batch
> mode. It can update over 40,000 calls in one go:

Note that Daniel is adding batch stuff to text_poke(), because
jump_label/static_key stuffs also end up wanting to change more than one
site at a time and IPI spraying the machine for every single instance is
hurting.

So ideally ftrace would start to use the 'normal' code when that
happens.
