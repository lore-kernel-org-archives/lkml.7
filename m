Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3612080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UO4Up5c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405486AbfFKP4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:56:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391859AbfFKP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dYWF8dg5ZWwrOvlmpQU8/b1U7j2GS0cV9KF8ci48uQA=; b=UO4Up5c8sxzI2qusz/vGAYQOu
        +QwryOTTYPx6psOLJBQIF4rNOo6mPv28IbkjmvcvaR6QPL8LzVVW9D7fCKgOw5o0P3F+2EHE2S3lV
        feKBFI2c8bb8M2xx42ivpb/hRUsXPsVWHX5hYWDY1k/y7NP2G+hqyI8fe11VYhntf8EFYBidqSHou
        MAz97neHt3+nmuK60pH2EyctnEi4CxcIKmNRf7Qj3OMuCK52uOT5vKlgO6GuG7jbvcl9dlgUzX7DU
        WxuEzW3SPEJZK4FQVgW6m6QE/tM9hm/FJo+N9aQy/pSU/86ldKDldOIjUCrHd7K4KqdYC0c2m7OZF
        5URSSNUUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haj7a-0008Fj-Sg; Tue, 11 Jun 2019 15:55:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E6A42023E4A7; Tue, 11 Jun 2019 17:55:37 +0200 (CEST)
Date:   Tue, 11 Jun 2019 17:55:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190611155537.GB3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611112254.576226fe@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611112254.576226fe@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:22:54AM -0400, Steven Rostedt wrote:
> On Tue, 11 Jun 2019 10:03:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
> > So what happens is that arch_prepare_optimized_kprobe() <-
> > copy_optimized_instructions() copies however much of the instruction
> > stream is required such that we can overwrite the instruction at @addr
> > with a 5 byte jump.
> > 
> > arch_optimize_kprobe() then does the text_poke_bp() that replaces the
> > instruction @addr with int3, copies the rel jump address and overwrites
> > the int3 with jmp.
> > 
> > And I'm thinking the problem is with something like:
> > 
> > @addr: nop nop nop nop nop
> 
> What would work would be to:
> 
> 	add breakpoint to first opcode.
> 
> 	call synchronize_tasks();
> 
> 	/* All tasks now hitting breakpoint and jumping over affected
> 	code */
> 
> 	update the rest of the instructions.
> 
> 	replace breakpoint with jmp.
> 
> One caveat is that the replaced instructions must not be a call
> function. As if the call function calls schedule then it will
> circumvent the synchronize_tasks(). It would be OK if that call is the
> last of the instructions. But I doubt we modify anything more then a
> call size anyway, so this should still work for all current instances.

Right, something like this could work (although I cannot currently find
synchronize_tasks), but it would make the optprobe stuff fairly slow
(iirc this sync_tasks() thing could be pretty horrible).


