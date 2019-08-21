Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7233D2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfHUMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:48:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:30849 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfHUMsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:48:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207724900"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 05:48:05 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 2/6] perf/x86/intel/pt: Use helpers to obtain ToPA entry size
Date:   Wed, 21 Aug 2019 15:47:23 +0300
Message-Id: <20190821124727.73310-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places in the PT driver that need to obtain the size of
a ToPA entry, some of them for the current ToPA entry in the buffer.
Use helpers for those, to make the lines shorter and more readable.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b029f32edae2..831163a1b41a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -572,6 +572,7 @@ struct topa {
 
 /* make -1 stand for the last table entry */
 #define TOPA_ENTRY(t, i) ((i) == -1 ? &(t)->table[(t)->last] : &(t)->table[(i)])
+#define TOPA_ENTRY_SIZE(t, i) (sizes(TOPA_ENTRY((t), (i))->size))
 
 /**
  * topa_alloc() - allocate page-sized ToPA table
@@ -771,7 +772,7 @@ static void pt_update_head(struct pt *pt)
 
 	/* offset of the current output region within this table */
 	for (topa_idx = 0; topa_idx < buf->cur_idx; topa_idx++)
-		base += sizes(buf->cur->table[topa_idx].size);
+		base += TOPA_ENTRY_SIZE(buf->cur, topa_idx);
 
 	if (buf->snapshot) {
 		local_set(&buf->data_size, base);
@@ -800,7 +801,7 @@ static void *pt_buffer_region(struct pt_buffer *buf)
  */
 static size_t pt_buffer_region_size(struct pt_buffer *buf)
 {
-	return sizes(buf->cur->table[buf->cur_idx].size);
+	return TOPA_ENTRY_SIZE(buf->cur, buf->cur_idx);
 }
 
 /**
@@ -830,7 +831,7 @@ static void pt_handle_status(struct pt *pt)
 		 * know.
 		 */
 		if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
-		    buf->output_off == sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size)) {
+		    buf->output_off == pt_buffer_region_size(buf)) {
 			perf_aux_output_flag(&pt->handle,
 			                     PERF_AUX_FLAG_TRUNCATED);
 			advance++;
@@ -925,8 +926,7 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	unsigned long idx, npages, wakeup;
 
 	/* can't stop in the middle of an output region */
-	if (buf->output_off + handle->size + 1 <
-	    sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size)) {
+	if (buf->output_off + handle->size + 1 < pt_buffer_region_size(buf)) {
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 		return -EINVAL;
 	}
@@ -1032,7 +1032,7 @@ static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 	buf->cur = (struct topa *)((unsigned long)buf->topa_index[pg] & PAGE_MASK);
 	buf->cur_idx = ((unsigned long)buf->topa_index[pg] -
 			(unsigned long)buf->cur) / sizeof(struct topa_entry);
-	buf->output_off = head & (sizes(buf->cur->table[buf->cur_idx].size) - 1);
+	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
 
 	local64_set(&buf->head, head);
 	local_set(&buf->data_size, 0);
-- 
2.23.0.rc1

