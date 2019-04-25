Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D815C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50A6217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KqwenI2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfDYKWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:22:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDYKWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LkolO5taBVs8THus8l4rmFbZgwW8DG+31ulE6mh/IpA=; b=KqwenI2JUsDtJI80PRTy8Ge0Z
        FBmdx8ItgqZeZ5zwAt+7iIIzatkoT+yE37umBSuMRKt8o/ECl7Tw+fb7bQmeET/4STG2laWhlHDdv
        Mkx6LNdl2WSARDz6V36vciV+KoAme4e5baNQr2Otm+HaV8ax05BbaYiVYlA+ywmga3jBZ8MrHSTYU
        2imGUOMmTpclqEbZEk7r9LjLac7WhAwvVNVY8Ae1phzV4GyEoC/FPjE6TU6iVEpgpcCNKQ3693OEq
        ftbjohl3fcy04oYSwuBMrlaQdOiZ7dS42KJ6UYBTxIyKbzKggWjSt25btShDVnRRMjusiFGoAmXGs
        jgdX9LzSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJbW9-0002fD-Du; Thu, 25 Apr 2019 10:22:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CA0A2395002B; Thu, 25 Apr 2019 12:22:10 +0200 (CEST)
Date:   Thu, 25 Apr 2019 12:22:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_call()
Message-ID: <20190425102210.GM4038@hirez.programming.kicks-ass.net>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com>
 <20190425091717.GA72229@gmail.com>
 <20190425092131.GL4038@hirez.programming.kicks-ass.net>
 <20190425095039.GC115378@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425095039.GC115378@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:50:39AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Apr 25, 2019 at 11:17:17AM +0200, Ingo Molnar wrote:
> > > It basically means that we silently won't do any patching and the kernel 
> > > will crash later on in mysterious ways, because paravirt patching is 
> > > usually relied on.
> > 
> > That's OK. The compiler emits an indirect CALL/JMP to the pv_ops
> > structure contents. That _should_ stay valid and function correctly at
> > all times.
> 
> It might result in a correctly executing kernel in terms of code 
> generation, but it doesn't result in a viable kernel: some of the places 
> rely on the patching going through and don't know what to do when it 
> doesn't and misbehave or crash in interesting ways.
> 
> Guess how I know this. ;-)

What sites would that be? It really should work AFAIK.
