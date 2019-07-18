Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A27C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A72821849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C129nuXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391328AbfGRVRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:17:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391249AbfGRVRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:17:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6ILGHQO2166514
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 14:16:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6ILGHQO2166514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563484578;
        bh=jz7955kGbyUBLoiWj4srCxrmMGflmpWrYP14eUEMtK4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C129nuXcuVNQKSK1Hg8+zcaPGaPyE3PmwHSbXRGDb/XxXg2n6CWSrl0cEAGNjLyLz
         LYHGiNWzOeH1iQsYuuFGvulLnzByQAiWqZ9DUaZ5a/0wNPdc2JMmTfNRzZRe9uk0Dg
         40UDbNKJAD7aU94YttCyQ8SXyXcQi7R7XWv95DI/zyxlg1ZWcMd45VEv046E2atosK
         U1Tv5GcH9e7YKxddKQQzUpELKrG3qjMfWry4kePRVjfowwEjTDp22dpu985RGVNf3+
         lsIXL+61z/+cVHBU38w+lz73Gx4pN4YlQh9TyVspczyln57dRZ81qpcr6sQrNJJvTV
         bmsQIgBE4dYEQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6ILGGNR2166511;
        Thu, 18 Jul 2019 14:16:16 -0700
Date:   Thu, 18 Jul 2019 14:16:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a50a3f4b6a313dc76912bd4ad3b8b4f4b479c801@git.kernel.org>
Cc:     julia@ni.com, tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.ibm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, lgoncalv@redhat.com,
        lukas.bulwahn@gmail.com, bigeasy@linutronix.de,
        rostedt@goodmis.org, mingo@kernel.org, bristot@redhat.com,
        tom.zanussi@linux.intel.com, marc.zyngier@arm.com, efault@gmx.de,
        gratian.crisan@ni.com, williams@redhat.com, hch@lst.de,
        wagi@monom.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        akpm@linuxfoundation.org, torvalds@linux-foundation.org
Reply-To: akpm@linuxfoundation.org, torvalds@linux-foundation.org,
          gratian.crisan@ni.com, hch@lst.de, williams@redhat.com,
          wagi@monom.org, gregkh@linuxfoundation.org, hpa@zytor.com,
          efault@gmx.de, tom.zanussi@linux.intel.com, marc.zyngier@arm.com,
          lukas.bulwahn@gmail.com, bigeasy@linutronix.de,
          rostedt@goodmis.org, mingo@kernel.org, bristot@redhat.com,
          tj@kernel.org, lgoncalv@redhat.com, linux-kernel@vger.kernel.org,
          julia@ni.com, tglx@linutronix.de, peterz@infradead.org,
          paulmck@linux.ibm.com, frederic@kernel.org
In-Reply-To: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt, Kconfig: Introduce CONFIG_PREEMPT_RT
Git-Commit-ID: a50a3f4b6a313dc76912bd4ad3b8b4f4b479c801
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

Commit-ID:  a50a3f4b6a313dc76912bd4ad3b8b4f4b479c801
Gitweb:     https://git.kernel.org/tip/a50a3f4b6a313dc76912bd4ad3b8b4f4b479c801
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 17 Jul 2019 22:01:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Jul 2019 23:10:57 +0200

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
Acked-by: Julia Cartwright <julia@ni.com>
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Acked-by: Gratian Crisan <gratian.crisan@ni.com>
Acked-by: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Tejun Heo <tj@kernel.org>
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
