Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F11C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6718120863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfFRVFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:05:02 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:49063 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfFRVFB (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 18 Jun 2019 17:05:01 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 23:05:00 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 21:44:15 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     john.stultz@linaro.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -tip] lib/timerqueue: Rely on rbtree semantics for next timer
Date:   Tue, 18 Jun 2019 13:44:05 -0700
Message-Id: <20190618204405.27956-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the timerqueue code by using cached rbtrees and rely on the tree
leftmost node semantics to get the timer with earliest expiration time.
This is a drop in conversion, and therefore semantics remain untouched.

The runtime overhead of cached rbtrees is be pretty much the same as the
current head->next method, noting that when removing the leftmost node,
a common operation for the timerqueue, the rb_next(leftmost) is O(1) as
well, so the next timer will either be the right node or its parent.
Therefore no extra pointer chasing. Finally, the size of the struct
timerqueue_head remains the same.

Passes several hours of rcutorture.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/timerqueue.h | 13 ++++++-------
 lib/timerqueue.c           | 28 +++++++++++-----------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 78b8cc73f12f..aff122f1062a 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -12,8 +12,7 @@ struct timerqueue_node {
 };
 
 struct timerqueue_head {
-	struct rb_root head;
-	struct timerqueue_node *next;
+	struct rb_root_cached rb_root;
 };
 
 
@@ -29,13 +28,14 @@ extern struct timerqueue_node *timerqueue_iterate_next(
  *
  * @head: head of timerqueue
  *
- * Returns a pointer to the timer node that has the
- * earliest expiration time.
+ * Returns a pointer to the timer node that has the earliest expiration time.
  */
 static inline
 struct timerqueue_node *timerqueue_getnext(struct timerqueue_head *head)
 {
-	return head->next;
+	struct rb_node *leftmost = rb_first_cached(&head->rb_root);
+
+	return rb_entry(leftmost, struct timerqueue_node, node);
 }
 
 static inline void timerqueue_init(struct timerqueue_node *node)
@@ -45,7 +45,6 @@ static inline void timerqueue_init(struct timerqueue_node *node)
 
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
-	head->head = RB_ROOT;
-	head->next = NULL;
+	head->rb_root = RB_ROOT_CACHED;
 }
 #endif /* _LINUX_TIMERQUEUE_H */
diff --git a/lib/timerqueue.c b/lib/timerqueue.c
index bc7e64df27df..892d2bdc27f0 100644
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -26,9 +26,10 @@
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
-	struct rb_node **p = &head->head.rb_node;
+	struct rb_node **p = &head->rb_root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
-	struct timerqueue_node  *ptr;
+	struct timerqueue_node *ptr;
+	bool leftmost = true;
 
 	/* Make sure we don't add nodes that are already added */
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
@@ -38,17 +39,15 @@ bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 		ptr = rb_entry(parent, struct timerqueue_node, node);
 		if (node->expires < ptr->expires)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&node->node, parent, p);
-	rb_insert_color(&node->node, &head->head);
+	rb_insert_color_cached(&node->node, &head->rb_root, leftmost);
 
-	if (!head->next || node->expires < head->next->expires) {
-		head->next = node;
-		return true;
-	}
-	return false;
+	return leftmost;
 }
 EXPORT_SYMBOL_GPL(timerqueue_add);
 
@@ -65,15 +64,10 @@ bool timerqueue_del(struct timerqueue_head *head, struct timerqueue_node *node)
 {
 	WARN_ON_ONCE(RB_EMPTY_NODE(&node->node));
 
-	/* update next pointer */
-	if (head->next == node) {
-		struct rb_node *rbn = rb_next(&node->node);
-
-		head->next = rb_entry_safe(rbn, struct timerqueue_node, node);
-	}
-	rb_erase(&node->node, &head->head);
+	rb_erase_cached(&node->node, &head->rb_root);
 	RB_CLEAR_NODE(&node->node);
-	return head->next != NULL;
+
+	return !RB_EMPTY_ROOT(&head->rb_root.rb_root);
 }
 EXPORT_SYMBOL_GPL(timerqueue_del);
 
-- 
2.16.4

