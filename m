Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C45C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE29E2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362099;
	bh=FtIUc/2LY8ueFAKrE4f7r3VZFkVvVUqRftm2AjIBMOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MnhHRnsRgGxsj6piUksfRpxVYlRbPbAKREw2vMJPowNmY2PUlOmkluHXBkyr0kHaw
	 Qvick36bJmwCfLvquYAwecSWIPDtIKdYuqdStOEswScdqHlW5QP79d11U9AKbeJRn7
	 4FgO8Y9QwXXMUcJT/7uAFC/Fu3vBQ4Ji0RSG6ezE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfFLRyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389324AbfFLRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4+peVPWYVnkGPsaJWb5LqT1IaoNXCgdiJALpdAywo5o=; b=YdAhQHz8AuZ/Je7mFY9Agjf7wg
        iLzRH/Ag1HcC+gr1ipL9JlWfR2nuc4MfaicwuM/T5yzEFPYK/B1QdphVmQHVZ21UO4c4PShVaL5RV
        Z4IDUf/d7yXAf3p79cnmGngwo8rk2Q73F7ywIn6g7YaNl92BsqjVAQLd5Q8BZC3eZ1o4yh4b2P5YX
        JdCOykwqfDBS9iKl4g3dGYr+8tMbHG9gLgn9Vij1XHgMXuwCyG2ev5o61zBAiTHedWBzZSpQRj313
        rM0kUyZz4f01V3boT4BQvtu8vjAURtfnsXV20KeLBi3xuY8SduKRBG18JEK/WFByT0UpOSrDpryEM
        5NOZ7xgA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qx-0002Ds-SH; Wed, 12 Jun 2019 17:53:16 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001hT-M9; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        Antti Palosaari <crope@iki.fi>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v4 24/28] docs: timers: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:53:00 -0300
Message-Id: <30e605cd5a295c42c39523d88b4c57298c5a6f1d.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion here is really trivial: just a bunch of title
markups and very few puntual changes is enough to make it to
be parsed by Sphinx and generate a nice html.

The conversion is actually:
  - add blank lines and identation in order to identify paragraphs;
  - fix tables markups;
  - add some lists markups;
  - mark literal blocks;
  - adjust title markups.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../timers/{highres.txt => highres.rst}       | 13 +++---
 Documentation/timers/{hpet.txt => hpet.rst}   |  4 +-
 .../timers/{hrtimers.txt => hrtimers.rst}     |  6 +--
 Documentation/timers/index.rst                | 22 ++++++++++
 Documentation/timers/{NO_HZ.txt => no_hz.rst} | 40 +++++++++++--------
 .../{timekeeping.txt => timekeeping.rst}      |  3 +-
 .../{timers-howto.txt => timers-howto.rst}    | 15 +++++--
 MAINTAINERS                                   |  2 +-
 drivers/media/usb/dvb-usb-v2/anysee.c         |  2 +-
 drivers/regulator/core.c                      |  2 +-
 include/linux/iopoll.h                        |  4 +-
 include/linux/regmap.h                        |  4 +-
 scripts/checkpatch.pl                         |  8 ++--
 sound/soc/sof/ops.h                           |  2 +-
 14 files changed, 84 insertions(+), 43 deletions(-)
 rename Documentation/timers/{highres.txt => highres.rst} (98%)
 rename Documentation/timers/{hpet.txt => hpet.rst} (91%)
 rename Documentation/timers/{hrtimers.txt => hrtimers.rst} (98%)
 create mode 100644 Documentation/timers/index.rst
 rename Documentation/timers/{NO_HZ.txt => no_hz.rst} (93%)
 rename Documentation/timers/{timekeeping.txt => timekeeping.rst} (98%)
 rename Documentation/timers/{timers-howto.txt => timers-howto.rst} (93%)

diff --git a/Documentation/timers/highres.txt b/Documentation/timers/highres.rst
similarity index 98%
rename from Documentation/timers/highres.txt
rename to Documentation/timers/highres.rst
index 8f9741592123..bde5eb7e5c9e 100644
--- a/Documentation/timers/highres.txt
+++ b/Documentation/timers/highres.rst
@@ -1,5 +1,6 @@
+=====================================================
 High resolution timers and dynamic ticks design notes
