Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF59C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A3420863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="e6yWgrtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfEVSU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:20:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35438 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfEVSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:20:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id a39so3580992qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u0wVb+qx0HP7ynGZlydxnvLcIfWt904t9XK5ssuA4Y8=;
        b=e6yWgrtARtsXcQv5iEPdsv+aZCwK0Sv0EUahl02/x2SND0Gzh4jrQB5UwGi1k0Nwdo
         NBbh+gujViNZIiOmWuZ1RNhmuH3OEav4ef/OpEImso4Lx3WpmQyoXOeSEc+pXcAU6bT0
         APbBY0fW7yiavNl/GSok0AkxOhT43B7gvxr4qobk/NbAH+Ea1bb63Hc8lLiaWr5c4bnr
         KTbJVtyOxr40evuRTgllQA67vVYIRCw6hsJ1ltonxvFmkn9lp7Guj9197taqUPATtFYR
         2mKhTMZQtbRQzITyIqBBbdEEqMSdx0UdBjIbf5DSf4A+T1rJ+aH7cQCXQsNtSoVzowa1
         ledQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u0wVb+qx0HP7ynGZlydxnvLcIfWt904t9XK5ssuA4Y8=;
        b=hNZ17zpWiWrZ1R71TRtw1QOwIKhk64s9X1ZBjSRC9VTpx0x+txWkP+x2Y6CTjqwNUA
         uVfFtCLSm7GzKbErfGqZIStdlxnTMQ13ubOQhRDmVoZhw7mabJFk8vxwfZmZTfbtZX2y
         LsWomliPRPUtb/GY8rX0RjaT9+B3TooHdsFOysma3acZv5eIDo0IEELjwpiVKtwgMZem
         m665ho6DGIMWZvyS79ZMDRKLX2byY/jftTAtgQpewKVQUf81frSBoVZlFz0IAORt1p1o
         PrEGLiToEqLvYbd+RkiO/C351cRCiGe0yVbANsjMCX+Cpw0GRcr7W5g/b5KkXhIk4HOC
         33Zg==
X-Gm-Message-State: APjAAAVUIosfTSnMMWqH3jEjKAAm7vPcGdSGBTIerrmcI+3GwQT1kkhe
        y7w5oFFiZe3aMVWKWuQBzl04Xg==
X-Google-Smtp-Source: APXvYqzDoWgrN1NhlYR+jsnY+Qo9humWfDmnt9M3VgEkVfjWVnKmkRtRsLUg29IEw4Iti+7ZMcr5Ng==
X-Received: by 2002:a0c:b602:: with SMTP id f2mr51638298qve.193.1558549225116;
        Wed, 22 May 2019 11:20:25 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u125sm2445534qkd.5.2019.05.22.11.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:20:24 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] sched: fix a compilation warning in sched_init()
Date:   Wed, 22 May 2019 14:20:06 -0400
Message-Id: <1558549206-13031-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a warning using W=1,

kernel/sched/core.c: In function 'sched_init':
kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
[-Wunused-but-set-variable]
  unsigned long alloc_size = 0, ptr;
                                ^~~
Use this opportunity to tidy up a code a bit by removing unnecssary
indentations and lines.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/sched/core.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427742a9..e7aff6d173a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5903,36 +5903,29 @@ int in_sched_functions(unsigned long addr)
 void __init sched_init(void)
 {
 	int i, j;
-	unsigned long alloc_size = 0, ptr;
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+	unsigned long alloc_size = 2 * nr_cpu_ids * sizeof(void **);
+	unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
 
-	wait_bit_init();
-
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
 #endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
-#endif
-	if (alloc_size) {
-		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
+	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.se = (struct sched_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.cfs_rq = (struct cfs_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.rt_rq = (struct rt_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_rq = (struct rt_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
 #endif /* CONFIG_RT_GROUP_SCHED */
-	}
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-- 
1.8.3.1

