Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBF1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F172088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FT45OuHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfKTSJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:09:34 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:48471 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:09:33 -0500
Received: by mail-pj1-f73.google.com with SMTP id e12so65566pjt.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m+U1zAaIxdg9VzXauR+Zmx1TAKT0+Jtq+g8ufQj/Y54=;
        b=FT45OuHHnDSdkxKOJP+US9ACDoY9OhGIlZMTSCY5rFOGBKxwkNxJCefmIgoCxs5lTF
         RCuI2X5faDDjKEgMRVVqvD79NG2sYeObTm2HfwuwPzLrf3I+Sxq/Ogs5Jmjc0Rp5eCOQ
         eSg4RMZGV12cxy8dfeGCUI8KF+/7o1urCJkb5gWhTlKbzgr3EnCTbUxsQ4KYzw4Ftpca
         0c3T392+Yx+3RhNZ/1PnzuGUchaKdDd/kDzUolKIrLvDXrs53UnJmvRgHRtMfpLPdHXe
         IHvjljgLso5kXS1oRpYMVbQfjOFbXgTrs6Iedo+qMZuIlFjn0CXKhbBHd3LnMeKTFohP
         TMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m+U1zAaIxdg9VzXauR+Zmx1TAKT0+Jtq+g8ufQj/Y54=;
        b=uAjlbUmlNZC20937D5JQ0t/S0wQO6nrJ0xrQd8vYopmpS0wCpv213WEVZ8pyM+8vCN
         wA78A0GdkPJeaOFFn/EcZKuL41QGCmwGUlEGapZlMJWX9r8iln/VtmJNxtCI4HriTlkp
         SEIi3CRdAECXeSBmekABQ4dkvSDzmTrmioQYq1qxsja5W/VVsTiiVP8Kf/h70/CnK1nY
         3ub8phQmCjUwRcYOkeL2H0zYadBuaS0XtjQGC8dz0Ph4QyZXYV4Xc/Jxogs/Q8+n1/J9
         609oDztabV1BGCZyExy0qZkDHUCVtIbOp+FTkOXmyUWpFlpxLj+vmICSKCj5BpWRhy4D
         UDGg==
X-Gm-Message-State: APjAAAX/sK5i0vaqiLsxohZNfkgxqnhmniSaFttWWSuW0GzHkyIMphGK
        1QTnjnWuqcYuPK+IyBTVuSvHtdWLyXFi
X-Google-Smtp-Source: APXvYqzZ7I1pJmW6BAE1YfbZD7VB35tQSl0CfOi45J0LagAuyRVxOzLjYSVkfySeJ0cKMS0Yv1kggFOyZ7mz
X-Received: by 2002:a63:66c1:: with SMTP id a184mr4755320pgc.164.1574273372597;
 Wed, 20 Nov 2019 10:09:32 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:09:25 -0800
Message-Id: <20191120180925.21787-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] perf tools: fix potential memory leak
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An error may be in place when tracepoint_error is called, use
parse_events__handle_error to avoid a memory leak and to capture the
first and last error. Error detected by LLVM's libFuzzer using the
following event:

$ perf stat -e 'msr/event/,f:e'
event syntax error: 'msr/event/,f:e'
                     \___ can't access trace events

Error:  No permissions to read /sys/kernel/debug/tracing/events/f/e
Hint:   Try 'sudo mount -o remount,mode=755 /sys/kernel/debug/tracing/'

Initial error:
event syntax error: 'msr/event/,f:e'
                                \___ no value assigned for term
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6bae9d6edc12..ecef5b8037b4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -511,6 +511,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 static void tracepoint_error(struct parse_events_error *e, int err,
 			     const char *sys, const char *name)
 {
+	const char *str;
 	char help[BUFSIZ];
 
 	if (!e)
@@ -524,18 +525,18 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 
 	switch (err) {
 	case EACCES:
-		e->str = strdup("can't access trace events");
+		str = "can't access trace events";
 		break;
 	case ENOENT:
-		e->str = strdup("unknown tracepoint");
+		str = "unknown tracepoint";
 		break;
 	default:
-		e->str = strdup("failed to add tracepoint");
+		str = "failed to add tracepoint";
 		break;
 	}
 
 	tracing_path__strerror_open_tp(err, help, sizeof(help), sys, name);
-	e->help = strdup(help);
+	parse_events__handle_error(e, 0, strdup(str), strdup(help));
 }
 
 static int add_tracepoint(struct list_head *list, int *idx,
-- 
2.24.0.432.g9d3f5f5b63-goog

