Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A06C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69BF20659
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEx0zUe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfGSUXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:23:08 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:44213 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbfGSUXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:23:08 -0400
Received: by mail-yb1-f201.google.com with SMTP id w200so15242594ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nd7na4u6hbizR6uAegpt+Plqr52QAU8/GnshRLqNaeY=;
        b=TEx0zUe27ionarvWLgmu0t1DbFCPlBQ2k4PhVk9j1IEZS6zASmDTpB8co/e4gesSpq
         Xxt07/iUwl07JXDLsKxLSyTQ6byotf48XWsPb0EoBfiN7XBWXwtnnsSfmpjzIZndS00U
         c/woi6uvYA00LfhAk7yEZsG+e1jrGBy5UKZ6sEyDSHg7GuflGq+sKGAbCZzm1eY8eaOV
         vqH/2893toutBnb2gSlsQpZ7MvwTEmj71ckn5M5uKKkySm9W09U+rInG8A8hxKsvoOVV
         Br6tSJkMEsqwuoDROTB2Iu/44q5oJRFjQuDCmE4cHBasSRZquTmb1udusRatDMmgRK1W
         jwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nd7na4u6hbizR6uAegpt+Plqr52QAU8/GnshRLqNaeY=;
        b=lPQN7UzXykBQ7MFR4LmzXbVIlNmYTggSMvfs0PfHqU2w3d3px7J6kr0Fudsekmv/TB
         7tBf1fM8shzMoY7GRyg9/5qE1yJT6bUqv05pWmY2a7m/Sl/fZV0w4yZmz5Uhv6jFo9sH
         uHd9lfL4NCVmS/bZJAmBuTsnfcpS/W/mkVYNJXBtkjL9cVm7DPcA1ZL24hgarcOfWt+B
         AgIyJ03BU4mg0vA7c7i7zZhhiSE/0rb51LN0+0MDeTkKswH/Zb5FdgVZfXkQt44uaMxQ
         NVciXSEoRoB0qY9c2gPTFhB3ZjvuUyIPqzIb+l1hEtV/ivUdIvfaXwMF6U3ynqTvwkct
         1Vkw==
X-Gm-Message-State: APjAAAXqI/uGHzIUI1o1k1WMDvL2YXk/DVHQ+jV1gz+rgpUasx4xfI+P
        zdzO1ZI61Ds5mlNwJvYHd0rAPu84W03FtLk5
X-Google-Smtp-Source: APXvYqy73Y98QngmgtKIhEGfjBwpdDWn3QFhV5nfj8xJtepLIPPF/nr4pUAX16YeBr5x0XwQN1DTD6Gb2Ua4em8V
X-Received: by 2002:a81:5e57:: with SMTP id s84mr30901271ywb.244.1563567787331;
 Fri, 19 Jul 2019 13:23:07 -0700 (PDT)
Date:   Fri, 19 Jul 2019 13:22:53 -0700
Message-Id: <20190719202253.220261-1-lukemujica@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH] perf tools: Fix paths in include statements
From:   Luke Mujica <lukemujica@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Luke Mujica <lukemujica@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These paths point to the wrong location but still work because
they get picked up by a -I flag that happens to direct to the correct
file. Fix paths to lead to the actual file location without help from
include flags.

Signed-off-by: Luke Mujica <lukemujica@google.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 4 ++--
 tools/perf/arch/x86/util/tsc.c      | 6 +++---
 tools/perf/ui/helpline.c            | 4 ++--
 tools/perf/ui/util.c                | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 865a9762f22e..3f84403c0983 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
-#include "../../util/kvm-stat.h"
-#include "../../util/evsel.h"
+#include "../../../util/kvm-stat.h"
+#include "../../../util/evsel.h"
 #include <asm/svm.h>
 #include <asm/vmx.h>
 #include <asm/kvm.h>
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 950539f9a4f7..b1eb963b4a6e 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -5,10 +5,10 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 
-#include "../../perf.h"
+#include "../../../perf.h"
 #include <linux/types.h>
-#include "../../util/debug.h"
-#include "../../util/tsc.h"
+#include "../../../util/debug.h"
+#include "../../../util/tsc.h"
 
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 			     struct perf_tsc_conversion *tc)
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index b3c421429ed4..54bcd08df87e 100644
--- a/tools/perf/ui/helpline.c
+++ b/tools/perf/ui/helpline.c
@@ -3,10 +3,10 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "../debug.h"
+#include "../util/debug.h"
 #include "helpline.h"
 #include "ui.h"
-#include "../util.h"
+#include "../util/util.h"
 
 char ui_helpline__current[512];
 
diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
index 63bf06e80ab9..9ed76e88a3e4 100644
--- a/tools/perf/ui/util.c
+++ b/tools/perf/ui/util.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util.h"
-#include "../debug.h"
+#include "../util/debug.h"
 
 
 /*
-- 
2.22.0.657.g960e92d24f-goog

