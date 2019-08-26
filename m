Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D28C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCABA2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfHZLqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbfHZLqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRQ-0000vT-SV; Mon, 26 Aug 2019 13:45:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 831C51C0DDA;
        Mon, 26 Aug 2019 13:45:44 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:45:44 -0000
From:   tip-bot2 for Alexander Shishkin <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Use helpers to obtain ToPA entry size
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190821124727.73310-3-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156681994442.3129.13335285452722167319.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fffec50f541ace292383c0cbe9a2a97d16d201c6
Gitweb:        https://git.kernel.org/tip/fffec50f541ace292383c0cbe9a2a97d16d201c6
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 21 Aug 2019 15:47:23 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 12:00:13 +02:00

perf/x86/intel/pt: Use helpers to obtain ToPA entry size

There are a few places in the PT driver that need to obtain the size of
a ToPA entry, some of them for the current ToPA entry in the buffer.
Use helpers for those, to make the lines shorter and more readable.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20190821124727.73310-3-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/pt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9d9258f..f269875 100644
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
