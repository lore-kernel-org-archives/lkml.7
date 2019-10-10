Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE04C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3D820659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hz5oc5x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfJJR2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:28:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJJR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jGjrMHjbVkw9PtNLTnGUIMRk1jbkYRQUfuTrxBmVYoQ=; b=hz5oc5x1byj44Rg9OJ/SdZ7hm
        5mBt4yBsLTf23k/+NnlS43TqkL980Ew3H36EWlZxXsF5VRKCc3bjqlwUw5AJ514IKVE3zViWsIGhS
        3k37NMgDWsyOtht0/DiJeGTRIUCXFGFdrUiDnkx3/ef+/dYff/ygMWT3VJouzdGPPgfr09jnkpYfv
        Z2R78hsYOxg2ginuv/mQ0Bll3zOPUs29npLXC2UpOJcoLY8rAW0tAmK1eiuivUomN9aRaU1RYy361
        QgSyoIr+fjU3xeQUckZdYGcWymzqDTP3xkuM0StUv5kT8TuL3BWyisuTDxAUYMR0TltgijkYQV8UV
        djwXtluSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIcEf-0002Sd-7H; Thu, 10 Oct 2019 17:28:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6446F3008C1;
        Thu, 10 Oct 2019 19:27:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88C8221492B16; Thu, 10 Oct 2019 19:28:19 +0200 (CEST)
Date:   Thu, 10 Oct 2019 19:28:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191010172819.GS2328@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010115449.22044b53@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 11:54:49AM -0400, Steven Rostedt wrote:
> On Thu, 10 Oct 2019 16:05:13 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Because we can't do the above once we have more than one CPU running.  
> > 
> > We loose BOOTING _long_ before we gain SMP.
> 
> Ah, yep. But I finally got it working with the following patch:

That looks like it can be done simpler; but my head is exploding, I'll
have to look at this in the AM.

> Is it really important to use text_poke() on text that is coming live?

What is really important is that we never have memory that is both
writable and executable (W^X).

Moving as much poking to before marking it RO (or moving the marking RO
later if that is the same thing) is a sane approach.

But once it gains X, we must never again mark it W, without first
removing X.

> That is, I really hate the above "set_ro" hack. This is because you
> moved the ro setting to create_trampoline() and then forcing the
> text_poke() on text that has just been created. I prefer to just modify
> it and then setting it to ro before it gets executed. Otherwise we need
> to do all these dances.

I thought create_trampoline() finished the whole thing; if it does not,
either make create_trampoline() do everything, or add a
finish_trampoline() callback to mark it complete.

> The same is with the module code. My patch was turning text to
> read-write that is not to be executed yet. Really, what's wrong with
> that?

The fact that it is executable; also the fact that you do it right after
we mark it ro. Flipping the memory protections back and forth is just
really poor everything.

Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
executable (kernel) memory writable.

Really the best solution is to move all the poking into
ftrace_module_init(), before we mark it RO+X. That's what I'm going to
do for jump_label and static_call as well, I just need to add that extra
notifier callback.
