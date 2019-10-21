Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F1CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0F12089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfJUUET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:04:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:57214 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUUET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:04:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 13:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="201467361"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.125])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2019 13:04:19 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 01/13] perf/core: Add new branch sample type for LBR TOS
Date:   Mon, 21 Oct 2019 13:03:02 -0700
Message-Id: <20191021200314.1613-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021200314.1613-1-kan.liang@linux.intel.com>
References: <20191021200314.1613-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In LBR call stack mode, the depth of reconstructed LBR call stack limits
to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
perf tool may stitch the stacks of two samples. The reconstructed LBR
call stack can break the HW limitation.

Add a new branch sample type to retrieve LBR TOS.

Only when the new branch sample type is set, the TOS information is
dumped into the PERF_SAMPLE_BRANCH_STACK output.
Perf tool should check the attr.branch_sample_type, and apply the
corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
Otherwise, some user case may be broken. For example, users may parse a
perf.data, which include the new branch sample type, with an old version
perf tool (without the check). Users probably get incorrect information
without any warning.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      |  4 ++++
 include/uapi/linux/perf_event.h | 10 +++++++++-
 kernel/events/core.c            | 10 ++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..0cebc8ec44fa 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -972,6 +972,10 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+
+	/* PMU specific data */
+	u64				lbr_tos;
+
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..b1f022190571 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -180,6 +180,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
 
+	PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT	= 17, /* save LBR TOS */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -207,6 +209,8 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
 		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_LBR_TOS	= 1U << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -849,7 +853,11 @@ enum perf_event_type {
 	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
 	 *
 	 *	{ u64                   nr;
-	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
+	 *        { u64 from, to, flags } lbr[nr];
+	 *
+	 *        # only available if PERF_SAMPLE_BRANCH_LBR_TOS is set
+	 *        u64			tos;
+	 *      } && PERF_SAMPLE_BRANCH_STACK
 	 *
 	 * 	{ u64			abi; # enum perf_sample_regs_abi
 	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 275eae05af20..3c1f88352404 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6318,6 +6318,11 @@ static void perf_output_read(struct perf_output_handle *handle,
 		perf_output_read_one(handle, event, enabled, running);
 }
 
+static inline bool perf_sample_save_lbr_tos(struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS;
+}
+
 void perf_output_sample(struct perf_output_handle *handle,
 			struct perf_event_header *header,
 			struct perf_sample_data *data,
@@ -6407,6 +6412,8 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 			perf_output_put(handle, data->br_stack->nr);
 			perf_output_copy(handle, data->br_stack->entries, size);
+			if (perf_sample_save_lbr_tos(event))
+				perf_output_put(handle, data->lbr_tos);
 		} else {
 			/*
 			 * we always store at least the value of nr
@@ -6595,6 +6602,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
 		}
+		if (perf_sample_save_lbr_tos(event))
+			size += sizeof(u64);
+
 		header->size += size;
 	}
 
-- 
2.17.1

