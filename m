Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E53C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841A821915
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127502;
	bh=FufMNJrseEIrEfH6YgA9Rr8so//dfXiyy9iQqeqqQw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VlaiyafCG4Kju658pF5ocWv4rNCVjNd8T40fmnhL3+ImPAt1ixb2EINT9b3ukigM/
	 WO/y0moH/EvocItpPuw48I+sw858M34A2TmB3J949CsaaZLq9raiTDkyKQPNY1vTPH
	 Cdvvi/N9h/NPcziviLjNh3sD7cDM3dPYGeEqAUjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392390AbfDXRiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392373AbfDXRiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:16 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7134A20675;
        Wed, 24 Apr 2019 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127495;
        bh=FufMNJrseEIrEfH6YgA9Rr8so//dfXiyy9iQqeqqQw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4j5PNOiZzTRFerTsPzpytlHbaKrZrF/gBHrWZLHd4BwuLHibc/BShtxQfRsLAyQh
         +FL+Q9iv+QIsp5H66T8RsLZU8NPxwOA7zo/g6wyhzFtDOWOdjdDq8kHH7jDknBrxtl
         6woGECPHYcH8U0odAc49fKyRAC+T62oYb0KHo4v8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Gainey <Ben.Gainey@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 111/115] perf/ring_buffer: Fix AUX record suppression
Date:   Wed, 24 Apr 2019 19:10:47 +0200
Message-Id: <20190424170931.165049663@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 339bc4183596e1f68c2c98a03b87aa124107c317 upstream.

The following commit:

  1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")

has an unintended side-effect of also suppressing all AUX records with no flags
and non-zero size, so all the regular records in the full trace mode.
This breaks some use cases for people.

Fix this by restoring "regular" AUX records.

Reported-by: Ben Gainey <Ben.Gainey@arm.com>
Tested-by: Ben Gainey <Ben.Gainey@arm.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")
Link: https://lkml.kernel.org/r/20190329091338.29999-1-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/ring_buffer.c |   33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -456,24 +456,21 @@ void perf_aux_output_end(struct perf_out
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


