Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDBDC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4123820896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AdTA9RyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfFKMnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:43:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfFKMnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kp1pRRfoumgY4Up20rnCQcSt99FXk8xSho/xLyWE55U=; b=AdTA9RyM7eWaOsI2SHx4yq+J+
        rQ+xaOkv9SClS4rtoCSqSWfHswNqwGONVngTCv9JhZEyxcyCvBv3RiW8Ggz+0TIrRJGh81Z4CdGrP
        4m9yvmNHj02qf3WnCwGGeulWfD4jKlGvWfNDldXMWDEhfDCB4/gSClS+vzYXEh/1e4PbALkTEn5QY
        E2zxChDB3zdImVaeHQAKnU3obf+8oDkiH/73osCNlhtle8w98vrjjrPQQ+q/MNLXAG2thJgRLgBBQ
        mO6N+yofbrgzwo3/K+Le0kNTDdsQkm2zRWgYCsTEKDEeTr8/IicojwrRGlH5qgqnRGqfpmI7VRZeF
        bNmUdPpUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hag6s-0004Y7-ES; Tue, 11 Jun 2019 12:42:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E97F720224753; Tue, 11 Jun 2019 14:42:40 +0200 (CEST)
Date:   Tue, 11 Jun 2019 14:42:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611124240.GI3463@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611120834.GG3463@hirez.programming.kicks-ass.net>
 <20190611123402.GH3463@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611123402.GH3463@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 02:34:02PM +0200, Peter Zijlstra wrote:

> Bugger, this isn't right. It'll jump to the beginning of the trampoline,
> even if it is multiple instructions in, which would lead to executing
> instructions twice, which would be BAD.
> 
> _maybe_, depending on what the slot looks like, we could do something
> like:
> 
> 	offset = regs->ip - (unsigned long)bp_int3_addr;
> 	regs->ip = bp_int3_handler + offset;
> 
> That is; jump into the slot at the same offset we hit the INT3, but this
> is quickly getting yuck.

Yeah, that won't work either... it needs something far more complex :/
