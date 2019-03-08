Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6FAC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BF220854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552018510;
	bh=aUADhIbDjTy6BwbCTPuVS0G70l2kWDm8+oGEGWPHsoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TJN5qAM9gmjm+1wil0ZwlqUmDWtdh6tkTArDWVjjjhztukXnM0jPSQS8bY3cq3MaO
	 R27J7JMbFmHt+W/CCp3QmC6QG89Tc63tmANZeheoiCgTt+5cclS43z7GaK//juVj2k
	 TNW4Jy1o9P8yIjXzQ5jb6eZtXxkkFcFqHJEKwnAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCHEPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:15:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38973 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfCHEPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:15:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F272C33C0;
        Thu,  7 Mar 2019 23:15:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 23:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=S945EuPNIvb2lzYR5n8bNRwR4B4LkW68HRQmRnZ/c7o=; b=SpG+6r/P
        b1zyzhX1lDp8bJRO9zY1vt+oKVxOBSb+xxxRDFuE6Ob97ESzfxiPWtwiGQv+ViLV
        Jwpko9MB0AR6KnspLc22jq8c/J3V4lrRoIVo/nFnwtgIDn/jfUlD8yqaDpJ1tMLM
        EOkPVgO2Ytg47CCgs4YmWaV6Mv6pkIaHwwtZ+HkJyT5PB1qRjpAxTXhW7YXHiSRr
        /oldHEHLZDx0IYDCvJIz6+L4KM9ZQI41HAOdWh/BtewP0cGZQBemOry6Z+rXRD1k
        B1o1HCIN2ACjCYtCBif2JPWNvwoBGB6LIH0YqIN3gcmeemioICG6qfgE3cLmXeTk
        YYyTy3ic9kdEng==
X-ME-Sender: <xms:SeyBXMAc_yt1jwGudsjvg_FZT4Y87tcSCCAT07-kdIEqmViZv1zbiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:SeyBXBGeJyNs4iWDQASAOCZRyY-X7z134w7-_P83cHwaVlE9pt9JEA>
    <xmx:SeyBXDNoq4wTpsFrCGeID1izD7YoJZ-Qe9VanBFeB26YS61IyawKWw>
    <xmx:SeyBXC7lKTvNi9Eh3mHfplsNAgRykTgAHZxvRzad6-ktHFId2Zpn-Q>
    <xmx:SeyBXM8ORuJPtBHKR0tnxb4POsfd3GQNHl6OaVsZHJ1WIqYVE0KNFw>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F06CE4383;
        Thu,  7 Mar 2019 23:15:02 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 02/15] slub: Add isolate() and migrate() methods
Date:   Fri,  8 Mar 2019 15:14:13 +1100
Message-Id: <20190308041426.16654-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308041426.16654-1-tobin@kernel.org>
References: <20190308041426.16654-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two methods needed for moving objects and enable the display of
the callbacks via the /sys/kernel/slab interface.

Add documentation explaining the use of these methods and the prototypes
for slab.h. Add functions to setup the callbacks method for a slab
cache.

Add empty functions for SLAB/SLOB. The API is generic so it could be
theoretically implemented for these allocators as well.

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slab.h     | 69 ++++++++++++++++++++++++++++++++++++++++
 include/linux/slub_def.h |  3 ++
 mm/slab_common.c         |  4 +++
 mm/slub.c                | 42 ++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11b45f7ae405..22e87c41b8a4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -152,6 +152,75 @@ void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
 void memcg_deactivate_kmem_caches(struct mem_cgroup *);
 void memcg_destroy_kmem_caches(struct mem_cgroup *);
 
