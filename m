Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5555C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F62217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qPHMmkd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfGYQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:26:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387917AbfGYQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGQRP11078728
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:26:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGQRP11078728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071987;
        bh=DcEqRRNdHIaWMrKVMF3sAna3Qm1OkhcgH2BVwUKgk04=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qPHMmkd3o1p2FtMXsSVsKhfvl17APT2zkna0FVtbuL1/ArWZQjI9CeC+E+xwMWB+N
         iyPpjASohe7wzWF0qc5iAXNOQ28kIukdqNnbK9mHVfhwtxc14daE3/uPQ9oHt2Jtru
         bxTqpu8TZbF3p3ifXDAWTcmm62NCoobiq/ZZIJarmePoxUEVIhrIPAS3S1n/C9Hrmo
         t3fRqgr6/volKNwJNzT7pRE57Gh+qAn3AQpamXO1vFUFCwkSn+yW0kj9DO9DuTEkbT
         pB3KUAsOBfIU8EJK5u7fmQ5EZpRD8Qdu6eXqzm9GlKAuA9CO6LxP3719XEg407X9Kc
         SOvoprq4v2nFw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGQQfS1078725;
        Thu, 25 Jul 2019 09:26:26 -0700
Date:   Thu, 25 Jul 2019 09:26:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-a1dc0446d64966dc0ae756aebdc449f335742c13@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, cai@lca.pw, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, cai@lca.pw, hpa@zytor.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190720012319.884-1-cai@lca.pw>
References: <20190720012319.884-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Silence a warning in sched_init()
Git-Commit-ID: a1dc0446d64966dc0ae756aebdc449f335742c13
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a1dc0446d64966dc0ae756aebdc449f335742c13
Gitweb:     https://git.kernel.org/tip/a1dc0446d64966dc0ae756aebdc449f335742c13
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Fri, 19 Jul 2019 21:23:19 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:05 +0200

sched/core: Silence a warning in sched_init()

Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
will generate a compiler warning:

  kernel/sched/core.c: In function 'sched_init':
  kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used

It is unnecessary to have both "alloc_size" and "ptr", so just combine
them.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: valentin.schneider@arm.com
Link: https://lkml.kernel.org/r/20190720012319.884-1-cai@lca.pw
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 042c736b2b73..46f3ca9e392a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6430,19 +6430,19 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
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
