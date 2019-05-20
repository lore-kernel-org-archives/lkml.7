Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6C20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igniLd0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392218AbfETPiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:38:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37630 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbfETPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:38:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so7416116pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HCWGPbCB1IAUiNh4J5x21IviuwK97PdKw68XVj7uGfY=;
        b=igniLd0MBlYjxgzMR5kyXnl8VT8ZtjRPrKt7aUAacEDN/OkL9DAh4o+l/pKeqrh2lr
         eazLg/XVLVN92cJwNeJ1uyI6xggkx6sPaD9q25GCBSuNHuBJWYH8kZE7Y/ZeQjZUQhI+
         0Nv1nUmCeOYqS1ALsMqdADZig3yQcYNOlwRGTtolAXwu1raNQ4E/NLQJ74VGu7WkO3Du
         R/iLAFIZxnFjll0A6PR6TQE7RaWbYQM05Jg7/zdl2nZcMNHit5Tc9/wItAOyecRQNATJ
         sRL+cW/t2bQZqRIYKiBgAy5R1lFcBA2yhUo+Vb9wNAY2VBMuCmpnGk/S85cDKIOQrPJ7
         VYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCWGPbCB1IAUiNh4J5x21IviuwK97PdKw68XVj7uGfY=;
        b=ON1lnvuwwFxJYxMYYXR0wz+B3tEjPT9f6TxGICP3g8cqvExSD9AdiTN72je8++cCQ4
         E05GmeOyoX4Vv0NY3mtWiKqoOZkGN5HJrGaUzwzL/540PXTBrkhsDygY0/QfSXHqdEOr
         LujVlfeD/BnhudXoVGw76CWfTBMbmDkfTGrXnykMsVr77UkSpge6omDaJJ9IGbJHCWye
         x49P2AUm4K/KjKVC4WqMOQpvrI964mtpdJxNHKHWBDPbmIiDCMfTKwO5z/Rw0onhW4T4
         MJbBEUO3BW+jatjaRA3kUkkvC85PDMD9xalEiftaWK2a6uDTA4dNCix4qVse5WCfKG3f
         g8fw==
X-Gm-Message-State: APjAAAWLpBEvKJvrqf4xwg34zZy5P59Sh6Xn7MEw8jJI6MRE4HD3ECSi
        8TmwCPxBjHRNMwedJ+OgCYw=
X-Google-Smtp-Source: APXvYqxDPl+B5/1wJyOPopG3XncxecQB7K5MLcwywRUNYTmdLcE6DD4ncAqutVAEsvnyk4pQ1XGeBQ==
X-Received: by 2002:a63:5c5b:: with SMTP id n27mr76820777pgm.52.1558366685895;
        Mon, 20 May 2019 08:38:05 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.19.216])
        by smtp.gmail.com with ESMTPSA id s28sm28429620pgl.88.2019.05.20.08.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 08:38:04 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        eranian@google.com, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] perf: Remove duplicate headers
Date:   Mon, 20 May 2019 21:12:43 +0530
Message-Id: <1558366963-4163-1-git-send-email-jrdr.linux@gmail.com>
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

