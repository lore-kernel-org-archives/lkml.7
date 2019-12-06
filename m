Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B51C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E2F20707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 23:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHQvRFAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLFXPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 18:15:51 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57107 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLFXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:15:50 -0500
Received: by mail-pl1-f202.google.com with SMTP id k22so4320479pls.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I4M4KX0Fp9NuQDPdpdb+xKGjzeVR9Ca/ebNzHoQzFYY=;
        b=mHQvRFAyDn4sUwagQUaGySuswXPtfz9iPRaRI/sCzYjJtZKVRgq0l1LQbRB3Fi1eWZ
         2OIuQJKHkeWKXkERjN32U4AIR7mfx5Foqs2R9BrLiQExdi8wdwkop0nWbpuDn+qFvXR8
         c571QvQu8dzi6al3UT02jqzQkm5S5xnWTwc3IEaRuqgBacwSzqVQ8CI6hIPsCoPGBrxZ
         AKVgQHRfatwRUtTSUMRy+60VMCUCw0J0zzu6LvwLbSMu98N8rwWNl7RWIly7nA1GYol+
         6lh5xZsoaebjgOxkjLasQ6jmYPsTzW8x3qeM+iM7/oOTcHva09RQqCEgj+gt64Q/FNxc
         mIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I4M4KX0Fp9NuQDPdpdb+xKGjzeVR9Ca/ebNzHoQzFYY=;
        b=l4DMiULuQ5+QPG+hlALjTz49YFTflOVgYFN3Z38SmTYmwENgqjNf8JypIjzBkJDftL
         X0DzUFPnvTFFYuBex8jizQThq3Au0IfwnJPtrEGy1EQnVN50KaQW2k7Sj0HywPe9RnO1
         tZ1ByUhKAQcwJFmfY/ZvEwoIaqH+LQFWVqhZY4I+cvQ3gwZmRyIHg8WxjKNTThSAVWMi
         BkrzZBP5UvEwx6M3GQ++iksH9v5B03fju1fyEjNE7f5jz2ejAS9Mh+BKmKW/4V7Juit5
         pOLi5PtUssFezN1gE1Mtb+v9f4fbaBRSiMagGcx9MEU9u6I6kQs3t5lKL1cJQFs6pMPi
         hqSQ==
X-Gm-Message-State: APjAAAWzkQM9nrbH7XtrLm1z/CFF8zb3UY1/zJr7m5tcuJdP7v0y9cq2
        7y9hnsd1XJ5GfffTgxVY3EK9ebulR/pQ
X-Google-Smtp-Source: APXvYqxL8l85+n88aPvVsM4BvzMu57TmZW9L0JeBP0YmnfzT2ykhBhIxQ80M4sTRnagcNXm4PbJ65SeOU/bx
X-Received: by 2002:a63:b20f:: with SMTP id x15mr6182506pge.65.1575674149825;
 Fri, 06 Dec 2019 15:15:49 -0800 (PST)
Date:   Fri,  6 Dec 2019 15:15:30 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20191206231539.227585-2-irogers@google.com>
Mime-Version: 1.0
References: <20191116011845.177150-1-irogers@google.com> <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v5 01/10] perf/cgroup: Reorder perf_cgroup_connect()
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
index 522438887206..9f055ca0651d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10762,12 +10762,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
@@ -10789,6 +10783,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
@@ -10849,12 +10849,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
2.24.0.393.g34dc348eaf-goog

