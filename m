Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB020674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDLmVjSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfK0S3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:29:04 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46697 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0S3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:29:03 -0500
Received: by mail-pl1-f201.google.com with SMTP id q19so2937916pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ag1CweCpiGJOsd3uy7niWtpeO/fNwRX/MteCEVka3+Q=;
        b=sDLmVjSFflZpw9puobFFAwUcgysskee6REyfYH0oK962cXdNYlbdy2tg4aKYUurjEl
         Z8+RFHkOXrwciKHXonylhNvZLT436vHk41y/A42IoqxZKUcqmAg8bunE56DMACK7Nmli
         j5W0ukFc8iMBebN0Rp12VHHSww9rGsV0tDyeFfVSyglRNBoUtmsnoph4UWlrccUAtV0O
         BiUfNrwyHurhBa6koeOTNxFJUSuQgL4YIfRKjh3dNBXnczE+v0WP5w/Uhd4rRIRsoePx
         QEPIo15f39weSR0CHeVChlu7cdcnj5zhKpHqiqbrFbGvxHQeAZRRcJZi0aRbYJ5VDo3E
         mpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ag1CweCpiGJOsd3uy7niWtpeO/fNwRX/MteCEVka3+Q=;
        b=DQklnIm6CTR+oCqsOzmJinL0do0xxuBG/Sw0eR/nOUVwZakp4r9bOTHLuGgqyiQEda
         lHCBggJRIkxyjB989DtvurUDvK0BhcPvvMyDVIninyYZKUv+yh86PusMJHvYTRn0FgLu
         1xHbzCLeKsuz5ml9BxPrcU94MvCG7KC5jfmtT7K95A58zNE7ymrs/VoSvyvF4GfWXzwm
         VIGtbwiRc7LfkzIUi7iLtLelRO0BJ1GlZTAsLA0B9assVrFv7aW1G5/pX69DPS3YNJLu
         5smstWvpXCBiTFRGsFR9VEpN78owX9FhJ9h7MHFR+vWFK+I10VQ/sIKk0PUmrmOn7EKS
         NArg==
X-Gm-Message-State: APjAAAV2eGU4geWYTb26cgVTgOCTN0NtmOADbcRzHhnEzTHE5MnFrQQe
        E5D8syJCuZoIGVV7RQBDC2g0dgatIMYQ
X-Google-Smtp-Source: APXvYqzJNj2orieX1dXFci6fK3LqofTW1PgPVbfoqLTDwWjWGHKfQ9uScmaoK0+ec1FA+7AmoM2zJPy2gBzQ
X-Received: by 2002:a63:1916:: with SMTP id z22mr6648286pgl.206.1574879341314;
 Wed, 27 Nov 2019 10:29:01 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:28:54 -0800
In-Reply-To: <20191127073442.174202-1-irogers@google.com>
Message-Id: <20191127182854.56755-1-irogers@google.com>
Mime-Version: 1.0
References: <20191127073442.174202-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v2] perf c2c: fix '-e list'
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the event is passed as list, the default events should be listed as
per 'perf mem record -e list'. Previous behavior is:

$ perf c2c record -e list
failed: event 'list' not found, use '-e list' to get list of available events

 Usage: perf c2c record [<options>] [<command>]
    or: perf c2c record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. Use 'perf mem record -e list' to list available events

New behavior:

$ perf c2c record -e list
ldlat-loads  : available
ldlat-stores : available

v2: addresses review comments by Jiri Olsa.
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-c2c.txt |  2 +-
 tools/perf/builtin-c2c.c              |  9 ++++++++-
 tools/perf/builtin-mem.c              | 24 +++++++-----------------
 tools/perf/util/mem-events.c          | 15 +++++++++++++++
 tools/perf/util/mem-events.h          |  2 ++
 5 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index e6150f21267d..6ab03e04c925 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -40,7 +40,7 @@ RECORD OPTIONS
 --------------
 -e::
 --event=::
-	Select the PMU event. Use 'perf mem record -e list'
+	Select the PMU event. Use 'perf c2c record -e list'
 	to list available events.
 
 -v::
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f44941aad..193d6a04f61b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2874,8 +2874,15 @@ static int parse_record_events(const struct option *opt,
 {
 	bool *event_set = (bool *) opt->value;
 
+	if (!strcmp(str, "list")) {
+		perf_mem_events__list();
+		exit(0);
+	}
+	if (perf_mem_events__parse(str))
+		exit(-1);
+
 	*event_set = true;
-	return perf_mem_events__parse(str);
+	return 0;
 }
 
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index a13f5817d6fc..c796bc08abb7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -38,26 +38,16 @@ static int parse_record_events(const struct option *opt,
 			       const char *str, int unset __maybe_unused)
 {
 	struct perf_mem *mem = *(struct perf_mem **)opt->value;
-	int j;
 
-	if (strcmp(str, "list")) {
-		if (!perf_mem_events__parse(str)) {
-			mem->operation = 0;
-			return 0;
-		}
-		exit(-1);
+	if (!strcmp(str, "list")) {
+		perf_mem_events__list();
+		exit(0);
 	}
+	if (perf_mem_events__parse(str))
+		exit(-1);
 
-	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		struct perf_mem_event *e = &perf_mem_events[j];
-
-		fprintf(stderr, "%-13s%-*s%s\n",
-			e->tag,
-			verbose > 0 ? 25 : 0,
-			verbose > 0 ? perf_mem_events__name(j) : "",
-			e->supported ? ": available" : "");
-	}
-	exit(0);
+	mem->operation = 0;
+	return 0;
 }
 
 static const char * const __usage[] = {
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index aa29589f6904..ea0af0bc4314 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -103,6 +103,21 @@ int perf_mem_events__init(void)
 	return found ? 0 : -ENOENT;
 }
 
+void perf_mem_events__list(void)
+{
+	int j;
+
+	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		struct perf_mem_event *e = &perf_mem_events[j];
+
+		fprintf(stderr, "%-13s%-*s%s\n",
+			e->tag,
+			verbose > 0 ? 25 : 0,
+			verbose > 0 ? perf_mem_events__name(j) : "",
+			e->supported ? ": available" : "");
+	}
+}
+
 static const char * const tlb_access[] = {
 	"N/A",
 	"HIT",
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index f1389bdae7bf..904dad34f7f7 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -39,6 +39,8 @@ int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i);
 
+void perf_mem_events__list(void);
+
 struct mem_info;
 int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-- 
2.24.0.393.g34dc348eaf-goog

