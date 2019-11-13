Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F118C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178B20818
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKMKGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:06:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfKMKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:06:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUpXg-0000HQ-6Q; Wed, 13 Nov 2019 11:06:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC85C1C0357;
        Wed, 13 Nov 2019 11:06:27 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:06:27 -0000
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/aux: Fix the aux_output group inheritance fix
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
In-Reply-To: <20191101151248.47327-1-alexander.shishkin@linux.intel.com>
References: <20191101151248.47327-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157363958745.29376.17174699138865617684.tip-bot2@tip-bot2>
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

Commit-ID:     00496fe5e09e8c8bb115540e7e3470553cd07a5c
Gitweb:        https://git.kernel.org/tip/00496fe5e09e8c8bb115540e7e3470553cd07a5c
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Fri, 01 Nov 2019 17:12:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2019 08:16:40 +01:00

perf/aux: Fix the aux_output group inheritance fix

Commit

  f733c6b508bc ("perf/core: Fix inheritance of aux_output groups")

adds a NULL pointer dereference in case inherit_group() races with
perf_release(), which causes the below crash:

 > BUG: kernel NULL pointer dereference, address: 000000000000010b
 > #PF: supervisor read access in kernel mode
 > #PF: error_code(0x0000) - not-present page
 > PGD 3b203b067 P4D 3b203b067 PUD 3b2040067 PMD 0
 > Oops: 0000 [#1] SMP KASAN
 > CPU: 0 PID: 315 Comm: exclusive-group Tainted: G B 5.4.0-rc3-00181-g72e1839403cb-dirty #878
 > RIP: 0010:perf_get_aux_event+0x86/0x270
 > Call Trace:
 >  ? __perf_read_group_add+0x3b0/0x3b0
 >  ? __kasan_check_write+0x14/0x20
 >  ? __perf_event_init_context+0x154/0x170
 >  inherit_task_group.isra.0.part.0+0x14b/0x170
 >  perf_event_init_task+0x296/0x4b0

Fix this by skipping over events that are getting closed, in the
inheritance path.

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
Fixes: f733c6b508bc ("perf/core: Fix inheritance of aux_output groups")
Link: https://lkml.kernel.org/r/20191101151248.47327-1-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 022a34b..b752bd3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11899,7 +11899,7 @@ static int inherit_group(struct perf_event *parent_event,
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 
-		if (sub->aux_event == parent_event &&
+		if (sub->aux_event == parent_event && child_ctr &&
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
