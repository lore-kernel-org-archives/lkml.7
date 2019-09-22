Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E504C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583B0208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179302;
	bh=GvRqM0aQvpD+M+nkcgd7HWYCA8o19fhJZkvaV1up1PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+QWfKmfvnzFG7jpmyqSu0Nea+Dngr/nW2TCMi+7NcSUHY6hAFC2LdmD8YhU52ZCx
	 0Qdjo63cuU/4UUUX+svOPuQtF/qLpeOkZrWsIlHrh7KaO6JmpWv1g0eh4XToAn7Cfx
	 NtgfGD9qWpcHEa8Jo8Fi09xA+RnopYPTMpnzTDpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395221AbfIVTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395094AbfIVS7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:59:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13974208C2;
        Sun, 22 Sep 2019 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178785;
        bh=GvRqM0aQvpD+M+nkcgd7HWYCA8o19fhJZkvaV1up1PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2ZbU/7NGER5VfkwOJpV9FEgEhMnOuPElQmnzVHhs+iK35DVaxNBjKaKZgmk1o5Ph
         TofKqi1EMU2mY1XeNmwHUYFLbO/walAMdMOvva4KSC1Lhh109uN22j1vei5hE1MK2O
         MLKim3fsESTDBUfUxSD3hxwMIF0PBbTeUCPmVdso=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 09/60] sched/fair: Fix imbalance due to CPU affinity
Date:   Sun, 22 Sep 2019 14:58:42 -0400
Message-Id: <20190922185934.4305-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit f6cad8df6b30a5d2bbbd2e698f74b4cafb9fb82b ]

The load_balance() has a dedicated mecanism to detect when an imbalance
is due to CPU affinity and must be handled at parent level. In this case,
the imbalance field of the parent's sched_group is set.

The description of sg_imbalanced() gives a typical example of two groups
of 4 CPUs each and 4 tasks each with a cpumask covering 1 CPU of the first
group and 3 CPUs of the second group. Something like:

	{ 0 1 2 3 } { 4 5 6 7 }
	        *     * * *

But the load_balance fails to fix this UC on my octo cores system
made of 2 clusters of quad cores.

Whereas the load_balance is able to detect that the imbalanced is due to
CPU affinity, it fails to fix it because the imbalance field is cleared
before letting parent level a chance to run. In fact, when the imbalance is
detected, the load_balance reruns without the CPU with pinned tasks. But
there is no other running tasks in the situation described above and
everything looks balanced this time so the imbalance field is immediately
cleared.

The imbalance field should not be cleared if there is no other task to move
when the imbalance is detected.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1561996022-28829-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b314feaf91f46..d8afae1bd5c5e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7929,9 +7929,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 out_balanced:
 	/*
 	 * We reach balance although we may have faced some affinity
-	 * constraints. Clear the imbalance flag if it was set.
+	 * constraints. Clear the imbalance flag only if other tasks got
+	 * a chance to move and fix the imbalance.
 	 */
-	if (sd_parent) {
+	if (sd_parent && !(env.flags & LBF_ALL_PINNED)) {
 		int *group_imbalance = &sd_parent->groups->sgc->imbalance;
 
 		if (*group_imbalance)
-- 
2.20.1

