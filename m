Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301DC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6015F2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QR/zCNgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfFQJMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:12:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36092 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfFQJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:12:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id w7so6492707oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oZAaOCoJj5x4sDBNqZQb5CRUWvcKQL64QGOvdU8EjU4=;
        b=QR/zCNgVHHN5LeDILxIyEF49A0+54vewuBaVy2cgPGVk8oEINFWT7v77TpCagykcA9
         sZtuMn2DGpqTyvZ4T46gz41Zqq9tSi0sR0XX/jm0xoLs6BlL8yS83yr5bwTUP/ZhXFFe
         APrXumCbSdT91yp1/Be6n4CnzCRDmCo5Mn6FSe/9mZb91Xur++zomVFwRzDqewFAqKxj
         YPyNnS2f6z5mV+A7dVWTEMCm82AJiM/GK0uCt8RMX6ekyDVhr+OB78o/BwVy7y656DY/
         YYI/DJvQ5lf4RZfQnDL+tbi3h+tvy+3/pY9ZEhcuHpoJzG0vTEumIjPZbIPMzjPBpn3B
         88iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oZAaOCoJj5x4sDBNqZQb5CRUWvcKQL64QGOvdU8EjU4=;
        b=r+/DNTsYm1qBPf3kJIL9KWjuLPDHVBuxfVns3KqtmhBmUlhF4O93xeq/ylt7Y7fw0n
         95m97Xf7xB36dRrNaJWvA2DPKuQKmV2XnZ+mDcNr1xTwHyCKNwYqG5rMkbnRvFXodatw
         U1ZyMaCBRZMnwnkXGsAX9XFgzBjWhnPVuFxsf+Qi/O5mwKMaKrA3IiJI5/SStFmHyg1q
         D1nArwwsugaL/hWEqNrbw3xs413nTl8BRTERsU5yCD7wYjPofYxxzlxMmZnfYCCG1F0Z
         +JnFQXCXsZlio//HfqaVA8yqURI9Vtq/TBkSiYb1FhlWmZ3zqzVTQNwACyVfCAtBgGNC
         +GpQ==
X-Gm-Message-State: APjAAAXtqQABI2UBwnd0Y/2KMJQfOUZQZJf3XiAE86Ke7XzxM4MaAawM
        EHsLoLtI5VT95zhPxRwR0RTclw==
X-Google-Smtp-Source: APXvYqxqLNV9ru2z5YiSS6UvcnG8UNh3v2Lq1GuDACtveDmZ0Jn/Bs7DJjYnWgT6GI7qHMz9SBfwOg==
X-Received: by 2002:aca:aa95:: with SMTP id t143mr10189295oie.22.1560762725883;
        Mon, 17 Jun 2019 02:12:05 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id l145sm4418324oib.6.2019.06.17.02.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:12:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] perf trace: Use pr_debug() instead of fprintf() for logging
Date:   Mon, 17 Jun 2019 17:11:39 +0800
Message-Id: <20190617091140.24372-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function trace__syscall_info(), it explicitly checks verbose
level and print out log with fprintf().  Actually, we can use
pr_debug() to do the same thing for debug logging.

This patch uses pr_debug() instead of fprintf() for debug logging; it
includes a minor fixing for 'space before tab in indent', which
dismisses git warning when apply it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-trace.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bd1f00e7a2eb..5cd74651db4c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1760,12 +1760,11 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		 * grep "NR -1 " /t/trace_pipe
 		 *
 		 * After generating some load on the machine.
- 		 */
-		if (verbose > 1) {
-			static u64 n;
-			fprintf(trace->output, "Invalid syscall %d id, skipping (%s, %" PRIu64 ") ...\n",
-				id, perf_evsel__name(evsel), ++n);
-		}
+		 */
+		static u64 n;
+
+		pr_debug("Invalid syscall %d id, skipping (%s, %" PRIu64 ")\n",
+			 id, perf_evsel__name(evsel), ++n);
 		return NULL;
 	}
 
@@ -1779,12 +1778,10 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 	return &trace->syscalls.table[id];
 
 out_cant_read:
-	if (verbose > 0) {
-		fprintf(trace->output, "Problems reading syscall %d", id);
-		if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
-			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
-		fputs(" information\n", trace->output);
-	}
+	pr_debug("Problems reading syscall %d", id);
+	if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
+		pr_debug("(%s)", trace->syscalls.table[id].name);
+	pr_debug(" information\n");
 	return NULL;
 }
 
-- 
2.17.1