------------------------------------------------------
+=====================================================
 
 Further information can be found in the paper of the OLS 2006 talk "hrtimers
 and beyond". The paper is part of the OLS 2006 Proceedings Volume 1, which can
@@ -30,11 +31,12 @@ hrtimer base infrastructure
 ---------------------------
 
 The hrtimer base infrastructure was merged into the 2.6.16 kernel. Details of
-the base implementation are covered in Documentation/timers/hrtimers.txt. See
+the base implementation are covered in Documentation/timers/hrtimers.rst. See
 also figure #2 (OLS slides p. 15)
 
 The main differences to the timer wheel, which holds the armed timer_list type
 timers are:
+
        - time ordered enqueueing into a rb-tree
        - independent of ticks (the processing is based on nanoseconds)
 
@@ -55,7 +57,8 @@ merged into the 2.6.18 kernel.
 
 Further information about the Generic Time Of Day framework is available in the
 OLS 2005 Proceedings Volume 1:
-http://www.linuxsymposium.org/2005/linuxsymposium_procv1.pdf
+
+	http://www.linuxsymposium.org/2005/linuxsymposium_procv1.pdf
 
 The paper "We Are Not Getting Any Younger: A New Approach to Time and
 Timers" was written by J. Stultz, D.V. Hart, & N. Aravamudan.
@@ -100,6 +103,7 @@ accounting, profiling, and high resolution timers.
 
 The management layer assigns one or more of the following functions to a clock
 event device:
+
       - system global periodic tick (jiffies update)
       - cpu local update_process_times
       - cpu local profiling
@@ -244,6 +248,3 @@ extended to x86_64 and ARM already. Initial (work in progress) support is also
 available for MIPS and PowerPC.
 
 	  Thomas, Ingo
-
-
-
diff --git a/Documentation/timers/hpet.txt b/Documentation/timers/hpet.rst
similarity index 91%
rename from Documentation/timers/hpet.txt
rename to Documentation/timers/hpet.rst
index 895345ec513b..c9d05d3caaca 100644
--- a/Documentation/timers/hpet.txt
+++ b/Documentation/timers/hpet.rst
@@ -1,4 +1,6 @@
-		High Precision Event Timer Driver for Linux
+===========================================
+High Precision Event Timer Driver for Linux
+===========================================
 
 The High Precision Event Timer (HPET) hardware follows a specification
 by Intel and Microsoft, revision 1.
diff --git a/Documentation/timers/hrtimers.txt b/Documentation/timers/hrtimers.rst
similarity index 98%
rename from Documentation/timers/hrtimers.txt
rename to Documentation/timers/hrtimers.rst
index 588d85724f10..c1c20a693e8f 100644
--- a/Documentation/timers/hrtimers.txt
+++ b/Documentation/timers/hrtimers.rst
@@ -1,6 +1,6 @@
-
+======================================================
 hrtimers - subsystem for high-resolution kernel timers
-----------------------------------------------------
+======================================================
 
 This patch introduces a new subsystem for high-resolution kernel timers.
 
@@ -146,7 +146,7 @@ the clock_getres() interface. This will return whatever real resolution
 a given clock has - be it low-res, high-res, or artificially-low-res.
 
 hrtimers - testing and verification
-----------------------------------
+-----------------------------------
 
 We used the high-resolution clock subsystem ontop of hrtimers to verify
 the hrtimer implementation details in praxis, and we also ran the posix
diff --git a/Documentation/timers/index.rst b/Documentation/timers/index.rst
new file mode 100644
index 000000000000..91f6f8263c48
--- /dev/null
+++ b/Documentation/timers/index.rst
@@ -0,0 +1,22 @@
+:orphan:
+
+======
+timers
+======
+
+.. toctree::
+    :maxdepth: 1
+
+    highres
+    hpet
+    hrtimers
+    no_hz
+    timekeeping
+    timers-howto
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/timers/NO_HZ.txt b/Documentation/timers/no_hz.rst
similarity index 93%
rename from Documentation/timers/NO_HZ.txt
rename to Documentation/timers/no_hz.rst
index 9591092da5e0..065db217cb04 100644
--- a/Documentation/timers/NO_HZ.txt
+++ b/Documentation/timers/no_hz.rst
@@ -1,4 +1,6 @@
-		NO_HZ: Reducing Scheduling-Clock Ticks
+﻿======================================
+NO_HZ: Reducing Scheduling-Clock Ticks
+======================================
 
 
 This document describes Kconfig options and boot parameters that can
