Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20275C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7F82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vISN4ZUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLMKZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:25:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMKZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fQpuePhuHdsHfFjMSNRNk+qAJUyan+oz0DXuXdMrsXI=; b=vISN4ZUa1HVL5zZrMHlJo4Hle
        0cO9SlMdmTXy5HojuMrYU0oSuOI/XS2JhoNvk8VmWLc7BNPA8KiZua578SsxODWX17buxJ/qeYJWt
        jMXZ6vCOtOl/909c8eKAS9EGfMG1A42urcDXx5CqeFQlUS1k2N6/DTJSNJ4AhSd2ufdIj19DJpAMD
        y+MTQdffatwzPV9eyleeFL8sIYFdOB8DzYAm+5GcGGpC9ppR0nZHD7wYH9D3tSe+pRuhkwKDf6UbQ
        CX2HyCqYa9thzBGukY4FT4sT8KBQJXquLLiL+jFwiItKNoyngTkFhe0gle+d+FzAuByWGh9K1pzEx
        UlFe6BHaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifi8W-000268-50; Fri, 13 Dec 2019 10:25:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2E34304637;
        Fri, 13 Dec 2019 11:24:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50D852B19B3AD; Fri, 13 Dec 2019 11:25:25 +0100 (CET)
Date:   Fri, 13 Dec 2019 11:25:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
Message-ID: <20191213102525.GA2844@hirez.programming.kicks-ass.net>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212223525.1652-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 05:35:24PM -0500, Waiman Long wrote:

> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index 4c23ab7d27c2..999cd714e0d1 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -107,8 +107,15 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>  #endif
>  
>  #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
> -
>  #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
> +#define MAX_CHAIN_HLOCKS_BLOCKS	1024
> +#define CHAIN_HLOCKS_HASH	8
> +
> +struct chain_hlocks_block {
> +	unsigned int		   depth: 8,
> +				   base :24;
> +	struct chain_hlocks_block *next;
> +};
>  
>  extern struct list_head all_lock_classes;
>  extern struct lock_chain lock_chains[];

This doesn't need to be in the header, there are no users outside of the
stuff you wrote below.

> +#ifdef CONFIG_PROVE_LOCKING
> +static struct chain_hlocks_block chain_hlocks_blocks[MAX_CHAIN_HLOCKS_BLOCKS];
> +static struct chain_hlocks_block *chain_hlocks_block_hash[CHAIN_HLOCKS_HASH];
> +static struct chain_hlocks_block *free_chain_hlocks_blocks;
> +
> +/*
> + * Graph lock must be held before calling the chain_hlocks_block functions.
> + * Chain hlocks of depth 1-(CHAIN_HLOCKS_HASH-1) is mapped directly to
> + * chain_hlocks_block_hash[1-(CHAIN_HLOCKS_HASH-1)]. All other sizes
> + * are mapped to chain_hlocks_block_hash[0].
> + */
> +static inline struct chain_hlocks_block *alloc_chain_hlocks_block(void)
> +{
> +	struct chain_hlocks_block *block = free_chain_hlocks_blocks;
> +
> +	WARN_ONCE(!debug_locks_silent && !block,
> +		  "Running out of chain_hlocks_block\n");
> +	free_chain_hlocks_blocks = block ? block->next : NULL;
> +	return block;
> +}
> +
> +static inline void free_chain_hlocks_block(struct chain_hlocks_block *block)
> +{
> +	block->next = free_chain_hlocks_blocks;
> +	free_chain_hlocks_blocks = block;
> +}
> +
> +static inline void push_chain_hlocks_block(struct chain_hlocks_block *block)
> +{
> +	int hash, depth = block->depth;
> +
> +	hash = (depth >= CHAIN_HLOCKS_HASH) ? 0 : depth;
> +	block->next = chain_hlocks_block_hash[hash];
> +	chain_hlocks_block_hash[hash] = block;
> +	nr_free_chain_hlocks += depth;
> +}

I would argue this is not a hash, these are buckets. You're doing
regular size buckets.

