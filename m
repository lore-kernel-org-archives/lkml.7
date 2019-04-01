Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37868206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfDASJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:09:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:45249 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbfDASJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:09:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 11:09:34 -0700
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="147091613"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2019 11:09:34 -0700
Message-ID: <46fede8e9c9da712475d3e7d956e8e2144b3bbb0.camel@linux.intel.com>
Subject: Re: [RFC 2/4] net/fib: Provide fib_balance_budget sysctl
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Mon, 01 Apr 2019 11:09:34 -0700
In-Reply-To: <20190326153026.24493-3-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
         <20190326153026.24493-3-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 15:30 +0000, Dmitry Safonov wrote:
> Unfortunately, MAX_WORK at this moment is broken: during
> trie_rebalance() climbing upwards resize() is being called for each
> tnode. Which makes the limit useless the bigger trie gets: at each level
> there are 10 attempts to balance tnode and childs, resulting in
> O(10^n + 10^{n-1} + ... 10^{n-k}) complexity to balance trie, where k - is
> the level where we changed the trie originally (adding/removing
> alias/route).
> 
> Which results in the following price of removing one route under big
> trie (similar for some other single routes that results in reallocating
> tnodes by hitting the threshold limits for halve/inflate resize):

The info below doesn't really tell us the price. It might be useful if
you could just time the removal of that one route and provide that
information.

> Before:
>    Basic info: size of leaf: 40 bytes, size of tnode: 40 bytes.
>    Main:
>            Aver depth:     1.99
>            Max depth:      2
>            Leaves:         77825
>            Prefixes:       77825
>            Internal nodes: 77
>              9: 1  10: 76
>            Pointers: 78336
>    Null ptrs: 435
>    Total size: 7912  kB
>    Local:
>    [omitted]
> 
> After:
>    Basic info: size of leaf: 40 bytes, size of tnode: 40 bytes.
>    Main:
>            Aver depth:     3.00
>            Max depth:      3
>            Leaves:         77824
>            Prefixes:       77824
>            Internal nodes: 20491
>              1: 2048  2: 18432  6: 1  11: 10
>            Pointers: 98368
>    Null ptrs: 54
>    Total size: 8865  kB
>    Local:
>    [omitted]
> 

Is this before/after the patch, or just before/after the removal of the
one route? I assume you are are just talking about the one route since
the number of prefixes has dropped by 1.

