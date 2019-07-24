Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A16C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C2A21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rMnDkdbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGXQT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:19:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfGXQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:19:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6OGJDG0606946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Jul 2019 09:19:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6OGJDG0606946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563985154;
        bh=LP2lq02qjDx3WAEY7Ycm+qsiR6woRh87K5XpnhNtbD4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rMnDkdbJ2QY7EEohAmfxINKQTd2XBq1g7BTTm4s5ZQYQHgG8zddOg0zRL43Fw2pTm
         kB0MAgxsnpZZLHFc+obr8Md9pBAk8cXg+HxdJQGT19zUSeOzXtcrGmehi3LFGXvWCl
         N6f5CZtls7oIcnWShzAgCP2jfXa7Esmj7ZDHtXwE/zJeeMpRbPD/CpfBlrSNrEK0vP
         PoJKDWIbsMVtPsVLladOG4pZ6MrDplXS5JsciNYEyFqkRd7XmMdoYin8HJBU6n0yho
         dm7y0oGoJd/lFjISvXvcyA0ti5GIF3fIUt5CZi/IH7B4p8p+iyr03uBerqKwjruANm
         tCuBc4fgWkniQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6OGJDO3606943;
        Wed, 24 Jul 2019 09:19:13 -0700
Date:   Wed, 24 Jul 2019 09:19:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-511885d7061eda3eb1faf3f57dcc936ff75863f1@git.kernel.org>
Cc:     tglx@linutronix.de, dbueso@suse.de, mingo@kernel.org,
        dave@stgolabs.net, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, dave@stgolabs.net, dbueso@suse.de,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190724152323.bojciei3muvfxalm@linux-r8p5>
References: <20190724152323.bojciei3muvfxalm@linux-r8p5>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] lib/timerqueue: Rely on rbtree semantics for next
 timer
Git-Commit-ID: 511885d7061eda3eb1faf3f57dcc936ff75863f1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  511885d7061eda3eb1faf3f57dcc936ff75863f1
Gitweb:     https://git.kernel.org/tip/511885d7061eda3eb1faf3f57dcc936ff75863f1
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Wed, 24 Jul 2019 08:23:23 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 24 Jul 2019 17:38:01 +0200

lib/timerqueue: Rely on rbtree semantics for next timer

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190724152323.bojciei3muvfxalm@linux-r8p5

---
 include/linux/timerqueue.h | 13 ++++++-------
 lib/timerqueue.c           | 30 ++++++++++++------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

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
index bc7e64df27df..c52710964593 100644
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
@@ -36,19 +37,17 @@ bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 	while (*p) {
 		parent = *p;
 		ptr = rb_entry(parent, struct timerqueue_node, node);
-		if (node->expires < ptr->expires)
+		if (node->expires < ptr->expires) {
 			p = &(*p)->rb_left;
-		else
+		} else {
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
 
