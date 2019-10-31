Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB55CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D04208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfJaLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfJaLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92s-000373-96; Thu, 31 Oct 2019 12:55:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2A00C1C06D2;
        Thu, 31 Oct 2019 12:55:09 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:08 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Remove CONFIG_HOTPLUG_CPU=n from scenarios
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290888.29376.7569458712945584864.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9f8ba55d49cef46da63f7863ec544e2b2b7eda66
Gitweb:        https://git.kernel.org/tip/9f8ba55d49cef46da63f7863ec544e2b2b7eda66
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 02 Aug 2019 20:18:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:49:13 -07:00

rcutorture: Remove CONFIG_HOTPLUG_CPU=n from scenarios

A number of mainstream CPU families are no longer capable of building
kernels having CONFIG_SMP=y and CONFIG_HOTPLUG_CPU=n, so this commit
removes this combination from the rcutorture scenarios having it.
People wishing to try out this combination may still do so using the
"--kconfig CONFIG_HOTPLUG_CPU=n CONFIG_SUSPEND=n CONFIG_HIBERNATION=n"
argument to the tools/testing/selftests/rcutorture/bin/kvm.sh script
that is used to run rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TASKS03      | 3 ---
 tools/testing/selftests/rcutorture/configs/rcu/TREE02       | 3 ---
 tools/testing/selftests/rcutorture/configs/rcu/TREE04       | 3 ---
 tools/testing/selftests/rcutorture/configs/rcu/TREE06       | 3 ---
 tools/testing/selftests/rcutorture/configs/rcu/TREE08       | 3 ---
 tools/testing/selftests/rcutorture/configs/rcu/TREE09       | 3 ---
 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL      | 3 ---
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt | 1 -
 8 files changed, 22 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
index 28568b7..ea43990 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
@@ -1,8 +1,5 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02
index 35e639e..65daee4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02
@@ -9,9 +9,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_RCU_FANOUT=3
 CONFIG_RCU_FANOUT_LEAF=3
 CONFIG_RCU_NOCB_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index 24c9f60..f6d6a40 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -9,9 +9,6 @@ CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
 CONFIG_RCU_FAST_NO_HZ=y
 CONFIG_RCU_TRACE=y
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_RCU_FANOUT=4
 CONFIG_RCU_FANOUT_LEAF=3
 CONFIG_DEBUG_LOCK_ALLOC=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06 b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
index 05a4eec..bf4980d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06
@@ -9,9 +9,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_RCU_FANOUT=6
 CONFIG_RCU_FANOUT_LEAF=6
 CONFIG_RCU_NOCB_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08 b/tools/testing/selftests/rcutorture/configs/rcu/TREE08
index fb1c763..c810c52 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08
@@ -9,9 +9,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_RCU_FANOUT=3
 CONFIG_RCU_FANOUT_LEAF=2
 CONFIG_RCU_NOCB_CPU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE09 b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
index 6710e74..8523a75 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE09
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
@@ -8,9 +8,6 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_TRACE=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
index 4d8eb5b..5d546ef 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
@@ -6,9 +6,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
index af6fca0..1b96d68 100644
--- a/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
+++ b/tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt
@@ -6,7 +6,6 @@ Kconfig Parameters:
 
 CONFIG_DEBUG_LOCK_ALLOC -- Do three, covering CONFIG_PROVE_LOCKING & not.
 CONFIG_DEBUG_OBJECTS_RCU_HEAD -- Do one.
-CONFIG_HOTPLUG_CPU -- Do half.  (Every second.)
 CONFIG_HZ_PERIODIC -- Do one.
 CONFIG_NO_HZ_IDLE -- Do those not otherwise specified. (Groups of two.)
 CONFIG_NO_HZ_FULL -- Do two, one with partial CPU enablement.
