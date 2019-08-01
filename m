Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD27C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66A72173E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N/4C99ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfHAQAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:00:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfHAQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:00:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G0SGK006734
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:00:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G0SGK006734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675228;
        bh=jSY/0wFUAVazotwIxttbJMiNiH4+Xh4HtIYT3ctqoAQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N/4C99gazAVBjNczKg9nCdDut/8sIP1Y7JiYLX+zQD23czMtG4Et8na4GS5O/ZvH2
         NogoZk1ukytqlgzFfyRsBreJnSIcu4c+P61C9ydVbMigm952BbVjt8AFiQ5+x+ZJnq
         EhYyB3cfIaiL8FRSiLnWZm5GZ4kt0FVlBa34o+usAmVJ5Y6HCy93m3xDlIu8TpLzhM
         tjkCqWT1j+VekdSu0v5sZZLG06mcBQyLR/um0c2YMi998lLHA/rXd6Dp+USwwD/FXR
         Turf/bp63UjmdPqmwrE8Ne6VW46psnpS6s10zzkeHqC8k9hf9hu69mPze5cu/oXw1p
         iwgiEh/S0JGWg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G0RAt006731;
        Thu, 1 Aug 2019 09:00:27 -0700
Date:   Thu, 1 Aug 2019 09:00:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-4394ba872c36255d25c6bde151b061f04655ebfb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, juri.lelli@redhat.com
In-Reply-To: <20190731103715.4047-1-juri.lelli@redhat.com>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched/deadline: Ensure inactive_timer runs in
 hardirq context
Git-Commit-ID: 4394ba872c36255d25c6bde151b061f04655ebfb
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

Commit-ID:  4394ba872c36255d25c6bde151b061f04655ebfb
Gitweb:     https://git.kernel.org/tip/4394ba872c36255d25c6bde151b061f04655ebfb
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 31 Jul 2019 12:37:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:43:20 +0200

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
 
