Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B13C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CFD20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="j5VUwoYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfDDSb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:31:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43947 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:31:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id d26so3142900ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o3JiYiaXLFttuORR/i6ScFngT48gAH5psY/aHu5CjL4=;
        b=j5VUwoYqztFvueXbcJ82RX7aljhmhem+6tpiIenn5mp1PuhrcW77dzVEdLXS1MaV6B
         qZcrCxmJmaQpn+ozKhundtahNSZsHSOIlC34Da9xC18BpZ5xKsT+eRLw1kIYkMpvrNoy
         xXxEvDFMO6RxJ9vHbvqry4LInDMYPZJNmXl6BaShK2Y1N7MzZBXAM5TAeFFa0dIAhxFH
         PqVijAFPTL4k6mD3qizfyQ2kCaTVPWFSNyOHeKp3CjKPGAhA3cdXY9hY9bo59AWexPas
         RKHi7geMnx1l2XTliJ4l5NKZJ3N8kO05gfu0CTHx3Rs3ieOnTYD5q+08NSwj//RI/Uuq
         B30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3JiYiaXLFttuORR/i6ScFngT48gAH5psY/aHu5CjL4=;
        b=FGmyOgHaLNGemE16av67TXJPRuEqgN0ZUECW2TYrbys++AFZZ/mR5U2EJID2LlZFeT
         ZJQTsGx/aDf9xYVzaHECY/STPkZc6o1bp6L44USwEWqrIm+45xM+xh57YIEFcUQC4jWs
         ZTfzZHr6M5EGaVsbzwoAm7xK6X/+KobefIiSKAkn+OuWS3R41bfs+53AzczVgv/cgH8h
         L5ko9d2EadwR3yKQ/J79PkbFJqobF7gAhB+ztxfSDmAzcNlwlkyUiPsNSgkDISwTE3Xa
         vfEPHvOyspC3uhthNRFWo/j5u4djTRt4FcQBN0h5BI+Siooe2bVPRzo85cQkVvC5b8ro
         qW0A==
X-Gm-Message-State: APjAAAU15LbFHtjzpueijcMr4DhXh2wb0kUIm4hslFAMx8Uoma4g6rgt
        Bk2V4MOj827BMFyOQ5UuJvBjiw==
X-Google-Smtp-Source: APXvYqyIm0+Ye6HPXd0K4jJ8ymSKL0vMWTKhRp7FaUDgpmuW2CuUbP6/wP0qhdKX1Td9WDcY0ANMLg==
X-Received: by 2002:a50:891d:: with SMTP id e29mr4870911ede.209.1554402712988;
        Thu, 04 Apr 2019 11:31:52 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d20sm5968322eda.82.2019.04.04.11.31.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:31:51 -0700 (PDT)
Subject: Re: [RFC 2/4] net/fib: Provide fib_balance_budget sysctl
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-3-dima@arista.com>
 <46fede8e9c9da712475d3e7d956e8e2144b3bbb0.camel@linux.intel.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <0ca9d27c-5d85-de1c-8303-697cc1acf85b@arista.com>
Date:   Thu, 4 Apr 2019 19:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <46fede8e9c9da712475d3e7d956e8e2144b3bbb0.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 7:09 PM, Alexander Duyck wrote:
> On Tue, 2019-03-26 at 15:30 +0000, Dmitry Safonov wrote:
>> Unfortunately, MAX_WORK at this moment is broken: during
>> trie_rebalance() climbing upwards resize() is being called for each
>> tnode. Which makes the limit useless the bigger trie gets: at each level
>> there are 10 attempts to balance tnode and childs, resulting in
>> O(10^n + 10^{n-1} + ... 10^{n-k}) complexity to balance trie, where k - is
>> the level where we changed the trie originally (adding/removing
>> alias/route).
>>
>> Which results in the following price of removing one route under big
>> trie (similar for some other single routes that results in reallocating
>> tnodes by hitting the threshold limits for halve/inflate resize):
> 
> The info below doesn't really tell us the price. It might be useful if
> you could just time the removal of that one route and provide that
> information.

Yes, well, that was an attempt to point that MAX_WORK in the current
state doesn't limit much complexity to balance trie.

So, most of the time (up to a couple of seconds) is spent on
synchronise_rcu() (which was addressed by 4/4 and a patch from David
Ahern in -next).

