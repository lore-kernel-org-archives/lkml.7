Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2772075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKUPWvkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfC0RHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:07:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfC0RHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:07:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so10217551pgj.11;
        Wed, 27 Mar 2019 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jQhbyxEE0mB1BOZQSrq0QxRyL0ayq5FPlmAQaxy3pl4=;
        b=JKUPWvkqZCmfYbY/rKeg0D6TgoITF+rfuD+9LuAOfH1Ad3Sugxbxf7HmpHx0gShJ/i
         F9T7CwSgUzk7B+o8O8VvWScSALILdiBPFxqxOkXAq+TLcutR3wTyvH3VLDcspdzNXBmV
         KUBPRqUpKh1u/Kr+N/nHcIxlxG6f21Bg+b+S3PV1KuRXdI+PTRZosLCcNnbAPL+1NEW5
         Tw1/mWoqRfTZ2q+gqR7PMpM9veL6lLMiZIa43D7S7zTwXtisDgEgMMLp7nD7gigze0Xj
         0fFTggVdmfj/NvoC3LliLcMXr6U+HF5Z2r5Ryho2z6niOM2/Lpe2bHYIZi2q7zeEEs1y
         Sl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jQhbyxEE0mB1BOZQSrq0QxRyL0ayq5FPlmAQaxy3pl4=;
        b=poMzyIdKSdHYmRT/rIF5ucnouihfq1b3Ymp3nD8FrHXQiSIFsCpSACsIUy1tQ13F4L
         R551ZgRoVjsUaxv3Ly5OoqsXVs98BzQVIFPp8Vq6CP3/uL+B1rjhLsxta1r9yD6E+kgu
         uPL7zqrFLP7Rp8ehKvfnSQs1kfMVhbrT4WWXhoYPhBzU1M/Ar1j2jSKG0OR46k/LsEGA
         gEyuuvC1i52R3s9IrsREF5Yf54QbUQapwT59GGxxz2CtE/uWlfOKn0RxicG7CUj8Polv
         jqoHXElq99JlBhhVxbhzG6ACkxbiTPs6MApc6W+4HIAel3CQeczwLRoaLMOZ+Vdmxh7m
         6NPQ==
X-Gm-Message-State: APjAAAWlAKW2zVFPk2+JgE26nbGGBOc9X9MGiuVAJ+zmKAagR1B8omaf
        /jKaD779CHu/jzyJZ2mt6JI=
X-Google-Smtp-Source: APXvYqwWxOH3FZ2TrgYSoct3qUneo/6fqFATS3vObMe7CVE1goatBmJQmGUK3Ti1z2RlodFZBQ6/Rg==
X-Received: by 2002:a62:12c8:: with SMTP id 69mr37014149pfs.184.1553706471716;
        Wed, 27 Mar 2019 10:07:51 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.54.136])
        by smtp.gmail.com with ESMTPSA id i79sm47603607pfj.28.2019.03.27.10.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:07:50 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, yao.jin@linux.intel.com,
        eranian@google.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] tools/perf/util: Remove duplicate headers
Date:   Thu, 28 Mar 2019 03:37:26 +0530
Message-Id: <1553724446-40957-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate headers which are included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/perf/util/annotate.c             | 1 -
 tools/perf/util/data.c                 | 1 -
 tools/perf/util/get_current_dir_name.c | 1 -
 tools/perf/util/stat-display.c         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c8b0117..b1dd021 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -36,7 +36,6 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
-#include <bpf/libbpf.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
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
1.8.3.1

