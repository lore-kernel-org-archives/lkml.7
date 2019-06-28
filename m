Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C95C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D19208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+MuVRlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfF1JQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40555 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1JQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so2662319pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXnF3iYyGg4UfoUHHK1tmv0Skp04CvidK4/eXPaeXXs=;
        b=c+MuVRlKnAwAHoW2coJ6rYQXo9lBnzwDw6OveR6uP4Ozi5u9VJHZjBihpls3VMTiCk
         HYtWpzT0i3pz/gjfLgHTTQsh0IAHs7BuGs0hCAbV8P+VVY9XZ439RzeDNYl9cZpo9QED
         lMyNnlHWNuq/Lmgu5OpW8EtZr7Mo+zx3i8gza/fg0NlnN22Ol9OBToygnaIwdO9dAiV1
         a+eXVLILaNJYvSinqrQEY7c+ipXbrowqvuSfX42HjmjhsQ5kprx60N+CVKuDUNd8RXE+
         5Nc2jXj1c6/k7UH7jzkvy54//muVCYTlheaKmqUPkvTABj+nCMMWwYz4fzrEzu9MIIkW
         UD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXnF3iYyGg4UfoUHHK1tmv0Skp04CvidK4/eXPaeXXs=;
        b=mMxGSCsLdh+3FTSuldsZdjlCp4/IWB3prLTB/8naMSSnj22Q4YPgNIkzU7aKJWQ1aw
         hLlMdciITsjlXsyTfH7S1xhKQzvR2ymZIjyUfUq/pQs9C3gNLEatVoXUa7hCgF/PQTq+
         RwCCskclIRUV8tnLGzIEb1JxZKtzdbDfpiICZD/xag2YW/bwAUXdkydP4b1S8uRjTUDv
         9TXhHUg8WTw3NguwqvhZSQ8aDRWkBm0KCMV5T6pk76Zg2mOZ1ba6jrOiFCclz99r4T8V
         sDFT7OSeZamBlQta6BTvD5w40wlK5qD6ly5Pzp2GhzBq1vZT6xcL0xTXPXxJipENpUTt
         +sjA==
X-Gm-Message-State: APjAAAVdVFWu7Tfr2GSBl6hkOOZX7xWtjDsxHTz7rHqPT1xCDZ5wRPIC
        Nb5SqBPhXyPp6s+3l7AGgCM=
X-Google-Smtp-Source: APXvYqxK7zdm0QHZZbhr6MhZHYZBOyaaGkRzaHJBFJLEWK3p1LcVOXhtTbFq7RIRGoGZQZgC7XtXUA==
X-Received: by 2002:a63:6155:: with SMTP id v82mr8128559pgb.304.1561713410915;
        Fri, 28 Jun 2019 02:16:50 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:50 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 15/30] locking/lockdep: Add lock chains to direct lock dependency graph
Date:   Fri, 28 Jun 2019 17:15:13 +0800
Message-Id: <20190628091528.17059-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock chains are derived from the current task lock stack. A lock chain
is a new sequence of locks taken by tasks or by interrupts "in the
tasks". It is not hard to notice that lockdep validates locking behavior
on lock chain basis, hence its main function name validate_chain(). With
a new lock chain, there may be a new direct dependency, and if so the
new dependency is checked.

Every direct lock dependency must be the top two locks in the lock
chains, but one direct dependency normally is associated with a number
of lock chains.

With such relationship between lock dependencies and lock chains, this
patch maps lock chains to their corresponding lock dependencies:

Lock dependency: L1 -> L2:
                    |
                    |--> Lock chain 1: .... L1 -> L2
                    |
                    |--> Lock chain 2: .... L1 -> L2
                    |
                  .....

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 79 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 36d55d3..3b655fd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -978,6 +978,33 @@ static bool __check_data_structures(void)
 			       e->class[1]->name ? : "(?)");
 			return false;
 		}
