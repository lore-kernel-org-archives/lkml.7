Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60918C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2653C20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554265913;
	bh=01Q+hEZMNHcrdU4lHpQCIXnBidDnS2K0SW8M5Ve15ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pjj6dS5S3zLGWrPFjQKsL9v+xxuPq95IXPUpvzP48p7E8J31mHfmaxJndqYPZi4in
	 D2SMo9+5Xwt8llB83dGIivkpikLbBkq8JtURxRCbEqyQhnnxZVHiHEo1+8VuUgNaL+
	 yYLMNJm/jR+63383NwuskdBkmzQr4pkKuwLjb6PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfDCEbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:31:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55021 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbfDCEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:31:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F3F2921BCD;
        Wed,  3 Apr 2019 00:24:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 00:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=aa6iExGIwghZDn1ZohvQXbuCEdzySOldf4bort+1eX4=; b=8XjWeMn3
        stH473eDauTmxcBAVjsdZ6VLe07BfcTO+2jHtP6gWq0xcnjBPRi3hGnlBM9khyi4
        x7rcfhtn6on7u25FsA2urq4JCHEBepYJkczrl/3vlZ48x4/DSRQKqoEWbBnBvVfJ
        MxfOOHWtw0PZu+4cT57honGKLamY1JbCpj+a27p+axoBMaxq5f4bSlAr2TeE93n/
        U5cd+18ck6m9ASBOCRNlBOQYvXX19OfKV4J3f9gfs/p/Ykio4ZEep0Nd/8CLNKMu
        SmIyQa15UNhCGj7disyal3eeyG8Ig8iFK8sUvsUwB+8kAaMt75jfZBoxCvTOLV4w
        pZs8GJCUsqb2jg==
X-ME-Sender: <xms:bjWkXDI7rudn-Spb64giJmJB-shiY4vTqGZ_skv51pgdHoA5qXG9nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddugdektdculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrh
    hnvghlrdhorhhgqeenucfkphepuddvgedrudeiledrvdejrddvtdeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpeduud
X-ME-Proxy: <xmx:bjWkXLvrdzTT7ajNuVw9SLH6CPT_arCRO7SQzZJZtutKtjnPIamIig>
    <xmx:bjWkXBLk7a4fcv0_qLI004cSSpfO6qoAz8X7y3Sk0CqidPNOwGEBCw>
    <xmx:bjWkXPCvuHXbiwvTJ5vYueFxFzCv4Ebf0k_izTZhK4_Nffhbc-DnSg>
    <xmx:bjWkXPa31EcJUk2qFxh9OGXpoCT9D-VcIsScU2hancUDnJyxI199sg>
Received: from eros.localdomain (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 22EAF100E5;
        Wed,  3 Apr 2019 00:24:07 -0400 (EDT)
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
Subject: [RFC PATCH v2 12/14] slub: Enable balancing slabs across nodes
Date:   Wed,  3 Apr 2019 15:21:25 +1100
Message-Id: <20190403042127.18755-13-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403042127.18755-1-tobin@kernel.org>
References: <20190403042127.18755-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have just implemented Slab Movable Objects (SMO).  On NUMA systems
slabs can become unbalanced i.e. many slabs on one node while other
nodes have few slabs.  Using SMO we can balance the slabs across all
the nodes.

The algorithm used is as follows:

 1. Move all objects to node 0 (this has the effect of defragmenting the
    cache).

 2. Calculate the desired number of slabs for each node (this is done
    using the approximation nr_slabs / nr_nodes).

 3. Loop over the nodes moving the desired number of slabs from node 0
    to the node.

Feature is conditionally built in with CONFIG_SMO_NODE, this is because
we need the full list (we enable SLUB_DEBUG to get this).  Future
version may separate final list out of SLUB_DEBUG.

Expose this functionality to userspace via a sysfs entry.  Add sysfs
entry:

       /sysfs/kernel/slab/<cache>/balance

Write of '1' to this file triggers balance, no other value accepted.

This feature relies on SMO being enable for the cache, this is done with
a call to, after the isolate/migrate functions have been defined.

	kmem_cache_setup_mobility(s, isolate, migrate)

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slub.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index e4f3dde443f5..a5c48c41d72b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4583,6 +4583,109 @@ static unsigned long kmem_cache_move_to_node(struct kmem_cache *s, int node)
 
 	return left;
 }
