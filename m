Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC38C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DFD2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203293;
	bh=CpcmPpFCIP763ND42Q8No0jtLg2Te8t6IKHrz6e9t60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iT+5XSKYttlWS36VbF9j4iKAdp7htm1bwNQzF2qclUfYZTw+E4lyub3b5d8JVmwtb
	 FWUL/8I6Yfva/jfSouU4pqGFQRI80M7VZ98oZN0B3Kb1Edrlj+cW2fV5fpO+8C1pxc
	 L3U1bY5r9KaKrZawh9gnn7TvATO4HgkgbixJK4M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfGOPIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733095AbfGON6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:58:16 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D2121530;
        Mon, 15 Jul 2019 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199095;
        bh=CpcmPpFCIP763ND42Q8No0jtLg2Te8t6IKHrz6e9t60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2ZRVlqOtAEa0RqrlsHDUi4i3DBXBCraZepD+nK1S+iwPNn5B1nbH9+BmexSRiWez
         iXhf3hCjt2zczplz+eFoln5Hi0sTZMECFIZnjqR/mJL3JoAlxNl9a7JKaOFHZ8M8nZ
         4HPR0+bUQC9FRP5uNVqIrRGhI0jWmEEiaF9USu9Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 190/249] cpufreq: Avoid calling cpufreq_verify_current_freq() from handle_update()
Date:   Mon, 15 Jul 2019 09:45:55 -0400
Message-Id: <20190715134655.4076-190-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 70a59fde6e69d1d8579f84bf4555bfffb3ce452d ]

On some occasions cpufreq_verify_current_freq() schedules a work whose
callback is handle_update(), which further calls cpufreq_update_policy()
which may end up calling cpufreq_verify_current_freq() again.

On the other hand, when cpufreq_update_policy() is called from
handle_update(), the pointer to the cpufreq policy is already
available, but cpufreq_cpu_acquire() is still called to get it in
cpufreq_update_policy(), which should be avoided as well.

To fix these issues, create a new helper, refresh_frequency_limits(),
and make both handle_update() call it cpufreq_update_policy().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Rename reeval_frequency_limits() as refresh_frequency_limits() ]
[ rjw: Changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e84bf0eb7239..876a4cb09de3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1114,13 +1114,25 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	return ret;
 }
 
+static void refresh_frequency_limits(struct cpufreq_policy *policy)
+{
+	struct cpufreq_policy new_policy = *policy;
+
+	pr_debug("updating policy for CPU %u\n", policy->cpu);
+
+	new_policy.min = policy->user_policy.min;
+	new_policy.max = policy->user_policy.max;
+
+	cpufreq_set_policy(policy, &new_policy);
+}
+
 static void handle_update(struct work_struct *work)
 {
 	struct cpufreq_policy *policy =
 		container_of(work, struct cpufreq_policy, update);
-	unsigned int cpu = policy->cpu;
-	pr_debug("handle_update for cpu %u called\n", cpu);
-	cpufreq_update_policy(cpu);
+
+	pr_debug("handle_update for cpu %u called\n", policy->cpu);
+	refresh_frequency_limits(policy);
 }
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
@@ -2392,7 +2404,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 void cpufreq_update_policy(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpufreq_policy new_policy;
 
 	if (!policy)
 		return;
@@ -2405,12 +2416,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
 		goto unlock;
 
-	pr_debug("updating policy for CPU %u\n", cpu);
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
-	cpufreq_set_policy(policy, &new_policy);
+	refresh_frequency_limits(policy);
 
 unlock:
 	cpufreq_cpu_release(policy);
-- 
2.20.1

