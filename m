Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF62C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDACD2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfECKX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:23:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfECKXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:23:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 920F715AD;
        Fri,  3 May 2019 03:23:24 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B063F557;
        Fri,  3 May 2019 03:23:23 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] perf: Use consistent style of comments for optional callbacks
Date:   Fri,  3 May 2019 11:23:15 +0100
Message-Id: <20190503102315.5697-3-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503102315.5697-1-andrew.murray@arm.com>
References: <20190503102315.5697-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the readability of perf_event.h, let's be consistent in how we
annotate optional struct pmu callbacks. Where a multi-line comment block
is present before a single function prototype we add the annotation at the
end of the block. Otherwise we use a single line comment at the end of the
function prototype.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/linux/perf_event.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 27c1cb3cddf1..f0479c99d2ec 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -393,8 +393,10 @@ struct pmu {
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
 	 * if no implementation is provided it will default to: 0.
+	 *
+	 * Optional.
 	 */
-	int (*event_idx)		(struct perf_event *event); /*optional */
+	int (*event_idx)		(struct perf_event *event);
 
 	/*
 	 * context-switches callback
@@ -409,15 +411,18 @@ struct pmu {
 
 	/*
 	 * Set up pmu-private data structures for an AUX area
+	 *
+	 * Optional.
 	 */
 	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
-					/* optional */
 
 	/*
 	 * Free pmu-private AUX data structures
+	 *
+	 * Optional.
 	 */
-	void (*free_aux)		(void *aux); /* optional */
+	void (*free_aux)		(void *aux);
 
 	/*
 	 * Validate address range filters: make sure the HW supports the
@@ -426,9 +431,10 @@ struct pmu {
 	 *
 	 * Runs in the context of the ioctl()ing process and is not serialized
 	 * with the rest of the PMU callbacks.
+	 *
+	 * Optional.
 	 */
 	int (*addr_filters_validate)	(struct list_head *filters);
-					/* optional */
 
 	/*
 	 * Synchronize address range filter configuration:
@@ -440,19 +446,24 @@ struct pmu {
 	 *
 	 * May (and should) traverse event::addr_filters::list, for which its
 	 * caller provides necessary serialization.
+	 *
+	 * Optional.
 	 */
 	void (*addr_filters_sync)	(struct perf_event *event);
-					/* optional */
 
 	/*
 	 * Filter events for PMU-specific reasons.
+	 *
+	 * Optional.
 	 */
-	int (*filter_match)		(struct perf_event *event); /* optional */
+	int (*filter_match)		(struct perf_event *event);
 
 	/*
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
+	 *
+	 * Optional.
 	 */
-	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+	int (*check_period)		(struct perf_event *event, u64 value);
 };
 
 enum perf_addr_filter_action_t {
-- 
2.21.0

