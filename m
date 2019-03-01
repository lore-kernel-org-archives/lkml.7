Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D692FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F542084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btq4ZZXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbfCAOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:38:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfCAOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D20FS/b3C+Uzm8zEFff2tzX0CzvSgkdyaf9/2GVvBys=; b=btq4ZZXHkJ41xA7TUZ3ii55LR
        S6VqS3rmxwXXcjW58IAaWPomDiCVk6nTKEVEp28XJ9dcrx9SOfXqwbBu2gr3HbR2+5Q0zL1TQMh2N
        oKP3uVTrHLnPAxf1IAP8OazXFH7/5DOZdl/CxP2Gnz9dEx6OG6g76Kg1jBe0Tb/AUxaK610uQ1yzG
        BOcC6O77mtPf6/n4OfL26lEdTvyS/uJnAG22LdoK4ieca3ZZm9RLjD8SYlwG7FcfYamWRp5FvLfwP
        F/olqGHu+akZqSty5F9gtXVosOU/2qfx3q6yTs8u6zAJQUuUmnPyKm8e06VWphyh0eCZf8s1I6Q1R
        d9kln29Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzjIY-0000E3-9a; Fri, 01 Mar 2019 14:38:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F414F29AAFFEA; Fri,  1 Mar 2019 15:38:00 +0100 (CET)
Date:   Fri, 1 Mar 2019 15:38:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Message-ID: <20190301143800.GT32534@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net>
 <20190228180154.GO32534@hirez.programming.kicks-ass.net>
 <CAHk-=whJww5smbSU2VzvcR7tajNqp=i9ZBYHK3RvwVXbs+V_JQ@mail.gmail.com>
 <20190228190111.GI32494@hirez.programming.kicks-ass.net>
 <20190301103452.GQ32534@hirez.programming.kicks-ass.net>
 <20190301122745.GR32534@hirez.programming.kicks-ass.net>
 <20190301125718.GS32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301125718.GS32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:57:18PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 01, 2019 at 01:27:45PM +0100, Peter Zijlstra wrote:
> > arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x30: redundant UACCESS disable
> 
> > The usercopy one is difficult, that's copy_user_handle_tail(), it is
> > buggered though, because that lacks notrace and thus has a __fentry__
> > call in.
> > 
> > Also, afaict all exception jumps into copy_user_handle_tail() will have
> > AC=1, but the __{get,put}_user_nocheck() things do STAC/CLAC all over
> > again.
> > 
> > So what do we do? Annotate that we start with AC=1 and then immediately
> > do the clac, and then let __{get,put}_user_nocheck() do their own thing?
> > or make it use the unsafe stuff?
> 
> Or.. we move the thing to assembly. Of course, I suck at (writing) asm,
> so the below is probably broken in various ways.

The advantage is that it now all lives in the same .o file and objtool
can actually follow and find the complete control flow.

I've made it ENDPROC() such that it becomes STT_FUNC and objtool does
all the normal things. I've also moved the ALIGN_DESTINATION macro into
the .S file.

Andy, do we have a sensible self-test for this path?
