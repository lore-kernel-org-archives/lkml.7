Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B223C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 07:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5921882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 07:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4YCQS8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfKIH6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 02:58:50 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48338 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 02:58:49 -0500
Received: by mail-pf1-f202.google.com with SMTP id g186so7138268pfb.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 23:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h7jObktrxG+0x3G8IDmsBGlvurAfvaMIXARQsuJxisQ=;
        b=B4YCQS8bVGBslnJy/b21ewNjCU1u5gr2VNF0whhAnKXjM/22OUr53IElOVBK0IsCCO
         00jb+TvgBhGmQ0iUWoN4lApl/KEKhMAglpHDgKrpBJ5pFruAh6aYQTNJncX7xckk/Ki7
         xuGjLBj938Ikpsag1RnLkFLhoeGK3NcWg1rWm/hF3pX9oBdVs3Bj28u2G5NaOAZCRE5x
         AblTZEWDlbr+ob/YWrKhnSTv7tkM2lQJkdwzCeroyQKEGFCx4RUFVvvXeiQpSKuzNpZq
         /d2OWFMn67kKvw9FT9ikvQfGuE0L+GBPm/H5JPa7c/CXMuQbonNnM0Ze7/rcw2l5cvI7
         6nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h7jObktrxG+0x3G8IDmsBGlvurAfvaMIXARQsuJxisQ=;
        b=JZbNQw6OfL71QPpvug7Am9oJdZQZ+LAXF3ruWyIssfB1TBEweO0sFKyX+XL/cM9gXs
         xIvh/ser6wOGVhZGw3oeeKrKVP3kgjguOup7lKJ2R+v2PflfBiBtIe2wo/+XbdBVzfBN
         xpAFhvmPQQdwXAfdZWxRIgHz9/ZrQiq3H+2I9ZyHHwPiH8kLXrlYsJCgUFnNo68R/I/J
         X559PRlC0DgOjW4W9Gn6IWfnGgSxNtMwTOHpaPoijt+WfFec1ItxZMxJP/Ip2zinojjj
         dfe/suc6npVAvRApj8k5Gkqy1ha92DrJonzNoh/jt9RyiC3vumKoZh1+Pfl6brEgVwh0
         04zw==
X-Gm-Message-State: APjAAAV0w5OZpzNsREdaXS0PqKj6Vy2CQexd8sxg0yN9S1wZ4u3A7MOl
        ePG5PN3nMZzq0cZ2Cb0Oja6vbZIgXyaI
X-Google-Smtp-Source: APXvYqwM++3oJMdm7IvHNpNnHUy6SVOeUNf0mBc0vgS9idyCJKrPzzeuxTmKz053rYSyf3Sb7/LE89mJ/4PU
X-Received: by 2002:a65:64da:: with SMTP id t26mr16635725pgv.180.1573286327073;
 Fri, 08 Nov 2019 23:58:47 -0800 (PST)
Date:   Fri,  8 Nov 2019 23:58:40 -0800
Message-Id: <20191109075840.181231-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] perf tools: address 2 parse event memory leaks
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using return rather than YYABORT means that the stack isn't cleared up
following a failure. The change to YYABORT means the return value is 1
rather than -1, but the callers just check for a result of 0 (success).
Add missing free of a list when an error occurs in event_pmu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4cac830015be..e2eea4e601b4 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -284,6 +284,7 @@ PE_NAME opt_pmu_config
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
+		free(list);				\
 		free($1);				\
 		free(pattern);				\
 		YYABORT;				\
@@ -550,7 +551,7 @@ tracepoint_name opt_event_config
 	free($1.event);
 	if (err) {
 		free(list);
-		return -1;
+		YYABORT;
 	}
 	$$ = list;
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

