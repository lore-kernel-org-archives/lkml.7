Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C9C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC54620873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jm0iZkDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGTJcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 05:32:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfGTJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 05:32:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6K9Vvxu2881070
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 20 Jul 2019 02:31:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6K9Vvxu2881070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563615118;
        bh=BBhwiJSF4HFd2wW6rUTEeMMDnaC77jv+fheQaqPwEcQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Jm0iZkDF+xWRZob0aMKmnYtFvNgiat/Df8UvYIomWwl0DBWD4FzuNP7c3kMleaBgr
         ziPH+kyHSiCIHXBAggQ8pPc5VSvT6o/9/nTM8WDGnCuPZfu6D40DvigY8+cm6j4cm+
         Elfwp9ufpoEmoERuhBPTpq8cWvrQtSw6HFkULG4yrD6hu40f4LPb5O6Pq/dG+yZig+
         ue0qzKk+Chd/3tHCGtBzy5SHptSnwThMbjmF4TqlN6hkhE0nbAdIWYTZIZ38n9eS9X
         X9Ki8pPNJapCZ3R0Ms2A0KO9meAIB5s160oxNm+XBgT3aPaGU8UUKBr9mv9ftoYru7
         Db9u0sMGTcI3g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6K9VvQV2881067;
        Sat, 20 Jul 2019 02:31:57 -0700
Date:   Sat, 20 Jul 2019 02:31:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-19dbdcb8039cff16669a05136a29180778d16d0a@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        luferry@163.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, luferry@163.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <20190718160601.GP3402@hirez.programming.kicks-ass.net>
References: <20190718160601.GP3402@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] smp: Warn on function calls from softirq context
Git-Commit-ID: 19dbdcb8039cff16669a05136a29180778d16d0a
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

Commit-ID:  19dbdcb8039cff16669a05136a29180778d16d0a
Gitweb:     https://git.kernel.org/tip/19dbdcb8039cff16669a05136a29180778d16d0a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 18 Jul 2019 11:20:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 20 Jul 2019 11:27:16 +0200

smp: Warn on function calls from softirq context

It's clearly documented that smp function calls cannot be invoked from
softirq handling context. Unfortunately nothing enforces that or emits a
warning.

A single function call can be invoked from softirq context only via
smp_call_function_single_async().

The only legit context is task context, so add a warning to that effect.

Reported-by: luferry <luferry@163.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190718160601.GP3402@hirez.programming.kicks-ass.net
---
 kernel/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 616d4d114847..7dbcb402c2fc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -291,6 +291,14 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress);
 
+	/*
+	 * When @wait we can deadlock when we interrupt between llist_add() and
+	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
+	 * csd_lock() on because the interrupt context uses the same csd
+	 * storage.
+	 */
+	WARN_ON_ONCE(!in_task());
+
 	csd = &csd_stack;
 	if (!wait) {
 		csd = this_cpu_ptr(&csd_data);
@@ -416,6 +424,14 @@ void smp_call_function_many(const struct cpumask *mask,
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress && !early_boot_irqs_disabled);
 
+	/*
+	 * When @wait we can deadlock when we interrupt between llist_add() and
+	 * arch_send_call_function_ipi*(); when !@wait we can deadlock due to
+	 * csd_lock() on because the interrupt context uses the same csd
+	 * storage.
+	 */
+	WARN_ON_ONCE(!in_task());
+
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
