Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E626F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DblUgg0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfDOQVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:21:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35452 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dqrr3CkKLNtBh20lOnWpTx6Xh80kM8mkgkJB9rxuKGI=; b=DblUgg0MVlMFn4rxcAawPMN+F
        TTxfsfdlN/NB9IQmbQ+z7EYh3FUkUMjyfaEr4KBvUmjxvJV4AEeqdJ1Ww94IEJWE9TDhfntSUaN//
        yhCEq2IHFDqVtkuDmwIOo+0tn5uXKe3W17J8mOr6NqEFaJXJXS7pY9KiQ7MGRzSIz+/ijlmsfzced
        OoTxgxlivoKoLopk1LpuNi9hqFFjOJOniWxryojabFVtvaZyKpRBq3urR6vxaslOC+7cL1ik+tTYi
        Gyf8rcyznvXlJnBxpyPDQI6t3VK1j/OqZfzjOZAPb2z0Myimzi80omeqcGv/vXige5WVA5K41Nxkr
        ZQGodA+0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG4Mf-0002yi-Rj; Mon, 15 Apr 2019 16:21:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B5FA29AD7C3D; Mon, 15 Apr 2019 18:21:48 +0200 (CEST)
Date:   Mon, 15 Apr 2019 18:21:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch V4 01/32] mm/slab: Fix broken stack trace storage
Message-ID: <20190415162148.GM4038@hirez.programming.kicks-ass.net>
References: <20190414155936.679808307@linutronix.de>
 <20190414160143.591255977@linutronix.de>
 <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com>
 <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
 <20190415132339.wiqyzygqklliyml7@treble>
 <alpine.DEB.2.21.1904151804460.1895@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904151804460.1895@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:07:44PM +0200, Thomas Gleixner wrote:
> On Mon, 15 Apr 2019, Josh Poimboeuf wrote:
> > > +		struct stack_trace trace = {
> > > +			/* Leave one for the end marker below */
> > > +			.max_entries	= size - 1,
> > > +			.entries	= addr,
> > > +			.skip		= 3,
> > > +		};

> > Looks like stack_trace.nr_entries isn't initialized?  (though this code
> > gets eventually replaced by a later patch)
> 
> struct initializer initialized the non mentioned fields to 0, if I'm not
> totally mistaken.

Correct.
