Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE8BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60C20644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hrLmkwAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfHASO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:14:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40384 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388150AbfHASOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:14:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so32512060pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtEVs28pcx+R11OqcxdYNvkun1RRpQ2WR9PzINStNLg=;
        b=hrLmkwAen060wVuTuRN9+LZt8J5otJRPcPXHJtayUa2WUrf43XWDWat3sgIJORZfoU
         yB/0dLVKoTEiUK+dPNVTwXWJnMOW+8w7UuRY1AuTD/ym0HjNMlcg3PsmXWMeVI2dzKVi
         CmzYPOzWN1rTfdBooVbmSgmv4lQG0fs3vBIVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtEVs28pcx+R11OqcxdYNvkun1RRpQ2WR9PzINStNLg=;
        b=hOwJoVbWD8iimorlkkVPvP5KNgEYCr/4i7NeddRyGu8xl5S3mhF0tFedImPf9TDuz5
         odDqZijn4+oMgFU8QWODFYoVWNbf4MiYQW/YxXqGvZo7UAg34n+6bzn2zixFZmmZ2U8F
         i9AORFGTuC6iGRu/xOMIqPIPTY1ySJ71rwCo/OyQuRsMOdfTTpJ+TpFO74f/ftsG7/ul
         xY64IfzZKGynW/CM7fPOkYnozfpplttKBULMbtVcgEnQc3XLQ8RmzCNnPx80Ivbpv2mB
         L/4Vzx4DaC/BAV1HSZnrulQMM3L4tmmUCbFZyO3zh4L05mcUgcEogrWp/nQTVF2liG4J
         lJBw==
X-Gm-Message-State: APjAAAURZz9t8h/7CTVMMSnKX0vYkvax//BXhAPkPE3Ed587qZxGnc7Y
        vx6XVyY/kf+bxUj3M3P5AWLPnPrX
X-Google-Smtp-Source: APXvYqweR0QhDFV49qYIb/4bJwnBtq6UZQg5DpSScdNEGAAT4fMLlF4ZORXJ22Fo2EMsEwN7/gIMaQ==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr128386713pln.304.1564683261513;
        Thu, 01 Aug 2019 11:14:21 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g8sm82089165pgk.1.2019.08.01.11.14.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:14:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH 2/9] Revert "rcu: Add support for consolidated-RCU reader checking"
Date:   Thu,  1 Aug 2019 14:14:04 -0400
Message-Id: <20190801181411.96429-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
References: <20190801181411.96429-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 50ad3f1f9b13c8a6f2ae79df4cecb2c21da1c7c8.
---
 include/linux/rculist.h  | 32 ++++----------------
 include/linux/rcupdate.h |  7 -----
 kernel/rcu/Kconfig.debug | 11 -------
 kernel/rcu/update.c      | 65 ++++++++++++++--------------------------
 4 files changed, 27 insertions(+), 88 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4158b7212936..932296144131 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -40,24 +40,6 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
 
