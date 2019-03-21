Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DB821902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfCUTFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:05:20 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:51849 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfCUTFS (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Mar 2019 15:05:18 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 21 Mar 2019 20:05:16 +0100
Received: from localhost.localdomain (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 21 Mar 2019 19:04:44 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     manfred@colorfullife.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -next 2/2] ipc/mqueue: optimize msg_get()
Date:   Thu, 21 Mar 2019 12:02:16 -0700
Message-Id: <20190321190216.1719-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190321190216.1719-1-dave@stgolabs.net>
References: <20190321190216.1719-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our msg priorities became an rbtree as of

    d6629859b36d ("ipc/mqueue: improve performance of send/recv")

however, consuming a msg in msg_get() remains logarithmic (still being better
than the case before of course). By applying well known techniques to cache
pointers we can have the node with the highest priority in O(1), which is
specially nice for the rt cases. Furthermore, some callers can call msg_get()
in a loop.

A new msg_tree_erase() helper is also added to encapsulate the tree removal
and node_cache game. Passes ltp mq testcases.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/mqueue.c | 60 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index be3f599e90ed..0c68d8d4b1a9 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -76,6 +76,7 @@ struct mqueue_inode_info {
 	wait_queue_head_t wait_q;
 
 	struct rb_root msg_tree;
+	struct rb_node *msg_tree_rightmost;
 	struct posix_msg_tree_node *node_cache;
 	struct mq_attr attr;
 
@@ -131,6 +132,7 @@ static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 {
 	struct rb_node **p, *parent = NULL;
 	struct posix_msg_tree_node *leaf;
+	bool rightmost = true;
 
 	p = &info->msg_tree.rb_node;
 	while (*p) {
@@ -139,9 +141,10 @@ static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 
 		if (likely(leaf->priority == msg->m_type))
 			goto insert_msg;
-		else if (msg->m_type < leaf->priority)
+		else if (msg->m_type < leaf->priority) {
 			p = &(*p)->rb_left;
-		else
+			rightmost = false;
+		} else
 			p = &(*p)->rb_right;
 	}
 	if (info->node_cache) {
@@ -154,6 +157,10 @@ static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 		INIT_LIST_HEAD(&leaf->msg_list);
 	}
 	leaf->priority = msg->m_type;
+
+	if (rightmost)
+		info->msg_tree_rightmost = &leaf->rb_node;
+
 	rb_link_node(&leaf->rb_node, parent, p);
 	rb_insert_color(&leaf->rb_node, &info->msg_tree);
 insert_msg:
@@ -163,23 +170,35 @@ static int msg_insert(struct msg_msg *msg, struct mqueue_inode_info *info)
 	return 0;
 }
 
+static inline void msg_tree_erase(struct posix_msg_tree_node *leaf,
+				  struct mqueue_inode_info *info)
+{
+	struct rb_node *node = &leaf->rb_node;
+
+	if (info->msg_tree_rightmost == node)
+		info->msg_tree_rightmost = rb_prev(node);
+
+	rb_erase(node, &info->msg_tree);
+	if (info->node_cache) {
+		kfree(leaf);
+	} else {
+		info->node_cache = leaf;
+	}
+}
+
 static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
 {
-	struct rb_node **p, *parent = NULL;
+	struct rb_node *parent = NULL;
 	struct posix_msg_tree_node *leaf;
 	struct msg_msg *msg;
 
 try_again:
-	p = &info->msg_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		/*
-		 * During insert, low priorities go to the left and high to the
-		 * right.  On receive, we want the highest priorities first, so
-		 * walk all the way to the right.
-		 */
-		p = &(*p)->rb_right;
-	}
+	/*
+	 * During insert, low priorities go to the left and high to the
+	 * right.  On receive, we want the highest priorities first, so
+	 * walk all the way to the right.
+	 */
+	parent = info->msg_tree_rightmost;
 	if (!parent) {
 		if (info->attr.mq_curmsgs) {
 			pr_warn_once("Inconsistency in POSIX message queue, "
@@ -194,24 +213,14 @@ static inline struct msg_msg *msg_get(struct mqueue_inode_info *info)
 		pr_warn_once("Inconsistency in POSIX message queue, "
 			     "empty leaf node but we haven't implemented "
 			     "lazy leaf delete!\n");
-		rb_erase(&leaf->rb_node, &info->msg_tree);
-		if (info->node_cache) {
-			kfree(leaf);
-		} else {
-			info->node_cache = leaf;
-		}
+		msg_tree_erase(leaf, info);
 		goto try_again;
 	} else {
 		msg = list_first_entry(&leaf->msg_list,
 				       struct msg_msg, m_list);
 		list_del(&msg->m_list);
 		if (list_empty(&leaf->msg_list)) {
-			rb_erase(&leaf->rb_node, &info->msg_tree);
-			if (info->node_cache) {
-				kfree(leaf);
-			} else {
-				info->node_cache = leaf;
-			}
+			msg_tree_erase(leaf, info);
 		}
 	}
 	info->attr.mq_curmsgs--;
@@ -254,6 +263,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 		info->qsize = 0;
 		info->user = NULL;	/* set when all is ok */
 		info->msg_tree = RB_ROOT;
+		info->msg_tree_rightmost = NULL;
 		info->node_cache = NULL;
 		memset(&info->attr, 0, sizeof(info->attr));
 		info->attr.mq_maxmsg = min(ipc_ns->mq_msg_max,
-- 
2.16.4

