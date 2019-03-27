Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A0E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfC0JRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:17:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:29121 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfC0JRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:17:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 02:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="331086745"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2019 02:17:44 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Ben Gainey <Ben.Gainey@arm.com>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "acme\@redhat.com" <acme@redhat.com>,
        Will Deacon <Will.Deacon@arm.com>
Cc:     "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: BUG in "perf: Suppress AUX/OVERWRITE records"?
In-Reply-To: <3f04004a48a4b5bece9d277d5c51661f4eca7e97.camel@arm.com>
References: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com> <87k1gm86en.fsf@ashishki-desk.ger.corp.intel.com> <3f04004a48a4b5bece9d277d5c51661f4eca7e97.camel@arm.com>
Date:   Wed, 27 Mar 2019 11:17:43 +0200
Message-ID: <87wokk7k20.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gainey <Ben.Gainey@arm.com> writes:

>> It was an unintentional side effect that it also
>> happened to coincide with context switches in the overwrite mode.
>
> I'm not using overwrite mode, I'm opening the mmap with PROT_WRITE
> (i.e. in truncate mode).

Now I get it. Does the below fix the problem for you?

From bf52320cce0e74a2c0d987db7bd571f7687b4f4f Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Wed, 27 Mar 2019 11:05:53 +0200
Subject: [PATCH] perf: Fix AUX record suppression

Commit 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records") has an
unintended side-effect of also suppressing all AUX records with no flags
and non-zero size, so all the regular records in the full trace mode.
This breaks some use cases for people.

Fix this by restoring "regular" AUX records to their former glory.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")
Reported-by: Ben Gainey <Ben.Gainey@arm.com>
CC: stable@vger.kernel.org # v4.20+
---
 kernel/events/ring_buffer.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 678ccec60d8f..626256dc26c1 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -455,24 +455,21 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
 		rb->aux_head += size;
 	}
 
-	if (size || handle->aux_flags) {
-		/*
-		 * Only send RECORD_AUX if we have something useful to communicate
-		 *
-		 * Note: the OVERWRITE records by themselves are not considered
-		 * useful, as they don't communicate any *new* information,
-		 * aside from the short-lived offset, that becomes history at
-		 * the next event sched-in and therefore isn't useful.
-		 * The userspace that needs to copy out AUX data in overwrite
-		 * mode should know to use user_page::aux_head for the actual
-		 * offset. So, from now on we don't output AUX records that
-		 * have *only* OVERWRITE flag set.
-		 */
-
-		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
-			perf_event_aux_event(handle->event, aux_head, size,
-			                     handle->aux_flags);
-	}
+	/*
+	 * Only send RECORD_AUX if we have something useful to communicate
+	 *
+	 * Note: the OVERWRITE records by themselves are not considered
+	 * useful, as they don't communicate any *new* information,
+	 * aside from the short-lived offset, that becomes history at
+	 * the next event sched-in and therefore isn't useful.
+	 * The userspace that needs to copy out AUX data in overwrite
+	 * mode should know to use user_page::aux_head for the actual
+	 * offset. So, from now on we don't output AUX records that
+	 * have *only* OVERWRITE flag set.
+	 */
+	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
+		perf_event_aux_event(handle->event, aux_head, size,
+				     handle->aux_flags);
 
 	rb->user_page->aux_head = rb->aux_head;
 	if (rb_need_aux_wakeup(rb))
-- 
2.20.1

