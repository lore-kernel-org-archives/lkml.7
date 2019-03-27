Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79072C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B82147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710816;
	bh=6RckVeM4IDJ1TixHhbiyG9Cd0+ldMpDtN22h2Qyns+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M6Lbx4oR4sDXC63X02LjgkMRFgweyuHMAn9aECnHz1a1zNQvKljCc90/ZChQ9HKeL
	 WGD+XUBzf76rf6PLmlPo2jdLG9I1t7IL1iwve22BBuMIBPcOiek9/Z4+33uEpXcUhV
	 youaDUJSxaKC9ZKzMT2AoCr5ee1TCNZ+tZn+EDxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390859AbfC0SUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388988AbfC0SUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C1920643;
        Wed, 27 Mar 2019 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710801;
        bh=6RckVeM4IDJ1TixHhbiyG9Cd0+ldMpDtN22h2Qyns+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMjXr88YDIDk8QvEOgjy/Op79ocz9H66kfqfAgLbxMLta1WwHBUF1Ok5AHmRphDAO
         fPdGOlLRsjCoUJlYZkyZqdn18ecY6sl9RW8Z+9BkE/Nks9CDFS02RD4sJqX5LFCYR0
         IJEMWIpazNpFq607dr2pH8AvD+8AgOJXa8xrVgUg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, cai@gmx.us,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        linux-arm-kernel@lists.infradead.org, longman@redhat.com,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 106/123] cpu/hotplug: Mute hotplug lockdep during init
Date:   Wed, 27 Mar 2019 14:16:10 -0400
Message-Id: <20190327181628.15899-106-sashal@kernel.org>
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

From: Valentin Schneider <valentin.schneider@arm.com>

[ Upstream commit ce48c457b95316b9a01b5aa9d4456ce820df94b4 ]

Since we've had:

  commit cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")

we've been getting some lockdep warnings during init, such as on HiKey960:

[    0.820495] WARNING: CPU: 4 PID: 0 at kernel/cpu.c:316 lockdep_assert_cpus_held+0x3c/0x48
[    0.820498] Modules linked in:
[    0.820509] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                4.20.0-rc5-00051-g4cae42a #34
[    0.820511] Hardware name: HiKey960 (DT)
[    0.820516] pstate: 600001c5 (nZCv dAIF -PAN -UAO)
[    0.820520] pc : lockdep_assert_cpus_held+0x3c/0x48
[    0.820523] lr : lockdep_assert_cpus_held+0x38/0x48
[    0.820526] sp : ffff00000a9cbe50
[    0.820528] x29: ffff00000a9cbe50 x28: 0000000000000000
[    0.820533] x27: 00008000b69e5000 x26: ffff8000bff4cfe0
[    0.820537] x25: ffff000008ba69e0 x24: 0000000000000001
[    0.820541] x23: ffff000008fce000 x22: ffff000008ba70c8
[    0.820545] x21: 0000000000000001 x20: 0000000000000003
[    0.820548] x19: ffff00000a35d628 x18: ffffffffffffffff
[    0.820552] x17: 0000000000000000 x16: 0000000000000000
[    0.820556] x15: ffff00000958f848 x14: 455f3052464d4d34
[    0.820559] x13: 00000000769dde98 x12: ffff8000bf3f65a8
[    0.820564] x11: 0000000000000000 x10: ffff00000958f848
[    0.820567] x9 : ffff000009592000 x8 : ffff00000958f848
[    0.820571] x7 : ffff00000818ffa0 x6 : 0000000000000000
[    0.820574] x5 : 0000000000000000 x4 : 0000000000000001
[    0.820578] x3 : 0000000000000000 x2 : 0000000000000001
[    0.820582] x1 : 00000000ffffffff x0 : 0000000000000000
[    0.820587] Call trace:
[    0.820591]  lockdep_assert_cpus_held+0x3c/0x48
[    0.820598]  static_key_enable_cpuslocked+0x28/0xd0
[    0.820606]  arch_timer_check_ool_workaround+0xe8/0x228
[    0.820610]  arch_timer_starting_cpu+0xe4/0x2d8
[    0.820615]  cpuhp_invoke_callback+0xe8/0xd08
[    0.820619]  notify_cpu_starting+0x80/0xb8
[    0.820625]  secondary_start_kernel+0x118/0x1d0

We've also had a similar warning in sched_init_smp() for every
asymmetric system that would enable the sched_asym_cpucapacity static
key, although that was singled out in:

  commit 40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")

Those warnings are actually harmless, since we cannot have hotplug
operations at the time they appear. Instead of starting to sprinkle
useless hotplug lock operations in the init codepaths, mute the
warnings until they start warning about real problems.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: cai@gmx.us
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: longman@redhat.com
Cc: marc.zyngier@arm.com
Cc: mark.rutland@arm.com
Link: https://lkml.kernel.org/r/1545243796-23224-2-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0171754db32b..469a01eee658 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -314,6 +314,15 @@ void cpus_write_unlock(void)
 
 void lockdep_assert_cpus_held(void)
 {
+	/*
+	 * We can't have hotplug operations before userspace starts running,
+	 * and some init codepaths will knowingly not take the hotplug lock.
+	 * This is all valid, so mute lockdep until it makes sense to report
+	 * unheld locks.
+	 */
+	if (system_state < SYSTEM_RUNNING)
+		return;
+
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 
-- 
2.19.1