But I thought fixing max_work is also worth attention, regardless the
fix for synchronising rcu. And playing with the sysctl limit that is
provided by the patch, I've found out that even with 4/4 applied one can
tune this sysctl knob the way that results in dividing the work between
consecutive route manipulations. So that on a 4-core switch the time
spent to add a route in maximum was more than a second and adjusting
work limit can bring it down to 300msec in max. Though, the total time
spent to add the whole route table was the same.

I will provide more details for v2.

> 
>> Before:
>>    Basic info: size of leaf: 40 bytes, size of tnode: 40 bytes.
>>    Main:
>>            Aver depth:     1.99
>>            Max depth:      2
>>            Leaves:         77825
>>            Prefixes:       77825
>>            Internal nodes: 77
>>              9: 1  10: 76
>>            Pointers: 78336
>>    Null ptrs: 435
>>    Total size: 7912  kB
>>    Local:
>>    [omitted]
>>
>> After:
>>    Basic info: size of leaf: 40 bytes, size of tnode: 40 bytes.
>>    Main:
>>            Aver depth:     3.00
>>            Max depth:      3
>>            Leaves:         77824
>>            Prefixes:       77824
>>            Internal nodes: 20491
>>              1: 2048  2: 18432  6: 1  11: 10
>>            Pointers: 98368
>>    Null ptrs: 54
>>    Total size: 8865  kB
>>    Local:
>>    [omitted]
>>
> 
> Is this before/after the patch, or just before/after the removal of the
> one route? I assume you are are just talking about the one route since
> the number of prefixes has dropped by 1.

Yes, just for removing one route. Should have mentioned that explicitly,
sorry.

> 
>> Provide a sysctl to control amount of pending balancing work.
>> (by default unlimited as it was)
>>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Fixes: ff181ed8768f ("fib_trie: Push assignment of child to parent down
>> into inflate/halve")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  Documentation/networking/ip-sysctl.txt |  6 +++
>>  include/net/ip.h                       |  1 +
>>  net/ipv4/fib_trie.c                    | 60 +++++++++++++++-----------
>>  net/ipv4/sysctl_net_ipv4.c             |  7 +++
>>  4 files changed, 49 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
>> index acdfb5d2bcaa..fb71dacff4dd 100644
>> --- a/Documentation/networking/ip-sysctl.txt
>> +++ b/Documentation/networking/ip-sysctl.txt
>> @@ -81,6 +81,12 @@ fib_multipath_hash_policy - INTEGER
>>  	0 - Layer 3
>>  	1 - Layer 4
>>  
>> +fib_balance_budget - UNSIGNED INTEGER
>> +	Limits the number of resize attempts during balancing fib trie
>> +	on adding/removing new routes.
>> +	Possible values:
>> +	Default: UINT_MAX (0xFFFFFFFF)
>> +
> 
> So I am not really a fan of the use of UNSIGNED_INTEGER here. I would
> much rather see this be a signed integer and the test be for the value
> going negative instead of having to test in so many places if the value
> is 0.

Ok, sounds good to me - will change the type for v2.

[..]
>> @@ -874,22 +877,25 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
>>  			break;
>>  		}
>>  
>> -		max_work--;
>> +		(*budget)--;
> 
> One thing we might explore here would be to look at pulling out the
> check of budget at the start of the loop and instead combine the
> decrement with the check for < 0 here so we have something like:
> 		if (--*budget < 0)
> 			break;
> 
> That way what should happen is that we will achieve maximum depth in
> any resize and make at least one pass optimizing from the bottom up
> instead of the top down.

Yeah, sounds reasonable - will do this way and retest.

> 
>> +		inflated = true;
>>  		tn = get_child(tp, cindex);
>>  	}
>>  
>>  	/* update parent in case inflate failed */
>>  	tp = node_parent(tn);
>>  
>> -	/* Return if at least one inflate is run */
>> -	if (max_work != MAX_WORK)
>> +	/* Return if at least one inflate is run:
>> +	 * microoptimization to not recalculate thresholds
>> +	 */
>> +	if (inflated)
>>  		return tp;
> 
> An alternative to having to add another variable would be to look at
> switching the loop to a combination of an if and a do/while like so:
> 	if (should_inflate(tp, tn)) {
> 		do {
> 			...
> 		} while (should_inflate(tp, tn));
> 	
> 		/* update parent in case inflate failed */
> 		return node_parent(tn);
> 	}

