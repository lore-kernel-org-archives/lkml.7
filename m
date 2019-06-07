Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93010C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6060B208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qercaASS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfFGIjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:39:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DI7Fs/1DQ5Cn1nmJ570WObqSu6i4Yj7LrxklY7389Uc=; b=qercaASSfzHrtRcjT1K1fZX7C4
        kqaZNJDYXQFjZKzny6G6KDsxtdLld5enRuJ3KM7Fjb5cAWTjUouUe/psUNX1KMI5+wv+wpMCON9MI
        UWD6s39s7yks1j/0GcxakXgvqGhc8Obzc+KBabseM57yRdkmRIDQJomr0jw1QZ/YZIYeSRp9x86IZ
        djRqrUkzrKTqUriQdmwIuUhC1pjCM5HKymegKwpP8ZhRyCcqsqGfAu049QBJxGAfE496IcG9XPNi/
        /cwSFfpo/QSRJ0JZp6TTx7N5+6aNJWr8xFT3hB/SqnPBRGctqBMKzSfLZh1gLigKaaIuttFemWy5o
        Njr8aOiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZAOd-0006Ya-Gu; Fri, 07 Jun 2019 08:38:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 520952097357A; Fri,  7 Jun 2019 10:38:46 +0200 (CEST)
Date:   Fri, 7 Jun 2019 10:38:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 12/15] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20190607083846.GX3419@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.254721704@infradead.org>
 <37C2FB32-3437-48CB-954D-05F683B7D80B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37C2FB32-3437-48CB-954D-05F683B7D80B@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 06:13:58AM +0000, Nadav Amit wrote:
> > On Jun 5, 2019, at 6:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > +void arch_static_call_transform(void *site, void *tramp, void *func)
> > +{
> > +	unsigned char opcodes[CALL_INSN_SIZE];
> > +	unsigned char insn_opcode;
> > +	unsigned long insn;
> > +	s32 dest_relative;
> > +
> > +	mutex_lock(&text_mutex);
> > +
> > +	insn = (unsigned long)tramp;
> > +
> > +	insn_opcode = *(unsigned char *)insn;
> > +	if (insn_opcode != 0xE9) {
> > +		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
> > +			  insn_opcode, (void *)insn);
> > +		goto unlock;
> 
> This might happen if a kprobe is installed on the call, no?
> 
> I don’t know if you want to be more gentle handling of this case (or perhaps
> modify can_probe() to prevent such a case).
> 

yuck.. yes, that's something that needs consideration.
