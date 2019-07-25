Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A214C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2006B21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="282jotNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfGYOK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:10:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfGYOKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:10:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEAA0T1034455
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:10:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEAA0T1034455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564063810;
        bh=wDu+dk/cAqPch7gPml/O3THYEPTwUlxjV8lvrRGyTLk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=282jotNiEriB7YTY7TL90x4+cdjgHNW7AEnEzXb/UbZvRPyj0Eszjeb3nP5k76NAy
         s5r2zDq3d0Vqj/9uY5oBOhO2d8G2qhwt5c9zEB7bbzDhyE3aq51GdYuuRNBNZySTLK
         NxAv/3COtUpKT7n/Ko50M/FcP1c2lUSSRpLyQcVB6WNz5Wl1LyuZj4cRnIc2KgXg/y
         ySxzocUQA+WUQVcMjT4Ztzo5SPjOnTaoRHL93kGt9MD0paO9x/crx/jYBB370DSI54
         cDnNERBEvX1OdOdOFf0G/sdNKWRZwBIMDrIEr6Xuy4LpAXSKC1W/KSm3vMjHW3DjpG
         YM/klSSEvkPaA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEA9nl1034452;
        Thu, 25 Jul 2019 07:10:09 -0700
Date:   Thu, 25 Jul 2019 07:10:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e797bda3fd29137f6c151dfa10ea6a61c17895ce@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190722105219.818822855@linutronix.de>
References: <20190722105219.818822855@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] smp/hotplug: Track booted once CPUs in a cpumask
Git-Commit-ID: e797bda3fd29137f6c151dfa10ea6a61c17895ce
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

Commit-ID:  e797bda3fd29137f6c151dfa10ea6a61c17895ce
Gitweb:     https://git.kernel.org/tip/e797bda3fd29137f6c151dfa10ea6a61c17895ce
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 15:47:37 +0200

smp/hotplug: Track booted once CPUs in a cpumask

The booted once information which is required to deal with the MCE
broadcast issue on X86 correctly is stored in the per cpu hotplug state,
which is perfectly fine for the intended purpose.

X86 needs that information for supporting NMI broadcasting via shortcuts,
but retrieving it from per cpu data is cumbersome.

Move it to a cpumask so the information can be checked against the
cpu_present_mask quickly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.818822855@linutronix.de

---
 include/linux/cpumask.h |  2 ++
 kernel/cpu.c            | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c3..693124900f0a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -115,6 +115,8 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_active(cpu)		((cpu) == 0)
 #endif
 
+extern cpumask_t cpus_booted_once_mask;
+
 static inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
 {
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e84c0873559e..05778e32674a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -62,7 +62,6 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
-	bool			booted_once;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -76,6 +75,10 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
+#ifdef CONFIG_SMP
+cpumask_t cpus_booted_once_mask;
+#endif
+
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -433,7 +436,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	 * CPU. Otherwise, a broadacasted MCE observing CR4.MCE=0b on any
 	 * core will shutdown the machine.
 	 */
-	return !per_cpu(cpuhp_state, cpu).booted_once;
+	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
@@ -1066,7 +1069,7 @@ void notify_cpu_starting(unsigned int cpu)
 	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
-	st->booted_once = true;
+	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
 	while (st->state < target) {
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
@@ -2334,7 +2337,7 @@ void __init boot_cpu_init(void)
 void __init boot_cpu_hotplug_init(void)
 {
 #ifdef CONFIG_SMP
-	this_cpu_write(cpuhp_state.booted_once, true);
+	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
