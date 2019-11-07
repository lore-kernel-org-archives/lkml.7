Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A635C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4722166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrQORgPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfKGWPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:15:09 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46566 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfKGWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:15:04 -0500
Received: by mail-pl1-f201.google.com with SMTP id a5so2684724pln.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AdCqemr3Cpf7H//3sUI2jx4nwjMA/tcTnOzbDM/nvC0=;
        b=jrQORgPzeZELMCAxvGhKK+LNKIHx0lR7EPWzROuGYaZ+8MQcE47ixHonnM93zYy6Bb
         nqX5lHMzBwuMZf0i1kUDabzHy8kdEY46PjxcAApEcS91vHsUB6MfoINBzDy2G4B5wHaR
         HoXGNztVqF4MNmFNLonRL2ICkbGLFEhkXxnmnsKhAZyejQg+RxxIiKY7wNzIIewoeyCq
         THAE+F2X5AyEIIUIWWoU8vmV7zRhdAMlzpBlaCPqBwkFWjmJdNttL/Tlsua/9W6NL0JO
         f51/JAkOljq+y3t/Fd5eL9Rf/ZbXtyvMoyjb0iBJ/vFzTQOG4qe1MRJAyPoRNrzWYIp5
         rs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AdCqemr3Cpf7H//3sUI2jx4nwjMA/tcTnOzbDM/nvC0=;
        b=SpFRzg/yqJuYSba8e+C8St1QLx7Ank53Uj7WNv24/X/21Jk+n0TKdD5eCbY2O7IKvV
         StzZwxVBflB97Vw+biF6FLhe739QKtpIERmkzZqXCEDtzkJq+SOWLgzvNMw2qqBqoF/N
         ed1VOcjJI9JAHmrWa2e0Z5nFcr7/EZTmMnguqEM3Vt6XPkK5094YaYEajz2oy8C7KiQo
         gDWcF6+ExVtQ6QDBWRggvTgedg/hkyXMHPGvT8Z7Y2hpnPgAoIOTdZ6Q0Qlw5RZbbhgj
         6q55Vzq1U5TA+CMFhd44XKGeZgPeSjFojBZ00b6dne//O1gBjYXuoKThvBxmydv+Jdjn
         lAUw==
X-Gm-Message-State: APjAAAWcvwgzha0rqlXnQa3NKy8W6jcu93TVyGXylQd0sYMvAS9OdcHs
        12GKfvCejZbtWAVuqUqfrniDq+EAcXUM
X-Google-Smtp-Source: APXvYqz/rkI814x4MOw4cAa7e4QfcUS64HmMtxPkZptIuD8Y+rQW1uOQ0spijoWFfSm8En8eJae60a5ns/vv
X-Received: by 2002:a63:5848:: with SMTP id i8mr7445484pgm.217.1573164903292;
 Thu, 07 Nov 2019 14:15:03 -0800 (PST)
Date:   Thu,  7 Nov 2019 14:14:26 -0800
In-Reply-To: <20191107221428.168286-1-irogers@google.com>
Message-Id: <20191107221428.168286-9-irogers@google.com>
Mime-Version: 1.0
References: <20191030223448.12930-1-irogers@google.com> <20191107221428.168286-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v6 08/10] perf tools: if pmu configuration fails free terms
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

Avoid a memory leak when the configuration fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 578288c94d2a..a0a80f4e7038 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1388,8 +1388,15 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (get_config_terms(head_config, &config_terms))
 		return -ENOMEM;
 
-	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error))
+	if (perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
+		struct perf_evsel_config_term *pos, *tmp;
+
+		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
+			list_del_init(&pos->list);
+			free(pos);
+		}
 		return -EINVAL;
+	}
 
 	evsel = __add_event(list, &parse_state->idx, &attr,
 			    get_config_name(head_config), pmu,
-- 
2.24.0.432.g9d3f5f5b63-goog

