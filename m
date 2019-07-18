Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7501BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4191121783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eTHUdDlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfGROVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:21:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGROVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:21:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IEJMYd2020610
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 07:19:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IEJMYd2020610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563459564;
        bh=AmdxMoMzuLsh1qy0WRK6wfOHnIglwr04LEu/wExBCJk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eTHUdDlVWA4BaJiDpdnnWjxgYZj7R0Lt++CmqqLnGhdTSF9liSeXOyvxajLQOgCrX
         jj9Y6dNeYCoKkbMesPh/VP5ExdI7etAJSGw8ZpRywymc2VGk30IVxRgG9knCAmgNby
         uISVteHT2Jcp48WH/RKiS/9e3Np4wMxGeKo3nC8mLra6f7aRHyFNfzBjFGGLyqFrDj
         RNRa1/ojiblzxusGAX91CRHUdyQ1ZMWfr7eajmeT/HptGK9/LvdC98uavbL1uXebGm
         yNYDJ+6jiV80M0c4JQklSMUWvY4RORldj49EbmyY6KfqcEFts3Q7sS+qlc/NZtwTIw
         yt62U2CXTSCWw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IEJLdT2020601;
        Thu, 18 Jul 2019 07:19:21 -0700
Date:   Thu, 18 Jul 2019 07:19:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2c2ffb925b368a1f00d4ddcc837f830394861d6c@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, williams@redhat.com,
        frederic@kernel.org, peterz@infradead.org, mingo@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, lukas.bulwahn@gmail.com,
        julia@ni.com, linux-kernel@vger.kernel.org, efault@gmx.de,
        marc.zyngier@arm.com, bristot@redhat.com,
        torvalds@linux-foundation.org, tom.zanussi@linux.intel.com,
        gregkh@linuxfoundation.org, hch@lst.de, bigeasy@linutronix.de,
        lgoncalv@redhat.com, clark.williams@gmail.com, tj@kernel.org,
        gratian.crisan@ni.com, wagi@monom.org, paulmck@linux.ibm.com,
        akpm@linuxfoundation.org, tglx@linutronix.de
Reply-To: gratian.crisan@ni.com, tj@kernel.org, clark.williams@gmail.com,
          lgoncalv@redhat.com, bigeasy@linutronix.de, hch@lst.de,
          tglx@linutronix.de, akpm@linuxfoundation.org,
          paulmck@linux.ibm.com, wagi@monom.org, marc.zyngier@arm.com,
          efault@gmx.de, tom.zanussi@linux.intel.com,
          gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
          bristot@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          lukas.bulwahn@gmail.com, julia@ni.com, frederic@kernel.org,
          williams@redhat.com, paulmck@linux.vnet.ibm.com,
          rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org
In-Reply-To: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt, Kconfig: Introduce CONFIG_PREEMPT_RT
Git-Commit-ID: 2c2ffb925b368a1f00d4ddcc837f830394861d6c
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

Commit-ID:  2c2ffb925b368a1f00d4ddcc837f830394861d6c
Gitweb:     https://git.kernel.org/tip/2c2ffb925b368a1f00d4ddcc837f830394861d6c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 17 Jul 2019 22:01:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Jul 2019 14:53:32 +0200

sched/rt, Kconfig: Introduce CONFIG_PREEMPT_RT

Add a new entry to the preemption menu which enables the real-time support
for the kernel. The choice is only enabled when an architecture supports
it.

It selects PREEMPT as the RT features depend on it. To achieve that the
existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
well.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Clark Williams <williams@redhat.com>
Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Daniel Wagner <wagi@monom.org>
Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Clark Williams <clark.williams@gmail.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julia Cartwright <julia@ni.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig           |  3 +++
 kernel/Kconfig.preempt | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c47b328eada0..ada51f36bd5d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -801,6 +801,9 @@ config ARCH_NO_COHERENT_DMA_MMAP
 config ARCH_NO_PREEMPT
 	bool
 
+config ARCH_SUPPORTS_RT
+	bool
+
 config CPU_NO_EFFICIENT_FFS
 	def_bool n
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index dc0b682ec2d9..fc020c09b7e8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -35,10 +35,10 @@ config PREEMPT_VOLUNTARY
 
 	  Select this if you are building a kernel for a desktop system.
 
-config PREEMPT
+config PREEMPT_LL
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_COUNT
+	select PREEMPT
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
@@ -55,7 +55,28 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
+config PREEMPT_RT
+	bool "Fully Preemptible Kernel (Real-Time)"
+	depends on EXPERT && ARCH_SUPPORTS_RT
+	select PREEMPT
+	help
+	  This option turns the kernel into a real-time kernel by replacing
+	  various locking primitives (spinlocks, rwlocks, etc.) with
+	  preemptible priority-inheritance aware variants, enforcing
+	  interrupt threading and introducing mechanisms to break up long
+	  non-preemptible sections. This makes the kernel, except for very
+	  low level and critical code pathes (entry code, scheduler, low
+	  level interrupt handling) fully preemptible and brings most
+	  execution contexts under scheduler control.
+
+	  Select this if you are building a kernel for systems which
+	  require real-time guarantees.
+
 endchoice
 
 config PREEMPT_COUNT
        bool
+
+config PREEMPT
+       bool
+       select PREEMPT_COUNT
