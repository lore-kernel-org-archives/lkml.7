Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444332087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrSETiRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfJ3WfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:35:08 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44920 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfJ3WfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:35:05 -0400
Received: by mail-yw1-f73.google.com with SMTP id e2so2849636ywc.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O46qQh0NfSafqZOQ3RB2bA5TlgUNmGeU07O7S2mDmp8=;
        b=CrSETiRqHMQOjdJ2lCCBT1pvusZ8sr35GXcohgUIb9pSfaqD9joqRIt248vJFuJbRn
         Vo/8A89RlQMQyyw7p0itwye5sPZNGqaR6KYv2mrmxYxgyzU5CzhJyaJEv5Z9hCpQXEM5
         pU4tszddJsg2nDsmH9PEDvoJYMaMWgm8UPpKIornmNUdfmMNvW7eR8KzZM1jPlI3nnSz
         yhTxFqGUhGL5nyUgJwuEdiShi101PN6is0peh5f5Ms+MLom82m8fBaJPrR+FW3gnhEF0
         z0ik5ClTfj81uwC34dQf42MrKwhBjUvsgJbS/OYcBWgpdn80siccizLp/y9mTyEsRamc
         ZSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O46qQh0NfSafqZOQ3RB2bA5TlgUNmGeU07O7S2mDmp8=;
        b=WtyImgnE9SNf+ok4+QKxFBNJan9Cl2NvILg69WIrkOP36/53muvId0JBtaHriegTb+
         A/DWsfmrxgCQemYEZZfTqewFvHRYbXb9qV+ZY1wXDYEaXafWw7K9gI3yG3Qugcmnnfzp
         qvBk2twQkDZhrxnefR8Ycj5McoQoSXL7n9Moz4vKz8Qzx19tyLDgbKGZM5AXH74cwRr9
         tViM8ndxWRtSMEc7sgqFTxVDIZLJ9HVW3b9BU4ARC0P1wSnEu+uzXTQgM8uZiIlTyJG6
         mgX0tY1MA9lPp3Tme+BRu5oBjd04exG4TjiPLeiHmW1dmW6BgcHc7fPBnvmVHMY2+MuU
         5/JQ==
X-Gm-Message-State: APjAAAUUDlFpGL/WiBe4KmdpfMk2MpOTtJo2AhBX5NKGLT/B6/092RJT
        alBIG6N9DrhrGQ56RfBGk5O8B3BrCvtd
X-Google-Smtp-Source: APXvYqzX3t2nUPQZVTOUg6iHaQA+sKWtzQICOwxNqxdMb2uq625C2MYcu4zfy22ADO3aYpTWbjATa7LM2Bla
X-Received: by 2002:a81:4948:: with SMTP id w69mr1570034ywa.404.1572474903817;
 Wed, 30 Oct 2019 15:35:03 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:34:42 -0700
In-Reply-To: <20191030223448.12930-1-irogers@google.com>
Message-Id: <20191030223448.12930-5-irogers@google.com>
Mime-Version: 1.0
References: <20191025180827.191916-1-irogers@google.com> <20191030223448.12930-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 04/10] perf tools: splice events onto evlist even on error
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

If event parsing fails the event list is leaked, instead splice the list
onto the out result and let the caller cleanup.

An example input for parse_events found by libFuzzer that reproduces
this memory leak is 'm{'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e9b958d6c534..03e54a2d8685 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1950,15 +1950,20 @@ int parse_events(struct evlist *evlist, const char *str,
 
 	ret = parse_events__scanner(str, &parse_state, PE_START_EVENTS);
 	perf_pmu__parse_cleanup();
+
+	if (!ret && list_empty(&parse_state.list)) {
+		WARN_ONCE(true, "WARNING: event parser found nothing\n");
+		return -1;
+	}
+
+	/*
+	 * Add list to the evlist even with errors to allow callers to clean up.
+	 */
+	perf_evlist__splice_list_tail(evlist, &parse_state.list);
+
 	if (!ret) {
 		struct evsel *last;
 
-		if (list_empty(&parse_state.list)) {
-			WARN_ONCE(true, "WARNING: event parser found nothing\n");
-			return -1;
-		}
-
-		perf_evlist__splice_list_tail(evlist, &parse_state.list);
 		evlist->nr_groups += parse_state.nr_groups;
 		last = evlist__last(evlist);
 		last->cmdline_group_boundary = true;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

