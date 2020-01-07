Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF604C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF0A2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432082;
	bh=c2hPFgjk4CWDasmc5+iGcU3CKmonvNZ9FSncLbPT0dU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xBz33gvLzxHV1FAZoJms+Ai+Tod4oHRWegIzXi/HZl4A79otiQYxTnT5i4r9BVV8h
	 8oMhIv6JtaZ8o6DZUs8JVghCOktznWhBfcUPLoo7UD9ghrR9QpgHdy55iax6PEYzlO
	 0nkAD2xkat3DsBhQObQ2jRpCobRURP3MwwF/BH00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAGVVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgAGVVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:21:20 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C532081E;
        Tue,  7 Jan 2020 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578432079;
        bh=c2hPFgjk4CWDasmc5+iGcU3CKmonvNZ9FSncLbPT0dU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AuSCEO+Otv9HKtTDIVW5at4pAiMvjj5R1LSkBSXbx2WiAt5xa22UvqXISV3I/vskz
         s8cb1JtbRqox9UMUWjGlYErt1N2HuflvEt4Iy25GSt9InHNd75DEORW9rqtjB9gncA
         KppTkk3pLwKIZBhEm3kUn92HgJi4KmFNZT5lKxDg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4E1673522735; Tue,  7 Jan 2020 13:21:19 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:21:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH RESEND -rcu] kcsan: Prefer __always_inline for fast-path
Message-ID: <20200107212119.GB13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200107163104.143542-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107163104.143542-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 05:31:04PM +0100, Marco Elver wrote:
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
> ---
> Rebased against -rcu/dev branch.

Queued and pushed, thank you, Marco!

							Thanx, Paul

> ---
>  kernel/kcsan/atomic.h   |  2 +-
>  kernel/kcsan/core.c     | 18 +++++++++---------
>  kernel/kcsan/encoding.h | 14 +++++++-------
>  3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> index 576e03ddd6a3..a9c193053491 100644
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
> index 3314fc29e236..4d4ab5c5dc53 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -78,10 +78,10 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
>   */
>  static DEFINE_PER_CPU(long, kcsan_skip);
>  
> -static inline atomic_long_t *find_watchpoint(unsigned long addr,
> -					     size_t size,
> -					     bool expect_write,
> -					     long *encoded_watchpoint)
> +static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
> +						      size_t size,
> +						      bool expect_write,
> +						      long *encoded_watchpoint)
>  {
>  	const int slot = watchpoint_slot(addr);
>  	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
> @@ -146,7 +146,7 @@ insert_watchpoint(unsigned long addr, size_t size, bool is_write)
>   *	2. the thread that set up the watchpoint already removed it;
>   *	3. the watchpoint was removed and then re-used.
>   */
> -static inline bool
> +static __always_inline bool
>  try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
>  {
>  	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
> @@ -160,7 +160,7 @@ static inline bool remove_watchpoint(atomic_long_t *watchpoint)
>  	return atomic_long_xchg_relaxed(watchpoint, INVALID_WATCHPOINT) != CONSUMED_WATCHPOINT;
>  }
>  
> -static inline struct kcsan_ctx *get_ctx(void)
> +static __always_inline struct kcsan_ctx *get_ctx(void)
>  {
>  	/*
>  	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
> @@ -169,7 +169,7 @@ static inline struct kcsan_ctx *get_ctx(void)
>  	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
>  }
>  
> -static inline bool is_atomic(const volatile void *ptr)
> +static __always_inline bool is_atomic(const volatile void *ptr)
>  {
>  	struct kcsan_ctx *ctx = get_ctx();
>  
> @@ -193,7 +193,7 @@ static inline bool is_atomic(const volatile void *ptr)
>  	return kcsan_is_atomic(ptr);
>  }
>  
> -static inline bool should_watch(const volatile void *ptr, int type)
> +static __always_inline bool should_watch(const volatile void *ptr, int type)
>  {
>  	/*
>  	 * Never set up watchpoints when memory operations are atomic.
> @@ -226,7 +226,7 @@ static inline void reset_kcsan_skip(void)
>  	this_cpu_write(kcsan_skip, skip_count);
>  }
>  
> -static inline bool kcsan_is_enabled(void)
> +static __always_inline bool kcsan_is_enabled(void)
>  {
>  	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
>  }
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index b63890e86449..f03562aaf2eb 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -59,10 +59,10 @@ encode_watchpoint(unsigned long addr, size_t size, bool is_write)
>  		      (addr & WATCHPOINT_ADDR_MASK));
>  }
>  
> -static inline bool decode_watchpoint(long watchpoint,
> -				     unsigned long *addr_masked,
> -				     size_t *size,
> -				     bool *is_write)
> +static __always_inline bool decode_watchpoint(long watchpoint,
> +					      unsigned long *addr_masked,
> +					      size_t *size,
> +					      bool *is_write)
>  {
>  	if (watchpoint == INVALID_WATCHPOINT ||
>  	    watchpoint == CONSUMED_WATCHPOINT)
> @@ -78,13 +78,13 @@ static inline bool decode_watchpoint(long watchpoint,
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
