Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1743FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAE72070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+IgsMnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAHOUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:20:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgAHOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:20:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so1652127pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u544TYKlKP+HlqPPdgbDDIkBZkVA5cDgelYhK98BAZ0=;
        b=U+IgsMnj6rkSh3PfmGvRFx6cvRHuYi+XYNlQo5C8i7GA/jgU6bQ9k1i0STeNwbWEdF
         og309iCMpI37t+WNo5Vx1S7tIvli5J9EQfN7iMpwIYQ2noRv7UiKQSmGI7tZ6fKLF/uW
         FlXSjpJ95z3tSdENcAaqBxNaPFPfJ1cAgL0U47/TnC57gKZbmV85xZH1N6fwmdZzXQmG
         IFfF1aQzzxW2pGYr33CgQ1dcnuCfgCdkdHDmvgos56Qaa5EHW7MNbuOwFKxpFGh8lJNT
         nKTWg6anfdPKN9LTggT9hTQW/+QwZboENsqP0SKGEHebvi6Cc/iTO/XDIt4AF+mmGcpV
         yzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u544TYKlKP+HlqPPdgbDDIkBZkVA5cDgelYhK98BAZ0=;
        b=okMewZ/Eebaa1KbKwEHW36r7CqltW1ArJPOll1bNZIMhB1S5thy3+v3ef397O40g3p
         xtrKInTGW1KfD+FVJd3VpPYt9BKKs1PFc7Q9ofqmZTz72T+iYfgqpM2Fe6k/2l/F0Pt3
         lWU0/Ab32eIfKwRxXGgjN3iwMC6R3Ba/Oz8/S/w2/FNiICkASOQjsn4rGF6AAKgftIky
         ux7LDuLBJp7TppSqct4XMteNr2zq1vqUcdUYgJBsyAkBSCENbBEezaU00UCYZ+RE6LS5
         lBrmMNvmio0cJropdCPTKHyiXz36pmyEo9uTWiZnNr/IZpRVM/mCxJEZuv6sndTkCI2N
         xwxA==
X-Gm-Message-State: APjAAAWlbkn25ov1CmdxPLbEHK3Hf3CxBrVBoxLtft1fdiDxqv+URREv
        UJ0oiEqElFHzaZ7uYpCKzMipLw==
X-Google-Smtp-Source: APXvYqx1fwHOK4iS/egLicKEdKsCMKdi21vy2KuUzlPNh9V6QlzeYlYq0LfIfM7IGqMU6a02BXAmIg==
X-Received: by 2002:a62:e411:: with SMTP id r17mr4981389pfh.119.1578493254423;
        Wed, 08 Jan 2020 06:20:54 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id a18sm3515054pjq.30.2020.01.08.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:20:54 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/2] perf parse: Copy string to perf_evsel_config_term
Date:   Wed,  8 Jan 2020 22:20:10 +0800
Message-Id: <20200108142010.11269-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108142010.11269-1-leo.yan@linaro.org>
References: <20200108142010.11269-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf with CoreSight fails to record trace data with command:

  perf record -e cs_etm/@tmc_etr0/u --per-thread ls
  failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
  directory)/perf/

This failure is root caused with the commit 1dc925568f01 ("perf
parse: Add a deep delete for parse event terms").

The log shows, cs_etm fails to parse the sink attribution; cs_etm event
relies on the event configuration to pass sink name, but the event
specific configuration data cannot be passed properly with flow:

  get_config_terms()
    ADD_CONFIG_TERM(DRV_CFG, term->val.str);
      __t->val.str = term->val.str;
        `> __t->val.str is assigned to term->val.str;

  parse_events_terms__purge()
    parse_events_term__delete()
      zfree(&term->val.str);
        `> term->val.str is freed and assigned to NULL pointer;

  cs_etm_set_sink_attr()
    sink = __t->val.str;
      `> sink string has been freed.

To fix this issue, in the function get_config_terms(), this patch
changes to use strdup() for allocation a new duplicate string rather
than directly assignment string pointer.

This patch addes a new field 'free_str' in the data structure
perf_evsel_config_term; 'free_str' is set to true when the union is used
as a string pointer; thus it can tell perf_evsel__free_config_terms() to
free the string.

Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/evsel.c        | 2 ++
 tools/perf/util/evsel_config.h | 1 +
 tools/perf/util/parse-events.c | 7 ++++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5f27f6b7ed94..6b56b35876e7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1265,6 +1265,8 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 
 	list_for_each_entry_safe(term, h, &evsel->config_terms, list) {
 		list_del_init(&term->list);
+		if (term->free_str)
+			free(term->val.str);
 		free(term);
 	}
 }
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index 4e5b3ebf09cf..12af1bca0cad 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -32,6 +32,7 @@ enum evsel_term_type {
 struct perf_evsel_config_term {
 	struct list_head      list;
 	enum evsel_term_type  type;
+	bool		      free_str;
 	union {
 		u64	      num;
 		char	      *str;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index caf38518762f..3353e9e8b134 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1240,7 +1240,12 @@ do {								\
 #define ADD_CONFIG_TERM_STR(__type, __val)			\
 do {								\
 	ADD_CONFIG_TERM(__type);				\
-	__t->val.str = __val;					\
+	__t->val.str = strdup(__val);				\
+	if (!__t->val.str) {					\
+		zfree(&__t);					\
+		return -ENOMEM;					\
+	}							\
+	__t->free_str = true;					\
 } while (0)
 
 	struct parse_events_term *term;
-- 
2.17.1

