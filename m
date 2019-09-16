Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D0C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FB12067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OtxEOkSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbfIPVTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:19:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36923 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfIPVTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:19:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id d2so1709698qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=H5UW5wagKW04F96GTBBaiTMgST09Ix10VZlrh75iTIo=;
        b=OtxEOkSZUUbBW0Fo/uVlK5sm/VQ6FDj6guxqW4jppiLEFD/cFIbfMh064UM0SApcIb
         K9w/1u4M2viEXs5Vltm0DLSfgJo5g7wQLyyTYlgVFwXVS2G/zMFSYsSi7Zq+uG8nCSVD
         xWe9WSexYP5qCZmtVyq7vaOeJEGKN054XnUK1K+uZYI7GIB9Ccbk/3NwwyJduMFQO4FG
         ZEg0jZaOht2IdxOAvuBLTKjwP8uLPUHbZt5tVXKuHjMsi4wJv5cd+Csg6frqXbxxQbtY
         w6u0WQSmhOrSxOBEIQfRzLA40nIgjQ5w8zfd1xWwp9EbYal04YJ0r8xKckgLcHSo0yaM
         tGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H5UW5wagKW04F96GTBBaiTMgST09Ix10VZlrh75iTIo=;
        b=ArUurb4CmXohl+Mfow9f4siesrg3Q2zo0e3fPeS7Izo8YHiKv+A0Y/e0tefo2VYTwv
         9gOum0xhigLV2buweXMKkTNfu3ZGHskhZOuAVN52NKKfSp4IeIJ/+N7PJm3NdbIo3U8U
         ++zPVWoknLSVmUgeKtUd1+D793ZAXOOJ3YMgXAk51aHcamijgOWStAtF9DIGqK5rPiVd
         gCZxieAyeiCpF9+YXQpRiF6sRRhnTipUaiL9abVjltncF6vE8UmvQ9hcscI1yVaRlJp1
         QywShdl+T30WJpkPlI/1K4x2PfsEzXlupaRkW0ubjnI9oAsI2ozSbbuW2KtR5OhCkzXz
         D80A==
X-Gm-Message-State: APjAAAV145bh7z/0HzxTNgT/OxxmCYiemX9Zw782KVwbRA5GFS0zDFzu
        7RINMie52/qqxvgJhHzUAV3kWA==
X-Google-Smtp-Source: APXvYqy47HRVWyxZtKhXKNRV49kIORiXqICCRRmpY6JGlEnmHtvQzwTiUaGQbDVWItZDSSLQW3MTkw==
X-Received: by 2002:a0c:ec11:: with SMTP id y17mr313980qvo.159.1568668788749;
        Mon, 16 Sep 2019 14:19:48 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p77sm74711qke.6.2019.09.16.14.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 14:19:47 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/fair: fix a -Wunused-function warning
Date:   Mon, 16 Sep 2019 17:19:35 -0400
Message-Id: <1568668775-2127-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_rq_clock_task() was first introduced in the commit f1b17280efbd
("sched: Maintain runnable averages across throttled periods"). Over
time, it has been graduately removed by the commits like,

d31b1a66cbe0 ("sched/fair: Factorize PELT update")
23127296889f ("sched/fair: Update scale invariance of PELT")

Today, there is no single user of it, so it could be safely removed.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/sched/fair.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 500f5db0de0b..0d0b812b6c49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -749,7 +749,6 @@ void init_entity_runnable_average(struct sched_entity *se)
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
 
-static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
 static void attach_entity_cfs_rq(struct sched_entity *se);
 
 /*
@@ -4379,15 +4378,6 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 	return &tg->cfs_bandwidth;
 }
 
-/* rq->task_clock normalized against any time this cfs_rq has spent throttled */
-static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
-{
-	if (unlikely(cfs_rq->throttle_count))
-		return cfs_rq->throttled_clock_task - cfs_rq->throttled_clock_task_time;
-
-	return rq_clock_task(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
-}
-
 /* returns 0 on failure to allocate runtime */
 static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
@@ -4524,7 +4514,6 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
-		/* adjust cfs_rq_clock_task() */
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
@@ -5135,11 +5124,6 @@ static inline bool cfs_bandwidth_used(void)
 	return false;
 }
 
-static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
-{
-	return rq_clock_task(rq_of(cfs_rq));
-}
-
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
-- 
1.8.3.1

