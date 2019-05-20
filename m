Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D40C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D40214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbfETOPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389951AbfETOPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:15:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4C7C81F1B;
        Mon, 20 May 2019 14:15:11 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C50841001DD9;
        Mon, 20 May 2019 14:15:10 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qian Cai <cai@gmx.us>, Zhong Jiang <zhongjiang@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] debugobjects: Reduce number of pool_lock acquisitions in fill_pool()
Date:   Mon, 20 May 2019 10:14:48 -0400
Message-Id: <20190520141450.7575-4-longman@redhat.com>
In-Reply-To: <20190520141450.7575-1-longman@redhat.com>
References: <20190520141450.7575-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 20 May 2019 14:15:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fill_pool(), the pool_lock is acquired and then released once per
debug object. If many objects are to be filled, the constant lock and
unlock operations are extra overhead. To reduce these overhead, we
batch them up and do an allocation of 4 objects per lock/unlock sequence.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index c30c9d308e9f..7573c736da7d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -120,7 +120,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 static void fill_pool(void)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
-	struct debug_obj *new, *obj;
+	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (likely(obj_pool_free >= debug_objects_pool_min_level))
@@ -136,7 +136,7 @@ static void fill_pool(void)
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		if (obj_nr_tofree) {
+		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			obj_nr_tofree--;
@@ -150,15 +150,23 @@ static void fill_pool(void)
 		return;
 
 	while (obj_pool_free < debug_objects_pool_min_level) {
+		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		int cnt;
 
-		new = kmem_cache_zalloc(obj_cache, gfp);
-		if (!new)
+		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new[cnt])
+				break;
+		}
+		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		hlist_add_head(&new->node, &obj_pool);
-		debug_objects_allocated++;
-		obj_pool_free++;
+		while (cnt) {
+			hlist_add_head(&new[--cnt]->node, &obj_pool);
+			debug_objects_allocated++;
+			obj_pool_free++;
+		}
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }
@@ -280,7 +288,7 @@ static void free_obj_work(struct work_struct *work)
 	/*
 	 * The objs on the pool list might be allocated before the work is
 	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list
+	 * list from the global free list.
 	 */
 	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
 		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-- 
2.18.1

