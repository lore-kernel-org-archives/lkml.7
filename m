Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D022120866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="inAjRHxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfCZPat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:30:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40071 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbfCZPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:30:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so11138005edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RqmWo28JW2clwB4Gt/VepomkIt6hea2E0CtBSqiPnc=;
        b=inAjRHxPIQ+irCWZ7SEoSkYaS0rOJ9J/urBPRydWhX4FurEkB/I8sLRg/hBKO1z8XZ
         BNgf5ASqV1N+yByh9AUbM2el/zlDCYUTRXpLK9Jdi0qSmAYpBLxy4HYJk3N6JnwtWO4C
         WwSywzAWU/ocX1E3MA/vRi4vVH0QuTRjiYp0xoj19d72q28ERxXzKhES0xhQXmxW272z
         fnKXtRAAs6D9E7fjM4EV84yDRZEVXO97vXS2NlWcYBH2leNz1Gdf6lH13/nr7jeYg/3G
         fs2i9sWnw/ZBCNgbocrqy3DOzXy8RTv20LoG3qPk5kqdL0Riwa71d+JvH6NvDiKTqV7y
         qCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RqmWo28JW2clwB4Gt/VepomkIt6hea2E0CtBSqiPnc=;
        b=BD6ZNSlgzfRbZluI82jjUOoEpzx6tX84rYYVgRgup4U1bvZEpGKOptfV6qJ4qZy2Ab
         BBAMbgRmEFULbRptM8gn62p0eeFd4CBNysWaHmXZ3FByGYm/Oj3Q2ybFyjMwGwuTWW+X
         ea0ZMXtUFOPnT8IukEtYsDkOzMILAEJJQuCaaXwkJynH1I26uEfpdDCxQoazJicaV7Jm
         AOYgF0+8ScJ6SHlB3JVqnUTkB6vtmXo4fceOq/ai9josvuz6QH+0tm1xL5qTow9k3IM7
         i9YFR6dsZWl7E55GC9YIOcT4wPdtAXps8cX3wr4ckYAm9oZnG80rEEPOu3dQ4tS3L3Gn
         wKKw==
X-Gm-Message-State: APjAAAX+MOwQQrjLp0sYfAcN/57bzc+QrCIc4pLv8oNDuQE0DEcJhSv5
        UZTJ5hTuqrKh3FUXo0yuIxkrwd7TT52pqg==
X-Google-Smtp-Source: APXvYqwqlWChpnwD65Z/LGYIe6DuGEUtTKTV7h6YnYZ8jdwZo/3YNzljZpWbLZRhdGR+LFD7QgWhcg==
X-Received: by 2002:a50:be01:: with SMTP id a1mr17051112edi.22.1553614230686;
        Tue, 26 Mar 2019 08:30:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b2sm5310830eda.36.2019.03.26.08.30.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 08:30:30 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC 2/4] net/fib: Provide fib_balance_budget sysctl
Date:   Tue, 26 Mar 2019 15:30:23 +0000
Message-Id: <20190326153026.24493-3-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326153026.24493-1-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, MAX_WORK at this moment is broken: during
trie_rebalance() climbing upwards resize() is being called for each
tnode. Which makes the limit useless the bigger trie gets: at each level
there are 10 attempts to balance tnode and childs, resulting in
O(10^n + 10^{n-1} + ... 10^{n-k}) complexity to balance trie, where k - is
the level where we changed the trie originally (adding/removing
alias/route).

Which results in the following price of removing one route under big
trie (similar for some other single routes that results in reallocating
tnodes by hitting the threshold limits for halve/inflate resize):

Before:
   Basic info: size of leaf: 40 bytes, size of tnode: 40 bytes.
   Main:
           Aver depth:     1.99
           Max depth:      2
           Leaves:         77825
           Prefixes:       77825
           Internal nodes: 77
             9: 1  10: 76
           Pointers: 78336
   Null ptrs: 435
   Total size: 7912  kB
   Local:
   [omitted]

After:
   Basic info: size of leaf: 40 bytes, size of tnode: 40 bytes.
   Main:
           Aver depth:     3.00
           Max depth:      3
           Leaves:         77824
           Prefixes:       77824
           Internal nodes: 20491
             1: 2048  2: 18432  6: 1  11: 10
           Pointers: 98368
   Null ptrs: 54
   Total size: 8865  kB
   Local:
   [omitted]

