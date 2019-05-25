Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F299C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2545920879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558822209;
	bh=VuyQV9yCcfmzDbrICJDTkT3K0+YFQkMCZif6CxZr9/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jMahEz6b1NJRV5lTcueGo7Id51Zee9yDvZbmZH3vRHYgNI6VWHZpoPC+4qJlG+ndR
	 fG9sZQW/Wr97fIkUQZZWVxtjpT0MqpVNhm6Rb3KgKLgNfWz6bHqX6zWcsSi+cFhudM
	 rFyuTLl11ibSgPqQpRmacv2pTUXZa2cEk3qqY/xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfEYWJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 18:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfEYWJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 18:09:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4322120815;
        Sat, 25 May 2019 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558822189;
        bh=VuyQV9yCcfmzDbrICJDTkT3K0+YFQkMCZif6CxZr9/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IQRUA5tkhswTF2Ciz/q+MUTYpYHiMtvkI3APccoGTImDGfdlv5vmiGY5LrGrHMTKN
         H/Or5yB8oZzFuI5ssnXzUeMz5mTrGxdtkgFwmp59zW2pqjrbHutRzawwgO5y8R4mCH
         PfjyYmoFSkzBP7IcoZi8FEjLWBDmxLPlonQLTcu8=
Date:   Sat, 25 May 2019 15:09:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Dan Streetman <ddstreet@ieee.org>,
        Oleksiy.Avramchenko@sony.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] z3fold: add inter-page compaction
Message-Id: <20190525150948.e1ff1a2a894ca8110abc8183@linux-foundation.org>
In-Reply-To: <20190524174918.71074b358001bdbf1c23cd77@gmail.com>
References: <20190524174918.71074b358001bdbf1c23cd77@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 17:49:18 +0200 Vitaly Wool <vitalywool@gmail.com> wrote:

> For each page scheduled for compaction (e. g. by z3fold_free()),
> try to apply inter-page compaction before running the traditional/
> existing intra-page compaction. That means, if the page has only one
> buddy, we treat that buddy as a new object that we aim to place into
> an existing z3fold page. If such a page is found, that object is
> transferred and the old page is freed completely. The transferred
> object is named "foreign" and treated slightly differently thereafter.
> 
> Namely, we increase "foreign handle" counter for the new page. Pages
> with non-zero "foreign handle" count become unmovable. This patch
> implements "foreign handle" detection when a handle is freed to
> decrement the foreign handle counter accordingly, so a page may as
> well become movable again as the time goes by.
> 
> As a result, we almost always have exactly 3 objects per page and
> significantly better average compression ratio.
> 
> ...
>
> +static inline struct z3fold_header *handle_to_z3fold_header(unsigned long);
> +static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *);

Forward-declaring inline functions is peculiar, but it does appear to work.

z3fold is quite inline-happy.  Fortunately the compiler will ignore the
inline hint if it seems a bad idea.  Even then, the below shrinks
z3fold.o text from 30k to 27k.  Which might even make it faster....

--- a/mm/z3fold.c~a
+++ a/mm/z3fold.c
@@ -185,8 +185,8 @@ enum z3fold_handle_flags {
 	HANDLES_ORPHANED = 0,
 };
 
-static inline struct z3fold_header *handle_to_z3fold_header(unsigned long);
-static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *);
+static struct z3fold_header *handle_to_z3fold_header(unsigned long);
+static struct z3fold_pool *zhdr_to_pool(struct z3fold_header *);
 static struct z3fold_header *__z3fold_alloc(struct z3fold_pool *, size_t, bool);
 static void add_to_unbuddied(struct z3fold_pool *, struct z3fold_header *);
 
@@ -205,7 +205,7 @@ static int size_to_chunks(size_t size)
 
 static void compact_page_work(struct work_struct *w);
 
