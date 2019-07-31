Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D79C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E948E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1DKQveMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfGaSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:02:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfGaSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:01:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VI0iV53778308
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 11:00:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VI0iV53778308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564596045;
        bh=Q0FaiK0C3p12cF4gvd/mtqQ1oguAUujBX1/6wh/pe8U=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=1DKQveMmG+WlEaOyj0si0gdgF2286kH+vZdvXl1odjERTYlR4aavTUaKSTonC8Fef
         87tWAvDiM/ngr9fMoPkHs5BkxGwUjV4/FlvcU1SyZihyDHldNbgBd4qutTXbMxLkXQ
         pzbIxJSWBHBe1hWIOVmVwco8nFpx5IAhqoQgy/od3ahFbqjjtVu/6sF+xLIavT9MUt
         LpUSCqdxwGUoOHA/EZYy1XX43jDXFZFiJxUh+08d3x25H+NDX+T5VX4uVE9Bg+sjP5
         d1/3hwR4XzQyGfz2qQ9TrtQ011b+g3r1kwcOfDcvuRDiOB2schAcVjPbhKkAMYOrz+
         AuwpYY89RCPfg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VI0hiq3778304;
        Wed, 31 Jul 2019 11:00:43 -0700
Date:   Wed, 31 Jul 2019 11:00:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-09c7e8b21d67c3c78ab9701dbc0fb1e9f14a0ba5@git.kernel.org>
Cc:     hpa@zytor.com, mhiramat@kernel.org, paulmck@linux.ibm.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, tglx@linutronix.de, rostedt@goodmis.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: pbonzini@redhat.com, mingo@kernel.org,
          torvalds@linux-foundation.org, paulmck@linux.ibm.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190726212124.789755413@linutronix.de>
References: <20190726212124.789755413@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] x86/kvm: Use CONFIG_PREEMPTION
Git-Commit-ID: 09c7e8b21d67c3c78ab9701dbc0fb1e9f14a0ba5
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

Commit-ID:  09c7e8b21d67c3c78ab9701dbc0fb1e9f14a0ba5
Gitweb:     https://git.kernel.org/tip/09c7e8b21d67c3c78ab9701dbc0fb1e9f14a0ba5
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:44 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:36 +0200

x86/kvm: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch the conditional for async pagefaults to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.789755413@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b7f34fe2171e..3d07f84c4846 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -314,7 +314,7 @@ static void kvm_guest_cpu_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF) && kvmapf) {
 		u64 pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
 #endif
 		pa |= KVM_ASYNC_PF_ENABLED;
