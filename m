Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96316C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7F4205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100284;
	bh=bDqKyMfXVgcsYBF/9J7WMcrOgZDjwR1isac/Sf0O1+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fstq1Jner+181wQRnBIoBQg7t+7mT669rY2HDMWTDkm4AtQXMcWt68CpjdqLU4vyB
	 n9SQFU+fq/7ZQJn70BpbABQtPOD8zpiEXxLsHSgpKMmWXknSbDePqlsgl+6EoYd++J
	 lwIxN6gYmgN9bnezdQSYgG68QC63aeUjD5MvTTfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfFIRBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfFIRBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:01:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1FA206C3;
        Sun,  9 Jun 2019 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099680;
        bh=bDqKyMfXVgcsYBF/9J7WMcrOgZDjwR1isac/Sf0O1+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2m5wdjQwUq77d+IiRGV6rOqyFNQp1U8DwzVeU/oJ3LpWf29cViBZ7eVrvzU15bPT
         U5LBcqbRjycuLmqjxYwK8oZuXiJmZlm5RiYWkRy+J7WX7amRHE6bf6BFRWnYkJOC2J
         YU0nUC63jVk7kOlw/sd7Xb0JWj5dqNAbOMBVGWhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 126/241] sched/core: Check quota and period overflow at usec to nsec conversion
Date:   Sun,  9 Jun 2019 18:41:08 +0200
Message-Id: <20190609164151.441155572@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1a8b4540db732ca16c9e43ac7c08b1b8f0b252d8 ]

Large values could overflow u64 and pass following sanity checks.

 # echo 18446744073750000 > cpu.cfs_period_us
 # cat cpu.cfs_period_us
 40448

 # echo 18446744073750000 > cpu.cfs_quota_us
 # cat cpu.cfs_quota_us
 40448

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/155125502079.293431.3947497929372138600.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d35a7d528ea66..1ef2fb4bbd6bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8460,8 +8460,10 @@ int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
-	else
+	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
 		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
 
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
@@ -8483,6 +8485,9 @@ int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
+	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
 
-- 
2.20.1



