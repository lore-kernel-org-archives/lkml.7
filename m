Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fAeEVbzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfHATFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:05:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHATFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:05:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J5XuF071008
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:05:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J5XuF071008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686333;
        bh=tDEe8aFRwAXcNcOHMWAUpkj0SqUNKh8wuYSTiy1ip/I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fAeEVbzN7oBU1pFZvWCXT9sGvUQb3m0Spoj0XpEX2TumbUAj7Q9unTzXuk2LejnK3
         v46hf+ofLad9toawN1eMo15s1dFnL4Mw35TOB+iO73HsQl9BUQFRpwbF2BNcUf6UD0
         oT7xIeFNBw2QFDw/RSj6itQdHHCw0uHQ6BtKGMutW3UgEWhuARvVgOyJl3seQWVc9F
         DM4FQYVB4HQ0cvWtFcyKQRLdXJnNPnWhPdVfksuB3t2rZOvak3rbPfrMn+TEjq1/bL
         YB4IKTET1NPAlFZFS1n/Y4jVz4j0eD/FXhs+2xgwJdcPXGtZpV370sWYujnAnMtqhT
         GVe4ebe0xmjvw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J5XFb071005;
        Thu, 1 Aug 2019 12:05:33 -0700
Date:   Thu, 1 Aug 2019 12:05:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-850377a875a481c393ce59111b0c9725005e0eb4@git.kernel.org>
Cc:     juri.lelli@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, juri.lelli@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190731103715.4047-1-juri.lelli@redhat.com>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched/deadline: Ensure inactive_timer runs in
 hardirq context
Git-Commit-ID: 850377a875a481c393ce59111b0c9725005e0eb4
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

Commit-ID:  850377a875a481c393ce59111b0c9725005e0eb4
Gitweb:     https://git.kernel.org/tip/850377a875a481c393ce59111b0c9725005e0eb4
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Wed, 31 Jul 2019 12:37:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:22 +0200

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
 
