Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A38C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68E62084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfFSGpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:45:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:50797 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfFSGpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:45:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 23:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="243224097"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2019 23:45:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()
Date:   Wed, 19 Jun 2019 09:44:29 +0300
Message-Id: <20190619064429.14940-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190619064429.14940-1-adrian.hunter@intel.com>
References: <20190619064429.14940-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new function thread_stack__pop_ks() in place of equivalent code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index f91c00dfe23b..b20c9b867fce 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -673,12 +673,9 @@ static int thread_stack__no_call_return(struct thread *thread,
 
 	if (ip >= ks && addr < ks) {
 		/* Return to userspace, so pop all kernel addresses */
-		while (thread_stack__in_kernel(ts)) {
-			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							tm, ref, true);
-			if (err)
-				return err;
-		}
+		err = thread_stack__pop_ks(thread, ts, sample, ref);
+		if (err)
+			return err;
 
 		/* If the stack is empty, push the userspace address */
 		if (!ts->cnt) {
@@ -688,12 +685,9 @@ static int thread_stack__no_call_return(struct thread *thread,
 		}
 	} else if (thread_stack__in_kernel(ts) && ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
-		while (thread_stack__in_kernel(ts)) {
-			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							tm, ref, true);
-			if (err)
-				return err;
-		}
+		err = thread_stack__pop_ks(thread, ts, sample, ref);
+		if (err)
+			return err;
 	}
 
 	if (ts->cnt)
-- 
2.17.1

