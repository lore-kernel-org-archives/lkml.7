Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B450C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00124233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494255;
	bh=P70geCj8NkRYahbgDe4eJ2CV5IMgGeWdoyYlOA1e7jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/bdk58A2UgPBjINPRaEt5SPzwiFsnlAJ7wGAmwE3UZFvP3vzPAWLNYuHm81oqZNU
	 B6RjW5Dfju1AMKc3lFIp5IJM9vd0jAptePMoBR711FMUTPI7XDJ8TVcAElMn9F/lxq
	 M/brFOmElartqF22x6nA1zvypYI56pbAxe4c3sIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbfHVRI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390278AbfHVRIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:22 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5B923406;
        Thu, 22 Aug 2019 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493701;
        bh=P70geCj8NkRYahbgDe4eJ2CV5IMgGeWdoyYlOA1e7jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwjzNmWphoEDdk9k+DfOaYD0zPdDDmX5N9vbdXpt+E6vDv9eUgON+b/fk7tUJkG19
         JIPCzCqUPD9Ihrzinxg/CkaFBTocyuX5q1+VYXZtEZE38uBry7s60Yb261hv4p6Fe0
         fOEcRRpaPRYLbjGVonrrmNCvypMevURLbtP5bUG0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 012/135] cpufreq: schedutil: Don't skip freq update when limits change
Date:   Thu, 22 Aug 2019 13:06:08 -0400
Message-Id: <20190822170811.13303-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 600f5badb78c316146d062cfd7af4a2cfb655baa upstream.

To avoid reducing the frequency of a CPU prematurely, we skip reducing
the frequency if the CPU had been busy recently.

This should not be done when the limits of the policy are changed, for
example due to thermal throttling. We should always get the frequency
within the new limits as soon as possible.

Trying to fix this by using only one flag, i.e. need_freq_update, can
lead to a race condition where the flag gets cleared without forcing us
to change the frequency at least once. And so this patch introduces
another flag to avoid that race condition.

Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
Cc: v4.18+ <stable@vger.kernel.org> # v4.18+
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 962cf343f798f..ae3ec77bb92f6 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -40,6 +40,7 @@ struct sugov_policy {
 	struct task_struct	*thread;
 	bool			work_in_progress;
 
+	bool			limits_changed;
 	bool			need_freq_update;
 };
 
@@ -89,8 +90,11 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	    !cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->need_freq_update))
+	if (unlikely(sg_policy->limits_changed)) {
+		sg_policy->limits_changed = false;
+		sg_policy->need_freq_update = true;
 		return true;
+	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -427,7 +431,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->need_freq_update = true;
+		sg_policy->limits_changed = true;
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -447,7 +451,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	busy = sugov_cpu_is_busy(sg_cpu);
+	/* Limits may have changed, don't skip frequency update */
+	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
@@ -821,6 +826,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
+	sg_policy->limits_changed		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
 
@@ -869,7 +875,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->need_freq_update = true;
+	sg_policy->limits_changed = true;
 }
 
 struct cpufreq_governor schedutil_gov = {
-- 
2.20.1

