Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B2920866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uyrcnoo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfLTUNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:13:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dLcmpRz2dHxIctx3Z0LJU9fWsVWtkTbestp9wAL4NSU=; b=Uyrcnoo7yYQv0BouG+Pl9Xs23
        g1GITmgl53QOxA7Bb9pvmNKrh90wMCE9ERj7MHfKmCemjC4JwFOns5WCzth2f0hfkBBaB2RDz1bkL
        1E6eqfGCKfVH7BJmb5OtfZSfLC0OoFeBe9Ixv9k+6TCtdCakxZkD8o3xA40fT9bU33WytdX6aL/A7
        QJ6Qo2P5Swsq1KUGuze/Xiuh9dS/NpBa5OXEioNGPQ97foMkovsQLzqRLz1mX2b8L76lpm/KqcptJ
        Ob9Fj87w4QKf0hBWALkDj6dikE4NOCDr52N8xyBIPO5yY5WaMSWjYqpP2CM9Cd5HZEWl3g7cTtjuy
        qZRQPv/bw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiOeC-0003nW-M2; Fri, 20 Dec 2019 20:13:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDE52300DB7;
        Fri, 20 Dec 2019 21:11:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E7352024479A; Fri, 20 Dec 2019 21:13:14 +0100 (CET)
Date:   Fri, 20 Dec 2019 21:13:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rxrpc: struct mutex cannot be used for
 rxrpc_call::user_mutex
Message-ID: <20191220201314.GS2827@hirez.programming.kicks-ass.net>
References: <157659672074.19580.11641288666811539040.stgit@warthog.procyon.org.uk>
 <20191218135047.GS2844@hirez.programming.kicks-ass.net>
 <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
 <20191218202801.wokf6hcvbafmjnkd@linux-p48b>
 <20191219090535.GV2844@hirez.programming.kicks-ass.net>
 <20191219174417.jax2fy3fvrvrrpsq@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219174417.jax2fy3fvrvrrpsq@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 09:44:17AM -0800, Davidlohr Bueso wrote:
> On Thu, 19 Dec 2019, Peter Zijlstra wrote:
> 
> > Automate what exactly?
> 
> What I meant was automating finding cases that are 'false positives' such
> as rxrpc and kexec _before_ re-adding the warn.

I suppose we can keep the WARN patch in a -next enabled branch for a
while, without it nessecarily going into linus' tree on the next
release.

That does require people actually testing -next, which seems somewhat
optimistic.

Alternatively, you can try your hand at smatch ...
