Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82375C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41350206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VSIB5J53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLUXVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:21:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52930 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLUXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:21:19 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so5756118pjd.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 15:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qwuvmk0kpw1Hb0uGtiWMIVWTE1pbXU+7hZ9NigrgvCY=;
        b=VSIB5J53C4iUAW+IG2TjewwAdxANiPTUn/+fzTlbZqiWf/9qx9gul+TZQvlRlyj/fI
         LRiFn5VDX9lNh6r3mpzagXQMoRLlki5Vqj203rPoIoQSeFnvAjCv3qXInxK136pK8EkE
         Rdm823etfCZIADtvhwmgr2UhU4nZeAnrmdqbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qwuvmk0kpw1Hb0uGtiWMIVWTE1pbXU+7hZ9NigrgvCY=;
        b=ejafci9vXi9CQtuH8ZIutIZOZKT7ejtWT7N8cAzVSEQgNXv6osXN6XyQ7vtWx1IOE/
         +SyqKMrYdB9LdxEXB6Wz4/Ur6gwLpH2S6NeyXfRQsKtFLhC8j/zhX6Xq8GPPnPjNAjCN
         YA9OZXXYI84Gwwj2zjwIhgwBKEzxl/05YXrgHTXt/wQebFaDlVpope5IS3h0RJjaQhCF
         UjPgR1hefV+1GFIMW76E7UBrB8ICMG7WIvCMUkQkbZEtO4ICdHkTTWFY1xtp/s8MUOCT
         E6B4oPmAyycD1AWqXUnF68i6BNKHWBQBbB1hr2ilpQHfo5JhismZmR0l4/YW+aJ0Gt5Y
         mVBg==
X-Gm-Message-State: APjAAAXLuprwj95azLRcjP11M81QXQjSI2TRjtmU92rcv0S6XHe9IBZM
        VkN2x/DvDUoXbUUgjlFcoImfrQ==
X-Google-Smtp-Source: APXvYqw9j0IluS1/ZwQwHAP/9TD/2HtPM2AFO3Xf7jX7dcpvwYOGyZfI3rdTFQn7XQ/eue6QGqWAZw==
X-Received: by 2002:a17:90a:e657:: with SMTP id ep23mr10025480pjb.105.1576970478804;
        Sat, 21 Dec 2019 15:21:18 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h7sm19587936pfq.36.2019.12.21.15.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:21:18 -0800 (PST)
Date:   Sat, 21 Dec 2019 18:21:17 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20191221232117.GA67625@google.com>
References: <20191220125624.3953-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220125624.3953-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:56:24PM +0100, Uladzislau Rezki (Sony) wrote:
> kfree_rcu() logic can be improved further by using kfree_bulk()
> interface along with "basic batching support" introduced earlier.
> 
> The are at least two advantages of using "bulk" interface:
> - in case of large number of kfree_rcu() requests kfree_bulk()
>   reduces the per-object overhead caused by calling kfree()
>   per-object.
> 
> - reduces the number of cache-misses due to "pointer chasing"
>   between objects which can be far spread between each other.
> 
> This approach defines a new kfree_rcu_bulk_data structure that
> stores pointers in an array with a specific size. Number of
> entries in that array depends on PAGE_SIZE, i.e. it is based
> on the fact that the size of kfree_rcu_bulk_data should not
> exceed one page therefore there is such dependency.
> 
> Since it deals with "block-chain" technique there is an extra
> need in dynamic allocation when a new block is required. Memory
> is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
> allows to skip direct reclaim under low memory condition to
> prevent stalling and fail silently under high memory pressure.
> 
> The "emergency path" gets maintained when a system is run out
> of memory. In that case objects are linked into regular list
> and that is it.
> 
> In order to evaluate it, the "rcuperf" was run to analyze how
> much memory is consumed and what is kfree_bulk() throughput.
> 
> Testing on the Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz 12xCPUs
> with below parameters:
> 
> CONFIG_SLAB=y
> kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> 
> Total time taken by all kfree'ers: 56828146341 ns, loops: 200000, batches: 2096
> Total time taken by all kfree'ers: 57329844331 ns, loops: 200000, batches: 2379
> 
> Total time taken by all kfree'ers: 45498404821 ns, loops: 200000, batches: 2271
> Total time taken by all kfree'ers: 45313811813 ns, loops: 200000, batches: 2263
> 
> rcuperf shows approximately ~21% better throughput(Total time)
> in case of using "bulk" interface. The "drain logic" or its RCU
> callback does the work faster that leads to better throughput.
> 
> During the test an average memory usage(see below run_2) is ~469MB
> with "Default" configuration and ~399MB in the "Bulk interface" case.
> 
> See below detailed plots of three run:
> 
> ftp://vps418301.ovh.net/incoming/rcuperf_mem_usage_run_0.png
> ftp://vps418301.ovh.net/incoming/rcuperf_mem_usage_run_1.png
> ftp://vps418301.ovh.net/incoming/rcuperf_mem_usage_run_2.png