+/*
+ * Function prototypes passed to kmem_cache_setup_mobility() to enable
+ * mobile objects and targeted reclaim in slab caches.
+ */
+
+/**
+ * typedef kmem_cache_isolate_func - Object migration callback function.
+ * @s: The cache we are working on.
+ * @ptr: Pointer to an array of pointers to the objects to migrate.
+ * @nr: Number of objects in array.
+ *
+ * The purpose of kmem_cache_isolate_func() is to pin each object so that
+ * they cannot be freed until kmem_cache_migrate_func() has processed
+ * them. This may be accomplished by increasing the refcount or setting
+ * a flag.
+ *
+ * The object pointer array passed is also passed to
+ * kmem_cache_migrate_func().  The function may remove objects from the
+ * array by setting pointers to NULL. This is useful if we can determine
+ * that an object is being freed because kmem_cache_isolate_func() was
+ * called when the subsystem was calling kmem_cache_free().  In that
+ * case it is not necessary to increase the refcount or specially mark
+ * the object because the release of the slab lock will lead to the
+ * immediate freeing of the object.
+ *
+ * Context: Called with locks held so that the slab objects cannot be
+ *          freed.  We are in an atomic context and no slab operations
+ *          may be performed.
+ * Return: A pointer that is passed to the migrate function. If any
+ *         objects cannot be touched at this point then the pointer may
+ *         indicate a failure and then the migration function can simply
+ *         remove the references that were already obtained. The private
+ *         data could be used to track the objects that were already pinned.
+ */
+typedef void *kmem_cache_isolate_func(struct kmem_cache *s, void **ptr, int nr);
+
+/**
+ * typedef kmem_cache_migrate_func - Object migration callback function.
+ * @s: The cache we are working on.
+ * @ptr: Pointer to an array of pointers to the objects to migrate.
+ * @nr: Number of objects in array.
+ * @node: The NUMA node where the object should be allocated.
+ * @private: The pointer returned by kmem_cache_isolate_func().
+ *
+ * This function is responsible for migrating objects.  Typically, for
+ * each object in the input array you will want to allocate an new
+ * object, copy the original object, update any pointers, and free the
+ * old object.
+ *
+ * After this function returns all pointers to the old object should now
+ * point to the new object.
+ *
+ * Context: Called with no locks held and interrupts enabled.  Sleeping
+ *          is possible.  Any operation may be performed.
+ */
+typedef void kmem_cache_migrate_func(struct kmem_cache *s, void **ptr,
+				     int nr, int node, void *private);
+
+/*
+ * kmem_cache_setup_mobility() is used to setup callbacks for a slab cache.
+ */
+#ifdef CONFIG_SLUB
+void kmem_cache_setup_mobility(struct kmem_cache *, kmem_cache_isolate_func,
+			       kmem_cache_migrate_func);
+#else
+static inline void kmem_cache_setup_mobility(struct kmem_cache *s,
+	kmem_cache_isolate_func isolate, kmem_cache_migrate_func migrate) {}
+#endif
+
 /*
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 3a1a1dbc6f49..a7340a1ed5dc 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -99,6 +99,9 @@ struct kmem_cache {
 	gfp_t allocflags;	/* gfp flags to use on each alloc */
 	int refcount;		/* Refcount for slab cache destroy */
 	void (*ctor)(void *);
+	kmem_cache_isolate_func *isolate;
+	kmem_cache_migrate_func *migrate;
+
 	unsigned int inuse;		/* Offset to metadata */
 	unsigned int align;		/* Alignment */
 	unsigned int red_left_pad;	/* Left redzone padding size */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f9d89c1b5977..754acdb292e4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -298,6 +298,10 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (!is_root_cache(s))
 		return 1;
 
+	/*
+	 * s->isolate and s->migrate imply s->ctor so no need to
+	 * check them explicitly.
+	 */
 	if (s->ctor)
 		return 1;
 
diff --git a/mm/slub.c b/mm/slub.c
index 69164aa7cbbf..0133168d1089 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4325,6 +4325,34 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return err;
 }
 
+void kmem_cache_setup_mobility(struct kmem_cache *s,
+			       kmem_cache_isolate_func isolate,
+			       kmem_cache_migrate_func migrate)
+{
+	/*
+	 * Mobile objects must have a ctor otherwise the object may be
+	 * in an undefined state on allocation.  Since the object may
+	 * need to be inspected by the migration function at any time
+	 * after allocation we must ensure that the object always has a
+	 * defined state.
+	 */
+	if (!s->ctor) {
+		pr_err("%s: cannot setup mobility without a constructor\n",
+		       s->name);
+		return;
+	}
+
+	s->isolate = isolate;
+	s->migrate = migrate;
+
+	/*
+	 * Sadly serialization requirements currently mean that we have
+	 * to disable fast cmpxchg based processing.
+	 */
+	s->flags &= ~__CMPXCHG_DOUBLE;
+}
+EXPORT_SYMBOL(kmem_cache_setup_mobility);
+
 void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -5018,6 +5046,20 @@ static ssize_t ops_show(struct kmem_cache *s, char *buf)
 
 	if (s->ctor)
 		x += sprintf(buf + x, "ctor : %pS\n", s->ctor);
+
+	if (s->isolate) {
+		x += sprintf(buf + x, "isolate : ");
+		x += sprint_symbol(buf + x,
+				(unsigned long)s->isolate);
+		x += sprintf(buf + x, "\n");
+	}
+
+	if (s->migrate) {
+		x += sprintf(buf + x, "migrate : ");
+		x += sprint_symbol(buf + x,
+				(unsigned long)s->migrate);
+		x += sprintf(buf + x, "\n");
+	}
 	return x;
 }
 SLAB_ATTR_RO(ops);
-- 
2.21.0

