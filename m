Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E1EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F376B20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552018560;
	bh=MvbJizNB0oxyKHbV5XWlhRXr+GPk4tLDiDap/4QcPsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/H2v4LvqwFGGVeYCLAISbRxkjjyxgaWEsV+sqNu9PM6TyE/Hz/4AmB7ZJ5ib/9L+
	 dXtBjsmj74xRtmJadI6DbQ/qz0JBglqpKhd4x3gYFk83m8Uf6+qITfrPxYlXjwGRtc
	 XjtKEM+xBNWyZujExh8d3pDR/98nJUVjj4Tutq6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCHEP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:15:58 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51531 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfCHEPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:15:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D3DC7344B;
        Thu,  7 Mar 2019 23:15:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 23:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=C1UFNBfZ1PMvCNxNU0QdAtVm0PxPQxmOQ26CPtV4v/w=; b=Qmgo7VSB
        25Hv9qMlIjQRkzsqOTVGEP5pLcSbpt3DJWN8NWVNcmjDKNpiyIyEtFWdajaruenR
        33v3iwjZWOfl5JkRUIRJC7kJAtaxoxgARgjAq1sufoH46mTMp1QyzGDSsfgqa5O+
        6w+qnrmhq4BO9tyIg4nccAOu0S+AjwSUgNpgIuqfcJ8fTCW664/tarqTE/ut3iGn
        PDO2Xsa0JWcl2TVuPC7cKht8NTrIxwF6mdZUrsCduNPz+y6CojsMKS1qQMo6szLW
        aoGsCaX8wrSfQbcVPagNzwupUVF6poQuujexNn1h9A/qGLh/msC9US0BgBrnwYm4
        zMDmQoMU8kUyiQ==
X-ME-Sender: <xms:eOyBXPurOQTwkP8AG9egnxs-3gU5aP-8JZef8WSS_sat6m_XAaU1Vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudeg
X-ME-Proxy: <xmx:eOyBXFFdpEdM1h3tbFwsgeor7IYGiE3xhifLk4MeDOAhEcUnmnHF3A>
    <xmx:eOyBXK4YDy2cIezjiVSvUpT6pIoSva4FlSS4iZtU1rwF_OoL9YjseQ>
    <xmx:eOyBXIXk3rc5QMoBiJCjc3AuwVL_W8l-PS3x1OnU9nXn5Q26hIxMoA>
    <xmx:eOyBXNHnCDk4TdN97Fy1SwrgY_2GiVVIqywcOrrE3Cksv3BdqeXnMw>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38D21E4548;
        Thu,  7 Mar 2019 23:15:48 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 15/15] slub: Enable balancing slab objects across nodes
Date:   Fri,  8 Mar 2019 15:14:26 +1100
Message-Id: <20190308041426.16654-16-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
References: <20190308041426.16654-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have just implemented Slab Movable Objects (SMO).  On NUMA systems
slabs can become unbalanced i.e. many objects on one node while other
nodes have few objects.  Using SMO we can balance the objects across all
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
 mm/slub.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index ac9b8f592e10..65cf305a70c3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4584,6 +4584,104 @@ static unsigned long __move_all_objects_to(struct kmem_cache *s, int node)
 
 	return left;
 }
+
+/*
+ * __move_n_slabs() - Attempt to move 'num' slabs to target_node,
+ * Return: The number of slabs moved or error code.
+ */
+static long __move_n_slabs(struct kmem_cache *s, int node, int target_node,
+			   long num)
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
+			__move(page, scratch, target_node);
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
+ * __balance_nodes_partial() - Balance partial objects.
+ * @s: The cache we are working on.
+ *
+ * Attempt to balance the objects that are in partial slabs evenly
+ * across all nodes.
+ */
+static void __balance_nodes_partial(struct kmem_cache *s)
+{
+	struct kmem_cache_node *n = get_node(s, 0);
+	unsigned long desired_nr_slabs_per_node;
+	unsigned long nr_slabs;
+	int nr_nodes = 0;
+	int nid;
+
+	(void)__move_all_objects_to(s, 0);
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
+		__move_n_slabs(s, 0, nid, desired_nr_slabs_per_node);
+	}
+}
 #endif
 
 /**
@@ -5836,6 +5934,22 @@ static ssize_t move_store(struct kmem_cache *s, const char *buf, size_t length)
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
+		__balance_nodes_partial(s);
+	else
+		return -EINVAL;
+	return length;
+}
+SLAB_ATTR(balance);
 #endif	/* CONFIG_SMO_NODE */
 
 #ifdef CONFIG_NUMA
@@ -5964,6 +6078,7 @@ static struct attribute *slab_attrs[] = {
 	&shrink_attr.attr,
 #ifdef CONFIG_SMO_NODE
 	&move_attr.attr,
+	&balance_attr.attr,
 #endif
 	&slabs_cpu_partial_attr.attr,
 #ifdef CONFIG_SLUB_DEBUG
-- 
2.21.0

