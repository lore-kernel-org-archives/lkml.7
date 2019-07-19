Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C4C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C37920873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfGSOAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:00:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbfGSOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:00:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so32346923wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCKTOX94dJMJaIi336ahfQwlG37S0yGGcCoKC+X5aD4=;
        b=J0dJHnyQtAu6xdP9zw+fKZfP/AjLVaf6m7b7zy4HgWZj3FHbdF8tjHZzh5SWciMHiM
         8P8/HKialx3316zsDC0idjdkPVH9xGBu5+bwfidXOmZsaFi6qygRddXVPc91ZDp4+/66
         nzitTP7LtqgdPkHsgZCKIjm7eiCSuFfR6NZ5idR5XLxmQaLgvAQh1kuEkTD0E7KGLs/B
         6zE+W0viX4pC+FFgzwG7eGYhSV+8kMpddMVT6ZZ5HlAStIi5zZXSS7j6yyr450jwQe/k
         SWheto8mj8UmuWWU7Eq25ZfCBhc+i11Hn4aeZSq9dvLDk1+eoiyYt9x6kX1VCnhPenI1
         u2Sg==
X-Gm-Message-State: APjAAAXw5Je7/e7Hyr/hZA/S09ObEnfr8zhP7YXR/d9xchcz+I+lLhWn
        wPAAPdX7blykYYZOFvi+zTk8mA==
X-Google-Smtp-Source: APXvYqymi+u8sAJDOJGZ+TE9F304naCkSgWxdKC1853CP1UOTXVZB7kOT4uoBOLgUDR0D7O8XX4C3w==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr41366942wru.246.1563544836142;
        Fri, 19 Jul 2019 07:00:36 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:35 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v9 7/8] rcu/tree: Setschedule gp ktread to SCHED_FIFO outside of atomic region
Date:   Fri, 19 Jul 2019 15:59:59 +0200
Message-Id: <20190719140000.31694-8-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_setscheduler() needs to acquire cpuset_rwsem, but it is currently
called from an invalid (atomic) context by rcu_spawn_gp_kthread().

Fix that by simply moving sched_setscheduler_nocheck() call outside of
the atomic region, as it doesn't actually require to be guarded by
rcu_node lock.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 980ca3ca643f..32ea75acba14 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3123,13 +3123,13 @@ static int __init rcu_spawn_gp_kthread(void)
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
+	if (kthread_prio)
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rcu_state.gp_kthread = t;
-	if (kthread_prio) {
+	if (kthread_prio)
 		sp.sched_priority = kthread_prio;
-		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
-	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
-- 
2.17.2

