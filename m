Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAFDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E706F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PXTAkF5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfCZPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:30:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43626 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbfCZPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:30:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id d26so11121772ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+L4U8orEw9uiR5qzAaEmkGzbeMHT+Q4wZ1ViLF3HGVk=;
        b=PXTAkF5/Q5z1rrjSOHkLwFICwkQZpzRlI0z+4S/sOIJjkfKYBLH0/INoo7a5vCg1mC
         hUyWaHnnJmsQlewOjVIML0P6hIX+T5kiDS45VTeH49TxBuhZlALjongUbJlvyCUV1F0j
         LCRM/nHSvvxzEOsVrjwR/x9bT8LFrEl7rNV9UYWf3L13qWRZf711rIfLEQXSFOs/71FK
         vgLhHKbI9fbQl8d1gKU7RqB8ugvcRgC7au6tswNmz463hDTwI6HTGsaL7SitzIvBc4fI
         iMgX08yVG3IIx0RBpDL3yjS2yY8nl0ZFWG6d/W0xowweqfoLlJUAH4QA/48douA/Exi1
         ogZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+L4U8orEw9uiR5qzAaEmkGzbeMHT+Q4wZ1ViLF3HGVk=;
        b=db+kDKyqV3pimyaJu4hudxnhN0vKXqIAU14+xzhs3hsus7T4bImF2RStWJVAZ6rO6P
         gICDx1WekenXjaeTIgFrbBZX2JLPyUxMJ/YJv0RzbH3Hm9mQ2z10GvjYyl2JDfcyOTMH
         zeQURT1SDgN/0NCPk3H/hrazVwRPo3bO/tyCtS6BQWpVm5UmZAlDBRZptkGNXqfFaUap
         fcWGLayuJi2coztxKgY8jNdk1vpm8eh+0LhZgPML9GklrE3oZnoHbDq85Pq1LiNvnp5X
         5RASnIi149zC0pl4T3YOF75vb198ym9A0+PJ3mENkEZHkDj/G+FonoFmwKZcUAzjO2lI
         yDOQ==
X-Gm-Message-State: APjAAAUMiSow7CBh8NH7U3cTiMXzg01YB7TaZBqQpAwt4WQqmqo4ViAH
        JerYfVLJI2erNxcvS0ddZaXpdrfCYr39zg==
X-Google-Smtp-Source: APXvYqwiO44bnS60Pv8ZisD4olxDZ7JAvGko4b8CQzXjI0kiBQrr3xXnDcL478L5bVov9bMWGXLNnQ==
X-Received: by 2002:a50:cd06:: with SMTP id z6mr20844524edi.163.1553614233194;
        Tue, 26 Mar 2019 08:30:33 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b2sm5310830eda.36.2019.03.26.08.30.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 08:30:32 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Subject: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
Date:   Tue, 26 Mar 2019 15:30:25 +0000
Message-Id: <20190326153026.24493-5-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326153026.24493-1-dima@arista.com>
References: <20190326153026.24493-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fib trie has a hard-coded sync_pages limit to call synchronise_rcu().
The limit is 128 pages or 512Kb (considering common case with 4Kb
pages).

Unfortunately, at Arista we have use-scenarios with full view software
forwarding. At the scale of 100K and more routes even on 2 core boxes
the hard-coded limit starts actively shooting in the leg: lockup
detector notices that rtnl_lock is held for seconds.
First reason is previously broken MAX_WORK, that didn't limit pending
balancing work. While fixing it, I've noticed that the bottle-neck is
actually in the number of synchronise_rcu() calls.

I've tried to fix it with a patch to decrement number of tnodes in rcu
callback, but it hasn't much affected performance.

One possible way to "fix" it - provide another sysctl to control
sync_pages, but in my POV it's nasty - exposing another realisation
detail into user-space.

To be complete honest, I'm not sure if calling rcu_synchronise() from
shrinker is a sane idea: during OOM we're slowed down enough and adding
synchronise there probably will noticeably falter a shrinker.

Anyway, I've got the following results on a very stupid benchmark that
adds one-by-one routes and removes them (with unlimited
fib_balance_budget) and measures time spent to remove one route:

*Before* on 4-cores switch (AMD GX-420CA SOC):
v4 Create of 4194304 routes: 76806ms
0(2097152): 000. 32.  0.  0	3353ms
1(3145729): 000. 48.  0.  1	1311ms
2(1048577): 000. 16.  0.  1	1286ms
3(524289): 000.  8.  0.  1	865ms
4(4098744): 000. 62.138.184	858ms
5(3145728): 000. 48.  0.  0	832ms
6(1048576): 000. 16.  0.  0	794ms
7(2621441): 000. 40.  0.  1	663ms
8(2621440): 000. 40.  0.  0	525ms
9(524288): 000.  8.  0.  0	508ms

v4 Delete of 4194304 routes: 111129ms
0(1589247): 000. 24. 63.255	3033ms
1(3702783): 000. 56.127.255	2833ms
2(3686399): 000. 56. 63.255	2630ms
3(1605631): 000. 24.127.255	2574ms
4(1581055): 000. 24. 31.255	2395ms
5(3671039): 000. 56.  3.255	2289ms
6(1573887): 000. 24.  3.255	2234ms
7(3678207): 000. 56. 31.255	2143ms
8(3670527): 000. 56.  1.255	2109ms
9(1573375): 000. 24.  1.255	2070ms

