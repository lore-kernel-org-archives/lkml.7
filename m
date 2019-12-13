Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EBDC7DBA8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E4B246EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZc274Lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfLMSNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:13:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nvJKkuuUpA7IOdjgxThavLGGgjF1c2RnRQtKXoSXgV4=; b=LZc274LqerX9tszvjBBjF8Y7Q
        2RrM5UKXVTCUhff2SxcdqgCjM5v+TvN1crMfU+2uMX7F23V2NhNxYcbtf4TKxD9pR9n14S/PSkuOx
        PL1Ll3oHDe5uUx7o9v+9FWK4V9cEKEsBZaC0rbSHjzc4ebg3Qa2O8Nu+By8r7ZJCSufsiW7KouJSP
        pMdxQEw2j2TT4wFguf0B8zIgSlMuYh8KMoZMTTNAvL2vzA1luosjrErc8wCXa7Dg2y6/8gfXTDKfp
        fBXplDlDvPtBkKRDJtBst4btxtVygMHAhUeXmpMluaONRMu5CJzffHR8AlPX19YDQNAOXAGl/L39f
        Fs2eQPsHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifpQw-0001fI-4G; Fri, 13 Dec 2019 18:12:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3DE5304637;
        Fri, 13 Dec 2019 19:11:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DD9029D73AA2; Fri, 13 Dec 2019 19:12:55 +0100 (CET)
Date:   Fri, 13 Dec 2019 19:12:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
Message-ID: <20191213181255.GF2844@hirez.programming.kicks-ass.net>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
 <20191213102525.GA2844@hirez.programming.kicks-ass.net>
 <20191213105042.GJ2871@hirez.programming.kicks-ass.net>
 <9a79ef1a-96e0-1fd7-97e8-ef854b08524d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a79ef1a-96e0-1fd7-97e8-ef854b08524d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:02:46AM -0500, Waiman Long wrote:

> That is an interesting idea. It will eliminate the need of a separate
> array to track the free chain_hlocks. However, if there are n chains
> available, it will waste about 3n bytes of storage, on average.
> 
> I have a slightly different idea. I will enforce a minimum allocation
> size of 2. For a free block, the first 2 hlocks for each allocation
> block will store a 32-bit integer (hlock[0] << 16)|hlock[1]:
> 
> Bit 31: always 1
> Bits 24-30: block size
> Bits 0-23: index to the next free block.

If you look closely at the proposed allocator, my blocks can be much
larger than 7 bit. In fact, it start with a single block of
MAX_LOCKDEP_CHAIN_HLOCKS entries.

That said; I don't think you need to encode the size at all. All we need
to do is encode the chain_blocks[] index (and stick init_block in that
array). That should maybe even fit in a single u16.

Also, if we store that in the first and last 'word' of the free range,
we can detect both before and after freespace.

> In this way, the wasted space will be k bytes where k is the number of
> 1-entry chains. I don't think merging adjacent blocks will be that
> useful at this point. We can always add this capability later on if it
> is found to be useful.

I'm thinking 1 entry isn't much of a chain. My brain is completely fried
atm, but are we really storing single entry 'chains' ? It seems to me we
could skip that.
