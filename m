Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93FC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BD21738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="elP/NX8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfC0OvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:51:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37504 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfC0OvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:51:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so19151065qtn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V2FxAfFFWtajtgc6o7ZK2g7f9qiJmBz4PznPjNz5bxg=;
        b=elP/NX8YIFhnGs2UxrlbkhY89KSfIh2axL6mj5Gc+/XB07tePbmLpOE5w6eNDqvf9O
         GlDeLNU+oMxmMggbRnTWixHiqgeLdBENCegrbvH/pSjsLIIDgIq31T1uCeu+NFDCx6HB
         lZbGIc0FTV88f5e2enhuc7ak/m90i6uKNWxCVnGK/Ziu15DgdWCKg1XJl4/TVMlhVWJ5
         4Nb02IXTsQgOZJ4I+LTqapBQzlbroaeXdWcjgrO+bkkq9VyijDRWtAJqPHutK9fauLYQ
         mjtalL3RifEZX+OYq/RiaP0vtwkXAw6GCE0MSQAkuHaf2SbXch0av0tFny4n6ESBxTxc
         Pldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V2FxAfFFWtajtgc6o7ZK2g7f9qiJmBz4PznPjNz5bxg=;
        b=Nbxti1iTex3ORW/fVumI7hLMLg97xuFJXboZf5RJ9PPdkXHp/zq9gLQneDsJm+nGHy
         oUfaDxICjPKEOIj4Z6r2M1XfJXnOlSMk3ECy5BprOu842HDO/+UK9fA1ytZgPS7VkQI8
         Aoxk/kmrIpNoRJJrH5mPmxamrKsFBPygO/AG3OXNs8hy9tzS/GwRPBawPA/XsHujBjjh
         EbZo2kCkUjD1+0NqTRf7FUIOnwkmAmTw56jGJzMK2Y7913AGXE0thYxpCR44/jpSwRIk
         362/WOy8al1j+77NsD79d6XXwO/BS9NgA0futeDvRTto02Q3rnT3xULExGUU5o5zJDwx
         V2JQ==
X-Gm-Message-State: APjAAAW5Z8hfSRomIYJp0JIWYd9YO6OW+RzAni13doP6LNF7eIZM2aPy
        5UnYAP+6iixFz6wR2wwUTknxrA==
X-Google-Smtp-Source: APXvYqy4IkBh9E7/Y9CE1R2wSyCdvbbWCkgoDwY53EfeqVSIxHJadjEnUEsBsALlHGxSSLtPyVuzlw==
X-Received: by 2002:ac8:2f4a:: with SMTP id k10mr30200027qta.208.1553698273337;
        Wed, 27 Mar 2019 07:51:13 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g5sm12510936qke.71.2019.03.27.07.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:51:12 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, cl@linux.com, mhocko@kernel.org,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v5] kmemleak: survive in a low-memory situation
Date:   Wed, 27 Mar 2019 10:51:01 -0400
Message-Id: <20190327145101.30845-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak could quickly fail to allocate an object structure and then
disable itself below in a low-memory situation. For example, running a
mmap() workload triggering swapping and OOM. This is especially
problematic for running things like LTP testsuite where one OOM test
case would disable the whole kmemleak and render the rest of test cases
without kmemleak watching for leaking.

Kmemleak allocation could fail even though the tracked memory is
succeeded. Hence, it could still try to start a direct reclaim if it is
not executed in an atomic context (spinlock, irq-handler etc), or a
high-priority allocation in an atomic context as a last-ditch effort.
Since kmemleak is a debug feature, it is unlikely to be used in
production that memory resources is scarce where direct reclaim or
high-priority atomic allocations should not be granted lightly.

Unless there is a brave soul to reimplement the kmemleak to embed it's
metadata into the tracked memory itself in a foreseeable future, this
provides a good balance between enabling kmemleak in a low-memory
situation and not introducing too much hackiness into the existing
code for now. Another approach is to fail back the original allocation
once kmemleak_alloc() failed, but there are too many call sites to
deal with which makes it error-prone.

kmemleak: Cannot allocate a kmemleak_object structure
kmemleak: Kernel memory leak detector disabled
kmemleak: Automatic memory scanning thread ended
RIP: 0010:__alloc_pages_nodemask+0x242a/0x2ab0
Call Trace:
 alloc_pages_current+0xdb/0x1c0
 allocate_slab+0x4d9/0x930
 new_slab+0x46/0x70
 ___slab_alloc+0x5d3/0x9c0
 __slab_alloc+0x12/0x20
 kmem_cache_alloc+0x30a/0x360
 create_object+0x96/0x9a0
 kmemleak_alloc+0x71/0xa0
 kmem_cache_alloc+0x254/0x360
 mempool_alloc_slab+0x3f/0x60
 mempool_alloc+0x120/0x329
 bio_alloc_bioset+0x1a8/0x510
 get_swap_bio+0x107/0x470
 __swap_writepage+0xab4/0x1650
 swap_writepage+0x86/0xe0

Signed-off-by: Qian Cai <cai@lca.pw>
---

v5: Move everything into gfp_kmemleak_mask().
    Use PREEMPT_COUNT to catch irq unsafe spinlocks held.
v4: Update the commit log.
    Fix a typo in comments per Christ.
    Consolidate the allocation.
v3: Update the commit log.
    Simplify the code inspired by graph_trace_open() from ftrace.
v2: Remove the needless checking for NULL objects in slab_post_alloc_hook()
    per Catalin.

 mm/kmemleak.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a2d894d3de07..98f874990553 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -124,11 +124,6 @@
 
 #define BYTES_PER_POINTER	sizeof(void *)
 
-/* GFP bitmask for kmemleak internal allocations */
-#define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
-				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
-				 __GFP_NOWARN | __GFP_NOFAIL)
-
 /* scanning area inside a memory block */
 struct kmemleak_scan_area {
 	struct hlist_node node;
@@ -315,6 +310,30 @@ static void kmemleak_disable(void);
 		pr_warn(fmt, ##__VA_ARGS__);		\
 } while (0)
 
+/* GFP bitmask for kmemleak internal allocations */
+static inline gfp_t gfp_kmemleak_mask(gfp_t gfp)
+{
+	gfp = (gfp & (GFP_KERNEL | GFP_ATOMIC)) | __GFP_NORETRY |
+		__GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_NOFAIL;
+
+/*
+ * PREEMPT_COUNT is set by either PREEMPT or DEBUG_ATOMIC_SLEEP which is
+ * normally found in a debug kernel just like kmemleak. Otherwise, it won't be
+ * able to catch irq unsafe spinlocks held.
+ */
+#ifdef CONFIG_PREEMPT_COUNT
+	/*
+	 * The tracked memory was allocated successful, if the kmemleak object
+	 * failed to allocate for some reasons, it ends up with the whole
+	 * kmemleak disabled, so try it harder.
+	 */
+	gfp |= ((in_atomic() || irqs_disabled()) ? GFP_ATOMIC :
+		__GFP_DIRECT_RECLAIM);
+#endif
+
+	return gfp;
+}
+
 static void warn_or_seq_hex_dump(struct seq_file *seq, int prefix_type,
 				 int rowsize, int groupsize, const void *buf,
 				 size_t len, bool ascii)
-- 
2.17.2 (Apple Git-113)

