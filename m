Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F7C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2FC20B1F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odyAHFpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDFNcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 09:32:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40841 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDFNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 09:32:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so57711pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 06:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OrHpZ2yrPdfC7P+2cVbH1U4444iOB5Q3LTKmsKr8Ke0=;
        b=odyAHFpSVAVcNUdalIgpJqfY6yBmaS97XxBZ53oPfILC2khDEi9RToVdJCkkVWAC4Q
         BhOsmLE0+K6rBgpXo/Ty2A7XEVe2qvtW1ZgDS6+yu7Z2ctW5MYA0t5DiOZQUp4XDogaX
         RhhPXWIcAhCq7Y2kT6oelTMA2+Qg3t+4bSzaLgHGEZY/1WiCJqUnniKaXeOwN9jsSyae
         gijYHbpdTfjqLUc/63u0pFxX4MKlANwXliKaFswRT4L3PersPSnWfJc0Z8hi2Fadkxjv
         E7b99NAFc1k4mdhqpeBavsIV+r/NxlgNmzqH1JveGdvEUtTnwmUNHxKB2pRrkn5KjL7M
         83HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OrHpZ2yrPdfC7P+2cVbH1U4444iOB5Q3LTKmsKr8Ke0=;
        b=kAYB6dhRBnAasAimeimRfeqPkgl9Tumdry3EHlNlbrbrdFBG8ZsgOXDu3OT9dDKV+N
         eHwxx65fk+0Hq9TLPciYEWR5AfstX+/qew//bRlidjSQpqx6abHCJF6cByXtDlzWx3pZ
         IhrP1NuP0KVjgsVWPjKOlB3k2xTjOVcF0hhNoBl9GlL13O6WM25bS8pm5w7xywh3/7LD
         yOWTLLQUPxDG6JINWQmzMXdxe8BXHKU+/m3TlO4LRqAopDWzRpZoohuVVN0P2hnYFl2I
         980UEJVxzvnjJ21Llyjq2orxxr/jDEW9ZAVktpyJUS3GAtR7MX1ZgXXuimCiqOvhM9+g
         uFSg==
X-Gm-Message-State: APjAAAXBlmbx8jUCo7jsDjHzeXSC2CU9MKzHeWEZotp1R567FsRY0mpz
        gGBP5PY0Sv+t3IZmUra8UYg=
X-Google-Smtp-Source: APXvYqyLOlHW41ikz0tWSZSeE+4h5Le6+zWY4GXofK/cqI0D3uVBeSjkZACWfj0nwR3eWPXrzXcngg==
X-Received: by 2002:aa7:9294:: with SMTP id j20mr18812936pfa.64.1554557541135;
        Sat, 06 Apr 2019 06:32:21 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.51.153])
        by smtp.gmail.com with ESMTPSA id l74sm39726985pfi.174.2019.04.06.06.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Apr 2019 06:32:19 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, eranian@google.com
Cc:     linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com, Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] perf: Remove duplicate headers
Date:   Sat,  6 Apr 2019 19:06:29 +0530
Message-Id: <1554557789-9474-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed duplicate headers which are included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/perf/util/data.c                 | 1 -
 tools/perf/util/get_current_dir_name.c | 1 -
 tools/perf/util/stat-display.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 6a64f71..509a41e 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -8,7 +8,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <asm/bug.h>
-#include <sys/types.h>
 #include <dirent.h>
 
 #include "data.h"
diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
index 267aa60..ebb80cd 100644
--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -5,7 +5,6 @@
 #include "util.h"
 #include <unistd.h>
 #include <stdlib.h>
-#include <stdlib.h>
 
 /* Android's 'bionic' library, for one, doesn't have this */
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d043c7..7b3a16c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -12,7 +12,6 @@
 #include "string2.h"
 #include "sane_ctype.h"
 #include "cgroup.h"
-#include <math.h>
 #include <api/fs/fs.h>
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
-- 
1.9.1

