Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404EC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD1620879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GA48HvpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfEYQSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:18:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35949 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfEYQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:18:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id o2so11702039qkb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdjzrs6vvJ3j4pGa7mp2KJeqYUL3Wnr2qtDzjg5y9zg=;
        b=GA48HvpIkAsZQguCHfouFRocEWJApkBS7HorSaEPM6yo2XfRD6ZqHrih/7GuP+alQt
         lV8vVlSmHHwDo56yejZV0kLW9Rg0YB/xam2YdXZWmTgWj4FBHGPQNV0NcjyIkcPyuZqF
         BEYdBkRKLZTJkpAR0C75D4JlxkttH8+ZMjpPwdHKQoTB7TEHiHuctXiqwe5ya7LTbPKE
         GPrAuxWEX+nVUwuHTePlfFnDUGLUBpGlOG0bABKbAEZtBbF1JOVAJG3tk8JP7bWAbnxv
         yfZQm7v+HKAfR3uHqURPsYgJUI1W2tpbeUBQ73hCRHXmFvi5DLTqifsUa7dXa/9YNNV4
         VeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdjzrs6vvJ3j4pGa7mp2KJeqYUL3Wnr2qtDzjg5y9zg=;
        b=gYPGqtF+6jCvV4jiKaNzo3H69IWsH0adEKfqMDXoeiN4jhwrCm6VczKlSxfHhOT/83
         ssWpGwjaHdcFn+AS/sjMcvz6HAofdW0Xff8OQytxrQEaz6FVr9u7IF74+h9xqfrFvo4d
         H8EO0w66AR05ESgiv6jr+lGhw/mrSD27CAJHJxhwrZDT4CT9Nf8hWETd9ShBBYJY53wU
         wZs/vkIgf/vWzj0UcJMmXsGyQTmmMZJLbicOXlpFV4gfiZBrKKG31zdbDyMMVZWq/1Ge
         KzwBXg1qjEHH7952UDV+kKwvzVSgR+qNH1Sl3Uj0sdo/V9srCkxptk1hoWi44txGP11T
         irtA==
X-Gm-Message-State: APjAAAU6WJPyWGdY7s7AuUPmpbpYdCM8/Camino/DXqBUfOa/FVsBpk9
        1bq8P9yzA1qKOKmmxTLEtvTeUQ==
X-Google-Smtp-Source: APXvYqy3EOqAmX6XqHp/FVqsfT+x+677YN/5en54Bj+BqyroG1ph34jxwCQfapsPcPI9hbRwea0ddQ==
X-Received: by 2002:ac8:228e:: with SMTP id f14mr57327602qta.79.1558801111153;
        Sat, 25 May 2019 09:18:31 -0700 (PDT)
Received: from ovpn-120-193.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u26sm2484129qtc.84.2019.05.25.09.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 May 2019 09:18:30 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/fair: fix variable "done" set but not used
Date:   Sat, 25 May 2019 12:18:21 -0400
Message-Id: <20190525161821.1025-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f643ea220701 ("sched/nohz: Stop NOHZ stats when decayed")
introduced a compilation warning if CONFIG_NO_HZ_COMMON=n,

kernel/sched/fair.c: In function 'update_blocked_averages':
kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used
[-Wunused-but-set-variable]

Fix it by adding a couple of "ifdef" macros as the variable is only
needed when CONFIG_NO_HZ_COMMON=y.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..c8682acf4508 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7747,7 +7747,9 @@ static void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq, *pos;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+#ifdef CONFIG_NO_HZ_COMMON
 	bool done = true;
+#endif
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7774,20 +7776,22 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_is_decayed(cfs_rq))
 			list_del_leaf_cfs_rq(cfs_rq);
 
+#ifdef CONFIG_NO_HZ_COMMON
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
+#endif
 
 	curr_class = rq->curr->sched_class;
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
+#ifdef CONFIG_NO_HZ_COMMON
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
 		done = false;
 
-#ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
 	if (done)
 		rq->has_blocked_load = 0;
-- 
2.20.1 (Apple Git-117)

