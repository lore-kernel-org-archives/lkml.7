Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C3C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A525320820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDJTOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:14:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDJTN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E7063086225;
        Wed, 10 Apr 2019 19:13:59 +0000 (UTC)
Received: from llong.com (ovpn-120-189.rdu2.redhat.com [10.10.120.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F2FD600CC;
        Wed, 10 Apr 2019 19:13:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Aaron Lu <aaron.lu@intel.com>, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 2/2] mm/memcontrol: Add a new MEMCG_SUBSET_HIGH event
Date:   Wed, 10 Apr 2019 15:13:21 -0400
Message-Id: <20190410191321.9527-3-longman@redhat.com>
In-Reply-To: <20190410191321.9527-1-longman@redhat.com>
References: <20190410191321.9527-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 10 Apr 2019 19:13:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new MEMCG_SUBSET_HIGH event is added to record the number of times
subset.high value is exceeded.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h | 1 +
 mm/memcontrol.c            | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1baf3e4a9eeb..4498db61507a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -52,6 +52,7 @@ enum memcg_memory_event {
 	MEMCG_LOW,
 	MEMCG_HIGH,
 	MEMCG_MAX,
+	MEMCG_SUBSET_HIGH,
 	MEMCG_OOM,
 	MEMCG_OOM_KILL,
 	MEMCG_SWAP_MAX,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7e52adea60d9..feba8b9c55b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2150,8 +2150,10 @@ static void reclaim_high(struct mem_cgroup *memcg,
 	/*
 	 * Try memory reclaim if subset_high is exceeded.
 	 */
-	if (mtype && (memcg_page_state(memcg, mtype) > memcg->subset_high))
+	if (mtype && (memcg_page_state(memcg, mtype) > memcg->subset_high)) {
+		memcg_memory_event(memcg, MEMCG_SUBSET_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
+	}
 
 	do {
 		if (page_counter_read(&memcg->memory) <= memcg->high)
@@ -5603,6 +5605,8 @@ static int memory_events_show(struct seq_file *m, void *v)
 		   atomic_long_read(&memcg->memory_events[MEMCG_HIGH]));
 	seq_printf(m, "max %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_MAX]));
+	seq_printf(m, "subset_high %lu\n",
+		   atomic_long_read(&memcg->memory_events[MEMCG_SUBSET_HIGH]));
 	seq_printf(m, "oom %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_OOM]));
 	seq_printf(m, "oom_kill %lu\n",
-- 
2.18.1

