Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUV9ZZun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfLJRca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:32:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJRca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0PlbuVjzY3V2HTrOXpLIk3hznlIV1chetO8B0aO9utU=; b=YUV9ZZun1mPnOMcp5QA6R1ye6
        mrfb8m6x5bNoy2/WHW11Xlwky/kC3KhAoHB+Wq8wRC5AoZ+6CTIdOfAlyglynI74j9JtqJLyvkTnU
        MOUjg5lIqziy5TDrhMPKurJ42p0i4TVWt891RDDZ0y8906k3QArsFwqg/q0u+2X99HTmMcuaHyXug
        KCN9EtFS5u/s9/zAEnu6Lle8Qz3MoxXB1Qk6hBGm1ZPyVyKikBrbmxWlbKCZ8xKvkYw3EQRh67yFD
        rATCk+6GL8Lo9r4zd5Az56rIcsEDTBBJNUip2jWT7gqRHsI0erudCuXoaE4QkHvbmi5OOc5I7XdmM
        OYMckR6BA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iejMq-0000j7-KE; Tue, 10 Dec 2019 17:32:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3498305DD6;
        Tue, 10 Dec 2019 18:30:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2305929DB7785; Tue, 10 Dec 2019 18:32:09 +0100 (CET)
Date:   Tue, 10 Dec 2019 18:32:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -tip 1/2] x86/alternative: Sync bp_patching update for
 avoiding NULL pointer exception
Message-ID: <20191210173209.GP2844@hirez.programming.kicks-ass.net>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483421229.25881.15314414408559963162.stgit@devnote2>
 <20191209143940.GI2810@hirez.programming.kicks-ass.net>
 <20191211014401.2f0c27f259a83d1f32aa6f2e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211014401.2f0c27f259a83d1f32aa6f2e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 01:44:01AM +0900, Masami Hiramatsu wrote:

> This looks good, but I feel it is a bit complicated.
> 
> If we use atomic (and spin-wait) here, can we use atomic_inc_not_zero()
> in the poke_int3_handler() at first for making sure the bp_batching is
> under operation or not?
> I think it makes things simpler, like below.
> 
> ---------
> atomic_t bp_refcnt;
> 
> poke_int3_handler()
> {
> 	smp_rmb();
> 	if (!READ_ONCE(bp_patching.nr_entries))
> 		return 0;
> 	if (!atomic_inc_not_zero(&bp_refcnt))
> 		return 0;
> 	smp_mb__after_atomic();
> 	[use bp_patching]
> 	atomic_dec(&bp_refcnt);
> }
> 
> text_poke_bp_batch()
> {
> 	bp_patching.vec = tp;
> 	bp_patching.nr_entries = nr_entries;
> 	smp_wmb();
> 	atomic_inc(&bp_refcnt);
> 	...
> 	atomic_dec(&bp_refcnt);
> 	/* wait for all running poke_int3_handler(). */
> 	atomic_cond_read_acquire(&bp_refcnt, !VAL);
> 	bp_patching.vec = NULL;
> 	bp_patching.nr_entries = 0;
> }

I feel that is actually more complicated...  Let me try to see if I can
simplify things.