-/*
- * Check during list traversal that we are within an RCU reader
- */
-
-#define check_arg_count_one(dummy)
-
-#ifdef CONFIG_PROVE_RCU_LIST
-#define __list_check_rcu(dummy, cond, extra...)				\
-	({								\
-	check_arg_count_one(extra);					\
-	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
-			 "RCU-list traversed in non-reader section!");	\
-	 })
-#else
-#define __list_check_rcu(dummy, cond, extra...)				\
-	({ check_arg_count_one(extra); })
-#endif
-
 /*
  * Insert a new entry between two known consecutive entries.
  *
@@ -361,16 +343,14 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
- * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
-#define list_for_each_entry_rcu(pos, head, member, cond...)		\
-	for (__list_check_rcu(dummy, ## cond, 0),			\
-	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
-		&pos->member != (head);					\
+#define list_for_each_entry_rcu(pos, head, member) \
+	for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
+		&pos->member != (head); \
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
 /**
@@ -636,15 +616,13 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
- * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
-#define hlist_for_each_entry_rcu(pos, head, member, cond...)		\
-	for (__list_check_rcu(dummy, ## cond, 0),			\
-	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
+#define hlist_for_each_entry_rcu(pos, head, member)			\
+	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
 			typeof(*(pos)), member);			\
 		pos;							\
 		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 80d6056f5855..bfcafbc1e301 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -221,7 +221,6 @@ int debug_lockdep_rcu_enabled(void);
 int rcu_read_lock_held(void);
 int rcu_read_lock_bh_held(void);
 int rcu_read_lock_sched_held(void);
-int rcu_read_lock_any_held(void);
 
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
@@ -242,12 +241,6 @@ static inline int rcu_read_lock_sched_held(void)
 {
 	return !preemptible();
 }
-
-static inline int rcu_read_lock_any_held(void)
-{
-	return !preemptible();
-}
-
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 #ifdef CONFIG_PROVE_RCU
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4aa02eee8f6c..5ec3ea4028e2 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -8,17 +8,6 @@ menu "RCU Debugging"
 config PROVE_RCU
 	def_bool PROVE_LOCKING
 
-config PROVE_RCU_LIST
-	bool "RCU list lockdep debugging"
-	depends on PROVE_RCU && RCU_EXPERT
-	default n
-	help
-	  Enable RCU lockdep checking for list usages. By default it is
-	  turned off since there are several list RCU users that still
-	  need to be converted to pass a lockdep expression. To prevent
-	  false-positive splats, we keep it default disabled but once all
-	  users are converted, we can remove this config option.
-
 config TORTURE_TEST
 	tristate
 	default n
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c768f1fd6804..64e9cc8609e7 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -91,30 +91,19 @@ module_param(rcu_normal_after_boot, int, 0);
  * Similarly, we avoid claiming an SRCU read lock held if the current
  * CPU is offline.
  */
-static bool rcu_read_lock_held_common(bool *ret)
-{
-	if (!debug_lockdep_rcu_enabled()) {
-		*ret = 1;
-		return true;
-	}
-	if (!rcu_is_watching()) {
-		*ret = 0;
-		return true;
-	}
-	if (!rcu_lockdep_current_cpu_online()) {
-		*ret = 0;
-		return true;
-	}
-	return false;
-}
-
 int rcu_read_lock_sched_held(void)
 {
-	bool ret;
+	int lockdep_opinion = 0;
 
-	if (rcu_read_lock_held_common(&ret))
-		return ret;
-	return lock_is_held(&rcu_sched_lock_map) || !preemptible();
+	if (!debug_lockdep_rcu_enabled())
+		return 1;
+	if (!rcu_is_watching())
+		return 0;
+	if (!rcu_lockdep_current_cpu_online())
+		return 0;
+	if (debug_locks)
+		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
+	return lockdep_opinion || !preemptible();
 }
 EXPORT_SYMBOL(rcu_read_lock_sched_held);
 #endif
@@ -271,10 +260,12 @@ NOKPROBE_SYMBOL(debug_lockdep_rcu_enabled);
  */
 int rcu_read_lock_held(void)
 {
-	bool ret;
-
-	if (rcu_read_lock_held_common(&ret))
-		return ret;
+	if (!debug_lockdep_rcu_enabled())
+		return 1;
+	if (!rcu_is_watching())
+		return 0;
+	if (!rcu_lockdep_current_cpu_online())
+		return 0;
 	return lock_is_held(&rcu_lock_map);
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_held);
@@ -296,28 +287,16 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_held);
  */
 int rcu_read_lock_bh_held(void)
 {
-	bool ret;
-
-	if (rcu_read_lock_held_common(&ret))
-		return ret;
+	if (!debug_lockdep_rcu_enabled())
+		return 1;
+	if (!rcu_is_watching())
+		return 0;
+	if (!rcu_lockdep_current_cpu_online())
+		return 0;
 	return in_softirq() || irqs_disabled();
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
-int rcu_read_lock_any_held(void)
-{
-	bool ret;
-
-	if (rcu_read_lock_held_common(&ret))
-		return ret;
-	if (lock_is_held(&rcu_lock_map) ||
-	    lock_is_held(&rcu_bh_lock_map) ||
-	    lock_is_held(&rcu_sched_lock_map))
-		return 1;
-	return !preemptible();
-}
-EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
-
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
-- 
2.22.0.770.g0f2c4a37fd-goog

