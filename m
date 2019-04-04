Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C932133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StRH5oW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDDCDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:03:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41142 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDCDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:03:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so510988pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 19:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=OFrH6yUQs4lhopvXqwVEFAjv4sQz8EJS3WfpjR4cwWs=;
        b=StRH5oW7ol0qJacNcLUKg6mElxHwgHClJj3sVgqC5ElSoLQoEqlICWkYPdE8xcDLMr
         wmS9qErF3MFwEqd3sWtltmY2GkToAzT0L3rM+aLGqZYT1fCSZPJvCTgnMeEkiWT8Rcr/
         uzgScX2JvC8+w9EGaTnDLTbeMXeim9QCIvfB0HmTwkWfuW7JPFLfFanMV40HLjJs8uUr
         +KTfpyzIIdaCyN8DhWxKT5d7DaWQaXq+UrOFoSeZP2A/HyCDZK48VV0La4US8Qc7sUXf
         atCp4Hr03GEtEBmWkCuWIps1fCHksW2ElDeh5yj27jFKlFcst9ahbChzTefOxGm1yrz/
         XBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=OFrH6yUQs4lhopvXqwVEFAjv4sQz8EJS3WfpjR4cwWs=;
        b=OaE88uQuKaMfA4/HDduS/87CK6ZJTi0K2Y7MZpfmqbnwMIrgx6mU3Xo//Lzqjnis/7
         ehexfs20ZvDELrZryf5b0crUHpKn852FMujPjAmA/Xy/mud9c06gETl+oeXEvYb07k9r
         5gBgHjThRjHzjHJ6eqG7IVCwSe6fYWlFMD00c7Nxxfd9xIwQRBE3eooiQFDxCF2eM8+o
         aiS4SStyLa3sDQ/GGcvmrRQn0FVph4S0tdYrFDPKyK9KOw+Q7JEIwoFUD2yEx7MtcQV3
         NAcPdTALJuB6CghlOe/VW1+flHseC3HQvhnHHozZPSXTIORh6sOtYbT6DIehGDXFOGC7
         l+pg==
X-Gm-Message-State: APjAAAVcwY4fuEFNKVpCK+Xj5x6JWyqGBZBSxgzNDMEyrOWUVE55etYT
        7cQCY74cXx1IGIVq++UXdTY=
X-Google-Smtp-Source: APXvYqyYj7scXs4rbtSWVf5ySYOl11Xmr38bvaJJ86L2IVxr/FPYntWmAhcWF90zhcyX4IACstd3ZA==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr3058941pgv.57.1554343410596;
        Wed, 03 Apr 2019 19:03:30 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e4sm20065805pgd.32.2019.04.03.19.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 19:03:29 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm:workingset use real time to judge activity of the file page
Date:   Thu,  4 Apr 2019 10:01:43 +0800
Message-Id: <1554343303-11880-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <Zhaoyang Huang@unisoc.com>

In previous implementation, the number of refault pages is used
for judging the refault period of each page, which is not precised.
We introduce the timestamp into the workingset's entry to measure
the file page's activity.

The patch is tested on an Android system, which can be described as
comparing the launch time of an application between a huge memory
consumption. The result is launch time decrease 50% and the page fault
during the test decrease 80%.

Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
---
 include/linux/mmzone.h |  2 ++
 mm/workingset.c        | 24 +++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..c38ba0a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -240,6 +240,8 @@ struct lruvec {
 	atomic_long_t			inactive_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults;
+	atomic_long_t			refaults_ratio;
+	atomic_long_t			prev_fault;
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c..6361853 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -159,7 +159,7 @@
 			 NODES_SHIFT +	\
 			 MEM_CGROUP_ID_SHIFT)
 #define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
-
+#define EVICTION_JIFFIES (BITS_PER_LONG >> 3)
 /*
  * Eviction timestamps need to be able to cover the full range of
  * actionable refaults. However, bits are tight in the radix tree
@@ -175,18 +175,22 @@ static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction)
 	eviction >>= bucket_order;
 	eviction = (eviction << MEM_CGROUP_ID_SHIFT) | memcgid;
 	eviction = (eviction << NODES_SHIFT) | pgdat->node_id;
+	eviction = (eviction << EVICTION_JIFFIES) | (jiffies >> EVICTION_JIFFIES);
 	eviction = (eviction << RADIX_TREE_EXCEPTIONAL_SHIFT);
 
 	return (void *)(eviction | RADIX_TREE_EXCEPTIONAL_ENTRY);
 }
 
 static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
-			  unsigned long *evictionp)
+			  unsigned long *evictionp, unsigned long *prev_jiffp)
 {
 	unsigned long entry = (unsigned long)shadow;
 	int memcgid, nid;
+	unsigned long prev_jiff;
 
 	entry >>= RADIX_TREE_EXCEPTIONAL_SHIFT;
+	entry >>= EVICTION_JIFFIES;
+	prev_jiff = (entry & ((1UL << EVICTION_JIFFIES) - 1)) << EVICTION_JIFFIES;
 	nid = entry & ((1UL << NODES_SHIFT) - 1);
 	entry >>= NODES_SHIFT;
 	memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
@@ -195,6 +199,7 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 	*memcgidp = memcgid;
 	*pgdat = NODE_DATA(nid);
 	*evictionp = entry << bucket_order;
+	*prev_jiffp = prev_jiff;
 }
 
 /**
@@ -242,8 +247,12 @@ bool workingset_refault(void *shadow)
 	unsigned long refault;
 	struct pglist_data *pgdat;
 	int memcgid;
+	unsigned long refault_ratio;
+	unsigned long prev_jiff;
+	unsigned long avg_refault_time;
+	unsigned long refault_time;
 
-	unpack_shadow(shadow, &memcgid, &pgdat, &eviction);
+	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &prev_jiff);
 
 	rcu_read_lock();
 	/*
@@ -288,10 +297,11 @@ bool workingset_refault(void *shadow)
 	 * list is not a problem.
 	 */
 	refault_distance = (refault - eviction) & EVICTION_MASK;
-
 	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
-
-	if (refault_distance <= active_file) {
+	lruvec->refaults_ratio = atomic_long_read(&lruvec->inactive_age) / jiffies;
+	refault_time = jiffies - prev_jiff;
+	avg_refault_time = refault_distance / lruvec->refaults_ratio;
+	if (refault_time <= avg_refault_time) {
 		inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
 		rcu_read_unlock();
 		return true;
@@ -521,7 +531,7 @@ static int __init workingset_init(void)
 	 * some more pages at runtime, so keep working with up to
 	 * double the initial memory by using totalram_pages as-is.
 	 */
-	timestamp_bits = BITS_PER_LONG - EVICTION_SHIFT;
+	timestamp_bits = BITS_PER_LONG - EVICTION_SHIFT - EVICTION_JIFFIES;
 	max_order = fls_long(totalram_pages - 1);
 	if (max_order > timestamp_bits)
 		bucket_order = max_order - timestamp_bits;
-- 
1.9.1

