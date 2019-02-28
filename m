Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA31C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F82D2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfB1H6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:58:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfB1H6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:58:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7vbDW2952079
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:57:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7vaRB2952076;
        Wed, 27 Feb 2019 23:57:36 -0800
Date:   Wed, 27 Feb 2019 23:57:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-18736eef12137c59f60cc9f56dc5bea05c92e0eb@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        malharthi9@gatech.edu, mathieu.poirier@linaro.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, acme@redhat.com, mathieu.poirier@linaro.org,
          malharthi9@gatech.edu, peterz@infradead.org
In-Reply-To: <20190215115655.63469-2-alexander.shishkin@linux.intel.com>
References: <20190215115655.63469-2-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf: Copy parent's address filter offsets on clone
Git-Commit-ID: 18736eef12137c59f60cc9f56dc5bea05c92e0eb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  18736eef12137c59f60cc9f56dc5bea05c92e0eb
Gitweb:     https://git.kernel.org/tip/18736eef12137c59f60cc9f56dc5bea05c92e0eb
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Fri, 15 Feb 2019 13:56:54 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 22 Feb 2019 16:52:07 -0300

perf: Copy parent's address filter offsets on clone

When a child event is allocated in the inherit_event() path, the VMA
based filter offsets are not copied from the parent, even though the
address space mapping of the new task remains the same, which leads to
no trace for the new task until exec.

Reported-by: Mansour Alharthi <malharthi9@gatech.edu>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
Link: http://lkml.kernel.org/r/20190215115655.63469-2-alexander.shishkin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5aeb4c74fb99..2d89efc0a3e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1255,6 +1255,7 @@ static void put_ctx(struct perf_event_context *ctx)
  *	      perf_event_context::lock
  *	    perf_event::mmap_mutex
  *	    mmap_sem
+ *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
  *      pmus_lock
@@ -10312,6 +10313,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 			goto err_per_task;
 		}
 
+		/*
+		 * Clone the parent's vma offsets: they are valid until exec()
+		 * even if the mm is not shared with the parent.
+		 */
+		if (event->parent) {
+			struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
+
+			raw_spin_lock_irq(&ifh->lock);
+			memcpy(event->addr_filters_offs,
+			       event->parent->addr_filters_offs,
+			       pmu->nr_addr_filters * sizeof(unsigned long));
+			raw_spin_unlock_irq(&ifh->lock);
+		}
+
 		/* force hw sync on the address filters */
 		event->addr_filters_gen = 1;
 	}
