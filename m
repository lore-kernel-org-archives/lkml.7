Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70EEC7E0AA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FE824765
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1wCCxb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfLMSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:43:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfLMSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pkImJBBvliE70238gLCg6578RnUPD1ZFNbwgEjyiYoA=; b=q1wCCxb5rghazlgxhc6QBLvA2
        gKon44zWeBj7+PsPXKqnK+2o/BTcZeRF+w6r+/ZauOz91jaVrxM+irJQGd+sUbzoWN6h6ZhrdWm4l
        ydQb1WY1zC+K5GiwqcsessaYF47m7zssNToRRl8bRy6/SuYUwdWSh//89kspF14QaQnxuz4PGkk7c
        c9I1LqxqfXd8SqAJLT7HCQ4V9fccASwVb9MUUZo6RDPTOqxi7ydXXoLSFJbw/o2IwSYH3mfKMQEv4
        n8GRwFRban1mplWjhovOYnNVR5JoObXZx29AkHuMLa5VO84UC18qt5eKahtzmsOElaNIdPzhb8OBj
        NeO7kT9Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifpuY-0000zH-2d; Fri, 13 Dec 2019 18:43:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D7723058B4;
        Fri, 13 Dec 2019 19:42:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DA6629D73AB3; Fri, 13 Dec 2019 19:43:32 +0100 (CET)
Date:   Fri, 13 Dec 2019 19:43:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
Message-ID: <20191213184332.GK2871@hirez.programming.kicks-ass.net>
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


modified version that assumes MAX_BLOCKS <= 15bit, if it is more, you
need the 2 entry version of it, but I suppose you get the idea.

On Fri, Dec 13, 2019 at 11:25:25AM +0100, Peter Zijlstra wrote:

> An implementation would be something along these lines (completely
> untested, fresh from the keyboard):
> 
> struct chain_block {
> 	int size;
> 	int base;
> 	struct chain_block *next;
> };
> 
> struct chain_block chain_blocks[MAX_BLOCKS];
> struct chain_block *free_blocks;

- struct chain_block init_block = {
- 	.size = MAX_LOCKDEP_CHAIN_HLOCKS,
- 	.base = 0,
- 	.next = NULL,
- };

- struct chain_block *free_list[MAX_BUCKETS] = {
- 	&init_block, /* 0 */
- };

+ struct chain_block *free_list;

> void free_block(struct chain_block *b)
> {
> 	b->next = free_blocks;
> 	free_blocks = b;
> }
> 
> struct chain_block *alloc_block(void)
> {
> 	struct chain_block *block = free_blocks;
> 	free_blocks = block->next;
> 	return block;
> }
> 
> struct chain_block *pop_block(struct chain_block **bp)
> {
> 	struct chain_block *b = *bp;
> 	if (!b)
> 		return NULL;
> 	*bp = b->next;
> }
> 
> void push_block(struct chain_block **bp, struct chain_block *b)
> {
	u16 idx = (b - chain_blocks) | BIT(15);

+	chain_hlock[b->base] = idx;
+	chain_block[b->base + b->size - 1] = idx;

> 	b->next = *bp;
> 	*bp = b;
> }
> 
> /* could contemplate ilog2() buckets */
> int size2bucket(int size)
> {
> 	return size >= MAX_BUCKET ? 0 : size;
> }
> 
> /* bucket[0] is mixed size */
> struct chain_block *pop_block_0(struct chain_block **bp, int size)
> {
> 	struct chain_block **p = bp, *b = *bp;
> 	if (!b)
> 		return NULL;
> 
> 	p = bp;
> 	while (b && b->size < size) {
> 		p = &b->next;
> 		b = b->next;
> 	}
> 	if (!b)
> 		return NULL;
> 
> 	*p = b->next;
> 	return b;
> }
> 
> u16 *alloc_chain(int size)
> {
> 	int i, bucket = size2bucket(size);
> 	struct chain_block *b;
> 	u16 *chain;
> 
> 	if (!bucket) {
> 		b = pop_block_0(&free_list[0], size);
> 		if (b)
> 			goto got_block;
> 	} else {
> 		b = pop_block(&free_list[bucket]);
> 		if (b)
> 			goto got_block;
> 
> 		/* pop a large block, hope the fragment is still useful */
> 		b = pop_block_0(&free_list[0], size);
> 		if (b)
> 			goto got_block;
> 
> 		for (i = MAX_BUCKETS-1; i > bucket; i--)
> 			b = pop_block(&free_list[bucket]);
> 			if (b)
> 				goto got_block;
> 		}
> 	}
> 	return NULL;
> 
> got_block:
> 
> 	chain = chain_hlocks + b->base;
> 	b->base += size;
> 	b->size -= size;
> 
> 	if (b->size) {
> 		/* return the fragment */
> 		bucket = size2bucket(b->size);
> 		push_block(&free_list[bucket], b);
> 	} else {
> 		free_block(b);
> 	}
> 
> 	return chain;
> }
> 
> void free_chain(int size, u16 *chain)
> {
- 	struct chain_block *b = alloc_block();
- 	int bucket = size2bucket(size);

+	struct chain_block *b = NULL, *p = NULL, *n = NULL;
+	int base = chain - chain_hlocks;
+	u16 p_idx, n_idx;
+	int bucket;

	p_idx = chain_hlocks[base - 1];
	n_idx = chain_hlocks[base + size];

	if (p_idx & BIT(15)) {
		p = chain_blocks[p_idx & ~BIT(15)];
		bucket = size2bucket(p->size);

		// find and remove @p from @bucket

		p->size += size; // merge with prev
		b = p;
	}

	if (n_idx & BIT(15)) {
		n = chain_blocks[n_idx & ~BIT(15)];
		bucket = size2bucket(n->size);

		// find and remove @n from @bucket

		if (p) {
			p->size += n->size;
			free_block(n);
			n = NULL;
		} else {
			n->base -= size;
			b = n;
		}
	}
		
	if (!b) {
		b = alloc_bucket();
		if (!b) {
			// leak stuff
			return;
		}

		b->size = size;
		b->base = base;
	}
	
- 	if (!b) {
- 		// leak stuff;
- 		return;
- 	}
- 
- 	b->size = size;
- 	b->base = chain - chain_hlocks;

	bucket = size2bucket(b->size);

> 	push_bucket(&free_list[bucket], b);
> }
> 
> void init_blocks(void)
> {
> 	int i;

	chain_blocks[0].size = MAX_LOCKDEP_CHAIN_HLOCKS;
	chain_blocks[0].base = 0;
	chain_blocks[0].next = NULL;

	free_list[0] = &chain_blocks[0];

> 	for (i = 1; i < MAX_BLOCKS; i++)
> 		free_block(chain_blocks[i]);
> }
