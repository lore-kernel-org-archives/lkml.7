Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6494C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB0E2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfKOQI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:08:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:21438 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfKOQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 08:08:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="405377086"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2019 08:08:26 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Fix the mlock accounting, again
Date:   Fri, 15 Nov 2019 18:08:18 +0200
Message-Id: <20191115160818.6480-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  5e6c3c7b1ec2 ("perf/aux: Fix tracking of auxiliary trace buffer allocation")

tried to guess the correct combination of arithmetic operations that would
undo the AUX buffer's mlock accounting, and failed, leaking the bottom part
when an allocation needs to be changed partially to both user->locked_vm
and mm->pinned_vm, eventually leaving the user with no locked bonus:

$ perf record -e intel_pt//u -m1,128 uname
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB perf.data ]
$ perf record -e intel_pt//u -m1,128 uname
Permission error mapping pages.
Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
or try again with a smaller value of -m/--mmap_pages.
(current value: 1,128)

Fix this by subtracting both locked and pinned counts when AUX buffer is
unmapped.

Signefdoff-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 16d80ad8d6d7..522438887206 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5664,10 +5664,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		if (!rb->aux_mmap_locked)
-			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
-		else
-			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
-- 
2.24.0

