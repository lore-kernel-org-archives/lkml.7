Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C9C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14668214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441390AbfIXOgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388630AbfIXOgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91D81309BF1A;
        Tue, 24 Sep 2019 14:36:20 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-245.ams2.redhat.com [10.36.116.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2181001B08;
        Tue, 24 Sep 2019 14:36:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Date:   Tue, 24 Sep 2019 16:36:15 +0200
Message-Id: <20190924143615.19628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 24 Sep 2019 14:36:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
rwsem") we do a cpus_read_lock() in mem_hotplug_begin(). This was
introduced to fix a potential deadlock between get_online_mems() and
get_online_cpus() - the memory and cpu hotplug lock. The root issue was
that build_all_zonelists() -> stop_machine() required the cpu hotplug lock:
    The reason is that memory hotplug takes the memory hotplug lock and
    then calls stop_machine() which calls get_online_cpus().  That's the
    reverse lock order to get_online_cpus(); get_online_mems(); in
    mm/slub_common.c

So memory hotplug never really required any cpu lock itself, only
stop_machine() and lru_add_drain_all() required it. Back then,
stop_machine_cpuslocked() and lru_add_drain_all_cpuslocked() were used
as the cpu hotplug lock was now obtained in the caller.

Since commit 11cd8638c37f ("mm, page_alloc: remove stop_machine from build
all_zonelists"), the stop_machine_cpuslocked() call is gone.
build_all_zonelists() does no longer require the cpu lock and does no
longer make use of stop_machine().

Since commit 9852a7212324 ("mm: drop hotplug lock from
lru_add_drain_all()"), lru_add_drain_all() "Doesn't need any cpu hotplug
locking because we do rely on per-cpu kworkers being shut down before our
page_alloc_cpu_dead callback is executed on the offlined cpu.". The
lru_add_drain_all_cpuslocked() variant was removed.

So there is nothing left that requires the cpu hotplug lock. The memory
hotplug lock and the device hotplug lock are sufficient.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

RFC -> v1:
- Reword and add more details why the cpu hotplug lock was needed here
  in the first place, and why we no longer require it.

---
 mm/memory_hotplug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c3e9aed6023f..5fa30f3010e1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -88,14 +88,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
 
 void mem_hotplug_begin(void)
 {
-	cpus_read_lock();
 	percpu_down_write(&mem_hotplug_lock);
 }
 
 void mem_hotplug_done(void)
 {
 	percpu_up_write(&mem_hotplug_lock);
-	cpus_read_unlock();
 }
 
 u64 max_mem_size = U64_MAX;
-- 
2.21.0

