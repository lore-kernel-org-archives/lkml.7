Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9AD206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zft23OiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKNAaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:30:52 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45505 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:30:51 -0500
Received: by mail-qk1-f202.google.com with SMTP id 125so2823506qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q5BVy3LM6g/+i5ONTVpnYErnTICrIvFQYsi/wghRzhI=;
        b=Zft23OiEim4VU62nn6aq7PUdGktOQ4gbOm3FWNIOgyfwOASjla85bl9KzK7PJyfGUl
         JsQAu1P3i9a5K9AjtjNsJB7CkLl3TB6JYEPFjnpVD6u28jJHwnjUyL7NQ2WtkALv9f/G
         /5TfZaJB+/t5IfOOQqQyxs4TCurTDIoXwbyP6A9TltHDlIkwsdwY939nFfmlvf3wgTYi
         pLdcaESDQRaWSC6jAtaGIfq5Kbi+8t9sb0kjRKvXltiWn/Bs4nM0cfrNKRN32Jj3m9bK
         h4GGf83r4Lve2vCzWmucxsx1+qMqz1syoFQmfhO7lt4Tf3THggRmwO/gnEi4BXzOJRJ8
         kD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q5BVy3LM6g/+i5ONTVpnYErnTICrIvFQYsi/wghRzhI=;
        b=dq6p4kJmdCv5v2tDpIVMs06C33D8IGO2sDukUCnOvoNXFHrYqwazl2OuWsEArV7D5a
         YlmkHK0FlQXSGaqKmLm9KEnoZrZfljNUPLBVacK6KycVuv3INcm2ysVBUtGMkkg6kE6r
         Pg3K0rY9BlXKQ4FyBExGWFs0y6cuaSupvXzEmyvAiROlvVt1AF+mvmXN8gUpaw6uEvTu
         K42WCUFWXOXOa8y1Ieb9E5SQIj5Nd7B4qRnc6uu5GgxaHQHrzCj21T4EEk1LPsMJiuXx
         F0+jp7xQj62+TXAmpZYkTz5v77x9T3AD+uQwGvc1pIBAXPKcMTkXt9zEgSL+lo/s/clo
         tFtA==
X-Gm-Message-State: APjAAAWu0AR6Ye7Ji2GWPgFkOuKGf/LiYSUYNSFJjY8PUy9qgRuC6nVe
        Au6axMaSkrCQx3nnZPvIRisTCBJlPw/D
X-Google-Smtp-Source: APXvYqwhDV/+fE48KwXb0ZGJt1uCq1GZB8QqYBMBmmq6X/Y0mM0V0SoXIZ2W/tMd9/kkb7cRqATpFSWZ65CR
X-Received: by 2002:a37:9d96:: with SMTP id g144mr5371822qke.93.1573691450191;
 Wed, 13 Nov 2019 16:30:50 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:33 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-2-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 01/10] perf/cgroup: Reorder perf_cgroup_connect()
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

From: Peter Zijlstra <peterz@infradead.org>

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

