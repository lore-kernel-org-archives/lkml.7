Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B45C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B582148E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlvdrSIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfDCIIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:08:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oZjPV8oWUa6XiQbycdnKQnPe90Y17J4aTwcP/iWRVO8=; b=mlvdrSIzLRpXlpGOuPJFPRQp4
        ZoOJB8hGPAHFQ8twdANBRRK1VvfSScVJZG4NxQNTlC90/1Y5AVEyCbmyaQFijylJXD/pBqunjymSx
        Pc7AKO9AcZ1nIvRZnBNep96ymlR/TBUcjXw2mAmCcNA1XqdrfRa/Xk9vwfABRUgmJgD7HkrmKaU26
        S9bQ0S3XhxL8dkn3FLKLCLpHVO0CeSZCIyBbkjnoVJ7iW840J0OJFfSO7sJPakg1tpMXASI+ErACo
        ziEJ3kSPaU+rIGao6gghU4fuAYPaJW3VxH7RHMMkt/w/UZc/TsF9trZ6cje0zhyYLNqZeHmpXIZFi
        mwOTAlavg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBawf-0002hr-SU; Wed, 03 Apr 2019 08:08:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E3B4213A0C8E; Wed,  3 Apr 2019 10:08:28 +0200 (CEST)
Date:   Wed, 3 Apr 2019 10:08:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
Message-ID: <20190403080828.GN12232@hirez.programming.kicks-ass.net>
References: <20190331214020.836098943@linutronix.de>
 <20190331215136.039902969@linutronix.de>
 <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
 <20190402154329.scp7i7uqevubgwrz@treble>
 <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <20190402155149.c23ivzzc5hyykokl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402155149.c23ivzzc5hyykokl@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:51:49AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 02, 2019 at 05:48:56PM +0200, Thomas Gleixner wrote:
> > > With the above "(stk <= begin || stk >= end)" check, removing the loop
> > > becomes not all that important since exception stack dumps are quite
> > > rare and not performance sensitive.  With all the macros this code
> > > becomes a little more obtuse, so I'm not sure whether removal of the
> > > loop is a net positive.
> > 
> > What about perf? It's NMI context and probably starts from there. Peter?
> 
> I believe perf unwinds starting from the regs from the context which was
> interrupted by the NMI.

Aah, indeed. So then we only see exception stacks when the NMI lands in
an exception, which is, as you say, quite rare.
