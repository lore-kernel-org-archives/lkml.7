Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAD7206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sn7Vdh66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfDDSc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:32:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43001 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDSc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:32:26 -0400
Received: by mail-pf1-f202.google.com with SMTP id f67so2303552pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dA/ytJbuWcWtwKks4hd9trqw0vz1rjFsxrd/Ic+Bx2I=;
        b=sn7Vdh66bDSQ0kQV5wAkH9X32I+IOMsM+yoA9kJ31EBkOdwRX4gFJfE2PbFp2ldKzo
         FeO02/qrU/QFxa/wenjgnguZQZDKbXXZkYkZX02DGW/ZxD5YnTCAE7Hexqalp2NNH5wz
         +VcfA3pejMCRMSX3I/jQiNzKduSsArdCijEi2DPQ8xwZdDj5y98ANDzq4gyF22dhUzJN
         u21lEsRR2vqVYw5M1r7ZwiroUj1gqpiqzc0ZeF7uFJPfH/j2baRW4FA2Bqu06nC43f+W
         IXxjdpLNxxLrrgqsGgT75E1Of4CKu3vHMtGeu8yEdOqBKGWkPLxgY5b7LHHQFEkKUszt
         tSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dA/ytJbuWcWtwKks4hd9trqw0vz1rjFsxrd/Ic+Bx2I=;
        b=uHR8Mr84VQEIAtf6tjM25p0wCQ1/A/ZsD08ohwXA0e8EGF5X78RHkcLyh5jE7mDUbQ
         aMj8IU1hN0UOAnopNzaO57wG/GQlft52o/Jx/7BjhCq53ZKWLxeKSk8LuD0VswVdtKH+
         dgtCUTe1Gt4q775IHoN1T5LarQocU92XV46BrO8m9hDyw3O2Xn+NPZ0ata9LtLGcoNGh
         A49pEx0VvODwQO13x4Uh8VpXbEWYUlhIqNdwC4qHjSfXllr6wpEoWsC+roayNakIL5xU
         BTPCbcavPmP7A8t67CAcBhMZ0FxDDLB8/E8irYj8AMEkR7iq70CH384oOTSr3yizqC82
         lGdA==
X-Gm-Message-State: APjAAAUzm3T0iRtCtWwZTrD2ORi1RdUXKN1Tf5ibofqTqGJa+kp9aZH0
        yd5csLDMahu4GZmsmxxfU0wvitNL4MV/5ZL5GFdzPBDQiA3h7kNTLi83asA+1b48X4UmU32W+TI
        7XOlq/0SYpROe8qzS3GxR6TtVE6/u3Et5SFoHT5clM6QgDVG8hEBMEVrztRT5toQdbCmh0lR/
X-Google-Smtp-Source: APXvYqwZMvkTalx2PQrzQiwIeipBGr1v1v5fYAKK6vZo9c3EzkpgmFlZVEy62w5wpKWFNTSopMUVwcVIpSFo
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr303248plb.13.1554402745047;
 Thu, 04 Apr 2019 11:32:25 -0700 (PDT)
Date:   Thu,  4 Apr 2019 11:32:17 -0700
In-Reply-To: <20190404183219.125083-1-eranian@google.com>
Message-Id: <20190404183219.125083-2-eranian@google.com>
Mime-Version: 1.0
References: <20190404183219.125083-1-eranian@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 1/3] perf/core: make perf_ctx_*lock() global inline functions
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        kan.liang@intel.com, mingo@elte.hu, nelson.dsouza@intel.com,
        jolsa@redhat.com, tonyj@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the perf_ctx_lock()/perf_ctx_unlock() inlined functions
available throughout the perf_events code and not just in kernel/events/core.c
This will help with the next patch.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 include/linux/perf_event.h | 16 ++++++++++++++++
 kernel/events/core.c       | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2a1405e907ec..514de997696b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1283,6 +1283,22 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline void perf_ctx_lock(struct perf_cpu_context *cpuctx,
+			  struct perf_event_context *ctx)
+{
+	raw_spin_lock(&cpuctx->ctx.lock);
+	if (ctx)
+		raw_spin_lock(&ctx->lock);
+}
+
+static inline void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
+			    struct perf_event_context *ctx)
+{
+	if (ctx)
+		raw_spin_unlock(&ctx->lock);
+	raw_spin_unlock(&cpuctx->ctx.lock);
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 833f1bccf25a..429bf6d8be95 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -148,22 +148,6 @@ __get_cpu_context(struct perf_event_context *ctx)
 	return this_cpu_ptr(ctx->pmu->pmu_cpu_context);
 }
 
-static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
-			  struct perf_event_context *ctx)
-{
-	raw_spin_lock(&cpuctx->ctx.lock);
-	if (ctx)
-		raw_spin_lock(&ctx->lock);
-}
-
-static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
-			    struct perf_event_context *ctx)
-{
-	if (ctx)
-		raw_spin_unlock(&ctx->lock);
-	raw_spin_unlock(&cpuctx->ctx.lock);
-}
-
 #define TASK_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
-- 
2.21.0.392.gf8f6787159e-goog

