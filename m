Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2150C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A261218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAUlvgZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388492AbfB1SCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:02:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfB1SCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7M0G4ypBWx4ZVP9RSaKOTyWNDB6/HRD6+A3GFbCM1fU=; b=lAUlvgZEWcJE1srWMLvatE0Ls
        iM3xjB0dF3M03qO0KOM7FJn922Cs6yaF3WBp70aPpm8hB5SVFBtIVZBEV17+P4AmDENt5xBA3Ai0+
        L+PzLXHbTYylBy274HroMKhHAfoH5lJJo4YMZ+msZ4abQrrJthweiSyWqc1rIUVEuEBCV32XDerOs
        fEVoRqxq5f89+k/DhEumBmL52I1QKa5Huko0Rtd+y88BZnHJBmv8shfv4YmWdP8gtWjWVQS8rXn9K
        MitzeSX9hypxR8+n97/N9H2EJtNSODcd3qQaWaeU374m30wCSqyjRUBAXcz8seot3IeLoEMthqQUO
        o8OEZGtEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzQ0K-0007TZ-4b; Thu, 28 Feb 2019 18:01:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FDAF202C2DA7; Thu, 28 Feb 2019 19:01:54 +0100 (CET)
Date:   Thu, 28 Feb 2019 19:01:54 +0100
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
Message-ID: <20190228180154.GO32534@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
 <20190228175114.GG32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228175114.GG32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 06:51:14PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 28, 2019 at 08:49:57AM -0800, Linus Torvalds wrote:
> > Yes, it is redundant (but harmlessly so) if no fault occurs.
> 
> Oooh, there's a label hidden in unsafe_put_user()...
> 
> And yes, objtool seems to miss that, damn. I'll go stare at that.

Weird, that jump is from C, not from a .fixup table. objtool _should_
see that and complain if there is a AC=1 path that reaches RET.

AFAIU validate_branch() should recurse down every single branch, right
Josh?
