Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BCC2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TfoRqS75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfECLam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:30:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfECLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:30:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43BUTju2725205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 04:30:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43BUTju2725205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556883030;
        bh=3BfSVPAM+qx8rQp0PB3FlMCmi5oGxDl3bMgwe05o2mo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TfoRqS75ibJUkFr1j6xx75cGO0YrnWVHKJriZDES41Oo5LIWe7Jn9aHbRa3Bnhnmj
         FJG86X7kURLwaa4JrFzA4GwWFqCq7RY9ivr9hMBZevgS0VqYO0E87U1e1E/f5V82uU
         mglhDphxm6s619Behtaj5jA5zL6dEZFvLLkdxJn83lsb334ilT3TJLUGsaJX/ugqH0
         TATyLE0q0+6ZtDe6EBcvCEOUsLpvVaUlAZfG3w3DoMDlwC3rQShc9iv64R5rhxx5Yl
         WrbmV9U0CTdcaIJF4bjkvghXdUe8Ve5kxNSYEkNMC5887+wojxkyAd5obw1EuUa/k0
         wKs/K3bUHp3tQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43BUTv02725202;
        Fri, 3 May 2019 04:30:29 -0700
Date:   Fri, 3 May 2019 04:30:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-e9a140c6d20ee29951a193342ebaccf07ebc63eb@git.kernel.org>
Cc:     npiggin@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        fweisbec@gmail.com, mingo@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          npiggin@gmail.com, torvalds@linux-foundation.org,
          fweisbec@gmail.com, peterz@infradead.org,
          rafael.j.wysocki@intel.com, mingo@kernel.org
In-Reply-To: <20190411033448.20842-5-npiggin@gmail.com>
References: <20190411033448.20842-5-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/isolation: Require a present CPU in
 housekeeping mask
Git-Commit-ID: e9a140c6d20ee29951a193342ebaccf07ebc63eb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e9a140c6d20ee29951a193342ebaccf07ebc63eb
Gitweb:     https://git.kernel.org/tip/e9a140c6d20ee29951a193342ebaccf07ebc63eb
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 12:53:14 +0200

sched/isolation: Require a present CPU in housekeeping mask

During housekeeping mask setup, currently a possible CPU is required.
That does not guarantee the CPU would be available at boot time, so
check to ensure that at least one present CPU is in the mask.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lkml.kernel.org/r/20190411033448.20842-5-npiggin@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/isolation.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b02d148e7672..687302051a27 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -65,6 +65,7 @@ void __init housekeeping_init(void)
 static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
+	cpumask_var_t tmp;
 	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
@@ -75,16 +76,23 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		return 0;
 	}
 
+	alloc_bootmem_cpumask_var(&tmp);
 	if (!housekeeping_flags) {
 		alloc_bootmem_cpumask_var(&housekeeping_mask);
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
-		if (cpumask_empty(housekeeping_mask))
+
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp)) {
+			pr_warn("Housekeeping: must include one present CPU, "
+				"using boot CPU:%d\n", smp_processor_id());
 			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+		}
 	} else {
-		cpumask_var_t tmp;
-
-		alloc_bootmem_cpumask_var(&tmp);
+		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+		if (cpumask_empty(tmp))
+			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
 		if (!cpumask_equal(tmp, housekeeping_mask)) {
 			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
@@ -92,8 +100,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
 		}
-		free_bootmem_cpumask_var(tmp);
 	}
+	free_bootmem_cpumask_var(tmp);
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
 		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
