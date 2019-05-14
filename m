Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3271C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yufZ3579"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENQ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:56:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QEzjc5Av74DO6+A4a5nv3t2hw4nojszLXPYtxmG0GVc=; b=yufZ3579mTxJxqVm3UxjtQD5j
        G8gnyWLZ5h5cEkEO2hNZMzp8py+tonmJgQolp3P05OwN049WGISW3OsAuqrUyIA/zfBum0nxgptif
        toCmg+dlWfxO+b5fjFDTOMTKs6IGnHSidITxnShgHAQFw55M4sZH75X0FtdN6Y58kgTir44IqKXQ+
        L20srlxad08fg4EnlYlOwdJYhYtUIDzxJxAoWNRCRG5pzAeaoUe6FXVd/Ts/QWiWVLlC+T4WKLhm+
        h5ItBx83ee2mkL0+wlF+jTgE2QHagl6e202XlHLleqZHHazKHE0z39jOiu+aEv1JahvvjWNjnTWzj
        b0L9Pb4ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQaiu-0000rQ-7W; Tue, 14 May 2019 16:56:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BBDA2029F888; Tue, 14 May 2019 18:56:14 +0200 (CEST)
Date:   Tue, 14 May 2019 18:56:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     huangpei@loongson.cn, Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Message-ID: <20190514165614.GV2623@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <20190425091258.GC14281@hirez.programming.kicks-ass.net>
 <20190514155813.GG2677@hirez.programming.kicks-ass.net>
 <CAHk-=wgxT24Z6Ba_4DKbMfBnQ0Cp4gzwp6Vq1aBkU5bsjqKUhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxT24Z6Ba_4DKbMfBnQ0Cp4gzwp6Vq1aBkU5bsjqKUhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 09:10:34AM -0700, Linus Torvalds wrote:
> On Tue, May 14, 2019 at 8:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > So if two variables share a line, and one is local while the other is
> > shared atomic, can contention on the line, but not the variable, cause
> > issues for the local variable?
> >
> > If not; why not? Because so far the issue is line granular due to the
> > coherence aspect.
> 
> If I understood the issue correctly, it's not that cache coherence
> doesn't work, it's literally that the sc succeeds when it shouldn't.
> 
> In other words, it's not going to affect anything else, but it means
> that "ll/sc" isn't actually truly atomic, because the cacheline could
> have bounced around to another CPU in the meantime.
> 
> So we *think* we got an atomic update, but didn't, and the "ll/sc"
> pair ends up incorrectly working as a regular "load -> store" pair,
> because the "sc' incorrectly thought it still had exclusive access to
> the line from the "ll".
> 
> The added memory barrier isn't because it's a memory barrier, it's
> just keeping the subsequent speculative instructions from getting the
> cacheline back and causing that "sc" confusion.
> 
> But note how from a cache coherency standpoint, it's not about the
> cache coherency being wrong, it's literally just about the ll/sc not
> giving the atomicity guarantees that the sequence is *supposed* to
> give. So an "atomic_inc()" can basically (under just the wrong
> circumstances) essentially turn into just a non-atomic "*p++".

Understood; the problem is that "*p++" is not good enough for local_t
either (on load-store architectures), since it needs to be "atomic" wrt
all other instructions on that CPU, most notably exceptions.

The issue has come up before in this thread; but I don't think it was
clearly answered before.