Provide a sysctl to control amount of pending balancing work.
(by default unlimited as it was)

Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Fixes: ff181ed8768f ("fib_trie: Push assignment of child to parent down
into inflate/halve")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/networking/ip-sysctl.txt |  6 +++
 include/net/ip.h                       |  1 +
 net/ipv4/fib_trie.c                    | 60 +++++++++++++++-----------
 net/ipv4/sysctl_net_ipv4.c             |  7 +++
 4 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
index acdfb5d2bcaa..fb71dacff4dd 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -81,6 +81,12 @@ fib_multipath_hash_policy - INTEGER
 	0 - Layer 3
 	1 - Layer 4
 
+fib_balance_budget - UNSIGNED INTEGER
+	Limits the number of resize attempts during balancing fib trie
+	on adding/removing new routes.
+	Possible values:
+	Default: UINT_MAX (0xFFFFFFFF)
+
 ip_forward_update_priority - INTEGER
 	Whether to update SKB priority from "TOS" field in IPv4 header after it
 	is forwarded. The new SKB priority is mapped from TOS field value
diff --git a/include/net/ip.h b/include/net/ip.h
index be3cad9c2e4c..305d0e43088b 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -421,6 +421,7 @@ static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 	return min(READ_ONCE(skb_dst(skb)->dev->mtu), IP_MAX_MTU);
 }
 
+extern unsigned int fib_balance_budget;
 struct dst_metrics *ip_fib_metrics_init(struct net *net, struct nlattr *fc_mx,
 					int fc_mx_len,
 					struct netlink_ext_ack *extack);
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index ad7d56c421cb..d90cf9dfd443 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -182,8 +182,10 @@ struct trie {
 #endif
 };
 
-static struct key_vector *resize(struct trie *t, struct key_vector *tn);
+static struct key_vector *resize(struct trie *t, struct key_vector *tn,
+				 unsigned int *budget);
 static size_t tnode_free_size;
+unsigned int fib_balance_budget = UINT_MAX;
 
 /*
  * synchronize_rcu after call_rcu for that many pages; it should be especially
@@ -506,7 +508,8 @@ static void tnode_free(struct key_vector *tn)
 
 static struct key_vector *replace(struct trie *t,
 				  struct key_vector *oldtnode,
-				  struct key_vector *tn)
+				  struct key_vector *tn,
+				  unsigned int *budget)
 {
 	struct key_vector *tp = node_parent(oldtnode);
 	unsigned long i;
@@ -522,19 +525,19 @@ static struct key_vector *replace(struct trie *t,
 	tnode_free(oldtnode);
 
 	/* resize children now that oldtnode is freed */
-	for (i = child_length(tn); i;) {
+	for (i = child_length(tn); i && *budget;) {
 		struct key_vector *inode = get_child(tn, --i);
 
 		/* resize child node */
 		if (tnode_full(tn, inode))
-			tn = resize(t, inode);
+			tn = resize(t, inode, budget);
 	}
 
 	return tp;
 }
 
