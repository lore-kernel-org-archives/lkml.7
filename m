Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E087C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772342075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfECIzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:55:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:31447 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfECIzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:55:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="321087555"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2019 01:55:42 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH 1/2] perf: Fix AUX software double buffering
Date:   Fri,  3 May 2019 11:55:35 +0300
Message-Id: <20190503085536.24119-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503085536.24119-1-alexander.shishkin@linux.intel.com>
References: <20190503085536.24119-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5768402fd9c6e87 ("perf/ring_buffer: Use high order allocations for
AUX buffers optimistically") overlooked the fact that the previous one page
granularity of the AUX buffer provided an implicit double buffering
capability to the PMU driver, which went away when the entire buffer became
one high-order page.

Always make the full-trace mode AUX allocation at least two-part to preserve
the previous behavior and allow the implicit double buffering to continue.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 5768402fd9c6e87 ("perf/ring_buffer: Use high order allocations for AUX buffers optimistically")
Reported-by: Ammy Yi <ammy.yi@intel.com>
---
 kernel/events/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5eedb49a65ea..674b35383491 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -610,8 +610,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	 * PMU requests more than one contiguous chunks of memory
 	 * for SW double buffering
 	 */
-	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
-	    !overwrite) {
+	if (!overwrite) {
 		if (!max_order)
 			return -EINVAL;
 
-- 
2.20.1

