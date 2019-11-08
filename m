Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C83FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D2F2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfKHVgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:36:00 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:48263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbfKHVf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:35:57 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRC7g-1iEnnH00M0-00N98i; Fri, 08 Nov 2019 22:35:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 08/16] tsacct: add 64-bit btime field
Date:   Fri,  8 Nov 2019 22:32:46 +0100
Message-Id: <20191108213257.3097633-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3+J3uRariZxxM90pMCKHnHOIPfnwPSLhxD7qOTYUVh3SZ+JnOFK
 VgE/W8pe5KqQiWz/onPIr5xkbYNXoU05ZXKz9Ur1T4KKbn55mDc736fX98L1y4kNR1sVl+E
 eJ+aGZ5iEbt0dGFkbfWunoEWg1qg93cxn7nXS0JHShvtXBZXfISyaiCUKqXP/DJmACan0V/
 DQ8ayfOjgUjuzE1dRVSKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:taJmWacjwUo=:jr/dEAhQn68wzbMKnfMDqL
 6Trhqpo0PcSePSySdrLaqoFD3YsWRrcfJGFidUMcseJjIG02n2xadFKWP4tqT5sJM0ORXGjiy
 HknMtrs50T4QateXUoDx6LDSZGEvxMhEui+Y7ekbhuFh+QgnMOTCJRWlC2PYczvC+nF+nNeLO
 L+Zg7VrudI22dMCln1JQEMge9JtAoHqhRMGYbWfjSMm3ACsdZ4doRuvJbT8vsRPdVfc6/7xel
 wGjByAa+2Wq5UKwOtUor7w+1FDBvKmF+rf6Toc0LE+azWpsTt+GTavipZ2txqUFfr8I/3uY8p
 enDWDzEB0bdiplvgNb6YELjHC7e1z5RpNFSf4ewQyz91wzSXxKAPp0KDwBiPbhM6qnMsHi8su
 bpd3g/IdgHYUl3p4tLVH9m3ZtfWNe3MKeOpLtu0NNrl4Tur6WTUbUQvwmj9MXi4KS3uKlruUx
 UlF429FjvvlKF/iT8yINQWWRg3HRtlfi7RoSIyQCdH2d1W/cpSl4zI0uApgJUfQIj2l8eSdHa
 FXJNfMEvrUtpbbrllLeIfg+5bztFXiFTZiUUzdNvXQTemvBJlztoiHFSy/CQ1iqOU4dTL7yG+
 eYkgZCO6isfij0b/H+F9cVuMhlsjW+1VU12AwwUySvGLW80M7VFbs/x1o0opar/YLu8nabZEg
 ooKs4URxFevO8UZkM3Jp3lLIJM4qM5XlsT5GWbX4Lf5P8JVoeX4BVQCjGKSfGxoM6epaLDQpe
 sVrjaI5uOgJ1lw8xAbc5OL3ugCWf8h3e8McYj1/TSbkAepgwAIjSEQrNXqQL1fQlh3RVsi7LI
 H3n1Cr+8v8LyNBUqjKLQDAEOQBu2S6v4+MKzrLg16vKj8P9se47KDiLNqFChBTy8W2XDRR0rd
 U6GSJyTjWManXM6BSsCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is only a 32-bit ac_btime field in taskstat and
we should handle dates after the overflow, add a new field
with the same information but 64-bit width that can hold
a full time64_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/taskstats.h | 5 ++++-
 kernel/tsacct.c                | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 7d3ea366e93b..ccbd08709321 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	9
+#define TASKSTATS_VERSION	10
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -169,6 +169,9 @@ struct taskstats {
 	/* Delay waiting for thrashing page */
 	__u64	thrashing_count;
 	__u64	thrashing_delay_total;
+
+	/* v10: 64-bit btime to avoid overflow */
+	__u64	ac_btime64;		/* 64-bit begin time */
 };
 
 
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index ab12616ee6fb..257ffb993ea2 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -36,6 +36,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	/* Convert to seconds for btime (note y2106 limit) */
 	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
 	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
+	stats->ac_btime64 = btime;
 
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;
-- 
2.20.0

