Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1809C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8911D2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 01:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHFI4YN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKPBSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:18:54 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35302 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 20:18:54 -0500
Received: by mail-pl1-f201.google.com with SMTP id x9so7461123plv.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 17:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oyyrSWNIsHzDyGXKN9qogJst/Abh/eZwINcXn9u67XQ=;
        b=pHFI4YN+TM3wMPRs0Sai00/gZw/oMmLXKygl5BBW7FgWJLykIeGJ8xmcFdZnXfbZlL
         3uW2I2buJVt2xtSF77DCulgSybJMOCp/y5UH/x+txuRGZJ0S12PXCSMq9SuOUaAwXSZ2
         Sut1gl40I/By7IeVYftAxb+SmokYNJ1EeQKQVJM4+rbfzTPh69i9sfNBMZby3NWkC5zu
         0BGttX2v5li9kc07FYSaTTQya/vvEYOZsXJpPnoBvEx0/Yd36Flcj9SiWKGVK/FyBvSp
         gNWjqIjxyIq5YdXP7fRkm4e5rjclzv482f2Kr0eLHTMgwFCqNpwvWAUZ8KFTtx8QVS09
         pcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oyyrSWNIsHzDyGXKN9qogJst/Abh/eZwINcXn9u67XQ=;
        b=nskUthLjVb9ELsJPhagxqk5qQDwf2QObDgCaD3h2fsQPiKKFOydGewu8y3urTh33CX
         CYGxT/H5Hfoib2FRgz4BchPRGXcnnWAU9UaEWneAa+u9zMJzvrWToIbyE7ekndigFq6T
         dLtzMKaxVVOzgKzg14RkWSUY9X2hT0StWGa6NMw5sI9cth0w+XsExGWVcGEcDPhQA6GU
         5IpbLcXzKOlmw9hLR0ANF0h5kefjANQQQA9YM+UIYFkiWy3q08XnfVOeviMIYlcaHo/3
         QkXL9eammGMfagbHOdfwO6XtB3RkCOirmwQTGLdpS/Z96iNoFLYn6tyqbndUEIqVMFnJ
         xmdQ==
X-Gm-Message-State: APjAAAXgNBFEJFAgAvz6+bSTRmaORgn6J4DHunW9qzcz/NhqS6qVAjoS
        1313wQ1aSx9eK5MtcLFUhEtx4S/CFVgm
X-Google-Smtp-Source: APXvYqydLayo836dsLIdcAePESVOSrYVoF/8reHncNaaFQPyT6vIf5oRUpwqS9D0iE+iyokD89CSTvvrt/if
X-Received: by 2002:a63:4a01:: with SMTP id x1mr5772043pga.312.1573867132739;
 Fri, 15 Nov 2019 17:18:52 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:18:36 -0800
In-Reply-To: <20191116011845.177150-1-irogers@google.com>
Message-Id: <20191116011845.177150-2-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191116011845.177150-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 01/10] perf/cgroup: Reorder perf_cgroup_connect()
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

From: Peter Zijlstra <peterz@infradead.org>

Move perf_cgroup_connect() after perf_event_alloc(), such that we can
find/use the PMU's cpu context.
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfd89b4a02d8..0dce28b0aae0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10597,12 +10597,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
 
-	if (cgroup_fd != -1) {
-		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
-		if (err)
-			goto err_ns;
-	}
-
 	pmu = perf_init_event(event);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
@@ -10615,6 +10609,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_pmu;
 	}
 
+	if (cgroup_fd != -1) {
+		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
+		if (err)
+			goto err_pmu;
+	}
+
 	err = exclusive_event_init(event);
 	if (err)
 		goto err_pmu;
@@ -10675,12 +10675,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	exclusive_event_destroy(event);
 
 err_pmu:
+	if (is_cgroup_event(event))
+		perf_detach_cgroup(event);
 	if (event->destroy)
 		event->destroy(event);
 	module_put(pmu->module);
 err_ns:
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
 	if (event->ns)
 		put_pid_ns(event->ns);
 	if (event->hw.target)
-- 
2.24.0.432.g9d3f5f5b63-goog

