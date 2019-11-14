Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4CDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB6D206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zgh4ESl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKNAbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:31:17 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49240 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfKNAbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:31:15 -0500
Received: by mail-pf1-f202.google.com with SMTP id r187so3059698pfc.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VgZwnUHO5f/jd24U05bDRgOKFO8dAbQvHdYsQlCEmvc=;
        b=Zgh4ESl6SeotYDy3E5btTCAJ2BJjVtJxHPSmFm2IlpiwBurx7RLXfprK+MUKgY2buP
         71pf6xh0jY3BxcU72KXd8/ESzUleg+UdzH+id1RLXOFhX9pBEOe+jqIgG2WDLRoS5wWh
         N7g0CBCt+9loS7VM9bfu4C3ed4tzRX9TnUiIVr9mZt5lLPULPI7/t+bAMYdFvTzbojL5
         Qp1BIlwpjwkhXbTwW80DjWpPK0nofAkXacJB3fQhPqCNyuCqsEZasGel2YjMwOr5TWGD
         AMU5DeyRZMRtTqVz1rFovbIJlMAaFv7yP/e2S4NSw+w0CwnO741cHQpGmykml/32zjVM
         dvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VgZwnUHO5f/jd24U05bDRgOKFO8dAbQvHdYsQlCEmvc=;
        b=A+WDnpB0fWvlgEAYWlJlXyP9d9uN2Y7MBLXxFjyJo6XXDLHHDoUogIgOUsqmJBNxmw
         A4RRix3nOkFkR0SpxvBali/zECS8x9WYmbgAqiInSO0xaU32qdxIBX0+z2gHf84ODwSz
         3Lu5h9IBChi4J06lNuOojC3sE/Ii5+kSps2FjBiynHLC9+t97hHX72ioiSBcrxpZ10FU
         d7UP+MBX/FS+GuhwFpYNq6SYyq9Fju1bY62WQBcXziXuCrZGN2vvA4Be+IW53ayVaNLg
         PXSXoSB1isifwYavpMH4flWoFcoxu1toztcOXZOON+Y41a35VMHYljZvXem0N3DsL433
         WXPw==
X-Gm-Message-State: APjAAAXcElgWjAJ51zMXCuh7JlbBQKkashVy/tvhak61dmKqmFOcLINV
        8X08FphxBwdruB78YXL5xFVeLniaBmJi
X-Google-Smtp-Source: APXvYqzTjwHR3bActcLFC3xRs7HkZf40asj/lMb+inicBAtWLiyW4bfXE/dJkOTP9bqfwVDdJKmjBTOsP92E
X-Received: by 2002:a63:4951:: with SMTP id y17mr682980pgk.231.1573691474088;
 Wed, 13 Nov 2019 16:31:14 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:41 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-10-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 09/10] perf: optimize event_filter_match during sched_in
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller verified the CPU and cgroup so directly call
pmu_filter_match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9f0febf51d97..99ac8248a9b6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2196,8 +2196,11 @@ static inline int pmu_filter_match(struct perf_event *event)
 static inline int
 event_filter_match(struct perf_event *event)
 {
-	return (event->cpu == -1 || event->cpu == smp_processor_id()) &&
-	       perf_cgroup_match(event) && pmu_filter_match(event);
+	if (event->cpu != -1 && event->cpu != smp_processor_id())
+		return 0;
+	if (!perf_cgroup_match(event))
+		return 0;
+	return pmu_filter_match(event);
 }
 
 static void
@@ -3632,7 +3635,11 @@ static int pinned_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	/*
+	 * Avoid full event_filter_match as the caller verified the CPU and
+	 * cgroup before calling.
+	 */
+	if (!pmu_filter_match(event))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, 1)) {
@@ -3658,7 +3665,11 @@ static int flexible_sched_in(struct perf_event_context *ctx,
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
-	if (!event_filter_match(event))
+	/*
+	 * Avoid full event_filter_match as the caller verified the CPU and
+	 * cgroup before calling.
+	 */
+	if (!pmu_filter_match(event))
 		return 0;
 
 	if (group_can_go_on(event, cpuctx, *can_add_hw)) {
-- 
2.24.0.432.g9d3f5f5b63-goog

