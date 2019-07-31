Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3973AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C581206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yXvNHivI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfGaLHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:07:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:07:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VB7LPl3643621
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 04:07:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VB7LPl3643621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564571241;
        bh=qau+9mBfFzobTAWVjgcWejzrE1fSf0Nn9rSurgLYng8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yXvNHivIAbjQVSUXZRLwtXFVRPavn1BiX46khZELsuVxkT5EOuPpejIVc4ae02DSU
         2FnWKglYHtJ8iN2ds31t5isQPO30ay9nEBmXgs0ABKj9/gVZN7JjaIBTEHPFZFLkYe
         9HFe0PQX8UzKawOUuCFvaSWuRNkEjATD1uQNhJPGVqE+zP0JxpuPy7sCaIdRpqex58
         bqv5ngdXxjURDpc2XkH7901Tm8c4vx7oNztsd75UNH2wkQd92OPGC/WOUjde3XrZo6
         yCCQGOxaoDdWp+Lv80MjyeRlCgTa4enoUGh8TPQOqKnFgDf+1Krk7c3kbAzQCc0ytu
         z7XRWXCmH7/wQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VB7KZO3643618;
        Wed, 31 Jul 2019 04:07:20 -0700
Date:   Wed, 31 Jul 2019 04:07:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-b223cc1bb098ebd1077a5390c434db411806d6b8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, juri.lelli@redhat.com
Reply-To: juri.lelli@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190731103715.4047-1-juri.lelli@redhat.com>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched/deadline: Ensure inactive_timer runs in
 hardirq context
Git-Commit-ID: b223cc1bb098ebd1077a5390c434db411806d6b8
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

Commit-ID:  b223cc1bb098ebd1077a5390c434db411806d6b8
Gitweb:     https://git.kernel.org/tip/b223cc1bb098ebd1077a5390c434db411806d6b8
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 31 Jul 2019 12:37:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jul 2019 13:01:26 +0200

sched/deadline: Ensure inactive_timer runs in hardirq context

SCHED_DEADLINE inactive timer needs to run in hardirq context (as
dl_task_timer already does) on PREEMPT_RT

Change the mode to HRTIMER_MODE_REL_HARD.

[ tglx: Fixed up the start site, so mode debugging works ]

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190731103715.4047-1-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0359612d5443..83a663a34196 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -287,7 +287,7 @@ static void task_non_contending(struct task_struct *p)
 
 	dl_se->dl_non_contending = 1;
 	get_task_struct(p);
-	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
+	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
 static void task_contending(struct sched_dl_entity *dl_se, int flags)
@@ -1292,7 +1292,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
