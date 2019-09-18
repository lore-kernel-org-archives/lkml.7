Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A6C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75849222C5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rwrNAQC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbfIRTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:02:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35012 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388697AbfIRTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:02:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so613807qkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a/WiKfNYY1RN1LifdVmZHeCC2ZxnRzILsPvEYFEN+kY=;
        b=rwrNAQC0qswaieiokaA6fijg6ESxtCtytuYveTzs3CY/5x3aFYekW+YT/ln6CPx9Iv
         giq6WisFO9XKO8N4hRb/BrzNsgS/QRdlxzdO+N40uGtbE1yijV2rCVz2Hfaq2+YHAqFi
         Cp+4CY2mieLd1UKau6/vkj04ucaAIGF/8VbP0llH+AFtaXPa+u2DdK2IuAus1f+sUfna
         oWnt9yh9X+gIVf4njrIl0MwNP7HBf9Bh2asuvde5tTNrbVraUTOHzeR28gPXk7CJ8FD8
         ESnpss3FcDtEG9aJsJyR5QuA0Khd5LWxOqSx1SR3uW3Or3G7pXDiraLkyD1rBQ3Ku/DE
         yUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a/WiKfNYY1RN1LifdVmZHeCC2ZxnRzILsPvEYFEN+kY=;
        b=PRAXzc4NPn1ViwtfiT6lM1Cg766P1yK82aYV5G8ex9RyDmaTrXh80T7fR5PFluHwte
         y5kbSloNdM+7N3m/NhMmVrLmzErICSjTaY4SvADWJHoCPBqx6lvt7HHIew+SFtjsrX2b
         auYg78SUNmFar78grZ3jg7LhTD6XokgC/OJmGr9AMSu0/oqnYe+GWTCQ9UQBNyXW8T2a
         9vP87J3nQxv7TiLtyno8jeyoDuxWpfjLSSkoBMnL/TcjHxO8j/RgDNEfIme9/dh8CMfv
         7DRg3e3/+lwNOATiyjW8506AZtYdziaRvRlgXnZ52n1SA+bn7smWae71smo1zd7kVtlD
         4Ksw==
X-Gm-Message-State: APjAAAUd2V5KZ8lZjjw1HHmU81FzeJJKE/LNK7JaN7rqnwWlQKSpJ+ut
        yD4g2pcXdOdH07BQs79ZtVHhBA==
X-Google-Smtp-Source: APXvYqyxgKFeBRnm9TLCRp8UaKTqWg0loz3BQgNVMKpcsDFcZbc1kSKOBjbDcTQratTnmiSl0OEA3Q==
X-Received: by 2002:a37:691:: with SMTP id 139mr5751571qkg.476.1568833319767;
        Wed, 18 Sep 2019 12:01:59 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k17sm4128260qtk.7.2019.09.18.12.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:01:58 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        chiluk+linux@indeed.com, pauld@redhat.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/fair: fix -Wunused-but-set-variable warnings
Date:   Wed, 18 Sep 2019 15:01:44 -0400
Message-Id: <1568833304-5148-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
throttling by removing expiration of cpu-local slices") introduced a few
compilation warnings:

  kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
  kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
    [-Wunused-but-set-variable]
  kernel/sched/fair.c: In function 'start_cfs_bandwidth':
  kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not
    used [-Wunused-but-set-variable]

Also, __refill_cfs_bandwidth_runtime() does no longer update the
expiration time, so fix the comments accordingly.

Fixes: de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

Resend it since the offensive commit is now in the mainline.

 kernel/sched/fair.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bbf68c3161..b4fb016e3557 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 }
 
 /*
- * Replenish runtime according to assigned quota and update expiration time.
- * We use sched_clock_cpu directly instead of rq->clock to avoid adding
- * additional synchronization around rq->lock.
+ * Replenish runtime according to assigned quota. We use sched_clock_cpu
+ * directly instead of rq->clock to avoid adding additional synchronization
+ * around rq->lock.
  *
  * requires cfs_b->lock
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	u64 now;
-
-	if (cfs_b->quota == RUNTIME_INF)
-		return;
-
-	now = sched_clock_cpu(smp_processor_id());
-	cfs_b->runtime = cfs_b->quota;
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_b->runtime = cfs_b->quota;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4994,15 +4989,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
-	u64 overrun;
-
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
-- 
1.8.3.1

