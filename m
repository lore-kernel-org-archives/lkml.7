Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574DC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C205420878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfKTRHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:07:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:34037 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfKTRHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:07:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 09:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="290007152"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2019 09:06:47 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: [PATCH] perf: Make the mlock accounting simple again
Date:   Wed, 20 Nov 2019 19:06:40 +0200
Message-Id: <20191120170640.54123-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

does a lot of things to the mlock accounting arithmetics, while the only
thing that actually needed to happen is subtracting the part that is
charged to the mm from the part that is charged to the user, so that the
former isn't charged twice.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: songliubraving@fb.com
---
 kernel/events/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 522438887206..059ee7116008 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5886,13 +5886,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
 
-	if (user_locked <= user_lock_limit) {
-		/* charge all to locked_vm */
-	} else if (atomic_long_read(&user->locked_vm) >= user_lock_limit) {
-		/* charge all to pinned_vm */
-		extra = user_extra;
-		user_extra = 0;
-	} else {
+	if (user_locked > user_lock_limit) {
 		/*
 		 * charge locked_vm until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
-- 
2.24.0

