Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BB620693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552454475;
	bh=2IHxanUuX8PYlJ5zcaVECjXUYbrnbs6mZQ8Drkxb/lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1oGQEIBn6X4E8Rzn8lg3zDrFujLD8dKQxzoOOHZcqhGcjZ7QLZxDyghSOxmZnOWRA
	 eFeyTNYwYwybEAjz/BU9tCXfuLHKgd4RZpFVdPDKpY42IXP/LSaXTpR5+2n7xdq1VH
	 5DekOdxZ82mSZudCbmL1vbEhyeUcxCwSTmd7S4BY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCMFVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:21:13 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46155 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfCMFVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:21:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A62DC38B1;
        Wed, 13 Mar 2019 01:21:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 01:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=acU2gA0XupWBWu0QZQ+K9+WO5Dqp8Z/Fo1Pi8Ye78KI=; b=GN9yesFe
        fo3KT4XAJDo714mB4gMydBPdMeMcnDRvhbZd+Ds8bNI2CGiKHRAoXJ7qpAFIl0wt
        wQhyVSgBu3pX1OUcdyYEhiWu0izqCbGg6ir2mVHVycMsrHFVyBU8C164PbRHmtxg
        AVCaisFmX5hUQQK+n+uQJ6scViCswM4tfjP3sZFO1m3fWxYLrpN+LeQLoLYK/Q9I
        Jttj8HFw54NR6+Ry+RcSxZ+Yl5+a332qgVj5cqPU+VFhrSgZkXx4+2hpFbfEXcYq
        DNlh0hsT2LzY5y7oL6AA8XuMejIP21MXq6X8GllKS4On7arir1leNxSISDUcF0a9
        m4nvuUJJivoAaw==
X-ME-Sender: <xms:RJOIXIBU9nK3Ls10XqXA4rlZXhrZx29XOc2fk61Dlh2u1YUg82EhNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:RJOIXB5x1Tb5a0ffmp8qJjF6CBLG_1KdLyvguUM2bX7D_oG9WLXbmA>
    <xmx:RJOIXBIi-GYj0em8GTHA9M-yTfSs6BuyBtVwQC2wkMjuXaVcTzQwQg>
    <xmx:RJOIXKuJHrY0vRNeYrBXHnumkuiCcH0hyouNcI5UtdwWAwiFrmh7bA>
    <xmx:RJOIXNWHQwT-VN01S5SRcrcV0B5RJGITcOSJFDtedSCRH7iK4SHpSw>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB509E4693;
        Wed, 13 Mar 2019 01:21:04 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] slub: Add comments to endif pre-processor macros
Date:   Wed, 13 Mar 2019 16:20:26 +1100
Message-Id: <20190313052030.13392-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313052030.13392-1-tobin@kernel.org>
References: <20190313052030.13392-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB allocator makes heavy use of ifdef/endif pre-processor macros.
The pairing of these statements is at times hard to follow e.g. if the
pair are further than a screen apart or if there are nested pairs.  We
can reduce cognitive load by adding a comment to the endif statement of
form

       #ifdef CONFIG_FOO
       ...
       #endif /* CONFIG_FOO */

Add comments to endif pre-processor macros if ifdef/endif pair is not
immediately apparent.

Reviewed-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1b08fbcb7e61..b282e22885cd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1951,7 +1951,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 			}
 		}
 	} while (read_mems_allowed_retry(cpuset_mems_cookie));
-#endif
+#endif	/* CONFIG_NUMA */
 	return NULL;
 }
 
@@ -2249,7 +2249,7 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
-#endif
+#endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
 /*
@@ -2308,7 +2308,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 		local_irq_restore(flags);
 	}
 	preempt_enable();
-#endif
+#endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
@@ -2813,7 +2813,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
 #endif
-#endif
+#endif	/* CONFIG_NUMA */
 
 /*
  * Slow path handling. This may still be called frequently since objects
@@ -3845,7 +3845,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	return ret;
 }
 EXPORT_SYMBOL(__kmalloc_node);
-#endif
+#endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_HARDENED_USERCOPY
 /*
@@ -4063,7 +4063,7 @@ void __kmemcg_cache_deactivate(struct kmem_cache *s)
 	 */
 	slab_deactivate_memcg_cache_rcu_sched(s, kmemcg_cache_deact_after_rcu);
 }
-#endif
+#endif	/* CONFIG_MEMCG */
 
 static int slab_mem_going_offline_callback(void *arg)
 {
@@ -4696,7 +4696,7 @@ static int list_locations(struct kmem_cache *s, char *buf,
 		len += sprintf(buf, "No data\n");
 	return len;
 }
-#endif
+#endif	/* CONFIG_SLUB_DEBUG */
 
 #ifdef SLUB_RESILIENCY_TEST
 static void __init resiliency_test(void)
@@ -4756,7 +4756,7 @@ static void __init resiliency_test(void)
 #ifdef CONFIG_SYSFS
 static void resiliency_test(void) {};
 #endif
-#endif
+#endif	/* SLUB_RESILIENCY_TEST */
 
 #ifdef CONFIG_SYSFS
 enum slab_stat_type {
@@ -5413,7 +5413,7 @@ STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
 STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
 STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
-#endif
+#endif	/* CONFIG_SLUB_STATS */
 
 static struct attribute *slab_attrs[] = {
 	&slab_size_attr.attr,
@@ -5614,7 +5614,7 @@ static void memcg_propagate_slab_attrs(struct kmem_cache *s)
 
 	if (buffer)
 		free_page((unsigned long)buffer);
-#endif
+#endif	/* CONFIG_MEMCG */
 }
 
 static void kmem_cache_release(struct kobject *k)
-- 
2.21.0

