Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B62C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE912089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s70513xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGBKez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:34:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46229 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:34:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id 65so12599750oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1cJQod20rlh4JhiBTdx2PH6KqMq30JuyoSJBz8Qo1U=;
        b=s70513xyDTidEr5Ppvu38moEO3tF4ILImM8v234mxyFjRqgVL7SFC8HyivT+ff4BNd
         wxGqLRz7aP+i61gRKfuH7f8z7WdX2tqXxbAgbQVVOGp+FcOfBbceh+Z0vBLp2jNZQqrs
         WAEP/LJXy6qfpj1dlbOlmWHvTcZp8tVA372DlFQZoDTSj6PhAMPwBV/3xMYn2Pc3hCp5
         tZCXr+LfJZtmlV2gC4Dv7HoGfDrJ43YxMfEIHYkyuuPPMyn+01SC86WD3fU0uQvp7Wlq
         cpolfqTfxRJQh6j8ZyxIdCmR+7ly3pT5tC68g9KVPQ2P2nGKQINU3FBmCxa3UMKBeKqJ
         8WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F1cJQod20rlh4JhiBTdx2PH6KqMq30JuyoSJBz8Qo1U=;
        b=sULfVjyirXn3Hqtkxz5cVfx/rkzp8cadcGefZXhwFNUV4oBi5BklJXdTBv4vt74zwG
         4n7hlykqAuf/iMT/O6oM54dmiq7REXGqr+TwvMivDDuxM6vubOmDJl3AbmwOv+CXt9CK
         MeMNXTskuUX0ii11rYPnURZqMfh/Nc/y08zN7s+d8D4P4phGNZzgbhIgzgz2QWvWVkj6
         jgeh+xmrzETJETOYV9SxYYcfuLzaIYIh+ARxQVjGISxdwVmWuJNnpbV6zbjHML8MJqtL
         CUumYl3ymGCoSIVMaOw/WzrM46LY6Pvru9AP73dzeObnA1TAsqqMzwex7pffT1RFE/k1
         3MFw==
X-Gm-Message-State: APjAAAW8ac3oEokv4YegUVEPDVELlK1eFmU+22grkMHtg3ueLh8JIKog
        uvPGNV9KH7dFONdDouvdUfn6lQ==
X-Google-Smtp-Source: APXvYqwXUGBWMvijX1rTe9gC+TubnyPy0SebRYMoaXww6u6Jlauk/K+tVBQqpLLVrWIfnLXQKnU2rA==
X-Received: by 2002:aca:3bc6:: with SMTP id i189mr2397047oia.153.1562063693989;
        Tue, 02 Jul 2019 03:34:53 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:34:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 01/11] perf report: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:10 +0800
Message-Id: <20190702103420.27540-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/builtin-report.c:304
  process_read_event() error: we previously assumed 'evsel' could be null (see line 301)

tools/perf/builtin-report.c
301                 const char *name = evsel ? perf_evsel__name(evsel) : "unknown";
302                 int err = perf_read_values_add_value(&rep->show_threads_values,
303                                            event->read.pid, event->read.tid,
304                                            evsel->idx,
                                               ^^^^^^^
305                                            name,
306                                            event->read.value);

This patch checks if 'evsel' is NULL pointer then pass UINT64_MAX as idx
parameter.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-report.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91c40808380d..a894ce7cd04e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -299,10 +299,10 @@ static int process_read_event(struct perf_tool *tool,
 
 	if (rep->show_threads) {
 		const char *name = evsel ? perf_evsel__name(evsel) : "unknown";
+		int idx = evsel ? evsel->idx : INT_MAX;
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
-					   evsel->idx,
-					   name,
+					   idx, name,
 					   event->read.value);
 
 		if (err)
-- 
2.17.1

