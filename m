Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C967C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025D3214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfIPNic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:38:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39250 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbfIPNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:38:31 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rCV-0006vQ-Ha; Mon, 16 Sep 2019 15:37:55 +0200
Date:   Mon, 16 Sep 2019 13:30:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for 5.4-rc1
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
Message-ID: <156864062018.3407.15816124333744004374.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

up to:  77b4b5420422: posix-cpu-timers: Fix permission check regression

Timers and timekeeping updates:

 - A large overhaul of the posix CPU timer code which is a preparation for
   moving the CPU timer expiry out into task work so it can be properly
   accounted on the task/process.

   An update to the bogus permission checks will come later during the
   merge window as feedback was not complete before heading of for travel.

 - Switch the timerqueue code to use cached rbtrees and get rid of the
   homebrewn caching of the leftmost node.

 - Consolidate hrtimer_init() + hrtimer_init_sleeper() calls into a single
   function

 - Implement the separation of hrtimers to be forced to expire in hard
   interrupt context even when PREEMPT_RT is enabled and mark the affected
   timers accordingly.

 - Implement a mechanism for hrtimers and the timer wheel to protect RT
   against priority inversion and live lock issues when a (hr)timer which
   should be canceled is currently executing the callback. Instead of
   infinitely spinning, the task which tries to cancel the timer blocks on
   a per cpu base expiry lock which is held and released by the (hr)timer
   expiry code.

 - Enable the Hyper-V TSC page based sched_clock for Hyper-V guests
   resulting in faster access to timekeeping functions.

 - Updates to various clocksource/clockevent drivers and their device tree
   bindings.

 - The usual small improvements all over the place.

Thanks,

	tglx

------------------>
Alexandre Belloni (1):
      clocksource/drivers/tcb_clksrc: Register delay timer

Anna-Maria Gleixner (5):
      hrtimer: Prepare support for PREEMPT_RT
      timers: Prepare support for PREEMPT_RT
      alarmtimer: Prepare for PREEMPT_RT
      timerfd: Prepare for PREEMPT_RT
      itimers: Prepare for PREEMPT_RT

Anson Huang (3):
      clocksource/drivers/imx-sysctr: Add internal clock divider handle
      arm64: dts: imx8mm: Add system counter node
      arm64: dts: imx8mq: Add system counter node

Avi Fishman (1):
      clocksource/drivers/npcm: Fix GENMASK and timer operation

Davidlohr Bueso (1):
      lib/timerqueue: Rely on rbtree semantics for next timer

Frederic Weisbecker (1):
      hrtimer: Improve comments on handling priority inversion against softirq kthread

Geert Uytterhoeven (1):
      clocksource/drivers/renesas-ostm: Use DIV_ROUND_CLOSEST() helper

Jon Hunter (2):
      clocksource/drivers/timer-of: Do not warn on deferred probe
      clocksource/drivers: Do not warn on probe defer

Julien Grall (2):
      hrtimer: Protect lockless access to timer->base
      hrtimer: Don't take expiry_lock when timer is currently migrated

Juri Lelli (1):
      sched/deadline: Ensure inactive_timer runs in hardirq context

Magnus Damm (7):
      dt-bindings: timer: renesas, cmt: Add CMT0234 to sh73a0 and r8a7740
      dt-bindings: timer: renesas, cmt: Update CMT1 on sh73a0 and r8a7740
      dt-bindings: timer: renesas, cmt: Add CMT0 and CMT1 to r8a7792
      dt-bindings: timer: renesas, cmt: Add CMT0 and CMT1 to r8a77995
      dt-bindings: timer: renesas, cmt: Update R-Car Gen3 CMT1 usage
      clocksource/drivers/sh_cmt: r8a7740 and sh73a0 SoC-specific match
      clocksource/drivers/sh_cmt: Document "cmt-48" as deprecated

Maxime Ripard (4):
      dt-bindings: timer: Convert Allwinner A10 Timer to a schema
      dt-bindings: timer: Add missing compatibles
      clocksource: sun4i: Add missing compatibles
      dt-bindings: timer: Convert Allwinner A13 HSTimer to a schema

