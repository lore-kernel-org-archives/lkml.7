Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DBC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF06222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKMK5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:57:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfKMK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:56:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUqKM-00026c-VW; Wed, 13 Nov 2019 11:56:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9ABAE1C0357;
        Wed, 13 Nov 2019 11:56:46 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:56:46 -0000
From:   "tip-bot2 for Qian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix unlock balance in perf_init_event()
Cc:     Qian Cai <cai@lca.pw>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
In-Reply-To: <20191106052935.8352-1-cai@lca.pw>
References: <20191106052935.8352-1-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <157364260624.29376.13060187465049038563.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     deb0c3c29d552ab81ecd5481bb83bf2f4e41927d
Gitweb:        https://git.kernel.org/tip/deb0c3c29d552ab81ecd5481bb83bf2f4e41927d
Author:        Qian Cai <cai@lca.pw>
AuthorDate:    Wed, 06 Nov 2019 00:29:35 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 11:06:13 +01:00

perf/core: Fix unlock balance in perf_init_event()

Commit:

  66d258c5b048 ("perf/core: Optimize perf_init_event()")

introduced an unlock imbalance in perf_init_event() where it calls
"goto again" and then only repeat rcu_read_unlock().

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
Link: https://lkml.kernel.org/r/20191106052935.8352-1-cai@lca.pw
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6cb6d68..8d65e03 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10307,7 +10307,6 @@ static struct pmu *perf_init_event(struct perf_event *event)
 			goto unlock;
 	}
 
-	rcu_read_lock();
 	/*
 	 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
 	 * are often aliases for PERF_TYPE_RAW.
@@ -10317,6 +10316,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		type = PERF_TYPE_RAW;
 
 again:
+	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
