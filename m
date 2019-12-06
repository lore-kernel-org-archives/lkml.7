Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA0C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DB52245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gboq1hQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLFXQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:16:15 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:34995 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfLFXQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:16:11 -0500
Received: by mail-yw1-f73.google.com with SMTP id c68so6587349ywa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wb+OKThbtJSICtKGbqaWde4wJBvL1Hfa7Pzncbz50Ck=;
        b=gboq1hQCrlc0HFE2wptE4H66zZSkT4E2GdJjF/bfMGkLq9fxgBHdFdVTwqCmUfyFgx
         GHi6dVCxFkiWuTStWkZfPGaTPPBze+seALYlxfBrl+j9+befxCLvxkIlHJndShiSUsdM
         ZhuqxLgmDtU+8djX1M+Bska9ICvWisI8/2PL4AVFZkkvuoh5FC7BK1eOuZRIoc8eSA4+
         hZWhERuUJgdy5gDjtRwiCf9ICWGhuk6hbJr63dVew9Ed+/X/NH9XaElwPfLrhBLygB0c
         hIgaWuRh7SP439z23zL554Y6NX8QrTV0wh84XgqINBItAVzRYEdObixpY7Sfceod0dzu
         H4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wb+OKThbtJSICtKGbqaWde4wJBvL1Hfa7Pzncbz50Ck=;
        b=TdJTHl0uqhFX3thaObldsrt/knrBHNhR13YvWeQXwihgle1iAB6LBfY8DcsWz/fpkr
         Us7UKWqJfni4b8mS6nAmvbsH9R3abFJmdquss1GphPR2z5a6hH+XUc/u8d7zQhpodGfF
         oZDsOXn0Aopqnax7jFzo+QrzbDQTcroEYfQd+o20AHjA0/kfIf9U53mf7jziJwpuXGrC
         ZEMTiK+nrF+lbwDtI8Ae/pF4MxaRQLqvgTQeZplKTjGAc7eAa7fgUe8YZJkfGXQPvQNG
         s58ZsgWszXGLQ7Kbu4U+EFJQb7ATU6eVzgE+mC1eKJrZ702+DZLoFmu6k15lNoEYdpkI
         grtw==
X-Gm-Message-State: APjAAAVy4+qrtDw2eD0t7Uje/wlYh4KBgf3Cb6XnifKnPH4odV3agKKZ
        yOEmDLbp+00srhFpk75Z3wfbWVsUezE1
X-Google-Smtp-Source: APXvYqxqyt7G125LkTKOPRmFM2J4oNiFQnGrKM2FAMF47G4qdMmoJZ77MCBAdGaG6FoPVAnGleKMeVXMX3yi
X-Received: by 2002:a0d:d64d:: with SMTP id y74mr12602330ywd.386.1575674170377;
 Fri, 06 Dec 2019 15:16:10 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:38 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-10-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 09/10] perf: optimize event_filter_match during sched_in
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
index 5935d2474050..bcaf100d8167 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2227,8 +2227,11 @@ static inline int pmu_filter_match(struct perf_event *event)
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
@@ -3577,7 +3580,11 @@ static int merge_sched_in(struct perf_event_context *ctx,
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
2.24.0.393.g34dc348eaf-goog