> +static inline struct chain_hlocks_block *pop_chain_hlocks_block(int depth)
> +{
> +	struct chain_hlocks_block *curr, **pprev;
> +
> +	if (!nr_free_chain_hlocks)
> +		return NULL;
> +
> +	if (depth < CHAIN_HLOCKS_HASH) {
> +		curr = chain_hlocks_block_hash[depth];
> +		if (curr) {
> +			chain_hlocks_block_hash[depth] = curr->next;
> +			nr_free_chain_hlocks -= depth;
> +		}
> +		return curr;
> +	}
> +
> +	/*
> +	 * For depth >= CHAIN_HLOCKS_HASH, it is not really a pop operation.
> +	 * Instead, the first entry with the right size is returned.
> +	 */
> +	curr  = chain_hlocks_block_hash[0];
> +	pprev = chain_hlocks_block_hash;
> +
> +	while (curr) {
> +		if (curr->depth == depth)
> +			break;
> +		pprev = &(curr->next);
> +		curr = curr->next;
> +	}
> +
> +	if (curr) {
> +		*pprev = curr->next;
> +		nr_free_chain_hlocks -= depth;
> +	}
> +	return curr;
> +}
> +#else
> +static inline void free_chain_hlocks_block(struct chain_hlocks_block *block) { }
> +static inline struct chain_hlocks_block *pop_chain_hlocks_block(int depth)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_PROVE_LOCKING */

You've made a bit of a mess of things though. Why is that push/pop crud
exposed? Why didn't you build a self contained allocator?

All you really want is:

u16 *alloc_chain(int size);
void free_chain(int size, u16 *chain);


An implementation would be something along these lines (completely
untested, fresh from the keyboard):

struct chain_block {
	int size;
	int base;
	struct chain_block *next;
};

struct chain_block chain_blocks[MAX_BLOCKS];
struct chain_block *free_blocks;


struct chain_block init_block = {
	.size = MAX_LOCKDEP_CHAIN_HLOCKS,
	.base = 0,
	.next = NULL,
};

struct chain_block *free_list[MAX_BUCKETS] = {
	&init_block, /* 0 */
};


void free_block(struct chain_block *b)
{
	b->next = free_blocks;
	free_blocks = b;
}

struct chain_block *alloc_block(void)
{
	struct chain_block *block = free_blocks;
	free_blocks = block->next;
	return block;
}

struct chain_block *pop_block(struct chain_block **bp)
{
	struct chain_block *b = *bp;
	if (!b)
		return NULL;
	*bp = b->next;
}

void push_block(struct chain_block **bp, struct chain_block *b)
{
	b->next = *bp;
	*bp = b;
}

/* could contemplate ilog2() buckets */
int size2bucket(int size)
{
	return size >= MAX_BUCKET ? 0 : size;
}

/* bucket[0] is mixed size */
struct chain_block *pop_block_0(struct chain_block **bp, int size)
{
	struct chain_block **p = bp, *b = *bp;
	if (!b)
		return NULL;

	p = bp;
	while (b && b->size < size) {
		p = &b->next;
		b = b->next;
	}
	if (!b)
		return NULL;

	*p = b->next;
	return b;
}

u16 *alloc_chain(int size)
{
	int i, bucket = size2bucket(size);
	struct chain_block *b;
	u16 *chain;

	if (!bucket) {
		b = pop_block_0(&free_list[0], size);
		if (b)
			goto got_block;
	} else {
		b = pop_block(&free_list[bucket]);
		if (b)
			goto got_block;

		/* pop a large block, hope the fragment is still useful */
		b = pop_block_0(&free_list[0], size);
		if (b)
			goto got_block;

		for (i = MAX_BUCKETS-1; i > bucket; i--)
			b = pop_block(&free_list[bucket]);
			if (b)
				goto got_block;
		}
	}
	return NULL;

got_block:

	chain = chain_hlocks + b->base;
	b->base += size;
	b->size -= size;

	if (b->size) {
		/* return the fragment */
		bucket = size2bucket(b->size);
		push_block(&free_list[bucket], b);
	} else {
		free_block(b);
	}

	return chain;
}

void free_chain(int size, u16 *chain)
{
	struct chain_block *b = alloc_block();
	int bucket = size2bucket(size);

	if (!b) {
		// leak stuff;
		return;
	}

	b->size = size;
	b->base = chain - chain_hlocks;

	push_bucket(&free_list[bucket], b);
}

void init_blocks(void)
{
	int i;

	for (i = 0; i < MAX_BLOCKS; i++)
		free_block(chain_blocks[i]);
}
