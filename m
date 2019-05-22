Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF08C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E3D20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfEVKRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:17:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:44776 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbfEVKRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:17:55 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hTOJi-0002Zw-Fh; Wed, 22 May 2019 13:17:50 +0300
Subject: [PATCH v2] mm: Rename mm_vmscan_lru_shrink_inactive trace event
 variables
To:     akpm@linux-foundation.org, mjeanson@efficios.com,
        rostedt@goodmis.org, lttng-dev@lists.lttng.org,
        linux-kernel@vger.kernel.org
References: <155851455676.7870.1951762540769724271.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9b9a8da4-556a-8972-cf87-071ce5099ad0@virtuozzo.com>
Date:   Wed, 22 May 2019 13:17:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155851455676.7870.1951762540769724271.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename nr_activate{0,1} into nr_activate{anon,file} since this
is exported into userspace, e.g., it's shown here:

/sys/kernel/debug/tracing/events/vmscan/mm_vmscan_lru_shrink_inactive/format

v2: Changed suggested person (sorry, Mathieu :))

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/trace/events/vmscan.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a5ab2973e8dc..c316279715f4 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -348,8 +348,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned long, nr_writeback)
 		__field(unsigned long, nr_congested)
 		__field(unsigned long, nr_immediate)
-		__field(unsigned int, nr_activate0)
-		__field(unsigned int, nr_activate1)
+		__field(unsigned int, nr_activate_anon)
+		__field(unsigned int, nr_activate_file)
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
 		__field(int, priority)
@@ -364,8 +364,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_writeback = stat->nr_writeback;
 		__entry->nr_congested = stat->nr_congested;
 		__entry->nr_immediate = stat->nr_immediate;
-		__entry->nr_activate0 = stat->nr_activate[0];
-		__entry->nr_activate1 = stat->nr_activate[1];
+		__entry->nr_activate_anon = stat->nr_activate[0];
+		__entry->nr_activate_file = stat->nr_activate[1];
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
 		__entry->priority = priority;
@@ -377,7 +377,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
-		__entry->nr_activate0, __entry->nr_activate1,
+		__entry->nr_activate_anon, __entry->nr_activate_file,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
 		__entry->priority,
 		show_reclaim_flags(__entry->reclaim_flags))
