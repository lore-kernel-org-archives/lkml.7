Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D179C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C552339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6b8aJX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbfIDSBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:01:16 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44277 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbfIDSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:01:13 -0400
Received: by mail-ua1-f73.google.com with SMTP id g19so1613712uaq.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hB3975bQEe7YwXrrn5iDW2OoMeJHoR5KURbyU532I8E=;
        b=j6b8aJX2+AM7wrmVWiG+1fBH3wBs4G7vlhLs5djzluKf1lh+aDFRF0DMqvpeYk7+N4
         NWTrFarLNMYotaTdV8+vHMyUHu3u6e/VrZO3+F9Ej2OgFoJrTfiP0YoPYSpH1YHOsv8z
         E2HTiEOcRLPiX/OHLjxMn/5GFOMG1TrT9IxVAF0V06mOiD6zz9IyxSdlkNkrX4feJkzG
         67IYNwK0B55+dyhjwdRNdAbIzHB0fQWFk78352Q5stGVPa7ofrtHOQU6t3kUVpP5WwO3
         d32chlFQfIremRbEW84FjjFPwHhLKRnsAIrAxqe00Z1u0CR823dkMmdoPgruB+44nR9s
         /8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hB3975bQEe7YwXrrn5iDW2OoMeJHoR5KURbyU532I8E=;
        b=gXkaXAuCQUyR0moU4quM/xSAiOIK9Tl4dOKdktfazEPAo/JmtzXq28LaIXtrbmZnBd
         Jn3sKbWfx0r8Tz0++BuJB4V2SHcX839o2JfUXCxEle51akjZEwbUYL2qcorVZYyGm2qG
         TI/K+03qcTc9d4/uulqMPTjm3VH2LmRaRAHIA+L9EDbPLVcI0uQcbtuat6R5hlq/AiYF
         dt0iJ6w3Co3FggSjJTNqK2yk/G4wmlNHlU1sF1HZSDPi4Ig4omudZfeCC0rPxHsn+aFV
         ZqYnIMOoE8qmnJoYCZS579Wjh2LJICfo6IsPbSmxy3E3a4fJUJnul9TBSfbmvnq7CeBT
         6qGg==
X-Gm-Message-State: APjAAAXt5prAwv90VM544tk23P2YETWLjlsmALxnkXNEa9lcOt83I1Fz
        xVMDZko67H+p1uz5xeP4OLNjyUjx9KJ0
X-Google-Smtp-Source: APXvYqzjwKtiv/1+0t4qQYpQXzR295bpi01G2uz1AA5oIHglW2/SsuxkeOjLPLYIKpdXnjT89djQWtlcLXvx
X-Received: by 2002:ab0:2412:: with SMTP id f18mr7710005uan.53.1567620072442;
 Wed, 04 Sep 2019 11:01:12 -0700 (PDT)
Date:   Wed,  4 Sep 2019 11:00:45 -0700
Message-Id: <20190904180045.138513-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] perf tools: Fix include paths in ui
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

These paths point to the wrong location but still work because they
get picked up by a -I flag that happens to direct to the correct
file. Fix paths to point to the correct location without -I flags.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browser.c      | 9 +++++----
 tools/perf/ui/tui/progress.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index f80c51d53565..d227d74b28f8 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../string2.h"
-#include "../config.h"
-#include "../../perf.h"
+#include "../util/util.h"
+#include "../util/string2.h"
+#include "../util/config.h"
+#include "../perf.h"
 #include "libslang.h"
 #include "ui.h"
 #include "util.h"
@@ -14,7 +15,7 @@
 #include "browser.h"
 #include "helpline.h"
 #include "keysyms.h"
-#include "../color.h"
+#include "../util/color.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index bc134b82829d..5a24dd3ce4db 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../cache.h"
+#include "../../util/cache.h"
 #include "../progress.h"
 #include "../libslang.h"
 #include "../ui.h"
-- 
2.22.0.770.g0f2c4a37fd-goog

