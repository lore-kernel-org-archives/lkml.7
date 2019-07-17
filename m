Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A77C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4262521873
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfGQUCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:02:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQUB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:01:59 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnq7b-0003TQ-D4; Wed, 17 Jul 2019 22:01:51 +0200
Date:   Wed, 17 Jul 2019 22:01:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Gratian Crisan <gratian.crisan@ni.com>
Subject: [patch V2 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
In-Reply-To: <20190715150601.205143057@linutronix.de>
Message-ID: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
References: <20190715150402.798499167@linutronix.de> <20190715150601.205143057@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Daniel Wagner <wagi@monom.org>
---
V2: Fix typos in help text, collect acks
---
 arch/Kconfig           |    3 +++
 kernel/Kconfig.preempt |   25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -809,6 +809,9 @@ config ARCH_NO_COHERENT_DMA_MMAP
 config ARCH_NO_PREEMPT
 	bool
 
+config ARCH_SUPPORTS_RT
+	bool
+
 config CPU_NO_EFFICIENT_FFS
 	def_bool n
 
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
