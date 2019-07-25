Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABE22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zil7vD52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbfGYQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:13:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389184AbfGYQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:13:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGD9R71074627
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:13:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGD9R71074627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071189;
        bh=Sej3E0zuNeW6aNXfOe8nX4J0oZkJD6yalWbXZthvR9A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zil7vD52l8XN9bVe4DnfFqw4Nh8SzSa2sh2VFNFRiO21XgJHaI7dOCYo1kMrUlMyJ
         GToo4PmYbN2oo5t3/Az6NPDt9hewFk0UtaXhMYpaWrvNZqx1HCslELRcy873b8vW+O
         DNpvLs03thwbsLN2r5IQ+Zl1aWpEa/idTACmfvfKhbgj2qaqkt+Ao1WvmunwKaxyzh
         iBdCFSKHcDsdbPNMiXGR4seHFvvXfgacI2t97YSXAmhFRYmGvO5CN+kBSB1Jqb0kTr
         3FUWb3GSEyAOoamC0J4IGsaexR/a0LBJW1w1xWVpgNbaQpNrsyySmSXM9cXpsRMWTm
         6XY9hD2b8rj2g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGD8uD1074624;
        Thu, 25 Jul 2019 09:13:08 -0700
Date:   Thu, 25 Jul 2019 09:13:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-9434f9f5d117302cc7ddf038e7879f6871dc7a81@git.kernel.org>
Cc:     valentin.schneider@arm.com, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190715102508.32434-4-valentin.schneider@arm.com>
References: <20190715102508.32434-4-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Change task_numa_work() storage to
 static
Git-Commit-ID: 9434f9f5d117302cc7ddf038e7879f6871dc7a81
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

Commit-ID:  9434f9f5d117302cc7ddf038e7879f6871dc7a81
Gitweb:     https://git.kernel.org/tip/9434f9f5d117302cc7ddf038e7879f6871dc7a81
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 15 Jul 2019 11:25:08 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:52 +0200

sched/fair: Change task_numa_work() storage to static

There are no callers outside of fair.c.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: mgorman@suse.de
Cc: riel@surriel.com
Link: https://lkml.kernel.org/r/20190715102508.32434-4-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fd391fc00ed8..b5546a15206c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2482,7 +2482,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
  */
-void task_numa_work(struct callback_head *work)
+static void task_numa_work(struct callback_head *work)
 {
 	unsigned long migrate, next_scan, now = jiffies;
 	struct task_struct *p = current;
