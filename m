Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE61C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137DB206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdSeMBCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfGaWzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:55:01 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41903 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfGaWzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:55:00 -0400
Received: by mail-qt1-f201.google.com with SMTP id e39so62769352qte.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hB3975bQEe7YwXrrn5iDW2OoMeJHoR5KURbyU532I8E=;
        b=YdSeMBCyZ0r4DzoQMwnCQ1wx9jqf0WwmbrxkEfzpriBDmfR30zm/h9VvxwzaPWIdgh
         9Y5aVWzLejnq/01jJHAHvR8pX7uBTfv1puqXF0845M8DegCIEPpS5m8xuhcIKt/YdTxH
         uPDcsWRf210q7vfi6wIr4uSB2WNmPuAMCxa9OaIUN40V3cbqIe1JIw1Ejn0PGjsWY/9r
         U1cMv2C7YT+10swkIha0YcaBZ8OQL6pMcfBNuP6DNa+mEAZdrI3pKEBxq/03brEVNuvh
         dR8ACvAmS3ZBx3tQ5eHN8W3Yc5Q0AeRZwRVtbiyYvYE+95iKuVxo8jLVIoWMIc/SF4FZ
         iPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hB3975bQEe7YwXrrn5iDW2OoMeJHoR5KURbyU532I8E=;
        b=At/aaNmP9Mn5i7+QmB6G3DZxs06CrY3JmsgwksevvvQM8/0dITwGT1oByD0h+EmCv+
         Kdec9aQlou/5hqcJhclcz/Z730RWMs/YxBDXu3Y9i2HsLGmerdCNov1Z0Fc0z/jpgQ3N
         syVxvIVC16oOXsmZk7NnQovZCTaUCSwwtNPxIKNJiEXpX/+JL3mJufv+3cM1mMVkUGft
         bSyrRdZfWvYJPwAZPilFSUMBRY5If70f9ZTAQRa108Nzshy2dGw4eJ8ucvKvNhxt9YLG
         Dps6fYDZARP9lP3p/9wfe4UhmaSEElqmZkKLFwy1T8UwA3OnsduKzKyC0shCRjx7YanX
         6C0g==
X-Gm-Message-State: APjAAAXWeaoU0DK99bpyjOKRW4axWnpAEbPn5Ow/WNP42356iMqFOUI1
        eluCsjA+cM6+2dXZ6yNrhmIqAgAIfFDR
X-Google-Smtp-Source: APXvYqwVG3KEHT8g7KNGup7fwjPQDl7CveswbL8P1N1LZb5VA+F8y3W/5keImMR4XexImXWrqTggxVlDV62l
X-Received: by 2002:a37:bf42:: with SMTP id p63mr30497142qkf.437.1564613699322;
 Wed, 31 Jul 2019 15:54:59 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:54:41 -0700
Message-Id: <20190731225441.233800-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
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

