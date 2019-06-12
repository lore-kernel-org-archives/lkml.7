Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611321721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362016;
	bh=rIXUsQ6KrV22nvfOLBEphHcv3awblM01Tt7BfoJoAz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6HhvadGy3eKv2U672nycZiQSc2Vk033S6AgpMuAkzMJiWy0DRsshT6EqTRuVBMOI
	 n8U/B7uMhPpnyGVvQq94iPCW2PrWp7TipeY6DxFjWcsad7/0wWekHc8RMQrEEiUdbn
	 IMPlnM3szckpTGmkt104LYt/dT0IDoONUB3+vdQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbfFLRxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:53:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbfFLRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YvaWc7/jIKu+tp7QGKqga7yKT74/WnMkBzkmsTWeFfs=; b=tDUuYoQ4DxMtZzKetdeJ0WNwae
        3EfwmR13cyyv58CmBxI28uaIC4LaMes3GPlLoTnNtgHrRDT+0VZcv48KI8ZccLKljnaupPfOHNYyR
        5FIK/fzoIuvTz7BdApkorfgJrVEq3hVj3A/6zH7ppY3wMckjTxbVV1FD2yJrm4DVGeaJMHT3Lasj9
        lO1RAJ1aJS6SBZn4PZeqIZTmVO2bUUVqga1M0viVzyXW+L/igTose4tucRxNFL4cko2PBF9PUT5wG
        cvkoh+c861MVYHNMEUnYzNJizAUJGJJED5VZEunGaPmYnPwCacTlPvWQcwPODhs14Ecm8vwcC5xY+
        p6r4aFNw==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qs-0002Dn-TI; Wed, 12 Jun 2019 17:53:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001hK-KL; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 22/28] docs: riscv: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:52:58 -0300
Message-Id: <4503067748f2638ca45f17498c70a3e6b10d7ce7.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion here is trivial:
 - Adjust the document title's markup
 - Do some whitespace alignment;
 - mark literal blocks;
 - Use ReST way to markup indented lists.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/riscv/index.rst            | 17 ++++
 Documentation/riscv/{pmu.txt => pmu.rst} | 98 +++++++++++++-----------
 2 files changed, 69 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/riscv/index.rst
 rename Documentation/riscv/{pmu.txt => pmu.rst} (77%)

diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
new file mode 100644
index 000000000000..c4b906d9b5a7
--- /dev/null
+++ b/Documentation/riscv/index.rst
@@ -0,0 +1,17 @@
+:orphan:
+
+===================
+RISC-V architecture
+===================
+
+.. toctree::
+    :maxdepth: 1
+
+    pmu
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/riscv/pmu.txt b/Documentation/riscv/pmu.rst
similarity index 77%
rename from Documentation/riscv/pmu.txt
rename to Documentation/riscv/pmu.rst
index b29f03a6d82f..acb216b99c26 100644
--- a/Documentation/riscv/pmu.txt
+++ b/Documentation/riscv/pmu.rst
@@ -1,5 +1,7 @@
+===================================
 Supporting PMUs on RISC-V platforms
-==========================================
+===================================
+
 Alan Kao <alankao@andestech.com>, Mar 2018
 
 Introduction
@@ -77,13 +79,13 @@ Note that some features can be done in this stage as well:
 (2) privilege level setting (user space only, kernel space only, both);
 (3) destructor setting.  Normally it is sufficient to apply *riscv_destroy_event*;
 (4) tweaks for non-sampling events, which will be utilized by functions such as
-*perf_adjust_period*, usually something like the follows:
+    *perf_adjust_period*, usually something like the follows::
 
-if (!is_sampling_event(event)) {
-        hwc->sample_period = x86_pmu.max_period;
-        hwc->last_period = hwc->sample_period;
-        local64_set(&hwc->period_left, hwc->sample_period);
-}
+      if (!is_sampling_event(event)) {
+              hwc->sample_period = x86_pmu.max_period;
+              hwc->last_period = hwc->sample_period;
+              local64_set(&hwc->period_left, hwc->sample_period);
+      }
 
 In the case of *riscv_base_pmu*, only (3) is provided for now.
 
@@ -94,10 +96,10 @@ In the case of *riscv_base_pmu*, only (3) is provided for now.
 3.1. Interrupt Initialization
 
 This often occurs at the beginning of the *event_init* method. In common
-practice, this should be a code segment like
+practice, this should be a code segment like::
 
-int x86_reserve_hardware(void)
-{
+  int x86_reserve_hardware(void)
+  {
         int err = 0;
 
         if (!atomic_inc_not_zero(&pmc_refcount)) {
@@ -114,7 +116,7 @@ int x86_reserve_hardware(void)
         }
 
         return err;
-}
+  }
 
 And the magic is in *reserve_pmc_hardware*, which usually does atomic
 operations to make implemented IRQ accessible from some global function pointer.
