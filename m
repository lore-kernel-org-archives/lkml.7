Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF77DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B622084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVPiV4Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfFQObm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:31:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NFJYXlUzdjtOs435zT2VUCTTaFwwk1bDij2QZYtv7Eo=; b=WVPiV4RoKw5OElXExsulkvelC
        I9ISaJTiqb4jKOqgu2cPZ9SOftWInZsm0TejjW7YtdMwZ4Z83MigsmuNETW25QvlGfnLIaNFMDJas
        ffWnXGYj/G52wdxf4iHhlPu1CQJykfjcsiOutiHslh17VubxroBb+mIyunb5gt4fT1Aw10uQmjqIX
        k6vANgk5iXa8iwlpMOvJ6ma6LAB5+6pS7QenrYP4LVqshx5SVSYj46P1VTvQcyTaosPv2dPCAiPIQ
        oT+P4fF432GZPBnIBibhQRWpZ/zJQRZQNj/WJOHsgfG4r8OW/r32Os6vJUdITZGI0xrtRb9eC9p1V
        yOaQ9d+AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcsf9-0003Wb-LN; Mon, 17 Jun 2019 14:31:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29EA4201F45FA; Mon, 17 Jun 2019 16:31:10 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:31:10 +0200
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
Message-ID: <20190617143110.GD3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <435093E5-6FE3-4DAA-9ABE-EB9D372F8CF8@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435093E5-6FE3-4DAA-9ABE-EB9D372F8CF8@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:54:23AM -0700, Andy Lutomirski wrote:
> > On Jun 11, 2019, at 1:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > arch_optimize_kprobe() then does the text_poke_bp() that replaces the
> > instruction @addr with int3, copies the rel jump address and overwrites
> > the int3 with jmp.
> > 
> > And I'm thinking the problem is with something like:
> > 
> > @addr: nop nop nop nop nop
> > 
> > We copy out the nops into the trampoline, overwrite the first nop with
> > an INT3, overwrite the remaining nops with the rel addr, but oops,
> > another CPU can still be executing one of those NOPs, right?
> > 
> > I'm thinking we could fix this by first writing INT3 into all relevant
> > instructions, which is going to be messy, given the current code base.
> 
> How does that help?  If RIP == x+2 and you want to put a 5-byte jump
> at address x, no amount of 0xcc is going to change the fact that RIP
> is in the middle of the jump.

What I proposed was doing 0xCC on every instruction that's inside of
[x,x+5). After that we do machine wide IPI+SYNC.

So if RIP is at x+2, then it will observe 0xCC and trigger the exception
there.

Now, the problem is that my exception cannot recover from anything
except NOPs, so while it could work for some corner cases, it doesn't
work for the optkprobe case in general.

Only then do we write the JMP offset and again to IPI+SYNC; then we
write the 0xE8 and again IPI-SYNC.

But at that point we already have the guarantee nobody is inside
[x,x+5). That is, except if we can get to x+2 without first going
through x, IOW if x+2 is a branch target we're screwed any which way
around and the poke is never valid.

Is that something optkprobes checks? If so, where and how?

