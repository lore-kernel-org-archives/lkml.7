Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782052075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712526;
	bh=/SN4psYJCM2Qvm1WDSJuHA6QWrwu2nlaHi9+3ChjUZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gw9d8jnBDHS+5wc/IRTaV0lmEzVEu7OjVz+6IKJ4/NEdQbJ3NteBGMucdp/pqhMrj
	 F8z1VvmRRKorC+aZTqbfCt8n4iqrigmaQtSOhlni+X18CRqoQ03ZsS6PQDPcOx6Id6
	 y/EkoEBjwe/KNUbU33RJBhd0oBiH7AWAtLpBjUes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfC0Sso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389555AbfC0STF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC9822063F;
        Wed, 27 Mar 2019 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710744;
        bh=/SN4psYJCM2Qvm1WDSJuHA6QWrwu2nlaHi9+3ChjUZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPhxnBVQVfIAgh7eBfNUdeHquOe4QSs9cC1lcAh4oH6OZYB25LRI3MoGtzr5y2W0T
         gpXiOlclPi/cOFvGKnVQwhtbIHVPFO4BJUfK0/AJfSZHpjVdyd+FdwaXXBckZb3Lgj
         o5AV3EiKEILXJT1xFB3TaBeL+vKX4atu01L1a8PU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 085/123] sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK
Date:   Wed, 27 Mar 2019 14:15:49 -0400
Message-Id: <20190327181628.15899-85-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
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
index 2f93e4a2d9f6..187c04a34ba1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -339,6 +339,7 @@ void register_sched_domain_sysctl(void)
 {
 	static struct ctl_table *cpu_entries;
 	static struct ctl_table **cpu_idx;
+	static bool init_done = false;
 	char buf[32];
 	int i;
 
@@ -368,7 +369,10 @@ void register_sched_domain_sysctl(void)
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

