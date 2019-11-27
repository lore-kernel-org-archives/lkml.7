Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8392C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789262053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT/9FzXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfK0Hex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:34:53 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41210 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0Hex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:34:53 -0500
Received: by mail-vk1-f201.google.com with SMTP id a17so10107604vko.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OlY6fp4GnRqHjQOCRT6PaMt8F1GqmDxHR8fe14B/Pso=;
        b=TT/9FzXSX64x0gmnOl3hXh0yWEFaBv377D8QkRQEzjyhdv4lyr+KrF6HqUi0h1Y2wO
         jQzum9n7mdKKFjadRkU9g8aaw0IY7LGfk+AY8ZXBa6YSkCP082TswGkyWi6FHL5yJIVX
         twQWsCfPlbDdt8UZVUdwOJD2SM4fXMeYKYagW46fNqYS76uRJmQDZZT9UmWY0gz7vrAE
         +m+PYnqqG0lu+YgxG1UXTDnD/3RCziULr2KrgfOKxfh70fwGKThDANs2Mo4zqYHS0bIF
         A4bFQelZ0fdHVdScI2tZxQwVxQsQSXNMXiG+D8zulL2M/HLpBhDHw493VcUwhXChXO7c
         RiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OlY6fp4GnRqHjQOCRT6PaMt8F1GqmDxHR8fe14B/Pso=;
        b=GIZFuC1kqX+bzNGaPG+rC7stvrpcxy6IKpWaFGCN3PHrUQGxyf6C99RFvyDjNMiRpH
         36ysJ2Yzl10jnDM18ZzjLarrmMQLP3J2VLYEuK2xKHQNXZLWDW8OuaiREFkpkXjVIx5D
         6AQ+MGVqKAEh76vCexE9GYC/CeqH36qCXIucMfOatHvQ2MCYDedtPyKRf+mrdrzlGGru
         bijkLQs6iIdtroCXYVagAPTN3p4dNGwgMhcrjRttwwY+ztPFN4jRZSa0aVqDjSw4XkbC
         y9dvtv+IjXdzcTbLbhEQmS0RhmDiK9/xNmYtUJpWm9uIieMlo5TZ16tUEBZVo6gWaZPp
         Xahw==
X-Gm-Message-State: APjAAAV32Ij0r3vxtGP+xCooatJUK5idI+UOWkq9RuyX8ROmvNdRJPkP
        nm3FmWaE/vnAo2aY+lAwl8CoDi+URxp8
X-Google-Smtp-Source: APXvYqzVZEb/Qe9M/V3TOzWXU5w6CdEWsYEqpjI5F1x4OIceM8E6OuGN3Cqeg7sgNYFHUljPT/CGubJ61+C2
X-Received: by 2002:a1f:1897:: with SMTP id 145mr1780599vky.47.1574840091762;
 Tue, 26 Nov 2019 23:34:51 -0800 (PST)
Date:   Tue, 26 Nov 2019 23:34:42 -0800
Message-Id: <20191127073442.174202-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] perf c2c: fix '-e list'
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f44941aad..dd69cd218e4c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2872,10 +2872,26 @@ static int perf_c2c__report(int argc, const char **argv)
 static int parse_record_events(const struct option *opt,
 			       const char *str, int unset __maybe_unused)
 {
+	int j;
 	bool *event_set = (bool *) opt->value;
 
-	*event_set = true;
-	return perf_mem_events__parse(str);
+	if (strcmp(str, "list")) {
+		*event_set = true;
+		if (!perf_mem_events__parse(str))
+			return 0;
+
+		exit(-1);
+	}
+	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		struct perf_mem_event *e = &perf_mem_events[j];
+
+		fprintf(stderr, "%-13s%-*s%s\n",
+			e->tag,
+			verbose > 0 ? 25 : 0,
+			verbose > 0 ? perf_mem_events__name(j) : "",
+			e->supported ? ": available" : "");
+	}
+	exit(0);
 }
 
 
-- 
2.24.0.393.g34dc348eaf-goog

