Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2FC4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C09214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178063;
	bh=zRRSafVxTQ5grYDlfaRz+gppOToyxtG9qdrTKTUUJ/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hnoa60smRznWB77CGEYpuzFDlCEPLvZ+CKgxm4UQxTQ3xX+Q4TP4Q4odDKr/b+nTT
	 mhlNGyVwuY2UCk54Kl3oqq7ypJC+IJdfWNSbCrqFlJLcM2cDUXVB7APKmAQb4w07Ab
	 HdyZqJdRpT7Zl2UpNooCpj27qS1bqoo08NbqjKMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391103AbfIVSrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391077AbfIVSrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:47:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910A4214D9;
        Sun, 22 Sep 2019 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178059;
        bh=zRRSafVxTQ5grYDlfaRz+gppOToyxtG9qdrTKTUUJ/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6ndi1jqpjctBHCoVdYXb9BEwFLo1Vm9idjZDaBw6rETZGhZ7itm1EidiaqgN34Y9
         TECgr7CPpEtR/5mmjwjL/E00brukx7QS83wXdJijJXOFIam7t7A20A2PNWtSHc09he
         RpM1GrB0BZ/cK4eXsr6tGCDVM+/LJtiiQbfdLMVA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas RAILLARD <douglas.raillard@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 135/203] sched/cpufreq: Align trace event behavior of fast switching
Date:   Sun, 22 Sep 2019 14:42:41 -0400
Message-Id: <20190922184350.30563-135-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

[ Upstream commit 77c84dd1881d0f0176cb678d770bfbda26c54390 ]

Fast switching path only emits an event for the CPU of interest, whereas the
regular path emits an event for all the CPUs that had their frequency changed,
i.e. all the CPUs sharing the same policy.

With the current behavior, looking at cpu_frequency event for a given CPU that
is using the fast switching path will not give the correct frequency signal.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 867b4bb6d4beb..b03ca2f73713d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -117,6 +117,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 			      unsigned int next_freq)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
+	int cpu;
 
 	if (!sugov_update_next_freq(sg_policy, time, next_freq))
 		return;
@@ -126,7 +127,11 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
 		return;
 
 	policy->cur = next_freq;
-	trace_cpu_frequency(next_freq, smp_processor_id());
+
+	if (trace_cpu_frequency_enabled()) {
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(next_freq, cpu);
+	}
 }
 
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
-- 
2.20.1

