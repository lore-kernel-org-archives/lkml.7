Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C1EC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB5B2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946616;
	bh=X9rQqn3RVML5scKi1v7R7U/N/VpZlwDXMAzPgYQtncA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJ7ANiezlobri2h7CEP2Eywb5CLzsijTLnySk+DSJRev8zO1h+s+KMsdx3aAURzJQ
	 qr10YdIZhDuOPijO17jJ+IlnRlcwjJqO754ZdlIaKhMVHCoXtWoq5mc36LDLm+wCw/
	 UfAyGWtFkBfrqg7zL/yBrjvUA1Ml6s6r1tx5rQBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDKBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:36:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59393 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfDKBgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:36:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E174B95AA;
        Wed, 10 Apr 2019 21:36:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Apr 2019 21:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+np6ZQiGNtF1RzthBJCokkLQhVYLo5zEKFMlgFr5PgA=; b=qzRvdUhs
        UVD4kyF8HJ7vBxCzVS8IYhTP/yBOeoOJ8PIdPnqARP3eX3pn8F6bHlUMx4NW+bqS
        TqwY+D0W0EHYASNuJXP+gP0jMjXji0hadDm8uDWa0tHVduPZo9PkDV2urFfnpBL8
        V7T/5LcjbLCAgmpVvqlPD0rWxm8XqKY60exQ9yNtdL0WBZSj9jASXsvRdjQVjLei
        FMSrJfYK9pAIq+Lzk39T5xR8zFen5FVAEju0lGvafW4YFbO2D3nVD5GfRwM2j6wP
        VFa7jwTh1JmRZo22bmbrHGANnZOkZ2LO5RVRNArjecXWW0LAkKQP3A9DkiQ6Kat0
        I6b7rT7YLxEvkw==
X-ME-Sender: <xms:NZquXJ6FqX33i7PtYAMBUodN0doBj59LYc8vaXoKQPMkhfSfFEPYHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudejuddrudelrdduleegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NZquXEa7z3rdg0o8vLUCgRyen1outPCswxvBHkxKNxi7m-Fd3ppygA>
    <xmx:NZquXDGUAePeD-JWcaDMLAM9IuFEg7K7o1jSrEzlq80-8f_nzdzFDw>
    <xmx:NZquXHlsc_WOf9xte6pLrBd6-6P4jZxbN8N3Nm4lF10yIEV1UGpXcg>
    <xmx:NZquXO81NJpPSsKVIKunIoikdl7o-w391DaR7WTvCzi6a7KdZHe-OA>
Received: from eros.localdomain (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18549E408B;
        Wed, 10 Apr 2019 21:36:45 -0400 (EDT)
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
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 09/15] xarray: Implement migration function for objects
Date:   Thu, 11 Apr 2019 11:34:35 +1000
Message-Id: <20190411013441.5415-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411013441.5415-1-tobin@kernel.org>
References: <20190411013441.5415-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement functions to migrate objects. This is based on initial code by
Matthew Wilcox and was modified to work with slab object migration.

This patch can not be merged until all radix tree & IDR users are
converted to the XArray because xa_nodes and radix tree nodes share the
same slab cache (thanks Matthew).

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/radix-tree.c | 13 +++++++++++++
 lib/xarray.c     | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index 6be3acbb861f..731dd3d8ddb8 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1971,6 +1971,55 @@ void xa_destroy(struct xarray *xa)
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
+	if (xa != node->array) {
+		node = new_node;
+		goto unlock;
+	}
+
+	memcpy(new_node, node, sizeof(struct xa_node));
+
+	if (list_empty(&node->private_list))
+		INIT_LIST_HEAD(&new_node->private_list);
+	else
+		list_replace(&node->private_list, &new_node->private_list);
+
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