*After* on 4-cores switch:
v4 Create of 4194304 routes: 65305ms
0(2097153): 000. 32.  0.  1	1871ms
1(1048577): 000. 16.  0.  1	1064ms
2(2097152): 000. 32.  0.  0	905ms
3(524289): 000.  8.  0.  1	507ms
4(1048576): 000. 16.  0.  0	451ms
5(2097154): 000. 32.  0.  2	355ms
6(262145): 000.  4.  0.  1	240ms
7(524288): 000.  8.  0.  0	230ms
8(262144): 000.  4.  0.  0	115ms
9(131073): 000.  2.  0.  1	109ms

v4 Delete of 4194304 routes: 38015ms
0(3571711): 000. 54.127.255	1616ms
1(3565567): 000. 54.103.255	1340ms
2(3670015): 000. 55.255.255	1297ms
3(3565183): 000. 54.102.127	1226ms
4(3565159): 000. 54.102.103	912ms
5(3604479): 000. 54.255.255	596ms
6(3670016): 000. 56.  0.  0	474ms
7(3565311): 000. 54.102.255	434ms
8(3567615): 000. 54.111.255	388ms
9(3565167): 000. 54.102.111	376ms

After the patch there is one core, completely busy with the benchmark,
while previously neither CPU was busy. Controlling balancing budget
sysctl knob, one can distribute balancing work on add/remove a route
between neighbour changes (with the price of possibly less balanced trie
and a bit more expensive lookups).

Fixes: fc86a93b46d7 ("fib_trie: Push tnode flushing down to
inflate/halve")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/fib_trie.c | 53 +++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 2ce2739e7693..5773d479e7d2 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -184,16 +184,9 @@ struct trie {
 
 static struct key_vector *resize(struct trie *t, struct key_vector *tn,
 				 unsigned int *budget);
-static size_t tnode_free_size;
+static atomic_long_t objects_waiting_rcu;
 unsigned int fib_balance_budget = UINT_MAX;
 
-/*
- * synchronize_rcu after call_rcu for that many pages; it should be especially
- * useful before resizing the root node with PREEMPT_NONE configs; the value was
- * obtained experimentally, aiming to avoid visible slowdown.
- */
-static const int sync_pages = 128;
-
 static struct kmem_cache *fn_alias_kmem __ro_after_init;
 static struct kmem_cache *trie_leaf_kmem __ro_after_init;
 
@@ -306,11 +299,16 @@ static const int inflate_threshold_root = 30;
 static void __alias_free_mem(struct rcu_head *head)
 {
 	struct fib_alias *fa = container_of(head, struct fib_alias, rcu);
+
+	atomic_long_dec(&objects_waiting_rcu);
 	kmem_cache_free(fn_alias_kmem, fa);
 }
 
 static inline void alias_free_mem_rcu(struct fib_alias *fa)
 {
+	lockdep_rtnl_is_held();
+
+	atomic_long_inc(&objects_waiting_rcu);
 	call_rcu(&fa->rcu, __alias_free_mem);
 }
 
@@ -318,13 +316,40 @@ static void __node_free_rcu(struct rcu_head *head)
 {
 	struct tnode *n = container_of(head, struct tnode, rcu);
 
+	atomic_long_dec(&objects_waiting_rcu);
 	if (!n->tn_bits)
 		kmem_cache_free(trie_leaf_kmem, n);
 	else
 		kvfree(n);
 }
 
-#define node_free(n) call_rcu(&tn_info(n)->rcu, __node_free_rcu)
+static inline void node_free(struct key_vector *n)
+{
+	lockdep_rtnl_is_held();
+
+	atomic_long_inc(&objects_waiting_rcu);
+	call_rcu(&tn_info(n)->rcu, __node_free_rcu);
+}
+
+static unsigned long fib_shrink_count(struct shrinker *s,
+				      struct shrink_control *sc)
+{
+	return (unsigned long)atomic_long_read(&objects_waiting_rcu);
+}
+
+static unsigned long fib_shrink_scan(struct shrinker *s,
+				    struct shrink_control *sc)
+{
+	long ret = (unsigned long)atomic_long_read(&objects_waiting_rcu);
+
+	synchronize_rcu();
+	return (unsigned long)ret;
+}
+
+static struct shrinker fib_shrinker = {
+	.count_objects = fib_shrink_count,
+	.scan_objects = fib_shrink_scan,
+};
 
 static struct tnode *tnode_alloc(int bits)
 {
@@ -494,16 +519,9 @@ static void tnode_free(struct key_vector *tn)
 
 	while (head) {
 		head = head->next;
-		tnode_free_size += TNODE_SIZE(1ul << tn->bits);
 		node_free(tn);
-
 		tn = container_of(head, struct tnode, rcu)->kv;
 	}
-
-	if (tnode_free_size >= PAGE_SIZE * sync_pages) {
-		tnode_free_size = 0;
-		synchronize_rcu();
-	}
 }
 
 static struct key_vector *replace(struct trie *t,
@@ -2118,6 +2136,9 @@ void __init fib_trie_init(void)
 	trie_leaf_kmem = kmem_cache_create("ip_fib_trie",
 					   LEAF_SIZE,
 					   0, SLAB_PANIC, NULL);
+
+	if (register_shrinker(&fib_shrinker))
+		panic("IP FIB: failed to register fib_shrinker\n");
 }
 
 struct fib_table *fib_trie_table(u32 id, struct fib_table *alias)
-- 
2.21.0

