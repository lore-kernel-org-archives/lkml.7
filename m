Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CFC46477
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867FA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHeXv7Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfFQOm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:42:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hiAU/ZObZlu6bcVKe/I5QdmTIpALzdfMSuN4Et+MDEI=; b=mHeXv7Gu6VGHGFwa7W7g0CKyhd
        KtNJuKxVNRWaE+ypaxnhDhURuOAaNc4t78rwhlN4o5qwucuBwV7MeW8LMgli5uYiKH7aOyyRgSzz2
        QRGHmsKUrImGVBsL8YFYQmvUdoNLhzbUd9lvvx5JDeMo8whN+IAGGrsNKwvZG/Tm+zX49pJZYHsQm
        mc0VSQitDyQMeK4JzGkEzn6xEJ+F9nKYEFfqDyknOE1c1PI0lUWNL6ivehelQzaqMomMttbCoLtx3
        1Z9sbNNNY2h7/MJGN2+YBC7j6m43TGLeiIFQu9HBsa8ueJo4sywJNwKk4kJQ3X6BLz27TWjwx+PU1
        1Ifmoy3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcspq-0008Hf-RF; Mon, 17 Jun 2019 14:42:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A98A201D1C98; Mon, 17 Jun 2019 16:42:13 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:42:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190617144213.GE3436@hirez.programming.kicks-ass.net>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611112254.576226fe@gandalf.local.home>
 <20190611155537.GB3436@hirez.programming.kicks-ass.net>
 <D9439F7B-3384-4BD5-B3BA-13EE52FEC15E@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9439F7B-3384-4BD5-B3BA-13EE52FEC15E@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 07:44:12PM +0000, Nadav Amit wrote:

> I have run into similar problems before.
> 
> I had two problematic scenarios. In the first case, I had a “call” in the
> middle of the patched code-block, but this call was always followed by a
> “jump” to the end of the potentially patched code-block, so I did not have
> the problem.
> 
> In the second case, I had an indirect call (which is shorter than a direct

Longer, 6 bytes vs 5 if I'm not mistaken.

> call) being patched into a direct call. In this case, I preceded the
> indirect call with NOPs so indeed the indirect call was at the end of the
> patched block.
> 
> In certain cases, if a shorter instruction should be potentially patched
> into a longer one, the shorter one can be preceded by some prefixes. If
> there are multiple REX prefixes, for instance, the CPU only uses the last
> one, IIRC. This can allow to avoid synchronize_sched() when patching a
> single instruction into another instruction with a different length.
> 
> Not sure how helpful this information is, but sharing - just in case.

I think we can patch multiple instructions provided:

 - all but one instruction are a NOP,
 - there are no branch targets inside the range.

By poking INT3 at every instruction in the range and then doing the
machine wide IPI+SYNC, we'll trap every CPU that is in-side the range.

Because all but one instruction are a NOP, we can emulate only the one
instruction (assuming the real instruction is always last), otherwise
NOP when we're behind the real instruction.

Then we can write new instructions, leaving the initial INT3 until last.

Something like this might be useful if we want to support immediate
instructions (like patch_data_* in paravirt_patch.c) for static_call().


