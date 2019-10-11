Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07601ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2342206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HqMH+WY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfJKM7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:59:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0oxLsQ5iH+e+05LkxnBni+6OFSMtRO8vSqonY1UcZaI=; b=HqMH+WY7Iy18jtrsWKkOPYCSd
        65W03V98M/943JgI/YKYX3vUHuwYXbof8bh2FOypQ7sOZVdeQLWJfQumslfLV4hIJedD9BbLXgYd+
        HCypAokA0CO7X0OPNsn4jj4sT8dXJxxURA2JmUpRqUfc1lqDCXiLiXnRaKv5fmaLN8KD1H8x6+XT+
        MdieLei4sB7J/gK47jo0jydI6AIGHcA0cuSNwfUKvuO/zEYfWiAJYGLq86y0eoCheWuLLRFa5QA0n
        Ws18zVMvyjIVugH8hJ2sHrhEPTr8s1+tWsGkXcuZsw0FejYccRhGMk7gTS892ftnyuKPQIK++Hd/T
        A7OtLEBng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIuVe-0002OW-6Q; Fri, 11 Oct 2019 12:59:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7582A3013A4;
        Fri, 11 Oct 2019 14:58:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16F592023D649; Fri, 11 Oct 2019 14:59:03 +0200 (CEST)
Date:   Fri, 11 Oct 2019 14:59:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191011125903.GN2359@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010172819.GS2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 07:28:19PM +0200, Peter Zijlstra wrote:

> Really the best solution is to move all the poking into
> ftrace_module_init(), before we mark it RO+X. That's what I'm going to
> do for jump_label and static_call as well, I just need to add that extra
> notifier callback.

OK, so I started writing that patch... or rather, I wrote the patch and
started on the Changelog when I ran into trouble describing why we need
it.

That is, I'm struggling to explain why we cannot flip
prepare_coming_module() and complete_formation().

Yes, it breaks ftrace, but I'm thinking that is all it breaks. So let me
see if we can cure that.

