Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A08F20449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254339;
	bh=0wIxtgCIcRX9SNXLhm7v1Zyg5DJEwZRWfzBZ8VR8Fvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZk42fMsUXLsktfzu21SY9tMxF+QseavraP2q4bJ3rLbFyL7ixqUC5IugIjrW8NwG
	 BLMaGyxzW5ckEKJsxY4wEbMP334I7TPlFnGuJtVwymCzWG7u6G5hwEYuZq4WC4OVCK
	 eVs6QDgWdGo8WPa7p56hu++f3lYQR91m7rWEz76E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfCVLcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbfCVLcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A38420449;
        Fri, 22 Mar 2019 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254334;
        bh=0wIxtgCIcRX9SNXLhm7v1Zyg5DJEwZRWfzBZ8VR8Fvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqyniN0In7DqTK9acX6VbCBDvNcgxM2BDuC7wkdZC104AoDSQp3YvwkNiYuJ0ONF7
         MXo7axNKMu0Rql6H0BpSRAPB6GjU9PIrLh3JBOAQ0+CO5gmKDQ40kt9Cn+fwdhnk8n
         lvJROz2V64nE6JC4yqfpUDdUE947XNnEkpwQfsgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 086/230] xtensa: SMP: fix secondary CPU initialization
Date:   Fri, 22 Mar 2019 12:13:44 +0100
Message-Id: <20190322111242.651736437@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 32a7726c4f4aadfabdb82440d84f88a5a2c8fe13 ]

- add missing memory barriers to the secondary CPU synchronization spin
  loops; add comment to the matching memory barrier in the boot_secondary
  and __cpu_die functions;
- use READ_ONCE/WRITE_ONCE to access cpu_start_id/cpu_start_ccount
  instead of reading/writing them directly;
- re-initialize cpu_running every time before starting secondary CPU to
  flush possible previous CPU startup results.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/kernel/head.S |  5 ++++-
 arch/xtensa/kernel/smp.c  | 34 +++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index c7b3bedbfffe..e3823b4f9d08 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -286,12 +286,13 @@ should_never_return:
 
 	movi	a2, cpu_start_ccount
 1:
+	memw
 	l32i	a3, a2, 0
 	beqi	a3, 0, 1b
 	movi	a3, 0
 	s32i	a3, a2, 0
-	memw
 1:
+	memw
 	l32i	a3, a2, 0
 	beqi	a3, 0, 1b
 	wsr	a3, ccount
@@ -328,11 +329,13 @@ ENTRY(cpu_restart)
 	rsr	a0, prid
 	neg	a2, a0
 	movi	a3, cpu_start_id
+	memw
 	s32i	a2, a3, 0
 #if XCHAL_DCACHE_IS_WRITEBACK
 	dhwbi	a3, 0
 #endif
 1:
+	memw
 	l32i	a2, a3, 0
 	dhi	a3, 0
 	bne	a2, a0, 1b
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 4d02e38514f5..545144d1431d 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -192,9 +192,11 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 	int i;
 
 #ifdef CONFIG_HOTPLUG_CPU
-	cpu_start_id = cpu;
-	system_flush_invalidate_dcache_range(
-			(unsigned long)&cpu_start_id, sizeof(cpu_start_id));
+	WRITE_ONCE(cpu_start_id, cpu);
+	/* Pairs with the third memw in the cpu_restart */
+	mb();
+	system_flush_invalidate_dcache_range((unsigned long)&cpu_start_id,
+					     sizeof(cpu_start_id));
 #endif
 	smp_call_function_single(0, mx_cpu_start, (void *)cpu, 1);
 
@@ -203,18 +205,21 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
 			ccount = get_ccount();
 		while (!ccount);
 
-		cpu_start_ccount = ccount;
+		WRITE_ONCE(cpu_start_ccount, ccount);
 
-		while (time_before(jiffies, timeout)) {
+		do {
+			/*
+			 * Pairs with the first two memws in the
+			 * .Lboot_secondary.
+			 */
 			mb();
-			if (!cpu_start_ccount)
-				break;
-		}
+			ccount = READ_ONCE(cpu_start_ccount);
+		} while (ccount && time_before(jiffies, timeout));
 
-		if (cpu_start_ccount) {
+		if (ccount) {
 			smp_call_function_single(0, mx_cpu_stop,
-					(void *)cpu, 1);
-			cpu_start_ccount = 0;
+						 (void *)cpu, 1);
+			WRITE_ONCE(cpu_start_ccount, 0);
 			return -EIO;
 		}
 	}
@@ -234,6 +239,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	pr_debug("%s: Calling wakeup_secondary(cpu:%d, idle:%p, sp: %08lx)\n",
 			__func__, cpu, idle, start_info.stack);
 
+	init_completion(&cpu_running);
 	ret = boot_secondary(cpu, idle);
 	if (ret == 0) {
 		wait_for_completion_timeout(&cpu_running,
@@ -295,8 +301,10 @@ void __cpu_die(unsigned int cpu)
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	while (time_before(jiffies, timeout)) {
 		system_invalidate_dcache_range((unsigned long)&cpu_start_id,
-				sizeof(cpu_start_id));
-		if (cpu_start_id == -cpu) {
+					       sizeof(cpu_start_id));
+		/* Pairs with the second memw in the cpu_restart */
+		mb();
+		if (READ_ONCE(cpu_start_id) == -cpu) {
 			platform_cpu_kill(cpu);
 			return;
 		}
-- 
2.19.1



