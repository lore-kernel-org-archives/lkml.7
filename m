Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B55C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BAB21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPW9NjK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392625AbfIYT7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:59:38 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47323 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfIYT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:59:37 -0400
Received: by mail-pf1-f201.google.com with SMTP id t65so4663585pfd.14
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nSSSsCHQoO5MrGz/qVzfoHlRr3sXZuE5W1f65hgD98s=;
        b=WPW9NjK89aM5m4GLnGHjzhxbX08OMgdZp31NaUOc1Vash/wJDS9R31U+Xb9tczJkXP
         p5WarRaQoX9OT3q7FBAHAC5j6gSc8hvrH+oEr7ok/LqoXrsNuDdwyKDxZXC6o9uE9B/q
         FA2H6pzp2cisAaZh5OW1hB+COt/+6xQT9Nukki06GfCicFAKSmb2b99eZAkt7PNH3ldu
         V/rieCtpzwLQp+l+JJbTPjyy1/dRetdxj4PpAw1Ls3rKBwbmadZ4ygyPNT8+W3SnwUHv
         mCj9d7nTkZPLi3LR/FlOQl6Gk4WSJe3Ds2vsnVjH0/7y4dP1gKkMG8qp1or+UIwpcfoa
         upvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nSSSsCHQoO5MrGz/qVzfoHlRr3sXZuE5W1f65hgD98s=;
        b=CqrZY2Yz6a7x6aCz9KPX2kA2kbFAOt60ADyTuOxNPofC0U4KhrBuQsJ6I7QE1ftjTU
         rUA8LHRbsnwgO/goRztnwGJQgq90P3j5hfD8Ui0Pxc1xBofTLz1GTg6x6wcguEaurF/W
         5yn4Smj/YfHNFHZ97t/BiFYNvFij02MVyNz2x17NDSk1RWDMRuKErZezdFO9lrmkVsEZ
         Z33PsqJb/TbJ/JhbLoRQ0i3dWzNH3StniQRXkmYqEcvtdnssFBVrV371f6zZkWtWiv+e
         1U9NbzC6IgoGIFjqjcINhS6LyagoUPReuDbhvn7bUh7sP8NjYJaKrMawkL8O54WNQAv/
         XNRg==
X-Gm-Message-State: APjAAAUFaI8nnqLJP7Vwb0gfXBNjkW4Yv7lXGNEJm28zKvCHLfs3ibif
        3wUJ/BZCeQqVSewhVVHgfXOB84KTWGA5
X-Google-Smtp-Source: APXvYqzm76+RK5PwLaNfUmf7msNP0MHZo0N5d0IA9KndyRPIrHeIUPaFs8N1kYJo+yjbZozv46+2Vos0zZX5
X-Received: by 2002:a63:e511:: with SMTP id r17mr1115476pgh.374.1569441576756;
 Wed, 25 Sep 2019 12:59:36 -0700 (PDT)
Date:   Wed, 25 Sep 2019 12:59:24 -0700
In-Reply-To: <20190925195924.152834-1-irogers@google.com>
Message-Id: <20190925195924.152834-2-irogers@google.com>
Mime-Version: 1.0
References: <20190925195924.152834-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH 2/2] Avoid raising segv using an obvious null dereference
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

An optimized build such as:
make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-O3
will turn the dereference operation into a ud2 instruction, raising a SIGILL
rather than a SIGSEGV. Use raise(..) for correctness and clarity.

Similar issues were addressed in Numfor Mbiziwo-Tiapo's patch:
https://lkml.org/lkml/2019/7/8/1234

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-hooks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index dbc27199c65e..dd865e0bea12 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -19,12 +19,11 @@ static void sigsegv_handler(int sig __maybe_unused)
 static void the_hook(void *_hook_flags)
 {
 	int *hook_flags = _hook_flags;
-	int *p = NULL;
 
 	*hook_flags = 1234;
 
 	/* Generate a segfault, test perf_hooks__recover */
-	*p = 0;
+	raise(SIGSEGV);
 }
 
 int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.23.0.351.gc4317032e6-goog

