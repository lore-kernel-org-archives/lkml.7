Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50D21655
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XRXXgMyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLMKux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:50:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfLMKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q5DQxAJLrLVWg5ivxLEzpBD4naGajuYEDSDd+WWD1Y4=; b=XRXXgMyrrIXAD436q7gDE5EWE
        RhzbJvXTe0skdhba68KzUYI1DfFOm16rs168gCyYAcSQfsUAR16a9xHGEM1M6OTY+fs7LljW51RTq
        Vag8A6SZQxvPPrHAJVmRQnroSAlPRMZNozqeufXkFNNIHameoEFdDixHTRQsYfobDxadUkW5qzrfC
        x6KxLhIKCfaaCaGWN6h4VxNwiUmeGOqFwPQ5VMwPBK9PfMLxCND7lAR202w6nkKdFjgy25iBrkKqu
        jFoiGw0py8GutTLqB9Clbk8QZob3CSFvSinGi1V5Z/bLdY6vOmro47ee7io75fK9Cvype9u2so99+
        iBNEwAMpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifiWy-0002Nu-5S; Fri, 13 Dec 2019 10:50:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31775304637;
        Fri, 13 Dec 2019 11:49:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E35812B19B3AD; Fri, 13 Dec 2019 11:50:42 +0100 (CET)
Date:   Fri, 13 Dec 2019 11:50:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
Message-ID: <20191213105042.GJ2871@hirez.programming.kicks-ass.net>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
 <20191213102525.GA2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213102525.GA2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:25:25AM +0100, Peter Zijlstra wrote:

> void push_block(struct chain_block **bp, struct chain_block *b)
> {
> 	b->next = *bp;
> 	*bp = b;
> }
> 
> /* could contemplate ilog2() buckets */
> int size2bucket(int size)
> {
> 	return size >= MAX_BUCKET ? 0 : size;
> }

If you make the allocation granularity 4 entries, then you can have
push_block() store the chain_block * at the start of every free entry,
which would enable merging adjecent blocks.

That is, if I'm not mistaken these u16 chain entries encode the class
index (per lock_chain_get_class()). And since the lock_classes array is
MAX_LOCKDEP_KEYS, or 13 bits, big, we have the MSB of each entry spare.

union {
	struct {
		u16 hlock[4];
	}
	u64 addr;
} ponies;

So if we make the rule that:

	!(idx % 4) && (((union ponies *)chain_hlock[idx])->addr & BIT_ULL(63))

encodes a free block at said addr, then we should be able to detect if:

	chain_hlock[b->base + b->size]

is also free and merge the blocks.

(we just have to fix up the MSB of the address, not all arches have
negative addresses for kernel space)
