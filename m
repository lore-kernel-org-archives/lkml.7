Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D36DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147FF20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ACzNOSjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfJWAyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:54:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56183 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbfJWAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:54:21 -0400
Received: by mail-pl1-f201.google.com with SMTP id g11so11567823plm.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SBGZ2h3aJPS5SN0EQWSYu3r6PtBuafsgvwZrw927JEs=;
        b=ACzNOSjhSAZYiamU7+gIegPI+Q1tGEcVzOclcAta24FXA9bzre55G4jhXY4B3F/EOS
         QjXmegl3BtNi5CgWf0hg2RZOQ2b+hcfinMpmKHoXdCIjh5lbkoObioutFrR5TpzlGrOo
         GP6655uAvHe+yP1LlBKwQqzL0KsohokW/xV73/Wd/RGAtEXTl+a9YHAfpNU/Ne1cH8jc
         VwLRUe4ne6QB5+uskSqKMaTV7rNuhHDLUBhr+IIv4Ywo2id29V7e4aOQ4oR0Hky7wSD4
         y0bFFjYGzE6UcfyibUpAfmWf4HWqy1hZoJL62SZ7mpwM5AHN6TflHqfk8y0ynM6upPMB
         5HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SBGZ2h3aJPS5SN0EQWSYu3r6PtBuafsgvwZrw927JEs=;
        b=n3bIrLMumuLxw3XfUfLS9T+ZfN7bQEQjHXJFc8V7lxsPBaV9RL0NnEt2ObXe1FZ+Jt
         8Yr7H3DuarMs3Kdjt/IBL6gH8dgeQdBCo3bRzRsZeHn2SS+DYoiwqQyn7q+YMUG0jFpN
         YyD850DzelciFCnShvdC13aYbZz9TUfxHaRdsTBIyoK+RwT2LH8KcIPJ/0ZAfGUmzeQ+
         zkWfojVSI2CSr6WG1+JvGqC8EQixpHy0XuZekp27FdoUw+1hOCOGTQoNhsg91/2kgzqq
         3C6ltrkRg+U2cYrZuw/nI9JUemNAOP8VoJqjbM38AyA4BFRcEl0KMKCxzus87ju1b652
         lnug==
X-Gm-Message-State: APjAAAXZEyy0ghgsxMZBl6yfg+lwDYAv2YnAvbYV/PIOHuM1ihiizl6I
        Z3kwPwAO07zimHUNfNm/EK3oju4wGLPo
X-Google-Smtp-Source: APXvYqx2sTqLsUkmI521OZWxpQAAgcxz8e7uQh+AaUBQ+LvndCn6I2uaUNv4az8+K0JxYSw1RKpnpAIXu+7r
X-Received: by 2002:a63:fa4a:: with SMTP id g10mr6658099pgk.432.1571792059764;
 Tue, 22 Oct 2019 17:54:19 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:36 -0700
In-Reply-To: <20191023005337.196160-1-irogers@google.com>
Message-Id: <20191023005337.196160-9-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com> <20191023005337.196160-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 8/9] perf tools: if pmu configuration fails free terms
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
index f7c8d0853d71..6bf64b3767cc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1400,8 +1400,15 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
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
2.23.0.866.gb869b98d4c-goog

