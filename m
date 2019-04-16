Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E48C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677A223F9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ak/IUFJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfDPOXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:23:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42655 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPOXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:23:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so23438571qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5zT/Zu265n7fMd2y+GkEVbND9utnsLCgOxsFe2ldPs=;
        b=ak/IUFJhX4m++/VPO8H0CMl8nCkDgVWzzlFupD4H/IHKLfXek/EYspaXR7v4OhTQ7V
         ibBOI/icPQBDl9xrZaq3oA2CN+iJft+uC25xd7sCxSX3+DHFQaPpO/ar3J6fV4wBXc5g
         y8xZfebMKpcv0ztBnHqxcD/EnPXqndL8kLnPTSBs5ZaoDk3Jgvq0OGvOYs0yLmniZL49
         uCQ3MZQFRnE+DYbN5x1YbpvoVYg12SPaDPqs5FGgw6MP+LR94c1oDNB3cAOHjSDULVll
         54pQV/6R6xwB5QTGQ/XyNAlkQxXTwPEk6I8BBxwmaSzLpaekYy5ZBgBiAsOrbmF7K6/z
         0mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5zT/Zu265n7fMd2y+GkEVbND9utnsLCgOxsFe2ldPs=;
        b=TQetV12KzwcVv7fTrZCH6y3OAHVrHmIvKbLwhBY4MFvpSTZTuSZYv2G86lMxkuifuC
         XW3jKfk8AG2QNT0xQfjwr19mR66LRD+fF7v2mDVzzFkA9ZkUvOmpewEG06T7G5Js3HYn
         5hN0H42PSdOURtSvI2SSyhGQPTtbx6hkCUxu7NXhYa7d2vuPuJ5d2BRCMQaAYcX6eAMf
         n1Fa65VhmfVoSNJq6Uq0/unQ5DmuilG+YEXAE3HqVSZKTJ0FEoL2fVGUHbsg5TpYBxti
         fmPEwEt8dkB42kYGO3WCJRpFnUBNjmfb6VR2pZomJVsFViG44Ke0EwcNXXuckkoUMWte
         3gTQ==
X-Gm-Message-State: APjAAAVY9HL3Ude4yup1CpglJWd9SwIv2iHSCmYyMCO/qps/MWDkt1Al
        WYHfoRU1OAsGSC2DFIAJyFnqlw==
X-Google-Smtp-Source: APXvYqx26QteTZ52Wy2B/3wChpP64k1AgWRy8FQu7Hqo90Lx9kjjxFRruTMBTk+71Eh+hbeQSwJn2A==
X-Received: by 2002:ac8:3fbc:: with SMTP id d57mr63710484qtk.96.1555424592962;
        Tue, 16 Apr 2019 07:23:12 -0700 (PDT)
Received: from ovpn-120-81.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d17sm24693234qko.93.2019.04.16.07.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:23:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, luto@kernel.org, jpoimboe@redhat.com,
        sean.j.christopherson@intel.com, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] slab: remove store_stackinfo()
Date:   Tue, 16 Apr 2019 10:22:57 -0400
Message-Id: <20190416142258.18694-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

store_stackinfo() does not seem used in actual SLAB debugging.
Potentially, it could be added to check_poison_obj() to provide more
information, but this seems like an overkill due to the declining
popularity of the SLAB, so just remove it instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slab.c | 48 ++++++------------------------------------------
 1 file changed, 6 insertions(+), 42 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 3e1b7ff0360c..20f318f4f56e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1467,53 +1467,17 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
-			    unsigned long caller)
-{
-	int size = cachep->object_size;
-
-	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
-
-	if (size < 5 * sizeof(unsigned long))
-		return;
-
-	*addr++ = 0x12345678;
-	*addr++ = caller;
-	*addr++ = smp_processor_id();
-	size -= 3 * sizeof(unsigned long);
-	{
-		unsigned long *sptr = &caller;
-		unsigned long svalue;
-
-		while (!kstack_end(sptr)) {
-			svalue = *sptr++;
-			if (kernel_text_address(svalue)) {
-				*addr++ = svalue;
-				size -= sizeof(unsigned long);
-				if (size <= sizeof(unsigned long))
-					break;
-			}
-		}
-
-	}
-	*addr++ = 0x87654321;
-}
-
-static void slab_kernel_map(struct kmem_cache *cachep, void *objp,
-				int map, unsigned long caller)
+static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
 {
 	if (!is_debug_pagealloc_cache(cachep))
 		return;
 
-	if (caller)
-		store_stackinfo(cachep, objp, caller);
-
 	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
 }
 
 #else
 static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
-				int map, unsigned long caller) {}
+				int map) {}
 
 #endif
 
@@ -1661,7 +1625,7 @@ static void slab_destroy_debugcheck(struct kmem_cache *cachep,
 
 		if (cachep->flags & SLAB_POISON) {
 			check_poison_obj(cachep, objp);
-			slab_kernel_map(cachep, objp, 1, 0);
+			slab_kernel_map(cachep, objp, 1);
 		}
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
@@ -2433,7 +2397,7 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct page *page)
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON) {
 			poison_obj(cachep, objp, POISON_FREE);
-			slab_kernel_map(cachep, objp, 0, 0);
+			slab_kernel_map(cachep, objp, 0);
 		}
 	}
 #endif
@@ -2812,7 +2776,7 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 
 	if (cachep->flags & SLAB_POISON) {
 		poison_obj(cachep, objp, POISON_FREE);
-		slab_kernel_map(cachep, objp, 0, caller);
+		slab_kernel_map(cachep, objp, 0);
 	}
 	return objp;
 }
@@ -3076,7 +3040,7 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
 		check_poison_obj(cachep, objp);
-		slab_kernel_map(cachep, objp, 1, 0);
+		slab_kernel_map(cachep, objp, 1);
 		poison_obj(cachep, objp, POISON_INUSE);
 	}
 	if (cachep->flags & SLAB_STORE_USER)
-- 
2.20.1 (Apple Git-117)

