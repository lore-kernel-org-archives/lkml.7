Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306CC34010
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23969246D0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM3x7IBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfLMPCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:02:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24647 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727499AbfLMPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576249354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHXpTUcPw2SpnBmWlIQHCjEfMqdBse48PD3viLk8Sfs=;
        b=LM3x7IBgPzG5ylnuL/kpFxa85kx3x4zAv2prSmzXUWVR+Mi+Yl8xX0CoA7PGC4+d37FOj5
        udW5SdU7heJR1X7tVXLUrQIxSE378j4BfxzHqmLdfmlLpWg1vLgsxj2NVOCFnDtof47bRp
        yMfhR3MLNoSquOphhwca9+uwgWIUJMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-5acyVH6yPoawh8q1UP2JtQ-1; Fri, 13 Dec 2019 10:02:30 -0500
X-MC-Unique: 5acyVH6yPoawh8q1UP2JtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77E401005502;
        Fri, 13 Dec 2019 15:02:29 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-140.rdu2.redhat.com [10.10.122.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0B6619C4F;
        Fri, 13 Dec 2019 15:02:26 +0000 (UTC)
Subject: Re: [PATCH 4/5] locking/lockdep: Reuse free chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191212223525.1652-1-longman@redhat.com>
 <20191212223525.1652-5-longman@redhat.com>
 <20191213102525.GA2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d639c80c-d60f-d5ac-8559-7942798dc92e@redhat.com>
Date:   Fri, 13 Dec 2019 10:02:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191213102525.GA2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 5:25 AM, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 05:35:24PM -0500, Waiman Long wrote:
>
>> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
>> index 4c23ab7d27c2..999cd714e0d1 100644
>> --- a/kernel/locking/lockdep_internals.h
>> +++ b/kernel/locking/lockdep_internals.h
>> @@ -107,8 +107,15 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>>  #endif
>>  
>>  #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
>> -
>>  #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
>> +#define MAX_CHAIN_HLOCKS_BLOCKS	1024
>> +#define CHAIN_HLOCKS_HASH	8
>> +
>> +struct chain_hlocks_block {
>> +	unsigned int		   depth: 8,
>> +				   base :24;
>> +	struct chain_hlocks_block *next;
>> +};
>>  
>>  extern struct list_head all_lock_classes;
>>  extern struct lock_chain lock_chains[];
> This doesn't need to be in the header, there are no users outside of the
> stuff you wrote below.
>
That is true.
>> +#ifdef CONFIG_PROVE_LOCKING
>> +static struct chain_hlocks_block chain_hlocks_blocks[MAX_CHAIN_HLOCKS_BLOCKS];
>> +static struct chain_hlocks_block *chain_hlocks_block_hash[CHAIN_HLOCKS_HASH];
>> +static struct chain_hlocks_block *free_chain_hlocks_blocks;
>> +
>> +/*
>> + * Graph lock must be held before calling the chain_hlocks_block functions.
>> + * Chain hlocks of depth 1-(CHAIN_HLOCKS_HASH-1) is mapped directly to
>> + * chain_hlocks_block_hash[1-(CHAIN_HLOCKS_HASH-1)]. All other sizes
>> + * are mapped to chain_hlocks_block_hash[0].
>> + */
>> +static inline struct chain_hlocks_block *alloc_chain_hlocks_block(void)
>> +{
>> +	struct chain_hlocks_block *block = free_chain_hlocks_blocks;
>> +
>> +	WARN_ONCE(!debug_locks_silent && !block,
>> +		  "Running out of chain_hlocks_block\n");
>> +	free_chain_hlocks_blocks = block ? block->next : NULL;
>> +	return block;
>> +}
>> +
>> +static inline void free_chain_hlocks_block(struct chain_hlocks_block *block)
>> +{
>> +	block->next = free_chain_hlocks_blocks;
>> +	free_chain_hlocks_blocks = block;
>> +}
>> +
>> +static inline void push_chain_hlocks_block(struct chain_hlocks_block *block)
>> +{
>> +	int hash, depth = block->depth;
>> +
>> +	hash = (depth >= CHAIN_HLOCKS_HASH) ? 0 : depth;
>> +	block->next = chain_hlocks_block_hash[hash];
>> +	chain_hlocks_block_hash[hash] = block;
>> +	nr_free_chain_hlocks += depth;
>> +}
> I would argue this is not a hash, these are buckets. You're doing
> regular size buckets.

I think I used the wrong terminology here. Bucket is a better description.


>
>> +static inline struct chain_hlocks_block *pop_chain_hlocks_block(int depth)
>> +{
>> +	struct chain_hlocks_block *curr, **pprev;
>> +
>> +	if (!nr_free_chain_hlocks)
>> +		return NULL;
>> +
>> +	if (depth < CHAIN_HLOCKS_HASH) {
>> +		curr = chain_hlocks_block_hash[depth];
>> +		if (curr) {
>> +			chain_hlocks_block_hash[depth] = curr->next;
>> +			nr_free_chain_hlocks -= depth;
>> +		}
>> +		return curr;
>> +	}
>> +
>> +	/*
>> +	 * For depth >= CHAIN_HLOCKS_HASH, it is not really a pop operation.
>> +	 * Instead, the first entry with the right size is returned.
>> +	 */
>> +	curr  = chain_hlocks_block_hash[0];
>> +	pprev = chain_hlocks_block_hash;
>> +
>> +	while (curr) {
>> +		if (curr->depth == depth)
>> +			break;
>> +		pprev = &(curr->next);
>> +		curr = curr->next;
>> +	}
>> +
>> +	if (curr) {
>> +		*pprev = curr->next;
>> +		nr_free_chain_hlocks -= depth;
>> +	}
>> +	return curr;
>> +}
>> +#else
>> +static inline void free_chain_hlocks_block(struct chain_hlocks_block *block) { }
>> +static inline struct chain_hlocks_block *pop_chain_hlocks_block(int depth)
>> +{
>> +	return NULL;
>> +}
>> +#endif /* CONFIG_PROVE_LOCKING */
> You've made a bit of a mess of things though. Why is that push/pop crud
> exposed? Why didn't you build a self contained allocator?
>
> All you really want is:
>
> u16 *alloc_chain(int size);
> void free_chain(int size, u16 *chain);
>
>
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
>
>
> struct chain_block init_block = {
> 	.size = MAX_LOCKDEP_CHAIN_HLOCKS,
> 	.base = 0,
> 	.next = NULL,
> };
>
> struct chain_block *free_list[MAX_BUCKETS] = {
> 	&init_block, /* 0 */
> };
>
>
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
> 	struct chain_block *b = alloc_block();
> 	int bucket = size2bucket(size);
>
> 	if (!b) {
> 		// leak stuff;
> 		return;
> 	}
>
> 	b->size = size;
> 	b->base = chain - chain_hlocks;
>
> 	push_bucket(&free_list[bucket], b);
> }
>
> void init_blocks(void)
> {
> 	int i;
>
> 	for (i = 0; i < MAX_BLOCKS; i++)
> 		free_block(chain_blocks[i]);
> }
>
Thanks for the suggestion. I will incorporate your idea in the next
version of the patch.

Cheers,
Longman

