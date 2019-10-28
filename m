Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B5CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB52E21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKOxV1my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbfJ1Qzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:55:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Qzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H+zZ/pHimBDhBBnI6Lvxg+HhhSJoDwfhbO80w+AkCs0=; b=bKOxV1myDjndo2kkGn3Qi918F
        CN4VqUX0k4OL6OJch7JXOWtqN4FILtRUK07WCShTpwdBSnoyai3rIYBVUFhaZfbdCK7lb41dBbBPM
        XNIV6lE1lSjukEJsLVqgTy7ilVBWnFJs6Oh4C6KIx5Uwu/00zk2yKJZYAFrjhiIXXdW2U+8Ado7EC
        pdUigELE1aZlAcdEAzRJ2mCAOt40ZJTuN9gBo1T8c4H0vCWT5DIlKzIBYZQ74KBw4voifAEL2UBnW
        gq6/MWPl7wN2P6f9sY9jXfaks/RovEpd/Rq+49FEJKYeL/JWp9BtO7Sq7bZGoTXFatWnGkrUnxLZ+
        84cP1++wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP8Ib-0008Fx-Uu; Mon, 28 Oct 2019 16:55:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAFFE300EBF;
        Mon, 28 Oct 2019 17:54:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0659020C4EA0B; Mon, 28 Oct 2019 17:55:20 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:55:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        rabin@rab.in, Mark Rutland <mark.rutland@arm.com>,
        james.morse@arm.com
Subject: Re: [PATCH v4 13/16] arm/ftrace: Use __patch_text_real()
Message-ID: <20191028165519.GF4114@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.687479693@infradead.org>
 <20191028162525.GF5576@willie-the-truck>
 <20191028163421.GI4097@hirez.programming.kicks-ass.net>
 <20191028164758.GH5576@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028164758.GH5576@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:47:59PM +0000, Will Deacon wrote:
> On Mon, Oct 28, 2019 at 05:34:21PM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 28, 2019 at 04:25:26PM +0000, Will Deacon wrote:
> > > On Fri, Oct 18, 2019 at 09:35:38AM +0200, Peter Zijlstra wrote:
> > > > @@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned l
> > > >  			return -EINVAL;
> > > >  	}
> > > >  
> > > > -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> > > > -		return -EPERM;
> > > > -
> > > > -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> > > > +	__patch_text_real((void *)pc, new, patch_text_remap);
> > > 
> > > Why can't you just pass 'true' for patch_text_remap? AFAICT, the only
> > > time you want to pass false is during early boot when the text is
> > > assumedly still writable without the fixmap.
> > 
> > Ah, it will also become true for module loading once we rework where we
> > flip the module text RO,X. See this patch:
> > 
> >   https://lkml.kernel.org/r/20191018074634.858645375@infradead.org
> > 
> > But for that to land, there's still a few other issues to fix (KLP).
> 
> Passing 'true' would still work though, right? Just feels a bit error
> prone having to maintain the state of patch_test_remap() and remember
> that 'ftrace_lock' is holding the concurrency together.

It should, provided your fixmap stuff is working when we do the early
stuff I suppose. Module loading will be a wee bit slower too, but I'm
not the person to care about that.
