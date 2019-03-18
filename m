Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB5020872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 00:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552867424;
	bh=Y5LImpZCpLrhY2rLv87hTWL4Q88CTVnd/+p6Dl+ZpsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FQxTQGOernO3m3nPkgtRRiAOTZ7NlshJPXZbfRXkQzhSIFz3uTWaHw/k3Bj6r9G8o
	 4MdgFcGl2qxVKCfmmkKNbGbpF+ENzZj4H/wbwboXxM5qsv433APWQizNk+1/QW5ZlM
	 Sfo3mg96In3vf/m9mGfx4VuO16rEWMWS/nuwiP8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCRADn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:03:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39257 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfCRADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 20:03:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1862F21111;
        Sun, 17 Mar 2019 20:03:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 17 Mar 2019 20:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=NZVnfMXNqUVsw72giEwpoDaffPcwW/v9YLVK4Q6YHM4=; b=vTFz98VY
        7bBMa6Yf3HAWm8MATThA/LFbexFrcI7slO0tNL/F4JJl4DXHmzKQ3mdz0vykheob
        2IxEaCAcxHDla/Ly1CDSo/OwuJAUZlN5Utp/SJqu6RqAgr6Fe1lHVne/LVWTY/y8
        Ma6pnrkpTTJM/Yv+sj9fzupGY/iCn+HcppuVUL/pazywQqGT6g/C7WqGzefa5QNt
        b8QOcrx02MYtFxcxzJi50UU2nqwsqf5pEq0iJaXEFNRlQ0CNHcnuUIbG+ob4nq80
        AGhfA+Lbm0N3c6o23iTZvCa/GXXwuyPDbZCg+C8611LlFeNn9absS2wwWy9jxZmh
        57varu9s8yKHeQ==
X-ME-Sender: <xms:XOCOXMeir27MQsXAGmPPgLN1-nBNMeX57vcdHw3j3qXbFx2w_A9rQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddukedrvdduuddrudelledruddvieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:XOCOXDx4LkJ-2cfsiFy0-w6Dsn3NNgAsEqIb-sWIzkGCjU-irH310Q>
    <xmx:XOCOXHGhcOHRJ94JT7_nJQgjXq7NODExZYeUPpU1tjpMQzy2b0ufsA>
    <xmx:XOCOXC2Bst_rbp-cGxF5jGIiqHQj258mcEw0i4X0P1Ly2urxJEXEtQ>
    <xmx:XeCOXAdhtBQL7UPQe0GOI1on-zjj7RFTyKE68Fmk4OyL70qECE_MpA>
Received: from eros.localdomain (ppp118-211-199-126.bras1.syd2.internode.on.net [118.211.199.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9892E44A0;
        Sun, 17 Mar 2019 20:03:36 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] slub: Add comments to endif pre-processor macros
Date:   Mon, 18 Mar 2019 11:02:31 +1100
Message-Id: <20190318000234.22049-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318000234.22049-1-tobin@kernel.org>
References: <20190318000234.22049-1-tobin@kernel.org>
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

Acked-by: Christoph Lameter <cl@linux.com>
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

