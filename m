Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9460C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804E420833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007129;
	bh=kSxDkykmz/YtayN79SAIQ24upYSTHY1sdJFVESpaadQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CY8I1mcYDZmN032m1T3l2i/aB+070WVJwVahuqPG3ZWtw+MMO1kIMR3vC26BbnB0/
	 EM9gCvRnZOmkUxot6RBfRsE1DNeMFgRD93EEhYEie3SJwqjTd+0pVgf5nPj1YnEyYm
	 6UPmm3PIMTbqld6sbYUy9o0JnTp6gD9Sms8HFes8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfEPLp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfEPLk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:40:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05DF42166E;
        Thu, 16 May 2019 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006856;
        bh=kSxDkykmz/YtayN79SAIQ24upYSTHY1sdJFVESpaadQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwNTT52XJz6S5lydSfLgWm0eoDo2mMqRqgS/2WDVavnyp0rQNxNAbkSv9qWQVYBQo
         +71GJkHxwSZpREPi7TDNbv8m1brEZyzRO6LO/tx2Vp83zgu7KaOCsRdEWLSYDyWcSl
         n7yuztSy9OIYZB48hKHt2UxyDCvEz58KOvAjAZWg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 21/25] sched/cpufreq: Fix kobject memleak
Date:   Thu, 16 May 2019 07:40:24 -0400
Message-Id: <20190516114029.8682-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516114029.8682-1-sashal@kernel.org>
References: <20190516114029.8682-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>

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
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 217f81ecae176..4e3625109b28d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -751,6 +751,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	return 0;
 
 fail:
+	kobject_put(&tunables->attr_set.kobj);
 	policy->governor_data = NULL;
 	sugov_tunables_free(tunables);
 
-- 
2.20.1

