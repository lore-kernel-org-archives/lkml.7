Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B427C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0A421883
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfGTMwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:52:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34317 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfGTMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:52:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hooqR-0005Qf-Ej; Sat, 20 Jul 2019 14:52:11 +0200
Date:   Sat, 20 Jul 2019 12:50:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for 5.3-rc1
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
Message-ID: <156362700019.18624.13516337882561160480.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

up to:  a50a3f4b6a31: sched/rt, Kconfig: Introduce CONFIG_PREEMPT_RT

The real-time preemption patch set exists for almost 15 years now and while
the vast majority of infrastructure and enhancements have found their way
into the mainline kernel, the final integration of RT is still missing.

Over the course of the last few years, we have worked on reducing the
intrusivenness of the RT patches by refactoring kernel infrastructure to be
more real-time friendly. Almost all of these changes were benefitial to
the mainline kernel on their own, so there was no objection to integrate
them.

Though except for the still ongoing printk refactoring, the remaining
changes which are required to make RT a first class mainline citizen are
not longer arguable as immediately beneficial for the mainline kernel. Most
of them are either reordering code flows or adding RT specific functionality.
But this now has hit a wall and turned into a classic hen and egg problem:

  Maintainers are rightfully wary vs. these changes as they make only
  sense if the final integration of RT into the mainline kernel takes
  place.

Adding CONFIG_PREEMPT_RT aims to solve this as a clear sign that RT will be
fully integrated into the mainline kernel. The final integration of the
missing bits and pieces will be of course done with the same careful
approach as we have used in the past.

While I'm aware that you are not entirely enthusiastic about that, I think
that RT should receive the same treatment as any other widely used out of
tree functionality, which we have accepted into mainline over the years.

RT has become the de-facto standard real-time enhancement and is shipped by
enterprise, embedded and community distros. It's in use throughout a wide
range of industries: telecommunications, industrial automation, professional
audio, medical devices, data acquisition, automotive - just to name a
few major use cases.

RT development is backed by a Linuxfoundation project which is supported
by major stakeholders of this technology. The funding will continue over
the actual inclusion into mainline to make sure that the functionality is
neither introducing regressions, regressing itself, nor becomes subject
to bitrot. There is also a lifely user community around RT as well, so
contrary to the grim situation 5 years ago, it's a healthy project.

As RT is still a good vehicle to exercise rarely used code paths and to
detect hard to trigger issues, you could at least view it as a QA tool if
nothing else.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      sched/rt, Kconfig: Introduce CONFIG_PREEMPT_RT


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

