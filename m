Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E16233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX6yFEcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfH2Icw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfH2Icr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so1220063pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pd2tWt/TivQaT8AJfyMmh5GM/hnW5CS+5kLnssRIqRE=;
        b=rX6yFEcdPUs3219bX8D1deiBjodEaISyMF61hMhoh6wcgPDjhKQkbQaUkZ5CFCyizE
         4F0Px2vMqc9tT2MpU7JQ3fSkrinuFFz163VRm3Lu1jnoXv/QrIIh+DBzgz09B8H7WSV0
         NyORAxLpEIKJY95zH1zApc2A+dQh+jQosx+6T/0cQsHi/tX7J4ZCUUv+I39+BJmE3Ya8
         tM5xIbbLKfJ20NN1EgHXV0iNGzW1uY+qo4s3db4NxVnFrwM/qlcBwFW8uvMvpQ8KkBaI
         FWsb7LXfuNgx4IVWUbEHfKIZ4BOQI6m4AROHEjY+Xst9O4g3+Nx2nNOwvcEjRVGDyeRM
         5I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pd2tWt/TivQaT8AJfyMmh5GM/hnW5CS+5kLnssRIqRE=;
        b=aiFqJ4f24W2zjkmV2/GV9J4rQRV5ypcIUW/EUh7V7UmxEBhDQduqVyVYOyq0CetY0l
         5FaRxnPDUcyaoa04/FtKFEXRRZdbsA3DEQH1UceQLNnYVabU7XM6+qCXC7HazBMXmKxW
         mbDcMSPPugu98do6R7Trx/cLXQLV+RhmS9B48E8qyXU3jqrKse7o4ANTAlbWCIJrdi3F
         g+RW8FTC42r0intbrQ9N6woeY29koPkkXBMy0njY1yb7kt5ANuxKuviuIAykoO6xQOw5
         XWuYik4+F689EnqCGFY4etJV+dCPRYZUk8Mn1RpNH1Jq2ILSKsIENDFh9/+I/7VW33dV
         Hgzg==
X-Gm-Message-State: APjAAAWGAXBrFILeNatnUU9LuYjNYMSka+HLBAwUl5Yf+7tnSdZGrFCb
        Kl/T7uwyRItFCmm7gHWxo9A=
X-Google-Smtp-Source: APXvYqzUlJKVK2frbougaClZ8R4ylJjBbR/Wobki4ZugHpwnNzG0j5NHVmC01nMLbIxHJ9d4v2A5aw==
X-Received: by 2002:a63:5811:: with SMTP id m17mr7205624pgb.237.1567067567067;
        Thu, 29 Aug 2019 01:32:47 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:46 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 16/30] locking/lockdep: Add lock chains to direct lock dependency graph
Date:   Thu, 29 Aug 2019 16:31:18 +0800
Message-Id: <20190829083132.22394-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock chains are derived from the current task lock stack. A lock chain is a
new sequence of locks taken by task or by interrupt contexts. It is not hard
to notice that lockdep validates the locking behavior on a lock chain basis,
hence its main function name validate_chain(). With a new lock chain, there
may be a new direct dependency, and if so the new dependency is checked.

Every direct lock dependency must be the top two locks in the lock
chains, but one direct dependency normally is associated with a number
of lock chains.

With such relationship between lock dependencies and lock chains, this
patch maps lock chains to their corresponding lock dependencies, for
example:

Lock dependency: L1 -> L2:
                    |
                    |--> Lock chain 1: .... L1 -> L2
                    |
                    |--> Lock chain 2: .... L1 -> L2
                    |
                  .....

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 85 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 33f8187..754a718 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1046,6 +1046,35 @@ static bool __check_data_structures(void)
 			       e->class[1]->name ? : "(?)");
 			return false;
 		}
+
+#ifdef CONFIG_PROVE_LOCKING
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
+#endif
 	}
 
 	/*
@@ -1072,6 +1101,16 @@ static bool __check_data_structures(void)
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
@@ -1128,6 +1167,9 @@ static void init_data_structures_once(void)
 		INIT_LIST_HEAD(&lock_classes[i].dep_list[0]);
 		INIT_LIST_HEAD(&lock_classes[i].dep_list[1]);
 	}
+
+	for (i = 0; i < ARRAY_SIZE(list_entries); i++)
+		INIT_LIST_HEAD(&list_entries[i].chains);
 }
 
 static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
@@ -1302,6 +1344,7 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 }
 
 #ifdef CONFIG_PROVE_LOCKING
+static DECLARE_BITMAP(lock_chains_in_dep, MAX_LOCKDEP_CHAINS);
 static inline struct
 lock_chain *lookup_chain_cache_add(struct task_struct *curr,
 				   struct held_lock *hlock,
@@ -1335,7 +1378,8 @@ static struct lock_list *alloc_list_entry(void)
 static int add_lock_to_list(struct lock_class *lock1,
 			    struct lock_class *lock2,
 			    unsigned long ip, int distance,
-			    const struct lock_trace *trace)
+			    const struct lock_trace *trace,
+			    struct lock_chain *chain)
 {
 	struct lock_list *entry;
 	/*
@@ -1359,6 +1403,12 @@ static int add_lock_to_list(struct lock_class *lock1,
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
 
@@ -2478,6 +2528,9 @@ static inline void inc_chains(void)
 		if (fw_dep_class(entry) == hlock_class(next)) {
 			debug_atomic_inc(nr_redundant);
 
+			list_add_tail_rcu(&chain->chain_entry, &entry->chains);
+			__set_bit(chain - lock_chains, lock_chains_in_dep);
+
 			if (distance == 1)
 				entry->distance = 1;
 
@@ -2524,8 +2577,7 @@ static inline void inc_chains(void)
 	 * dependency list of the previous lock <prev>:
 	 */
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       next->acquire_ip, distance, *trace);
-
+			       next->acquire_ip, distance, *trace, chain);
 	if (!ret)
 		return 0;
 
@@ -4783,8 +4835,11 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
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
@@ -4792,6 +4847,10 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	}
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+	if (test_bit(chain - lock_chains, lock_chains_in_dep)) {
+		list_replace_rcu(&chain->chain_entry, &new_chain->chain_entry);
+		__set_bit(new_chain - lock_chains, lock_chains_in_dep);
+	}
 #endif
 }
 
@@ -4817,6 +4876,7 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 static void zap_class(struct pending_free *pf, struct lock_class *class)
 {
 	struct lock_list *entry;
+	struct lock_chain *chain;
 	int i;
 
 	WARN_ON_ONCE(!class->key);
@@ -4833,6 +4893,20 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		nr_list_entries--;
 		list_del_rcu(&entry->entry[0]);
 		list_del_rcu(&entry->entry[1]);
+
+#ifdef CONFIG_PROVE_LOCKING
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
+#endif
 	}
 	if (list_empty(&class->dep_list[0]) &&
 	    list_empty(&class->dep_list[1])) {
@@ -4919,6 +4993,8 @@ static void __free_zapped_classes(struct pending_free *pf)
 #ifdef CONFIG_PROVE_LOCKING
 	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
 		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
+	bitmap_andnot(lock_chains_in_dep, lock_chains_in_dep,
+		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
 	bitmap_clear(pf->lock_chains_being_freed, 0, ARRAY_SIZE(lock_chains));
 #endif
 }
@@ -5197,6 +5273,7 @@ void __init lockdep_init(void)
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
 		+ sizeof(lock_chains_in_use)
+		+ sizeof(lock_chains_in_dep)
 		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
-- 
1.8.3.1

