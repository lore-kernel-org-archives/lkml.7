Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68142086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.b="J6IgkrNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfITRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:13:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfITRNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:13:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so7502923wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpoN+zJsHYCQ62XlF8eh17xf9pyp/7YrrbP1I7F2ie8=;
        b=J6IgkrNIAXoo3YOY/K6fNOiHlkWiZZvaeI3PpAXec9FbfPY2XwVyCDVydfdxkeFjoz
         BL8vCJRUkTZ4m6a9qHkCzvRx+x8pBuJShlQXB79EX5LGX0RcTxgbD3aupm6BhlpVGT5R
         yQ9jDNTA4DduB6cdGxD2FermDrmnF2sjH/Cn4SlZEGWnLavu0da8KAzkjFWpMvsNE10l
         KbkWJfUwozPqnflpjUhauqLIARH9su8DyUYk9ZxM3U7aJs15KVQiTWVa3MO7vR4DOB+W
         xlXTf/5E8TMmtV0ZF45FIKMcpdMBnD1XPdNWpfvZcrd1YN/0PPlvAVrOCgpZ8HEJeKv8
         to4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IpoN+zJsHYCQ62XlF8eh17xf9pyp/7YrrbP1I7F2ie8=;
        b=a222WM8ECFPBZQ9agwxAfLcq0KcyEs0v4kHMbNz6cbvLeWNTPwJohN25vhFY2lTxTG
         nafawQ2CBZs02QA+IFOja6+Mk43kCw4mCHGrQQOyRemZMtrgKwqSZANnr6nmOGgrIXSg
         SXhvWdudmK7/kge/esJFm5EO2CHKaISI4mjxw9ZXN2W/BhTkaWinrjOxxu6yA0woBYiF
         +9rwzb13MeoRH/adejmRCU95q1nV1xxZbAuAcu0xQ2yQyIXpoxiVZgSRsqDNpd0fKpog
         s6SE98b6A1yBo64xFe4HjtIXqjbRWc6J1n8Yw/XsH5oU+LAkSXBYTDfGWEetsl2s0MjC
         iavA==
X-Gm-Message-State: APjAAAVmMq+3909yS9Y2gGDhK9d85pEe17cU4TiUT6w8ERAzKQQi+kQK
        Mg7v/Yh0BrlcRGXsc+yld0nyxA==
X-Google-Smtp-Source: APXvYqxgVBnLeRpGIlIc08M1BCeQcZRXIc707bk1MORs1/jKo8kP+XMffhhNVasZkWSgAllMpuAc/A==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr13184729wru.9.1568999627033;
        Fri, 20 Sep 2019 10:13:47 -0700 (PDT)
Received: from localhost.localdomain (bzq-127-168-31-148.red.bezeqint.net. [31.168.127.148])
        by smtp.googlemail.com with ESMTPSA id x5sm3598470wrg.69.2019.09.20.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:13:46 -0700 (PDT)
From:   Roy Ben Shlomo <royb@sentinelone.com>
Cc:     royb@sentinelone.com, Roy Ben Shlomo <roy.benshlomo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: fixing several typos in comments
Date:   Fri, 20 Sep 2019 20:12:53 +0300
Message-Id: <20190920171254.31373-1-royb@sentinelone.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Ben Shlomo <roy.benshlomo@gmail.com>

Fixing typos in a few functions' documentation comments
Signed-off-by: Roy Ben Shlomo <royb@sentinelone.com>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4f08b17d6426..275eae05af20 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2239,7 +2239,7 @@ static void __perf_event_disable(struct perf_event *event,
  *
  * If event->ctx is a cloned context, callers must make sure that
  * every task struct that event->ctx->task could possibly point to
- * remains valid.  This condition is satisifed when called through
+ * remains valid.  This condition is satisfied when called through
  * perf_event_for_each_child or perf_event_for_each because they
  * hold the top-level event's child_mutex, so any descendant that
  * goes to exit will block in perf_event_exit_event().
@@ -6054,7 +6054,7 @@ static void perf_sample_regs_intr(struct perf_regs *regs_intr,
  * Get remaining task size from user stack pointer.
  *
  * It'd be better to take stack vma map and limit this more
- * precisly, but there's no way to get it safely under interrupt,
+ * precisely, but there's no way to get it safely under interrupt,
  * so using TASK_SIZE as limit.
  */
 static u64 perf_ustack_task_size(struct pt_regs *regs)
@@ -6616,7 +6616,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_STACK_USER) {
 		/*
-		 * Either we need PERF_SAMPLE_STACK_USER bit to be allways
+		 * Either we need PERF_SAMPLE_STACK_USER bit to be always
 		 * processed as the last one or have additional check added
 		 * in case new sample type is added, because we could eat
 		 * up the rest of the sample size.
-- 
2.20.1

