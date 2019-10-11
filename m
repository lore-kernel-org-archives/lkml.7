Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0766C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4EF2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHYydlo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfJKJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:20:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35818 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfJKJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:20:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so11048991wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qTreiY0r3fTwoJUxRJnyLrebcRQRT7U9Xfdqs5o+giI=;
        b=mHYydlo2SqywtwYM3g8rRTyOTaZ2DBvRJEpZhZPD1tC+iz0x4R6WeN6JaUYRAztMUG
         gn2u58+m9hI4YnuqqyWMWrdrjhVE1t8obVZLZLJ0xA//K0dsZVu0ikMZdLAH7IouHwcG
         HR7xJuoCu5fYsYytFqGykH4pl2m8vh6QoCfCoKZqz5oZMeZnMuZAsk83mbmZtzI1KWbt
         mGDZMm/X3kDPWmPqyjO+n3mRwqVKNmDmfZcM6Yf9u8ecAATx3RHDpnr7HY7ok3hmys+q
         ey0hxGyhjdsIZ0L+aD+db2hK+1U/lH/EqOF3Lbc6P6vhE1k0ygypHyF84DO/VYncpPLL
         twTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qTreiY0r3fTwoJUxRJnyLrebcRQRT7U9Xfdqs5o+giI=;
        b=ZIZCMrSmD6b2c7zREPql5fKZ4Nj31QFjkuUHY3B1DJXxsuPRPfK3ie9yudscl0TPEc
         /2pBzDN5kkPR24vA2w+ndXCOm/Tvc3agxj+bgdLYjwfxpkXEt6cgy7KC9ulrWuywtJdH
         dqPOfWKLuqgvPcbo4OJw8qf4WMeWkAYZZCdnjzhgLeMaBKlMkZfai/0dfAjzBmAlBRHe
         HI3WKIfeN2tyq75MIypv776uF5O/uoOWCC17AEkx/rN5TImjOO/LhO6OswBKosAOz0Pn
         dyGiRI6eeiIJpQxY7mkWmhezEmAEifuHq+IcydwAJTx9YPKyrT+9Mteg3GDOSbwWSF87
         RD3w==
X-Gm-Message-State: APjAAAXzl5vVqucQUrK38SroajiREyFxAH7OfAtYr2wfQlwOs8A4c3Tf
        dyK3c7eaTOL9XQEdTFjx8kPuPA==
X-Google-Smtp-Source: APXvYqzjVDPoOSUpWe+tgBg9Peazn8a4pRxoFsJ08U3LOhCp/ABBxPZg05ZafUWWf6lvLvlVJaQRvw==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr13058979wro.16.1570785604033;
        Fri, 11 Oct 2019 02:20:04 -0700 (PDT)
Received: from localhost.localdomain (li2042-79.members.linode.com. [172.105.81.79])
        by smtp.gmail.com with ESMTPSA id u10sm8603492wmm.0.2019.10.11.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 02:20:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf test: Avoid infinite loop for task exit case
Date:   Fri, 11 Oct 2019 17:19:42 +0800
Message-Id: <20191011091942.29841-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011091942.29841-1-leo.yan@linaro.org>
References: <20191011091942.29841-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When execute task exit testing case, Perf tool stucks in this case and
doesn't return back on Arm64 Juno board.

After dig into this issue, since Juno board has Arm's big.LITTLE CPUs,
thus the PMUs are not compatible between the big CPUs and little CPUs.
This leads to PMU event cannot be enabled properly when the traced task
is migrated from one variant's CPU to another variant.  Finally, the
test case runs into infinite loop for cannot read out any event data
after return from polling.

Eventually, we need to work out formal solution to allow PMU events can
be freely migrated from one CPU variant to another, but this is a
difficult task and a different topic.  This patch tries to fix the Perf
test case to avoid infinite loop, when the testing detects 1000 times
retrying for reading empty events, it will directly bail out and return
failure.  This allows the Perf tool can continue its other test cases.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/task-exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index ca0a6ca43b13..d85c9f608564 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -53,6 +53,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	struct perf_cpu_map *cpus;
 	struct perf_thread_map *threads;
 	struct mmap *md;
+	int retry_count = 0;
 
 	signal(SIGCHLD, sig_handler);
 
@@ -132,6 +133,13 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 out_init:
 	if (!exited || !nr_exit) {
 		evlist__poll(evlist, -1);
+
+		if (retry_count++ > 1000) {
+			pr_debug("Failed after retrying 1000 times\n");
+			err = -1;
+			goto out_free_maps;
+		}
+
 		goto retry;
 	}
 
-- 
2.17.1