@@ -128,28 +130,28 @@ which will be introduced in the next section.)
 
 3.2. IRQ Structure
 
-Basically, a IRQ runs the following pseudo code:
+Basically, a IRQ runs the following pseudo code::
 
-for each hardware counter that triggered this overflow
+  for each hardware counter that triggered this overflow
 
-    get the event of this counter
+      get the event of this counter
 
-    // following two steps are defined as *read()*,
-    // check the section Reading/Writing Counters for details.
-    count the delta value since previous interrupt
-    update the event->count (# event occurs) by adding delta, and
-               event->hw.period_left by subtracting delta
+      // following two steps are defined as *read()*,
+      // check the section Reading/Writing Counters for details.
+      count the delta value since previous interrupt
+      update the event->count (# event occurs) by adding delta, and
+                 event->hw.period_left by subtracting delta
 
-    if the event overflows
-        sample data
-        set the counter appropriately for the next overflow
+      if the event overflows
+          sample data
+          set the counter appropriately for the next overflow
 
-        if the event overflows again
-            too frequently, throttle this event
-        fi
-    fi
+          if the event overflows again
+              too frequently, throttle this event
+          fi
+      fi
 
-end for
+  end for
 
 However as of this writing, none of the RISC-V implementations have designed an
 interrupt for perf, so the details are to be completed in the future.
@@ -195,23 +197,26 @@ A normal flow of these state transitions are as follows:
   At this stage, a general event is bound to a physical counter, if any.
   The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE, because it is now
   stopped, and the (software) event count does not need updating.
-** *start* is then called, and the counter is enabled.
-   With flag PERF_EF_RELOAD, it writes an appropriate value to the counter (check
-   previous section for detail).
-   Nothing is written if the flag does not contain PERF_EF_RELOAD.
-   The state now is reset to none, because it is neither stopped nor updated
-   (the counting already started)
+
+  - *start* is then called, and the counter is enabled.
+    With flag PERF_EF_RELOAD, it writes an appropriate value to the counter (check
+    previous section for detail).
+    Nothing is written if the flag does not contain PERF_EF_RELOAD.
+    The state now is reset to none, because it is neither stopped nor updated
+    (the counting already started)
+
 * When being context-switched out, *del* is called.  It then checks out all the
   events in the PMU and calls *stop* to update their counts.
-** *stop* is called by *del*
-   and the perf core with flag PERF_EF_UPDATE, and it often shares the same
-   subroutine as *read* with the same logic.
-   The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE, again.
 
-** Life cycle of these two pairs: *add* and *del* are called repeatedly as
-  tasks switch in-and-out; *start* and *stop* is also called when the perf core
-  needs a quick stop-and-start, for instance, when the interrupt period is being
-  adjusted.
+  - *stop* is called by *del*
+    and the perf core with flag PERF_EF_UPDATE, and it often shares the same
+    subroutine as *read* with the same logic.
+    The state changes to PERF_HES_STOPPED and PERF_HES_UPTODATE, again.
+
+  - Life cycle of these two pairs: *add* and *del* are called repeatedly as
+    tasks switch in-and-out; *start* and *stop* is also called when the perf core
+    needs a quick stop-and-start, for instance, when the interrupt period is being
+    adjusted.
 
 Current implementation is sufficient for now and can be easily extended to
 features in the future.
@@ -225,25 +230,26 @@ A. Related Structures
   Both structures are designed to be read-only.
 
   *struct pmu* defines some function pointer interfaces, and most of them take
-*struct perf_event* as a main argument, dealing with perf events according to
-perf's internal state machine (check kernel/events/core.c for details).
+  *struct perf_event* as a main argument, dealing with perf events according to
+  perf's internal state machine (check kernel/events/core.c for details).
 
   *struct riscv_pmu* defines PMU-specific parameters.  The naming follows the
-convention of all other architectures.
+  convention of all other architectures.
 
 * struct perf_event: include/linux/perf_event.h
 * struct hw_perf_event
 
   The generic structure that represents perf events, and the hardware-related
-details.
+  details.
 
 * struct riscv_hw_events: arch/riscv/include/asm/perf_event.h
 
   The structure that holds the status of events, has two fixed members:
-the number of events and the array of the events.
+  the number of events and the array of the events.
 
 References
 ----------
 
 [1] https://github.com/riscv/riscv-linux/pull/124
+
 [2] https://groups.google.com/a/groups.riscv.org/forum/#!topic/sw-dev/f19TmCNP6yA
-- 
2.21.0

