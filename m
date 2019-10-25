Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90C9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C0421D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1GOx2ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfJYSJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:09:07 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34687 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbfJYSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:46 -0400
Received: by mail-pl1-f201.google.com with SMTP id 70so2012247ple.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2S2DsvKndhCCCwXhy7APxIUiBul3NbHlVg5iB3GS6wI=;
        b=S1GOx2chJq005n3l26PE/OxzhX5C+hRjXWDeFhCkywyuslxoRAeqypOqIuChfSPfUu
         NA1KhxahOriQwx+Z0BGci3W2BvxgOZ4rdrGOZxI1SKIQSknC8epGu4qXsv/k893YtYdg
         WpOhSw/4+Afdl6vLLCjgFzadtYVTPJe27sil2puX6SEQfWnaOqwv913miQpe9jhpgNVP
         IwZ+wOOqqRJZaO2uGGzu2DukYz3QSOj4FjyMPSnCsMFkongN9d6l+UzyX9w+4bZESB6O
         tq6e2DSiaqb5XaJ+mIvS6WrlxxKexhmJKDP+A/AIzZiyYL3a3f8E1zVVOEwkFpBnODLK
         Q0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2S2DsvKndhCCCwXhy7APxIUiBul3NbHlVg5iB3GS6wI=;
        b=M5Ac6JwCv5dCSuRALHuizwaue4NpjEvGroZlC5LAkJWRg6K72BMvEWaN8q6mMqA2ld
         g72YolBmqPTJpTKIxPtDmnroYhC+2hIkXmFTCcAvirUET3Cpz4Nwe/kQBoq9femZCHEk
         x2XPV9A0SJMXDGv0cyYmqgCHHhGmXt2ofQ5i72klp5RLngwcV0SqjpT/BBSMjngT+TGF
         Amiw8bH6HrXwsrSh9jV4JcxyFB5n2jhbmB7d8H1/qhbKmZfvXGApEKR2lEPwWPP8L3PA
         j/gLAAFYK0GJSqBqEAZx64/9WAHQebVacYBnfOdlVqvMV1rebuu4IKJ/R5kybJQ2gN15
         +ldQ==
X-Gm-Message-State: APjAAAXwsk6H+EINewgQVmx/gmQPwYQ7nvrJb4zI65+zTswMLJD31HKC
        p3se38TzjhOMpYX3yT6uIc7tcPUpA953
X-Google-Smtp-Source: APXvYqwCiOCxWKogyeiMwYvwOtugEYW5dgD9xy0gca9fx0LItS/FqQFuYGbkyTwUtw9zrUcH6p/Wu4erFpVv
X-Received: by 2002:a63:e60b:: with SMTP id g11mr3770780pgh.119.1572026923546;
 Fri, 25 Oct 2019 11:08:43 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:21 -0700
In-Reply-To: <20191025180827.191916-1-irogers@google.com>
Message-Id: <20191025180827.191916-4-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com> <20191025180827.191916-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 3/9] perf tools: avoid a malloc for array events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use realloc rather than malloc+memcpy to possibly avoid a memory
allocation when appending array elements.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5863acb34780..ffa1a1b63796 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -689,14 +689,12 @@ array_terms ',' array_term
 	struct parse_events_array new_array;
 
 	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = malloc(sizeof(new_array.ranges[0]) *
-				  new_array.nr_ranges);
+	new_array.ranges = realloc($1.ranges,
+				sizeof(new_array.ranges[0]) *
+				new_array.nr_ranges);
 	ABORT_ON(!new_array.ranges);
-	memcpy(&new_array.ranges[0], $1.ranges,
-	       $1.nr_ranges * sizeof(new_array.ranges[0]));
 	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
 	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($1.ranges);
 	free($3.ranges);
 	$$ = new_array;
 }
-- 
2.24.0.rc0.303.g954a862665-goog