-static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
+static struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 							gfp_t gfp)
 {
 	struct z3fold_buddy_slots *slots = kmem_cache_alloc(pool->c_handle,
@@ -220,17 +220,17 @@ static inline struct z3fold_buddy_slots
 	return slots;
 }
 
-static inline struct z3fold_pool *slots_to_pool(struct z3fold_buddy_slots *s)
+static struct z3fold_pool *slots_to_pool(struct z3fold_buddy_slots *s)
 {
 	return (struct z3fold_pool *)(s->pool & ~HANDLE_FLAG_MASK);
 }
 
-static inline struct z3fold_buddy_slots *handle_to_slots(unsigned long handle)
+static struct z3fold_buddy_slots *handle_to_slots(unsigned long handle)
 {
 	return (struct z3fold_buddy_slots *)(handle & ~(SLOTS_ALIGN - 1));
 }
 
-static inline void free_handle(unsigned long handle)
+static void free_handle(unsigned long handle)
 {
 	struct z3fold_buddy_slots *slots;
 	struct z3fold_header *zhdr;
@@ -423,7 +423,7 @@ static unsigned long encode_handle(struc
 	return (unsigned long)&slots->slot[idx];
 }
 
-static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
+static struct z3fold_header *__get_z3fold_header(unsigned long handle,
 							bool lock)
 {
 	struct z3fold_buddy_slots *slots;
@@ -648,7 +648,7 @@ static int num_free_chunks(struct z3fold
 }
 
 /* Add to the appropriate unbuddied list */
-static inline void add_to_unbuddied(struct z3fold_pool *pool,
+static void add_to_unbuddied(struct z3fold_pool *pool,
 				struct z3fold_header *zhdr)
 {
 	if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
@@ -664,7 +664,7 @@ static inline void add_to_unbuddied(stru
 	}
 }
 
-static inline void *mchunk_memmove(struct z3fold_header *zhdr,
+static void *mchunk_memmove(struct z3fold_header *zhdr,
 				unsigned short dst_chunk)
 {
 	void *beg = zhdr;
@@ -673,7 +673,7 @@ static inline void *mchunk_memmove(struc
 		       zhdr->middle_chunks << CHUNK_SHIFT);
 }
 
-static inline bool buddy_single(struct z3fold_header *zhdr)
+static bool buddy_single(struct z3fold_header *zhdr)
 {
 	return !((zhdr->first_chunks && zhdr->middle_chunks) ||
 			(zhdr->first_chunks && zhdr->last_chunks) ||
@@ -884,7 +884,7 @@ static void compact_page_work(struct wor
 }
 
 /* returns _locked_ z3fold page header or NULL */
-static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
+static struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 						size_t size, bool can_sleep)
 {
 	struct z3fold_header *zhdr = NULL;
_


>
> ...
>
> +static inline struct z3fold_header *__get_z3fold_header(unsigned long handle,
> +							bool lock)
> +{
> +	struct z3fold_buddy_slots *slots;
> +	struct z3fold_header *zhdr;
> +	unsigned int seq;
> +	bool is_valid;
> +
> +	if (!(handle & (1 << PAGE_HEADLESS))) {
> +		slots = handle_to_slots(handle);
> +		do {
> +			unsigned long addr;
> +
> +			seq = read_seqbegin(&slots->seqlock);
> +			addr = *(unsigned long *)handle;
> +			zhdr = (struct z3fold_header *)(addr & PAGE_MASK);
> +			preempt_disable();

Why is this done?

> +			is_valid = !read_seqretry(&slots->seqlock, seq);
> +			if (!is_valid) {
> +				preempt_enable();
> +				continue;
> +			}
> +			/*
> +			 * if we are here, zhdr is a pointer to a valid z3fold
> +			 * header. Lock it! And then re-check if someone has
> +			 * changed which z3fold page this handle points to
> +			 */
> +			if (lock)
> +				z3fold_page_lock(zhdr);
> +			preempt_enable();
> +			/*
> +			 * we use is_valid as a "cached" value: if it's false,
> +			 * no other checks needed, have to go one more round
> +			 */
> +		} while (!is_valid || (read_seqretry(&slots->seqlock, seq) &&
> +			(lock ? ({ z3fold_page_unlock(zhdr); 1; }) : 1)));
> +	} else {
> +		zhdr = (struct z3fold_header *)(handle & PAGE_MASK);
> +	}
> +
> +	return zhdr;
> +}
>
> ...
>
>  static unsigned short handle_to_chunks(unsigned long handle)
>  {
> -	unsigned long addr = *(unsigned long *)handle;
> +	unsigned long addr;
> +	struct z3fold_buddy_slots *slots = handle_to_slots(handle);
> +	unsigned int seq;
> +
> +	do {
> +		seq = read_seqbegin(&slots->seqlock);
> +		addr = *(unsigned long *)handle;
> +	} while (read_seqretry(&slots->seqlock, seq));

It isn't done here (I think).