> Provide a sysctl to control amount of pending balancing work.
> (by default unlimited as it was)
> 
> Cc: linux-doc@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Fixes: ff181ed8768f ("fib_trie: Push assignment of child to parent down
> into inflate/halve")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  Documentation/networking/ip-sysctl.txt |  6 +++
>  include/net/ip.h                       |  1 +
>  net/ipv4/fib_trie.c                    | 60 +++++++++++++++-----------
>  net/ipv4/sysctl_net_ipv4.c             |  7 +++
>  4 files changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
> index acdfb5d2bcaa..fb71dacff4dd 100644
> --- a/Documentation/networking/ip-sysctl.txt
> +++ b/Documentation/networking/ip-sysctl.txt
> @@ -81,6 +81,12 @@ fib_multipath_hash_policy - INTEGER
>  	0 - Layer 3
>  	1 - Layer 4
>  
> +fib_balance_budget - UNSIGNED INTEGER
> +	Limits the number of resize attempts during balancing fib trie
> +	on adding/removing new routes.
> +	Possible values:
> +	Default: UINT_MAX (0xFFFFFFFF)
> +

So I am not really a fan of the use of UNSIGNED_INTEGER here. I would
much rather see this be a signed integer and the test be for the value
going negative instead of having to test in so many places if the value
is 0.

>  ip_forward_update_priority - INTEGER
>  	Whether to update SKB priority from "TOS" field in IPv4 header after it
>  	is forwarded. The new SKB priority is mapped from TOS field value
> diff --git a/include/net/ip.h b/include/net/ip.h
> index be3cad9c2e4c..305d0e43088b 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -421,6 +421,7 @@ static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
>  	return min(READ_ONCE(skb_dst(skb)->dev->mtu), IP_MAX_MTU);
>  }
>  
> +extern unsigned int fib_balance_budget;
>  struct dst_metrics *ip_fib_metrics_init(struct net *net, struct nlattr *fc_mx,
>  					int fc_mx_len,
>  					struct netlink_ext_ack *extack);
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index ad7d56c421cb..d90cf9dfd443 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -182,8 +182,10 @@ struct trie {
>  #endif
>  };
>  
> -static struct key_vector *resize(struct trie *t, struct key_vector *tn);
> +static struct key_vector *resize(struct trie *t, struct key_vector *tn,
> +				 unsigned int *budget);
>  static size_t tnode_free_size;
> +unsigned int fib_balance_budget = UINT_MAX;
>  
>  /*
>   * synchronize_rcu after call_rcu for that many pages; it should be especially
> @@ -506,7 +508,8 @@ static void tnode_free(struct key_vector *tn)
>  
>  static struct key_vector *replace(struct trie *t,
>  				  struct key_vector *oldtnode,
> -				  struct key_vector *tn)
> +				  struct key_vector *tn,
> +				  unsigned int *budget)
>  {
>  	struct key_vector *tp = node_parent(oldtnode);
>  	unsigned long i;
> @@ -522,19 +525,19 @@ static struct key_vector *replace(struct trie *t,
>  	tnode_free(oldtnode);
>  
>  	/* resize children now that oldtnode is freed */
> -	for (i = child_length(tn); i;) {
> +	for (i = child_length(tn); i && *budget;) {

So this is an example of the kind of stuff I am talking about. Having a
check for budget here isn't going to add much in the way of value. I
would much rather keep the logic contained within resize, and just do a
check for *budget >= 0.

>  		struct key_vector *inode = get_child(tn, --i);
>  
>  		/* resize child node */
>  		if (tnode_full(tn, inode))
> -			tn = resize(t, inode);
> +			tn = resize(t, inode, budget);
>  	}
>  
>  	return tp;
>  }
>  
> -static struct key_vector *inflate(struct trie *t,
> -				  struct key_vector *oldtnode)
> +static struct key_vector *inflate(struct trie *t, struct key_vector *oldtnode,
> +				  unsigned int *budget)
>  {
>  	struct key_vector *tn;
>  	unsigned long i;
> @@ -621,7 +624,7 @@ static struct key_vector *inflate(struct trie *t,
>  	}
>  
>  	/* setup the parent pointers into and out of this node */
> -	return replace(t, oldtnode, tn);
> +	return replace(t, oldtnode, tn, budget);
>  nomem:
>  	/* all pointers should be clean so we are done */
>  	tnode_free(tn);
> @@ -629,8 +632,8 @@ static struct key_vector *inflate(struct trie *t,
>  	return NULL;
>  }
>  
> -static struct key_vector *halve(struct trie *t,
> -				struct key_vector *oldtnode)
> +static struct key_vector *halve(struct trie *t, struct key_vector *oldtnode,
> +				unsigned int *budget)
>  {
>  	struct key_vector *tn;
>  	unsigned long i;
> @@ -676,7 +679,7 @@ static struct key_vector *halve(struct trie *t,
>  	}
>  
>  	/* setup the parent pointers into and out of this node */
> -	return replace(t, oldtnode, tn);
> +	return replace(t, oldtnode, tn, budget);
>  nomem:
>  	/* all pointers should be clean so we are done */
>  	tnode_free(tn);
> @@ -843,15 +846,15 @@ static inline bool should_collapse(struct key_vector *tn)
>  	return used < 2;
>  }
>  
> -#define MAX_WORK 10
> -static struct key_vector *resize(struct trie *t, struct key_vector *tn)
> +static struct key_vector *resize(struct trie *t, struct key_vector *tn,
> +				 unsigned int *budget)
>  {
>  #ifdef CONFIG_IP_FIB_TRIE_STATS
>  	struct trie_use_stats __percpu *stats = t->stats;
>  #endif
>  	struct key_vector *tp = node_parent(tn);
>  	unsigned long cindex = get_index(tn->key, tp);
> -	int max_work = MAX_WORK;
> +	bool inflated = false;
>  
>  	pr_debug("In tnode_resize %p inflate_threshold=%d threshold=%d\n",
>  		 tn, inflate_threshold, halve_threshold);
> @@ -865,8 +868,8 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
>  	/* Double as long as the resulting node has a number of
>  	 * nonempty nodes that are above the threshold.
>  	 */
> -	while (should_inflate(tp, tn) && max_work) {
> -		tp = inflate(t, tn);
> +	while (should_inflate(tp, tn) && *budget) {
> +		tp = inflate(t, tn, budget);
>  		if (!tp) {
>  #ifdef CONFIG_IP_FIB_TRIE_STATS
>  			this_cpu_inc(stats->resize_node_skipped);
> @@ -874,22 +877,25 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
>  			break;
>  		}
>  
> -		max_work--;
> +		(*budget)--;

One thing we might explore here would be to look at pulling out the
check of budget at the start of the loop and instead combine the
decrement with the check for < 0 here so we have something like:
		if (--*budget < 0)
			break;

That way what should happen is that we will achieve maximum depth in
any resize and make at least one pass optimizing from the bottom up
instead of the top down.

> +		inflated = true;
>  		tn = get_child(tp, cindex);
>  	}
>  
>  	/* update parent in case inflate failed */
>  	tp = node_parent(tn);
>  
> -	/* Return if at least one inflate is run */
> -	if (max_work != MAX_WORK)
> +	/* Return if at least one inflate is run:
> +	 * microoptimization to not recalculate thresholds
> +	 */
> +	if (inflated)
>  		return tp;

An alternative to having to add another variable would be to look at
switching the loop to a combination of an if and a do/while like so:
	if (should_inflate(tp, tn)) {
		do {
			...
		} while (should_inflate(tp, tn));
	
		/* update parent in case inflate failed */
		return node_parent(tn);
	}
		

>  	/* Halve as long as the number of empty children in this
>  	 * node is above threshold.
>  	 */
> -	while (should_halve(tp, tn) && max_work) {
> -		tp = halve(t, tn);
> +	while (should_halve(tp, tn) && *budget) {
> +		tp = halve(t, tn, budget);
>  		if (!tp) {
>  #ifdef CONFIG_IP_FIB_TRIE_STATS
>  			this_cpu_inc(stats->resize_node_skipped);
> @@ -897,7 +903,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
>  			break;
>  		}
>  
> -		max_work--;
> +		(*budget)--;

Same here. It might make sense to pull the budget check out of the
start of the loop and move it here so that it becomes a depth first
optimization instead of being a shallow one.

>  		tn = get_child(tp, cindex);
>  	}
>  
> @@ -1005,8 +1011,10 @@ static struct fib_alias *fib_find_alias(struct hlist_head *fah, u8 slen,
>  
>  static void trie_rebalance(struct trie *t, struct key_vector *tn)
>  {
> -	while (!IS_TRIE(tn))
> -		tn = resize(t, tn);
> +	unsigned int budget = fib_balance_budget;
> +
> +	while (budget && !IS_TRIE(tn))
> +		tn = resize(t, tn, &budget);

I would not have the budget check here. At a minimum we should be
replacing trie nodes with leaves in the case that we are down to one
leaf node in the trie.

>  }
>  
>  static int fib_insert_node(struct trie *t, struct key_vector *tp,
> @@ -1784,6 +1792,7 @@ struct fib_table *fib_trie_unmerge(struct fib_table *oldtb)
>  void fib_table_flush_external(struct fib_table *tb)
>  {
>  	struct trie *t = (struct trie *)tb->tb_data;
> +	unsigned int budget = fib_balance_budget;
>  	struct key_vector *pn = t->kv;
>  	unsigned long cindex = 1;
>  	struct hlist_node *tmp;
> @@ -1806,7 +1815,7 @@ void fib_table_flush_external(struct fib_table *tb)
>  				update_suffix(pn);
>  
>  			/* resize completed node */
> -			pn = resize(t, pn);
> +			pn = resize(t, pn, &budget);
>  			cindex = get_index(pkey, pn);
>  
>  			continue;

So we would probably want a completely different budget here, or at
least we would want the budget to be multiplied by the leaves we are
removing. The problem is we aren't pulling single addresses, but are
literally splitting the tree into two separate tries. The same budget
isn't going to work for both cases.

> @@ -1853,6 +1862,7 @@ void fib_table_flush_external(struct fib_table *tb)
>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>  {
>  	struct trie *t = (struct trie *)tb->tb_data;
> +	unsigned int budget = fib_balance_budget;
>  	struct key_vector *pn = t->kv;
>  	unsigned long cindex = 1;
>  	struct hlist_node *tmp;
> @@ -1876,7 +1886,7 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>  				update_suffix(pn);
>  
>  			/* resize completed node */
> -			pn = resize(t, pn);
> +			pn = resize(t, pn, &budget);
>  			cindex = get_index(pkey, pn);
>  
>  			continue;

Similar issues here, though I don't know what the typical amount of
change is we expect to see from a fib_table_flush call versus something
like the fib_table_flush_external call.

> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index ba0fc4b18465..d7274cc442af 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -443,6 +443,13 @@ static struct ctl_table ipv4_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec
>  	},
> +	{
> +		.procname	= "fib_balance_budget",
> +		.data		= &fib_balance_budget,
> +		.maxlen		= sizeof(fib_balance_budget),
> +		.mode		= 0644,
> +		.proc_handler	= proc_douintvec,
> +	},
>  	{
>  		.procname	= "inet_peer_threshold",
>  		.data		= &inet_peer_threshold,

