Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A14CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9852A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="VeyPNpse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfJVOsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:48:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43202 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388191AbfJVOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:48:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so27129953qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54i+z1wfPwz6/cGLiUfokNvMUBs/QmsNtuItwhjfY2I=;
        b=VeyPNpsexL0QFkwSfvrTR+ipseMK3B6GkLGCh7t5KGPNh0aMLaYY4TWUiEkgaDu6sD
         OkqHdMhcpIvf5XAGg/oS8FJjjmUpM6xU7YpSL3bUeqIvvhVMb5cC3eV3DewVSbLjNStD
         9hGN9zzHYGIgW7xx0P59N7oMLQTufgOsE1gjmjXMZVI47+Zkyxj31tmPrn8qjtbRAFPh
         vNFBmq6PWAVVO0YuBbdhsLwignvBhDRkChbOK6E5kx0O2EhLLaGU1GycTyplz//xMOhi
         DEIK+UTUiUZN6jWWk5xd9koF4vwGVJUX9DZcU5arHIMdyseCVVORi9OuYlO1srYyED4+
         O6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54i+z1wfPwz6/cGLiUfokNvMUBs/QmsNtuItwhjfY2I=;
        b=UEcij66ajAkPl0zM1hW/9xWywBi8sURNvYSt4uRqQXojlj62FBBSKeSPiwMIhKzQ1d
         gkYcM9h1Y5f2h5qIT8QtoqXY0ewgZqGLcxFwVuhNBLaY0ywi2Q1cHbGGlQrUHbYO6jty
         WbL++c28AY771yKkgquW7y3zPg1GL4Res5rs/9iCyVIX0C/m3mJv7qC/ESrFp0F1oNly
         KCdCVzKaHHQx9H4/xMC2F91V6gr2iaiqTieKubH18WnLS/7yQmSkfKsInSsety0SPbXZ
         ey0vueSSPLVYgbn0iLmJGZOAKYg0fk/n1WuD9AuP9KhA5sNOSCDOq00qFlkdUjhtvW/F
         ev7Q==
X-Gm-Message-State: APjAAAXG0FxOiiwEivVMQGfJi1a1OTlW3YRhywktwqXYZh+PrKDXySB/
        i5Jc0qlwBfY3LnY2n4ZN41WihA==
X-Google-Smtp-Source: APXvYqxUIOCsaOjFLF5giMe1ZXcyXhEJn1Gw5IIrOkv2mgKxObwAUB99LeseVc6rptgLFSj6NnGlZw==
X-Received: by 2002:ac8:73cf:: with SMTP id v15mr3631553qtp.310.1571755699119;
        Tue, 22 Oct 2019 07:48:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:10ad])
        by smtp.gmail.com with ESMTPSA id q16sm7131372qke.22.2019.10.22.07.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:48:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and sane_reclaim()
Date:   Tue, 22 Oct 2019 10:47:59 -0400
Message-Id: <20191022144803.302233-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022144803.302233-1-hannes@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seven years after introducing the global_reclaim() function, I still
have to double take when reading a callsite. I don't know how others
do it, this is a terrible name.

Invert the meaning and rename it to cgroup_reclaim().

[ After all, "global reclaim" is just regular reclaim invoked from the
  page allocator. It's reclaim on behalf of a cgroup limit that is a
  special case of reclaim, and should be explicit - not the reverse. ]

sane_reclaim() isn't very descriptive either: it tests whether we can
use the regular writeback throttling - available during regular page
reclaim or cgroup2 limit reclaim - or need to use the broken
wait_on_page_writeback() method. Use "writeback_throttling_sane()".

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 622b77488144..302dad112f75 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -239,13 +239,13 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
-static bool global_reclaim(struct scan_control *sc)
+static bool cgroup_reclaim(struct scan_control *sc)
 {
-	return !sc->target_mem_cgroup;
+	return sc->target_mem_cgroup;
 }
 
 /**
- * sane_reclaim - is the usual dirty throttling mechanism operational?
+ * writeback_throttling_sane - is the usual dirty throttling mechanism available?
  * @sc: scan_control in question
  *
  * The normal page dirty throttling mechanism in balance_dirty_pages() is
@@ -257,11 +257,9 @@ static bool global_reclaim(struct scan_control *sc)
  * This function tests whether the vmscan currently in progress can assume
  * that the normal dirty throttling mechanism is operational.
  */
