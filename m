Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF162C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5FE2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TBhQiV2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407003AbfITXEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:04:23 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44411 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404344AbfITXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:04:23 -0400
Received: by mail-pf1-f202.google.com with SMTP id b204so5730249pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5CW8doTfN0jqcSdKfn2ajplx2560aHluoBdOqTHKwzw=;
        b=TBhQiV2/lvaPXxRNhitN3eKFuLJoAQ74ivFJwziRr7zccuw9rmNDUIkw1AwdkVIyKJ
         8UcmC1okVCHLi6r3HAdpumWVii+RZHX/nQZ85n431JEd49O/yWtwAkpp4rmgNbCYAOer
         T6Y2R92tY8ODCFHTlJ1VbN0+At+8THF6dd2o2L0h7TFq8qlmkWy2SXmkoiOmp+rgjDMQ
         46+bAJ6nnEY4Q/SVNFC028IT7G3xCA7T3vIlKP17xX2cYYRunw2TG2kFPGchefX6G6hZ
         u9vY7TrWne6mU0gdYMYjj70l1FxzxWVPOSO6UMe/UebaiwED44B+uRpKfO8qmC0LDNGq
         XBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5CW8doTfN0jqcSdKfn2ajplx2560aHluoBdOqTHKwzw=;
        b=Egk0RIOITriyIqDQhZNTv7BoUH4zCPAY4BmpkjdSy+pPv3+JxJvf91byvdz606UdQe
         n2baudelGviwwTVm4oak0GXqQZwhefNekRBYO+h3Ers+3d8Q/ND015qSxCss9HH1KZFo
         p6X2wbf0FCgD9msuGocwccE6NRDsXiEbc2jqgaNUPsP2Mi5+Q0RR7zD0ACxwULSxAaeR
         MDP4Hf0IMGy96AsgwMqkwoCysxmiI0z40Nl2QCc8hnaHQJSnHI0jSHSkoCkP0aSD1XAi
         2w2LEWZ4Q5jhh81p6AHq8ZmvWfQFaPh2H2HhB7+7zdMCxfC54530N8oevgmqig1HDW3l
         NloQ==
X-Gm-Message-State: APjAAAXKPk4CYMf0ZL5X5/uT2sBwtrtnZE7c6ipxeAxiELYwR9qEkvgm
        EDgJfXYkTQvCPFdcNAUq+Urk4vkEEAjD7DItZavilxBdyx3fQZ+TzOAZQn/zzQQZS6czqjZutb7
        7PB4PzuVy6yaG7rT4/+eHDLE6X5tJN1lmkX8HTjxPPD4fuXAW2E94hRGt/PPs3jYOcN82puDQ
X-Google-Smtp-Source: APXvYqylD1pwnyxaGfdp+Tla9FMZ6YorG+qx7fuzQpE82uu3ToQTS2PYRlvBnbxHM1dMRZhz2xaykNFuAcGU
X-Received: by 2002:a63:f1c:: with SMTP id e28mr14088555pgl.360.1569020662080;
 Fri, 20 Sep 2019 16:04:22 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:03:56 -0700
Message-Id: <20190920230356.41420-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2] perf record: fix priv level with branch sampling for paranoid=2
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the default perf_events paranoid level is set to 2, a regular user
cannot monitor kernel level activity anymore. As such, with the following
cmdline:

$ perf record -e cycles date

The perf tool first tries cycles:uk but then falls back to cycles:u
as can be seen in the perf report --header-only output:

  cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
  event : name = cycles:u, , id = { 436186, ... }

This is okay as long as there is way to learn the priv level was changed
internally by the tool.

But consider a similar example:

$ perf record -b -e cycles date
Error:
You may not have permission to collect stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_SYS_ADMIN).
...

Why is that treated differently given that the branch sampling inherits the
priv level of the first event in this case, i.e., cycles:u? It turns out
that the branch sampling code is more picky and also checks exclude_hv.

In the fallback path, perf record is setting exclude_kernel = 1, but it
does not change exclude_hv. This does not seem to match the restriction
imposed by paranoid = 2.

This patch fixes the problem by forcing exclude_hv = 1 in the fallback
for paranoid=2. With this in place:

$ perf record -b -e cycles date
  cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
  event : name = cycles:u, , id = { 436847, ... }

And the command succeeds as expected.

V2 fix a white space.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 85825384f9e8..3cbe06fdf7f7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2811,9 +2811,11 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		if (evsel->name)
 			free(evsel->name);
 		evsel->name = new_name;
-		scnprintf(msg, msgsize,
-"kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
+		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
+			  "to fall back to excluding kernel and hypervisor "
+			  " samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
+		evsel->core.attr.exclude_hv     = 1;

 		return true;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