@@ -28,7 +30,8 @@ by a third section on RCU-specific considerations, a fourth section
 discussing testing, and a fifth and final section listing known issues.
 
 
-NEVER OMIT SCHEDULING-CLOCK TICKS
+Never Omit Scheduling-Clock Ticks
+=================================
 
 Very old versions of Linux from the 1990s and the very early 2000s
 are incapable of omitting scheduling-clock ticks.  It turns out that
@@ -59,7 +62,8 @@ degrade your applications performance.  If this describes your workload,
 you should read the following two sections.
 
 
-OMIT SCHEDULING-CLOCK TICKS FOR IDLE CPUs
+Omit Scheduling-Clock Ticks For Idle CPUs
+=========================================
 
 If a CPU is idle, there is little point in sending it a scheduling-clock
 interrupt.  After all, the primary purpose of a scheduling-clock interrupt
@@ -97,7 +101,8 @@ By default, CONFIG_NO_HZ_IDLE=y kernels boot with "nohz=on", enabling
 dyntick-idle mode.
 
 
-OMIT SCHEDULING-CLOCK TICKS FOR CPUs WITH ONLY ONE RUNNABLE TASK
+Omit Scheduling-Clock Ticks For CPUs With Only One Runnable Task
+================================================================
 
 If a CPU has only one runnable task, there is little point in sending it
 a scheduling-clock interrupt because there is no other task to switch to.
@@ -174,7 +179,8 @@ However, the drawbacks listed above mean that adaptive ticks should not
 (yet) be enabled by default.
 
 
-RCU IMPLICATIONS
+RCU Implications
+================
 
 There are situations in which idle CPUs cannot be permitted to
 enter either dyntick-idle mode or adaptive-tick mode, the most
@@ -199,7 +205,8 @@ scheduler will decide where to run them, which might or might not be
 where you want them to run.
 
 
-TESTING
+Testing
+=======
 
 So you enable all the OS-jitter features described in this document,
 but do not see any change in your workload's behavior.  Is this because
@@ -222,9 +229,10 @@ We do not currently have a good way to remove OS jitter from single-CPU
 systems.
 
 
-KNOWN ISSUES
+Known Issues
+============
 
-o	Dyntick-idle slows transitions to and from idle slightly.
+*	Dyntick-idle slows transitions to and from idle slightly.
 	In practice, this has not been a problem except for the most
 	aggressive real-time workloads, which have the option of disabling
 	dyntick-idle mode, an option that most of them take.  However,
@@ -248,13 +256,13 @@ o	Dyntick-idle slows transitions to and from idle slightly.
 		this parameter effectively disables Turbo Mode on Intel
 		CPUs, which can significantly reduce maximum performance.
 
-o	Adaptive-ticks slows user/kernel transitions slightly.
+*	Adaptive-ticks slows user/kernel transitions slightly.
 	This is not expected to be a problem for computationally intensive
 	workloads, which have few such transitions.  Careful benchmarking
 	will be required to determine whether or not other workloads
 	are significantly affected by this effect.
 
-o	Adaptive-ticks does not do anything unless there is only one
+*	Adaptive-ticks does not do anything unless there is only one
 	runnable task for a given CPU, even though there are a number
 	of other situations where the scheduling-clock tick is not
 	needed.  To give but one example, consider a CPU that has one
@@ -275,7 +283,7 @@ o	Adaptive-ticks does not do anything unless there is only one
 
 	Better handling of these sorts of situations is future work.
 
-o	A reboot is required to reconfigure both adaptive idle and RCU
+*	A reboot is required to reconfigure both adaptive idle and RCU
 	callback offloading.  Runtime reconfiguration could be provided
 	if needed, however, due to the complexity of reconfiguring RCU at
 	runtime, there would need to be an earthshakingly good reason.
@@ -283,12 +291,12 @@ o	A reboot is required to reconfigure both adaptive idle and RCU
 	simply offloading RCU callbacks from all CPUs and pinning them
 	where you want them whenever you want them pinned.
 
