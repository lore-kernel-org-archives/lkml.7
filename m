Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8FC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E663624658
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576307425;
	bh=hDUvD25Gte+PrDGnam0RqGK0I/9VsEWs4aAMnrFWYtQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=R+uh+qqsCGG2MDSqrRfE75qYRWLHlmfc671ikHA8wU2VtW1Vy2Ce6CbF940BAKO2C
	 KpHdtte2QvpoFT10aXF6OVQJNU/BqiaB0i9xj8zyNsybFVexnwNQXdGBgqHou/7jCk
	 1zm8jjYvMm2VJ99MBiKwL7wPJWlC11vxyU5mTl+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfLNHKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfLNHKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:10:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403C120724;
        Sat, 14 Dec 2019 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576307422;
        bh=hDUvD25Gte+PrDGnam0RqGK0I/9VsEWs4aAMnrFWYtQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HSQWPjtaQxITmfeyByg3fuOEYMgis27/cFEDi8ZsCxqeWqFDMSqyoN8dcqj5Rp9z0
         p0hSgWAKNSd+x4Bj7/maYyoHnjiS+1V0iiPlq1jzHA+5IEqjuQmCcshxGOOHLzFvWs
         qd90FrUwHsvmolceUa0BwrfKA4ZV7Ho48ctzIt2o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05C6F352276B; Fri, 13 Dec 2019 23:10:22 -0800 (PST)
Date:   Fri, 13 Dec 2019 23:10:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RESEND -rcu/kcsan] kcsan: Prefer __always_inline for
 fast-path
Message-ID: <20191214071021.GJ2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191213204946.251125-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213204946.251125-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:49:46PM +0100, Marco Elver wrote:
> Prefer __always_inline for fast-path functions that are called outside
> of user_access_save, to avoid generating UACCESS warnings when
> optimizing for size (CC_OPTIMIZE_FOR_SIZE). It will also avoid future
> surprises with compiler versions that change the inlining heuristic even
> when optimizing for performance.
> 
> Report: http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Signed-off-by: Marco Elver <elver@google.com>

Queued for review and testing, thank you!

							Thanx, Paul

> ---
> Version rebased on -rcu/kcsan.
> 
> There are 3 locations that would conflict with the style cleanup in
> -tip/locking/kcsan:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/kcsan&id=5cbaefe9743bf14c9d3106db0cc19f8cb0a3ca22
> 
> For the conflicting locations the better style is carried over, so that
> upon eventual merge the resolution should be trivial.
> ---
>  kernel/kcsan/atomic.h   |  2 +-
>  kernel/kcsan/core.c     | 17 ++++++++---------
>  kernel/kcsan/encoding.h | 11 +++++------
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> index c9c3fe628011..466e6777533e 100644
> --- a/kernel/kcsan/atomic.h
> +++ b/kernel/kcsan/atomic.h
> @@ -18,7 +18,7 @@
>   * than cast to volatile. Eventually, we hope to be able to remove this
>   * function.
>   */
> -static inline bool kcsan_is_atomic(const volatile void *ptr)
> +static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
>  {
>  	/* only jiffies for now */
>  	return ptr == &jiffies;
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index d9410d58c93e..69870645b631 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -78,9 +78,8 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS - 1];
>   */
>  static DEFINE_PER_CPU(long, kcsan_skip);
>  
> -static inline atomic_long_t *find_watchpoint(unsigned long addr, size_t size,
> -					     bool expect_write,
> -					     long *encoded_watchpoint)
> +static __always_inline atomic_long_t *
> +find_watchpoint(unsigned long addr, size_t size, bool expect_write, long *encoded_watchpoint)
>  {
>  	const int slot = watchpoint_slot(addr);
>  	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> @@ -150,8 +149,8 @@ static inline atomic_long_t *insert_watchpoint(unsigned long addr, size_t size,
>   *	2. the thread that set up the watchpoint already removed it;
>   *	3. the watchpoint was removed and then re-used.
>   */
> -static inline bool try_consume_watchpoint(atomic_long_t *watchpoint,
> -					  long encoded_watchpoint)
> +static __always_inline bool
> +try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
>  {
>  	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint,
>  					       CONSUMED_WATCHPOINT);
> @@ -166,7 +165,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
>  	       CONSUMED_WATCHPOINT;
>  }
>  
> -static inline struct kcsan_ctx *get_ctx(void)
> +static __always_inline struct kcsan_ctx *get_ctx(void)
>  {
>  	/*
>  	 * In interrupt, use raw_cpu_ptr to avoid unnecessary checks, that would
> @@ -175,7 +174,7 @@ static inline struct kcsan_ctx *get_ctx(void)
>  	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
>  }
>  
> -static inline bool is_atomic(const volatile void *ptr)
> +static __always_inline bool is_atomic(const volatile void *ptr)
>  {
>  	struct kcsan_ctx *ctx = get_ctx();
>  
> @@ -199,7 +198,7 @@ static inline bool is_atomic(const volatile void *ptr)
>  	return kcsan_is_atomic(ptr);
>  }
>  
> -static inline bool should_watch(const volatile void *ptr, int type)
> +static __always_inline bool should_watch(const volatile void *ptr, int type)
>  {
>  	/*
>  	 * Never set up watchpoints when memory operations are atomic.
> @@ -232,7 +231,7 @@ static inline void reset_kcsan_skip(void)
>  	this_cpu_write(kcsan_skip, skip_count);
>  }
>  
> -static inline bool kcsan_is_enabled(void)
> +static __always_inline bool kcsan_is_enabled(void)
>  {
>  	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
>  }
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index e17bdac0e54b..e527e83ce825 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -58,9 +58,8 @@ static inline long encode_watchpoint(unsigned long addr, size_t size,
>  		      (addr & WATCHPOINT_ADDR_MASK));
>  }
>  
> -static inline bool decode_watchpoint(long watchpoint,
> -				     unsigned long *addr_masked, size_t *size,
> -				     bool *is_write)
> +static __always_inline bool
> +decode_watchpoint(long watchpoint, unsigned long *addr_masked, size_t *size, bool *is_write)
>  {
>  	if (watchpoint == INVALID_WATCHPOINT ||
>  	    watchpoint == CONSUMED_WATCHPOINT)
> @@ -77,13 +76,13 @@ static inline bool decode_watchpoint(long watchpoint,
>  /*
>   * Return watchpoint slot for an address.
>   */
> -static inline int watchpoint_slot(unsigned long addr)
> +static __always_inline int watchpoint_slot(unsigned long addr)
>  {
>  	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
>  }
>  
> -static inline bool matching_access(unsigned long addr1, size_t size1,
> -				   unsigned long addr2, size_t size2)
> +static __always_inline bool matching_access(unsigned long addr1, size_t size1,
> +					    unsigned long addr2, size_t size2)
>  {
>  	unsigned long end_range1 = addr1 + size1 - 1;
>  	unsigned long end_range2 = addr2 + size2 - 1;
> -- 
> 2.24.1.735.g03f4e72817-goog
> 