-static struct key_vector *inflate(struct trie *t,
-				  struct key_vector *oldtnode)
+static struct key_vector *inflate(struct trie *t, struct key_vector *oldtnode,
+				  unsigned int *budget)
 {
 	struct key_vector *tn;
 	unsigned long i;
@@ -621,7 +624,7 @@ static struct key_vector *inflate(struct trie *t,
 	}
 
 	/* setup the parent pointers into and out of this node */
-	return replace(t, oldtnode, tn);
+	return replace(t, oldtnode, tn, budget);
 nomem:
 	/* all pointers should be clean so we are done */
 	tnode_free(tn);
@@ -629,8 +632,8 @@ static struct key_vector *inflate(struct trie *t,
 	return NULL;
 }
 
-static struct key_vector *halve(struct trie *t,
-				struct key_vector *oldtnode)
+static struct key_vector *halve(struct trie *t, struct key_vector *oldtnode,
+				unsigned int *budget)
 {
 	struct key_vector *tn;
 	unsigned long i;
@@ -676,7 +679,7 @@ static struct key_vector *halve(struct trie *t,
 	}
 
 	/* setup the parent pointers into and out of this node */
-	return replace(t, oldtnode, tn);
+	return replace(t, oldtnode, tn, budget);
 nomem:
 	/* all pointers should be clean so we are done */
 	tnode_free(tn);
@@ -843,15 +846,15 @@ static inline bool should_collapse(struct key_vector *tn)
 	return used < 2;
 }
 
-#define MAX_WORK 10
-static struct key_vector *resize(struct trie *t, struct key_vector *tn)
+static struct key_vector *resize(struct trie *t, struct key_vector *tn,
+				 unsigned int *budget)
 {
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 	struct trie_use_stats __percpu *stats = t->stats;
 #endif
 	struct key_vector *tp = node_parent(tn);
 	unsigned long cindex = get_index(tn->key, tp);
-	int max_work = MAX_WORK;
+	bool inflated = false;
 
 	pr_debug("In tnode_resize %p inflate_threshold=%d threshold=%d\n",
 		 tn, inflate_threshold, halve_threshold);
@@ -865,8 +868,8 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
 	/* Double as long as the resulting node has a number of
 	 * nonempty nodes that are above the threshold.
 	 */
-	while (should_inflate(tp, tn) && max_work) {
-		tp = inflate(t, tn);
+	while (should_inflate(tp, tn) && *budget) {
+		tp = inflate(t, tn, budget);
 		if (!tp) {
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->resize_node_skipped);
@@ -874,22 +877,25 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
 			break;
 		}
 
-		max_work--;
+		(*budget)--;
+		inflated = true;
 		tn = get_child(tp, cindex);
 	}
 
 	/* update parent in case inflate failed */
 	tp = node_parent(tn);
 
-	/* Return if at least one inflate is run */
-	if (max_work != MAX_WORK)
+	/* Return if at least one inflate is run:
+	 * microoptimization to not recalculate thresholds
+	 */
+	if (inflated)
 		return tp;
 
 	/* Halve as long as the number of empty children in this
 	 * node is above threshold.
 	 */
-	while (should_halve(tp, tn) && max_work) {
-		tp = halve(t, tn);
+	while (should_halve(tp, tn) && *budget) {
+		tp = halve(t, tn, budget);
 		if (!tp) {
 #ifdef CONFIG_IP_FIB_TRIE_STATS
 			this_cpu_inc(stats->resize_node_skipped);
@@ -897,7 +903,7 @@ static struct key_vector *resize(struct trie *t, struct key_vector *tn)
 			break;
 		}
 
-		max_work--;
+		(*budget)--;
 		tn = get_child(tp, cindex);
 	}
 
@@ -1005,8 +1011,10 @@ static struct fib_alias *fib_find_alias(struct hlist_head *fah, u8 slen,
 
 static void trie_rebalance(struct trie *t, struct key_vector *tn)
 {
-	while (!IS_TRIE(tn))
-		tn = resize(t, tn);
+	unsigned int budget = fib_balance_budget;
+
+	while (budget && !IS_TRIE(tn))
+		tn = resize(t, tn, &budget);
 }
 
 static int fib_insert_node(struct trie *t, struct key_vector *tp,
@@ -1784,6 +1792,7 @@ struct fib_table *fib_trie_unmerge(struct fib_table *oldtb)
 void fib_table_flush_external(struct fib_table *tb)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	unsigned int budget = fib_balance_budget;
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -1806,7 +1815,7 @@ void fib_table_flush_external(struct fib_table *tb)
 				update_suffix(pn);
 
 			/* resize completed node */
-			pn = resize(t, pn);
+			pn = resize(t, pn, &budget);
 			cindex = get_index(pkey, pn);
 
 			continue;
@@ -1853,6 +1862,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	unsigned int budget = fib_balance_budget;
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -1876,7 +1886,7 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 				update_suffix(pn);
 
 			/* resize completed node */
-			pn = resize(t, pn);
+			pn = resize(t, pn, &budget);
 			cindex = get_index(pkey, pn);
 
 			continue;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ba0fc4b18465..d7274cc442af 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -443,6 +443,13 @@ static struct ctl_table ipv4_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
+	{
+		.procname	= "fib_balance_budget",
+		.data		= &fib_balance_budget,
+		.maxlen		= sizeof(fib_balance_budget),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
 	{
 		.procname	= "inet_peer_threshold",
 		.data		= &inet_peer_threshold,
-- 
2.21.0

