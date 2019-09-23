Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53828C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340DE20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405923AbfIWJap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:30:45 -0400
Received: from foss.arm.com ([217.140.110.172]:39460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405719AbfIWJap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:30:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D3711000;
        Mon, 23 Sep 2019 02:30:42 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 368293F59C;
        Mon, 23 Sep 2019 02:30:41 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de
Subject: [PATCH] sched/core: Remove double update_max_interval() call on CPU startup
Date:   Mon, 23 Sep 2019 10:30:17 +0100
Message-Id: <20190923093017.11755-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_max_interval() is called in both CPUHP_AP_SCHED_STARTING's startup
and teardown callbacks, but it turns out it's also called at the end of
the startup callback of CPUHP_AP_ACTIVE (which is further down the
startup sequence).

There's no point in repeating this interval update in the startup sequence
since the CPU will remain online until it goes down the teardown path.

Remove the redundant call in sched_cpu_activate() (CPUHP_AP_ACTIVE).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87b84a726db4..6b94e71f659e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6418,9 +6418,6 @@ int sched_cpu_activate(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-	update_max_interval();
-
 	return 0;
 }
 
--
2.22.0

