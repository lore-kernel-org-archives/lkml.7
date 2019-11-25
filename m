Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B5D20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIJ3Ezvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfKYRlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:41:42 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51123 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKYRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:41:41 -0500
Received: by mail-pg1-f201.google.com with SMTP id u197so9156438pgc.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XYu2mD7mAFODCF+cWnHpB69giVKtmp2lAnz9r0bBxfs=;
        b=HIJ3EzvcsQw68+t/hjGahfNDrn9zVE/rogo2UzEv8U/avieGPZERP282ovoIDyF5ND
         vu+mGOvjJaUVmkkmvlQ9kz8Sneqb7mMBpjp4ChH4aKR7XgFWLqlLnir/PWICEB8EOLxy
         JwlQqoUkSaRuvVA0yMmYoAKOowMJcalHECKUo0PIJhqV3uM6WjfMZrnttCIYcOXUZD2x
         v3g6jMyiGOFLCUhF033kTb5uuLCJ5CMHPcHK2DUrvWtbxj8qI53oUg1i+R6MQ6fR/+/f
         0FqMppnL+QCl7roIAWBX8T3lNSmkqYafHEPNIAVT240550lzbq4M/A2iDbtqKiNrquFZ
         Qekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XYu2mD7mAFODCF+cWnHpB69giVKtmp2lAnz9r0bBxfs=;
        b=T6k3o8yzcTh+2TbW+9hCsDfpp+rT0aju4ym/fErwkKn5jM9PYKJ7cun82TCzpqiA+j
         EyQedRt0H+01lend/jamUJV8afxuGGkKsxud75ZUyhppuekMhN58GkRYSWTNNxbuPC3j
         8vIObdspAO7xjv6+Ym4gdF8I0sh7GlluekZt1DcR9b1Fwsbs+/+VTKcTV3329bTDeHhv
         J6aGcGhx+AvB3MNh02+2yX1s7MUDgdutCUBPQxrMi4GfFE72nYP9EsPQTJ9UML8R9eS/
         bnezagOlDSQNp6CSr7+/XPSUrRqBqabLAQwh9nrL48sB2t6qTg4ciZAMcd4RKTF7tdT6
         AK2A==
X-Gm-Message-State: APjAAAVKb4O2U2k+A0j+dzkGCIGRhrLr9qB3FCj0HR0WOlHFEAh1NAlp
        cuChv+ZSByfeXlaE4JWdRIi6BgMcRhyP
X-Google-Smtp-Source: APXvYqwa8M4lSpC89U9XypJDCzcJcESxvNi34GN55SkF5c0++O3PMJG3RzvNpQS9xaoVkDGx6gs/HCW+Vev4
X-Received: by 2002:a63:4948:: with SMTP id y8mr35070328pgk.333.1574703700864;
 Mon, 25 Nov 2019 09:41:40 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:41:35 -0800
Message-Id: <20191125174136.95893-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] perf tools: avoid segv in pmu_resolve_param_term
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PE_TERMS may set the config to NULL, avoid dereferencing this in
pmu_resolve_param_term. Error detected by LLVM's libFuzzer.
To reproduce the segv run:
$ perf record -e 'm/event=?,time/' ls

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e8d348988026..1a6e36353407 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -988,13 +988,17 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
 	struct parse_events_term *t;
 
 	list_for_each_entry(t, head_terms, list) {
-		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
-			if (!strcmp(t->config, term->config)) {
-				t->used = true;
-				*value = t->val.num;
-				return 0;
-			}
-		}
+		if (t->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
+			continue;
+
+		if (t->config == NULL && term->config != NULL)
+			continue;
+		else if (strcmp(t->config, term->config))
+			continue;
+
+		t->used = true;
+		*value = t->val.num;
+		return 0;
 	}
 
 	if (verbose > 0)
-- 
2.24.0.432.g9d3f5f5b63-goog