That's neat! Will drop the variable.

> 		
> 
>>  	/* Halve as long as the number of empty children in this
>>  	 * node is above threshold.
>>  	 */
>> -	while (should_halve(tp, tn) && max_work) {
>> -		tp = halve(t, tn);
>> +	while (should_halve(tp, tn) && *budget) {
>> +		tp = halve(t, tn, budget);
>>  		if (!tp) {
>>  #ifdef CONFIG_IP_FIB_TRIE_STATS
>>  			this_cpu_inc(stats->resize_node_skipped);
>> @@ -897,7 +903,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
>>  			break;
>>  		}
>>  
>> -		max_work--;
>> +		(*budget)--;
> 
> Same here. It might make sense to pull the budget check out of the
> start of the loop and move it here so that it becomes a depth first
> optimization instead of being a shallow one.

Makes sense, will rework.

> 
>>  		tn = get_child(tp, cindex);
>>  	}
>>  
>> @@ -1005,8 +1011,10 @@ static struct fib_alias *fib_find_alias(struct hlist_head *fah, u8 slen,
>>  
>>  static void trie_rebalance(struct trie *t, struct key_vector *tn)
>>  {
>> -	while (!IS_TRIE(tn))
>> -		tn = resize(t, tn);
>> +	unsigned int budget = fib_balance_budget;
>> +
>> +	while (budget && !IS_TRIE(tn))
>> +		tn = resize(t, tn, &budget);
> 
> I would not have the budget check here. At a minimum we should be
> replacing trie nodes with leaves in the case that we are down to one
> leaf node in the trie.

Yeah, I see.

> 
>>  }
>>  
>>  static int fib_insert_node(struct trie *t, struct key_vector *tp,
>> @@ -1784,6 +1792,7 @@ struct fib_table *fib_trie_unmerge(struct fib_table *oldtb)
>>  void fib_table_flush_external(struct fib_table *tb)
>>  {
>>  	struct trie *t = (struct trie *)tb->tb_data;
>> +	unsigned int budget = fib_balance_budget;
>>  	struct key_vector *pn = t->kv;
>>  	unsigned long cindex = 1;
>>  	struct hlist_node *tmp;
>> @@ -1806,7 +1815,7 @@ void fib_table_flush_external(struct fib_table *tb)
>>  				update_suffix(pn);
>>  
>>  			/* resize completed node */
>> -			pn = resize(t, pn);
>> +			pn = resize(t, pn, &budget);
>>  			cindex = get_index(pkey, pn);
>>  
>>  			continue;
> 
> So we would probably want a completely different budget here, or at
> least we would want the budget to be multiplied by the leaves we are
> removing. The problem is we aren't pulling single addresses, but are
> literally splitting the tree into two separate tries. The same budget
> isn't going to work for both cases.

Which will multiply the work (and the time spent).
Hmm, well, I guess we can multiply here and relax rtnl_mutex pressure if
needed by introducing fib_lock. Does that sounds good?

> 
>> @@ -1853,6 +1862,7 @@ void fib_table_flush_external(struct fib_table *tb)
>>  int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>>  {
>>  	struct trie *t = (struct trie *)tb->tb_data;
>> +	unsigned int budget = fib_balance_budget;
>>  	struct key_vector *pn = t->kv;
>>  	unsigned long cindex = 1;
>>  	struct hlist_node *tmp;
>> @@ -1876,7 +1886,7 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
>>  				update_suffix(pn);
>>  
>>  			/* resize completed node */
>> -			pn = resize(t, pn);
>> +			pn = resize(t, pn, &budget);
>>  			cindex = get_index(pkey, pn);
>>  
>>  			continue;
> 
> Similar issues here, though I don't know what the typical amount of
> change is we expect to see from a fib_table_flush call versus something
> like the fib_table_flush_external call.

Yes. Well, I was also curious if it's possible to avoid resize() call
under (flush_all == true)?
So, that exiting a namespace wouldn't result in rebalancing a possibly
huge routing trie.

Thanks for your notes and review,
          Dmitry
