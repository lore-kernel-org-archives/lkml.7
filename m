Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2486C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 01:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A689B20873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 01:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="j3D1XjXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbfGTBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 21:23:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32860 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbfGTBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 21:23:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so28787339qtt.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sycMcUcoeC9bn38OVaHWWfc+SOTmaJGA01wVQbaVLhA=;
        b=j3D1XjXjtg4zmql5wk+RMkmqZD5Hle6ME7GgXhWWtj8Fw7LX1e/blGU6w6B+QOXkAq
         rktRz22Y//T2SZXOBJeqawf3WEQRfXMiHsKs4YvwkBLOj4k4RpSBiie9fD0+3IePxl4S
         +riIyWNdtSpgQwK9FkiSHPAinVCXfK9BWwgqM0+Z4tI4PikqpMHDz3RQ+XtgP/MUtS7y
         C7NgaggySyC7oCEI3QiZGyAOQunwNnID6P7sMMc/Ky61Gjk4gy18vBae/lZAsnn05QGs
         XxyceRD36zVI24ThdFWO3bRcG3rIYA+BWavT/5NzJj2ivwk7LF5azM//CPZUxrRbeFLo
         4fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sycMcUcoeC9bn38OVaHWWfc+SOTmaJGA01wVQbaVLhA=;
        b=myPybs9FmcS3PaS4cvPFQNvbP+6JWTvK3v1DR+h8PLNxhqmM3/tVz9xOPkt32BnAIT
         qpdFP53hTrmfJLJk0m2iS1xfd3JIX/hkf3twkBuzgqRMrngFhSgCpgfXZ/7Vv6Mc8dnn
         b7bTnQK87sOHqaqZAUM83ByUekiS5apfKfjGt/WA7WtBA6jk2eQNKz0Wrirj6r5XT+9i
         9+aC80jiUunv4yczMSOmoi/kDsu+jKpW8aWqOrgASkd+3psI550f/ewLzfNzLc4xiUVR
         otoD749liZEWdRpqGwvP1dJDGyI5KtHd8+gpflJ1sQPtCRBCn4x9+q1g3mXypJvYYOwl
         Y6wQ==
X-Gm-Message-State: APjAAAWj/pbpMvz7JdAsG1v2BWjgBW94hwBNDP4t9r9M79/ybuC25UKJ
        ADwClY9DEIdN8WPXkxwqOu33OA==
X-Google-Smtp-Source: APXvYqz7v2dDsHo+mKy4sc2jHdJtjMacRYbAbU+2Bx2jjwOuBdsfQO33fBZMHYtC2f1dUlaDo8NRjw==
X-Received: by 2002:a0c:bd86:: with SMTP id n6mr40840893qvg.183.1563585834497;
        Fri, 19 Jul 2019 18:23:54 -0700 (PDT)
Received: from localhost.localdomain (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p3sm22707150qta.12.2019.07.19.18.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 18:23:53 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v4] sched/core: silence a warning in sched_init()
Date:   Fri, 19 Jul 2019 21:23:19 -0400
Message-Id: <20190720012319.884-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a compiler warning,

kernel/sched/core.c: In function 'sched_init':
kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
[-Wunused-but-set-variable]
 unsigned long alloc_size = 0, ptr;
                               ^~~
It is unnecessary to have both "alloc_size" and "ptr", so just combine
them.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v4: Combine "alloc_size" and "ptr" together.
v3: Use a different approach to see if Peter will like it.
v2: Incorporate the feedback from Valentin.

 kernel/sched/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..6eefaeea4c88 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6371,19 +6371,19 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 void __init sched_init(void)
 {
-	unsigned long alloc_size = 0, ptr;
+	unsigned long ptr = 0;
 	int i;
 
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
+	ptr += 2 * nr_cpu_ids * sizeof(void **);
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
-	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
+	ptr += 2 * nr_cpu_ids * sizeof(void **);
 #endif
-	if (alloc_size) {
-		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
+	if (ptr) {
+		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		root_task_group.se = (struct sched_entity **)ptr;
-- 
2.20.1 (Apple Git-117)

