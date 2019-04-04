Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0A0C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96022214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554374535;
	bh=vni2/i4c8GhakK2w2EUjsFfFtDtf4e+bZfULiLKCx4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZ1++qoOJ5RxR3ZK0JT4Kio53K4Qq1Ku77GtgzbulUX5gRoBCq+vaZW3b9ud08dZp
	 xakibmTfhAmumHE35seovrns4XiYhE3+oILc5thI+lw3fkaEk8XM50TYoCS/2paqyo
	 cChLw0erYY2BZRH3+Bm/G+tkZKddhsN54s46GF+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfDDKmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDKmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:42:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7DD20855;
        Thu,  4 Apr 2019 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554374533;
        bh=vni2/i4c8GhakK2w2EUjsFfFtDtf4e+bZfULiLKCx4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzcJi+q6trFS7Mq2dIXK7QE4utVyUV2noHZnmDzsv+2zlH/CyAY0ppCIdlNOHKLA/
         FBb4iCZlhzlw9x+m5beJ+rD7SB4/JZ4+8Q5vTGyKaXRc+uDmJP5QUpUaTs3jzflkrF
         qafb+ihQyxHjgQClzdA7zvXIqqFRuly8tP1MdTX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>,
        "Tarumizu, Kohei" <tarumizu.kohei@jp.fujitsu.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 086/121] sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK
Date:   Thu,  4 Apr 2019 10:47:54 +0200
Message-Id: <20190404084549.907798535@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



