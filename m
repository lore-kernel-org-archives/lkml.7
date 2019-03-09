Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25649207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCIOgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:36:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfCIOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:36:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Ea3aE3108672
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:36:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Ea01J3108598;
        Sat, 9 Mar 2019 06:36:00 -0800
Date:   Sat, 9 Mar 2019 06:36:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-5105fa52df1f249f996308188dd1e85c3ae62de5@git.kernel.org>
Cc:     khlebnikov@yandex-team.ru, dave.hansen@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org, bp@alien8.de,
        lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, tj@kernel.org, riel@surriel.com
Reply-To: hannes@cmpxchg.org, bp@alien8.de, luto@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, lizefan@huawei.com,
          torvalds@linux-foundation.org, tj@kernel.org, riel@surriel.com,
          khlebnikov@yandex-team.ru, dave.hansen@linux.intel.com,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <155189230232.2620.13120481613524200065.stgit@buzz>
References: <155189230232.2620.13120481613524200065.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Fix buffer overflow in cgroup2
 property cpu.max
Git-Commit-ID: 5105fa52df1f249f996308188dd1e85c3ae62de5
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

Commit-ID:  5105fa52df1f249f996308188dd1e85c3ae62de5
Gitweb:     https://git.kernel.org/tip/5105fa52df1f249f996308188dd1e85c3ae62de5
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Wed, 6 Mar 2019 20:11:42 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:03:51 +0100

sched/core: Fix buffer overflow in cgroup2 property cpu.max

Add limit into sscanf format string for on-stack buffer.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
Link: https://lkml.kernel.org/r/155189230232.2620.13120481613524200065.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6b2c055564b5..b7a4afdc33cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6943,7 +6943,7 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 {
 	char tok[21];	/* U64_MAX */
 
-	if (!sscanf(buf, "%s %llu", tok, periodp))
+	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
