Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44476C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120C520882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265904;
	bh=kMRUSHoj68+FFWDsB1DSNQtzYqLZr5/HMMcvP7yau6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZXlEaroNotbVoOeorvr3C+R60E5hFIZAdvwb+hdQLZfyBbgJ1hM321aP2tVH+F1X
	 pktnZl6Z0TR1BYowMAjvb7TzlWHOqbzwh4C/YGqdnIav6pfTV19k+06byBS4rhDFeg
	 YP5JA6l/WWdhmGlhDD9266ewTfbinQjmMFqbiBWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfDCEbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:31:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43441 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728687AbfDCEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 91FB421B84;
        Wed,  3 Apr 2019 00:23:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=uAywuLhgM6+Szq4etbWPzwmP073FVonmktwU8/xEONg=; b=xeXsXdNf
        P0XevguDVWe8R0wWT3qYLmuo5crZKYPd4pltu4WJxBU0f1oEsa362LSpgZ4CdNQZ
        InDlUyX3uK85y8/EYAAhVz5TMUtIHMgU5XXYa5LIjJPFILKnrfjMeJrdXL/dSU6Y
        pJlOZ3Mo836ihiKeOtTmLe+/CGXJQ8tmDK3FsS8LQUztBoDAC5+NA+JnSY/Zs4F4
        o+IXwNfDR69U8p86UcIwY8UpCknhFqteRa5q7IUTo/MbwI//s1f3+TKLxZTEVbA8
        HKFIpylGzC69vJxjlgNyf1x9aio4JulIFvN5CtZCFtfVq2Sk50jrULAcxMsV3Mx1
        hz3eqk7G3QXNhg==
X-ME-Sender: <xms:WDWkXD92euADIF6N_DJbNWkSRO_N_CpcPFa1Sim91M773aIhopolVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeek
X-ME-Proxy: <xmx:WDWkXClVAC0W5egos2v__G-wTzSARXKpUdBkMXnkSCfzSuzyzdSc3w>
    <xmx:WDWkXB245maRTv74OLD3kfyMI-v7-lhMbnlQL7b_QghGi1syx0TTqw>
    <xmx:WDWkXBRIHyxbCeDYWFfWcDfhHfVNqUKTfCX5zkvnPZIBIPLL0CJIyw>
    <xmx:WDWkXCJTa2wZTEzm6tGVMXngzOJXHP0PrA6YFc9lOtPc90Dn4cowdQ>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9597A100E5;
        Wed,  3 Apr 2019 00:23:45 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 09/14] xarray: Implement migration function for objects
Date:   Wed,  3 Apr 2019 15:21:22 +1100
Message-Id: <20190403042127.18755-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement functions to migrate objects. This is based on
initial code by Matthew Wilcox and was modified to work with
slab object migration.

Cc: Matthew Wilcox <willy@infradead.org>
Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/radix-tree.c | 13 +++++++++++++
 lib/xarray.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 14d51548bea6..9412c2853726 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1613,6 +1613,17 @@ static int radix_tree_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+extern void xa_object_migrate(void *tree_node, int numa_node);
+
+static void radix_tree_migrate(struct kmem_cache *s, void **objects, int nr,
+			       int node, void *private)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		xa_object_migrate(objects[i], node);
+}
+
 void __init radix_tree_init(void)
 {
 	int ret;
@@ -1627,4 +1638,6 @@ void __init radix_tree_init(void)
 	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
 					NULL, radix_tree_cpu_dead);
 	WARN_ON(ret < 0);
+	kmem_cache_setup_mobility(radix_tree_node_cachep, NULL,
+				  radix_tree_migrate);
 }
diff --git a/lib/xarray.c b/lib/xarray.c
index 6be3acbb861f..6d2657f2e4cb 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1971,6 +1971,52 @@ void xa_destroy(struct xarray *xa)
 }
 EXPORT_SYMBOL(xa_destroy);
 
+void xa_object_migrate(struct xa_node *node, int numa_node)
+{
+	struct xarray *xa = READ_ONCE(node->array);
+	void __rcu **slot;
+	struct xa_node *new_node;
+	int i;
+
+	/* Freed or not yet in tree then skip */
+	if (!xa || xa == XA_RCU_FREE)
+		return;
+
+	new_node = kmem_cache_alloc_node(radix_tree_node_cachep,
+					 GFP_KERNEL, numa_node);
+	if (!new_node)
+		return;
+
+	xa_lock_irq(xa);
+
+	/* Check again..... */
+	if (xa != node->array || !list_empty(&node->private_list)) {
+		node = new_node;
+		goto unlock;
+	}
+
+	memcpy(new_node, node, sizeof(struct xa_node));
+
+	/* Move pointers to new node */
+	INIT_LIST_HEAD(&new_node->private_list);
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		void *x = xa_entry_locked(xa, new_node, i);
+
+		if (xa_is_node(x))
+			rcu_assign_pointer(xa_to_node(x)->parent, new_node);
+	}
+	if (!new_node->parent)
+		slot = &xa->xa_head;
+	else
+		slot = &xa_parent_locked(xa, new_node)->slots[new_node->offset];
+	rcu_assign_pointer(*slot, xa_mk_node(new_node));
+
+unlock:
+	xa_unlock_irq(xa);
+	xa_node_free(node);
+	rcu_barrier();
+}
+
 #ifdef XA_DEBUG
 void xa_dump_node(const struct xa_node *node)
 {
-- 
2.21.0

