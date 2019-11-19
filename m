Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0ABC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63101222B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfKSOfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:35:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:64761 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfKSOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:35:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 06:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="215552366"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 06:35:05 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 01/13] perf/core: Add new branch sample type for LBR TOS
Date:   Tue, 19 Nov 2019 06:33:59 -0800
Message-Id: <20191119143411.3482-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119143411.3482-1-kan.liang@linux.intel.com>
References: <20191119143411.3482-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In LBR call stack mode, the depth of reconstructed LBR call stack limits
to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
perf tool may stitch the stacks of two samples. The reconstructed LBR
call stack can break the HW limitation.

Add a new branch sample type to retrieve LBR TOS. The new type is PMU
specific. Add it at the end of enum perf_branch_sample_type.
Add a macro to retrieve defined bits of branch sample type.
Update perf_copy_attr() to handle the new bit.

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
 include/linux/perf_event.h      |  2 ++
 include/uapi/linux/perf_event.h | 16 ++++++++++++++--
 kernel/events/core.c            | 13 ++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 011dcbdbccc2..761021c7ee8a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -93,6 +93,7 @@ struct perf_raw_record {
 /*
  * branch stack layout:
  *  nr: number of taken branches stored in entries[]
+ *  tos: Top-of-Stack (TOS) information. PMU specific data.
  *
  * Note that nr can vary from sample to sample
  * branches (to, from) are stored from most recent
@@ -101,6 +102,7 @@ struct perf_raw_record {
  */
 struct perf_branch_stack {
 	__u64				nr;
+	__u64				tos; /* PMU specific data */
 	struct perf_branch_entry	entries[0];
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bb7b271397a6..c2da61c9ace7 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -180,7 +180,10 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
 
-	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
+	PERF_SAMPLE_BRANCH_MAX_SHIFT		= 17, /* non-ABI */
+
+	/* PMU specific */
+	PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT	= 63, /* save LBR TOS */
 };
 
 enum perf_branch_sample_type {
@@ -208,8 +211,13 @@ enum perf_branch_sample_type {
 		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
 
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
+
+	PERF_SAMPLE_BRANCH_LBR_TOS	= 1ULL << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
 };
 
+#define PERF_SAMPLE_BRANCH_MASK		((PERF_SAMPLE_BRANCH_MAX - 1) |\
+					 PERF_SAMPLE_BRANCH_LBR_TOS)
+
 /*
  * Common flow change classification
  */
@@ -849,7 +857,11 @@ enum perf_event_type {
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
index cfd89b4a02d8..8aff3aad43b5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6391,6 +6391,11 @@ static void perf_output_read(struct perf_output_handle *handle,
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
@@ -6480,6 +6485,8 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 			perf_output_put(handle, data->br_stack->nr);
 			perf_output_copy(handle, data->br_stack->entries, size);
+			if (perf_sample_save_lbr_tos(event))
+				perf_output_put(handle, data->br_stack->tos);
 		} else {
 			/*
 			 * we always store at least the value of nr
@@ -6667,7 +6674,11 @@ void perf_prepare_sample(struct perf_event_header *header,
 		if (data->br_stack) {
 			size += data->br_stack->nr
 			      * sizeof(struct perf_branch_entry);
+
+			if (perf_sample_save_lbr_tos(event))
+				size += sizeof(u64);
 		}
+
 		header->size += size;
 	}
 
@@ -10731,7 +10742,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		u64 mask = attr->branch_sample_type;
 
 		/* only using defined bits */
-		if (mask & ~(PERF_SAMPLE_BRANCH_MAX-1))
+		if (mask & ~PERF_SAMPLE_BRANCH_MASK)
 			return -EINVAL;
 
 		/* at least one branch bit must be set */
-- 
2.17.1

