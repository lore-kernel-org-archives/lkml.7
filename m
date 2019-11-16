Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1567CC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC9720874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920492;
	bh=EbbfNz2ZlOjuyLlZQPVnXYerkBR9NFHbNmfKODEnyRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXrElLKJbR2gvfxW3DM0X9EXlx7h4GumUQ8I/DO875/JWKoBMcMbaQjFK4Ps8VDcG
	 Ht5M0jmlYL4MXsn9VuEH2ZFcGwWGAAKfmPNjY+kOg+0/SF/i3FiX6QHxhLMOrEq8rz
	 ON+Iau3XK72MV0FDiX11pyNITUbm5uBHroInPnW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfKPQIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbfKPPuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:50:17 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0DF208A1;
        Sat, 16 Nov 2019 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919416;
        bh=EbbfNz2ZlOjuyLlZQPVnXYerkBR9NFHbNmfKODEnyRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaLC2NuGIdgFIsLfVWqIWLQNeLFL0K2giLvTHwHfO+sixA01V1SNOT+1lHLiEI3HF
         W0oMKAVLM4HBPYSJjOipiZzQOtrxh3jGXupLYVMGU9qkG+Q2qlq4aLoaEys8ukjYOL
         ISVYkWSh5iOF84ShcY/Tim3fuv7OjxZbq2TW19Os=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, patrick.bellasi@arm.com,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 115/150] sched/fair: Don't increase sd->balance_interval on newidle balance
Date:   Sat, 16 Nov 2019 10:46:53 -0500
Message-Id: <20191116154729.9573-115-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

[ Upstream commit 3f130a37c442d5c4d66531b240ebe9abfef426b5 ]

When load_balance() fails to move some load because of task affinity,
we end up increasing sd->balance_interval to delay the next periodic
balance in the hopes that next time we look, that annoying pinned
task(s) will be gone.

However, idle_balance() pays no attention to sd->balance_interval, yet
it will still lead to an increase in balance_interval in case of
pinned tasks.

If we're going through several newidle balances (e.g. we have a
periodic task), this can lead to a huge increase of the
balance_interval in a very small amount of time.

To prevent that, don't increase the balance interval when going
through a newidle balance.

This is a similar approach to what is done in commit 58b26c4c0257
("sched: Increment cache_nice_tries only on periodic lb"), where we
disregard newidle balance and rely on periodic balance for more stable
results.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: patrick.bellasi@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1537974727-30788-2-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index feeb52880d353..67433fbdcb5a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8319,13 +8319,22 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	sd->nr_balance_failed = 0;
 
 out_one_pinned:
+	ld_moved = 0;
+
+	/*
+	 * idle_balance() disregards balance intervals, so we could repeatedly
+	 * reach this code, which would lead to balance_interval skyrocketting
+	 * in a short amount of time. Skip the balance_interval increase logic
+	 * to avoid that.
+	 */
+	if (env.idle == CPU_NEWLY_IDLE)
+		goto out;
+
 	/* tune up the balancing interval */
 	if (((env.flags & LBF_ALL_PINNED) &&
 			sd->balance_interval < MAX_PINNED_INTERVAL) ||
 			(sd->balance_interval < sd->max_interval))
 		sd->balance_interval *= 2;
-
-	ld_moved = 0;
 out:
 	return ld_moved;
 }
-- 
2.20.1