Sebastian Andrzej Siewior (13):
      hrtimer: Consolidate hrtimer_init() + hrtimer_init_sleeper() calls
      hrtimer: Introduce HARD expiry mode
      sched: Mark hrtimers to expire in hard interrupt context
      perf/core: Mark hrtimers to expire in hard interrupt context
      watchdog: Mark watchdog_hrtimer to expire in hard interrupt context
      KVM: LAPIC: Mark hrtimer to expire in hard interrupt context
      tick: Mark tick related hrtimers to expiry in hard interrupt context
      hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT
      hrtimer: Determine hard/soft expiry mode for hrtimer sleepers on RT
      posix-timers: Move rcu_head out of it union
      hrtimer: Add kernel doc annotation for HRTIMER_MODE_HARD
      tick: Mark sched_timer to expire in hard interrupt context
      hrtimer: Add a missing bracket and hide `migration_base' on !SMP

Stephen Boyd (1):
      clocksource: Remove dev_err() usage after platform_get_irq()

Thomas Gleixner (54):
      hrtimer: Remove task argument from hrtimer_init_sleeper()
      hrtimer: Provide hrtimer_sleeper_start_expires()
      hrtimer/treewide: Use hrtimer_sleeper_start_expires()
      hrtimer: Make enqueue mode check work on RT
      posix-timers: Cleanup the flag/flags confusion
      posix-timers: Rework cancel retry loops
      posix-timers: Use a callback for cancel synchronization on PREEMPT_RT
      posix-timers: Cleanup forward declarations and includes
      alarmtimers: Avoid rtc.h include
      posix-cpu-timers: Fixup stale comment
      posix-cpu-timers: Sanitize bogus WARNONS
      posix-cpu-timers: Remove tsk argument from run_posix_cpu_timers()
      posix-cpu-timers: Provide task validation functions
      posix-cpu-timers: Use common permission check in posix_cpu_clock_get()
      posix-cpu-timers: Use common permission check in posix_cpu_timer_create()
      posix-cpu-timers: Provide quick sample function for itimer
      itimers: Use quick sample function
      posix-cpu-timers: Sample directly in timer check
      posix-cpu-timers: Rename thread_group_cputimer() and make it static
      posix-cpu-timers: Consolidate thread group sample code
      posix-cpu-timers: Use clock ID in posix_cpu_timer_set()
      posix-cpu-timers: Use clock ID in posix_cpu_timer_get()
      posix-cpu-timers: Use clock ID in posix_cpu_timer_rearm()
      posix-cpu-timers: Remove pointless return value check
      posix-cpu-timers: Simplify sample functions
      posix-cpu-timers: Get rid of pointer indirection
      posix-cpu-timers: Sample task times once in expiry check
      posix-cpu-timers: Move prof/virt_ticks into caller
      posix-cpu-timers: Create a container struct
      sched: Move struct task_cputime to types.h
      posix-cpu-timers: Move expiry cache into struct posix_cputimers
      posix-cpu-timers: Provide array based access to expiry cache
      posix-cpu-timers: Simplify timer queueing
      posix-cpu-timers: Simplify set_process_cpu_timer()
      posix-cpu-timers: Switch check_*_timers() to array cache
      posix-cpu-timers: Remove the odd field rename defines
      posix-cpu-timers: Provide array based sample functions
      posix-cpu-timers: Make expiry checks array based
      posix-cpu-timers: Remove cputime_expires
      posix-cpu-timers: Restructure expiry array
      posix-cpu-timers: Switch thread group sampling to array
      posix-cpu-timers: Respect INFINITY for hard RTTIME limit
      rlimit: Rewrite non-sensical RLIMIT_CPU comment
      posix-cpu-timers: Get rid of zero checks
      posix-cpu-timers: Consolidate timer expiry further
      posix-cpu-timers: Get rid of 64bit divisions
      posix-cpu-timers: Remove pointless comparisons
      posix-cpu-timers: Deduplicate rlimit handling
      posix-cpu-timers: Move state tracking to struct posix_cputimers
      posix-cpu-timers: Utilize timerqueue for storage
      posix-timers: Unbreak CONFIG_POSIX_TIMERS=n build
      posix-cpu-timers: Make expiry_active check actually work correctly
      posix-cpu-timers: Always clear head pointer on dequeue
      posix-cpu-timers: Fix permission check regression

Tianyu Lan (3):
      clocksource/drivers/hyperv: Allocate Hyper-V TSC page statically
      clocksource/drivers/hyperv: Add Hyper-V specific sched clock function
      x86/hyperv: Hide pv_ops access for CONFIG_PARAVIRT=n

Vitaly Kuznetsov (1):
      clocksource/drivers/hyperv: Enable TSC page clocksource on 32bit


 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |  102 ++
 .../bindings/timer/allwinner,sun4i-timer.txt       |   19 -
 .../bindings/timer/allwinner,sun5i-a13-hstimer.txt |   26 -
 .../timer/allwinner,sun5i-a13-hstimer.yaml         |   79 ++
 .../devicetree/bindings/timer/renesas,cmt.txt      |   40 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |    8 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |    8 +
 arch/x86/entry/vdso/vma.c                          |    2 +-
 arch/x86/hyperv/hv_init.c                          |    2 -
 arch/x86/include/asm/vdso/gettimeofday.h           |    6 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   10 +
 arch/x86/kvm/lapic.c                               |    6 +-
 block/blk-mq.c                                     |    5 +-
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/clocksource/em_sti.c                       |    4 +-
 drivers/clocksource/hyperv_timer.c                 |   45 +-
 drivers/clocksource/renesas-ostm.c                 |    2 +-
 drivers/clocksource/sh_cmt.c                       |   19 +-
 drivers/clocksource/sh_tmu.c                       |    5 +-
 drivers/clocksource/timer-atmel-tcb.c              |   18 +
 drivers/clocksource/timer-imx-sysctr.c             |    5 +
 drivers/clocksource/timer-npcm7xx.c                |    9 +-
 drivers/clocksource/timer-of.c                     |    6 +-
 drivers/clocksource/timer-probe.c                  |    4 +-
 drivers/clocksource/timer-sun4i.c                  |    4 +
 drivers/hv/Kconfig                                 |    3 -
 drivers/staging/android/vsoc.c                     |    8 +-
 fs/timerfd.c                                       |    6 +-
 include/asm-generic/mshyperv.h                     |    1 +
 include/clocksource/hyperv_timer.h                 |    8 +-
 include/linux/alarmtimer.h                         |    3 +-
 include/linux/hrtimer.h                            |   48 +-
 include/linux/init_task.h                          |   11 -
 include/linux/posix-timers.h                       |  131 ++-
 include/linux/sched.h                              |   29 +-
 include/linux/sched/cputime.h                      |   12 +-
 include/linux/sched/signal.h                       |   14 +-
 include/linux/sched/types.h                        |   23 +
 include/linux/timer.h                              |    2 +-
 include/linux/timerqueue.h                         |   23 +-
 include/linux/wait.h                               |    4 +-
 init/init_task.c                                   |    2 -
 kernel/events/core.c                               |    8 +-
 kernel/fork.c                                      |   34 +-
 kernel/futex.c                                     |   12 +-
 kernel/sched/core.c                                |    6 +-
 kernel/sched/deadline.c                            |    8 +-
 kernel/sched/rt.c                                  |   13 +-
 kernel/sys.c                                       |   16 +-
 kernel/time/alarmtimer.c                           |   16 +-
 kernel/time/hrtimer.c                              |  235 ++++-
 kernel/time/itimer.c                               |   12 +-
 kernel/time/posix-cpu-timers.c                     | 1010 ++++++++++----------
 kernel/time/posix-timers.c                         |   61 +-
 kernel/time/posix-timers.h                         |    1 +
 kernel/time/tick-broadcast-hrtimer.c               |   13 +-
 kernel/time/tick-sched.c                           |   17 +-
 kernel/time/timer.c                                |  105 +-
 kernel/watchdog.c                                  |    4 +-
 lib/timerqueue.c                                   |   30 +-
 net/core/pktgen.c                                  |    6 +-
 61 files changed, 1476 insertions(+), 895 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
 create mode 100644 include/linux/sched/types.h

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
new file mode 100644
index 000000000000..20adc1c8e9cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/allwinner,sun4i-a10-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 Timer Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun4i-a10-timer
+      - allwinner,sun8i-a23-timer
+      - allwinner,sun8i-v3s-timer
+      - allwinner,suniv-f1c100s-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      List of timers interrupts
+
+  clocks:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,sun4i-a10-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,sun8i-a23-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,sun8i-v3s-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          items:
+            const: allwinner,suniv-f1c100s-timer
+
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer {
+        compatible = "allwinner,sun4i-a10-timer";
+        reg = <0x01c20c00 0x400>;
+        interrupts = <22>,
+                     <23>,
+                     <24>,
+                     <25>,
+                     <67>,
+                     <68>;
+        clocks = <&osc>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
deleted file mode 100644
index 3da9d515c03a..000000000000
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Allwinner A1X SoCs Timer Controller
-
-Required properties:
-
-- compatible : should be one of the following:
-              "allwinner,sun4i-a10-timer"
-              "allwinner,suniv-f1c100s-timer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The interrupt of the first timer
-- clocks: phandle to the source clock (usually a 24 MHz fixed clock)
-
-Example:
-
-timer {
-	compatible = "allwinner,sun4i-a10-timer";
-	reg = <0x01c20c00 0x400>;
-	interrupts = <22>;
-	clocks = <&osc>;
-};
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
deleted file mode 100644
index 2c5c1be78360..000000000000
--- a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Allwinner SoCs High Speed Timer Controller
-
-Required properties:
-
-- compatible :	should be "allwinner,sun5i-a13-hstimer" or
-		"allwinner,sun7i-a20-hstimer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts :	The interrupts of these timers (2 for the sun5i IP, 4 for the sun7i
-		one)
-- clocks: phandle to the source clock (usually the AHB clock)
-
-Optional properties:
-- resets: phandle to a reset controller asserting the timer
-
-Example:
-
-timer@1c60000 {
-	compatible = "allwinner,sun7i-a20-hstimer";
-	reg = <0x01c60000 0x1000>;
-	interrupts = <0 51 1>,
-		     <0 52 1>,
-		     <0 53 1>,
-		     <0 54 1>;
-	clocks = <&ahb1_gates 19>;
-	resets = <&ahb1rst 19>;
-};
diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
new file mode 100644
index 000000000000..dfa0c41fd261
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun5i-a13-hstimer.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/allwinner,sun5i-a13-hstimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A13 High-Speed Timer Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun5i-a13-hstimer
+      - const: allwinner,sun7i-a20-hstimer
+      - items:
+          - const: allwinner,sun6i-a31-hstimer
+          - const: allwinner,sun7i-a20-hstimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 4
+    items:
+      - description: Timer 0 Interrupt
+      - description: Timer 1 Interrupt
+      - description: Timer 2 Interrupt
+      - description: Timer 3 Interrupt
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+if:
+  properties:
+    compatible:
+      items:
+        const: allwinner,sun5i-a13-hstimer
+
+then:
+  properties:
+    interrupts:
+      minItems: 2
+      maxItems: 2
+
+else:
+  properties:
+    interrupts:
+      minItems: 4
+      maxItems: 4
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@1c60000 {
+        compatible = "allwinner,sun7i-a20-hstimer";
+        reg = <0x01c60000 0x1000>;
+        interrupts = <0 51 1>,
+                     <0 52 1>,
+                     <0 53 1>,
+                     <0 54 1>;
+        clocks = <&ahb1_gates 19>;
+        resets = <&ahb1rst 19>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index c5220bcd852b..a444cfc5852a 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -12,16 +12,13 @@ datasheets.
 Required Properties:
 
   - compatible: must contain one or more of the following:
-    - "renesas,cmt-48-sh73a0" for the sh73A0 48-bit CMT
-		(CMT1)
-    - "renesas,cmt-48-r8a7740" for the r8a7740 48-bit CMT
-		(CMT1)
-    - "renesas,cmt-48" for all non-second generation 48-bit CMT
-		(CMT1 on sh73a0 and r8a7740)
-		This is a fallback for the above renesas,cmt-48-* entries.
-
     - "renesas,r8a73a4-cmt0" for the 32-bit CMT0 device included in r8a73a4.
     - "renesas,r8a73a4-cmt1" for the 48-bit CMT1 device included in r8a73a4.
+    - "renesas,r8a7740-cmt0" for the 32-bit CMT0 device included in r8a7740.
+    - "renesas,r8a7740-cmt1" for the 48-bit CMT1 device included in r8a7740.
+    - "renesas,r8a7740-cmt2" for the 32-bit CMT2 device included in r8a7740.
+    - "renesas,r8a7740-cmt3" for the 32-bit CMT3 device included in r8a7740.
+    - "renesas,r8a7740-cmt4" for the 32-bit CMT4 device included in r8a7740.
     - "renesas,r8a7743-cmt0" for the 32-bit CMT0 device included in r8a7743.
     - "renesas,r8a7743-cmt1" for the 48-bit CMT1 device included in r8a7743.
     - "renesas,r8a7744-cmt0" for the 32-bit CMT0 device included in r8a7744.
@@ -31,29 +28,38 @@ Required Properties:
     - "renesas,r8a77470-cmt0" for the 32-bit CMT0 device included in r8a77470.
     - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
     - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
-    - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
+    - "renesas,r8a774a1-cmt1" for the 48-bit CMT devices included in r8a774a1.
     - "renesas,r8a774c0-cmt0" for the 32-bit CMT0 device included in r8a774c0.
-    - "renesas,r8a774c0-cmt1" for the 48-bit CMT1 device included in r8a774c0.
+    - "renesas,r8a774c0-cmt1" for the 48-bit CMT devices included in r8a774c0.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
     - "renesas,r8a7791-cmt1" for the 48-bit CMT1 device included in r8a7791.
+    - "renesas,r8a7792-cmt0" for the 32-bit CMT0 device included in r8a7792.
+    - "renesas,r8a7792-cmt1" for the 48-bit CMT1 device included in r8a7792.
     - "renesas,r8a7793-cmt0" for the 32-bit CMT0 device included in r8a7793.
     - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
     - "renesas,r8a7795-cmt0" for the 32-bit CMT0 device included in r8a7795.
-    - "renesas,r8a7795-cmt1" for the 48-bit CMT1 device included in r8a7795.
+    - "renesas,r8a7795-cmt1" for the 48-bit CMT devices included in r8a7795.
     - "renesas,r8a7796-cmt0" for the 32-bit CMT0 device included in r8a7796.
-    - "renesas,r8a7796-cmt1" for the 48-bit CMT1 device included in r8a7796.
+    - "renesas,r8a7796-cmt1" for the 48-bit CMT devices included in r8a7796.
     - "renesas,r8a77965-cmt0" for the 32-bit CMT0 device included in r8a77965.
-    - "renesas,r8a77965-cmt1" for the 48-bit CMT1 device included in r8a77965.
+    - "renesas,r8a77965-cmt1" for the 48-bit CMT devices included in r8a77965.
     - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
-    - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
+    - "renesas,r8a77970-cmt1" for the 48-bit CMT devices included in r8a77970.
     - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
-    - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
+    - "renesas,r8a77980-cmt1" for the 48-bit CMT devices included in r8a77980.
     - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
-    - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
+    - "renesas,r8a77990-cmt1" for the 48-bit CMT devices included in r8a77990.
+    - "renesas,r8a77995-cmt0" for the 32-bit CMT0 device included in r8a77995.
+    - "renesas,r8a77995-cmt1" for the 48-bit CMT devices included in r8a77995.
+    - "renesas,sh73a0-cmt0" for the 32-bit CMT0 device included in sh73a0.
+    - "renesas,sh73a0-cmt1" for the 48-bit CMT1 device included in sh73a0.
+    - "renesas,sh73a0-cmt2" for the 32-bit CMT2 device included in sh73a0.
+    - "renesas,sh73a0-cmt3" for the 32-bit CMT3 device included in sh73a0.
+    - "renesas,sh73a0-cmt4" for the 32-bit CMT4 device included in sh73a0.
 
     - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
 		and RZ/G1.
@@ -63,7 +69,7 @@ Required Properties:
 		listed above.
     - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3
 		and RZ/G2.
-    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT devices included in R-Car Gen3
 		and RZ/G2.
 		These are fallbacks for R-Car Gen3 and RZ/G2 entries listed
 		above.
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 232a7412755a..89ef22a8f81e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -510,6 +510,14 @@
 				#pwm-cells = <2>;
 				status = "disabled";
 			};
+
+			system_counter: timer@306a0000 {
+				compatible = "nxp,sysctr-timer";
+				reg = <0x306a0000 0x20000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_24m>;
+				clock-names = "per";
+			};
 		};
 
 		aips3: bus@30800000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808eff87..b4529773af51 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -635,6 +635,14 @@
 				#pwm-cells = <2>;
 				status = "disabled";
 			};
+
+			system_counter: timer@306a0000 {
+				compatible = "nxp,sysctr-timer";
+				reg = <0x306a0000 0x20000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_25m>;
+				clock-names = "per";
+			};
 		};
 
 		bus@30800000 { /* AIPS3 */
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 349a61d8bf34..f5937742b290 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -122,7 +122,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
-					vmalloc_to_pfn(tsc_pg));
+					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0d258688c8cf..866dfb3dca48 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -301,8 +301,6 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
-	/* Register Hyper-V specific clocksource */
-	hv_init_clocksource();
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index ae91429129a6..bcbf901befbe 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -51,7 +51,7 @@ extern struct pvclock_vsyscall_time_info pvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
@@ -192,7 +192,7 @@ static u64 vread_pvclock(void)
 }
 #endif
 
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 static u64 vread_hvclock(void)
 {
 	return hv_read_tsc_page(&hvclock_page);
@@ -215,7 +215,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode)
 		return vread_pvclock();
 	}
 #endif
-#ifdef CONFIG_HYPERV_TSCPAGE
+#ifdef CONFIG_HYPERV_TIMER
 	if (clock_mode == VCLOCK_HVCLOCK) {
 		barrier();
 		return vread_hvclock();
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 062f77279ce3..267daad8c036 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -29,6 +29,7 @@
 #include <asm/timer.h>
 #include <asm/reboot.h>
 #include <asm/nmi.h>
+#include <clocksource/hyperv_timer.h>
 
 struct ms_hyperv_info ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
@@ -338,6 +339,15 @@ static void __init ms_hyperv_init_platform(void)
 		x2apic_phys = 1;
 # endif
 
+	/* Register Hyper-V specific clocksource */
+	hv_init_clocksource();
+#endif
+}
+
+void hv_setup_sched_clock(void *sched_clock)
+{
+#ifdef CONFIG_PARAVIRT
+	pv_ops.time.sched_clock = sched_clock;
 #endif
 }
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0aa158657f20..b9e516099d07 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1601,7 +1601,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
 	    likely(ns > apic->lapic_timer.timer_advance_ns)) {
 		expire = ktime_add_ns(now, ns);
 		expire = ktime_sub_ns(expire, ktimer->timer_advance_ns);
-		hrtimer_start(&ktimer->timer, expire, HRTIMER_MODE_ABS);
+		hrtimer_start(&ktimer->timer, expire, HRTIMER_MODE_ABS_HARD);
 	} else
 		apic_timer_expired(apic);
 
@@ -2302,7 +2302,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
 	apic->vcpu = vcpu;
 
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS);
+		     HRTIMER_MODE_ABS_HARD);
 	apic->lapic_timer.timer.function = apic_timer_fn;
 	if (timer_advance_ns == -1) {
 		apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_ADJUST_INIT;
@@ -2487,7 +2487,7 @@ void __kvm_migrate_apic_timer(struct kvm_vcpu *vcpu)
 
 	timer = &vcpu->arch.apic->lapic_timer.timer;
 	if (hrtimer_cancel(timer))
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_HARD);
 }
 
 /*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..f567146f9ed7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3415,15 +3415,14 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	kt = nsecs;
 
 	mode = HRTIMER_MODE_REL;
-	hrtimer_init_on_stack(&hs.timer, CLOCK_MONOTONIC, mode);
+	hrtimer_init_sleeper_on_stack(&hs, CLOCK_MONOTONIC, mode);
 	hrtimer_set_expires(&hs.timer, kt);
 
-	hrtimer_init_sleeper(&hs, current);
 	do {
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		hrtimer_start_expires(&hs.timer, mode);
+		hrtimer_sleeper_start_expires(&hs, mode);
 		if (hs.task)
 			io_schedule();
 		hrtimer_cancel(&hs.timer);
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e9317dc3d39..a642c23b2fba 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -429,7 +429,7 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on ARM && HAS_IOMEM
 	select TIMER_OF if OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 8e12b11e81b0..9039df4f90e2 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -291,10 +291,8 @@ static int em_sti_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	/* map memory, let base point to the STI instance */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba2c79e6a0ee..2317d4e3daaf 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -22,6 +22,7 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
+static u64 hv_sched_clock_offset __ro_after_init;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -212,19 +213,17 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-
-static struct ms_hyperv_tsc_page *tsc_pg;
+static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return tsc_pg;
+	return &tsc_pg;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
-static u64 notrace read_hv_sched_clock_tsc(void)
+static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 {
-	u64 current_tick = hv_read_tsc_page(tsc_pg);
+	u64 current_tick = hv_read_tsc_page(&tsc_pg);
 
 	if (current_tick == U64_MAX)
 		hv_get_time_ref_count(current_tick);
@@ -232,9 +231,9 @@ static u64 notrace read_hv_sched_clock_tsc(void)
 	return current_tick;
 }
 
-static u64 read_hv_clock_tsc(struct clocksource *arg)
+static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_sched_clock_tsc();
+	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_tsc = {
@@ -244,9 +243,8 @@ static struct clocksource hyperv_cs_tsc = {
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
-#endif
 
-static u64 notrace read_hv_sched_clock_msr(void)
+static u64 notrace read_hv_clock_msr(struct clocksource *arg)
 {
 	u64 current_tick;
 	/*
@@ -258,9 +256,9 @@ static u64 notrace read_hv_sched_clock_msr(void)
 	return current_tick;
 }
 
-static u64 read_hv_clock_msr(struct clocksource *arg)
+static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_sched_clock_msr();
+	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
 }
 
 static struct clocksource hyperv_cs_msr = {
@@ -271,7 +269,6 @@ static struct clocksource hyperv_cs_msr = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
@@ -280,12 +277,8 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	tsc_pg = vmalloc(PAGE_SIZE);
-	if (!tsc_pg)
-		return false;
-
 	hyperv_cs = &hyperv_cs_tsc;
-	phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
+	phys_addr = virt_to_phys(&tsc_pg);
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
@@ -302,17 +295,11 @@ static bool __init hv_init_tsc_clocksource(void)
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
-	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
+	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_setup_sched_clock(read_hv_sched_clock_tsc);
+
 	return true;
 }
-#else
-static bool __init hv_init_tsc_clocksource(void)
-{
-	return false;
-}
-#endif
-
 
 void __init hv_init_clocksource(void)
 {
@@ -333,7 +320,7 @@ void __init hv_init_clocksource(void)
 	hyperv_cs = &hyperv_cs_msr;
 	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 
-	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
-	sched_clock_register(read_hv_sched_clock_msr, 64, HV_CLOCK_HZ);
+	hv_sched_clock_offset = hyperv_cs->read(hyperv_cs);
+	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 61d5f3b539ce..37c39b901bb1 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -221,7 +221,7 @@ static int __init ostm_init(struct device_node *np)
 	}
 
 	rate = clk_get_rate(ostm_clk);
-	ostm->ticks_per_jiffy = (rate + HZ / 2) / HZ;
+	ostm->ticks_per_jiffy = DIV_ROUND_CLOSEST(rate, HZ);
 
 	/*
 	 * First probed device will be used as system clocksource. Any
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 55d3e03f2cd4..ef773db080e9 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -776,11 +776,8 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	int ret;
 
 	irq = platform_get_irq(ch->cmt->pdev, ch->index);
-	if (irq < 0) {
-		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_irq(irq, sh_cmt_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
@@ -921,12 +918,24 @@ static const struct platform_device_id sh_cmt_id_table[] = {
 MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
 
 static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
-	{ .compatible = "renesas,cmt-48", .data = &sh_cmt_info[SH_CMT_48BIT] },
+	{
+		/* deprecated, preserved for backward compatibility */
+		.compatible = "renesas,cmt-48",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
 	{
 		/* deprecated, preserved for backward compatibility */
 		.compatible = "renesas,cmt-48-gen2",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
 	},
+	{
+		.compatible = "renesas,r8a7740-cmt1",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
+	{
+		.compatible = "renesas,sh73a0-cmt1",
+		.data = &sh_cmt_info[SH_CMT_48BIT]
+	},
 	{
 		.compatible = "renesas,rcar-gen2-cmt0",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 49f1c805fc95..8c4f3753b36e 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -462,11 +462,8 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 		ch->base = tmu->mapbase + 8 + ch->index * 12;
 
 	ch->irq = platform_get_irq(tmu->pdev, index);
-	if (ch->irq < 0) {
-		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
+	if (ch->irq < 0)
 		return ch->irq;
-	}
 
 	ch->cs_enabled = false;
 	ch->enable_count = 0;
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 6ed31f9def7e..7427b07495a8 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -6,6 +6,7 @@
 #include <linux/irq.h>
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -125,6 +126,18 @@ static u64 notrace tc_sched_clock_read32(void)
 	return tc_get_cycles32(&clksrc);
 }
 
+static struct delay_timer tc_delay_timer;
+
+static unsigned long tc_delay_timer_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static unsigned long notrace tc_delay_timer_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -432,6 +445,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read32;
+		tc_delay_timer.read_current_timer = tc_delay_timer_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -444,6 +458,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read;
+		tc_delay_timer.read_current_timer = tc_delay_timer_read;
 	}
 
 	/* and away we go! */
@@ -458,6 +473,9 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	sched_clock_register(tc_sched_clock, 32, divided_rate);
 
+	tc_delay_timer.freq = divided_rate;
+	register_current_timer_delay(&tc_delay_timer);
+
 	return 0;
 
 err_unregister_clksrc:
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index fd7d68066efb..b7c80a368a1b 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,6 +20,8 @@
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
 
+#define SYS_CTR_CLK_DIV		0x3
+
 static void __iomem *sys_ctr_base;
 static u32 cmpcr;
 
@@ -134,6 +136,9 @@ static int __init sysctr_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
+	/* system counter clock is divided by 3 internally */
+	to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
+
 	sys_ctr_base = timer_of_base(&to_sysctr);
 	cmpcr = readl(sys_ctr_base + CMPCR);
 	cmpcr &= ~SYS_CTR_EN;
diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index 8a30da7f083b..9780ffd8010e 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN		BIT(29)
 #define NPCM7XX_Tx_COUNTEN		BIT(30)
 #define NPCM7XX_Tx_ONESHOT		0x0
-#define NPCM7XX_Tx_OPER			GENMASK(27, 3)
+#define NPCM7XX_Tx_OPER			GENMASK(28, 27)
 #define NPCM7XX_Tx_MIN_PRESCALE		0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS	24
 #define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
@@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct clock_event_device *evt)
 
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val |= NPCM7XX_START_ONESHOT_Tx;
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
@@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct clock_event_device *evt)
 	struct timer_of *to = to_timer_of(evt);
 	u32 val;
 
+	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
 	val |= NPCM7XX_START_PERIODIC_Tx;
-
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
 	return 0;
diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 80542289fae7..d8c2bd4391d0 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -113,8 +113,10 @@ static __init int timer_of_clk_init(struct device_node *np,
 	of_clk->clk = of_clk->name ? of_clk_get_by_name(np, of_clk->name) :
 		of_clk_get(np, of_clk->index);
 	if (IS_ERR(of_clk->clk)) {
-		pr_err("Failed to get clock for %pOF\n", np);
-		return PTR_ERR(of_clk->clk);
+		ret = PTR_ERR(of_clk->clk);
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to get clock for %pOF\n", np);
+		goto out;
 	}
 
 	ret = clk_prepare_enable(of_clk->clk);
diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index dda1946e84dd..ee9574da53c0 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -29,7 +29,9 @@ void __init timer_probe(void)
 
 		ret = init_func_ret(np);
 		if (ret) {
-			pr_err("Failed to initialize '%pOF': %d\n", np, ret);
+			if (ret != -EPROBE_DEFER)
+				pr_err("Failed to initialize '%pOF': %d\n", np,
+				       ret);
 			continue;
 		}
 
diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 65f38f6ca714..0ba8155b8287 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -219,5 +219,9 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(sun8i_a23, "allwinner,sun8i-a23-timer",
+		 sun4i_timer_init);
+TIMER_OF_DECLARE(sun8i_v3s, "allwinner,sun8i-v3s-timer",
+		 sun4i_timer_init);
 TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
 		       sun4i_timer_init);
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 9a59957922d4..79e5356a737a 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -14,9 +14,6 @@ config HYPERV
 config HYPERV_TIMER
 	def_bool HYPERV
 
-config HYPERV_TSCPAGE
-       def_bool HYPERV && X86_64
-
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
 	depends on HYPERV && CONNECTOR && NLS
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 00a1ec7b9154..1240bb0317d9 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -437,12 +437,10 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 			return -EINVAL;
 		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
 
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
+		hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC,
+					      HRTIMER_MODE_ABS);
 		hrtimer_set_expires_range_ns(&to->timer, wake_time,
 					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to, current);
 	}
 
 	while (1) {
@@ -460,7 +458,7 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 			break;
 		}
 		if (to) {
-			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
+			hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
 			if (likely(to->task))
 				freezable_schedule();
 			hrtimer_cancel(&to->timer);
diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..48305ba41e3c 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -471,7 +471,11 @@ static int do_timerfd_settime(int ufd, int flags,
 				break;
 		}
 		spin_unlock_irq(&ctx->wqh.lock);
-		cpu_relax();
+
+		if (isalarm(ctx))
+			hrtimer_cancel_wait_running(&ctx->t.alarm.timer);
+		else
+			hrtimer_cancel_wait_running(&ctx->t.tmr);
 	}
 
 	/*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 0becb7d9704d..18d8e2d8210f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -167,6 +167,7 @@ void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
+void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline void hyperv_cleanup(void) {}
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index a821deb8ecb2..422f5e5237be 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -28,12 +28,10 @@ extern void hv_stimer_cleanup(unsigned int cpu);
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
-#if IS_ENABLED(CONFIG_HYPERV)
+#ifdef CONFIG_HYPERV_TIMER
 extern struct clocksource *hyperv_cs;
 extern void hv_init_clocksource(void);
-#endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
 static inline notrace u64
@@ -91,7 +89,7 @@ hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
 	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
 }
 
-#else /* CONFIG_HYPERV_TSC_PAGE */
+#else /* CONFIG_HYPERV_TIMER */
 static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
 	return NULL;
@@ -102,6 +100,6 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 {
 	return U64_MAX;
 }
-#endif /* CONFIG_HYPERV_TSCPAGE */
+#endif /* CONFIG_HYPERV_TIMER */
 
 #endif
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 0760ca1cb009..74748e306f4b 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -5,7 +5,8 @@
 #include <linux/time.h>
 #include <linux/hrtimer.h>
 #include <linux/timerqueue.h>
-#include <linux/rtc.h>
+
+struct rtc_device;
 
 enum alarmtimer_type {
 	ALARM_REALTIME,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 4971100a8cab..1b9a51a1bccb 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -32,12 +32,15 @@ struct hrtimer_cpu_base;
  *				  when starting the timer)
  * HRTIMER_MODE_SOFT		- Timer callback function will be executed in
  *				  soft irq context
+ * HRTIMER_MODE_HARD		- Timer callback function will be executed in
+ *				  hard irq context even on PREEMPT_RT.
  */
 enum hrtimer_mode {
 	HRTIMER_MODE_ABS	= 0x00,
 	HRTIMER_MODE_REL	= 0x01,
 	HRTIMER_MODE_PINNED	= 0x02,
 	HRTIMER_MODE_SOFT	= 0x04,
+	HRTIMER_MODE_HARD	= 0x08,
 
 	HRTIMER_MODE_ABS_PINNED = HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
 	HRTIMER_MODE_REL_PINNED = HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
@@ -48,6 +51,11 @@ enum hrtimer_mode {
 	HRTIMER_MODE_ABS_PINNED_SOFT = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_SOFT,
 	HRTIMER_MODE_REL_PINNED_SOFT = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_SOFT,
 
+	HRTIMER_MODE_ABS_HARD	= HRTIMER_MODE_ABS | HRTIMER_MODE_HARD,
+	HRTIMER_MODE_REL_HARD	= HRTIMER_MODE_REL | HRTIMER_MODE_HARD,
+
+	HRTIMER_MODE_ABS_PINNED_HARD = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_HARD,
+	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
 };
 
 /*
@@ -101,6 +109,8 @@ enum hrtimer_restart {
  * @state:	state information (See bit values above)
  * @is_rel:	Set if the timer was armed relative
  * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
+ * @is_hard:	Set if hrtimer will be expired in hard interrupt context
+ *		even on RT.
  *
  * The hrtimer structure must be initialized by hrtimer_init()
  */
@@ -112,6 +122,7 @@ struct hrtimer {
 	u8				state;
 	u8				is_rel;
 	u8				is_soft;
+	u8				is_hard;
 };
 
 /**
@@ -183,6 +194,10 @@ enum  hrtimer_base_type {
  * @nr_retries:		Total number of hrtimer interrupt retries
  * @nr_hangs:		Total number of hrtimer interrupt hangs
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
+ * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
+ *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
  *			hrtimer enqueue; it is the total first expiry time (hard
  *			and soft hrtimer are taken into account)
@@ -209,6 +224,10 @@ struct hrtimer_cpu_base {
 	unsigned short			nr_retries;
 	unsigned short			nr_hangs;
 	unsigned int			max_hang_time;
+#endif
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t			softirq_expiry_lock;
+	atomic_t			timer_waiters;
 #endif
 	ktime_t				expires_next;
 	struct hrtimer			*next_timer;
@@ -341,16 +360,29 @@ extern void hrtimers_resume(void);
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 
+#ifdef CONFIG_PREEMPT_RT
+void hrtimer_cancel_wait_running(const struct hrtimer *timer);
+#else
+static inline void hrtimer_cancel_wait_running(struct hrtimer *timer)
+{
+	cpu_relax();
+}
+#endif
 
 /* Exported timer functions: */
 
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+				 enum hrtimer_mode mode);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
+extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+					  clockid_t clock_id,
+					  enum hrtimer_mode mode);
 
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
@@ -360,6 +392,14 @@ static inline void hrtimer_init_on_stack(struct hrtimer *timer,
 {
 	hrtimer_init(timer, which_clock, mode);
 }
+
+static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+						 clockid_t clock_id,
+						 enum hrtimer_mode mode)
+{
+	hrtimer_init_sleeper(sl, clock_id, mode);
+}
+
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
 
@@ -395,6 +435,9 @@ static inline void hrtimer_start_expires(struct hrtimer *timer,
 	hrtimer_start_range_ns(timer, soft, delta, mode);
 }
 
+void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
+				   enum hrtimer_mode mode);
+
 static inline void hrtimer_restart(struct hrtimer *timer)
 {
 	hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
@@ -463,11 +506,8 @@ extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
 			      const enum hrtimer_mode mode,
 			      const clockid_t clockid);
 
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				 struct task_struct *tsk);
-
 extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
-						const enum hrtimer_mode mode);
+				    const enum hrtimer_mode mode);
 extern int schedule_hrtimeout_range_clock(ktime_t *expires,
 					  u64 delta,
 					  const enum hrtimer_mode mode,
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 6049baa5b8bc..2c620d7ac432 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -36,17 +36,6 @@ extern struct cred init_cred;
 #define INIT_PREV_CPUTIME(x)
 #endif
 
-#ifdef CONFIG_POSIX_TIMERS
-#define INIT_CPU_TIMERS(s)						\
-	.cpu_timers = {							\
-		LIST_HEAD_INIT(s.cpu_timers[0]),			\
-		LIST_HEAD_INIT(s.cpu_timers[1]),			\
-		LIST_HEAD_INIT(s.cpu_timers[2]),			\
-	},
-#else
-#define INIT_CPU_TIMERS(s)
-#endif
-
 #define INIT_TASK_COMM "swapper"
 
 /* Attach to the init_task data structure for proper alignment */
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index b20798fc5191..3d10c84a97a9 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,18 +4,11 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
-#include <linux/sched.h>
-#include <linux/timex.h>
 #include <linux/alarmtimer.h>
+#include <linux/timerqueue.h>
 
-struct siginfo;
-
-struct cpu_timer_list {
-	struct list_head entry;
-	u64 expires;
-	struct task_struct *task;
-	int firing;
-};
+struct kernel_siginfo;
+struct task_struct;
 
 /*
  * Bit fields within a clockid:
@@ -63,6 +56,115 @@ static inline int clockid_to_fd(const clockid_t clk)
 	return ~(clk >> 3);
 }
 
+#ifdef CONFIG_POSIX_TIMERS
+
+/**
+ * cpu_timer - Posix CPU timer representation for k_itimer
+ * @node:	timerqueue node to queue in the task/sig
+ * @head:	timerqueue head on which this timer is queued
+ * @task:	Pointer to target task
+ * @elist:	List head for the expiry list
+ * @firing:	Timer is currently firing
+ */
+struct cpu_timer {
+	struct timerqueue_node	node;
+	struct timerqueue_head	*head;
+	struct task_struct	*task;
+	struct list_head	elist;
+	int			firing;
+};
+
+static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
+				     struct cpu_timer *ctmr)
+{
+	ctmr->head = head;
+	return timerqueue_add(head, &ctmr->node);
+}
+
+static inline void cpu_timer_dequeue(struct cpu_timer *ctmr)
+{
+	if (ctmr->head) {
+		timerqueue_del(ctmr->head, &ctmr->node);
+		ctmr->head = NULL;
+	}
+}
+
+static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
+{
+	return ctmr->node.expires;
+}
+
+static inline void cpu_timer_setexpires(struct cpu_timer *ctmr, u64 exp)
+{
+	ctmr->node.expires = exp;
+}
+
+/**
+ * posix_cputimer_base - Container per posix CPU clock
+ * @nextevt:		Earliest-expiration cache
+ * @tqhead:		timerqueue head for cpu_timers
+ */
+struct posix_cputimer_base {
+	u64			nextevt;
+	struct timerqueue_head	tqhead;
+};
+
+/**
+ * posix_cputimers - Container for posix CPU timer related data
+ * @bases:		Base container for posix CPU clocks
+ * @timers_active:	Timers are queued.
+ * @expiry_active:	Timer expiry is active. Used for
+ *			process wide timers to avoid multiple
+ *			task trying to handle expiry concurrently
+ *
+ * Used in task_struct and signal_struct
+ */
+struct posix_cputimers {
+	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
+	unsigned int			timers_active;
+	unsigned int			expiry_active;
+};
+
+static inline void posix_cputimers_init(struct posix_cputimers *pct)
+{
+	memset(pct, 0, sizeof(*pct));
+	pct->bases[0].nextevt = U64_MAX;
+	pct->bases[1].nextevt = U64_MAX;
+	pct->bases[2].nextevt = U64_MAX;
+}
+
+void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit);
+
+static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
+					       u64 runtime)
+{
+	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
+}
+
+/* Init task static initializer */
+#define INIT_CPU_TIMERBASE(b) {						\
+	.nextevt	= U64_MAX,					\
+}
+
+#define INIT_CPU_TIMERBASES(b) {					\
+	INIT_CPU_TIMERBASE(b[0]),					\
+	INIT_CPU_TIMERBASE(b[1]),					\
+	INIT_CPU_TIMERBASE(b[2]),					\
+}
+
+#define INIT_CPU_TIMERS(s)						\
+	.posix_cputimers = {						\
+		.bases = INIT_CPU_TIMERBASES(s.posix_cputimers.bases),	\
+	},
+#else
+struct posix_cputimers { };
+struct cpu_timer { };
+#define INIT_CPU_TIMERS(s)
+static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
+static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
+					      u64 cpu_limit) { }
+#endif
+
 #define REQUEUE_PENDING 1
 
 /**
@@ -85,7 +187,8 @@ static inline int clockid_to_fd(const clockid_t clk)
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
- *			internals. Also used for rcu freeing the timer.
+ *			internals.
+ * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
 	struct list_head	list;
@@ -110,15 +213,15 @@ struct k_itimer {
 		struct {
 			struct hrtimer	timer;
 		} real;
-		struct cpu_timer_list	cpu;
+		struct cpu_timer	cpu;
 		struct {
 			struct alarm	alarmtimer;
 		} alarm;
-		struct rcu_head		rcu;
 	} it;
+	struct rcu_head		rcu;
 };
 
-void run_posix_cpu_timers(struct task_struct *task);
+void run_posix_cpu_timers(void);
 void posix_cpu_timers_exit(struct task_struct *task);
 void posix_cpu_timers_exit_group(struct task_struct *task);
 void set_process_cpu_timer(struct task_struct *task, unsigned int clock_idx,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8dc1811487f5..8cc8e323093f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -25,9 +25,11 @@
 #include <linux/resource.h>
 #include <linux/latencytop.h>
 #include <linux/sched/prio.h>
+#include <linux/sched/types.h>
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/posix-timers.h>
 #include <linux/rseq.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -244,27 +246,6 @@ struct prev_cputime {
 #endif
 };
 
-/**
- * struct task_cputime - collected CPU time counts
- * @utime:		time spent in user mode, in nanoseconds
- * @stime:		time spent in kernel mode, in nanoseconds
- * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
- *
- * This structure groups together three kinds of CPU time that are tracked for
- * threads and thread groups.  Most things considering CPU time want to group
- * these counts together and treat all three of them in parallel.
- */
-struct task_cputime {
-	u64				utime;
-	u64				stime;
-	unsigned long long		sum_exec_runtime;
-};
-
-/* Alternate field names when used on cache expirations: */
-#define virt_exp			utime
-#define prof_exp			stime
-#define sched_exp			sum_exec_runtime
-
 enum vtime_state {
 	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
@@ -876,10 +857,8 @@ struct task_struct {
 	unsigned long			min_flt;
 	unsigned long			maj_flt;
 
-#ifdef CONFIG_POSIX_TIMERS
-	struct task_cputime		cputime_expires;
-	struct list_head		cpu_timers[3];
-#endif
+	/* Empty if CONFIG_POSIX_CPUTIMERS=n */
+	struct posix_cputimers		posix_cputimers;
 
 	/* Process credentials: */
 
diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 53f883f5a2fd..6c9f19a33865 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -61,8 +61,7 @@ extern void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
  * Thread group CPU time accounting.
  */
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times);
-void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times);
-
+void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples);
 
 /*
  * The following are functions that support scheduler-internal time accounting.
@@ -71,7 +70,7 @@ void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times);
  */
 
 /**
- * get_running_cputimer - return &tsk->signal->cputimer if cputimer is running
+ * get_running_cputimer - return &tsk->signal->cputimer if cputimers are active
  *
  * @tsk:	Pointer to target task.
  */
@@ -81,8 +80,11 @@ struct thread_group_cputimer *get_running_cputimer(struct task_struct *tsk)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 
-	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(cputimer->running))
+	/*
+	 * Check whether posix CPU timers are active. If not the thread
+	 * group accounting is not active either. Lockless check.
+	 */
+	if (!READ_ONCE(tsk->signal->posix_cputimers.timers_active))
 		return NULL;
 
 	/*
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index efd8ce7675ed..88050259c466 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -9,6 +9,7 @@
 #include <linux/sched/task.h>
 #include <linux/cred.h>
 #include <linux/refcount.h>
+#include <linux/posix-timers.h>
 
 /*
  * Types defining task->signal and task->sighand and APIs using them:
@@ -56,18 +57,12 @@ struct task_cputime_atomic {
 /**
  * struct thread_group_cputimer - thread group interval timer counts
  * @cputime_atomic:	atomic thread group interval timers.
- * @running:		true when there are timers running and
- *			@cputime_atomic receives updates.
- * @checking_timer:	true when a thread in the group is in the
- *			process of checking for thread group timers.
  *
  * This structure contains the version of task_cputime, above, that is
  * used for thread group CPU timer calculations.
  */
 struct thread_group_cputimer {
 	struct task_cputime_atomic cputime_atomic;
-	bool running;
-	bool checking_timer;
 };
 
 struct multiprocess_signals {
@@ -148,12 +143,9 @@ struct signal_struct {
 	 */
 	struct thread_group_cputimer cputimer;
 
-	/* Earliest-expiration cache. */
-	struct task_cputime cputime_expires;
-
-	struct list_head cpu_timers[3];
-
 #endif
+	/* Empty if CONFIG_POSIX_TIMERS=n */
+	struct posix_cputimers posix_cputimers;
 
 	/* PID/PID hash table linkage. */
 	struct pid *pids[PIDTYPE_MAX];
diff --git a/include/linux/sched/types.h b/include/linux/sched/types.h
new file mode 100644
index 000000000000..3c3e049224ae
--- /dev/null
+++ b/include/linux/sched/types.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_TYPES_H
+#define _LINUX_SCHED_TYPES_H
+
+#include <linux/types.h>
+
+/**
+ * struct task_cputime - collected CPU time counts
+ * @stime:		time spent in kernel mode, in nanoseconds
+ * @utime:		time spent in user mode, in nanoseconds
+ * @sum_exec_runtime:	total time spent on the CPU, in nanoseconds
+ *
+ * This structure groups together three kinds of CPU time that are tracked for
+ * threads and thread groups.  Most things considering CPU time want to group
+ * these counts together and treat all three of them in parallel.
+ */
+struct task_cputime {
+	u64				stime;
+	u64				utime;
+	unsigned long long		sum_exec_runtime;
+};
+
+#endif
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 282e4f2a532a..1e6650ed066d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,7 +183,7 @@ extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
   extern int del_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t)		del_timer(t)
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 78b8cc73f12f..93884086f392 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -12,8 +12,7 @@ struct timerqueue_node {
 };
 
 struct timerqueue_head {
-	struct rb_root head;
-	struct timerqueue_node *next;
+	struct rb_root_cached rb_root;
 };
 
 
@@ -29,13 +28,14 @@ extern struct timerqueue_node *timerqueue_iterate_next(
  *
  * @head: head of timerqueue
  *
- * Returns a pointer to the timer node that has the
- * earliest expiration time.
+ * Returns a pointer to the timer node that has the earliest expiration time.
  */
 static inline
 struct timerqueue_node *timerqueue_getnext(struct timerqueue_head *head)
 {
-	return head->next;
+	struct rb_node *leftmost = rb_first_cached(&head->rb_root);
+
+	return rb_entry(leftmost, struct timerqueue_node, node);
 }
 
 static inline void timerqueue_init(struct timerqueue_node *node)
@@ -43,9 +43,18 @@ static inline void timerqueue_init(struct timerqueue_node *node)
 	RB_CLEAR_NODE(&node->node);
 }
 
+static inline bool timerqueue_node_queued(struct timerqueue_node *node)
+{
+	return !RB_EMPTY_NODE(&node->node);
+}
+
+static inline bool timerqueue_node_expires(struct timerqueue_node *node)
+{
+	return node->expires;
+}
+
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
-	head->head = RB_ROOT;
-	head->next = NULL;
+	head->rb_root = RB_ROOT_CACHED;
 }
 #endif /* _LINUX_TIMERQUEUE_H */
diff --git a/include/linux/wait.h b/include/linux/wait.h
index b6f77cf60dd7..4707543ef575 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -488,8 +488,8 @@ do {										\
 	int __ret = 0;								\
 	struct hrtimer_sleeper __t;						\
 										\
-	hrtimer_init_on_stack(&__t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);	\
-	hrtimer_init_sleeper(&__t, current);					\
+	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
+				      HRTIMER_MODE_REL);			\
 	if ((timeout) != KTIME_MAX)						\
 		hrtimer_start_range_ns(&__t.timer, timeout,			\
 				       current->timer_slack_ns,			\
diff --git a/init/init_task.c b/init/init_task.c
index 7ab773b9b3cd..d49692a0ec51 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -30,8 +30,6 @@ static struct signal_struct init_signals = {
 	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
 	.cputimer	= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
-		.running	= false,
-		.checking_timer = false,
 	},
 #endif
 	INIT_CPU_TIMERS(init_signals)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..9d623e257a51 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1103,7 +1103,7 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
 	cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
 
 	raw_spin_lock_init(&cpuctx->hrtimer_lock);
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	timer->function = perf_mux_hrtimer_handler;
 }
 
@@ -1121,7 +1121,7 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
 	if (!cpuctx->hrtimer_active) {
 		cpuctx->hrtimer_active = 1;
 		hrtimer_forward_now(timer, cpuctx->hrtimer_interval);
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	}
 	raw_spin_unlock_irqrestore(&cpuctx->hrtimer_lock, flags);
 
@@ -9491,7 +9491,7 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 		period = max_t(u64, 10000, hwc->sample_period);
 	}
 	hrtimer_start(&hwc->hrtimer, ns_to_ktime(period),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 
 static void perf_swevent_cancel_hrtimer(struct perf_event *event)
@@ -9513,7 +9513,7 @@ static void perf_swevent_init_hrtimer(struct perf_event *event)
 	if (!is_sampling_event(event))
 		return;
 
-	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hwc->hrtimer.function = perf_swevent_hrtimer;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..f1228d9f0b11 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1517,28 +1517,17 @@ void __cleanup_sighand(struct sighand_struct *sighand)
 	}
 }
 
-#ifdef CONFIG_POSIX_TIMERS
 /*
  * Initialize POSIX timer handling for a thread group.
  */
 static void posix_cpu_timers_init_group(struct signal_struct *sig)
 {
+	struct posix_cputimers *pct = &sig->posix_cputimers;
 	unsigned long cpu_limit;
 
 	cpu_limit = READ_ONCE(sig->rlim[RLIMIT_CPU].rlim_cur);
-	if (cpu_limit != RLIM_INFINITY) {
-		sig->cputime_expires.prof_exp = cpu_limit * NSEC_PER_SEC;
-		sig->cputimer.running = true;
-	}
-
-	/* The timer lists. */
-	INIT_LIST_HEAD(&sig->cpu_timers[0]);
-	INIT_LIST_HEAD(&sig->cpu_timers[1]);
-	INIT_LIST_HEAD(&sig->cpu_timers[2]);
+	posix_cputimers_group_init(pct, cpu_limit);
 }
-#else
-static inline void posix_cpu_timers_init_group(struct signal_struct *sig) { }
-#endif
 
 static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 {
@@ -1640,23 +1629,6 @@ static void rt_mutex_init_task(struct task_struct *p)
 #endif
 }
 
-#ifdef CONFIG_POSIX_TIMERS
-/*
- * Initialize POSIX timer handling for a single task.
- */
-static void posix_cpu_timers_init(struct task_struct *tsk)
-{
-	tsk->cputime_expires.prof_exp = 0;
-	tsk->cputime_expires.virt_exp = 0;
-	tsk->cputime_expires.sched_exp = 0;
-	INIT_LIST_HEAD(&tsk->cpu_timers[0]);
-	INIT_LIST_HEAD(&tsk->cpu_timers[1]);
-	INIT_LIST_HEAD(&tsk->cpu_timers[2]);
-}
-#else
-static inline void posix_cpu_timers_init(struct task_struct *tsk) { }
-#endif
-
 static inline void init_task_pid_links(struct task_struct *task)
 {
 	enum pid_type type;
@@ -1935,7 +1907,7 @@ static __latent_entropy struct task_struct *copy_process(
 	task_io_accounting_init(&p->ioac);
 	acct_clear_integrals(p);
 
-	posix_cpu_timers_init(p);
+	posix_cputimers_init(&p->posix_cputimers);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..bd18f60e4c6c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -487,11 +487,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 	if (!time)
 		return NULL;
 
-	hrtimer_init_on_stack(&timeout->timer, (flags & FLAGS_CLOCKRT) ?
-			      CLOCK_REALTIME : CLOCK_MONOTONIC,
-			      HRTIMER_MODE_ABS);
-	hrtimer_init_sleeper(timeout, current);
-
+	hrtimer_init_sleeper_on_stack(timeout, (flags & FLAGS_CLOCKRT) ?
+				      CLOCK_REALTIME : CLOCK_MONOTONIC,
+				      HRTIMER_MODE_ABS);
 	/*
 	 * If range_ns is 0, calling hrtimer_set_expires_range_ns() is
 	 * effectively the same as calling hrtimer_set_expires().
@@ -2613,7 +2611,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 
 	/* Arm the timer */
 	if (timeout)
-		hrtimer_start_expires(&timeout->timer, HRTIMER_MODE_ABS);
+		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
 
 	/*
 	 * If we have been removed from the hash list, then another task
@@ -2899,7 +2897,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	}
 
 	if (unlikely(to))
-		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
+		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
 
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..389e0993fbb4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -255,7 +255,7 @@ static void __hrtick_restart(struct rq *rq)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
 
-	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
 }
 
 /*
@@ -314,7 +314,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 	 */
 	delay = max_t(u64, delay, 10000LL);
 	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 #endif /* CONFIG_SMP */
 
@@ -328,7 +328,7 @@ static void hrtick_rq_init(struct rq *rq)
 	rq->hrtick_csd.info = rq;
 #endif
 
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
 }
 #else	/* CONFIG_SCHED_HRTICK */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b9f6b1d42..83a663a34196 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -287,7 +287,7 @@ static void task_non_contending(struct task_struct *p)
 
 	dl_se->dl_non_contending = 1;
 	get_task_struct(p);
-	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
+	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
 static void task_contending(struct sched_dl_entity *dl_se, int flags)
@@ -923,7 +923,7 @@ static int start_dl_timer(struct task_struct *p)
 	 */
 	if (!hrtimer_is_queued(timer)) {
 		get_task_struct(p);
-		hrtimer_start(timer, act, HRTIMER_MODE_ABS);
+		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
 	}
 
 	return 1;
@@ -1053,7 +1053,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = dl_task_timer;
 }
 
@@ -1292,7 +1292,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558a5176..d6678f773c96 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -45,8 +45,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
 
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
 
-	hrtimer_init(&rt_b->rt_period_timer,
-			CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL_HARD);
 	rt_b->rt_period_timer.function = sched_rt_period_timer;
 }
 
@@ -67,7 +67,8 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 		 * to update the period.
 		 */
 		hrtimer_forward_now(&rt_b->rt_period_timer, ns_to_ktime(0));
-		hrtimer_start_expires(&rt_b->rt_period_timer, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start_expires(&rt_b->rt_period_timer,
+				      HRTIMER_MODE_ABS_PINNED_HARD);
 	}
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
@@ -2304,8 +2305,10 @@ static void watchdog(struct rq *rq, struct task_struct *p)
 		}
 
 		next = DIV_ROUND_UP(min(soft, hard), USEC_PER_SEC/HZ);
-		if (p->rt.timeout > next)
-			p->cputime_expires.sched_exp = p->se.sum_exec_runtime;
+		if (p->rt.timeout > next) {
+			posix_cputimers_rt_watchdog(&p->posix_cputimers,
+						    p->se.sum_exec_runtime);
+		}
 	}
 }
 #else
diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..2462aa84247f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1557,15 +1557,6 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 			retval = -EPERM;
 		if (!retval)
 			retval = security_task_setrlimit(tsk, resource, new_rlim);
-		if (resource == RLIMIT_CPU && new_rlim->rlim_cur == 0) {
-			/*
-			 * The caller is asking for an immediate RLIMIT_CPU
-			 * expiry.  But we use the zero value to mean "it was
-			 * never set".  So let's cheat and make it one second
-			 * instead
-			 */
-			new_rlim->rlim_cur = 1;
-		}
 	}
 	if (!retval) {
 		if (old_rlim)
@@ -1576,10 +1567,9 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	task_unlock(tsk->group_leader);
 
 	/*
-	 * RLIMIT_CPU handling.   Note that the kernel fails to return an error
-	 * code if it rejected the user's attempt to set RLIMIT_CPU.  This is a
-	 * very long-standing error, and fixing it now risks breakage of
-	 * applications, so we live with it
+	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not
+	 * infite. In case of RLIM_INFINITY the posix CPU timer code
+	 * ignores the rlimit.
 	 */
 	 if (!retval && new_rlim && resource == RLIMIT_CPU &&
 	     new_rlim->rlim_cur != RLIM_INFINITY &&
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 57518efc3810..ec32876e284d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -432,7 +432,7 @@ int alarm_cancel(struct alarm *alarm)
 		int ret = alarm_try_to_cancel(alarm);
 		if (ret >= 0)
 			return ret;
-		cpu_relax();
+		hrtimer_cancel_wait_running(&alarm->timer);
 	}
 }
 EXPORT_SYMBOL_GPL(alarm_cancel);
@@ -605,6 +605,19 @@ static int alarm_timer_try_to_cancel(struct k_itimer *timr)
 	return alarm_try_to_cancel(&timr->it.alarm.alarmtimer);
 }
 
+/**
+ * alarm_timer_wait_running - Posix timer callback to wait for a timer
+ * @timr:	Pointer to the posixtimer data struct
+ *
+ * Called from the core code when timer cancel detected that the callback
+ * is running. @timr is unlocked and rcu read lock is held to prevent it
+ * from being freed.
+ */
+static void alarm_timer_wait_running(struct k_itimer *timr)
+{
+	hrtimer_cancel_wait_running(&timr->it.alarm.alarmtimer.timer);
+}
+
 /**
  * alarm_timer_arm - Posix timer callback to arm a timer
  * @timr:	Pointer to the posixtimer data struct
@@ -834,6 +847,7 @@ const struct k_clock alarm_clock = {
 	.timer_forward		= alarm_timer_forward,
 	.timer_remaining	= alarm_timer_remaining,
 	.timer_try_to_cancel	= alarm_timer_try_to_cancel,
+	.timer_wait_running	= alarm_timer_wait_running,
 	.nsleep			= alarm_timer_nsleep,
 };
 #endif /* CONFIG_POSIX_TIMERS */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5ee77f1a8a92..0d4dc241c0fb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -140,6 +140,11 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -264,6 +269,11 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -427,6 +437,17 @@ void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
 
+static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode);
+
+void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode)
+{
+	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
+
 void destroy_hrtimer_on_stack(struct hrtimer *timer)
 {
 	debug_object_free(timer, &hrtimer_debug_descr);
@@ -1096,9 +1117,13 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
-	 * match.
+	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard
+	 * expiry mode because unmarked timers are moved to softirq expiry.
 	 */
-	WARN_ON_ONCE(!(mode & HRTIMER_MODE_SOFT) ^ !timer->is_soft);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		WARN_ON_ONCE(!(mode & HRTIMER_MODE_SOFT) ^ !timer->is_soft);
+	else
+		WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard);
 
 	base = lock_hrtimer_base(timer, &flags);
 
@@ -1147,6 +1172,93 @@ int hrtimer_try_to_cancel(struct hrtimer *timer)
 }
 EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
 
+#ifdef CONFIG_PREEMPT_RT
+static void hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base)
+{
+	spin_lock_init(&base->softirq_expiry_lock);
+}
+
+static void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base)
+{
+	spin_lock(&base->softirq_expiry_lock);
+}
+
+static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
+{
+	spin_unlock(&base->softirq_expiry_lock);
+}
+
+/*
+ * The counterpart to hrtimer_cancel_wait_running().
+ *
+ * If there is a waiter for cpu_base->expiry_lock, then it was waiting for
+ * the timer callback to finish. Drop expiry_lock and reaquire it. That
+ * allows the waiter to acquire the lock and make progress.
+ */
+static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
+				      unsigned long flags)
+{
+	if (atomic_read(&cpu_base->timer_waiters)) {
+		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+		spin_unlock(&cpu_base->softirq_expiry_lock);
+		spin_lock(&cpu_base->softirq_expiry_lock);
+		raw_spin_lock_irq(&cpu_base->lock);
+	}
+}
+
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
+ *
+ * This prevents priority inversion: if the soft irq thread is preempted
+ * in the middle of a timer callback, then calling del_timer_sync() can
+ * lead to two issues:
+ *
+ *  - If the caller is on a remote CPU then it has to spin wait for the timer
+ *    handler to complete. This can result in unbound priority inversion.
+ *
+ *  - If the caller originates from the task which preempted the timer
+ *    handler on the same CPU, then spin waiting for the timer handler to
+ *    complete is never going to end.
+ */
+void hrtimer_cancel_wait_running(const struct hrtimer *timer)
+{
+	/* Lockless read. Prevent the compiler from reloading it below */
+	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
+
+	/*
+	 * Just relax if the timer expires in hard interrupt context or if
+	 * it is currently on the migration base.
+	 */
+	if (!timer->is_soft || is_migration_base(base)) {
+		cpu_relax();
+		return;
+	}
+
+	/*
+	 * Mark the base as contended and grab the expiry lock, which is
+	 * held by the softirq across the timer callback. Drop the lock
+	 * immediately so the softirq can expire the next timer. In theory
+	 * the timer could already be running again, but that's more than
+	 * unlikely and just causes another wait loop.
+	 */
+	atomic_inc(&base->cpu_base->timer_waiters);
+	spin_lock_bh(&base->cpu_base->softirq_expiry_lock);
+	atomic_dec(&base->cpu_base->timer_waiters);
+	spin_unlock_bh(&base->cpu_base->softirq_expiry_lock);
+}
+#else
+static inline void
+hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base) { }
+static inline void
+hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base) { }
+static inline void
+hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base) { }
+static inline void hrtimer_sync_wait_running(struct hrtimer_cpu_base *base,
+					     unsigned long flags) { }
+#endif
+
 /**
  * hrtimer_cancel - cancel a timer and wait for the handler to finish.
  * @timer:	the timer to be cancelled
@@ -1157,13 +1269,15 @@ EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
  */
 int hrtimer_cancel(struct hrtimer *timer)
 {
-	for (;;) {
-		int ret = hrtimer_try_to_cancel(timer);
+	int ret;
 
-		if (ret >= 0)
-			return ret;
-		cpu_relax();
-	}
+	do {
+		ret = hrtimer_try_to_cancel(timer);
+
+		if (ret < 0)
+			hrtimer_cancel_wait_running(timer);
+	} while (ret < 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
@@ -1260,8 +1374,17 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
-	int base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	struct hrtimer_cpu_base *cpu_base;
+	int base;
+
+	/*
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * marked for hard interrupt expiry mode are moved into soft
+	 * interrupt context for latency reasons and because the callbacks
+	 * can invoke functions which might sleep on RT, e.g. spin_lock().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
+		softtimer = true;
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
@@ -1275,8 +1398,10 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	if (clock_id == CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id = CLOCK_MONOTONIC;
 
+	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
+	timer->is_hard = !softtimer;
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
 }
@@ -1449,6 +1574,8 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 				break;
 
 			__run_hrtimer(cpu_base, base, timer, &basenow, flags);
+			if (active_mask == HRTIMER_ACTIVE_SOFT)
+				hrtimer_sync_wait_running(cpu_base, flags);
 		}
 	}
 }
@@ -1459,6 +1586,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	unsigned long flags;
 	ktime_t now;
 
+	hrtimer_cpu_base_lock_expiry(cpu_base);
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
 	now = hrtimer_update_base(cpu_base);
@@ -1468,6 +1596,7 @@ static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
 	hrtimer_update_softirq_timer(cpu_base, true);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	hrtimer_cpu_base_unlock_expiry(cpu_base);
 }
 
 #ifdef CONFIG_HIGH_RES_TIMERS
@@ -1639,10 +1768,75 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, struct task_struct *task)
+/**
+ * hrtimer_sleeper_start_expires - Start a hrtimer sleeper timer
+ * @sl:		sleeper to be started
+ * @mode:	timer mode abs/rel
+ *
+ * Wrapper around hrtimer_start_expires() for hrtimer_sleeper based timers
+ * to allow PREEMPT_RT to tweak the delivery mode (soft/hardirq context)
+ */
+void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
+				   enum hrtimer_mode mode)
+{
+	/*
+	 * Make the enqueue delivery mode check work on RT. If the sleeper
+	 * was initialized for hard interrupt delivery, force the mode bit.
+	 * This is a special case for hrtimer_sleepers because
+	 * hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * fiddling with this decision is avoided at the call sites.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
+		mode |= HRTIMER_MODE_HARD;
+
+	hrtimer_start_expires(&sl->timer, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
+
+static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode)
 {
+	/*
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * marked for hard interrupt expiry mode are moved into soft
+	 * interrupt context either for latency reasons or because the
+	 * hrtimer callback takes regular spinlocks or invokes other
+	 * functions which are not suitable for hard interrupt context on
+	 * PREEMPT_RT.
+	 *
+	 * The hrtimer_sleeper callback is RT compatible in hard interrupt
+	 * context, but there is a latency concern: Untrusted userspace can
+	 * spawn many threads which arm timers for the same expiry time on
+	 * the same CPU. That causes a latency spike due to the wakeup of
+	 * a gazillion threads.
+	 *
+	 * OTOH, priviledged real-time user space applications rely on the
+	 * low latency of hard interrupt wakeups. If the current task is in
+	 * a real-time scheduling class, mark the mode for hard interrupt
+	 * expiry.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
+			mode |= HRTIMER_MODE_HARD;
+	}
+
+	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
-	sl->task = task;
+	sl->task = current;
+}
+
+/**
+ * hrtimer_init_sleeper - initialize sleeper to the given clock
+ * @sl:		sleeper to be initialized
+ * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
+ */
+void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
+			  enum hrtimer_mode mode)
+{
+	debug_init(&sl->timer, clock_id, mode);
+	__hrtimer_init_sleeper(sl, clock_id, mode);
+
 }
 EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 
@@ -1669,11 +1863,9 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 {
 	struct restart_block *restart;
 
-	hrtimer_init_sleeper(t, current);
-
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
-		hrtimer_start_expires(&t->timer, mode);
+		hrtimer_sleeper_start_expires(t, mode);
 
 		if (likely(t->task))
 			freezable_schedule();
@@ -1707,10 +1899,9 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
 
-	hrtimer_init_on_stack(&t.timer, restart->nanosleep.clockid,
-				HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
+				      HRTIMER_MODE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
@@ -1728,7 +1919,7 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
 
-	hrtimer_init_on_stack(&t.timer, clockid, mode);
+	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, timespec64_to_ktime(*rqtp), slack);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
@@ -1809,6 +2000,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 
@@ -1927,12 +2119,9 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	hrtimer_init_on_stack(&t.timer, clock_id, mode);
+	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
-
-	hrtimer_init_sleeper(&t, current);
-
-	hrtimer_start_expires(&t.timer, mode);
+	hrtimer_sleeper_start_expires(&t, mode);
 
 	if (likely(t.task))
 		schedule();
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 02068b2d5862..77f1e5635cc1 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -55,15 +55,10 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 	val = it->expires;
 	interval = it->incr;
 	if (val) {
-		struct task_cputime cputime;
-		u64 t;
+		u64 t, samples[CPUCLOCK_MAX];
 
-		thread_group_cputimer(tsk, &cputime);
-		if (clock_id == CPUCLOCK_PROF)
-			t = cputime.utime + cputime.stime;
-		else
-			/* CPUCLOCK_VIRT */
-			t = cputime.utime;
+		thread_group_sample_cputime(tsk, samples);
+		t = samples[clock_id];
 
 		if (val < t)
 			/* about to fire */
@@ -213,6 +208,7 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
+			hrtimer_cancel_wait_running(timer);
 			goto again;
 		}
 		expires = timeval_to_ktime(value->it_value);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a426f4e3125..92a431981b1c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -20,11 +20,20 @@
 
 static void posix_cpu_timer_rearm(struct k_itimer *timer);
 
+void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
+{
+	posix_cputimers_init(pct);
+	if (cpu_limit != RLIM_INFINITY) {
+		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
+		pct->timers_active = true;
+	}
+}
+
 /*
  * Called after updating RLIMIT_CPU to run cpu timer and update
- * tsk->signal->cputime_expires expiration cache if necessary. Needs
- * siglock protection since other code may update expiration cache as
- * well.
+ * tsk->signal->posix_cputimers.bases[clock].nextevt expiration cache if
+ * necessary. Needs siglock protection since other code may update the
+ * expiration cache as well.
  */
 void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 {
@@ -35,46 +44,97 @@ void update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new)
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
-static int check_clock(const clockid_t which_clock)
+/*
+ * Functions for validating access to tasks.
+ */
+static struct task_struct *lookup_task(const pid_t pid, bool thread,
+				       bool gettime)
 {
-	int error = 0;
 	struct task_struct *p;
-	const pid_t pid = CPUCLOCK_PID(which_clock);
-
-	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
-		return -EINVAL;
 
-	if (pid == 0)
-		return 0;
+	/*
+	 * If the encoded PID is 0, then the timer is targeted at current
+	 * or the process to which current belongs.
+	 */
+	if (!pid)
+		return thread ? current : current->group_leader;
 
-	rcu_read_lock();
 	p = find_task_by_vpid(pid);
-	if (!p || !(CPUCLOCK_PERTHREAD(which_clock) ?
-		   same_thread_group(p, current) : has_group_leader_pid(p))) {
-		error = -EINVAL;
+	if (!p)
+		return p;
+
+	if (thread)
+		return same_thread_group(p, current) ? p : NULL;
+
+	if (gettime) {
+		/*
+		 * For clock_gettime(PROCESS) the task does not need to be
+		 * the actual group leader. tsk->sighand gives
+		 * access to the group's clock.
+		 *
+		 * Timers need the group leader because they take a
+		 * reference on it and store the task pointer until the
+		 * timer is destroyed.
+		 */
+		return (p == current || thread_group_leader(p)) ? p : NULL;
 	}
+
+	/*
+	 * For processes require that p is group leader.
+	 */
+	return has_group_leader_pid(p) ? p : NULL;
+}
+
+static struct task_struct *__get_task_for_clock(const clockid_t clock,
+						bool getref, bool gettime)
+{
+	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
+	const pid_t pid = CPUCLOCK_PID(clock);
+	struct task_struct *p;
+
+	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
+		return NULL;
+
+	rcu_read_lock();
+	p = lookup_task(pid, thread, gettime);
+	if (p && getref)
+		get_task_struct(p);
 	rcu_read_unlock();
+	return p;
+}
 
-	return error;
+static inline struct task_struct *get_task_for_clock(const clockid_t clock)
+{
+	return __get_task_for_clock(clock, true, false);
+}
+
+static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
+{
+	return __get_task_for_clock(clock, true, true);
+}
+
+static inline int validate_clock_permissions(const clockid_t clock)
+{
+	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
 }
 
 /*
  * Update expiry time from increment, and increase overrun count,
  * given the current clock sample.
  */
-static void bump_cpu_timer(struct k_itimer *timer, u64 now)
+static u64 bump_cpu_timer(struct k_itimer *timer, u64 now)
 {
+	u64 delta, incr, expires = timer->it.cpu.node.expires;
 	int i;
-	u64 delta, incr;
 
 	if (!timer->it_interval)
-		return;
+		return expires;
 
-	if (now < timer->it.cpu.expires)
-		return;
+	if (now < expires)
+		return expires;
 
 	incr = timer->it_interval;
-	delta = now + incr - timer->it.cpu.expires;
+	delta = now + incr - expires;
 
 	/* Don't use (incr*2 < delta), incr*2 might overflow. */
 	for (i = 0; incr < delta - incr; i++)
@@ -84,48 +144,26 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
 		if (delta < incr)
 			continue;
 
-		timer->it.cpu.expires += incr;
+		timer->it.cpu.node.expires += incr;
 		timer->it_overrun += 1LL << i;
 		delta -= incr;
 	}
+	return timer->it.cpu.node.expires;
 }
 
-/**
- * task_cputime_zero - Check a task_cputime struct for all zero fields.
- *
- * @cputime:	The struct to compare.
- *
- * Checks @cputime to see if all fields are zero.  Returns true if all fields
- * are zero, false if any field is nonzero.
- */
-static inline int task_cputime_zero(const struct task_cputime *cputime)
+/* Check whether all cache entries contain U64_MAX, i.e. eternal expiry time */
+static inline bool expiry_cache_is_inactive(const struct posix_cputimers *pct)
 {
-	if (!cputime->utime && !cputime->stime && !cputime->sum_exec_runtime)
-		return 1;
-	return 0;
-}
-
-static inline u64 prof_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime + stime;
-}
-static inline u64 virt_ticks(struct task_struct *p)
-{
-	u64 utime, stime;
-
-	task_cputime(p, &utime, &stime);
-
-	return utime;
+	return !(~pct->bases[CPUCLOCK_PROF].nextevt |
+		 ~pct->bases[CPUCLOCK_VIRT].nextevt |
+		 ~pct->bases[CPUCLOCK_SCHED].nextevt);
 }
 
 static int
 posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 {
-	int error = check_clock(which_clock);
+	int error = validate_clock_permissions(which_clock);
+
 	if (!error) {
 		tp->tv_sec = 0;
 		tp->tv_nsec = ((NSEC_PER_SEC + HZ - 1) / HZ);
@@ -142,42 +180,66 @@ posix_cpu_clock_getres(const clockid_t which_clock, struct timespec64 *tp)
 }
 
 static int
-posix_cpu_clock_set(const clockid_t which_clock, const struct timespec64 *tp)
+posix_cpu_clock_set(const clockid_t clock, const struct timespec64 *tp)
 {
+	int error = validate_clock_permissions(clock);
+
 	/*
 	 * You can never reset a CPU clock, but we check for other errors
 	 * in the call before failing with EPERM.
 	 */
-	int error = check_clock(which_clock);
-	if (error == 0) {
-		error = -EPERM;
-	}
-	return error;
+	return error ? : -EPERM;
 }
 
-
 /*
- * Sample a per-thread clock for the given task.
+ * Sample a per-thread clock for the given task. clkid is validated.
  */
-static int cpu_clock_sample(const clockid_t which_clock,
-			    struct task_struct *p, u64 *sample)
+static u64 cpu_clock_sample(const clockid_t clkid, struct task_struct *p)
 {
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
+	u64 utime, stime;
+
+	if (clkid == CPUCLOCK_SCHED)
+		return task_sched_runtime(p);
+
+	task_cputime(p, &utime, &stime);
+
+	switch (clkid) {
 	case CPUCLOCK_PROF:
-		*sample = prof_ticks(p);
-		break;
+		return utime + stime;
 	case CPUCLOCK_VIRT:
-		*sample = virt_ticks(p);
-		break;
-	case CPUCLOCK_SCHED:
-		*sample = task_sched_runtime(p);
-		break;
+		return utime;
+	default:
+		WARN_ON_ONCE(1);
 	}
 	return 0;
 }
 
+static inline void store_samples(u64 *samples, u64 stime, u64 utime, u64 rtime)
+{
+	samples[CPUCLOCK_PROF] = stime + utime;
+	samples[CPUCLOCK_VIRT] = utime;
+	samples[CPUCLOCK_SCHED] = rtime;
+}
+
+static void task_sample_cputime(struct task_struct *p, u64 *samples)
+{
+	u64 stime, utime;
+
+	task_cputime(p, &utime, &stime);
+	store_samples(samples, stime, utime, p->se.sum_exec_runtime);
+}
+
+static void proc_sample_cputime_atomic(struct task_cputime_atomic *at,
+				       u64 *samples)
+{
+	u64 stime, utime, rtime;
+
+	utime = atomic64_read(&at->utime);
+	stime = atomic64_read(&at->stime);
+	rtime = atomic64_read(&at->sum_exec_runtime);
+	store_samples(samples, stime, utime, rtime);
+}
+
 /*
  * Set cputime to sum_cputime if sum_cputime > cputime. Use cmpxchg
  * to avoid race conditions with concurrent updates to cputime.
@@ -193,29 +255,56 @@ static inline void __update_gt_cputime(atomic64_t *cputime, u64 sum_cputime)
 	}
 }
 
-static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic, struct task_cputime *sum)
+static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
+			      struct task_cputime *sum)
 {
 	__update_gt_cputime(&cputime_atomic->utime, sum->utime);
 	__update_gt_cputime(&cputime_atomic->stime, sum->stime);
 	__update_gt_cputime(&cputime_atomic->sum_exec_runtime, sum->sum_exec_runtime);
 }
 
-/* Sample task_cputime_atomic values in "atomic_timers", store results in "times". */
-static inline void sample_cputime_atomic(struct task_cputime *times,
-					 struct task_cputime_atomic *atomic_times)
+/**
+ * thread_group_sample_cputime - Sample cputime for a given task
+ * @tsk:	Task for which cputime needs to be started
+ * @iimes:	Storage for time samples
+ *
+ * Called from sys_getitimer() to calculate the expiry time of an active
+ * timer. That means group cputime accounting is already active. Called
+ * with task sighand lock held.
+ *
+ * Updates @times with an uptodate sample of the thread group cputimes.
+ */
+void thread_group_sample_cputime(struct task_struct *tsk, u64 *samples)
 {
-	times->utime = atomic64_read(&atomic_times->utime);
-	times->stime = atomic64_read(&atomic_times->stime);
-	times->sum_exec_runtime = atomic64_read(&atomic_times->sum_exec_runtime);
+	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
+	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
+
+	WARN_ON_ONCE(!pct->timers_active);
+
+	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
 
-void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times)
+/**
+ * thread_group_start_cputime - Start cputime and return a sample
+ * @tsk:	Task for which cputime needs to be started
+ * @samples:	Storage for time samples
+ *
+ * The thread group cputime accouting is avoided when there are no posix
+ * CPU timers armed. Before starting a timer it's required to check whether
+ * the time accounting is active. If not, a full update of the atomic
+ * accounting store needs to be done and the accounting enabled.
+ *
+ * Updates @times with an uptodate sample of the thread group cputimes.
+ */
+static void thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
 {
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
-	struct task_cputime sum;
+	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
 	/* Check if cputimer isn't running. This is accessed without locking. */
-	if (!READ_ONCE(cputimer->running)) {
+	if (!READ_ONCE(pct->timers_active)) {
+		struct task_cputime sum;
+
 		/*
 		 * The POSIX timer interface allows for absolute time expiry
 		 * values through the TIMER_ABSTIME flag, therefore we have
@@ -225,94 +314,69 @@ void thread_group_cputimer(struct task_struct *tsk, struct task_cputime *times)
 		update_gt_cputime(&cputimer->cputime_atomic, &sum);
 
 		/*
-		 * We're setting cputimer->running without a lock. Ensure
-		 * this only gets written to in one operation. We set
-		 * running after update_gt_cputime() as a small optimization,
-		 * but barriers are not required because update_gt_cputime()
+		 * We're setting timers_active without a lock. Ensure this
+		 * only gets written to in one operation. We set it after
+		 * update_gt_cputime() as a small optimization, but
+		 * barriers are not required because update_gt_cputime()
 		 * can handle concurrent updates.
 		 */
-		WRITE_ONCE(cputimer->running, true);
+		WRITE_ONCE(pct->timers_active, true);
 	}
-	sample_cputime_atomic(times, &cputimer->cputime_atomic);
+	proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 }
 
-/*
- * Sample a process (thread group) clock for the given group_leader task.
- * Must be called with task sighand lock held for safe while_each_thread()
- * traversal.
- */
-static int cpu_clock_sample_group(const clockid_t which_clock,
-				  struct task_struct *p,
-				  u64 *sample)
+static void __thread_group_cputime(struct task_struct *tsk, u64 *samples)
 {
-	struct task_cputime cputime;
+	struct task_cputime ct;
 
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
-	case CPUCLOCK_PROF:
-		thread_group_cputime(p, &cputime);
-		*sample = cputime.utime + cputime.stime;
-		break;
-	case CPUCLOCK_VIRT:
-		thread_group_cputime(p, &cputime);
-		*sample = cputime.utime;
-		break;
-	case CPUCLOCK_SCHED:
-		thread_group_cputime(p, &cputime);
-		*sample = cputime.sum_exec_runtime;
-		break;
-	}
-	return 0;
+	thread_group_cputime(tsk, &ct);
+	store_samples(samples, ct.stime, ct.utime, ct.sum_exec_runtime);
 }
 
-static int posix_cpu_clock_get_task(struct task_struct *tsk,
-				    const clockid_t which_clock,
-				    struct timespec64 *tp)
+/*
+ * Sample a process (thread group) clock for the given task clkid. If the
+ * group's cputime accounting is already enabled, read the atomic
+ * store. Otherwise a full update is required.  Task's sighand lock must be
+ * held to protect the task traversal on a full update. clkid is already
+ * validated.
+ */
+static u64 cpu_clock_sample_group(const clockid_t clkid, struct task_struct *p,
+				  bool start)
 {
-	int err = -EINVAL;
-	u64 rtn;
+	struct thread_group_cputimer *cputimer = &p->signal->cputimer;
+	struct posix_cputimers *pct = &p->signal->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 
-	if (CPUCLOCK_PERTHREAD(which_clock)) {
-		if (same_thread_group(tsk, current))
-			err = cpu_clock_sample(which_clock, tsk, &rtn);
+	if (!READ_ONCE(pct->timers_active)) {
+		if (start)
+			thread_group_start_cputime(p, samples);
+		else
+			__thread_group_cputime(p, samples);
 	} else {
-		if (tsk == current || thread_group_leader(tsk))
-			err = cpu_clock_sample_group(which_clock, tsk, &rtn);
+		proc_sample_cputime_atomic(&cputimer->cputime_atomic, samples);
 	}
 
-	if (!err)
-		*tp = ns_to_timespec64(rtn);
-
-	return err;
+	return samples[clkid];
 }
 
-
-static int posix_cpu_clock_get(const clockid_t which_clock, struct timespec64 *tp)
+static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 {
-	const pid_t pid = CPUCLOCK_PID(which_clock);
-	int err = -EINVAL;
+	const clockid_t clkid = CPUCLOCK_WHICH(clock);
+	struct task_struct *tsk;
+	u64 t;
 
-	if (pid == 0) {
-		/*
-		 * Special case constant value for our own clocks.
-		 * We don't have to do any lookup to find ourselves.
-		 */
-		err = posix_cpu_clock_get_task(current, which_clock, tp);
-	} else {
-		/*
-		 * Find the given PID, and validate that the caller
-		 * should be able to see it.
-		 */
-		struct task_struct *p;
-		rcu_read_lock();
-		p = find_task_by_vpid(pid);
-		if (p)
-			err = posix_cpu_clock_get_task(p, which_clock, tp);
-		rcu_read_unlock();
-	}
+	tsk = get_task_for_clock_get(clock);
+	if (!tsk)
+		return -EINVAL;
 
-	return err;
+	if (CPUCLOCK_PERTHREAD(clock))
+		t = cpu_clock_sample(clkid, tsk);
+	else
+		t = cpu_clock_sample_group(clkid, tsk, false);
+	put_task_struct(tsk);
+
+	*tp = ns_to_timespec64(t);
+	return 0;
 }
 
 /*
@@ -322,44 +386,15 @@ static int posix_cpu_clock_get(const clockid_t which_clock, struct timespec64 *t
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
-	int ret = 0;
-	const pid_t pid = CPUCLOCK_PID(new_timer->it_clock);
-	struct task_struct *p;
+	struct task_struct *p = get_task_for_clock(new_timer->it_clock);
 
-	if (CPUCLOCK_WHICH(new_timer->it_clock) >= CPUCLOCK_MAX)
+	if (!p)
 		return -EINVAL;
 
 	new_timer->kclock = &clock_posix_cpu;
-
-	INIT_LIST_HEAD(&new_timer->it.cpu.entry);
-
-	rcu_read_lock();
-	if (CPUCLOCK_PERTHREAD(new_timer->it_clock)) {
-		if (pid == 0) {
-			p = current;
-		} else {
-			p = find_task_by_vpid(pid);
-			if (p && !same_thread_group(p, current))
-				p = NULL;
-		}
-	} else {
-		if (pid == 0) {
-			p = current->group_leader;
-		} else {
-			p = find_task_by_vpid(pid);
-			if (p && !has_group_leader_pid(p))
-				p = NULL;
-		}
-	}
+	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.task = p;
-	if (p) {
-		get_task_struct(p);
-	} else {
-		ret = -EINVAL;
-	}
-	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 /*
@@ -370,12 +405,14 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
  */
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
-	int ret = 0;
-	unsigned long flags;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
-	struct task_struct *p = timer->it.cpu.task;
+	unsigned long flags;
+	int ret = 0;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return -EINVAL;
 
 	/*
 	 * Protect against sighand release/switch in exit/exec and process/
@@ -384,15 +421,15 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	sighand = lock_task_sighand(p, &flags);
 	if (unlikely(sighand == NULL)) {
 		/*
-		 * We raced with the reaping of the task.
-		 * The deletion should have cleared us off the list.
+		 * This raced with the reaping of the task. The exit cleanup
+		 * should have removed this timer from the timer queue.
 		 */
-		WARN_ON_ONCE(!list_empty(&timer->it.cpu.entry));
+		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
 		else
-			list_del(&timer->it.cpu.entry);
+			cpu_timer_dequeue(ctmr);
 
 		unlock_task_sighand(p, &flags);
 	}
@@ -403,25 +440,30 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 	return ret;
 }
 
-static void cleanup_timers_list(struct list_head *head)
+static void cleanup_timerqueue(struct timerqueue_head *head)
 {
-	struct cpu_timer_list *timer, *next;
+	struct timerqueue_node *node;
+	struct cpu_timer *ctmr;
 
-	list_for_each_entry_safe(timer, next, head, entry)
-		list_del_init(&timer->entry);
+	while ((node = timerqueue_getnext(head))) {
+		timerqueue_del(head, node);
+		ctmr = container_of(node, struct cpu_timer, node);
+		ctmr->head = NULL;
+	}
 }
 
 /*
- * Clean out CPU timers still ticking when a thread exited.  The task
- * pointer is cleared, and the expiry time is replaced with the residual
- * time for later timer_gettime calls to return.
+ * Clean out CPU timers which are still armed when a thread exits. The
+ * timers are only removed from the list. No other updates are done. The
+ * corresponding posix timers are still accessible, but cannot be rearmed.
+ *
  * This must be called with the siglock held.
  */
-static void cleanup_timers(struct list_head *head)
+static void cleanup_timers(struct posix_cputimers *pct)
 {
-	cleanup_timers_list(head);
-	cleanup_timers_list(++head);
-	cleanup_timers_list(++head);
+	cleanup_timerqueue(&pct->bases[CPUCLOCK_PROF].tqhead);
+	cleanup_timerqueue(&pct->bases[CPUCLOCK_VIRT].tqhead);
+	cleanup_timerqueue(&pct->bases[CPUCLOCK_SCHED].tqhead);
 }
 
 /*
@@ -431,16 +473,11 @@ static void cleanup_timers(struct list_head *head)
  */
 void posix_cpu_timers_exit(struct task_struct *tsk)
 {
-	cleanup_timers(tsk->cpu_timers);
+	cleanup_timers(&tsk->posix_cputimers);
 }
 void posix_cpu_timers_exit_group(struct task_struct *tsk)
 {
-	cleanup_timers(tsk->signal->cpu_timers);
-}
-
-static inline int expires_gt(u64 expires, u64 new_exp)
-{
-	return expires == 0 || expires > new_exp;
+	cleanup_timers(&tsk->signal->posix_cputimers);
 }
 
 /*
@@ -449,58 +486,33 @@ static inline int expires_gt(u64 expires, u64 new_exp)
  */
 static void arm_timer(struct k_itimer *timer)
 {
-	struct task_struct *p = timer->it.cpu.task;
-	struct list_head *head, *listpos;
-	struct task_cputime *cputime_expires;
-	struct cpu_timer_list *const nt = &timer->it.cpu;
-	struct cpu_timer_list *next;
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		head = p->cpu_timers;
-		cputime_expires = &p->cputime_expires;
-	} else {
-		head = p->signal->cpu_timers;
-		cputime_expires = &p->signal->cputime_expires;
-	}
-	head += CPUCLOCK_WHICH(timer->it_clock);
-
-	listpos = head;
-	list_for_each_entry(next, head, entry) {
-		if (nt->expires < next->expires)
-			break;
-		listpos = &next->entry;
-	}
-	list_add(&nt->entry, listpos);
-
-	if (listpos == head) {
-		u64 exp = nt->expires;
+	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 newexp = cpu_timer_getexpires(ctmr);
+	struct task_struct *p = ctmr->task;
+	struct posix_cputimer_base *base;
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		base = p->posix_cputimers.bases + clkidx;
+	else
+		base = p->signal->posix_cputimers.bases + clkidx;
+
+	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
+		return;
 
-		/*
-		 * We are the new earliest-expiring POSIX 1.b timer, hence
-		 * need to update expiration cache. Take into account that
-		 * for process timers we share expiration cache with itimers
-		 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
-		 */
+	/*
+	 * We are the new earliest-expiring POSIX 1.b timer, hence
+	 * need to update expiration cache. Take into account that
+	 * for process timers we share expiration cache with itimers
+	 * and RLIMIT_CPU and for thread timers with RLIMIT_RTTIME.
+	 */
+	if (newexp < base->nextevt)
+		base->nextevt = newexp;
 
-		switch (CPUCLOCK_WHICH(timer->it_clock)) {
-		case CPUCLOCK_PROF:
-			if (expires_gt(cputime_expires->prof_exp, exp))
-				cputime_expires->prof_exp = exp;
-			break;
-		case CPUCLOCK_VIRT:
-			if (expires_gt(cputime_expires->virt_exp, exp))
-				cputime_expires->virt_exp = exp;
-			break;
-		case CPUCLOCK_SCHED:
-			if (expires_gt(cputime_expires->sched_exp, exp))
-				cputime_expires->sched_exp = exp;
-			break;
-		}
-		if (CPUCLOCK_PERTHREAD(timer->it_clock))
-			tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
-		else
-			tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
-	}
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
+	else
+		tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 /*
@@ -508,24 +520,26 @@ static void arm_timer(struct k_itimer *timer)
  */
 static void cpu_timer_fire(struct k_itimer *timer)
 {
+	struct cpu_timer *ctmr = &timer->it.cpu;
+
 	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 		/*
 		 * User don't want any signal.
 		 */
-		timer->it.cpu.expires = 0;
+		cpu_timer_setexpires(ctmr, 0);
 	} else if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
 		 */
 		wake_up_process(timer->it_process);
-		timer->it.cpu.expires = 0;
+		cpu_timer_setexpires(ctmr, 0);
 	} else if (!timer->it_interval) {
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
 		posix_timer_event(timer, 0);
-		timer->it.cpu.expires = 0;
+		cpu_timer_setexpires(ctmr, 0);
 	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
 		/*
 		 * The signal did not get queued because the signal
@@ -538,33 +552,6 @@ static void cpu_timer_fire(struct k_itimer *timer)
 	}
 }
 
-/*
- * Sample a process (thread group) timer for the given group_leader task.
- * Must be called with task sighand lock held for safe while_each_thread()
- * traversal.
- */
-static int cpu_timer_sample_group(const clockid_t which_clock,
-				  struct task_struct *p, u64 *sample)
-{
-	struct task_cputime cputime;
-
-	thread_group_cputimer(p, &cputime);
-	switch (CPUCLOCK_WHICH(which_clock)) {
-	default:
-		return -EINVAL;
-	case CPUCLOCK_PROF:
-		*sample = cputime.utime + cputime.stime;
-		break;
-	case CPUCLOCK_VIRT:
-		*sample = cputime.utime;
-		break;
-	case CPUCLOCK_SCHED:
-		*sample = cputime.sum_exec_runtime;
-		break;
-	}
-	return 0;
-}
-
 /*
  * Guts of sys_timer_settime for CPU timers.
  * This is called with the timer locked and interrupts disabled.
@@ -574,13 +561,16 @@ static int cpu_timer_sample_group(const clockid_t which_clock,
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
-	unsigned long flags;
-	struct sighand_struct *sighand;
-	struct task_struct *p = timer->it.cpu.task;
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
-	int ret;
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p = ctmr->task;
+	struct sighand_struct *sighand;
+	unsigned long flags;
+	int ret = 0;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return -EINVAL;
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -597,22 +587,21 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * If p has just been reaped, we can no
 	 * longer get any information about it at all.
 	 */
-	if (unlikely(sighand == NULL)) {
+	if (unlikely(sighand == NULL))
 		return -ESRCH;
-	}
 
 	/*
 	 * Disarm any old timer after extracting its expiry time.
 	 */
-
-	ret = 0;
 	old_incr = timer->it_interval;
-	old_expires = timer->it.cpu.expires;
+	old_expires = cpu_timer_getexpires(ctmr);
+
 	if (unlikely(timer->it.cpu.firing)) {
 		timer->it.cpu.firing = -1;
 		ret = TIMER_RETRY;
-	} else
-		list_del_init(&timer->it.cpu.entry);
+	} else {
+		cpu_timer_dequeue(ctmr);
+	}
 
 	/*
 	 * We need to sample the current value to convert the new
@@ -622,11 +611,10 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * times (in arm_timer).  With an absolute time, we must
 	 * check if it's already passed.  In short, we need a sample.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(timer->it_clock, p, &val);
-	} else {
-		cpu_timer_sample_group(timer->it_clock, p, &val);
-	}
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		val = cpu_clock_sample(clkid, p);
+	else
+		val = cpu_clock_sample_group(clkid, p, true);
 
 	if (old) {
 		if (old_expires == 0) {
@@ -634,18 +622,16 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			old->it_value.tv_nsec = 0;
 		} else {
 			/*
-			 * Update the timer in case it has
-			 * overrun already.  If it has,
-			 * we'll report it as having overrun
-			 * and with the next reloaded timer
-			 * already ticking, though we are
-			 * swallowing that pending
-			 * notification here to install the
-			 * new setting.
+			 * Update the timer in case it has overrun already.
+			 * If it has, we'll report it as having overrun and
+			 * with the next reloaded timer already ticking,
+			 * though we are swallowing that pending
+			 * notification here to install the new setting.
 			 */
-			bump_cpu_timer(timer, val);
-			if (val < timer->it.cpu.expires) {
-				old_expires = timer->it.cpu.expires - val;
+			u64 exp = bump_cpu_timer(timer, val);
+
+			if (val < exp) {
+				old_expires = exp - val;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
 				old->it_value.tv_nsec = 1;
@@ -674,7 +660,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * For a timer with no notification action, we don't actually
 	 * arm the timer (we'll just fake it for timer_gettime).
 	 */
-	timer->it.cpu.expires = new_expires;
+	cpu_timer_setexpires(ctmr, new_expires);
 	if (new_expires != 0 && val < new_expires) {
 		arm_timer(timer);
 	}
@@ -715,24 +701,27 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
 {
-	u64 now;
-	struct task_struct *p = timer->it.cpu.task;
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 now, expires = cpu_timer_getexpires(ctmr);
+	struct task_struct *p = ctmr->task;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return;
 
 	/*
 	 * Easy part: convert the reload time.
 	 */
 	itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
-	if (!timer->it.cpu.expires)
+	if (!expires)
 		return;
 
 	/*
 	 * Sample the clock to take the difference with the expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(timer->it_clock, p, &now);
+		now = cpu_clock_sample(clkid, p);
 	} else {
 		struct sighand_struct *sighand;
 		unsigned long flags;
@@ -747,18 +736,18 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 			/*
 			 * The process has been reaped.
 			 * We can't even collect a sample any more.
-			 * Call the timer disarmed, nothing else to do.
+			 * Disarm the timer, nothing else to do.
 			 */
-			timer->it.cpu.expires = 0;
+			cpu_timer_setexpires(ctmr, 0);
 			return;
 		} else {
-			cpu_timer_sample_group(timer->it_clock, p, &now);
+			now = cpu_clock_sample_group(clkid, p, false);
 			unlock_task_sighand(p, &flags);
 		}
 	}
 
-	if (now < timer->it.cpu.expires) {
-		itp->it_value = ns_to_timespec64(timer->it.cpu.expires - now);
+	if (now < expires) {
+		itp->it_value = ns_to_timespec64(expires - now);
 	} else {
 		/*
 		 * The timer should have expired already, but the firing
@@ -769,26 +758,42 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	}
 }
 
-static unsigned long long
-check_timers_list(struct list_head *timers,
-		  struct list_head *firing,
-		  unsigned long long curr)
-{
-	int maxfire = 20;
+#define MAX_COLLECTED	20
 
-	while (!list_empty(timers)) {
-		struct cpu_timer_list *t;
+static u64 collect_timerqueue(struct timerqueue_head *head,
+			      struct list_head *firing, u64 now)
+{
+	struct timerqueue_node *next;
+	int i = 0;
+
+	while ((next = timerqueue_getnext(head))) {
+		struct cpu_timer *ctmr;
+		u64 expires;
+
+		ctmr = container_of(next, struct cpu_timer, node);
+		expires = cpu_timer_getexpires(ctmr);
+		/* Limit the number of timers to expire at once */
+		if (++i == MAX_COLLECTED || now < expires)
+			return expires;
+
+		ctmr->firing = 1;
+		cpu_timer_dequeue(ctmr);
+		list_add_tail(&ctmr->elist, firing);
+	}
 
-		t = list_first_entry(timers, struct cpu_timer_list, entry);
+	return U64_MAX;
+}
 
-		if (!--maxfire || curr < t->expires)
-			return t->expires;
+static void collect_posix_cputimers(struct posix_cputimers *pct, u64 *samples,
+				    struct list_head *firing)
+{
+	struct posix_cputimer_base *base = pct->bases;
+	int i;
 
-		t->firing = 1;
-		list_move_tail(&t->entry, firing);
+	for (i = 0; i < CPUCLOCK_MAX; i++, base++) {
+		base->nextevt = collect_timerqueue(&base->tqhead, firing,
+						    samples[i]);
 	}
-
-	return 0;
 }
 
 static inline void check_dl_overrun(struct task_struct *tsk)
@@ -799,6 +804,20 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 	}
 }
 
+static bool check_rlimit(u64 time, u64 limit, int signo, bool rt, bool hard)
+{
+	if (time < limit)
+		return false;
+
+	if (print_fatal_signals) {
+		pr_info("%s Watchdog Timeout (%s): %s[%d]\n",
+			rt ? "RT" : "CPU", hard ? "hard" : "soft",
+			current->comm, task_pid_nr(current));
+	}
+	__group_send_sig_info(signo, SEND_SIG_PRIV, current);
+	return true;
+}
+
 /*
  * Check for any per-thread CPU timers that have fired and move them off
  * the tsk->cpu_timers[N] list onto the firing list.  Here we update the
@@ -807,76 +826,50 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
 {
-	struct list_head *timers = tsk->cpu_timers;
-	struct task_cputime *tsk_expires = &tsk->cputime_expires;
-	u64 expires;
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	if (dl_task(tsk))
 		check_dl_overrun(tsk);
 
-	/*
-	 * If cputime_expires is zero, then there are no active
-	 * per thread CPU timers.
-	 */
-	if (task_cputime_zero(&tsk->cputime_expires))
+	if (expiry_cache_is_inactive(pct))
 		return;
 
-	expires = check_timers_list(timers, firing, prof_ticks(tsk));
-	tsk_expires->prof_exp = expires;
-
-	expires = check_timers_list(++timers, firing, virt_ticks(tsk));
-	tsk_expires->virt_exp = expires;
-
-	tsk_expires->sched_exp = check_timers_list(++timers, firing,
-						   tsk->se.sum_exec_runtime);
+	task_sample_cputime(tsk, samples);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case thread timers.
 	 */
 	soft = task_rlimit(tsk, RLIMIT_RTTIME);
 	if (soft != RLIM_INFINITY) {
+		/* Task RT timeout is accounted in jiffies. RTTIME is usec */
+		unsigned long rttime = tsk->rt.timeout * (USEC_PER_SEC / HZ);
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_RTTIME);
 
+		/* At the hard limit, send SIGKILL. No further action. */
 		if (hard != RLIM_INFINITY &&
-		    tsk->rt.timeout > DIV_ROUND_UP(hard, USEC_PER_SEC/HZ)) {
-			/*
-			 * At the hard limit, we just die.
-			 * No need to calculate anything else now.
-			 */
-			if (print_fatal_signals) {
-				pr_info("CPU Watchdog Timeout (hard): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
+		    check_rlimit(rttime, hard, SIGKILL, true, true))
 			return;
-		}
-		if (tsk->rt.timeout > DIV_ROUND_UP(soft, USEC_PER_SEC/HZ)) {
-			/*
-			 * At the soft limit, send a SIGXCPU every second.
-			 */
-			if (soft < hard) {
-				soft += USEC_PER_SEC;
-				tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur =
-					soft;
-			}
-			if (print_fatal_signals) {
-				pr_info("RT Watchdog Timeout (soft): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+
+		/* At the soft limit, send a SIGXCPU every second */
+		if (check_rlimit(rttime, soft, SIGXCPU, true, false)) {
+			soft += USEC_PER_SEC;
+			tsk->signal->rlim[RLIMIT_RTTIME].rlim_cur = soft;
 		}
 	}
-	if (task_cputime_zero(tsk_expires))
+
+	if (expiry_cache_is_inactive(pct))
 		tick_dep_clear_task(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 static inline void stop_process_timers(struct signal_struct *sig)
 {
-	struct thread_group_cputimer *cputimer = &sig->cputimer;
+	struct posix_cputimers *pct = &sig->posix_cputimers;
 
-	/* Turn off cputimer->running. This is done without locking. */
-	WRITE_ONCE(cputimer->running, false);
+	/* Turn off the active flag. This is done without locking. */
+	WRITE_ONCE(pct->timers_active, false);
 	tick_dep_clear_signal(sig, TICK_DEP_BIT_POSIX_TIMER);
 }
 
@@ -898,7 +891,7 @@ static void check_cpu_itimer(struct task_struct *tsk, struct cpu_itimer *it,
 		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
 	}
 
-	if (it->expires && (!*expires || it->expires < *expires))
+	if (it->expires && it->expires < *expires)
 		*expires = it->expires;
 }
 
@@ -911,87 +904,69 @@ static void check_process_timers(struct task_struct *tsk,
 				 struct list_head *firing)
 {
 	struct signal_struct *const sig = tsk->signal;
-	u64 utime, ptime, virt_expires, prof_expires;
-	u64 sum_sched_runtime, sched_expires;
-	struct list_head *timers = sig->cpu_timers;
-	struct task_cputime cputime;
+	struct posix_cputimers *pct = &sig->posix_cputimers;
+	u64 samples[CPUCLOCK_MAX];
 	unsigned long soft;
 
 	/*
-	 * If cputimer is not running, then there are no active
-	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
+	 * If there are no active process wide timers (POSIX 1.b, itimers,
+	 * RLIMIT_CPU) nothing to check. Also skip the process wide timer
+	 * processing when there is already another task handling them.
 	 */
-	if (!READ_ONCE(tsk->signal->cputimer.running))
+	if (!READ_ONCE(pct->timers_active) || pct->expiry_active)
 		return;
 
-        /*
+	/*
 	 * Signify that a thread is checking for process timers.
 	 * Write access to this field is protected by the sighand lock.
 	 */
-	sig->cputimer.checking_timer = true;
+	pct->expiry_active = true;
 
 	/*
-	 * Collect the current process totals.
+	 * Collect the current process totals. Group accounting is active
+	 * so the sample can be taken directly.
 	 */
-	thread_group_cputimer(tsk, &cputime);
-	utime = cputime.utime;
-	ptime = utime + cputime.stime;
-	sum_sched_runtime = cputime.sum_exec_runtime;
-
-	prof_expires = check_timers_list(timers, firing, ptime);
-	virt_expires = check_timers_list(++timers, firing, utime);
-	sched_expires = check_timers_list(++timers, firing, sum_sched_runtime);
+	proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic, samples);
+	collect_posix_cputimers(pct, samples, firing);
 
 	/*
 	 * Check for the special case process timers.
 	 */
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF], &prof_expires, ptime,
-			 SIGPROF);
-	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT], &virt_expires, utime,
-			 SIGVTALRM);
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_PROF],
+			 &pct->bases[CPUCLOCK_PROF].nextevt,
+			 samples[CPUCLOCK_PROF], SIGPROF);
+	check_cpu_itimer(tsk, &sig->it[CPUCLOCK_VIRT],
+			 &pct->bases[CPUCLOCK_VIRT].nextevt,
+			 samples[CPUCLOCK_VIRT], SIGVTALRM);
+
 	soft = task_rlimit(tsk, RLIMIT_CPU);
 	if (soft != RLIM_INFINITY) {
-		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
+		/* RLIMIT_CPU is in seconds. Samples are nanoseconds */
 		unsigned long hard = task_rlimit_max(tsk, RLIMIT_CPU);
-		u64 x;
-		if (psecs >= hard) {
-			/*
-			 * At the hard limit, we just die.
-			 * No need to calculate anything else now.
-			 */
-			if (print_fatal_signals) {
-				pr_info("RT Watchdog Timeout (hard): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGKILL, SEND_SIG_PRIV, tsk);
+		u64 ptime = samples[CPUCLOCK_PROF];
+		u64 softns = (u64)soft * NSEC_PER_SEC;
+		u64 hardns = (u64)hard * NSEC_PER_SEC;
+
+		/* At the hard limit, send SIGKILL. No further action. */
+		if (hard != RLIM_INFINITY &&
+		    check_rlimit(ptime, hardns, SIGKILL, false, true))
 			return;
+
+		/* At the soft limit, send a SIGXCPU every second */
+		if (check_rlimit(ptime, softns, SIGXCPU, false, false)) {
+			sig->rlim[RLIMIT_CPU].rlim_cur = soft + 1;
+			softns += NSEC_PER_SEC;
 		}
-		if (psecs >= soft) {
-			/*
-			 * At the soft limit, send a SIGXCPU every second.
-			 */
-			if (print_fatal_signals) {
-				pr_info("CPU Watchdog Timeout (soft): %s[%d]\n",
-					tsk->comm, task_pid_nr(tsk));
-			}
-			__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
-			if (soft < hard) {
-				soft++;
-				sig->rlim[RLIMIT_CPU].rlim_cur = soft;
-			}
-		}
-		x = soft * NSEC_PER_SEC;
-		if (!prof_expires || x < prof_expires)
-			prof_expires = x;
+
+		/* Update the expiry cache */
+		if (softns < pct->bases[CPUCLOCK_PROF].nextevt)
+			pct->bases[CPUCLOCK_PROF].nextevt = softns;
 	}
 
-	sig->cputime_expires.prof_exp = prof_expires;
-	sig->cputime_expires.virt_exp = virt_expires;
-	sig->cputime_expires.sched_exp = sched_expires;
-	if (task_cputime_zero(&sig->cputime_expires))
+	if (expiry_cache_is_inactive(pct))
 		stop_process_timers(sig);
 
-	sig->cputimer.checking_timer = false;
+	pct->expiry_active = false;
 }
 
 /*
@@ -1000,18 +975,21 @@ static void check_process_timers(struct task_struct *tsk,
  */
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p = ctmr->task;
 	struct sighand_struct *sighand;
 	unsigned long flags;
-	struct task_struct *p = timer->it.cpu.task;
 	u64 now;
 
-	WARN_ON_ONCE(p == NULL);
+	if (WARN_ON_ONCE(!p))
+		return;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
-		cpu_clock_sample(timer->it_clock, p, &now);
+		now = cpu_clock_sample(clkid, p);
 		bump_cpu_timer(timer, now);
 		if (unlikely(p->exit_state))
 			return;
@@ -1031,13 +1009,13 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 			 * The process has been reaped.
 			 * We can't even collect a sample any more.
 			 */
-			timer->it.cpu.expires = 0;
+			cpu_timer_setexpires(ctmr, 0);
 			return;
 		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
 			/* If the process is dying, no need to rearm */
 			goto unlock;
 		}
-		cpu_timer_sample_group(timer->it_clock, p, &now);
+		now = cpu_clock_sample_group(clkid, p, true);
 		bump_cpu_timer(timer, now);
 		/* Leave the sighand locked for the call below.  */
 	}
@@ -1051,26 +1029,24 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 }
 
 /**
- * task_cputime_expired - Compare two task_cputime entities.
+ * task_cputimers_expired - Check whether posix CPU timers are expired
  *
- * @sample:	The task_cputime structure to be checked for expiration.
- * @expires:	Expiration times, against which @sample will be checked.
+ * @samples:	Array of current samples for the CPUCLOCK clocks
+ * @pct:	Pointer to a posix_cputimers container
  *
- * Checks @sample against @expires to see if any field of @sample has expired.
- * Returns true if any field of the former is greater than the corresponding
- * field of the latter if the latter field is set.  Otherwise returns false.
+ * Returns true if any member of @samples is greater than the corresponding
+ * member of @pct->bases[CLK].nextevt. False otherwise
  */
-static inline int task_cputime_expired(const struct task_cputime *sample,
-					const struct task_cputime *expires)
+static inline bool
+task_cputimers_expired(const u64 *sample, struct posix_cputimers *pct)
 {
-	if (expires->utime && sample->utime >= expires->utime)
-		return 1;
-	if (expires->stime && sample->utime + sample->stime >= expires->stime)
-		return 1;
-	if (expires->sum_exec_runtime != 0 &&
-	    sample->sum_exec_runtime >= expires->sum_exec_runtime)
-		return 1;
-	return 0;
+	int i;
+
+	for (i = 0; i < CPUCLOCK_MAX; i++) {
+		if (sample[i] >= pct->bases[i].nextevt)
+			return true;
+	}
+	return false;
 }
 
 /**
@@ -1083,48 +1059,50 @@ static inline int task_cputime_expired(const struct task_cputime *sample,
  * timers and compare them with the corresponding expiration times.  Return
  * true if a timer has expired, else return false.
  */
-static inline int fastpath_timer_check(struct task_struct *tsk)
+static inline bool fastpath_timer_check(struct task_struct *tsk)
 {
+	struct posix_cputimers *pct = &tsk->posix_cputimers;
 	struct signal_struct *sig;
 
-	if (!task_cputime_zero(&tsk->cputime_expires)) {
-		struct task_cputime task_sample;
+	if (!expiry_cache_is_inactive(pct)) {
+		u64 samples[CPUCLOCK_MAX];
 
-		task_cputime(tsk, &task_sample.utime, &task_sample.stime);
-		task_sample.sum_exec_runtime = tsk->se.sum_exec_runtime;
-		if (task_cputime_expired(&task_sample, &tsk->cputime_expires))
-			return 1;
+		task_sample_cputime(tsk, samples);
+		if (task_cputimers_expired(samples, pct))
+			return true;
 	}
 
 	sig = tsk->signal;
+	pct = &sig->posix_cputimers;
 	/*
-	 * Check if thread group timers expired when the cputimer is
-	 * running and no other thread in the group is already checking
-	 * for thread group cputimers. These fields are read without the
-	 * sighand lock. However, this is fine because this is meant to
-	 * be a fastpath heuristic to determine whether we should try to
-	 * acquire the sighand lock to check/handle timers.
+	 * Check if thread group timers expired when timers are active and
+	 * no other thread in the group is already handling expiry for
+	 * thread group cputimers. These fields are read without the
+	 * sighand lock. However, this is fine because this is meant to be
+	 * a fastpath heuristic to determine whether we should try to
+	 * acquire the sighand lock to handle timer expiry.
 	 *
-	 * In the worst case scenario, if 'running' or 'checking_timer' gets
-	 * set but the current thread doesn't see the change yet, we'll wait
-	 * until the next thread in the group gets a scheduler interrupt to
-	 * handle the timer. This isn't an issue in practice because these
-	 * types of delays with signals actually getting sent are expected.
+	 * In the worst case scenario, if concurrently timers_active is set
+	 * or expiry_active is cleared, but the current thread doesn't see
+	 * the change yet, the timer checks are delayed until the next
+	 * thread in the group gets a scheduler interrupt to handle the
+	 * timer. This isn't an issue in practice because these types of
+	 * delays with signals actually getting sent are expected.
 	 */
-	if (READ_ONCE(sig->cputimer.running) &&
-	    !READ_ONCE(sig->cputimer.checking_timer)) {
-		struct task_cputime group_sample;
+	if (READ_ONCE(pct->timers_active) && !READ_ONCE(pct->expiry_active)) {
+		u64 samples[CPUCLOCK_MAX];
 
-		sample_cputime_atomic(&group_sample, &sig->cputimer.cputime_atomic);
+		proc_sample_cputime_atomic(&sig->cputimer.cputime_atomic,
+					   samples);
 
-		if (task_cputime_expired(&group_sample, &sig->cputime_expires))
-			return 1;
+		if (task_cputimers_expired(samples, pct))
+			return true;
 	}
 
 	if (dl_task(tsk) && tsk->dl.dl_overrun)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 /*
@@ -1132,11 +1110,12 @@ static inline int fastpath_timer_check(struct task_struct *tsk)
  * already updated our counts.  We need to check if any timers fire now.
  * Interrupts are disabled.
  */
-void run_posix_cpu_timers(struct task_struct *tsk)
+void run_posix_cpu_timers(void)
 {
-	LIST_HEAD(firing);
+	struct task_struct *tsk = current;
 	struct k_itimer *timer, *next;
 	unsigned long flags;
+	LIST_HEAD(firing);
 
 	lockdep_assert_irqs_disabled();
 
@@ -1174,11 +1153,11 @@ void run_posix_cpu_timers(struct task_struct *tsk)
 	 * each timer's lock before clearing its firing flag, so no
 	 * timer call will interfere.
 	 */
-	list_for_each_entry_safe(timer, next, &firing, it.cpu.entry) {
+	list_for_each_entry_safe(timer, next, &firing, it.cpu.elist) {
 		int cpu_firing;
 
 		spin_lock(&timer->it_lock);
-		list_del_init(&timer->it.cpu.entry);
+		list_del_init(&timer->it.cpu.elist);
 		cpu_firing = timer->it.cpu.firing;
 		timer->it.cpu.firing = 0;
 		/*
@@ -1196,16 +1175,18 @@ void run_posix_cpu_timers(struct task_struct *tsk)
  * Set one of the process-wide special case CPU timers or RLIMIT_CPU.
  * The tsk->sighand->siglock must be held by the caller.
  */
-void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
+void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			   u64 *newval, u64 *oldval)
 {
-	u64 now;
-	int ret;
+	u64 now, *nextevt;
+
+	if (WARN_ON_ONCE(clkid >= CPUCLOCK_SCHED))
+		return;
 
-	WARN_ON_ONCE(clock_idx == CPUCLOCK_SCHED);
-	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
+	nextevt = &tsk->signal->posix_cputimers.bases[clkid].nextevt;
+	now = cpu_clock_sample_group(clkid, tsk, true);
 
-	if (oldval && ret != -EINVAL) {
+	if (oldval) {
 		/*
 		 * We are setting itimer. The *oldval is absolute and we update
 		 * it to be relative, *newval argument is relative and we update
@@ -1226,19 +1207,11 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 	}
 
 	/*
-	 * Update expiration cache if we are the earliest timer, or eventually
-	 * RLIMIT_CPU limit is earlier than prof_exp cpu timer expire.
+	 * Update expiration cache if this is the earliest timer. CPUCLOCK_PROF
+	 * expiry cache is also used by RLIMIT_CPU!.
 	 */
-	switch (clock_idx) {
-	case CPUCLOCK_PROF:
-		if (expires_gt(tsk->signal->cputime_expires.prof_exp, *newval))
-			tsk->signal->cputime_expires.prof_exp = *newval;
-		break;
-	case CPUCLOCK_VIRT:
-		if (expires_gt(tsk->signal->cputime_expires.virt_exp, *newval))
-			tsk->signal->cputime_expires.virt_exp = *newval;
-		break;
-	}
+	if (*newval < *nextevt)
+		*nextevt = *newval;
 
 	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
 }
@@ -1260,6 +1233,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 	timer.it_overrun = -1;
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
+
 	if (!error) {
 		static struct itimerspec64 zero_it;
 		struct restart_block *restart;
@@ -1275,7 +1249,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		}
 
 		while (!signal_pending(current)) {
-			if (timer.it.cpu.expires == 0) {
+			if (!cpu_timer_getexpires(&timer.it.cpu)) {
 				/*
 				 * Our timer fired and was reset, below
 				 * deletion can not fail.
@@ -1297,7 +1271,7 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		/*
 		 * We were interrupted by a signal.
 		 */
-		expires = timer.it.cpu.expires;
+		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
 			/*
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d7f2d91acdac..0ec5b7a1d769 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -442,7 +442,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -459,7 +459,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -805,6 +805,35 @@ static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+static void common_timer_wait_running(struct k_itimer *timer)
+{
+	hrtimer_cancel_wait_running(&timer->it.real.timer);
+}
+
+/*
+ * On PREEMPT_RT this prevent priority inversion against softirq kthread in
+ * case it gets preempted while executing a timer callback. See comments in
+ * hrtimer_cancel_wait_running. For PREEMPT_RT=n this just results in a
+ * cpu_relax().
+ */
+static struct k_itimer *timer_wait_running(struct k_itimer *timer,
+					   unsigned long *flags)
+{
+	const struct k_clock *kc = READ_ONCE(timer->kclock);
+	timer_t timer_id = READ_ONCE(timer->it_id);
+
+	/* Prevent kfree(timer) after dropping the lock */
+	rcu_read_lock();
+	unlock_timer(timer, *flags);
+
+	if (!WARN_ON_ONCE(!kc->timer_wait_running))
+		kc->timer_wait_running(timer);
+
+	rcu_read_unlock();
+	/* Relock the timer. It might be not longer hashed. */
+	return lock_timer(timer_id, flags);
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -844,13 +873,13 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	return 0;
 }
 
-static int do_timer_settime(timer_t timer_id, int flags,
+static int do_timer_settime(timer_t timer_id, int tmr_flags,
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
 	const struct k_clock *kc;
 	struct k_itimer *timr;
-	unsigned long flag;
+	unsigned long flags;
 	int error = 0;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -859,8 +888,9 @@ static int do_timer_settime(timer_t timer_id, int flags,
 
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
+
+	timr = lock_timer(timer_id, &flags);
 retry:
-	timr = lock_timer(timer_id, &flag);
 	if (!timr)
 		return -EINVAL;
 
@@ -868,13 +898,16 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
 	else
-		error = kc->timer_set(timr, flags, new_spec64, old_spec64);
+		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
-		old_spec64 = NULL;	// We already got the old time...
+		// We already got the old time...
+		old_spec64 = NULL;
+		/* Unlocks and relocks the timer if it still exists */
+		timr = timer_wait_running(timr, &flags);
 		goto retry;
 	}
+	unlock_timer(timr, flags);
 
 	return error;
 }
@@ -951,13 +984,15 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	struct k_itimer *timer;
 	unsigned long flags;
 
-retry_delete:
 	timer = lock_timer(timer_id, &flags);
+
+retry_delete:
 	if (!timer)
 		return -EINVAL;
 
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
+	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
+		/* Unlocks and relocks the timer if it still exists */
+		timer = timer_wait_running(timer, &flags);
 		goto retry_delete;
 	}
 
@@ -1238,6 +1273,7 @@ static const struct k_clock clock_realtime = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1253,6 +1289,7 @@ static const struct k_clock clock_monotonic = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1283,6 +1320,7 @@ static const struct k_clock clock_tai = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
@@ -1298,6 +1336,7 @@ static const struct k_clock clock_boottime = {
 	.timer_forward		= common_hrtimer_forward,
 	.timer_remaining	= common_hrtimer_remaining,
 	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
+	.timer_wait_running	= common_timer_wait_running,
 	.timer_arm		= common_hrtimer_arm,
 };
 
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index de5daa6d975a..897c29e162b9 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -24,6 +24,7 @@ struct k_clock {
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
 	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,
 			     bool absolute, bool sigev_none);
+	void	(*timer_wait_running)(struct k_itimer *timr);
 };
 
 extern const struct k_clock clock_posix_cpu;
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index 5be6154e2fd2..c1f5bb590b5e 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -59,11 +59,16 @@ static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 	 * hrtimer_{start/cancel} functions call into tracing,
 	 * calls to these functions must be bound within RCU_NONIDLE.
 	 */
-	RCU_NONIDLE({
+	RCU_NONIDLE(
+		{
 			bc_moved = hrtimer_try_to_cancel(&bctimer) >= 0;
-			if (bc_moved)
+			if (bc_moved) {
 				hrtimer_start(&bctimer, expires,
-					      HRTIMER_MODE_ABS_PINNED);});
+					      HRTIMER_MODE_ABS_PINNED_HARD);
+			}
+		}
+	);
+
 	if (bc_moved) {
 		/* Bind the "device" to the cpu */
 		bc->bound_on = smp_processor_id();
@@ -104,7 +109,7 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 
 void tick_setup_hrtimer_broadcast(void)
 {
-	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&bctimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	bctimer.function = bc_handler;
 	clockevents_register_device(&ce_broadcast_hrtimer);
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be9707f68024..955851748dc3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -634,10 +634,12 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	/* Forward the time to expire in the future */
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
 
-	if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
-		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
-	else
+	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
+		hrtimer_start_expires(&ts->sched_timer,
+				      HRTIMER_MODE_ABS_PINNED_HARD);
+	} else {
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	}
 
 	/*
 	 * Reset to make sure next tick stop doesn't get fooled by past
@@ -802,7 +804,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
-		hrtimer_start(&ts->sched_timer, tick, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start(&ts->sched_timer, tick,
+			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
 		hrtimer_set_expires(&ts->sched_timer, tick);
 		tick_program_event(tick, 1);
@@ -1230,7 +1233,7 @@ static void tick_nohz_switch_to_nohz(void)
 	 * Recycle the hrtimer in ts, so we can share the
 	 * hrtimer_forward with the highres code.
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	/* Get the next period */
 	next = tick_init_jiffy_update();
 
@@ -1327,7 +1330,7 @@ void tick_setup_sched_timer(void)
 	/*
 	 * Emulate tick processing via per-CPU hrtimers:
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	ts->sched_timer.function = tick_sched_timer;
 
 	/* Get the next period (per-CPU) */
@@ -1342,7 +1345,7 @@ void tick_setup_sched_timer(void)
 	}
 
 	hrtimer_forward(&ts->sched_timer, now, tick_period);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }
 #endif /* HIGH_RES_TIMERS */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 343c7ba33b1c..0e315a2e77ae 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -196,6 +196,10 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		expiry_lock;
+	atomic_t		timer_waiters;
+#endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1227,7 +1231,78 @@ int try_to_del_timer_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_PREEMPT_RT
+static __init void timer_base_init_expiry_lock(struct timer_base *base)
+{
+	spin_lock_init(&base->expiry_lock);
+}
+
+static inline void timer_base_lock_expiry(struct timer_base *base)
+{
+	spin_lock(&base->expiry_lock);
+}
+
+static inline void timer_base_unlock_expiry(struct timer_base *base)
+{
+	spin_unlock(&base->expiry_lock);
+}
+
+/*
+ * The counterpart to del_timer_wait_running().
+ *
+ * If there is a waiter for base->expiry_lock, then it was waiting for the
+ * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * the waiter to acquire the lock and make progress.
+ */
+static void timer_sync_wait_running(struct timer_base *base)
+{
+	if (atomic_read(&base->timer_waiters)) {
+		spin_unlock(&base->expiry_lock);
+		spin_lock(&base->expiry_lock);
+	}
+}
+
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
+ *
+ * This prevents priority inversion, if the softirq thread on a remote CPU
+ * got preempted, and it prevents a life lock when the task which tries to
+ * delete a timer preempted the softirq thread running the timer callback
+ * function.
+ */
+static void del_timer_wait_running(struct timer_list *timer)
+{
+	u32 tf;
+
+	tf = READ_ONCE(timer->flags);
+	if (!(tf & TIMER_MIGRATING)) {
+		struct timer_base *base = get_timer_base(tf);
+
+		/*
+		 * Mark the base as contended and grab the expiry lock,
+		 * which is held by the softirq across the timer
+		 * callback. Drop the lock immediately so the softirq can
+		 * expire the next timer. In theory the timer could already
+		 * be running again, but that's more than unlikely and just
+		 * causes another wait loop.
+		 */
+		atomic_inc(&base->timer_waiters);
+		spin_lock_bh(&base->expiry_lock);
+		atomic_dec(&base->timer_waiters);
+		spin_unlock_bh(&base->expiry_lock);
+	}
+}
+#else
+static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
+static inline void timer_base_lock_expiry(struct timer_base *base) { }
+static inline void timer_base_unlock_expiry(struct timer_base *base) { }
+static inline void timer_sync_wait_running(struct timer_base *base) { }
+static inline void del_timer_wait_running(struct timer_list *timer) { }
+#endif
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1266,6 +1341,8 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1283,12 +1360,17 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-		cpu_relax();
-	}
+
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1360,10 +1442,13 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			base->running_timer = NULL;
+			timer_sync_wait_running(base);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1643,7 +1728,7 @@ void update_process_times(int user_tick)
 #endif
 	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
-		run_posix_cpu_timers(p);
+		run_posix_cpu_timers();
 }
 
 /**
@@ -1658,6 +1743,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
+	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1684,8 +1770,8 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
-	base->running_timer = NULL;
 	raw_spin_unlock_irq(&base->lock);
+	timer_base_unlock_expiry(base);
 }
 
 /*
@@ -1930,6 +2016,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
+		timer_base_init_expiry_lock(base);
 	}
 }
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..f41334ef0971 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -490,10 +490,10 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hrtimer->function = watchdog_timer_fn;
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	/* Initialize timestamp */
 	__touch_watchdog();
diff --git a/lib/timerqueue.c b/lib/timerqueue.c
index bc7e64df27df..c52710964593 100644
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -26,9 +26,10 @@
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
-	struct rb_node **p = &head->head.rb_node;
+	struct rb_node **p = &head->rb_root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
-	struct timerqueue_node  *ptr;
+	struct timerqueue_node *ptr;
+	bool leftmost = true;
 
 	/* Make sure we don't add nodes that are already added */
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
@@ -36,19 +37,17 @@ bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 	while (*p) {
 		parent = *p;
 		ptr = rb_entry(parent, struct timerqueue_node, node);
-		if (node->expires < ptr->expires)
+		if (node->expires < ptr->expires) {
 			p = &(*p)->rb_left;
-		else
+		} else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&node->node, parent, p);
-	rb_insert_color(&node->node, &head->head);
+	rb_insert_color_cached(&node->node, &head->rb_root, leftmost);
 
-	if (!head->next || node->expires < head->next->expires) {
-		head->next = node;
-		return true;
-	}
-	return false;
+	return leftmost;
 }
 EXPORT_SYMBOL_GPL(timerqueue_add);
 
@@ -65,15 +64,10 @@ bool timerqueue_del(struct timerqueue_head *head, struct timerqueue_node *node)
 {
 	WARN_ON_ONCE(RB_EMPTY_NODE(&node->node));
 
-	/* update next pointer */
-	if (head->next == node) {
-		struct rb_node *rbn = rb_next(&node->node);
-
-		head->next = rb_entry_safe(rbn, struct timerqueue_node, node);
-	}
-	rb_erase(&node->node, &head->head);
+	rb_erase_cached(&node->node, &head->rb_root);
 	RB_CLEAR_NODE(&node->node);
-	return head->next != NULL;
+
+	return !RB_EMPTY_ROOT(&head->rb_root.rb_root);
 }
 EXPORT_SYMBOL_GPL(timerqueue_del);
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index bb9915291644..1d0c1b4886d7 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2156,7 +2156,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 	s64 remaining;
 	struct hrtimer_sleeper t;
 
-	hrtimer_init_on_stack(&t.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	hrtimer_set_expires(&t.timer, spin_until);
 
 	remaining = ktime_to_ns(hrtimer_expires_remaining(&t.timer));
@@ -2170,11 +2170,9 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 			end_time = ktime_get();
 		} while (ktime_compare(end_time, spin_until) < 0);
 	} else {
-		/* see do_nanosleep */
-		hrtimer_init_sleeper(&t, current);
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
-			hrtimer_start_expires(&t.timer, HRTIMER_MODE_ABS);
+			hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_ABS);
 
 			if (likely(t.task))
 				schedule();


