Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F741C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 16:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EB321897
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNcP5cZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfHXQKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 12:10:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34687 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfHXQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 12:10:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so8760101pfp.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HCWGPbCB1IAUiNh4J5x21IviuwK97PdKw68XVj7uGfY=;
        b=VNcP5cZgHfYl2j6WTkz2IWwk8xT5e0NZc2X47SgYs6umDmL0oxc00FHtHHVgDW7pES
         jU8dt4L2c64vWHHD5ftu+TtDeMF3/NfWr/ylfomZPj26O6hz1S0SS5eeC/u125tlE+C1
         1AMRzCsfE6uuqnkp6hjwvfl70dMR1/PqmQlP1PY8II54XOYnc6aoLHDnoBMlVaDZVEsv
         nF9Nv/uSGMmMmPmyv4Mj4te33iTptp4kBZt/ckMNYje7I2AXwCGgnvnmUzZu/hL1j8VL
         tyjaegeGIuUZc8cfiX7179arihVqN0rqw87CmvgWaLhH8o2ZdBW62DiL+7DI1tJp/pWZ
         vpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCWGPbCB1IAUiNh4J5x21IviuwK97PdKw68XVj7uGfY=;
        b=I8Yqz8R6E1Zo2D9OIdsFA3//s+2EKZ2kmXZEXKo61OIaai62qyCrLTRXnYQ9qsTQyJ
         WGZHNkRXRHW8Etrqe9pfROQXT2OimaEjFmSbNYkOINADjUhQGcgUdh2fQEFQRA1VfLit
         FLqjpMGDetN8AJBp5Ww2phesfUpVOJspLGgLqyStHlymcFSXJvKXFI7JhllIe3JGNGdv
         sLVsS1gwcm6X2IEHnZuTh9q0EnT28esDLW2vXlXNG1PclAiP7ZIXrT7jOPjcqt8/huXM
         6DOlnMzoShEM1ilsj3YPQMowK5F7YKZRuZPAgl4cLGkd7VuMtbx8gWl1YviNAic+scg+
         0gow==
X-Gm-Message-State: APjAAAX6ebA/spkBH+8yvkn4qVbWWYZVxKZOY/M+OxIJ/fDgNILqCzl+
        65Af8nd6fVBoqOKgiP+gwNk=
X-Google-Smtp-Source: APXvYqybqqz3NHXhqpKcAZEHAN60pgX74B0MOZuG5FpqAVnEbs6fnxhASpzKhRka1WHIRgC1pCaPKA==
X-Received: by 2002:aa7:9edc:: with SMTP id r28mr10999095pfq.219.1566663004948;
        Sat, 24 Aug 2019 09:10:04 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.17.2])
        by smtp.gmail.com with ESMTPSA id k5sm6518658pfg.167.2019.08.24.09.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 09:10:03 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [RESEND PATCH] perf: Remove duplicate headers
Date:   Sat, 24 Aug 2019 21:45:19 +0530
Message-Id: <1566663319-4283-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed duplicate headers which are included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
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

