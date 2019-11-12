Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929A9222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qik0ZHa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKLWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:25:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57782 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d8f0soa0yTZkhnVBvXezc7PxaJxfMJk5hgjY8nKMTR4=; b=Qik0ZHa7KWlZiA2rEKuOGf3nq
        4Wsg7gSffcSsLwSSJ7bZA7pqoENPp8t6q4ckrB7c4WqVnimAcLSxJyykQc7cBhGwzoUGgStAtRDWi
        GwtyMEnTZNeiqGcckhC04URnur9Z7Ry5+zihzwKyMc+JskDiFAJSshi9H0qLaCM3TUo+aZ5wheRtP
        8jxMDRgEFa74OYWr8OX2MunE9La3WsX6O1Bv8CaMJP3WoqqFDZoioeAvG1vDdF+qL1IWZ1Bsuj/rD
        mzYCvsRkEvhkDrG+tob7mdS/mv34d/NDy+76IA0HkaEBWh5e1zBn8GeMPEoxJ8/rT9tLFP8kD/yjP
        4Kmsl8eLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUebO-0000Q9-Gf; Tue, 12 Nov 2019 22:25:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EBA83056C8;
        Tue, 12 Nov 2019 23:24:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AE4620261852; Tue, 12 Nov 2019 23:25:33 +0100 (CET)
Date:   Tue, 12 Nov 2019 23:25:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 04/17] x86/alternatives: Add and use text_gen_insn()
 helper
Message-ID: <20191112222533.GC4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132457.703538332@infradead.org>
 <20191112121028.3ef25207@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112121028.3ef25207@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 12:10:28PM -0500, Steven Rostedt wrote:
> On Mon, 11 Nov 2019 14:12:56 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
> > +{
> > +	static union text_poke_insn insn; /* text_mutex */
> > +	int size = 0;
> > +
> > +	lockdep_assert_held(&text_mutex);
> > +
> > +	insn.opcode = opcode;
> > +
> > +#define __CASE(insn)	\
> > +	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
> > +
> > +	switch(opcode) {
> > +	__CASE(INT3);
> > +	__CASE(CALL);
> > +	__CASE(JMP32);
> > +	__CASE(JMP8);
> > +	}
> > +
> > +	if (size > 1) {
> > +		insn.disp = (long)dest - (long)(addr + size);
> > +		if (size == 2)
> 
> Could we add a comment here. It took me a little bit to figure out why
> you have this BUG_ON().

:-)

Sure, I'll add something like:

			/*
			 * Ensure that for JMP.d8 the displacement
			 * actually fits the signed byte.
			 */

> > +			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
> > +	}
> > +
> > +	return &insn.text;
> > +}
