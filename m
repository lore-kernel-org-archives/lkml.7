Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEAEC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E3A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TEf7btWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfGRRxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:53:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:53:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IHqGnW2095808
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 10:52:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IHqGnW2095808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563472338;
        bh=rd7QaIB/lsFqGDOjsr5j5Cd14wGMuqN+A1zM18ay75Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TEf7btWsYFKQ8RyrcIDUTzoDVWnh+p2HDnsS34X3U0h3xTGMGbgCAsfFBftaCGOQt
         SCAhkxRxkceZSzzgtGltWbYBJxZBd3Aiu4svsiudcUvtOnKRNZlUwZSxeSE1i8cErH
         h0kuNojxNo/vKuUYIlYjE2+YwkJeTeu11MayBTo4ftX+q0mZ+jGDhCGbRNYBYnuBWW
         CWxfn5rCqrLrHeL80kD1K/6p18fhXxt1HA8IXow7Bs4oc4HhKM2sqE8u7rmTYuAhKk
         iYFhFEDCo3win7WLNTU317jekZEsjBetivip7Js1VsTzhM8YjQV6jR4JWG9RmVBhmx
         JEtU17K1Kexgw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IHqFRh2095803;
        Thu, 18 Jul 2019 10:52:15 -0700
Date:   Thu, 18 Jul 2019 10:52:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a003296b7a97dedccb0c35c4c1e44e088050b8c4@git.kernel.org>
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org,
        tom.zanussi@linux.intel.com, lukas.bulwahn@gmail.com,
        tglx@linutronix.de, marc.zyngier@arm.com, rostedt@goodmis.org,
        akpm@linuxfoundation.org, frederic@kernel.org, efault@gmx.de,
        paulmck@linux.vnet.ibm.com, lgoncalv@redhat.com,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        mingo@kernel.org, bristot@redhat.com, julia@ni.com,
        gratian.crisan@ni.com, torvalds@linux-foundation.org,
        clark.williams@gmail.com, wagi@monom.org, williams@redhat.com,
        tj@kernel.org, paulmck@linux.ibm.com, hch@lst.de,
        peterz@infradead.org
Reply-To: mingo@kernel.org, clark.williams@gmail.com,
          torvalds@linux-foundation.org, julia@ni.com,
          gratian.crisan@ni.com, bristot@redhat.com, wagi@monom.org,
          peterz@infradead.org, hch@lst.de, tj@kernel.org,
          paulmck@linux.ibm.com, williams@redhat.com, tglx@linutronix.de,
          marc.zyngier@arm.com, lukas.bulwahn@gmail.com,
          tom.zanussi@linux.intel.com, gregkh@linuxfoundation.org,
          hpa@zytor.com, frederic@kernel.org, akpm@linuxfoundation.org,
          rostedt@goodmis.org, lgoncalv@redhat.com,
          paulmck@linux.vnet.ibm.com, efault@gmx.de, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt, Kconfig: Introduce CONFIG_PREEMPT_RT
Git-Commit-ID: a003296b7a97dedccb0c35c4c1e44e088050b8c4
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

Commit-ID:  a003296b7a97dedccb0c35c4c1e44e088050b8c4
Gitweb:     https://git.kernel.org/tip/a003296b7a97dedccb0c35c4c1e44e088050b8c4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 17 Jul 2019 22:01:49 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Jul 2019 19:47:11 +0200

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
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Clark Williams <clark.williams@gmail.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
