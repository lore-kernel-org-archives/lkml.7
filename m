Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF51FC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39002073A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnsW3D2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfKPBTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:19:18 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36546 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfKPBTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:19:16 -0500
Received: by mail-pg1-f201.google.com with SMTP id g6so8555298pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K24WoJSDORJhbZAjQBSR8bl4xUZNuCUW/4U8RC0nkmM=;
        b=jnsW3D2jykRX82K/Q0CeEhmAfIjyxBrX56HgsdwGHcZluGYgJh8pehrGt3TGRJmbf8
         ArLelPbvDaAVYNyzUm9HxKPsoKB6aiRSrDUu47WygekfK8iuqBdLbViHpTqOkQbq4Zo2
         pruBUPS97g/Pa2URO34VQ92jpHuwPTFJQKxaw1kmIHgH/DLS9ygKdW0ZWyMC6cHihu2+
         ecasY7Zn5NP9i5J6Ub1PxFI9ILebKuZPmO0kDHt7KVe0bm5Zkm6yuNzRVOUcK3kmHDwt
         IQrg8JWAHOrTjtvFC5Q8XPvdktlmJyKAwJH/+I+iMV47/rK8XoKT1Z6ZV5ZDdkHZjci1
         y+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K24WoJSDORJhbZAjQBSR8bl4xUZNuCUW/4U8RC0nkmM=;
        b=uh4wwLpB8+R5h25jRgXnZqf7faXRIfs6uPdi1Eng2rICPqp+gIIYNAPO/jFPEO1KqV
         iDPV+42lMgm4qBjoditSZysZh+bql4DfAkDh3k7vWLOU0x08gScsDQglD1ODkGgTVY4o
         91WrpdOjtEY0TFyD+39mw9Y/LpD5hmBaU1t0jznCKQNNCshrHqI93vFVkb5IjrTzhI2q
         P+nnGan+92zgZa4tzc2jGHax4YOfgRkKZRgyCH01y4YWplkR3L2UHH1bWVUJNT+o8KmX
         9lc951puFC3hdtW/ksIeRJxi2ybcqecocT9oQnrmonYek6zm1C1YRWIiPR0tdGHRwZK3
         H3uw==
X-Gm-Message-State: APjAAAX7+rD9jqz0NwsFX1Z03O4VHLDYqKS/LY/TthLJYFiQrG2h9hiP
        WDeevpHIoqhRe39NvOZVRtwXvvnnTkF/
X-Google-Smtp-Source: APXvYqzvVVHvDpzGdzw4fOWkeKTvy7V67Y6qbVyaf/MM9sNB/1WOVjJ+pbwU2ToRB7z0M9IRJD1OrNa2koVf
X-Received: by 2002:a65:528b:: with SMTP id y11mr19459494pgp.420.1573867155316;
 Fri, 15 Nov 2019 17:19:15 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:44 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-10-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 09/10] perf: optimize event_filter_match during sched_in
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
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 kernel/events/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 37abfca18bd3..6427b16c95d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2212,8 +2212,11 @@ static inline int pmu_filter_match(struct perf_event *event)
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
@@ -3562,7 +3565,11 @@ static int merge_sched_in(struct perf_event_context *ctx,
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
-- 
2.24.0.432.g9d3f5f5b63-goog