-o	Additional configuration is required to deal with other sources
+*	Additional configuration is required to deal with other sources
 	of OS jitter, including interrupts and system-utility tasks
 	and processes.  This configuration normally involves binding
 	interrupts and tasks to particular CPUs.
 
-o	Some sources of OS jitter can currently be eliminated only by
+*	Some sources of OS jitter can currently be eliminated only by
 	constraining the workload.  For example, the only way to eliminate
 	OS jitter due to global TLB shootdowns is to avoid the unmapping
 	operations (such as kernel module unload operations) that
@@ -299,17 +307,17 @@ o	Some sources of OS jitter can currently be eliminated only by
 	helpful, especially when combined with the mlock() and mlockall()
 	system calls.
 
-o	Unless all CPUs are idle, at least one CPU must keep the
+*	Unless all CPUs are idle, at least one CPU must keep the
 	scheduling-clock interrupt going in order to support accurate
 	timekeeping.
 
-o	If there might potentially be some adaptive-ticks CPUs, there
+*	If there might potentially be some adaptive-ticks CPUs, there
 	will be at least one CPU keeping the scheduling-clock interrupt
 	going, even if all CPUs are otherwise idle.
 
 	Better handling of this situation is ongoing work.
 
-o	Some process-handling operations still require the occasional
+*	Some process-handling operations still require the occasional
 	scheduling-clock tick.	These operations include calculating CPU
 	load, maintaining sched average, computing CFS entity vruntime,
 	computing avenrun, and carrying out load balancing.  They are
diff --git a/Documentation/timers/timekeeping.txt b/Documentation/timers/timekeeping.rst
similarity index 98%
rename from Documentation/timers/timekeeping.txt
rename to Documentation/timers/timekeeping.rst
index 2d1732b0a868..f83e98852e2c 100644
--- a/Documentation/timers/timekeeping.txt
+++ b/Documentation/timers/timekeeping.rst
@@ -1,5 +1,6 @@
+===========================================================
 Clock sources, Clock events, sched_clock() and delay timers
------------------------------------------------------------
+===========================================================
 
 This document tries to briefly explain some basic kernel timekeeping
 abstractions. It partly pertains to the drivers usually found in
diff --git a/Documentation/timers/timers-howto.txt b/Documentation/timers/timers-howto.rst
similarity index 93%
rename from Documentation/timers/timers-howto.txt
rename to Documentation/timers/timers-howto.rst
index 038f8c77a076..7e3167bec2b1 100644
--- a/Documentation/timers/timers-howto.txt
+++ b/Documentation/timers/timers-howto.rst
@@ -1,5 +1,6 @@
+===================================================================
 delays - Information on the various kernel delay / sleep mechanisms
--------------------------------------------------------------------
+===================================================================
 
 This document seeks to answer the common question: "What is the
 RightWay (TM) to insert a delay?"
@@ -17,7 +18,7 @@ code in an atomic context?"  This should be followed closely by "Does
 it really need to delay in atomic context?" If so...
 
 ATOMIC CONTEXT:
-	You must use the *delay family of functions. These
+	You must use the `*delay` family of functions. These
 	functions use the jiffie estimation of clock speed
 	and will busy wait for enough loop cycles to achieve
 	the desired delay:
@@ -35,21 +36,26 @@ ATOMIC CONTEXT:
 	be refactored to allow for the use of msleep.
 
 NON-ATOMIC CONTEXT:
-	You should use the *sleep[_range] family of functions.
+	You should use the `*sleep[_range]` family of functions.
 	There are a few more options here, while any of them may
 	work correctly, using the "right" sleep function will
 	help the scheduler, power management, and just make your
 	driver better :)
 
 	-- Backed by busy-wait loop:
+
 		udelay(unsigned long usecs)
+
 	-- Backed by hrtimers:
+
 		usleep_range(unsigned long min, unsigned long max)
+
 	-- Backed by jiffies / legacy_timers
+
 		msleep(unsigned long msecs)
 		msleep_interruptible(unsigned long msecs)
 
-	Unlike the *delay family, the underlying mechanism
+	Unlike the `*delay` family, the underlying mechanism
 	driving each of these calls varies, thus there are
 	quirks you should be aware of.
 
