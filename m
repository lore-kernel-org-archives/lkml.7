Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED3ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE04D2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMtbEdxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440556AbfJQRFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:05:39 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33225 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbfJQRFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:05:39 -0400
Received: by mail-pf1-f202.google.com with SMTP id z4so2251862pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KdTZDDDRzkpxS5FsYtTfQfiur0+t7NAcZsbef9E4EjA=;
        b=GMtbEdxZdTkK2AxED3byzE2O2Rq42mvmnyocbUsyNA7Rmvnu7U6I+qp3niaAka1SLj
         MdmqYmG8YWbtkIo7GJzqXnWYEpXyZXO3p+LmLZj6gOQF4h17Grn+oFHM99p8UhQzeI2H
         f2fK4MgTIZsC7kDujFj/W+iQM/BtzWI9dFHwtxCophWW3FFoXuPipVwaE7JL8HfP9A3z
         vDIdNjr3AqgC6Tzbg1KVC6a+A1IGCS+1mKFsxo0vIDcv7yKDYSPna1oGkYmLBlhQskwH
         5EQIZtLQQwOolFHUXWgrKHpvR1xlslFlZ0I6sQdGe15KakS8u2KbOHodbFbbB0IkVat6
         Bzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KdTZDDDRzkpxS5FsYtTfQfiur0+t7NAcZsbef9E4EjA=;
        b=bCETGJWhUwtqTjHC/xeRpG6Y3wykGQXAZZvjaUOkuvEEOFEP+VFGaa5A7d05gtn8xJ
         HM4uflD+JL12dWauh6XGBckTTKIHB7U05VzVx2irIIV5CNIJ/9iU0/jx4x+7bqXfVC4R
         WvX+sTmgI+ofkWNgzLwCsntjf9gsZtgwOIOlG83uQ3jwBfEbQ89rzzmP0I+WM6w6loDA
         TYEB9gMMayx4dOx0H1Bzu6kBOm4LtHXdvEi1ZHmhEG398d4DGnqakwO80XgDTOdHEZLG
         E8kyLW9wy6hTdB0sZkZ3sXHfDcD5eJjrhMjKtgAoQe+Ld4o0tzPKRDeO0LpURoF1Mzkg
         0kqQ==
X-Gm-Message-State: APjAAAVB9CuIbAvQZ8zT0oOhsi8yvsQJfSKo1DKU4T2ZH8bfx/hfmEsT
        sG6DZI9KiOpcgiQPfbU7N0ymrgr3b6Q9
X-Google-Smtp-Source: APXvYqxAJGh4yl1goKClnAPjJuMPtWKQkYnbNVeHMZ0BhMmMqpxIQXpp5Yh2StnUjYLvJPXfRrtGdDMqj+wC
X-Received: by 2002:a65:6903:: with SMTP id s3mr5086248pgq.195.1571331938396;
 Thu, 17 Oct 2019 10:05:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:05:31 -0700
Message-Id: <20191017170531.171244-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH] perf tools: avoid reading out of scope array
From:   Ian Rogers <irogers@google.com>
To:     He Kuang <hekuang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify tracepoint name into 2 sys components and assemble at use. This
avoids the sys_name array being out of scope at the point of use.
Bug caught with LLVM's address sanitizer with fuzz generated input of
":cs\1" to parse_events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 36 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 48126ae4cd13..28be39a703c9 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -104,7 +104,8 @@ static void inc_group_count(struct list_head *list,
 	struct list_head *head;
 	struct parse_events_term *term;
 	struct tracepoint_name {
-		char *sys;
+		char *sys1;
+		char *sys2;
 		char *event;
 	} tracepoint_name;
 	struct parse_events_array array;
@@ -425,9 +426,19 @@ tracepoint_name opt_event_config
 	if (error)
 		error->idx = @1.first_column;
 
-	if (parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
-					error, $2))
-		return -1;
+        if ($1.sys2) {
+		char sys_name[128];
+		snprintf(&sys_name, sizeof(sys_name), "%s-%s",
+			$1.sys1, $1.sys2);
+		if (parse_events_add_tracepoint(list, &parse_state->idx,
+						sys_name, $1.event,
+						error, $2))
+			return -1;
+        } else
+		if (parse_events_add_tracepoint(list, &parse_state->idx,
+						$1.sys1, $1.event,
+						error, $2))
+			return -1;
 
 	$$ = list;
 }
@@ -435,19 +446,22 @@ tracepoint_name opt_event_config
 tracepoint_name:
 PE_NAME '-' PE_NAME ':' PE_NAME
 {
-	char sys_name[128];
-	struct tracepoint_name tracepoint;
-
-	snprintf(&sys_name, 128, "%s-%s", $1, $3);
-	tracepoint.sys = &sys_name;
-	tracepoint.event = $5;
+	struct tracepoint_name tracepoint = {
+		.sys1 = $1,
+		.sys2 = $3,
+		.event = $5,
+	};
 
 	$$ = tracepoint;
 }
 |
 PE_NAME ':' PE_NAME
 {
-	struct tracepoint_name tracepoint = {$1, $3};
+	struct tracepoint_name tracepoint = {
+		.sys1 = $1,
+		.sys2 = NULL,
+		.event = $3,
+	};
 
 	$$ = tracepoint;
 }
-- 
2.23.0.700.g56cf767bdb-goog

