Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB7B2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554434;
	bh=2Ej++43+0ra7hQ2n3/xZ3y5xmW7GGAxykRpfXfRSlHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgIUgYiTNP2MELQ/VOA/zQMp6UzCcOdMWonpVRTMwXPg7QXHguGW+jOOG7ZO+n/1T
	 OADtDeGHE0XjoZX5Di5qdfTKSk0JuK//cE2hW2wh81LxN0Z9W5lFGsOcsvpZOeJtn8
	 glbUhUVPtToQ69F6Ef5L9aZg5LAe59HFSR+bNoFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbfEVTrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbfEVT1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:27:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364B420879;
        Wed, 22 May 2019 19:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553250;
        bh=2Ej++43+0ra7hQ2n3/xZ3y5xmW7GGAxykRpfXfRSlHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhCH2P8DMvjHxDnDk2ufsO8fpCfk3fSdxtSZJP0+dhLAG+xfT0KwmQk45p9EJ1+cL
         aT3XEYBBiR8k8fYERumt/me7GoQfxIeyq6C5Y+E1Vfq2r+8PxrZt5sL0Oii2LK8sQt
         EnHdGL88XU2BK5xHNohUlrbBfUqq1+3v97e6iooU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 034/244] sched/cpufreq: Fix kobject memleak
Date:   Wed, 22 May 2019 15:23:00 -0400
Message-Id: <20190522192630.24917-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 9a4f26cc98d81b67ecc23b890c28e2df324e29f3 ]

Currently the error return path from kobject_init_and_add() is not
followed by a call to kobject_put() - which means we are leaking
the kobject.

Fix it by adding a call to kobject_put() in the error path of
kobject_init_and_add().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tobin C. Harding <tobin@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: http://lkml.kernel.org/r/20190430001144.24890-1-tobin@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c          | 1 +
 drivers/cpufreq/cpufreq_governor.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 505c9a55d5551..d3213594d1a7a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1103,6 +1103,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		kobject_put(&policy->kobj);
 		goto err_free_real_cpus;
 	}
 
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 6d53f7d9fc7a9..69fc5cf4782fb 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -459,6 +459,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	/* Failure, so roll back. */
 	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
 
+	kobject_put(&dbs_data->attr_set.kobj);
+
 	policy->governor_data = NULL;
 
 	if (!have_governor_per_policy())
-- 
2.20.1