+
+/*
+ * kmem_cache_move_slabs() - Attempt to move @num slabs to target_node,
+ * @s: The cache we are working on.
+ * @node: The node to move objects from.
+ * @target_node: The node to move objects to.
+ * @num: The number of slabs to move.
+ *
+ * Attempts to move @num slabs from @node to @target_node.  This is done
+ * by migrating objects from slabs on the full_list.
+ *
+ * Return: The number of slabs moved or error code.
+ */
+static long kmem_cache_move_slabs(struct kmem_cache *s,
+				  int node, int target_node, long num)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+	LIST_HEAD(move_list);
+	struct page *page, *page2;
+	unsigned long flags;
+	void **scratch;
+	long done = 0;
+
+	if (node == target_node)
+		return -EINVAL;
+
+	scratch = alloc_scratch(s);
+	if (!scratch)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&n->list_lock, flags);
+	list_for_each_entry_safe(page, page2, &n->full, lru) {
+		if (!slab_trylock(page))
+			/* Busy slab. Get out of the way */
+			continue;
+
+		list_move(&page->lru, &move_list);
+		page->frozen = 1;
+		slab_unlock(page);
+
+		if (++done >= num)
+			break;
+	}
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	list_for_each_entry(page, &move_list, lru) {
+		if (page->inuse)
+			move_slab_page(page, scratch, target_node);
+	}
+	kfree(scratch);
+
+	/* Inspect results and dispose of pages */
+	spin_lock_irqsave(&n->list_lock, flags);
+	list_for_each_entry_safe(page, page2, &move_list, lru) {
+		list_del(&page->lru);
+		slab_lock(page);
+		page->frozen = 0;
+
+		if (page->inuse) {
+			/*
+			 * This is best effort only, if slab still has
+			 * objects just put it back on the partial list.
+			 */
+			n->nr_partial++;
+			list_add_tail(&page->lru, &n->partial);
+			slab_unlock(page);
+		} else {
+			slab_unlock(page);
+			discard_slab(s, page);
+		}
+	}
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	return done;
+}
+
+/*
+ * kmem_cache_balance_nodes() - Balance slabs across nodes.
+ * @s: The cache we are working on.
+ */
+static void kmem_cache_balance_nodes(struct kmem_cache *s)
+{
+	struct kmem_cache_node *n = get_node(s, 0);
+	unsigned long desired_nr_slabs_per_node;
+	unsigned long nr_slabs;
+	int nr_nodes = 0;
+	int nid;
+
+	(void)kmem_cache_move_to_node(s, 0);
+
+	for_each_node_state(nid, N_NORMAL_MEMORY)
+		nr_nodes++;
+
+	nr_slabs = atomic_long_read(&n->nr_slabs);
+	desired_nr_slabs_per_node = nr_slabs / nr_nodes;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		if (nid == 0)
+			continue;
+
+		kmem_cache_move_slabs(s, 0, nid, desired_nr_slabs_per_node);
+	}
+}
 #endif
 
 /**
@@ -5847,6 +5950,22 @@ static ssize_t move_store(struct kmem_cache *s, const char *buf, size_t length)
 	return length;
 }
 SLAB_ATTR(move);
+
+static ssize_t balance_show(struct kmem_cache *s, char *buf)
+{
+	return 0;
+}
+
+static ssize_t balance_store(struct kmem_cache *s,
+			     const char *buf, size_t length)
+{
+	if (buf[0] == '1')
+		kmem_cache_balance_nodes(s);
+	else
+		return -EINVAL;
+	return length;
+}
+SLAB_ATTR(balance);
 #endif	/* CONFIG_SMO_NODE */
 
 #ifdef CONFIG_NUMA
@@ -5975,6 +6094,7 @@ static struct attribute *slab_attrs[] = {
 	&shrink_attr.attr,
 #ifdef CONFIG_SMO_NODE
 	&move_attr.attr,
+	&balance_attr.attr,
 #endif
 	&slabs_cpu_partial_attr.attr,
 #ifdef CONFIG_SLUB_DEBUG
-- 
2.21.0

