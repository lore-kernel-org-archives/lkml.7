Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A488922BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cmWw9LTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbfGYQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:14:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52763 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389047AbfGYQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:14:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGDrEG1074723
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:13:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGDrEG1074723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071234;
        bh=8yVF7IZrgX50g7djFY4XHNWwrGK56BFLFrBlWT3Mc8s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cmWw9LTSIlsem7fMutmEj0Vm0QAkBIz2UDGgXB8U4+KzKs8VzYN4ij3BW3fPlxJUa
         zW3/eqPySD38w3Gq1gNMFBIk2LREXswb3zAmIyYX2GTUULpNqSRNg4YSaLkLrfXTMi
         zKsMW6j+Jdc0IJG5hLVkYQoCCoZ9mo2xo4DbNGeFBiHWapPoL3rE7jktCj6wMW1R94
         6fux6dqycZMTYbWkatRoZyoyhZIkVNzWBtwHSVSN02JCsk7Oo+wEyO5BAlvTao2JB7
         ITFfBMJo753wCA+SY/OJ3DlhPAW2vRqlTwF1T1wIXYiEqmhvnVSSFPnWGTe1hK9Bce
         9e+cefl4lr+vQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGDqLl1074720;
        Thu, 25 Jul 2019 09:13:52 -0700
Date:   Thu, 25 Jul 2019 09:13:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-f6cad8df6b30a5d2bbbd2e698f74b4cafb9fb82b@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, vincent.guittot@linaro.org,
          torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
References: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix imbalance due to CPU affinity
Git-Commit-ID: f6cad8df6b30a5d2bbbd2e698f74b4cafb9fb82b
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

Commit-ID:  f6cad8df6b30a5d2bbbd2e698f74b4cafb9fb82b
Gitweb:     https://git.kernel.org/tip/f6cad8df6b30a5d2bbbd2e698f74b4cafb9fb82b
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Mon, 1 Jul 2019 17:47:02 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:52 +0200

sched/fair: Fix imbalance due to CPU affinity

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
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b5546a15206c..9be36ffb5689 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9048,9 +9048,10 @@ more_balance:
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