+
+		list_for_each_entry_rcu(chain, &e->chains, chain_entry) {
+			if (!check_lock_chain_key(chain))
+				return false;
+
+			/* <next> lock */
+			class = lock_classes +
+				chain_hlocks[chain->base + chain->depth - 1];
+			if (class != e->class[1]) {
+				printk(KERN_INFO "list entry %d has bad <next> lock; class %s <> %s\n",
+				       (unsigned int)(e - list_entries),
+				       class->name ? : "(?)",
+				       e->class[1]->name ? : "(?)");
+				return false;
+			}
+
+			/* <prev> lock */
+			class = lock_classes +
+				chain_hlocks[chain->base + chain->depth - 2];
+			if (class != e->class[0]) {
+				printk(KERN_INFO "list entry %d has bad <prev> lock; class %s <> %s\n",
+				       (unsigned int)(e - list_entries),
+				       class->name ? : "(?)",
+				       e->class[0]->name ? : "(?)");
+				return false;
+			}
+		}
 	}
 
 	/*
@@ -1004,6 +1031,16 @@ static bool __check_data_structures(void)
 			       e->class[1]->name : "(?)");
 			return false;
 		}
+
+		if (!list_empty(&e->chains)) {
+			printk(KERN_INFO "list entry %d has nonempty chain list; class %s <> %s\n",
+			       (unsigned int)(e - list_entries),
+			       e->class[0] && e->class[0]->name ? e->class[0]->name :
+			       "(?)",
+			       e->class[1] && e->class[1]->name ?
+			       e->class[1]->name : "(?)");
+			return false;
+		}
 	}
 
 	return true;
@@ -1060,6 +1097,9 @@ static void init_data_structures_once(void)
 		INIT_LIST_HEAD(&lock_classes[i].dep_list[0]);
 		INIT_LIST_HEAD(&lock_classes[i].dep_list[1]);
 	}
+
+	for (i = 0; i < ARRAY_SIZE(list_entries); i++)
+		INIT_LIST_HEAD(&list_entries[i].chains);
 }
 
 static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
@@ -1234,6 +1274,7 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 }
 
 #ifdef CONFIG_PROVE_LOCKING
+static DECLARE_BITMAP(lock_chains_in_dep, MAX_LOCKDEP_CHAINS);
 static inline struct
 lock_chain *lookup_chain_cache_add(struct task_struct *curr,
 				   struct held_lock *hlock,
@@ -1266,7 +1307,7 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *lock1, struct lock_class *lock2,
 			    unsigned long ip, int distance,
-			    struct lock_trace *trace)
+			    struct lock_trace *trace, struct lock_chain *chain)
 {
 	struct lock_list *entry;
 	/*
@@ -1290,6 +1331,12 @@ static int add_lock_to_list(struct lock_class *lock1, struct lock_class *lock2,
 	list_add_tail_rcu(&entry->entry[1], &lock1->dep_list[1]);
 	list_add_tail_rcu(&entry->entry[0], &lock2->dep_list[0]);
 
+	/*
+	 * Add the corresponding lock chain to lock_list's chains.
+	 */
+	list_add_tail_rcu(&chain->chain_entry, &entry->chains);
+	__set_bit(chain - lock_chains, lock_chains_in_dep);
+
 	return 1;
 }
 
@@ -2407,6 +2454,9 @@ static inline void inc_chains(void)
 		if (fw_dep_class(entry) == hlock_class(next)) {
 			debug_atomic_inc(nr_redundant);
 
+			list_add_tail_rcu(&chain->chain_entry, &entry->chains);
+			__set_bit(chain - lock_chains, lock_chains_in_dep);
+
 			if (distance == 1)
 				entry->distance = 1;
 
@@ -2450,8 +2500,7 @@ static inline void inc_chains(void)
 	 * dependency list of the previous lock <prev>:
 	 */
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       next->acquire_ip, distance, trace);
-
+			       next->acquire_ip, distance, trace, chain);
 	if (!ret)
 		return 0;
 
@@ -4711,8 +4760,11 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	 * If the modified lock chain matches an existing lock chain, drop
 	 * the modified lock chain.
 	 */
-	if (lookup_chain_cache(chain_key))
+	if (lookup_chain_cache(chain_key)) {
+		if (test_bit(chain - lock_chains, lock_chains_in_dep))
+			list_del_rcu(&chain->chain_entry);
 		return;
+	}
 	new_chain = alloc_lock_chain();
 	if (WARN_ON_ONCE(!new_chain)) {
 		debug_locks_off();
@@ -4720,6 +4772,10 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	}
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+	if (test_bit(chain - lock_chains, lock_chains_in_dep)) {
+		list_replace_rcu(&chain->chain_entry, &new_chain->chain_entry);
+		__set_bit(new_chain - lock_chains, lock_chains_in_dep);
+	}
 #endif
 }
 
@@ -4745,6 +4801,7 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 static void zap_class(struct pending_free *pf, struct lock_class *class)
 {
 	struct lock_list *entry;
+	struct lock_chain *chain;
 	int i;
 
 	WARN_ON_ONCE(!class->key);
@@ -4761,6 +4818,17 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		nr_list_entries--;
 		list_del_rcu(&entry->entry[0]);
 		list_del_rcu(&entry->entry[1]);
+		/*
+		 * Destroy the chain list by deleting every chain associated
+		 * with this lock_list entry.
+		 *
+		 * The corresponding lock chains in this lock_list will
+		 * be removed later by remove_class_from_lock_chains().
+		 */
+		list_for_each_entry_rcu(chain, &entry->chains, chain_entry) {
+			__clear_bit(chain - lock_chains, lock_chains_in_dep);
+			list_del_rcu(&chain->chain_entry);
+		}
 	}
 	if (list_empty(&class->dep_list[0]) &&
 	    list_empty(&class->dep_list[1])) {
@@ -4847,6 +4915,8 @@ static void __free_zapped_classes(struct pending_free *pf)
 #ifdef CONFIG_PROVE_LOCKING
 	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
 		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
+	bitmap_andnot(lock_chains_in_dep, lock_chains_in_dep,
+		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
 	bitmap_clear(pf->lock_chains_being_freed, 0, ARRAY_SIZE(lock_chains));
 #endif
 }
@@ -5125,6 +5195,7 @@ void __init lockdep_init(void)
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
 		+ sizeof(lock_chains_in_use)
+		+ sizeof(lock_chains_in_dep)
 		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
-- 
1.8.3.1

