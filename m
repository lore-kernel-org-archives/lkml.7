Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA51E222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067275;
	bh=4qjaDDO3fRS1z7Wjmci4DwMu7bIKBDHLF38+pxY4uho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLyo/BNG1VNQkyTaYKoBwVDF8HJ3q/dCrkDy7nHCG5i085wNf/O+sX2JZclXRP3dp
	 JVoJACS7IrzX1F10WVT4HP2DVxAdrUvzypWdjSvDvL/Yrb2pCLCoXsdn97Kqwa5wek
	 32aXLCEkrJq0n82BCs5w6uuLD/k17aDHrI0XOgoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfJCBrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfJCBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529D6222C3;
        Thu,  3 Oct 2019 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067251;
        bh=4qjaDDO3fRS1z7Wjmci4DwMu7bIKBDHLF38+pxY4uho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiVO8hKFAKJ75/yFfDPOlLr/ygI3ciXWbu1xnSLBo/Et28D+l6dQFUCCRV48c8qar
         +lOuGZpUFzNNgrSXg4ztdHkQuaY0qTYD3JK+HLzTcTYU79A4wev/G+/xdVokWpOpXa
         xjFn0ZT9peZfZjTmh9z3C1eFDADfbfjTMxUB+gbU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/9] rcutorture: Remove CONFIG_HOTPLUG_CPU=n from scenarios
Date:   Wed,  2 Oct 2019 18:47:22 -0700
Message-Id: <20191003014728.13496-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

A number of mainstream CPU families are no longer capable of building
kernels having CONFIG_SMP=y and CONFIG_HOTPLUG_CPU=n, so this commit
removes this combination from the rcutorture scenarios having it.
People wishing to try out this combination may still do so using the
"--kconfig CONFIG_HOTPLUG_CPU=n CONFIG_SUSPEND=n CONFIG_HIBERNATION=n"
argument to the tools/testing/selftests/rcutorture/bin/kvm.sh script
that is used to run rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
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
-- 
2.9.5

