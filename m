Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E87C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86C7217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369417;
	bh=r5DgWeTdEcF1hOAtTU54is8LPwLqAafydhWJ7i6ef5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P/V5Gr/nea8Tq7IcoI+PzNgvlXqWIq4fdf0KHtoRwUact1RnFEvLByVDgIVbOE3ge
	 QdMryH3zaeTTTWyLHGhovNYRv0vXDmz7PozgWBwusW8VkMIMqtHL0RzFbut1ubjuc8
	 +FUqPMLLJmWeorNQYLoOY60eNXKKRPBHW6GBrzUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfDDJQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbfDDJQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3834120693;
        Thu,  4 Apr 2019 09:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369412;
        bh=r5DgWeTdEcF1hOAtTU54is8LPwLqAafydhWJ7i6ef5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtimH7z+hZOBMB80/eWkKcFp6JAtmXeRKsOKDuobmkctv/Ycjr8OpidI7E6+EUbc+
         SyO97vFF3NebuJTczQk/IG1HniBDK4PTbhhM6wBKkRv/gcSVbZAWbBnCHTuNc6KuEw
         dv8UjvkvDXuWl3/xo3BhgK+8MtXz77sKCMNaIKkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, cai@gmx.us,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        linux-arm-kernel@lists.infradead.org, longman@redhat.com,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 214/246] cpu/hotplug: Mute hotplug lockdep during init
Date:   Thu,  4 Apr 2019 10:48:34 +0200
Message-Id: <20190404084626.685559617@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 47f695d80dd1..6754f3ecfd94 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -313,6 +313,15 @@ void cpus_write_unlock(void)
 
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