-static bool sane_reclaim(struct scan_control *sc)
+static bool writeback_throttling_sane(struct scan_control *sc)
 {
-	struct mem_cgroup *memcg = sc->target_mem_cgroup;
-
-	if (!memcg)
+	if (!cgroup_reclaim(sc))
 		return true;
 #ifdef CONFIG_CGROUP_WRITEBACK
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
@@ -302,12 +300,12 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 {
 }
 
-static bool global_reclaim(struct scan_control *sc)
+static bool cgroup_reclaim(struct scan_control *sc)
 {
-	return true;
+	return false;
 }
 
-static bool sane_reclaim(struct scan_control *sc)
+static bool writeback_throttling_sane(struct scan_control *sc)
 {
 	return true;
 }
@@ -1227,7 +1225,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 				goto activate_locked;
 
 			/* Case 2 above */
-			} else if (sane_reclaim(sc) ||
+			} else if (writeback_throttling_sane(sc) ||
 			    !PageReclaim(page) || !may_enter_fs) {
 				/*
 				 * This is slightly racy - end_page_writeback()
@@ -1821,7 +1819,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	if (current_is_kswapd())
 		return 0;
 
-	if (!sane_reclaim(sc))
+	if (!writeback_throttling_sane(sc))
 		return 0;
 
 	if (file) {
@@ -1971,7 +1969,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	reclaim_stat->recent_scanned[file] += nr_taken;
 
 	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
-	if (global_reclaim(sc))
+	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
 	spin_unlock_irq(&pgdat->lru_lock);
@@ -1985,7 +1983,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	spin_lock_irq(&pgdat->lru_lock);
 
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
-	if (global_reclaim(sc))
+	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
@@ -2309,7 +2307,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	 * using the memory controller's swap limit feature would be
 	 * too expensive.
 	 */
-	if (!global_reclaim(sc) && !swappiness) {
+	if (cgroup_reclaim(sc) && !swappiness) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2333,7 +2331,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 	 * thrashing file LRU becomes infinitely more attractive than
 	 * anon pages.  Try to detect this based on file LRU size.
 	 */
-	if (global_reclaim(sc)) {
+	if (!cgroup_reclaim(sc)) {
 		unsigned long pgdatfile;
 		unsigned long pgdatfree;
 		int z;
@@ -2564,7 +2562,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
 	 * abort proportional reclaim if either the file or anon lru has already
 	 * dropped to zero at the first pass.
 	 */
-	scan_adjusted = (global_reclaim(sc) && !current_is_kswapd() &&
+	scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
 			 sc->priority == DEF_PRIORITY);
 
 	blk_start_plug(&plug);
@@ -2853,7 +2851,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		 * Legacy memcg will stall in page writeback so avoid forcibly
 		 * stalling in wait_iff_congested().
 		 */
-		if (!global_reclaim(sc) && sane_reclaim(sc) &&
+		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
 		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
 			set_memcg_congestion(pgdat, root, true);
 
@@ -2948,7 +2946,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
 		 */
-		if (global_reclaim(sc)) {
+		if (!cgroup_reclaim(sc)) {
 			if (!cpuset_zone_allowed(zone,
 						 GFP_KERNEL | __GFP_HARDWALL))
 				continue;
@@ -3048,7 +3046,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 retry:
 	delayacct_freepages_start();
 
-	if (global_reclaim(sc))
+	if (!cgroup_reclaim(sc))
 		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
 
 	do {
-- 
2.23.0

