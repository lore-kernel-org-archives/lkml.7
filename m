Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357FBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F234420828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951610;
	bh=om8HX3F1JQk0D3I7aUPL63MWrWDKGacZCIEb5Psjg9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1N7Sk4TqKw886LI3qVROgPvFFp8q9hcZ+iYWuLC39a4+mldlYaAcrVoFGqL1NHfer
	 LQeCL2fujXOKHHQrTt5DwrVaoN0zY7hJULePXvQdC53Epm+XQhgOizxwVWcV01o6ih
	 vQ/IaOb0oL8sCdLlfO+t6WpYxBcmvDBmHpHmmdik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLJEUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfLJEUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:06 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232D720836;
        Tue, 10 Dec 2019 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951605;
        bh=om8HX3F1JQk0D3I7aUPL63MWrWDKGacZCIEb5Psjg9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEUFzaxmNivRQSSB7xxaWvz+8xhj+go/LfiQHyffh1jYDyZ5iHnvV1KkOLuc4MN73
         wBvp5xVghYqOqE2bWTfegZbbRHiVQdVJpNHblTgj1SVeF/G3RCgpfMTflfyFMFuAfA
         Zkfw1/Zxz2iOpc2zJmwCsb9oeCQ+vdEZr/D1l//o=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/9] list: Add hlist_unhashed_lockless()
Date:   Mon,  9 Dec 2019 20:19:55 -0800
Message-Id: <20191210042002.3490-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

We would like to use hlist_unhashed() from timer_pending(),
which runs without protection of a lock.

Note that other callers might also want to use this variant.

Instead of forcing a READ_ONCE() for all hlist_unhashed()
callers, add a new helper with an explicit _lockless suffix
in the name to better document what is going on.

Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
and hlist_add_before()/hlist_add_behind() to pair with
the READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
[ paulmck: Also add WRITE_ONCE() to rculist.h. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h    | 32 +++++++++++++++++++++-----------
 include/linux/rculist.h | 24 ++++++++++++------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 85c9255..61f5aaf 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -749,6 +749,16 @@ static inline int hlist_unhashed(const struct hlist_node *h)
 	return !h->pprev;
 }
 
+/* This variant of hlist_unhashed() must be used in lockless contexts
+ * to avoid potential load-tearing.
+ * The READ_ONCE() is paired with the various WRITE_ONCE() in hlist
+ * helpers that are defined below.
+ */
+static inline int hlist_unhashed_lockless(const struct hlist_node *h)
+{
+	return !READ_ONCE(h->pprev);
+}
+
 static inline int hlist_empty(const struct hlist_head *h)
 {
 	return !READ_ONCE(h->first);
@@ -761,7 +771,7 @@ static inline void __hlist_del(struct hlist_node *n)
 
 	WRITE_ONCE(*pprev, next);
 	if (next)
-		next->pprev = pprev;
+		WRITE_ONCE(next->pprev, pprev);
 }
 
 static inline void hlist_del(struct hlist_node *n)
@@ -782,32 +792,32 @@ static inline void hlist_del_init(struct hlist_node *n)
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
-	n->next = first;
+	WRITE_ONCE(n->next, first);
 	if (first)
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 	WRITE_ONCE(h->first, n);
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 }
 
 /* next must be != NULL */
 static inline void hlist_add_before(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
-	n->next = next;
-	next->pprev = &n->next;
+	WRITE_ONCE(n->pprev, next->pprev);
+	WRITE_ONCE(n->next, next);
+	WRITE_ONCE(next->pprev, &n->next);
 	WRITE_ONCE(*(n->pprev), n);
 }
 
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	n->next = prev->next;
-	prev->next = n;
-	n->pprev = &prev->next;
+	WRITE_ONCE(n->next, prev->next);
+	WRITE_ONCE(prev->next, n);
+	WRITE_ONCE(n->pprev, &prev->next);
 
 	if (n->next)
-		n->next->pprev  = &n->next;
+		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 /* after that we'll appear to be on some hlist and hlist_del will work */
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 61c6728a..4b7ae1b 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -173,7 +173,7 @@ static inline void hlist_del_init_rcu(struct hlist_node *n)
 {
 	if (!hlist_unhashed(n)) {
 		__hlist_del(n);
-		n->pprev = NULL;
+		WRITE_ONCE(n->pprev, NULL);
 	}
 }
 
@@ -473,7 +473,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 static inline void hlist_del_rcu(struct hlist_node *n)
 {
 	__hlist_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
@@ -489,11 +489,11 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
 	struct hlist_node *next = old->next;
 
 	new->next = next;
-	new->pprev = old->pprev;
+	WRITE_ONCE(new->pprev, old->pprev);
 	rcu_assign_pointer(*(struct hlist_node __rcu **)new->pprev, new);
 	if (next)
-		new->next->pprev = &new->next;
-	old->pprev = LIST_POISON2;
+		WRITE_ONCE(new->next->pprev, &new->next);
+	WRITE_ONCE(old->pprev, LIST_POISON2);
 }
 
 /*
@@ -528,10 +528,10 @@ static inline void hlist_add_head_rcu(struct hlist_node *n,
 	struct hlist_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_first_rcu(h), n);
 	if (first)
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 /**
@@ -564,7 +564,7 @@ static inline void hlist_add_tail_rcu(struct hlist_node *n,
 
 	if (last) {
 		n->next = last->next;
-		n->pprev = &last->next;
+		WRITE_ONCE(n->pprev, &last->next);
 		rcu_assign_pointer(hlist_next_rcu(last), n);
 	} else {
 		hlist_add_head_rcu(n, h);
@@ -592,10 +592,10 @@ static inline void hlist_add_tail_rcu(struct hlist_node *n,
 static inline void hlist_add_before_rcu(struct hlist_node *n,
 					struct hlist_node *next)
 {
-	n->pprev = next->pprev;
+	WRITE_ONCE(n->pprev, next->pprev);
 	n->next = next;
 	rcu_assign_pointer(hlist_pprev_rcu(n), n);
-	next->pprev = &n->next;
+	WRITE_ONCE(next->pprev, &n->next);
 }
 
 /**
@@ -620,10 +620,10 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 					struct hlist_node *prev)
 {
 	n->next = prev->next;
-	n->pprev = &prev->next;
+	WRITE_ONCE(n->pprev, &prev->next);
 	rcu_assign_pointer(hlist_next_rcu(prev), n);
 	if (n->next)
-		n->next->pprev = &n->next;
+		WRITE_ONCE(n->next->pprev, &n->next);
 }
 
 #define __hlist_for_each_rcu(pos, head)				\
-- 
2.9.5

