Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF799C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DA220665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfGOK0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:26:24 -0400
Received: from foss.arm.com ([217.140.110.172]:46870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbfGOK0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:26:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 818D8150C;
        Mon, 15 Jul 2019 03:26:19 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 909773F59C;
        Mon, 15 Jul 2019 03:26:18 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, mgorman@suse.de,
        riel@surriel.com
Subject: [PATCH 3/3] sched/fair: Change task_numa_work() storage to static
Date:   Mon, 15 Jul 2019 11:25:08 +0100
Message-Id: <20190715102508.32434-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715102508.32434-1-valentin.schneider@arm.com>
References: <20190715102508.32434-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no callers outside of fair.c.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 74faa55bc52a..c747ce05e726 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2428,7 +2428,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
  * The expensive part of numa migration is done from task_work context.
  * Triggered from task_tick_numa().
  */
-void task_numa_work(struct callback_head *work)
+static void task_numa_work(struct callback_head *work)
 {
 	unsigned long migrate, next_scan, now = jiffies;
 	struct task_struct *p = current;
-- 
2.22.0

