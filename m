Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A566215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887014;
	bh=s3CGvjS4iv6lqtw9qf0dsHz4Mb21EKg5poi6xwHyv1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n2fl6Aj+t8Nhi8ilbdR7VsMbFtEYGR7lysHJvdvC+0EyLLrkyVZcIi2y6K2DnB/6j
	 iFqOa/3tA3qnJmh5508xxxUdad3aX9cWhetoQ5i1l7Kj6cfOVckSqpzs1xDDC3MPso
	 M9knsxsx7xu6gSo96EaWszvweT3ZJ32mhUj7ZJXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfK0Ugx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfK0Ugu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:36:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC1521569;
        Wed, 27 Nov 2019 20:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887009;
        bh=s3CGvjS4iv6lqtw9qf0dsHz4Mb21EKg5poi6xwHyv1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CPgWoMnNxtDMxuZFl69z8oWVhD4iyvaZIBZKFe/s8ckoGilQWxMpYKNBJaY89Wj6
         TSzgPx911IZOuYgDJNBB2KGE18JNQ0+kklF30HIa2Z/my+B3f/pvXXFoZKC7BZ9jU8
         w9W67XVYwgqRkZCRpuVSR5ms5S9fXvWcooB2VEVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, patrick.bellasi@arm.com,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 079/132] sched/fair: Dont increase sd->balance_interval on newidle balance
Date:   Wed, 27 Nov 2019 21:31:10 +0100
Message-Id: <20191127203010.440551269@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index cd2fb8384fbe3..d012681fb1abd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7334,13 +7334,22 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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



