Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E682AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D2E24651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfLEO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:29:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:12291 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbfLEO3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:29:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 06:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="209170931"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2019 06:29:00 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/2] perf/x86/intel/bts: Fix the use of page_private()
Date:   Thu,  5 Dec 2019 17:28:53 +0300
Message-Id: <20191205142853.28894-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205142853.28894-1-alexander.shishkin@linux.intel.com>
References: <20191205142853.28894-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  8062382c8dbe2 ("perf/x86/intel/bts: Add BTS PMU driver")

uses page_private(page) without checking the PagePrivate(page) first,
which seems like a potential bug, considering that page->private aliases
with other stuff in struct page.

Fix this by checking PagePrivate() first.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 8062382c8dbe2 ("perf/x86/intel/bts: Add BTS PMU driver")
---
 arch/x86/events/intel/bts.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index d53b4fb86d87..9e4da1c5a129 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -63,9 +63,17 @@ struct bts_buffer {
 
 static struct pmu bts_pmu;
 
+static int buf_nr_pages(struct page *page)
+{
+	if (!PagePrivate(page))
+		return 1;
+
+	return 1 << page_private(page);
+}
+
 static size_t buf_size(struct page *page)
 {
-	return 1 << (PAGE_SHIFT + page_private(page));
+	return 1 << (PAGE_SHIFT + buf_nr_pages(page));
 }
 
 static void *
@@ -83,7 +91,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	/* count all the high order buffers */
 	for (pg = 0, nbuf = 0; pg < nr_pages;) {
 		page = virt_to_page(pages[pg]);
-		pg += 1 << page_private(page);
+		pg += buf_nr_pages(page);
 		nbuf++;
 	}
 
@@ -107,7 +115,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 		unsigned int __nr_pages;
 
 		page = virt_to_page(pages[pg]);
-		__nr_pages = PagePrivate(page) ? 1 << page_private(page) : 1;
+		__nr_pages = buf_nr_pages(page);
 		buf->buf[nbuf].page = page;
 		buf->buf[nbuf].offset = offset;
 		buf->buf[nbuf].displacement = (pad ? BTS_RECORD_SIZE - pad : 0);
-- 
2.24.0

