Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411753;
	bh=sc1dDyAKOn7+QN7hcjUMjtAW7GzMKZVhNJRh2NpQ9EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mpw0FegqlaekwMotI+pLAIwoUetzcQV7xQETNKXb4LRNvshcZDI0BRoa1SZZ//Z7c
	 rWcZCBL9f7CVjXB5xQT0NKJiac2ZsqL7/0UvipkiPJsuAuk9tNZwKI5ALct7aAMDZc
	 IwW53eJeShLI0Zq6hY4DvrAkk6bU5Wh2ILBp9fEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfCLRR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfCLRQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:19 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2A221850;
        Tue, 12 Mar 2019 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410978;
        bh=sc1dDyAKOn7+QN7hcjUMjtAW7GzMKZVhNJRh2NpQ9EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ZmHsVC1HduOLsf4fL/OhFCh90Dx2xq/xFoYTh9r14t1zmvVJ6+PPZ+XgrtAOPp9t
         /HQUAW+rJcgOl4Jl0+GSajehnNuZSJ0bwvTzZMlmaCYmzogMD7+xo2vo69BhAwWyJM
         5KeEELgod9ji3Ay5wyIWLokkOgwt0rnGSSRO74nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/135] xtensa: SMP: fix secondary CPU initialization
Date:   Tue, 12 Mar 2019 10:08:21 -0700
Message-Id: <20190312170346.165997501@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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
index 27c8e07ace43..29f445b410b3 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -281,12 +281,13 @@ should_never_return:
 
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
@@ -323,11 +324,13 @@ ENTRY(cpu_restart)
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
index 932d64689bac..c9fc2c4f71b3 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -195,9 +195,11 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
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
 
@@ -206,18 +208,21 @@ static int boot_secondary(unsigned int cpu, struct task_struct *ts)
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
@@ -237,6 +242,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	pr_debug("%s: Calling wakeup_secondary(cpu:%d, idle:%p, sp: %08lx)\n",
 			__func__, cpu, idle, start_info.stack);
 
+	init_completion(&cpu_running);
 	ret = boot_secondary(cpu, idle);
 	if (ret == 0) {
 		wait_for_completion_timeout(&cpu_running,
@@ -298,8 +304,10 @@ void __cpu_die(unsigned int cpu)
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