Hi Uladzislau,

Your patch is based on an older version of the kfree_rcu work. The latest
version is in Paul's -dev branch. There is also additional work done in that
branch as well "rcu: Add multiple in-flight batches of kfree_rcu() work" :
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=e38fa01b94c87dfa945afa603ed50b4f7955934b

Could you rebase your patch on Paul's -dev branch? The branch also has an
rcuperf patch for measuring memory footprint automatically (memory footprint
value is printed by rcuperf). Although I'd say try to use the latest version
of the rcuperf patch by reverting that and applying:
https://lore.kernel.org/patchwork/patch/1170895/ . I can then add your
Tested-by tag to any future postings of the patch for rcuperf as well!

thanks,

 - Joel


> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 123 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 103 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d8e250c8a48f..942a1beb06bb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2655,6 +2655,28 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  /* Maximum number of jiffies to wait before draining a batch. */
>  #define KFREE_DRAIN_JIFFIES (HZ / 50)
>  
> +/*
> + * This macro defines how many entries the "records" array
> + * will contain. It is based on the fact that the size of
> + * kfree_rcu_bulk_data structure should not exceed one page
> + * therefore there is a dependency on PAGE_SIZE.
> + *
> + * To be more specific it is set to half of the PAGE_SIZE.
> + * For example if the PAGE_SIZE is 4096, the record size
> + * is 8, the structure size becomes 2048 thus number of
> + * entries are 254.
> + *
> + * We also can reserve exactly one page for that purpose
> + * and switch to using directly "page allocator" instead.
> + */
> +#define KFREE_BULK_MAX_ENTR (((PAGE_SIZE / sizeof(void *)) >> 1) - 2)
> +
> +struct kfree_rcu_bulk_data {
> +	unsigned long nr_records;
> +	void *records[KFREE_BULK_MAX_ENTR];
> +	struct kfree_rcu_bulk_data *next;
> +};
> +
>  /*
>   * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
>   * kfree(s) is queued for freeing after a grace period, right away.
> @@ -2666,21 +2688,40 @@ struct kfree_rcu_cpu {
>  	struct rcu_work rcu_work;
>  
>  	/* The list of objects being queued in a batch but are not yet
> -	 * scheduled to be freed.
> +	 * scheduled to be freed. For emergency path only.
>  	 */
>  	struct rcu_head *head;
>  
>  	/* The list of objects that have now left ->head and are queued for
> -	 * freeing after a grace period.
> +	 * freeing after a grace period. For emergency path only.
>  	 */
>  	struct rcu_head *head_free;
>  
> +	/*
> +	 * The bulk list that keeps pointers in the array of
> +	 * specific size for later take over to bhead_free.
> +	 */
> +	struct kfree_rcu_bulk_data *bhead;
> +
> +	/*
> +	 * The bulk list that is detached from the bhead to
> +	 * perform draining using kfree_bulk() interface.
> +	 */
> +	struct kfree_rcu_bulk_data *bhead_free;
> +
> +	/*
> +	 * Keeps at most one object for late reuse.
> +	 */
> +	struct kfree_rcu_bulk_data *bcached;
> +
>  	/* Protect concurrent access to this structure. */
>  	spinlock_t lock;
>  
> -	/* The delayed work that flushes ->head to ->head_free incase ->head
> -	 * within KFREE_DRAIN_JIFFIES. In case flushing cannot be done if RCU
> -	 * is busy, ->head just continues to grow and we retry flushing later.
> +	/*
> +	 * The delayed work that flushes ->bhead/head to ->bhead_free/head_free
> +	 * incase ->bhead/head within KFREE_DRAIN_JIFFIES. In case flushing cannot
> +	 * be done if RCU is busy, ->bhead/head just continues to grow and we retry
> +	 * flushing later.
>  	 */
>  	struct delayed_work monitor_work;
>  	bool monitor_todo;      /* Is a delayed work pending execution? */
> @@ -2690,27 +2731,44 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
>  
>  /*
>   * This function is invoked in workqueue context after a grace period.
> - * It frees all the objects queued on ->head_free.
> + * It frees all the objects queued on ->head_free or bhead_free.
>   */
>  static void kfree_rcu_work(struct work_struct *work)
>  {
>  	unsigned long flags;
>  	struct rcu_head *head, *next;
> +	struct kfree_rcu_bulk_data *bhead, *bnext;
>  	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
>  											  struct kfree_rcu_cpu, rcu_work);
>  
>  	spin_lock_irqsave(&krcp->lock, flags);
>  	head = krcp->head_free;
>  	krcp->head_free = NULL;
> +	bhead = krcp->bhead_free;
> +	krcp->bhead_free = NULL;
>  	spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  	/*
>  	 * The head is detached and not referenced from anywhere, so lockless
>  	 * access is Ok.
>  	 */
> +	for (; bhead; bhead = bnext) {
> +		bnext = bhead->next;
> +		kfree_bulk(bhead->nr_records, bhead->records);
> +
> +		if (cmpxchg(&krcp->bcached, NULL, bhead))
> +			kfree(bhead);
> +
> +		cond_resched_tasks_rcu_qs();
> +	}
> +
> +	/*
> +	 * Emergency case only. It can happen under low
> +	 * memory condition when kmalloc gets failed, so
> +	 * the "bulk" path can not be temporary maintained.
> +	 */
>  	for (; head; head = next) {
>  		next = head->next;
> -		/* Could be possible to optimize with kfree_bulk in future */
>  		__rcu_reclaim(rcu_state.name, head);
>  		cond_resched_tasks_rcu_qs();
>  	}
> @@ -2730,11 +2788,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  	 * another one, just refuse the optimization and it will be retried
>  	 * again in KFREE_DRAIN_JIFFIES time.
>  	 */
> -	if (krcp->head_free)
> +	if (krcp->bhead_free || krcp->head_free)
>  		return false;
>  
>  	krcp->head_free = krcp->head;
>  	krcp->head = NULL;
> +
> +	krcp->bhead_free = krcp->bhead;
> +	krcp->bhead = NULL;
> +
>  	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
>  	queue_rcu_work(system_wq, &krcp->rcu_work);
>  
> @@ -2744,8 +2806,9 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>  static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
>  										  unsigned long flags)
>  {
> -	/* Flush ->head to ->head_free, all objects on ->head_free will be
> -	 * kfree'd after a grace period.
> +	/*
> +	 * Flush ->bhead/head to ->bhead_free/head_free, so all objects
> +	 * on ->bhead_free/head_free will be freed after a grace period.
>  	 */
>  	if (queue_kfree_rcu_work(krcp)) {
>  		/* Success! Our job is done here. */
> @@ -2763,7 +2826,7 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
>  
>  /*
>   * This function is invoked after the KFREE_DRAIN_JIFFIES timeout has elapsed,
> - * and it drains the specified kfree_rcu_cpu structure's ->head list.
> + * and it drains the specified kfree_rcu_cpu structure's ->bhead/head list.
>   */
>  static void kfree_rcu_monitor(struct work_struct *work)
>  {
> @@ -2795,17 +2858,15 @@ EXPORT_SYMBOL_GPL(kfree_call_rcu_nobatch);
>   * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
>   * will be kfree'd in workqueue context. This allows us to:
>   *
> - * 1. Batch requests together to reduce the number of grace periods during
> + * Batch requests together to reduce the number of grace periods during
>   * heavy kfree_rcu() load.
> - *
> - * 2. In the future, makes it possible to use kfree_bulk() on a large number of
> - * kfree_rcu() requests thus reducing the per-object overhead of kfree() and
> - * also reducing cache misses.
>   */
>  void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
>  	unsigned long flags;
>  	struct kfree_rcu_cpu *krcp;
> +	struct kfree_rcu_bulk_data *bnode;
> +	bool maintain_bulk_list = true;
>  
>  	/* kfree_call_rcu() batching requires timers to be up. If the scheduler
>  	 * is not yet up, just skip batching and do the non-batched version.
> @@ -2813,15 +2874,37 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
>  		return kfree_call_rcu_nobatch(head, func);
>  
> -	head->func = func;
> -
>  	local_irq_save(flags);  /* For safely calling this_cpu_ptr(). */
>  	krcp = this_cpu_ptr(&krc);
>  	spin_lock(&krcp->lock);
>  
> +	/* Check if we need a new block. */
> +	if (!krcp->bhead ||
> +			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> +		bnode = xchg(&krcp->bcached, NULL);
> +		if (!bnode)
> +			bnode = kmalloc(sizeof(struct kfree_rcu_bulk_data),
> +				GFP_NOWAIT | __GFP_NOWARN);
> +
> +		if (likely(bnode)) {
> +			bnode->nr_records = 0;
> +			bnode->next = krcp->bhead;
> +			krcp->bhead = bnode;
> +		} else {
> +			/* If gets failed, maintain the list instead. */
> +			maintain_bulk_list = false;
> +		}
> +	}
> +
>  	/* Queue the kfree but don't yet schedule the batch. */
> -	head->next = krcp->head;
> -	krcp->head = head;
> +	if (likely(maintain_bulk_list)) {
> +		krcp->bhead->records[krcp->bhead->nr_records++] =
> +			(void *) head - (unsigned long) func;
> +	} else {
> +		head->func = func;
> +		head->next = krcp->head;
> +		krcp->head = head;
> +	}
>  
>  	/* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
>  	if (!xchg(&krcp->monitor_todo, true))
> -- 
> 2.20.1
> 