@@ -70,6 +76,7 @@ NON-ATOMIC CONTEXT:
 		- Why not msleep for (1ms - 20ms)?
 			Explained originally here:
 				http://lkml.org/lkml/2007/8/3/250
+
 			msleep(1~20) may not do what the caller intends, and
 			will often sleep longer (~20 ms actual sleep for any
 			value given in the 1~20ms range). In many cases this
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d9399c9cf47..71b4754ea7c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7223,7 +7223,7 @@ F:	drivers/net/ethernet/hp/hp100.*
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
 S:	Maintained
-F:	Documentation/timers/hpet.txt
+F:	Documentation/timers/hpet.rst
 F:	drivers/char/hpet.c
 F:	include/linux/hpet.h
 F:	include/uapi/linux/hpet.h
diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-usb-v2/anysee.c
index 48fb0d41e03b..fb6d99dea31a 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -56,7 +56,7 @@ static int anysee_ctrl_msg(struct dvb_usb_device *d,
 	/* TODO FIXME: dvb_usb_generic_rw() fails rarely with error code -32
 	 * (EPIPE, Broken pipe). Function supports currently msleep() as a
 	 * parameter but I would not like to use it, since according to
-	 * Documentation/timers/timers-howto.txt it should not be used such
+	 * Documentation/timers/timers-howto.rst it should not be used such
 	 * short, under < 20ms, sleeps. Repeating failed message would be
 	 * better choice as not to add unwanted delays...
 	 * Fixing that correctly is one of those or both;
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 85f61e5dc312..aff1f2cefe4b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2304,7 +2304,7 @@ static int regulator_ena_gpio_ctrl(struct regulator_dev *rdev, bool enable)
  *
  * Delay for the requested amount of time as per the guidelines in:
  *
- *     Documentation/timers/timers-howto.txt
+ *     Documentation/timers/timers-howto.rst
  *
  * The assumption here is that regulators will never be enabled in
  * atomic context and therefore sleeping functions can be used.
diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 3908353deec6..35e15dfd4155 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -21,7 +21,7 @@
  * @cond: Break condition (usually involving @val)
  * @sleep_us: Maximum time to sleep between reads in us (0
  *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.txt).
+ *            is used (see Documentation/timers/timers-howto.rst).
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
@@ -60,7 +60,7 @@
  * @cond: Break condition (usually involving @val)
  * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
  *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.txt).
+ *            Documentation/timers/timers-howto.rst).
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f65984d98b07..038568a9b957 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -113,7 +113,7 @@ struct reg_sequence {
  * @cond: Break condition (usually involving @val)
  * @sleep_us: Maximum time to sleep between reads in us (0
  *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.txt).
+ *            is used (see Documentation/timers/timers-howto.rst).
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
@@ -155,7 +155,7 @@ struct reg_sequence {
  * @cond: Break condition (usually involving @val)
  * @sleep_us: Maximum time to sleep between reads in us (0
  *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.txt).
+ *            is used (see Documentation/timers/timers-howto.rst).
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c1be9f6958b7..6cb99ec62000 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5714,7 +5714,7 @@ sub process {
 			# ignore udelay's < 10, however
 			if (! ($delay < 10) ) {
 				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt\n" . $herecurr);
+				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst\n" . $herecurr);
 			}
 			if ($delay > 2000) {
 				WARN("LONG_UDELAY",
@@ -5726,7 +5726,7 @@ sub process {
 		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
 			if ($1 < 20) {
 				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt\n" . $herecurr);
+				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst\n" . $herecurr);
 			}
 		}
 
@@ -6117,11 +6117,11 @@ sub process {
 			my $max = $7;
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.txt\n" . "$here\n$stat\n");
+				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
 			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.txt\n" . "$here\n$stat\n");
+				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
 			}
 		}
 
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 80fc3b374c2b..8058a6c73082 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -349,7 +349,7 @@ static inline const struct snd_sof_dsp_ops
  * @cond: Break condition (usually involving @val)
  * @sleep_us: Maximum time to sleep between reads in us (0
  *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.txt).
+ *            is used (see Documentation/timers/timers-howto.rst).
  * @timeout_us: Timeout in us, 0 means never timeout
  *
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
-- 
2.21.0

