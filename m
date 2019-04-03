Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA62EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A122147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfDCIr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:47:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35906 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfDCIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:47:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so20204002wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+elIWaSRRzW1VcHznsP5iucrAyCnlyU8peFEPVpuM2g=;
        b=r4HNFUK/3VBpi2DtAcrwInFr/irh3AtLX6FtJTfr92oQ1auH/B4B86e33dZ88NLJVl
         KKnw67+l5KLmeU3al7fwc+XGUbVyWOQNHZsX3gv/Nlu8ec7i/cJoSqss0k4ShwwJaP1o
         7XK/yle0zh0Ijf+IMVus5RAOmoNLdW5qsBoG2bSeSoV8f0bCQlHfECAHZLvw7hAY9nH7
         vtzdFdOQgcn6Oc5c1isVXRLG8gAie8AZdfN3MceE5jwM0qkJVb7K9HFs9t0WxDUDJlJD
         DWoSrKNnJK8HI5iRIl1Ya7eGR6nYvv597FFR03CsQzW1VfbdVHplDb7KN582da06ZFp2
         vXUA==
X-Gm-Message-State: APjAAAWyw4qy6roYv+i7aPDwY71RUjLw7fc0XrcCgv86DzTcOUGeltxH
        MQ4hU/i2wfyaTYM33NVrA90F6A==
X-Google-Smtp-Source: APXvYqxVIEY0lpWHpNtTl30gzxug117JezgS8Sz1TM3tgFZegx/uQzblmViFHK4g5yxmdXfX6AeqlQ==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr47217819wrp.92.1554281240305;
        Wed, 03 Apr 2019 01:47:20 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.174.33])
        by smtp.gmail.com with ESMTPSA id o2sm12258081wrs.89.2019.04.03.01.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:47:19 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v7 7/7] sched/deadline: Fix bandwidth accounting at all levels after offline migration
Date:   Wed,  3 Apr 2019 10:46:50 +0200
Message-Id: <20190403084650.4414-8-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190403084650.4414-1-juri.lelli@redhat.com>
References: <20190403084650.4414-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task happens to be throttled while the CPU it was running on gets
hotplugged off, the bandwidth associated with the task is not correctly
migrated with it when the replenishment timer fires (offline_migration).

Fix things up, for this_bw, running_bw and total_bw, when replenishment
timer fires and task is migrated (dl_task_offline_migration()).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c8a654b133da..91be79072845 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -530,6 +530,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq);
 static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p)
 {
 	struct rq *later_rq = NULL;
+	struct dl_bw *dl_b;
 
 	later_rq = find_lock_later_rq(p, rq);
 	if (!later_rq) {
@@ -558,6 +559,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		double_lock_balance(rq, later_rq);
 	}
 
+	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
+		/*
+		 * Inactive timer is armed (or callback is running, but
+		 * waiting for us to release rq locks). In any case, when it
+		 * will file (or continue), it will see running_bw of this
+		 * task migrated to later_rq (and correctly handle it).
+		 */
+		sub_running_bw(&p->dl, &rq->dl);
+		sub_rq_bw(&p->dl, &rq->dl);
+
+		add_rq_bw(&p->dl, &later_rq->dl);
+		add_running_bw(&p->dl, &later_rq->dl);
+	} else {
+		sub_rq_bw(&p->dl, &rq->dl);
+		add_rq_bw(&p->dl, &later_rq->dl);
+	}
+
+	/*
+	 * And we finally need to fixup root_domain(s) bandwidth accounting,
+	 * since p is still hanging out in the old (now moved to default) root
+	 * domain.
+	 */
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+	__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	raw_spin_unlock(&dl_b->lock);
+
+	dl_b = &later_rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
+	raw_spin_unlock(&dl_b->lock);
+
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
 
-- 
2.17.2

