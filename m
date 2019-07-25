Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E32190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfGYJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:22:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:22:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C36A230917AF;
        Thu, 25 Jul 2019 09:22:11 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-212.ams2.redhat.com [10.36.117.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D39D5C652;
        Thu, 25 Jul 2019 09:22:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RFC] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Date:   Thu, 25 Jul 2019 11:22:06 +0200
Message-Id: <20190725092206.23712-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 25 Jul 2019 09:22:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9852a7212324 ("mm: drop hotplug lock from lru_add_drain_all()")
states that lru_add_drain_all() "Doesn't need any cpu hotplug locking
because we do rely on per-cpu kworkers being shut down before our
page_alloc_cpu_dead callback is executed on the offlined cpu."

And also "Calling this function with cpu hotplug locks held can actually
lead to obscure indirect dependencies via WQ context.".

Since commit 3f906ba23689 ("mm/memory-hotplug: switch locking to a percpu
rwsem") we do a cpus_read_lock() in mem_hotplug_begin().

I don't see how that lock is still helpful, we already hold the
device_hotplug_lock to protect try_offline_node(), which is AFAIK one
problematic part that can race with CPU hotplug. If it is still
necessary, we should document why.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e7c3b219a305..43b8cd4b96f5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -86,14 +86,12 @@ __setup("memhp_default_state=", setup_memhp_default_state);
 
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

