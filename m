Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE4BC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F3F222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKMKGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:06:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37170 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfKMKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:06:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUpXf-0000HG-3G; Wed, 13 Nov 2019 11:06:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B89A81C03A8;
        Wed, 13 Nov 2019 11:06:26 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:06:26 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/aux: Disallow aux_output for kernel events
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191030134731.5437-3-alexander.shishkin@linux.intel.com>
References: <20191030134731.5437-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157363958637.29376.6730701512874139098.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     dce5affb94eb54edfff17727a6240a6a5d998666
Gitweb:        https://git.kernel.org/tip/dce5affb94eb54edfff17727a6240a6a5d998666
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 30 Oct 2019 15:47:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 08:16:42 +01:00

perf/aux: Disallow aux_output for kernel events

Commit

  ab43762ef0109 ("perf: Allow normal events to output AUX data")

added 'aux_output' bit to the attribute structure, which relies on AUX
events and grouping, neither of which is supported for the kernel events.
This notwithstanding, attempts have been made to use it in the kernel
code, suggesting the necessity of an explicit hard -EINVAL.

Fix this by rejecting attributes with aux_output set for kernel events.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20191030134731.5437-3-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e18d8d3..7655441 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11331,6 +11331,13 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	struct perf_event *event;
 	int err;
 
+	/*
+	 * Grouping is not supported for kernel events, neither is 'AUX',
+	 * make sure the caller's intentions are adjusted.
+	 */
+	if (attr->aux_output)
+		return ERR_PTR(-EINVAL);
+
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
 				 overflow_handler, context, -1);
 	if (IS_ERR(event)) {
