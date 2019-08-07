Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B16C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E5B21E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbfHGRlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:41:19 -0400
Received: from foss.arm.com ([217.140.110.172]:52538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389216AbfHGRlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:41:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC32228;
        Wed,  7 Aug 2019 10:41:16 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 025043F575;
        Wed,  7 Aug 2019 10:41:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Subject: [PATCH 3/3] sched/fair: Check for CFS tasks in active_load_balance_cpu_stop()
Date:   Wed,  7 Aug 2019 18:40:26 +0100
Message-Id: <20190807174026.31242-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807174026.31242-1-valentin.schneider@arm.com>
References: <20190807174026.31242-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should really only be looking for CFS tasks, since that's all
detach_one_task() can ever pull.

Replace the rq.nr_running check with a rq.cfs.h_nr_running one to do
just that.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 79bd6ead589c..099aad1930bb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9206,8 +9206,8 @@ static int active_load_balance_cpu_stop(void *data)
 		     !busiest_rq->active_balance))
 		goto out_unlock;
 
-	/* Is there any task to move? */
-	if (busiest_rq->nr_running <= 1)
+	/* Is there any CFS task to move? */
+	if (busiest_rq->cfs.h_nr_running < 1)
 		goto out_unlock;
 
 	/*
--
2.22.0

