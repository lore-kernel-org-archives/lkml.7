Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089EBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE118206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713256;
	bh=vUcCubPw+Ol78m849nlicRTbEvuCwdVryCl8fSAdwjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GM6eI0TVjy/r7pGlf4tCB9IcELBOxg4UGtyHNQjKqx0KNz2akDI36+B3c4ZccmXZv
	 rPQBVXOQwelbeZ2B+tDP4YQjsb9uLMPLdT6bY9syHgIaxoRc3tw/Hrwdn1km57K7SO
	 YN+jwTr8ZSpLMq2C3NJqIHV0TE0BX8cepqC+zVZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbfC0TAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389644AbfC0SOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8636D2147C;
        Wed, 27 Mar 2019 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710469;
        bh=vUcCubPw+Ol78m849nlicRTbEvuCwdVryCl8fSAdwjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPPMO2Ub+KxOeEMJA5e1glkuEbQzbfq/hUBYCCpTPhbhHRGBY1enxNqkmosxgwcME
         IqYXfQ0Pp6nZYcel6MU9bYQluNHLynkLJdzkilVw9lYyWEaTYJBNvHWVvQdD3LZUT1
         JsTiXdUApFpiFAQtBGK6xM18dCSjODqvwQmS/Knk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 134/192] sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK
Date:   Wed, 27 Mar 2019 14:09:26 -0400
Message-Id: <20190327181025.13507-134-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

[ Upstream commit 1ca4fa3ab604734e38e2a3000c9abf788512ffa7 ]

register_sched_domain_sysctl() copies the cpu_possible_mask into
sd_sysctl_cpus, but only if sd_sysctl_cpus hasn't already been
allocated (ie, CONFIG_CPUMASK_OFFSTACK is set).  However, when
CONFIG_CPUMASK_OFFSTACK is not set, sd_sysctl_cpus is left
uninitialized (all zeroes) and the kernel may fail to initialize
sched_domain sysctl entries for all possible CPUs.

This is visible to the user if the kernel is booted with maxcpus=n, or
if ACPI tables have been modified to leave CPUs offline, and then
checking for missing /proc/sys/kernel/sched_domain/cpu* entries.

Fix this by separating the allocation and initialization, and adding a
flag to initialize the possible CPU entries while system booting only.

Tested-by: Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>
Tested-by: Tarumizu, Kohei <tarumizu.kohei@jp.fujitsu.com>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190129151245.5073-1-msys.mizuma@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6383aa6a60ca..141ea9ff210e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -315,6 +315,7 @@ void register_sched_domain_sysctl(void)
 {
 	static struct ctl_table *cpu_entries;
 	static struct ctl_table **cpu_idx;
+	static bool init_done = false;
 	char buf[32];
 	int i;
 
@@ -344,7 +345,10 @@ void register_sched_domain_sysctl(void)
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
+	}
 
+	if (!init_done) {
+		init_done = true;
 		/* init to possible to not have holes in @cpu_entries */
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
 	}
-- 
2.19.1

