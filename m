Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A168C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B7F21479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfJGOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJGOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK5-0005wT-M0; Mon, 07 Oct 2019 16:49:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 594431C08B0;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf jevents: Fix period for Intel fixed counters
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190927233546.11533-2-andi@firstfloor.org>
References: <20190927233546.11533-2-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157045975531.9978.3214758589104443413.tip-bot2@tip-bot2>
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

Commit-ID:     6bdfd9f118bd59cf0f85d3bf4b72b586adea17c1
Gitweb:        https://git.kernel.org/tip/6bdfd9f118bd59cf0f85d3bf4b72b586adea17c1
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Fri, 27 Sep 2019 16:35:45 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:53 -03:00

perf jevents: Fix period for Intel fixed counters

The Intel fixed counters use a special table to override the JSON
information.

During this override the period information from the JSON file got
dropped, which results in inst_retired.any and similar running with
frequency mode instead of a period.

Just specify the expected period in the table.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20190927233546.11533-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9e37287..e283726 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -450,12 +450,12 @@ static struct fixed {
 	const char *name;
 	const char *event;
 } fixed[] = {
-	{ "inst_retired.any", "event=0xc0" },
-	{ "inst_retired.any_p", "event=0xc0" },
-	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
-	{ "cpu_clk_unhalted.thread", "event=0x3c" },
-	{ "cpu_clk_unhalted.core", "event=0x3c" },
-	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
+	{ "inst_retired.any", "event=0xc0,period=2000003" },
+	{ "inst_retired.any_p", "event=0xc0,period=2000003" },
+	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03,period=2000003" },
+	{ "cpu_clk_unhalted.thread", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.core", "event=0x3c,period=2000003" },
+	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1,period=2000003" },
 	{ NULL, NULL},
 };
 
